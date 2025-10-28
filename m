Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D2C131EF
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 07:24:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd7b-0006iQ-4a; Tue, 28 Oct 2025 02:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd7D-0006Td-NK; Tue, 28 Oct 2025 02:23:32 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd7B-0000XI-DQ; Tue, 28 Oct 2025 02:23:31 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 14:23:09 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 14:23:09 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 02/16] hw/arm/aspeed: Split Supermicro X11 machine into a
 separate source file for maintainability
Date: Tue, 28 Oct 2025 14:22:46 +0800
Message-ID: <20251028062307.2410346-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028062307.2410346-1-jamin_lin@aspeedtech.com>
References: <20251028062307.2410346-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This commit moves the Supermicro X11 BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2400_supermicrox11.c and
removes its dependency on the Palmetto platform’s I²C initialization.

This refactor continues the modularization effort for Aspeed platform support,
ensuring that each board’s configuration resides in its own dedicated source file.
By duplicating and renaming the palmetto_bmc_i2c_init() logic into
supermicrox11_bmc_i2c_init(), this change removes unwanted coupling between
the two board definitions.

Key updates include:
- Removed SUPERMICROX11_BMC_HW_STRAP1 macro definition from aspeed.c.
- Moved aspeed_machine_supermicrox11_bmc_class_init() and type registration into a new file.
- Added a dedicated supermicrox11_bmc_i2c_init() function (copied and renamed from Palmetto’s version).
- Added the new file aspeed_ast2400_supermicrox11.c to the build system (meson.build).
- Removed all Supermicro X11–specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                       | 36 ------------
 hw/arm/aspeed_ast2400_supermicrox11.c | 80 +++++++++++++++++++++++++++
 hw/arm/meson.build                    |  1 +
 3 files changed, 81 insertions(+), 36 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3eb1d19373..f6e9d5cda1 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -56,20 +56,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
-/* TODO: Find the actual hardware value */
-#define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
-        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
-        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           \
-        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
-        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
-        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
-        SCU_HW_STRAP_SPI_WIDTH |                                        \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
-        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
@@ -1072,24 +1058,6 @@ static void aspeed_machine_palmetto_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
-                                                        const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Supermicro X11 BMC (ARM926EJ-S)";
-    amc->soc_name  = "ast2400-a1";
-    amc->hw_strap1 = SUPERMICROX11_BMC_HW_STRAP1;
-    amc->fmc_model = "mx25l25635e";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 1;
-    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
-    amc->i2c_init  = palmetto_bmc_i2c_init;
-    mc->default_ram_size = 256 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1439,10 +1407,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
new file mode 100644
index 0000000000..168a3251f0
--- /dev/null
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -0,0 +1,80 @@
+/*
+ * Supermicro X11
+ *
+ * Copyright (C) 2025 ASPEED Technology Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/arm/aspeed.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/i2c/smbus_eeprom.h"
+
+/* TODO: Find the actual hardware value */
+#define SUPERMICROX11_BMC_HW_STRAP1 (                                   \
+        SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
+        SCU_AST2400_HW_STRAP_DRAM_CONFIG(2) |                           \
+        SCU_AST2400_HW_STRAP_ACPI_DIS |                                 \
+        SCU_AST2400_HW_STRAP_SET_CLK_SOURCE(AST2400_CLK_48M_IN) |       \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_M_S_EN) |                \
+        SCU_AST2400_HW_STRAP_SET_CPU_AHB_RATIO(AST2400_CPU_AHB_RATIO_2_1) | \
+        SCU_HW_STRAP_SPI_WIDTH |                                        \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
+        SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
+
+static void supermicrox11_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    DeviceState *dev;
+    uint8_t *eeprom_buf = g_malloc0(32 * 1024);
+
+    /*
+     * The palmetto platform expects a ds3231 RTC but a ds1338 is
+     * enough to provide basic RTC features. Alarms will be missing
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 0), "ds1338", 0x68);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 0), 0x50,
+                          eeprom_buf);
+
+    /* add a TMP423 temperature sensor */
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2),
+                                         "tmp423", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature3", 110000, &error_abort);
+}
+
+static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
+                                                        const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Supermicro X11 BMC (ARM926EJ-S)";
+    amc->soc_name  = "ast2400-a1";
+    amc->hw_strap1 = SUPERMICROX11_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635e";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 1;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = supermicrox11_bmc_i2c_init;
+    mc->default_ram_size = 256 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2400_supermicrox11_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_ast2400_supermicrox11_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4475807e11..9411e27d78 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -45,6 +45,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2400_quanta-q71l.c',
+  'aspeed_ast2400_supermicrox11.c',
   'aspeed_ast2500_evb.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
-- 
2.43.0


