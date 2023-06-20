Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E561B737539
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhGk-0005H9-UO; Tue, 20 Jun 2023 15:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qBhGi-0005DI-3P
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:44:00 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucas@osdyne.com>) id 1qBhGe-0000ix-RU
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:43:59 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-39eac9da7ecso434453b6e.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osdyne.com; s=google; t=1687290235; x=1689882235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0H2F2TynOv6XAuQxcEErLPWZK5cjqLSbSV0b24Rq8+4=;
 b=AEwp9y4jd9/Uk6CsY+2o26stpVYlZRx0bxspcl4Tt7Si+iFeAMInTkeOEyHwPJODSq
 eWVyBULxdIkK4UBJlZU76HOApN7tXc9K7Y0B7kMBsAsGeF0WQ2SnacJyzf1Mzd3ZIsGv
 c1E3HJBPSXa3MBJRMo4egM6PB1eNzTlY+SAXf3n2TPGitz6ht+oOMQly6aA2/Ok8IFDN
 8HGMX6oe+dPlIOfcom2OP9caftyqWPpe+ZkxwLqcXwFH4yFSmSStkWyQAKlg16rdo66A
 sypXl7ZHd3lnMHhWaVBziS8Szt2QkTDo0F0iJZAAHD+l2DOLnjbXSt+h0UKqRSNaYoFE
 XVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687290235; x=1689882235;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0H2F2TynOv6XAuQxcEErLPWZK5cjqLSbSV0b24Rq8+4=;
 b=ZKSe214zq/eYwsDdCSnp8NOU+dP7qVYVDvr/C7GoDRQ6UaSReYCMegGNdXdFRFUO03
 e14utWkNRh+MB5OFTaH+ZCdTyI66co+Rbza7F+6J+6K7KBtaKu4HK9VQ7e7lxOeBL44p
 wUjydHmY8jp4qxbnEGwfuNnquhQBsyYBOMOooKmBBO0+y8ZsRM0hyGxQyoZb12PZyDU2
 IpNBaqhusmJtRdhfAUIM8lev2oNz0xKvyiUlzjJAohQSIvLcye5BNSUYluGPKSB2K81C
 vDBr88Eqd8hI/MvEP/y8LivDShU10Zl4qeaYT6FAuqx/w8MwFGHKG12Rd/wyvOn3SFp2
 mTjQ==
X-Gm-Message-State: AC+VfDzKMtSnrx5efOUZMb/b2rd75yMujxO7pIoQTlq1V1H35zU4GdtG
 xXwlMbWRG0bu5Wj8blSBdtTy/w==
X-Google-Smtp-Source: ACHHUZ48oP13xAkbM2FaR2oSDBSA8V93EcUAYuHUAMNO4kRnzY4QJrYEZ2IgDmic635EfXJ7sfAhiA==
X-Received: by 2002:aca:3442:0:b0:396:4680:df1b with SMTP id
 b63-20020aca3442000000b003964680df1bmr7888200oia.3.1687290235301; 
 Tue, 20 Jun 2023 12:43:55 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:46:24d1:115d:65a6:335b:88b6])
 by smtp.gmail.com with ESMTPSA id
 bj36-20020a05680819a400b003a033fc87c7sm1429916oib.30.2023.06.20.12.43.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jun 2023 12:43:54 -0700 (PDT)
From: Lucas Villa Real <lucas@osdyne.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, erdnaxe@crans.org,
 Lucas Villa Real <lucas@osdyne.com>,
 "Lucas C . Villa Real" <lucas@odsyne.com>
Subject: [PATCH] STM32F100: add support for external memory via FSMC
Date: Tue, 20 Jun 2023 16:43:17 -0300
Message-Id: <20230620194317.45772-1-lucas@osdyne.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230619221819.6882-1-lucas@osdyne.com>
References: <20230619221819.6882-1-lucas@osdyne.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=lucas@osdyne.com; helo=mail-oi1-x22d.google.com
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

Add support for FSMC on high-density STM32F100 devices and enable
mapping of additional memory via the `-m SIZE` command-line option.
FSMC Bank1 can address up to 4x64MB of PSRAM memory at 0x60000000.

RCC is needed to enable peripheral clock for FSMC; this commit
implements support for RCC through the MMIO interface.

Last, high-density devices support up to 32KB of static SRAM, so
adjust SRAM_SIZE accordingly.

Signed-off-by: Lucas C. Villa Real <lucas@odsyne.com>
---
 docs/system/arm/stm32.rst        |  12 ++-
 hw/arm/Kconfig                   |   1 +
 hw/arm/stm32f100_soc.c           | 102 +++++++++++++++++++-
 hw/arm/stm32f1_generic.c         |  12 +++
 hw/misc/Kconfig                  |   3 +
 hw/misc/meson.build              |   1 +
 hw/misc/stm32f1xx_fsmc.c         | 155 +++++++++++++++++++++++++++++++
 include/hw/arm/stm32f100_soc.h   |  24 ++++-
 include/hw/misc/stm32f1xx_fsmc.h |  62 +++++++++++++
 9 files changed, 368 insertions(+), 4 deletions(-)
 create mode 100644 hw/misc/stm32f1xx_fsmc.c
 create mode 100644 include/hw/misc/stm32f1xx_fsmc.h

diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index d0a3b1a7eb..40de58ed04 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -40,6 +40,8 @@ Supported devices
  * SPI controller
  * System configuration (SYSCFG)
  * Timer controller (TIMER)
+ * Reset and Clock Controller (RCC)
+ * Flexible static memory controller (FSMC)
 
 Missing devices
 ---------------
@@ -57,7 +59,6 @@ Missing devices
  * Power supply configuration (PWR)
  * Random Number Generator (RNG)
  * Real-Time Clock (RTC) controller
- * Reset and Clock Controller (RCC)
  * Secure Digital Input/Output (SDIO) interface
  * USB OTG
  * Watchdog controller (IWDG, WWDG)
@@ -78,4 +79,11 @@ to select the device density line.  The following values are supported:
 
 .. code-block:: bash
 
-  $ qemu-system-arm -M stm32f1-generic -global stm32f100-soc.density=medium ...
\ No newline at end of file
+  $ qemu-system-arm -M stm32f1-generic -global stm32f100-soc.density=medium ...
+
+High-density devices can also enable up to 256 MB of external memory using
+the `-m SIZE` option. The memory is mapped at address 0x60000000. Example:
+ 
+.. code-block:: bash
+
+  $ qemu-system-arm -M stm32f1-generic -m 64M ...
\ No newline at end of file
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 822441945c..dd48068108 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -433,6 +433,7 @@ config RASPI
 config STM32F100_SOC
     bool
     select ARM_V7M
+    select STM32F1XX_FSMC
     select STM32F2XX_USART
     select STM32F2XX_SPI
 
diff --git a/hw/arm/stm32f100_soc.c b/hw/arm/stm32f100_soc.c
index c157ffd644..a2b863d309 100644
--- a/hw/arm/stm32f100_soc.c
+++ b/hw/arm/stm32f100_soc.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "hw/arm/boot.h"
 #include "exec/address-spaces.h"
 #include "hw/arm/stm32f100_soc.h"
@@ -40,9 +41,85 @@ static const uint32_t usart_addr[STM_NUM_USARTS] = { 0x40013800, 0x40004400,
     0x40004800 };
 static const uint32_t spi_addr[STM_NUM_SPIS] = { 0x40013000, 0x40003800,
     0x40003C00 };
+static const uint32_t fsmc_addr = 0xA0000000;
 
 static const int usart_irq[STM_NUM_USARTS] = {37, 38, 39};
 static const int spi_irq[STM_NUM_SPIS] = {35, 36, 51};
+static const int fsmc_irq = 48;
+
+static uint64_t stm32f100_rcc_read(void *h, hwaddr offset, unsigned size)
+{
+    STM32F100State *s = (STM32F100State *) h;
+    switch (offset) {
+    case 0x00:
+        return s->rcc.cr;
+    case 0x04:
+        return s->rcc.cfgr;
+    case 0x08:
+        return s->rcc.cir;
+    case 0x0C:
+        return s->rcc.apb2rstr;
+    case 0x10:
+        return s->rcc.apb1rstr;
+    case 0x14:
+        return s->rcc.ahbenr;
+    case 0x18:
+        return s->rcc.apb2enr;
+    case 0x1C:
+        return s->rcc.apb1enr;
+    case 0x20:
+        return s->rcc.bdcr;
+    case 0x24:
+        return s->rcc.csr;
+    case 0x2C:
+        return s->rcc.cfgr2;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, offset);
+    }
+    return 0;
+}
+
+static void stm32f100_rcc_write(void *h, hwaddr offset, uint64_t value64,
+                                unsigned size)
+{
+    STM32F100State *s = (STM32F100State *) h;
+    uint32_t value = value64 & 0xffffffff;
+
+    switch (offset) {
+    case 0x00:
+        s->rcc.cr = value;
+    case 0x04:
+        s->rcc.cfgr = value;
+    case 0x08:
+        s->rcc.cir = value;
+    case 0x0C:
+        s->rcc.apb2rstr = value;
+    case 0x10:
+        s->rcc.apb1rstr = value;
+    case 0x14:
+        s->rcc.ahbenr = value;
+    case 0x18:
+        s->rcc.apb2enr = value;
+    case 0x1C:
+        s->rcc.apb1enr = value;
+    case 0x20:
+        s->rcc.bdcr = value;
+    case 0x24:
+        s->rcc.csr = value;
+    case 0x2C:
+        s->rcc.cfgr2 = value;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, offset);
+    }
+}
+
+static const MemoryRegionOps stm32f100_rcc_ops = {
+    .read = stm32f100_rcc_read,
+    .write = stm32f100_rcc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
 
 static void stm32f100_soc_initfn(Object *obj)
 {
@@ -66,6 +143,11 @@ static void stm32f100_soc_initfn(Object *obj)
 
     /* Default density. May be overridden by the machine or cmdline option */
     s->density = STM32F100_DENSITY_HIGH;
+
+    memset(&s->rcc, 0, sizeof(s->rcc));
+    s->rcc.cr = 0x00000083;
+    s->rcc.ahbenr = 0x00000014;
+    s->rcc.csr = 0x0C000000;
 }
 
 static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
@@ -168,6 +250,25 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
         sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 
+    /* Declare a simple memory-mapped I/O region for RCC */
+    memory_region_init_io(&s->iomem, OBJECT(dev_soc), &stm32f100_rcc_ops, s,
+                          "STM32F100.mmio.rcc", 0x400);
+    memory_region_add_subregion(system_memory, 0x40021000, &s->iomem);
+
+    /* Declare an I/O region for FSMC */
+    if (s->density == STM32F100_DENSITY_HIGH) {
+        object_initialize_child(OBJECT(dev_soc), "fsmc", &s->fsmc,
+                                TYPE_STM32F1XX_FSMC);
+
+        dev = DEVICE(&s->fsmc);
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->fsmc), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, fsmc_addr);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, fsmc_irq));
+    }
+
     create_unimplemented_device("timer[2]",  0x40000000, 0x400);
     create_unimplemented_device("timer[3]",  0x40000400, 0x400);
     create_unimplemented_device("timer[4]",  0x40000800, 0x400);
@@ -203,7 +304,6 @@ static void stm32f100_soc_realize(DeviceState *dev_soc, Error **errp)
     create_unimplemented_device("timer[17]", 0x40014800, 0x400);
     create_unimplemented_device("DMA1",      0x40020000, 0x400);
     create_unimplemented_device("DMA2",      0x40020400, 0x400);
-    create_unimplemented_device("RCC",       0x40021000, 0x400);
     create_unimplemented_device("Flash Int", 0x40022000, 0x400);
     create_unimplemented_device("CRC",       0x40023000, 0x400);
 }
diff --git a/hw/arm/stm32f1_generic.c b/hw/arm/stm32f1_generic.c
index 63d2a58bdc..6420542f1b 100644
--- a/hw/arm/stm32f1_generic.c
+++ b/hw/arm/stm32f1_generic.c
@@ -30,6 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
+#include "exec/address-spaces.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
 
@@ -38,6 +39,7 @@
 
 static void stm32f1_generic_init(MachineState *machine)
 {
+    MemoryRegion *psram1;
     STM32F100State *s;
     DeviceState *dev;
     Clock *sysclk;
@@ -59,6 +61,16 @@ static void stm32f1_generic_init(MachineState *machine)
     armv7m_load_kernel(ARM_CPU(first_cpu),
                        machine->kernel_filename,
                        0, s->flash_size);
+
+    /* Allow assigning more RAM via FSMC on high-density devices */
+    if (s->density == STM32F100_DENSITY_HIGH) {
+        assert(machine->ram_size <= PSRAM1_SIZE);
+        psram1 = g_new(MemoryRegion, 1);
+        memory_region_init_ram(psram1, NULL, "STM32F1-generic.psram1",
+                               machine->ram_size, &error_fatal);
+        memory_region_add_subregion(get_system_memory(),
+                                    PSRAM1_BASE_ADDRESS, psram1);
+    }
 }
 
 static void stm32f1_generic_machine_init(MachineClass *mc)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index e4c2149175..002d34a123 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -73,6 +73,9 @@ config IMX
     select SSI
     select USB_EHCI_SYSBUS
 
+config STM32F1XX_FSMC
+    bool
+
 config STM32F2XX_SYSCFG
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 78ca857c9d..a0b0786fd3 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -97,6 +97,7 @@ softmmu_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files(
   'xlnx-versal-xramc.c',
   'xlnx-versal-pmc-iou-slcr.c',
 ))
+softmmu_ss.add(when: 'CONFIG_STM32F1XX_FSMC', if_true: files('stm32f1xx_fsmc.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 softmmu_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
diff --git a/hw/misc/stm32f1xx_fsmc.c b/hw/misc/stm32f1xx_fsmc.c
new file mode 100644
index 0000000000..8a9618bb31
--- /dev/null
+++ b/hw/misc/stm32f1xx_fsmc.c
@@ -0,0 +1,155 @@
+/*
+ * STM32F1XX FSMC
+ *
+ * Copyright (c) 2023 Lucas C. Villa Real <lucas@osdyne.com>
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
+#include "hw/misc/stm32f1xx_fsmc.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+
+static void stm32f1xx_fsmc_reset(DeviceState *dev)
+{
+    STM32F1XXFsmcState *s = STM32F1XX_FSMC(dev);
+
+    s->fsmc_bcr[0] = 0x000030DB;
+    for (int i=1; i<4; ++i)
+        s->fsmc_bcr[i] = 0x000030D2;
+    for (int i=0; i<4; ++i) {
+        s->fsmc_btr[i] = 0xffffffff;
+        s->fsmc_bwtr[i] = 0xffffffff;
+    }
+}
+
+static uint64_t stm32f1xx_fsmc_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    STM32F1XXFsmcState *s = opaque;
+
+    switch (addr) {
+    case FSMC_BCR1:
+        return s->fsmc_bcr[0];
+    case FSMC_BCR2:
+        return s->fsmc_bcr[1];
+    case FSMC_BCR3:
+        return s->fsmc_bcr[2];
+    case FSMC_BCR4:
+        return s->fsmc_bcr[3];
+    case FSMC_BTR1:
+        return s->fsmc_btr[0];
+    case FSMC_BTR2:
+        return s->fsmc_btr[1];
+    case FSMC_BTR3:
+        return s->fsmc_btr[2];
+    case FSMC_BTR4:
+        return s->fsmc_btr[3];
+    case FSMC_BWTR1:
+        return s->fsmc_bwtr[0];
+    case FSMC_BWTR2:
+        return s->fsmc_bwtr[1];
+    case FSMC_BWTR3:
+        return s->fsmc_bwtr[2];
+    case FSMC_BWTR4:
+        return s->fsmc_bwtr[3];
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+
+    return 0;
+}
+
+static void stm32f1xx_fsmc_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    STM32F1XXFsmcState *s = opaque;
+    uint32_t value = val64 & 0xffffffff;
+
+    switch (addr) {
+    case FSMC_BCR1:
+        s->fsmc_bcr[0] = value;
+    case FSMC_BCR2:
+        s->fsmc_bcr[1] = value;
+    case FSMC_BCR3:
+        s->fsmc_bcr[2] = value;
+    case FSMC_BCR4:
+        s->fsmc_bcr[3] = value;
+    case FSMC_BTR1:
+        s->fsmc_btr[0] = value;
+    case FSMC_BTR2:
+        s->fsmc_btr[1] = value;
+    case FSMC_BTR3:
+        s->fsmc_btr[2] = value;
+    case FSMC_BTR4:
+        s->fsmc_btr[3] = value;
+    case FSMC_BWTR1:
+        s->fsmc_bwtr[0] = value;
+    case FSMC_BWTR2:
+        s->fsmc_bwtr[1] = value;
+    case FSMC_BWTR3:
+        s->fsmc_bwtr[2] = value;
+    case FSMC_BWTR4:
+        s->fsmc_bwtr[3] = value;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%"HWADDR_PRIx"\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32f1xx_fsmc_ops = {
+    .read = stm32f1xx_fsmc_read,
+    .write = stm32f1xx_fsmc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void stm32f1xx_fsmc_init(Object *obj)
+{
+    STM32F1XXFsmcState *s = STM32F1XX_FSMC(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32f1xx_fsmc_ops, s,
+                          TYPE_STM32F1XX_FSMC, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+}
+
+static void stm32f1xx_fsmc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->reset = stm32f1xx_fsmc_reset;
+}
+
+static const TypeInfo stm32f1xx_fsmc_info = {
+    .name          = TYPE_STM32F1XX_FSMC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(STM32F1XXFsmcState),
+    .instance_init = stm32f1xx_fsmc_init,
+    .class_init    = stm32f1xx_fsmc_class_init,
+};
+
+static void stm32f1xx_fsmc_register_types(void)
+{
+    type_register_static(&stm32f1xx_fsmc_info);
+}
+
+type_init(stm32f1xx_fsmc_register_types)
diff --git a/include/hw/arm/stm32f100_soc.h b/include/hw/arm/stm32f100_soc.h
index 5305e342e3..0ce2439e38 100644
--- a/include/hw/arm/stm32f100_soc.h
+++ b/include/hw/arm/stm32f100_soc.h
@@ -26,6 +26,7 @@
 #define HW_ARM_STM32F100_SOC_H
 
 #include "hw/char/stm32f2xx_usart.h"
+#include "hw/misc/stm32f1xx_fsmc.h"
 #include "hw/ssi/stm32f2xx_spi.h"
 #include "hw/arm/armv7m.h"
 #include "qom/object.h"
@@ -42,8 +43,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(STM32F100State, STM32F100_SOC)
 #define FLASH_SIZE_LD (32 * 1024)
 #define FLASH_SIZE_MD (128 * 1024)
 #define FLASH_SIZE_HD (512 * 1024)
+
 #define SRAM_BASE_ADDRESS 0x20000000
-#define SRAM_SIZE (8 * 1024)
+#define SRAM_SIZE (32 * 1024)
+
+#define PSRAM1_BASE_ADDRESS 0x60000000
+#define PSRAM1_SIZE (256 * 1024 * 1024)
 
 /* Supported density value lines */
 typedef enum {
@@ -52,6 +57,20 @@ typedef enum {
     STM32F100_DENSITY_HIGH,
 } STM32F100Density;
 
+typedef struct {
+    uint32_t cr;
+    uint32_t cfgr;
+    uint32_t cir;
+    uint32_t apb2rstr;
+    uint32_t apb1rstr;
+    uint32_t ahbenr;
+    uint32_t apb2enr;
+    uint32_t apb1enr;
+    uint32_t bdcr;
+    uint32_t csr;
+    uint32_t cfgr2;
+} STM32F1XXRccState;
+
 struct STM32F100State {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -63,10 +82,13 @@ struct STM32F100State {
 
     STM32F2XXUsartState usart[STM_NUM_USARTS];
     STM32F2XXSPIState spi[STM_NUM_SPIS];
+    STM32F1XXFsmcState fsmc;
+    STM32F1XXRccState rcc;
 
     MemoryRegion sram;
     MemoryRegion flash;
     MemoryRegion flash_alias;
+    MemoryRegion iomem;
 
     Clock *sysclk;
     Clock *refclk;
diff --git a/include/hw/misc/stm32f1xx_fsmc.h b/include/hw/misc/stm32f1xx_fsmc.h
new file mode 100644
index 0000000000..1432d2da9e
--- /dev/null
+++ b/include/hw/misc/stm32f1xx_fsmc.h
@@ -0,0 +1,62 @@
+/*
+ * STM32F1xx FSMC
+ *
+ * Copyright (c) 2023 Lucas C. Villa Real <lucas@osdyne.com>
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
+#ifndef HW_STM32F1XX_FSMC_H
+#define HW_STM32F1XX_FSMC_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define FSMC_BCR1  0x000
+#define FSMC_BCR2  0x008
+#define FSMC_BCR3  0x010
+#define FSMC_BCR4  0x018
+#define FSMC_BTR1  0x004
+#define FSMC_BTR2  0x00C
+#define FSMC_BTR3  0x014
+#define FSMC_BTR4  0x01C
+#define FSMC_BWTR1 0x104
+#define FSMC_BWTR2 0x10C
+#define FSMC_BWTR3 0x114
+#define FSMC_BWTR4 0x11C
+#define NUM_BANKS  4
+
+#define TYPE_STM32F1XX_FSMC "stm32f1xx-fsmc"
+OBJECT_DECLARE_SIMPLE_TYPE(STM32F1XXFsmcState, STM32F1XX_FSMC)
+
+struct STM32F1XXFsmcState {
+    /* <private> */
+    SysBusDevice parent_obj;
+
+    /* <public> */
+    MemoryRegion mmio;
+
+    uint32_t fsmc_bcr[NUM_BANKS];
+    uint32_t fsmc_btr[NUM_BANKS];
+    uint32_t fsmc_bwtr[NUM_BANKS];
+
+    qemu_irq irq;
+};
+
+#endif
-- 
2.39.2 (Apple Git-143)


