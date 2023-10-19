Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A53AB7CFCFA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:39:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtU7l-0006p7-Aj; Thu, 19 Oct 2023 10:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7j-0006oN-4A
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtU7h-0000Mq-KQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697726141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSZoggcrMrR23J5/Xh2uuJObVTFIG5OUw6hy0Fy1Dy0=;
 b=UQOkT/KuDpiUlTwztMPI2mpXLymCs7QdsmMENpycMwHmQdHsJ5YR415qZUFZdJYlVzYQCL
 nOgoIJqpLRevoDv7tXckfX2nLYKS6nHV4GecfIa8197QqzaEcBIUBYbBOZervqHXr7TqYo
 U791y7ih8yNT3fIG22fqA2kVaNXhNmc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-9tbzNri0MNmE9PcKwG1v6Q-1; Thu, 19 Oct 2023 10:35:38 -0400
X-MC-Unique: 9tbzNri0MNmE9PcKwG1v6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCE6F185A79C;
 Thu, 19 Oct 2023 14:35:36 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B80BC15BB8;
 Thu, 19 Oct 2023 14:35:34 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Shannon <shannon.nelson@amd.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Jason Wang <jasowang@redhat.com>, Yajun Wu <yajunw@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com,
 Gautam Dawar <gdawar@xilinx.com>
Subject: [RFC PATCH 15/18] vdpa: add vhost_vdpa_load_setup
Date: Thu, 19 Oct 2023 16:34:52 +0200
Message-Id: <20231019143455.2377694-16-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
References: <20231019143455.2377694-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

Callers can use this function to setup the incoming migration.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  7 +++++++
 hw/virtio/vhost-vdpa.c         | 17 ++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 8f54e5edd4..edc08b7a02 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -45,6 +45,12 @@ typedef struct vhost_vdpa_shared {
 
     bool iotlb_batch_begin_sent;
 
+    /*
+     * The memory listener has been registered, so DMA maps have been sent to
+     * the device.
+     */
+    bool listener_registered;
+
     /* Vdpa must send shadow addresses as IOTLB key for data queues, not GPA */
     bool shadow_data;
 } VhostVDPAShared;
@@ -73,6 +79,7 @@ int vhost_vdpa_dma_map(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                        hwaddr size, void *vaddr, bool readonly);
 int vhost_vdpa_dma_unmap(VhostVDPAShared *s, uint32_t asid, hwaddr iova,
                          hwaddr size);
+int vhost_vdpa_load_setup(VhostVDPAShared *s, AddressSpace *dma_as);
 
 typedef struct vdpa_iommu {
     VhostVDPAShared *dev_shared;
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index cc252fc2d8..bfbe4673af 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -1325,7 +1325,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *dev, bool started)
                          "IOMMU and try again");
             return -1;
         }
-        memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        if (!v->shared->listener_registered) {
+            memory_listener_register(&v->shared->listener, dev->vdev->dma_as);
+        }
 
         return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
     }
@@ -1528,3 +1530,16 @@ const VhostOps vdpa_ops = {
         .vhost_set_config_call = vhost_vdpa_set_config_call,
         .vhost_reset_status = vhost_vdpa_reset_status,
 };
+
+int vhost_vdpa_load_setup(VhostVDPAShared *shared, AddressSpace *dma_as)
+{
+    uint8_t s = VIRTIO_CONFIG_S_ACKNOWLEDGE | VIRTIO_CONFIG_S_DRIVER;
+    int r = ioctl(shared->device_fd, VHOST_VDPA_SET_STATUS, &s);
+    if (unlikely(r < 0)) {
+        return r;
+    }
+
+    memory_listener_register(&shared->listener, dma_as);
+    shared->listener_registered = true;
+    return 0;
+}
-- 
2.39.3


