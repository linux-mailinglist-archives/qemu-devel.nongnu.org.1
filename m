Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787370D723
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:20:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NF8-0004UE-PT; Tue, 23 May 2023 04:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q1NF6-0004Tm-6g
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:19:40 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q1NF3-0005N9-Gn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684829977; x=1716365977;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wf/N1SMwE02glMH/l/yHrg8c/GFZCHuhXd+i2CXsPpk=;
 b=hJXxUdvzuWgO6sK0mtQdbxX4pOLAJxKkL5amQc15re7FGMTnomHjO/ya
 dgeJJl+ZzEAl0OgIQGQuVx7AEXqu7aFq8IP3he/TOfdOZiL4UyDYPKEHO
 mD7HRo4L2h1yFAvsH8/dmyuvrrahW9C3G4T+9CyBSLSDnigmGrbiTgHy3
 tOBzeRnD83qH2jyLOI0t1ZICo93z9gW5kU5X2onNil0i3Kj2vUj3w3RCO
 lSU3tBtrIApTI3TsupLI6M4Y/0gJ/1pxFxZeTFSKGHlUBO4F/ZrnVsRhv
 KmKNQsyVBQ8GrYXuoNZDZrzxZiuxLOOEBtiiCx5vc0+GOQX8RQz/ZoPDO Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="418879543"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; d="scan'208";a="418879543"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 01:19:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="793647800"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400"; d="scan'208";a="793647800"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 01:19:21 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Date: Tue, 23 May 2023 16:07:02 +0800
Message-Id: <20230523080702.179363-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Commit 63b88968f1 ("intel-iommu: rework the page walk logic") adds logic
to record mapped IOVA ranges so we only need to send MAP or UNMAP when
necessary. But there are still a few corner cases of unnecessary UNMAP.

One is address space switch. During switching to iommu address space,
all the original mappings have been dropped by VFIO memory listener,
we don't need to unmap again in replay. The other is invalidation,
we only need to unmap when there are recorded mapped IOVA ranges,
presuming most of OSes allocating IOVA range continuously,
ex. on x86, linux sets up mapping from 0xffffffff downwards.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
Tested on x86 with a net card passed or hotpluged to kvm guest,
ping/ssh pass.

 hw/i386/intel_iommu.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205d2..6afd6428aaaa 100644
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
+        map.size = size;
+        if (iova_tree_find(as->iova_tree, &map)) {
+            event.entry.iova = start;
+            event.entry.addr_mask = mask;
+            memory_region_notify_iommu_one(n, &event);
+        }
 
         start += size;
         remain -= size;
@@ -3826,13 +3830,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
     VTDContextEntry ce;
 
-    /*
-     * The replay can be triggered by either a invalidation or a newly
-     * created entry. No matter what, we release existing mappings
-     * (it means flushing caches for UNMAP-only registers).
-     */
-    vtd_address_space_unmap(vtd_as, n);
-
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
                                   "legacy mode",
-- 
2.34.1


