Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3395819035
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:02:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIX-0003WP-KE; Tue, 19 Dec 2023 13:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIV-0003KX-75
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:31 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIR-0007CA-Ql
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDc5WWCz4xS5;
 Wed, 20 Dec 2023 05:58:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDX4skgz4xCp;
 Wed, 20 Dec 2023 05:58:20 +1100 (AEDT)
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
Subject: [PULL 17/47] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
Date: Tue, 19 Dec 2023 19:56:13 +0100
Message-ID: <20231219185643.725448-18-clg@redhat.com>
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

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  5 -----
 include/hw/vfio/vfio-container-base.h |  5 +++++
 hw/vfio/common.c                      |  8 ++------
 hw/vfio/container-base.c              | 21 +++++++++++++++++++++
 hw/vfio/spapr.c                       | 19 ++++++++++++++-----
 5 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9e5a0e64b46bacae99c2c542f1b7c7560957080..055f6793635e8c0faa2bbd910737bf8db4e45c88 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -169,11 +169,6 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 
 /* SPAPR specific */
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp);
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section);
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp);
 void vfio_spapr_container_deinit(VFIOContainer *container);
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index f62a14ac7388de4e682181eb141c71f61b43791b..4b6f017c6f15de1bb1fb42bcae62a1f062895bdd 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -75,6 +75,11 @@ int vfio_container_dma_map(VFIOContainerBase *bcontainer,
 int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
+int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp);
+void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section);
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start);
 int vfio_container_query_dirty_bitmap(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 483ba820890460cba0ec7a4ecfed72d66433d41e..572ae7c934070b9fdc66915f6831fb0fa1323941 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -571,8 +571,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     void *vaddr;
@@ -595,7 +593,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (vfio_container_add_section_window(container, section, &err)) {
+    if (vfio_container_add_section_window(bcontainer, section, &err)) {
         goto fail;
     }
 
@@ -738,8 +736,6 @@ static void vfio_listener_region_del(MemoryListener *listener,
 {
     VFIOContainerBase *bcontainer = container_of(listener, VFIOContainerBase,
                                                  listener);
-    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
-                                            bcontainer);
     hwaddr iova, end;
     Int128 llend, llsize;
     int ret;
@@ -818,7 +814,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    vfio_container_del_section_window(container, section);
+    vfio_container_del_section_window(bcontainer, section);
 }
 
 typedef struct VFIODirtyRanges {
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 0177f4374132d4bbdc5f992e9c3fddb138809307..71f727497314b06185fd0201d1472b83aafda703 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -31,6 +31,27 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
 
+int vfio_container_add_section_window(VFIOContainerBase *bcontainer,
+                                      MemoryRegionSection *section,
+                                      Error **errp)
+{
+    if (!bcontainer->ops->add_window) {
+        return 0;
+    }
+
+    return bcontainer->ops->add_window(bcontainer, section, errp);
+}
+
+void vfio_container_del_section_window(VFIOContainerBase *bcontainer,
+                                       MemoryRegionSection *section)
+{
+    if (!bcontainer->ops->del_window) {
+        return;
+    }
+
+    return bcontainer->ops->del_window(bcontainer, section);
+}
+
 int vfio_container_set_dirty_page_tracking(VFIOContainerBase *bcontainer,
                                            bool start)
 {
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index e1a6b3556347ddd29fdbe13f96ac6db9a2a869e5..5be1911aadccc3b3300b84b614a212aff39d57e0 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -319,10 +319,13 @@ static int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-int vfio_container_add_section_window(VFIOContainer *container,
-                                      MemoryRegionSection *section,
-                                      Error **errp)
+static int
+vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section,
+                                        Error **errp)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -407,9 +410,13 @@ int vfio_container_add_section_window(VFIOContainer *container,
     return 0;
 }
 
-void vfio_container_del_section_window(VFIOContainer *container,
-                                       MemoryRegionSection *section)
+static void
+vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
+                                        MemoryRegionSection *section)
 {
+    VFIOContainer *container = container_of(bcontainer, VFIOContainer,
+                                            bcontainer);
+
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
     }
@@ -430,6 +437,8 @@ static VFIOIOMMUOps vfio_iommu_spapr_ops;
 static void setup_spapr_ops(VFIOContainerBase *bcontainer)
 {
     vfio_iommu_spapr_ops = *bcontainer->ops;
+    vfio_iommu_spapr_ops.add_window = vfio_spapr_container_add_section_window;
+    vfio_iommu_spapr_ops.del_window = vfio_spapr_container_del_section_window;
     bcontainer->ops = &vfio_iommu_spapr_ops;
 }
 
-- 
2.43.0


