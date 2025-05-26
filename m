Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDA6AC403B
	for <lists+qemu-devel@lfdr.de>; Mon, 26 May 2025 15:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXmD-0008Tc-7R; Mon, 26 May 2025 09:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXm2-0008SC-Em; Mon, 26 May 2025 09:21:50 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uJXm0-0000HL-J7; Mon, 26 May 2025 09:21:50 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 603B044556;
 Mon, 26 May 2025 15:21:45 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v3 02/24] block: move drain outside of read-locked
 bdrv_reopen_queue_child()
Date: Mon, 26 May 2025 15:21:18 +0200
Message-Id: <20250526132140.1641377-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250526132140.1641377-1-f.ebner@proxmox.com>
References: <20250526132140.1641377-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is in preparation to mark bdrv_drained_begin() as GRAPH_UNLOCKED.

More granular draining is not trivially possible, because
bdrv_reopen_queue_child() can recursively call itself.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---

No changes in v3.

 block.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index a5399888ba..3065d5c91e 100644
--- a/block.c
+++ b/block.c
@@ -4358,7 +4358,7 @@ bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
  * returns a pointer to bs_queue, which is either the newly allocated
  * bs_queue, or the existing bs_queue being used.
  *
- * bs is drained here and undrained by bdrv_reopen_queue_free().
+ * bs must be drained.
  */
 static BlockReopenQueue * GRAPH_RDLOCK
 bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
@@ -4377,12 +4377,7 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
 
     GLOBAL_STATE_CODE();
 
-    /*
-     * Strictly speaking, draining is illegal under GRAPH_RDLOCK. We know that
-     * we've been called with bdrv_graph_rdlock_main_loop(), though, so it's ok
-     * in practice.
-     */
-    bdrv_drained_begin(bs);
+    assert(bs->quiesce_counter > 0);
 
     if (bs_queue == NULL) {
         bs_queue = g_new0(BlockReopenQueue, 1);
@@ -4522,6 +4517,12 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     QDict *options, bool keep_old_opts)
 {
     GLOBAL_STATE_CODE();
+
+    if (bs_queue == NULL) {
+        /* Paired with bdrv_drain_all_end() in bdrv_reopen_queue_free(). */
+        bdrv_drain_all_begin();
+    }
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
@@ -4534,12 +4535,14 @@ void bdrv_reopen_queue_free(BlockReopenQueue *bs_queue)
     if (bs_queue) {
         BlockReopenQueueEntry *bs_entry, *next;
         QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
-            bdrv_drained_end(bs_entry->state.bs);
             qobject_unref(bs_entry->state.explicit_options);
             qobject_unref(bs_entry->state.options);
             g_free(bs_entry);
         }
         g_free(bs_queue);
+
+        /* Paired with bdrv_drain_all_begin() in bdrv_reopen_queue(). */
+        bdrv_drain_all_end();
     }
 }
 
-- 
2.39.5



