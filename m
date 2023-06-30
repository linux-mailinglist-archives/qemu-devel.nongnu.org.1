Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E35743635
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 09:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF8tG-0001tD-Qd; Fri, 30 Jun 2023 03:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tE-0001sB-6P
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:50:00 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF8tC-0002be-4F
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:49:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688111398; x=1719647398;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=20hMq7y7c4qZBJSiY004C/qGpgUHmVDDFDGqjY1tRBw=;
 b=FhtHnsc5iSPkXIf2xSqobFQmbGDrRQ44JjJ3TabDPX+tKvKyTvB0ZyvH
 GKAvPQRCReDQHspFbEzu8gTbrHA2S4NUATTuD08cN4VVwig2EE19J6NsZ
 d/grblQGdhuaCzJGbFd6S5R9Q+E4VWQmZSHd20xBDxTlXl7avl4UlTDU1
 21IFPY79aQZNE8Ao+6xP6V3IuVCV5rMehr/LjeYmUKGzAu/xlYA+yIcWr
 et+H72+rRjwBJHzVojOvzimxJZz4103oaBVktYOARiQauqviKj9zGBvyt
 XJ+QA2SIOdNUN+1A9lNw1UW/ucBKe1Q+WgN+BPqQ7e0CZsPyuA66mnZEo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365824443"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="365824443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="841770774"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="841770774"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 00:49:53 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
Subject: [PATCH v5 3/7] vfio/pci: Disable INTx in vfio_realize error path
Date: Fri, 30 Jun 2023 15:36:33 +0800
Message-Id: <20230630073637.124234-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230630073637.124234-1-zhenzhong.duan@intel.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

Fixes: c5478fea27ac ("vfio/pci: Respond to KVM irqchip change notifier")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


