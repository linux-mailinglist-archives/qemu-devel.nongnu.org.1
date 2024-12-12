Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689509EE190
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 09:42:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLem1-0004md-LI; Thu, 12 Dec 2024 03:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelb-0004ft-8r
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:56 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tLelZ-0007zv-He
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733992909; x=1765528909;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NRig9xicZToLVp64jS5HyMBzT+np40CCapHkrXRZR+g=;
 b=Z7Bbz3OI57rPPak/66g0s2CrYJjI2ul/OmXNWQyxVdydsnt7gOQT4okU
 CUNmsYOdMpyhF3CwrBFjxaS3zA5U2q9d2wPZDmjO0JhrzsKYoMrLkLQ1z
 82tLTG9yUJjOWJZN31Z4dC6ISxR5pOd8ClkwjyT9aKDMSQtlx2FCPFW+P
 WeIWHr6FOXm9Lcc62Ry6hzUJYVFoCJrLspzFKxPJAyno+Hl7FVQnCgabA
 UOnJw+GPzI3R5gwfSuRo9T1nEwtxMi8dYTJcTtZYx5OB2YLvtql9lT4hg
 4CYp3ksre47EG5YoXYkSwwW+F254Kl1RjcU2u19lwRREiQToE1L6UWE6i g==;
X-CSE-ConnectionGUID: 9uchILEwRPygo7DOQvJ3ng==
X-CSE-MsgGUID: GTkYoQPXSsq8T0Vgwef6FQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34124894"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; d="scan'208";a="34124894"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:49 -0800
X-CSE-ConnectionGUID: MhJDpMSRR0KB1y/CjJ0gow==
X-CSE-MsgGUID: OvDdlJWtR8GnynnTXBG3uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="119407060"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2024 00:41:44 -0800
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
Subject: [PATCH v6 08/20] intel_iommu: Check stage-1 translation result with
 interrupt range
Date: Thu, 12 Dec 2024 16:37:45 +0800
Message-Id: <20241212083757.605022-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212083757.605022-1-zhenzhong.duan@intel.com>
References: <20241212083757.605022-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
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

Per VT-d spec 4.1 section 3.15, "Untranslated requests and translation
requests that result in an address in the interrupt range will be
blocked with condition code LGN.4 or SGN.8."

This applies to both stage-1 and stage-2 IOMMU page table, move the
check from vtd_iova_to_slpte() to vtd_do_iommu_translate() so stage-1
page table could also be checked.

By this chance, update the comment with correct section number.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/i386/intel_iommu.c | 48 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index a4a2a44f92..594c8e3272 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1138,7 +1138,6 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
     uint32_t offset;
     uint64_t slpte;
     uint64_t access_right_check;
-    uint64_t xlat, size;
 
     if (!vtd_iova_sl_range_check(s, iova, ce, aw_bits, pasid)) {
         error_report_once("%s: detected IOVA overflow (iova=0x%" PRIx64 ","
@@ -1191,28 +1190,7 @@ static int vtd_iova_to_slpte(IntelIOMMUState *s, VTDContextEntry *ce,
         level--;
     }
 
-    xlat = vtd_get_pte_addr(*slptep, aw_bits);
-    size = ~vtd_pt_level_page_mask(level) + 1;
-
-    /*
-     * From VT-d spec 3.14: Untranslated requests and translation
-     * requests that result in an address in the interrupt range will be
-     * blocked with condition code LGN.4 or SGN.8.
-     */
-    if ((xlat > VTD_INTERRUPT_ADDR_LAST ||
-         xlat + size - 1 < VTD_INTERRUPT_ADDR_FIRST)) {
-        return 0;
-    } else {
-        error_report_once("%s: xlat address is in interrupt range "
-                          "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
-                          "slpte=0x%" PRIx64 ", write=%d, "
-                          "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
-                          "pasid=0x%" PRIx32 ")",
-                          __func__, iova, level, slpte, is_write,
-                          xlat, size, pasid);
-        return s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
-                                  -VTD_FR_INTERRUPT_ADDR;
-    }
+    return 0;
 }
 
 typedef int (*vtd_page_walk_hook)(const IOMMUTLBEvent *event, void *private);
@@ -2064,6 +2042,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     uint8_t access_flags;
     bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
     VTDIOTLBEntry *iotlb_entry;
+    uint64_t xlat, size;
 
     /*
      * We have standalone memory region for interrupt addresses, we
@@ -2173,6 +2152,29 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
         ret_fr = vtd_iova_to_slpte(s, &ce, addr, is_write, &pte, &level,
                                    &reads, &writes, s->aw_bits, pasid);
     }
+    if (!ret_fr) {
+        xlat = vtd_get_pte_addr(pte, s->aw_bits);
+        size = ~vtd_pt_level_page_mask(level) + 1;
+
+        /*
+         * Per VT-d spec 4.1 section 3.15: Untranslated requests and translation
+         * requests that result in an address in the interrupt range will be
+         * blocked with condition code LGN.4 or SGN.8.
+         */
+        if ((xlat <= VTD_INTERRUPT_ADDR_LAST &&
+             xlat + size - 1 >= VTD_INTERRUPT_ADDR_FIRST)) {
+            error_report_once("%s: xlat address is in interrupt range "
+                              "(iova=0x%" PRIx64 ", level=0x%" PRIx32 ", "
+                              "pte=0x%" PRIx64 ", write=%d, "
+                              "xlat=0x%" PRIx64 ", size=0x%" PRIx64 ", "
+                              "pasid=0x%" PRIx32 ")",
+                              __func__, addr, level, pte, is_write,
+                              xlat, size, pasid);
+            ret_fr = s->scalable_mode ? -VTD_FR_SM_INTERRUPT_ADDR :
+                                        -VTD_FR_INTERRUPT_ADDR;
+        }
+    }
+
     if (ret_fr) {
         vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
                          addr, is_write, pasid != PCI_NO_PASID, pasid);
-- 
2.34.1


