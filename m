Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE270466B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:32:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyp9C-0005MQ-Hy; Tue, 16 May 2023 03:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8m-0004ac-Jk; Tue, 16 May 2023 03:30:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <m.elsayed4420@gmail.com>)
 id 1pyp8g-00006Z-A8; Tue, 16 May 2023 03:30:33 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30626f4d74aso8981911f8f.0; 
 Tue, 16 May 2023 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684222227; x=1686814227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQg+813lxdFN0r1kQPu6O9fQCGxBdpM/2BZI3yPOpm4=;
 b=SohDGimqqRSgUg6AJxyWEdQ5ruqzoOP8Rqx5rJkdeg3ubB20FyezCPUxyQJfCt9XbB
 dVZo/9bziQxpPFlsgyjPu2RTg67iF/EBJ/EHCbehy6rMWVPV3oYByK8X7bKQWlydd8EX
 sCAjXtUlwezH/n652XUIx9BrFy/IseGEPwYGWIlTsqsN3avUrQkH0vAaDrW3nK/Vflyp
 65ixLUba/4GTn42FvT3kNrDcpBnv6s+ag89ALiaLBeccMI9ELKs7mPB1q1BUWgl7p2yx
 Nl1MzsHVCP1LEBUZOYNaQ3uA4IAPGv1CmXrI8eJ6uW+13v0KFKooY00F/N9S03K3PAtt
 oJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684222227; x=1686814227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQg+813lxdFN0r1kQPu6O9fQCGxBdpM/2BZI3yPOpm4=;
 b=EM3jywpnHZbp6m0R5JNZn+bFwICOxxrTqUpZvCUazjoHreHdeTgj6+TG9oe/7Qg0ew
 41tEb5jNlpIExwCD3ZZTgbxtHmVYtjh0qst/5yNfPzZu4K+CCInCqK1JTB4tdtDRfGo8
 VNTo0LKSiVKFWyezk/muy18G0QszkYFw2Ie24Ww7KcHCqJ8SkBa8EuBej42b2fLux4lx
 ZSQZ056TS8XCTe0vQQxd+NT9/ImyvgocNisbkCcDN48pPO7PDzhO9785HHNvCFIOjIXh
 L9U1q9MYgEhLr03k4LeP8bFuMK3gQNic3L+g+LRblwXCHYHg6enLwoSxTZ+suW/fYxQx
 Ge8A==
X-Gm-Message-State: AC+VfDyJEjyhW8pWkD6gHc3A95zYkMrE+VwzdLoGuaT1+rixjJUSFYv1
 xcB+kYOtPpkxp46HlYA4DWN/e6cr+dbJQQ==
X-Google-Smtp-Source: ACHHUZ7d5UuUATUDlby+ez9YkSiiGz61REfIAiDFOZeGAuLsRp2X+aRxWGgn5JPmdCGqqRo9I/GrIg==
X-Received: by 2002:a05:6000:192:b0:306:489b:3c6 with SMTP id
 p18-20020a056000019200b00306489b03c6mr23360567wrx.58.1684222226619; 
 Tue, 16 May 2023 00:30:26 -0700 (PDT)
Received: from i.. ([41.236.82.205]) by smtp.gmail.com with ESMTPSA id
 y12-20020a5d614c000000b003062c609115sm1559997wrt.21.2023.05.16.00.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 00:30:26 -0700 (PDT)
From: Mohamed ElSayed <m.elsayed4420@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Mohamed ElSayed <m.elsayed4420@gmail.com>
Subject: [PULL 3/8] tivac gpio module implementation
Date: Tue, 16 May 2023 10:29:54 +0300
Message-Id: <20230516072959.49994-4-m.elsayed4420@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516072959.49994-1-m.elsayed4420@gmail.com>
References: <20230516072959.49994-1-m.elsayed4420@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=m.elsayed4420@gmail.com; helo=mail-wr1-x430.google.com
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
 hw/gpio/tm4c123_gpio.c         | 372 +++++++++++++++++++++++++++++++++
 include/hw/gpio/tm4c123_gpio.h | 127 +++++++++++
 2 files changed, 499 insertions(+)
 create mode 100644 hw/gpio/tm4c123_gpio.c
 create mode 100644 include/hw/gpio/tm4c123_gpio.h

diff --git a/hw/gpio/tm4c123_gpio.c b/hw/gpio/tm4c123_gpio.c
new file mode 100644
index 0000000000..7fbe04bd77
--- /dev/null
+++ b/hw/gpio/tm4c123_gpio.c
@@ -0,0 +1,372 @@
+/*
+ * TM4C123 GPIO
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
+#include "hw/gpio/tm4c123_gpio.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/misc/tm4c123_sysctl.h"
+#include "qemu/bitops.h"
+#include "trace.h"
+
+#define LOG(fmt, args...) qemu_log("%s: " fmt, __func__, ## args)
+#define READONLY LOG("0x%"HWADDR_PRIx" is a readonly field\n.", addr)
+
+static bool gpio_clock_enabled(TM4C123SysCtlState *s, hwaddr addr)
+{
+    switch(addr) {
+        case GPIO_A:
+            return test_bit(0, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+        case GPIO_B:
+            return test_bit(1, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+        case GPIO_C:
+            return test_bit(2, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+        case GPIO_D:
+            return test_bit(3, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+        case GPIO_E:
+            return test_bit(4, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+        case GPIO_F:
+            return test_bit(5, (const unsigned long*)&s->sysctl_rcgcgpio);
+            break;
+    }
+    return false;
+}
+
+static void tm4c123_gpio_reset(DeviceState *dev)
+{
+    TM4C123GPIOState *s = TM4C123_GPIO(dev);
+
+    s->gpio_data = 0x00000000;
+    s->gpio_dir = 0x00000000;
+    s->gpio_is = 0x00000000;
+    s->gpio_ibe = 0x00000000;
+    s->gpio_iev = 0x00000000;
+    s->gpio_im = 0x00000000;
+    s->gpio_ris = 0x00000000;
+    s->gpio_mis = 0x00000000;
+    s->gpio_icr = 0x00000000;
+    s->gpio_afsel = 0x00000000;
+    s->gpio_dr2r = 0x000000FF;
+    s->gpio_dr4r = 0x00000000;
+    s->gpio_dr8r = 0x00000000;
+    s->gpio_odr = 0x00000000;
+    s->gpio_pur = 0x00000000;
+    s->gpio_pdr = 0x00000000;
+    s->gpio_slr = 0x00000000;
+    s->gpio_den = 0x00000000;
+    s->gpio_lock = 0x00000001;
+    s->gpio_ocr = 0x00000000;
+    s->gpio_amsel = 0x00000000;
+    s->gpio_pctl = 0x00000000;
+    s->gpio_adcctl = 0x00000000;
+    s->gpio_dmactl = 0x00000000;
+    s->gpio_per_id4 = 0x00000000;
+    s->gpio_per_id5 = 0x00000000;
+    s->gpio_per_id6 = 0x00000000;
+    s->gpio_per_id7 = 0x00000000;
+    s->gpio_per_id0 = 0x00000061;
+    s->gpio_per_id1 = 0x00000000;
+    s->gpio_per_id2 = 0x00000018;
+    s->gpio_per_id3 = 0x00000001;
+    s->gpio_pcell_id0 = 0x0000000D;
+    s->gpio_pcell_id1 = 0x000000F0;
+    s->gpio_pcell_id2 = 0x00000005;
+    s->gpio_pcell_id3 = 0x000000B1;
+}
+
+static void tm4c123_gpio_write(void *opaque, hwaddr addr, uint64_t val64, unsigned int size)
+{
+    TM4C123GPIOState *s = opaque;
+    uint32_t val32 = val64;
+
+    if (!gpio_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("GPIO module clock is not enabled");
+    }
+    trace_tm4c123_gpio_write(addr, val32);
+
+    switch(addr) {
+        case GPIO_DATA:
+            {
+                uint32_t rising_edge = (val32 ^ s->gpio_data) & val32;
+                //level detection
+                s->gpio_mis = s->gpio_is & s->gpio_iev & val32;
+                s->gpio_mis |= s->gpio_is & ~(s->gpio_iev | val32);
+                s->gpio_mis &= s->gpio_im;
+
+                //edge detection
+                //both edges
+                s->gpio_mis |= (s->gpio_is | s->gpio_ibe) & (~s->gpio_is);
+                //rising edge
+                s->gpio_mis |= (~(s->gpio_is | s->gpio_ibe | s->gpio_iev)) & rising_edge;
+                //falling edge
+                s->gpio_mis |= ~(s->gpio_is | s->gpio_ibe | s->gpio_iev | rising_edge);
+                s->gpio_mis &= s->gpio_im;
+                s->gpio_ris |= s->gpio_mis & val32;
+
+                s->gpio_data = val32;
+                if (s->gpio_im != 0)
+                    qemu_irq_pulse(s->irq);
+            }
+            break;
+        case GPIO_DIR:
+            s->gpio_dir = val32;
+            break;
+        case GPIO_IS:
+            s->gpio_is = val32;
+            break;
+        case GPIO_IBE:
+            s->gpio_ibe = val32;
+            break;
+        case GPIO_IEV:
+            s->gpio_iev = val32;
+            break;
+        case GPIO_IM:
+            s->gpio_im = val32;
+            break;
+        case GPIO_RIS:
+            s->gpio_ris = val32;
+            break;
+        case GPIO_MIS:
+            READONLY;
+            break;
+        case GPIO_ICR:
+            s->gpio_mis ^= val32;
+            s->gpio_ris ^= val32;
+            s->gpio_icr = val32;
+            break;
+        case GPIO_AFSEL:
+            s->gpio_afsel = val32;
+            break;
+        case GPIO_DR2R:
+            s->gpio_dr2r = val32;
+            break;
+        case GPIO_DR4R:
+            s->gpio_dr4r = val32;
+            break;
+        case GPIO_DR8R:
+            s->gpio_dr8r = val32;
+            break;
+        case GPIO_ODR:
+            s->gpio_odr = val32;
+            break;
+        case GPIO_PUR:
+            s->gpio_pur = val32;
+            break;
+        case GPIO_PDR:
+            s->gpio_pdr = val32;
+            break;
+        case GPIO_SLR:
+            s->gpio_slr = val32;
+            break;
+        case GPIO_DEN:
+            s->gpio_den = val32;
+            break;
+        case GPIO_LOCK:
+            s->gpio_lock = val32;
+            break;
+        case GPIO_OCR:
+            s->gpio_ocr = val32;
+            break;
+        case GPIO_AMSEL:
+            s->gpio_amsel = val32;
+            break;
+        case GPIO_PCTL:
+            s->gpio_pctl = val32;
+            break;
+        case GPIO_ADCCTL:
+            s->gpio_adcctl = val32;
+            break;
+        case GPIO_DMACTL:
+            s->gpio_dmactl = val32;
+            break;
+        case GPIO_PER_ID4:
+            READONLY;
+            break;
+        case GPIO_PER_ID5:
+            READONLY;
+            break;
+        case GPIO_PER_ID6:
+            READONLY;
+            break;
+        case GPIO_PER_ID7:
+            READONLY;
+            break;
+        case GPIO_PER_ID0:
+            READONLY;
+            break;
+        case GPIO_PER_ID1:
+            READONLY;
+            break;
+        case GPIO_PER_ID2:
+            READONLY;
+            break;
+        case GPIO_PER_ID3:
+            READONLY;
+            break;
+        case GPIO_PCELL_ID0:
+            READONLY;
+            break;
+        case GPIO_PCELL_ID1:
+            READONLY;
+            break;
+        case GPIO_PCELL_ID2:
+            READONLY;
+            break;
+        case GPIO_PCELL_ID3:
+            READONLY;
+            break;
+        default:
+            LOG("Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+}
+
+static uint64_t tm4c123_gpio_read(void *opaque, hwaddr addr, unsigned int size)
+{
+    TM4C123GPIOState *s = opaque;
+
+    trace_tm4c123_gpio_read(addr);
+
+    if (!gpio_clock_enabled(s->sysctl, s->mmio.addr)) {
+        hw_error("GPIO module clock is not enabled");
+    }
+
+    switch(addr) {
+        case GPIO_DATA:
+            return s->gpio_data;
+        case GPIO_DIR:
+            return s->gpio_dir;
+        case GPIO_IS:
+            return s->gpio_is;
+        case GPIO_IBE:
+            return s->gpio_ibe;
+        case GPIO_IEV:
+            return s->gpio_iev;
+        case GPIO_IM:
+            return s->gpio_im;
+        case GPIO_RIS:
+            return s->gpio_ris;
+        case GPIO_MIS:
+            return s->gpio_mis;
+        case GPIO_ICR:
+            return s->gpio_icr;
+        case GPIO_AFSEL:
+            return s->gpio_afsel;
+        case GPIO_DR2R:
+            return s->gpio_dr2r;
+        case GPIO_DR4R:
+            return s->gpio_dr4r;
+        case GPIO_DR8R:
+            return s->gpio_dr8r;
+        case GPIO_ODR:
+            return s->gpio_odr;
+        case GPIO_PUR:
+            return s->gpio_pur;
+        case GPIO_PDR:
+            return s->gpio_pdr;
+        case GPIO_SLR:
+            return s->gpio_slr;
+        case GPIO_DEN:
+            return s->gpio_den;
+        case GPIO_LOCK:
+            return s->gpio_lock;
+        case GPIO_OCR:
+            return s->gpio_ocr;
+        case GPIO_AMSEL:
+            return s->gpio_amsel;
+        case GPIO_PCTL:
+            return s->gpio_pctl;
+        case GPIO_ADCCTL:
+            return s->gpio_adcctl;
+        case GPIO_DMACTL:
+            return s->gpio_dmactl;
+        case GPIO_PER_ID4:
+            return s->gpio_per_id4;
+        case GPIO_PER_ID5:
+            return s->gpio_per_id5;
+        case GPIO_PER_ID6:
+            return s->gpio_per_id6;
+        case GPIO_PER_ID7:
+            return s->gpio_per_id7;
+        case GPIO_PER_ID0:
+            return s->gpio_per_id0;
+        case GPIO_PER_ID1:
+            return s->gpio_per_id1;
+        case GPIO_PER_ID2:
+            return s->gpio_per_id2;
+        case GPIO_PER_ID3:
+            return s->gpio_per_id3;
+        case GPIO_PCELL_ID0:
+            return s->gpio_pcell_id0;
+        case GPIO_PCELL_ID1:
+            return s->gpio_pcell_id1;
+        case GPIO_PCELL_ID2:
+            return s->gpio_pcell_id2;
+        case GPIO_PCELL_ID3:
+            return s->gpio_pcell_id3;
+        default:
+            LOG("Bad address 0x%"HWADDR_PRIx"\n", addr);
+    }
+    return 0;
+}
+
+static const MemoryRegionOps tm4c123_gpio_ops = {
+    .read = tm4c123_gpio_read,
+    .write = tm4c123_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void tm4c123_gpio_init(Object *obj)
+{
+    TM4C123GPIOState *s = TM4C123_GPIO(obj);
+
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+    memory_region_init_io(&s->mmio, obj, &tm4c123_gpio_ops, s, TYPE_TM4C123_GPIO, 0xFFF);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+}
+
+static void tm4c123_gpio_class_init(ObjectClass *kclass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(kclass);
+    dc->reset = tm4c123_gpio_reset;
+}
+
+static const TypeInfo tm4c123_gpio_info = {
+    .name = TYPE_TM4C123_GPIO,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(TM4C123GPIOState),
+    .instance_init = tm4c123_gpio_init,
+    .class_init = tm4c123_gpio_class_init,
+};
+
+static void tm4c123_gpio_register_types(void)
+{
+    type_register_static(&tm4c123_gpio_info);
+}
+
+type_init(tm4c123_gpio_register_types)
diff --git a/include/hw/gpio/tm4c123_gpio.h b/include/hw/gpio/tm4c123_gpio.h
new file mode 100644
index 0000000000..5162e7bd53
--- /dev/null
+++ b/include/hw/gpio/tm4c123_gpio.h
@@ -0,0 +1,127 @@
+/*
+ * TM4C123 GPIO
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
+#ifndef HW_ARM_TM4C123_GPIO_H
+#define HW_ARM_TM4C123_GPIO_H
+
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "qom/object.h"
+#include "hw/misc/tm4c123_sysctl.h"
+
+/* #define GPIO_DATA 0x00 */
+#define GPIO_DATA 0x3FC
+#define GPIO_DIR 0x400
+#define GPIO_IS 0x404
+#define GPIO_IBE 0x408
+#define GPIO_IEV 0x40C
+#define GPIO_IM 0x410
+#define GPIO_RIS 0x414
+#define GPIO_MIS 0x418
+#define GPIO_ICR 0x41C
+#define GPIO_AFSEL 0x420
+#define GPIO_DR2R 0x500
+#define GPIO_DR4R 0x504
+#define GPIO_DR8R 0x508
+#define GPIO_ODR 0x50C
+#define GPIO_PUR 0x510
+#define GPIO_PDR 0x514
+#define GPIO_SLR 0x518
+#define GPIO_DEN 0x51C
+#define GPIO_LOCK 0x520
+#define GPIO_OCR 0x524
+#define GPIO_AMSEL 0x528
+#define GPIO_PCTL 0x52C
+#define GPIO_ADCCTL 0x530
+#define GPIO_DMACTL 0x534
+#define GPIO_PER_ID4 0xFD0
+#define GPIO_PER_ID5 0xFD4
+#define GPIO_PER_ID6 0xFD8
+#define GPIO_PER_ID7 0xFDC
+#define GPIO_PER_ID0 0XFE0
+#define GPIO_PER_ID1 0xFE4
+#define GPIO_PER_ID2 0xFE8
+#define GPIO_PER_ID3 0xFEC
+#define GPIO_PCELL_ID0 0xFF0
+#define GPIO_PCELL_ID1 0xFF4
+#define GPIO_PCELL_ID2 0xFF8
+#define GPIO_PCELL_ID3 0xFFC
+
+#define GPIO_A 0x40004000
+#define GPIO_B 0x40005000
+#define GPIO_C 0x40006000
+#define GPIO_D 0x40007000
+#define GPIO_E 0x40024000
+#define GPIO_F 0x40025000
+
+#define TYPE_TM4C123_GPIO "tm4c123-gpio"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TM4C123GPIOState, TM4C123_GPIO)
+
+struct TM4C123GPIOState {
+    SysBusDevice parent_obj;
+    MemoryRegion mmio;
+
+    uint32_t gpio_data;
+    uint32_t gpio_dir;
+    uint32_t gpio_is;
+    uint32_t gpio_ibe;
+    uint32_t gpio_iev;
+    uint32_t gpio_im;
+    uint32_t gpio_ris;
+    uint32_t gpio_mis;
+    uint32_t gpio_icr;
+    uint32_t gpio_afsel;
+    uint32_t gpio_dr2r;
+    uint32_t gpio_dr4r;
+    uint32_t gpio_dr8r;
+    uint32_t gpio_odr;
+    uint32_t gpio_pur;
+    uint32_t gpio_pdr;
+    uint32_t gpio_slr;
+    uint32_t gpio_den;
+    uint32_t gpio_lock;
+    uint32_t gpio_ocr;
+    uint32_t gpio_amsel;
+    uint32_t gpio_pctl;
+    uint32_t gpio_adcctl;
+    uint32_t gpio_dmactl;
+    uint32_t gpio_per_id4;
+    uint32_t gpio_per_id5;
+    uint32_t gpio_per_id6;
+    uint32_t gpio_per_id7;
+    uint32_t gpio_per_id0;
+    uint32_t gpio_per_id1;
+    uint32_t gpio_per_id2;
+    uint32_t gpio_per_id3;
+    uint32_t gpio_pcell_id0;
+    uint32_t gpio_pcell_id1;
+    uint32_t gpio_pcell_id2;
+    uint32_t gpio_pcell_id3;
+
+    qemu_irq irq;
+    TM4C123SysCtlState *sysctl;
+};
+
+#endif
-- 
2.34.1


