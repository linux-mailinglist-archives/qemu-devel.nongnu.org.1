Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0E571F6D0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 01:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ryN-0006Fl-O7; Thu, 01 Jun 2023 19:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryL-0006Eg-3z
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4ryH-0000xe-3x
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 19:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685663083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TF/SpRsVU0zyYX4JBUn+J3w91fUBxDQQEjMTghPFV0M=;
 b=JBJWG0E+FqLL0ypVC12XF3Ku2wBOdjRim05dmsF+24p529ZyCgm5gtDQaKL5zi8JP9mUvn
 lnTXZ0xjtgI+IebsBJ6Wrw+AVcNo9d4Z0gfc8b9pUeFysxSBSobzMTsJYXqn2KwRIr/JOA
 CjEoB04OBN2azKFWp9Bdd18c5xBLMPY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-404-jp9jFAVsM9enegM95dbyLA-1; Thu, 01 Jun 2023 19:44:31 -0400
X-MC-Unique: jp9jFAVsM9enegM95dbyLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92D338015D8;
 Thu,  1 Jun 2023 23:44:31 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 701F0492B00;
 Thu,  1 Jun 2023 23:44:30 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 2/6] migration: never fail in global_state_store()
Date: Fri,  2 Jun 2023 01:44:22 +0200
Message-Id: <20230601234426.29984-3-quintela@redhat.com>
In-Reply-To: <20230601234426.29984-1-quintela@redhat.com>
References: <20230601234426.29984-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Actually global_state_store() can never fail. Let's get rid of extra
error paths.

To make things clear, use new runstate_get() and use same approach for
global_state_store() and global_state_store_running().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230517123752.21615-3-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/global_state.h |  2 +-
 migration/global_state.c         | 29 +++++++++++-----------
 migration/migration.c            | 41 +++++++++++++++-----------------
 migration/savevm.c               |  6 +----
 4 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index 945eb35d5b..d7c2cd3216 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -16,7 +16,7 @@
 #include "qapi/qapi-types-run-state.h"
 
 void register_global_state(void);
-int global_state_store(void);
+void global_state_store(void);
 void global_state_store_running(void);
 bool global_state_received(void);
 RunState global_state_get_runstate(void);
diff --git a/migration/global_state.c b/migration/global_state.c
index a33947ca32..4e2a9d8ec0 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -29,23 +29,22 @@ typedef struct {
 
 static GlobalState global_state;
 
-int global_state_store(void)
+static void global_state_do_store(RunState state)
 {
-    if (!runstate_store((char *)global_state.runstate,
-                        sizeof(global_state.runstate))) {
-        error_report("runstate name too big: %s", global_state.runstate);
-        trace_migrate_state_too_big();
-        return -EINVAL;
-    }
-    return 0;
-}
-
-void global_state_store_running(void)
-{
-    const char *state = RunState_str(RUN_STATE_RUNNING);
-    assert(strlen(state) < sizeof(global_state.runstate));
+    const char *state_str = RunState_str(state);
+    assert(strlen(state_str) < sizeof(global_state.runstate));
     strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
-              state, '\0');
+              state_str, '\0');
+}
+
+void global_state_store(void)
+{
+    global_state_do_store(runstate_get());
+}
+
+void global_state_store_running(void)
+{
+    global_state_do_store(RUN_STATE_RUNNING);
 }
 
 bool global_state_received(void)
diff --git a/migration/migration.c b/migration/migration.c
index 5de7f734b9..c75d5aa479 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2288,27 +2288,26 @@ static void migration_completion(MigrationState *s)
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
         s->vm_was_running = runstate_is_running();
-        ret = global_state_store();
+        global_state_store();
 
-        if (!ret) {
-            ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
-            trace_migration_completion_vm_stop(ret);
-            if (ret >= 0) {
-                ret = migration_maybe_pause(s, &current_active_state,
-                                            MIGRATION_STATUS_DEVICE);
-            }
-            if (ret >= 0) {
-                /*
-                 * Inactivate disks except in COLO, and track that we
-                 * have done so in order to remember to reactivate
-                 * them if migration fails or is cancelled.
-                 */
-                s->block_inactive = !migrate_colo();
-                migration_rate_set(RATE_LIMIT_DISABLED);
-                ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                                         s->block_inactive);
-            }
+        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+        trace_migration_completion_vm_stop(ret);
+        if (ret >= 0) {
+            ret = migration_maybe_pause(s, &current_active_state,
+                                        MIGRATION_STATUS_DEVICE);
         }
+        if (ret >= 0) {
+            /*
+             * Inactivate disks except in COLO, and track that we
+             * have done so in order to remember to reactivate
+             * them if migration fails or is cancelled.
+             */
+            s->block_inactive = !migrate_colo();
+            migration_rate_set(RATE_LIMIT_DISABLED);
+            ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
+                                                     s->block_inactive);
+        }
+
         qemu_mutex_unlock_iothread();
 
         if (ret < 0) {
@@ -3088,9 +3087,7 @@ static void *bg_migration_thread(void *opaque)
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     s->vm_was_running = runstate_is_running();
 
-    if (global_state_store()) {
-        goto fail;
-    }
+    global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
     if (vm_stop_force_state(RUN_STATE_PAUSED)) {
         goto fail;
diff --git a/migration/savevm.c b/migration/savevm.c
index 03795ce8dc..bc284087f9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2919,11 +2919,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
     saved_vm_running = runstate_is_running();
 
-    ret = global_state_store();
-    if (ret) {
-        error_setg(errp, "Error saving global state");
-        return false;
-    }
+    global_state_store();
     vm_stop(RUN_STATE_SAVE_VM);
 
     bdrv_drain_all_begin();
-- 
2.40.1


