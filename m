Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7287819018
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:58:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfIB-0002ML-T2; Tue, 19 Dec 2023 13:58:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfIA-0002M8-DP
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:10 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfI8-00073h-KG
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:58:10 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmDF42sdz4xS5;
 Wed, 20 Dec 2023 05:58:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmD86f9rz4xCp;
 Wed, 20 Dec 2023 05:58:00 +1100 (AEDT)
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
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/47] vfio/container: Move dirty_pgsizes and
 max_dirty_bitmap_size to base container
Date: Tue, 19 Dec 2023 19:56:09 +0100
Message-ID: <20231219185643.725448-14-clg@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         | 2 --
 include/hw/vfio/vfio-container-base.h | 2 ++
 hw/vfio/container.c                   | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 922022cbc6c69ddb39c7241fc983b959be566d33..b1c9fe711bb9cb661ca036214a63bb1607e956a3 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -80,8 +80,6 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    uint64_t dirty_pgsizes;
-    uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
     QLIST_HEAD(, VFIOGroup) group_list;
     GList *iova_ranges;
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 95f8d319e0c6cf490a3e92dbf1735ad12b53fc65..80e4a993c5cfbceb9ab8366eae4ba5bafe26b208 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -39,6 +39,8 @@ typedef struct VFIOContainerBase {
     MemoryListener listener;
     Error *error;
     bool initialized;
+    uint64_t dirty_pgsizes;
+    uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5c1dee8c9f889fb6746449fe4fe611289cb247db..c8088a8174f18e58c6704e09cf9a7c09a0124175 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -64,6 +64,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
+    VFIOContainerBase *bcontainer = &container->bcontainer;
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -91,7 +92,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
     bitmap->size = vbmap.size;
     bitmap->data = (__u64 *)vbmap.bitmap;
 
-    if (vbmap.size > container->max_dirty_bitmap_size) {
+    if (vbmap.size > bcontainer->max_dirty_bitmap_size) {
         error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
         ret = -E2BIG;
         goto unmap_exit;
@@ -131,7 +132,7 @@ static int vfio_legacy_dma_unmap(VFIOContainerBase *bcontainer, hwaddr iova,
 
     if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
-            container->bcontainer.dirty_pages_supported) {
+            bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
 
@@ -469,8 +470,8 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
      */
     if (cap_mig->pgsize_bitmap & qemu_real_host_page_size()) {
         bcontainer->dirty_pages_supported = true;
-        container->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
-        container->dirty_pgsizes = cap_mig->pgsize_bitmap;
+        bcontainer->max_dirty_bitmap_size = cap_mig->max_dirty_bitmap_size;
+        bcontainer->dirty_pgsizes = cap_mig->pgsize_bitmap;
     }
 }
 
-- 
2.43.0


