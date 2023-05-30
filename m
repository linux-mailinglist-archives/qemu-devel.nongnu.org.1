Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EAB7169AF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IG-0008MD-TL; Tue, 30 May 2023 12:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hf-0006ua-H9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hc-0008TD-Nh
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sM8CqCJfymg0LztUUAinTRoTzulNqxCG6biluR1gPT8=;
 b=CWR1HKsWXdOULtMf75LCOxIzw2A3VUU94L+Umq244mHV8zSm5pQeYmwEmsJifyGbtDwzPF
 bdvzhQqT03hefRzoaS9Av3kcpiGM0wSz7CgpdFYpMw1uMTDPUXGb6g8Lx14CETu6jahd9Y
 1UN0LSNAXp24kPFc7lsPUACX6ezuscs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-eSBDAEjZNGC-hrRCvwfl-w-1; Tue, 30 May 2023 12:33:11 -0400
X-MC-Unique: eSBDAEjZNGC-hrRCvwfl-w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D06AE3C025C6;
 Tue, 30 May 2023 16:33:10 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 228C6C154D2;
 Tue, 30 May 2023 16:33:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 25/32] block/export: rewrite vduse-blk drain code
Date: Tue, 30 May 2023 18:32:32 +0200
Message-Id: <20230530163239.576632-26-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vduse_blk_detach_ctx() waits for in-flight requests using
AIO_WAIT_WHILE(). This is not allowed according to a comment in
bdrv_set_aio_context_commit():

  /*
   * Take the old AioContex when detaching it from bs.
   * At this point, new_context lock is already acquired, and we are now
   * also taking old_context. This is safe as long as bdrv_detach_aio_context
   * does not call AIO_POLL_WHILE().
   */

Use this opportunity to rewrite the drain code in vduse-blk:

- Use the BlockExport refcount so that vduse_blk_exp_delete() is only
  called when there are no more requests in flight.

- Implement .drained_poll() so in-flight request coroutines are stopped
  by the time .bdrv_detach_aio_context() is called.

- Remove AIO_WAIT_WHILE() from vduse_blk_detach_ctx() to solve the
  .bdrv_detach_aio_context() constraint violation. It's no longer
  needed due to the previous changes.

- Always handle the VDUSE file descriptor, even in drained sections. The
  VDUSE file descriptor doesn't submit I/O, so it's safe to handle it in
  drained sections. This ensures that the VDUSE kernel code gets a fast
  response.

- Suspend virtqueue fd handlers in .drained_begin() and resume them in
  .drained_end(). This eliminates the need for the
  aio_set_fd_handler(is_external=true) flag, which is being removed from
  QEMU.

This is a long list but splitting it into individual commits would
probably lead to git bisect failures - the changes are all related.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-14-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/vduse-blk.c | 132 +++++++++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 39 deletions(-)

diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index b53ef39da0..a25556fe04 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -31,7 +31,8 @@ typedef struct VduseBlkExport {
     VduseDev *dev;
     uint16_t num_queues;
     char *recon_file;
-    unsigned int inflight;
+    unsigned int inflight; /* atomic */
+    bool vqs_started;
 } VduseBlkExport;
 
 typedef struct VduseBlkReq {
@@ -41,13 +42,24 @@ typedef struct VduseBlkReq {
 
 static void vduse_blk_inflight_inc(VduseBlkExport *vblk_exp)
 {
-    vblk_exp->inflight++;
+    if (qatomic_fetch_inc(&vblk_exp->inflight) == 0) {
+        /* Prevent export from being deleted */
+        aio_context_acquire(vblk_exp->export.ctx);
+        blk_exp_ref(&vblk_exp->export);
+        aio_context_release(vblk_exp->export.ctx);
+    }
 }
 
 static void vduse_blk_inflight_dec(VduseBlkExport *vblk_exp)
 {
-    if (--vblk_exp->inflight == 0) {
+    if (qatomic_fetch_dec(&vblk_exp->inflight) == 1) {
+        /* Wake AIO_WAIT_WHILE() */
         aio_wait_kick();
+
+        /* Now the export can be deleted */
+        aio_context_acquire(vblk_exp->export.ctx);
+        blk_exp_unref(&vblk_exp->export);
+        aio_context_release(vblk_exp->export.ctx);
     }
 }
 
@@ -124,8 +136,12 @@ static void vduse_blk_enable_queue(VduseDev *dev, VduseVirtq *vq)
 {
     VduseBlkExport *vblk_exp = vduse_dev_get_priv(dev);
 
+    if (!vblk_exp->vqs_started) {
+        return; /* vduse_blk_drained_end() will start vqs later */
+    }
+
     aio_set_fd_handler(vblk_exp->export.ctx, vduse_queue_get_fd(vq),
-                       true, on_vduse_vq_kick, NULL, NULL, NULL, vq);
+                       false, on_vduse_vq_kick, NULL, NULL, NULL, vq);
     /* Make sure we don't miss any kick afer reconnecting */
     eventfd_write(vduse_queue_get_fd(vq), 1);
 }
@@ -133,9 +149,14 @@ static void vduse_blk_enable_queue(VduseDev *dev, VduseVirtq *vq)
 static void vduse_blk_disable_queue(VduseDev *dev, VduseVirtq *vq)
 {
     VduseBlkExport *vblk_exp = vduse_dev_get_priv(dev);
+    int fd = vduse_queue_get_fd(vq);
 
-    aio_set_fd_handler(vblk_exp->export.ctx, vduse_queue_get_fd(vq),
-                       true, NULL, NULL, NULL, NULL, NULL);
+    if (fd < 0) {
+        return;
+    }
+
+    aio_set_fd_handler(vblk_exp->export.ctx, fd, false,
+                       NULL, NULL, NULL, NULL, NULL);
 }
 
 static const VduseOps vduse_blk_ops = {
@@ -152,42 +173,19 @@ static void on_vduse_dev_kick(void *opaque)
 
 static void vduse_blk_attach_ctx(VduseBlkExport *vblk_exp, AioContext *ctx)
 {
-    int i;
-
     aio_set_fd_handler(vblk_exp->export.ctx, vduse_dev_get_fd(vblk_exp->dev),
-                       true, on_vduse_dev_kick, NULL, NULL, NULL,
+                       false, on_vduse_dev_kick, NULL, NULL, NULL,
                        vblk_exp->dev);
 
-    for (i = 0; i < vblk_exp->num_queues; i++) {
-        VduseVirtq *vq = vduse_dev_get_queue(vblk_exp->dev, i);
-        int fd = vduse_queue_get_fd(vq);
-
-        if (fd < 0) {
-            continue;
-        }
-        aio_set_fd_handler(vblk_exp->export.ctx, fd, true,
-                           on_vduse_vq_kick, NULL, NULL, NULL, vq);
-    }
+    /* Virtqueues are handled by vduse_blk_drained_end() */
 }
 
 static void vduse_blk_detach_ctx(VduseBlkExport *vblk_exp)
 {
-    int i;
-
-    for (i = 0; i < vblk_exp->num_queues; i++) {
-        VduseVirtq *vq = vduse_dev_get_queue(vblk_exp->dev, i);
-        int fd = vduse_queue_get_fd(vq);
-
-        if (fd < 0) {
-            continue;
-        }
-        aio_set_fd_handler(vblk_exp->export.ctx, fd,
-                           true, NULL, NULL, NULL, NULL, NULL);
-    }
     aio_set_fd_handler(vblk_exp->export.ctx, vduse_dev_get_fd(vblk_exp->dev),
-                       true, NULL, NULL, NULL, NULL, NULL);
+                       false, NULL, NULL, NULL, NULL, NULL);
 
-    AIO_WAIT_WHILE(vblk_exp->export.ctx, vblk_exp->inflight > 0);
+    /* Virtqueues are handled by vduse_blk_drained_begin() */
 }
 
 
@@ -220,8 +218,55 @@ static void vduse_blk_resize(void *opaque)
                             (char *)&config.capacity);
 }
 
+static void vduse_blk_stop_virtqueues(VduseBlkExport *vblk_exp)
+{
+    for (uint16_t i = 0; i < vblk_exp->num_queues; i++) {
+        VduseVirtq *vq = vduse_dev_get_queue(vblk_exp->dev, i);
+        vduse_blk_disable_queue(vblk_exp->dev, vq);
+    }
+
+    vblk_exp->vqs_started = false;
+}
+
+static void vduse_blk_start_virtqueues(VduseBlkExport *vblk_exp)
+{
+    vblk_exp->vqs_started = true;
+
+    for (uint16_t i = 0; i < vblk_exp->num_queues; i++) {
+        VduseVirtq *vq = vduse_dev_get_queue(vblk_exp->dev, i);
+        vduse_blk_enable_queue(vblk_exp->dev, vq);
+    }
+}
+
+static void vduse_blk_drained_begin(void *opaque)
+{
+    BlockExport *exp = opaque;
+    VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
+
+    vduse_blk_stop_virtqueues(vblk_exp);
+}
+
+static void vduse_blk_drained_end(void *opaque)
+{
+    BlockExport *exp = opaque;
+    VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
+
+    vduse_blk_start_virtqueues(vblk_exp);
+}
+
+static bool vduse_blk_drained_poll(void *opaque)
+{
+    BlockExport *exp = opaque;
+    VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
+
+    return qatomic_read(&vblk_exp->inflight) > 0;
+}
+
 static const BlockDevOps vduse_block_ops = {
-    .resize_cb = vduse_blk_resize,
+    .resize_cb     = vduse_blk_resize,
+    .drained_begin = vduse_blk_drained_begin,
+    .drained_end   = vduse_blk_drained_end,
+    .drained_poll  = vduse_blk_drained_poll,
 };
 
 static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
@@ -268,6 +313,7 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
     vblk_exp->handler.serial = g_strdup(vblk_opts->serial ?: "");
     vblk_exp->handler.logical_block_size = logical_block_size;
     vblk_exp->handler.writable = opts->writable;
+    vblk_exp->vqs_started = true;
 
     config.capacity =
             cpu_to_le64(blk_getlength(exp->blk) >> VIRTIO_BLK_SECTOR_BITS);
@@ -322,14 +368,20 @@ static int vduse_blk_exp_create(BlockExport *exp, BlockExportOptions *opts,
         vduse_dev_setup_queue(vblk_exp->dev, i, queue_size);
     }
 
-    aio_set_fd_handler(exp->ctx, vduse_dev_get_fd(vblk_exp->dev), true,
+    aio_set_fd_handler(exp->ctx, vduse_dev_get_fd(vblk_exp->dev), false,
                        on_vduse_dev_kick, NULL, NULL, NULL, vblk_exp->dev);
 
     blk_add_aio_context_notifier(exp->blk, blk_aio_attached, blk_aio_detach,
                                  vblk_exp);
-
     blk_set_dev_ops(exp->blk, &vduse_block_ops, exp);
 
+    /*
+     * We handle draining ourselves using an in-flight counter and by disabling
+     * virtqueue fd handlers. Do not queue BlockBackend requests, they need to
+     * complete so the in-flight counter reaches zero.
+     */
+    blk_set_disable_request_queuing(exp->blk, true);
+
     return 0;
 err:
     vduse_dev_destroy(vblk_exp->dev);
@@ -344,6 +396,9 @@ static void vduse_blk_exp_delete(BlockExport *exp)
     VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
     int ret;
 
+    assert(qatomic_read(&vblk_exp->inflight) == 0);
+
+    vduse_blk_detach_ctx(vblk_exp);
     blk_remove_aio_context_notifier(exp->blk, blk_aio_attached, blk_aio_detach,
                                     vblk_exp);
     ret = vduse_dev_destroy(vblk_exp->dev);
@@ -354,13 +409,12 @@ static void vduse_blk_exp_delete(BlockExport *exp)
     g_free(vblk_exp->handler.serial);
 }
 
+/* Called with exp->ctx acquired */
 static void vduse_blk_exp_request_shutdown(BlockExport *exp)
 {
     VduseBlkExport *vblk_exp = container_of(exp, VduseBlkExport, export);
 
-    aio_context_acquire(vblk_exp->export.ctx);
-    vduse_blk_detach_ctx(vblk_exp);
-    aio_context_acquire(vblk_exp->export.ctx);
+    vduse_blk_stop_virtqueues(vblk_exp);
 }
 
 const BlockExportDriver blk_exp_vduse_blk = {
-- 
2.40.1


