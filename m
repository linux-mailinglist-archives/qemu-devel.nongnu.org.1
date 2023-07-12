Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B9E750055
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:43:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURu-0004GN-KG; Wed, 12 Jul 2023 03:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURs-0004DV-8u
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:44 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURq-0006oM-KR
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147582; x=1720683582;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wAyFkAIBXMppDvtxsys+A+jSAf+ZNgDKnymq/F4VcsY=;
 b=FZVvvVW0ZZfxxSYyS6qUXAdx71VFV99OAOHaFsmhxBvNJaE9SCXs5oXb
 9wLcAQ1VasaCNpoPCqB7fFsNbo4BUZbldaP5U89qLRjKUFh8ZwQlXhjvt
 AW9SnItGN2bV/zmetzO/d1R8e3eWyyGwyDnuR7dy+epYVRHJdCb+MU7kA
 mdaiQQkKkgb1NQnmxZQpwjmukFldVMiWbr2n5JWkUcN4dODrTfx92IJmi
 lHabmmIrfG1gjk0bsZSNBKbx31CTMY15XjTA+f0P/1aRz4Gk+E31j+Azm
 tgykZGGee0DTUS/2Kiz5WXpsvUJHa6XWP/3cbwvcjS9/HHwURAwPjJcbw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953670"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024014"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024014"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:23 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 09/24] vfio/common: Rename into as.c
Date: Wed, 12 Jul 2023 15:25:13 +0800
Message-Id: <20230712072528.275577-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Yi Liu <yi.l.liu@intel.com>

As the file mostly contains code related to VFIOAddressSpaces and
MemoryListeners, let's rename it into as.c

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/{common.c => as.c} | 0
 hw/vfio/meson.build        | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/vfio/{common.c => as.c} (100%)

diff --git a/hw/vfio/common.c b/hw/vfio/as.c
similarity index 100%
rename from hw/vfio/common.c
rename to hw/vfio/as.c
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 2a6912c940..7937dab078 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -1,7 +1,7 @@
 vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'helpers.c',
-  'common.c',
+  'as.c',
   'container.c',
   'spapr.c',
   'migration.c',
-- 
2.34.1


