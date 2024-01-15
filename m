Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A107782D70B
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:18:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1X-0007ho-4I; Mon, 15 Jan 2024 05:16:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1S-0007hW-QG
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:51 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1Q-0007Q7-Qg
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313808; x=1736849808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jzlIz+xqyPFKX6mKgHxAxAqCZndzvcdtf7o5NBPArXY=;
 b=PWREvdJDLarb2PBK51Jm1XbTjgZMjUXJ0IM+/zVcbr5xS4umZPJABaXI
 6cgUNf4gasnS4qrX1P8uR4Gar0PqFP9nMSh7hBzDo2uBJ1zDBNQhTF0ss
 aA0oFxqUO34zjb5aKOJxWODkyqa9r1wNMKMIzBOZnMOS4S7gfzGhOJOwH
 U9gK7rSgcO6QvjGhFsRFKUi1SkjQYAh/3tRDMTJgHaGLqqLHNEltSLFEW
 GzlVH2m2WAivylBDX94vdrkakz6MEMR3rX99b5Y7UzQq9frvwWNLZ8cjW
 CHi+3KOS8Bnvsi+aT0TNIa4EoKd4nzKoEF4zo6on/cfHOaZ/fOSKst/c/ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032508"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032508"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599517"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599517"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:43 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv1 5/6] intel_iommu: extract out vtd_cap_init to initialize
 cap/ecap
Date: Mon, 15 Jan 2024 18:13:12 +0800
Message-Id: <20240115101313.131139-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101313.131139-1-zhenzhong.duan@intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a prerequisite for host cap/ecap sync.

No functional change intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 92 +++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 95faf697eb..4c1d058ebd 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4009,30 +4009,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
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
@@ -4049,27 +4029,6 @@ static void vtd_init(IntelIOMMUState *s)
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
@@ -4102,7 +4061,56 @@ static void vtd_init(IntelIOMMUState *s)
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
 
+    vtd_cap_init(s);
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
-- 
2.34.1


