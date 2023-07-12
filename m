Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE37975003B
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:40:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURL-00045j-0R; Wed, 12 Jul 2023 03:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURG-00045A-7h
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:06 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURE-0005uM-9y
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147544; x=1720683544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pwt63gHRnDoXZ3T2Mf+OvoWjXHFkcAU7xOVp2wScvx0=;
 b=Aw0cOoVcwsZ89SXVkJrxRpno+gRIzwBDx8tJnaZn8gj5LOS2iMM1Irmj
 c+CR1Jf8YbRHpzEQB6SMn9VWTA18lrCuGmn8acaluuItbNFZrY2mmAIda
 UMlAwOBAT0DzLVsOa1qVq7AWCeBE+orOpjjIpJ2Pntb6qTj/Mk/rNp3zt
 N5Fz9Zdft1cXOrf+kejOCTDEtzcvIbYV6KsmLEV0ZQm7tmV4THuI/FJWX
 AFBHCsZOqXWYXUznRFI3M9n+IgmUqAbGJphbW9wdBGmCq34FoOrBR3Din
 LTx7rnci+NM2O7njvjzBODVm/voUNWTkRo1ToYz9bYM1b2jKjKT7WAaW8 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953548"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953548"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:38:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835023930"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835023930"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:38:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v4 01/24] scripts/update-linux-headers: Add iommufd.h
Date: Wed, 12 Jul 2023 15:25:05 +0800
Message-Id: <20230712072528.275577-2-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Update the script to import iommufd.h

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 scripts/update-linux-headers.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 35a64bb501..34295c0fe5 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -161,7 +161,8 @@ done
 rm -rf "$output/linux-headers/linux"
 mkdir -p "$output/linux-headers/linux"
 for header in const.h stddef.h kvm.h vfio.h vfio_ccw.h vfio_zdev.h vhost.h \
-              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h vduse.h; do
+              psci.h psp-sev.h userfaultfd.h memfd.h mman.h nvme_ioctl.h \
+              vduse.h iommufd.h; do
     cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
 done
 
-- 
2.34.1


