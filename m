Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0007AA73E
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 05:08:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjWW1-00007s-GB; Thu, 21 Sep 2023 23:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjWVy-00007S-QE
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:07:35 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjWVv-0002VP-PD
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 23:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695352051; x=1726888051;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KjqfTX9SDCg4Hi/z3Wuo+HAbvsGrx9IOZ0Lol3PpxY8=;
 b=jJsHRAOOABRkmowh6RD8LqMKPzXdawmf7VLSWJ/YgUAbLe19IWLb4dJ6
 05jyPrlaL4zUfnG1LtJ6sWodyTTJItCzHHO5OVpDAxJn5wpaTdHRseBgw
 zprpjiE4FicgPvEKkRzCKaDrtk9DQoNSvtCAQCiQPm2MtPILdGUeERh2Q
 QZm+Loi6hQNINHGFPDvfI44K82MDzjxYUsKQC/wSuITx/WDnv6qK8O8QD
 /SnmyegTU12ilTV70hZQ6BpTkr0Darb11SoVvEPRDiznw/QMn7fcMgyvv
 3ErjydQemaJ0rE3mklBJ7yBYEpGwFfVDf8PnrEwMru3XGKqytTRfkC/dR w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="384564163"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="384564163"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 20:07:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="724017789"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="724017789"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 20:07:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/pci: rename vfio_put_device to vfio_pci_put_device
Date: Fri, 22 Sep 2023 10:52:23 +0800
Message-Id: <20230922025223.1091821-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

vfio_put_device() is a VFIO PCI specific function, rename it with
'vfio_pci' prefix to avoid confusing.

No functional change.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3b2ca3c24ca2..b2d5010b9f0e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2826,7 +2826,7 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     }
 }
 
-static void vfio_put_device(VFIOPCIDevice *vdev)
+static void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     g_free(vdev->vbasedev.name);
     g_free(vdev->msix);
@@ -3317,7 +3317,7 @@ static void vfio_instance_finalize(Object *obj)
      *
      * g_free(vdev->igd_opregion);
      */
-    vfio_put_device(vdev);
+    vfio_pci_put_device(vdev);
     vfio_put_group(group);
 }
 
-- 
2.34.1


