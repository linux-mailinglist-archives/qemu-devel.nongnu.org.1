Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ECD7D052C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 00:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtbtO-0008Cj-Mt; Thu, 19 Oct 2023 18:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtM-0008BF-Hd
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:24 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qtbtJ-0002h1-WC
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 18:53:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E7142CE329F;
 Thu, 19 Oct 2023 22:53:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188FFC433C9;
 Thu, 19 Oct 2023 22:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1697755998;
 bh=MoWmkliGz8u0Iob74IbByuMPZNF32jyF16WTmAbgCdg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lrpY34lEhNyRnF4WZ41t8PgqgM38on/hWA4DzMhdPejzaSW0eJFwlafsc+aMChMc3
 yNMGmTtqN+Vhk8Y+B8bbAf7oz2HX8L1d4KwvUogFV+vo39XDATYGgjJhlhNAWEYKg+
 tUeu00IEtbSLMcGIDYqCYnwBnN39fWdwHWyE496lZDIuNi8ssOo9SnFfAqiP7OSI5g
 Tso+hy8QM6vAVFSZQBLMIYTU50daSya/Ejj3+QrKRnzYInCUbHDG59zivdXNtqB9ES
 BgxQapt0yf4EZYcldWbkYp3ctDVxRF7Kdl8KxKV/JOTmHQE3VEUEcuMGP637Z+zHml
 xLM6NRb9EJvAw==
From: deller@kernel.org
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 10/11] hw/hppa: Split out machine creation
Date: Fri, 20 Oct 2023 00:52:56 +0200
Message-ID: <20231019225257.383071-11-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019225257.383071-1-deller@kernel.org>
References: <20231019225257.383071-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
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

From: Helge Deller <deller@gmx.de>

This is a preparation patch to allow the creation of additional
hppa machine.

It splits out the creation of the machine into a
- machine_HP_common_init_cpus(), and a
- machine_HP_common_init_tail()
function.

This will allow to reuse the basic functions which are common to
all parisc machines.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 171 +++++++++++++++++++++++++++-------------------
 1 file changed, 99 insertions(+), 72 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index d459ba631b..2bd02508a9 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -23,6 +23,7 @@
 #include "hw/net/lasi_82596.h"
 #include "hw/nmi.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_device.h"
 #include "hw/pci-host/dino.h"
 #include "hw/misc/lasi.h"
 #include "hppa_hardware.h"
@@ -37,6 +38,7 @@
 
 #define enable_lasi_lan()       0
 
+static DeviceState *lasi_dev;
 
 static void hppa_powerdown_req(Notifier *n, void *opaque)
 {
@@ -250,29 +252,20 @@ static DinoState *dino_init(MemoryRegion *addr_space)
     return DINO_PCI_HOST_BRIDGE(dev);
 }
 
-static void machine_hppa_init(MachineState *machine)
+/*
+ * Step 1: Create CPUs and Memory
+ */
+static void machine_HP_common_init_cpus(MachineState *machine)
 {
-    const char *kernel_filename = machine->kernel_filename;
-    const char *kernel_cmdline = machine->kernel_cmdline;
-    const char *initrd_filename = machine->initrd_filename;
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-    DeviceState *dev, *dino_dev, *lasi_dev;
-    PCIBus *pci_bus;
-    ISABus *isa_bus;
-    char *firmware_filename;
-    uint64_t firmware_low, firmware_high;
-    long size;
-    uint64_t kernel_entry = 0, kernel_low, kernel_high;
     MemoryRegion *addr_space = get_system_memory();
-    MemoryRegion *rom_region;
     MemoryRegion *cpu_region;
     long i;
     unsigned int smp_cpus = machine->smp.cpus;
-    SysBusDevice *s;
+    char *name;
 
     /* Create CPUs.  */
     for (i = 0; i < smp_cpus; i++) {
-        char *name = g_strdup_printf("cpu%ld-io-eir", i);
+        name = g_strdup_printf("cpu%ld-io-eir", i);
         cpu[i] = HPPA_CPU(cpu_create(machine->cpu_type));
 
         cpu_region = g_new(MemoryRegion, 1);
@@ -295,45 +288,27 @@ static void machine_hppa_init(MachineState *machine)
         exit(EXIT_FAILURE);
     }
     memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1);
+}
 
-
-    /* Init Lasi chip */
-    lasi_dev = DEVICE(lasi_init());
-    memory_region_add_subregion(addr_space, LASI_HPA,
-                                sysbus_mmio_get_region(
-                                    SYS_BUS_DEVICE(lasi_dev), 0));
-
-    /* Init Dino (PCI host bus chip).  */
-    dino_dev = DEVICE(dino_init(addr_space));
-    memory_region_add_subregion(addr_space, DINO_HPA,
-                                sysbus_mmio_get_region(
-                                    SYS_BUS_DEVICE(dino_dev), 0));
-    pci_bus = PCI_BUS(qdev_get_child_bus(dino_dev, "pci"));
-    assert(pci_bus);
-
-    /* Create ISA bus. */
-    isa_bus = hppa_isa_bus();
-    assert(isa_bus);
-
-    /* Realtime clock, used by firmware for PDC_TOD call. */
-    mc146818_rtc_init(isa_bus, 2000, NULL);
-
-    /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
-    serial_mm_init(addr_space, LASI_UART_HPA + 0x800, 0,
-        qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
-        serial_hd(0), DEVICE_BIG_ENDIAN);
-
-    serial_mm_init(addr_space, DINO_UART_HPA + 0x800, 0,
-        qdev_get_gpio_in(dino_dev, DINO_IRQ_RS232INT), 7272727 / 16,
-        serial_hd(1), DEVICE_BIG_ENDIAN);
-
-    /* Parallel port */
-    parallel_mm_init(addr_space, LASI_LPT_HPA + 0x800, 0,
-                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
-                     parallel_hds[0]);
-
-    /* fw_cfg configuration interface */
-    create_fw_cfg(machine, pci_bus);
+/*
+ * Last creation step: Add SCSI discs, NICs, graphics & load firmware
+ */
+static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus)
+{
+    const char *kernel_filename = machine->kernel_filename;
+    const char *kernel_cmdline = machine->kernel_cmdline;
+    const char *initrd_filename = machine->initrd_filename;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    DeviceState *dev;
+    char *firmware_filename;
+    uint64_t firmware_low, firmware_high;
+    long size;
+    uint64_t kernel_entry = 0, kernel_low, kernel_high;
+    MemoryRegion *addr_space = get_system_memory();
+    MemoryRegion *rom_region;
+    long i;
+    unsigned int smp_cpus = machine->smp.cpus;
+    SysBusDevice *s;
 
     /* SCSI disk setup. */
     dev = DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
@@ -361,21 +336,12 @@ static void machine_hppa_init(MachineState *machine)
         }
     }
 
-    /* PS/2 Keyboard/Mouse */
-    dev = qdev_new(TYPE_LASIPS2);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
-                                                       0));
-    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA + 0x100,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
-                                                       1));
-
     /* register power switch emulation */
     qemu_register_powerdown_notifier(&hppa_system_powerdown_notifier);
 
+    /* fw_cfg configuration interface */
+    create_fw_cfg(machine, pci_bus);
+
     /* Load firmware.  Given that this is not "real" firmware,
        but one explicitly written for the emulation, we might as
        well load it directly from an ELF image.  */
@@ -493,6 +459,67 @@ static void machine_hppa_init(MachineState *machine)
     cpu[0]->env.gr[19] = FW_CFG_IO_BASE;
 }
 
+/*
+ * Create HP B160L workstation
+ */
+static void machine_HP_B160L_init(MachineState *machine)
+{
+    DeviceState *dev, *dino_dev;
+    MemoryRegion *addr_space = get_system_memory();
+    ISABus *isa_bus;
+    PCIBus *pci_bus;
+
+    /* Create CPUs and RAM.  */
+    machine_HP_common_init_cpus(machine);
+
+    /* Init Lasi chip */
+    lasi_dev = DEVICE(lasi_init());
+    memory_region_add_subregion(addr_space, LASI_HPA,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(lasi_dev), 0));
+
+    /* Init Dino (PCI host bus chip).  */
+    dino_dev = DEVICE(dino_init(addr_space));
+    memory_region_add_subregion(addr_space, DINO_HPA,
+                                sysbus_mmio_get_region(
+                                    SYS_BUS_DEVICE(dino_dev), 0));
+    pci_bus = PCI_BUS(qdev_get_child_bus(dino_dev, "pci"));
+    assert(pci_bus);
+
+    /* Create ISA bus, needed for PS/2 kbd/mouse port emulation */
+    isa_bus = hppa_isa_bus();
+    assert(isa_bus);
+
+    /* Serial ports: Lasi and Dino use a 7.272727 MHz clock. */
+    serial_mm_init(addr_space, LASI_UART_HPA + 0x800, 0,
+        qdev_get_gpio_in(lasi_dev, LASI_IRQ_UART_HPA), 7272727 / 16,
+        serial_hd(0), DEVICE_BIG_ENDIAN);
+
+    serial_mm_init(addr_space, DINO_UART_HPA + 0x800, 0,
+        qdev_get_gpio_in(dino_dev, DINO_IRQ_RS232INT), 7272727 / 16,
+        serial_hd(1), DEVICE_BIG_ENDIAN);
+
+    /* Parallel port */
+    parallel_mm_init(addr_space, LASI_LPT_HPA + 0x800, 0,
+                     qdev_get_gpio_in(lasi_dev, LASI_IRQ_LAN_HPA),
+                     parallel_hds[0]);
+
+    /* PS/2 Keyboard/Mouse */
+    dev = qdev_new(TYPE_LASIPS2);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(lasi_dev, LASI_IRQ_PS2KBD_HPA));
+    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       0));
+    memory_region_add_subregion(addr_space, LASI_PS2KBD_HPA + 0x100,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev),
+                                                       1));
+
+    /* Add SCSI discs, NICs, graphics & load firmware */
+    machine_HP_common_init_tail(machine, pci_bus);
+}
+
 static void hppa_machine_reset(MachineState *ms, ShutdownCause reason)
 {
     unsigned int smp_cpus = ms->smp.cpus;
@@ -541,14 +568,14 @@ static void hppa_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
-static void hppa_machine_init_class_init(ObjectClass *oc, void *data)
+static void HP_B160L_machine_init_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
-    mc->desc = "HPPA B160L machine";
+    mc->desc = "HP B160L workstation";
     mc->default_cpu_type = TYPE_HPPA_CPU;
-    mc->init = machine_hppa_init;
+    mc->init = machine_HP_B160L_init;
     mc->reset = hppa_machine_reset;
     mc->block_default_type = IF_SCSI;
     mc->max_cpus = HPPA_MAX_CPUS;
@@ -562,10 +589,10 @@ static void hppa_machine_init_class_init(ObjectClass *oc, void *data)
     nc->nmi_monitor_handler = hppa_nmi;
 }
 
-static const TypeInfo hppa_machine_init_typeinfo = {
-    .name = MACHINE_TYPE_NAME("hppa"),
+static const TypeInfo HP_B160L_machine_init_typeinfo = {
+    .name = MACHINE_TYPE_NAME("B160L"),
     .parent = TYPE_MACHINE,
-    .class_init = hppa_machine_init_class_init,
+    .class_init = HP_B160L_machine_init_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_NMI },
         { }
@@ -574,7 +601,7 @@ static const TypeInfo hppa_machine_init_typeinfo = {
 
 static void hppa_machine_init_register_types(void)
 {
-    type_register_static(&hppa_machine_init_typeinfo);
+    type_register_static(&HP_B160L_machine_init_typeinfo);
 }
 
 type_init(hppa_machine_init_register_types)
-- 
2.41.0


