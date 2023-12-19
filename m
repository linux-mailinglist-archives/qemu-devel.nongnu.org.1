Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB6819019
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:59:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIz-0004IS-QE; Tue, 19 Dec 2023 13:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIc-0003ng-Dt
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:41 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIa-0007D7-2W
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:38 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDp0QjBz4xS5;
 Wed, 20 Dec 2023 05:58:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmDk02f9z4xS9;
 Wed, 20 Dec 2023 05:58:29 +1100 (AEDT)
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
Subject: [PULL 19/47] vfio/spapr: Move hostwin_list into spapr container
Date: Tue, 19 Dec 2023 19:56:15 +0100
Message-ID: <20231219185643.725448-20-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 -
 hw/vfio/spapr.c               | 36 +++++++++++++++++++----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index ed6148c058be03f6c1898ff680072f23dbe51ba2..24ecc0e7ee6243ad9ee2003d197e04390b780d2c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -79,7 +79,6 @@ typedef struct VFIOContainer {
     VFIOContainerBase bcontainer;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     unsigned iommu_type;
-    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOContainer;
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 68c3dd6c75678dcfa901b8e7bc241a56047c0fbe..5c6426e6973bec606667ebcaca5b0585b184a214 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -27,6 +27,7 @@
 typedef struct VFIOSpaprContainer {
     VFIOContainer container;
     MemoryListener prereg_listener;
+    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
 } VFIOSpaprContainer;
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
@@ -154,12 +155,12 @@ static const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
-static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
+static void vfio_host_win_add(VFIOSpaprContainer *scontainer, hwaddr min_iova,
                               hwaddr max_iova, uint64_t iova_pgsizes)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            min_iova,
@@ -173,15 +174,15 @@ static void vfio_host_win_add(VFIOContainer *container, hwaddr min_iova,
     hostwin->min_iova = min_iova;
     hostwin->max_iova = max_iova;
     hostwin->iova_pgsizes = iova_pgsizes;
-    QLIST_INSERT_HEAD(&container->hostwin_list, hostwin, hostwin_next);
+    QLIST_INSERT_HEAD(&scontainer->hostwin_list, hostwin, hostwin_next);
 }
 
-static int vfio_host_win_del(VFIOContainer *container,
+static int vfio_host_win_del(VFIOSpaprContainer *scontainer,
                              hwaddr min_iova, hwaddr max_iova)
 {
     VFIOHostDMAWindow *hostwin;
 
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (hostwin->min_iova == min_iova && hostwin->max_iova == max_iova) {
             QLIST_REMOVE(hostwin, hostwin_next);
             g_free(hostwin);
@@ -192,7 +193,7 @@ static int vfio_host_win_del(VFIOContainer *container,
     return -1;
 }
 
-static VFIOHostDMAWindow *vfio_find_hostwin(VFIOContainer *container,
+static VFIOHostDMAWindow *vfio_find_hostwin(VFIOSpaprContainer *container,
                                             hwaddr iova, hwaddr end)
 {
     VFIOHostDMAWindow *hostwin;
@@ -329,6 +330,8 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     VFIOHostDMAWindow *hostwin;
     hwaddr pgsize = 0;
     int ret;
@@ -344,7 +347,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         iova = section->offset_within_address_space;
         end = iova + int128_get64(section->size) - 1;
 
-        if (!vfio_find_hostwin(container, iova, end)) {
+        if (!vfio_find_hostwin(scontainer, iova, end)) {
             error_setg(errp, "Container %p can't map guest IOVA region"
                        " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container,
                        iova, end);
@@ -358,7 +361,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
     }
 
     /* For now intersections are not allowed, we may relax this later */
-    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+    QLIST_FOREACH(hostwin, &scontainer->hostwin_list, hostwin_next) {
         if (ranges_overlap(hostwin->min_iova,
                            hostwin->max_iova - hostwin->min_iova + 1,
                            section->offset_within_address_space,
@@ -380,7 +383,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
         return ret;
     }
 
-    vfio_host_win_add(container, section->offset_within_address_space,
+    vfio_host_win_add(scontainer, section->offset_within_address_space,
                       section->offset_within_address_space +
                       int128_get64(section->size) - 1, pgsize);
 #ifdef CONFIG_KVM
@@ -419,6 +422,8 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 {
     VFIOContainer *container = container_of(bcontainer, VFIOContainer,
                                             bcontainer);
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
 
     if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
         return;
@@ -426,7 +431,7 @@ vfio_spapr_container_del_section_window(VFIOContainerBase *bcontainer,
 
     vfio_spapr_remove_window(container,
                              section->offset_within_address_space);
-    if (vfio_host_win_del(container,
+    if (vfio_host_win_del(scontainer,
                           section->offset_within_address_space,
                           section->offset_within_address_space +
                           int128_get64(section->size) - 1) < 0) {
@@ -454,7 +459,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     bool v2 = container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU;
     int ret, fd = container->fd;
 
-    QLIST_INIT(&container->hostwin_list);
+    QLIST_INIT(&scontainer->hostwin_list);
 
     /*
      * The host kernel code implementing VFIO_IOMMU_DISABLE is called
@@ -506,7 +511,7 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
     } else {
         /* The default table uses 4K pages */
         bcontainer->pgsizes = 0x1000;
-        vfio_host_win_add(container, info.dma32_window_start,
+        vfio_host_win_add(scontainer, info.dma32_window_start,
                           info.dma32_window_start +
                           info.dma32_window_size - 1,
                           0x1000);
@@ -525,15 +530,14 @@ listener_unregister_exit:
 
 void vfio_spapr_container_deinit(VFIOContainer *container)
 {
+    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
+                                                  container);
     VFIOHostDMAWindow *hostwin, *next;
 
     if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        VFIOSpaprContainer *scontainer = container_of(container,
-                                                      VFIOSpaprContainer,
-                                                      container);
         memory_listener_unregister(&scontainer->prereg_listener);
     }
-    QLIST_FOREACH_SAFE(hostwin, &container->hostwin_list, hostwin_next,
+    QLIST_FOREACH_SAFE(hostwin, &scontainer->hostwin_list, hostwin_next,
                        next) {
         QLIST_REMOVE(hostwin, hostwin_next);
         g_free(hostwin);
-- 
2.43.0


