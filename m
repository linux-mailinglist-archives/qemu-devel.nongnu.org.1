Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7217D0199
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:32:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhP-0000TS-Pw; Thu, 19 Oct 2023 14:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfg-00073W-A1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfe-0000rE-Jz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fsLh7ia6XRW9dnJHrit24Lv0bVF86UyjHpRok70ZRQs=;
 b=aHr5jwN9/azps51BdrL8cGEWyHLwIIDfkzmGMW2v49MdnoRBrU/sfi/VQ1o3Mw7axJelSr
 9mOsFe3HbVOolu6XsPqgRiG1OmC5KDtJl17HdMbzcdpYsDpRhLq84qO55JUjk6Pg5qoRXJ
 gbkuwW/2B8N+lJL4PgaEdmLhVyA1tWE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-LebOQAXfNtG6N58jkLZKcQ-1; Thu, 19 Oct 2023 14:22:46 -0400
X-MC-Unique: LebOQAXfNtG6N58jkLZKcQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d9751ca2cso4298539f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739764; x=1698344564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsLh7ia6XRW9dnJHrit24Lv0bVF86UyjHpRok70ZRQs=;
 b=OXWIVEPlnP7bpgLuiZt517RMs1mQ4s9DgGY2stQwi7T1Y3T8r1V3BtKMGgWEXL+IzV
 wXLOdbHYgxR2J0XQPD3UTsf8TC195zEVxoMkcKnL2R0MmtbWo2uMIp2OA+jfcpaA8p/v
 X8ikSBUH05fPtiIed4vSX8PzCUNEss3QdR5Y30vlsjuzO4+dN+ieqCuhj4/tTzN6TD4Q
 e5X4iUtG8mx2XMl98nFAWSNaHYQ2Hk4Fc+AgC96uamh+EKVfokUqKIUSwojQVjtp3+P0
 crNuw3JOz0WCq6AGpdWeddTwsreIo+vDlirxFy0WDj8L8LM/ZeIp4zlHhFjG/FHyhwvt
 L4xg==
X-Gm-Message-State: AOJu0Ywup7ubPcBiHWsmFG0vRBcu7RM53iLf4C1DdbNO2nEPVpTgzzU7
 P9Q8A+CjEEjNIzI79WMJEtB5//1wI776ICClyd9YSYaid1fyL++cD72FMSqMzMr5A7YfxazST4i
 LcTt/IUx1rzRHCzFjbD0cWSE92YgdC72aCNgAIcPq0qabZUKUmOK1KHZrlBnTGOhExgEC
X-Received: by 2002:adf:f7d1:0:b0:32d:89c5:45b6 with SMTP id
 a17-20020adff7d1000000b0032d89c545b6mr2216775wrq.38.1697739764111; 
 Thu, 19 Oct 2023 11:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeXJdri2FDqXjhuUgwmz76D4ESaCHB2zV12TyElNdojSX97JY7f/Cm4hvBw3tORkDtlR/GAA==
X-Received: by 2002:adf:f7d1:0:b0:32d:89c5:45b6 with SMTP id
 a17-20020adff7d1000000b0032d89c545b6mr2216757wrq.38.1697739763766; 
 Thu, 19 Oct 2023 11:22:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 e11-20020adffd0b000000b0032dbf26e7aesm4975157wrr.65.2023.10.19.11.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:43 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:41 -0400
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
Subject: [PULL v2 34/78] virtio: call ->vhost_reset_device() during reset
Message-ID: <b7e9e78ade053308ef52b8dadeba15bd55623d20.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


