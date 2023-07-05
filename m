Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D087C748EB0
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:16:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sY-0002zd-Rq; Wed, 05 Jul 2023 16:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sC-0002j4-UI; Wed, 05 Jul 2023 16:13:12 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sB-000650-CM; Wed, 05 Jul 2023 16:13:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1E7F2748A64;
 Wed,  5 Jul 2023 22:12:51 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 02689748A5D; Wed,  5 Jul 2023 22:12:51 +0200 (CEST)
Message-Id: <b631c3a61729eee2166d899b8888164ebeb71574.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 06/14] ppc440: Stop using system io region for PCIe buses
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:51 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add separate memory regions for the mem and io spaces of the PCIe bus
to avoid different buses using the same system io region.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 5724db2702..663abf3449 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -776,6 +776,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PPC460EXPCIEState, PPC460EX_PCIE_HOST)
 struct PPC460EXPCIEState {
     PCIExpressHost parent_obj;
 
+    MemoryRegion busmem;
     MemoryRegion iomem;
     qemu_irq irq[4];
     int32_t dcrn_base;
@@ -1056,15 +1057,17 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "invalid PCIe DCRN base");
         return;
     }
+    snprintf(buf, sizeof(buf), "pcie%d-mem", id);
+    memory_region_init(&s->busmem, OBJECT(s), buf, UINT64_MAX);
     snprintf(buf, sizeof(buf), "pcie%d-io", id);
-    memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
+    memory_region_init(&s->iomem, OBJECT(s), buf, 64 * KiB);
     for (i = 0; i < 4; i++) {
         sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
     }
     snprintf(buf, sizeof(buf), "pcie.%d", id);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
-                                pci_swizzle_map_irq_fn, s, &s->iomem,
-                                get_system_io(), 0, 4, TYPE_PCIE_BUS);
+                                pci_swizzle_map_irq_fn, s, &s->busmem,
+                                &s->iomem, 0, 4, TYPE_PCIE_BUS);
     ppc460ex_pcie_register_dcrs(s);
 }
 
-- 
2.30.9


