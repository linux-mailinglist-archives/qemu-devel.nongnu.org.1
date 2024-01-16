Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B248C82F12F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7I-0006eY-O1; Tue, 16 Jan 2024 10:12:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7F-0006cf-Jb
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:37 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7B-0005pg-RH
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:37 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40d6b4e2945so112509665e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417952; x=1706022752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qQ1HDafZxLbMk6CEIn/JqJ+lBNZpXCcGnxRdGBmzjag=;
 b=C8DnwCttoDJG/sw88HnlArRQq6bAXo2Qqfc4ICuuSQ3XYuGWEB7yUmAWPe7WlBh8S0
 FDfItzLiScab9u3koAuwRq2AkfGqtqIsyNvU5x8HMgSOGgcUw3ssNAkXGjZ7bacgNcnn
 nCAK/9cSJ8gmF45b1PBvdz/3P/pquhxEri0TWnOj1+q/za2DtM6YuRAxf/waxLPH/EIh
 b4Smxo0iJK1peyMVjGDp/5tEOKLnOxWY9emr93+ybwGiNx7kShGxyR4zVrNt2Lict9jX
 1I7irgW8TFwkI09Sooer0QlCluTfsdcJZEgCeqJxj3ZBFYS0jHx8ScpxKUczp0iFAzTg
 +q6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417952; x=1706022752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQ1HDafZxLbMk6CEIn/JqJ+lBNZpXCcGnxRdGBmzjag=;
 b=PMxLCLoUQV8m5VSA62sgJfUT8/TpRt6LYJtsHa8tBH/pGirH7Xuc2R8xKcJwI2ohRO
 nBIq3D1a5NnYDCkWY6uyXguhdCTyH2v8YGMwjHwAe86OeMgluWY0sGUu1GvVrxWaJkWY
 M8LLGu4CNfVEKGbQuD1BCIPSnpHgfqQ5PkWkUY7244V3fZW1tSu2QLY0WwC5jpCTMyvV
 hKvNMGgiwk5DoX1orByXzccOPci6lOyKA1+OTBeUvRZ/DVTQWyJJdaxV0bnAxi7bOFLA
 drMp4A0V03rqrtAbm0fPgIZv6dSRCQLrTnyKQseLotvpgJTX09lGg1giWTZVVIj9iS+o
 QcAg==
X-Gm-Message-State: AOJu0YykDRkjlLBbCYQXx7UzL/sxTSYPUrwI77IS9vDSOqkRQ/apIloC
 wpYyyhnaVp3Thg0O8wYCUUJ9aQhXUTORCBSApGautwKn0I4=
X-Google-Smtp-Source: AGHT+IFmPqH6OmpsqM9HJ+5OKIiFjUDdhVi09lzRzdCoK8NkQ0FX4zlwD9/h0B/p4qm2mjtd4vtOIw==
X-Received: by 2002:a05:600c:210:b0:40e:448a:b4d9 with SMTP id
 16-20020a05600c021000b0040e448ab4d9mr2669867wmi.257.1705417952191; 
 Tue, 16 Jan 2024 07:12:32 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] hw/misc: Implement STM32L4x5 SYSCFG
Date: Tue, 16 Jan 2024 15:12:14 +0000
Message-Id: <20240116151228.2430754-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240109194438.70934-2-ines.varhol@telecom-paris.fr
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 include/hw/misc/stm32l4x5_syscfg.h |  54 ++++++
 hw/misc/stm32l4x5_syscfg.c         | 266 +++++++++++++++++++++++++++++
 hw/misc/Kconfig                    |   3 +
 hw/misc/meson.build                |   1 +
 hw/misc/trace-events               |   6 +
 6 files changed, 331 insertions(+), 1 deletion(-)
 create mode 100644 include/hw/misc/stm32l4x5_syscfg.h
 create mode 100644 hw/misc/stm32l4x5_syscfg.c

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
index 72f256ace75..1a021b306a6 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -16,6 +16,7 @@ Currently B-L475E-IOT01A machine's only supports the following devices:
 
 - Cortex-M4F based STM32L4x5 SoC
 - STM32L4x5 EXTI (Extended interrupts and events controller)
+- STM32L4x5 SYSCFG (System configuration controller)
 
 Missing devices
 """""""""""""""
@@ -24,7 +25,6 @@ The B-L475E-IOT01A does *not* support the following devices:
 
 - Reset and clock control (RCC)
 - Serial ports (UART)
-- System configuration controller (SYSCFG)
 - General-purpose I/Os (GPIO)
 - Analog to Digital Converter (ADC)
 - SPI controller
diff --git a/include/hw/misc/stm32l4x5_syscfg.h b/include/hw/misc/stm32l4x5_syscfg.h
new file mode 100644
index 00000000000..29c3522f9dd
--- /dev/null
+++ b/include/hw/misc/stm32l4x5_syscfg.h
@@ -0,0 +1,54 @@
+/*
+ * STM32L4x5 SYSCFG (System Configuration Controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_syscfg by Alistair Francis.
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
+#ifndef HW_STM32L4X5_SYSCFG_H
+#define HW_STM32L4X5_SYSCFG_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_SYSCFG "stm32l4x5-syscfg"
+OBJECT_DECLARE_SIMPLE_TYPE(Stm32l4x5SyscfgState, STM32L4X5_SYSCFG)
+
+#define NUM_GPIOS 8
+#define GPIO_NUM_PINS 16
+#define SYSCFG_NUM_EXTICR 4
+
+struct Stm32l4x5SyscfgState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t memrmp;
+    uint32_t cfgr1;
+    uint32_t exticr[SYSCFG_NUM_EXTICR];
+    uint32_t scsr;
+    uint32_t cfgr2;
+    uint32_t swpr;
+    uint32_t skr;
+    uint32_t swpr2;
+
+    qemu_irq gpio_out[GPIO_NUM_PINS];
+};
+
+#endif
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
new file mode 100644
index 00000000000..fd68cb800bb
--- /dev/null
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -0,0 +1,266 @@
+/*
+ * STM32L4x5 SYSCFG (System Configuration Controller)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is based on the stm32f4xx_syscfg by Alistair Francis.
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
+#include "hw/misc/stm32l4x5_syscfg.h"
+
+#define SYSCFG_MEMRMP 0x00
+#define SYSCFG_CFGR1 0x04
+#define SYSCFG_EXTICR1 0x08
+#define SYSCFG_EXTICR2 0x0C
+#define SYSCFG_EXTICR3 0x10
+#define SYSCFG_EXTICR4 0x14
+#define SYSCFG_SCSR 0x18
+#define SYSCFG_CFGR2 0x1C
+#define SYSCFG_SWPR 0x20
+#define SYSCFG_SKR 0x24
+#define SYSCFG_SWPR2 0x28
+
+/* 00000000_00000000_00000001_00000111 */
+#define ACTIVABLE_BITS_MEMRP 0x00000107
+
+/* 11111100_11111111_00000001_00000000 */
+#define ACTIVABLE_BITS_CFGR1 0xFCFF0100
+/* 00000000_00000000_00000000_00000001 */
+#define FIREWALL_DISABLE_CFGR1 0x00000001
+
+/* 00000000_00000000_11111111_11111111 */
+#define ACTIVABLE_BITS_EXTICR 0x0000FFFF
+
+/* 00000000_00000000_00000000_00000011 */
+/* #define ACTIVABLE_BITS_SCSR 0x00000003 */
+
+/* 00000000_00000000_00000000_00001111 */
+#define ECC_LOCK_CFGR2 0x0000000F
+/* 00000000_00000000_00000001_00000000 */
+#define SRAM2_PARITY_ERROR_FLAG_CFGR2 0x00000100
+
+/* 00000000_00000000_00000000_11111111 */
+#define ACTIVABLE_BITS_SKR 0x000000FF
+
+#define NUM_LINES_PER_EXTICR_REG 4
+
+static void stm32l4x5_syscfg_hold_reset(Object *obj)
+{
+    Stm32l4x5SyscfgState *s = STM32L4X5_SYSCFG(obj);
+
+    s->memrmp = 0x00000000;
+    s->cfgr1 = 0x7C000001;
+    s->exticr[0] = 0x00000000;
+    s->exticr[1] = 0x00000000;
+    s->exticr[2] = 0x00000000;
+    s->exticr[3] = 0x00000000;
+    s->scsr = 0x00000000;
+    s->cfgr2 = 0x00000000;
+    s->swpr = 0x00000000;
+    s->skr = 0x00000000;
+    s->swpr2 = 0x00000000;
+}
+
+static void stm32l4x5_syscfg_set_irq(void *opaque, int irq, int level)
+{
+    Stm32l4x5SyscfgState *s = opaque;
+    const uint8_t gpio = irq / GPIO_NUM_PINS;
+    const int line = irq % GPIO_NUM_PINS;
+
+    const int exticr_reg = line / NUM_LINES_PER_EXTICR_REG;
+    const int startbit = (line % NUM_LINES_PER_EXTICR_REG) * 4;
+
+    g_assert(gpio < NUM_GPIOS);
+    trace_stm32l4x5_syscfg_set_irq(gpio, line, level);
+
+    if (extract32(s->exticr[exticr_reg], startbit, 4) == gpio) {
+        trace_stm32l4x5_syscfg_forward_exti(line);
+        qemu_set_irq(s->gpio_out[line], level);
+    }
+}
+
+static uint64_t stm32l4x5_syscfg_read(void *opaque, hwaddr addr,
+                                      unsigned int size)
+{
+    Stm32l4x5SyscfgState *s = opaque;
+
+    trace_stm32l4x5_syscfg_read(addr);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        return s->memrmp;
+    case SYSCFG_CFGR1:
+        return s->cfgr1;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        return s->exticr[(addr - SYSCFG_EXTICR1) / 4];
+    case SYSCFG_SCSR:
+        return s->scsr;
+    case SYSCFG_CFGR2:
+        return s->cfgr2;
+    case SYSCFG_SWPR:
+        return s->swpr;
+    case SYSCFG_SKR:
+        return s->skr;
+    case SYSCFG_SWPR2:
+        return s->swpr2;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+        return 0;
+    }
+}
+static void stm32l4x5_syscfg_write(void *opaque, hwaddr addr,
+                                   uint64_t value, unsigned int size)
+{
+    Stm32l4x5SyscfgState *s = opaque;
+
+    trace_stm32l4x5_syscfg_write(addr, value);
+
+    switch (addr) {
+    case SYSCFG_MEMRMP:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the memory mapping isn't supported\n",
+                      __func__);
+        s->memrmp = value & ACTIVABLE_BITS_MEMRP;
+        return;
+    case SYSCFG_CFGR1:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Functions in CFGRx aren't supported\n",
+                      __func__);
+        /* bit 0 (firewall dis.) is cleared by software, set only by reset. */
+        s->cfgr1 = (s->cfgr1 & value & FIREWALL_DISABLE_CFGR1) |
+                   (value & ACTIVABLE_BITS_CFGR1);
+        return;
+    case SYSCFG_EXTICR1...SYSCFG_EXTICR4:
+        s->exticr[(addr - SYSCFG_EXTICR1) / 4] =
+                (value & ACTIVABLE_BITS_EXTICR);
+        return;
+    case SYSCFG_SCSR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Erasing SRAM2 isn't supported\n",
+                      __func__);
+        /*
+         * only non reserved bits are :
+         * bit 0 (write-protected by a passkey), bit 1 (meant to be read)
+         * so it serves no purpose yet to add :
+         * s->scsr = value & 0x3;
+         */
+        return;
+    case SYSCFG_CFGR2:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Functions in CFGRx aren't supported\n",
+                      __func__);
+        /* bit 8 (SRAM2 PEF) is cleared by software by writing a '1'.*/
+        /* bits[3:0] (ECC Lock) are set by software, cleared only by reset.*/
+        s->cfgr2 = (s->cfgr2 | (value & ECC_LOCK_CFGR2)) &
+                   ~(value & SRAM2_PARITY_ERROR_FLAG_CFGR2);
+        return;
+    case SYSCFG_SWPR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Write protecting SRAM2 isn't supported\n",
+                      __func__);
+        /* These bits are set by software and cleared only by reset.*/
+        s->swpr |= value;
+        return;
+    case SYSCFG_SKR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Erasing SRAM2 isn't supported\n",
+                      __func__);
+        s->skr = value & ACTIVABLE_BITS_SKR;
+        return;
+    case SYSCFG_SWPR2:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Write protecting SRAM2 isn't supported\n",
+                      __func__);
+        /* These bits are set by software and cleared only by reset.*/
+        s->swpr2 |= value;
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_syscfg_ops = {
+    .read = stm32l4x5_syscfg_read,
+    .write = stm32l4x5_syscfg_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+    .impl.unaligned = false,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static void stm32l4x5_syscfg_init(Object *obj)
+{
+    Stm32l4x5SyscfgState *s = STM32L4X5_SYSCFG(obj);
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_syscfg_ops, s,
+                          TYPE_STM32L4X5_SYSCFG, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_syscfg_set_irq,
+                      GPIO_NUM_PINS * NUM_GPIOS);
+    qdev_init_gpio_out(DEVICE(obj), s->gpio_out, GPIO_NUM_PINS);
+}
+
+static const VMStateDescription vmstate_stm32l4x5_syscfg = {
+    .name = TYPE_STM32L4X5_SYSCFG,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(memrmp, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32(cfgr1, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32_ARRAY(exticr, Stm32l4x5SyscfgState,
+                             SYSCFG_NUM_EXTICR),
+        VMSTATE_UINT32(scsr, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32(cfgr2, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32(swpr, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32(skr, Stm32l4x5SyscfgState),
+        VMSTATE_UINT32(swpr2, Stm32l4x5SyscfgState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32l4x5_syscfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->vmsd = &vmstate_stm32l4x5_syscfg;
+    rc->phases.hold = stm32l4x5_syscfg_hold_reset;
+}
+
+static const TypeInfo stm32l4x5_syscfg_info[] = {
+    {
+        .name          = TYPE_STM32L4X5_SYSCFG,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(Stm32l4x5SyscfgState),
+        .instance_init = stm32l4x5_syscfg_init,
+        .class_init    = stm32l4x5_syscfg_class_init,
+    }
+};
+
+DEFINE_TYPES(stm32l4x5_syscfg_info)
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 3efe3dc2cc7..4fc6b29b43d 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -90,6 +90,9 @@ config STM32F4XX_EXTI
 config STM32L4X5_EXTI
     bool
 
+config STM32L4X5_SYSCFG
+    bool
+
 config MIPS_ITU
     bool
 
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 16db6e228d7..2ca2ce4b62e 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -111,6 +111,7 @@ system_ss.add(when: 'CONFIG_STM32F2XX_SYSCFG', if_true: files('stm32f2xx_syscfg.
 system_ss.add(when: 'CONFIG_STM32F4XX_SYSCFG', if_true: files('stm32f4xx_syscfg.c'))
 system_ss.add(when: 'CONFIG_STM32F4XX_EXTI', if_true: files('stm32f4xx_exti.c'))
 system_ss.add(when: 'CONFIG_STM32L4X5_EXTI', if_true: files('stm32l4x5_exti.c'))
+system_ss.add(when: 'CONFIG_STM32L4X5_SYSCFG', if_true: files('stm32l4x5_syscfg.c'))
 system_ss.add(when: 'CONFIG_MPS2_FPGAIO', if_true: files('mps2-fpgaio.c'))
 system_ss.add(when: 'CONFIG_MPS2_SCC', if_true: files('mps2-scc.c'))
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index fccd3204bf5..5f5bc922223 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -163,6 +163,12 @@ stm32f4xx_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32f4xx_exti_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
 stm32f4xx_exti_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
 
+# stm32l4x5_syscfg.c
+stm32l4x5_syscfg_set_irq(int gpio, int line, int level) "irq from GPIO: %d, line: %d, level: %d"
+stm32l4x5_syscfg_forward_exti(int irq) "irq %d forwarded to EXTI"
+stm32l4x5_syscfg_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32l4x5_syscfg_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
+
 # stm32l4x5_exti.c
 stm32l4x5_exti_set_irq(int irq, int level) "Set EXTI: %d to %d"
 stm32l4x5_exti_read(uint64_t addr, uint64_t data) "reg read: addr: 0x%" PRIx64 " val: 0x%" PRIx64 ""
-- 
2.34.1


