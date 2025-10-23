Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373BC0062F
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 12:03:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9m-0001cC-U3; Thu, 23 Oct 2025 06:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9k-0001YP-GA; Thu, 23 Oct 2025 06:02:52 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9i-0003D7-HK; Thu, 23 Oct 2025 06:02:52 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:55 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:55 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 13/13] hw/arm/aspeed: Split AST2500 EVB machine into a
 separate source file for maintainability
Date: Thu, 23 Oct 2025 18:01:46 +0800
Message-ID: <20251023100150.295370-14-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
References: <20251023100150.295370-1-jamin_lin@aspeedtech.com>
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

This commit moves the AST2500 EVB machine implementation out of
aspeed.c into a new standalone file aspeed_ast2500_evb.c.

This refactor continues the modularization effort for Aspeed platform
support, placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future
development for new platforms without cluttering aspeed.c.

Key updates include:

- Moved AST2500_EVB_HW_STRAP1 macro definition into the new file.
- Moved ast2500_evb_i2c_init() I²C initialization logic.
- Moved aspeed_machine_ast2500_evb_class_init() and type registration.
- Added aspeed_ast2500_evb.c to the build system (meson.build).
- Removed all AST2500 EVB–specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c             | 45 -------------------------
 hw/arm/aspeed_ast2500_evb.c | 66 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build          |  1 +
 3 files changed, 67 insertions(+), 45 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_evb.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 3618f01ea2..11c74c3e1b 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -70,17 +70,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2400_HW_STRAP_BOOT_MODE(AST2400_SPI_BOOT))
 
-/* AST2500 evb hardware value: 0xF100C2E6 */
-#define AST2500_EVB_HW_STRAP1 ((                                        \
-        AST2500_HW_STRAP1_DEFAULTS |                                    \
-        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
-        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
-        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
-        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
-        SCU_HW_STRAP_MAC1_RGMII |                                       \
-        SCU_HW_STRAP_MAC0_RGMII) &                                      \
-        ~SCU_HW_STRAP_2ND_BOOT_WDT)
-
 /* Quanta-Q71l hardware value */
 #define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
@@ -405,19 +394,6 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
     /* TODO: i2c-8: Add BMC FRU eeprom@50 */
 }
 
-static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
-
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
-                          eeprom_buf);
-
-    /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
-                     TYPE_TMP105, 0x4d);
-}
-
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1176,23 +1152,6 @@ static void aspeed_machine_supermicrox11_bmc_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 }
 
-static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Aspeed AST2500 EVB (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = AST2500_EVB_HW_STRAP1;
-    amc->fmc_model = "mx25l25635e";
-    amc->spi_model = "mx25l25635f";
-    amc->num_cs    = 1;
-    amc->i2c_init  = ast2500_evb_i2c_init;
-    mc->default_ram_size       = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1546,10 +1505,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("ast2500-evb"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_ast2500_evb_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
new file mode 100644
index 0000000000..4646c73e8e
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -0,0 +1,66 @@
+/*
+ * ASPEED AST2500 EVB
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
+#include "hw/sensor/tmp105.h"
+
+/* AST2500 evb hardware value: 0xF100C2E6 */
+#define AST2500_EVB_HW_STRAP1 ((                                        \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_HW_STRAP_MAC1_RGMII |                                       \
+        SCU_HW_STRAP_MAC0_RGMII) &                                      \
+        ~SCU_HW_STRAP_2ND_BOOT_WDT)
+
+static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
+                          eeprom_buf);
+
+    /* The AST2500 EVB expects a LM75 but a TMP105 is compatible */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 7),
+                     TYPE_TMP105, 0x4d);
+}
+
+static void aspeed_machine_ast2500_evb_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Aspeed AST2500 EVB (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = AST2500_EVB_HW_STRAP1;
+    amc->fmc_model = "mx25l25635e";
+    amc->spi_model = "mx25l25635f";
+    amc->num_cs    = 1;
+    amc->i2c_init  = ast2500_evb_i2c_init;
+    mc->default_ram_size       = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_evb_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("ast2500-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2500_evb_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_evb_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index f788baabeb..cbee7ebf60 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -44,6 +44,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed.c',
   'aspeed_soc_common.c',
   'aspeed_ast2400.c',
+  'aspeed_ast2500_evb.c',
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_romulus.c',
-- 
2.43.0


