Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6775C73DAF3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 11:13:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDiHj-0002Ea-Ax; Mon, 26 Jun 2023 05:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHZ-0002D3-Hv
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:14 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qDiHX-0006A6-Dt
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 05:13:13 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51d80c5c834so3266313a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 02:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1687770789; x=1690362789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65D9pazVGNczpCkR9CBdv0sj2pWpFpF69/C0zCu5CI8=;
 b=h4UqSeHsJWnMGy4TXB0ayW1TI5HPZcYujGcUS3se2K5hUz3FOr0wbRSAYBI8++Yp5o
 o8nshl5u8R4Fyb5Iwfg/VWujO43cbDjaE9/V4Vh4TOAiyC3RzWs6Ks+4QtX7oZJXX9bi
 DC3+je5Ux4Er+wpUMsJfrHxKnJBE2orGCjsptYhPBDdexFhVgBdWgInrB+4Ub7SywyoV
 JEl9Ai3Vea5jsHe5FDb7xXuqy7NpS712CFkzZrW+ZcPpYz0y0Cn4YhA76GXFpGFeP5IZ
 66W8JTPsYF2PO5PdPWXga8NC3CpG2TVHB2CoIYLavwbW4sOOET13V3BmuNqiE01XAioK
 gVqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687770789; x=1690362789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65D9pazVGNczpCkR9CBdv0sj2pWpFpF69/C0zCu5CI8=;
 b=dtn6imajwcMbGh9dhHFtHpdFbSDxBbTVdplsFuFtUHW6G1ZBvlLHns0Al/jLyCD3pw
 cCTuPjcOvgh0F+AHYY1kADyD2ihlfbmHeSHRqlyqTJmIZwq4QbxqL7zNYIaEX6zyAo7z
 faAelBN4hS6UGk9GU4aauKz3bPxcKOAZCCt195IksVwbrlQqXkNKtE21HqU/U1ziXo2e
 mGDD5op13mXFv/uC4/tbiB87W1YlncNc54uaG9j4/RBe/4Jw4q2Mt1Rj8+cFrOkkJ1w+
 nuM1jZie17bydqMZNsfDE3tQ06Dabmog9w/QBb2q8Gfyv2GimSeQyr25tpOaNxfq6ocE
 jykg==
X-Gm-Message-State: AC+VfDz0vXoXWfI6qjqSvGf/KcN2AqWYVwxcD/UskwkGyyeWEVkSHsXU
 6UG1SR/BnWB+fU4G/KBWgVZVWw==
X-Google-Smtp-Source: ACHHUZ65v69Gl+CVc1ylg9r0sksEOv1dg+OQafM120nj3A/IfU9k1ZjElZbT9kpcPZ8n1F3DzGnDEg==
X-Received: by 2002:a05:6402:50cd:b0:516:a1d5:846f with SMTP id
 h13-20020a05640250cd00b00516a1d5846fmr30843688edb.1.1687770788847; 
 Mon, 26 Jun 2023 02:13:08 -0700 (PDT)
Received: from localhost.localdomain.cc ([62.4.35.38])
 by smtp.gmail.com with ESMTPSA id
 i23-20020a50fc17000000b0051c7b5692easm2597693edr.7.2023.06.26.02.13.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 02:13:08 -0700 (PDT)
From: Viktor Prutyanov <viktor@daynix.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com,
 Viktor Prutyanov <viktor@daynix.com>
Subject: [PATCH v5 1/2] vhost: register and change IOMMU flag depending on
 Device-TLB state
Date: Mon, 26 Jun 2023 12:12:57 +0300
Message-Id: <20230626091258.24453-2-viktor@daynix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230626091258.24453-1-viktor@daynix.com>
References: <20230626091258.24453-1-viktor@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::52c;
 envelope-from=viktor@daynix.com; helo=mail-ed1-x52c.google.com
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
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost-stub.c    |  4 ++++
 hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
 include/hw/virtio/vhost.h |  1 +
 3 files changed, 31 insertions(+), 12 deletions(-)

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


