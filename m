Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEB37E48B2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:50:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6A-0004Ln-7t; Tue, 07 Nov 2023 13:46:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0003vS-SL
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5f-0001UH-Ab
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Drxgkp0ROJENIrnPXu5nTdA0hV4Rbo4Y1Phpl0DAVFc=;
 b=dbYk8n264owuIk/efYtGjuy+Lb4pV7VGICWkSoRxMK3nfPxYQeKP50XyGVqa27HiSst9w2
 uQg290Q5vci/7bsojgIT9+F0RX8a0K0nOLNi/Hsp0Af7biZmZHYjqz3Km0bToIECkDMaQl
 b5CdLONLKBmbIScUglcagdvLKo1hudU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-H-3So__5NB2fZkqyJMTt7g-1; Tue, 07 Nov 2023 13:46:15 -0500
X-MC-Unique: H-3So__5NB2fZkqyJMTt7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77F41101AA42
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 023D0C1290F;
 Tue,  7 Nov 2023 18:46:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 10/25] block: Mark bdrv_chain_contains() and callers
 GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:50 +0100
Message-ID: <20231107184605.236540-11-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_chain_contains() need to hold a reader lock for the graph because
it calls bdrv_filter_or_cow_bs(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-11-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  4 ++-
 block.c                            |  1 -
 block/block-copy.c                 |  2 ++
 blockdev.c                         | 48 +++++++++++++++++-------------
 4 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 545708c35a..9a33bd7ef9 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -199,7 +199,9 @@ XDbgBlockGraph * GRAPH_RDLOCK bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
                                  const char *node_name,
                                  Error **errp);
-bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
+bool GRAPH_RDLOCK
+bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base);
+
 BlockDriverState *bdrv_next_node(BlockDriverState *bs);
 BlockDriverState *bdrv_next_all_states(BlockDriverState *bs);
 
diff --git a/block.c b/block.c
index dc1980ee42..bb322df7d8 100644
--- a/block.c
+++ b/block.c
@@ -6524,7 +6524,6 @@ bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     while (top && top != base) {
         top = bdrv_filter_or_cow_bs(top);
diff --git a/block/block-copy.c b/block/block-copy.c
index 6b2be3d204..9ee3dd7ef5 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -399,7 +399,9 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
      * For more information see commit f8d59dfb40bb and test
      * tests/qemu-iotests/222
      */
+    bdrv_graph_rdlock_main_loop();
     is_fleecing = bdrv_chain_contains(target->bs, source->bs);
+    bdrv_graph_rdunlock_main_loop();
 
     s = g_new(BlockCopyState, 1);
     *s = (BlockCopyState) {
diff --git a/blockdev.c b/blockdev.c
index 5f15ea3b1d..f04faf6373 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2450,11 +2450,12 @@ void qmp_block_stream(const char *job_id, const char *device,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
+    bdrv_graph_rdlock_main_loop();
     if (base) {
         base_bs = bdrv_find_backing_image(bs, base);
         if (base_bs == NULL) {
             error_setg(errp, "Can't find '%s' in the backing chain", base);
-            goto out;
+            goto out_rdlock;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
     }
@@ -2462,38 +2463,36 @@ void qmp_block_stream(const char *job_id, const char *device,
     if (base_node) {
         base_bs = bdrv_lookup_bs(NULL, base_node, errp);
         if (!base_bs) {
-            goto out;
+            goto out_rdlock;
         }
         if (bs == base_bs || !bdrv_chain_contains(bs, base_bs)) {
             error_setg(errp, "Node '%s' is not a backing image of '%s'",
                        base_node, device);
-            goto out;
+            goto out_rdlock;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
 
-        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(base_bs);
-        bdrv_graph_rdunlock_main_loop();
     }
 
     if (bottom) {
         bottom_bs = bdrv_lookup_bs(NULL, bottom, errp);
         if (!bottom_bs) {
-            goto out;
+            goto out_rdlock;
         }
         if (!bottom_bs->drv) {
             error_setg(errp, "Node '%s' is not open", bottom);
-            goto out;
+            goto out_rdlock;
         }
         if (bottom_bs->drv->is_filter) {
             error_setg(errp, "Node '%s' is a filter, use a non-filter node "
                        "as 'bottom'", bottom);
-            goto out;
+            goto out_rdlock;
         }
         if (!bdrv_chain_contains(bs, bottom_bs)) {
             error_setg(errp, "Node '%s' is not in a chain starting from '%s'",
                        bottom, device);
-            goto out;
+            goto out_rdlock;
         }
         assert(bdrv_get_aio_context(bottom_bs) == aio_context);
     }
@@ -2501,14 +2500,12 @@ void qmp_block_stream(const char *job_id, const char *device,
     /*
      * Check for op blockers in the whole chain between bs and base (or bottom)
      */
-    bdrv_graph_rdlock_main_loop();
     iter_end = bottom ? bdrv_filter_or_cow_bs(bottom_bs) : base_bs;
     for (iter = bs; iter && iter != iter_end;
          iter = bdrv_filter_or_cow_bs(iter))
     {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
-            bdrv_graph_rdunlock_main_loop();
-            goto out;
+            goto out_rdlock;
         }
     }
     bdrv_graph_rdunlock_main_loop();
@@ -2540,6 +2537,11 @@ void qmp_block_stream(const char *job_id, const char *device,
 
 out:
     aio_context_release(aio_context);
+    return;
+
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
+    aio_context_release(aio_context);
 }
 
 void qmp_block_commit(const char *job_id, const char *device,
@@ -3439,39 +3441,38 @@ void qmp_change_backing_file(const char *device,
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
 
+    bdrv_graph_rdlock_main_loop();
+
     image_bs = bdrv_lookup_bs(NULL, image_node_name, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        goto out;
+        goto out_rdlock;
     }
 
     if (!image_bs) {
         error_setg(errp, "image file not found");
-        goto out;
+        goto out_rdlock;
     }
 
-    bdrv_graph_rdlock_main_loop();
     if (bdrv_find_base(image_bs) == image_bs) {
         error_setg(errp, "not allowing backing file change on an image "
                          "without a backing file");
-        bdrv_graph_rdunlock_main_loop();
-        goto out;
+        goto out_rdlock;
     }
 
     /* even though we are not necessarily operating on bs, we need it to
      * determine if block ops are currently prohibited on the chain */
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_CHANGE, errp)) {
-        bdrv_graph_rdunlock_main_loop();
-        goto out;
+        goto out_rdlock;
     }
-    bdrv_graph_rdunlock_main_loop();
 
     /* final sanity check */
     if (!bdrv_chain_contains(bs, image_bs)) {
         error_setg(errp, "'%s' and image file are not in the same chain",
                    device);
-        goto out;
+        goto out_rdlock;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     /* if not r/w, reopen to make r/w */
     ro = bdrv_is_read_only(image_bs);
@@ -3499,6 +3500,11 @@ void qmp_change_backing_file(const char *device,
 
 out:
     aio_context_release(aio_context);
+    return;
+
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
+    aio_context_release(aio_context);
 }
 
 void qmp_blockdev_add(BlockdevOptions *options, Error **errp)
-- 
2.41.0


