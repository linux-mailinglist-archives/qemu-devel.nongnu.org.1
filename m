Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B52AC00617
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Oct 2025 12:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBs9Z-0001RA-2G; Thu, 23 Oct 2025 06:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9W-0001QW-3A; Thu, 23 Oct 2025 06:02:38 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vBs9T-00039r-UT; Thu, 23 Oct 2025 06:02:37 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 23 Oct
 2025 18:01:54 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 23 Oct 2025 18:01:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 09/13] hw/arm/aspeed: Split Witherspoon machine into a
 separate source file for maintainability
Date: Thu, 23 Oct 2025 18:01:42 +0800
Message-ID: <20251023100150.295370-10-jamin_lin@aspeedtech.com>
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

This commit moves the Witherspoon BMC machine implementation out of
aspeed.c and into a new dedicated file aspeed_ast2500_witherspoon.c.

To support splitting Witherspoon into a dedicated source file,
a new WITHERSPOON_BMC_HW_STRAP1 macro is added as a copy of
ROMULUS_BMC_HW_STRAP1.

The change is part of a broader effort to modularize Aspeed board
definitions, allowing each machine type to be maintained and updated
independently. By isolating Witherspoon logic, the aspeed.c file
becomes cleaner and easier to manage as more platforms are added.

Key updates include:

- Moved witherspoon_bmc_i2c_init() and related LED setup code into
aspeed_ast2500_witherspoon.c.
- Added WITHERSPOON_BMC_HW_STRAP1 replacement macro for local use.
- Removed aspeed_machine_witherspoon_class_init() and type
registration from aspeed.c.
- Added the new file to meson.build for compilation.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                     |  81 --------------------
 hw/arm/aspeed_ast2500_witherspoon.c | 111 ++++++++++++++++++++++++++++
 hw/arm/meson.build                  |   1 +
 3 files changed, 112 insertions(+), 81 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f890d30d0e..91d59e0d2d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -116,9 +116,6 @@ static struct arm_boot_info aspeed_board_binfo = {
         SCU_HW_STRAP_VGA_SIZE_SET(VGA_16M_DRAM) |                       \
         SCU_AST2500_HW_STRAP_RESERVED1)
 
-/* Witherspoon hardware value: 0xF10AD216 (but use romulus definition) */
-#define WITHERSPOON_BMC_HW_STRAP1 ROMULUS_BMC_HW_STRAP1
-
 /* Quanta-Q71l hardware value */
 #define QUANTA_Q71L_BMC_HW_STRAP1 (                                     \
         SCU_AST2400_HW_STRAP_DRAM_SIZE(DRAM_SIZE_128MB) |               \
@@ -536,63 +533,6 @@ static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 
 }
 
-static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    static const struct {
-        unsigned gpio_id;
-        LEDColor color;
-        const char *description;
-        bool gpio_polarity;
-    } pca1_leds[] = {
-        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
-        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
-        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
-    };
-    AspeedSoCState *soc = bmc->soc;
-    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
-    DeviceState *dev;
-    LEDState *led;
-
-    /* Bus 3: TODO bmp280@77 */
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
-    qdev_prop_set_string(dev, "description", "pca1");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 3),
-                                &error_fatal);
-
-    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
-        led = led_create_simple(OBJECT(bmc),
-                                pca1_leds[i].gpio_polarity,
-                                pca1_leds[i].color,
-                                pca1_leds[i].description);
-        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
-                              qdev_get_gpio_in(DEVICE(led), 0));
-    }
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
-
-    /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
-                     0x4a);
-
-    /*
-     * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
-     * good enough
-     */
-    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
-
-    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
-                          eeprom_buf);
-    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
-    qdev_prop_set_string(dev, "description", "pca0");
-    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
-                                aspeed_i2c_get_bus(&soc->i2c, 11),
-                                &error_fatal);
-    /* Bus 11: TODO ucd90160@64 */
-}
-
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1396,23 +1336,6 @@ static void aspeed_machine_sonorapass_class_init(ObjectClass *oc,
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
-                                                  const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
-    amc->soc_name  = "ast2500-a1";
-    amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
-    amc->fmc_model = "mx25l25635f";
-    amc->spi_model = "mx66l1g45g";
-    amc->num_cs    = 2;
-    amc->i2c_init  = witherspoon_bmc_i2c_init;
-    mc->default_ram_size = 512 * MiB;
-    aspeed_machine_class_init_cpus_defaults(mc);
-};
-
 static void aspeed_machine_ast2600_evb_class_init(ObjectClass *oc,
                                                   const void *data)
 {
@@ -1782,10 +1705,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("sonorapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_sonorapass_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_witherspoon_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
new file mode 100644
index 0000000000..249d63a9dd
--- /dev/null
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -0,0 +1,111 @@
+/*
+ * OpenPOWER Witherspoon
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
+#include "hw/misc/led.h"
+#include "hw/sensor/tmp105.h"
+#include "hw/i2c/smbus_eeprom.h"
+#include "hw/gpio/pca9552.h"
+
+/* Witherspoon hardware value: 0xF10AD216 */
+#define WITHERSPOON_BMC_HW_STRAP1 (                                     \
+        AST2500_HW_STRAP1_DEFAULTS |                                    \
+        SCU_AST2500_HW_STRAP_SPI_AUTOFETCH_ENABLE |                     \
+        SCU_AST2500_HW_STRAP_GPIO_STRAP_ENABLE |                        \
+        SCU_AST2500_HW_STRAP_UART_DEBUG |                               \
+        SCU_AST2500_HW_STRAP_DDR4_ENABLE |                              \
+        SCU_AST2500_HW_STRAP_ACPI_ENABLE |                              \
+        SCU_HW_STRAP_SPI_MODE(SCU_HW_STRAP_SPI_MASTER))
+
+static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    static const struct {
+        unsigned gpio_id;
+        LEDColor color;
+        const char *description;
+        bool gpio_polarity;
+    } pca1_leds[] = {
+        {13, LED_COLOR_GREEN, "front-fault-4",  GPIO_POLARITY_ACTIVE_LOW},
+        {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
+        {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
+    };
+    AspeedSoCState *soc = bmc->soc;
+    uint8_t *eeprom_buf = g_malloc0(8 * 1024);
+    DeviceState *dev;
+    LEDState *led;
+
+    /* Bus 3: TODO bmp280@77 */
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    qdev_prop_set_string(dev, "description", "pca1");
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 3),
+                                &error_fatal);
+
+    for (size_t i = 0; i < ARRAY_SIZE(pca1_leds); i++) {
+        led = led_create_simple(OBJECT(bmc),
+                                pca1_leds[i].gpio_polarity,
+                                pca1_leds[i].color,
+                                pca1_leds[i].description);
+        qdev_connect_gpio_out(dev, pca1_leds[i].gpio_id,
+                              qdev_get_gpio_in(DEVICE(led), 0));
+    }
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "dps310", 0x76);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3), "max31785", 0x52);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 4), "tmp423", 0x4c);
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 5), "tmp423", 0x4c);
+
+    /* The Witherspoon expects a TMP275 but a TMP105 is compatible */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 9), TYPE_TMP105,
+                     0x4a);
+
+    /*
+     * The witherspoon board expects Epson RX8900 I2C RTC but a ds1338 is
+     * good enough
+     */
+    i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 11), "ds1338", 0x32);
+
+    smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 11), 0x51,
+                          eeprom_buf);
+    dev = DEVICE(i2c_slave_new(TYPE_PCA9552, 0x60));
+    qdev_prop_set_string(dev, "description", "pca0");
+    i2c_slave_realize_and_unref(I2C_SLAVE(dev),
+                                aspeed_i2c_get_bus(&soc->i2c, 11),
+                                &error_fatal);
+    /* Bus 11: TODO ucd90160@64 */
+}
+
+static void aspeed_machine_witherspoon_class_init(ObjectClass *oc,
+                                                  const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "OpenPOWER Witherspoon BMC (ARM1176)";
+    amc->soc_name  = "ast2500-a1";
+    amc->hw_strap1 = WITHERSPOON_BMC_HW_STRAP1;
+    amc->fmc_model = "mx25l25635f";
+    amc->spi_model = "mx66l1g45g";
+    amc->num_cs    = 2;
+    amc->i2c_init  = witherspoon_bmc_i2c_init;
+    mc->default_ram_size = 512 * MiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+};
+
+static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_witherspoon_class_init,
+    }
+};
+
+DEFINE_TYPES(aspeed_ast2500_witherspoon_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d07ebc9dd7..d3726d1b9d 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -47,6 +47,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_fp5280g2.c',
   'aspeed_ast2500_g220a.c',
   'aspeed_ast2500_tiogapass.c',
+  'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
-- 
2.43.0


