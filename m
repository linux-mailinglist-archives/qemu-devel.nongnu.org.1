Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DEC7D9D88
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAB-0003up-O2; Fri, 27 Oct 2023 11:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9z-0003aV-QW
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9w-0002nq-57
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y06hjOIaF//T00YKjclIkGs0hl2F8sNFdUr6SPtDbiU=;
 b=XjAm3C+qwfY/n0szLzoKANP57div5gcfLkdloSc3mm3ZOe1qo5O83GVzEAX6tYW1D//+dQ
 PBGgJ0rBOv/VDXlKWPcLj4CVxOzenaNcClhFQ0VlD7y7w3JksEwsOCbHeAvkoT5eMyu94w
 6/ulypVNijqEe3hD2JYb1JvcwYN4mSA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-qnuEtd7eMzqddXl-IODWtg-1; Fri, 27 Oct 2023 11:53:56 -0400
X-MC-Unique: qnuEtd7eMzqddXl-IODWtg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C21038021BE;
 Fri, 27 Oct 2023 15:53:55 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94D485027;
 Fri, 27 Oct 2023 15:53:54 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 10/24] block: Mark bdrv_chain_contains() and callers
 GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:19 +0200
Message-ID: <20231027155333.420094-11-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_chain_contains() need to hold a reader lock for the graph because
it calls bdrv_filter_or_cow_bs(), which accesses bs->file/backing.

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
index 0d9c821e66..368cec3747 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2441,11 +2441,12 @@ void qmp_block_stream(const char *job_id, const char *device,
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
@@ -2453,38 +2454,36 @@ void qmp_block_stream(const char *job_id, const char *device,
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
@@ -2492,14 +2491,12 @@ void qmp_block_stream(const char *job_id, const char *device,
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
@@ -2531,6 +2528,11 @@ void qmp_block_stream(const char *job_id, const char *device,
 
 out:
     aio_context_release(aio_context);
+    return;
+
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
+    aio_context_release(aio_context);
 }
 
 void qmp_block_commit(const char *job_id, const char *device,
@@ -3416,39 +3418,38 @@ void qmp_change_backing_file(const char *device,
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
@@ -3476,6 +3477,11 @@ void qmp_change_backing_file(const char *device,
 
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


