Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 749AE727C4D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:06:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CWj-0000AL-7c; Thu, 08 Jun 2023 06:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWY-00007I-Dk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:48 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWR-0007tA-8C
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686218739; x=1717754739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=k6pazZM8t2kfEFHaI7eml0v1NUuRM/XJAG7pYSmrhXU=;
 b=AIV2tIhts6SHvzRjNnpY2g+7X3ZFJ4dj2/daELWG8aA1xLSMLoZOnA3V
 sqTi8vK9g6M4t5vAvPDNf7+c0Qi7V+BoGsHl/FA3ESzpxoHg/suIHc9F8
 vc7y59/oDYL2nnFEQgkehHnT+uWlLQSO7T+GxtGsWkDCsScyBmNJW+Psa
 6Fww0cCjVLRr2jKTX3ftVXlLtvkve6ly8d5L75qWtz2A7kczJ6yW28HjZ
 IIO9K6FmVguLbLqVhRbGgFvFyIkJtM/Y67A07kQuh38x+8ymEDtdR3KyX
 Mj7bVAYVYOXRGDvhuECaSbnUbubbEM9nl0Yb4rs/efgL65J3uRXrrKkvW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337624432"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="337624432"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956652066"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="956652066"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v3 3/5] intel_iommu: Fix flag check in replay
Date: Thu,  8 Jun 2023 17:52:29 +0800
Message-Id: <20230608095231.225450-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608095231.225450-1-zhenzhong.duan@intel.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mga17.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Replay doesn't notify registered notifiers but the one passed
to it. So it's meaningless to check the registered notifier's
synthetic flag.

There is no issue currently as all replay use cases have MAP
flag set, but let's be robust.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


