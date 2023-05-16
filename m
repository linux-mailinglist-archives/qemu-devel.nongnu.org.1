Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE4D7056B4
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzwu-0001m3-On; Tue, 16 May 2023 15:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzwt-0001lo-5D
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzwr-0001Ay-Cx
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+xP3+VvbKptobyZr1DGqYiArlGHMgmGr4twrwXIfR0=;
 b=br4gSS/8K93M2GqMV4QLB6sjeP6C6JRpyK1dnKOsHweqNEMuydIBSPnRsoIp+wJJnLCgyJ
 tZSvVypgSCgrWzZWLF/C9wNnEm0HQyAm9ZBsqnGDjhGzcTYA3GuLvPEsxVAkOEgCqLlTDu
 KcvdXVxxLpdgB8AD59aAawbPUJ2QJNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-ZScnqIcZMPy3U2EgdpHnTw-1; Tue, 16 May 2023 15:02:56 -0400
X-MC-Unique: ZScnqIcZMPy3U2EgdpHnTw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725C286C614;
 Tue, 16 May 2023 19:02:55 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C6A3A492B00;
 Tue, 16 May 2023 19:02:53 +0000 (UTC)
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
 Juan Quintela <quintela@redhat.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: [PATCH v6 03/20] virtio-scsi: avoid race between unplug and transport
 event
Date: Tue, 16 May 2023 15:02:21 -0400
Message-Id: <20230516190238.8401-4-stefanha@redhat.com>
In-Reply-To: <20230516190238.8401-1-stefanha@redhat.com>
References: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

Only report a transport reset event to the guest after the SCSIDevice
has been unrealized by qdev_simple_device_unplug_cb().

qdev_simple_device_unplug_cb() sets the SCSIDevice's qdev.realized field
to false so that scsi_device_find/get() no longer see it.

scsi_target_emulate_report_luns() also needs to be updated to filter out
SCSIDevices that are unrealized.

Change virtio_scsi_push_event() to take event information as an argument
instead of the SCSIDevice. This allows virtio_scsi_hotunplug() to emit a
VIRTIO_SCSI_T_TRANSPORT_RESET event after the SCSIDevice has already
been unrealized.

These changes ensure that the guest driver does not see the SCSIDevice
that's being unplugged if it responds very quickly to the transport
reset event.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
v5:
- Stash SCSIDevice id/lun values for VIRTIO_SCSI_T_TRANSPORT_RESET event
  before unrealizing the SCSIDevice [Kevin]
---
 hw/scsi/scsi-bus.c    |  3 +-
 hw/scsi/virtio-scsi.c | 86 ++++++++++++++++++++++++++++++-------------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 8857ff41f6..64013c8a24 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -487,7 +487,8 @@ static bool scsi_target_emulate_report_luns(SCSITargetReq *r)
             DeviceState *qdev = kid->child;
             SCSIDevice *dev = SCSI_DEVICE(qdev);
 
-            if (dev->channel == channel && dev->id == id && dev->lun != 0) {
+            if (dev->channel == channel && dev->id == id && dev->lun != 0 &&
+                qdev_is_realized(&dev->qdev)) {
                 store_lun(tmp, dev->lun);
                 g_byte_array_append(buf, tmp, 8);
                 len += 8;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 612c525d9d..ae314af3de 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -933,13 +933,27 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
     s->events_dropped = false;
 }
 
-static void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
-                                   uint32_t event, uint32_t reason)
+typedef struct {
+    uint32_t event;
+    uint32_t reason;
+    union {
+        /* Used by messages specific to a device */
+        struct {
+            uint32_t id;
+            uint32_t lun;
+        } address;
+    };
+} VirtIOSCSIEventInfo;
+
+static void virtio_scsi_push_event(VirtIOSCSI *s,
+                                   const VirtIOSCSIEventInfo *info)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
     VirtIOSCSIReq *req;
     VirtIOSCSIEvent *evt;
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
+    uint32_t event = info->event;
+    uint32_t reason = info->reason;
 
     if (!(vdev->status & VIRTIO_CONFIG_S_DRIVER_OK)) {
         return;
@@ -965,27 +979,28 @@ static void virtio_scsi_push_event(VirtIOSCSI *s, SCSIDevice *dev,
     memset(evt, 0, sizeof(VirtIOSCSIEvent));
     evt->event = virtio_tswap32(vdev, event);
     evt->reason = virtio_tswap32(vdev, reason);
-    if (!dev) {
-        assert(event == VIRTIO_SCSI_T_EVENTS_MISSED);
-    } else {
+    if (event != VIRTIO_SCSI_T_EVENTS_MISSED) {
         evt->lun[0] = 1;
-        evt->lun[1] = dev->id;
+        evt->lun[1] = info->address.id;
 
         /* Linux wants us to keep the same encoding we use for REPORT LUNS.  */
-        if (dev->lun >= 256) {
-            evt->lun[2] = (dev->lun >> 8) | 0x40;
+        if (info->address.lun >= 256) {
+            evt->lun[2] = (info->address.lun >> 8) | 0x40;
         }
-        evt->lun[3] = dev->lun & 0xFF;
+        evt->lun[3] = info->address.lun & 0xFF;
     }
     trace_virtio_scsi_event(virtio_scsi_get_lun(evt->lun), event, reason);
-     
+
     virtio_scsi_complete_req(req);
 }
 
 static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
     if (s->events_dropped) {
-        virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
+        VirtIOSCSIEventInfo info = {
+            .event = VIRTIO_SCSI_T_NO_EVENT,
+        };
+        virtio_scsi_push_event(s, &info);
     }
 }
 
@@ -1009,9 +1024,17 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_CHANGE) &&
         dev->type != TYPE_ROM) {
+        VirtIOSCSIEventInfo info = {
+            .event   = VIRTIO_SCSI_T_PARAM_CHANGE,
+            .reason  = sense.asc | (sense.ascq << 8),
+            .address = {
+                .id  = dev->id,
+                .lun = dev->lun,
+            },
+        };
+
         virtio_scsi_acquire(s);
-        virtio_scsi_push_event(s, dev, VIRTIO_SCSI_T_PARAM_CHANGE,
-                               sense.asc | (sense.ascq << 8));
+        virtio_scsi_push_event(s, &info);
         virtio_scsi_release(s);
     }
 }
@@ -1046,10 +1069,17 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
+        VirtIOSCSIEventInfo info = {
+            .event   = VIRTIO_SCSI_T_TRANSPORT_RESET,
+            .reason  = VIRTIO_SCSI_EVT_RESET_RESCAN,
+            .address = {
+                .id  = sd->id,
+                .lun = sd->lun,
+            },
+        };
+
         virtio_scsi_acquire(s);
-        virtio_scsi_push_event(s, sd,
-                               VIRTIO_SCSI_T_TRANSPORT_RESET,
-                               VIRTIO_SCSI_EVT_RESET_RESCAN);
+        virtio_scsi_push_event(s, &info);
         scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
         virtio_scsi_release(s);
     }
@@ -1062,15 +1092,14 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     SCSIDevice *sd = SCSI_DEVICE(dev);
     AioContext *ctx = s->ctx ?: qemu_get_aio_context();
-
-    if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
-        virtio_scsi_acquire(s);
-        virtio_scsi_push_event(s, sd,
-                               VIRTIO_SCSI_T_TRANSPORT_RESET,
-                               VIRTIO_SCSI_EVT_RESET_REMOVED);
-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
-        virtio_scsi_release(s);
-    }
+    VirtIOSCSIEventInfo info = {
+        .event   = VIRTIO_SCSI_T_TRANSPORT_RESET,
+        .reason  = VIRTIO_SCSI_EVT_RESET_REMOVED,
+        .address = {
+            .id  = sd->id,
+            .lun = sd->lun,
+        },
+    };
 
     aio_disable_external(ctx);
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
@@ -1082,6 +1111,13 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
         virtio_scsi_release(s);
     }
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
+        virtio_scsi_acquire(s);
+        virtio_scsi_push_event(s, &info);
+        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
+        virtio_scsi_release(s);
+    }
 }
 
 static struct SCSIBusInfo virtio_scsi_scsi_info = {
-- 
2.40.1


