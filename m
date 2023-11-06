Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 861717E276E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:45:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00jO-0005AZ-Nd; Mon, 06 Nov 2023 09:37:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00j8-0003js-Nv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:20 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00j2-0000oY-8V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:37:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDT108knz4xjV;
 Tue,  7 Nov 2023 01:37:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDSz0gjyz4xjN;
 Tue,  7 Nov 2023 01:37:06 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yanghang Liu <yanghliu@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/22] vfio: Collect container iova range info
Date: Mon,  6 Nov 2023 15:36:34 +0100
Message-ID: <20231106143653.302391-4-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
capability is supported.

This allows to propagate the information though the IOMMU MR
set_iova_ranges() callback so that virtual IOMMUs
get aware of those aperture constraints. This is only done if
the info is available and the number of iova ranges is greater than
0.

A new vfio_get_info_iova_range helper is introduced matching
the coding style of existing vfio_get_info_dma_avail. The
boolean returned value isn't used though. Code is aligned
between both.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              |  9 ++++++++
 hw/vfio/container.c           | 42 ++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7780b9073a6c71d2aa5e2c5d157935c5805ba2f8..0c3d390e8bd5e990e1ccb1c7e077bde0baa812e9 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -99,6 +99,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
+    GList *iova_ranges;
 } VFIOContainer;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d806057b4003d69975986d8a86a6f78fe8622616..9c5c6433f23416f75c1e5525f880c4339fcfe73f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -693,6 +693,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
+        if (container->iova_ranges) {
+            ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
+                    container->iova_ranges, &err);
+            if (ret) {
+                g_free(giommu);
+                goto fail;
+            }
+        }
+
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index adc467210ff73422ad2f897abfbcf6eddbb22ad2..fc882223779bb30f31c435e92d0eb04383a9e1ed 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -382,7 +382,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     /* If the capability cannot be found, assume no DMA limiting */
     hdr = vfio_get_iommu_type1_info_cap(info,
                                         VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
-    if (hdr == NULL) {
+    if (!hdr) {
         return false;
     }
 
@@ -394,6 +394,32 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
+                                     VFIOContainer *container)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_iova_range *cap;
+
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+    if (!hdr) {
+        return false;
+    }
+
+    cap = (void *)hdr;
+
+    for (int i = 0; i < cap->nr_iovas; i++) {
+        Range *range = g_new(Range, 1);
+
+        range_set_bounds(range, cap->iova_ranges[i].start,
+                         cap->iova_ranges[i].end);
+        container->iova_ranges =
+            range_list_insert(container->iova_ranges, range);
+    }
+
+    return true;
+}
+
 static void vfio_kvm_device_add_group(VFIOGroup *group)
 {
     Error *err = NULL;
@@ -535,6 +561,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
+static void vfio_free_container(VFIOContainer *container)
+{
+    g_list_free_full(container->iova_ranges, g_free);
+    g_free(container);
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -616,6 +648,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->error = NULL;
     container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
+    container->iova_ranges = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
@@ -652,6 +685,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
             container->dma_max_mappings = 65535;
         }
+
+        vfio_get_info_iova_range(info, container);
+
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
 
@@ -765,7 +801,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    g_free(container);
+    vfio_free_container(container);
 
 close_fd_exit:
     close(fd);
@@ -819,7 +855,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        g_free(container);
+        vfio_free_container(container);
 
         vfio_put_address_space(space);
     }
-- 
2.41.0


