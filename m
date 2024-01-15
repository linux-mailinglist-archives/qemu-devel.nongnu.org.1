Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B473E82D790
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:41:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKPG-0004Gd-JS; Mon, 15 Jan 2024 05:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPC-000457-84
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:22 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPA-0003Jt-0C
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315280; x=1736851280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fJOX1cjFN0fKo1HlZXBJcFTRrqpVs4CrCib5VoGAUrw=;
 b=BNKy7UAyRiNmvWJdf0W2y9CShO4twQPwGt38GZFYIwK9U3NNpT1Rcw0o
 cJbf9gHScml1VwV+V+7DmXBnrveDjUUDqx3YQ6oTsp+drFFhL/J1LFPoe
 EbxfOpfZ4Zn942kkRUmOLL86c5cbxRGz27s6Un53HMIozbS0RQaOgWkQw
 4CMYQHexWN+koVfKMLxd3K+v83FNAcLu0DTl6OdjHwO5AioZdekzTuyt+
 /2wHFJCNuMJTQOBWrMwjMW4tjSVI1WbIAqS/ecbwIJ7PnPipJP8xDHxPi
 kwgbWfC+c2SxtdvO083uEP6wrNDA1ljN35mXTUXD/Wi/ypHXsVVAYGZvc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067929"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067929"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065579"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065579"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:56 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yu Zhang <yu.c.zhang@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 18/23] intel_iommu: fix the fault reason report
Date: Mon, 15 Jan 2024 18:37:30 +0800
Message-Id: <20240115103735.132209-19-zhenzhong.duan@intel.com>
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

From: Yu Zhang <yu.c.zhang@linux.intel.com>

Currently we use only VTD_FR_PASID_TABLE_INV as
fault reaon. Fix this with correct fault reasons
listed in VT-d spec 7.2.3.

Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  8 ++++++-
 hw/i386/intel_iommu.c          | 42 +++++++++++++++++++++-------------
 2 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 41b958cd5d..21fa767740 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -325,8 +325,14 @@ typedef enum VTDFaultReason {
                                   * request while disabled */
     VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
 
-    VTD_FR_PASID_TABLE_INV = 0x58,  /*Invalid PASID table entry */
+    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
+    /* PASID directory entry access failure */
+    VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
+    /* The Present(P) field of pasid directory entry is 0 */
+    VTD_FR_PASID_DIR_ENTRY_P = 0x51,
+    VTD_FR_PASID_TABLE_ACCESS_ERR = 0x58, /* PASID table entry access failure */
     VTD_FR_PASID_ENTRY_P = 0x59, /* The Present(P) field of pasidt-entry is 0 */
+    VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
 
     /* Output address in the interrupt address range for scalable mode */
     VTD_FR_SM_INTERRUPT_ADDR = 0x87,
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1c21f40ccd..1e87383a41 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -819,7 +819,7 @@ static int vtd_get_pdire_from_pdir_table(dma_addr_t pasid_dir_base,
     addr = pasid_dir_base + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pdire, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ACCESS_ERR;
     }
 
     pdire->val = le64_to_cpu(pdire->val);
@@ -832,6 +832,11 @@ static inline bool vtd_pe_present(VTDPASIDEntry *pe)
     return pe->val[0] & VTD_PASID_ENTRY_P;
 }
 
+static inline uint32_t vtd_pe_get_flpt_level(VTDPASIDEntry *pe)
+{
+    return 4 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM);
+}
+
 static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
                                           uint32_t pasid,
                                           dma_addr_t addr,
@@ -840,13 +845,14 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
     uint32_t index;
     dma_addr_t entry_size;
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+    uint8_t pgtt;
 
     index = VTD_PASID_TABLE_INDEX(pasid);
     entry_size = VTD_PASID_ENTRY_SIZE;
     addr = addr + index * entry_size;
     if (dma_memory_read(&address_space_memory, addr,
                         pe, entry_size, MEMTXATTRS_UNSPECIFIED)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ACCESS_ERR;
     }
     for (size_t i = 0; i < ARRAY_SIZE(pe->val); i++) {
         pe->val[i] = le64_to_cpu(pe->val[i]);
@@ -854,12 +860,17 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
 
     /* Do translation type check */
     if (!vtd_pe_type_check(x86_iommu, pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_TABLE_ENTRY_INV;
     }
 
-    if (!vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe))) {
-        return -VTD_FR_PASID_TABLE_INV;
-    }
+    pgtt = VTD_PE_GET_TYPE(pe);
+    if (pgtt == VTD_SM_PASID_ENTRY_SLT &&
+        !vtd_is_level_supported(s, VTD_PE_GET_LEVEL(pe)))
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
+
+    if (pgtt == VTD_SM_PASID_ENTRY_FLT &&
+        vtd_pe_get_flpt_level(pe) != 4)
+            return -VTD_FR_PASID_TABLE_ENTRY_INV;
 
     return 0;
 }
@@ -899,7 +910,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     ret = vtd_get_pe_from_pdire(s, pasid, &pdire, pe);
@@ -908,7 +919,7 @@ static int vtd_get_pe_from_pasid_table(IntelIOMMUState *s,
     }
 
     if (!vtd_pe_present(pe)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_ENTRY_P;
     }
 
     return 0;
@@ -961,7 +972,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
     }
 
     if (!vtd_pdire_present(&pdire)) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_PASID_DIR_ENTRY_P;
     }
 
     /*
@@ -1829,7 +1840,11 @@ static const bool vtd_qualified_faults[] = {
     [VTD_FR_ROOT_ENTRY_RSVD] = false,
     [VTD_FR_PAGING_ENTRY_RSVD] = true,
     [VTD_FR_CONTEXT_ENTRY_TT] = true,
-    [VTD_FR_PASID_TABLE_INV] = false,
+    [VTD_FR_PASID_DIR_ACCESS_ERR] = false,
+    [VTD_FR_PASID_DIR_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ACCESS_ERR] = false,
+    [VTD_FR_PASID_ENTRY_P] = true,
+    [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
     [VTD_FR_SM_INTERRUPT_ADDR] = true,
     [VTD_FR_MAX] = false,
 };
@@ -1904,11 +1919,6 @@ static inline uint64_t vtd_flpt_level_page_mask(uint32_t level)
     return ~((1ULL << vtd_flpt_level_shift(level)) - 1);
 }
 
-static inline dma_addr_t vtd_pe_get_flpt_level(VTDPASIDEntry *pe)
-{
-    return 4 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM);
-}
-
 /*
  * Given an iova and the level of paging structure, return the offset
  * of current level.
@@ -3499,7 +3509,7 @@ static inline int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s,
     dma_addr_t pasid_dir_base;
 
     if (!s->root_scalable) {
-        return -VTD_FR_PASID_TABLE_INV;
+        return -VTD_FR_RTADDR_INV_TTM;
     }
 
     ret = vtd_dev_to_context_entry(s, bus_num, devfn, &ce);
-- 
2.34.1


