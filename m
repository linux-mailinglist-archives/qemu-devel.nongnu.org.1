Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B1370627C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCGk-0005iV-AD; Wed, 17 May 2023 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGe-0005eN-T5; Wed, 17 May 2023 04:12:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pzCGb-0003II-Sm; Wed, 17 May 2023 04:12:16 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f42bcf5df1so4349095e9.3; 
 Wed, 17 May 2023 01:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684311132; x=1686903132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4H4TLD9Tgw1VSAkuUmuXqvaTIifJo+7xd82yABLyRs=;
 b=Q6CgS3RdJX4L3572tZ7hyDZT20H59gptV8LYkmDrFakNfF5OULVIRmIOSRlcrjH3B/
 Ytk0BLqDyKaQ0pIFqkkmuxmd87aPDvM4dGXINjlTm9RLyDdDSi0q1700Xm0O9v/z1SFr
 QOQC39ZSHq3CHfGA4XAtAZa2P9+9J3kStGRAMF/HAg2fS6FTXChV3rokLspND1L+xCcI
 AA6oCiuY6tb10YhK11n2DY/DxIj4t6HKCZpDFNSIBdRuY0TntCMsEd2OhoP1XcLxo74K
 drhYiMh2UTJUwdZsS0PfUqIZQm4hPVcob7x5wyXxg7rL6TbwgjrlLpNagvI2DCpRsQLH
 WQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684311132; x=1686903132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4H4TLD9Tgw1VSAkuUmuXqvaTIifJo+7xd82yABLyRs=;
 b=ktRr+Vl+jKzkncLrHKxCs5Yc2nTsE98E+l3KkM+nm7Rvmg+c8oCuGSscisfV6xOoVF
 +Uyo4eXFFNAMsXXZJxzavwmoyciZ6Ca3YeknKAZQwIYg02caYlSXocM9g+zCFNmZr0Oo
 ikK6O5ylpeYqI6sxI0nhcTdORLtf1H7UTw4HzTqSwmoCs0KLGhd7xgzjZHCAIoOG+p1p
 Kn75rMmYyZRa/TTHb2oc3e5DFPTvI1SUL+yTvymm2k7uzTt54fzzABzEYG6kwTj0U6MY
 frEE8XF+Gvp0I5dEq9zWg/Pw7nygoib51bLwI9gFG9GxkFaMBsMl6vKULbb9rhQeoZeo
 CF+w==
X-Gm-Message-State: AC+VfDzXKIRYvUFcM20HqE5h2W2nINryqA2DgBlCxz17s66vq0IXvEg4
 G5WGsOtsJNOsE/kxgNfa/dUBdVPJpahnHA==
X-Google-Smtp-Source: ACHHUZ6MvVvXolK68xNPIRc/MMQN7673B8iHiyyMbSTZLphXrvefN/+CqR3zyhTYREAMxBUDgjS3RQ==
X-Received: by 2002:a05:600c:3787:b0:3f4:2775:3f89 with SMTP id
 o7-20020a05600c378700b003f427753f89mr21813453wmr.35.1684311131419; 
 Wed, 17 May 2023 01:12:11 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 o24-20020a1c7518000000b003f42158288dsm1414942wmc.20.2023.05.17.01.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:12:11 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PATCH 1/8] The tivac board initial machine definition
Date: Wed, 17 May 2023 11:11:57 +0300
Message-Id: <20230517081204.30333-2-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517081204.30333-1-m.elsayed4420@gmail.com>
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
---
 hw/arm/tivac.c                    |  56 ++++++
 hw/arm/tm4c123gh6pm_soc.c         | 275 ++++++++++++++++++++++++++++++
 include/hw/arm/tm4c123gh6pm_soc.h |  71 ++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 hw/arm/tivac.c
 create mode 100644 hw/arm/tm4c123gh6pm_soc.c
 create mode 100644 include/hw/arm/tm4c123gh6pm_soc.h

diff --git a/hw/arm/tivac.c b/hw/arm/tivac.c
new file mode 100644
index 0000000000..5d917a8f9e
--- /dev/null
+++ b/hw/arm/tivac.c
@@ -0,0 +1,56 @@
+/*
+ * TivaC Board Implementation
+ *
+ * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
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
+#include "hw/arm/tm4c123gh6pm_soc.h"
+#include "hw/arm/boot.h"
+
+
+/* Main SYSCLK frequency in Hz (24MHz) */
+#define SYSCLK_FRQ 24000000ULL
+
+static void tivac_init(MachineState *machine)
+{
+    DeviceState *dev;
+    dev = qdev_new(TYPE_TM4C123GH6PM_SOC);
+
+    qdev_prop_set_string(dev, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+            machine->kernel_filename,
+            0, FLASH_SIZE);
+}
+
+static void tivac_machine_init(MachineClass *mc)
+{
+    mc->desc = "Tiva C (Cortex-M4)";
+    mc->init = tivac_init;
+}
+DEFINE_MACHINE("tivac", tivac_machine_init)
diff --git a/hw/arm/tm4c123gh6pm_soc.c b/hw/arm/tm4c123gh6pm_soc.c
new file mode 100644
index 0000000000..3e61911bba
--- /dev/null
+++ b/hw/arm/tm4c123gh6pm_soc.c
@@ -0,0 +1,275 @@
+/*
+ * TM4C123GH6PM SoC
+ *
+ * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
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
+#include "qemu/module.h"
+#include "hw/arm/boot.h"
+#include "exec/address-spaces.h"
+#include "hw/arm/tm4c123gh6pm_soc.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+#include "sysemu/sysemu.h"
+
+static const uint32_t gpio_addrs[GPIO_COUNT] = {
+    0x40004000,
+    0x40005000,
+    0x40006000,
+    0x40007000,
+    0x40024000,
+    0x40025000
+};
+
+static const uint32_t usart_addrs[USART_COUNT] = {
+    0x4000C000,
+    0x4000D000,
+    0x4000E000,
+    0x4000F000,
+    0x40010000,
+    0x40011000,
+    0x40012000,
+    0x40013000
+};
+
+static const uint32_t wdt_addrs[WDT_COUNT] = {
+    0x40000000,
+    0x40001000
+};
+
+static const uint32_t gptm_addrs[GPTM_COUNT] = {
+    0x40030000,
+    0x40031000,
+    0x40032000,
+    0x40033000,
+    0x40034000,
+    0x40035000,
+    0x40036000,
+    0x40037000,
+    0x4003C800,
+    0x4003D000,
+    0x4003E000,
+    0x4003F000,
+};
+
+static const uint16_t usart_irqs[USART_COUNT] = {5, 6, 33, 59, 60, 61, 62, 63};
+static const uint16_t gpio_irqs[GPIO_COUNT] = {0, 1, 2, 3, 4, 30};
+static const uint16_t wdt_irqs[WDT_COUNT] = {18, 18};
+static const uint16_t gptm_irqs[GPTM_COUNT * 2] = {
+    19, 20, 21, 22, 23, 24, 35, 36, 70, 71, 92, 93,
+    94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105};
+
+static void tm4c123gh6pm_soc_initfn(Object *obj)
+{
+    int i;
+    TM4C123GH6PMState *s = TM4C123GH6PM_SOC(obj);
+
+    object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
+    object_initialize_child(obj, "sysctl", &s->sysctl, TYPE_TM4C123_SYSCTL);
+
+    for (i = 0; i < USART_COUNT; i++) {
+        object_initialize_child(obj, "usart[*]",
+                                &s->usart[i], TYPE_TM4C123_USART);
+    }
+
+    for (i = 0; i < GPIO_COUNT; i++) {
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_TM4C123_GPIO);
+    }
+
+    for (i = 0; i < WDT_COUNT; i++) {
+        object_initialize_child(obj, "watchdog-timer[*]",
+                                &s->wdt[i], TYPE_TM4C123_WATCHDOG);
+    }
+
+    for (i = 0; i < GPTM_COUNT; i++) {
+        object_initialize_child(obj, "gptm[*]", &s->gptm[i], TYPE_TM4C123_GPTM);
+    }
+}
+
+static void tm4c123gh6pm_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    TM4C123GH6PMState *s = TM4C123GH6PM_SOC(dev_soc);
+    DeviceState *armv7m;
+    DeviceState *dev;
+    SysBusDevice *busdev;
+    int i;
+
+    MemoryRegion *system_memory = get_system_memory();
+
+    /* init flash memory */
+    memory_region_init_rom(
+            &s->flash, OBJECT(dev_soc),
+            "TM4C123GH6PM.flash", FLASH_SIZE, &error_fatal
+            );
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+
+    /* init sram and the sram alias region */
+    memory_region_init_ram(
+            &s->sram, OBJECT(dev_soc),
+            "TM4C123GH6PM.sram", SRAM_SIZE, &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, &s->sram);
+
+    /* Init ARMv7m */
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 138);
+    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysctl.mainclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->sysctl.mainclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+            OBJECT(get_system_memory()), &error_abort);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    /* USART */
+    for (i = 0; i < USART_COUNT; i++) {
+        dev = DEVICE(&(s->usart[i]));
+        s->usart[i].sysctl = &s->sysctl;
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->usart[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, usart_addrs[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irqs[i]));
+    }
+
+    /* GPIO */
+    for (i = 0; i < GPIO_COUNT; i++) {
+        dev = DEVICE(&(s->gpio[i]));
+        s->gpio[i].sysctl = &s->sysctl;
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, gpio_addrs[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, gpio_irqs[i]));
+    }
+
+    /* Watchdog Timers */
+    for (i = 0; i < WDT_COUNT; i++) {
+        dev = DEVICE(&(s->wdt[i]));
+        s->wdt[i].sysctl = &s->sysctl;
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, wdt_addrs[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, wdt_irqs[i]));
+    }
+
+    /* General purpose timers */
+    int j = 0;
+    for (i = 0, j = 0; i < GPTM_COUNT; i++, j += 2) {
+        dev = DEVICE(&(s->gptm[i]));
+        s->gptm[i].sysctl = &s->sysctl;
+        if (!sysbus_realize(SYS_BUS_DEVICE(&s->gptm[i]), errp)) {
+            return;
+        }
+        busdev = SYS_BUS_DEVICE(dev);
+        sysbus_mmio_map(busdev, 0, gptm_addrs[i]);
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, gptm_irqs[j]));
+        sysbus_connect_irq(busdev, 1, qdev_get_gpio_in(armv7m, gptm_irqs[j + 1]));
+    }
+
+    /* SYSCTL */
+    dev = DEVICE(&(s->sysctl));
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->sysctl), errp)) {
+        return;
+    }
+    busdev = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(busdev, 0, SYSCTL_ADDR);
+
+
+    create_unimplemented_device("SSI_0", 0x40008000, 0xFFF);
+    create_unimplemented_device("SSI_1", 0x40009000, 0xFFF);
+    create_unimplemented_device("SSI_2", 0x4000A000, 0xFFF);
+    create_unimplemented_device("SSI_3", 0x4000B000, 0xFFF);
+
+    create_unimplemented_device("I2C_0", 0x40020000, 0xFFF);
+    create_unimplemented_device("I2C_1", 0x40021000, 0xFFF);
+    create_unimplemented_device("I2C_2", 0x40022000, 0xFFF);
+    create_unimplemented_device("I2C_3", 0x40023000, 0xFFF);
+
+    create_unimplemented_device("PWM_0", 0x40028000, 0xFFF);
+    create_unimplemented_device("PWM_1", 0x40029000, 0xFFF);
+
+    create_unimplemented_device("QEI_0", 0x4002C000, 0xFFF);
+    create_unimplemented_device("QEI_1", 0x4002D000, 0xFFF);
+
+    create_unimplemented_device("ADC_0", 0x40038000, 0xFFF);
+    create_unimplemented_device("ADC_1", 0x40039000, 0xFFF);
+
+    create_unimplemented_device("ANALOG_CMP", 0x4003C000, 0xFFF);
+
+    create_unimplemented_device("CAN_0", 0x40040000, 0xFFF);
+    create_unimplemented_device("CAN_1", 0x40041000, 0xFFF);
+
+    create_unimplemented_device("USB", 0x40050000, 0xFFF);
+
+    create_unimplemented_device("GPIO_A_AHB", 0x40058000, 0xFFF);
+    create_unimplemented_device("GPIO_B_AHB", 0x40059000, 0xFFF);
+    create_unimplemented_device("GPIO_C_AHB", 0x4005A000, 0xFFF);
+    create_unimplemented_device("GPIO_D_AHB", 0x4005B000, 0xFFF);
+    create_unimplemented_device("GPIO_E_AHB", 0x4005C000, 0xFFF);
+    create_unimplemented_device("GPIO_F_AHB", 0x4005D000, 0xFFF);
+
+    create_unimplemented_device("EEPROM", 0x400AF000, 0xFFF);
+    create_unimplemented_device("SYS_EXC", 0x400F9000, 0xFFF);
+    create_unimplemented_device("HIBERNATION_MOD", 0x400FC000, 0xFFF);
+    create_unimplemented_device("FLASH_CONT", 0x400FD000, 0xFFF);
+    create_unimplemented_device("SYS_CONT", 0x400FE000, 0xFFF);
+
+    create_unimplemented_device("uDMA", 0x400FF000, 0xFFF);
+}
+
+static Property tm4c123gh6pm_soc_properties[] = {
+    DEFINE_PROP_STRING("cpu-type", TM4C123GH6PMState, cpu_type),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tm4c123gh6pm_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = tm4c123gh6pm_soc_realize;
+    device_class_set_props(dc, tm4c123gh6pm_soc_properties);
+}
+
+static const TypeInfo tm4c123gh6pm_soc_info = {
+    .name          = TYPE_TM4C123GH6PM_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TM4C123GH6PMState),
+    .instance_init = tm4c123gh6pm_soc_initfn,
+    .class_init    = tm4c123gh6pm_soc_class_init,
+};
+
+static void tm4c123gh6pm_soc_types(void)
+{
+    type_register_static(&tm4c123gh6pm_soc_info);
+}
+
+type_init(tm4c123gh6pm_soc_types)
diff --git a/include/hw/arm/tm4c123gh6pm_soc.h b/include/hw/arm/tm4c123gh6pm_soc.h
new file mode 100644
index 0000000000..1841483a78
--- /dev/null
+++ b/include/hw/arm/tm4c123gh6pm_soc.h
@@ -0,0 +1,71 @@
+/*
+ * TM4C123GH6PM SoC
+ *
+ * Copyright (c) 2023 Mohamed ElSayed <m.elsayed4420@gmail.com>
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
+#ifndef HW_ARM_TM4C123GH6PM_SOC_H
+#define HW_ARM_TM4C123GH6PM_SOC_H
+
+#include "hw/arm/armv7m.h"
+#include "qom/object.h"
+#include "hw/clock.h"
+#include "hw/char/tm4c123_usart.h"
+#include "hw/misc/tm4c123_sysctl.h"
+#include "hw/gpio/tm4c123_gpio.h"
+#include "hw/watchdog/tm4c123_watchdog.h"
+#include "hw/timer/tm4c123_gptm.h"
+
+#define TYPE_TM4C123GH6PM_SOC "tm4c123gh6pm-soc"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TM4C123GH6PMState, TM4C123GH6PM_SOC)
+
+#define FLASH_BASE_ADDRESS 0x00000000
+#define FLASH_SIZE (256 * 1024)
+#define SRAM_BASE_ADDRESS 0x20000000
+#define SRAM_SIZE (32 * 1024)
+
+#define SYSCTL_ADDR 0x400FE000
+
+#define USART_COUNT 8
+#define GPIO_COUNT 6
+#define WDT_COUNT 2
+#define GPTM_COUNT 12
+
+struct TM4C123GH6PMState {
+    SysBusDevice parent_obj;
+
+    char *cpu_type;
+
+    ARMv7MState armv7m;
+
+    TM4C123USARTState usart[USART_COUNT];
+    TM4C123SysCtlState sysctl;
+    TM4C123GPIOState gpio[GPIO_COUNT];
+    TM4C123WatchdogState wdt[WDT_COUNT];
+    TM4C123GPTMState gptm[GPTM_COUNT];
+
+    MemoryRegion sram;
+    MemoryRegion alias_region;
+    MemoryRegion flash;
+};
+
+#endif
-- 
2.34.1


