Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7495F7B7661
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 03:47:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnqxa-0000vw-1I; Tue, 03 Oct 2023 21:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxP-0000uz-F0
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qnqxN-0003Rt-2n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 21:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696383944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sNeRgr8beYooE2rReqcWKNErsfwoDkn7m7ZjPHZKTys=;
 b=A+fXQJQn3BkmoJzUu1r96yTuGZC7/c2D75EHL0z4fZyuzADR7ZkJfRbfjG1y6UBZg7DmeS
 q03s0INxeVDvTEBYM8uC7jEKfXixxpc2TF48yHoPbqvLb2AGQICdu1hFwTa1nUzg4qgigI
 S/7HghTpKw2GMUnv0YsjlrJ35UXwvqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-IiXgTkn4ND6ObMnl9AuDdw-1; Tue, 03 Oct 2023 21:45:41 -0400
X-MC-Unique: IiXgTkn4ND6ObMnl9AuDdw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC0DC8032F6;
 Wed,  4 Oct 2023 01:45:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.46])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2B72026D4B;
 Wed,  4 Oct 2023 01:45:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, hreitz@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 eperezma@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/3] virtio: call ->vhost_reset_device() during reset
Date: Tue,  3 Oct 2023 21:45:32 -0400
Message-ID: <20231004014532.1228637-4-stefanha@redhat.com>
In-Reply-To: <20231004014532.1228637-1-stefanha@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

vhost-user-scsi has a VirtioDeviceClass->reset() function that calls
->vhost_reset_device(). The other vhost devices don't notify the vhost
device upon reset.

Stateful vhost devices may need to handle device reset in order to free
resources or prevent stale device state from interfering after reset.

Call ->vhost_device_reset() from virtio_reset() so that that vhost
devices are notified of device reset.

This patch affects behavior as follows:
- vhost-kernel: No change in behavior since ->vhost_reset_device() is
  not implemented.
- vhost-user: back-ends that negotiate
  VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
  VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
  no change in behavior. DPDK, SPDK, libvhost-user, and the
  vhost-user-backend crate do not negotiate
  VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
- vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 meson.build               |  1 +
 include/hw/virtio/vhost.h | 10 ++++++++++
 hw/scsi/vhost-user-scsi.c | 11 -----------
 hw/virtio/vhost.c         |  9 +++++++++
 hw/virtio/virtio.c        |  4 ++++
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/meson.build b/meson.build
index 21a1bc03f8..dd5e61915a 100644
--- a/meson.build
+++ b/meson.build
@@ -2143,6 +2143,7 @@ config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
+config_host_data.set('CONFIG_VHOST', have_vhost)
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
 config_host_data.set('CONFIG_VHOST_NET_USER', have_vhost_net_user)
 config_host_data.set('CONFIG_VHOST_NET_VDPA', have_vhost_net_vdpa)
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a173cb9fa..14621f9e79 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -338,4 +338,14 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
 int vhost_dev_get_inflight(struct vhost_dev *dev, uint16_t queue_size,
                            struct vhost_inflight *inflight);
 bool vhost_dev_has_iommu(struct vhost_dev *dev);
+
+#ifdef CONFIG_VHOST
+int vhost_reset_device(struct vhost_dev *hdev);
+#else
+static inline int vhost_reset_device(struct vhost_dev *hdev)
+{
+    return -ENOSYS;
+}
+#endif /* CONFIG_VHOST */
+
 #endif
diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 8582b2e8ab..6917a748bb 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -66,16 +66,6 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
     }
 }
 
-static void vhost_user_scsi_reset(VirtIODevice *vdev)
-{
-    VHostSCSICommon *vsc = VHOST_SCSI_COMMON(vdev);
-    struct vhost_dev *dev = &vsc->dev;
-
-    if (dev->vhost_ops->vhost_reset_device) {
-        dev->vhost_ops->vhost_reset_device(dev);
-    }
-}
-
 static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
@@ -195,7 +185,6 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->get_features = vhost_scsi_common_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
-    vdc->reset = vhost_user_scsi_reset;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
 }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index e2f6ffb446..6003e50e83 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2087,3 +2087,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
     return -ENOSYS;
 }
+
+int vhost_reset_device(struct vhost_dev *hdev)
+{
+    if (hdev->vhost_ops->vhost_reset_device) {
+        return hdev->vhost_ops->vhost_reset_device(hdev);
+    }
+
+    return -ENOSYS;
+}
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4577f3f5b3..d863ffd5d6 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2121,6 +2121,10 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
+    if (vdev->vhost_started) {
+        vhost_reset_device(k->get_vhost(vdev));
+    }
+
     if (k->reset) {
         k->reset(vdev);
     }
-- 
2.41.0


