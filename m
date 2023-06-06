Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D35723E51
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIy-0007ol-30; Tue, 06 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIg-0007b7-L3
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TId-0004jx-J9
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:26 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so49893325e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044901; x=1688636901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MWPb7Jy8+7x5gkTFAiffz5QOK3pkVlOOxFo23ysfWJQ=;
 b=ECjYyG9OqgO7B3GzhNRzi8X4+vJVO39e033JSJF6eaFuVzeUhkQtF/0HG8ppD48qHV
 SU8YdEWkwVp9cwyeiXwXFyRX3s7cgiT7wuNZcrdz8MM/CA13WHb3Zj4LeyAvXP1utcJl
 5B1ro3u5f5XIbTTIqQoh6jeKX9omrxbaJgPw58uopr4jSCUZencuaQmuA+cdf1ixMlzJ
 WmetxfKAtkwLM3JmudanYFA/hwREoE2n6cQjVLsq6BJpf18QBbOVKc9MEe8GlEkis+8f
 HkS+WdOWL5UUTr7t4BHwXgkLAULjCMJ5E6Cy2JZ0KluZ2ISWBwb2Gb8T+tqPs9EjqEd+
 sTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044901; x=1688636901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWPb7Jy8+7x5gkTFAiffz5QOK3pkVlOOxFo23ysfWJQ=;
 b=DvRRI8aLm530ROldGmUHCwNB6EpIAbi+qi+Kx/h2VmarhkLoojlqsT4W7DOyV73/kY
 WvGZnpZ4+N2MTts7MuAXwtVtHbrwUVKS1ys0h8w08L0eI85PJ1A66KtK/G7c9/kXaemF
 +ex0kVGMSCTFCUaAYu1f42EkBrdQ4kOteidMKsxyW6ZT6dVpnbRLTf8X3dzLOaSFXvUP
 ugx1MmmLtq7adPWVT8EFgP1Qi9z3qSoxlio99z5+urh6QwVJ8QRZA7D3EM4Atd39jK7C
 F3d+XZft0uXvzjGblfCKaRc5fPgAoChuPnpNXzs0LtUgBiVNsP7zJel+mWC006QVT0Jr
 jjnA==
X-Gm-Message-State: AC+VfDw8mQTZh0UnW/HxwZ5Ec3qIMLvnMcxwMr2V6pVLGzlr7UsmI75O
 jEoIoTdGhCch0PM0p+CWj6f9q2WCE42bYZnO+Ps=
X-Google-Smtp-Source: ACHHUZ4jjvQ4OQ11fmRkiPciCugDyX4S5GbQNxlSVICJ/6fG1EXY3RXq5Ul5aFGYUTr/sribaL1vtA==
X-Received: by 2002:a05:600c:46c7:b0:3f7:16dd:1c3b with SMTP id
 q7-20020a05600c46c700b003f716dd1c3bmr10321002wmo.10.1686044901131; 
 Tue, 06 Jun 2023 02:48:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/42] hw/arm/allwinner-r40: add Clock Control Unit
Date: Tue,  6 Jun 2023 10:47:42 +0100
Message-Id: <20230606094814.3581397-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The CCU provides the registers to program the PLLs and the controls
most of the clock generation, division, distribution, synchronization
and gating.

This commit adds support for the Clock Control Unit which emulates
a simple read/write register interface.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-r40.h      |   2 +
 include/hw/misc/allwinner-r40-ccu.h |  65 +++++++++
 hw/arm/allwinner-r40.c              |   8 +-
 hw/misc/allwinner-r40-ccu.c         | 209 ++++++++++++++++++++++++++++
 hw/misc/meson.build                 |   1 +
 5 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/allwinner-r40-ccu.h
 create mode 100644 hw/misc/allwinner-r40-ccu.c

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 348bf25d6be..3be9dc962be 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -25,6 +25,7 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
+#include "hw/misc/allwinner-r40-ccu.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -79,6 +80,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
+    AwR40ClockCtlState ccu;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/include/hw/misc/allwinner-r40-ccu.h b/include/hw/misc/allwinner-r40-ccu.h
new file mode 100644
index 00000000000..ceb74eff923
--- /dev/null
+++ b/include/hw/misc/allwinner-r40-ccu.h
@@ -0,0 +1,65 @@
+/*
+ * Allwinner R40 Clock Control Unit emulation
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
+#ifndef HW_MISC_ALLWINNER_R40_CCU_H
+#define HW_MISC_ALLWINNER_R40_CCU_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by CCU device */
+#define AW_R40_CCU_IOSIZE        (0x400)
+
+/** Total number of known registers */
+#define AW_R40_CCU_REGS_NUM      (AW_R40_CCU_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_R40_CCU    "allwinner-r40-ccu"
+OBJECT_DECLARE_SIMPLE_TYPE(AwR40ClockCtlState, AW_R40_CCU)
+
+/** @} */
+
+/**
+ * Allwinner R40 CCU object instance state.
+ */
+struct AwR40ClockCtlState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_R40_CCU_REGS_NUM];
+
+};
+
+#endif /* HW_MISC_ALLWINNER_R40_CCU_H */
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 97f2aa92fdf..72973f69ff0 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -42,6 +42,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
     [AW_R40_DEV_UART0]      = 0x01c28000,
     [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
@@ -80,7 +81,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "usb2-host",  0x01c1c000, 4 * KiB },
     { "cs1",        0x01c1d000, 4 * KiB },
     { "spi3",       0x01c1f000, 4 * KiB },
-    { "ccu",        0x01c20000, 1 * KiB },
     { "rtc",        0x01c20400, 1 * KiB },
     { "pio",        0x01c20800, 1 * KiB },
     { "owa",        0x01c21000, 1 * KiB },
@@ -250,6 +250,8 @@ static void allwinner_r40_init(Object *obj)
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq");
 
+    object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
+
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         object_initialize_child(obj, mmc_names[i], &s->mmc[i],
                                 TYPE_AW_SDHOST_SUN5I);
@@ -364,6 +366,10 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
                                 s->memmap[AW_R40_DEV_SRAM_A4], &s->sram_a4);
 
+    /* Clock Control Unit */
+    sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
+
     /* SD/MMC */
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->gic),
diff --git a/hw/misc/allwinner-r40-ccu.c b/hw/misc/allwinner-r40-ccu.c
new file mode 100644
index 00000000000..d82fee12db6
--- /dev/null
+++ b/hw/misc/allwinner-r40-ccu.c
@@ -0,0 +1,209 @@
+/*
+ * Allwinner R40 Clock Control Unit emulation
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
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/allwinner-r40-ccu.h"
+
+/* CCU register offsets */
+enum {
+    REG_PLL_CPUX_CTRL           = 0x0000,
+    REG_PLL_AUDIO_CTRL          = 0x0008,
+    REG_PLL_VIDEO0_CTRL         = 0x0010,
+    REG_PLL_VE_CTRL             = 0x0018,
+    REG_PLL_DDR0_CTRL           = 0x0020,
+    REG_PLL_PERIPH0_CTRL        = 0x0028,
+    REG_PLL_PERIPH1_CTRL        = 0x002c,
+    REG_PLL_VIDEO1_CTRL         = 0x0030,
+    REG_PLL_SATA_CTRL           = 0x0034,
+    REG_PLL_GPU_CTRL            = 0x0038,
+    REG_PLL_MIPI_CTRL           = 0x0040,
+    REG_PLL_DE_CTRL             = 0x0048,
+    REG_PLL_DDR1_CTRL           = 0x004c,
+    REG_AHB1_APB1_CFG           = 0x0054,
+    REG_APB2_CFG                = 0x0058,
+    REG_MMC0_CLK                = 0x0088,
+    REG_MMC1_CLK                = 0x008c,
+    REG_MMC2_CLK                = 0x0090,
+    REG_MMC3_CLK                = 0x0094,
+    REG_USBPHY_CFG              = 0x00cc,
+    REG_PLL_DDR_AUX             = 0x00f0,
+    REG_DRAM_CFG                = 0x00f4,
+    REG_PLL_DDR1_CFG            = 0x00f8,
+    REG_DRAM_CLK_GATING         = 0x0100,
+    REG_GMAC_CLK                = 0x0164,
+    REG_SYS_32K_CLK             = 0x0310,
+    REG_PLL_LOCK_CTRL           = 0x0320,
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* CCU register flags */
+enum {
+    REG_PLL_ENABLE           = (1 << 31),
+    REG_PLL_LOCK             = (1 << 28),
+};
+
+static uint64_t allwinner_r40_ccu_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    const AwR40ClockCtlState *s = AW_R40_CCU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case 0x324 ... AW_R40_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_r40_ccu_write(void *opaque, hwaddr offset,
+                                    uint64_t val, unsigned size)
+{
+    AwR40ClockCtlState *s = AW_R40_CCU(opaque);
+
+    switch (offset) {
+    case REG_DRAM_CFG:    /* DRAM Configuration(for DDR0) */
+        /* bit16: SDRCLK_UPD (SDRCLK configuration 0 update) */
+        val &= ~(1 << 16);
+        break;
+    case REG_PLL_DDR1_CTRL: /* DDR1 Control register */
+        /* bit30: SDRPLL_UPD */
+        val &= ~(1 << 30);
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    case REG_PLL_CPUX_CTRL:
+    case REG_PLL_AUDIO_CTRL:
+    case REG_PLL_VE_CTRL:
+    case REG_PLL_VIDEO0_CTRL:
+    case REG_PLL_DDR0_CTRL:
+    case REG_PLL_PERIPH0_CTRL:
+    case REG_PLL_PERIPH1_CTRL:
+    case REG_PLL_VIDEO1_CTRL:
+    case REG_PLL_SATA_CTRL:
+    case REG_PLL_GPU_CTRL:
+    case REG_PLL_MIPI_CTRL:
+    case REG_PLL_DE_CTRL:
+        if (val & REG_PLL_ENABLE) {
+            val |= REG_PLL_LOCK;
+        }
+        break;
+    case 0x324 ... AW_R40_CCU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+
+    s->regs[REG_INDEX(offset)] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_r40_ccu_ops = {
+    .read = allwinner_r40_ccu_read,
+    .write = allwinner_r40_ccu_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_r40_ccu_reset(DeviceState *dev)
+{
+    AwR40ClockCtlState *s = AW_R40_CCU(dev);
+
+    memset(s->regs, 0, sizeof(s->regs));
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_PLL_CPUX_CTRL)]       = 0x00001000;
+    s->regs[REG_INDEX(REG_PLL_AUDIO_CTRL)]      = 0x00035514;
+    s->regs[REG_INDEX(REG_PLL_VIDEO0_CTRL)]     = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_VE_CTRL)]         = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_DDR0_CTRL)]       = 0x00001000,
+    s->regs[REG_INDEX(REG_PLL_PERIPH0_CTRL)]    = 0x00041811;
+    s->regs[REG_INDEX(REG_PLL_PERIPH1_CTRL)]    = 0x00041811;
+    s->regs[REG_INDEX(REG_PLL_VIDEO1_CTRL)]     = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_SATA_CTRL)]       = 0x00001811;
+    s->regs[REG_INDEX(REG_PLL_GPU_CTRL)]        = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_MIPI_CTRL)]       = 0x00000515;
+    s->regs[REG_INDEX(REG_PLL_DE_CTRL)]         = 0x03006207;
+    s->regs[REG_INDEX(REG_PLL_DDR1_CTRL)]       = 0x00001800;
+    s->regs[REG_INDEX(REG_AHB1_APB1_CFG)]       = 0x00001010;
+    s->regs[REG_INDEX(REG_APB2_CFG)]            = 0x01000000;
+    s->regs[REG_INDEX(REG_PLL_DDR_AUX)]         = 0x00000001;
+    s->regs[REG_INDEX(REG_PLL_DDR1_CFG)]        = 0x0ccca000;
+    s->regs[REG_INDEX(REG_SYS_32K_CLK)]         = 0x0000000f;
+}
+
+static void allwinner_r40_ccu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwR40ClockCtlState *s = AW_R40_CCU(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_r40_ccu_ops, s,
+                          TYPE_AW_R40_CCU, AW_R40_CCU_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_r40_ccu_vmstate = {
+    .name = "allwinner-r40-ccu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwR40ClockCtlState, AW_R40_CCU_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_r40_ccu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->reset = allwinner_r40_ccu_reset;
+    dc->vmsd = &allwinner_r40_ccu_vmstate;
+}
+
+static const TypeInfo allwinner_r40_ccu_info = {
+    .name          = TYPE_AW_R40_CCU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_r40_ccu_init,
+    .instance_size = sizeof(AwR40ClockCtlState),
+    .class_init    = allwinner_r40_ccu_class_init,
+};
+
+static void allwinner_r40_ccu_register(void)
+{
+    type_register_static(&allwinner_r40_ccu_info);
+}
+
+type_init(allwinner_r40_ccu_register)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a40245ad44f..96e35f1cdbc 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -44,6 +44,7 @@ specific_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-cpucfg.c'
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-dramc.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3-sysctrl.c'))
 softmmu_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sid.c'))
+softmmu_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40-ccu.c'))
 softmmu_ss.add(when: 'CONFIG_AXP209_PMU', if_true: files('axp209.c'))
 softmmu_ss.add(when: 'CONFIG_REALVIEW', if_true: files('arm_sysctl.c'))
 softmmu_ss.add(when: 'CONFIG_NSERIES', if_true: files('cbus.c'))
-- 
2.34.1


