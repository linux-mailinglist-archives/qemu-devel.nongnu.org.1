Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EB7422B7
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEnPS-0002Ja-1A; Thu, 29 Jun 2023 04:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPO-0002JO-H1
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:46 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qEnPM-0003gN-Uf
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688028824; x=1719564824;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=auMMZ44FpdF9pO57M72BIAIa9/kWifdFwydoJYidDdk=;
 b=lCmpDxxiqA3j5Av2pkajhAEyD53mViXP1XMrBtFTw7cyQbl8Brp7gl2F
 VkFnDtjknEyKNvriTJuHRoC5Nfp6xdsXYPIWYtes1D0MJ9RyzA3BO0fhv
 wgvBSEoqePRPNntQo5nqJIJNk8XaklY/8pF/d+eW1aUfvt0GffcQFIVhD
 N90EdQbEPtGGl4lIPPxXQYeJ4HjFUABVIxKBiZOCI57BXy5nfft/jvzZw
 6+bJEp6Ku7oCilOL1DdGadElLpfXnRqbo4INXR71M0+Mx/HaUq3iFgIxL
 Hr1ZaJEoF5ztfByob2ovNArCbT59iZqH8tmKJy1LLHpFAGfyjF8yFtO+o w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="360908865"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="360908865"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="720494349"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; d="scan'208";a="720494349"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 01:53:41 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v4 3/5] vfio/pci: Disable INTx in vfio_realize error path
Date: Thu, 29 Jun 2023 16:40:40 +0800
Message-Id: <20230629084042.86502-4-zhenzhong.duan@intel.com>
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

When vfio realize fails, INTx isn't disabled if it has been enabled.
This may confuse host side with unhandled interrupt report.

Add a new label to be used for vfio_intx_enable() failed case.

Fixes: a9994687cb9b ("vfio/display: core & wireup")
Fixes: b290659fc3dd ("hw/vfio/display: add ramfb support")
Fixes: c62a0c7ce34e ("vfio/display: add xres + yres properties")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index ab6645ba60af..54a8179d1c64 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3167,7 +3167,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
         ret = vfio_intx_enable(vdev, errp);
         if (ret) {
-            goto out_deregister;
+            goto out_intx_disable;
         }
     }
 
@@ -3220,6 +3220,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     return;
 
 out_deregister:
+    vfio_disable_interrupts(vdev);
+out_intx_disable:
     pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
-- 
2.34.1


