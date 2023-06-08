Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B5A727C4C
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7CWO-0008V2-NT; Thu, 08 Jun 2023 06:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWK-0008US-16
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:32 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7CWH-0007nc-Lv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686218729; x=1717754729;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9F+Mc9VF74DcZg6hFSGE0eB7mt8jnYFlQG5NmflvmYs=;
 b=JCOf3NY1rsIx/1A/N/fLwGyYOwbM7XO3RtwGHDJlriHRYwk0/MVHgjEx
 Efd5vOuoyKwMdHiAIiN4xEGQIJ4euMBay9DGBaPfzAVRL41w/oMRezvYa
 EgzWQtsg48IC7ftaV1iRXRbprhZ+a+hlRjIwZOnhGgK/xlRGgYWtorjNj
 nv8OOXuGO3E0sTXsV93y0VF5LWcWjlxGu6l3fhtBbrPN7Xa4HovDuIVbz
 ppDuOruRr9nF5oq9c2CZIR2Qj+hNNDaQOKtOTXAvvtHY4ZraxpNNtWQTj
 HcRFW/sTDOehGjhHP8Jar65q+Es1VJmPst+STxa/zKRaaLt/iyhrL022Z g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="337624380"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="337624380"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="956652017"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; d="scan'208";a="956652017"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 03:05:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v3 0/5] Optimize UNMAP call and bug fix
Date: Thu,  8 Jun 2023 17:52:26 +0800
Message-Id: <20230608095231.225450-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi All,

This patchset includes some fixes on VFIO dirty sync and vIOMMU.
PATCH1 isn't needed now as dependent changes in PATCH2 is removed,
but as Peter has given Reviewed-by, leave it to maintainer to
decide if pick or not.

Tested net card passthrough, ping/ssh pass
Tested DSA vdev passthrough, start dmatest then do live migration, pass.
Checked the LM performance before and after patch, no explicit difference.
(DSA vdev requires customed kernel and qemu)

v3:
updated PATCH2 to fix VFIO dirty sync in Peter suggested way.
split PATCH4 in v2 to PATCH4 and PATCH5 as they target different issue.
dropped PATCH3 in v2.
add Suggested-by.

Thanks

Zhenzhong Duan (5):
  util: Add iova_tree_foreach_range_data
  intel_iommu: Fix a potential issue in VFIO dirty page sync
  intel_iommu: Fix flag check in replay
  intel_iommu: Fix address space unmap
  intel_iommu: Optimize out some unnecessary UNMAP calls

 hw/i386/intel_iommu.c    | 37 +++++++++++++++++++------------------
 include/qemu/iova-tree.h | 17 +++++++++++++++--
 util/iova-tree.c         | 31 +++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 20 deletions(-)

-- 
2.34.1


