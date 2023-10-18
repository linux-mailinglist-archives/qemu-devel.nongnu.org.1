Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 731A27CE264
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vM-0005xn-Cb; Wed, 18 Oct 2023 11:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uK-00044G-Kg
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8uH-00071p-5t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsLh7ia6XRW9dnJHrit24Lv0bVF86UyjHpRok70ZRQs=;
 b=L5fNP8/bUsedZQZmm9pmf07fAWYry1rTPWxomh93+DfoHhrI/RrVTZMa4LcZM/38NJEM9v
 fwzc+lxHd5Uk0GFf2GBmbGnCEgUfBDcftdtI/1tjoKYhGwZOgXwSEuFDJuTtj7528igUbs
 zmj5H2j7TNqc0zxD+khYC2voEr2dJPU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-GxmzIErtO86OYowOTaogxg-1; Wed, 18 Oct 2023 11:56:23 -0400
X-MC-Unique: GxmzIErtO86OYowOTaogxg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so4245796f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644581; x=1698249381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsLh7ia6XRW9dnJHrit24Lv0bVF86UyjHpRok70ZRQs=;
 b=ezzYtedN1ReLrgVWpeNQ25oqv2jgwbRr+v99gmcbIH1Zi75x7wynT1DNeHoMHi2Xi8
 WO+6hvivbRTmUlk6eeT5QntVxgHvAT/we5LyFG+LxMbBk0KSrKVFLSj+tPYFOTcGxrXs
 7oAmHKrqyI2Fw/dDcUIQIVRrBePAC7BUk8pHO0fXA0mjzlHhOko6uCBksnZCMI93yBbW
 7GXIsoYZ161e7G3CT3cHEhY2kf19YnHOFCAvRi8CI8jsB+Ys2zNMCYTnHWvbBPoJA0SM
 Pk0N4mvmcwfRNnXq02z6gCWIL6pYqp/+DC6h32BeXW8l/pUrGNOghwyFXYDp3Jmgz/jK
 eePw==
X-Gm-Message-State: AOJu0YwZ2C3ZRtQ4CBHJpDJDWePCRyu+wkIisFzIE40RjvaQSDC18Ly1
 vluhRYIlh6xcHCDa89Hsl/9E7fusg86MsCppmL3vfNVQXgTf4Ul5NEZ552VfyBjjp/9vLpN8uSt
 6FkvZWrPqbhTxMPHE1TFlgnGGWbL6FIBSWk/D2bwGFNIDvyaG8B7vlniISpjMZ8Z8jhakaBU=
X-Received: by 2002:a5d:6087:0:b0:32d:9b80:e2c6 with SMTP id
 w7-20020a5d6087000000b0032d9b80e2c6mr4205928wrt.26.1697644581453; 
 Wed, 18 Oct 2023 08:56:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwA69fOc+1X4JF5MdB4cd2D+ED0XqJNnMXun73yih18Fg5bJ5Ca9A0Gm2xxNvKt9dCvKoP0w==
X-Received: by 2002:a5d:6087:0:b0:32d:9b80:e2c6 with SMTP id
 w7-20020a5d6087000000b0032d9b80e2c6mr4205904wrt.26.1697644581081; 
 Wed, 18 Oct 2023 08:56:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a5d4a4e000000b0032196c508e3sm2362620wrs.53.2023.10.18.08.56.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:56:20 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:56:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Hanna Czenczek <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 39/83] virtio: call ->vhost_reset_device() during reset
Message-ID: <d96f0bf8e4edf8b4578cc1c737d354435a06080e.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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
Message-Id: <20231004014532.1228637-4-stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/hw/virtio/vhost.h | 10 ++++++++++
 hw/scsi/vhost-user-scsi.c | 11 -----------
 hw/virtio/vhost.c         |  9 +++++++++
 hw/virtio/virtio.c        |  4 ++++
 meson.build               |  1 +
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index c7e5467693..00e0a669b8 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -339,4 +339,14 @@ int vhost_dev_set_inflight(struct vhost_dev *dev,
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
index 78aef4765f..b7c6100f3e 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -62,16 +62,6 @@ static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
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
@@ -191,7 +181,6 @@ static void vhost_user_scsi_class_init(ObjectClass *klass, void *data)
     vdc->get_features = vhost_scsi_common_get_features;
     vdc->set_config = vhost_scsi_common_set_config;
     vdc->set_status = vhost_user_scsi_set_status;
-    vdc->reset = vhost_user_scsi_reset;
     fwc->get_dev_path = vhost_scsi_common_get_fw_dev_path;
 }
 
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 9f37206ba0..92a6933f66 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -2154,3 +2154,12 @@ int vhost_net_set_backend(struct vhost_dev *hdev,
 
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
index 6facd64fbc..fb24bc927b 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2136,6 +2136,10 @@ void virtio_reset(void *opaque)
         vdev->device_endian = virtio_default_endian();
     }
 
+    if (vdev->vhost_started) {
+        vhost_reset_device(k->get_vhost(vdev));
+    }
+
     if (k->reset) {
         k->reset(vdev);
     }
diff --git a/meson.build b/meson.build
index e0d1f84b26..cbee764817 100644
--- a/meson.build
+++ b/meson.build
@@ -2134,6 +2134,7 @@ config_host_data.set('CONFIG_TPM', have_tpm)
 config_host_data.set('CONFIG_TSAN', get_option('tsan'))
 config_host_data.set('CONFIG_USB_LIBUSB', libusb.found())
 config_host_data.set('CONFIG_VDE', vde.found())
+config_host_data.set('CONFIG_VHOST', have_vhost)
 config_host_data.set('CONFIG_VHOST_NET', have_vhost_net)
 config_host_data.set('CONFIG_VHOST_NET_USER', have_vhost_net_user)
 config_host_data.set('CONFIG_VHOST_NET_VDPA', have_vhost_net_vdpa)
-- 
MST


