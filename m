Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A657422BF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPN-0002IS-Ef; Thu, 29 Jun 2023 04:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPK-0002Hv-NI
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:42 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPI-0003dp-KB
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028820; x=1719564820;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cJIPVP01AA7xsD3iUU2rztqJwjACTSIZKHRcfCmA+tw=;
 b=CSabYyBtWiPASluonNN4ZB2d4Y+XuP8Yp3qJAfBsVDP3Za9AcT5ygn0D
 E+CJD0FwjMaQDTcM3P+2azc1rguR1mTk62tns5UDG4ebO74UhPKCJ6mSY
 yYeboas++W4hdMC6iwFwJM8xWLzOrDYehmoKoVr6SMz6zxJSNBeVM/Z4u
 +kr37ymG5t36kkPbktagTDGN6BGf295Osm0m6AJWMkT1uM9Fi0wAHqYed
 yy1fhjJ6jJKH5nqbuKUKjyL6SKAzWbbm3FARdQC0I/R6qgjh4PxzJKUxK
 IIA0lz3VsIwDwy3KHLJMGoLQM0NvFaoCuCceq0hwTbv3+m4kP+qGqCAwV g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908850"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908850"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494306"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494306"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 1/5] vfio/pci: Fix a segfault in vfio_realize
Date: Thu, 29 Jun 2023 16:40:38 +0800
Message-Id: <20230629084042.86502-2-zhenzhong.duan@intel.com>
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

The kvm irqchip notifier is only registered if the device supports
INTx, however it's unconditionally removed in vfio realize error
path. If the assigned device does not support INTx, this will cause
QEMU to crash when vfio realize fails. Change it to conditionally
remove the notifier only if the notify hook is setup.

Before fix:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
Connection closed by foreign host.

After fix:
(qemu) device_add vfio-pci,host=81:11.1,id=vfio1,bus=root1,xres=1
Error: vfio 0000:81:11.1: xres and yres properties require display=on
(qemu)

Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 73e19a04b2bf..48df517f79ee 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3221,7 +3221,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
 out_deregister:
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
-    kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    if (vdev->irqchip_change_notifier.notify) {
+        kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
+    }
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
-- 
2.34.1


