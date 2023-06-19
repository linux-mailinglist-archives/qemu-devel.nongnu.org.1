Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5625735FCF
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 00:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBNCp-0000xg-67; Mon, 19 Jun 2023 18:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qBNCm-0000x4-Nh
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 18:18:36 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qBNCj-0007Sq-VJ
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 18:18:36 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-39c76b2917bso386460b6e.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 15:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osdyne.com; s=google; t=1687213112; x=1689805112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yRtCkEvn2A6RY+QITqEBb3454E9W4+CtATt9wpzPC/Q=;
 b=dnBlvEb0ajSAV5qdwCBqkU32DvCKLNWoqvtS7d+VG7UYG/7UcvDlSf9PwLnXUYGltB
 QARMMijNLKyhBZ6wk1JZyoklJYGINFSHwr1Fd2EaK9r4WkmLO7GBaDPraqsVa3v1fzLQ
 llJyIqfu4bo3gunPIrLFpSOsbtcyO6VmzepsP3RBb0KCkUNgdZ/U7XKobI3fIXD0TALU
 dkwabzHXxw3IrKnxBpDir0xn43nIYA9M1cMo5ayoXs4NpCTfAHDnG9JSUjZNv5LT93bR
 gXulyngfBvKjWucd9oa3nrSweZOqEpBqaefbicfUSapPw3LKJA1ROpiC4ZFwLdXflXbt
 LM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687213112; x=1689805112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRtCkEvn2A6RY+QITqEBb3454E9W4+CtATt9wpzPC/Q=;
 b=lEZIYtU7JQDXLUsuq+L2c1e3B0uvns+DQwlgNckUZahU6MBiI8GflvEGR9ALohwsmj
 lqnN5/jNzwaXgCOf1oSBYC9UZ/UmAG6Q/XnBvJ2oZeK2FEy+IfzEM8Xa973oBxPJ07EC
 0s3HeEoFTPOOXvNID4APsfY/IhUpmglrziyCmx5vueavfxbaHBW/ObRS8mRISDBnJXaH
 Gr6ujtP5k8SIgrULC7pX+q4+t45ltpyPhElEZrJhzsixMAJ6KotytQljg0lkqVn3koB4
 9Lv1i9JDDJe/ueM1E3FZetHCDLfoZ4YO6VfWcJBS8wdF37+M3hdZzjTPcy+wN5SQgA/N
 Foag==
X-Gm-Message-State: AC+VfDyv4R0c+JMbPMMw9cpIosYuywS2UaTc6LTR74BlmFF8F9x2MYT4
 gBSr+iPLCfqChzlSDnR0Ls4FxQ==
X-Google-Smtp-Source: ACHHUZ7sGsav51h4//j5G1ss2UFTxY9Ms+FBXLIEgkWIzw263u1QGvWQNs4wAv8nsz8lUnbOHO2HHw==
X-Received: by 2002:aca:f208:0:b0:39c:8216:e648 with SMTP id
 q8-20020acaf208000000b0039c8216e648mr6645549oih.1.1687213112162; 
 Mon, 19 Jun 2023 15:18:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:46:24d1:115d:65a6:335b:88b6])
 by smtp.gmail.com with ESMTPSA id
 l203-20020acabbd4000000b00398031b1014sm444137oif.26.2023.06.19.15.18.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Jun 2023 15:18:31 -0700 (PDT)
From: Lucas Villa Real <lucas@osdyne.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, erdnaxe@crans.org,
 Lucas Villa Real <lucas@osdyne.com>
Subject: [PATCH] STM32F100: support different density lines
Date: Mon, 19 Jun 2023 19:18:19 -0300
Message-Id: <20230619221819.6882-1-lucas@osdyne.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=lucas@osdyne.com; helo=mail-oi1-x234.google.com
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

This patch adds support for the emulation of different density lines
(low, medium, and high). A new class property stm32f100-soc.density=
has been introduced to allow users to state the desired configuration.
That property is recognized by a new machine, stm32f1-generic. The SOC
is configured according to the following:

   density=low       32 KB FLASH, 2 SPIs
   density=medium   128 KB FLASH, 2 SPIs
   density=high     512 KB FLASH, 3 SPIs

With this code change we should be able to introduce richer features
to STM32F100, such as support for FSMC (so that a machine with more
RAM capacity can be properly emulated). FSMC is supported on high
density line devices only.

Signed-off-by: Lucas C. Villa Real <lucas@osdyne.com>
---
 configs/devices/arm-softmmu/default.mak |  1 +
 docs/system/arm/stm32.rst               | 14 ++++
 hw/arm/Kconfig                          |  6 ++
 hw/arm/meson.build                      |  1 +
 hw/arm/stm32f100_soc.c                  | 92 +++++++++++++++++++++----
 hw/arm/stm32f1_generic.c                | 70 +++++++++++++++++++
 hw/arm/stm32vldiscovery.c               |  3 +-
 include/hw/arm/stm32f100_soc.h          | 18 ++++-
 8 files changed, 189 insertions(+), 16 deletions(-)
 create mode 100644 hw/arm/stm32f1_generic.c

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 980c48a7d9..4f0f2e99c0 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -19,6 +19,7 @@ CONFIG_ARM_VIRT=y
 # CONFIG_NSERIES=n
 # CONFIG_STELLARIS=n
 # CONFIG_STM32VLDISCOVERY=n
+# CONFIG_STM32F1_GENERIC=n
 # CONFIG_REALVIEW=n
 # CONFIG_VERSATILE=n
 # CONFIG_VEXPRESS=n
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index d7265b763d..d0a3b1a7eb 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -10,6 +10,12 @@ The STM32F1 series is based on ARM Cortex-M3 core. The following machines are
 based on this chip :
 
 - ``stm32vldiscovery``  STM32VLDISCOVERY board with STM32F100RBT6 microcontroller
+- ``stm32f1-generic``   Generic STM32F1 board supporting low, medium and high
+                        density devices. Low-density emulates a 32KB FLASH;
+                        medium-density emulates a 128KB FLASH; high-density
+                        emulates a 512KB FLASH. The density also affects the
+                        number of peripherals exposed by QEMU for the emulated
+                        device. See ``Boot options`` below for more details.
 
 The STM32F2 series is based on ARM Cortex-M3 core. The following machines are
 based on this chip :
@@ -65,3 +71,11 @@ firmware. Example:
 .. code-block:: bash
 
   $ qemu-system-arm -M stm32vldiscovery -kernel firmware.bin
+
+Additionally, the ``stm32f1-generic`` board supports the ``density`` option
+to select the device density line.  The following values are supported:
+``low``, ``medium``, ``high``. Example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M stm32f1-generic -global stm32f100-soc.density=medium ...
\ No newline at end of file
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2159de3ce6..822441945c 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -301,6 +301,12 @@ config STM32VLDISCOVERY
     depends on TCG && ARM
     select STM32F100_SOC
 
+config STM32F1_GENERIC
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32F100_SOC
+
 config STRONGARM
     bool
     select PXA2XX
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 870ec67376..f88b5fe3c8 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -23,6 +23,7 @@ arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
+arm_ss.add(when: 'CONFIG_STM32F1_GENERIC', if_true: files('stm32f1_generic.c'))
 arm_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 arm_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
 arm_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index f7b344ba9f..c157ffd644 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -38,10 +38,11 @@
 
 static const uint32_t usart_addr[STM_NUM_USARTS] = { 0x40013800, 0x40004400,
     0x40004800 };
-static const uint32_t spi_addr[STM_NUM_SPIS] = { 0x40013000, 0x40003800 };
+static const uint32_t spi_addr[STM_NUM_SPIS] = { 0x40013000, 0x40003800,
+    0x40003C00 };
 
 static const int usart_irq[STM_NUM_USARTS] = {37, 38, 39};
-static const int spi_irq[STM_NUM_SPIS] = {35, 36};
+static const int spi_irq[STM_NUM_SPIS] = {35, 36, 51};
 
 static void stm32f100_soc_initfn(Object *obj)
 {
@@ -50,17 +51,21 @@ static void stm32f100_soc_initfn(Object *obj)
 
     object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
 
+    /*
+     * All density lines feature the same number of USARTs, so they can be
+     * initialized in this function. The number of SPIs is density-dependent,
+     * though, so SPIs are initialized in stm32f100_soc_realize().
+     */
     for (i = 0; i < STM_NUM_USARTS; i++) {
         object_initialize_child(obj, "usart[*]", &s->usart[i],
                                 TYPE_STM32F2XX_USART);
     }
 
-    for (i = 0; i < STM_NUM_SPIS; i++) {
-        object_initialize_child(obj, "spi[*]", &s->spi[i], TYPE_STM32F2XX_SPI);
-    }
-
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
     s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+
+    /* Default density. May be overridden by the machine or cmdline option */
+    s->density = STM32F100_DENSITY_HIGH;
 }
 
 static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -70,6 +75,17 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     SysBusDevice *busdev;
     int i;
 
+    if (s->density == STM32F100_DENSITY_HIGH) {
+        s->num_spis = 3;
+        s->flash_size = FLASH_SIZE_HD;
+    } else if (s->density == STM32F100_DENSITY_MEDIUM) {
+        s->num_spis = 2;
+        s->flash_size = FLASH_SIZE_MD;
+    } else {
+        s->num_spis = 2;
+        s->flash_size = FLASH_SIZE_LD;
+    }
+
     MemoryRegion *system_memory = get_system_memory();
 
     /*
@@ -101,9 +117,10 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
      * Flash starts at 0x08000000 and then is aliased to boot memory at 0x0
      */
     memory_region_init_rom(&s->flash, OBJECT(dev_soc), "STM32F100.flash",
-                           FLASH_SIZE, &error_fatal);
+                           s->flash_size, &error_fatal);
     memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
-                             "STM32F100.flash.alias", &s->flash, 0, FLASH_SIZE);
+                             "STM32F100.flash.alias", &s->flash, 0,
+                             s->flash_size);
     memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
     memory_region_add_subregion(system_memory, 0, &s->flash_alias);
 
@@ -137,8 +154,11 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
     }
 
-    /* SPI 1 and 2 */
-    for (i = 0; i < STM_NUM_SPIS; i++) {
+    /* Initialize all SPIs supported by the selected density line */
+    for (i = 0; i < s->num_spis; i++) {
+        object_initialize_child(OBJECT(dev_soc), "spi[*]", &s->spi[i],
+                                TYPE_STM32F2XX_SPI);
+
         dev = DEVICE(&(s->spi[i]));
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->spi[i]), errp)) {
             return;
@@ -153,9 +173,14 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("timer[4]",  0x40000800, 0x400);
     create_unimplemented_device("timer[6]",  0x40001000, 0x400);
     create_unimplemented_device("timer[7]",  0x40001400, 0x400);
+    create_unimplemented_device("timer[12]", 0x40001800, 0x400);
+    create_unimplemented_device("timer[13]", 0x40001C00, 0x400);
+    create_unimplemented_device("timer[14]", 0x40002000, 0x400);
     create_unimplemented_device("RTC",       0x40002800, 0x400);
     create_unimplemented_device("WWDG",      0x40002C00, 0x400);
     create_unimplemented_device("IWDG",      0x40003000, 0x400);
+    create_unimplemented_device("UART4",     0x40004C00, 0x400);
+    create_unimplemented_device("UART5",     0x40005000, 0x400);
     create_unimplemented_device("I2C1",      0x40005400, 0x400);
     create_unimplemented_device("I2C2",      0x40005800, 0x400);
     create_unimplemented_device("BKP",       0x40006C00, 0x400);
@@ -169,12 +194,15 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("GPIOC",     0x40011000, 0x400);
     create_unimplemented_device("GPIOD",     0x40011400, 0x400);
     create_unimplemented_device("GPIOE",     0x40011800, 0x400);
+    create_unimplemented_device("GPIOF",     0x40011C00, 0x400);
+    create_unimplemented_device("GPIOG",     0x40012000, 0x400);
     create_unimplemented_device("ADC1",      0x40012400, 0x400);
     create_unimplemented_device("timer[1]",  0x40012C00, 0x400);
     create_unimplemented_device("timer[15]", 0x40014000, 0x400);
     create_unimplemented_device("timer[16]", 0x40014400, 0x400);
     create_unimplemented_device("timer[17]", 0x40014800, 0x400);
-    create_unimplemented_device("DMA",       0x40020000, 0x400);
+    create_unimplemented_device("DMA1",      0x40020000, 0x400);
+    create_unimplemented_device("DMA2",      0x40020400, 0x400);
     create_unimplemented_device("RCC",       0x40021000, 0x400);
     create_unimplemented_device("Flash Int", 0x40022000, 0x400);
     create_unimplemented_device("CRC",       0x40023000, 0x400);
@@ -185,12 +213,50 @@ static Property stm32f100_soc_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void stm32f100_soc_class_init(ObjectClass *klass, void *data)
+static char *stm32f100_get_density(Object *obj, Error **errp)
 {
-    DeviceClass *dc = DEVICE_CLASS(klass);
+    STM32F100State *s = STM32F100_SOC(obj);
+
+    switch (s->density) {
+    case STM32F100_DENSITY_LOW:
+        return g_strdup("low");
+    case STM32F100_DENSITY_MEDIUM:
+        return g_strdup("medium");
+    case STM32F100_DENSITY_HIGH:
+        return g_strdup("high");
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void stm32f100_set_density(Object *obj, const char *value, Error **errp)
+{
+    STM32F100State *s = STM32F100_SOC(obj);
+
+    if (!strcmp(value, "low")) {
+        s->density = STM32F100_DENSITY_LOW;
+    } else if (!strcmp(value, "medium")) {
+        s->density = STM32F100_DENSITY_MEDIUM;
+    } else if (!strcmp(value, "high")) {
+        s->density = STM32F100_DENSITY_HIGH;
+    } else {
+        error_setg(errp, "Invalid density value '%s'", value);
+        error_append_hint(errp, "Valid values: 'low', 'medium', 'high'\n");
+    }
+}
+
+static void stm32f100_soc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = stm32f100_soc_realize;
     device_class_set_props(dc, stm32f100_soc_properties);
+
+    object_class_property_add_str(oc, "density", stm32f100_get_density,
+        stm32f100_set_density);
+    object_class_property_set_description(oc, "density",
+        "Set the STM32F100 density line device. "
+        "Valid values are 'low', 'medium', and 'high' (default).");
 }
 
 static const TypeInfo stm32f100_soc_info = {
diff --git a/hw/arm/stm32f1_generic.c b/hw/arm/stm32f1_generic.c
new file mode 100644
index 0000000000..63d2a58bdc
--- /dev/null
+++ b/hw/arm/stm32f1_generic.c
@@ -0,0 +1,70 @@
+/*
+ * ST generic STM32F1 board
+ *
+ * Copyright (c) 2023 Lucas C. Villa Real <lucas@osdyne.com>
+ * Copyright (c) 2021 Alexandre Iooss <erdnaxe@crans.org>
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "qemu/error-report.h"
+#include "hw/arm/stm32f100_soc.h"
+#include "hw/arm/boot.h"
+
+/* Main SYSCLK frequency in Hz (24MHz) */
+#define SYSCLK_FRQ 24000000ULL
+
+static void stm32f1_generic_init(MachineState *machine)
+{
+    STM32F100State *s;
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency */
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    /*
+     * Note that we don't set the "density" property so that the default
+     * value ("high") can be changed via "-global stm32f100-soc.density=..."
+     */
+    dev = qdev_new(TYPE_STM32F100_SOC);
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    s = STM32F100_SOC(OBJECT(dev));
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, s->flash_size);
+}
+
+static void stm32f1_generic_machine_init(MachineClass *mc)
+{
+    mc->desc = "STM32F1 generic (Cortex-M3)";
+    mc->init = stm32f1_generic_init;
+}
+
+DEFINE_MACHINE("stm32f1-generic", stm32f1_generic_machine_init)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 67675e952f..3c4bffe5d4 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -47,13 +47,14 @@ static void stm32vldiscovery_init(MachineState *machine)
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
     dev = qdev_new(TYPE_STM32F100_SOC);
+    qdev_prop_set_string(dev, "density", "medium");
     qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m3"));
     qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
-                       0, FLASH_SIZE);
+                       0, FLASH_SIZE_MD);
 }
 
 static void stm32vldiscovery_machine_init(MachineClass *mc)
diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_soc.h
index 40cd415b28..5305e342e3 100644
--- a/include/hw/arm/stm32f100_soc.h
+++ b/include/hw/arm/stm32f100_soc.h
@@ -34,14 +34,24 @@
 #define TYPE_STM32F100_SOC "stm32f100-soc"
 OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_SOC)
 
+/* Definitions for high-density value line devices */
 #define STM_NUM_USARTS 3
-#define STM_NUM_SPIS 2
+#define STM_NUM_SPIS 3
 
 #define FLASH_BASE_ADDRESS 0x08000000
-#define FLASH_SIZE (128 * 1024)
+#define FLASH_SIZE_LD (32 * 1024)
+#define FLASH_SIZE_MD (128 * 1024)
+#define FLASH_SIZE_HD (512 * 1024)
 #define SRAM_BASE_ADDRESS 0x20000000
 #define SRAM_SIZE (8 * 1024)
 
+/* Supported density value lines */
+typedef enum {
+    STM32F100_DENSITY_LOW,
+    STM32F100_DENSITY_MEDIUM,
+    STM32F100_DENSITY_HIGH,
+} STM32F100Density;
+
 struct STM32F100State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -60,6 +70,10 @@ struct STM32F100State {
 
     Clock *sysclk;
     Clock *refclk;
+
+    STM32F100Density density;
+    uint8_t num_spis;
+    uint32_t flash_size;
 };
 
 #endif
-- 
2.39.2 (Apple Git-143)


