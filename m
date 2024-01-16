Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11D482F127
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:14:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7G-0006cd-Bf; Tue, 16 Jan 2024 10:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7E-0006ba-13
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7A-0005pT-Cr
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40e69b3149fso43422825e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417951; x=1706022751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dC6OZe1+HIS56y3mIpb8eva6rU71DiVV1enzLIhFmJY=;
 b=geBPqfUtso20jeVIOw6JvXIutekuhMlhBYApqTPxGVv1HS9So0vLhWtz7bDFXKURFI
 UFWH+s1l9a8EpN1nGmGm/+PsgC52vL7FVAFPXpkxn09dBmImaEuELupKhIi+/VvKiHnG
 cMQOW78HanUkwtFU8H9CrdPQH9mbGskm0fjm8LdTolADUEjS29bVwAipiVq/iinS6gMc
 d0oBF4XVrX5tZfCZgkdHwTjT+zT5+W7OHT1b3Ad5Hp8BSktJEYeaneOa3n+tuc1xd3zU
 H8ZxAewi3/gWCtRqiHb0d/V8qLmtU5nzOWwB5+TOfXo7C3Wes4yxk+vzOt4OMS1+MGTt
 hRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417951; x=1706022751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dC6OZe1+HIS56y3mIpb8eva6rU71DiVV1enzLIhFmJY=;
 b=mGfBvjZDgKy1QBFMYUrHDLoRc0s3PDYrGE4IHbznkLUbjc4ytZUP4jhL9s7IcVqBLy
 ajt2Myfeuvg9Plt/INee8FIvSuCETPPzn0rMB8VO8vSxoz49i4Vc7yBWp5mi99Bd9vBL
 3bkO3mND8qiB1VqqxgNZMmxYSKAHSiTpjDA3OuMTb0yt3F/AwzUx9R6sxSai/c3/i0wJ
 I8x0as7wc3RYUUe4C1nIkz3SFCsb6XuTQdNc3lCcksyKlWYxEGDsF+dlGVD8SUiNmx+i
 s0ilgBGrYHOy1efkvZPYdf8A4XSi/M0ZKiSSQbIraaykLcH3LCHbjzBWkqxzOHqM8cbr
 Utzg==
X-Gm-Message-State: AOJu0Ywn7tOgJGfP/fnQXdwrYRpwPsuUKJQ5AP3ZwUEoq6e2oYqBUHQz
 GF55WPZfWsIfI9I7AEY2artzHN1/xDmxRtflNMcwqwfKjWM=
X-Google-Smtp-Source: AGHT+IHJAVrmycJjHS3ECk9Ym8mYGWtk/zCRJw0cCK4EIpO8bMzMfMGxDS30etcmuhEcRZAU4pmeKQ==
X-Received: by 2002:a05:600c:2e05:b0:40e:6ea4:bf57 with SMTP id
 o5-20020a05600c2e0500b0040e6ea4bf57mr2926687wmf.126.1705417950925; 
 Tue, 16 Jan 2024 07:12:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/21] hw/misc: Implement STM32L4x5 EXTI
Date: Tue, 16 Jan 2024 15:12:11 +0000
Message-Id: <20240116151228.2430754-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Although very similar to the STM32F4xx EXTI, STM32L4x5 EXTI generates
more than 32 event/interrupt requests and thus uses more registers
than STM32F4xx EXTI which generates 23 event/interrupt requests.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240109160658.311932-2-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/b-l475e-iot01a.rst |   5 +-
 include/hw/misc/stm32l4x5_exti.h   |  51 +++++
 hw/misc/stm32l4x5_exti.c           | 290 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   5 +
 6 files changed, 352 insertions(+), 3 deletions(-)
 create mode 100644 include/hw/misc/stm32l4x5_exti.h
 create mode 100644 hw/misc/stm32l4x5_exti.c

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 2b128e6b847..72f256ace75 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -12,17 +12,16 @@ USART, I2C, SPI, CAN and USB OTG, as well as a variety of sensors.
 Supported devices
 """""""""""""""""
 
-Currently, B-L475E-IOT01A machine's implementation is minimal,
-it only supports the following device:
+Currently B-L475E-IOT01A machine's only supports the following devices:
 
 - Cortex-M4F based STM32L4x5 SoC
+- STM32L4x5 EXTI (Extended interrupts and events controller)
 
 Missing devices
 """""""""""""""
 
 The B-L475E-IOT01A does *not* support the following devices:
 
-- Extended interrupts and events controller (EXTI)
 - Reset and clock control (RCC)
 - Serial ports (UART)
 - System configuration controller (SYSCFG)
diff --git a/include/hw/misc/stm32l4x5_exti.h b/include/hw/misc/stm32l4x5_exti.h
new file mode 100644
index 00000000000..be961d2f01f
--- /dev/null
+++ b/include/hw/misc/stm32l4x5_exti.h
@@ -0,0 +1,51 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_exti by Alistair Francis.
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
+#ifndef HW_STM32L4X5_EXTI_H
+#define HW_STM32L4X5_EXTI_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_EXTI "stm32l4x5-exti"
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5ExtiState, STM32L4X5_EXTI)
+
+#define EXTI_NUM_INTERRUPT_OUT_LINES 40
+#define EXTI_NUM_REGISTER 2
+
+struct Stm32l4x5ExtiState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t imr[EXTI_NUM_REGISTER];
+    uint32_t emr[EXTI_NUM_REGISTER];
+    uint32_t rtsr[EXTI_NUM_REGISTER];
+    uint32_t ftsr[EXTI_NUM_REGISTER];
+    uint32_t swier[EXTI_NUM_REGISTER];
+    uint32_t pr[EXTI_NUM_REGISTER];
+
+    qemu_irq irq[EXTI_NUM_INTERRUPT_OUT_LINES];
+};
+
+#endif
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
new file mode 100644
index 00000000000..9fd859160d4
--- /dev/null
+++ b/hw/misc/stm32l4x5_exti.c
@@ -0,0 +1,290 @@
+/*
+ * STM32L4x5 EXTI (Extended interrupts and events controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_exti by Alistair Francis.
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
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/stm32l4x5_exti.h"
+
+#define EXTI_IMR1   0x00
+#define EXTI_EMR1   0x04
+#define EXTI_RTSR1  0x08
+#define EXTI_FTSR1  0x0C
+#define EXTI_SWIER1 0x10
+#define EXTI_PR1    0x14
+#define EXTI_IMR2   0x20
+#define EXTI_EMR2   0x24
+#define EXTI_RTSR2  0x28
+#define EXTI_FTSR2  0x2C
+#define EXTI_SWIER2 0x30
+#define EXTI_PR2    0x34
+
+#define EXTI_NUM_GPIO_EVENT_IN_LINES 16
+#define EXTI_MAX_IRQ_PER_BANK 32
+#define EXTI_IRQS_BANK0  32
+#define EXTI_IRQS_BANK1  8
+
+static const unsigned irqs_per_bank[EXTI_NUM_REGISTER] = {
+    EXTI_IRQS_BANK0,
+    EXTI_IRQS_BANK1,
+};
+
+static const uint32_t exti_romask[EXTI_NUM_REGISTER] = {
+    0xff820000, /* 0b11111111_10000010_00000000_00000000 */
+    0x00000087, /* 0b00000000_00000000_00000000_10000111 */
+};
+
+static unsigned regbank_index_by_irq(unsigned irq)
+{
+     return irq >= EXTI_MAX_IRQ_PER_BANK ? 1 : 0;
+}
+
+static unsigned regbank_index_by_addr(hwaddr addr)
+{
+     return addr >= EXTI_IMR2 ? 1 : 0;
+}
+
+static unsigned valid_mask(unsigned bank)
+{
+     return MAKE_64BIT_MASK(0, irqs_per_bank[bank]);
+}
+
+static unsigned configurable_mask(unsigned bank)
+{
+     return valid_mask(bank) & ~exti_romask[bank];
+}
+
+static void stm32l4x5_exti_reset_hold(Object *obj)
+{
+    Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);
+
+    for (unsigned bank = 0; bank < EXTI_NUM_REGISTER; bank++) {
+        s->imr[bank] = exti_romask[bank];
+        s->emr[bank] = 0x00000000;
+        s->rtsr[bank] = 0x00000000;
+        s->ftsr[bank] = 0x00000000;
+        s->swier[bank] = 0x00000000;
+        s->pr[bank] = 0x00000000;
+    }
+}
+
+static void stm32l4x5_exti_set_irq(void *opaque, int irq, int level)
+{
+    Stm32l4x5ExtiState *s = opaque;
+    const unsigned bank = regbank_index_by_irq(irq);
+    const int oirq = irq;
+
+    trace_stm32l4x5_exti_set_irq(irq, level);
+
+    /* Shift the value to enable access in x2 registers. */
+    irq %= EXTI_MAX_IRQ_PER_BANK;
+
+    /* If the interrupt is masked, pr won't be raised */
+    if (!extract32(s->imr[bank], irq, 1)) {
+        return;
+    }
+
+    if (((1 << irq) & s->rtsr[bank]) && level) {
+        /* Rising Edge */
+        s->pr[bank] |= 1 << irq;
+        qemu_irq_pulse(s->irq[oirq]);
+    } else if (((1 << irq) & s->ftsr[bank]) && !level) {
+        /* Falling Edge */
+        s->pr[bank] |= 1 << irq;
+        qemu_irq_pulse(s->irq[oirq]);
+    }
+    /*
+     * In the following situations :
+     * - falling edge but rising trigger selected
+     * - rising edge but falling trigger selected
+     * - no trigger selected
+     * No action is required
+     */
+}
+
+static uint64_t stm32l4x5_exti_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Stm32l4x5ExtiState *s = opaque;
+    uint32_t r = 0;
+    const unsigned bank = regbank_index_by_addr(addr);
+
+    switch (addr) {
+    case EXTI_IMR1:
+    case EXTI_IMR2:
+        r = s->imr[bank];
+        break;
+    case EXTI_EMR1:
+    case EXTI_EMR2:
+        r = s->emr[bank];
+        break;
+    case EXTI_RTSR1:
+    case EXTI_RTSR2:
+        r = s->rtsr[bank];
+        break;
+    case EXTI_FTSR1:
+    case EXTI_FTSR2:
+        r = s->ftsr[bank];
+        break;
+    case EXTI_SWIER1:
+    case EXTI_SWIER2:
+        r = s->swier[bank];
+        break;
+    case EXTI_PR1:
+    case EXTI_PR2:
+        r = s->pr[bank];
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32L4X5_exti_read: Bad offset 0x%" HWADDR_PRIx "\n",
+                      addr);
+        break;
+    }
+
+    trace_stm32l4x5_exti_read(addr, r);
+
+    return r;
+}
+
+static void stm32l4x5_exti_write(void *opaque, hwaddr addr,
+                                 uint64_t val64, unsigned int size)
+{
+    Stm32l4x5ExtiState *s = opaque;
+    const unsigned bank = regbank_index_by_addr(addr);
+
+    trace_stm32l4x5_exti_write(addr, val64);
+
+    switch (addr) {
+    case EXTI_IMR1:
+    case EXTI_IMR2:
+        s->imr[bank] = val64 & valid_mask(bank);
+        return;
+    case EXTI_EMR1:
+    case EXTI_EMR2:
+        s->emr[bank] = val64 & valid_mask(bank);
+        return;
+    case EXTI_RTSR1:
+    case EXTI_RTSR2:
+        s->rtsr[bank] = val64 & configurable_mask(bank);
+        return;
+    case EXTI_FTSR1:
+    case EXTI_FTSR2:
+        s->ftsr[bank] = val64 & configurable_mask(bank);
+        return;
+    case EXTI_SWIER1:
+    case EXTI_SWIER2: {
+        const uint32_t set = val64 & configurable_mask(bank);
+        const uint32_t pend = set & ~s->swier[bank] & s->imr[bank] &
+                              ~s->pr[bank];
+        s->swier[bank] = set;
+        s->pr[bank] |= pend;
+        for (unsigned i = 0; i < irqs_per_bank[bank]; i++) {
+            if (extract32(pend, i, 1)) {
+                qemu_irq_pulse(s->irq[i + 32 * bank]);
+            }
+        }
+        return;
+    }
+    case EXTI_PR1:
+    case EXTI_PR2: {
+        const uint32_t cleared = s->pr[bank] & val64 & configurable_mask(bank);
+        /* This bit is cleared by writing a 1 to it */
+        s->pr[bank] &= ~cleared;
+        /* Software triggered interrupts are cleared as well */
+        s->swier[bank] &= ~cleared;
+        return;
+    }
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "STM32L4X5_exti_write: Bad offset 0x%" HWADDR_PRIx "\n",
+                      addr);
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_exti_ops = {
+    .read = stm32l4x5_exti_read,
+    .write = stm32l4x5_exti_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .impl.unaligned = false,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void stm32l4x5_exti_init(Object *obj)
+{
+    Stm32l4x5ExtiState *s = STM32L4X5_EXTI(obj);
+
+    for (size_t i = 0; i < EXTI_NUM_INTERRUPT_OUT_LINES; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_exti_ops, s,
+                          TYPE_STM32L4X5_EXTI, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_exti_set_irq,
+                      EXTI_NUM_GPIO_EVENT_IN_LINES);
+}
+
+static const VMStateDescription vmstate_stm32l4x5_exti = {
+    .name = TYPE_STM32L4X5_EXTI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(imr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(emr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(rtsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(ftsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(swier, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_UINT32_ARRAY(pr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32l4x5_exti_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_stm32l4x5_exti;
+    rc->phases.hold = stm32l4x5_exti_reset_hold;
+}
+
+static const TypeInfo stm32l4x5_exti_types[] = {
+    {
+        .name          = TYPE_STM32L4X5_EXTI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(Stm32l4x5ExtiState),
+        .instance_init = stm32l4x5_exti_init,
+        .class_init    = stm32l4x5_exti_class_init,
+    }
+};
+
+DEFINE_TYPES(stm32l4x5_exti_types)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index cc8a8c1418f..3efe3dc2cc7 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -87,6 +87,9 @@ config STM32F4XX_SYSCFG
 config STM32F4XX_EXTI
     bool
 
+config STM32L4X5_EXTI
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 36c20d5637f..16db6e228d7 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -110,6 +110,7 @@ system_ss.add(when: 'CONFIG_XLNX_VERSAL_TRNG', if_true: files(
 system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
+system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_exti.c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 85725506bff..fccd3204bf5 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -163,6 +163,11 @@ stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
+# stm32l4x5_exti.c
+stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
+stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+stm32l4x5_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # tz-mpc.c
 tz_mpc_reg_read(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 tz_mpc_reg_write(uint32_t offset, uint64_t data, unsigned size) "TZ MPC regs write: offset 0x%x data 0x%" PRIx64 " size %u"
-- 
2.34.1


