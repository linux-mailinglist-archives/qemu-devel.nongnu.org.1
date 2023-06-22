Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDF73A6A9
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNbc-00070r-Rv; Thu, 22 Jun 2023 12:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbP-0006zn-6g
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNbN-0008Ov-4k
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687452967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sAl6CGYlK5QbshW2YIG60eMeK03wS4wFRYbi+G4BEtk=;
 b=TLPRd6U43JgHYqWOxyn3I7Ji9jpyWwcJA2du/t0FdBL8BYaRQIYqy4EDz7D1rM7ao9tNS9
 qJsIri4+Crr4UOswYdssEwElf8qqxt0vqNxeOyXCgAFwRyooa9HWKyyr5c23VrHplKFc0X
 kA+hioyvzQzFf5Zsyq1FJE3fJl8wcCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-573-zWn52uNbNNqtugqy_6vW1A-1; Thu, 22 Jun 2023 12:56:03 -0400
X-MC-Unique: zWn52uNbNNqtugqy_6vW1A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B5FF8A2E29;
 Thu, 22 Jun 2023 16:55:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE467C00049;
 Thu, 22 Jun 2023 16:55:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Hyman=20Huang=28=E9=BB=84=E5=8B=87=29?= <yong.huang@smartx.com>
Subject: [PULL 09/30] migration: Implement dirty-limit convergence algo
Date: Thu, 22 Jun 2023 18:55:06 +0200
Message-Id: <20230622165527.2417-10-quintela@redhat.com>
In-Reply-To: <20230622165527.2417-1-quintela@redhat.com>
References: <20230622165527.2417-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Hyman Huang(黄勇) <yong.huang@smartx.com>

Implement dirty-limit convergence algo for live migration,
which is kind of like auto-converge algo but using dirty-limit
instead of cpu throttle to make migration convergent.

Enable dirty page limit if dirty_rate_high_cnt greater than 2
when dirty-limit capability enabled, Disable dirty-limit if
migration be canceled.

Note that "set_vcpu_dirty_limit", "cancel_vcpu_dirty_limit"
commands are not allowed during dirty-limit live migration.

Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <168733225273.5845.15871826788879741674-7@git.sr.ht>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  |  3 +++
 migration/ram.c        | 36 ++++++++++++++++++++++++++++++++++++
 softmmu/dirtylimit.c   | 29 +++++++++++++++++++++++++++++
 migration/trace-events |  1 +
 4 files changed, 69 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 3a001dd042..c101784dfa 100644
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
 
diff --git a/migration/ram.c b/migration/ram.c
index b6559f9312..8a86363216 100644
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
 
 #include "hw/boards.h" /* for machine_dump_guest_core() */
 
@@ -984,6 +987,37 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
     }
 }
 
+/*
+ * Enable dirty-limit to throttle down the guest
+ */
+static void migration_dirty_limit_guest(void)
+{
+    /*
+     * dirty page rate quota for all vCPUs fetched from
+     * migration parameter 'vcpu_dirty_limit'
+     */
+    static int64_t quota_dirtyrate;
+    MigrationState *s = migrate_get_current();
+
+    /*
+     * If dirty limit already enabled and migration parameter
+     * vcpu-dirty-limit untouched.
+     */
+    if (dirtylimit_in_service() &&
+        quota_dirtyrate == s->parameters.vcpu_dirty_limit) {
+        return;
+    }
+
+    quota_dirtyrate = s->parameters.vcpu_dirty_limit;
+
+    /*
+     * Set all vCPU a quota dirtyrate, note that the second
+     * parameter will be ignored if setting all vCPU for the vm
+     */
+    qmp_set_vcpu_dirty_limit(false, -1, quota_dirtyrate, NULL);
+    trace_migration_dirty_limit_guest(quota_dirtyrate);
+}
+
 static void migration_trigger_throttle(RAMState *rs)
 {
     uint64_t threshold = migrate_throttle_trigger_threshold();
@@ -1013,6 +1047,8 @@ static void migration_trigger_throttle(RAMState *rs)
             trace_migration_throttle();
             mig_throttle_guest_down(bytes_dirty_period,
                                     bytes_dirty_threshold);
+        } else if (migrate_dirty_limit()) {
+            migration_dirty_limit_guest();
         }
     }
 }
diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
index 942d876523..a6d854d161 100644
--- a/softmmu/dirtylimit.c
+++ b/softmmu/dirtylimit.c
@@ -436,6 +436,23 @@ static void dirtylimit_cleanup(void)
     dirtylimit_state_finalize();
 }
 
+/*
+ * dirty page rate limit is not allowed to set if migration
+ * is running with dirty-limit capability enabled.
+ */
+static bool dirtylimit_is_allowed(void)
+{
+    MigrationState *ms = migrate_get_current();
+
+    if (migration_is_running(ms->state) &&
+        (!qemu_thread_is_self(&ms->thread)) &&
+        migrate_dirty_limit() &&
+        dirtylimit_in_service()) {
+        return false;
+    }
+    return true;
+}
+
 void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
                                  int64_t cpu_index,
                                  Error **errp)
@@ -449,6 +466,12 @@ void qmp_cancel_vcpu_dirty_limit(bool has_cpu_index,
         return;
     }
 
+    if (!dirtylimit_is_allowed()) {
+        error_setg(errp, "can't cancel dirty page rate limit while"
+                   " migration is running");
+        return;
+    }
+
     if (!dirtylimit_in_service()) {
         return;
     }
@@ -499,6 +522,12 @@ void qmp_set_vcpu_dirty_limit(bool has_cpu_index,
         return;
     }
 
+    if (!dirtylimit_is_allowed()) {
+        error_setg(errp, "can't set dirty page rate limit while"
+                   " migration is running");
+        return;
+    }
+
     if (!dirty_rate) {
         qmp_cancel_vcpu_dirty_limit(has_cpu_index, cpu_index, errp);
         return;
diff --git a/migration/trace-events b/migration/trace-events
index cdaef7a1ea..c5cb280d95 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -91,6 +91,7 @@ migration_bitmap_sync_start(void) ""
 migration_bitmap_sync_end(uint64_t dirty_pages) "dirty_pages %" PRIu64
 migration_bitmap_clear_dirty(char *str, uint64_t start, uint64_t size, unsigned long page) "rb %s start 0x%"PRIx64" size 0x%"PRIx64" page 0x%lx"
 migration_throttle(void) ""
+migration_dirty_limit_guest(int64_t dirtyrate) "guest dirty page rate limit %" PRIi64 " MB/s"
 ram_discard_range(const char *rbname, uint64_t start, size_t len) "%s: start: %" PRIx64 " %zx"
 ram_load_loop(const char *rbname, uint64_t addr, int flags, void *host) "%s: addr: 0x%" PRIx64 " flags: 0x%x host: %p"
 ram_load_postcopy_loop(int channel, uint64_t addr, int flags) "chan=%d addr=0x%" PRIx64 " flags=0x%x"
-- 
2.40.1


