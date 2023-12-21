Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679081B561
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 12:55:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGHch-0008D7-8N; Thu, 21 Dec 2023 06:53:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHcb-0008BS-R5
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rGHca-0007xR-8i
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 06:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703159626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmPzHpJ7J2BnbFMyirhJkM/dBrBacMx6b4xylXe8QsI=;
 b=J9CX7u0zYN6hdv1I8ppfmSHfLSG/prWAiArOkEgNteXKttgw6ivXvNl3jbOeUhW+lF7M88
 D04Ex1Q2K7l7l77qupAQBjxn7VoN04dct7dv4CTZD3FpkFMjjhAF19VBBqkQ5cBEFkN4di
 paZGZhYn0zoXh5uXUS/xZ3I1cBRBQOk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-Ym5jm0Q6PfOikSY0l7-3JA-1; Thu,
 21 Dec 2023 06:53:45 -0500
X-MC-Unique: Ym5jm0Q6PfOikSY0l7-3JA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DACD13816B4B;
 Thu, 21 Dec 2023 11:53:44 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 423C440C6EB9;
 Thu, 21 Dec 2023 11:53:42 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 si-wei.liu@oracle.com, Zhu Lingshan <lingshan.zhu@intel.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v3 10/14] vdpa: move iommu_list to vhost_vdpa_shared
Date: Thu, 21 Dec 2023 12:53:15 +0100
Message-Id: <20231221115319.3067586-11-eperezma@redhat.com>
In-Reply-To: <20231221115319.3067586-1-eperezma@redhat.com>
References: <20231221115319.3067586-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Next patches will register the vhost_vdpa memory listener while the VM
is migrating at the destination, so we can map the memory to the device
before stopping the VM at the source.  The main goal is to reduce the
downtime.

However, the destination QEMU is unaware of which vhost_vdpa device will
register its memory_listener.  If the source guest has CVQ enabled, it
will be the CVQ device.  Otherwise, it  will be the first one.

Move the iommu_list member to VhostVDPAShared so all vhost_vdpa can use
it, rather than always in the first / last vhost_vdpa.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 2 +-
 hw/virtio/vhost-vdpa.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 5bd964dac5..3880b9e7f2 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -34,6 +34,7 @@ typedef struct VhostVDPAHostNotifier {
 typedef struct vhost_vdpa_shared {
     int device_fd;
     struct vhost_vdpa_iova_range iova_range;
+    QLIST_HEAD(, vdpa_iommu) iommu_list;
 
     /* IOVA mapping used by the Shadow Virtqueue */
     VhostIOVATree *iova_tree;
@@ -62,7 +63,6 @@ typedef struct vhost_vdpa {
     struct vhost_dev *dev;
     Error *migration_blocker;
     VhostVDPAHostNotifier notifier[VIRTIO_QUEUE_MAX];
-    QLIST_HEAD(, vdpa_iommu) iommu_list;
     IOMMUNotifier n;
 } VhostVDPA;
 
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 38afcbf1c9..a07cd85081 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -279,7 +279,7 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
         return;
     }
 
-    QLIST_INSERT_HEAD(&v->iommu_list, iommu, iommu_next);
+    QLIST_INSERT_HEAD(&v->shared->iommu_list, iommu, iommu_next);
     memory_region_iommu_replay(iommu->iommu_mr, &iommu->n);
 
     return;
@@ -292,7 +292,7 @@ static void vhost_vdpa_iommu_region_del(MemoryListener *listener,
 
     struct vdpa_iommu *iommu;
 
-    QLIST_FOREACH(iommu, &v->iommu_list, iommu_next)
+    QLIST_FOREACH(iommu, &v->shared->iommu_list, iommu_next)
     {
         if (MEMORY_REGION(iommu->iommu_mr) == section->mr &&
             iommu->n.start == section->offset_within_region) {
-- 
2.39.3


