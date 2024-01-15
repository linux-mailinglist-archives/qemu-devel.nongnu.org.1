Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145E382D796
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKOf-00035v-Jq; Mon, 15 Jan 2024 05:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOe-000347-Cy
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:48 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOc-0003GV-Cq
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315246; x=1736851246;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rzv4rACBfIq9ROOfL34OgDBmAl9ewK2Tn0IPg/RHhrA=;
 b=HRa/+nS+4B7spO4WKxgQRoB5+h314UpYpShBG0AcuEF47ekYYAbR8P3t
 vcOeeRSTqFRqCV94avFjnPYf7ZAgtFfx5FSdCHovA5En9Umb+TGEEePH0
 OSanmgFNzmKnUuEowdOYPS7oGl/97G57Q0et8/peR/pnKmkVL7xkifwxQ
 gJ4Kc/Bw2yaumYjE6xSpYsbn6RjAohWF6YxHhra8HuKkWCkP0rhvZ1Aog
 wujhTaop3XKDwaUj7PcQrP6dSU50yITo16ZWy+bPQBJM7FcEq2YY3kk51
 WqbBVAJldkCNG4ik/9n8Z5RL7uBNzs6koowsDjIGmZUKZraGFrL0qwJTO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067850"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067850"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065425"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065425"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:40 -0800
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
Subject: [PATCH rfcv1 15/23] intel_iommu: process PASID-based Device-TLB
 invalidation
Date: Mon, 15 Jan 2024 18:37:27 +0800
Message-Id: <20240115103735.132209-16-zhenzhong.duan@intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

This adds an empty handling for PASID-based Device-TLB invalidation.
For now it is enough as it is not necessary to propagate it to host
for passthrough device.

The reason for an empty device tlb invalidation handling is that
iommufd's intel vt-d cache invalidation uapi indicates all caches
related to the mapping. So no need to send device tlb. spec says
an iotlb invalidation should be issued before issuing device tlb
invalidation. This means host should have received a cache invalidation
due to guest iotlb invalidation. Hence no need to send another cache
invalidation due to device tlb invalidation.

Chapter 6.5.2.5:
"Since translation requests-without-PASID from a device may be serviced by
hardware from the IOTLB, software must always request IOTLB invalidation
(iotlb_inv_dsc) before requesting corresponding Device-TLB (dev_tlb_inv_dsc)
invalidation."

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index ed0d5cd99b..dcf1410fcf 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -380,6 +380,7 @@ typedef union VTDInvDesc VTDInvDesc;
 #define VTD_INV_DESC_WAIT               0x5 /* Invalidation Wait Descriptor */
 #define VTD_INV_DESC_PIOTLB             0x6 /* PASID-IOTLB Invalidate Desc */
 #define VTD_INV_DESC_PC                 0x7 /* PASID-cache Invalidate Desc */
+#define VTD_INV_DESC_DEV_PIOTLB         0x8 /* PASID-based-DIOTLB inv_desc*/
 #define VTD_INV_DESC_NONE               0   /* Not an Invalidate Descriptor */
 
 /* Masks for Invalidation Wait Descriptor*/
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2912fc6b88..5e7d445d98 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3950,6 +3950,17 @@ static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
     return true;
 }
 
+static bool vtd_process_device_piotlb_desc(IntelIOMMUState *s,
+                                           VTDInvDesc *inv_desc)
+{
+    /*
+     * no need to handle it for passthru device, for emulated
+     * devices with device tlb, it may be required, but for now,
+     * return is enough
+     */
+    return true;
+}
+
 static bool vtd_process_device_iotlb_desc(IntelIOMMUState *s,
                                           VTDInvDesc *inv_desc)
 {
@@ -4066,6 +4077,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
         }
         break;
 
+    case VTD_INV_DESC_DEV_PIOTLB:
+        trace_vtd_inv_desc("device-piotlb", inv_desc.hi, inv_desc.lo);
+        if (!vtd_process_device_piotlb_desc(s, &inv_desc)) {
+            return false;
+        }
+        break;
+
     case VTD_INV_DESC_DEVICE:
         trace_vtd_inv_desc("device", inv_desc.hi, inv_desc.lo);
         if (!vtd_process_device_iotlb_desc(s, &inv_desc)) {
-- 
2.34.1


