Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B8270DA5D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:22:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P8C-0006Cm-Ay; Tue, 23 May 2023 06:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P82-0005Ip-BJ; Tue, 23 May 2023 06:20:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P80-000349-94; Tue, 23 May 2023 06:20:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E6CA7D3D;
 Tue, 23 May 2023 13:20:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B8E772A4;
 Tue, 23 May 2023 13:20:15 +0300 (MSK)
Received: (nullmailer pid 86082 invoked by uid 1000);
 Tue, 23 May 2023 10:20:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 38/45] migration: Attempt disk reactivation in more
 failure scenarios
Date: Tue, 23 May 2023 13:17:15 +0300
Message-Id: <20230523102014.85954-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Eric Blake <eblake@redhat.com>

Commit fe904ea824 added a fail_inactivate label, which tries to
reactivate disks on the source after a failure while s->state ==
MIGRATION_STATUS_ACTIVE, but didn't actually use the label if
qemu_savevm_state_complete_precopy() failed.  This failure to
reactivate is also present in commit 6039dd5b1c (also covering the new
s->state == MIGRATION_STATUS_DEVICE state) and 403d18ae (ensuring
s->block_inactive is set more reliably).

Consolidate the two labels back into one - no matter HOW migration is
failed, if there is any chance we can reach vm_start() after having
attempted inactivation, it is essential that we have tried to restart
disks before then.  This also makes the cleanup more like
migrate_fd_cancel().

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20230502205212.134680-1-eblake@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 6dab4c93ecfae48e2e67b984d1032c1e988d3005)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: minor context tweak near added comment in migration/migration.c)

diff --git a/migration/migration.c b/migration/migration.c
index 2c92ad9014..c19fb5cb3e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3327,6 +3327,11 @@ static void migration_completion(MigrationState *s)
                                             MIGRATION_STATUS_DEVICE);
             }
             if (ret >= 0) {
+                /*
+                 * Inactivate disks except in COLO, and track that we
+                 * have done so in order to remember to reactivate
+                 * them if migration fails or is cancelled.
+                 */
                 s->block_inactive = !migrate_colo_enabled();
                 qemu_file_set_rate_limit(s->to_dst_file, INT64_MAX);
                 ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,
@@ -3367,13 +3372,13 @@ static void migration_completion(MigrationState *s)
         rp_error = await_return_path_close_on_source(s);
         trace_migration_return_path_end_after(rp_error);
         if (rp_error) {
-            goto fail_invalidate;
+            goto fail;
         }
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
         trace_migration_completion_file_err();
-        goto fail_invalidate;
+        goto fail;
     }
 
     if (migrate_colo_enabled() && s->state == MIGRATION_STATUS_ACTIVE) {
@@ -3387,26 +3392,25 @@ static void migration_completion(MigrationState *s)
 
     return;
 
-fail_invalidate:
-    /* If not doing postcopy, vm_start() will be called: let's regain
-     * control on images.
-     */
-    if (s->state == MIGRATION_STATUS_ACTIVE ||
-        s->state == MIGRATION_STATUS_DEVICE) {
+fail:
+    if (s->block_inactive && (s->state == MIGRATION_STATUS_ACTIVE ||
+                              s->state == MIGRATION_STATUS_DEVICE)) {
+        /*
+         * If not doing postcopy, vm_start() will be called: let's
+         * regain control on images.
+         */
         Error *local_err = NULL;
 
         qemu_mutex_lock_iothread();
         bdrv_activate_all(&local_err);
         if (local_err) {
             error_report_err(local_err);
-            s->block_inactive = true;
         } else {
             s->block_inactive = false;
         }
         qemu_mutex_unlock_iothread();
     }
 
-fail:
     migrate_set_state(&s->state, current_active_state,
                       MIGRATION_STATUS_FAILED);
 }
-- 
2.39.2


