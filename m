Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A580F76D933
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 23:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRJ59-00041b-Ss; Wed, 02 Aug 2023 17:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qRJ57-0003zm-Bf; Wed, 02 Aug 2023 17:08:33 -0400
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcd@tribudubois.net>)
 id 1qRJ54-0007Oh-Iz; Wed, 02 Aug 2023 17:08:33 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2420FFF806;
 Wed,  2 Aug 2023 21:08:27 +0000 (UTC)
From: Jean-Christophe Dubois <jcd@tribudubois.net>
To: qemu-arm@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] Refactor i.MX7 processor code
Date: Wed,  2 Aug 2023 23:08:06 +0200
Message-Id: <011393f8c5be2d382955dceb7bc5d78a77b99c31.1691010283.git.jcd@tribudubois.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1691010283.git.jcd@tribudubois.net>
References: <cover.1691010283.git.jcd@tribudubois.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: jcd@tribudubois.net
Received-SPF: pass client-ip=2001:4b98:dc4:8::229;
 envelope-from=jcd@tribudubois.net; helo=relay9-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

* Add Addr and size definition for all i.MX7 devices in i.MX7 header file.
* Use those newly defined named constants whenever possible.
* Standardize the way we init a familly of unimplemented devices
  - SAI
  - PWM
  - CAN
* Add/rework few comments

Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
---
 hw/arm/fsl-imx7.c         | 134 ++++++++++-----
 include/hw/arm/fsl-imx7.h | 340 ++++++++++++++++++++++++++++----------
 2 files changed, 350 insertions(+), 124 deletions(-)

diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 9e41d4b677..3bb0da6850 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -36,6 +36,9 @@ static void fsl_imx7_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
+    /*
+     * CPUs
+     */
     for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
         snprintf(name, NAME_SIZE, "cpu%d", i);
         object_initialize_child(obj, name, &s->cpu[i],
@@ -49,7 +52,7 @@ static void fsl_imx7_init(Object *obj)
                             TYPE_A15MPCORE_PRIV);
 
     /*
-     * GPIOs 1 to 7
+     * GPIOs
      */
     for (i = 0; i < FSL_IMX7_NUM_GPIOS; i++) {
         snprintf(name, NAME_SIZE, "gpio%d", i);
@@ -57,7 +60,7 @@ static void fsl_imx7_init(Object *obj)
     }
 
     /*
-     * GPT1, 2, 3, 4
+     * GPTs
      */
     for (i = 0; i < FSL_IMX7_NUM_GPTS; i++) {
         snprintf(name, NAME_SIZE, "gpt%d", i);
@@ -79,19 +82,24 @@ static void fsl_imx7_init(Object *obj)
      */
     object_initialize_child(obj, "gpcv2", &s->gpcv2, TYPE_IMX_GPCV2);
 
+    /*
+     * ECSPIs
+     */
     for (i = 0; i < FSL_IMX7_NUM_ECSPIS; i++) {
         snprintf(name, NAME_SIZE, "spi%d", i + 1);
         object_initialize_child(obj, name, &s->spi[i], TYPE_IMX_SPI);
     }
 
-
+    /*
+     * I2Cs
+     */
     for (i = 0; i < FSL_IMX7_NUM_I2CS; i++) {
         snprintf(name, NAME_SIZE, "i2c%d", i + 1);
         object_initialize_child(obj, name, &s->i2c[i], TYPE_IMX_I2C);
     }
 
     /*
-     * UART
+     * UARTs
      */
     for (i = 0; i < FSL_IMX7_NUM_UARTS; i++) {
             snprintf(name, NAME_SIZE, "uart%d", i);
@@ -99,7 +107,7 @@ static void fsl_imx7_init(Object *obj)
     }
 
     /*
-     * Ethernet
+     * Ethernets
      */
     for (i = 0; i < FSL_IMX7_NUM_ETHS; i++) {
             snprintf(name, NAME_SIZE, "eth%d", i);
@@ -107,7 +115,7 @@ static void fsl_imx7_init(Object *obj)
     }
 
     /*
-     * SDHCI
+     * SDHCIs
      */
     for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
             snprintf(name, NAME_SIZE, "usdhc%d", i);
@@ -120,7 +128,7 @@ static void fsl_imx7_init(Object *obj)
     object_initialize_child(obj, "snvs", &s->snvs, TYPE_IMX7_SNVS);
 
     /*
-     * Watchdog
+     * Watchdogs
      */
     for (i = 0; i < FSL_IMX7_NUM_WDTS; i++) {
             snprintf(name, NAME_SIZE, "wdt%d", i);
@@ -132,8 +140,14 @@ static void fsl_imx7_init(Object *obj)
      */
     object_initialize_child(obj, "gpr", &s->gpr, TYPE_IMX7_GPR);
 
+    /*
+     * PCIE
+     */
     object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
 
+    /*
+     * USBs
+     */
     for (i = 0; i < FSL_IMX7_NUM_USBS; i++) {
         snprintf(name, NAME_SIZE, "usb%d", i);
         object_initialize_child(obj, name, &s->usb[i], TYPE_CHIPIDEA);
@@ -156,6 +170,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /*
+     * CPUs
+     */
     for (i = 0; i < smp_cpus; i++) {
         o = OBJECT(&s->cpu[i]);
 
@@ -206,10 +223,10 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      * A7MPCORE DAP
      */
     create_unimplemented_device("a7mpcore-dap", FSL_IMX7_A7MPCORE_DAP_ADDR,
-                                0x100000);
+                                FSL_IMX7_A7MPCORE_DAP_SIZE);
 
     /*
-     * GPT1, 2, 3, 4
+     * GPTs
      */
     for (i = 0; i < FSL_IMX7_NUM_GPTS; i++) {
         static const hwaddr FSL_IMX7_GPTn_ADDR[FSL_IMX7_NUM_GPTS] = {
@@ -234,6 +251,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX7_GPTn_IRQ[i]));
     }
 
+    /*
+     * GPIOs
+     */
     for (i = 0; i < FSL_IMX7_NUM_GPIOS; i++) {
         static const hwaddr FSL_IMX7_GPIOn_ADDR[FSL_IMX7_NUM_GPIOS] = {
             FSL_IMX7_GPIO1_ADDR,
@@ -279,18 +299,14 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * IOMUXC and IOMUXC_LPSR
+     * IOMUXC, IOMUXC_GPR and IOMUXC_LPSR
      */
-    for (i = 0; i < FSL_IMX7_NUM_IOMUXCS; i++) {
-        static const hwaddr FSL_IMX7_IOMUXCn_ADDR[FSL_IMX7_NUM_IOMUXCS] = {
-            FSL_IMX7_IOMUXC_ADDR,
-            FSL_IMX7_IOMUXC_LPSR_ADDR,
-        };
-
-        snprintf(name, NAME_SIZE, "iomuxc%d", i);
-        create_unimplemented_device(name, FSL_IMX7_IOMUXCn_ADDR[i],
-                                    FSL_IMX7_IOMUXCn_SIZE);
-    }
+    create_unimplemented_device("iomuxc", FSL_IMX7_IOMUXC_ADDR,
+                                FSL_IMX7_IOMUXC_SIZE);
+    create_unimplemented_device("iomuxc_gpr", FSL_IMX7_IOMUXC_GPR_ADDR,
+                                FSL_IMX7_IOMUXC_GPR_SIZE);
+    create_unimplemented_device("iomuxc_lspr", FSL_IMX7_IOMUXC_LPSR_ADDR,
+                                FSL_IMX7_IOMUXC_LPSR_SIZE);
 
     /*
      * CCM
@@ -310,7 +326,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->gpcv2), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpcv2), 0, FSL_IMX7_GPC_ADDR);
 
-    /* Initialize all ECSPI */
+    /*
+     * ECSPIs
+     */
     for (i = 0; i < FSL_IMX7_NUM_ECSPIS; i++) {
         static const hwaddr FSL_IMX7_SPIn_ADDR[FSL_IMX7_NUM_ECSPIS] = {
             FSL_IMX7_ECSPI1_ADDR,
@@ -335,6 +353,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX7_SPIn_IRQ[i]));
     }
 
+    /*
+     * I2Cs
+     */
     for (i = 0; i < FSL_IMX7_NUM_I2CS; i++) {
         static const hwaddr FSL_IMX7_I2Cn_ADDR[FSL_IMX7_NUM_I2CS] = {
             FSL_IMX7_I2C1_ADDR,
@@ -359,7 +380,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * UART
+     * UARTs
      */
     for (i = 0; i < FSL_IMX7_NUM_UARTS; i++) {
         static const hwaddr FSL_IMX7_UARTn_ADDR[FSL_IMX7_NUM_UARTS] = {
@@ -394,7 +415,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * Ethernet
+     * Ethernets
      *
      * We must use two loops since phy_connected affects the other interface
      * and we have to set all properties before calling sysbus_realize().
@@ -434,7 +455,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     }
 
     /*
-     * USDHC
+     * USDHCs
      */
     for (i = 0; i < FSL_IMX7_NUM_USDHCS; i++) {
         static const hwaddr FSL_IMX7_USDHCn_ADDR[FSL_IMX7_NUM_USDHCS] = {
@@ -464,7 +485,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      * SNVS
      */
     sysbus_realize(SYS_BUS_DEVICE(&s->snvs), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX7_SNVS_ADDR);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->snvs), 0, FSL_IMX7_SNVS_HP_ADDR);
 
     /*
      * SRC
@@ -472,7 +493,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("src", FSL_IMX7_SRC_ADDR, FSL_IMX7_SRC_SIZE);
 
     /*
-     * Watchdog
+     * Watchdogs
      */
     for (i = 0; i < FSL_IMX7_NUM_WDTS; i++) {
         static const hwaddr FSL_IMX7_WDOGn_ADDR[FSL_IMX7_NUM_WDTS] = {
@@ -509,25 +530,49 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("caam", FSL_IMX7_CAAM_ADDR, FSL_IMX7_CAAM_SIZE);
 
     /*
-     * PWM
+     * SAIs (Audio SSI (Synchronous Serial Interface))
      */
-    create_unimplemented_device("pwm1", FSL_IMX7_PWM1_ADDR, FSL_IMX7_PWMn_SIZE);
-    create_unimplemented_device("pwm2", FSL_IMX7_PWM2_ADDR, FSL_IMX7_PWMn_SIZE);
-    create_unimplemented_device("pwm3", FSL_IMX7_PWM3_ADDR, FSL_IMX7_PWMn_SIZE);
-    create_unimplemented_device("pwm4", FSL_IMX7_PWM4_ADDR, FSL_IMX7_PWMn_SIZE);
+    for (i = 0; i < FSL_IMX7_NUM_SAIS; i++) {
+        static const hwaddr FSL_IMX7_SAIn_ADDR[FSL_IMX7_NUM_SAIS] = {
+            FSL_IMX7_SAI1_ADDR,
+            FSL_IMX7_SAI2_ADDR,
+            FSL_IMX7_SAI3_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "sai%d", i);
+        create_unimplemented_device(name, FSL_IMX7_SAIn_ADDR[i],
+                                    FSL_IMX7_SAIn_SIZE);
+    }
 
     /*
-     * CAN
+     * PWMs
      */
-    create_unimplemented_device("can1", FSL_IMX7_CAN1_ADDR, FSL_IMX7_CANn_SIZE);
-    create_unimplemented_device("can2", FSL_IMX7_CAN2_ADDR, FSL_IMX7_CANn_SIZE);
+    for (i = 0; i < FSL_IMX7_NUM_PWMS; i++) {
+        static const hwaddr FSL_IMX7_PWMn_ADDR[FSL_IMX7_NUM_PWMS] = {
+            FSL_IMX7_PWM1_ADDR,
+            FSL_IMX7_PWM2_ADDR,
+            FSL_IMX7_PWM3_ADDR,
+            FSL_IMX7_PWM4_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "pwm%d", i);
+        create_unimplemented_device(name, FSL_IMX7_PWMn_ADDR[i],
+                                    FSL_IMX7_PWMn_SIZE);
+    }
 
     /*
-     * SAI (Audio SSI (Synchronous Serial Interface))
+     * CANs
      */
-    create_unimplemented_device("sai1", FSL_IMX7_SAI1_ADDR, FSL_IMX7_SAIn_SIZE);
-    create_unimplemented_device("sai2", FSL_IMX7_SAI2_ADDR, FSL_IMX7_SAIn_SIZE);
-    create_unimplemented_device("sai2", FSL_IMX7_SAI3_ADDR, FSL_IMX7_SAIn_SIZE);
+    for (i = 0; i < FSL_IMX7_NUM_CANS; i++) {
+        static const hwaddr FSL_IMX7_CANn_ADDR[FSL_IMX7_NUM_CANS] = {
+            FSL_IMX7_CAN1_ADDR,
+            FSL_IMX7_CAN2_ADDR,
+        };
+
+        snprintf(name, NAME_SIZE, "can%d", i);
+        create_unimplemented_device(name, FSL_IMX7_CANn_ADDR[i],
+                                    FSL_IMX7_CANn_SIZE);
+    }
 
     /*
      * OCOTP
@@ -535,9 +580,15 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     create_unimplemented_device("ocotp", FSL_IMX7_OCOTP_ADDR,
                                 FSL_IMX7_OCOTP_SIZE);
 
+    /*
+     * GPR
+     */
     sysbus_realize(SYS_BUS_DEVICE(&s->gpr), &error_abort);
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX7_GPR_ADDR);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpr), 0, FSL_IMX7_IOMUXC_GPR_ADDR);
 
+    /*
+     * PCIE
+     */
     sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX7_PCIE_REG_ADDR);
 
@@ -550,7 +601,9 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore), FSL_IMX7_PCI_INTD_IRQ);
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
 
-
+    /*
+     * USBs
+     */
     for (i = 0; i < FSL_IMX7_NUM_USBS; i++) {
         static const hwaddr FSL_IMX7_USBMISCn_ADDR[FSL_IMX7_NUM_USBS] = {
             FSL_IMX7_USBMISC1_ADDR,
@@ -612,6 +665,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
      */
     create_unimplemented_device("pcie-phy", FSL_IMX7_PCIE_PHY_ADDR,
                                 FSL_IMX7_PCIE_PHY_SIZE);
+
 }
 
 static Property fsl_imx7_properties[] = {
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 54ea2f0890..9a7cc4e366 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -25,7 +25,6 @@
 #include "hw/misc/imx7_ccm.h"
 #include "hw/misc/imx7_snvs.h"
 #include "hw/misc/imx7_gpr.h"
-#include "hw/misc/imx6_src.h"
 #include "hw/watchdog/wdt_imx2.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/char/imx_serial.h"
@@ -39,6 +38,7 @@
 #include "hw/usb/chipidea.h"
 #include "cpu.h"
 #include "qom/object.h"
+#include "qemu/units.h"
 
 #define TYPE_FSL_IMX7 "fsl-imx7"
 OBJECT_DECLARE_SIMPLE_TYPE(FslIMX7State, FSL_IMX7)
@@ -57,6 +57,9 @@ enum FslIMX7Configuration {
     FSL_IMX7_NUM_ECSPIS       = 4,
     FSL_IMX7_NUM_USBS         = 3,
     FSL_IMX7_NUM_ADCS         = 2,
+    FSL_IMX7_NUM_SAIS         = 3,
+    FSL_IMX7_NUM_CANS         = 2,
+    FSL_IMX7_NUM_PWMS         = 4,
 };
 
 struct FslIMX7State {
@@ -87,80 +90,112 @@ struct FslIMX7State {
 
 enum FslIMX7MemoryMap {
     FSL_IMX7_MMDC_ADDR            = 0x80000000,
-    FSL_IMX7_MMDC_SIZE            = 2 * 1024 * 1024 * 1024UL,
+    FSL_IMX7_MMDC_SIZE            = (2 * GiB),
 
-    FSL_IMX7_GPIO1_ADDR           = 0x30200000,
-    FSL_IMX7_GPIO2_ADDR           = 0x30210000,
-    FSL_IMX7_GPIO3_ADDR           = 0x30220000,
-    FSL_IMX7_GPIO4_ADDR           = 0x30230000,
-    FSL_IMX7_GPIO5_ADDR           = 0x30240000,
-    FSL_IMX7_GPIO6_ADDR           = 0x30250000,
-    FSL_IMX7_GPIO7_ADDR           = 0x30260000,
+    FSL_IMX7_QSPI1_MEM_ADDR       = 0x60000000,
+    FSL_IMX7_QSPI1_MEM_SIZE       = (256 * MiB),
 
-    FSL_IMX7_IOMUXC_LPSR_GPR_ADDR = 0x30270000,
+    FSL_IMX7_PCIE1_MEM_ADDR       = 0x40000000,
+    FSL_IMX7_PCIE1_MEM_SIZE       = (256 * MiB),
 
-    FSL_IMX7_WDOG1_ADDR           = 0x30280000,
-    FSL_IMX7_WDOG2_ADDR           = 0x30290000,
-    FSL_IMX7_WDOG3_ADDR           = 0x302A0000,
-    FSL_IMX7_WDOG4_ADDR           = 0x302B0000,
+    FSL_IMX7_QSPI1_RX_BUF_ADDR    = 0x34000000,
+    FSL_IMX7_QSPI1_RX_BUF_SIZE    = (32 * MiB),
 
-    FSL_IMX7_IOMUXC_LPSR_ADDR     = 0x302C0000,
+    /* PCIe Peripherals */
+    FSL_IMX7_PCIE_REG_ADDR        = 0x33800000,
+    FSL_IMX7_PCIE_REG_SIZE        = (16 * KiB),
 
-    FSL_IMX7_GPT1_ADDR            = 0x302D0000,
-    FSL_IMX7_GPT2_ADDR            = 0x302E0000,
-    FSL_IMX7_GPT3_ADDR            = 0x302F0000,
-    FSL_IMX7_GPT4_ADDR            = 0x30300000,
+    /* MMAP Peripherals */
+    FSL_IMX7_DMA_APBH_ADDR        = 0x33000000,
+    FSL_IMX7_DMA_APBH_SIZE        = 0x8000,
+
+    /* GPV configuration */
+    FSL_IMX7_GPV6_ADDR            = 0x32600000,
+    FSL_IMX7_GPV5_ADDR            = 0x32500000,
+    FSL_IMX7_GPV4_ADDR            = 0x32400000,
+    FSL_IMX7_GPV3_ADDR            = 0x32300000,
+    FSL_IMX7_GPV2_ADDR            = 0x32200000,
+    FSL_IMX7_GPV1_ADDR            = 0x32100000,
+    FSL_IMX7_GPV0_ADDR            = 0x32000000,
+    FSL_IMX7_GPVn_SIZE            = (1 * MiB),
+
+    /* Arm Peripherals */
+    FSL_IMX7_A7MPCORE_ADDR        = 0x31000000,
 
-    FSL_IMX7_IOMUXC_ADDR          = 0x30330000,
-    FSL_IMX7_IOMUXC_GPR_ADDR      = 0x30340000,
-    FSL_IMX7_IOMUXCn_SIZE         = 0x1000,
+    /* AIPS-3 Begin */
 
-    FSL_IMX7_OCOTP_ADDR           = 0x30350000,
-    FSL_IMX7_OCOTP_SIZE           = 0x10000,
+    FSL_IMX7_ENET2_ADDR           = 0x30BF0000,
+    FSL_IMX7_ENET1_ADDR           = 0x30BE0000,
+    FSL_IMX7_ENETn_ADDR           = (4 * KiB),
 
-    FSL_IMX7_ANALOG_ADDR          = 0x30360000,
-    FSL_IMX7_SNVS_ADDR            = 0x30370000,
-    FSL_IMX7_CCM_ADDR             = 0x30380000,
+    FSL_IMX7_SDMA_ADDR            = 0x30BD0000,
+    FSL_IMX7_SDMA_SIZE            = (4 * KiB),
 
-    FSL_IMX7_SRC_ADDR             = 0x30390000,
-    FSL_IMX7_SRC_SIZE             = 0x1000,
+    FSL_IMX7_EIM_ADDR             = 0x30BC0000,
+    FSL_IMX7_EIM_SIZE             = (4 * KiB),
 
-    FSL_IMX7_ADC1_ADDR            = 0x30610000,
-    FSL_IMX7_ADC2_ADDR            = 0x30620000,
-    FSL_IMX7_ADCn_SIZE            = 0x1000,
+    FSL_IMX7_QSPI_ADDR            = 0x30BB0000,
+    FSL_IMX7_QSPI_SIZE            = 0x8000,
 
-    FSL_IMX7_PWM1_ADDR            = 0x30660000,
-    FSL_IMX7_PWM2_ADDR            = 0x30670000,
-    FSL_IMX7_PWM3_ADDR            = 0x30680000,
-    FSL_IMX7_PWM4_ADDR            = 0x30690000,
-    FSL_IMX7_PWMn_SIZE            = 0x10000,
+    FSL_IMX7_SIM2_ADDR            = 0x30BA0000,
+    FSL_IMX7_SIM1_ADDR            = 0x30B90000,
+    FSL_IMX7_SIMn_SIZE            = (4 * KiB),
 
-    FSL_IMX7_PCIE_PHY_ADDR        = 0x306D0000,
-    FSL_IMX7_PCIE_PHY_SIZE        = 0x10000,
+    FSL_IMX7_USDHC3_ADDR          = 0x30B60000,
+    FSL_IMX7_USDHC2_ADDR          = 0x30B50000,
+    FSL_IMX7_USDHC1_ADDR          = 0x30B40000,
+    FSL_IMX7_USDHCn_SIZE          = (4 * KiB),
 
-    FSL_IMX7_GPC_ADDR             = 0x303A0000,
+    FSL_IMX7_USB3_ADDR            = 0x30B30000,
+    FSL_IMX7_USBMISC3_ADDR        = 0x30B30200,
+    FSL_IMX7_USB2_ADDR            = 0x30B20000,
+    FSL_IMX7_USBMISC2_ADDR        = 0x30B20200,
+    FSL_IMX7_USB1_ADDR            = 0x30B10000,
+    FSL_IMX7_USBMISC1_ADDR        = 0x30B10200,
+    FSL_IMX7_USBMISCn_SIZE        = 0x200,
+    FSL_IMX7_USBn_SIZE            = 0x200,
 
-    FSL_IMX7_CAAM_ADDR            = 0x30900000,
-    FSL_IMX7_CAAM_SIZE            = 0x40000,
+    FSL_IMX7_USB_PL301_ADDR       = 0x30AD0000,
+    FSL_IMX7_USB_PL301_SIZE       = (64 * KiB),
 
-    FSL_IMX7_CAN1_ADDR            = 0x30A00000,
-    FSL_IMX7_CAN2_ADDR            = 0x30A10000,
-    FSL_IMX7_CANn_SIZE            = 0x10000,
+    FSL_IMX7_SEMAPHORE_HS_ADDR    = 0x30AC0000,
+    FSL_IMX7_SEMAPHORE_HS_SIZE    = (64 * KiB),
+
+    FSL_IMX7_MUB_ADDR             = 0x30AB0000,
+    FSL_IMX7_MUA_ADDR             = 0x30AA0000,
+    FSL_IMX7_MUn_SIZE             = (KiB),
+
+    FSL_IMX7_UART7_ADDR           = 0x30A90000,
+    FSL_IMX7_UART6_ADDR           = 0x30A80000,
+    FSL_IMX7_UART5_ADDR           = 0x30A70000,
+    FSL_IMX7_UART4_ADDR           = 0x30A60000,
+    FSL_IMX7_UARTn_SIZE           = (4 * KiB),
 
-    FSL_IMX7_I2C1_ADDR            = 0x30A20000,
-    FSL_IMX7_I2C2_ADDR            = 0x30A30000,
-    FSL_IMX7_I2C3_ADDR            = 0x30A40000,
     FSL_IMX7_I2C4_ADDR            = 0x30A50000,
+    FSL_IMX7_I2C3_ADDR            = 0x30A40000,
+    FSL_IMX7_I2C2_ADDR            = 0x30A30000,
+    FSL_IMX7_I2C1_ADDR            = 0x30A20000,
+    FSL_IMX7_I2Cn_SIZE            = (4 * KiB),
 
-    FSL_IMX7_ECSPI1_ADDR          = 0x30820000,
-    FSL_IMX7_ECSPI2_ADDR          = 0x30830000,
-    FSL_IMX7_ECSPI3_ADDR          = 0x30840000,
-    FSL_IMX7_ECSPI4_ADDR          = 0x30630000,
+    FSL_IMX7_CAN2_ADDR            = 0x30A10000,
+    FSL_IMX7_CAN1_ADDR            = 0x30A00000,
+    FSL_IMX7_CANn_SIZE            = (4 * KiB),
 
-    FSL_IMX7_LCDIF_ADDR           = 0x30730000,
-    FSL_IMX7_LCDIF_SIZE           = 0x1000,
+    FSL_IMX7_AIPS3_CONF_ADDR      = 0x309F0000,
+    FSL_IMX7_AIPS3_CONF_SIZE      = (64 * KiB),
 
-    FSL_IMX7_UART1_ADDR           = 0x30860000,
+    FSL_IMX7_CAAM_ADDR            = 0x30900000,
+    FSL_IMX7_CAAM_SIZE            = (256 * KiB),
+
+    FSL_IMX7_SPBA_ADDR            = 0x308F0000,
+    FSL_IMX7_SPBA_SIZE            = (4 * KiB),
+
+    FSL_IMX7_SAI3_ADDR            = 0x308C0000,
+    FSL_IMX7_SAI2_ADDR            = 0x308B0000,
+    FSL_IMX7_SAI1_ADDR            = 0x308A0000,
+    FSL_IMX7_SAIn_SIZE            = (4 * KiB),
+
+    FSL_IMX7_UART3_ADDR           = 0x30880000,
     /*
      * Some versions of the reference manual claim that UART2 is @
      * 0x30870000, but experiments with HW + DT files in upstream
@@ -168,45 +203,182 @@ enum FslIMX7MemoryMap {
      * acutally located @ 0x30890000
      */
     FSL_IMX7_UART2_ADDR           = 0x30890000,
-    FSL_IMX7_UART3_ADDR           = 0x30880000,
-    FSL_IMX7_UART4_ADDR           = 0x30A60000,
-    FSL_IMX7_UART5_ADDR           = 0x30A70000,
-    FSL_IMX7_UART6_ADDR           = 0x30A80000,
-    FSL_IMX7_UART7_ADDR           = 0x30A90000,
+    FSL_IMX7_UART1_ADDR           = 0x30860000,
 
-    FSL_IMX7_SAI1_ADDR            = 0x308A0000,
-    FSL_IMX7_SAI2_ADDR            = 0x308B0000,
-    FSL_IMX7_SAI3_ADDR            = 0x308C0000,
-    FSL_IMX7_SAIn_SIZE            = 0x10000,
+    FSL_IMX7_ECSPI3_ADDR          = 0x30840000,
+    FSL_IMX7_ECSPI2_ADDR          = 0x30830000,
+    FSL_IMX7_ECSPI1_ADDR          = 0x30820000,
+    FSL_IMX7_ECSPIn_SIZE          = (4 * KiB),
 
-    FSL_IMX7_ENET1_ADDR           = 0x30BE0000,
-    FSL_IMX7_ENET2_ADDR           = 0x30BF0000,
+    /* AIPS-3 End */
 
-    FSL_IMX7_USB1_ADDR            = 0x30B10000,
-    FSL_IMX7_USBMISC1_ADDR        = 0x30B10200,
-    FSL_IMX7_USB2_ADDR            = 0x30B20000,
-    FSL_IMX7_USBMISC2_ADDR        = 0x30B20200,
-    FSL_IMX7_USB3_ADDR            = 0x30B30000,
-    FSL_IMX7_USBMISC3_ADDR        = 0x30B30200,
-    FSL_IMX7_USBMISCn_SIZE        = 0x200,
+    /* AIPS-2 Begin */
 
-    FSL_IMX7_USDHC1_ADDR          = 0x30B40000,
-    FSL_IMX7_USDHC2_ADDR          = 0x30B50000,
-    FSL_IMX7_USDHC3_ADDR          = 0x30B60000,
+    FSL_IMX7_AXI_DEBUG_MON_ADDR   = 0x307E0000,
+    FSL_IMX7_AXI_DEBUG_MON_SIZE   = (64 * KiB),
 
-    FSL_IMX7_SDMA_ADDR            = 0x30BD0000,
-    FSL_IMX7_SDMA_SIZE            = 0x1000,
+    FSL_IMX7_PERFMON2_ADDR        = 0x307D0000,
+    FSL_IMX7_PERFMON1_ADDR        = 0x307C0000,
+    FSL_IMX7_PERFMONn_SIZE        = (64 * KiB),
+
+    FSL_IMX7_DDRC_ADDR            = 0x307A0000,
+    FSL_IMX7_DDRC_SIZE            = (4 * KiB),
+
+    FSL_IMX7_DDRC_PHY_ADDR        = 0x30790000,
+    FSL_IMX7_DDRC_PHY_SIZE        = (4 * KiB),
+
+    FSL_IMX7_TZASC_ADDR           = 0x30780000,
+    FSL_IMX7_TZASC_SIZE           = (64 * KiB),
+
+    FSL_IMX7_MIPI_DSI_ADDR        = 0x30760000,
+    FSL_IMX7_MIPI_DSI_SIZE        = (4 * KiB),
+
+    FSL_IMX7_MIPI_CSI_ADDR        = 0x30750000,
+    FSL_IMX7_MIPI_CSI_SIZE        = 0x4000,
+
+    FSL_IMX7_LCDIF_ADDR           = 0x30730000,
+    FSL_IMX7_LCDIF_SIZE           = 0x8000,
+
+    FSL_IMX7_CSI_ADDR             = 0x30710000,
+    FSL_IMX7_CSI_SIZE             = (4 * KiB),
+
+    FSL_IMX7_PXP_ADDR             = 0x30700000,
+    FSL_IMX7_PXP_SIZE             = 0x4000,
+
+    FSL_IMX7_EPDC_ADDR            = 0x306F0000,
+    FSL_IMX7_EPDC_SIZE            = (4 * KiB),
+
+    FSL_IMX7_PCIE_PHY_ADDR        = 0x306D0000,
+    FSL_IMX7_PCIE_PHY_SIZE        = (4 * KiB),
+
+    FSL_IMX7_SYSCNT_CTRL_ADDR     = 0x306C0000,
+    FSL_IMX7_SYSCNT_CMP_ADDR      = 0x306B0000,
+    FSL_IMX7_SYSCNT_RD_ADDR       = 0x306A0000,
+
+    FSL_IMX7_PWM4_ADDR            = 0x30690000,
+    FSL_IMX7_PWM3_ADDR            = 0x30680000,
+    FSL_IMX7_PWM2_ADDR            = 0x30670000,
+    FSL_IMX7_PWM1_ADDR            = 0x30660000,
+    FSL_IMX7_PWMn_SIZE            = (4 * KiB),
+
+    FSL_IMX7_FlEXTIMER2_ADDR      = 0x30650000,
+    FSL_IMX7_FlEXTIMER1_ADDR      = 0x30640000,
+    FSL_IMX7_FLEXTIMERn_SIZE      = (4 * KiB),
+
+    FSL_IMX7_ECSPI4_ADDR          = 0x30630000,
+
+    FSL_IMX7_ADC2_ADDR            = 0x30620000,
+    FSL_IMX7_ADC1_ADDR            = 0x30610000,
+    FSL_IMX7_ADCn_SIZE            = (4 * KiB),
+
+    FSL_IMX7_AIPS2_CONF_ADDR      = 0x305F0000,
+    FSL_IMX7_AIPS2_CONF_SIZE      = (64 * KiB),
+
+    /* AIPS-2 End */
+
+    /* AIPS-1 Begin */
+
+    FSL_IMX7_CSU_ADDR             = 0x303E0000,
+    FSL_IMX7_CSU_SIZE             = (64 * KiB),
+
+    FSL_IMX7_RDC_ADDR             = 0x303D0000,
+    FSL_IMX7_RDC_SIZE             = (4 * KiB),
+
+    FSL_IMX7_SEMAPHORE2_ADDR      = 0x303C0000,
+    FSL_IMX7_SEMAPHORE1_ADDR      = 0x303B0000,
+    FSL_IMX7_SEMAPHOREn_SIZE      = (4 * KiB),
+
+    FSL_IMX7_GPC_ADDR             = 0x303A0000,
+    FSL_IMX7_GPC_SIZE             = (4 * KiB),
+
+    FSL_IMX7_SRC_ADDR             = 0x30390000,
+    FSL_IMX7_SRC_SIZE             = (4 * KiB),
+
+    FSL_IMX7_CCM_ADDR             = 0x30380000,
+    FSL_IMX7_CCM_SIZE             = 0x10000,
+
+    FSL_IMX7_SNVS_HP_ADDR         = 0x30370000,
+    FSL_IMX7_SNVS_HP_SIZE         = (4 * KiB),
+
+    FSL_IMX7_ANALOG_ADDR          = 0x30360000,
+    FSL_IMX7_ANALOG_SIZE          = (4 * KiB),
+
+    FSL_IMX7_OCOTP_ADDR           = 0x30350000,
+    FSL_IMX7_OCOTP_SIZE           = 0x10000,
+
+    FSL_IMX7_IOMUXC_GPR_ADDR      = 0x30340000,
+    FSL_IMX7_IOMUXC_GPR_SIZE      = (4 * KiB),
+
+    FSL_IMX7_IOMUXC_ADDR          = 0x30330000,
+    FSL_IMX7_IOMUXC_SIZE          = (4 * KiB),
+
+    FSL_IMX7_KPP_ADDR             = 0x30320000,
+    FSL_IMX7_KPP_SIZE             = (4 * KiB),
+
+    FSL_IMX7_ROMCP_ADDR           = 0x30310000,
+    FSL_IMX7_ROMCP_SIZE           = (4 * KiB),
+
+    FSL_IMX7_GPT4_ADDR            = 0x30300000,
+    FSL_IMX7_GPT3_ADDR            = 0x302F0000,
+    FSL_IMX7_GPT2_ADDR            = 0x302E0000,
+    FSL_IMX7_GPT1_ADDR            = 0x302D0000,
+    FSL_IMX7_GPTn_SIZE            = (4 * KiB),
+
+    FSL_IMX7_IOMUXC_LPSR_ADDR     = 0x302C0000,
+    FSL_IMX7_IOMUXC_LPSR_SIZE     = (4 * KiB),
+
+    FSL_IMX7_WDOG4_ADDR           = 0x302B0000,
+    FSL_IMX7_WDOG3_ADDR           = 0x302A0000,
+    FSL_IMX7_WDOG2_ADDR           = 0x30290000,
+    FSL_IMX7_WDOG1_ADDR           = 0x30280000,
+    FSL_IMX7_WDOGn_SIZE           = (4 * KiB),
+
+    FSL_IMX7_IOMUXC_LPSR_GPR_ADDR = 0x30270000,
+    FSL_IMX7_IOMUXC_LPSR_GPR_SIZE = (4 * KiB),
+
+    FSL_IMX7_GPIO7_ADDR           = 0x30260000,
+    FSL_IMX7_GPIO6_ADDR           = 0x30250000,
+    FSL_IMX7_GPIO5_ADDR           = 0x30240000,
+    FSL_IMX7_GPIO4_ADDR           = 0x30230000,
+    FSL_IMX7_GPIO3_ADDR           = 0x30220000,
+    FSL_IMX7_GPIO2_ADDR           = 0x30210000,
+    FSL_IMX7_GPIO1_ADDR           = 0x30200000,
+    FSL_IMX7_GPIOn_SIZE           = (4 * KiB),
+
+    FSL_IMX7_AIPS1_CONF_ADDR      = 0x301F0000,
+    FSL_IMX7_AIPS1_CONF_SIZE      = (64 * KiB),
 
-    FSL_IMX7_A7MPCORE_ADDR        = 0x31000000,
     FSL_IMX7_A7MPCORE_DAP_ADDR    = 0x30000000,
+    FSL_IMX7_A7MPCORE_DAP_SIZE    = (1 * MiB),
 
-    FSL_IMX7_PCIE_REG_ADDR        = 0x33800000,
-    FSL_IMX7_PCIE_REG_SIZE        = 16 * 1024,
+    /* AIPS-1 End */
 
-    FSL_IMX7_GPR_ADDR             = 0x30340000,
+    FSL_IMX7_EIM_CS0_ADDR         = 0x28000000,
+    FSL_IMX7_EIM_CS0_SIZE         = (128 * MiB),
 
-    FSL_IMX7_DMA_APBH_ADDR        = 0x33000000,
-    FSL_IMX7_DMA_APBH_SIZE        = 0x2000,
+    FSL_IMX7_OCRAM_PXP_ADDR       = 0x00940000,
+    FSL_IMX7_OCRAM_PXP_SIZE       = (32 * KiB),
+
+    FSL_IMX7_OCRAM_EPDC_ADDR      = 0x00920000,
+    FSL_IMX7_OCRAM_EPDC_SIZE      = (128 * KiB),
+
+    FSL_IMX7_OCRAM_MEM_ADDR       = 0x00900000,
+    FSL_IMX7_OCRAM_MEM_SIZE       = (128 * KiB),
+
+    FSL_IMX7_TCMU_ADDR            = 0x00800000,
+    FSL_IMX7_TCMU_SIZE            = (32 * KiB),
+
+    FSL_IMX7_TCML_ADDR            = 0x007F8000,
+    FSL_IMX7_TCML_SIZE            = (32 * KiB),
+
+    FSL_IMX7_OCRAM_S_ADDR         = 0x00180000,
+    FSL_IMX7_OCRAM_S_SIZE         = (32 * KiB),
+
+    FSL_IMX7_CAAM_MEM_ADDR        = 0x00100000,
+    FSL_IMX7_CAAM_MEM_SIZE        = (32 * KiB),
+
+    FSL_IMX7_ROM_ADDR             = 0x00000000,
+    FSL_IMX7_ROM_SIZE             = (96 * KiB),
 };
 
 enum FslIMX7IRQs {
-- 
2.34.1


