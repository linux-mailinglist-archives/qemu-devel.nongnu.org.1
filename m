Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED35F7056D3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:09:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzxn-0002vZ-3w; Tue, 16 May 2023 15:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxl-0002oV-8J
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzxi-0001LW-Po
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b5WnUQm2S0YXwNos6EbIKNeS3TxM6yVDdnX/yh34lvc=;
 b=I02Ksrp19XNmTkQMKVoc01fnvOVbtdPdJvU9auVIhWaiIQ1JcfOAl/UmnQNyZOCxYBdj2g
 +3FslLyR9b1e4TOo569CuXqoDoTNjr0YJPL+xfcAZda7bZlV9nauBe0PJykjj/5j/Bgnjt
 /ncbkRE/c4bQL66zoaXDlXmDFUDpGmg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-Eqyk3gCQO6C1PHNyU1HRkQ-1; Tue, 16 May 2023 15:03:47 -0400
X-MC-Unique: Eqyk3gCQO6C1PHNyU1HRkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91CBC29A9CA1;
 Tue, 16 May 2023 19:03:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E0C1F2166B31;
 Tue, 16 May 2023 19:03:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 eesposit@redhat.com, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v6 18/20] virtio-scsi: implement BlockDevOps->drained_begin()
Date: Tue, 16 May 2023 15:02:36 -0400
Message-Id: <20230516190238.8401-19-stefanha@redhat.com>
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The virtio-scsi Host Bus Adapter provides access to devices on a SCSI
bus. Those SCSI devices typically have a BlockBackend. When the
BlockBackend enters a drained section, the SCSI device must temporarily
stop submitting new I/O requests.

Implement this behavior by temporarily stopping virtio-scsi virtqueue
processing when one of the SCSI devices enters a drained section. The
new scsi_device_drained_begin() API allows scsi-disk to message the
virtio-scsi HBA.

scsi_device_drained_begin() uses a drain counter so that multiple SCSI
devices can have overlapping drained sections. The HBA only sees one
pair of .drained_begin/end() calls.

After this commit, virtio-scsi no longer depends on hw/virtio's
ioeventfd aio_set_event_notifier(is_external=true). This commit is a
step towards removing the aio_disable_external() API.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/scsi/scsi.h          | 14 ++++++++++++
 hw/scsi/scsi-bus.c              | 40 +++++++++++++++++++++++++++++++++
 hw/scsi/scsi-disk.c             | 27 +++++++++++++++++-----
 hw/scsi/virtio-scsi-dataplane.c | 18 +++++++++------
 hw/scsi/virtio-scsi.c           | 38 +++++++++++++++++++++++++++++++
 hw/scsi/trace-events            |  2 ++
 6 files changed, 127 insertions(+), 12 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index 6f23a7a73e..e2bb1a2fbf 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -133,6 +133,16 @@ struct SCSIBusInfo {
     void (*save_request)(QEMUFile *f, SCSIRequest *req);
     void *(*load_request)(QEMUFile *f, SCSIRequest *req);
     void (*free_request)(SCSIBus *bus, void *priv);
+
+    /*
+     * Temporarily stop submitting new requests between drained_begin() and
+     * drained_end(). Called from the main loop thread with the BQL held.
+     *
+     * Implement these callbacks if request processing is triggered by a file
+     * descriptor like an EventNotifier. Otherwise set them to NULL.
+     */
+    void (*drained_begin)(SCSIBus *bus);
+    void (*drained_end)(SCSIBus *bus);
 };
 
 #define TYPE_SCSI_BUS "SCSI"
@@ -144,6 +154,8 @@ struct SCSIBus {
 
     SCSISense unit_attention;
     const SCSIBusInfo *info;
+
+    int drain_count; /* protected by BQL */
 };
 
 /**
@@ -213,6 +225,8 @@ void scsi_req_cancel_complete(SCSIRequest *req);
 void scsi_req_cancel(SCSIRequest *req);
 void scsi_req_cancel_async(SCSIRequest *req, Notifier *notifier);
 void scsi_req_retry(SCSIRequest *req);
+void scsi_device_drained_begin(SCSIDevice *sdev);
+void scsi_device_drained_end(SCSIDevice *sdev);
 void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense);
 void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense);
 void scsi_device_report_change(SCSIDevice *dev, SCSISense sense);
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 64013c8a24..f80f4cb4fc 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1669,6 +1669,46 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
     scsi_device_set_ua(sdev, sense);
 }
 
+void scsi_device_drained_begin(SCSIDevice *sdev)
+{
+    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+    if (!bus) {
+        return;
+    }
+
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+    assert(bus->drain_count < INT_MAX);
+
+    /*
+     * Multiple BlockBackends can be on a SCSIBus and each may begin/end
+     * draining at any time. Keep a counter so HBAs only see begin/end once.
+     */
+    if (bus->drain_count++ == 0) {
+        trace_scsi_bus_drained_begin(bus, sdev);
+        if (bus->info->drained_begin) {
+            bus->info->drained_begin(bus);
+        }
+    }
+}
+
+void scsi_device_drained_end(SCSIDevice *sdev)
+{
+    SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, sdev->qdev.parent_bus);
+    if (!bus) {
+        return;
+    }
+
+    assert(qemu_get_current_aio_context() == qemu_get_aio_context());
+    assert(bus->drain_count > 0);
+
+    if (bus->drain_count-- == 1) {
+        trace_scsi_bus_drained_end(bus, sdev);
+        if (bus->info->drained_end) {
+            bus->info->drained_end(bus);
+        }
+    }
+}
+
 static char *scsibus_get_dev_path(DeviceState *dev)
 {
     SCSIDevice *d = SCSI_DEVICE(dev);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 97c9b1c8cd..e0d79c7966 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2360,6 +2360,20 @@ static void scsi_disk_reset(DeviceState *dev)
     s->qdev.scsi_version = s->qdev.default_scsi_version;
 }
 
+static void scsi_disk_drained_begin(void *opaque)
+{
+    SCSIDiskState *s = opaque;
+
+    scsi_device_drained_begin(&s->qdev);
+}
+
+static void scsi_disk_drained_end(void *opaque)
+{
+    SCSIDiskState *s = opaque;
+
+    scsi_device_drained_end(&s->qdev);
+}
+
 static void scsi_disk_resize_cb(void *opaque)
 {
     SCSIDiskState *s = opaque;
@@ -2414,16 +2428,19 @@ static bool scsi_cd_is_medium_locked(void *opaque)
 }
 
 static const BlockDevOps scsi_disk_removable_block_ops = {
-    .change_media_cb = scsi_cd_change_media_cb,
+    .change_media_cb  = scsi_cd_change_media_cb,
+    .drained_begin    = scsi_disk_drained_begin,
+    .drained_end      = scsi_disk_drained_end,
     .eject_request_cb = scsi_cd_eject_request_cb,
-    .is_tray_open = scsi_cd_is_tray_open,
     .is_medium_locked = scsi_cd_is_medium_locked,
-
-    .resize_cb = scsi_disk_resize_cb,
+    .is_tray_open     = scsi_cd_is_tray_open,
+    .resize_cb        = scsi_disk_resize_cb,
 };
 
 static const BlockDevOps scsi_disk_block_ops = {
-    .resize_cb = scsi_disk_resize_cb,
+    .drained_begin = scsi_disk_drained_begin,
+    .drained_end   = scsi_disk_drained_end,
+    .resize_cb     = scsi_disk_resize_cb,
 };
 
 static void scsi_disk_unit_attention_reported(SCSIDevice *dev)
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index b3a1ed21f7..d55de4c8ca 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -158,14 +158,16 @@ int virtio_scsi_dataplane_start(VirtIODevice *vdev)
     s->dataplane_starting = false;
     s->dataplane_started = true;
 
-    aio_context_acquire(s->ctx);
-    virtio_queue_aio_attach_host_notifier(vs->ctrl_vq, s->ctx);
-    virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);
+    if (s->bus.drain_count == 0) {
+        aio_context_acquire(s->ctx);
+        virtio_queue_aio_attach_host_notifier(vs->ctrl_vq, s->ctx);
+        virtio_queue_aio_attach_host_notifier_no_poll(vs->event_vq, s->ctx);
 
-    for (i = 0; i < vs->conf.num_queues; i++) {
-        virtio_queue_aio_attach_host_notifier(vs->cmd_vqs[i], s->ctx);
+        for (i = 0; i < vs->conf.num_queues; i++) {
+            virtio_queue_aio_attach_host_notifier(vs->cmd_vqs[i], s->ctx);
+        }
+        aio_context_release(s->ctx);
     }
-    aio_context_release(s->ctx);
     return 0;
 
 fail_host_notifiers:
@@ -211,7 +213,9 @@ void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
     }
     s->dataplane_stopping = true;
 
-    aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
+    if (s->bus.drain_count == 0) {
+        aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
+    }
 
     blk_drain_all(); /* ensure there are no in-flight requests */
 
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index c1a7ea9ae2..4a8849cc7e 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1117,6 +1117,42 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 }
 
+/* Suspend virtqueue ioeventfd processing during drain */
+static void virtio_scsi_drained_begin(SCSIBus *bus)
+{
+    VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+    uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
+                            s->parent_obj.conf.num_queues;
+
+    if (!s->dataplane_started) {
+        return;
+    }
+
+    for (uint32_t i = 0; i < total_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_detach_host_notifier(vq, s->ctx);
+    }
+}
+
+/* Resume virtqueue ioeventfd processing after drain */
+static void virtio_scsi_drained_end(SCSIBus *bus)
+{
+    VirtIOSCSI *s = container_of(bus, VirtIOSCSI, bus);
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+    uint32_t total_queues = VIRTIO_SCSI_VQ_NUM_FIXED +
+                            s->parent_obj.conf.num_queues;
+
+    if (!s->dataplane_started) {
+        return;
+    }
+
+    for (uint32_t i = 0; i < total_queues; i++) {
+        VirtQueue *vq = virtio_get_queue(vdev, i);
+        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
+    }
+}
+
 static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .tcq = true,
     .max_channel = VIRTIO_SCSI_MAX_CHANNEL,
@@ -1131,6 +1167,8 @@ static struct SCSIBusInfo virtio_scsi_scsi_info = {
     .get_sg_list = virtio_scsi_get_sg_list,
     .save_request = virtio_scsi_save_request,
     .load_request = virtio_scsi_load_request,
+    .drained_begin = virtio_scsi_drained_begin,
+    .drained_end = virtio_scsi_drained_end,
 };
 
 void virtio_scsi_common_realize(DeviceState *dev,
diff --git a/hw/scsi/trace-events b/hw/scsi/trace-events
index ab238293f0..bdd4e2c7c7 100644
--- a/hw/scsi/trace-events
+++ b/hw/scsi/trace-events
@@ -6,6 +6,8 @@ scsi_req_cancel(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_data(int target, int lun, int tag, int len) "target %d lun %d tag %d len %d"
 scsi_req_data_canceled(int target, int lun, int tag, int len) "target %d lun %d tag %d len %d"
 scsi_req_dequeue(int target, int lun, int tag) "target %d lun %d tag %d"
+scsi_bus_drained_begin(void *bus, void *sdev) "bus %p sdev %p"
+scsi_bus_drained_end(void *bus, void *sdev) "bus %p sdev %p"
 scsi_req_continue(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_continue_canceled(int target, int lun, int tag) "target %d lun %d tag %d"
 scsi_req_parsed(int target, int lun, int tag, int cmd, int mode, int xfer) "target %d lun %d tag %d command %d dir %d length %d"
-- 
2.40.1


