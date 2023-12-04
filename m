Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90899802991
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:36:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wnn-0004ly-NQ; Sun, 03 Dec 2023 19:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnG-0004SQ-GI; Sun, 03 Dec 2023 19:26:39 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnB-00006l-S9; Sun, 03 Dec 2023 19:26:36 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d05ff42db0so43606127b3.2; 
 Sun, 03 Dec 2023 16:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649592; x=1702254392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=imxvMsz0CNvo8nrzFvIRSqzHEH+HatWQq7mvnvZiPnw=;
 b=YVIOsLm5hrVUerbLAlqlZlCGaPxpl4fvkQeszgy75itZCjqYLfsTjphvRUvCskzUnd
 2o7b9o+82a5PLKDK9R2P9pIi/S7C1Eb9iFXKx4shP4AwUjxzvBVPNvrxFUeAtuEBW/nQ
 X2cIn8s1a2ZCB41MvAp0yfeCnPfxrXpiP0AYqZC7NTWvjd99aVQeZeV2yGrEQrQ0yk8J
 THzA4xHNGCs/clXZSN8uVrLyeAvGDVEP5Fw7w17joPDgijnjU8PavZRllkc6Q7kJF0ZL
 fjJobW5lNq2f8UEqEcgrzR4XgqTsJehrtfpup1pTctNcfrzvG61a8BO4vWUFB/ss9KeR
 NrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649592; x=1702254392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=imxvMsz0CNvo8nrzFvIRSqzHEH+HatWQq7mvnvZiPnw=;
 b=d7f3XlhJk6KssSR5rZw7Ut+REPFFgZSoOIU+F5p2VxeTpig4qrdQFmAbsh+J+98NEg
 ge9c26Nia8U+odvqRBsiuTF5NHBD5Qq/RI3QrBA4TBeX7kIFaq8BXnvpc2oQiUOzjwdO
 7xhXhp88ymWApR4JvryNRi4wkXHPbcpffmh+xMd8FuEt0g1FAz2CTEYTQFt5XkHOD6ay
 wltr2O+9RYR5IJZemcOtzZLoKKIHsQSdPQqMKCpWRFtTnhUkzPecjgfvwUneC697sNl6
 CfamSsVF/njmq92yQZYeU+fbsyMn+msjhORUj1BoMJ3kQhgTQRBgAWHPpmHUReeIAyHr
 v6dw==
X-Gm-Message-State: AOJu0YxTalAWHMsnqlDL72Fzq5DwXyu8K/sLW/5BqQpX7MiZm/gty3s6
 JFOMHiOMcU8hJ1mLV30hBDpmyk8bTW1SEw==
X-Google-Smtp-Source: AGHT+IFwx/farTQc0pFkqqw8wlF1j0V1+zso/oWU/1t73FJwr9/snSsnqTqElij8FBBp8znPiDI9Pg==
X-Received: by 2002:a81:57d5:0:b0:5d7:1941:2c21 with SMTP id
 l204-20020a8157d5000000b005d719412c21mr2240074ywb.78.1701649591864; 
 Sun, 03 Dec 2023 16:26:31 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:31 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 06/45] Add BCM2838 GPIO stub
Date: Sun,  3 Dec 2023 18:25:40 -0600
Message-Id: <20231204002619.1367044-7-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     |   4 +-
 hw/gpio/bcm2838_gpio.c               | 152 +++++++++++++++++++++++++++
 hw/gpio/meson.build                  |   5 +-
 include/hw/arm/bcm2838_peripherals.h |   2 -
 include/hw/gpio/bcm2838_gpio.h       |  40 +++++++
 5 files changed, 198 insertions(+), 5 deletions(-)
 create mode 100644 hw/gpio/bcm2838_gpio.c
 create mode 100644 include/hw/gpio/bcm2838_gpio.h

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 042e543006..8925957c6c 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -14,7 +14,7 @@
 #include "hw/arm/bcm2838.h"
 #include "trace.h"
 
-#define GIC400_MAINTAINANCE_IRQ      9
+#define GIC400_MAINTENANCE_IRQ      9
 #define GIC400_TIMER_NS_EL2_IRQ     10
 #define GIC400_TIMER_VIRT_IRQ       11
 #define GIC400_LEGACY_FIQ           12
@@ -163,7 +163,7 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
 
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
                            qdev_get_gpio_in(gicdev,
-                                            PPI(n, GIC400_MAINTAINANCE_IRQ)));
+                                            PPI(n, GIC400_MAINTENANCE_IRQ)));
 
         /* Connect timers from the CPU to the interrupt controller */
         qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
new file mode 100644
index 0000000000..15b66cb559
--- /dev/null
+++ b/hw/gpio/bcm2838_gpio.c
@@ -0,0 +1,152 @@
+/*
+ * Raspberry Pi (BCM2838) GPIO Controller
+ * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
+ *
+ * Copyright (c) 2022 Auriga LLC
+ *
+ * Authors:
+ *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/gpio/bcm2838_gpio.h"
+
+#define GPFSEL0   0x00
+#define GPFSEL1   0x04
+#define GPFSEL2   0x08
+#define GPFSEL3   0x0C
+#define GPFSEL4   0x10
+#define GPFSEL5   0x14
+#define GPSET0    0x1C
+#define GPSET1    0x20
+#define GPCLR0    0x28
+#define GPCLR1    0x2C
+#define GPLEV0    0x34
+#define GPLEV1    0x38
+#define GPEDS0    0x40
+#define GPEDS1    0x44
+#define GPREN0    0x4C
+#define GPREN1    0x50
+#define GPFEN0    0x58
+#define GPFEN1    0x5C
+#define GPHEN0    0x64
+#define GPHEN1    0x68
+#define GPLEN0    0x70
+#define GPLEN1    0x74
+#define GPAREN0   0x7C
+#define GPAREN1   0x80
+#define GPAFEN0   0x88
+#define GPAFEN1   0x8C
+
+#define GPIO_PUP_PDN_CNTRL_REG0 0xE4
+#define GPIO_PUP_PDN_CNTRL_REG1 0xE8
+#define GPIO_PUP_PDN_CNTRL_REG2 0xEC
+#define GPIO_PUP_PDN_CNTRL_REG3 0xF0
+
+#define RESET_VAL_CNTRL_REG0 0xAAA95555;
+#define RESET_VAL_CNTRL_REG1 0xA0AAAAAA;
+#define RESET_VAL_CNTRL_REG2 0x50AAA95A;
+#define RESET_VAL_CNTRL_REG3 0x00055555;
+
+#define BYTES_IN_WORD        4
+
+static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = 0;
+
+    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                  TYPE_BCM2838_GPIO, __func__, offset);
+
+    return value;
+}
+
+static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                  TYPE_BCM2838_GPIO, __func__, offset);
+}
+
+static void bcm2838_gpio_reset(DeviceState *dev)
+{
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+
+    s->lev0 = 0;
+    s->lev1 = 0;
+
+    s->pup_cntrl_reg[0] = RESET_VAL_CNTRL_REG0;
+    s->pup_cntrl_reg[1] = RESET_VAL_CNTRL_REG1;
+    s->pup_cntrl_reg[2] = RESET_VAL_CNTRL_REG2;
+    s->pup_cntrl_reg[3] = RESET_VAL_CNTRL_REG3;
+}
+
+static const MemoryRegionOps bcm2838_gpio_ops = {
+    .read = bcm2838_gpio_read,
+    .write = bcm2838_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription vmstate_bcm2838_gpio = {
+    .name = "bcm2838_gpio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(fsel, BCM2838GpioState, BCM2838_GPIO_NUM),
+        VMSTATE_UINT32(lev0, BCM2838GpioState),
+        VMSTATE_UINT32(lev1, BCM2838GpioState),
+        VMSTATE_UINT8(sd_fsel, BCM2838GpioState),
+        VMSTATE_UINT32_ARRAY(pup_cntrl_reg, BCM2838GpioState,
+                             GPIO_PUP_PDN_CNTRL_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2838_gpio_init(Object *obj)
+{
+    BCM2838GpioState *s = BCM2838_GPIO(obj);
+    DeviceState *dev = DEVICE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &bcm2838_gpio_ops, s,
+                          "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    qdev_init_gpio_out(dev, s->out, BCM2838_GPIO_NUM);
+}
+
+static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
+{
+    /* Temporary stub. Do nothing */
+}
+
+static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_bcm2838_gpio;
+    dc->realize = &bcm2838_gpio_realize;
+    dc->reset = &bcm2838_gpio_reset;
+}
+
+static const TypeInfo bcm2838_gpio_info = {
+    .name          = TYPE_BCM2838_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GpioState),
+    .instance_init = bcm2838_gpio_init,
+    .class_init    = bcm2838_gpio_class_init,
+};
+
+static void bcm2838_gpio_register_types(void)
+{
+    type_register_static(&bcm2838_gpio_info);
+}
+
+type_init(bcm2838_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 066ea96480..8a8d03d885 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -9,6 +9,9 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files(
+    'bcm2835_gpio.c',
+    'bcm2838_gpio.c'
+))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 5a72355183..d07831753a 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,8 +11,6 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 
-#define GENET_OFFSET            0x1580000
-
 /* SPI */
 #define GIC_SPI_INTERRUPT_MBOX         33
 #define GIC_SPI_INTERRUPT_MPHI         40
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
new file mode 100644
index 0000000000..06d48e0c19
--- /dev/null
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -0,0 +1,40 @@
+/*
+ * Raspberry Pi (BCM2838) GPIO Controller
+ * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
+ *
+ * Copyright (c) 2022 Auriga LLC
+ *
+ * Authors:
+ *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_GPIO_H
+#define BCM2838_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_GPIO "bcm2838-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GpioState, BCM2838_GPIO)
+
+#define BCM2838_GPIO_REGS_SIZE 0x1000
+#define BCM2838_GPIO_NUM       58
+#define GPIO_PUP_PDN_CNTRL_NUM 4
+
+struct BCM2838GpioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+
+    uint8_t fsel[BCM2838_GPIO_NUM];
+    uint32_t lev0, lev1;
+    uint8_t sd_fsel;
+    qemu_irq out[BCM2838_GPIO_NUM];
+    uint32_t pup_cntrl_reg[GPIO_PUP_PDN_CNTRL_NUM];
+};
+
+#endif
-- 
2.34.1


