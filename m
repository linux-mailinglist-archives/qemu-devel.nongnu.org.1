Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E622B82D705
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:17:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1b-0007iY-4T; Mon, 15 Jan 2024 05:16:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1Y-0007iO-TW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:56 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1W-0007Q7-GP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313814; x=1736849814;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VZD6V8ZTFo0W2/fiSlQ4zviQC5Yy1Sfx4PmCNMdFT8Y=;
 b=XSAkVM5U10UUS+6kg276MFR4lRBM/0PD+vXceZDazXzpFxNljDDaUFos
 Nl2t7lVz3sQ/1+YEZyQmgWUKwEfvGPt/nfBQW97J4GtLnsJYxYODwTygX
 GJ2QAW3VqKrYG+Z3f35Ta7UXp22ivd3gVQgvk5QCdQb4kQndFiwZnmlN4
 REIAgUiAkGve/YvIse+3zSPL16Afvukwl5SunnkcwO2dRVcagqjDXam/O
 H79Y8RrDFZ1+SZqb6SloBi4xMsuH1aBlK7bDTPACKi1Abf8zaWCm/YqN7
 qOVHM5eMHajSDVCp9o74OWKHZaTI9jXKU980TYn9o5CRatfnL01wMXwju Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032528"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032528"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599525"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599525"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:48 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv1 6/6] intel_iommu: add a framework to check and sync host
 IOMMU cap/ecap
Date: Mon, 15 Jan 2024 18:13:13 +0800
Message-Id: <20240115101313.131139-7-zhenzhong.duan@intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

Add a framework to check and synchronize host IOMMU cap/ecap with
vIOMMU cap/ecap.

Currently only stage-2 translation is supported which is backed by
shadow page table on host side. So we don't need exact matching of
each bit of cap/ecap between vIOMMU and host. However, we can still
utilize this framework to ensure compatibility of host and vIOMMU's
address width at least, i.e., vIOMMU's aw_bits <= host aw_bits,
which is missed before.

When stage-1 translation is supported in future, a.k.a. scalable
modern mode, we need to ensure compatibility of each bits. Some
bits are user controllable, they should be checked with host side
to ensure compatibility. Other bits are not, they should be synced
into vIOMMU cap/ecap for compatibility.

The sequence will be:

vtd_cap_init() initializes iommu->cap/ecap. ---- vtd_cap_init()
iommu->host_cap/ecap is initialized as iommu->cap/ecap.  ---- vtd_init()
iommu->host_cap/ecap is checked and updated some bits with host cap/ecap. ---- vtd_sync_hw_info()
iommu->cap/ecap is finalized as iommu->host_cap/ecap.  ---- vtd_machine_done_hook()

iommu->host_cap/ecap is a temporary storage to hold intermediate value
when synthesize host cap/ecap and vIOMMU's initial configured cap/ecap.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  4 ++
 hw/i386/intel_iommu.c         | 78 +++++++++++++++++++++++++++++++----
 2 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index c65fdde56f..b8abbcce12 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -292,6 +292,9 @@ struct IntelIOMMUState {
     uint64_t cap;                   /* The value of capability reg */
     uint64_t ecap;                  /* The value of extended capability reg */
 
+    uint64_t host_cap;              /* The value of host capability reg */
+    uint64_t host_ecap;             /* The value of host ext-capability reg */
+
     uint32_t context_cache_gen;     /* Should be in [1,MAX] */
     GHashTable *iotlb;              /* IOTLB */
 
@@ -314,6 +317,7 @@ struct IntelIOMMUState {
     bool dma_translation;           /* Whether DMA translation supported */
     bool pasid;                     /* Whether to support PASID */
 
+    bool cap_finalized;             /* Whether VTD capability finalized */
     /*
      * Protects IOMMU states in general.  Currently it protects the
      * per-IOMMU IOTLB cache, and context entry cache in VTDAddressSpace.
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 4c1d058ebd..be03fcbf52 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,6 +3819,47 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_sync_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
+                             Error **errp)
+{
+    uint64_t addr_width;
+
+    addr_width = (vtd->cap_reg >> 16) & 0x3fULL;
+    if (s->aw_bits > addr_width) {
+        error_setg(errp, "User aw-bits: %u > host address width: %lu",
+                   s->aw_bits, addr_width);
+        return false;
+    }
+
+    /* TODO: check and sync host cap/ecap into vIOMMU cap/ecap */
+
+    return true;
+}
+
+/*
+ * virtual VT-d which wants nested needs to check the host IOMMU
+ * nesting cap info behind the assigned devices. Thus that vIOMMU
+ * could bind guest page table to host.
+ */
+static bool vtd_check_idev(IntelIOMMUState *s, IOMMUFDDevice *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_vtd vtd;
+    enum iommu_hw_info_type type = IOMMU_HW_INFO_TYPE_INTEL_VTD;
+
+    if (iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd)) {
+        error_setg(errp, "Failed to get IOMMU capability!!!");
+        return false;
+    }
+
+    if (type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
+        error_setg(errp, "IOMMU hardware is not compatible!!!");
+        return false;
+    }
+
+    return vtd_sync_hw_info(s, &vtd, errp);
+}
+
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
                                     IOMMUFDDevice *idev, Error **errp)
 {
@@ -3837,6 +3878,10 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
         return 0;
     }
 
+    if (!vtd_check_idev(s, idev, errp)) {
+        return -1;
+    }
+
     vtd_iommu_lock(s);
 
     vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
@@ -4071,10 +4116,11 @@ static void vtd_init(IntelIOMMUState *s)
 {
     X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
-    memset(s->csr, 0, DMAR_REG_SIZE);
-    memset(s->wmask, 0, DMAR_REG_SIZE);
-    memset(s->w1cmask, 0, DMAR_REG_SIZE);
-    memset(s->womask, 0, DMAR_REG_SIZE);
+    /* CAP/ECAP are initialized in machine create done stage */
+    memset(s->csr + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
+    memset(s->wmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
+    memset(s->w1cmask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
+    memset(s->womask + DMAR_GCMD_REG, 0, DMAR_REG_SIZE - DMAR_GCMD_REG);
 
     s->root = 0;
     s->root_scalable = false;
@@ -4110,13 +4156,16 @@ static void vtd_init(IntelIOMMUState *s)
         vtd_spte_rsvd_large[3] &= ~VTD_SPTE_SNP;
     }
 
-    vtd_cap_init(s);
+    if (!s->cap_finalized) {
+        vtd_cap_init(s);
+        s->host_cap = s->cap;
+        s->host_ecap = s->ecap;
+    }
+
     vtd_reset_caches(s);
 
     /* Define registers with default values and bit semantics */
     vtd_define_long(s, DMAR_VER_REG, 0x10UL, 0, 0);
-    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
-    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
     vtd_define_long(s, DMAR_GCMD_REG, 0, 0xff800000UL, 0);
     vtd_define_long_wo(s, DMAR_GCMD_REG, 0xff800000UL);
     vtd_define_long(s, DMAR_GSTS_REG, 0, 0, 0);
@@ -4241,6 +4290,12 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
     return true;
 }
 
+static void vtd_setup_capability_reg(IntelIOMMUState *s)
+{
+    vtd_define_quad(s, DMAR_CAP_REG, s->cap, 0, 0);
+    vtd_define_quad(s, DMAR_ECAP_REG, s->ecap, 0, 0);
+}
+
 static int vtd_machine_done_notify_one(Object *child, void *unused)
 {
     IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
@@ -4259,6 +4314,14 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
 
 static void vtd_machine_done_hook(Notifier *notifier, void *unused)
 {
+    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
+
+    iommu->cap = iommu->host_cap;
+    iommu->ecap = iommu->host_ecap;
+    iommu->cap_finalized = true;
+
+    vtd_setup_capability_reg(iommu);
+
     object_child_foreach_recursive(object_get_root(),
                                    vtd_machine_done_notify_one, NULL);
 }
@@ -4292,6 +4355,7 @@ static void vtd_realize(DeviceState *dev, Error **errp)
 
     QLIST_INIT(&s->vtd_as_with_notifiers);
     qemu_mutex_init(&s->iommu_lock);
+    s->cap_finalized = false;
     memory_region_init_io(&s->csrmem, OBJECT(s), &vtd_mem_ops, s,
                           "intel_iommu", DMAR_REG_SIZE);
     memory_region_add_subregion(get_system_memory(),
-- 
2.34.1


