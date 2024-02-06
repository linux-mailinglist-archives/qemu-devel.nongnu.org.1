Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D684BDDF
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Feb 2024 20:07:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQm1-0008IC-RG; Tue, 06 Feb 2024 14:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQm0-0008Ha-C7
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rXQly-0000eO-G2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707246381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zd00/eSHCWjYaWUzdyc1RU+DgeFJvNq6u2T6kNcIzaU=;
 b=caEFnYDlD8JGaE7OFbtCKnkP0EvkrE09j/DBFHv8xWuPUqxtASfFqM0kT+2RO7+L3bjJ8L
 ybrR6wmEfvM0BWNQBuOYs6PjxP69NFOAn+Mbsd/hgUKvubQ7u8b4DXHRDXiNajvRKSnI8J
 dKil513aIXPE0HyfLff9N6rgtRfEj88=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-9-9AqYy2N4C1knD7epWozw-1; Tue, 06 Feb 2024 14:06:16 -0500
X-MC-Unique: 9-9AqYy2N4C1knD7epWozw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03D2E8489EF;
 Tue,  6 Feb 2024 19:06:15 +0000 (UTC)
Received: from localhost (unknown [10.39.192.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DAD5492BC7;
 Tue,  6 Feb 2024 19:06:14 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 1/5] virtio-blk: enforce iothread-vq-mapping validation
Date: Tue,  6 Feb 2024 14:06:06 -0500
Message-ID: <20240206190610.107963-2-stefanha@redhat.com>
In-Reply-To: <20240206190610.107963-1-stefanha@redhat.com>
References: <20240206190610.107963-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hanna Czenczek <hreitz@redhat.com> noticed that the safety of
`vq_aio_context[vq->value] = ctx;` with user-defined vq->value inputs is
not obvious.

The code is structured in validate() + apply() steps so input validation
is there, but it happens way earlier and there is nothing that
guarantees apply() can only be called with validated inputs.

This patch moves the validate() call inside the apply() function so
validation is guaranteed. I also added the bounds checking assertion
that Hanna suggested.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 hw/block/virtio-blk.c | 191 +++++++++++++++++++++++-------------------
 1 file changed, 106 insertions(+), 85 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 227d83569f..6e3e3a23ee 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1485,6 +1485,72 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
+static void virtio_resize_cb(void *opaque)
+{
+    VirtIODevice *vdev = opaque;
+
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+    virtio_notify_config(vdev);
+}
+
+static void virtio_blk_resize(void *opaque)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
+
+    /*
+     * virtio_notify_config() needs to acquire the BQL,
+     * so it can't be called from an iothread. Instead, schedule
+     * it to be run in the main context BH.
+     */
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
+}
+
+static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
+
+static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
+
+/* Suspend virtqueue ioeventfd processing during drain */
+static void virtio_blk_drained_begin(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+
+    if (s->ioeventfd_started) {
+        virtio_blk_ioeventfd_detach(s);
+    }
+}
+
+/* Resume virtqueue ioeventfd processing after drain */
+static void virtio_blk_drained_end(void *opaque)
+{
+    VirtIOBlock *s = opaque;
+
+    if (s->ioeventfd_started) {
+        virtio_blk_ioeventfd_attach(s);
+    }
+}
+
+static const BlockDevOps virtio_block_ops = {
+    .resize_cb     = virtio_blk_resize,
+    .drained_begin = virtio_blk_drained_begin,
+    .drained_end   = virtio_blk_drained_end,
+};
+
 static bool
 validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
         uint16_t num_queues, Error **errp)
@@ -1547,81 +1613,33 @@ validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
     return true;
 }
 
-static void virtio_resize_cb(void *opaque)
-{
-    VirtIODevice *vdev = opaque;
-
-    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
-    virtio_notify_config(vdev);
-}
-
-static void virtio_blk_resize(void *opaque)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
-
-    /*
-     * virtio_notify_config() needs to acquire the BQL,
-     * so it can't be called from an iothread. Instead, schedule
-     * it to be run in the main context BH.
-     */
-    aio_bh_schedule_oneshot(qemu_get_aio_context(), virtio_resize_cb, vdev);
-}
-
-static void virtio_blk_ioeventfd_detach(VirtIOBlock *s)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-
-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
-    }
-}
-
-static void virtio_blk_ioeventfd_attach(VirtIOBlock *s)
-{
-    VirtIODevice *vdev = VIRTIO_DEVICE(s);
-
-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
-    }
-}
-
-/* Suspend virtqueue ioeventfd processing during drain */
-static void virtio_blk_drained_begin(void *opaque)
-{
-    VirtIOBlock *s = opaque;
-
-    if (s->ioeventfd_started) {
-        virtio_blk_ioeventfd_detach(s);
-    }
-}
-
-/* Resume virtqueue ioeventfd processing after drain */
-static void virtio_blk_drained_end(void *opaque)
-{
-    VirtIOBlock *s = opaque;
-
-    if (s->ioeventfd_started) {
-        virtio_blk_ioeventfd_attach(s);
-    }
-}
-
-static const BlockDevOps virtio_block_ops = {
-    .resize_cb     = virtio_blk_resize,
-    .drained_begin = virtio_blk_drained_begin,
-    .drained_end   = virtio_blk_drained_end,
-};
-
-/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
-static void
-apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
-                 AioContext **vq_aio_context, uint16_t num_queues)
+/**
+ * apply_iothread_vq_mapping:
+ * @iothread_vq_mapping_list: The mapping of virtqueues to IOThreads.
+ * @vq_aio_context: The array of AioContext pointers to fill in.
+ * @num_queues: The length of @vq_aio_context.
+ * @errp: If an error occurs, a pointer to the area to store the error.
+ *
+ * Fill in the AioContext for each virtqueue in the @vq_aio_context array given
+ * the iothread-vq-mapping parameter in @iothread_vq_mapping_list.
+ *
+ * Returns: %true on success, %false on failure.
+ **/
+static bool apply_iothread_vq_mapping(
+        IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
+        AioContext **vq_aio_context,
+        uint16_t num_queues,
+        Error **errp)
 {
     IOThreadVirtQueueMappingList *node;
     size_t num_iothreads = 0;
     size_t cur_iothread = 0;
 
+    if (!validate_iothread_vq_mapping_list(iothread_vq_mapping_list,
+                                           num_queues, errp)) {
+        return false;
+    }
+
     for (node = iothread_vq_mapping_list; node; node = node->next) {
         num_iothreads++;
     }
@@ -1638,6 +1656,7 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
 
             /* Explicit vq:IOThread assignment */
             for (vq = node->value->vqs; vq; vq = vq->next) {
+                assert(vq->value < num_queues);
                 vq_aio_context[vq->value] = ctx;
             }
         } else {
@@ -1650,6 +1669,8 @@ apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
 
         cur_iothread++;
     }
+
+    return true;
 }
 
 /* Context: BQL held */
@@ -1660,6 +1681,13 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
 
+    if (conf->iothread && conf->iothread_vq_mapping_list) {
+        error_setg(errp,
+                   "iothread and iothread-vq-mapping properties cannot be set "
+                   "at the same time");
+        return false;
+    }
+
     if (conf->iothread || conf->iothread_vq_mapping_list) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
             error_setg(errp,
@@ -1685,8 +1713,14 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
-                         conf->num_queues);
+        if (!apply_iothread_vq_mapping(conf->iothread_vq_mapping_list,
+                                       s->vq_aio_context,
+                                       conf->num_queues,
+                                       errp)) {
+            g_free(s->vq_aio_context);
+            s->vq_aio_context = NULL;
+            return false;
+        }
     } else if (conf->iothread) {
         AioContext *ctx = iothread_get_aio_context(conf->iothread);
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1996,19 +2030,6 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (conf->iothread_vq_mapping_list) {
-        if (conf->iothread) {
-            error_setg(errp, "iothread and iothread-vq-mapping properties "
-                             "cannot be set at the same time");
-            return;
-        }
-
-        if (!validate_iothread_vq_mapping_list(conf->iothread_vq_mapping_list,
-                                               conf->num_queues, errp)) {
-            return;
-        }
-    }
-
     s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
                                             s->host_features);
     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
-- 
2.43.0


