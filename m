Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4573D727617
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 06:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q77BI-00067S-CW; Thu, 08 Jun 2023 00:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q74z5-0006RZ-LE
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:02:43 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1q74z3-0000De-Pe
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 22:02:43 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id CE22B11F133;
 Thu,  8 Jun 2023 02:02:39 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Thu, 08 Jun 2023 00:12:40 +0800
Subject: [PATCH QEMU v5 6/8] migration: Implement dirty-limit convergence algo
MIME-Version: 1.0
Message-ID: <168618975839.6361.17407633874747688653-6@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168618975839.6361.17407633874747688653-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hyman =?utf-8?b?SHVhbmco6buE5YuHKQ==?= <yong.huang@smartx.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 00:23:23 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~hyman <yong.huang@smartx.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>

Implement dirty-limit convergence algo for live migration,
which is kind of like auto-converge algo but using dirty-limit
instead of cpu throttle to make migration convergent.

Enable dirty page limit if dirty_rate_high_cnt greater than 2
when dirty-limit capability enabled, Disable dirty-limit if
migration be cancled.

Note that "set_vcpu_dirty_limit", "cancel_vcpu_dirty_limit"
commands are not allowed during dirty-limit live migration.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/migration.c  |  3 ++
 migration/ram.c        | 63 ++++++++++++++++++++++++++++++++----------
 migration/trace-events |  1 +
 softmmu/dirtylimit.c   | 22 +++++++++++++++
 4 files changed, 74 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index dc05c6f6ea..4278b48af0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -165,6 +165,9 @@ void migration_cancel(const Error *error)
     if (error) {
         migrate_set_error(current_migration, error);
     }
+    if (migrate_dirty_limit()) {
+        qmp_cancel_vcpu_dirty_limit(false, -1, NULL);
+    }
     migrate_fd_cancel(current_migration);
 }
=20
diff --git a/migration/ram.c b/migration/ram.c
index 132f1a81d9..d26c7a8193 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -46,6 +46,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-types-migration.h"
 #include "qapi/qapi-events-migration.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
 #include "exec/ram_addr.h"
@@ -59,6 +60,8 @@
 #include "multifd.h"
 #include "sysemu/runstate.h"
 #include "options.h"
+#include "sysemu/dirtylimit.h"
+#include "sysemu/kvm.h"
=20
 #include "hw/boards.h" /* for machine_dump_guest_core() */
=20
@@ -983,6 +986,30 @@ static void migration_update_rates(RAMState *rs, int64_t=
 end_time)
     }
 }
=20
+/*
+ * Enable dirty-limit to throttle down the guest
+ */
+static void migration_dirty_limit_guest(void)
+{
+    static int64_t quota_dirtyrate;
+    MigrationState *s =3D migrate_get_current();
+
+    /*
+     * If dirty limit already enabled and migration parameter
+     * vcpu-dirty-limit untouched.
+     */
+    if (dirtylimit_in_service() &&
+        quota_dirtyrate =3D=3D s->parameters.vcpu_dirty_limit) {
+        return;
+    }
+
+    quota_dirtyrate =3D s->parameters.vcpu_dirty_limit;
+
+    /* Set or update quota dirty limit */
+    qmp_set_vcpu_dirty_limit(false, -1, quota_dirtyrate, NULL);
+    trace_migration_dirty_limit_guest(quota_dirtyrate);
+}
+
 static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold =3D migrate_throttle_trigger_threshold();
@@ -991,26 +1018,32 @@ static void migration_trigger_throttle(RAMState *rs)
     uint64_t bytes_dirty_period =3D rs->num_dirty_pages_period * TARGET_PAGE=
_SIZE;
     uint64_t bytes_dirty_threshold =3D bytes_xfer_period * threshold / 100;
=20
-    /* During block migration the auto-converge logic incorrectly detects
-     * that ram migration makes no progress. Avoid this by disabling the
-     * throttling logic during the bulk phase of block migration. */
-    if (blk_mig_bulk_active()) {
-        return;
-    }
+    /*
+     * The following detection logic can be refined later. For now:
+     * Check to see if the ratio between dirtied bytes and the approx.
+     * amount of bytes that just got transferred since the last time
+     * we were in this routine reaches the threshold. If that happens
+     * twice, start or increase throttling.
+     */
=20
-    if (migrate_auto_converge()) {
-        /* The following detection logic can be refined later. For now:
-           Check to see if the ratio between dirtied bytes and the approx.
-           amount of bytes that just got transferred since the last time
-           we were in this routine reaches the threshold. If that happens
-           twice, start or increase throttling. */
+    if ((bytes_dirty_period > bytes_dirty_threshold) &&
+        (++rs->dirty_rate_high_cnt >=3D 2)) {
+        rs->dirty_rate_high_cnt =3D 0;
+        /*
+         * During block migration the auto-converge logic incorrectly detects
+         * that ram migration makes no progress. Avoid this by disabling the
+         * throttling logic during the bulk phase of block migration
+         */
+        if (blk_mig_bulk_active()) {
+            return;
+        }
=20
-        if ((bytes_dirty_period > bytes_dirty_threshold) &&
-            (++rs->dirty_rate_high_cnt >=3D 2)) {
+        if (migrate_auto_converge()) {
             trace_migration_throttle();
-            rs->dirty_rate_high_cnt =3D 0;
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
+        } else if (migrate_dirty_limit()) {
+            migration_dirty_limit_guest();
         }
     }
 }
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..c5cb280d95 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -91,6 +91,7 @@ migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsig=
ned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
 migration_throttle(void) ""
+migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit =
%" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start=
: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s:=
 addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(int channel, uint64_t addr, int flags) "chan=3D%d add=
r=3D0x%" PRIx64 " flags=3D0x%x"
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 3f1103b04b..ee47158986 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -440,6 +440,8 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
                                  int64_t cpu_index,
                                  Error **errp)
 {
+    MigrationState *ms =3D migrate_get_current();
+
     if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
         return;
     }
@@ -453,6 +455,15 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
         return;
     }
=20
+    if (migration_is_running(ms->state) &&
+        (!qemu_thread_is_self(&ms->thread)) &&
+        migrate_dirty_limit() &&
+        dirtylimit_in_service()) {
+        error_setg(errp, "can't cancel dirty page limit while"
+                   " migration is running");
+        return;
+    }
+
     dirtylimit_state_lock();
=20
     if (has_cpu_index) {
@@ -488,6 +499,8 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
                               uint64_t dirty_rate,
                               Error **errp)
 {
+    MigrationState *ms =3D migrate_get_current();
+
     if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
         error_setg(errp, "dirty page limit feature requires KVM with"
                    " accelerator property 'dirty-ring-size' set'");
@@ -504,6 +517,15 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
         return;
     }
=20
+    if (migration_is_running(ms->state) &&
+        (!qemu_thread_is_self(&ms->thread)) &&
+        migrate_dirty_limit() &&
+        dirtylimit_in_service()) {
+        error_setg(errp, "can't cancel dirty page limit while"
+                   " migration is running");
+        return;
+    }
+
     dirtylimit_state_lock();
=20
     if (!dirtylimit_in_service()) {
--=20
2.38.5


