Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1707DED62
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:33:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9P-0004qG-6y; Thu, 02 Nov 2023 03:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9M-0004hB-Nw
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:56 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9L-0003Ox-2u
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910195; x=1730446195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=31JYkYEjp0/hjcg8A2CZRlpGcKKCzVxH23KgUl4EDzE=;
 b=khj44zbNj5V2aPYa2UTVcGknYZfNZw9X/B0efmoy8nCZrgGxYk77WH3u
 +UgaSXKPoVtFzIkFcgktkrhBtPBrTWtQa/vrR4I44C/ewJ1HsKT1VrwIy
 MR3Ovo3wW0E6ZhTat+AE6G0BJCMiQQW8Ma1qpbsga7KV8vsOJeO4kgKSO
 MMXFBx4VgS0SHhSgxjP1ekzMDuVAL6ZPkB0t01Ezzno3VNhMf50MKEIDc
 uyAdRCXV0y+Xs79L3K/VBUtmg0o2KyVhZsn0fo2uKCjxMz67RES1mTaMi
 fRJIqPLc7hgUqQqA8Of7/BKOzFjsxNuHNReXhtFwpIvfMxj9Mel95ahfU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953208"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953208"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055421"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055421"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:39 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 18/41] vfio/container: Move dirty_pgsizes and
 max_dirty_bitmap_size to base container
Date: Thu,  2 Nov 2023 15:12:39 +0800
Message-Id: <20231102071302.1818071-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 include/hw/vfio/vfio-common.h         | 2 --
 include/hw/vfio/vfio-container-base.h | 2 ++
 hw/vfio/container.c                   | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 922022cbc6..b1c9fe711b 100644
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
index 95f8d319e0..80e4a993c5 100644
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
index 5c1dee8c9f..c8088a8174 100644
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
2.34.1


