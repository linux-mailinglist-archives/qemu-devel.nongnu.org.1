Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBCB748EAC
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sN-0002rv-KX; Wed, 05 Jul 2023 16:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8sB-0002gj-D9; Wed, 05 Jul 2023 16:13:12 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s7-00063u-OP; Wed, 05 Jul 2023 16:13:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E1807748A5B;
 Wed,  5 Jul 2023 22:12:46 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B6015748A59; Wed,  5 Jul 2023 22:12:46 +0200 (CEST)
Message-Id: <a79796654deaa81a6a1c71efc874e4d88c4cafd4.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 02/14] ppc440: Add cpu link property to PCIe controller
 model
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:46 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

The PCIe controller model uses PPC DCRs but cannot be modeled with
TYPE_PPC4xx_DCR_DEVICE as it derives from TYPE_PCIE_HOST_BRIDGE. Add a
cpu link property to it similar to other DCR devices to allow
registering DCRs from the device model.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440_uc.c | 114 ++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 52 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 8eb985d714..b26c0cee1b 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -779,6 +779,7 @@ struct PPC460EXPCIEState {
     MemoryRegion iomem;
     qemu_irq irq[4];
     int32_t dcrn_base;
+    PowerPCCPU *cpu;
 
     uint64_t cfg_base;
     uint32_t cfg_mask;
@@ -1001,6 +1002,58 @@ static void ppc460ex_set_irq(void *opaque, int irq_num, int level)
        qemu_set_irq(s->irq[irq_num], level);
 }
 
+static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s)
+{
+    CPUPPCState *env = &s->cpu->env;
+
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
+                     &dcr_read_pcie, &dcr_write_pcie);
+}
+
 static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 {
     PPC460EXPCIEState *s = PPC460EX_PCIE_HOST(dev);
@@ -1008,6 +1061,10 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     int i, id;
     char buf[16];
 
+    if (!s->cpu) {
+        error_setg(errp, "cpu link property must be set");
+        return;
+    }
     switch (s->dcrn_base) {
     case DCRN_PCIE0_BASE:
         id = 0;
@@ -1028,10 +1085,13 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->iomem,
                                 get_system_io(), 0, 4, TYPE_PCIE_BUS);
+    ppc460ex_pcie_register_dcrs(s);
 }
 
 static Property ppc460ex_pcie_props[] = {
     DEFINE_PROP_INT32("dcrn-base", PPC460EXPCIEState, dcrn_base, -1),
+    DEFINE_PROP_LINK("cpu", PPC460EXPCIEState, cpu, TYPE_POWERPC_CPU,
+                     PowerPCCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1059,67 +1119,17 @@ static void ppc460ex_pcie_register(void)
 
 type_init(ppc460ex_pcie_register)
 
-static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s, CPUPPCState *env)
-{
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_MSGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR1MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR2MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3BAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_OMR3MSKL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAH, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGBAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_REGMSK, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_SPECIAL, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-    ppc_dcr_register(env, s->dcrn_base + PEGPL_CFG, s,
-                     &dcr_read_pcie, &dcr_write_pcie);
-}
-
 void ppc460ex_pcie_init(PowerPCCPU *cpu)
 {
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
+    object_property_set_link(OBJECT(dev), "cpu", OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 }
-- 
2.30.9


