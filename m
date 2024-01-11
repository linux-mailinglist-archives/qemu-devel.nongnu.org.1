Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8214382ACF7
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssS-0001RV-0Y; Thu, 11 Jan 2024 06:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0001Jz-21
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss1-0004N8-Lz
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3374e332124so4018764f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971108; x=1705575908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bt6pFgMxYQrPt6S3CAwmSz7UkOhzZR/7nCH1KuyRR1Q=;
 b=Tm6HM7zzVDgxu0te0xLm5Q+fhlO4mI4hCETi4ZSKQ3Xlq2m+jfSIIKvVS+DsIUwirT
 RzxzqyjEIUYc/4Xa7VKglXwfEVcqmY5J1WdGt64OumQuvnjy7E6YwBRoF99zFCmiKxrg
 JiMJA9ftTO0cD30s7CG0ezF54SknOf3jTEfxEUt4Sfc8N11/8i9gLXEqu85s8F4Lbc4E
 obU4gkEaD9Lgdhy6yVn9RfoxLJE1YnD11OI7ZKidPn8mD/WdpjZN/W9zPJSp/rckDlyW
 levXERBfofZWu2JxRK/95ARnKv5xGHIsfGgPhIwYjSvHYnZQirJPsyyOFHTtVsm6PyOm
 vmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971108; x=1705575908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bt6pFgMxYQrPt6S3CAwmSz7UkOhzZR/7nCH1KuyRR1Q=;
 b=Ks5sgto+7nC1/HuGG5k9Ri3nYusxNY/ieVGYMNEOVeta7ilvUtAC4lyRcUwMHXnT0C
 97vO1xWRz2e3ELpvFcTj/bkmCbG1HcQRlpdp8KtMbO1FSg1NWDrO69BIvr96wWqbg08f
 SEMYNetK2YY82+GZvtsiVtBmBbDTz/Fd0+P37ELQfGL8I9kGojIvW4ZpITUGxBsYRJ4Z
 G0CGlpnwk5wP8ngGs/mwVKmQLv9U1tOr33+qRnTqxpP4xeAfsTsApg/+noLWxa++KPJr
 ml0AWZSlgeC5Sh1GKiulEIJ0QR7cbiA+H36EAkH2hJI916aKTTG8WnocGwUzDvROIjyt
 jBcA==
X-Gm-Message-State: AOJu0YxDv4KfId2Zy0gQ1OIwDX8chrnbNRJjXmq81bzOyGMQTqo5/dZb
 eno7E4KYaOAybkm4s98xMIQiQElFhPYc8UOzETLmU1gHDbA=
X-Google-Smtp-Source: AGHT+IEICNRpVtWoJ6Hk7d2V75MaRSmQv3xYSpGtrLXEJMlFNgdFZ3tcObb9BYJz/5/Ugkhdp+l/3g==
X-Received: by 2002:a05:6000:504:b0:336:6c0d:b79f with SMTP id
 a4-20020a056000050400b003366c0db79fmr507785wrf.39.1704971108139; 
 Thu, 11 Jan 2024 03:05:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:07 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/41] hw/arm: Add minimal support for the STM32L4x5 SoC
Date: Thu, 11 Jan 2024 11:04:26 +0000
Message-Id: <20240111110505.1563291-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

This patch adds a new STM32L4x5 SoC, it is necessary to add support for
the B-L475E-IOT01A board.
The implementation is derived from the STM32F405 SoC.
The implementation contains no peripherals, only memory regions are
implemented.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240108135849.351719-2-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                    |   8 +
 include/hw/arm/stm32l4x5_soc.h |  57 +++++++
 hw/arm/stm32l4x5_soc.c         | 265 +++++++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |   5 +
 hw/arm/meson.build             |   1 +
 5 files changed, 336 insertions(+)
 create mode 100644 include/hw/arm/stm32l4x5_soc.h
 create mode 100644 hw/arm/stm32l4x5_soc.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00ec1f7ecaf..da29dcc16ec 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1122,6 +1122,14 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/olimex-stm32-h405.c
 
+STM32L4x5 SoC Family
+M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
+M: Inès Varhol <ines.varhol@telecom-paris.fr>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/stm32l4x5_soc.c
+F: include/hw/arm/stm32l4x5_soc.h
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_soc.h
new file mode 100644
index 00000000000..2fd44a36a9d
--- /dev/null
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -0,0 +1,57 @@
+/*
+ * STM32L4x5 SoC family
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is heavily inspired by the stm32f405_soc by Alistair Francis.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm ® -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html
+ */
+
+#ifndef HW_ARM_STM32L4x5_SOC_H
+#define HW_ARM_STM32L4x5_SOC_H
+
+#include "exec/memory.h"
+#include "hw/arm/armv7m.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_SOC "stm32l4x5-soc"
+#define TYPE_STM32L4X5XC_SOC "stm32l4x5xc-soc"
+#define TYPE_STM32L4X5XE_SOC "stm32l4x5xe-soc"
+#define TYPE_STM32L4X5XG_SOC "stm32l4x5xg-soc"
+OBJECT_DECLARE_TYPE(Stm32l4x5SocState, Stm32l4x5SocClass, STM32L4X5_SOC)
+
+struct Stm32l4x5SocState {
+    SysBusDevice parent_obj;
+
+    ARMv7MState armv7m;
+
+    MemoryRegion sram1;
+    MemoryRegion sram2;
+    MemoryRegion flash;
+    MemoryRegion flash_alias;
+
+    Clock *sysclk;
+    Clock *refclk;
+};
+
+struct Stm32l4x5SocClass {
+    SysBusDeviceClass parent_class;
+
+    size_t flash_size;
+};
+
+#endif
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
new file mode 100644
index 00000000000..70609a6dac4
--- /dev/null
+++ b/hw/arm/stm32l4x5_soc.c
@@ -0,0 +1,265 @@
+/*
+ * STM32L4x5 SoC family
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is heavily inspired by the stm32f405_soc by Alistair Francis.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm ® -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/documentation.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/arm/stm32l4x5_soc.h"
+#include "hw/qdev-clock.h"
+#include "hw/misc/unimp.h"
+
+#define FLASH_BASE_ADDRESS 0x08000000
+#define SRAM1_BASE_ADDRESS 0x20000000
+#define SRAM1_SIZE (96 * KiB)
+#define SRAM2_BASE_ADDRESS 0x10000000
+#define SRAM2_SIZE (32 * KiB)
+
+static void stm32l4x5_soc_initfn(Object *obj)
+{
+    Stm32l4x5SocState *s = STM32L4X5_SOC(obj);
+
+    s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
+    s->refclk = qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0);
+}
+
+static void stm32l4x5_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    ERRP_GUARD();
+    Stm32l4x5SocState *s = STM32L4X5_SOC(dev_soc);
+    const Stm32l4x5SocClass *sc = STM32L4X5_SOC_GET_CLASS(dev_soc);
+    MemoryRegion *system_memory = get_system_memory();
+    DeviceState *armv7m;
+
+    /*
+     * We use s->refclk internally and only define it with qdev_init_clock_in()
+     * so it is correctly parented and not leaked on an init/deinit; it is not
+     * intended as an externally exposed clock.
+     */
+    if (clock_has_source(s->refclk)) {
+        error_setg(errp, "refclk clock must not be wired up by the board code");
+        return;
+    }
+
+    if (!clock_has_source(s->sysclk)) {
+        error_setg(errp, "sysclk clock must be wired up by the board code");
+        return;
+    }
+
+    /*
+     * TODO: ideally we should model the SoC RCC and its ability to
+     * change the sysclk frequency and define different sysclk sources.
+     */
+
+    /* The refclk always runs at frequency HCLK / 8 */
+    clock_set_mul_div(s->refclk, 8, 1);
+    clock_set_source(s->refclk, s->sysclk);
+
+    if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
+                                sc->flash_size, errp)) {
+        return;
+    }
+    memory_region_init_alias(&s->flash_alias, OBJECT(dev_soc),
+                             "flash_boot_alias", &s->flash, 0,
+                             sc->flash_size);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, &s->flash);
+    memory_region_add_subregion(system_memory, 0, &s->flash_alias);
+
+    if (!memory_region_init_ram(&s->sram1, OBJECT(dev_soc), "SRAM1", SRAM1_SIZE,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM1_BASE_ADDRESS, &s->sram1);
+
+    if (!memory_region_init_ram(&s->sram2, OBJECT(dev_soc), "SRAM2", SRAM2_SIZE,
+                                errp)) {
+        return;
+    }
+    memory_region_add_subregion(system_memory, SRAM2_BASE_ADDRESS, &s->sram2);
+
+    object_initialize_child(OBJECT(dev_soc), "armv7m", &s->armv7m, TYPE_ARMV7M);
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m4"));
+    qdev_prop_set_bit(armv7m, "enable-bitband", true);
+    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
+    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    object_property_set_link(OBJECT(&s->armv7m), "memory",
+                             OBJECT(system_memory), &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
+        return;
+    }
+
+    /* APB1 BUS */
+    create_unimplemented_device("TIM2",      0x40000000, 0x400);
+    create_unimplemented_device("TIM3",      0x40000400, 0x400);
+    create_unimplemented_device("TIM4",      0x40000800, 0x400);
+    create_unimplemented_device("TIM5",      0x40000C00, 0x400);
+    create_unimplemented_device("TIM6",      0x40001000, 0x400);
+    create_unimplemented_device("TIM7",      0x40001400, 0x400);
+    /* RESERVED:    0x40001800, 0x1000 */
+    create_unimplemented_device("RTC",       0x40002800, 0x400);
+    create_unimplemented_device("WWDG",      0x40002C00, 0x400);
+    create_unimplemented_device("IWDG",      0x40003000, 0x400);
+    /* RESERVED:    0x40001800, 0x400 */
+    create_unimplemented_device("SPI2",      0x40003800, 0x400);
+    create_unimplemented_device("SPI3",      0x40003C00, 0x400);
+    /* RESERVED:    0x40004000, 0x400 */
+    create_unimplemented_device("USART2",    0x40004400, 0x400);
+    create_unimplemented_device("USART3",    0x40004800, 0x400);
+    create_unimplemented_device("UART4",     0x40004C00, 0x400);
+    create_unimplemented_device("UART5",     0x40005000, 0x400);
+    create_unimplemented_device("I2C1",      0x40005400, 0x400);
+    create_unimplemented_device("I2C2",      0x40005800, 0x400);
+    create_unimplemented_device("I2C3",      0x40005C00, 0x400);
+    /* RESERVED:    0x40006000, 0x400 */
+    create_unimplemented_device("CAN1",      0x40006400, 0x400);
+    /* RESERVED:    0x40006800, 0x400 */
+    create_unimplemented_device("PWR",       0x40007000, 0x400);
+    create_unimplemented_device("DAC1",      0x40007400, 0x400);
+    create_unimplemented_device("OPAMP",     0x40007800, 0x400);
+    create_unimplemented_device("LPTIM1",    0x40007C00, 0x400);
+    create_unimplemented_device("LPUART1",   0x40008000, 0x400);
+    /* RESERVED:    0x40008400, 0x400 */
+    create_unimplemented_device("SWPMI1",    0x40008800, 0x400);
+    /* RESERVED:    0x40008C00, 0x800 */
+    create_unimplemented_device("LPTIM2",    0x40009400, 0x400);
+    /* RESERVED:    0x40009800, 0x6800 */
+
+    /* APB2 BUS */
+    create_unimplemented_device("SYSCFG",    0x40010000, 0x30);
+    create_unimplemented_device("VREFBUF",   0x40010030, 0x1D0);
+    create_unimplemented_device("COMP",      0x40010200, 0x200);
+    create_unimplemented_device("EXTI",      0x40010400, 0x400);
+    /* RESERVED:    0x40010800, 0x1400 */
+    create_unimplemented_device("FIREWALL",  0x40011C00, 0x400);
+    /* RESERVED:    0x40012000, 0x800 */
+    create_unimplemented_device("SDMMC1",    0x40012800, 0x400);
+    create_unimplemented_device("TIM1",      0x40012C00, 0x400);
+    create_unimplemented_device("SPI1",      0x40013000, 0x400);
+    create_unimplemented_device("TIM8",      0x40013400, 0x400);
+    create_unimplemented_device("USART1",    0x40013800, 0x400);
+    /* RESERVED:    0x40013C00, 0x400 */
+    create_unimplemented_device("TIM15",     0x40014000, 0x400);
+    create_unimplemented_device("TIM16",     0x40014400, 0x400);
+    create_unimplemented_device("TIM17",     0x40014800, 0x400);
+    /* RESERVED:    0x40014C00, 0x800 */
+    create_unimplemented_device("SAI1",      0x40015400, 0x400);
+    create_unimplemented_device("SAI2",      0x40015800, 0x400);
+    /* RESERVED:    0x40015C00, 0x400 */
+    create_unimplemented_device("DFSDM1",    0x40016000, 0x400);
+    /* RESERVED:    0x40016400, 0x9C00 */
+
+    /* AHB1 BUS */
+    create_unimplemented_device("DMA1",      0x40020000, 0x400);
+    create_unimplemented_device("DMA2",      0x40020400, 0x400);
+    /* RESERVED:    0x40020800, 0x800 */
+    create_unimplemented_device("RCC",       0x40021000, 0x400);
+    /* RESERVED:    0x40021400, 0xC00 */
+    create_unimplemented_device("FLASH",     0x40022000, 0x400);
+    /* RESERVED:    0x40022400, 0xC00 */
+    create_unimplemented_device("CRC",       0x40023000, 0x400);
+    /* RESERVED:    0x40023400, 0x400 */
+    create_unimplemented_device("TSC",       0x40024000, 0x400);
+
+    /* RESERVED:    0x40024400, 0x7FDBC00 */
+
+    /* AHB2 BUS */
+    create_unimplemented_device("GPIOA",     0x48000000, 0x400);
+    create_unimplemented_device("GPIOB",     0x48000400, 0x400);
+    create_unimplemented_device("GPIOC",     0x48000800, 0x400);
+    create_unimplemented_device("GPIOD",     0x48000C00, 0x400);
+    create_unimplemented_device("GPIOE",     0x48001000, 0x400);
+    create_unimplemented_device("GPIOF",     0x48001400, 0x400);
+    create_unimplemented_device("GPIOG",     0x48001800, 0x400);
+    create_unimplemented_device("GPIOH",     0x48001C00, 0x400);
+    /* RESERVED:    0x48002000, 0x7FDBC00 */
+    create_unimplemented_device("OTG_FS",    0x50000000, 0x40000);
+    create_unimplemented_device("ADC",       0x50040000, 0x400);
+    /* RESERVED:    0x50040400, 0x20400 */
+    create_unimplemented_device("RNG",       0x50060800, 0x400);
+
+    /* AHB3 BUS */
+    create_unimplemented_device("FMC",       0xA0000000, 0x1000);
+    create_unimplemented_device("QUADSPI",   0xA0001000, 0x400);
+}
+
+static void stm32l4x5_soc_class_init(ObjectClass *klass, void *data)
+{
+
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = stm32l4x5_soc_realize;
+    /* Reason: Mapped at fixed location on the system bus */
+    dc->user_creatable = false;
+    /* No vmstate or reset required: device has no internal state */
+}
+
+static void stm32l4x5xc_soc_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
+
+    ssc->flash_size = 256 * KiB;
+}
+
+static void stm32l4x5xe_soc_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
+
+    ssc->flash_size = 512 * KiB;
+}
+
+static void stm32l4x5xg_soc_class_init(ObjectClass *oc, void *data)
+{
+    Stm32l4x5SocClass *ssc = STM32L4X5_SOC_CLASS(oc);
+
+    ssc->flash_size = 1 * MiB;
+}
+
+static const TypeInfo stm32l4x5_soc_types[] = {
+    {
+        .name           = TYPE_STM32L4X5XC_SOC,
+        .parent         = TYPE_STM32L4X5_SOC,
+        .class_init     = stm32l4x5xc_soc_class_init,
+    }, {
+        .name           = TYPE_STM32L4X5XE_SOC,
+        .parent         = TYPE_STM32L4X5_SOC,
+        .class_init     = stm32l4x5xe_soc_class_init,
+    }, {
+        .name           = TYPE_STM32L4X5XG_SOC,
+        .parent         = TYPE_STM32L4X5_SOC,
+        .class_init     = stm32l4x5xg_soc_class_init,
+    }, {
+        .name           = TYPE_STM32L4X5_SOC,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(Stm32l4x5SocState),
+        .instance_init  = stm32l4x5_soc_initfn,
+        .class_size     = sizeof(Stm32l4x5SocClass),
+        .class_init     = stm32l4x5_soc_class_init,
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(stm32l4x5_soc_types)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index b853577e725..5f9780bbceb 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -449,6 +449,11 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config STM32L4X5_SOC
+    bool
+    select ARM_V7M
+    select OR_IRQ
+
 config XLNX_ZYNQMP_ARM
     bool
     default y if PIXMAN
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68245d3ad10..9766da10c48 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
 arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
 arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
-- 
2.34.1


