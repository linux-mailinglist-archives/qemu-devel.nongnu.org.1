Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0DE7E4898
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:47:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R69-0004HB-J4; Tue, 07 Nov 2023 13:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5f-0003vJ-IR
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5b-0001TP-Pd
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tsO1hoc8KHZp/hJdF9DKjncWu0YA2pJ95srb5fxo7iQ=;
 b=gpTuPubOeP0HuNQVcSYM9sVJrsixdnh4hegsKRld18Z4UOjArjZQNXVHQLhXx6PdV2aVGr
 TXaHCCcdbbqUqlflKepBhTkKNp9R1fMh0tcihGXx8wETPkmmNviDvFWCZYenwzrJjXdIAg
 Mz7CzxrcZ94xwOB7t5sdnGsdFcPQfAI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-HMXChmdxPUC6NKe4COhifQ-1; Tue,
 07 Nov 2023 13:46:09 -0500
X-MC-Unique: HMXChmdxPUC6NKe4COhifQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D68738143AC
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD761C1596F;
 Tue,  7 Nov 2023 18:46:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 02/25] block: Mark bdrv_has_zero_init() and callers GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:42 +0100
Message-ID: <20231107184605.236540-3-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
bdrv_has_zero_init() need to hold a reader lock for the graph because
it calls bdrv_filter_bs(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-3-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  2 +-
 include/block/block_int-common.h   |  2 +-
 block.c                            |  2 +-
 block/qcow2.c                      |  3 ++-
 block/raw-format.c                 |  2 +-
 block/vdi.c                        |  2 +-
 block/vhdx.c                       | 13 +++++++++----
 block/vmdk.c                       |  2 +-
 block/vpc.c                        |  2 +-
 blockdev.c                         |  2 ++
 qemu-img.c                         |  2 ++
 11 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index fca0a40dbd..3ae468ea15 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -189,7 +189,7 @@ void bdrv_drain_all(void);
 void bdrv_aio_cancel(BlockAIOCB *acb);
 
 int bdrv_has_zero_init_1(BlockDriverState *bs);
-int bdrv_has_zero_init(BlockDriverState *bs);
+int coroutine_mixed_fn GRAPH_RDLOCK bdrv_has_zero_init(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat, Error **errp);
 XDbgBlockGraph * GRAPH_RDLOCK bdrv_get_xdbg_block_graph(Error **errp);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 8abdd2724b..c0db862de7 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -349,7 +349,7 @@ struct BlockDriver {
      * Returns 1 if newly created images are guaranteed to contain only
      * zeros, 0 otherwise.
      */
-    int (*bdrv_has_zero_init)(BlockDriverState *bs);
+    int GRAPH_RDLOCK_PTR (*bdrv_has_zero_init)(BlockDriverState *bs);
 
     /*
      * Remove fd handlers, timers, and other event loop callbacks so the event
diff --git a/block.c b/block.c
index a527aa1a4c..1171f47570 100644
--- a/block.c
+++ b/block.c
@@ -6587,7 +6587,7 @@ int bdrv_has_zero_init_1(BlockDriverState *bs)
     return 1;
 }
 
-int bdrv_has_zero_init(BlockDriverState *bs)
+int coroutine_mixed_fn bdrv_has_zero_init(BlockDriverState *bs)
 {
     BlockDriverState *filtered;
     GLOBAL_STATE_CODE();
diff --git a/block/qcow2.c b/block/qcow2.c
index aa01d9e7b5..a1443a31aa 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5302,7 +5302,8 @@ static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
     return spec_info;
 }
 
-static int coroutine_mixed_fn qcow2_has_zero_init(BlockDriverState *bs)
+static int coroutine_mixed_fn GRAPH_RDLOCK
+qcow2_has_zero_init(BlockDriverState *bs)
 {
     BDRVQcow2State *s = bs->opaque;
     bool preallocated;
diff --git a/block/raw-format.c b/block/raw-format.c
index 3fb77b0097..8ca74c1cf3 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -452,7 +452,7 @@ raw_co_ioctl(BlockDriverState *bs, unsigned long int req, void *buf)
     return bdrv_co_ioctl(bs->file->bs, req, buf);
 }
 
-static int raw_has_zero_init(BlockDriverState *bs)
+static int GRAPH_RDLOCK raw_has_zero_init(BlockDriverState *bs)
 {
     return bdrv_has_zero_init(bs->file->bs);
 }
diff --git a/block/vdi.c b/block/vdi.c
index 7cfd12b50d..8e144ce523 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -990,7 +990,7 @@ static void vdi_close(BlockDriverState *bs)
     migrate_del_blocker(&s->migration_blocker);
 }
 
-static int vdi_has_zero_init(BlockDriverState *bs)
+static int GRAPH_RDLOCK vdi_has_zero_init(BlockDriverState *bs)
 {
     BDRVVdiState *s = bs->opaque;
 
diff --git a/block/vhdx.c b/block/vhdx.c
index a9d08742f9..e136ba1ae1 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1695,7 +1695,7 @@ exit:
  *  Fixed images: default state of the BAT is fully populated, with
  *                file offsets and state PAYLOAD_BLOCK_FULLY_PRESENT.
  */
-static int coroutine_fn
+static int coroutine_fn GRAPH_UNLOCKED
 vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
                 uint64_t image_size, VHDXImageType type,
                 bool use_zero_blocks, uint64_t file_offset,
@@ -1708,6 +1708,7 @@ vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
     uint64_t unused;
     int block_state;
     VHDXSectorInfo sinfo;
+    bool has_zero_init;
 
     assert(s->bat == NULL);
 
@@ -1737,9 +1738,13 @@ vhdx_create_bat(BlockBackend *blk, BDRVVHDXState *s,
         goto exit;
     }
 
+    bdrv_graph_co_rdlock();
+    has_zero_init = bdrv_has_zero_init(blk_bs(blk));
+    bdrv_graph_co_rdunlock();
+
     if (type == VHDX_TYPE_FIXED ||
                 use_zero_blocks ||
-                bdrv_has_zero_init(blk_bs(blk)) == 0) {
+                has_zero_init == 0) {
         /* for a fixed file, the default BAT entry is not zero */
         s->bat = g_try_malloc0(length);
         if (length && s->bat == NULL) {
@@ -1782,7 +1787,7 @@ exit:
  * to create the BAT itself, we will also cause the BAT to be
  * created.
  */
-static int coroutine_fn
+static int coroutine_fn GRAPH_UNLOCKED
 vhdx_create_new_region_table(BlockBackend *blk, uint64_t image_size,
                              uint32_t block_size, uint32_t sector_size,
                              uint32_t log_size, bool use_zero_blocks,
@@ -2173,7 +2178,7 @@ static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
     return 0;
 }
 
-static int vhdx_has_zero_init(BlockDriverState *bs)
+static int GRAPH_RDLOCK vhdx_has_zero_init(BlockDriverState *bs)
 {
     BDRVVHDXState *s = bs->opaque;
     int state;
diff --git a/block/vmdk.c b/block/vmdk.c
index 85864b8045..91ed7a8d93 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2894,7 +2894,7 @@ vmdk_co_get_allocated_file_size(BlockDriverState *bs)
     return ret;
 }
 
-static int vmdk_has_zero_init(BlockDriverState *bs)
+static int GRAPH_RDLOCK vmdk_has_zero_init(BlockDriverState *bs)
 {
     int i;
     BDRVVmdkState *s = bs->opaque;
diff --git a/block/vpc.c b/block/vpc.c
index aa1a48ae0e..483775103c 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -1170,7 +1170,7 @@ fail:
 }
 
 
-static int vpc_has_zero_init(BlockDriverState *bs)
+static int GRAPH_RDLOCK vpc_has_zero_init(BlockDriverState *bs)
 {
     BDRVVPCState *s = bs->opaque;
 
diff --git a/blockdev.c b/blockdev.c
index e9b7e38dc4..148df99e00 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3156,9 +3156,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         return;
     }
 
+    bdrv_graph_rdlock_main_loop();
     zero_target = (arg->sync == MIRROR_SYNC_MODE_FULL &&
                    (arg->mode == NEW_IMAGE_MODE_EXISTING ||
                     !bdrv_has_zero_init(target_bs)));
+    bdrv_graph_rdunlock_main_loop();
 
 
     /* Honor bdrv_try_change_aio_context() context acquisition requirements. */
diff --git a/qemu-img.c b/qemu-img.c
index 369c2e8ddf..c061fd0634 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2099,7 +2099,9 @@ static int convert_do_copy(ImgConvertState *s)
     /* Check whether we have zero initialisation or can get it efficiently */
     if (!s->has_zero_init && s->target_is_new && s->min_sparse &&
         !s->target_has_backing) {
+        bdrv_graph_rdlock_main_loop();
         s->has_zero_init = bdrv_has_zero_init(blk_bs(s->target));
+        bdrv_graph_rdunlock_main_loop();
     }
 
     /* Allocate buffer for copied data. For compressed images, only one cluster
-- 
2.41.0


