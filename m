Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77A37262AE
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0m-0002r5-RP; Wed, 07 Jun 2023 10:19:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0k-0002qB-JK
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:42 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0i-0003PT-WB
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147580;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KHUNXK6qIii10auVdLh+VILOmUdSI2ZnD9Adc1nNpLA=;
 b=VlDe/eJbvSsalpP8QvalhmAlBEfRQPW7eypA79+0ove4Dp0gfegTPqFB
 DZjgL2b5QomcAEcUDJQgyF69Zhjmn1ZCQeA/MoorrgOT8nB4WCdj5m8UI
 3IA3viDHZlDrzV+Syf3PxyXag0eTDO8iZjTijUXRMDGzDvI2uFwyx+VyD A=;
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 112338010
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:iIUwf6zzexoGq2eN0JZ6t+cxxirEfRIJ4+MujC+fZmUNrF6WrkVRz
 GQfCm+BO6uDZWenfY12a42x80NTscPQzd5iGwtv+CAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EsHUMja4mtC5QRgPa8T5jcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KVsf9
 PAncW5OVxuCh971wL/iRspOi9t2eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMxB3D9
 jqfpwwVBDkmFufCwDuEq0uin+qTmD/1UrhPCIyRo6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHVRB21pmKJrzYTXtNRF6sx7wTl90bPy1/HXC5eFGcHMYF48pZsHlTGy
 2NlgfvTVD1jj+TLCkuW97eo7jO/YCQ2D2IdMHpsoRQ+3/Hvp4Q6jxTqR9llEbKogtCdJQwc0
 wxmvwBl2exN0JdjO7GTuAme3mny/sShohsdvF2/Y46z0u9uiGdJjaSM4EOT0/tPJZ3xorKp7
 CldwJj2AAzj4PiweM2xrAclRunBCxWtame0bbtT834JqVyQF4aLJ9w43d2HDB4B3jw4UTHoe
 lTPngha+YVeOnCnBYcuPdLvU5t0l/S7RIi8PhwxUjaoSsIpHONg1Hs3DXN8Iki3yBR8+U3BE
 cnznTmQ4YYyVv08kWveqxY12r433CEurV4/triipylLJYG2PSbPIZ9caQvmUwzMxP/cyOkj2
 4oFZpTiJtQ2eLGWXxQ7BqZNdQ1bcyJmX8meRg4+XrfrHzeK0VoJU5f5qY7NsaQ890iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:p2Carap/eQIf2UycZYI9jTUaV5oleYIsimQD101hICG9E/b1qy
 nKpp8mPHDP5wr5NEtPpTnjAsm9qALnlKKdiLN5Vd3OYOCMghrKEGgN1/qG/xTQXwH46+5Bxe
 NBXsFFebnN5IFB/KTH3DU=
X-Talos-CUID: =?us-ascii?q?9a23=3Ad1ftfmogWCRARUXQHw0IHYXmUfp0c3HilSmTGkS?=
 =?us-ascii?q?5CVoqSLDMRXyy9bwxxg=3D=3D?=
X-Talos-MUID: 9a23:C6GYRQU0WNtxSYXq/APOv2xrNcYx2qq3DRwIjZsMgZSYBAUlbg==
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="112338010"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 06/12] hw/pci/pci.c: Don't leak PCIBus::irq_count[] in
 pci_bus_irqs()
Date: Wed, 7 Jun 2023 15:18:33 +0100
Message-ID: <20230607141839.48422-7-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.142;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa1.hc3370-68.iphmx.com
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

When calling pci_bus_irqs() multiple times on the same object without calling
pci_bus_irqs_cleanup() in between PCIBus::irq_count[] is currently leaked.
Let's fix this because Xen will do just that in a few commits, and because
calling pci_bus_irqs_cleanup() in between seems fragile and cumbersome.

Note that pci_bus_irqs_cleanup() now has to NULL irq_count such that
pci_bus_irqs() doesn't do a double free.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230403074124.3925-3-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1cc7c89036..9b7b4d7c18 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -560,6 +560,7 @@ void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq,
     bus->set_irq = set_irq;
     bus->irq_opaque = irq_opaque;
     bus->nirq = nirq;
+    g_free(bus->irq_count);
     bus->irq_count = g_malloc0(nirq * sizeof(bus->irq_count[0]));
 }
 
@@ -575,6 +576,7 @@ void pci_bus_irqs_cleanup(PCIBus *bus)
     bus->irq_opaque = NULL;
     bus->nirq = 0;
     g_free(bus->irq_count);
+    bus->irq_count = NULL;
 }
 
 PCIBus *pci_register_root_bus(DeviceState *parent, const char *name,
-- 
Anthony PERARD


