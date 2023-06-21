Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCBC737D2A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBszi-0004iG-PC; Wed, 21 Jun 2023 04:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszY-0004f3-Te
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:05 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBszX-0002sc-7Z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687335303; x=1718871303;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0hPMkNVrRILLd9lF9N0wtK7GJK0SD1zU2iVss5LP7Jg=;
 b=g5LzpH575ng4y6rXO4MUn7Vg8IMjN9QtHaKZdGFXd5t44Ycq5S/t6IRS
 csG4QAy1AB7LapvWxqiBsuD3MaJGGyX3P0nqK6LPg0T62GAvCe3P3xPG3
 kMMejBHNpVETHPZgOG2eY/1EW8DPSk3Yo2DCdsFPB9RIH7QRembN9EESh
 qtnDfLdcuEbE/pBfzlu8xvFjdPTrGFojn2vE5Ev++C5y9L4d7ilnvMaXQ
 JuLUt7P2eAGK3HIktxtu5qCpRyh5PZOgXL00TNYhwbZPDxLYoCO6JP+8s
 0zvd2mwyBrGaIvIWx9Wi6D4CvGx+nVhSW/Tx9GoEy+2to0DXICi5l2Mkz A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="344843465"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="344843465"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="804282299"
X-IronPort-AV: E=Sophos;i="6.00,259,1681196400"; d="scan'208";a="804282299"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jun 2023 01:14:59 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
Date: Wed, 21 Jun 2023 16:02:03 +0800
Message-Id: <20230621080204.420723-3-zhenzhong.duan@intel.com>
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

In case irqchip_change_notifier isn't added, removing it triggers segfault.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c71b0955d81c..82c4cf4f7609 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3222,7 +3222,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
 
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


