Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8476A719380
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4c4p-0004Hq-Ks; Thu, 01 Jun 2023 02:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4n-0004H6-Hb
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:25 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q4c4l-00072j-1x
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 02:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685601982; x=1717137982;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hEOxUjycGRiDea9C06uSOfcvuD3cHL4VQf4u/4D15GU=;
 b=fFHVD+ekXy+CFCCuLO9Tv5ts4UMS+C+u9UQApAfD3HBKasL9rcPj7K/4
 +GzHiO59zfWvlsnWaMS8Gq0Nz0uGU1vgpS5O6FxEp8rwYyfAFa1VRKxFG
 qBUtcfbKq0HdZAGQLAfJzHcLJ3hXtuOq+3aa0grrfAb6mZFdT0IZ5Ropn
 Fw5sD6u5Tp7O7QQiUoKX7CLbQmS31JJGX08IlgigPcCjtWT3HCICPzuBK
 iKge3OPY8TkYsVq+4gCi/drabBRl60hNKUwUYerxfyGJewMra3tJZbjSZ
 rTCMB0y5E+LbwC3ViMZCbSotYCb9RlijEXbciGM8uNiFv9IqY9Dowdl8g A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="421249303"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="421249303"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="953953048"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="953953048"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 23:46:13 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com, clg@redhat.com,
 david@redhat.com, philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: [PATCH v2 0/4] Optimize UNMAP call and bug fix
Date: Thu,  1 Jun 2023 14:33:16 +0800
Message-Id: <20230601063320.139308-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
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

Hi All,

This is an extention to original patch [1] based on discuss in [2].

1. Fixed a potential VFIO migration issue Peter found, and optimize
   VFIO dirty page sync in intel_iommu incidentally.

2. Clarify the definition of replay() to match existent optimization
   in intel_iommu.

3. Optimize out some potential UNMAP calls

Tested net card passthrough, ping/ssh pass
Tested DSA vdev passthrough, start dmatest then do live migration, pass.
I checked the LM performance before and after patch, no explicit difference.
I think it may because dirty page sync isn't an important factor in LM
and it's small in number in my test, 4 or 5.

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg05549.html
[2] https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg06708.html

Thanks

Zhenzhong Duan (4):
  util: Add iova_tree_foreach_range_data
  intel_iommu: Fix a potential issue in VFIO dirty page sync
  memory: Document update on replay()
  intel_iommu: Optimize out some unnecessary UNMAP calls

 hw/i386/intel_iommu.c    | 75 +++++++++++++++++++++++++++++-----------
 hw/vfio/common.c         |  2 +-
 include/exec/memory.h    | 19 ++++++++--
 include/qemu/iova-tree.h | 17 +++++++--
 softmmu/memory.c         |  4 +++
 util/iova-tree.c         | 31 +++++++++++++++++
 6 files changed, 122 insertions(+), 26 deletions(-)

-- 
2.34.1


