Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACA4747CAB
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:50:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGvOY-0005Vd-Vz; Wed, 05 Jul 2023 01:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOG-0005S8-SA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:25 -0400
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1qGvOD-00084t-Bm
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:49:24 -0400
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 9F47711F0BD;
 Wed,  5 Jul 2023 05:49:20 +0000 (UTC)
From: ~hyman <hyman@git.sr.ht>
Date: Wed, 07 Jun 2023 23:30:50 +0800
Subject: [PATCH QEMU v7 4/9] migration: Introduce dirty-limit capability
MIME-Version: 1.0
Message-ID: <168853615963.17240.15832775267134683267-4@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <168853615963.17240.15832775267134683267-0@git.sr.ht>
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
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
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

Introduce migration dirty-limit capability, which can
be turned on before live migration and limit dirty
page rate durty live migration.

Introduce migrate_dirty_limit function to help check
if dirty-limit capability enabled during live migration.

Meanwhile, refactor vcpu_dirty_rate_stat_collect
so that period can be configured instead of hardcoded.

dirty-limit capability is kind of like auto-converge
but using dirty limit instead of traditional cpu-throttle
to throttle guest down. To enable this feature, turn on
the dirty-limit capability before live migration using
migrate-set-capabilities, and set the parameters
"x-vcpu-dirty-limit-period", "vcpu-dirty-limit" suitably
to speed up convergence.

Signed-off-by: Hyman Huang(=E9=BB=84=E5=8B=87) <yong.huang@smartx.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/options.c  | 24 ++++++++++++++++++++++++
 migration/options.h  |  1 +
 qapi/migration.json  | 13 ++++++++++++-
 softmmu/dirtylimit.c | 12 +++++++++++-
 4 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 7d2d98830e..8b4eb8c519 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -27,6 +27,7 @@
 #include "qemu-file.h"
 #include "ram.h"
 #include "options.h"
+#include "sysemu/kvm.h"
=20
 /* Maximum migrate downtime set to 2000 seconds */
 #define MAX_MIGRATE_DOWNTIME_SECONDS 2000
@@ -196,6 +197,8 @@ Property migration_properties[] =3D {
 #endif
     DEFINE_PROP_MIG_CAP("x-switchover-ack",
                         MIGRATION_CAPABILITY_SWITCHOVER_ACK),
+    DEFINE_PROP_MIG_CAP("x-dirty-limit",
+                        MIGRATION_CAPABILITY_DIRTY_LIMIT),
=20
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -242,6 +245,13 @@ bool migrate_dirty_bitmaps(void)
     return s->capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
 }
=20
+bool migrate_dirty_limit(void)
+{
+    MigrationState *s =3D migrate_get_current();
+
+    return s->capabilities[MIGRATION_CAPABILITY_DIRTY_LIMIT];
+}
+
 bool migrate_events(void)
 {
     MigrationState *s =3D migrate_get_current();
@@ -573,6 +583,20 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, =
Error **errp)
         }
     }
=20
+    if (new_caps[MIGRATION_CAPABILITY_DIRTY_LIMIT]) {
+        if (new_caps[MIGRATION_CAPABILITY_AUTO_CONVERGE]) {
+            error_setg(errp, "dirty-limit conflicts with auto-converge"
+                       " either of then available currently");
+            return false;
+        }
+
+        if (!kvm_enabled() || !kvm_dirty_ring_enabled()) {
+            error_setg(errp, "dirty-limit requires KVM with accelerator"
+                   " property 'dirty-ring-size' set");
+            return false;
+        }
+    }
+
     return true;
 }
=20
diff --git a/migration/options.h b/migration/options.h
index 9aaf363322..b5a950d4e4 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -24,6 +24,7 @@ extern Property migration_properties[];
 /* capabilities */
=20
 bool migrate_auto_converge(void);
+bool migrate_dirty_limit(void);
 bool migrate_background_snapshot(void);
 bool migrate_block(void);
 bool migrate_colo(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index aa590dbf0e..cc51835cdd 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -497,6 +497,16 @@
 #     are present.  'return-path' capability must be enabled to use
 #     it.  (since 8.1)
 #
+# @dirty-limit: If enabled, migration will use the dirty-limit algo to
+#               throttle down guest instead of auto-converge algo.
+#               Throttle algo only works when vCPU's dirtyrate greater
+#               than 'vcpu-dirty-limit', read processes in guest os
+#               aren't penalized any more, so this algo can improve
+#               performance of vCPU during live migration. This is an
+#               optional performance feature and should not affect the
+#               correctness of the existing auto-converge algo.
+#               (since 8.1)
+#
 # Features:
 #
 # @unstable: Members @x-colo and @x-ignore-shared are experimental.
@@ -512,7 +522,8 @@
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
            { 'name': 'x-ignore-shared', 'features': [ 'unstable' ] },
            'validate-uuid', 'background-snapshot',
-           'zero-copy-send', 'postcopy-preempt', 'switchover-ack'] }
+           'zero-copy-send', 'postcopy-preempt', 'switchover-ack',
+           'dirty-limit'] }
=20
 ##
 # @MigrationCapabilityStatus:
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 5c12d26d49..953ef934bc 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -24,6 +24,9 @@
 #include "hw/boards.h"
 #include "sysemu/kvm.h"
 #include "trace.h"
+#include "migration/misc.h"
+#include "migration/migration.h"
+#include "migration/options.h"
=20
 /*
  * Dirtylimit stop working if dirty page rate error
@@ -75,11 +78,18 @@ static bool dirtylimit_quit;
=20
 static void vcpu_dirty_rate_stat_collect(void)
 {
+    MigrationState *s =3D migrate_get_current();
     VcpuStat stat;
     int i =3D 0;
+    int64_t period =3D DIRTYLIMIT_CALC_TIME_MS;
+
+    if (migrate_dirty_limit() &&
+        migration_is_active(s)) {
+        period =3D s->parameters.x_vcpu_dirty_limit_period;
+    }
=20
     /* calculate vcpu dirtyrate */
-    vcpu_calculate_dirtyrate(DIRTYLIMIT_CALC_TIME_MS,
+    vcpu_calculate_dirtyrate(period,
                              &stat,
                              GLOBAL_DIRTY_LIMIT,
                              false);
--=20
2.38.5


