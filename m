Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D73C374E1AA
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzty-0002pf-IX; Mon, 10 Jul 2023 19:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztw-0002pH-EB
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIztu-00046k-Q4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HBXk/tr6uvd4qdoz2s4YWQLgUA//BbIN1kbLdfETPAE=;
 b=DMZl99fa2slFn8mUz9M9MoWc27vjWnAfUVR4O8x/Nn1P8lIz4c2Yobe3/lNt7yy1+bYjZp
 DxdCUCXMV7EBYISaex9A98OH6tJX1RZrWZLeWGBQMj51oqxZOnDZvBLq+ogrUcs0x8xoVh
 vxsx+sWGfqBx3OpP3hJqnYFjk5fFDcU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-dWdqLP08O7-tlm3qm_0chA-1; Mon, 10 Jul 2023 19:02:36 -0400
X-MC-Unique: dWdqLP08O7-tlm3qm_0chA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbb0fdd060so31128435e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030155; x=1691622155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HBXk/tr6uvd4qdoz2s4YWQLgUA//BbIN1kbLdfETPAE=;
 b=kDuEn7JZGQ9GgovWbn1L/yrNQjpjnUBaMx6bW1bDrdQJj/KdXNgxJPpJisbMUXcf/T
 DxYxLJi9gYtlesQtal4icE1/RyGDWKuvnoBaAyO5EfSbxxBQ5S/M5SzF/9YeqdnU4GKO
 zLGC54VjRl16aqZQcq6IwLJPZCYFhvKusl8x/tLPkP22mSwjhntd23Fj7CVbb1Clfwo1
 2Mi5ShgQw/sFYTGDbZ7cjv/5QNDkfFs63d/iaD+bmORaQ0KAsAqjmkRpHy82fAJnxZHz
 gORe9rGKB0TMkvEk4wmva6vKdm85SrvBXS24uN/NusBRjpOK1aTCE0nltHuHfOP/ssuF
 mo0Q==
X-Gm-Message-State: ABy/qLZSI2wt1DddDcJsv5SoJW+6mjFYrHmdn31QhxqM7/2QYPIjw1bQ
 kwrS91Z+L6yXtllG4+5u/Afqr4o0QomeXM8nEykuHRuUk3Yz3+3LWU21l0ztUbvjmzmA5CiKIDG
 Rd7LlN9QUuvGVVPSk6ZNbYJho3CE4LY2zil0CrpJ4u8/XSEwhzCq67XspF5Z3KQ5mXxO8
X-Received: by 2002:a1c:f713:0:b0:3f8:f4f3:82ec with SMTP id
 v19-20020a1cf713000000b003f8f4f382ecmr13687793wmh.8.1689030154752; 
 Mon, 10 Jul 2023 16:02:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNpx1nNcAnLSa6CB6YiiKBzg+S2tvs2Fpdz8H6LR+3H+iCAh9ZvzCh/A6L8Gi4B/lFeYR0nQ==
X-Received: by 2002:a1c:f713:0:b0:3f8:f4f3:82ec with SMTP id
 v19-20020a1cf713000000b003f8f4f382ecmr13687773wmh.8.1689030154420; 
 Mon, 10 Jul 2023 16:02:34 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v15-20020a1cf70f000000b003fa8158135esm11397594wmh.11.2023.07.10.16.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:02:33 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:02:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Viktor Prutyanov <viktor@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 02/66] vhost: register and change IOMMU flag depending on
 Device-TLB state
Message-ID: <ee071f67f7a103c66f85f68ffe083712929122e3.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/hw/virtio/vhost.h |  1 +
 hw/virtio/vhost-stub.c    |  4 ++++
 hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
 3 files changed, 31 insertions(+), 12 deletions(-)

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
index 82394331bf..abf0d03c8d 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -780,7 +780,6 @@ static void vhost_iommu_region_add(MemoryListener *listener,
     Int128 end;
     int iommu_idx;
     IOMMUMemoryRegion *iommu_mr;
-    int ret;
 
     if (!memory_region_is_iommu(section->mr)) {
         return;
@@ -795,7 +794,9 @@ static void vhost_iommu_region_add(MemoryListener *listener,
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
@@ -803,16 +804,8 @@ static void vhost_iommu_region_add(MemoryListener *listener,
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
@@ -840,6 +833,27 @@ static void vhost_iommu_region_del(MemoryListener *listener,
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
-- 
MST


