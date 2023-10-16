Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E72547CA282
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJH8-0000GZ-HF; Mon, 16 Oct 2023 04:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGz-0008Lf-BU
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:28 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJGu-0001FN-W5
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446101; x=1728982101;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y+HkCVoou1khEr9z+ilkcNKYFw+WgtgDANUYD38SDLY=;
 b=aUJwlPXssAgDFeAoPes55AgJsg6FhFqd/F5Yqf2W1GNy4d2BZ7MC08ot
 J56JtEKgCxRBNkaAeL9P9DWLsMjPkksanMvJoZfO7f1G5koSKU7lqkXan
 fobEFewhEE13teAOdvywYJceXBVoWaTPO8B9FTOHID6i+jWPZwo177qPR
 zkIqa8fFJq0GZLLQmW5GFxKtzQIaofuF+wNTFytrzxWLwV6tuVTx54m16
 WO9Px23AFfLTU3Peu4g7O0E3z1gMDNgk9kMhVlrRiX7o1pc8tL4iHCCMq
 FoTg5mDUtSq1vgnTxnpT/YHlZaUx5yZ3VDU8CTIZPaXk0Yqs4sIVT7V+T Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737646"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737646"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222939"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222939"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:48:14 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 14/27] vfio/container: Move dirty_pgsizes and
 max_dirty_bitmap_size to base container
Date: Mon, 16 Oct 2023 16:32:10 +0800
Message-Id: <20231016083223.1519410-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 include/hw/vfio/vfio-common.h         |  2 --
 include/hw/vfio/vfio-container-base.h |  2 ++
 hw/vfio/container.c                   | 11 ++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8771160849..9f2b86581b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -80,8 +80,6 @@ typedef struct VFIOLegacyContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener prereg_listener;
     unsigned iommu_type;
-    uint64_t dirty_pgsizes;
-    uint64_t max_dirty_bitmap_size;
     QLIST_HEAD(, VFIOGroup) group_list;
 } VFIOLegacyContainer;
 
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 96d33495c1..9a5971a00a 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -79,6 +79,8 @@ struct VFIOContainer {
     MemoryListener listener;
     Error *error;
     bool initialized;
+    uint64_t dirty_pgsizes;
+    uint64_t max_dirty_bitmap_size;
     unsigned long pgsizes;
     unsigned int dma_max_mappings;
     bool dirty_pages_supported;
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 5b14a9b307..9d5be749c7 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -70,6 +70,7 @@ static int vfio_dma_unmap_bitmap(VFIOLegacyContainer *container,
                                  hwaddr iova, ram_addr_t size,
                                  IOMMUTLBEntry *iotlb)
 {
+    VFIOContainer *bcontainer = &container->bcontainer;
     struct vfio_iommu_type1_dma_unmap *unmap;
     struct vfio_bitmap *bitmap;
     VFIOBitmap vbmap;
@@ -97,7 +98,7 @@ static int vfio_dma_unmap_bitmap(VFIOLegacyContainer *container,
     bitmap->size = vbmap.size;
     bitmap->data = (__u64 *)vbmap.bitmap;
 
-    if (vbmap.size > container->max_dirty_bitmap_size) {
+    if (vbmap.size > bcontainer->max_dirty_bitmap_size) {
         error_report("UNMAP: Size of bitmap too big 0x%"PRIx64, vbmap.size);
         ret = -E2BIG;
         goto unmap_exit;
@@ -139,7 +140,7 @@ static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
 
     if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
         if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
-            container->bcontainer.dirty_pages_supported) {
+            bcontainer->dirty_pages_supported) {
             return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
         }
 
@@ -162,7 +163,7 @@ static int vfio_legacy_dma_unmap(VFIOContainer *bcontainer, hwaddr iova,
         if (errno == EINVAL && unmap.size && !(unmap.iova + unmap.size) &&
             container->iommu_type == VFIO_TYPE1v2_IOMMU) {
             trace_vfio_legacy_dma_unmap_overflow_workaround();
-            unmap.size -= 1ULL << ctz64(container->bcontainer.pgsizes);
+            unmap.size -= 1ULL << ctz64(bcontainer->pgsizes);
             continue;
         }
         error_report("VFIO_UNMAP_DMA failed: %s", strerror(errno));
@@ -558,8 +559,8 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
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


