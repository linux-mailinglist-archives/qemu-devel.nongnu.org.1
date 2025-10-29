Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF083C1983E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 10:56:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE2tQ-0005x0-Au; Wed, 29 Oct 2025 05:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tN-0005wH-U1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:57 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vE2tI-0002n9-1m
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 05:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761731692; x=1793267692;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lq5YlZsXi79CCeK0nauOZ3bVXvHplXnalGhdh+p16z8=;
 b=Gc2WUiryacGf+gdGZF7V2R9uzSHyD1xgU0x52BfZaPZjPrTXEgsp+jXG
 /elcJ6+odoOM2KkzIkPHWzSRfr/cSUEtpxGGjdau1lVm5GQv8flUHfsUV
 VOjpIKhIghqQGAm/bZK2we2+/0LQHRWs1w56KZPRL/QmIT8QphUkGU6zo
 iDcGPerqzlJueneChLVglYnT/kSsmsqLJb6ICFdNLfcA5WB4gzB0ijJ+y
 Eo5WP/TV6yp1diG2TUORM+cRai5j5Q1gO6psY7q/CH0kaWtcI+xh+j2/H
 cdE/sOK1I8G7IVGVPBTEo7mBYwkMjBdwJnowdxM4jWZbxdWOcl6ZKS8tP Q==;
X-CSE-ConnectionGUID: RXbVp/nBTGK+1+Ytt787SQ==
X-CSE-MsgGUID: ENvV/VmsQPODFGZL9h+Piw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="67685140"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="67685140"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:49 -0700
X-CSE-ConnectionGUID: Lmw+k4u9RLeqD3H7NiYIdg==
X-CSE-MsgGUID: T4gJ606VRTutf+4pcUPVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; d="scan'208";a="185529892"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2025 02:54:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 07/10] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Date: Wed, 29 Oct 2025 05:53:50 -0400
Message-ID: <20251029095354.56305-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029095354.56305-1-zhenzhong.duan@intel.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

If a VFIO device in guest switches from IOMMU domain to block domain,
vtd_address_space_unmap() is called to unmap whole address space.

If that happens during migration, migration fails with legacy VFIO
backend as below:

Status: failed (vfio_container_dma_unmap(0x561bbbd92d90, 0x100000000000, 0x100000000000) = -7 (Argument list too long))

Because legacy VFIO limits maximum bitmap size to 256MB which maps to 8TB on
4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
ioctl fails. Normally such large UNMAP notification come from IOVA range
rather than system memory.

Fix it by iterating over DMAMap list to unmap each range with active mapping
when migration is active. If migration is not active, unmapping the whole
address space in one go is optimal.

There is no such limitation with iommufd backend, but it's still not optimal
to allocate large bitmap, e.g., there may be large hole between IOVA ranges,
allocating large bitmap and dirty tracking on the hole is time consuming and
useless work.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
Tested-by: Rohith S R <rohith.s.r@intel.com>
---
 hw/i386/intel_iommu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c402643b56..b00fdecaf8 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -37,6 +37,7 @@
 #include "system/system.h"
 #include "hw/i386/apic_internal.h"
 #include "kvm/kvm_i386.h"
+#include "migration/misc.h"
 #include "migration/vmstate.h"
 #include "trace.h"
 
@@ -4695,6 +4696,42 @@ static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int devfn)
     vtd_iommu_unlock(s);
 }
 
+/*
+ * Unmapping a large range in one go is not optimal during migration because
+ * a large dirty bitmap needs to be allocated while there may be only small
+ * mappings, iterate over DMAMap list to unmap each range with active mapping.
+ */
+static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
+                                                 IOMMUNotifier *n)
+{
+    const DMAMap *map;
+    const DMAMap target = {
+        .iova = n->start,
+        .size = n->end,
+    };
+    IOVATree *tree = as->iova_tree;
+
+    /*
+     * DMAMap is created during IOMMU page table sync, it's either 4KB or huge
+     * page size and always a power of 2 in size. So the range of DMAMap could
+     * be used for UNMAP notification directly.
+     */
+    while ((map = iova_tree_find(tree, &target))) {
+        IOMMUTLBEvent event;
+
+        event.type = IOMMU_NOTIFIER_UNMAP;
+        event.entry.iova = map->iova;
+        event.entry.addr_mask = map->size;
+        event.entry.target_as = &address_space_memory;
+        event.entry.perm = IOMMU_NONE;
+        /* This field is meaningless for unmap */
+        event.entry.translated_addr = 0;
+        memory_region_notify_iommu_one(n, &event);
+
+        iova_tree_remove(tree, *map);
+    }
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4704,6 +4741,11 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     IntelIOMMUState *s = as->iommu_state;
     DMAMap map;
 
+    if (migration_is_running()) {
+        vtd_address_space_unmap_in_migration(as, n);
+        return;
+    }
+
     /*
      * Note: all the codes in this function has a assumption that IOVA
      * bits are no more than VTD_MGAW bits (which is restricted by
-- 
2.47.1


