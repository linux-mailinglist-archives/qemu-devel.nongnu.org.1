Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC15730D9E
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dpZ-0005f8-4J; Wed, 14 Jun 2023 23:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpW-0005eq-OL
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:26 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpV-0003qf-69
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686800365; x=1718336365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E3JARyeWHEd/zAisEtngwSFOdTcxaJ6TCBPJvdFo3z0=;
 b=IriQ5zjCT4ReWIrIHi3oYXZdDbDJMeIRO8kHlX8yALctpXtGBxzKVBqs
 gfSBP5tra3sLdlgdgVvNqalSXEz928EvqraRnMokLICTkBkWbF8ehxVbQ
 l6DAXX7GMyoVFJ56CnkCr35reb1d3kIuOu57OfzkOr2RUjzSc9aP8uMhl
 KUcEJDyypEILJv2fM/C6nGM9AdsiBBk6fY/bBidjnmLhftEq2AWVtHGf3
 7sPT3FVRtgEWhjOyrLgqk3bjiE5mNDssfOa4bofBFqij5smWVm/y7aHYe
 ktVID5auS9HXvcnnAspdMrQKy2oVGuBk+A2akQkLaPkdz2UAH+dYHSaWu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362182811"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="362182811"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662626519"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="662626519"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 kwankhede@nvidia.com, cjia@nvidia.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: [PATCH v4 2/3] intel_iommu: Fix flag check in replay
Date: Thu, 15 Jun 2023 11:26:25 +0800
Message-Id: <20230615032626.314476-3-zhenzhong.duan@intel.com>
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

Replay doesn't notify registered notifiers but the one passed
to it. So it's meaningless to check the registered notifier's
synthetic flag.

There is no issue currently as all replay use cases have MAP
flag set, but let's be robust.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 34af12f392f5..f046f8591335 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3837,7 +3837,7 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
                                   PCI_FUNC(vtd_as->devfn),
                                   vtd_get_domain_id(s, &ce, vtd_as->pasid),
                                   ce.hi, ce.lo);
-        if (vtd_as_has_map_notifier(vtd_as)) {
+        if (n->notifier_flags & IOMMU_NOTIFIER_MAP) {
             /* This is required only for MAP typed notifiers */
             vtd_page_walk_info info = {
                 .hook_fn = vtd_replay_hook,
-- 
2.34.1


