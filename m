Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2760B79E188
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:07:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKre-0000rc-6n; Wed, 13 Sep 2023 04:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrc-0000qy-7W
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKra-0004id-2V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=deUtT+oz+1XIYevIMg+Drga7A61AlvVs6/MjQyLPDyM=;
 b=I7EFupc/BhMfSmLT2S3TX1nwuQYxvgZGT3HR1B9c8OKg/8WrSJuqXD876MIqsE8OEypCiv
 wK2yxrG+vFpYE3VwZh2vfIKaPXEkS1IfbQwwWOHOy243bTTt0sbZpJKNTpVMbdtXVO2YXG
 XezYQTkt+dfyLQTG3xq7bmokEsyCf9g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-CUHaqXD4PNyZrW0thbEAHg-1; Wed, 13 Sep 2023 04:04:38 -0400
X-MC-Unique: CUHaqXD4PNyZrW0thbEAHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC2BC8B7487;
 Wed, 13 Sep 2023 08:04:37 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 867422026D4B;
 Wed, 13 Sep 2023 08:04:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 03/12] vfio: Collect container iova range info
Date: Wed, 13 Sep 2023 10:01:38 +0200
Message-ID: <20230913080423.523953-4-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
capability is supported.

This allows to propagate the information though the IOMMU MR
set_iova_ranges() callback so that virtual IOMMUs
get aware of those aperture constraints.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 45 +++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index da43d27352..74b9b27270 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -98,6 +98,8 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIOGroup) group_list;
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
+    unsigned nr_iovas;
+    struct  vfio_iova_range *iova_ranges;
 } VFIOContainer;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9aac21abb7..26da38de05 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1157,6 +1157,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
+        ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
+                container->nr_iovas, (struct Range *)container->iova_ranges,
+                &err);
+        if (ret) {
+            g_free(giommu);
+            goto fail;
+        }
+
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
@@ -1981,6 +1989,29 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+static void vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
+                                     unsigned int *nr_iovas,
+                                     struct  vfio_iova_range **iova_ranges)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_iova_range *cap;
+
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+    if (hdr == NULL) {
+        return;
+    }
+
+    cap = (void *)hdr;
+    *nr_iovas = cap->nr_iovas;
+
+    if (*nr_iovas == 0) {
+        return;
+    }
+    *iova_ranges = g_memdup2(cap->iova_ranges,
+                             *nr_iovas * sizeof(struct  vfio_iova_range));
+}
+
 static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
                                           struct vfio_region_info *info)
 {
@@ -2433,6 +2464,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
+static void vfio_free_container(VFIOContainer *container)
+{
+    g_free(container->iova_ranges);
+    g_free(container);
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -2550,6 +2587,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
             container->dma_max_mappings = 65535;
         }
+
+        vfio_get_info_iova_range(info, &container->nr_iovas,
+                                 &container->iova_ranges);
+
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
 
@@ -2663,7 +2704,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    g_free(container);
+    vfio_free_container(container);
 
 close_fd_exit:
     close(fd);
@@ -2717,7 +2758,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        g_free(container);
+        vfio_free_container(container);
 
         vfio_put_address_space(space);
     }
-- 
2.41.0


