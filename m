Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D582D785
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:40:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKNf-0000dw-I3; Mon, 15 Jan 2024 05:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNb-0000dj-Kw
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:43 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNZ-0002iw-QQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315182; x=1736851182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H+naJ7VRctkuwtffWQXrbsDi9DkheXW/d5BzZnaSwP8=;
 b=XDkpDgHZMI+qLRVruCl77hZdBBkTb/jHEmnFN3yc1GGZAy4ESCe+ceDX
 SmGX42JOnZchh4dmWP1XLA9yh27QvElTwx96+Ero9GeWG3LTg5n57DRVy
 5qQoI+wuwltrV6DRSyEvNRsPzyRXpubtK3eZ7i0Gxx0OIJ0AeB4XImbXF
 6eMD3Op0owl9USUBFSwC89xYfiaUTB1lHWtYVUoqO23uQVU6Vr5SwFsdG
 BRIw1r7Aoao3ZZHyZk5hZ1QaxnEDTnDs+SfguHMsKNRG4R2aP+sOWY7XB
 x8jergMDebcxCjxEhts8b3/jn0E58ZZbpiHkcF0S/OAomOHdHO6J+Vy2t g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067461"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067461"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065313"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065313"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv1 02/23] backends/iommufd: add helpers for allocating
 user-managed HWPT
Date: Mon, 15 Jan 2024 18:37:14 +0800
Message-Id: <20240115103735.132209-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115103735.132209-1-zhenzhong.duan@intel.com>
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Include helper to allocate user-managed hwpt and helper for cache
invalidation as user-managed HWPT needs to sync cache per modifications.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  7 +++++
 backends/iommufd.c       | 61 ++++++++++++++++++++++++++++++++++++++++
 backends/trace-events    |  2 ++
 3 files changed, 70 insertions(+)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 9af27ebd6c..ab6c382081 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -33,4 +33,11 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t flags,
+                               uint32_t data_type, uint32_t data_len,
+                               void *data_ptr, uint32_t *out_hwpt);
+int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint32_t data_type, uint32_t entry_len,
+                                     uint32_t *entry_num, void *data_ptr);
 #endif
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 1ef683c7b0..9f920e08d3 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -211,6 +211,67 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+int iommufd_backend_alloc_hwpt(IOMMUFDBackend *be, uint32_t dev_id,
+                               uint32_t pt_id, uint32_t flags,
+                               uint32_t data_type, uint32_t data_len,
+                               void *data_ptr, uint32_t *out_hwpt)
+{
+    int ret, fd = be->fd;
+    struct iommu_hwpt_alloc alloc_hwpt = {
+        .size = sizeof(struct iommu_hwpt_alloc),
+        .flags = flags,
+        .dev_id = dev_id,
+        .pt_id = pt_id,
+        .data_type = data_type,
+        .data_len = data_len,
+        .data_uptr = (uintptr_t)data_ptr,
+        .__reserved = 0,
+    };
+
+    ret = ioctl(fd, IOMMU_HWPT_ALLOC, &alloc_hwpt);
+    if (ret) {
+        ret = -errno;
+        error_report("IOMMU_HWPT_ALLOC failed: %m");
+    } else {
+        *out_hwpt = alloc_hwpt.out_hwpt_id;
+    }
+
+    trace_iommufd_backend_alloc_hwpt(fd, dev_id, pt_id, flags, data_type,
+                                     data_len, (uint64_t)data_ptr,
+                                     alloc_hwpt.out_hwpt_id, ret);
+    return ret;
+}
+
+int iommufd_backend_invalidate_cache(IOMMUFDBackend *be, uint32_t hwpt_id,
+                                     uint32_t data_type, uint32_t entry_len,
+                                     uint32_t *entry_num, void *data_ptr)
+{
+    int ret, fd = be->fd;
+    struct iommu_hwpt_invalidate cache = {
+        .size = sizeof(cache),
+        .hwpt_id = hwpt_id,
+        .data_type = data_type,
+        .entry_len = entry_len,
+        .entry_num = *entry_num,
+        .data_uptr = (uintptr_t)data_ptr,
+    };
+
+    ret = ioctl(fd, IOMMU_HWPT_INVALIDATE, &cache);
+
+    trace_iommufd_backend_invalidate_cache(fd, hwpt_id, data_type, entry_len,
+                                           *entry_num, cache.entry_num,
+                                           (uintptr_t)data_ptr, ret);
+    if (ret) {
+        *entry_num = cache.entry_num;
+        error_report("IOMMU_HWPT_INVALIDATE failed: %s", strerror(errno));
+        ret = -errno;
+    } else {
+        g_assert(*entry_num == cache.entry_num);
+    }
+
+    return ret;
+}
+
 static const TypeInfo iommufd_backend_info = {
     .name = TYPE_IOMMUFD_BACKEND,
     .parent = TYPE_OBJECT,
diff --git a/backends/trace-events b/backends/trace-events
index d45c6e31a6..3df48bfb08 100644
--- a/backends/trace-events
+++ b/backends/trace-events
@@ -15,3 +15,5 @@ iommufd_backend_unmap_dma_non_exist(int iommufd, uint32_t ioas, uint64_t iova, u
 iommufd_backend_unmap_dma(int iommufd, uint32_t ioas, uint64_t iova, uint64_t size, int ret) " iommufd=%d ioas=%d iova=0x%"PRIx64" size=0x%"PRIx64" (%d)"
 iommufd_backend_alloc_ioas(int iommufd, uint32_t ioas, int ret) " iommufd=%d ioas=%d (%d)"
 iommufd_backend_free_id(int iommufd, uint32_t id, int ret) " iommufd=%d id=%d (%d)"
+iommufd_backend_alloc_hwpt(int iommufd, uint32_t dev_id, uint32_t pt_id, uint32_t flags, uint32_t hwpt_type, uint32_t len, uint64_t data_ptr, uint32_t out_hwpt_id, int ret) " iommufd=%d dev_id=%u pt_id=%u flags=0x%x hwpt_type=%u len=%u data_ptr=0x%"PRIx64" out_hwpt=%u (%d)"
+iommufd_backend_invalidate_cache(int iommufd, uint32_t hwpt_id, uint32_t data_type, uint32_t entry_len, uint32_t entry_num, uint32_t done_num, uint64_t data_ptr, int ret) " iommufd=%d hwpt_id=%u data_type=%u entry_len=%u entry_num=%u done_num=%u data_ptr=0x%"PRIx64" (%d)"
-- 
2.34.1


