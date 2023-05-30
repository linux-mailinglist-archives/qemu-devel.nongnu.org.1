Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93980715E1A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 13:56:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3xw5-00052E-Sf; Tue, 30 May 2023 07:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw3-0004x3-KN
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q3xw1-00008C-Vw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 07:54:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685447680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tj0cQwuOH13SAeW28WyCSad0nngr0wzVxNpQRkS9oRA=;
 b=gkOTh2PfwMG4F5odpdb02mdPFAV0kS3QQvc6iS/7nkQiAqc7wmgkrhIZeLujLLilykNl02
 Soxd+OMCJakMb3xgSFMxhcvDa+AS0hYXCssxZaW7FCq+C4PTSGxTQBRyImQT5U9l6z49oe
 AhhUJfyRppfK6RsjgcZoEfsP6h23vBo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-F_tCMbPNMaCGU3KugtBgGQ-1; Tue, 30 May 2023 07:54:38 -0400
X-MC-Unique: F_tCMbPNMaCGU3KugtBgGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93F9685A5A8;
 Tue, 30 May 2023 11:54:38 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3E240C6EC4;
 Tue, 30 May 2023 11:54:36 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 04/21] migration: switch from .vm_was_running to .vm_old_state
Date: Tue, 30 May 2023 13:54:12 +0200
Message-Id: <20230530115429.1998-5-quintela@redhat.com>
In-Reply-To: <20230530115429.1998-1-quintela@redhat.com>
References: <20230530115429.1998-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

No logic change here, only refactoring. That's a preparation for next
commit where we finally restore the stopped vm state on migration
failure or cancellation.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20230517123752.21615-5-vsementsov@yandex-team.ru>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.h |  9 ++++++---
 migration/migration.c | 11 ++++++-----
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 48a46123a0..30c3e97635 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -25,6 +25,7 @@
 #include "net/announce.h"
 #include "qom/object.h"
 #include "postcopy-ram.h"
+#include "sysemu/runstate.h"
 
 struct PostcopyBlocktimeContext;
 
@@ -317,12 +318,14 @@ struct MigrationState {
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
diff --git a/migration/migration.c b/migration/migration.c
index c75d5aa479..033162cda0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1402,7 +1402,7 @@ void migrate_init(MigrationState *s)
 
     s->start_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     s->total_time = 0;
-    s->vm_was_running = false;
+    s->vm_old_state = -1;
     s->iteration_initial_bytes = 0;
     s->threshold_size = 0;
 }
@@ -2287,7 +2287,8 @@ static void migration_completion(MigrationState *s)
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-        s->vm_was_running = runstate_is_running();
+
+        s->vm_old_state = runstate_get();
         global_state_store();
 
         ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
@@ -2760,12 +2761,12 @@ static void migration_iteration_finish(MigrationState *s)
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
@@ -3085,7 +3086,7 @@ static void *bg_migration_thread(void *opaque)
      * transition in vm_stop_force_state() we need to wakeup it up.
      */
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-    s->vm_was_running = runstate_is_running();
+    s->vm_old_state = runstate_get();
 
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
-- 
2.40.1


