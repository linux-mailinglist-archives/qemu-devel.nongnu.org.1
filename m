Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30257706857
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGQX-0006eM-8I; Wed, 17 May 2023 08:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQV-0006dE-44
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:43 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQT-0001AD-CJ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:42 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 6264D5F025;
 Wed, 17 May 2023 15:38:35 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown
 [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KcbvG13OqeA0-AULsnu2a; Wed, 17 May 2023 15:38:34 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684327114; bh=Fo/EWCGQSlUr4DO8LrrOj/QlVEYudvQ+nSMzOkacUDc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=RIyUTS2r0L7OigEnEvdlVlJUsb5d0qfLS5pbX8vy20bS1JJY3NAgwsyi4md+wILzk
 lU+sQ5MwKG/QoC8moH5TrYfWjFARuZ2tLMPM0y3cXRFmhbDVYb+ACT9UhXRR7fh6WG
 ZAI/H2ZmjhRVatyVVXu7F18R1G//Jg6eY48m4v9g=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, leobras@redhat.com, peterx@redhat.com,
 quintela@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH 4/5] migration: switch from .vm_was_running to .vm_old_state
Date: Wed, 17 May 2023 15:37:51 +0300
Message-Id: <20230517123752.21615-5-vsementsov@yandex-team.ru>
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

No logic change here, only refactoring. That's a preparation for next
commit where we finally restore the stopped vm state on migration
failure or cancellation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/migration.c | 11 ++++++-----
 migration/migration.h |  9 ++++++---
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b42d028191..4ccb9f9f3b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1422,7 +1422,7 @@ void migrate_init(MigrationState *s)
 
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
-    s->vm_was_running = false;
+    s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
 }
@@ -2312,7 +2312,8 @@ static void migration_completion(MigrationState *s)
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-        s->vm_was_running = runstate_is_running();
+
+        s->vm_old_state = runstate_get();
         global_state_store();
 
         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
@@ -2792,12 +2793,12 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_COLO:
         assert(migrate_colo());
         migrate_start_colo_process(s);
-        s->vm_was_running = true;
+        s->vm_old_state = RUN_STATE_RUNNING;
         /* Fallthrough */
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        if (s->vm_was_running) {
+        if (s->vm_old_state == RUN_STATE_RUNNING) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
                 vm_start();
             }
@@ -3117,7 +3118,7 @@ static void *bg_migration_thread(void *opaque)
      * transition in vm_stop_force_state() we need to wakeup it up.
      */
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-    s->vm_was_running = runstate_is_running();
+    s->vm_old_state = runstate_get();
 
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
diff --git a/migration/migration.h b/migration/migration.h
index 7721c7658b..a786778c9d 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -25,6 +25,7 @@
 #include "net/announce.h"
 #include "qom/object.h"
 #include "postcopy-ram.h"
+#include "sysemu/runstate.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -310,12 +311,14 @@ struct MigrationState {
     int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
     int64_t setup_time;
+
     /*
-     * Whether guest was running when we enter the completion stage.
+     * State before stopping the vm by vm_stop_force_state().
      * If migration is interrupted by any reason, we need to continue
-     * running the guest on source.
+     * running the guest on source if it was running or restore its stopped
+     * state.
      */
-    bool vm_was_running;
+    RunState vm_old_state;
 
     /* Flag set once the migration has been asked to enter postcopy */
     bool start_postcopy;
-- 
2.34.1


