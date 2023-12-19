Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B521819040
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:03:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIG-0002TG-76; Tue, 19 Dec 2023 13:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIE-0002Mi-43
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:14 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIC-00076c-5G
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:13 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDL1PSrz4xS7;
 Wed, 20 Dec 2023 05:58:10 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDG11vZz4xCp;
 Wed, 20 Dec 2023 05:58:05 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/47] vfio/container: Move iova_ranges to base container
Date: Tue, 19 Dec 2023 19:56:10 +0100
Message-ID: <20231219185643.725448-15-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Meanwhile remove the helper function vfio_free_container as it
only calls g_free now.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  1 -
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/common.c                      |  5 +++--
 hw/vfio/container-base.c              |  3 +++
 hw/vfio/container.c                   | 19 ++++++-------------
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b1c9fe711bb9cb661ca036214a63bb1607e956a3..b9e5a0e64b46bacae99c2c542f1b7c7560957080 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -82,7 +82,6 @@ typedef struct VFIOContainer {
     unsigned iommu_type;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
-    GList *iova_ranges;
 } VFIOContainer;
 
 typedef struct VFIOHostDMAWindow {
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 80e4a993c5cfbceb9ab8366eae4ba5bafe26b208..9658ffb526f61734611fea2a2a8401fdd77b02fb 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -48,6 +48,7 @@ typedef struct VFIOContainerBase {
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainerBase) next;
     QLIST_HEAD(, VFIODevice) device_list;
+    GList *iova_ranges;
 } VFIOContainerBase;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index be623e544b641c0bc202b30ed350911b3ec99078..8ef2e7967d6572e3ad3d53d6d5b5d3d0c95301ae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -637,9 +637,10 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
-        if (container->iova_ranges) {
+        if (bcontainer->iova_ranges) {
             ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
-                    container->iova_ranges, &err);
+                                                      bcontainer->iova_ranges,
+                                                      &err);
             if (ret) {
                 g_free(giommu);
                 goto fail;
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 7f508669f5dbdab211bed217c143c2c8387b5ae4..0177f4374132d4bbdc5f992e9c3fddb138809307 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -54,6 +54,7 @@ void vfio_container_init(VFIOContainerBase *bcontainer, VFIOAddressSpace *space,
     bcontainer->error = NULL;
     bcontainer->dirty_pages_supported = false;
     bcontainer->dma_max_mappings = 0;
+    bcontainer->iova_ranges = NULL;
     QLIST_INIT(&bcontainer->giommu_list);
     QLIST_INIT(&bcontainer->vrdl_list);
 }
@@ -70,4 +71,6 @@ void vfio_container_destroy(VFIOContainerBase *bcontainer)
         QLIST_REMOVE(giommu, giommu_next);
         g_free(giommu);
     }
+
+    g_list_free_full(bcontainer->iova_ranges, g_free);
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c8088a8174f18e58c6704e09cf9a7c09a0124175..721c0d7375bd1e07f04e33558e8ca3b3f234412d 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -308,7 +308,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 }
 
 static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
-                                     VFIOContainer *container)
+                                     VFIOContainerBase *bcontainer)
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_iommu_type1_info_cap_iova_range *cap;
@@ -326,8 +326,8 @@ static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
 
         range_set_bounds(range, cap->iova_ranges[i].start,
                          cap->iova_ranges[i].end);
-        container->iova_ranges =
-            range_list_insert(container->iova_ranges, range);
+        bcontainer->iova_ranges =
+            range_list_insert(bcontainer->iova_ranges, range);
     }
 
     return true;
@@ -475,12 +475,6 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
-static void vfio_free_container(VFIOContainer *container)
-{
-    g_list_free_full(container->iova_ranges, g_free);
-    g_free(container);
-}
-
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -560,7 +554,6 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
 
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
-    container->iova_ranges = NULL;
     bcontainer = &container->bcontainer;
     vfio_container_init(bcontainer, space, &vfio_legacy_ops);
 
@@ -597,7 +590,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
             bcontainer->dma_max_mappings = 65535;
         }
 
-        vfio_get_info_iova_range(info, container);
+        vfio_get_info_iova_range(info, bcontainer);
 
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
@@ -649,7 +642,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    vfio_free_container(container);
+    g_free(container);
 
 close_fd_exit:
     close(fd);
@@ -693,7 +686,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        vfio_free_container(container);
+        g_free(container);
 
         vfio_put_address_space(space);
     }
-- 
2.43.0


