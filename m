Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E78B7708DF
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0IN-0000Le-Hw; Fri, 04 Aug 2023 15:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IJ-0000K7-Tj; Fri, 04 Aug 2023 15:17:03 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0IH-0006uH-Jm; Fri, 04 Aug 2023 15:17:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7434518456;
 Fri,  4 Aug 2023 22:17:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E5C971B899;
 Fri,  4 Aug 2023 22:16:49 +0300 (MSK)
Received: (nullmailer pid 1875699 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Viktor Prutyanov <viktor@daynix.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 36/63] vhost: register and change IOMMU flag depending
 on Device-TLB state
Date: Fri,  4 Aug 2023 22:16:19 +0300
Message-Id: <20230804191647.1875608-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Viktor Prutyanov <viktor@daynix.com>

The guest can disable or never enable Device-TLB. In these cases,
it can't be used even if enabled in QEMU. So, check Device-TLB state
before registering IOMMU notifier and select unmap flag depending on
that. Also, implement a way to change IOMMU notifier flag if Device-TLB
state is changed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2001312
Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20230626091258.24453-2-viktor@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit ee071f67f7a103c66f85f68ffe083712929122e3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index c175148fce..aa858ef3fb 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -15,3 +15,7 @@ bool vhost_user_init(VhostUserState *user, CharBackend *chr, Error **errp)
 void vhost_user_cleanup(VhostUserState *user)
 {
 }
+
+void vhost_toggle_device_iotlb(VirtIODevice *vdev)
+{
+}
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 69a7b5592a..480e7f8048 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -781,7 +781,6 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     Int128 end;
     int iommu_idx;
     IOMMUMemoryRegion *iommu_mr;
-    int ret;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -796,7 +795,9 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr,
                                                    MEMTXATTRS_UNSPECIFIED);
     iommu_notifier_init(&iommu->n, vhost_iommu_unmap_notify,
-                        IOMMU_NOTIFIER_DEVIOTLB_UNMAP,
+                        dev->vdev->device_iotlb_enabled ?
+                            IOMMU_NOTIFIER_DEVIOTLB_UNMAP :
+                            IOMMU_NOTIFIER_UNMAP,
                         section->offset_within_region,
                         int128_get64(end),
                         iommu_idx);
@@ -804,16 +805,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     iommu->iommu_offset = section->offset_within_address_space -
                           section->offset_within_region;
     iommu->hdev = dev;
-    ret = memory_region_register_iommu_notifier(section->mr, &iommu->n, NULL);
-    if (ret) {
-        /*
-         * Some vIOMMUs do not support dev-iotlb yet.  If so, try to use the
-         * UNMAP legacy message
-         */
-        iommu->n.notifier_flags = IOMMU_NOTIFIER_UNMAP;
-        memory_region_register_iommu_notifier(section->mr, &iommu->n,
-                                              &error_fatal);
-    }
+    memory_region_register_iommu_notifier(section->mr, &iommu->n,
+                                          &error_fatal);
     QLIST_INSERT_HEAD(&dev->iommu_list, iommu, iommu_next);
     /* TODO: can replay help performance here? */
 }
@@ -841,6 +834,27 @@ static void vhost_iommu_region_del(MemoryListener *listener,
     }
 }
 
+void vhost_toggle_device_iotlb(VirtIODevice *vdev)
+{
+    VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
+    struct vhost_dev *dev;
+    struct vhost_iommu *iommu;
+
+    if (vdev->vhost_started) {
+        dev = vdc->get_vhost(vdev);
+    } else {
+        return;
+    }
+
+    QLIST_FOREACH(iommu, &dev->iommu_list, iommu_next) {
+        memory_region_unregister_iommu_notifier(iommu->mr, &iommu->n);
+        iommu->n.notifier_flags = vdev->device_iotlb_enabled ?
+                IOMMU_NOTIFIER_DEVIOTLB_UNMAP : IOMMU_NOTIFIER_UNMAP;
+        memory_region_register_iommu_notifier(iommu->mr, &iommu->n,
+                                              &error_fatal);
+    }
+}
+
 static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
                                     struct vhost_virtqueue *vq,
                                     unsigned idx, bool enable_log)
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index a52f273347..0a07f4435e 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
+void vhost_toggle_device_iotlb(VirtIODevice *vdev);
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
-- 
2.39.2


