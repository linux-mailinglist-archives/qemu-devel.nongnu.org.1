Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55370685C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGQW-0006dV-2R; Wed, 17 May 2023 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQT-0006cp-QA
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:41 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQR-00019r-LZ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:41 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id B205E5ED1E;
 Wed, 17 May 2023 15:38:33 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown
 [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KcbvG13OqeA0-G3PHp3O5; Wed, 17 May 2023 15:38:32 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684327112; bh=5/3JCpOGZMdbTePdLb5WsIsKbqTR8LjuYOU/wmufghs=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oj7v3FbNBrJ4W0u0bii8gLyUvAs7AACsaRr2WEpDL6RodjHkSJnrUs234yxLRrZHW
 4yaXwmK528xJUB0mlQpZM725Ek2ANveF2vZG2s/KRBpFwHIMkIXhn7A/GIbwklW2xU
 8bokjF02Bn7DUixry8EAfOY/j++HDWOIGNaYH7EY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, leobras@redhat.com, peterx@redhat.com,
 quintela@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH 2/5] migration: never fail in global_state_store()
Date: Wed, 17 May 2023 15:37:49 +0300
Message-Id: <20230517123752.21615-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517123752.21615-1-vsementsov@yandex-team.ru>
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Actually global_state_store() can never fail. Let's get rid of extra
error paths.

To make things clear, use new runstate_get() and use same approach for
global_state_store() and global_state_store_running().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/global_state.h |  2 +-
 migration/global_state.c         | 23 ++++++++---------
 migration/migration.c            | 43 +++++++++++++++-----------------
 migration/savevm.c               |  6 +----
 4 files changed, 33 insertions(+), 41 deletions(-)

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
+    const char *state_str = RunState_str(state);
+    assert(strlen(state_str) < sizeof(global_state.runstate));
+    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
+              state_str, '\0');
+}
+
+void global_state_store(void)
+{
+    global_state_do_store(runstate_get());
 }
 
 void global_state_store_running(void)
 {
-    const char *state = RunState_str(RUN_STATE_RUNNING);
-    assert(strlen(state) < sizeof(global_state.runstate));
-    strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
-              state, '\0');
+    global_state_do_store(RUN_STATE_RUNNING);
 }
 
 bool global_state_received(void)
diff --git a/migration/migration.c b/migration/migration.c
index 439e8651df..b42d028191 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2313,27 +2313,26 @@ static void migration_completion(MigrationState *s)
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
         s->vm_was_running = runstate_is_running();
-        ret = global_state_store();
-
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
-                qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
-                ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
-                                                         s->block_inactive);
-            }
+        global_state_store();
+
+        ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
+        trace_migration_completion_vm_stop(ret);
+        if (ret >= 0) {
+            ret = migration_maybe_pause(s, &current_active_state,
+                                        MIGRATION_STATUS_DEVICE);
+        }
+        if (ret >= 0) {
+            /*
+             * Inactivate disks except in COLO, and track that we
+             * have done so in order to remember to reactivate
+             * them if migration fails or is cancelled.
+             */
+            s->block_inactive = !migrate_colo();
+            qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
+            ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
+                                                     s->block_inactive);
         }
+
         qemu_mutex_unlock_iothread();
 
         if (ret < 0) {
@@ -3120,9 +3119,7 @@ static void *bg_migration_thread(void *opaque)
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
index 032044b1d5..778030d087 100644
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
2.34.1


