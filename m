Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A230B14B3E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Jul 2025 11:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uggXl-0006up-UU; Tue, 29 Jul 2025 05:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXG-0005W3-4O
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:15 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uggXE-0002hc-0v
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 05:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753780932; x=1785316932;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1nLMzElehs6tW3dbq3bMZPxSJW79QvkawYEEw1pR7YI=;
 b=Fb6F95dAuEX+TjEnff45RMIfddhGCOpUBAv/CMYFRI9duoUizJBuwWqF
 r9Kmxzo4dMEZg1zhC8SiRD3wPXvYkvdNgBjmcutr1nLXYZu1jmdadnj8x
 MuDBLT49UqJz+8p5hdQrhFG5+TVEWL5ZyO+I63yrYH7d7/GY+x8qZBBIz
 Q2LxbT8SdGr20wHhrWDxvoTuDkNvLBpePUY3Rq5pIYP1tQzEddXOTecUB
 A3/s8Pnr0bQCuD6poNH/s/kibgtOyZPAXBWo4nZs3tEHVRYIzwWchC3y0
 JuuMPB7Us5eCGLfY1bCAk03Eg8+1ohiep3BPClmC74x2iZSW2tVrpydoW g==;
X-CSE-ConnectionGUID: fb63hJChQJmZF4kJh4aUSw==
X-CSE-MsgGUID: CLbOIP4tRLSiC8H6WWfrDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55981956"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55981956"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:22:07 -0700
X-CSE-ConnectionGUID: iCY4lmnERNuFIcv8PSomlw==
X-CSE-MsgGUID: FAxYvdXSSqe/7rnRMNAsMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162691423"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2025 02:21:48 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v4 12/20] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Date: Tue, 29 Jul 2025 05:20:34 -0400
Message-ID: <20250729092043.785836-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250729092043.785836-1-zhenzhong.duan@intel.com>
References: <20250729092043.785836-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
underlying pasid entry is still valid, it drops all the pasid caches.

FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
only used internally in system level reset.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  9 +++++++++
 hw/i386/intel_iommu.c          | 25 +++++++++++++++++++++++++
 hw/i386/trace-events           |  1 +
 3 files changed, 35 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index fb2a919e87..c510b09d1a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -569,6 +569,15 @@ typedef enum VTDPCInvType {
     VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
     VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
     VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
+
+    /*
+     * Internally used PASID cache invalidation type starts here,
+     * 0x10 is large enough as invalidation type in pc_inv_desc
+     * is 2bits in size.
+     */
+
+    /* Reset all PASID cache entries, used in system level reset */
+    VTD_PASID_CACHE_FORCE_RESET = 0x10,
 } VTDPCInvType;
 
 typedef struct VTDPASIDCacheInfo {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 95d1893a44..2d8588d9fe 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -87,6 +87,8 @@ struct vtd_iotlb_key {
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+
 static void vtd_panic_require_caching_mode(void)
 {
     error_report("We need to set caching-mode=on for intel-iommu to enable "
@@ -391,6 +393,7 @@ static void vtd_reset_caches(IntelIOMMUState *s)
     vtd_iommu_lock(s);
     vtd_reset_iotlb_locked(s);
     vtd_reset_context_cache_locked(s);
+    vtd_pasid_cache_reset_locked(s);
     vtd_iommu_unlock(s);
 }
 
@@ -3180,6 +3183,8 @@ static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
         /* fall through */
     case VTD_PASID_CACHE_GLOBAL_INV:
         break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        goto remove;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for flush");
     }
@@ -3222,6 +3227,23 @@ remove:
     return true;
 }
 
+static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info;
+
+    trace_vtd_pasid_cache_reset();
+
+    pc_info.type = VTD_PASID_CACHE_FORCE_RESET;
+
+    /*
+     * Reset pasid cache is a big hammer, so use g_hash_table_foreach_remove
+     * which will free all vtd_as instances except those created for PCI
+     * sub-system.
+     */
+    g_hash_table_foreach_remove(s->vtd_address_spaces,
+                                vtd_flush_pasid_locked, &pc_info);
+}
+
 /*
  * This function walks over PASID range within [start, end) in a single
  * PASID table for entries matching @info type/did, then retrieve/create
@@ -3360,6 +3382,9 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_GLOBAL_INV:
         /* loop all assigned devices */
         break;
+    case VTD_PASID_CACHE_FORCE_RESET:
+        /* For force reset, no need to go further replay */
+        return;
     default:
         error_setg(&error_fatal, "invalid pc_info->type for replay");
     }
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index ae5bbfcdc0..c8a936eb46 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -24,6 +24,7 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
 vtd_inv_qi_tail(uint16_t head) "write tail %d"
 vtd_inv_qi_fetch(void) ""
 vtd_context_cache_reset(void) ""
+vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
-- 
2.47.1


