Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A479A6EA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVR-0005tQ-2Y; Mon, 11 Sep 2023 05:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVO-0005sv-CA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVL-0004hU-B7
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nMmOF+2KrBCM0S2W3HN4k7c0AIh1dUK+4JCs0+HVhIk=;
 b=bUUy54FZDXobmDYVkLfpXjPBWSxG0CQ+Ev/B7Nb26j9HxMjSttDNnlrpj1NjllJCoA6tlL
 V1xGG0ZhC4YjukXvJ19sl6fWWeXfdVswyZja1sqj2+KavF1xEHIr0e+0JppcMULsmvajF8
 f0biqR5sjRyT5CI/zRrT4NYA5RRYcSE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-1FGGAu5hOQiBexn4wvIDVA-1; Mon, 11 Sep 2023 05:46:46 -0400
X-MC-Unique: 1FGGAu5hOQiBexn4wvIDVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F2E1C11812;
 Mon, 11 Sep 2023 09:46:46 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0979340C6EBF;
 Mon, 11 Sep 2023 09:46:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 10/21] block: Mark bdrv_attach_child_common() GRAPH_WRLOCK
Date: Mon, 11 Sep 2023 11:46:09 +0200
Message-ID: <20230911094620.45040-11-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_attach_child_common(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

Note that the transaction callbacks still take the lock internally, so
tran_finalize() must be called without the lock held. This is because
bdrv_append() also calls bdrv_replace_node_noperm(), which currently
requires the transaction callbacks to be called unlocked. In the next
step, both of them can be switched to locked tran_finalize() calls
together.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block.c        | 133 +++++++++++++++++++++++++++++++------------------
 block/stream.c |  20 ++++++--
 2 files changed, 100 insertions(+), 53 deletions(-)

diff --git a/block.c b/block.c
index 0973b91d98..f6e7cf4fb9 100644
--- a/block.c
+++ b/block.c
@@ -3004,13 +3004,14 @@ static TransactionActionDrv bdrv_attach_child_common_drv = {
  * @child_bs can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
  */
-static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
-                                           const char *child_name,
-                                           const BdrvChildClass *child_class,
-                                           BdrvChildRole child_role,
-                                           uint64_t perm, uint64_t shared_perm,
-                                           void *opaque,
-                                           Transaction *tran, Error **errp)
+static BdrvChild * GRAPH_WRLOCK
+bdrv_attach_child_common(BlockDriverState *child_bs,
+                         const char *child_name,
+                         const BdrvChildClass *child_class,
+                         BdrvChildRole child_role,
+                         uint64_t perm, uint64_t shared_perm,
+                         void *opaque,
+                         Transaction *tran, Error **errp)
 {
     BdrvChild *new_child;
     AioContext *parent_ctx, *new_child_ctx;
@@ -3088,10 +3089,8 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
      * a problem, we already did this), but it will still poll until the parent
      * is fully quiesced, so it will not be negatively affected either.
      */
-    bdrv_graph_wrlock(child_bs);
     bdrv_parent_drained_begin_single(new_child);
     bdrv_replace_child_noperm(new_child, child_bs);
-    bdrv_graph_wrunlock();
 
     BdrvAttachChildCommonState *s = g_new(BdrvAttachChildCommonState, 1);
     *s = (BdrvAttachChildCommonState) {
@@ -3116,13 +3115,14 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
  * @child_bs can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
  */
-static BdrvChild *bdrv_attach_child_noperm(BlockDriverState *parent_bs,
-                                           BlockDriverState *child_bs,
-                                           const char *child_name,
-                                           const BdrvChildClass *child_class,
-                                           BdrvChildRole child_role,
-                                           Transaction *tran,
-                                           Error **errp)
+static BdrvChild * GRAPH_WRLOCK
+bdrv_attach_child_noperm(BlockDriverState *parent_bs,
+                         BlockDriverState *child_bs,
+                         const char *child_name,
+                         const BdrvChildClass *child_class,
+                         BdrvChildRole child_role,
+                         Transaction *tran,
+                         Error **errp)
 {
     uint64_t perm, shared_perm;
 
@@ -3167,6 +3167,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_wrlock(child_bs);
+
     child = bdrv_attach_child_common(child_bs, child_name, child_class,
                                    child_role, perm, shared_perm, opaque,
                                    tran, errp);
@@ -3178,6 +3180,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
     ret = bdrv_refresh_perms(child_bs, tran, errp);
 
 out:
+    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
 
     bdrv_unref(child_bs);
@@ -3209,6 +3212,8 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_wrlock(child_bs);
+
     child = bdrv_attach_child_noperm(parent_bs, child_bs, child_name,
                                      child_class, child_role, tran, errp);
     if (!child) {
@@ -3222,6 +3227,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
     }
 
 out:
+    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
 
     bdrv_unref(child_bs);
@@ -3379,16 +3385,20 @@ static BdrvChildRole bdrv_backing_role(BlockDriverState *bs)
  * Sets the bs->backing or bs->file link of a BDS. A new reference is created;
  * callers which don't need their own reference any more must call bdrv_unref().
  *
+ * If the respective child is already present (i.e. we're detaching a node),
+ * that child node must be drained.
+ *
  * Function doesn't update permissions, caller is responsible for this.
  *
  * The caller must hold the AioContext lock for @child_bs. Both @parent_bs and
  * @child_bs can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
  */
-static int bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
-                                           BlockDriverState *child_bs,
-                                           bool is_backing,
-                                           Transaction *tran, Error **errp)
+static int GRAPH_WRLOCK
+bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
+                                BlockDriverState *child_bs,
+                                bool is_backing,
+                                Transaction *tran, Error **errp)
 {
     bool update_inherits_from =
         bdrv_inherits_from_recursive(child_bs, parent_bs);
@@ -3439,14 +3449,9 @@ static int bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
     }
 
     if (child) {
-        bdrv_drained_begin(child->bs);
-        bdrv_graph_wrlock(NULL);
-
+        assert(child->bs->quiesce_counter);
         bdrv_unset_inherits_from(parent_bs, child, tran);
         bdrv_remove_child(child, tran);
-
-        bdrv_graph_wrunlock();
-        bdrv_drained_end(child->bs);
     }
 
     if (!child_bs) {
@@ -3471,9 +3476,7 @@ static int bdrv_set_file_or_backing_noperm(BlockDriverState *parent_bs,
     }
 
 out:
-    bdrv_graph_rdlock_main_loop();
     bdrv_refresh_limits(parent_bs, tran, NULL);
-    bdrv_graph_rdunlock_main_loop();
 
     return 0;
 }
@@ -3482,10 +3485,14 @@ out:
  * The caller must hold the AioContext lock for @backing_hd. Both @bs and
  * @backing_hd can move to a different AioContext in this function. Callers must
  * make sure that their AioContext locking is still correct after this.
+ *
+ * If a backing child is already present (i.e. we're detaching a node), that
+ * child node must be drained.
  */
-static int bdrv_set_backing_noperm(BlockDriverState *bs,
-                                   BlockDriverState *backing_hd,
-                                   Transaction *tran, Error **errp)
+static int GRAPH_WRLOCK
+bdrv_set_backing_noperm(BlockDriverState *bs,
+                        BlockDriverState *backing_hd,
+                        Transaction *tran, Error **errp)
 {
     GLOBAL_STATE_CODE();
     return bdrv_set_file_or_backing_noperm(bs, backing_hd, true, tran, errp);
@@ -3500,6 +3507,10 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
 
     GLOBAL_STATE_CODE();
     assert(bs->quiesce_counter > 0);
+    if (bs->backing) {
+        assert(bs->backing->bs->quiesce_counter > 0);
+    }
+    bdrv_graph_wrlock(backing_hd);
 
     ret = bdrv_set_backing_noperm(bs, backing_hd, tran, errp);
     if (ret < 0) {
@@ -3508,6 +3519,7 @@ int bdrv_set_backing_hd_drained(BlockDriverState *bs,
 
     ret = bdrv_refresh_perms(bs, tran, errp);
 out:
+    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
     return ret;
 }
@@ -3515,12 +3527,15 @@ out:
 int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                         Error **errp)
 {
+    BlockDriverState *drain_bs = bs->backing ? bs->backing->bs : bs;
     int ret;
     GLOBAL_STATE_CODE();
 
-    bdrv_drained_begin(bs);
+    bdrv_ref(drain_bs);
+    bdrv_drained_begin(drain_bs);
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
-    bdrv_drained_end(bs);
+    bdrv_drained_end(drain_bs);
+    bdrv_unref(drain_bs);
 
     return ret;
 }
@@ -4597,6 +4612,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 
 abort:
     tran_abort(tran);
+
     QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (bs_entry->prepared) {
             ctx = bdrv_get_aio_context(bs_entry->state.bs);
@@ -4746,6 +4762,11 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         reopen_state->old_file_bs = old_child_bs;
     }
 
+    if (old_child_bs) {
+        bdrv_ref(old_child_bs);
+        bdrv_drained_begin(old_child_bs);
+    }
+
     old_ctx = bdrv_get_aio_context(bs);
     ctx = bdrv_get_aio_context(new_child_bs);
     if (old_ctx != ctx) {
@@ -4753,14 +4774,23 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         aio_context_acquire(ctx);
     }
 
+    bdrv_graph_wrlock(new_child_bs);
+
     ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
                                           tran, errp);
 
+    bdrv_graph_wrunlock();
+
     if (old_ctx != ctx) {
         aio_context_release(ctx);
         aio_context_acquire(old_ctx);
     }
 
+    if (old_child_bs) {
+        bdrv_drained_end(old_child_bs);
+        bdrv_unref(old_child_bs);
+    }
+
     return ret;
 }
 
@@ -5403,13 +5433,28 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     BdrvChild *child;
     Transaction *tran = tran_new();
     AioContext *old_context, *new_context = NULL;
-    bool drained = false;
 
     GLOBAL_STATE_CODE();
 
     assert(!bs_new->backing);
 
     old_context = bdrv_get_aio_context(bs_top);
+    bdrv_drained_begin(bs_top);
+
+    /*
+     * bdrv_drained_begin() requires that only the AioContext of the drained
+     * node is locked, and at this point it can still differ from the AioContext
+     * of bs_top.
+     */
+    new_context = bdrv_get_aio_context(bs_new);
+    aio_context_release(old_context);
+    aio_context_acquire(new_context);
+    bdrv_drained_begin(bs_new);
+    aio_context_release(new_context);
+    aio_context_acquire(old_context);
+    new_context = NULL;
+
+    bdrv_graph_wrlock(bs_top);
 
     child = bdrv_attach_child_noperm(bs_new, bs_top, "backing",
                                      &child_of_bds, bdrv_backing_role(bs_new),
@@ -5420,10 +5465,9 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
     }
 
     /*
-     * bdrv_attach_child_noperm could change the AioContext of bs_top.
-     * bdrv_replace_node_noperm calls bdrv_drained_begin, so let's temporarily
-     * hold the new AioContext, since bdrv_drained_begin calls BDRV_POLL_WHILE
-     * that assumes the new lock is taken.
+     * bdrv_attach_child_noperm could change the AioContext of bs_top and
+     * bs_new, but at least they are in the same AioContext now. This is the
+     * AioContext that we need to lock for the rest of the function.
      */
     new_context = bdrv_get_aio_context(bs_top);
 
@@ -5432,29 +5476,22 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
         aio_context_acquire(new_context);
     }
 
-    bdrv_drained_begin(bs_new);
-    bdrv_drained_begin(bs_top);
-    drained = true;
-
-    bdrv_graph_wrlock(bs_new);
     ret = bdrv_replace_node_noperm(bs_top, bs_new, true, tran, errp);
-    bdrv_graph_wrunlock();
     if (ret < 0) {
         goto out;
     }
 
     ret = bdrv_refresh_perms(bs_new, tran, errp);
 out:
+    bdrv_graph_wrunlock();
     tran_finalize(tran, ret);
 
     bdrv_graph_rdlock_main_loop();
     bdrv_refresh_limits(bs_top, NULL, NULL);
     bdrv_graph_rdunlock_main_loop();
 
-    if (drained) {
-        bdrv_drained_end(bs_top);
-        bdrv_drained_end(bs_new);
-    }
+    bdrv_drained_end(bs_top);
+    bdrv_drained_end(bs_new);
 
     if (new_context && old_context != new_context) {
         aio_context_release(new_context);
diff --git a/block/stream.c b/block/stream.c
index e522bbdec5..e4da214f1f 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -54,6 +54,7 @@ static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
     BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
+    BlockDriverState *unfiltered_bs_cow = bdrv_cow_bs(unfiltered_bs);
     BlockDriverState *base;
     BlockDriverState *unfiltered_base;
     Error *local_err = NULL;
@@ -64,13 +65,18 @@ static int stream_prepare(Job *job)
     s->cor_filter_bs = NULL;
 
     /*
-     * bdrv_set_backing_hd() requires that unfiltered_bs is drained. Drain
-     * already here and use bdrv_set_backing_hd_drained() instead because
-     * the polling during drained_begin() might change the graph, and if we do
-     * this only later, we may end up working with the wrong base node (or it
-     * might even have gone away by the time we want to use it).
+     * bdrv_set_backing_hd() requires that the unfiltered_bs and the COW child
+     * of unfiltered_bs is drained. Drain already here and use
+     * bdrv_set_backing_hd_drained() instead because the polling during
+     * drained_begin() might change the graph, and if we do this only later, we
+     * may end up working with the wrong base node (or it might even have gone
+     * away by the time we want to use it).
      */
     bdrv_drained_begin(unfiltered_bs);
+    if (unfiltered_bs_cow) {
+        bdrv_ref(unfiltered_bs_cow);
+        bdrv_drained_begin(unfiltered_bs_cow);
+    }
 
     base = bdrv_filter_or_cow_bs(s->above_base);
     unfiltered_base = bdrv_skip_filters(base);
@@ -100,6 +106,10 @@ static int stream_prepare(Job *job)
     }
 
 out:
+    if (unfiltered_bs_cow) {
+        bdrv_drained_end(unfiltered_bs_cow);
+        bdrv_unref(unfiltered_bs_cow);
+    }
     bdrv_drained_end(unfiltered_bs);
     return ret;
 }
-- 
2.41.0


