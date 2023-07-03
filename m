Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F8745617
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:29:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDyt-0006CQ-CP; Mon, 03 Jul 2023 03:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyq-0006Bx-L1
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:16 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGDyo-0003we-Qt
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688369294; x=1719905294;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3Tzb73hY6oDdkY1FyoMeSKY04AeNZkybsLZ2x4i3oAI=;
 b=H9P8xIdGCjhbWhXA5sXVWdf98B8EbOVY9zjij+gdnYzF8vmt/jbXzSah
 CYa/huAqrEi0dCahdIbNwiPqC+J3e9V09WqkRw11xiYqFIIgoLR+5E5DW
 tKy4wvil03NyEP07lJsyiI2SWbGFAd5fBnOZwqyvUwPUkLUiimImH+cja
 PyP05khwzzno+oU3OCTzrTVmyK0Ni1FRxvxab4oQFMtC+CXDWyic32UVg
 Dx7k8r0sEPIJ6F/rCUqWZRGHjMxD11RlNVW14RvOz7uM0OFr6tZO2IKX8
 TCYWUvnbG77IEJmarbJ7t8whLU+zHqiDXDoW2+Iy7t6tEdgs2PwcNhyvk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342405633"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342405633"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748058763"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="748058763"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2023 00:28:10 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v6 3/7] vfio/pci: Disable INTx in vfio_realize error path
Date: Mon,  3 Jul 2023 15:15:06 +0800
Message-Id: <20230703071510.160712-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703071510.160712-1-zhenzhong.duan@intel.com>
References: <20230703071510.160712-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

When vfio realize fails, INTx isn't disabled if it has been enabled.
This may confuse host side with unhandled interrupt report.

Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab6645ba60af..31c4ab250fbe 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3220,6 +3220,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     return;
 
 out_deregister:
+    if (vdev->interrupt == VFIO_INT_INTx) {
+        vfio_intx_disable(vdev);
+    }
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
-- 
2.34.1


