Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AA832EB6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:15:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNM-0001jS-TZ; Fri, 19 Jan 2024 13:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNF-0001eM-O5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNA-0007eX-Jn
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nbl/qqCJEWa0LP2TGqKJo8vlByfV4ij/WjG/uLcE6Cc=;
 b=K8WW/pJ6nfizwfqfwgvFxH/j8Z0u4n4QBomCPfEinq6Ioy4400Wdc2550LMAmXq1rMPgzm
 Axd10NWPh4dDOoaPJTm1GQXujqmixg5BW1rbLNksMlo8EjULP1tj01nu/N+VKbhIWN8cn0
 Ma0bE/5U//KQnwwdOyZQ5ZuGcCvffJY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-zh1ObvJAMk2j-cXokxe19Q-1; Fri, 19 Jan 2024 13:13:41 -0500
X-MC-Unique: zh1ObvJAMk2j-cXokxe19Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88ABB185A784;
 Fri, 19 Jan 2024 18:13:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EEEF4494;
 Fri, 19 Jan 2024 18:13:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/14] virtio-blk: rename dataplane to ioeventfd
Date: Fri, 19 Jan 2024 19:13:23 +0100
Message-ID: <20240119181327.236745-11-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The dataplane code is really about using ioeventfd. It's used both for
IOThreads (what we think of as dataplane) and for the core virtio-pci
code's ioeventfd feature (which is enabled by default and used when no
IOThread has been specified). Rename the code to reflect this.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20240119135748.270944-4-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/virtio/virtio-blk.h |  8 ++--
 hw/block/virtio-blk.c          | 78 +++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index fecffdc303..833a9a344f 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -60,10 +60,10 @@ struct VirtIOBlock {
     unsigned short sector_mask;
     bool original_wce;
     VMChangeStateEntry *change;
-    bool dataplane_disabled;
-    bool dataplane_started;
-    bool dataplane_starting;
-    bool dataplane_stopping;
+    bool ioeventfd_disabled;
+    bool ioeventfd_started;
+    bool ioeventfd_starting;
+    bool ioeventfd_stopping;
 
     /*
      * The AioContext for each virtqueue. The BlockDriverState will use the
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 47494ebadd..e342cb2cfb 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -64,7 +64,7 @@ static void virtio_blk_req_complete(VirtIOBlockReq *req, unsigned char status)
     iov_discard_undo(&req->inhdr_undo);
     iov_discard_undo(&req->outhdr_undo);
     virtqueue_push(req->vq, &req->elem, req->in_len);
-    if (s->dataplane_started && !s->dataplane_disabled) {
+    if (s->ioeventfd_started && !s->ioeventfd_disabled) {
         virtio_notify_irqfd(vdev, req->vq);
     } else {
         virtio_notify(vdev, req->vq);
@@ -1141,12 +1141,12 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
 
-    if (!s->dataplane_disabled && !s->dataplane_started) {
+    if (!s->ioeventfd_disabled && !s->ioeventfd_started) {
         /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
-         * dataplane here instead of waiting for .set_status().
+         * ioeventfd here instead of waiting for .set_status().
          */
         virtio_device_start_ioeventfd(vdev);
-        if (!s->dataplane_disabled) {
+        if (!s->ioeventfd_disabled) {
             return;
         }
     }
@@ -1213,7 +1213,7 @@ static void virtio_blk_reset(VirtIODevice *vdev)
     VirtIOBlockReq *req;
 
     /* Dataplane has stopped... */
-    assert(!s->dataplane_started);
+    assert(!s->ioeventfd_started);
 
     /* ...but requests may still be in flight. */
     blk_drain(s->blk);
@@ -1380,7 +1380,7 @@ static void virtio_blk_set_status(VirtIODevice *vdev, uint8_t status)
     VirtIOBlock *s = VIRTIO_BLK(vdev);
 
     if (!(status & (VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK))) {
-        assert(!s->dataplane_started);
+        assert(!s->ioeventfd_started);
     }
 
     if (!(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
@@ -1545,7 +1545,7 @@ static void virtio_blk_resize(void *opaque)
     aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
 }
 
-static void virtio_blk_data_plane_detach(VirtIOBlock *s)
+static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
@@ -1555,7 +1555,7 @@ static void virtio_blk_data_plane_detach(VirtIOBlock *s)
     }
 }
 
-static void virtio_blk_data_plane_attach(VirtIOBlock *s)
+static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
 
@@ -1570,8 +1570,8 @@ static void virtio_blk_drained_begin(void *opaque)
 {
     VirtIOBlock *s = opaque;
 
-    if (s->dataplane_started) {
-        virtio_blk_data_plane_detach(s);
+    if (s->ioeventfd_started) {
+        virtio_blk_ioeventfd_detach(s);
     }
 }
 
@@ -1580,8 +1580,8 @@ static void virtio_blk_drained_end(void *opaque)
 {
     VirtIOBlock *s = opaque;
 
-    if (s->dataplane_started) {
-        virtio_blk_data_plane_attach(s);
+    if (s->ioeventfd_started) {
+        virtio_blk_ioeventfd_attach(s);
     }
 }
 
@@ -1651,11 +1651,11 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
         }
 
         /*
-         * If dataplane is (re-)enabled while the guest is running there could
+         * If ioeventfd is (re-)enabled while the guest is running there could
          * be block jobs that can conflict.
          */
         if (blk_op_is_blocked(conf->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
-            error_prepend(errp, "cannot start virtio-blk dataplane: ");
+            error_prepend(errp, "cannot start virtio-blk ioeventfd: ");
             return false;
         }
     }
@@ -1688,7 +1688,7 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
 
-    assert(!s->dataplane_started);
+    assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
         IOThreadVirtQueueMappingList *node;
@@ -1708,7 +1708,7 @@ static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 }
 
 /* Context: BQL held */
-static int virtio_blk_data_plane_start(VirtIODevice *vdev)
+static int virtio_blk_start_ioeventfd(VirtIODevice *vdev)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(s)));
@@ -1718,11 +1718,11 @@ static int virtio_blk_data_plane_start(VirtIODevice *vdev)
     Error *local_err = NULL;
     int r;
 
-    if (s->dataplane_started || s->dataplane_starting) {
+    if (s->ioeventfd_started || s->ioeventfd_starting) {
         return 0;
     }
 
-    s->dataplane_starting = true;
+    s->ioeventfd_starting = true;
 
     /* Set up guest notifier (irq) */
     r = k->set_guest_notifiers(qbus->parent, nvqs, true);
@@ -1773,14 +1773,14 @@ static int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     /*
      * These fields must be visible to the IOThread when it processes the
-     * virtqueue, otherwise it will think dataplane has not started yet.
+     * virtqueue, otherwise it will think ioeventfd has not started yet.
      *
-     * Make sure ->dataplane_started is false when blk_set_aio_context() is
+     * Make sure ->ioeventfd_started is false when blk_set_aio_context() is
      * called above so that draining does not cause the host notifier to be
      * detached/attached prematurely.
      */
-    s->dataplane_starting = false;
-    s->dataplane_started = true;
+    s->ioeventfd_starting = false;
+    s->ioeventfd_started = true;
     smp_wmb(); /* paired with aio_notify_accept() on the read side */
 
     /* Get this show started by hooking up our callbacks */
@@ -1812,8 +1812,8 @@ static int virtio_blk_data_plane_start(VirtIODevice *vdev)
   fail_host_notifiers:
     k->set_guest_notifiers(qbus->parent, nvqs, false);
   fail_guest_notifiers:
-    s->dataplane_disabled = true;
-    s->dataplane_starting = false;
+    s->ioeventfd_disabled = true;
+    s->ioeventfd_starting = false;
     return -ENOSYS;
 }
 
@@ -1821,7 +1821,7 @@ static int virtio_blk_data_plane_start(VirtIODevice *vdev)
  *
  * Context: BH in IOThread
  */
-static void virtio_blk_data_plane_stop_vq_bh(void *opaque)
+static void virtio_blk_ioeventfd_stop_vq_bh(void *opaque)
 {
     VirtQueue *vq = opaque;
     EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
@@ -1836,7 +1836,7 @@ static void virtio_blk_data_plane_stop_vq_bh(void *opaque)
 }
 
 /* Context: BQL held */
-static void virtio_blk_data_plane_stop(VirtIODevice *vdev)
+static void virtio_blk_stop_ioeventfd(VirtIODevice *vdev)
 {
     VirtIOBlock *s = VIRTIO_BLK(vdev);
     BusState *qbus = qdev_get_parent_bus(DEVICE(s));
@@ -1844,24 +1844,24 @@ static void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     unsigned i;
     unsigned nvqs = s->conf.num_queues;
 
-    if (!s->dataplane_started || s->dataplane_stopping) {
+    if (!s->ioeventfd_started || s->ioeventfd_stopping) {
         return;
     }
 
     /* Better luck next time. */
-    if (s->dataplane_disabled) {
-        s->dataplane_disabled = false;
-        s->dataplane_started = false;
+    if (s->ioeventfd_disabled) {
+        s->ioeventfd_disabled = false;
+        s->ioeventfd_started = false;
         return;
     }
-    s->dataplane_stopping = true;
+    s->ioeventfd_stopping = true;
 
     if (!blk_in_drain(s->conf.conf.blk)) {
         for (i = 0; i < nvqs; i++) {
             VirtQueue *vq = virtio_get_queue(vdev, i);
             AioContext *ctx = s->vq_aio_context[i];
 
-            aio_wait_bh_oneshot(ctx, virtio_blk_data_plane_stop_vq_bh, vq);
+            aio_wait_bh_oneshot(ctx, virtio_blk_ioeventfd_stop_vq_bh, vq);
         }
     }
 
@@ -1886,10 +1886,10 @@ static void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     }
 
     /*
-     * Set ->dataplane_started to false before draining so that host notifiers
+     * Set ->ioeventfd_started to false before draining so that host notifiers
      * are not detached/attached anymore.
      */
-    s->dataplane_started = false;
+    s->ioeventfd_started = false;
 
     /* Wait for virtio_blk_dma_restart_bh() and in flight I/O to complete */
     blk_drain(s->conf.conf.blk);
@@ -1903,7 +1903,7 @@ static void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     /* Clean up guest notifier (irq) */
     k->set_guest_notifiers(qbus->parent, nvqs, false);
 
-    s->dataplane_stopping = false;
+    s->ioeventfd_stopping = false;
 }
 
 static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
@@ -2011,9 +2011,9 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
     }
     qemu_coroutine_inc_pool_size(conf->num_queues * conf->queue_size / 2);
 
-    /* Don't start dataplane if transport does not support notifiers. */
+    /* Don't start ioeventfd if transport does not support notifiers. */
     if (!virtio_device_ioeventfd_enabled(vdev)) {
-        s->dataplane_disabled = true;
+        s->ioeventfd_disabled = true;
     }
 
     virtio_blk_vq_aio_context_init(s, &err);
@@ -2137,8 +2137,8 @@ static void virtio_blk_class_init(ObjectClass *klass, void *data)
     vdc->reset = virtio_blk_reset;
     vdc->save = virtio_blk_save_device;
     vdc->load = virtio_blk_load_device;
-    vdc->start_ioeventfd = virtio_blk_data_plane_start;
-    vdc->stop_ioeventfd = virtio_blk_data_plane_stop;
+    vdc->start_ioeventfd = virtio_blk_start_ioeventfd;
+    vdc->stop_ioeventfd = virtio_blk_stop_ioeventfd;
 }
 
 static const TypeInfo virtio_blk_info = {
-- 
2.43.0


