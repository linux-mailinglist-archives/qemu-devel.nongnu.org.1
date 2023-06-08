Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F81727C4A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CWi-0000A5-LC; Thu, 08 Jun 2023 06:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWT-00005a-6R
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:42 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWR-0007rz-ON
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686218739; x=1717754739;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4CgpPYVbeorcoGZpZNNOjXMIcZ32rq+ORgYJFTf1398=;
 b=EazVifGq4b0QNsmHJ6TV7ol219gQObl9uoTzWEIOJNn1lpAqAd1Tv7rf
 M8Blf7czpEAUNvPPTcF4CXgWz9SZk3BE189xv9gHpfzIkwfl3r++BLcaD
 nqQIM1nnnwPQMLvnW3iRLlL0y6OTlVHiPjfXn083xozJNpnXSfYgYU2V7
 ogkNMQE2rBq0/uzvgRurlV7BOPokcXMDlu7UDnBM5Diur65qnT/vM4+97
 OYd4K1JLP2EgKf558GKNZsP9OrmiIDJiWw2E2YdnpVMBjR7HgmkDzTLzu
 iSLenj7eGBGh3nF4Mxc9qSR9/prAOA2ukaib3ZlIMSpeomDE1Rp6jofXj Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337624448"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="337624448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956652087"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="956652087"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:34 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Date: Thu,  8 Jun 2023 17:52:30 +0800
Message-Id: <20230608095231.225450-5-zhenzhong.duan@intel.com>
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

During address space unmap, corresponding IOVA tree entries are
also removed. But DMAMap is set beyond notifier's scope by 1, so
in theory there is possibility to remove a continuous entry above
the notifier's scope but falling in adjacent notifier's scope.

There is no issue currently as no use cases allocate notifiers
continuously, but let's be robust.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f046f8591335..dcc334060cd6 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3791,7 +3791,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              n->start, size);
 
     map.iova = n->start;
-    map.size = size;
+    map.size = size - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
-- 
2.34.1


