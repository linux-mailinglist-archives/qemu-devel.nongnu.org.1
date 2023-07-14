Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E222753B4D
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIE1-0006rU-Pv; Fri, 14 Jul 2023 08:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qKIDy-0006qN-Rk
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:48:42 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qKIDw-0008Pl-Ko
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 08:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689338920; x=1720874920;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=ImiwlgKEiPnFpHNJXbW6OppNQm7invy60SkgkT0QiVI=;
 b=KQtyUP/979d7gyt3Gi8N6HqZQDkTLWiQcypA7C9M0Hx7KVpEfglH6EM5
 hsUYYkbhDG7VFL2z71kTaYUMM2yWmlnmWP66Yu6wrtaDZIgLMXJduQCCR
 ELoTus/NWzacj9JTDJmA9249cNfmpiOrjXvp+T6xkFJbULtnyUTmhqKNh
 cXiYdmPWQLSNr6Uw0GIMZxEsh2FFMsfJuxo1PExPNhH8QAX0eJiiTkg/+
 pgwj7qk4EZdln1Wy8bb+79f6j8ljXfqoppLJyXdutRCXkGsCUug8jgkgc
 yX1oQVx/vyuVlQKS5k138dMWocTizji7g1S6XW5CzGdeLwVNQNVWwErMJ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345061669"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; d="scan'208";a="345061669"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2023 05:48:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846440576"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; d="scan'208";a="846440576"
Received: from tdx-lm.sh.intel.com ([10.239.53.27])
 by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 05:48:34 -0700
From: Wei Wang <wei.w.wang@intel.com>
To: quintela@redhat.com,
	peterx@redhat.com
Cc: qemu-devel@nongnu.org,
	Wei Wang <wei.w.wang@intel.com>
Subject: [PATCH v1] migration: refactor migration_completion
Date: Fri, 14 Jul 2023 20:48:23 +0800
Message-Id: <20230714124823.25142-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=wei.w.wang@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
 migration/migration.c | 181 +++++++++++++++++++++++++-----------------
 1 file changed, 106 insertions(+), 75 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..83f1c74f99 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2058,6 +2058,21 @@ static int await_return_path_close_on_source(MigrationState *ms)
     return ms->rp_state.error;
 }
 
+static int close_return_path_on_source(MigrationState *ms)
+{
+    int ret;
+
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
+    trace_migration_return_path_end_before();
+    ret = await_return_path_close_on_source(ms);
+    trace_migration_return_path_end_after(ret);
+
+    return ret;
+}
+
 static inline void
 migration_wait_main_channel(MigrationState *ms)
 {
@@ -2288,66 +2303,107 @@ static int migration_maybe_pause(MigrationState *s,
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
+static int migration_completion_postcopy(MigrationState *s)
+{
+    trace_migration_completion_postcopy_end();
+
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
+
+    return 0;
+}
 
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
-    } else {
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
+    int ret = -1;
+    int current_active_state = s->state;
+
+    if (s->state == MIGRATION_STATUS_ACTIVE) {
+        ret = migration_completion_precopy(s, &current_active_state);
+    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        ret = migration_completion_postcopy(s);
+    }
+
+    if (ret < 0) {
         goto fail;
     }
 
@@ -2357,14 +2413,8 @@ static void migration_completion(MigrationState *s)
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
@@ -2384,26 +2434,7 @@ static void migration_completion(MigrationState *s)
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


