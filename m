Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF82748EB9
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 22:18:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH8sE-0002hD-2C; Wed, 05 Jul 2023 16:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s9-0002gJ-O8; Wed, 05 Jul 2023 16:13:09 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qH8s7-00063n-PN; Wed, 05 Jul 2023 16:13:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CF9E8746E5A;
 Wed,  5 Jul 2023 22:12:45 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9D8E7746369; Wed,  5 Jul 2023 22:12:45 +0200 (CEST)
Message-Id: <1695d7cc1a9f1070ab498c078916e2389d6e9469.1688586835.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1688586835.git.balaton@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 01/14] ppc440: Change ppc460ex_pcie_init() parameter type
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <"danielhb413@gmail.com>, philmd"@linaro.org>
Date: Wed,  5 Jul 2023 22:12:45 +0200 (CEST)
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

Change parameter of ppc460ex_pcie_init() from env to cpu to allow
further refactoring.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/ppc440.h    | 2 +-
 hw/ppc/ppc440_uc.c | 7 ++++---
 hw/ppc/sam460ex.c  | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
index 7c24db8504..ae42bcf0c8 100644
--- a/hw/ppc/ppc440.h
+++ b/hw/ppc/ppc440.h
@@ -18,6 +18,6 @@ void ppc4xx_cpr_init(CPUPPCState *env);
 void ppc4xx_sdr_init(CPUPPCState *env);
 void ppc4xx_ahb_init(CPUPPCState *env);
 void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
-void ppc460ex_pcie_init(CPUPPCState *env);
+void ppc460ex_pcie_init(PowerPCCPU *cpu);
 
 #endif /* PPC440_H */
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 651263926e..8eb985d714 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/reset.h"
+#include "cpu.h"
 #include "ppc440.h"
 
 /*****************************************************************************/
@@ -1108,17 +1109,17 @@ static void ppc460ex_pcie_register_dcrs(PPC460EXPCIEState *s, CPUPPCState *env)
                      &dcr_read_pcie, &dcr_write_pcie);
 }
 
-void ppc460ex_pcie_init(CPUPPCState *env)
+void ppc460ex_pcie_init(PowerPCCPU *cpu)
 {
     DeviceState *dev;
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE0_BASE);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 
     dev = qdev_new(TYPE_PPC460EX_PCIE_HOST);
     qdev_prop_set_int32(dev, "dcrn-base", DCRN_PCIE1_BASE);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), env);
+    ppc460ex_pcie_register_dcrs(PPC460EX_PCIE_HOST(dev), &cpu->env);
 }
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index cf065aae0e..aaa8d2f4a5 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -422,7 +422,7 @@ static void sam460ex_init(MachineState *machine)
     usb_create_simple(usb_bus_find(-1), "usb-mouse");
 
     /* PCI bus */
-    ppc460ex_pcie_init(env);
+    ppc460ex_pcie_init(cpu);
     /* All PCI irqs are connected to the same UIC pin (cf. UBoot source) */
     dev = sysbus_create_simple("ppc440-pcix-host", 0xc0ec00000,
                                qdev_get_gpio_in(uic[1], 0));
-- 
2.30.9


