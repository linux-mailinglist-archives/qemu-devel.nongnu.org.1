Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB357422B6
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPU-0002K5-EU; Thu, 29 Jun 2023 04:53:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPQ-0002Jb-72
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:48 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPO-0003fe-Fh
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028826; x=1719564826;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G5HFVlLCJ61xkjz00WCRqTvVJSqyMqfJRHBOqW6i9Z0=;
 b=a+ERvJf+7k8HZtqWKH6yln1qaTYbuZfdzurCGwSX0xhh6JQNR9dreyPC
 0O8QAXlxN0DsMhMHHoXHx9/i827O9NiV79qoPBW/JBGKSQdEyfcUjWeDt
 4HgEf9Gar9TWgxcxIc2ZaGkzYbRrt8TZWhVeA3RtkJBFq+sCB5/vV9opR
 Xozu4ET1vCLwyz2+nRt/wEEhlDyiYZTbWp3pHt90Bor6YxrqgtuaQjr//
 gwEyxhplT80g7ECDIkL7PY20FWUaEcJ6nO0tLx6/bQ/KhTxwwQapUmo1L
 UtutA3xRWdtUVJcawFSk6qoV/ROSUhsN0Jpwgyl6zHwTcC1yLSEYCn1bw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908873"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908873"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494362"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494362"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:43 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 4/5] vfio/pci: Free resources when vfio_migration_realize
 fails
Date: Thu, 29 Jun 2023 16:40:41 +0800
Message-Id: <20230629084042.86502-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629084042.86502-1-zhenzhong.duan@intel.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
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

When vfio_realize() succeeds, hot unplug will call vfio_exitfn()
to free resources allocated in vfio_realize(); when vfio_realize()
fails, vfio_exitfn() is never called and we need to free resources
in vfio_realize().

In the case that vfio_migration_realize() fails,
e.g: with -only-migratable & enable-migration=off, we see below:

(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
0000:81:11.1: Migration disabled
Error: disallowing migration blocker (--only-migratable) for: 0000:81:11.1: Migration is disabled for VFIO device

If we hotplug again we should see same log as above, but we see:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,enable-migration=off
Error: vfio 0000:81:11.1: device is already attached

That's because some references to VFIO device isn't released,
we should check return value of vfio_migration_realize() and
release the references, then VFIO device will be truely
released when hotplug fails.

Fixes: a22651053b59 ("vfio: Make vfio-pci device migration capable")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 54a8179d1c64..dc69d3031b24 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3210,6 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         ret = vfio_migration_realize(vbasedev, errp);
         if (ret) {
             error_report("%s: Migration disabled", vbasedev->name);
+            goto out_vfio_migration;
         }
     }
 
@@ -3219,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
     return;
 
+out_vfio_migration:
+    vfio_migration_exit(vbasedev);
 out_deregister:
     vfio_disable_interrupts(vdev);
 out_intx_disable:
-- 
2.34.1


