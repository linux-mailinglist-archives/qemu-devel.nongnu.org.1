Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D62737D2C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBszh-0004fx-4c; Wed, 21 Jun 2023 04:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszX-0004ew-Jj
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:04 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszV-0002s8-91
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687335301; x=1718871301;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mNuXNxjtVp9RLH7yf+INXJlD+blwYMF2DVMvyiVISEQ=;
 b=P8afrtrteYSg7ei/MgN7oj+7Am7hQ4P8sWNf41aCirfuj0r6+d5wiJba
 /PCqMadoz9FJPlu1c0hbWXWCiyrruB+GIDIc9xSjBjs5Dt6C+DmAmqWMY
 cUE1vNWmw1haRR+tQoBFPwdt8fQH8VE15vsCMxS4UCeeY10GWzO1RSWQS
 7JlQX3X9qGgjWS5rgQQWrjQjpWuqlDPlZtpHv/+4KoPmn8t6oyEqyAe5p
 EWBb0DAEcGsxAdqQff7/E2jiM8YarkACMEWIiTXfkYhneqrleK6mZe8+T
 5A9LSv4nogWG0WM/uaAPW5xZU+kPuNCp2tZlludw9aDG4/PYZvojbxAl6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344843456"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="344843456"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:14:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804282290"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="804282290"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:14:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Date: Wed, 21 Jun 2023 16:02:02 +0800
Message-Id: <20230621080204.420723-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621080204.420723-1-zhenzhong.duan@intel.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When adding migration blocker failed in vfio_migration_realize(),
hotplug will fail and we see below:

(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,x-enable-migration=true
0000:81:11.1: VFIO migration is not supported in kernel
Error: disallowing migration blocker (--only-migratable) for: VFIO device doesn't support migration

If we hotplug again we should see same log as above, but we see:
(qemu) device_add vfio-pci,host=81:11.0,id=vfio0,bus=root0,x-enable-migration=true
Error: vfio 0000:81:11.0: device is already attached

That's because some references to VFIO device isn't released,
we should check return value of vfio_migration_realize() and
release the references, then VFIO device will be truely
released when hotplug failed.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73874a94de12..c71b0955d81c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
             error_report("%s: Migration disabled", vbasedev->name);
+            goto out_deregister;
         }
     }
 
-- 
2.34.1


