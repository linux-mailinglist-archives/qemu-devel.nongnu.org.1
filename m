Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9D710CAB
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AXc-0003db-Do; Thu, 25 May 2023 08:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXX-0003ct-Fk
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:57:59 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1q2AXV-0004oC-Fg
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:57:59 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f1411e8111so2492829e87.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1685019476; x=1687611476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kr8tbHJTibD9N/kYZQtUA+ePJsrH6dqFoUFs/8Ufdic=;
 b=A4pSjeJiSsyiFIvQrGCA3v74x9dg+cNFwdtpR6IvkdNtykQthvQSdLi8H/QPt3asTV
 Hz/C0i/k9LV5UsHMovIdKpohfYcBn9TriI/9eDAZ9/AMDlA4FOiJfJPo7qJkrzdIBbIF
 5TPqYDcTI++HQhsiWLwsTY0MAX/bjcMkd2KYDLLJ4CsD0x2E1VKYRX2fnixOtJgQXaRG
 nsSwm8tBKUjMy3ppiBcGk4krFMJLuXybTU4DoALE8Sh1rQGoo1dPhAg6QmVcq7WkBq7M
 zUKWF9SAVKzOfHh4FFrTtkCDLbJdaTJy8rT+DYkUJmxovRbbdyhGXENHpTjFE90GVKTX
 sZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685019476; x=1687611476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kr8tbHJTibD9N/kYZQtUA+ePJsrH6dqFoUFs/8Ufdic=;
 b=iGwDat6bRrAKhv2sW8LDKERoZxeQqC6ehWoaFvz2EjVcHEos5NTuJho/cdCjaCwa2+
 /cL9hQbE6KgWp/oDLg0hDHZRIG/JnoH6nlXXAy3CwVW6kYWepLvGMNuBTNyABx2DnW2h
 zQBHfYAAZjr5LZVY8VFVyjR/1v9kr2K7qZUzYbiN1CYggND+CDDhZo8yTg2z7IXIx41O
 zgAve0ZXJYT7O27mSfHWTwdpfqhKFJrtM1YMoflg20wjEvoVHMaCAjUntg3mfn+j2Sex
 hq69BflNR0nAYevTSQzHZnt+vGQHc63x3ENrjhV+h8bax24eBVvnotDQxBXanWcR7j40
 4Hjg==
X-Gm-Message-State: AC+VfDxmQXsnFOyjdFm1LwgWkxVkNMGWMmVNK7urbvBz7aWEBsVyl4/+
 V8cKtVA04phbV7NK9N8Z+NsZEw==
X-Google-Smtp-Source: ACHHUZ7GGuzIkXnAwYko4KbOBi9+RWFfI9jIz5PzX4l8k8TQssoKQhaxSdxh2vsnKF7iCpQEM5l6og==
X-Received: by 2002:a19:c517:0:b0:4f1:dcd2:ab6d with SMTP id
 w23-20020a19c517000000b004f1dcd2ab6dmr6097368lfe.28.1685019475852; 
 Thu, 25 May 2023 05:57:55 -0700 (PDT)
Received: from localhost.Dlink ([94.188.60.65])
 by smtp.gmail.com with ESMTPSA id
 r9-20020ac25a49000000b004f1430ee142sm209509lfn.17.2023.05.25.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 05:57:55 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v4 1/2] vhost: register and change IOMMU flag depending on
 Device-TLB state
Date: Thu, 25 May 2023 15:57:41 +0300
Message-Id: <20230525125742.4190-2-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230525125742.4190-1-viktor@daynix.com>
References: <20230525125742.4190-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::12e;
 envelope-from=viktor@daynix.com; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The guest can disable or never enable Device-TLB. In these cases,
it can't be used even if enabled in QEMU. So, check Device-TLB state
before registering IOMMU notifier and select unmap flag depending on
that. Also, implement a way to change IOMMU notifier flag if Device-TLB
state is changed.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2001312
Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
---
 hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
 include/hw/virtio/vhost.h |  1 +
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 23da579ce2..e48507b5a1 100644
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
index f7f10c8fb7..6a173cb9fa 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -320,6 +320,7 @@ bool vhost_has_free_slot(void);
 int vhost_net_set_backend(struct vhost_dev *hdev,
                           struct vhost_vring_file *file);
 
+void vhost_toggle_device_iotlb(VirtIODevice *vdev);
 int vhost_device_iotlb_miss(struct vhost_dev *dev, uint64_t iova, int write);
 
 int vhost_virtqueue_start(struct vhost_dev *dev, struct VirtIODevice *vdev,
-- 
2.21.0


