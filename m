Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B005BC00647
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 12:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9O-0001N6-Nb; Thu, 23 Oct 2025 06:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9K-0001LN-4N; Thu, 23 Oct 2025 06:02:27 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9I-00039r-7c; Thu, 23 Oct 2025 06:02:25 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:53 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:53 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 06/13] hw/arm/aspeed: Split G220A machine into a separate
 source file for better maintenance
Date: Thu, 23 Oct 2025 18:01:39 +0800
Message-ID: <20251023100150.295370-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

This commit refactors the Bytedance G220A BMC machine by moving its
implementation from aspeed.c into a new dedicated file
aspeed_ast2500_g220a.c.

The goal is to improve modularity and maintainability of Aspeed
machine definitions by isolating each platform into its own source
file. This aligns with ongoing efforts to simplify aspeed.c,
which previously contained all machine configurations.

Key updates include:

- Moved G220A_BMC_HW_STRAP1 definition and
g220a_bmc_i2c_init() function into aspeed_ast2500_g220a.c.
- Moved aspeed_machine_g220a_class_init() and related type
registration to the new file.
- Added the new file to the build system (meson.build).
- Removed all G220A-specific code from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c               | 71 ---------------------------
 hw/arm/aspeed_ast2500_g220a.c | 91 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |  1 +
 3 files changed, 92 insertions(+), 71 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_g220a.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 48c3d73e73..dbeb751275 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -116,20 +116,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2500_HW_STRAP_RESERVED1)
 
-#define G220A_BMC_HW_STRAP1 (                                      \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_2ND_BOOT_WDT |                                     \
-        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
-        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
-        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
-        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
-        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
-        SCU_AST2500_HW_STRAP_RESERVED1)
-
 /* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
 #define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
 
@@ -634,42 +620,6 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
     /* Bus 11: TODO ucd90160@64 */
 }
 
-static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    DeviceState *dev;
-
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
-                                         "emc1413", 0x4c));
-    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
-
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
-                                         "emc1413", 0x4c));
-    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
-
-    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
-                                         "emc1413", 0x4c));
-    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
-    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
-
-    static uint8_t eeprom_buf[2 * 1024] = {
-            0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0xfe,
-            0x01, 0x06, 0x00, 0xc9, 0x42, 0x79, 0x74, 0x65,
-            0x64, 0x61, 0x6e, 0x63, 0x65, 0xc5, 0x47, 0x32,
-            0x32, 0x30, 0x41, 0xc4, 0x41, 0x41, 0x42, 0x42,
-            0xc4, 0x43, 0x43, 0x44, 0x44, 0xc4, 0x45, 0x45,
-            0x46, 0x46, 0xc4, 0x48, 0x48, 0x47, 0x47, 0xc1,
-            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa7,
-    };
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x57,
-                          eeprom_buf);
-}
-
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1548,23 +1498,6 @@ static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
     aspeed_machine_ast2600_class_emmc_init(oc);
 };
 
-static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Bytedance G220A BMC (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = G220A_BMC_HW_STRAP1;
-    amc->fmc_model = "n25q512a";
-    amc->spi_model = "mx25l25635e";
-    amc->num_cs    = 2;
-    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
-    amc->i2c_init  = g220a_bmc_i2c_init;
-    mc->default_ram_size = 1024 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_rainier_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1928,10 +1861,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("g220a-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_g220a_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("qcom-dc-scm-v1-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
new file mode 100644
index 0000000000..d9cc0ca018
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -0,0 +1,91 @@
+/*
+ * Bytedance G220A
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
+#define G220A_BMC_HW_STRAP1 (                                      \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_RESERVED28 |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_2ND_BOOT_WDT |                                     \
+        SCU_HW_STRAP_VGA_CLASS_CODE |                                   \
+        SCU_HW_STRAP_LPC_RESET_PIN |                                    \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER) |                \
+        SCU_AST2500_HW_STRAP_SET_AXI_AHB_RATIO(AXI_AHB_RATIO_2_1) |     \
+        SCU_HW_STRAP_VGA_SIZE_SET(VGA_64M_DRAM) |                       \
+        SCU_AST2500_HW_STRAP_RESERVED1)
+
+static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    DeviceState *dev;
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 12),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+
+    dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 13),
+                                         "emc1413", 0x4c));
+    object_property_set_int(OBJECT(dev), "temperature0", 31000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature1", 28000, &error_abort);
+    object_property_set_int(OBJECT(dev), "temperature2", 20000, &error_abort);
+
+    static uint8_t eeprom_buf[2 * 1024] = {
+            0x01, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0xfe,
+            0x01, 0x06, 0x00, 0xc9, 0x42, 0x79, 0x74, 0x65,
+            0x64, 0x61, 0x6e, 0x63, 0x65, 0xc5, 0x47, 0x32,
+            0x32, 0x30, 0x41, 0xc4, 0x41, 0x41, 0x42, 0x42,
+            0xc4, 0x43, 0x43, 0x44, 0x44, 0xc4, 0x45, 0x45,
+            0x46, 0x46, 0xc4, 0x48, 0x48, 0x47, 0x47, 0xc1,
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xa7,
+    };
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 4), 0x57,
+                          eeprom_buf);
+}
+
+static void aspeed_machine_g220a_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Bytedance G220A BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = G220A_BMC_HW_STRAP1;
+    amc->fmc_model = "n25q512a";
+    amc->spi_model = "mx25l25635e";
+    amc->num_cs    = 2;
+    amc->macs_mask  = ASPEED_MAC0_ON | ASPEED_MAC1_ON;
+    amc->i2c_init  = g220a_bmc_i2c_init;
+    mc->default_ram_size = 1024 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_g220a_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("g220a-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_g220a_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_g220a_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 55513db65b..a8539ff51e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -45,6 +45,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
   'aspeed_ast2500_fp5280g2.c',
+  'aspeed_ast2500_g220a.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
-- 
2.43.0


