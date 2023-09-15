Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E60037A2157
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3C-00006t-A4; Fri, 15 Sep 2023 10:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA35-0008TD-IF
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA33-0004un-Ss
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kRbpuCOqsxQKNFqf6K3F7V12WNJmJ0ub8QxsgU1lUVc=;
 b=S2Ff9EOzxVOng4ma97JpBdcsuhP/aRRcpyEU4Jkigtm2sl/ffnHp5H8+IqjJmiwKDUsa1J
 wXvALu5kdkRpFiZzSjHZcKe2dK6ms7O0fIIZNxJGRXr6DyeHqLMPEU6xEuqL6frPU1QVoE
 VTKy3772Lrpfo2oT23w82iFZtx6ZTyw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-niMny_rzMAehnxqZcStpBg-1; Fri, 15 Sep 2023 10:43:55 -0400
X-MC-Unique: niMny_rzMAehnxqZcStpBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C001185A790;
 Fri, 15 Sep 2023 14:43:55 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD9742026D4B;
 Fri, 15 Sep 2023 14:43:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/28] block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
Date: Fri, 15 Sep 2023 16:43:24 +0200
Message-ID: <20230915144344.238596-9-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
hold it when calling bdrv_replace_child_noperm(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-9-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index c8ac7cfac4..61856f5c33 100644
--- a/block.c
+++ b/block.c
@@ -91,8 +91,9 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 static bool bdrv_recurse_has_child(BlockDriverState *bs,
                                    BlockDriverState *child);
 
-static void bdrv_replace_child_noperm(BdrvChild *child,
-                                      BlockDriverState *new_bs);
+static void GRAPH_WRLOCK
+bdrv_replace_child_noperm(BdrvChild *child, BlockDriverState *new_bs);
+
 static void bdrv_remove_child(BdrvChild *child, Transaction *tran);
 
 static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
@@ -2387,6 +2388,8 @@ static void bdrv_replace_child_abort(void *opaque)
     BlockDriverState *new_bs = s->child->bs;
 
     GLOBAL_STATE_CODE();
+    bdrv_graph_wrlock(s->old_bs);
+
     /* old_bs reference is transparently moved from @s to @s->child */
     if (!s->child->bs) {
         /*
@@ -2403,6 +2406,8 @@ static void bdrv_replace_child_abort(void *opaque)
     }
     assert(s->child->quiesced_parent);
     bdrv_replace_child_noperm(s->child, s->old_bs);
+
+    bdrv_graph_wrunlock();
     bdrv_unref(new_bs);
 }
 
@@ -2439,7 +2444,10 @@ static void bdrv_replace_child_tran(BdrvChild *child, BlockDriverState *new_bs,
     if (new_bs) {
         bdrv_ref(new_bs);
     }
+
+    bdrv_graph_wrlock(new_bs);
     bdrv_replace_child_noperm(child, new_bs);
+    bdrv_graph_wrunlock();
     /* old_bs reference is transparently moved from @child to @s */
 }
 
@@ -2858,8 +2866,8 @@ uint64_t bdrv_qapi_perm_to_blk_perm(BlockPermission qapi_perm)
  * If @new_bs is non-NULL, the parent of @child must already be drained through
  * @child and the caller must hold the AioContext lock for @new_bs.
  */
-static void bdrv_replace_child_noperm(BdrvChild *child,
-                                      BlockDriverState *new_bs)
+static void GRAPH_WRLOCK
+bdrv_replace_child_noperm(BdrvChild *child, BlockDriverState *new_bs)
 {
     BlockDriverState *old_bs = child->bs;
     int new_bs_quiesce_counter;
@@ -2894,8 +2902,6 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
 
-    /* TODO Pull this up into the callers to avoid polling here */
-    bdrv_graph_wrlock(new_bs);
     if (old_bs) {
         if (child->klass->detach) {
             child->klass->detach(child);
@@ -2911,7 +2917,6 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
             child->klass->attach(child);
         }
     }
-    bdrv_graph_wrunlock();
 
     /*
      * If the parent was drained through this BdrvChild previously, but new_bs
@@ -2952,7 +2957,10 @@ static void bdrv_attach_child_common_abort(void *opaque)
     BlockDriverState *bs = s->child->bs;
 
     GLOBAL_STATE_CODE();
+
+    bdrv_graph_wrlock(NULL);
     bdrv_replace_child_noperm(s->child, NULL);
+    bdrv_graph_wrunlock();
 
     if (bdrv_get_aio_context(bs) != s->old_child_ctx) {
         bdrv_try_change_aio_context(bs, s->old_child_ctx, NULL, &error_abort);
@@ -3080,8 +3088,10 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
      * a problem, we already did this), but it will still poll until the parent
      * is fully quiesced, so it will not be negatively affected either.
      */
+    bdrv_graph_wrlock(child_bs);
     bdrv_parent_drained_begin_single(new_child);
     bdrv_replace_child_noperm(new_child, child_bs);
+    bdrv_graph_wrunlock();
 
     BdrvAttachChildCommonState *s = g_new(BdrvAttachChildCommonState, 1);
     *s = (BdrvAttachChildCommonState) {
@@ -3225,7 +3235,9 @@ void bdrv_root_unref_child(BdrvChild *child)
     BlockDriverState *child_bs = child->bs;
 
     GLOBAL_STATE_CODE();
+    bdrv_graph_wrlock(NULL);
     bdrv_replace_child_noperm(child, NULL);
+    bdrv_graph_wrunlock();
     bdrv_child_free(child);
 
     if (child_bs) {
-- 
2.41.0


