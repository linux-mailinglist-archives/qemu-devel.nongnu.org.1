Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D192482D795
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKNw-0000jq-WC; Mon, 15 Jan 2024 05:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNu-0000gf-BJ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:02 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNs-0002kC-A7
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315200; x=1736851200;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CmrsCEMVEfEQPHwzbT2P/VKgXPg6Wj6hai7KgFcbhbw=;
 b=A9AYR4pS7uf4N5Vc5Ny2Qz0K4E2EO5C2ryxKxssWhyNrr+eDbYBs5sr1
 Ed9wWYgjgSKm2CwnennB2RO5VulIhgpooVnqh74BKL7GwDyKr+GIiAash
 IX7dPGPF1K59/0DnEST0188HMwjEK0KFr6l7cRTOGki+E/FMm1L6kX6u7
 S2xg0ly9WyS777HGdxGwmpptDnpx77K2mhpqURFFUZD1e/7RmtQfW82Uc
 riyb/qvH2Hd7ibMOu92I67Jue8IcttJVKFkAFbpHLXVNGRIhOn2GjItGS
 8dPElfyIyCb4eA1uWAMXWcC7Txo916qHMQ3uZ1BBm9YU1hXhWh2GzRs4h w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067588"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067588"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065333"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065333"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:54 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 06/23] intel_iommu: check and sync host IOMMU cap/ecap
 in scalable modern mode
Date: Mon, 15 Jan 2024 18:37:18 +0800
Message-Id: <20240115103735.132209-7-zhenzhong.duan@intel.com>
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

When vIOMMU is configured in scalable modern mode, stage-1 page table is
supported. We need to check and sync host side cap/ecap with vIOMMU
cap/ecap.

This happens when PCIe device (i.e., VFIO case) sets IOMMUFDDevice to vIOMMU.
Some of the bits in cap/ecap is user controllable, then user setting is
compared with host cap/ecap for compatibility, i.e., if intel_iommu is
configured in scalable modern but VTD_ECAP_NEST isn't set in host ecap,
that device will fail to attach. For other bits not controlled by user,
i.e. VTD_CAP/ECAP_MASK bits, host cap/ecap is picked.

Below is the sequence to initial and finalize vIOMMU cap/ecap:

vtd_cap_init() initializes iommu->cap/ecap. ---- vtd_cap_init()
iommu->host_cap/ecap is initialized as iommu->cap/ecap.  ---- vtd_init()
iommu->host_cap/ecap is updated some bits(VTD_CAP/ECAP_MASK) with host setting. ---- vtd_sync_hw_info()
iommu->cap/ecap is finalized as iommu->host_cap/ecap.  ---- vtd_machine_done_hook()

iommu->host_cap/ecap is a temporary storage to hold intermediate value
when synthesize host cap/ecap with vIOMMU's initial configured cap/ecap.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h | 10 ++++
 hw/i386/intel_iommu.c          | 83 ++++++++++++++++++++++++++++++----
 2 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index ee4a784a35..6d881adf9b 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -191,13 +191,19 @@
 #define VTD_ECAP_PT                 (1ULL << 6)
 #define VTD_ECAP_SC                 (1ULL << 7)
 #define VTD_ECAP_MHMV               (15ULL << 20)
+#define VTD_ECAP_NEST               (1ULL << 26)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_EAFS               (1ULL << 34)
+#define VTD_ECAP_PSS(val)           (((val) & 0x1fULL) << 35)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_SMTS               (1ULL << 43)
 #define VTD_ECAP_SLTS               (1ULL << 46)
 #define VTD_ECAP_FLTS               (1ULL << 47)
 
+#define VTD_ECAP_MASK               (VTD_ECAP_SRS | VTD_ECAP_EAFS)
+#define VTD_GET_PSS(val)            (((val) >> 35) & 0x1f)
+#define VTD_ECAP_PSS_MASK           (0x1fULL << 35)
+
 /* CAP_REG */
 /* (offset >> 4) << 24 */
 #define VTD_CAP_FRO                 (DMAR_FRCD_REG_OFFSET << 20)
@@ -214,11 +220,15 @@
 #define VTD_CAP_DRAIN_WRITE         (1ULL << 54)
 #define VTD_CAP_DRAIN_READ          (1ULL << 55)
 #define VTD_CAP_FL1GP               (1ULL << 56)
+#define VTD_CAP_FL5LP               (1ULL << 60)
 #define VTD_CAP_DRAIN               (VTD_CAP_DRAIN_READ | VTD_CAP_DRAIN_WRITE)
 #define VTD_CAP_CM                  (1ULL << 7)
 #define VTD_PASID_ID_SHIFT          20
 #define VTD_PASID_ID_MASK           ((1ULL << VTD_PASID_ID_SHIFT) - 1)
 
+
+#define VTD_CAP_MASK                (VTD_CAP_FL1GP | VTD_CAP_FL5LP)
+
 /* Supported Adjusted Guest Address Widths */
 #define VTD_CAP_SAGAW_SHIFT         8
 #define VTD_CAP_SAGAW_MASK          (0x1fULL << VTD_CAP_SAGAW_SHIFT)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1d007c33a8..c0973aaccb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,19 +3819,82 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static bool vtd_check_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
+                              Error **errp)
+{
+    if (!(vtd->ecap_reg & VTD_ECAP_NEST)) {
+        error_setg(errp, "Need nested translation on host in modern mode");
+        return false;
+    }
+
+    return true;
+}
+
+/* cap/ecap are readonly after vIOMMU finalized */
+static bool vtd_check_hw_info_finalized(IntelIOMMUState *s,
+                                        struct iommu_hw_info_vtd *vtd,
+                                        Error **errp)
+{
+    if (s->cap & ~vtd->cap_reg & VTD_CAP_MASK) {
+        error_setg(errp, "vIOMMU cap %lx isn't compatible with host %llx",
+                   s->cap, vtd->cap_reg);
+        return false;
+    }
+
+    if (s->ecap & ~vtd->ecap_reg & VTD_ECAP_MASK) {
+        error_setg(errp, "vIOMMU ecap %lx isn't compatible with host %llx",
+                   s->ecap, vtd->ecap_reg);
+        return false;
+    }
+
+    if (s->ecap & vtd->ecap_reg & VTD_ECAP_PASID &&
+        VTD_GET_PSS(s->ecap) > VTD_GET_PSS(vtd->ecap_reg)) {
+        error_setg(errp, "vIOMMU pasid bits %lu > host pasid bits %llu",
+                   VTD_GET_PSS(s->ecap), VTD_GET_PSS(vtd->ecap_reg));
+        return false;
+    }
+
+    return true;
+}
+
 static bool vtd_sync_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
                              Error **errp)
 {
-    uint64_t addr_width;
+    uint64_t cap, ecap, addr_width, pasid_bits;
 
-    addr_width = (vtd->cap_reg >> 16) & 0x3fULL;
-    if (s->aw_bits > addr_width) {
-        error_setg(errp, "User aw-bits: %u > host address width: %lu",
-                   s->aw_bits, addr_width);
+    if (!s->scalable_modern) {
+        addr_width = (vtd->cap_reg >> 16) & 0x3fULL;
+        if (s->aw_bits > addr_width) {
+            error_setg(errp, "User aw-bits: %u > host address width: %lu",
+                       s->aw_bits, addr_width);
+            return false;
+        }
+        return true;
+    }
+
+    if (!vtd_check_hw_info(s, vtd, errp)) {
         return false;
     }
 
-    /* TODO: check and sync host cap/ecap into vIOMMU cap/ecap */
+    if (s->cap_finalized) {
+        return vtd_check_hw_info_finalized(s, vtd, errp);
+    }
+
+    /* sync host cap/ecap to vIOMMU */
+
+    cap = s->host_cap & vtd->cap_reg & VTD_CAP_MASK;
+    s->host_cap &= ~VTD_CAP_MASK;
+    s->host_cap |= cap;
+    ecap = s->host_ecap & vtd->ecap_reg & VTD_ECAP_MASK;
+    s->host_ecap &= ~VTD_ECAP_MASK;
+    s->host_ecap |= ecap;
+
+    pasid_bits = VTD_GET_PSS(vtd->ecap_reg);
+    if (s->host_ecap & VTD_ECAP_PASID &&
+        VTD_GET_PSS(s->host_ecap) > pasid_bits) {
+        s->host_ecap &= ~VTD_ECAP_PSS_MASK;
+        s->host_ecap |= VTD_ECAP_PSS(pasid_bits);
+    }
 
     return true;
 }
@@ -3873,9 +3936,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
-    /* None IOMMUFD case */
-    if (!idev) {
+    if (!s->scalable_modern && !idev) {
+        /* Legacy vIOMMU and non-IOMMUFD backend */
         return 0;
+    } else if (!idev) {
+        /* Modern vIOMMU and non-IOMMUFD backend */
+        error_setg(errp, "Need IOMMUFD backend to setup nested page table");
+        return -1;
     }
 
     if (!vtd_check_idev(s, idev, errp)) {
-- 
2.34.1


