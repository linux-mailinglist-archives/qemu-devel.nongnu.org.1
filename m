Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C7719384
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:47:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c50-0004KQ-V3; Thu, 01 Jun 2023 02:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4y-0004KI-2G
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:36 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4w-00077p-74
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685601993; x=1717137993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d1VixyNubrvQo5Vj6XTAaxOQt/YjrCUWfhpDJ8Iv61U=;
 b=kVV11IhlFINIvzSQjIquFm6rR8cNwF0szDBZTZXK9ZdruPvEnoY55lZD
 4x27a4hq2AN0LwOO1n0ekB44fNIR8bEEunuHvuvrykUsHVMYkRo1jQ7cp
 GyGb1T91J0SpA8O87gLRxCc31KfRPO+JPqHiLiCHoXLdp5HFDP8kyiRY6
 0COafhfVyWLVWKOaGajwSk7RUU5AXRU004ZIETJwBCZtxVZ6dOgWBa+WI
 q7kkMp/xE/oVjks1oFaNWnZh9aiF0lgYcPxmQ6gdjLb/UtX7UvrFJFfuP
 Cf2IpwMS/zLssmiA8/zIWs9DSWQ/ATk88IpigkLc97t/4t0TLRymeI6N+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421249381"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="421249381"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953953100"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953953100"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:29 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v2 4/4] intel_iommu: Optimize out some unnecessary UNMAP calls
Date: Thu,  1 Jun 2023 14:33:20 +0800
Message-Id: <20230601063320.139308-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601063320.139308-1-zhenzhong.duan@intel.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds IOVA
tree to cache mapped ranges so we only need to send MAP or UNMAP when
there are changes. But there is still a corner case of unnecessary UNMAP.

During invalidation, either domain or device selective, we only need to
unmap when there are recorded mapped IOVA ranges, presuming most of OSes
allocating IOVA range continuously, e.g. on x86, linux sets up mapping
from 0xffffffff downwards.

Strace shows UNMAP ioctl taking 0.000014us and we have 28 such ioctl()
in one invalidation, as two notifiers in x86 are split into power of 2
pieces.

ioctl(48, VFIO_IOMMU_UNMAP_DMA, 0x7ffffd5c42f0) = 0 <0.000014>

The other purpose of this patch is to eliminate noisy error log when we
work with IOMMUFD. It looks the duplicate UNMAP call will fail with IOMMUFD
while always succeed with legacy container. This behavior difference leads
to below error log for IOMMUFD:

IOMMU_IOAS_UNMAP failed: No such file or directory
vfio_container_dma_unmap(0x562012d6b6d0, 0x0, 0x80000000) = -2 (No such file or directory)
IOMMU_IOAS_UNMAP failed: No such file or directory
vfio_container_dma_unmap(0x562012d6b6d0, 0x80000000, 0x40000000) = -2 (No such file or directory)
...

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 061fcded0dfb..a5fd144aa246 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3743,6 +3743,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     hwaddr start = n->start;
     hwaddr end = n->end;
     IntelIOMMUState *s = as->iommu_state;
+    IOMMUTLBEvent event;
     DMAMap map;
 
     /*
@@ -3762,22 +3763,25 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
     assert(start <= end);
     size = remain = end - start + 1;
 
+    event.type = IOMMU_NOTIFIER_UNMAP;
+    event.entry.target_as = &address_space_memory;
+    event.entry.perm = IOMMU_NONE;
+    /* This field is meaningless for unmap */
+    event.entry.translated_addr = 0;
+
     while (remain >= VTD_PAGE_SIZE) {
-        IOMMUTLBEvent event;
         uint64_t mask = dma_aligned_pow2_mask(start, end, s->aw_bits);
         uint64_t size = mask + 1;
 
         assert(size);
 
-        event.type = IOMMU_NOTIFIER_UNMAP;
-        event.entry.iova = start;
-        event.entry.addr_mask = mask;
-        event.entry.target_as = &address_space_memory;
-        event.entry.perm = IOMMU_NONE;
-        /* This field is meaningless for unmap */
-        event.entry.translated_addr = 0;
-
-        memory_region_notify_iommu_one(n, &event);
+        map.iova = start;
+        map.size = mask;
+        if (iova_tree_find(as->iova_tree, &map)) {
+            event.entry.iova = start;
+            event.entry.addr_mask = mask;
+            memory_region_notify_iommu_one(n, &event);
+        }
 
         start += size;
         remain -= size;
@@ -3791,7 +3795,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              n->start, size);
 
     map.iova = n->start;
-    map.size = size;
+    map.size = size - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
-- 
2.34.1


