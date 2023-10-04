Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE07B7994
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwse-0002w1-6u; Wed, 04 Oct 2023 04:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsN-0001cR-47; Wed, 04 Oct 2023 04:04:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnws7-0001cU-L3; Wed, 04 Oct 2023 04:04:58 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EDBF3275A9;
 Wed,  4 Oct 2023 11:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EABBF2CBE3;
 Wed,  4 Oct 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 2702837 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 29/45] migration: Fix possible race when shutting down
 to_dst_file
Date: Wed,  4 Oct 2023 11:01:50 +0300
Message-Id: <20231004080221.2702636-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

It's not safe to call qemu_file_shutdown() on the to_dst_file without
first checking for the file's presence under the lock. The cleanup of
this file happens at postcopy_pause() and migrate_fd_cleanup() which
are not necessarily running in the same thread as migrate_fd_cancel().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-5-farosas@suse.de>
(cherry picked from commit 7478fb0df914f0a5ab551ff74b1df62dd250500e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 517b3e04d2..169e6bdce8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1246,7 +1246,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
 static void migrate_fd_cancel(MigrationState *s)
 {
     int old_state ;
-    QEMUFile *f = migrate_get_current()->to_dst_file;
+
     trace_migrate_fd_cancel();
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
@@ -1272,11 +1272,13 @@ static void migrate_fd_cancel(MigrationState *s)
      * If we're unlucky the migration code might be stuck somewhere in a
      * send/write while the network has failed and is waiting to timeout;
      * if we've got shutdown(2) available then we can force it to quit.
-     * The outgoing qemu file gets closed in migrate_fd_cleanup that is
-     * called in a bh, so there is no race against this cancel.
      */
-    if (s->state == MIGRATION_STATUS_CANCELLING && f) {
-        qemu_file_shutdown(f);
+    if (s->state == MIGRATION_STATUS_CANCELLING) {
+        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+            if (s->to_dst_file) {
+                qemu_file_shutdown(s->to_dst_file);
+            }
+        }
     }
     if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
         Error *local_err = NULL;
@@ -1520,12 +1522,14 @@ void qmp_migrate_pause(Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
-    int ret;
+    int ret = 0;
 
     if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         /* Source side, during postcopy */
         qemu_mutex_lock(&ms->qemu_file_lock);
-        ret = qemu_file_shutdown(ms->to_dst_file);
+        if (ms->to_dst_file) {
+            ret = qemu_file_shutdown(ms->to_dst_file);
+        }
         qemu_mutex_unlock(&ms->qemu_file_lock);
         if (ret) {
             error_setg(errp, "Failed to pause source migration");
-- 
2.39.2


