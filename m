Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C25805D3D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 19:23:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAa30-0000Sq-Jy; Tue, 05 Dec 2023 13:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2L-00007J-0Y
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAa2G-0002lC-3q
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 13:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701800443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKQzQ3fye1WySx6n8C4OipFXirz9rwxVm6vz00LMeKs=;
 b=UL1HngwMW0sovO5vzNd6JctMerp8OihcHC8joBj1Tiq4dv0f0O6RNUZ5C8yC39mBNbDstg
 YIknNYveIUw0AXXn8DQo08a2An+ORc5VTEu0A5wjNiVwKSoMGyX6MKEh/PNBdn2M8M7lYS
 P3Yps68pHxY9rT9/pGPZl46CA/tpWm8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-ksoH-B_qNCu3IHo5ypFuDQ-1; Tue,
 05 Dec 2023 13:20:40 -0500
X-MC-Unique: ksoH-B_qNCu3IHo5ypFuDQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D0ACB386A0AC;
 Tue,  5 Dec 2023 18:20:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 329D9492BC6;
 Tue,  5 Dec 2023 18:20:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Paul Durrant <paul@xen.org>, Ari Sundholm <ari@tuxera.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Wen Congyang <wencongyang2@huawei.com>, Alberto Garcia <berto@igalia.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Peter Xu <peterx@redhat.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 Fam Zheng <fam@euphon.net>, Leonardo Bras <leobras@redhat.com>,
 David Hildenbrand <david@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 08/14] scsi: remove AioContext locking
Date: Tue,  5 Dec 2023 13:20:05 -0500
Message-ID: <20231205182011.1976568-9-stefanha@redhat.com>
In-Reply-To: <20231205182011.1976568-1-stefanha@redhat.com>
References: <20231205182011.1976568-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The AioContext lock no longer has any effect. Remove it.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/hw/virtio/virtio-scsi.h | 14 --------------
 hw/scsi/scsi-bus.c              |  2 --
 hw/scsi/scsi-disk.c             | 31 +++++--------------------------
 hw/scsi/virtio-scsi.c           | 18 ------------------
 4 files changed, 5 insertions(+), 60 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index da8cb928d9..7f0573b1bf 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -101,20 +101,6 @@ struct VirtIOSCSI {
     uint32_t host_features;
 };
 
-static inline void virtio_scsi_acquire(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_acquire(s->ctx);
-    }
-}
-
-static inline void virtio_scsi_release(VirtIOSCSI *s)
-{
-    if (s->ctx) {
-        aio_context_release(s->ctx);
-    }
-}
-
 void virtio_scsi_common_realize(DeviceState *dev,
                                 VirtIOHandleOutput ctrl,
                                 VirtIOHandleOutput evt,
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f3ec11f892..df68a44b6a 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1731,9 +1731,7 @@ void scsi_device_purge_requests(SCSIDevice *sdev, SCSISense sense)
 {
     scsi_device_for_each_req_async(sdev, scsi_device_purge_one_req, NULL);
 
-    aio_context_acquire(blk_get_aio_context(sdev->conf.blk));
     blk_drain(sdev->conf.blk);
-    aio_context_release(blk_get_aio_context(sdev->conf.blk));
     scsi_device_set_ua(sdev, sense);
 }
 
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index a5048e0aaf..61be3d395a 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2339,14 +2339,10 @@ static void scsi_disk_reset(DeviceState *dev)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev.qdev, dev);
     uint64_t nb_sectors;
-    AioContext *ctx;
 
     scsi_device_purge_requests(&s->qdev, SENSE_CODE(RESET));
 
-    ctx = blk_get_aio_context(s->qdev.conf.blk);
-    aio_context_acquire(ctx);
     blk_get_geometry(s->qdev.conf.blk, &nb_sectors);
-    aio_context_release(ctx);
 
     nb_sectors /= s->qdev.blocksize / BDRV_SECTOR_SIZE;
     if (nb_sectors) {
@@ -2545,15 +2541,13 @@ static void scsi_unrealize(SCSIDevice *dev)
 static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    AioContext *ctx = NULL;
+
     /* can happen for devices without drive. The error message for missing
      * backend will be issued in scsi_realize
      */
     if (s->qdev.conf.blk) {
-        ctx = blk_get_aio_context(s->qdev.conf.blk);
-        aio_context_acquire(ctx);
         if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
-            goto out;
+            return;
         }
     }
     s->qdev.blocksize = s->qdev.conf.logical_block_size;
@@ -2562,16 +2556,11 @@ static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
         s->product = g_strdup("QEMU HARDDISK");
     }
     scsi_realize(&s->qdev, errp);
-out:
-    if (ctx) {
-        aio_context_release(ctx);
-    }
 }
 
 static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    AioContext *ctx;
     int ret;
     uint32_t blocksize = 2048;
 
@@ -2587,8 +2576,6 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
         blocksize = dev->conf.physical_block_size;
     }
 
-    ctx = blk_get_aio_context(dev->conf.blk);
-    aio_context_acquire(ctx);
     s->qdev.blocksize = blocksize;
     s->qdev.type = TYPE_ROM;
     s->features |= 1 << SCSI_DISK_F_REMOVABLE;
@@ -2596,7 +2583,6 @@ static void scsi_cd_realize(SCSIDevice *dev, Error **errp)
         s->product = g_strdup("QEMU CD-ROM");
     }
     scsi_realize(&s->qdev, errp);
-    aio_context_release(ctx);
 }
 
 
@@ -2727,7 +2713,6 @@ static int get_device_type(SCSIDiskState *s)
 static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 {
     SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, dev);
-    AioContext *ctx;
     int sg_version;
     int rc;
 
@@ -2742,9 +2727,6 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
                           "be removed in a future version");
     }
 
-    ctx = blk_get_aio_context(s->qdev.conf.blk);
-    aio_context_acquire(ctx);
-
     /* check we are using a driver managing SG_IO (version 3 and after) */
     rc = blk_ioctl(s->qdev.conf.blk, SG_GET_VERSION_NUM, &sg_version);
     if (rc < 0) {
@@ -2752,18 +2734,18 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
         if (rc != -EPERM) {
             error_append_hint(errp, "Is this a SCSI device?\n");
         }
-        goto out;
+        return;
     }
     if (sg_version < 30000) {
         error_setg(errp, "scsi generic interface too old");
-        goto out;
+        return;
     }
 
     /* get device type from INQUIRY data */
     rc = get_device_type(s);
     if (rc < 0) {
         error_setg(errp, "INQUIRY failed");
-        goto out;
+        return;
     }
 
     /* Make a guess for the block size, we'll fix it when the guest sends.
@@ -2783,9 +2765,6 @@ static void scsi_block_realize(SCSIDevice *dev, Error **errp)
 
     scsi_realize(&s->qdev, errp);
     scsi_generic_read_device_inquiry(&s->qdev);
-
-out:
-    aio_context_release(ctx);
 }
 
 typedef struct SCSIBlockReq {
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 4f8d35facc..ca365a70e9 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -642,9 +642,7 @@ static void virtio_scsi_handle_ctrl(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
 
-    virtio_scsi_acquire(s);
     virtio_scsi_handle_ctrl_vq(s, vq);
-    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_complete_cmd_req(VirtIOSCSIReq *req)
@@ -882,9 +880,7 @@ static void virtio_scsi_handle_cmd(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
 
-    virtio_scsi_acquire(s);
     virtio_scsi_handle_cmd_vq(s, vq);
-    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_get_config(VirtIODevice *vdev,
@@ -1031,9 +1027,7 @@ static void virtio_scsi_handle_event(VirtIODevice *vdev, VirtQueue *vq)
         return;
     }
 
-    virtio_scsi_acquire(s);
     virtio_scsi_handle_event_vq(s, vq);
-    virtio_scsi_release(s);
 }
 
 static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
@@ -1052,9 +1046,7 @@ static void virtio_scsi_change(SCSIBus *bus, SCSIDevice *dev, SCSISense sense)
             },
         };
 
-        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, &info);
-        virtio_scsi_release(s);
     }
 }
 
@@ -1071,17 +1063,13 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     VirtIODevice *vdev = VIRTIO_DEVICE(hotplug_dev);
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
     SCSIDevice *sd = SCSI_DEVICE(dev);
-    AioContext *old_context;
     int ret;
 
     if (s->ctx && !s->dataplane_fenced) {
         if (blk_op_is_blocked(sd->conf.blk, BLOCK_OP_TYPE_DATAPLANE, errp)) {
             return;
         }
-        old_context = blk_get_aio_context(sd->conf.blk);
-        aio_context_acquire(old_context);
         ret = blk_set_aio_context(sd->conf.blk, s->ctx, errp);
-        aio_context_release(old_context);
         if (ret < 0) {
             return;
         }
@@ -1097,10 +1085,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
             },
         };
 
-        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, &info);
         scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
-        virtio_scsi_release(s);
     }
 }
 
@@ -1122,17 +1108,13 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     qdev_simple_device_unplug_cb(hotplug_dev, dev, errp);
 
     if (s->ctx) {
-        virtio_scsi_acquire(s);
         /* If other users keep the BlockBackend in the iothread, that's ok */
         blk_set_aio_context(sd->conf.blk, qemu_get_aio_context(), NULL);
-        virtio_scsi_release(s);
     }
 
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
-        virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, &info);
         scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
-        virtio_scsi_release(s);
     }
 }
 
-- 
2.43.0


