Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A16AD48F1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 04:48:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPBU1-0003RQ-GM; Tue, 10 Jun 2025 22:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPBTv-0003RA-Tw
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 22:46:27 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uPBTu-0007pu-5B
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 22:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749609986; x=1781145986;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4nVVIqu3PeOpL+xt4TRfr1LoCSbWuvtT0hbst1bBmDs=;
 b=be7SOhtulslYEpFKOfqXFqMKlrjALGY42Xgy3pxBAXHbnHInXjXKoeDD
 Uq6TgWTWQVvDyl3rZg390xDsWUWWpzsQzElxMS1GozYBoM3B8aExWEGFe
 PH5qG8xFIJXcLLgohbZqqVmbEBIg8cK8pC3DOi3xcb9XwAx+GYRWJPRqy
 ZlcbDR5NHXoBW9S/jjAyNjzq05u3zHYWGwFeV/0lasgnl1slTrrYcJMZ/
 SMGpx86pHCSGQL38HECsdrFwfCCPNidsFwLEhFMmiGE6oA3HDkx3pErHv
 oQEq8/BxoC1WTXBe0qfowTvlVsK1bmxm5Ru70aoZzatkISPwnK8TWSK4F g==;
X-CSE-ConnectionGUID: BsAxqWlZQnmEO1hVV4ffww==
X-CSE-MsgGUID: n8IH37XFTfelertjL5PBaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63091900"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="63091900"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 19:46:20 -0700
X-CSE-ConnectionGUID: q/GuYDnxQp2UdsKE7ctMyQ==
X-CSE-MsgGUID: 807uYkPLSmmAp5lgV+caOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; d="scan'208";a="184200049"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2025 19:46:18 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Fix instance_size of VFIO_PCI_BASE
Date: Wed, 11 Jun 2025 10:42:28 +0800
Message-Id: <20250611024228.423666-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Currently the final instance_size of VFIO_PCI_BASE is sizeof(PCIDevice).
It should be sizeof(VFIOPCIDevice), VFIO_PCI uses same structure as
base class VFIO_PCI_BASE, so no need to set its instance_size explicitly.

This isn't catastrophic only because VFIO_PCI_BASE is an abstract class.

Fixes: d4e392d0a99b ("vfio: add vfio-pci-base class")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 92562898e4..03f52a9b8f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3478,7 +3478,7 @@ static void vfio_pci_base_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_base_dev_info = {
     .name = TYPE_VFIO_PCI_BASE,
     .parent = TYPE_PCI_DEVICE,
-    .instance_size = 0,
+    .instance_size = sizeof(VFIOPCIDevice),
     .abstract = true,
     .class_init = vfio_pci_base_dev_class_init,
     .interfaces = (const InterfaceInfo[]) {
@@ -3701,7 +3701,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, const void *data)
 static const TypeInfo vfio_pci_dev_info = {
     .name = TYPE_VFIO_PCI,
     .parent = TYPE_VFIO_PCI_BASE,
-    .instance_size = sizeof(VFIOPCIDevice),
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
-- 
2.34.1


