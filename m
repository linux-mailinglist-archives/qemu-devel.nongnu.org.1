Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67CAD1EA3
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Jun 2025 15:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOcNu-0001SA-B4; Mon, 09 Jun 2025 09:17:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uOcNp-0001Gm-D3; Mon, 09 Jun 2025 09:17:49 -0400
Received: from imap5.colo.codethink.co.uk ([78.40.148.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <srv_ts003@codethink.com>)
 id 1uOcNm-0006fk-2k; Mon, 09 Jun 2025 09:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap5-20230908; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MxMEjBX3ZAdWFSR0PD4WOcS+0SQK7f0T1oofFK052c4=; b=T9dEoE8+tGjgzOOUoPuIMPp+Sf
 jSv9+23qRXE7YQrpfdg3trxaJIpTOZwJ5wNcVgT1ec6EXfYFWXcgZxXZW+x59uIpkE1OEXAB+QcQU
 ZxAuiBWFFkhd2Gc2RpThi5RIwjWBGwmxW34NiyTjKSkep2SmK8Oel3XQZMwdzh6MSw9MVa8g2KHWR
 YdtxdRNp3LvyvlN/1KJRz3XkMMM1zOQnIazqZ/lb2VbXYWcjLV94u2lia/chTayQO5Mg+bCefK+EL
 eGTiJTz6vevP1t+rebGAeUBWgrKdOsCc0+Heu2NKJrZSSGk4EW1ur1veikslYIGNXK/Ot+TwDFJQT
 URGxkh3w==;
Received: from [63.135.74.212] (helo=rainbowdash)
 by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uOcNZ-00FOsq-2Q; Mon, 09 Jun 2025 14:17:33 +0100
Received: from ben by rainbowdash with local (Exim 4.98.2)
 (envelope-from <ben@rainbowdash>) id 1uOcNY-00000006969-2sGn;
 Mon, 09 Jun 2025 14:17:32 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: nazar.kazakov@codethink.co.uk, joseph.baker@codethink.co.uk,
 fran.redondo@codethink.co.uk, lawrence.hunter@codethink.co.uk,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org
Cc: ben.dooks@codethink.co.uk,
	qemu-devel@nongnu.org
Subject: [PATCH v3 1/3] hw/riscv: add CVA6 machine
Date: Mon,  9 Jun 2025 14:17:29 +0100
Message-Id: <20250609131731.1464616-2-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
In-Reply-To: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
References: <20250609131731.1464616-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=78.40.148.171;
 envelope-from=srv_ts003@codethink.com; helo=imap5.colo.codethink.co.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.097,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a (currently Genesy2 based) CVA6 machine.

Has SPI and UART, the GPIO and Ethernet are currently black-holed
as there is no hardware model for them (lowRISC ethernet and Xilinx
GPIO)

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
v3:
- fix missed plic comment
- made 64bit only for now
v2:
- whitespace fixes
- use g_autofree on plic
v1:
- squashed in fixes for sd-card and new qemu init
- move to spdx for cva6 machine
- code cleanups missed in first review

updated plic regmap

make cva6 64bit for now
---
 hw/riscv/Kconfig        |  11 ++
 hw/riscv/cva6.c         | 229 ++++++++++++++++++++++++++++++++++++++++
 hw/riscv/meson.build    |   1 +
 include/hw/riscv/cva6.h |  88 +++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 hw/riscv/cva6.c
 create mode 100644 include/hw/riscv/cva6.h

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index e6a0ac1fa1..033e29dab1 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -9,6 +9,17 @@ config IBEX
 
 # RISC-V machines in alphabetical order
 
+# technically it might be possible to build cva6 32bit
+config CVA6
+    bool
+    default y
+    depends on RISCV64
+    select DEVICE_TREE
+    select SIFIVE_PLIC
+    select XILINX_SPI
+    select RISCV_ACLINT
+    select UNIMP
+
 config MICROCHIP_PFSOC
     bool
     default y
diff --git a/hw/riscv/cva6.c b/hw/riscv/cva6.c
new file mode 100644
index 0000000000..3adfa8b5cc
--- /dev/null
+++ b/hw/riscv/cva6.c
@@ -0,0 +1,229 @@
+/*
+ * QEMU RISC-V Board for OpenHW CVA6 SoC
+ *
+ * Copyright (c) 2025 Codethink Ltd
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/boards.h"
+#include "hw/irq.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/misc/unimp.h"
+
+#include "hw/sd/sd.h"
+#include "hw/ssi/ssi.h"
+
+#include "hw/riscv/cva6.h"
+#include "hw/riscv/boot.h"
+#include "hw/intc/riscv_aclint.h"
+
+#include "system/system.h"
+
+#include <libfdt.h>
+
+#define CVA6_ROM_BASE  0x10000
+
+static const MemMapEntry cva6_memmap[] = {
+    [CVA6_DEBUG] =              {  0x0000000,  0x1000 },
+    [CVA6_ROM] =                { CVA6_ROM_BASE, 0x10000 },
+    [CVA6_CLINT] =              {  0x2000000, 0xC0000 },
+    [CVA6_PLIC] =               {  0xC000000, 0x4000000 },
+    [CVA6_UART] =               { 0x10000000, 0x1000 },
+    [CVA6_TIMER] =              { 0x18000000, 0x10000 },
+    [CVA6_SPI] =                { 0x20000000, 0x800000 },
+    [CVA6_ETHERNET] =           { 0x30000000, 0x10000 },
+    [CVA6_GPIO] =               { 0x40000000, 0x1000 },
+    [CVA6_DRAM] =               { 0x80000000, 0x40000000 },
+};
+
+static void cva6_machine_init(MachineState *machine)
+{
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    MemoryRegion *sys_mem = get_system_memory();
+    hwaddr dram_addr = cva6_memmap[CVA6_DRAM].base;
+    CVA6State *s = CVA6_MACHINE(machine);
+    RISCVBootInfo boot_info;
+
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_RISCV_CVA6);
+    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+
+    if (machine->ram_size > mc->default_ram_size) {
+        error_report("RAM size is too big for DRAM area");
+        exit(EXIT_FAILURE);
+    }
+
+    memory_region_add_subregion(sys_mem, dram_addr, machine->ram);
+    riscv_boot_info_init(&boot_info, &s->soc.cpus);
+
+    if (machine->firmware) {
+         hwaddr firmware_load_addr = cva6_memmap[CVA6_ROM].base;
+         riscv_load_firmware(machine->firmware, &firmware_load_addr, NULL);
+    }
+
+     if (machine->kernel_filename) {
+         /* note - we've not tested just loading the kernel w/o uboot */
+         riscv_load_kernel(machine, &boot_info, dram_addr, false, NULL);
+    }
+
+}
+
+static void cva6_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "RISC-V board for CVA6";
+    mc->init = cva6_machine_init;
+    mc->max_cpus = 1;
+    mc->default_ram_id = "cva6.ram";
+    /* start with "max" cpu type until we sort out CVA6 type */
+    mc->default_cpu_type = TYPE_RISCV_CPU_MAX;
+    mc->default_ram_size = cva6_memmap[CVA6_DRAM].size;
+};
+
+static void cva6_soc_init(Object *obj)
+{
+    CVA6SoCState *s = RISCV_CVA6(obj);
+
+    object_initialize_child(obj, "cpus", &s->cpus, TYPE_RISCV_HART_ARRAY);
+}
+
+static void cva6_add_spi(CVA6SoCState *s, const MemMapEntry *map)
+{
+    DriveInfo *dinfo;
+    BlockBackend *blk;
+    DeviceState *card_dev;
+    qemu_irq sd_cs;
+    DeviceState *sddev;
+    SysBusDevice *busdev;
+    DeviceState *spi_dev;
+    SSIBus *spi;
+
+    spi_dev = qdev_new("xlnx.xps-spi");
+    qdev_prop_set_uint8(spi_dev, "num-ss-bits", 1);
+    qdev_prop_set_string(spi_dev, "endianness", "little");
+
+    busdev = SYS_BUS_DEVICE(spi_dev);
+    sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_mmio_map(busdev, 0, map->base);
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(DEVICE(s->plic), CVA6_SPI_IRQ));
+
+    spi = (SSIBus *)qdev_get_child_bus(spi_dev, "spi");
+
+    sddev = ssi_create_peripheral(spi, "ssi-sd");
+    sd_cs = qdev_get_gpio_in_named(sddev, SSI_GPIO_CS, 0);
+    sysbus_connect_irq(busdev, 1, sd_cs);
+
+    dinfo = drive_get(IF_SD, 0, 0);
+    blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
+    card_dev = qdev_new(TYPE_SD_CARD_SPI);
+    qdev_prop_set_drive_err(card_dev, "drive", blk, &error_fatal);
+
+    qdev_realize_and_unref(card_dev, qdev_get_child_bus(sddev, "sd-bus"), &error_fatal);
+}
+
+static void not_implemented(const char *name, const MemMapEntry *map)
+{
+    create_unimplemented_device(name, map->base, map->size);
+}
+
+static void cva6_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    MemoryRegion *system_memory = get_system_memory();
+    MachineState *ms = MACHINE(qdev_get_machine());
+    CVA6SoCState *s = RISCV_CVA6(dev_soc);
+    const MemMapEntry *memmap = cva6_memmap;
+    MemoryRegion *rom = g_new(MemoryRegion, 1);
+    g_autofree char *plic_hart_config;
+
+    object_property_set_str(OBJECT(&s->cpus), "cpu-type", ms->cpu_type,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "num-harts", ms->smp.cpus,
+                            &error_abort);
+    object_property_set_int(OBJECT(&s->cpus), "resetvec", CVA6_ROM_BASE,
+                            &error_abort);
+    sysbus_realize(SYS_BUS_DEVICE(&s->cpus), &error_fatal);
+
+    /* boot rom */
+    memory_region_init_rom(rom, OBJECT(dev_soc), "riscv.cva6.bootrom",
+                           memmap[CVA6_ROM].size, &error_fatal);
+    memory_region_add_subregion(system_memory, memmap[CVA6_ROM].base,
+                                rom);
+
+    /* create PLIC hart topology configuration string */
+    plic_hart_config = riscv_plic_hart_config_string(ms->smp.cpus);
+
+    /* MMIO */
+    s->plic = sifive_plic_create(memmap[CVA6_PLIC].base,
+        plic_hart_config, ms->smp.cpus, 0,
+        CVA6_PLIC_NUM_SOURCES,
+        CVA6_PLIC_NUM_PRIORITIES,
+        CVA6_PLIC_PRIORITY_BASE,
+        CVA6_PLIC_PENDING_BASE,
+        CVA6_PLIC_ENABLE_BASE,
+        CVA6_PLIC_ENABLE_STRIDE,
+        CVA6_PLIC_CONTEXT_BASE,
+        CVA6_PLIC_CONTEXT_STRIDE,
+        memmap[CVA6_PLIC].size);
+
+    riscv_aclint_swi_create(memmap[CVA6_CLINT].base, 0,
+                            ms->smp.cpus, false);
+
+    riscv_aclint_mtimer_create(
+        memmap[CVA6_CLINT].base + RISCV_ACLINT_SWI_SIZE,
+        RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
+        RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
+        CLINT_TIMEBASE_FREQ, true);
+
+    /* something in cva6-sdk uboot seems to prod the debug
+     * unit by accident, so make it not implemented */
+    not_implemented("debug", &memmap[CVA6_DEBUG]);
+
+    /* 16550 uart, one 32bit register per 32bit word */
+
+    serial_mm_init(system_memory, memmap[CVA6_UART].base, 2,
+                   qdev_get_gpio_in(DEVICE(s->plic), CVA6_UART_IRQ),
+                   50*1000*10000,
+                   serial_hd(0), DEVICE_LITTLE_ENDIAN);
+
+    /* just unimplement the timers, network and gpio here for now.
+     * no-one seems to be using the apb timer block anyway*/
+    not_implemented("net", &memmap[CVA6_ETHERNET]);
+    not_implemented("gpio", &memmap[CVA6_GPIO]);
+    not_implemented("timer", &memmap[CVA6_TIMER]);
+
+    /* connect xilinx spi block here */
+    cva6_add_spi(s, &memmap[CVA6_SPI]);
+}
+
+static void cva6_soc_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = cva6_soc_realize;
+    dc->user_creatable = false;
+};
+
+static const TypeInfo cva6_types[] = {
+    {
+        .name           = TYPE_RISCV_CVA6,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(CVA6SoCState),
+        .instance_init  = cva6_soc_init,
+        .class_init     = cva6_soc_class_init,
+    }, {
+        .name           = TYPE_CVA6_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(CVA6State),
+        .class_init     = cva6_machine_class_init,
+    }
+};
+
+DEFINE_TYPES(cva6_types)
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
index c22f3a7216..a32fffab63 100644
--- a/hw/riscv/meson.build
+++ b/hw/riscv/meson.build
@@ -2,6 +2,7 @@ riscv_ss = ss.source_set()
 riscv_ss.add(files('boot.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_NUMA', if_true: files('numa.c'))
 riscv_ss.add(files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_CVA6', if_true: files('cva6.c'))
 riscv_ss.add(when: 'CONFIG_OPENTITAN', if_true: files('opentitan.c'))
 riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
 riscv_ss.add(when: 'CONFIG_SHAKTI_C', if_true: files('shakti_c.c'))
diff --git a/include/hw/riscv/cva6.h b/include/hw/riscv/cva6.h
new file mode 100644
index 0000000000..48e0979a0a
--- /dev/null
+++ b/include/hw/riscv/cva6.h
@@ -0,0 +1,88 @@
+/*
+ * QEMU RISC-V Board for OpenHW CVA6 SoC
+ * https://github.com/openhwgroup/cva6/tree/master/corev_apu
+ *
+ * Copyright (c) 2025 Codethink Ltd
+ * Ben Dooks <ben.dooks@codethink.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_CVA6_H
+#define HW_CVA6_H
+
+#include "hw/riscv/riscv_hart.h"
+#include "hw/intc/sifive_plic.h"
+#include "hw/char/serial-mm.h"
+
+#include "hw/boards.h"
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_CVA6 "riscv.cva6.soc"
+OBJECT_DECLARE_SIMPLE_TYPE(CVA6SoCState, RISCV_CVA6)
+
+typedef struct CVA6SoCState {
+    /*< private >*/
+    DeviceState parent_obj;
+
+    /*< public >*/
+    RISCVHartArrayState cpus;
+    DeviceState *plic;
+    MemoryRegion rom;
+
+    uint32_t resetvec;
+} CVA6SoCState;
+
+#define TYPE_CVA6_MACHINE MACHINE_TYPE_NAME("cva6")
+OBJECT_DECLARE_SIMPLE_TYPE(CVA6State, CVA6_MACHINE)
+
+typedef struct CVA6State {
+    /*< private >*/
+    MachineState parent_obj;
+
+    /*< public >*/
+    CVA6SoCState soc;
+}
+CVA6State;
+
+enum {
+    CVA6_DEBUG,
+    CVA6_ROM,
+    CVA6_CLINT,
+    CVA6_PLIC,
+    CVA6_UART,
+    CVA6_TIMER,
+    CVA6_SPI,
+    CVA6_ETHERNET,
+    CVA6_GPIO,
+    CVA6_DRAM,
+};
+
+enum {
+    CVA6_UART_IRQ       = 1,
+    CVA6_SPI_IRQ        = 2,
+    CVA6_ETH_IRQ        = 3,
+    CVA6_TIMER0_OVF_IRQ = 4,
+    CVA6_TIMER0_CMP_IRQ = 5,
+    CVA6_TIMER1_OVF_IRQ = 6,
+    CVA6_TIMER1_CMP_IRQ = 7,
+};
+
+#define CLINT_TIMEBASE_FREQ 25000000
+
+/*
+ * plic register interface in corev_apu/rv_plic/rtl/plic_regmap.sv
+ * https://github.com/pulp-platform/rv_plic/blob/master/rtl/plic_regmap.sv
+*/
+
+#define CVA6_PLIC_NUM_SOURCES           32
+#define CVA6_PLIC_NUM_PRIORITIES        7
+#define CVA6_PLIC_PRIORITY_BASE         0x0000
+#define CVA6_PLIC_PENDING_BASE          0x1000
+#define CVA6_PLIC_ENABLE_BASE           0x2000
+#define CVA6_PLIC_ENABLE_STRIDE         0x80
+#define CVA6_PLIC_CONTEXT_BASE          0x200000
+#define CVA6_PLIC_CONTEXT_STRIDE        0x1000
+
+#endif /* HW_CVA6_H */
-- 
2.37.2.352.g3c44437643


