Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F6277F6C8
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcTP-000099-He; Thu, 17 Aug 2023 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT8-0007xE-6s
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qWcT4-0002ia-Oc
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 08:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692276672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwfaL3cDiMBo5TlgRk8mP0ZysCCdxjNcqZQRWaJF1Ag=;
 b=hFGP5Me6eC43KyE0dyGvEl14BHJXxRhfv/Yurf03K51qI6l2mU1yLez+fCGar4vs4Q476o
 +1k146v9SUqmc+oSvgS+c5im0KMy36gzdSnAvdjG1BYZP9chFbE1iH/k+wuLQ1YyjDCokb
 LQYPSQgBc/aED4sJfb1CvmcbV7+o9JQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-vM_h7ptQOWm-VCUf42R7MQ-1; Thu, 17 Aug 2023 08:51:09 -0400
X-MC-Unique: vM_h7ptQOWm-VCUf42R7MQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9E93C0E208;
 Thu, 17 Aug 2023 12:51:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 82DA31121314;
 Thu, 17 Aug 2023 12:51:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 11/21] block: Call transaction callbacks with lock held
Date: Thu, 17 Aug 2023 14:50:10 +0200
Message-ID: <20230817125020.208339-12-kwolf@redhat.com>
In-Reply-To: <20230817125020.208339-1-kwolf@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In previous patches, we changed some transactionable functions to be
marked as GRAPH_WRLOCK, but required that tran_finalize() is still
called without the lock. This was because all callbacks that can be in
the same transaction need to follow the same convention.

Now that we don't have conflicting requirements any more, we can switch
all of the transaction callbacks to be declared GRAPH_WRLOCK, too, and
call tran_finalize() with the lock held.

Document for each of these transactionable functions that the lock needs
to be held when completing the transaction, and make sure that all
callers down to the place where the transaction is finalised actually
have the writer lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 61 +++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/block.c b/block.c
index 780d129007..064851e0e1 100644
--- a/block.c
+++ b/block.c
@@ -2373,21 +2373,21 @@ typedef struct BdrvReplaceChildState {
     BlockDriverState *old_bs;
 } BdrvReplaceChildState;
 
-static void bdrv_replace_child_commit(void *opaque)
+static void GRAPH_WRLOCK bdrv_replace_child_commit(void *opaque)
 {
     BdrvReplaceChildState *s = opaque;
     GLOBAL_STATE_CODE();
 
-    bdrv_unref(s->old_bs);
+    bdrv_schedule_unref(s->old_bs);
 }
 
-static void bdrv_replace_child_abort(void *opaque)
+static void GRAPH_WRLOCK bdrv_replace_child_abort(void *opaque)
 {
     BdrvReplaceChildState *s = opaque;
     BlockDriverState *new_bs = s->child->bs;
 
     GLOBAL_STATE_CODE();
-    bdrv_graph_wrlock(s->old_bs);
+    assert_bdrv_graph_writable();
 
     /* old_bs reference is transparently moved from @s to @s->child */
     if (!s->child->bs) {
@@ -2406,7 +2406,6 @@ static void bdrv_replace_child_abort(void *opaque)
     assert(s->child->quiesced_parent);
     bdrv_replace_child_noperm(s->child, s->old_bs);
 
-    bdrv_graph_wrunlock();
     bdrv_unref(new_bs);
 }
 
@@ -2424,6 +2423,9 @@ static TransactionActionDrv bdrv_replace_child_drv = {
  * Both @child->bs and @new_bs (if non-NULL) must be drained. @new_bs must be
  * kept drained until the transaction is completed.
  *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
+ *
  * The function doesn't update permissions, caller is responsible for this.
  */
 static void GRAPH_WRLOCK
@@ -2949,16 +2951,15 @@ typedef struct BdrvAttachChildCommonState {
     AioContext *old_child_ctx;
 } BdrvAttachChildCommonState;
 
-static void bdrv_attach_child_common_abort(void *opaque)
+static void GRAPH_WRLOCK bdrv_attach_child_common_abort(void *opaque)
 {
     BdrvAttachChildCommonState *s = opaque;
     BlockDriverState *bs = s->child->bs;
 
     GLOBAL_STATE_CODE();
+    assert_bdrv_graph_writable();
 
-    bdrv_graph_wrlock(NULL);
     bdrv_replace_child_noperm(s->child, NULL);
-    bdrv_graph_wrunlock();
 
     if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
         bdrv_try_change_aio_context(bs, s->old_child_ctx, NULL, &error_abort);
@@ -2982,7 +2983,7 @@ static void bdrv_attach_child_common_abort(void *opaque)
         tran_commit(tran);
     }
 
-    bdrv_unref(bs);
+    bdrv_schedule_unref(bs);
     bdrv_child_free(s->child);
 }
 
@@ -2996,6 +2997,9 @@ static TransactionActionDrv bdrv_attach_child_common_drv = {
  *
  * Function doesn't update permissions, caller is responsible for this.
  *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
+ *
  * Returns new created child.
  *
  * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
@@ -3112,6 +3116,9 @@ bdrv_attach_child_common(BlockDriverState *child_bs,
  * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
  * @child_bs can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
  */
 static BdrvChild * GRAPH_WRLOCK
 bdrv_attach_child_noperm(BlockDriverState *parent_bs,
@@ -3178,8 +3185,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     ret = bdrv_refresh_perms(child_bs, tran, errp);
 
 out:
-    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
+    bdrv_graph_wrunlock();
 
     bdrv_unref(child_bs);
 
@@ -3225,8 +3232,8 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     }
 
 out:
-    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
+    bdrv_graph_wrunlock();
 
     bdrv_unref(child_bs);
 
@@ -3391,6 +3398,9 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
  * @child_bs can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
  */
 static int GRAPH_WRLOCK
 bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
@@ -3486,6 +3496,9 @@ out:
  *
  * If a backing child is already present (i.e. we're detaching a node), that
  * child node must be drained.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
  */
 static int GRAPH_WRLOCK
 bdrv_set_backing_noperm(BlockDriverState *bs,
@@ -3517,8 +3530,8 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
 
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
-    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
+    bdrv_graph_wrunlock();
     return ret;
 }
 
@@ -4592,7 +4605,9 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         aio_context_release(ctx);
     }
 
+    bdrv_graph_wrlock(NULL);
     tran_commit(tran);
+    bdrv_graph_wrunlock();
 
     QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         BlockDriverState *bs = bs_entry->state.bs;
@@ -4609,7 +4624,9 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
     goto cleanup;
 
 abort:
+    bdrv_graph_wrlock(NULL);
     tran_abort(tran);
+    bdrv_graph_wrunlock();
 
     QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (bs_entry->prepared) {
@@ -4676,6 +4693,9 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
  * true and reopen_state->new_backing_bs contains a pointer to the new
  * backing BlockDriverState (or NULL).
  *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
+ *
  * Return 0 on success, otherwise return < 0 and set @errp.
  *
  * The caller must hold the AioContext lock of @reopen_state->bs.
@@ -4809,6 +4829,9 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
  * commit() for any other BDS that have been left in a prepare() state
  *
  * The caller must hold the AioContext lock of @reopen_state->bs.
+ *
+ * After calling this function, the transaction @change_child_tran may only be
+ * completed while holding a writer lock for the graph.
  */
 static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
                                BlockReopenQueue *queue,
@@ -5260,6 +5283,9 @@ static TransactionActionDrv bdrv_remove_child_drv = {
  * Function doesn't update permissions, caller is responsible for this.
  *
  * @child->bs (if non-NULL) must be drained.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
  */
 static void GRAPH_WRLOCK bdrv_remove_child(BdrvChild *child, Transaction *tran)
 {
@@ -5278,6 +5304,9 @@ static void GRAPH_WRLOCK bdrv_remove_child(BdrvChild *child, Transaction *tran)
 /*
  * Both @from and @to (if non-NULL) must be drained. @to must be kept drained
  * until the transaction is completed.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a writer lock for the graph.
  */
 static int GRAPH_WRLOCK
 bdrv_replace_node_noperm(BlockDriverState *from,
@@ -5384,8 +5413,8 @@ static int bdrv_replace_node_common(BlockDriverState *from,
     ret = 0;
 
 out:
-    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
+    bdrv_graph_wrunlock();
 
     bdrv_drained_end(to);
     bdrv_drained_end(from);
@@ -5481,12 +5510,10 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
 
     ret = bdrv_refresh_perms(bs_new, tran, errp);
 out:
-    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
 
-    bdrv_graph_rdlock_main_loop();
     bdrv_refresh_limits(bs_top, NULL, NULL);
-    bdrv_graph_rdunlock_main_loop();
+    bdrv_graph_wrunlock();
 
     bdrv_drained_end(bs_top);
     bdrv_drained_end(bs_new);
@@ -5521,10 +5548,10 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
     refresh_list = g_slist_prepend(refresh_list, new_bs);
 
     ret = bdrv_list_refresh_perms(refresh_list, NULL, tran, errp);
-    bdrv_graph_wrunlock();
 
     tran_finalize(tran, ret);
 
+    bdrv_graph_wrunlock();
     bdrv_drained_end(old_bs);
     bdrv_drained_end(new_bs);
     bdrv_unref(old_bs);
-- 
2.41.0


