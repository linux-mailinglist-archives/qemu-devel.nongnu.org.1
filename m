Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C348D7B70
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 08:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0y4-0007Qe-UD; Mon, 03 Jun 2024 02:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xq-0006mx-FS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:40 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0xn-0000xl-Ft
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395275; x=1748931275;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=B7nXRh7ZojaXtdhNyRfMhv/+nlUrwKMI6CTd3vTaKw0=;
 b=FuxPPiTHJZb9GW5GSn/U9iDB7ebuz1FuiLuHsTPGljE3pP1Hvpu+jpOK
 95BRfaNvanAdGzQwA+VWz6TWhEtjICuAYNF8ctHP5glcKZDEsvpxb69HI
 F9+2I2QZQeGAJ+Ln8icKXh+gdDLNMcoXpRE/+YkIcRKXwCxJsBG5d+myV
 RjDe0FIcuGG9JD1zUTZbMXEpGFMprQq2Hj6xVLPTEuvhoj2BcNBPjGP14
 gL0wDfW8ne/mNJ/CmpsaA5QgRJhiCm6eKLQ1lcZlfHjE/+6TYchNCp9r9
 vZDYfy5z02wyn+ZYDmXZ4iMYEZwsAiIRwKdXdr5OJyAoeoVs53MJQSaM+ A==;
X-CSE-ConnectionGUID: ethdSeD6R5CRz2NTa7aAsA==
X-CSE-MsgGUID: Ne/UShP5T9a8LlmlaF9H+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277774"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277774"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:25 -0700
X-CSE-ConnectionGUID: j0zz8ApUQ46v09usbXqTkw==
X-CSE-MsgGUID: Pr3AkDXvQty5PmnhUvKAJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855981"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:14:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v6 17/19] intel_iommu: Extract out vtd_cap_init() to
 initialize cap/ecap
Date: Mon,  3 Jun 2024 14:10:21 +0800
Message-Id: <20240603061023.269738-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Extract cap/ecap initialization in vtd_cap_init() to make code
cleaner.

No functional change intended.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 93 ++++++++++++++++++++++++-------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index cc8e59674e..519063c8f8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3934,30 +3934,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     return;
 }
 
-/* Do the initialization. It will also be called when reset, so pay
- * attention when adding new initialization stuff.
- */
-static void vtd_init(IntelIOMMUState *s)
+static void vtd_cap_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    memset(s->csr, 0, DMAR_REG_SIZE);
-    memset(s->wmask, 0, DMAR_REG_SIZE);
-    memset(s->w1cmask, 0, DMAR_REG_SIZE);
-    memset(s->womask, 0, DMAR_REG_SIZE);
-
-    s->root = 0;
-    s->root_scalable = false;
-    s->dmar_enabled = false;
-    s->intr_enabled = false;
-    s->iq_head = 0;
-    s->iq_tail = 0;
-    s->iq = 0;
-    s->iq_size = 0;
-    s->qi_enabled = false;
-    s->iq_last_desc_type = VTD_INV_DESC_NONE;
-    s->iq_dw = false;
-    s->next_frcd_reg = 0;
     s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
              VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SLLPS |
              VTD_CAP_MGAW(s->aw_bits);
@@ -3974,27 +3954,6 @@ static void vtd_init(IntelIOMMUState *s)
     }
     s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
 
-    /*
-     * Rsvd field masks for spte
-     */
-    vtd_spte_rsvd[0] = ~0ULL;
-    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
-                                                  x86_iommu->dt_supported);
-    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
-    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
-
-    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
-                                                         x86_iommu->dt_supported);
-
-    if (s->scalable_mode || s->snoop_control) {
-        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
-        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
-    }
-
     if (x86_iommu_ir_supported(x86_iommu)) {
         s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;
         if (s->intr_eim == ON_OFF_AUTO_ON) {
@@ -4027,6 +3986,56 @@ static void vtd_init(IntelIOMMUState *s)
     if (s->pasid) {
         s->ecap |= VTD_ECAP_PASID;
     }
+}
+
+/*
+ * Do the initialization. It will also be called when reset, so pay
+ * attention when adding new initialization stuff.
+ */
+static void vtd_init(IntelIOMMUState *s)
+{
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
+
+    memset(s->csr, 0, DMAR_REG_SIZE);
+    memset(s->wmask, 0, DMAR_REG_SIZE);
+    memset(s->w1cmask, 0, DMAR_REG_SIZE);
+    memset(s->womask, 0, DMAR_REG_SIZE);
+
+    s->root = 0;
+    s->root_scalable = false;
+    s->dmar_enabled = false;
+    s->intr_enabled = false;
+    s->iq_head = 0;
+    s->iq_tail = 0;
+    s->iq = 0;
+    s->iq_size = 0;
+    s->qi_enabled = false;
+    s->iq_last_desc_type = VTD_INV_DESC_NONE;
+    s->iq_dw = false;
+    s->next_frcd_reg = 0;
+
+    vtd_cap_init(s);
+
+    /*
+     * Rsvd field masks for spte
+     */
+    vtd_spte_rsvd[0] = ~0ULL;
+    vtd_spte_rsvd[1] = VTD_SPTE_PAGE_L1_RSVD_MASK(s->aw_bits,
+                                                  x86_iommu->dt_supported);
+    vtd_spte_rsvd[2] = VTD_SPTE_PAGE_L2_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[3] = VTD_SPTE_PAGE_L3_RSVD_MASK(s->aw_bits);
+    vtd_spte_rsvd[4] = VTD_SPTE_PAGE_L4_RSVD_MASK(s->aw_bits);
+
+    vtd_spte_rsvd_large[2] = VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+    vtd_spte_rsvd_large[3] = VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits,
+                                                    x86_iommu->dt_supported);
+
+    if (s->scalable_mode || s->snoop_control) {
+        vtd_spte_rsvd[1] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[2] &= ~VTD_SPTE_SNP;
+        vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
+    }
 
     vtd_reset_caches(s);
 
-- 
2.34.1


