Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A4281A03E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 14:49:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFwvq-0003Xh-RH; Wed, 20 Dec 2023 08:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFwvl-0003Wl-RY
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:48:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFwvj-00067T-Fz
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 08:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703080090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iSTl8r7MCUEEVF2GX0KDPa3mjieQwODaKzWcob/iH4g=;
 b=Jm9m0mhD9NyktceKBLP3u5sRPyh2LfzYpqPq/j7Lgt73ixnuclTezmux00F/xSxD4T9eVD
 9mOqYrZxOp+DK4Tp5bDDqElp8tL9eGcUaSF7FO17r2AiIq4qkRnOw864q2yIXl3EN4oE6G
 87mlZvLEFPskyvcCjSkgZlwh45e9XdI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-fByQAsoMOqCu--va_fGIhg-1; Wed,
 20 Dec 2023 08:48:08 -0500
X-MC-Unique: fByQAsoMOqCu--va_fGIhg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D8FB81C3EA61;
 Wed, 20 Dec 2023 13:48:07 +0000 (UTC)
Received: from localhost (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 11EA751D5;
 Wed, 20 Dec 2023 13:48:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 4/4] virtio-blk: add iothread-vq-mapping parameter
Date: Wed, 20 Dec 2023 08:47:55 -0500
Message-ID: <20231220134755.814917-5-stefanha@redhat.com>
In-Reply-To: <20231220134755.814917-1-stefanha@redhat.com>
References: <20231220134755.814917-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Add the iothread-vq-mapping parameter to assign virtqueues to IOThreads.
Store the vq:AioContext mapping in the new struct
VirtIOBlockDataPlane->vq_aio_context[] field and refactor the code to
use the per-vq AioContext instead of the BlockDriverState's AioContext.

Reimplement --device virtio-blk-pci,iothread= and non-IOThread mode by
assigning all virtqueues to the IOThread and main loop's AioContext in
vq_aio_context[], respectively.

The comment in struct VirtIOBlockDataPlane about EventNotifiers is
stale. Remove it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/dataplane/virtio-blk.h |   3 +
 include/hw/virtio/virtio-blk.h  |   2 +
 hw/block/dataplane/virtio-blk.c | 155 ++++++++++++++++++++++++--------
 hw/block/virtio-blk.c           |  92 ++++++++++++++++---
 4 files changed, 202 insertions(+), 50 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.h b/hw/block/dataplane/virtio-blk.h
index 5e18bb99ae..1a806fe447 100644
--- a/hw/block/dataplane/virtio-blk.h
+++ b/hw/block/dataplane/virtio-blk.h
@@ -28,4 +28,7 @@ void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq);
 int virtio_blk_data_plane_start(VirtIODevice *vdev);
 void virtio_blk_data_plane_stop(VirtIODevice *vdev);
 
+void virtio_blk_data_plane_detach(VirtIOBlockDataPlane *s);
+void virtio_blk_data_plane_attach(VirtIOBlockDataPlane *s);
+
 #endif /* HW_DATAPLANE_VIRTIO_BLK_H */
diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
index 9881009c22..5e4091e4da 100644
--- a/include/hw/virtio/virtio-blk.h
+++ b/include/hw/virtio/virtio-blk.h
@@ -21,6 +21,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/block-ram-registrar.h"
 #include "qom/object.h"
+#include "qapi/qapi-types-virtio.h"
 
 #define TYPE_VIRTIO_BLK "virtio-blk-device"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOBlock, VIRTIO_BLK)
@@ -37,6 +38,7 @@ struct VirtIOBlkConf
 {
     BlockConf conf;
     IOThread *iothread;
+    IOThreadVirtQueueMappingList *iothread_vq_mapping_list;
     char *serial;
     uint32_t request_merging;
     uint16_t num_queues;
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 7bbbd981ad..6debd4401e 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -32,13 +32,11 @@ struct VirtIOBlockDataPlane {
     VirtIOBlkConf *conf;
     VirtIODevice *vdev;
 
-    /* Note that these EventNotifiers are assigned by value.  This is
-     * fine as long as you do not call event_notifier_cleanup on them
-     * (because you don't own the file descriptor or handle; you just
-     * use it).
+    /*
+     * The AioContext for each virtqueue. The BlockDriverState will use the
+     * first element as its AioContext.
      */
-    IOThread *iothread;
-    AioContext *ctx;
+    AioContext **vq_aio_context;
 };
 
 /* Raise an interrupt to signal guest, if necessary */
@@ -47,6 +45,45 @@ void virtio_blk_data_plane_notify(VirtIOBlockDataPlane *s, VirtQueue *vq)
     virtio_notify_irqfd(s->vdev, vq);
 }
 
+/* Generate vq:AioContext mappings from a validated iothread-vq-mapping list */
+static void
+apply_vq_mapping(IOThreadVirtQueueMappingList *iothread_vq_mapping_list,
+                 AioContext **vq_aio_context, uint16_t num_queues)
+{
+    IOThreadVirtQueueMappingList *node;
+    size_t num_iothreads = 0;
+    size_t cur_iothread = 0;
+
+    for (node = iothread_vq_mapping_list; node; node = node->next) {
+        num_iothreads++;
+    }
+
+    for (node = iothread_vq_mapping_list; node; node = node->next) {
+        IOThread *iothread = iothread_by_id(node->value->iothread);
+        AioContext *ctx = iothread_get_aio_context(iothread);
+
+        /* Released in virtio_blk_data_plane_destroy() */
+        object_ref(OBJECT(iothread));
+
+        if (node->value->vqs) {
+            uint16List *vq;
+
+            /* Explicit vq:IOThread assignment */
+            for (vq = node->value->vqs; vq; vq = vq->next) {
+                vq_aio_context[vq->value] = ctx;
+            }
+        } else {
+            /* Round-robin vq:IOThread assignment */
+            for (unsigned i = cur_iothread; i < num_queues;
+                 i += num_iothreads) {
+                vq_aio_context[i] = ctx;
+            }
+        }
+
+        cur_iothread++;
+    }
+}
+
 /* Context: QEMU global mutex held */
 bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
                                   VirtIOBlockDataPlane **dataplane,
@@ -58,7 +95,7 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
 
     *dataplane = NULL;
 
-    if (conf->iothread) {
+    if (conf->iothread || conf->iothread_vq_mapping_list) {
         if (!k->set_guest_notifiers || !k->ioeventfd_assign) {
             error_setg(errp,
                        "device is incompatible with iothread "
@@ -86,13 +123,24 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
     s = g_new0(VirtIOBlockDataPlane, 1);
     s->vdev = vdev;
     s->conf = conf;
+    s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
-    if (conf->iothread) {
-        s->iothread = conf->iothread;
-        object_ref(OBJECT(s->iothread));
-        s->ctx = iothread_get_aio_context(s->iothread);
+    if (conf->iothread_vq_mapping_list) {
+        apply_vq_mapping(conf->iothread_vq_mapping_list, s->vq_aio_context,
+                         conf->num_queues);
+    } else if (conf->iothread) {
+        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        for (unsigned i = 0; i < conf->num_queues; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
+
+        /* Released in virtio_blk_data_plane_destroy() */
+        object_ref(OBJECT(conf->iothread));
     } else {
-        s->ctx = qemu_get_aio_context();
+        AioContext *ctx = qemu_get_aio_context();
+        for (unsigned i = 0; i < conf->num_queues; i++) {
+            s->vq_aio_context[i] = ctx;
+        }
     }
 
     *dataplane = s;
@@ -104,6 +152,7 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
 void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
 {
     VirtIOBlock *vblk;
+    VirtIOBlkConf *conf = s->conf;
 
     if (!s) {
         return;
@@ -111,9 +160,21 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
 
     vblk = VIRTIO_BLK(s->vdev);
     assert(!vblk->dataplane_started);
-    if (s->iothread) {
-        object_unref(OBJECT(s->iothread));
+
+    if (conf->iothread_vq_mapping_list) {
+        IOThreadVirtQueueMappingList *node;
+
+        for (node = conf->iothread_vq_mapping_list; node; node = node->next) {
+            IOThread *iothread = iothread_by_id(node->value->iothread);
+            object_unref(OBJECT(iothread));
+        }
     }
+
+    if (conf->iothread) {
+        object_unref(OBJECT(conf->iothread));
+    }
+
+    g_free(s->vq_aio_context);
     g_free(s);
 }
 
@@ -177,19 +238,13 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
 
     trace_virtio_blk_data_plane_start(s);
 
-    r = blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err);
+    r = blk_set_aio_context(s->conf->conf.blk, s->vq_aio_context[0],
+                            &local_err);
     if (r < 0) {
         error_report_err(local_err);
         goto fail_aio_context;
     }
 
-    /* Kick right away to begin processing requests already in vring */
-    for (i = 0; i < nvqs; i++) {
-        VirtQueue *vq = virtio_get_queue(s->vdev, i);
-
-        event_notifier_set(virtio_queue_get_host_notifier(vq));
-    }
-
     /*
      * These fields must be visible to the IOThread when it processes the
      * virtqueue, otherwise it will think dataplane has not started yet.
@@ -206,8 +261,12 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
     if (!blk_in_drain(s->conf->conf.blk)) {
         for (i = 0; i < nvqs; i++) {
             VirtQueue *vq = virtio_get_queue(s->vdev, i);
+            AioContext *ctx = s->vq_aio_context[i];
 
-            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+            /* Kick right away to begin processing requests already in vring */
+            event_notifier_set(virtio_queue_get_host_notifier(vq));
+
+            virtio_queue_aio_attach_host_notifier(vq, ctx);
         }
     }
     return 0;
@@ -236,23 +295,18 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
  *
  * Context: BH in IOThread
  */
-static void virtio_blk_data_plane_stop_bh(void *opaque)
+static void virtio_blk_data_plane_stop_vq_bh(void *opaque)
 {
-    VirtIOBlockDataPlane *s = opaque;
-    unsigned i;
+    VirtQueue *vq = opaque;
+    EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
 
-    for (i = 0; i < s->conf->num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(s->vdev, i);
-        EventNotifier *host_notifier = virtio_queue_get_host_notifier(vq);
+    virtio_queue_aio_detach_host_notifier(vq, qemu_get_current_aio_context());
 
-        virtio_queue_aio_detach_host_notifier(vq, s->ctx);
-
-        /*
-         * Test and clear notifier after disabling event, in case poll callback
-         * didn't have time to run.
-         */
-        virtio_queue_host_notifier_read(host_notifier);
-    }
+    /*
+     * Test and clear notifier after disabling event, in case poll callback
+     * didn't have time to run.
+     */
+    virtio_queue_host_notifier_read(host_notifier);
 }
 
 /* Context: QEMU global mutex held */
@@ -279,7 +333,12 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     trace_virtio_blk_data_plane_stop(s);
 
     if (!blk_in_drain(s->conf->conf.blk)) {
-        aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
+        for (i = 0; i < nvqs; i++) {
+            VirtQueue *vq = virtio_get_queue(s->vdev, i);
+            AioContext *ctx = s->vq_aio_context[i];
+
+            aio_wait_bh_oneshot(ctx, virtio_blk_data_plane_stop_vq_bh, vq);
+        }
     }
 
     /*
@@ -322,3 +381,23 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
 
     s->stopping = false;
 }
+
+void virtio_blk_data_plane_detach(VirtIOBlockDataPlane *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s->vdev);
+
+    for (uint16_t i = 0; i < s->conf->num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_detach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
+
+void virtio_blk_data_plane_attach(VirtIOBlockDataPlane *s)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(s->vdev);
+
+    for (uint16_t i = 0; i < s->conf->num_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_attach_host_notifier(vq, s->vq_aio_context[i]);
+    }
+}
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index ec9ed09a6a..46e73b2c96 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1151,6 +1151,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
             return;
         }
     }
+
     virtio_blk_handle_vq(s, vq);
 }
 
@@ -1463,6 +1464,68 @@ static int virtio_blk_load_device(VirtIODevice *vdev, QEMUFile *f,
     return 0;
 }
 
+static bool
+validate_iothread_vq_mapping_list(IOThreadVirtQueueMappingList *list,
+        uint16_t num_queues, Error **errp)
+{
+    g_autofree unsigned long *vqs = bitmap_new(num_queues);
+    g_autoptr(GHashTable) iothreads =
+        g_hash_table_new(g_str_hash, g_str_equal);
+
+    for (IOThreadVirtQueueMappingList *node = list; node; node = node->next) {
+        const char *name = node->value->iothread;
+        uint16List *vq;
+
+        if (!iothread_by_id(name)) {
+            error_setg(errp, "IOThread \"%s\" object does not exist", name);
+            return false;
+        }
+
+        if (!g_hash_table_add(iothreads, (gpointer)name)) {
+            error_setg(errp,
+                    "duplicate IOThread name \"%s\" in iothread-vq-mapping",
+                    name);
+            return false;
+        }
+
+        if (node != list) {
+            if (!!node->value->vqs != !!list->value->vqs) {
+                error_setg(errp, "either all items in iothread-vq-mapping "
+                                 "must have vqs or none of them must have it");
+                return false;
+            }
+        }
+
+        for (vq = node->value->vqs; vq; vq = vq->next) {
+            if (vq->value >= num_queues) {
+                error_setg(errp, "vq index %u for IOThread \"%s\" must be "
+                        "less than num_queues %u in iothread-vq-mapping",
+                        vq->value, name, num_queues);
+                return false;
+            }
+
+            if (test_and_set_bit(vq->value, vqs)) {
+                error_setg(errp, "cannot assign vq %u to IOThread \"%s\" "
+                        "because it is already assigned", vq->value, name);
+                return false;
+            }
+        }
+    }
+
+    if (list->value->vqs) {
+        for (uint16_t i = 0; i < num_queues; i++) {
+            if (!test_bit(i, vqs)) {
+                error_setg(errp,
+                        "missing vq %u IOThread assignment in iothread-vq-mapping",
+                        i);
+                return false;
+            }
+        }
+    }
+
+    return true;
+}
+
 static void virtio_resize_cb(void *opaque)
 {
     VirtIODevice *vdev = opaque;
@@ -1487,34 +1550,24 @@ static void virtio_blk_resize(void *opaque)
 static void virtio_blk_drained_begin(void *opaque)
 {
     VirtIOBlock *s = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
-    AioContext *ctx = blk_get_aio_context(s->conf.conf.blk);
 
     if (!s->dataplane || !s->dataplane_started) {
         return;
     }
 
-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_detach_host_notifier(vq, ctx);
-    }
+    virtio_blk_data_plane_detach(s->dataplane);
 }
 
 /* Resume virtqueue ioeventfd processing after drain */
 static void virtio_blk_drained_end(void *opaque)
 {
     VirtIOBlock *s = opaque;
-    VirtIODevice *vdev = VIRTIO_DEVICE(opaque);
-    AioContext *ctx = blk_get_aio_context(s->conf.conf.blk);
 
     if (!s->dataplane || !s->dataplane_started) {
         return;
     }
 
-    for (uint16_t i = 0; i < s->conf.num_queues; i++) {
-        VirtQueue *vq = virtio_get_queue(vdev, i);
-        virtio_queue_aio_attach_host_notifier(vq, ctx);
-    }
+    virtio_blk_data_plane_attach(s->dataplane);
 }
 
 static const BlockDevOps virtio_block_ops = {
@@ -1600,6 +1653,19 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (conf->iothread_vq_mapping_list) {
+        if (conf->iothread) {
+            error_setg(errp, "iothread and iothread-vq-mapping properties "
+                             "cannot be set at the same time");
+            return;
+        }
+
+        if (!validate_iothread_vq_mapping_list(conf->iothread_vq_mapping_list,
+                                               conf->num_queues, errp)) {
+            return;
+        }
+    }
+
     s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
                                             s->host_features);
     virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
@@ -1702,6 +1768,8 @@ static Property virtio_blk_properties[] = {
     DEFINE_PROP_BOOL("seg-max-adjust", VirtIOBlock, conf.seg_max_adjust, true),
     DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
                      IOThread *),
+    DEFINE_PROP_IOTHREAD_VQ_MAPPING_LIST("iothread-vq-mapping", VirtIOBlock,
+                                         conf.iothread_vq_mapping_list),
     DEFINE_PROP_BIT64("discard", VirtIOBlock, host_features,
                       VIRTIO_BLK_F_DISCARD, true),
     DEFINE_PROP_BOOL("report-discard-granularity", VirtIOBlock,
-- 
2.43.0


