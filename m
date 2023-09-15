Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D297A215D
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3X-0000Vx-Jm; Fri, 15 Sep 2023 10:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3L-0000G4-2d
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3I-00054x-65
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0Xa26wXIDQwwBrbHic4lRt1xh2ltuJoKQ7poyvx110=;
 b=YpfbpfUXM7G+BwZKb78StQmj0qakY/ieEbZzcVKsogxEj/g7jsp+1XquIfMOV3p7iLJHDM
 CmpnC5a/s30sU4z+6o+9Z8EJinwZy69+7k+CJO92NCupTARs9kt7iZhTXhIsb7dy3b7QAM
 p7ANNwjpd2mzu64rwq4hxneQ4Cbrank=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-52-7bEJm4MBNT2wa0pHkyHscQ-1; Fri, 15 Sep 2023 10:44:09 -0400
X-MC-Unique: 7bEJm4MBNT2wa0pHkyHscQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0DE980D2A6;
 Fri, 15 Sep 2023 14:44:08 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E77A2026D4B;
 Fri, 15 Sep 2023 14:44:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 24/28] block: remove AIOCBInfo->get_aio_context()
Date: Fri, 15 Sep 2023 16:43:40 +0200
Message-ID: <20230915144344.238596-25-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The synchronous bdrv_aio_cancel() function needs the acb's AioContext so
it can call aio_poll() to wait for cancellation.

It turns out that all users run under the BQL in the main AioContext, so
this callback is not needed.

Remove the callback, mark bdrv_aio_cancel() GLOBAL_STATE_CODE just like
its blk_aio_cancel() caller, and poll the main loop AioContext.

The purpose of this cleanup is to identify bdrv_aio_cancel() as an API
that does not work with the multi-queue block layer.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230912231037.826804-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio.h                |  1 -
 include/block/block-global-state.h |  2 ++
 include/block/block-io.h           |  1 -
 block/block-backend.c              | 17 -----------------
 block/io.c                         | 23 ++++++++---------------
 hw/nvme/ctrl.c                     |  7 -------
 softmmu/dma-helpers.c              |  8 --------
 util/thread-pool.c                 |  8 --------
 8 files changed, 10 insertions(+), 57 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index 32042e8905..bcc165c974 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -31,7 +31,6 @@ typedef void BlockCompletionFunc(void *opaque, int ret);
 
 typedef struct AIOCBInfo {
     void (*cancel_async)(BlockAIOCB *acb);
-    AioContext *(*get_aio_context)(BlockAIOCB *acb);
     size_t aiocb_size;
 } AIOCBInfo;
 
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index f31660c7b1..6061220a6c 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -185,6 +185,8 @@ void bdrv_drain_all_begin_nopoll(void);
 void bdrv_drain_all_end(void);
 void bdrv_drain_all(void);
 
+void bdrv_aio_cancel(BlockAIOCB *acb);
+
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int bdrv_has_zero_init(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
diff --git a/include/block/block-io.h b/include/block/block-io.h
index 6db48f2d35..f1c796a1ce 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -101,7 +101,6 @@ bdrv_co_delete_file_noerr(BlockDriverState *bs);
 
 
 /* async block I/O */
-void bdrv_aio_cancel(BlockAIOCB *acb);
 void bdrv_aio_cancel_async(BlockAIOCB *acb);
 
 /* sg packet commands */
diff --git a/block/block-backend.c b/block/block-backend.c
index c2636f4351..24b9449712 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -33,8 +33,6 @@
 
 #define NOT_DONE 0x7fffffff /* used while emulated sync operation in progress */
 
-static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb);
-
 typedef struct BlockBackendAioNotifier {
     void (*attached_aio_context)(AioContext *new_context, void *opaque);
     void (*detach_aio_context)(void *opaque);
@@ -103,7 +101,6 @@ typedef struct BlockBackendAIOCB {
 } BlockBackendAIOCB;
 
 static const AIOCBInfo block_backend_aiocb_info = {
-    .get_aio_context = blk_aiocb_get_aio_context,
     .aiocb_size = sizeof(BlockBackendAIOCB),
 };
 
@@ -1562,16 +1559,8 @@ typedef struct BlkAioEmAIOCB {
     bool has_returned;
 } BlkAioEmAIOCB;
 
-static AioContext *blk_aio_em_aiocb_get_aio_context(BlockAIOCB *acb_)
-{
-    BlkAioEmAIOCB *acb = container_of(acb_, BlkAioEmAIOCB, common);
-
-    return blk_get_aio_context(acb->rwco.blk);
-}
-
 static const AIOCBInfo blk_aio_em_aiocb_info = {
     .aiocb_size         = sizeof(BlkAioEmAIOCB),
-    .get_aio_context    = blk_aio_em_aiocb_get_aio_context,
 };
 
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
@@ -2451,12 +2440,6 @@ AioContext *blk_get_aio_context(BlockBackend *blk)
     return blk->ctx;
 }
 
-static AioContext *blk_aiocb_get_aio_context(BlockAIOCB *acb)
-{
-    BlockBackendAIOCB *blk_acb = DO_UPCAST(BlockBackendAIOCB, common, acb);
-    return blk_get_aio_context(blk_acb->blk);
-}
-
 int blk_set_aio_context(BlockBackend *blk, AioContext *new_context,
                         Error **errp)
 {
diff --git a/block/io.c b/block/io.c
index ba23a9bcd3..209a6da0c8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2950,25 +2950,18 @@ int bdrv_load_vmstate(BlockDriverState *bs, uint8_t *buf,
 /**************************************************************/
 /* async I/Os */
 
+/**
+ * Synchronously cancels an acb. Must be called with the BQL held and the acb
+ * must be processed with the BQL held too (IOThreads are not allowed).
+ *
+ * Use bdrv_aio_cancel_async() instead when possible.
+ */
 void bdrv_aio_cancel(BlockAIOCB *acb)
 {
-    IO_CODE();
+    GLOBAL_STATE_CODE();
     qemu_aio_ref(acb);
     bdrv_aio_cancel_async(acb);
-    while (acb->refcnt > 1) {
-        if (acb->aiocb_info->get_aio_context) {
-            aio_poll(acb->aiocb_info->get_aio_context(acb), true);
-        } else if (acb->bs) {
-            /* qemu_aio_ref and qemu_aio_unref are not thread-safe, so
-             * assert that we're not using an I/O thread.  Thread-safe
-             * code should use bdrv_aio_cancel_async exclusively.
-             */
-            assert(bdrv_get_aio_context(acb->bs) == qemu_get_aio_context());
-            aio_poll(bdrv_get_aio_context(acb->bs), true);
-        } else {
-            abort();
-        }
-    }
+    AIO_WAIT_WHILE_UNLOCKED(NULL, acb->refcnt > 1);
     qemu_aio_unref(acb);
 }
 
diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 90687b168a..03265359ff 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2130,11 +2130,6 @@ static inline bool nvme_is_write(NvmeRequest *req)
            rw->opcode == NVME_CMD_WRITE_ZEROES;
 }
 
-static AioContext *nvme_get_aio_context(BlockAIOCB *acb)
-{
-    return qemu_get_aio_context();
-}
-
 static void nvme_misc_cb(void *opaque, int ret)
 {
     NvmeRequest *req = opaque;
@@ -3302,7 +3297,6 @@ static void nvme_flush_cancel(BlockAIOCB *acb)
 static const AIOCBInfo nvme_flush_aiocb_info = {
     .aiocb_size = sizeof(NvmeFlushAIOCB),
     .cancel_async = nvme_flush_cancel,
-    .get_aio_context = nvme_get_aio_context,
 };
 
 static void nvme_do_flush(NvmeFlushAIOCB *iocb);
@@ -6478,7 +6472,6 @@ static void nvme_format_cancel(BlockAIOCB *aiocb)
 static const AIOCBInfo nvme_format_aiocb_info = {
     .aiocb_size = sizeof(NvmeFormatAIOCB),
     .cancel_async = nvme_format_cancel,
-    .get_aio_context = nvme_get_aio_context,
 };
 
 static void nvme_format_set(NvmeNamespace *ns, uint8_t lbaf, uint8_t mset,
diff --git a/softmmu/dma-helpers.c b/softmmu/dma-helpers.c
index 2463964805..36211acc7e 100644
--- a/softmmu/dma-helpers.c
+++ b/softmmu/dma-helpers.c
@@ -206,17 +206,9 @@ static void dma_aio_cancel(BlockAIOCB *acb)
     }
 }
 
-static AioContext *dma_get_aio_context(BlockAIOCB *acb)
-{
-    DMAAIOCB *dbs = container_of(acb, DMAAIOCB, common);
-
-    return dbs->ctx;
-}
-
 static const AIOCBInfo dma_aiocb_info = {
     .aiocb_size         = sizeof(DMAAIOCB),
     .cancel_async       = dma_aio_cancel,
-    .get_aio_context    = dma_get_aio_context,
 };
 
 BlockAIOCB *dma_blk_io(AioContext *ctx,
diff --git a/util/thread-pool.c b/util/thread-pool.c
index e3d8292d14..22f9ba3286 100644
--- a/util/thread-pool.c
+++ b/util/thread-pool.c
@@ -228,17 +228,9 @@ static void thread_pool_cancel(BlockAIOCB *acb)
 
 }
 
-static AioContext *thread_pool_get_aio_context(BlockAIOCB *acb)
-{
-    ThreadPoolElement *elem = (ThreadPoolElement *)acb;
-    ThreadPool *pool = elem->pool;
-    return pool->ctx;
-}
-
 static const AIOCBInfo thread_pool_aiocb_info = {
     .aiocb_size         = sizeof(ThreadPoolElement),
     .cancel_async       = thread_pool_cancel,
-    .get_aio_context    = thread_pool_get_aio_context,
 };
 
 BlockAIOCB *thread_pool_submit_aio(ThreadPoolFunc *func, void *arg,
-- 
2.41.0


