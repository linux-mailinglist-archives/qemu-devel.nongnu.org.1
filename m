Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324A7AF996C
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 18:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjjO-0007D0-QN; Fri, 04 Jul 2025 12:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjH-0006w3-20
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:39 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uXjjE-0000OR-KU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:57:38 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6fd0a7d3949so19301876d6.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751648255; x=1752253055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3HwpcHBBUn2dcbW8T3vErv8M1+Kd3LAIXbcCOF5JP6o=;
 b=IrMCg49LQ/JdasiHdiRzWddu8AYNI7cibVES5ADr0jaZrYzIwfnV5LuR9XDj3YveK9
 MQxvLRG+HdHxb4FGk+8KlKCLOjVOGWzscUld4TLXa5WZa4O9wYxowxPMS/dePh5CyE1l
 fShyRNcl0xJJuMgIxlUsHz4EG0n3p+4blMfJu3SF14fthXul0X1Ope0NN4V/M8EXOmy2
 ns8n0H7yQ77yf6uG+nxwPr0L+J8Lc2DZwi276+rlZ5JKAhIOtgLetb0mIiIwcbT0Spt5
 l8YL9vQgneyEmcgW+Kp0QwRWotTbPIiMQRhMiuSf+SWDm2eHUE4p905dTZ09W3Vd1R6m
 QAXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751648255; x=1752253055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3HwpcHBBUn2dcbW8T3vErv8M1+Kd3LAIXbcCOF5JP6o=;
 b=m9lVr9Gai2DpcKnFkwm+Kan/hm7d13q/DsrLhBkusrFcP6jy14Cy8nR9KQhLesgUSy
 OvJQxKVZqrLGLAZD7OYI/Ub621LUBpN5IpGH5m9aVKZUPVBJ365pkENEh2h7Ae7HQG3k
 Wbpx0Mgh+Nx78CAFzAqpMISm6mVeqKI1CLsvbCFm5qQSauQWc2qFX4aIRFF8HPjJWKdA
 R5boZG95bWsII73Py0kS8h5nNwZR7V0lxVrq1O/5vbWShMQPE0t5/FyQB71t9g8y80NF
 XrjxaQwi75YR8jmM38uyD7DVmaqI9993QdISwSinEIWb7z50ZBdB5zWe3LRi6k/FK/W/
 wl6Q==
X-Gm-Message-State: AOJu0Yz2726vbivAoVuCNx95t3dDWi1bdu7J2ZpV4O2OR5vf4Mxj11+F
 8JVrRt4Kyk0CpKdYe7ldy70RTLyUOZ68oSvpo/3eT85EO9KHDYpluhrG6jHYuA==
X-Gm-Gg: ASbGncsAOoLiWbnXW1R1Lff0nxwZ7xX0aPQEqgSXNd6QNIZxDaOF8UjCpTxkYXeHqf/
 oMRioD4+lseIxLyGVMNnCSLChSNqK18smn7EvRY2zaY2CErPf+TK72IA1Zq6Jl+ZlDB0yafnaxD
 Ih4me3Wqif7ZP63GX3+H1GKSkuK1Y/GJl8/8pkXPf7XBLhGqlrcbLmv6JaTi6e8Vbz0sOsX5C2Q
 a86NGHKYfx7ErCJc49/IHmWGvt4j9HVI6s3XBm8XMa5tV+KexNny9zlph4X2CIeSve4U2RHZVcH
 ruWnTcyxPdn3C3g7NMx1/kZbFU3Kx83viRFziiUjt7adDtG8k906Hv0b2f1MfKcDyUpRos64aVS
 a3CIb
X-Google-Smtp-Source: AGHT+IEKvExQWSW5j2DvXiXCg+zJSpnE0l+dBmV0L0Owfnpu82/rY7eZrcQGRO1t5lyi4jdLs1NXqg==
X-Received: by 2002:a05:6214:588b:b0:6fa:a0ac:8d57 with SMTP id
 6a1803df08f44-702c6d49559mr41258546d6.12.1751648255272; 
 Fri, 04 Jul 2025 09:57:35 -0700 (PDT)
Received: from user-jcksn.myfiosgateway.com
 ([2600:4040:2bcd:3800:e3f4:4cee:828f:52d])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-702c4ccc6easm15345826d6.26.2025.07.04.09.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:57:34 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 06/11] MAX78000: GCR Implementation
Date: Fri,  4 Jul 2025 12:57:24 -0400
Message-Id: <20250704165729.208381-7-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704165729.208381-1-jcksn@duck.com>
References: <20250704165729.208381-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This commit implements the Global Control Register
for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/Kconfig                 |   1 +
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_gcr.c         | 339 +++++++++++++++++++++++++++++++++
 hw/misc/meson.build            |   1 +
 include/hw/misc/max78000_gcr.h | 129 +++++++++++++
 5 files changed, 473 insertions(+)
 create mode 100644 hw/misc/max78000_gcr.c
 create mode 100644 include/hw/misc/max78000_gcr.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 031e0bf59e..41bb64458f 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -368,6 +368,7 @@ config MAX78000_SOC
     select ARM_V7M
     select MAX78000_ICC
     select MAX78000_UART
+    select MAX78000_GCR
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 781bcf74cc..fde2266b8f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_GCR
+    bool
+
 config MAX78000_ICC
     bool
 
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
new file mode 100644
index 0000000000..8c282f3916
--- /dev/null
+++ b/hw/misc/max78000_gcr.c
@@ -0,0 +1,339 @@
+/*
+ * MAX78000 Global Control Registers
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "system/runstate.h"
+#include "migration/vmstate.h"
+#include "hw/qdev-properties.h"
+#include "hw/char/max78000_uart.h"
+#include "hw/misc/max78000_gcr.h"
+
+
+static void max78000_gcr_reset_hold(Object *obj, ResetType type)
+{
+    DeviceState *dev = DEVICE(obj);
+    Max78000GcrState *s = MAX78000_GCR(dev);
+    s->sysctrl = 0x21002;
+    s->rst0 = 0;
+    /* All clocks are always ready */
+    s->clkctrl = 0x3e140008;
+    s->pm = 0x3f000;
+    s->pclkdiv = 0;
+    s->pclkdis0 = 0xffffffff;
+    s->memctrl = 0x5;
+    s->memz = 0;
+    s->sysst = 0;
+    s->rst1 = 0;
+    s->pckdis1 = 0xffffffff;
+    s->eventen = 0;
+    s->revision = 0xa1;
+    s->sysie = 0;
+    s->eccerr = 0;
+    s->ecced = 0;
+    s->eccie = 0;
+    s->eccaddr = 0;
+}
+
+static uint64_t max78000_gcr_read(void *opaque, hwaddr addr,
+                                     unsigned int size)
+{
+    Max78000GcrState *s = opaque;
+
+    switch (addr) {
+    case SYSCTRL:
+        return s->sysctrl;
+
+    case RST0:
+        return s->rst0;
+
+    case CLKCTRL:
+        return s->clkctrl;
+
+    case PM:
+        return s->pm;
+
+    case PCLKDIV:
+        return s->pclkdiv;
+
+    case PCLKDIS0:
+        return s->pclkdis0;
+
+    case MEMCTRL:
+        return s->memctrl;
+
+    case MEMZ:
+        return s->memz;
+
+    case SYSST:
+        return s->sysst;
+
+    case RST1:
+        return s->rst1;
+
+    case PCKDIS1:
+        return s->pckdis1;
+
+    case EVENTEN:
+        return s->eventen;
+
+    case REVISION:
+        return s->revision;
+
+    case SYSIE:
+        return s->sysie;
+
+    case ECCERR:
+        return s->eccerr;
+
+    case ECCED:
+        return s->ecced;
+
+    case ECCIE:
+        return s->eccie;
+
+    case ECCADDR:
+        return s->eccaddr;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        return 0;
+
+    }
+}
+
+static void max78000_gcr_write(void *opaque, hwaddr addr,
+                       uint64_t val64, unsigned int size)
+{
+    Max78000GcrState *s = opaque;
+    uint32_t val = val64;
+    uint8_t zero[0xc000] = {0};
+    switch (addr) {
+    case SYSCTRL:
+        /* Checksum calculations always pass immediately */
+        s->sysctrl = (val & 0x30000) | 0x1002;
+        break;
+
+    case RST0:
+        if (val & SYSTEM_RESET) {
+            qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+        }
+        if (val & PERIPHERAL_RESET) {
+            /*
+             * Peripheral reset resets all peripherals. The CPU
+             * retains its state. The GPIO, watchdog timers, AoD,
+             * RAM retention, and general control registers (GCR),
+             * including the clock configuration, are unaffected.
+             */
+            val = UART2_RESET | UART1_RESET | UART0_RESET |
+                    ADC_RESET | CNN_RESET | TRNG_RESET |
+                    RTC_RESET | I2C0_RESET | SPI1_RESET |
+                    TMR3_RESET | TMR2_RESET | TMR1_RESET |
+                    TMR0_RESET | WDT0_RESET | DMA_RESET;
+        }
+        if (val & SOFT_RESET) {
+            /* Soft reset also resets GPIO */
+            val = UART2_RESET | UART1_RESET | UART0_RESET |
+                    ADC_RESET | CNN_RESET | TRNG_RESET |
+                    RTC_RESET | I2C0_RESET | SPI1_RESET |
+                    TMR3_RESET | TMR2_RESET | TMR1_RESET |
+                    TMR0_RESET | GPIO1_RESET | GPIO0_RESET |
+                    DMA_RESET;
+        }
+        if (val & UART2_RESET) {
+            device_cold_reset(s->uart2);
+        }
+        if (val & UART1_RESET) {
+            device_cold_reset(s->uart1);
+        }
+        if (val & UART0_RESET) {
+            device_cold_reset(s->uart0);
+        }
+        /* TODO: As other devices are implemented, add them here */
+        break;
+
+    case CLKCTRL:
+        s->clkctrl = val | SYSCLK_RDY;
+        break;
+
+    case PM:
+        s->pm = val;
+        break;
+
+    case PCLKDIV:
+        s->pclkdiv = val;
+        break;
+
+    case PCLKDIS0:
+        s->pclkdis0 = val;
+        break;
+
+    case MEMCTRL:
+        s->memctrl = val;
+        break;
+
+    case MEMZ:
+        if (val & ram0) {
+            address_space_write(&s->sram_as, SYSRAM0_START,
+                                MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
+        }
+        if (val & ram1) {
+            address_space_write(&s->sram_as, SYSRAM1_START,
+                                MEMTXATTRS_UNSPECIFIED, zero, 0x8000);
+        }
+        if (val & ram2) {
+            address_space_write(&s->sram_as, SYSRAM2_START,
+                                MEMTXATTRS_UNSPECIFIED, zero, 0xC000);
+        }
+        if (val & ram3) {
+            address_space_write(&s->sram_as, SYSRAM3_START,
+                                MEMTXATTRS_UNSPECIFIED, zero, 0x4000);
+        }
+        break;
+
+    case SYSST:
+        s->sysst = val;
+        break;
+
+    case RST1:
+        /* TODO: As other devices are implemented, add them here */
+        s->rst1 = val;
+        break;
+
+    case PCKDIS1:
+        s->pckdis1 = val;
+        break;
+
+    case EVENTEN:
+        s->eventen = val;
+        break;
+
+    case REVISION:
+        s->revision = val;
+        break;
+
+    case SYSIE:
+        s->sysie = val;
+        break;
+
+    case ECCERR:
+        s->eccerr = val;
+        break;
+
+    case ECCED:
+        s->ecced = val;
+        break;
+
+    case ECCIE:
+        s->eccie = val;
+        break;
+
+    case ECCADDR:
+        s->eccaddr = val;
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                      __func__, addr);
+        break;
+
+    }
+}
+
+static const Property max78000_gcr_properties[] = {
+    DEFINE_PROP_LINK("sram", Max78000GcrState, sram,
+                     TYPE_MEMORY_REGION, MemoryRegion*),
+    DEFINE_PROP_LINK("uart0", Max78000GcrState, uart0,
+                     TYPE_MAX78000_UART, DeviceState*),
+    DEFINE_PROP_LINK("uart1", Max78000GcrState, uart1,
+                     TYPE_MAX78000_UART, DeviceState*),
+    DEFINE_PROP_LINK("uart2", Max78000GcrState, uart2,
+                     TYPE_MAX78000_UART, DeviceState*),
+};
+
+static const MemoryRegionOps max78000_gcr_ops = {
+    .read = max78000_gcr_read,
+    .write = max78000_gcr_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_max78000_gcr = {
+    .name = TYPE_MAX78000_GCR,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(sysctrl, Max78000GcrState),
+        VMSTATE_UINT32(rst0, Max78000GcrState),
+        VMSTATE_UINT32(clkctrl, Max78000GcrState),
+        VMSTATE_UINT32(pm, Max78000GcrState),
+        VMSTATE_UINT32(pclkdiv, Max78000GcrState),
+        VMSTATE_UINT32(pclkdis0, Max78000GcrState),
+        VMSTATE_UINT32(memctrl, Max78000GcrState),
+        VMSTATE_UINT32(memz, Max78000GcrState),
+        VMSTATE_UINT32(sysst, Max78000GcrState),
+        VMSTATE_UINT32(rst1, Max78000GcrState),
+        VMSTATE_UINT32(pckdis1, Max78000GcrState),
+        VMSTATE_UINT32(eventen, Max78000GcrState),
+        VMSTATE_UINT32(revision, Max78000GcrState),
+        VMSTATE_UINT32(sysie, Max78000GcrState),
+        VMSTATE_UINT32(eccerr, Max78000GcrState),
+        VMSTATE_UINT32(ecced, Max78000GcrState),
+        VMSTATE_UINT32(eccie, Max78000GcrState),
+        VMSTATE_UINT32(eccaddr, Max78000GcrState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_gcr_init(Object *obj)
+{
+    Max78000GcrState *s = MAX78000_GCR(obj);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_gcr_ops, s,
+                          TYPE_MAX78000_GCR, 0x400);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_gcr_realize(DeviceState *dev, Error **errp)
+{
+    Max78000GcrState *s = MAX78000_GCR(dev);
+
+    address_space_init(&s->sram_as, s->sram, "sram");
+}
+
+static void max78000_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, max78000_gcr_properties);
+
+    dc->realize = max78000_gcr_realize;
+    dc->vmsd = &vmstate_max78000_gcr;
+    rc->phases.hold = max78000_gcr_reset_hold;
+}
+
+static const TypeInfo max78000_gcr_info = {
+    .name          = TYPE_MAX78000_GCR,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000GcrState),
+    .instance_init = max78000_gcr_init,
+    .class_init     = max78000_gcr_class_init,
+};
+
+static void max78000_gcr_register_types(void)
+{
+    type_register_static(&max78000_gcr_info);
+}
+
+type_init(max78000_gcr_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a21a994ff8..283d06dad4 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files(
   'npcm_clk.c',
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
new file mode 100644
index 0000000000..f04c8a3ee7
--- /dev/null
+++ b/include/hw/misc/max78000_gcr.h
@@ -0,0 +1,129 @@
+/*
+ * MAX78000 Global Control Register
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_GCR_H
+#define HW_MAX78000_GCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_GCR "max78000-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000GcrState, MAX78000_GCR)
+
+#define SYSCTRL     0x0
+#define RST0        0x4
+#define CLKCTRL     0x8
+#define PM          0xc
+#define PCLKDIV     0x18
+#define PCLKDIS0    0x24
+#define MEMCTRL     0x28
+#define MEMZ        0x2c
+#define SYSST       0x40
+#define RST1        0x44
+#define PCKDIS1     0x48
+#define EVENTEN     0x4c
+#define REVISION    0x50
+#define SYSIE       0x54
+#define ECCERR      0x64
+#define ECCED       0x68
+#define ECCIE       0x6c
+#define ECCADDR     0x70
+
+/* RST0 */
+#define SYSTEM_RESET (1 << 31)
+#define PERIPHERAL_RESET (1 << 30)
+#define SOFT_RESET (1 << 29)
+#define UART2_RESET (1 << 28)
+
+#define ADC_RESET (1 << 26)
+#define CNN_RESET (1 << 25)
+#define TRNG_RESET (1 << 24)
+
+#define RTC_RESET (1 << 17)
+#define I2C0_RESET (1 << 16)
+
+#define SPI1_RESET (1 << 13)
+#define UART1_RESET (1 << 12)
+#define UART0_RESET (1 << 11)
+
+#define TMR3_RESET (1 << 8)
+#define TMR2_RESET (1 << 7)
+#define TMR1_RESET (1 << 6)
+#define TMR0_RESET (1 << 5)
+
+#define GPIO1_RESET (1 << 3)
+#define GPIO0_RESET (1 << 2)
+#define WDT0_RESET (1 << 1)
+#define DMA_RESET (1 << 0)
+
+/* CLKCTRL */
+#define SYSCLK_RDY (1 << 13)
+
+/* MEMZ */
+#define ram0 (1 << 0)
+#define ram1 (1 << 1)
+#define ram2 (1 << 2)
+#define ram3 (1 << 3)
+
+/* RST1 */
+#define CPU1_RESET (1 << 31)
+
+#define SIMO_RESET (1 << 25)
+#define DVS_RESET (1 << 24)
+
+#define I2C2_RESET (1 << 20)
+#define I2S_RESET (1 << 19)
+
+#define SMPHR_RESET (1 << 16)
+
+#define SPI0_RESET (1 << 11)
+#define AES_RESET (1 << 10)
+#define CRC_RESET (1 << 9)
+
+#define PT_RESET (1 << 1)
+#define I2C1_RESET (1 << 0)
+
+
+#define SYSRAM0_START 0x20000000
+#define SYSRAM1_START 0x20008000
+#define SYSRAM2_START 0x20010000
+#define SYSRAM3_START 0x2001C000
+
+struct Max78000GcrState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t sysctrl;
+    uint32_t rst0;
+    uint32_t clkctrl;
+    uint32_t pm;
+    uint32_t pclkdiv;
+    uint32_t pclkdis0;
+    uint32_t memctrl;
+    uint32_t memz;
+    uint32_t sysst;
+    uint32_t rst1;
+    uint32_t pckdis1;
+    uint32_t eventen;
+    uint32_t revision;
+    uint32_t sysie;
+    uint32_t eccerr;
+    uint32_t ecced;
+    uint32_t eccie;
+    uint32_t eccaddr;
+
+    MemoryRegion *sram;
+    AddressSpace sram_as;
+
+    DeviceState *uart0;
+    DeviceState *uart1;
+    DeviceState *uart2;
+
+};
+
+#endif
-- 
2.34.1


