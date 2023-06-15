Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C69730D9D
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9dpS-0005cR-Vy; Wed, 14 Jun 2023 23:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpQ-0005cE-EX
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:20 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9dpO-0003pb-IE
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 23:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686800358; x=1718336358;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xKors8puxed9EdA4JYhjyu6oi4ZdWa/BBbYjDsjC9uQ=;
 b=gP3ClCWbXhT1uIQCaSHLNVocoC0PiCk16uTTImI+pRO6Nuk3nMukKlzi
 3j+FnJRuhfJHTe+18FW/gv1faY2PY/liy7LRjpT40px19tl1yzQSHC5G1
 Cr5IfeCJS/R5JqbimplG6IgpEGMRW5tgAG2Q8km1hOePpPA2t8N7VAmKi
 yRfIf2g/j7oAvv8NakEKeIMmhUNBe1m/oPO38P9SqnWO886a68KaVhJTm
 C9aqnCUU0a2xl48n43GOxZBJlxt2tBUQrq6k4ILLQSViwlCsveCFdcvMn
 t2QmcLevL2adzop9E5e8MwPiYdvJ601Rc79Ak3nGFlyuFLgVmlrR2iC1h g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362182794"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="362182794"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="662626504"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; d="scan'208";a="662626504"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2023 20:39:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 kwankhede@nvidia.com, cjia@nvidia.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: [PATCH v4 0/3] Some fixes on intel_iommu
Date: Thu, 15 Jun 2023 11:26:23 +0800
Message-Id: <20230615032626.314476-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi All,

This patchset fixes a potential issue in VFIO dirty page sync and
two trivial fixes for robust purpose.

Tested net card passthrough, ping/ssh pass
Tested DSA vdev passthrough, start dmatest then do live migration, pass.
Checked the LM performance before and after patch, no explicit difference.
(DSA vdev requires customed kernel and qemu)

v4:
Add Reviewed-by
Drop PATCH1 and PATCH5

v3:
updated PATCH2 to fix VFIO dirty sync in Peter suggested way.
split PATCH4 in v2 to PATCH4 and PATCH5 as they target different issue.
dropped PATCH3 in v2.
add Suggested-by.

Thanks

Zhenzhong Duan (3):
  intel_iommu: Fix a potential issue in VFIO dirty page sync
  intel_iommu: Fix flag check in replay
  intel_iommu: Fix address space unmap

 hw/i386/intel_iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

-- 
2.34.1


