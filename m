Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C514EAF6568
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 00:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX65w-0008KK-FA; Wed, 02 Jul 2025 18:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65q-0008FT-Kx; Wed, 02 Jul 2025 18:38:18 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65n-0005FL-Nj; Wed, 02 Jul 2025 18:38:18 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 01B3A55CB64;
 Thu, 03 Jul 2025 00:38:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rs2usqVgs9Mx; Thu,  3 Jul 2025 00:38:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F339255CB68; Thu, 03 Jul 2025 00:38:11 +0200 (CEST)
Message-ID: <7e7aa9d6626e87507646659ba05ac9cbcfd68662.1751494995.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1751494995.git.balaton@eik.bme.hu>
References: <cover.1751494995.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 09/13] hw/ppc/pegasos2: Introduce abstract superclass
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Jul 2025 00:38:11 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Rename machine state struct to PegasosMachineState as it will be used
for pegasos1 too.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 66 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index e3c1ee9347..f7999520e4 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,10 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
-OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
+#define TYPE_PEGASOS_MACHINE MACHINE_TYPE_NAME("pegasos")
+OBJECT_DECLARE_SIMPLE_TYPE(PegasosMachineState, PEGASOS_MACHINE)
 
-struct Pegasos2MachineState {
+struct PegasosMachineState {
     MachineState parent_obj;
 
     PowerPCCPU *cpu;
@@ -78,12 +78,12 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
+static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(current_machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(current_machine);
 
     cpu_reset(CPU(cpu));
     cpu->env.spr[SPR_HID1] = 7ULL << 28;
@@ -96,7 +96,7 @@ static void pegasos2_cpu_reset(void *opaque)
 
 static void pegasos2_pci_irq(void *opaque, int n, int level)
 {
-    Pegasos2MachineState *pm = opaque;
+    PegasosMachineState *pm = opaque;
 
     /* PCI interrupt lines are connected to both MV64361 and VT8231 */
     qemu_set_irq(pm->mv_pirq[n], level);
@@ -104,7 +104,7 @@ static void pegasos2_pci_irq(void *opaque, int n, int level)
 }
 
 /* Set up PCI interrupt routing: lines from pci.0 and pci.1 are ORed */
-static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
+static void pegasos2_setup_pci_irq(PegasosMachineState *pm)
 {
     for (int h = 0; h < 2; h++) {
         DeviceState *pd;
@@ -137,7 +137,7 @@ static void pegasos2_setup_pci_irq(Pegasos2MachineState *pm)
 
 static void pegasos2_init(MachineState *machine)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     CPUPPCState *env;
     MemoryRegion *rom = g_new(MemoryRegion, 1);
     PCIBus *pci_bus;
@@ -262,7 +262,7 @@ static void pegasos2_init(MachineState *machine)
     }
 }
 
-static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
+static uint32_t pegasos2_mv_reg_read(PegasosMachineState *pm,
                                      uint32_t addr, uint32_t len)
 {
     MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
@@ -272,7 +272,7 @@ static uint32_t pegasos2_mv_reg_read(Pegasos2MachineState *pm,
     return val;
 }
 
-static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
+static void pegasos2_mv_reg_write(PegasosMachineState *pm, uint32_t addr,
                                   uint32_t len, uint32_t val)
 {
     MemoryRegion *r = sysbus_mmio_get_region(SYS_BUS_DEVICE(pm->nb), 0);
@@ -283,7 +283,7 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
 #define PCI0_CFG_ADDR 0xcf8
 #define PCI1_CFG_ADDR 0xc78
 
-static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
+static uint32_t pegasos2_pci_config_read(PegasosMachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
     hwaddr pcicfg = bus ? PCI1_CFG_ADDR : PCI0_CFG_ADDR;
@@ -296,7 +296,7 @@ static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
     return val;
 }
 
-static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
+static void pegasos2_pci_config_write(PegasosMachineState *pm, int bus,
                                       uint32_t addr, uint32_t len, uint32_t val)
 {
     hwaddr pcicfg = bus ? PCI1_CFG_ADDR : PCI0_CFG_ADDR;
@@ -311,7 +311,7 @@ static void pegasos2_superio_write(uint8_t addr, uint8_t val)
     cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
+static void pegasos2_chipset_reset(PegasosMachineState *pm)
 {
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
@@ -379,7 +379,7 @@ static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 
 static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    PegasosMachineState *pm = PEGASOS_MACHINE(machine);
     void *fdt;
     uint32_t c[2];
     uint64_t d[2];
@@ -463,7 +463,7 @@ enum pegasos2_rtas_tokens {
     RTAS_SYSTEM_REBOOT = 20,
 };
 
-static target_ulong pegasos2_rtas(PowerPCCPU *cpu, Pegasos2MachineState *pm,
+static target_ulong pegasos2_rtas(PowerPCCPU *cpu, PegasosMachineState *pm,
                                   target_ulong args_real)
 {
     AddressSpace *as = CPU(cpu)->as;
@@ -566,7 +566,7 @@ static bool pegasos2_cpu_in_nested(PowerPCCPU *cpu)
 
 static void pegasos2_hypercall(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(vhyp);
+    PegasosMachineState *pm = PEGASOS_MACHINE(vhyp);
     CPUPPCState *env = &cpu->env;
 
     /* The TCG path should also be holding the BQL at this point */
@@ -629,24 +629,26 @@ static void pegasos2_machine_class_init(ObjectClass *oc, const void *data)
     vmc->setprop = pegasos2_setprop;
 }
 
-static const TypeInfo pegasos2_machine_info = {
-    .name          = TYPE_PEGASOS2_MACHINE,
-    .parent        = TYPE_MACHINE,
-    .class_init    = pegasos2_machine_class_init,
-    .instance_size = sizeof(Pegasos2MachineState),
-    .interfaces = (const InterfaceInfo[]) {
-        { TYPE_PPC_VIRTUAL_HYPERVISOR },
-        { TYPE_VOF_MACHINE_IF },
-        { }
+static const TypeInfo pegasos_machine_types[] = {
+    {
+        .name          = TYPE_PEGASOS_MACHINE,
+        .parent        = TYPE_MACHINE,
+        .instance_size = sizeof(PegasosMachineState),
+        .abstract      = true,
+    },
+    {
+        .name          = MACHINE_TYPE_NAME("pegasos2"),
+        .parent        = TYPE_PEGASOS_MACHINE,
+        .class_init    = pegasos2_machine_class_init,
+        .interfaces = (const InterfaceInfo[]) {
+              { TYPE_PPC_VIRTUAL_HYPERVISOR },
+              { TYPE_VOF_MACHINE_IF },
+              { }
+        },
     },
 };
 
-static void pegasos2_machine_register_types(void)
-{
-    type_register_static(&pegasos2_machine_info);
-}
-
-type_init(pegasos2_machine_register_types)
+DEFINE_TYPES(pegasos_machine_types)
 
 /* FDT creation for passing to firmware */
 
@@ -848,7 +850,7 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
+static void *pegasos2_build_fdt(PegasosMachineState *pm, int *fdt_size)
 {
     FDTInfo fi;
     PCIBus *pci_bus;
-- 
2.41.3


