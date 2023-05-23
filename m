Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6DF70D9E8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ou2-0005Dq-6M; Tue, 23 May 2023 06:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1Otw-00054F-V5; Tue, 23 May 2023 06:05:58 -0400
Received: from m12.mail.163.com ([220.181.12.215])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1Ott-00079I-B7; Tue, 23 May 2023 06:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=vP8Cq
 KAV00ydKV1/c+Ir8Sc5aY0y4lMUdijiaaCTOSc=; b=kdplax0UCJ2yb/Fo0ghgs
 3VmtyNUP7Q3KJXhhs1XYjuBFH68AsC1XHw3hLN7gPv0zFDW14Mor1UhmCG3qTfBD
 drA3yvxlPiXAIo4HXiADzhFrmu6pCejEn5CMIzUo3aWn6CJEuItxJ2nUvQOWRq5F
 bfBXLv0LuKAoVMF7ys6Itg=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAnDC3Wj2xkMfafAQ--.65319S8;
 Tue, 23 May 2023 18:05:23 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 06/11] hw/arm/allwinner-r40: add SDRAM controller device
Date: Tue, 23 May 2023 18:05:03 +0800
Message-Id: <20230523100508.32564-7-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S8
X-Coremail-Antispam: 1Uf129KBjvAXoWftFWxCw15XrWrCFy8ur45ZFb_yoW5Gw4xuo
 WSgF45Zw4agw12qr1Fgw1jyr13Kws8KrWxJw45GF43ua98JFs8G39xJwn5Xr4fWr4FkFn7
 XFySgr1fZrWkCas3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R1xRQUUUUU
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbBzgZ47WI0ZReIvQAAsM
Received-SPF: pass client-ip=220.181.12.215;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: qianfan Zhao <qianfanguijin@163.com>

Types of memory that the SDRAM controller supports are DDR2/DDR3
and capacities of up to 2GiB. This commit adds emulation support
of the Allwinner R40 SDRAM controller.

This driver only support 256M, 512M and 1024M memory now.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 hw/arm/allwinner-r40.c                |  21 +-
 hw/arm/bananapi_m2u.c                 |   7 +
 hw/misc/allwinner-r40-dramc.c         | 513 ++++++++++++++++++++++++++
 hw/misc/meson.build                   |   1 +
 hw/misc/trace-events                  |  14 +
 include/hw/arm/allwinner-r40.h        |  13 +-
 include/hw/misc/allwinner-r40-dramc.h | 108 ++++++
 7 files changed, 674 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/allwinner-r40-dramc.c
 create mode 100644 include/hw/misc/allwinner-r40-dramc.h

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 4bc582630c..0e4542d35f 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -31,6 +31,7 @@
 #include "hw/loader.h"
 #include "sysemu/sysemu.h"
 #include "hw/arm/allwinner-r40.h"
+#include "hw/misc/allwinner-r40-dramc.h"
 
 /* Memory map */
 const hwaddr allwinner_r40_memmap[] = {
@@ -53,6 +54,9 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_UART6]      = 0x01c29800,
     [AW_R40_DEV_UART7]      = 0x01c29c00,
     [AW_R40_DEV_TWI0]       = 0x01c2ac00,
+    [AW_R40_DEV_DRAMCOM]    = 0x01c62000,
+    [AW_R40_DEV_DRAMCTL]    = 0x01c63000,
+    [AW_R40_DEV_DRAMPHY]    = 0x01c65000,
     [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
     [AW_R40_DEV_GIC_CPU]    = 0x01c82000,
     [AW_R40_DEV_GIC_HYP]    = 0x01c84000,
@@ -129,8 +133,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "gpu",        0x01c40000, 64 * KiB },
     { "gmac",       0x01c50000, 64 * KiB },
     { "hstmr",      0x01c60000, 4 * KiB },
-    { "dram-com",   0x01c62000, 4 * KiB },
-    { "dram-ctl",   0x01c63000, 4 * KiB },
     { "tcon-top",   0x01c70000, 4 * KiB },
     { "lcd0",       0x01c71000, 4 * KiB },
     { "lcd1",       0x01c72000, 4 * KiB },
@@ -273,6 +275,12 @@ static void allwinner_r40_init(Object *obj)
     }
 
     object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
+
+    object_initialize_child(obj, "dramc", &s->dramc, TYPE_AW_R40_DRAMC);
+    object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
+                             "ram-addr");
+    object_property_add_alias(obj, "ram-size", OBJECT(&s->dramc),
+                              "ram-size");
 }
 
 static void allwinner_r40_realize(DeviceState *dev, Error **errp)
@@ -425,6 +433,15 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c0), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_TWI0));
 
+    /* DRAMC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->dramc), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 0,
+                    s->memmap[AW_R40_DEV_DRAMCOM]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 1,
+                    s->memmap[AW_R40_DEV_DRAMCTL]);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
+                    s->memmap[AW_R40_DEV_DRAMPHY]);
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 9c5360a41b..20a4550c68 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -85,6 +85,13 @@ static void bpim2u_init(MachineState *machine)
     object_property_set_int(OBJECT(r40), "clk1-freq", 24 * 1000 * 1000,
                             &error_abort);
 
+    /* DRAMC */
+    r40->ram_size = machine->ram_size / MiB;
+    object_property_set_uint(OBJECT(r40), "ram-addr",
+                             r40->memmap[AW_R40_DEV_SDRAM], &error_abort);
+    object_property_set_int(OBJECT(r40), "ram-size",
+                            r40->ram_size, &error_abort);
+
     /* Mark R40 object realized */
     qdev_realize(DEVICE(r40), NULL, &error_abort);
 
diff --git a/hw/misc/allwinner-r40-dramc.c b/hw/misc/allwinner-r40-dramc.c
new file mode 100644
index 0000000000..ea6124744f
--- /dev/null
+++ b/hw/misc/allwinner-r40-dramc.c
@@ -0,0 +1,513 @@
+/*
+ * Allwinner R40 SDRAM Controller emulation
+ *
+ * CCopyright (C) 2023 qianfan Zhao <qianfanguijin@163.com>
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
+#include "qemu/error-report.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "exec/address-spaces.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/bitops.h"
+#include "hw/misc/allwinner-r40-dramc.h"
+#include "trace.h"
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* DRAMCOM register offsets */
+enum {
+    REG_DRAMCOM_CR    = 0x0000, /* Control Register */
+};
+
+/* DRAMCOMM register flags */
+enum {
+    REG_DRAMCOM_CR_DUAL_RANK = (1 << 0),
+};
+
+/* DRAMCTL register offsets */
+enum {
+    REG_DRAMCTL_PIR   = 0x0000, /* PHY Initialization Register */
+    REG_DRAMCTL_PGSR  = 0x0010, /* PHY General Status Register */
+    REG_DRAMCTL_STATR = 0x0018, /* Status Register */
+    REG_DRAMCTL_PGCR  = 0x0100, /* PHY general configuration registers */
+};
+
+/* DRAMCTL register flags */
+enum {
+    REG_DRAMCTL_PGSR_INITDONE = (1 << 0),
+    REG_DRAMCTL_PGSR_READ_TIMEOUT = (1 << 13),
+    REG_DRAMCTL_PGCR_ENABLE_READ_TIMEOUT = (1 << 25),
+};
+
+enum {
+    REG_DRAMCTL_STATR_ACTIVE  = (1 << 0),
+};
+
+#define DRAM_MAX_ROW_BITS       16
+#define DRAM_MAX_COL_BITS       13  /* 8192 */
+#define DRAM_MAX_BANK            3
+
+static uint64_t dram_autodetect_cells[DRAM_MAX_ROW_BITS]
+                                     [DRAM_MAX_BANK]
+                                     [DRAM_MAX_COL_BITS];
+struct VirtualDDRChip {
+    uint32_t    ram_size;
+    uint8_t     bank_bits;
+    uint8_t     row_bits;
+    uint8_t     col_bits;
+};
+
+/*
+ * Only power of 2 RAM sizes from 256MiB up to 2048MiB are supported,
+ * 2GiB memory is not supported due to dual rank feature.
+ */
+static const struct VirtualDDRChip dummy_ddr_chips[] = {
+    {
+        .ram_size   = 256,
+        .bank_bits  = 3,
+        .row_bits   = 12,
+        .col_bits   = 13,
+    }, {
+        .ram_size   = 512,
+        .bank_bits  = 3,
+        .row_bits   = 13,
+        .col_bits   = 13,
+    }, {
+        .ram_size   = 1024,
+        .bank_bits  = 3,
+        .row_bits   = 14,
+        .col_bits   = 13,
+    }, {
+        0
+    }
+};
+
+static const struct VirtualDDRChip *get_match_ddr(uint32_t ram_size)
+{
+    const struct VirtualDDRChip *ddr;
+
+    for (ddr = &dummy_ddr_chips[0]; ddr->ram_size; ddr++) {
+        if (ddr->ram_size == ram_size) {
+            return ddr;
+        }
+    }
+
+    return NULL;
+}
+
+static uint64_t *address_to_autodetect_cells(AwR40DramCtlState *s,
+                                             const struct VirtualDDRChip *ddr,
+                                             uint32_t offset)
+{
+    int row_index = 0, bank_index = 0, col_index = 0;
+    uint32_t row_addr, bank_addr, col_addr;
+
+    row_addr = extract32(offset, s->set_col_bits + s->set_bank_bits,
+                         s->set_row_bits);
+    bank_addr = extract32(offset, s->set_col_bits, s->set_bank_bits);
+    col_addr = extract32(offset, 0, s->set_col_bits);
+
+    for (int i = 0; i < ddr->row_bits; i++) {
+        if (row_addr & BIT(i)) {
+            row_index = i;
+        }
+    }
+
+    for (int i = 0; i < ddr->bank_bits; i++) {
+        if (bank_addr & BIT(i)) {
+            bank_index = i;
+        }
+    }
+
+    for (int i = 0; i < ddr->col_bits; i++) {
+        if (col_addr & BIT(i)) {
+            col_index = i;
+        }
+    }
+
+    trace_allwinner_r40_dramc_offset_to_cell(offset, row_index, bank_index,
+                                             col_index);
+    return &dram_autodetect_cells[row_index][bank_index][col_index];
+}
+
+static void allwinner_r40_dramc_map_rows(AwR40DramCtlState *s, uint8_t row_bits,
+                                         uint8_t bank_bits, uint8_t col_bits)
+{
+    const struct VirtualDDRChip *ddr = get_match_ddr(s->ram_size);
+    bool enable_detect_cells;
+
+    trace_allwinner_r40_dramc_map_rows(row_bits, bank_bits, col_bits);
+
+    if (!ddr) {
+        return;
+    }
+
+    s->set_row_bits = row_bits;
+    s->set_bank_bits = bank_bits;
+    s->set_col_bits = col_bits;
+
+    enable_detect_cells = ddr->bank_bits != bank_bits
+                        || ddr->row_bits != row_bits
+                        || ddr->col_bits != col_bits;
+
+    if (enable_detect_cells) {
+        trace_allwinner_r40_dramc_detect_cells_enable();
+    } else {
+        trace_allwinner_r40_dramc_detect_cells_disable();
+    }
+
+    memory_region_set_enabled(&s->detect_cells, enable_detect_cells);
+}
+
+static uint64_t allwinner_r40_dramcom_read(void *opaque, hwaddr offset,
+                                           unsigned size)
+{
+    const AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_R40_DRAMCOM_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_r40_dramcom_read(offset, s->dramcom[idx], size);
+    return s->dramcom[idx];
+}
+
+static void allwinner_r40_dramcom_write(void *opaque, hwaddr offset,
+                                        uint64_t val, unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_r40_dramcom_write(offset, val, size);
+
+    if (idx >= AW_R40_DRAMCOM_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_DRAMCOM_CR:   /* Control Register */
+        if (!(val & REG_DRAMCOM_CR_DUAL_RANK)) {
+            allwinner_r40_dramc_map_rows(s, ((val >> 4) & 0xf) + 1,
+                                         ((val >> 2) & 0x1) + 2,
+                                         (((val >> 8) & 0xf) + 3));
+        }
+        break;
+    };
+
+    s->dramcom[idx] = (uint32_t) val;
+}
+
+static uint64_t allwinner_r40_dramctl_read(void *opaque, hwaddr offset,
+                                           unsigned size)
+{
+    const AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_R40_DRAMCTL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_r40_dramctl_read(offset, s->dramctl[idx], size);
+    return s->dramctl[idx];
+}
+
+static void allwinner_r40_dramctl_write(void *opaque, hwaddr offset,
+                                        uint64_t val, unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_r40_dramctl_write(offset, val, size);
+
+    if (idx >= AW_R40_DRAMCTL_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    switch (offset) {
+    case REG_DRAMCTL_PIR:    /* PHY Initialization Register */
+        s->dramctl[REG_INDEX(REG_DRAMCTL_PGSR)] |= REG_DRAMCTL_PGSR_INITDONE;
+        s->dramctl[REG_INDEX(REG_DRAMCTL_STATR)] |= REG_DRAMCTL_STATR_ACTIVE;
+        break;
+    }
+
+    s->dramctl[idx] = (uint32_t) val;
+}
+
+static uint64_t allwinner_r40_dramphy_read(void *opaque, hwaddr offset,
+                                           unsigned size)
+{
+    const AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    if (idx >= AW_R40_DRAMPHY_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    trace_allwinner_r40_dramphy_read(offset, s->dramphy[idx], size);
+    return s->dramphy[idx];
+}
+
+static void allwinner_r40_dramphy_write(void *opaque, hwaddr offset,
+                                        uint64_t val, unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_r40_dramphy_write(offset, val, size);
+
+    if (idx >= AW_R40_DRAMPHY_REGS_NUM) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return;
+    }
+
+    s->dramphy[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_r40_dramcom_ops = {
+    .read = allwinner_r40_dramcom_read,
+    .write = allwinner_r40_dramcom_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const MemoryRegionOps allwinner_r40_dramctl_ops = {
+    .read = allwinner_r40_dramctl_read,
+    .write = allwinner_r40_dramctl_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const MemoryRegionOps allwinner_r40_dramphy_ops = {
+    .read = allwinner_r40_dramphy_read,
+    .write = allwinner_r40_dramphy_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static uint64_t allwinner_r40_detect_read(void *opaque, hwaddr offset,
+                                          unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const struct VirtualDDRChip *ddr = get_match_ddr(s->ram_size);
+    uint64_t data = 0;
+
+    if (ddr) {
+        data = *address_to_autodetect_cells(s, ddr, (uint32_t)offset);
+    }
+
+    trace_allwinner_r40_dramc_detect_cell_read(offset, data);
+    return data;
+}
+
+static void allwinner_r40_detect_write(void *opaque, hwaddr offset,
+                                       uint64_t data, unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    const struct VirtualDDRChip *ddr = get_match_ddr(s->ram_size);
+
+    if (ddr) {
+        uint64_t *cell = address_to_autodetect_cells(s, ddr, (uint32_t)offset);
+        trace_allwinner_r40_dramc_detect_cell_write(offset, data);
+        *cell = data;
+    }
+}
+
+static const MemoryRegionOps allwinner_r40_detect_ops = {
+    .read = allwinner_r40_detect_read,
+    .write = allwinner_r40_detect_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+/*
+ * mctl_r40_detect_rank_count in u-boot will write the high 1G of DDR
+ * to detect wether the board support dual_rank or not. Create a virtual memory
+ * if the board's ram_size less or equal than 1G, and set read time out flag of
+ * REG_DRAMCTL_PGSR when the user touch this high dram.
+ */
+static uint64_t allwinner_r40_dualrank_detect_read(void *opaque, hwaddr offset,
+                                                   unsigned size)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(opaque);
+    uint32_t reg;
+
+    reg = s->dramctl[REG_INDEX(REG_DRAMCTL_PGCR)];
+    if (reg & REG_DRAMCTL_PGCR_ENABLE_READ_TIMEOUT) { /* Enable read time out */
+        /*
+         * this driver only support one rank, mark READ_TIMEOUT when try
+         * read the second rank.
+         */
+        s->dramctl[REG_INDEX(REG_DRAMCTL_PGSR)]
+                                |= REG_DRAMCTL_PGSR_READ_TIMEOUT;
+    }
+
+    return 0;
+}
+
+static const MemoryRegionOps allwinner_r40_dualrank_detect_ops = {
+    .read = allwinner_r40_dualrank_detect_read,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_r40_dramc_reset(DeviceState *dev)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(dev);
+
+    /* Set default values for registers */
+    memset(&s->dramcom, 0, sizeof(s->dramcom));
+    memset(&s->dramctl, 0, sizeof(s->dramctl));
+    memset(&s->dramphy, 0, sizeof(s->dramphy));
+}
+
+static void allwinner_r40_dramc_realize(DeviceState *dev, Error **errp)
+{
+    AwR40DramCtlState *s = AW_R40_DRAMC(dev);
+
+    if (!get_match_ddr(s->ram_size)) {
+        error_report("%s: ram-size %u MiB is not supported",
+                        __func__, s->ram_size);
+        exit(1);
+    }
+
+    /* detect_cells */
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s), 3, s->ram_addr, 10);
+    memory_region_set_enabled(&s->detect_cells, false);
+
+    /*
+     * We only support DRAM size up to 1G now, so prepare a high memory page
+     * after 1G for dualrank detect. index = 4
+     */
+    memory_region_init_io(&s->dram_high, OBJECT(s),
+                            &allwinner_r40_dualrank_detect_ops, s,
+                            "DRAMHIGH", KiB);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->dram_high);
+    sysbus_mmio_map(SYS_BUS_DEVICE(s), 4, s->ram_addr + GiB);
+}
+
+static void allwinner_r40_dramc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwR40DramCtlState *s = AW_R40_DRAMC(obj);
+
+    /* DRAMCOM registers, index 0 */
+    memory_region_init_io(&s->dramcom_iomem, OBJECT(s),
+                          &allwinner_r40_dramcom_ops, s,
+                          "DRAMCOM", 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramcom_iomem);
+
+    /* DRAMCTL registers, index 1 */
+    memory_region_init_io(&s->dramctl_iomem, OBJECT(s),
+                          &allwinner_r40_dramctl_ops, s,
+                          "DRAMCTL", 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramctl_iomem);
+
+    /* DRAMPHY registers. index 2 */
+    memory_region_init_io(&s->dramphy_iomem, OBJECT(s),
+                          &allwinner_r40_dramphy_ops, s,
+                          "DRAMPHY", 4 * KiB);
+    sysbus_init_mmio(sbd, &s->dramphy_iomem);
+
+    /* R40 support max 2G memory but we only support up to 1G now. index 3 */
+    memory_region_init_io(&s->detect_cells, OBJECT(s),
+                          &allwinner_r40_detect_ops, s,
+                          "DRAMCELLS", 1 * GiB);
+    sysbus_init_mmio(sbd, &s->detect_cells);
+}
+
+static Property allwinner_r40_dramc_properties[] = {
+    DEFINE_PROP_UINT64("ram-addr", AwR40DramCtlState, ram_addr, 0x0),
+    DEFINE_PROP_UINT32("ram-size", AwR40DramCtlState, ram_size, 256), /* MiB */
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static const VMStateDescription allwinner_r40_dramc_vmstate = {
+    .name = "allwinner-r40-dramc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(dramcom, AwR40DramCtlState,
+                             AW_R40_DRAMCOM_REGS_NUM),
+        VMSTATE_UINT32_ARRAY(dramctl, AwR40DramCtlState,
+                             AW_R40_DRAMCTL_REGS_NUM),
+        VMSTATE_UINT32_ARRAY(dramphy, AwR40DramCtlState,
+                             AW_R40_DRAMPHY_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_r40_dramc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_r40_dramc_reset;
+    dc->vmsd = &allwinner_r40_dramc_vmstate;
+    dc->realize = allwinner_r40_dramc_realize;
+    device_class_set_props(dc, allwinner_r40_dramc_properties);
+}
+
+static const TypeInfo allwinner_r40_dramc_info = {
+    .name          = TYPE_AW_R40_DRAMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_r40_dramc_init,
+    .instance_size = sizeof(AwR40DramCtlState),
+    .class_init    = allwinner_r40_dramc_class_init,
+};
+
+static void allwinner_r40_dramc_register(void)
+{
+    type_register_static(&allwinner_r40_dramc_info);
+}
+
+type_init(allwinner_r40_dramc_register)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 1db0343333..b04d43e05a 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -45,6 +45,7 @@ softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-dramc.c'))
 softmmu_ss.add(when: 'CONFIG_AXP2XX_PMU', if_true: files('axp2xx.c'))
 softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 24cdec83fe..8b68f07765 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -15,6 +15,20 @@ allwinner_h3_dramctl_write(uint64_t offset, uint64_t data, unsigned size) "Write
 allwinner_h3_dramphy_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_h3_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 
+# allwinner-r40-dramc.c
+allwinner_r40_dramc_detect_cells_disable(void) "Disable detect cells"
+allwinner_r40_dramc_detect_cells_enable(void) "Enable detect cells"
+allwinner_r40_dramc_map_rows(uint8_t row_bits, uint8_t bank_bits, uint8_t col_bits) "DRAM layout: row_bits %d, bank_bits %d, col_bits %d"
+allwinner_r40_dramc_offset_to_cell(uint64_t offset, int row, int bank, int col) "offset 0x%" PRIx64 " row %d bank %d col %d"
+allwinner_r40_dramc_detect_cell_write(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64 ""
+allwinner_r40_dramc_detect_cell_read(uint64_t offset, uint64_t data) "offset 0x%" PRIx64 " data 0x%" PRIx64 ""
+allwinner_r40_dramcom_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_r40_dramcom_write(uint64_t offset, uint64_t data, unsigned size) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_r40_dramctl_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_r40_dramctl_write(uint64_t offset, uint64_t data, unsigned size) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_r40_dramphy_read(uint64_t offset, uint64_t data, unsigned size) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+allwinner_r40_dramphy_write(uint64_t offset, uint64_t data, unsigned size) "write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
+
 # allwinner-sid.c
 allwinner_sid_read(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
 allwinner_sid_write(uint64_t offset, uint64_t data, unsigned size) "offset 0x%" PRIx64 " data 0x%" PRIx64 " size %" PRIu32
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 95366f4eee..8243e8903b 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -26,6 +26,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
+#include "hw/misc/allwinner-r40-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
@@ -54,7 +55,10 @@ enum {
     AW_R40_DEV_GIC_CPU,
     AW_R40_DEV_GIC_HYP,
     AW_R40_DEV_GIC_VCPU,
-    AW_R40_DEV_SDRAM
+    AW_R40_DEV_SDRAM,
+    AW_R40_DEV_DRAMCOM,
+    AW_R40_DEV_DRAMCTL,
+    AW_R40_DEV_DRAMPHY,
 };
 
 #define AW_R40_NUM_CPUS      (4)
@@ -86,11 +90,18 @@ struct AwR40State {
     DeviceState parent_obj;
     /*< public >*/
 
+    /** Physical base address for start of RAM */
+    hwaddr ram_addr;
+
+    /** Total RAM size in megabytes */
+    uint32_t ram_size;
+
     ARMCPU cpus[AW_R40_NUM_CPUS];
     const hwaddr *memmap;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     AwR40ClockCtlState ccu;
+    AwR40DramCtlState dramc;
     AWI2CState i2c0;
     GICState gic;
     MemoryRegion sram_a1;
diff --git a/include/hw/misc/allwinner-r40-dramc.h b/include/hw/misc/allwinner-r40-dramc.h
new file mode 100644
index 0000000000..6a1a3a7893
--- /dev/null
+++ b/include/hw/misc/allwinner-r40-dramc.h
@@ -0,0 +1,108 @@
+/*
+ * Allwinner R40 SDRAM Controller emulation
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
+#ifndef HW_MISC_ALLWINNER_R40_DRAMC_H
+#define HW_MISC_ALLWINNER_R40_DRAMC_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "exec/hwaddr.h"
+
+/**
+ * Constants
+ * @{
+ */
+
+/** Highest register address used by DRAMCOM module */
+#define AW_R40_DRAMCOM_REGS_MAXADDR  (0x804)
+
+/** Total number of known DRAMCOM registers */
+#define AW_R40_DRAMCOM_REGS_NUM      (AW_R40_DRAMCOM_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** Highest register address used by DRAMCTL module */
+#define AW_R40_DRAMCTL_REGS_MAXADDR  (0x88c)
+
+/** Total number of known DRAMCTL registers */
+#define AW_R40_DRAMCTL_REGS_NUM      (AW_R40_DRAMCTL_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** Highest register address used by DRAMPHY module */
+#define AW_R40_DRAMPHY_REGS_MAXADDR  (0x4)
+
+/** Total number of known DRAMPHY registers */
+#define AW_R40_DRAMPHY_REGS_NUM      (AW_R40_DRAMPHY_REGS_MAXADDR / \
+                                     sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * Object model
+ * @{
+ */
+
+#define TYPE_AW_R40_DRAMC "allwinner-r40-dramc"
+OBJECT_DECLARE_SIMPLE_TYPE(AwR40DramCtlState, AW_R40_DRAMC)
+
+/** @} */
+
+/**
+ * Allwinner R40 SDRAM Controller object instance state.
+ */
+struct AwR40DramCtlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Physical base address for start of RAM */
+    hwaddr ram_addr;
+
+    /** Total RAM size in megabytes */
+    uint32_t ram_size;
+
+    uint8_t set_row_bits;
+    uint8_t set_bank_bits;
+    uint8_t set_col_bits;
+
+    /**
+     * @name Memory Regions
+     * @{
+     */
+    MemoryRegion dramcom_iomem;    /**< DRAMCOM module I/O registers */
+    MemoryRegion dramctl_iomem;    /**< DRAMCTL module I/O registers */
+    MemoryRegion dramphy_iomem;    /**< DRAMPHY module I/O registers */
+    MemoryRegion dram_high;        /**< The high 1G dram for dualrank detect */
+    MemoryRegion detect_cells;     /**< DRAM memory cells for auto detect */
+
+    /** @} */
+
+    /**
+     * @name Hardware Registers
+     * @{
+     */
+
+    uint32_t dramcom[AW_R40_DRAMCOM_REGS_NUM]; /**< DRAMCOM registers */
+    uint32_t dramctl[AW_R40_DRAMCTL_REGS_NUM]; /**< DRAMCTL registers */
+    uint32_t dramphy[AW_R40_DRAMPHY_REGS_NUM] ;/**< DRAMPHY registers */
+
+    /** @} */
+
+};
+
+#endif /* HW_MISC_ALLWINNER_R40_DRAMC_H */
-- 
2.25.1


