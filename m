Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 906E69C39BC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Nov 2024 09:40:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAPwN-0004s3-8c; Mon, 11 Nov 2024 03:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwG-0004rS-U2
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:24 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tAPwF-0003UG-2l
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 03:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731314303; x=1762850303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/8IG36P/t4d/6IkZ8Hw35fvK05oUnjKxvWgx+3gFyGc=;
 b=aKZ4KpJMs/S1CdRj3T3fjunaC2MPIYz3JJADEO2Nje2NnywVsGsRtpU4
 eHoxlmn+STIStpUYHWwB2be7WUzqFzy/+nr4Is6AHlxCovbNMWa06ei6q
 //ZkpoFD+IFa06qTcQFvBBKJQOKDlLJ8AiQL7YubdjbuIWol+wbkykzbB
 jjYnpBCkJ0708ibPMxv2sLnEZAXYy6ISwhJgB8SSPDvR8AZ4NKNmwwgUh
 ubmlCFVYHP6YaEJPKa1Y6eCGRO4WbRtZGGd3RNl9Eshj74KbQZmy7Y1Pk
 k1Pip7AE2mEVRwC+yvJf4cBJhe/Kybp/vjlxPrkn9cNW3M+uEHsLePoPk g==;
X-CSE-ConnectionGUID: j/jIS4fxR+qB3Lj9RMNL9w==
X-CSE-MsgGUID: Vb7rd7TkTfa5qzIfwT4ZGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11252"; a="31334367"
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="31334367"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:21 -0800
X-CSE-ConnectionGUID: cb1dW8/vQLu3X2ZBxz0U0w==
X-CSE-MsgGUID: f5EYL62lSKu3Z3relCHjSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,144,1728975600"; d="scan'208";a="87608265"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2024 00:38:18 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v5 04/20] intel_iommu: Flush stage-2 cache in PASID-selective
 PASID-based iotlb invalidation
Date: Mon, 11 Nov 2024 16:34:41 +0800
Message-Id: <20241111083457.2090664-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per VT-d spec 4.1, 6.5.2.4, "Table 21. PASID-based-IOTLB Invalidation",
PADID-selective PASID-based iotlb invalidation will flush stage-2 iotlb
entries with matching domain id and pasid.

With scalable modern mode introduced, guest could send PASID-selective
PASID-based iotlb invalidation to flush either stage-1 or stage-2 entries.

By this chance, remove old IOTLB related definitions which were unused.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu_internal.h | 14 ++++--
 hw/i386/intel_iommu.c          | 85 +++++++++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index a987023692..48019e2005 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -404,11 +404,6 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_IOTLB_AM(val)      ((val) & 0x3fULL)
 #define VTD_INV_DESC_IOTLB_RSVD_LO      0xffffffff0000f100ULL
 #define VTD_INV_DESC_IOTLB_RSVD_HI      0xf80ULL
-#define VTD_INV_DESC_IOTLB_PASID_PASID  (2ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID_PAGE   (3ULL << 4)
-#define VTD_INV_DESC_IOTLB_PASID(val)   (((val) >> 32) & VTD_PASID_ID_MASK)
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_LO      0xfff00000000001c0ULL
-#define VTD_INV_DESC_IOTLB_PASID_RSVD_HI      0xf80ULL
 
 /* Mask for Device IOTLB Invalidate Descriptor */
 #define VTD_INV_DESC_DEVICE_IOTLB_ADDR(val) ((val) & 0xfffffffffffff000ULL)
@@ -443,6 +438,15 @@ typedef union VTDInvDesc VTDInvDesc;
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM | VTD_SL_TM)) : \
         (0x3ffff800ULL | ~(VTD_HAW_MASK(aw) | VTD_SL_IGN_COM))
 
+/* Masks for PIOTLB Invalidate Descriptor */
+#define VTD_INV_DESC_PIOTLB_G             (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_ALL_IN_PASID  (2ULL << 4)
+#define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
+#define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
+#define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
+#define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
+
 /* Information about page-selective IOTLB invalidate */
 struct VTDIOTLBPageInvInfo {
     uint16_t domain_id;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1d13916a98..1b07146e23 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2692,6 +2692,83 @@ static bool vtd_process_iotlb_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
     return true;
 }
 
+static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
+    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
+
+    return ((entry->domain_id == info->domain_id) &&
+            (entry->pasid == info->pasid));
+}
+
+static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
+                                        uint16_t domain_id, uint32_t pasid)
+{
+    VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+
+    info.domain_id = domain_id;
+    info.pasid = pasid;
+
+    vtd_iommu_lock(s);
+    g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
+                                &info);
+    vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
+        if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                      vtd_as->devfn, &ce) &&
+            domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
+            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
+
+            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
+                vtd_as->pasid != pasid) {
+                continue;
+            }
+
+            if (!s->scalable_modern) {
+                vtd_address_space_sync(vtd_as);
+            }
+        }
+    }
+}
+
+static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
+                                    VTDInvDesc *inv_desc)
+{
+    uint16_t domain_id;
+    uint32_t pasid;
+    uint64_t mask[4] = {VTD_INV_DESC_PIOTLB_RSVD_VAL0,
+                        VTD_INV_DESC_PIOTLB_RSVD_VAL1,
+                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
+
+    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
+                                     __func__, "piotlb inv")) {
+        return false;
+    }
+
+    domain_id = VTD_INV_DESC_PIOTLB_DID(inv_desc->val[0]);
+    pasid = VTD_INV_DESC_PIOTLB_PASID(inv_desc->val[0]);
+    switch (inv_desc->val[0] & VTD_INV_DESC_PIOTLB_G) {
+    case VTD_INV_DESC_PIOTLB_ALL_IN_PASID:
+        vtd_piotlb_pasid_invalidate(s, domain_id, pasid);
+        break;
+
+    case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
+        break;
+
+    default:
+        error_report_once("%s: invalid piotlb inv desc: hi=0x%"PRIx64
+                          ", lo=0x%"PRIx64" (type mismatch: 0x%llx)",
+                          __func__, inv_desc->val[1], inv_desc->val[0],
+                          inv_desc->val[0] & VTD_INV_DESC_IOTLB_G);
+        return false;
+    }
+    return true;
+}
+
 static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
                                      VTDInvDesc *inv_desc)
 {
@@ -2810,6 +2887,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_PIOTLB:
+        trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
+        if (!vtd_process_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_WAIT:
         trace_vtd_inv_desc("wait", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_wait_desc(s, &inv_desc)) {
@@ -2837,7 +2921,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
      * iommu driver) work, just return true is enough so far.
      */
     case VTD_INV_DESC_PC:
-    case VTD_INV_DESC_PIOTLB:
         if (s->scalable_mode) {
             break;
         }
-- 
2.34.1


