Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B547CE945
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDNs-0005pB-5f; Wed, 18 Oct 2023 16:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNQ-0004gf-Bg; Wed, 18 Oct 2023 16:42:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qtDNN-0001CI-2R; Wed, 18 Oct 2023 16:42:47 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 132D7756087;
 Wed, 18 Oct 2023 22:42:42 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B6D10756078; Wed, 18 Oct 2023 22:42:41 +0200 (CEST)
Message-Id: <b68bd667c7947e09b33684796bba286b447a8aba.1697661160.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1697661160.git.balaton@eik.bme.hu>
References: <cover.1697661160.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v5 3/4] hw/ppc: Add emulation of AmigaOne XE board
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org,
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Date: Wed, 18 Oct 2023 22:42:41 +0200 (CEST)
X-Spam-Probability: 10%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
with patches to support AmigaOS and is very similar to pegasos2 so can
be easily emulated sharing most code with pegasos2. The reason to
emulate it is that AmigaOS comes in different versions for AmigaOne
and PegasosII which only have drivers for one machine and firmware so
these only run on the specific machine. Adding this board allows
another AmigaOS version to be used reusing already existing peagasos2
emulation. (The AmigaOne was the first of these boards so likely most
widespread which then inspired Pegasos that was later replaced with
PegasosII due to problems with Articia S, so these have a lot of
similarity. Pegasos mainly ran MorphOS while the PegasosII version of
AmigaOS was added later and therefore less common than the AmigaOne
version.)

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS                             |   8 ++
 configs/devices/ppc-softmmu/default.mak |   1 +
 hw/ppc/Kconfig                          |   7 +
 hw/ppc/amigaone.c                       | 164 ++++++++++++++++++++++++
 hw/ppc/meson.build                      |   2 +
 5 files changed, 182 insertions(+)
 create mode 100644 hw/ppc/amigaone.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bd4fe378d..efc3f369bb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1508,6 +1508,14 @@ F: hw/pci-host/mv64361.c
 F: hw/pci-host/mv643xx.h
 F: include/hw/pci-host/mv64361.h
 
+amigaone
+M: BALATON Zoltan <balaton@eik.bme.hu>
+L: qemu-ppc@nongnu.org
+S: Maintained
+F: hw/ppc/amigaone.c
+F: hw/pci-host/articia.c
+F: include/hw/pci-host/articia.h
+
 Virtual Open Firmware (VOF)
 M: Alexey Kardashevskiy <aik@ozlabs.ru>
 R: David Gibson <david@gibson.dropbear.id.au>
diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
index a887f5438b..b85fd2bcd7 100644
--- a/configs/devices/ppc-softmmu/default.mak
+++ b/configs/devices/ppc-softmmu/default.mak
@@ -14,6 +14,7 @@ CONFIG_SAM460EX=y
 CONFIG_MAC_OLDWORLD=y
 CONFIG_MAC_NEWWORLD=y
 
+CONFIG_AMIGAONE=y
 CONFIG_PEGASOS2=y
 
 # For PReP
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 5dfbf47ef5..56f0475a8e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -69,6 +69,13 @@ config SAM460EX
     select USB_OHCI
     select FDT_PPC
 
+config AMIGAONE
+    bool
+    imply ATI_VGA
+    select ARTICIA
+    select VT82C686
+    select SMBUS_EEPROM
+
 config PEGASOS2
     bool
     imply ATI_VGA
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
new file mode 100644
index 0000000000..3589924c8a
--- /dev/null
+++ b/hw/ppc/amigaone.c
@@ -0,0 +1,164 @@
+/*
+ * QEMU Eyetech AmigaOne/Mai Logic Teron emulation
+ *
+ * Copyright (c) 2023 BALATON Zoltan
+ *
+ * This work is licensed under the GNU GPL license version 2 or later.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/datadir.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/ppc/ppc.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/pci-host/articia.h"
+#include "hw/isa/vt82c686.h"
+#include "hw/ide/pci.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "hw/ppc/ppc.h"
+#include "sysemu/reset.h"
+#include "kvm_ppc.h"
+
+#define BUS_FREQ_HZ 100000000
+
+/*
+ * Firmware binary available at
+ * https://www.hyperion-entertainment.com/index.php/downloads?view=files&parent=28
+ * then "tail -c 524288 updater.image >u-boot-amigaone.bin"
+ *
+ * BIOS emulator in firmware cannot run QEMU vgabios and hangs on it, use
+ * -device VGA,romfile=VGABIOS-lgpl-latest.bin
+ * from http://www.nongnu.org/vgabios/ instead.
+ */
+#define PROM_FILENAME "u-boot-amigaone.bin"
+#define PROM_ADDR 0xfff00000
+#define PROM_SIZE (512 * KiB)
+
+static void amigaone_cpu_reset(void *opaque)
+{
+    PowerPCCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+    cpu_ppc_tb_reset(&cpu->env);
+}
+
+static void fix_spd_data(uint8_t *spd)
+{
+    uint32_t bank_size = 4 * MiB * spd[31];
+    uint32_t rows = bank_size / spd[13] / spd[17];
+    spd[3] = ctz32(rows) - spd[4];
+}
+
+static void amigaone_init(MachineState *machine)
+{
+    PowerPCCPU *cpu;
+    CPUPPCState *env;
+    MemoryRegion *rom, *pci_mem, *mr;
+    const char *fwname = machine->firmware ?: PROM_FILENAME;
+    char *filename;
+    ssize_t sz;
+    PCIBus *pci_bus;
+    Object *via;
+    DeviceState *dev;
+    I2CBus *i2c_bus;
+    uint8_t *spd_data;
+    int i;
+
+    /* init CPU */
+    cpu = POWERPC_CPU(cpu_create(machine->cpu_type));
+    env = &cpu->env;
+    if (PPC_INPUT(env) != PPC_FLAGS_INPUT_6xx) {
+        error_report("Incompatible CPU, only 6xx bus supported");
+        exit(1);
+    }
+    cpu_ppc_tb_init(env, BUS_FREQ_HZ / 4);
+    qemu_register_reset(amigaone_cpu_reset, cpu);
+
+    /* RAM */
+    if (machine->ram_size > 2 * GiB) {
+        error_report("RAM size more than 2 GiB is not supported");
+        exit(1);
+    }
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
+    if (machine->ram_size < 1 * GiB + 32 * KiB) {
+        /* Firmware uses this area for startup */
+        mr = g_new(MemoryRegion, 1);
+        memory_region_init_ram(mr, NULL, "init-cache", 32 * KiB, &error_fatal);
+        memory_region_add_subregion(get_system_memory(), 0x40000000, mr);
+    }
+
+    /* allocate and load firmware */
+    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
+    if (!filename) {
+        error_report("Could not find firmware '%s'", fwname);
+        exit(1);
+    }
+    rom = g_new(MemoryRegion, 1);
+    memory_region_init_rom(rom, NULL, "rom", PROM_SIZE, &error_fatal);
+    memory_region_add_subregion(get_system_memory(), PROM_ADDR, rom);
+    sz = load_image_targphys(filename, PROM_ADDR, PROM_SIZE);
+    if (sz <= 0 || sz > PROM_SIZE) {
+        error_report("Could not load firmware '%s'", filename);
+        exit(1);
+    }
+    g_free(filename);
+
+    /* Articia S */
+    dev = sysbus_create_simple(TYPE_ARTICIA, 0xfe000000, NULL);
+
+    i2c_bus = I2C_BUS(qdev_get_child_bus(dev, "smbus"));
+    if (machine->ram_size > 512 * MiB) {
+        spd_data = spd_data_generate(SDR, machine->ram_size / 2);
+    } else {
+        spd_data = spd_data_generate(SDR, machine->ram_size);
+    }
+    fix_spd_data(spd_data);
+    smbus_eeprom_init_one(i2c_bus, 0x51, spd_data);
+    if (machine->ram_size > 512 * MiB) {
+        smbus_eeprom_init_one(i2c_bus, 0x52, spd_data);
+    }
+
+    pci_mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-low", pci_mem,
+                             0, 0x1000000);
+    memory_region_add_subregion(get_system_memory(), 0xfd000000, mr);
+    mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(mr, OBJECT(dev), "pci-mem-high", pci_mem,
+                             0x80000000, 0x7d000000);
+    memory_region_add_subregion(get_system_memory(), 0x80000000, mr);
+    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
+
+    /* VIA VT82c686B South Bridge (multifunction PCI device) */
+    via = OBJECT(pci_create_simple_multifunction(pci_bus, PCI_DEVFN(7, 0),
+                                                 TYPE_VT82C686B_ISA));
+    object_property_add_alias(OBJECT(machine), "rtc-time",
+                              object_resolve_path_component(via, "rtc"),
+                              "date");
+    qdev_connect_gpio_out(DEVICE(via), 0,
+                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
+                                                             "pirq", i));
+    }
+    pci_ide_create_devs(PCI_DEVICE(object_resolve_path_component(via, "ide")));
+    pci_vga_init(pci_bus);
+}
+
+static void amigaone_machine_init(MachineClass *mc)
+{
+    mc->desc = "Eyetech AmigaOne/Mai Logic Teron";
+    mc->init = amigaone_init;
+    mc->block_default_type = IF_IDE;
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("7457_v1.2");
+    mc->default_display = "std";
+    mc->default_ram_id = "ram";
+    mc->default_ram_size = 128 * MiB;
+}
+
+DEFINE_MACHINE("amigaone", amigaone_machine_init)
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index 7c2c52434a..7338f9432a 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -81,6 +81,8 @@ ppc_ss.add(when: 'CONFIG_E500', if_true: files(
 ))
 # PowerPC 440 Xilinx ML507 reference board.
 ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
+# AmigaOne
+ppc_ss.add(when: 'CONFIG_AMIGAONE', if_true: files('amigaone.c'))
 # Pegasos2
 ppc_ss.add(when: 'CONFIG_PEGASOS2', if_true: files('pegasos2.c'))
 
-- 
2.30.9


