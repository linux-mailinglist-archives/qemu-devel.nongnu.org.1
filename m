Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 098F8AD0027
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Jun 2025 12:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNU0n-0000U4-Vj; Fri, 06 Jun 2025 06:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0k-0000QR-Ix
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:18 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uNU0e-0007c5-OE
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 06:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749204553; x=1780740553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DI58VuIQqxrYvarl8DuQleqUhqpMUprKQCWrJbzMfio=;
 b=M287VRwRBijDo04+OlpzvFHugQrkW4aUJD7EKkjTs/4lV3PGfXWMgxvp
 /cOE2x9t2qm4ufofSgPlc4Kjtj4GMf7i5qaTno9zU03ij6p4hsDt7T202
 gOplC/hP1SmIedI8ko0xMEVBV2G7aSqI4Hp1QDJM1W8S+XiMA9w+Jji44
 mw/E5UTluqgxoNSzGkKgn1mnRjL5xFzE/h35UZkFI//8SVM88JmhVDwSZ
 yKFoZrx6fgHeL6MJG6P+bEbarFFaVUkAtYzoCcn7AnLKSRoXiGWaLZY3o
 nSUStHweSK0W8diHW9yogNvHYKpUFser48FcVVpgc04hLeiUydRWLybGl A==;
X-CSE-ConnectionGUID: u3En/imuS4+StmDViT7llw==
X-CSE-MsgGUID: GtR3HeK6TYa3mEFBOOgT4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="76747339"
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="76747339"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:12 -0700
X-CSE-ConnectionGUID: he7PI6gUTqeW8o23ou8t5Q==
X-CSE-MsgGUID: +JnliCuuQX+GuCUoD5ioig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,214,1744095600"; d="scan'208";a="146759208"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 03:09:07 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 11/15] intel_iommu: Replay pasid binds after context cache
 invalidation
Date: Fri,  6 Jun 2025 18:04:12 +0800
Message-Id: <20250606100416.346132-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606100416.346132-1-zhenzhong.duan@intel.com>
References: <20250606100416.346132-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

From: Yi Liu <yi.l.liu@intel.com>

This replays guest pasid attachments after context cache invalidation.
This is a behavior to ensure safety. Actually, programmer should issue
pasid cache invalidation with proper granularity after issuing a context
cache invalidation.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu_internal.h |  1 +
 hw/i386/intel_iommu.c          | 51 ++++++++++++++++++++++++++++++++--
 hw/i386/trace-events           |  1 +
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
index 75d840f9fe..198726b48f 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -575,6 +575,7 @@ typedef enum VTDPCInvType {
     VTD_PASID_CACHE_FORCE_RESET = 0,
     /* pasid cache invalidation rely on guest PASID entry */
     VTD_PASID_CACHE_GLOBAL_INV, /* pasid cache global invalidation */
+    VTD_PASID_CACHE_DEVSI,      /* pasid cache device selective invalidation */
     VTD_PASID_CACHE_DOMSI,      /* pasid cache domain selective invalidation */
     VTD_PASID_CACHE_PASIDSI,    /* pasid cache pasid selective invalidation */
 } VTDPCInvType;
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index b8c0d0dd2e..275b8bafef 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -91,6 +91,10 @@ static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
 
 static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
+static void vtd_pasid_cache_sync(IntelIOMMUState *s,
+                                 VTDPASIDCacheInfo *pc_info);
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -2417,6 +2421,8 @@ static void vtd_iommu_replay_all(IntelIOMMUState *s)
 
 static void vtd_context_global_invalidate(IntelIOMMUState *s)
 {
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
+
     trace_vtd_inv_desc_cc_global();
     /* Protects context cache */
     vtd_iommu_lock(s);
@@ -2434,6 +2440,9 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
      * VT-d emulation codes.
      */
     vtd_iommu_replay_all(s);
+
+    pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
+    vtd_pasid_cache_sync(s, &pc_info);
 }
 
 #ifdef CONFIG_IOMMUFD
@@ -2989,6 +2998,21 @@ static void vtd_context_device_invalidate(IntelIOMMUState *s,
              * happened.
              */
             vtd_address_space_sync(vtd_as);
+            /*
+             * Per spec, context flush should also followed with PASID
+             * cache and iotlb flush. Regards to a device selective
+             * context cache invalidation:
+             * if (emaulted_device)
+             *    invalidate pasid cache and pasid-based iotlb
+             * else if (assigned_device)
+             *    check if the device has been bound to any pasid
+             *    invoke pasid_unbind regards to each bound pasid
+             * Here, we have vtd_pasid_cache_devsi() to invalidate pasid
+             * caches, while for piotlb in QEMU, we don't have it yet, so
+             * no handling. For assigned device, host iommu driver would
+             * flush piotlb when a pasid unbind is pass down to it.
+             */
+             vtd_pasid_cache_devsi(s, vtd_as->bus, devfn);
         }
     }
 }
@@ -3737,6 +3761,11 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         /* Fall through */
     case VTD_PASID_CACHE_GLOBAL_INV:
         break;
+    case VTD_PASID_CACHE_DEVSI:
+        if (pc_info->bus != vtd_as->bus || pc_info->devfn != vtd_as->devfn) {
+            return false;
+        }
+        break;
     default:
         error_report("invalid pc_info->type");
         abort();
@@ -3933,6 +3962,11 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     case VTD_PASID_CACHE_GLOBAL_INV:
         /* loop all assigned devices */
         break;
+    case VTD_PASID_CACHE_DEVSI:
+        walk_info.bus = pc_info->bus;
+        walk_info.devfn = pc_info->devfn;
+        vtd_replay_pasid_bind_for_dev(s, start, end, &walk_info);
+        return;
     case VTD_PASID_CACHE_FORCE_RESET:
         /* For force reset, no need to go further replay */
         return;
@@ -3968,8 +4002,7 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
  * It includes updating the pasid cache in vIOMMU and updating the
  * pasid bindings per guest's latest pasid entry presence.
  */
-static void vtd_pasid_cache_sync(IntelIOMMUState *s,
-                                 VTDPASIDCacheInfo *pc_info)
+static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
 {
     if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
         return;
@@ -4030,6 +4063,20 @@ static void vtd_pasid_cache_sync(IntelIOMMUState *s,
     vtd_replay_guest_pasid_bindings(s, pc_info);
 }
 
+static void vtd_pasid_cache_devsi(IntelIOMMUState *s,
+                                  PCIBus *bus, uint16_t devfn)
+{
+    VTDPASIDCacheInfo pc_info = { .error_happened = false, };
+
+    trace_vtd_pasid_cache_devsi(devfn);
+
+    pc_info.type = VTD_PASID_CACHE_DEVSI;
+    pc_info.bus = bus;
+    pc_info.devfn = devfn;
+
+    vtd_pasid_cache_sync(s, &pc_info);
+}
+
 static bool vtd_process_pasid_desc(IntelIOMMUState *s,
                                    VTDInvDesc *inv_desc)
 {
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index de903a0033..f001b820d9 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -28,6 +28,7 @@ vtd_pasid_cache_reset(void) ""
 vtd_pasid_cache_gsi(void) ""
 vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
 vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
+vtd_pasid_cache_devsi(uint16_t devfn) "Dev selective PC invalidation dev: 0x%"PRIx16
 vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
 vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
 vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
-- 
2.34.1


