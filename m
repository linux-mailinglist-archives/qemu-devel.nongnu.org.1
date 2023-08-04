Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE3676FD56
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 11:32:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRr9R-0004Fz-7j; Fri, 04 Aug 2023 05:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qRr9J-0004Fo-3u
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:31:09 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qRr9D-00061C-AG
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 05:31:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1691141463; x=1722677463;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cKTpz5Tdbw6w2Gchfvbbj8ujbALk1nwwa7KAH13Ts/I=;
 b=brQDUxr9xQZt7VzRQEoRuSMVX01TClcUCF7ux3+P0xhYTPDHszKeaeSY
 2tqSddpf7KVSRjPmMEuemS1FY/pGWljL7JSiBoRneSHosQQ/8K1i+HZzr
 chl4Do0HnT46G8qdvdR6JoUvfSwFHl8xeBo6R9zqTfxOTiTZy6etGVkQd
 kOj2KMPVjOoMdjJ/ggY6pJAdkJnNPJntvo13iOmA02sfUd/zhvgp2oAGO
 6pps2fYRjb7CnYxtZWwSpIm1Y+BiIJmEv9cfXhWzA3T0SlbJB4wxZOmTm
 rGxaYOj8BQteOr+HrfCfSD2kXrAAljM00RIo0nPE3GgyyKYy9wqnbZR4H g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="367573115"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="367573115"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2023 02:30:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="903836927"
X-IronPort-AV: E=Sophos;i="6.01,254,1684825200"; d="scan'208";a="903836927"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga005.jf.intel.com with ESMTP; 04 Aug 2023 02:30:56 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: peterx@redhat.com,
	quintela@redhat.com,
	isaku.yamahata@gmail.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v2] migration: refactor migration_completion
Date: Fri,  4 Aug 2023 17:30:53 +0800
Message-Id: <20230804093053.5037-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Current migration_completion function is a bit long. Refactor the long
implementation into different subfunctions:
- migration_completion_precopy: completion code related to precopy
- migration_completion_postcopy: completion code related to postcopy
- close_return_path_on_source: rp thread related cleanup on migration
completion. It is named to match with open_return_path_on_source.

This improves readability and is easier for future updates (e.g. add new
subfunctions when completion code related to new features are needed). No
functional changes intended.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
Changelog:
- Merge await_return_path_close_on_source into
  close_return_path_on_source as the later basically just calls the
  previous;
- make migration_completion_postcopy "void" as it doesn't return a
  value.

 migration/migration.c | 174 ++++++++++++++++++++++++------------------
 1 file changed, 98 insertions(+), 76 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5528acb65e..f1c55d1148 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2048,9 +2048,13 @@ static int open_return_path_on_source(MigrationState *ms,
     return 0;
 }
 
-/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
-static int await_return_path_close_on_source(MigrationState *ms)
+static int close_return_path_on_source(MigrationState *ms)
 {
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+    trace_migration_return_path_end_before();
+
     /*
      * If this is a normal exit then the destination will send a SHUT and the
      * rp_thread will exit, however if there's an error we need to cause
@@ -2068,6 +2072,8 @@ static int await_return_path_close_on_source(MigrationState *ms)
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
     trace_await_return_path_close_on_source_close();
+
+    trace_migration_return_path_end_after(ms->rp_state.error);
     return ms->rp_state.error;
 }
 
@@ -2301,66 +2307,107 @@ static int migration_maybe_pause(MigrationState *s,
     return s->state == new_state ? 0 : -EINVAL;
 }
 
-/**
- * migration_completion: Used by migration_thread when there's not much left.
- *   The caller 'breaks' the loop when this returns.
- *
- * @s: Current migration state
- */
-static void migration_completion(MigrationState *s)
+static int migration_completion_precopy(MigrationState *s,
+                                        int *current_active_state)
 {
     int ret;
-    int current_active_state = s->state;
 
-    if (s->state == MIGRATION_STATUS_ACTIVE) {
-        qemu_mutex_lock_iothread();
-        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
+    qemu_mutex_lock_iothread();
+    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
-        s->vm_old_state = runstate_get();
-        global_state_store();
+    s->vm_old_state = runstate_get();
+    global_state_store();
 
-        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
-        trace_migration_completion_vm_stop(ret);
-        if (ret >= 0) {
-            ret = migration_maybe_pause(s, &current_active_state,
-                                        MIGRATION_STATUS_DEVICE);
-        }
-        if (ret >= 0) {
-            /*
-             * Inactivate disks except in COLO, and track that we
-             * have done so in order to remember to reactivate
-             * them if migration fails or is cancelled.
-             */
-            s->block_inactive = !migrate_colo();
-            migration_rate_set(RATE_LIMIT_DISABLED);
-            ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                                     s->block_inactive);
-        }
+    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    trace_migration_completion_vm_stop(ret);
+    if (ret < 0) {
+        goto out_unlock;
+    }
 
-        qemu_mutex_unlock_iothread();
+    ret = migration_maybe_pause(s, current_active_state,
+                                MIGRATION_STATUS_DEVICE);
+    if (ret < 0) {
+        goto out_unlock;
+    }
 
-        if (ret < 0) {
-            goto fail;
-        }
-    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
-        trace_migration_completion_postcopy_end();
+    /*
+     * Inactivate disks except in COLO, and track that we have done so in order
+     * to remember to reactivate them if migration fails or is cancelled.
+     */
+    s->block_inactive = !migrate_colo();
+    migration_rate_set(RATE_LIMIT_DISABLED);
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
+                                             s->block_inactive);
+out_unlock:
+    qemu_mutex_unlock_iothread();
+    return ret;
+}
 
-        qemu_mutex_lock_iothread();
-        qemu_savevm_state_complete_postcopy(s->to_dst_file);
-        qemu_mutex_unlock_iothread();
+static void migration_completion_postcopy(MigrationState *s)
+{
+    trace_migration_completion_postcopy_end();
 
+    qemu_mutex_lock_iothread();
+    qemu_savevm_state_complete_postcopy(s->to_dst_file);
+    qemu_mutex_unlock_iothread();
+
+    /*
+     * Shutdown the postcopy fast path thread.  This is only needed when dest
+     * QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need this.
+     */
+    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+        postcopy_preempt_shutdown_file(s);
+    }
+
+    trace_migration_completion_postcopy_end_after_complete();
+}
+
+static void migration_completion_failed(MigrationState *s,
+                                        int current_active_state)
+{
+    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
+                              s->state == MIGRATION_STATUS_DEVICE)) {
         /*
-         * Shutdown the postcopy fast path thread.  This is only needed
-         * when dest QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need
-         * this.
+         * If not doing postcopy, vm_start() will be called: let's
+         * regain control on images.
          */
-        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-            postcopy_preempt_shutdown_file(s);
+        Error *local_err = NULL;
+
+        qemu_mutex_lock_iothread();
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            s->block_inactive = false;
         }
+        qemu_mutex_unlock_iothread();
+    }
 
-        trace_migration_completion_postcopy_end_after_complete();
+    migrate_set_state(&s->state, current_active_state,
+                      MIGRATION_STATUS_FAILED);
+}
+
+/**
+ * migration_completion: Used by migration_thread when there's not much left.
+ *   The caller 'breaks' the loop when this returns.
+ *
+ * @s: Current migration state
+ */
+static void migration_completion(MigrationState *s)
+{
+    int ret = 0;
+    int current_active_state = s->state;
+
+    if (s->state == MIGRATION_STATUS_ACTIVE) {
+        ret = migration_completion_precopy(s, &current_active_state);
+    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        migration_completion_postcopy(s);
     } else {
+        ret = -1;
+    }
+
+    if (ret < 0) {
         goto fail;
     }
 
@@ -2370,14 +2417,8 @@ static void migration_completion(MigrationState *s)
      * it will wait for the destination to send it's status in
      * a SHUT command).
      */
-    if (s->rp_state.rp_thread_created) {
-        int rp_error;
-        trace_migration_return_path_end_before();
-        rp_error = await_return_path_close_on_source(s);
-        trace_migration_return_path_end_after(rp_error);
-        if (rp_error) {
-            goto fail;
-        }
+    if (close_return_path_on_source(s) < 0) {
+        goto fail;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
@@ -2397,26 +2438,7 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
-    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
-                              s->state == MIGRATION_STATUS_DEVICE)) {
-        /*
-         * If not doing postcopy, vm_start() will be called: let's
-         * regain control on images.
-         */
-        Error *local_err = NULL;
-
-        qemu_mutex_lock_iothread();
-        bdrv_activate_all(&local_err);
-        if (local_err) {
-            error_report_err(local_err);
-        } else {
-            s->block_inactive = false;
-        }
-        qemu_mutex_unlock_iothread();
-    }
-
-    migrate_set_state(&s->state, current_active_state,
-                      MIGRATION_STATUS_FAILED);
+    migration_completion_failed(s, current_active_state);
 }
 
 /**
-- 
2.27.0


