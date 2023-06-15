Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233D4730D9F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dpU-0005cy-HK; Wed, 14 Jun 2023 23:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpS-0005cg-G5
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:22 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpQ-0003pb-P2
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686800360; x=1718336360;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=c+tgk//W5cgwU6zn0AuJ0TG3lRdRmRHblHfLr00w71s=;
 b=cwmX3f52I5oRPuqjxuAhHZoJTbMgJAGtn4jC5rknvTqGIaUXkMGHhsuT
 UG6418MBxVP6D2nMulClwpA1EFMFgANV0xdyMLu0iVxphMMcSZSOSikSm
 sxSzZAyQkmKX74EZp3EyOcMpbaGGcz3GPZzPmp8XKtMoKZhgbuSY0l5a0
 gcbcDne7FyD43/TzekFyl6ZG7SBQ35U2NWMMRo4hihsVBA/bcJ9NSkQ9x
 epfnS59UCCBOSgFIyXuS6+gcBhZXeIlOsy49FZRy8LAH10CBNbgSQDdCc
 JRvlJ3BsWBItWmuT0Ug/URTkO9oECLG5t4ECT79p/isseOwCVjslYBMv1 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362182799"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="362182799"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662626510"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="662626510"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:15 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 kwankhede@nvidia.com, cjia@nvidia.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: [PATCH v4 1/3] intel_iommu: Fix a potential issue in VFIO dirty page
 sync
Date: Thu, 15 Jun 2023 11:26:24 +0800
Message-Id: <20230615032626.314476-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615032626.314476-1-zhenzhong.duan@intel.com>
References: <20230615032626.314476-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

Peter Xu found a potential issue:

"The other thing is when I am looking at the new code I found that we
actually extended the replay() to be used also in dirty tracking of vfio,
in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
unmap_all() because afaiu log_sync() can be called in migration thread
anytime during DMA so I think it means the device is prone to DMA with the
IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
fail unexpectedly.  Copy Alex, Kirti and Neo."

Fix it by replacing the unmap_all() to only evacuate the iova tree
(keeping all host mappings untouched, IOW, don't notify UNMAP), and
do a full resync in page walk which will notify all existing mappings
as MAP. This way we don't interrupt with any existing mapping if there
is (e.g. for the dirty sync case), meanwhile we keep sync too to latest
(for moving a vfio device into an existing iommu group).

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205d2..34af12f392f5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3825,13 +3825,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     IntelIOMMUState *s = vtd_as->iommu_state;
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
     VTDContextEntry ce;
+    DMAMap map = { .iova = 0, .size = HWADDR_MAX };
 
-    /*
-     * The replay can be triggered by either a invalidation or a newly
-     * created entry. No matter what, we release existing mappings
-     * (it means flushing caches for UNMAP-only registers).
-     */
-    vtd_address_space_unmap(vtd_as, n);
+    /* replay is protected by BQL, page walk will re-setup it safely */
+    iova_tree_remove(vtd_as->iova_tree, map);
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
-- 
2.34.1


