Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C39FC131F2
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Oct 2025 07:24:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDd7f-00077v-Lx; Tue, 28 Oct 2025 02:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd7L-0006XX-6Y; Tue, 28 Oct 2025 02:23:41 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDd7I-0000XI-6s; Tue, 28 Oct 2025 02:23:38 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 28 Oct
 2025 14:23:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 28 Oct 2025 14:23:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v1 04/16] hw/arm/aspeed: Split Bletchley machine into a
 separate source file for maintainability
Date: Tue, 28 Oct 2025 14:22:48 +0800
Message-ID: <20251028062307.2410346-5-jamin_lin@aspeedtech.com>
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

This commit moves the Facebook Bletchley BMC machine implementation out of
aspeed.c into a new standalone file aspeed_ast2600_bletchley.c.

This refactor continues the modularization effort for Aspeed platform support,
placing each board’s logic in its own dedicated source file.
It improves maintainability, readability, and simplifies future development for
new platforms without cluttering aspeed.c.

Key updates include:
- Removed BLETCHLEY_BMC_HW_STRAP1 and BLETCHLEY_BMC_HW_STRAP2 macro definitions from aspeed.c.
- Moved bletchley_bmc_i2c_init() I²C initialization logic into the new file.
- Moved aspeed_machine_bletchley_class_init() and type registration.
- Added aspeed_ast2600_bletchley.c to the build system (meson.build).
- Removed all Bletchley-specific code and macros from aspeed.c.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c                   | 76 -------------------------
 hw/arm/aspeed_ast2600_bletchley.c | 95 +++++++++++++++++++++++++++++++
 hw/arm/meson.build                |  1 +
 3 files changed, 96 insertions(+), 76 deletions(-)
 create mode 100644 hw/arm/aspeed_ast2600_bletchley.c

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f58245456a..80449131d8 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -62,10 +62,6 @@ static struct arm_boot_info aspeed_board_binfo = {
 #define FUJI_BMC_HW_STRAP1    0x00000000
 #define FUJI_BMC_HW_STRAP2    0x00000000
 
-/* Bletchley hardware value */
-#define BLETCHLEY_BMC_HW_STRAP1 0x00002000
-#define BLETCHLEY_BMC_HW_STRAP2 0x00000801
-
 /* GB200NVL hardware value */
 #define GB200NVL_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
 #define GB200NVL_BMC_HW_STRAP2 AST2600_EVB_HW_STRAP2
@@ -691,53 +687,6 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     at24c_eeprom_init(i2c[15], 0x52, 8 * KiB);
 }
 
-static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
-{
-    AspeedSoCState *soc = bmc->soc;
-    I2CBus *i2c[13] = {};
-    for (int i = 0; i < 13; i++) {
-        if ((i == 8) || (i == 11)) {
-            continue;
-        }
-        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
-    }
-
-    /* Bus 0 - 5 all have the same config. */
-    for (int i = 0; i < 6; i++) {
-        /* Missing model: ti,ina230 @ 0x45 */
-        /* Missing model: mps,mp5023 @ 0x40 */
-        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
-        /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
-        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
-        /* Missing model: fsc,fusb302 @ 0x22 */
-    }
-
-    /* Bus 6 */
-    at24c_eeprom_init(i2c[6], 0x56, 65536);
-    /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
-    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
-
-
-    /* Bus 7 */
-    at24c_eeprom_init(i2c[7], 0x54, 65536);
-
-    /* Bus 9 */
-    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
-
-    /* Bus 10 */
-    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
-    /* Missing model: ti,hdc1080 @ 0x40 */
-    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
-
-    /* Bus 12 */
-    /* Missing model: adi,adm1278 @ 0x11 */
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
-    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
-    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
-}
-
-
 static void gb200nvl_bmc_i2c_init(AspeedMachineState *bmc)
 {
     AspeedSoCState *soc = bmc->soc;
@@ -1065,27 +1014,6 @@ static void aspeed_machine_fuji_class_init(ObjectClass *oc, const void *data)
     aspeed_machine_class_init_cpus_defaults(mc);
 };
 
-#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
-
-static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
-                                                const void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
-
-    mc->desc       = "Facebook Bletchley BMC (Cortex-A7)";
-    amc->soc_name  = "ast2600-a3";
-    amc->hw_strap1 = BLETCHLEY_BMC_HW_STRAP1;
-    amc->hw_strap2 = BLETCHLEY_BMC_HW_STRAP2;
-    amc->fmc_model = "w25q01jvq";
-    amc->spi_model = NULL;
-    amc->num_cs    = 2;
-    amc->macs_mask = ASPEED_MAC2_ON;
-    amc->i2c_init  = bletchley_bmc_i2c_init;
-    mc->default_ram_size = BLETCHLEY_BMC_RAM_SIZE;
-    aspeed_machine_class_init_cpus_defaults(mc);
-}
-
 static void aspeed_machine_catalina_class_init(ObjectClass *oc,
                                                const void *data)
 {
@@ -1368,10 +1296,6 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
-    }, {
-        .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
-        .parent        = TYPE_ASPEED_MACHINE,
-        .class_init    = aspeed_machine_bletchley_class_init,
     }, {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
new file mode 100644
index 0000000000..5b7993bf6f
--- /dev/null
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -0,0 +1,95 @@
+/*
+ * Facebook Bletchley
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
+#include "hw/gpio/pca9552.h"
+#include "hw/nvram/eeprom_at24c.h"
+
+#define TYPE_TMP421 "tmp421"
+/* Bletchley hardware value */
+#define BLETCHLEY_BMC_HW_STRAP1 0x00002000
+#define BLETCHLEY_BMC_HW_STRAP2 0x00000801
+
+static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
+{
+    AspeedSoCState *soc = bmc->soc;
+    I2CBus *i2c[13] = {};
+    for (int i = 0; i < 13; i++) {
+        if ((i == 8) || (i == 11)) {
+            continue;
+        }
+        i2c[i] = aspeed_i2c_get_bus(&soc->i2c, i);
+    }
+
+    /* Bus 0 - 5 all have the same config. */
+    for (int i = 0; i < 6; i++) {
+        /* Missing model: ti,ina230 @ 0x45 */
+        /* Missing model: mps,mp5023 @ 0x40 */
+        i2c_slave_create_simple(i2c[i], TYPE_TMP421, 0x4f);
+        /* Missing model: nxp,pca9539 @ 0x76, but PCA9552 works enough */
+        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x76);
+        i2c_slave_create_simple(i2c[i], TYPE_PCA9552, 0x67);
+        /* Missing model: fsc,fusb302 @ 0x22 */
+    }
+
+    /* Bus 6 */
+    at24c_eeprom_init(i2c[6], 0x56, 65536);
+    /* Missing model: nxp,pcf85263 @ 0x51 , but ds1338 works enough */
+    i2c_slave_create_simple(i2c[6], "ds1338", 0x51);
+
+
+    /* Bus 7 */
+    at24c_eeprom_init(i2c[7], 0x54, 65536);
+
+    /* Bus 9 */
+    i2c_slave_create_simple(i2c[9], TYPE_TMP421, 0x4f);
+
+    /* Bus 10 */
+    i2c_slave_create_simple(i2c[10], TYPE_TMP421, 0x4f);
+    /* Missing model: ti,hdc1080 @ 0x40 */
+    i2c_slave_create_simple(i2c[10], TYPE_PCA9552, 0x67);
+
+    /* Bus 12 */
+    /* Missing model: adi,adm1278 @ 0x11 */
+    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4c);
+    i2c_slave_create_simple(i2c[12], TYPE_TMP421, 0x4d);
+    i2c_slave_create_simple(i2c[12], TYPE_PCA9552, 0x67);
+}
+
+static void aspeed_machine_bletchley_class_init(ObjectClass *oc,
+                                                const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc       = "Facebook Bletchley BMC (Cortex-A7)";
+    amc->soc_name  = "ast2600-a3";
+    amc->hw_strap1 = BLETCHLEY_BMC_HW_STRAP1;
+    amc->hw_strap2 = BLETCHLEY_BMC_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = NULL;
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC2_ON;
+    amc->i2c_init  = bletchley_bmc_i2c_init;
+    mc->default_ram_size = 2 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
+static const TypeInfo aspeed_ast2600_bletchley_types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_bletchley_class_init,
+    },
+};
+
+DEFINE_TYPES(aspeed_ast2600_bletchley_types)
+
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 293dbbb53b..06e27d94b9 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -57,6 +57,7 @@ arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_ast2500_witherspoon.c',
   'aspeed_ast2500_yosemitev2.c',
   'aspeed_ast2600.c',
+  'aspeed_ast2600_bletchley.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
   'fby35.c'))
-- 
2.43.0


