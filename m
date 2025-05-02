Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 266ABAA675F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 01:24:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAdDN-00054x-DE; Thu, 01 May 2025 19:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdCx-0004lP-7P; Thu, 01 May 2025 19:20:47 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uAdCv-0007H4-7d; Thu, 01 May 2025 19:20:46 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99ABF55D25A;
 Fri, 02 May 2025 01:20:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Rjs2A4OJkx81; Fri,  2 May 2025 01:20:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A7A5655D265; Fri, 02 May 2025 01:20:41 +0200 (CEST)
Message-ID: <8ca9de03b3c7152fa30703eb9088f164c7a52a9d.1746139668.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1746139668.git.balaton@eik.bme.hu>
References: <cover.1746139668.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 09/13] hw/ppc/pegasos2: Move hardware specific parts out of
 machine reset
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 02 May 2025 01:20:41 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the chipset reset which is pegasos2 specific out from machine
reset to a separate function and move parts not specific to pegasos2
form build_fdt in machine reset so now build_fdt contains pegasos2
specific parts and renamed accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 79 ++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 26a571f82e..e3c1ee9347 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -57,10 +57,6 @@
 
 #define BUS_FREQ_HZ 133333333
 
-#define PCI0_CFG_ADDR 0xcf8
-#define PCI1_CFG_ADDR 0xc78
-#define PCI1_IO_BASE  0xfe000000
-
 #define TYPE_PEGASOS2_MACHINE  MACHINE_TYPE_NAME("pegasos2")
 OBJECT_DECLARE_TYPE(Pegasos2MachineState, MachineClass, PEGASOS2_MACHINE)
 
@@ -82,7 +78,7 @@ struct Pegasos2MachineState {
     uint64_t initrd_size;
 };
 
-static void *build_fdt(MachineState *machine, int *fdt_size);
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size);
 
 static void pegasos2_cpu_reset(void *opaque)
 {
@@ -284,6 +280,9 @@ static void pegasos2_mv_reg_write(Pegasos2MachineState *pm, uint32_t addr,
                                  MEMTXATTRS_UNSPECIFIED);
 }
 
+#define PCI0_CFG_ADDR 0xcf8
+#define PCI1_CFG_ADDR 0xc78
+
 static uint32_t pegasos2_pci_config_read(Pegasos2MachineState *pm, int bus,
                                          uint32_t addr, uint32_t len)
 {
@@ -308,23 +307,12 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
 
 static void pegasos2_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+    cpu_physical_memory_write(0xfe0003f0, &addr, 1);
+    cpu_physical_memory_write(0xfe0003f1, &val, 1);
 }
 
-static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+static void pegasos2_chipset_reset(Pegasos2MachineState *pm)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
-    void *fdt;
-    uint64_t d[2];
-    int sz;
-
-    qemu_devices_reset(type);
-    if (!pm->vof) {
-        return; /* Firmware should set up machine so nothing to do */
-    }
-
-    /* Otherwise, set up devices that board firmware would normally do */
     pegasos2_mv_reg_write(pm, 0, 4, 0x28020ff);
     pegasos2_mv_reg_write(pm, 0x278, 4, 0xa31fc);
     pegasos2_mv_reg_write(pm, 0xf300, 4, 0x11ff0400);
@@ -387,6 +375,23 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
 
     pegasos2_pci_config_write(pm, 1, (PCI_DEVFN(12, 6) << 8) |
                               PCI_INTERRUPT_LINE, 2, 0x309);
+}
+
+static void pegasos2_machine_reset(MachineState *machine, ResetType type)
+{
+    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
+    void *fdt;
+    uint32_t c[2];
+    uint64_t d[2];
+    int sz;
+
+    qemu_devices_reset(type);
+    if (!pm->vof) {
+        return; /* Firmware should set up machine so nothing to do */
+    }
+
+    /* Otherwise, set up devices that board firmware would normally do */
+    pegasos2_chipset_reset(pm);
 
     /* Device tree and VOF set up */
     vof_init(pm->vof, machine->ram_size, &error_fatal);
@@ -405,10 +410,25 @@ static void pegasos2_machine_reset(MachineState *machine, ResetType type)
         exit(1);
     }
 
-    fdt = build_fdt(machine, &sz);
+    fdt = pegasos2_build_fdt(pm, &sz);
     if (!fdt) {
         exit(1);
     }
+
+    /* Set memory size */
+    c[0] = 0;
+    c[1] = cpu_to_be32(machine->ram_size);
+    qemu_fdt_setprop(fdt, "/memory@0", "reg", c, sizeof(c));
+
+    /* Boot parameters */
+    if (pm->initrd_addr && pm->initrd_size) {
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
+                              pm->initrd_addr + pm->initrd_size);
+        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
+                              pm->initrd_addr);
+    }
+    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
+                            machine->kernel_cmdline ?: "");
     /* FIXME: VOF assumes entry is same as load address */
     d[0] = cpu_to_be64(pm->kernel_entry);
     d[1] = cpu_to_be64(pm->kernel_size - (pm->kernel_entry - pm->kernel_addr));
@@ -828,12 +848,10 @@ static void *load_dtb(const char *filename, int *fdt_size)
     return fdt;
 }
 
-static void *build_fdt(MachineState *machine, int *fdt_size)
+static void *pegasos2_build_fdt(Pegasos2MachineState *pm, int *fdt_size)
 {
-    Pegasos2MachineState *pm = PEGASOS2_MACHINE(machine);
     FDTInfo fi;
     PCIBus *pci_bus;
-    uint32_t cells[2];
     void *fdt = load_dtb("pegasos2.dtb", fdt_size);
 
     if (!fdt) {
@@ -841,21 +859,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/", "name", "bplan,Pegasos2");
 
-    /* Set memory size */
-    cells[0] = 0;
-    cells[1] = cpu_to_be32(machine->ram_size);
-    qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
-
-    /* Boot parameters */
-    if (pm->initrd_addr && pm->initrd_size) {
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
-                              pm->initrd_addr + pm->initrd_size);
-        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
-                              pm->initrd_addr);
-    }
-    qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
-                            machine->kernel_cmdline ?: "");
-
     add_cpu_info(fdt, pm->cpu);
 
     fi.fdt = fdt;
-- 
2.41.3


