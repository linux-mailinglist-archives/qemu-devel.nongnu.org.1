Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B397B7990
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:08:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwsk-0003By-ET; Wed, 04 Oct 2023 04:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsY-0002fj-OF; Wed, 04 Oct 2023 04:05:10 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwsR-0001Z8-OL; Wed, 04 Oct 2023 04:05:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1832275A8;
 Wed,  4 Oct 2023 11:02:28 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9448E2CBE2;
 Wed,  4 Oct 2023 11:02:27 +0300 (MSK)
Received: (nullmailer pid 2702834 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 28/45] migration: Fix possible races when shutting down
 the return path
Date: Wed,  4 Oct 2023 11:01:49 +0300
Message-Id: <20231004080221.2702636-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Fabiano Rosas <farosas@suse.de>

We cannot call qemu_file_shutdown() on the return path file without
taking the file lock. The return path thread could be running it's
cleanup code and have just cleared the from_dst_file pointer.

Checking ms->to_dst_file for errors could also race with
migrate_fd_cleanup() which clears the to_dst_file pointer.

Protect both accesses by taking the file lock.

This was caught by inspection, it should be rare, but the next patches
will start calling this code from other places, so let's do the
correct thing.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230918172822.19052-4-farosas@suse.de>
(cherry picked from commit 639decf529793fc544c8055b82be8abe77fa48fa)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index b92c6ae436..517b3e04d2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2053,17 +2053,18 @@ static int open_return_path_on_source(MigrationState *ms,
 static int await_return_path_close_on_source(MigrationState *ms)
 {
     /*
-     * If this is a normal exit then the destination will send a SHUT and the
-     * rp_thread will exit, however if there's an error we need to cause
-     * it to exit.
+     * If this is a normal exit then the destination will send a SHUT
+     * and the rp_thread will exit, however if there's an error we
+     * need to cause it to exit. shutdown(2), if we have it, will
+     * cause it to unblock if it's stuck waiting for the destination.
      */
-    if (qemu_file_get_error(ms->to_dst_file) && ms->rp_state.from_dst_file) {
-        /*
-         * shutdown(2), if we have it, will cause it to unblock if it's stuck
-         * waiting for the destination.
-         */
-        qemu_file_shutdown(ms->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
+        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
+            qemu_file_get_error(ms->to_dst_file)) {
+            qemu_file_shutdown(ms->rp_state.from_dst_file);
+        }
     }
+
     trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
-- 
2.39.2


