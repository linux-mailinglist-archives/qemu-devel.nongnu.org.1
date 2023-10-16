Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2570C7CA4D5
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:10:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKVc-0001Nv-4M; Mon, 16 Oct 2023 06:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVM-0001JJ-8C
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKVK-0007Nl-0d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KuYyQQwWfQ7obuS2fy7ZldJSg7RA9HYmz86cPjRoGGk=;
 b=ckcq9Ck2JKINyKz2mw75+xE1O2yGcs+ltEE6HqCu0Y3fH/cBZEYG5Vlp7VYy9X9JTONIxS
 wfvqFik0IpZSrrANtJZJWiMOJmDkHUcDGHP/A4EgVKeCIUEWOlRv9I0VNhGQhjGFdGQqPe
 iH6BuC+EGi73qpsQp/oeshaoRkCentA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-FqF2wy3YM_y5SWmfvCZT4Q-1; Mon, 16 Oct 2023 06:07:15 -0400
X-MC-Unique: FqF2wy3YM_y5SWmfvCZT4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CB5D3C1F120;
 Mon, 16 Oct 2023 10:07:14 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7115F63F45;
 Mon, 16 Oct 2023 10:07:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PULL 01/38] migration: refactor migration_completion
Date: Mon, 16 Oct 2023 12:06:29 +0200
Message-ID: <20231016100706.2551-2-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Wei Wang <wei.w.wang@intel.com>

Current migration_completion function is a bit long. Refactor the long
implementation into different subfunctions:
- migration_completion_precopy: completion code related to precopy
- migration_completion_postcopy: completion code related to postcopy

Rename await_return_path_close_on_source to
close_return_path_on_source: It is renamed to match with
open_return_path_on_source.

This improves readability and is easier for future updates (e.g. add new
subfunctions when completion code related to new features are needed). No
functional changes intended.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20230804093053.5037-1-wei.w.wang@intel.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 167 ++++++++++++++++++++++++------------------
 1 file changed, 94 insertions(+), 73 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1c6c81ad49..0e1002d017 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -99,7 +99,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
-static int await_return_path_close_on_source(MigrationState *s);
+static int close_return_path_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1191,7 +1191,7 @@ static void migrate_fd_cleanup(MigrationState *s)
      * We already cleaned up to_dst_file, so errors from the return
      * path might be due to that, ignore them.
      */
-    await_return_path_close_on_source(s);
+    close_return_path_on_source(s);
 
     assert(!migration_is_active(s));
 
@@ -2049,8 +2049,7 @@ static int open_return_path_on_source(MigrationState *ms)
     return 0;
 }
 
-/* Returns 0 if the RP was ok, otherwise there was an error on the RP */
-static int await_return_path_close_on_source(MigrationState *ms)
+static int close_return_path_on_source(MigrationState *ms)
 {
     int ret;
 
@@ -2317,6 +2316,87 @@ static int migration_maybe_pause(MigrationState *s,
     return s->state == new_state ? 0 : -EINVAL;
 }
 
+static int migration_completion_precopy(MigrationState *s,
+                                        int *current_active_state)
+{
+    int ret;
+
+    qemu_mutex_lock_iothread();
+    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
+
+    s->vm_old_state = runstate_get();
+    global_state_store();
+
+    ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+    trace_migration_completion_vm_stop(ret);
+    if (ret < 0) {
+        goto out_unlock;
+    }
+
+    ret = migration_maybe_pause(s, current_active_state,
+                                MIGRATION_STATUS_DEVICE);
+    if (ret < 0) {
+        goto out_unlock;
+    }
+
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
+
+static void migration_completion_postcopy(MigrationState *s)
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
+}
+
+static void migration_completion_failed(MigrationState *s,
+                                        int current_active_state)
+{
+    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
+                              s->state == MIGRATION_STATUS_DEVICE)) {
+        /*
+         * If not doing postcopy, vm_start() will be called: let's
+         * regain control on images.
+         */
+        Error *local_err = NULL;
+
+        qemu_mutex_lock_iothread();
+        bdrv_activate_all(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+        } else {
+            s->block_inactive = false;
+        }
+        qemu_mutex_unlock_iothread();
+    }
+
+    migrate_set_state(&s->state, current_active_state,
+                      MIGRATION_STATUS_FAILED);
+}
+
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
@@ -2325,62 +2405,22 @@ static int migration_maybe_pause(MigrationState *s,
  */
 static void migration_completion(MigrationState *s)
 {
-    int ret;
+    int ret = 0;
     int current_active_state = s->state;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
-        qemu_mutex_lock_iothread();
-        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-
-        s->vm_old_state = runstate_get();
-        global_state_store();
-
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
-
-        qemu_mutex_unlock_iothread();
-
-        if (ret < 0) {
-            goto fail;
-        }
+        ret = migration_completion_precopy(s, &current_active_state);
     } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
-        trace_migration_completion_postcopy_end();
-
-        qemu_mutex_lock_iothread();
-        qemu_savevm_state_complete_postcopy(s->to_dst_file);
-        qemu_mutex_unlock_iothread();
-
-        /*
-         * Shutdown the postcopy fast path thread.  This is only needed
-         * when dest QEMU binary is old (7.1/7.2).  QEMU 8.0+ doesn't need
-         * this.
-         */
-        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-            postcopy_preempt_shutdown_file(s);
-        }
-
-        trace_migration_completion_postcopy_end_after_complete();
+        migration_completion_postcopy(s);
     } else {
+        ret = -1;
+    }
+
+    if (ret < 0) {
         goto fail;
     }
 
-    if (await_return_path_close_on_source(s)) {
+    if (close_return_path_on_source(s)) {
         goto fail;
     }
 
@@ -2401,26 +2441,7 @@ static void migration_completion(MigrationState *s)
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
@@ -2563,7 +2584,7 @@ static MigThrError postcopy_pause(MigrationState *s)
          * path and just wait for the thread to finish. It will be
          * re-created when we resume.
          */
-        await_return_path_close_on_source(s);
+        close_return_path_on_source(s);
 
         migrate_set_state(&s->state, s->state,
                           MIGRATION_STATUS_POSTCOPY_PAUSED);
-- 
2.41.0


