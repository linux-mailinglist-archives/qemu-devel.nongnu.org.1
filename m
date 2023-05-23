Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8285670D9ED
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Otc-0004qw-2N; Tue, 23 May 2023 06:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1OtY-0004lk-Ck; Tue, 23 May 2023 06:05:32 -0400
Received: from m12.mail.163.com ([220.181.12.216])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1OtS-0006uI-W3; Tue, 23 May 2023 06:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yYal0
 fkkLh8G8ISz5sakliMwOIckwWwrBygm2j+tuH4=; b=RPQMX/d7CcDm44LVxODex
 VI6HrcMZX6DlMn15L3y/fELxScpDHiVBvXiFSPkTIoE1CZRhvwPlKCWNPUU6lpx2
 lj6sUqH/5SwiBmlwztTyKz+D9zn8JMQp83rR8DdvSiUaGOTJ9iKuJ9QKVcxx+Azk
 SxGpQATtSmRYmgflSP5VQ8=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAnDC3Wj2xkMfafAQ--.65319S3;
 Tue, 23 May 2023 18:05:13 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 01/11] hw: arm: Add bananapi M2-Ultra and allwinner-r40
 support
Date: Tue, 23 May 2023 18:04:58 +0800
Message-Id: <20230523100508.32564-2-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S3
X-Coremail-Antispam: 1Uf129KBjvAXoWfurWxJw4DXr18urWUXFWDArb_yoW8Kw4Uuo
 WfZFsYq3ykK39rWFyrKw409rWUuw1kWr47Aw47uFWxu3WUJw47KryUC3s7Xr43Xr40kF97
 X34Fvryfu3y7twn5n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RvksyUUUUU
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXBt47VXl6riLGQAAsi
Received-SPF: pass client-ip=220.181.12.216;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: qianfan Zhao <qianfanguijin@163.com>

Allwinner R40 (sun8i) SoC features a Quad-Core Cortex-A7 ARM CPU,
and a Mali400 MP2 GPU from ARM. It's also known as the Allwinner T3
for In-Car Entertainment usage, A40i and A40pro are variants that
differ in applicable temperatures range (industrial and military).

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/Kconfig                 |  10 +
 hw/arm/allwinner-r40.c         | 415 +++++++++++++++++++++++++++++++++
 hw/arm/bananapi_m2u.c          | 129 ++++++++++
 hw/arm/meson.build             |   1 +
 include/hw/arm/allwinner-r40.h | 110 +++++++++
 5 files changed, 665 insertions(+)
 create mode 100644 hw/arm/allwinner-r40.c
 create mode 100644 hw/arm/bananapi_m2u.c
 create mode 100644 include/hw/arm/allwinner-r40.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0f42c556d7..0afb87ec1a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -374,6 +374,16 @@ config ALLWINNER_H3
     select USB_EHCI_SYSBUS
     select SD
 
+config ALLWINNER_R40
+    bool
+    default y if TCG && ARM
+    select ALLWINNER_A10_PIT
+    select SERIAL
+    select ARM_TIMER
+    select ARM_GIC
+    select UNIMP
+    select SD
+
 config RASPI
     bool
     default y if TCG && ARM
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
new file mode 100644
index 0000000000..97f2aa92fd
--- /dev/null
+++ b/hw/arm/allwinner-r40.c
@@ -0,0 +1,415 @@
+/*
+ * Allwinner R40/A40i/T3 System on Chip emulation
+ *
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/bswap.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/qdev-core.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/misc/unimp.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/loader.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/allwinner-r40.h"
+
+/* Memory map */
+const hwaddr allwinner_r40_memmap[] = {
+    [AW_R40_DEV_SRAM_A1]    = 0x00000000,
+    [AW_R40_DEV_SRAM_A2]    = 0x00004000,
+    [AW_R40_DEV_SRAM_A3]    = 0x00008000,
+    [AW_R40_DEV_SRAM_A4]    = 0x0000b400,
+    [AW_R40_DEV_MMC0]       = 0x01c0f000,
+    [AW_R40_DEV_MMC1]       = 0x01c10000,
+    [AW_R40_DEV_MMC2]       = 0x01c11000,
+    [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_PIT]        = 0x01c20c00,
+    [AW_R40_DEV_UART0]      = 0x01c28000,
+    [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
+    [AW_R40_DEV_GIC_CPU]    = 0x01c82000,
+    [AW_R40_DEV_GIC_HYP]    = 0x01c84000,
+    [AW_R40_DEV_GIC_VCPU]   = 0x01c86000,
+    [AW_R40_DEV_SDRAM]      = 0x40000000
+};
+
+/* List of unimplemented devices */
+struct AwR40Unimplemented {
+    const char *device_name;
+    hwaddr base;
+    hwaddr size;
+};
+
+static struct AwR40Unimplemented r40_unimplemented[] = {
+    { "d-engine",   0x01000000, 4 * MiB },
+    { "d-inter",    0x01400000, 128 * KiB },
+    { "sram-c",     0x01c00000, 4 * KiB },
+    { "dma",        0x01c02000, 4 * KiB },
+    { "nfdc",       0x01c03000, 4 * KiB },
+    { "ts",         0x01c04000, 4 * KiB },
+    { "spi0",       0x01c05000, 4 * KiB },
+    { "spi1",       0x01c06000, 4 * KiB },
+    { "cs0",        0x01c09000, 4 * KiB },
+    { "keymem",     0x01c0a000, 4 * KiB },
+    { "emac",       0x01c0b000, 4 * KiB },
+    { "usb0-otg",   0x01c13000, 4 * KiB },
+    { "usb0-host",  0x01c14000, 4 * KiB },
+    { "crypto",     0x01c15000, 4 * KiB },
+    { "spi2",       0x01c17000, 4 * KiB },
+    { "sata",       0x01c18000, 4 * KiB },
+    { "usb1-host",  0x01c19000, 4 * KiB },
+    { "sid",        0x01c1b000, 4 * KiB },
+    { "usb2-host",  0x01c1c000, 4 * KiB },
+    { "cs1",        0x01c1d000, 4 * KiB },
+    { "spi3",       0x01c1f000, 4 * KiB },
+    { "ccu",        0x01c20000, 1 * KiB },
+    { "rtc",        0x01c20400, 1 * KiB },
+    { "pio",        0x01c20800, 1 * KiB },
+    { "owa",        0x01c21000, 1 * KiB },
+    { "ac97",       0x01c21400, 1 * KiB },
+    { "cir0",       0x01c21800, 1 * KiB },
+    { "cir1",       0x01c21c00, 1 * KiB },
+    { "pcm0",       0x01c22000, 1 * KiB },
+    { "pcm1",       0x01c22400, 1 * KiB },
+    { "pcm2",       0x01c22800, 1 * KiB },
+    { "audio",      0x01c22c00, 1 * KiB },
+    { "keypad",     0x01c23000, 1 * KiB },
+    { "pwm",        0x01c23400, 1 * KiB },
+    { "keyadc",     0x01c24400, 1 * KiB },
+    { "ths",        0x01c24c00, 1 * KiB },
+    { "rtp",        0x01c25000, 1 * KiB },
+    { "pmu",        0x01c25400, 1 * KiB },
+    { "cpu-cfg",    0x01c25c00, 1 * KiB },
+    { "uart0",      0x01c28000, 1 * KiB },
+    { "uart1",      0x01c28400, 1 * KiB },
+    { "uart2",      0x01c28800, 1 * KiB },
+    { "uart3",      0x01c28c00, 1 * KiB },
+    { "uart4",      0x01c29000, 1 * KiB },
+    { "uart5",      0x01c29400, 1 * KiB },
+    { "uart6",      0x01c29800, 1 * KiB },
+    { "uart7",      0x01c29c00, 1 * KiB },
+    { "ps20",       0x01c2a000, 1 * KiB },
+    { "ps21",       0x01c2a400, 1 * KiB },
+    { "twi0",       0x01c2ac00, 1 * KiB },
+    { "twi1",       0x01c2b000, 1 * KiB },
+    { "twi2",       0x01c2b400, 1 * KiB },
+    { "twi3",       0x01c2b800, 1 * KiB },
+    { "twi4",       0x01c2c000, 1 * KiB },
+    { "scr",        0x01c2c400, 1 * KiB },
+    { "tvd-top",    0x01c30000, 4 * KiB },
+    { "tvd0",       0x01c31000, 4 * KiB },
+    { "tvd1",       0x01c32000, 4 * KiB },
+    { "tvd2",       0x01c33000, 4 * KiB },
+    { "tvd3",       0x01c34000, 4 * KiB },
+    { "gpu",        0x01c40000, 64 * KiB },
+    { "gmac",       0x01c50000, 64 * KiB },
+    { "hstmr",      0x01c60000, 4 * KiB },
+    { "dram-com",   0x01c62000, 4 * KiB },
+    { "dram-ctl",   0x01c63000, 4 * KiB },
+    { "tcon-top",   0x01c70000, 4 * KiB },
+    { "lcd0",       0x01c71000, 4 * KiB },
+    { "lcd1",       0x01c72000, 4 * KiB },
+    { "tv0",        0x01c73000, 4 * KiB },
+    { "tv1",        0x01c74000, 4 * KiB },
+    { "tve-top",    0x01c90000, 16 * KiB },
+    { "tve0",       0x01c94000, 16 * KiB },
+    { "tve1",       0x01c98000, 16 * KiB },
+    { "mipi_dsi",   0x01ca0000, 4 * KiB },
+    { "mipi_dphy",  0x01ca1000, 4 * KiB },
+    { "ve",         0x01d00000, 1024 * KiB },
+    { "mp",         0x01e80000, 128 * KiB },
+    { "hdmi",       0x01ee0000, 128 * KiB },
+    { "prcm",       0x01f01400, 1 * KiB },
+    { "debug",      0x3f500000, 64 * KiB },
+    { "cpubist",    0x3f501000, 4 * KiB },
+    { "dcu",        0x3fff0000, 64 * KiB },
+    { "hstmr",      0x01c60000, 4 * KiB },
+    { "brom",       0xffff0000, 36 * KiB }
+};
+
+/* Per Processor Interrupts */
+enum {
+    AW_R40_GIC_PPI_MAINT     =  9,
+    AW_R40_GIC_PPI_HYPTIMER  = 10,
+    AW_R40_GIC_PPI_VIRTTIMER = 11,
+    AW_R40_GIC_PPI_SECTIMER  = 13,
+    AW_R40_GIC_PPI_PHYSTIMER = 14
+};
+
+/* Shared Processor Interrupts */
+enum {
+    AW_R40_GIC_SPI_UART0     =  1,
+    AW_R40_GIC_SPI_TIMER0    = 22,
+    AW_R40_GIC_SPI_TIMER1    = 23,
+    AW_R40_GIC_SPI_MMC0      = 32,
+    AW_R40_GIC_SPI_MMC1      = 33,
+    AW_R40_GIC_SPI_MMC2      = 34,
+    AW_R40_GIC_SPI_MMC3      = 35,
+};
+
+/* Allwinner R40 general constants */
+enum {
+    AW_R40_GIC_NUM_SPI       = 128
+};
+
+#define BOOT0_MAGIC             "eGON.BT0"
+
+/* The low 8-bits of the 'boot_media' field in the SPL header */
+#define SUNXI_BOOTED_FROM_MMC0  0
+#define SUNXI_BOOTED_FROM_NAND  1
+#define SUNXI_BOOTED_FROM_MMC2  2
+#define SUNXI_BOOTED_FROM_SPI   3
+
+struct boot_file_head {
+    uint32_t            b_instruction;
+    uint8_t             magic[8];
+    uint32_t            check_sum;
+    uint32_t            length;
+    uint32_t            pub_head_size;
+    uint32_t            fel_script_address;
+    uint32_t            fel_uEnv_length;
+    uint32_t            dt_name_offset;
+    uint32_t            dram_size;
+    uint32_t            boot_media;
+    uint32_t            string_pool[13];
+};
+
+bool allwinner_r40_bootrom_setup(AwR40State *s, BlockBackend *blk, int unit)
+{
+    const int64_t rom_size = 32 * KiB;
+    g_autofree uint8_t *buffer = g_new0(uint8_t, rom_size);
+    struct boot_file_head *head = (struct boot_file_head *)buffer;
+
+    if (blk_pread(blk, 8 * KiB, rom_size, buffer, 0) < 0) {
+        error_setg(&error_fatal, "%s: failed to read BlockBackend data",
+                   __func__);
+        return false;
+    }
+
+    /* we only check the magic string here. */
+    if (memcmp(head->magic, BOOT0_MAGIC, sizeof(head->magic))) {
+        return false;
+    }
+
+    /*
+     * Simulate the behavior of the bootROM, it will change the boot_media
+     * flag to indicate where the chip is booting from. R40 can boot from
+     * mmc0 or mmc2, the default value of boot_media is zero
+     * (SUNXI_BOOTED_FROM_MMC0), let's fix this flag when it is booting from
+     * the others.
+     */
+    if (unit == 2) {
+        head->boot_media = cpu_to_le32(SUNXI_BOOTED_FROM_MMC2);
+    } else {
+        head->boot_media = cpu_to_le32(SUNXI_BOOTED_FROM_MMC0);
+    }
+
+    rom_add_blob("allwinner-r40.bootrom", buffer, rom_size,
+                  rom_size, s->memmap[AW_R40_DEV_SRAM_A1],
+                  NULL, NULL, NULL, NULL, false);
+    return true;
+}
+
+static void allwinner_r40_init(Object *obj)
+{
+    static const char *mmc_names[AW_R40_NUM_MMCS] = {
+        "mmc0", "mmc1", "mmc2", "mmc3"
+    };
+    AwR40State *s = AW_R40(obj);
+
+    s->memmap = allwinner_r40_memmap;
+
+    for (int i = 0; i < AW_R40_NUM_CPUS; i++) {
+        object_initialize_child(obj, "cpu[*]", &s->cpus[i],
+                                ARM_CPU_TYPE_NAME("cortex-a7"));
+    }
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+
+    object_initialize_child(obj, "timer", &s->timer, TYPE_AW_A10_PIT);
+    object_property_add_alias(obj, "clk0-freq", OBJECT(&s->timer),
+                              "clk0-freq");
+    object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
+                              "clk1-freq");
+
+    for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
+        object_initialize_child(obj, mmc_names[i], &s->mmc[i],
+                                TYPE_AW_SDHOST_SUN5I);
+    }
+}
+
+static void allwinner_r40_realize(DeviceState *dev, Error **errp)
+{
+    AwR40State *s = AW_R40(dev);
+    unsigned i;
+
+    /* CPUs */
+    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+
+        /*
+         * Disable secondary CPUs. Guest EL3 firmware will start
+         * them via CPU reset control registers.
+         */
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "start-powered-off",
+                          i > 0);
+
+        /* All exception levels required */
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el3", true);
+        qdev_prop_set_bit(DEVICE(&s->cpus[i]), "has_el2", true);
+
+        /* Mark realized */
+        qdev_realize(DEVICE(&s->cpus[i]), NULL, &error_fatal);
+    }
+
+    /* Generic Interrupt Controller */
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-irq", AW_R40_GIC_NUM_SPI +
+                                                     GIC_INTERNAL);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "num-cpu", AW_R40_NUM_CPUS);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-security-extensions", false);
+    qdev_prop_set_bit(DEVICE(&s->gic), "has-virtualization-extensions", true);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gic), &error_fatal);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, s->memmap[AW_R40_DEV_GIC_DIST]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, s->memmap[AW_R40_DEV_GIC_CPU]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2, s->memmap[AW_R40_DEV_GIC_HYP]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3, s->memmap[AW_R40_DEV_GIC_VCPU]);
+
+    /*
+     * Wire the outputs from each CPU's generic timer and the GICv2
+     * maintenance interrupt signal to the appropriate GIC PPI inputs,
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     */
+    for (i = 0; i < AW_R40_NUM_CPUS; i++) {
+        DeviceState *cpudev = DEVICE(&s->cpus[i]);
+        int ppibase = AW_R40_GIC_NUM_SPI + i * GIC_INTERNAL + GIC_NR_SGIS;
+        int irq;
+        /*
+         * Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs used for this board.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = AW_R40_GIC_PPI_PHYSTIMER,
+            [GTIMER_VIRT] = AW_R40_GIC_PPI_VIRTTIMER,
+            [GTIMER_HYP]  = AW_R40_GIC_PPI_HYPTIMER,
+            [GTIMER_SEC]  = AW_R40_GIC_PPI_SECTIMER,
+        };
+
+        /* Connect CPU timer outputs to GIC PPI inputs */
+        for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+            qdev_connect_gpio_out(cpudev, irq,
+                                  qdev_get_gpio_in(DEVICE(&s->gic),
+                                                   ppibase + timer_irq[irq]));
+        }
+
+        /* Connect GIC outputs to CPU interrupt inputs */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + AW_R40_NUM_CPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (2 * AW_R40_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (3 * AW_R40_NUM_CPUS),
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        /* GIC maintenance signal */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + (4 * AW_R40_NUM_CPUS),
+                           qdev_get_gpio_in(DEVICE(&s->gic),
+                                            ppibase + AW_R40_GIC_PPI_MAINT));
+    }
+
+    /* Timer */
+    sysbus_realize(SYS_BUS_DEVICE(&s->timer), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->timer), 0, s->memmap[AW_R40_DEV_PIT]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic),
+                       AW_R40_GIC_SPI_TIMER0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->timer), 1,
+                       qdev_get_gpio_in(DEVICE(&s->gic),
+                       AW_R40_GIC_SPI_TIMER1));
+
+    /* SRAM */
+    memory_region_init_ram(&s->sram_a1, OBJECT(dev), "sram A1",
+                            16 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_a2, OBJECT(dev), "sram A2",
+                            16 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_a3, OBJECT(dev), "sram A3",
+                            13 * KiB, &error_abort);
+    memory_region_init_ram(&s->sram_a4, OBJECT(dev), "sram A4",
+                            3 * KiB, &error_abort);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_R40_DEV_SRAM_A1], &s->sram_a1);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_R40_DEV_SRAM_A2], &s->sram_a2);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_R40_DEV_SRAM_A3], &s->sram_a3);
+    memory_region_add_subregion(get_system_memory(),
+                                s->memmap[AW_R40_DEV_SRAM_A4], &s->sram_a4);
+
+    /* SD/MMC */
+    for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
+        qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->gic),
+                                        AW_R40_GIC_SPI_MMC0 + i);
+        const hwaddr addr = s->memmap[AW_R40_DEV_MMC0 + i];
+
+        object_property_set_link(OBJECT(&s->mmc[i]), "dma-memory",
+                                 OBJECT(get_system_memory()), &error_fatal);
+        sysbus_realize(SYS_BUS_DEVICE(&s->mmc[i]), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc[i]), 0, addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc[i]), 0, irq);
+    }
+
+    /* UART0. For future clocktree API: All UARTS are connected to APB2_CLK. */
+    serial_mm_init(get_system_memory(), s->memmap[AW_R40_DEV_UART0], 2,
+                   qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_UART0),
+                   115200, serial_hd(0), DEVICE_NATIVE_ENDIAN);
+
+    /* Unimplemented devices */
+    for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
+        create_unimplemented_device(r40_unimplemented[i].device_name,
+                                    r40_unimplemented[i].base,
+                                    r40_unimplemented[i].size);
+    }
+}
+
+static void allwinner_r40_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = allwinner_r40_realize;
+    /* Reason: uses serial_hd() in realize function */
+    dc->user_creatable = false;
+}
+
+static const TypeInfo allwinner_r40_type_info = {
+    .name = TYPE_AW_R40,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(AwR40State),
+    .instance_init = allwinner_r40_init,
+    .class_init = allwinner_r40_class_init,
+};
+
+static void allwinner_r40_register_types(void)
+{
+    type_register_static(&allwinner_r40_type_info);
+}
+
+type_init(allwinner_r40_register_types)
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
new file mode 100644
index 0000000000..1d49a006b5
--- /dev/null
+++ b/hw/arm/bananapi_m2u.c
@@ -0,0 +1,129 @@
+/*
+ * Bananapi M2U emulation
+ *
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "exec/address-spaces.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/arm/allwinner-r40.h"
+
+static struct arm_boot_info bpim2u_binfo;
+
+/*
+ * R40 can boot from mmc0 and mmc2, and bpim2u has two mmc interface, one is
+ * connected to sdcard and another mount an emmc media.
+ * Attach the mmc driver and try loading bootloader.
+ */
+static void mmc_attach_drive(AwR40State *s, AwSdHostState *mmc, int unit,
+                             bool load_bootroom, bool *bootroom_loaded)
+{
+    DriveInfo *di = drive_get(IF_SD, 0, unit);
+    BlockBackend *blk = di ? blk_by_legacy_dinfo(di) : NULL;
+    BusState *bus;
+    DeviceState *carddev;
+
+    bus = qdev_get_child_bus(DEVICE(mmc), "sd-bus");
+    if (bus == NULL) {
+        error_report("No SD bus found in SOC object");
+        exit(1);
+    }
+
+    carddev = qdev_new(TYPE_SD_CARD);
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(carddev, bus, &error_fatal);
+
+    if (load_bootroom && blk && blk_is_available(blk)) {
+        /* Use Boot ROM to copy data from SD card to SRAM */
+        *bootroom_loaded = allwinner_r40_bootrom_setup(s, blk, unit);
+    }
+}
+
+static void bpim2u_init(MachineState *machine)
+{
+    bool bootroom_loaded = false;
+    AwR40State *r40;
+
+    /* BIOS is not supported by this board */
+    if (machine->firmware) {
+        error_report("BIOS not supported for this machine");
+        exit(1);
+    }
+
+    /* Only allow Cortex-A7 for this board */
+    if (strcmp(machine->cpu_type, ARM_CPU_TYPE_NAME("cortex-a7")) != 0) {
+        error_report("This board can only be used with cortex-a7 CPU");
+        exit(1);
+    }
+
+    r40 = AW_R40(object_new(TYPE_AW_R40));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(r40));
+    object_unref(OBJECT(r40));
+
+    /* Setup timer properties */
+    object_property_set_int(OBJECT(r40), "clk0-freq", 32768, &error_abort);
+    object_property_set_int(OBJECT(r40), "clk1-freq", 24 * 1000 * 1000,
+                            &error_abort);
+
+    /* Mark R40 object realized */
+    qdev_realize(DEVICE(r40), NULL, &error_abort);
+
+    /*
+     * Plug in SD card and try load bootrom, R40 has 4 mmc controllers but can
+     * only booting from mmc0 and mmc2.
+     */
+    for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
+        switch (i) {
+        case 0:
+        case 2:
+            mmc_attach_drive(r40, &r40->mmc[i], i,
+                             !machine->kernel_filename && !bootroom_loaded,
+                             &bootroom_loaded);
+            break;
+        default:
+            mmc_attach_drive(r40, &r40->mmc[i], i, false, NULL);
+            break;
+        }
+    }
+
+    /* SDRAM */
+    memory_region_add_subregion(get_system_memory(),
+                                r40->memmap[AW_R40_DEV_SDRAM], machine->ram);
+
+    bpim2u_binfo.loader_start = r40->memmap[AW_R40_DEV_SDRAM];
+    bpim2u_binfo.ram_size = machine->ram_size;
+    bpim2u_binfo.psci_conduit = QEMU_PSCI_CONDUIT_SMC;
+    arm_load_kernel(ARM_CPU(first_cpu), machine, &bpim2u_binfo);
+}
+
+static void bpim2u_machine_init(MachineClass *mc)
+{
+    mc->desc = "Bananapi M2U (Cortex-A7)";
+    mc->init = bpim2u_init;
+    mc->min_cpus = AW_R40_NUM_CPUS;
+    mc->max_cpus = AW_R40_NUM_CPUS;
+    mc->default_cpus = AW_R40_NUM_CPUS;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
+    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_id = "bpim2u.ram";
+}
+
+DEFINE_MACHINE("bpim2u", bpim2u_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index b545ba0e4f..870ec67376 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -37,6 +37,7 @@ arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c', 'omap2.c'))
 arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
+arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
new file mode 100644
index 0000000000..348bf25d6b
--- /dev/null
+++ b/include/hw/arm/allwinner-r40.h
@@ -0,0 +1,110 @@
+/*
+ * Allwinner R40/A40i/T3 System on Chip emulation
+ *
+ * Copyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ARM_ALLWINNER_R40_H
+#define HW_ARM_ALLWINNER_R40_H
+
+#include "qom/object.h"
+#include "hw/arm/boot.h"
+#include "hw/timer/allwinner-a10-pit.h"
+#include "hw/intc/arm_gic.h"
+#include "hw/sd/allwinner-sdhost.h"
+#include "target/arm/cpu.h"
+#include "sysemu/block-backend.h"
+
+enum {
+    AW_R40_DEV_SRAM_A1,
+    AW_R40_DEV_SRAM_A2,
+    AW_R40_DEV_SRAM_A3,
+    AW_R40_DEV_SRAM_A4,
+    AW_R40_DEV_MMC0,
+    AW_R40_DEV_MMC1,
+    AW_R40_DEV_MMC2,
+    AW_R40_DEV_MMC3,
+    AW_R40_DEV_CCU,
+    AW_R40_DEV_PIT,
+    AW_R40_DEV_UART0,
+    AW_R40_DEV_GIC_DIST,
+    AW_R40_DEV_GIC_CPU,
+    AW_R40_DEV_GIC_HYP,
+    AW_R40_DEV_GIC_VCPU,
+    AW_R40_DEV_SDRAM
+};
+
+#define AW_R40_NUM_CPUS      (4)
+
+/**
+ * Allwinner R40 object model
+ * @{
+ */
+
+/** Object type for the Allwinner R40 SoC */
+#define TYPE_AW_R40 "allwinner-r40"
+
+/** Convert input object to Allwinner R40 state object */
+OBJECT_DECLARE_SIMPLE_TYPE(AwR40State, AW_R40)
+
+/** @} */
+
+/**
+ * Allwinner R40 object
+ *
+ * This struct contains the state of all the devices
+ * which are currently emulated by the R40 SoC code.
+ */
+#define AW_R40_NUM_MMCS         4
+
+struct AwR40State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    ARMCPU cpus[AW_R40_NUM_CPUS];
+    const hwaddr *memmap;
+    AwA10PITState timer;
+    AwSdHostState mmc[AW_R40_NUM_MMCS];
+    GICState gic;
+    MemoryRegion sram_a1;
+    MemoryRegion sram_a2;
+    MemoryRegion sram_a3;
+    MemoryRegion sram_a4;
+};
+
+/**
+ * Emulate Boot ROM firmware setup functionality.
+ *
+ * A real Allwinner R40 SoC contains a Boot ROM
+ * which is the first code that runs right after
+ * the SoC is powered on. The Boot ROM is responsible
+ * for loading user code (e.g. a bootloader) from any
+ * of the supported external devices and writing the
+ * downloaded code to internal SRAM. After loading the SoC
+ * begins executing the code written to SRAM.
+ *
+ * This function emulates the Boot ROM by copying 32 KiB
+ * of data from the given block device and writes it to
+ * the start of the first internal SRAM memory.
+ *
+ * @s: Allwinner R40 state object pointer
+ * @blk: Block backend device object pointer
+ * @unit: the mmc control's unit
+ */
+bool allwinner_r40_bootrom_setup(AwR40State *s, BlockBackend *blk, int unit);
+
+#endif /* HW_ARM_ALLWINNER_R40_H */
-- 
2.25.1


