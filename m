Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B3AB50B27
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 04:40:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAii-00071I-I8; Tue, 09 Sep 2025 22:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAie-000713-7R
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:38:00 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uwAib-0005fl-Gb
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757471877; x=1789007877;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tdZgGAXGGAq4Pg6STXrJDzN4iFO8GejtPxlwh1FrhXU=;
 b=mtWVY+3wB27M4Xdzlw6H6NxrOvTAzM34YLqzCBFe6v1CJFdjKpIl0VdP
 LP3J3n6Z5G5lCOKW1K8RyNE/vgLt3qaznWLdLJlqUVZx0kOxZMTjqhiB7
 hWfWnA/pzTcNIQBZ9XSVp92sTlcL/SbT/w2jYRfkBbamejG3j7PC9wHdg
 ngbDqqQ1AIrG248hZqp3vqfzTguV7ElZ1KVYLnsO1eGzuyRLzvA3ibP81
 Y4MSifGoBaxvzcKd4PvZhjJuqk239cjiS5HIozgNLb7joyWwxDU2Y843o
 kK2lgG3f0mhVR5guu9DVYjb7zt9votlHbm0jxkgXab7W56uCkrt5uRFkl w==;
X-CSE-ConnectionGUID: UidPoc1eRAWHfG13hRGZaw==
X-CSE-MsgGUID: 4Nd5qdG0R8uBjfyKl2vEJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11548"; a="62402804"
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="62402804"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:41 -0700
X-CSE-ConnectionGUID: qIhbZV7lRfu8R4qQbjT/xw==
X-CSE-MsgGUID: B5bGZjbETziHd9N5mWHLUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; d="scan'208";a="196930571"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2025 19:37:38 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/5] vfio/iommufd: Add IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
 flag support
Date: Tue,  9 Sep 2025 22:36:59 -0400
Message-ID: <20250910023701.244356-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250910023701.244356-1-zhenzhong.duan@intel.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the last dirty
bitmap query right before unmap, no PTEs flushes. This accelerates the
query without issue because unmap will tear down the mapping anyway.

Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
be used for the flags of iommufd dirty tracking. Currently it is
set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based on
the scenario.

Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 hw/vfio/vfio-iommufd.h   | 1 +
 include/system/iommufd.h | 2 +-
 backends/iommufd.c       | 5 +++--
 hw/vfio/iommufd.c        | 6 +++++-
 backends/trace-events    | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
index 07ea0f4304..e0af241c75 100644
--- a/hw/vfio/vfio-iommufd.h
+++ b/hw/vfio/vfio-iommufd.h
@@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
     VFIOContainerBase bcontainer;
     IOMMUFDBackend *be;
     uint32_t ioas_id;
+    uint64_t dirty_tracking_flags;
     QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
 } VFIOIOMMUFDContainer;
 
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index c9c72ffc45..63898e7b0d 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -64,7 +64,7 @@ bool iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t hwpt_id,
 bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be, uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
-                                      Error **errp);
+                                      uint64_t flags, Error **errp);
 bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t id,
                                       uint32_t data_type, uint32_t entry_len,
                                       uint32_t *entry_num, void *data,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 2a33c7ab0b..3c4f6157e2 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -361,7 +361,7 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
                                       uint32_t hwpt_id,
                                       uint64_t iova, ram_addr_t size,
                                       uint64_t page_size, uint64_t *data,
-                                      Error **errp)
+                                      uint64_t flags, Error **errp)
 {
     int ret;
     struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap = {
@@ -371,11 +371,12 @@ bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
         .length = size,
         .page_size = page_size,
         .data = (uintptr_t)data,
+        .flags = flags,
     };
 
     ret = ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP, &get_dirty_bitmap);
     trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id, iova, size,
-                                           page_size, ret ? errno : 0);
+                                           flags, page_size, ret ? errno : 0);
     if (ret) {
         error_setg_errno(errp, errno,
                          "IOMMU_HWPT_GET_DIRTY_BITMAP (iova: 0x%"HWADDR_PRIx
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 0057488ce9..c897aa6b17 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
                                   hwaddr iova, ram_addr_t size,
                                   IOMMUTLBEntry *iotlb)
 {
-    const VFIOIOMMUFDContainer *container =
+    VFIOIOMMUFDContainer *container =
         container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
     bool need_dirty_sync = false;
     Error *local_err = NULL;
@@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const VFIOContainerBase *bcontainer,
     if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer)) {
         if (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
             bcontainer->dirty_pages_supported) {
+            container->dirty_tracking_flags =
+                                      IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
             ret = vfio_container_query_dirty_bitmap(bcontainer, iova, size,
                                                     iotlb->translated_addr,
                                                     &local_err);
+            container->dirty_tracking_flags = 0;
             if (ret) {
                 error_report_err(local_err);
             }
@@ -248,6 +251,7 @@ static int iommufd_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
         if (!iommufd_backend_get_dirty_bitmap(container->be, hwpt->hwpt_id,
                                               iova, size, page_size,
                                               (uint64_t *)vbmap->bitmap,
+                                              container->dirty_tracking_flags,
                                               errp)) {
             return -EINVAL;
         }
diff --git a/backends/trace-events b/backends/trace-events
index 56132d3fd2..e1992ba12f 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -19,5 +19,5 @@ iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas) " iommufd=%d ioas=%d"
 iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
 iommufd_backend_set_dirty(int iommufd, uint32_t hwpt_id, bool start, int ret) " iommufd=%d hwpt=%u enable=%d (%d)"
-iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
+iommufd_backend_get_dirty_bitmap(int iommufd, uint32_t hwpt_id, uint64_t iova, uint64_t size, uint64_t flags, uint64_t page_size, int ret) " iommufd=%d hwpt=%u iova=0x%"PRIx64" size=0x%"PRIx64" flags=0x%"PRIx64" page_size=0x%"PRIx64" (%d)"
 iommufd_backend_invalidate_cache(int iommufd, uint32_t id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-- 
2.47.1


