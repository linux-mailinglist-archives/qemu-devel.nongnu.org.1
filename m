Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD777F6E8
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:55:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTI-0008HF-7q; Thu, 17 Aug 2023 08:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT6-0007xB-TZ
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT2-0002fZ-Pv
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7vBTDTOQ/FcEoefjWhh2zX6DUa648dlO3UpsEjjfZ8=;
 b=hsC3HUm9M+VspFWXkxSaMnnuIDFScilQhK7r5Xs3qOyMQAD3EJf3wmHXICZPJ1qNIF37hs
 DGDkBXOZK000azIEHwdGexFwRdqHy9JPjsZvaUlia+ZzY5WnjTWKylBWTluMsmNA8x3hnl
 dXUFqprlDe7v/9brZQXnpCobNeoNldM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-avPZpYVfNcChxy3YY4F92Q-1; Thu, 17 Aug 2023 08:51:06 -0400
X-MC-Unique: avPZpYVfNcChxy3YY4F92Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D47BC381BE81;
 Thu, 17 Aug 2023 12:51:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A8E181121314;
 Thu, 17 Aug 2023 12:51:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 09/21] block: Mark bdrv_replace_child_tran() GRAPH_WRLOCK
Date: Thu, 17 Aug 2023 14:50:08 +0200
Message-ID: <20230817125020.208339-10-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_replace_child_tran(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

While a graph lock is held, polling is not allowed. Therefore draining
the necessary nodes can no longer be done in bdrv_remove_child() and
bdrv_replace_node_noperm(), but the callers must already make sure that
they are drained.

Note that the transaction callbacks still take the lock internally, so
tran_finalize() must be called without the lock held. This is because
bdrv_append() also calls bdrv_attach_child_noperm(), which currently
requires to be called unlocked. Once it changes, the transaction
callbacks can be changed, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 78 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/block.c b/block.c
index 500a08b26c..c06853f36e 100644
--- a/block.c
+++ b/block.c
@@ -94,7 +94,8 @@ static bool bdrv_recurse_has_child(BlockDriverState *bs,
 static void GRAPH_WRLOCK
 bdrv_replace_child_noperm(BdrvChild *child, BlockDriverState *new_bs);
 
-static void bdrv_remove_child(BdrvChild *child, Transaction *tran);
+static void GRAPH_WRLOCK
+bdrv_remove_child(BdrvChild *child, Transaction *tran);
 
 static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue,
@@ -2425,8 +2426,9 @@ static TransactionActionDrv bdrv_replace_child_drv = {
  *
  * The function doesn't update permissions, caller is responsible for this.
  */
-static void bdrv_replace_child_tran(BdrvChild *child, BlockDriverState *new_bs,
-                                    Transaction *tran)
+static void GRAPH_WRLOCK
+bdrv_replace_child_tran(BdrvChild *child, BlockDriverState *new_bs,
+                        Transaction *tran)
 {
     BdrvReplaceChildState *s = g_new(BdrvReplaceChildState, 1);
 
@@ -2443,9 +2445,7 @@ static void bdrv_replace_child_tran(BdrvChild *child, BlockDriverState *new_bs,
         bdrv_ref(new_bs);
     }
 
-    bdrv_graph_wrlock(new_bs);
     bdrv_replace_child_noperm(child, new_bs);
-    bdrv_graph_wrunlock();
     /* old_bs reference is transparently moved from @child to @s */
 }
 
@@ -3437,8 +3437,14 @@ static int bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
     }
 
     if (child) {
+        bdrv_drained_begin(child->bs);
+        bdrv_graph_wrlock(NULL);
+
         bdrv_unset_inherits_from(parent_bs, child, tran);
         bdrv_remove_child(child, tran);
+
+        bdrv_graph_wrunlock();
+        bdrv_drained_end(child->bs);
     }
 
     if (!child_bs) {
@@ -5131,7 +5137,7 @@ void bdrv_close_all(void)
     assert(QTAILQ_EMPTY(&all_bdrv_states));
 }
 
-static bool should_update_child(BdrvChild *c, BlockDriverState *to)
+static bool GRAPH_RDLOCK should_update_child(BdrvChild *c, BlockDriverState *to)
 {
     GQueue *queue;
     GHashTable *found;
@@ -5220,45 +5226,41 @@ static TransactionActionDrv bdrv_remove_child_drv = {
     .commit = bdrv_remove_child_commit,
 };
 
-/* Function doesn't update permissions, caller is responsible for this. */
-static void bdrv_remove_child(BdrvChild *child, Transaction *tran)
+/*
+ * Function doesn't update permissions, caller is responsible for this.
+ *
+ * @child->bs (if non-NULL) must be drained.
+ */
+static void GRAPH_WRLOCK bdrv_remove_child(BdrvChild *child, Transaction *tran)
 {
     if (!child) {
         return;
     }
 
     if (child->bs) {
-        BlockDriverState *bs = child->bs;
-        bdrv_drained_begin(bs);
+        assert(child->quiesced_parent);
         bdrv_replace_child_tran(child, NULL, tran);
-        bdrv_drained_end(bs);
     }
 
     tran_add(tran, &bdrv_remove_child_drv, child);
 }
 
-static void undrain_on_clean_cb(void *opaque)
-{
-    bdrv_drained_end(opaque);
-}
-
-static TransactionActionDrv undrain_on_clean = {
-    .clean = undrain_on_clean_cb,
-};
-
-static int bdrv_replace_node_noperm(BlockDriverState *from,
-                                    BlockDriverState *to,
-                                    bool auto_skip, Transaction *tran,
-                                    Error **errp)
+/*
+ * Both @from and @to (if non-NULL) must be drained. @to must be kept drained
+ * until the transaction is completed.
+ */
+static int GRAPH_WRLOCK
+bdrv_replace_node_noperm(BlockDriverState *from,
+                         BlockDriverState *to,
+                         bool auto_skip, Transaction *tran,
+                         Error **errp)
 {
     BdrvChild *c, *next;
 
     GLOBAL_STATE_CODE();
 
-    bdrv_drained_begin(from);
-    bdrv_drained_begin(to);
-    tran_add(tran, &undrain_on_clean, from);
-    tran_add(tran, &undrain_on_clean, to);
+    assert(from->quiesce_counter);
+    assert(to->quiesce_counter);
 
     QLIST_FOREACH_SAFE(c, &from->parents, next_parent, next) {
         assert(c->bs == from);
@@ -5321,6 +5323,9 @@ static int bdrv_replace_node_common(BlockDriverState *from,
     assert(qemu_get_current_aio_context() == qemu_get_aio_context());
     assert(bdrv_get_aio_context(from) == bdrv_get_aio_context(to));
     bdrv_drained_begin(from);
+    bdrv_drained_begin(to);
+
+    bdrv_graph_wrlock(to);
 
     /*
      * Do the replacement without permission update.
@@ -5334,6 +5339,7 @@ static int bdrv_replace_node_common(BlockDriverState *from,
     }
 
     if (detach_subchain) {
+        /* to_cow_parent is already drained because from is drained */
         bdrv_remove_child(bdrv_filter_or_cow_child(to_cow_parent), tran);
     }
 
@@ -5348,8 +5354,10 @@ static int bdrv_replace_node_common(BlockDriverState *from,
     ret = 0;
 
 out:
+    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
 
+    bdrv_drained_end(to);
     bdrv_drained_end(from);
     bdrv_unref(from);
 
@@ -5393,6 +5401,7 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     BdrvChild *child;
     Transaction *tran = tran_new();
     AioContext *old_context, *new_context = NULL;
+    bool drained = false;
 
     GLOBAL_STATE_CODE();
 
@@ -5421,7 +5430,13 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
         aio_context_acquire(new_context);
     }
 
+    bdrv_drained_begin(bs_new);
+    bdrv_drained_begin(bs_top);
+    drained = true;
+
+    bdrv_graph_wrlock(bs_new);
     ret = bdrv_replace_node_noperm(bs_top, bs_new, true, tran, errp);
+    bdrv_graph_wrunlock();
     if (ret < 0) {
         goto out;
     }
@@ -5434,6 +5449,11 @@ out:
     bdrv_refresh_limits(bs_top, NULL, NULL);
     bdrv_graph_rdunlock_main_loop();
 
+    if (drained) {
+        bdrv_drained_end(bs_top);
+        bdrv_drained_end(bs_new);
+    }
+
     if (new_context && old_context != new_context) {
         aio_context_release(new_context);
         aio_context_acquire(old_context);
@@ -5456,6 +5476,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     bdrv_ref(old_bs);
     bdrv_drained_begin(old_bs);
     bdrv_drained_begin(new_bs);
+    bdrv_graph_wrlock(new_bs);
 
     bdrv_replace_child_tran(child, new_bs, tran);
 
@@ -5463,6 +5484,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     refresh_list = g_slist_prepend(refresh_list, new_bs);
 
     ret = bdrv_list_refresh_perms(refresh_list, NULL, tran, errp);
+    bdrv_graph_wrunlock();
 
     tran_finalize(tran, ret);
 
-- 
2.41.0


