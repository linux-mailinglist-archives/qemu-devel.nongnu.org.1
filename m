Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A5F7E4896
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:47:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R69-0004Fn-Jl; Tue, 07 Nov 2023 13:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5j-0003vb-7b
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0001Uw-31
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6sfjBtg43d8qTRgHVSUXIOWhcEaXJBXhjGAOPyBdwgo=;
 b=OnP4lVErIml7B1UOUopUBWVIQWAgkazxQTgJtj0lrfLh9+o0Tpt2H+25mGGMTllvaYfiOq
 rMADFYsziouMULkj+nSwzObnyauT+BgmGlc/IrS8sOM4GQspyOt14LOVo/4KuJsiVMBrOb
 5kjp5cbtAZSgduQjizrumGpkHItVVdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-IXIPfhyGOrGwN5MaOltwRg-1; Tue, 07 Nov 2023 13:46:17 -0500
X-MC-Unique: IXIPfhyGOrGwN5MaOltwRg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E428F834FC3
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B46EC1290F;
 Tue,  7 Nov 2023 18:46:16 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 12/25] block: Mark bdrv_cow_child() and callers GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:52 +0100
Message-ID: <20231107184605.236540-13-kwolf@redhat.com>
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
bdrv_cow_child() need to hold a reader lock for the graph because it
accesses bs->backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-13-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h |  5 +++--
 block/stream.c               |  2 +-
 qemu-img.c                   | 11 ++++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 17547a2dab..4a7cf2b4fd 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -130,14 +130,15 @@ bdrv_co_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 int co_wrapper_mixed_bdrv_rdlock
 bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 
-BdrvChild *bdrv_cow_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_filter_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_filter_or_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_skip_filters(BlockDriverState *bs);
 BlockDriverState * GRAPH_RDLOCK bdrv_backing_chain_next(BlockDriverState *bs);
 
-static inline BlockDriverState *bdrv_cow_bs(BlockDriverState *bs)
+static inline BlockDriverState * GRAPH_RDLOCK
+bdrv_cow_bs(BlockDriverState *bs)
 {
     IO_CODE();
     return child_bs(bdrv_cow_child(bs));
diff --git a/block/stream.c b/block/stream.c
index c32c98339a..3f5d773535 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -90,7 +90,7 @@ static int stream_prepare(Job *job)
     unfiltered_base = bdrv_skip_filters(base);
     bdrv_graph_rdunlock_main_loop();
 
-    if (bdrv_cow_child(unfiltered_bs)) {
+    if (unfiltered_bs_cow) {
         const char *base_id = NULL, *base_fmt = NULL;
         if (unfiltered_base) {
             base_id = s->backing_file_str ?: unfiltered_base->filename;
diff --git a/qemu-img.c b/qemu-img.c
index 33f3ab5fba..5a77f67719 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3541,7 +3541,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_old = NULL;
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
-    BlockDriverState *unfiltered_bs;
+    BlockDriverState *unfiltered_bs, *unfiltered_bs_cow;
     BlockDriverInfo bdi = {0};
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
@@ -3675,6 +3675,7 @@ static int img_rebase(int argc, char **argv)
 
     bdrv_graph_rdlock_main_loop();
     unfiltered_bs = bdrv_skip_filters(bs);
+    unfiltered_bs_cow = bdrv_cow_bs(unfiltered_bs);
     bdrv_graph_rdunlock_main_loop();
 
     if (compress && !block_driver_can_compress(unfiltered_bs->drv)) {
@@ -3710,7 +3711,11 @@ static int img_rebase(int argc, char **argv)
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
-        BlockDriverState *base_bs = bdrv_cow_bs(unfiltered_bs);
+        BlockDriverState *base_bs;
+
+        bdrv_graph_rdlock_main_loop();
+        base_bs = bdrv_cow_bs(unfiltered_bs);
+        bdrv_graph_rdunlock_main_loop();
 
         if (base_bs) {
             blk_old_backing = blk_new(qemu_get_aio_context(),
@@ -3876,7 +3881,7 @@ static int img_rebase(int argc, char **argv)
                  * If cluster wasn't changed since prefix_chain, we don't need
                  * to take action
                  */
-                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                ret = bdrv_is_allocated_above(unfiltered_bs_cow,
                                               prefix_chain_bs, false,
                                               offset, n, &n);
                 if (ret < 0) {
-- 
2.41.0


