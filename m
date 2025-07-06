Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E8AF6574
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 00:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX65x-0008M0-Nl; Wed, 02 Jul 2025 18:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65l-0008DL-Ix; Wed, 02 Jul 2025 18:38:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uX65i-0005Dg-04; Wed, 02 Jul 2025 18:38:12 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 38C8B55CA60;
 Thu, 03 Jul 2025 00:38:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x6Zvs3O2WHAa; Thu,  3 Jul 2025 00:38:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7C4CF55CA58; Thu, 03 Jul 2025 00:38:04 +0200 (CEST)
Message-ID: <ea74ad1351a40b037c6af0cd1563d7bff9727e1b.1751494995.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1751494995.git.balaton@eik.bme.hu>
References: <cover.1751494995.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 02/13] hw/ppc/pegasos2: Remove explicit name properties
 from device tree
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 03 Jul 2025 00:38:04 +0200 (CEST)
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

These are not needed any more now that VOF can handle it.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/pegasos2.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index e15cf96427..73995624e5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -662,7 +662,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     qemu_fdt_setprop_cell(fi->fdt, fi->path, "#size-cells", 1);
     qemu_fdt_setprop_cell(fi->fdt, fi->path, "#address-cells", 2);
     qemu_fdt_setprop_string(fi->fdt, fi->path, "device_type", "isa");
-    qemu_fdt_setprop_string(fi->fdt, fi->path, "name", "isa");
 
     /* additional devices */
     g_string_printf(name, "%s/lpt@i3bc", fi->path);
@@ -677,7 +676,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "lpt");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "lpt");
 
     g_string_printf(name, "%s/fdc@i3f0", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -691,7 +689,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "fdc");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "fdc");
 
     g_string_printf(name, "%s/timer@i40", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -701,7 +698,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "timer");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "timer");
 
     g_string_printf(name, "%s/rtc@i70", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -716,7 +712,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(2);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "rtc");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "rtc");
 
     g_string_printf(name, "%s/keyboard@i60", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -729,7 +724,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(5);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "keyboard");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "keyboard");
 
     g_string_printf(name, "%s/8042@i60", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -743,7 +737,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(5);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "8042");
 
     g_string_printf(name, "%s/serial@i2f8", fi->path);
     qemu_fdt_add_subnode(fi->fdt, name->str);
@@ -757,7 +750,6 @@ static void dt_isa(PCIBus *bus, PCIDevice *d, FDTInfo *fi)
     cells[2] = cpu_to_be32(8);
     qemu_fdt_setprop(fi->fdt, name->str, "reg", cells, 3 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fi->fdt, name->str, "device_type", "serial");
-    qemu_fdt_setprop_string(fi->fdt, name->str, "name", "serial");
 
     g_string_free(name, TRUE);
 }
@@ -846,7 +838,6 @@ static void add_pci_device(PCIBus *bus, PCIDevice *d, void *opaque)
         j += 5;
     }
     qemu_fdt_setprop(fi->fdt, node->str, "reg", cells, j * sizeof(cells[0]));
-    qemu_fdt_setprop_string(fi->fdt, node->str, "name", name ?: pn);
     if (pci_get_byte(&d->config[PCI_INTERRUPT_PIN])) {
         qemu_fdt_setprop_cell(fi->fdt, node->str, "interrupts",
                               pci_get_byte(&d->config[PCI_INTERRUPT_PIN]));
@@ -916,7 +907,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#size-cells", 2);
     qemu_fdt_setprop_cell(fdt, "/pci@c0000000", "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/pci@c0000000", "device_type", "pci");
-    qemu_fdt_setprop_string(fdt, "/pci@c0000000", "name", "pci");
 
     fi.path = "/pci@c0000000";
     pci_bus = mv64361_get_pci_bus(pm->mv, 0);
@@ -951,7 +941,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#size-cells", 2);
     qemu_fdt_setprop_cell(fdt, "/pci@80000000", "#address-cells", 3);
     qemu_fdt_setprop_string(fdt, "/pci@80000000", "device_type", "pci");
-    qemu_fdt_setprop_string(fdt, "/pci@80000000", "name", "pci");
 
     fi.path = "/pci@80000000";
     pci_bus = mv64361_get_pci_bus(pm->mv, 1);
@@ -959,7 +948,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
 
     qemu_fdt_add_subnode(fdt, "/failsafe");
     qemu_fdt_setprop_string(fdt, "/failsafe", "device_type", "serial");
-    qemu_fdt_setprop_string(fdt, "/failsafe", "name", "failsafe");
 
     qemu_fdt_add_subnode(fdt, "/rtas");
     qemu_fdt_setprop_cell(fdt, "/rtas", "system-reboot", RTAS_SYSTEM_REBOOT);
@@ -989,14 +977,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-display-device", 0);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-size", 20);
     qemu_fdt_setprop_cell(fdt, "/rtas", "rtas-version", 1);
-    qemu_fdt_setprop_string(fdt, "/rtas", "name", "rtas");
 
     /* cpus */
     qemu_fdt_add_subnode(fdt, "/cpus");
     qemu_fdt_setprop_cell(fdt, "/cpus", "#cpus", 1);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 1);
     qemu_fdt_setprop_cell(fdt, "/cpus", "#size-cells", 0);
-    qemu_fdt_setprop_string(fdt, "/cpus", "name", "cpus");
 
     /* FIXME Get CPU name from CPU object */
     const char *cp = "/cpus/PowerPC,G4";
@@ -1048,7 +1034,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     cells[1] = 0;
     qemu_fdt_setprop(fdt, cp, "reg", cells, 2 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fdt, cp, "device_type", "cpu");
-    qemu_fdt_setprop_string(fdt, cp, "name", strrchr(cp, '/') + 1);
 
     /* memory */
     qemu_fdt_add_subnode(fdt, "/memory@0");
@@ -1056,7 +1041,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     cells[1] = cpu_to_be32(machine->ram_size);
     qemu_fdt_setprop(fdt, "/memory@0", "reg", cells, 2 * sizeof(cells[0]));
     qemu_fdt_setprop_string(fdt, "/memory@0", "device_type", "memory");
-    qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
 
     qemu_fdt_add_subnode(fdt, "/chosen");
     if (pm->initrd_addr && pm->initrd_size) {
@@ -1067,7 +1051,6 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
     }
     qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
                             machine->kernel_cmdline ?: "");
-    qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");
 
     qemu_fdt_add_subnode(fdt, "/openprom");
     qemu_fdt_setprop_string(fdt, "/openprom", "model", "Pegasos2,1.1");
-- 
2.41.3


