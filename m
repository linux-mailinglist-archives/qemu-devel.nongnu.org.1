Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9715882C441
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:08:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKze-0005K0-NR; Fri, 12 Jan 2024 12:06:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKzc-0005Ir-HS; Fri, 12 Jan 2024 12:06:52 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rOKzY-00050Z-3y; Fri, 12 Jan 2024 12:06:52 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id A6E9880689;
 Fri, 12 Jan 2024 18:06:42 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id gWrdwKkOY9M1; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 4FCC08066D;
 Fri, 12 Jan 2024 18:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 4FCC08066D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1705079201;
 bh=e8CaFPt3t7WNykfq9lSxgZInyTaxN+5SCk6ipY+Z7Fk=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=ms5wDZfh8qiP8RqQviu5TnQvV3jQO8Xp8B56oxRwGaaaz4+4jrRgXEJuNFsRyCVuO
 1+P1Lh2sOBo9oTi4WVfd4qyAnJD0hdIBmxv5EbI4U7cLJyIAtWOtxoRDTvTWI/N5ZK
 J3sTrWeG7YMBuUUCSdMCSYbvWXGEhqSlOlvQwA/8=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 7eOnXL6mgMr2; Fri, 12 Jan 2024 18:06:41 +0100 (CET)
Received: from inesv-Inspiron-3501.enst.fr (unknown
 [IPv6:2a04:8ec0:0:240:fa97:9da:79c1:e167])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 093C380689;
 Fri, 12 Jan 2024 18:06:41 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [RFC 1/3] hw/gpio: Implement STM32L4x5 GPIO
Date: Fri, 12 Jan 2024 18:05:38 +0100
Message-ID: <20240112170635.303226-2-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112170635.303226-1-ines.varhol@telecom-paris.fr>
References: <20240112170635.303226-1-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.221;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 docs/system/arm/b-l475e-iot01a.rst |   2 +-
 hw/gpio/Kconfig                    |   3 +
 hw/gpio/meson.build                |   1 +
 hw/gpio/stm32l4x5_gpio.c           | 520 +++++++++++++++++++++++++++++
 hw/gpio/trace-events               |   6 +
 include/hw/gpio/stm32l4x5_gpio.h   |  79 +++++
 6 files changed, 610 insertions(+), 1 deletion(-)
 create mode 100644 hw/gpio/stm32l4x5_gpio.c
 create mode 100644 include/hw/gpio/stm32l4x5_gpio.h

diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
index 1a021b306a..fe1143e05e 100644
--- a/docs/system/arm/b-l475e-iot01a.rst
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -17,6 +17,7 @@ Currently B-L475E-IOT01A machine's only supports the fo=
llowing devices:
 - Cortex-M4F based STM32L4x5 SoC
 - STM32L4x5 EXTI (Extended interrupts and events controller)
 - STM32L4x5 SYSCFG (System configuration controller)
+- STM32L4x5 GPIOs (General-purpose I/Os)
=20
 Missing devices
 """""""""""""""
@@ -25,7 +26,6 @@ The B-L475E-IOT01A does *not* support the following dev=
ices:
=20
 - Reset and clock control (RCC)
 - Serial ports (UART)
-- General-purpose I/Os (GPIO)
 - Analog to Digital Converter (ADC)
 - SPI controller
 - Timer controller (TIMER)
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig
index d2cf3accc8..712940b8e0 100644
--- a/hw/gpio/Kconfig
+++ b/hw/gpio/Kconfig
@@ -16,3 +16,6 @@ config GPIO_PWR
=20
 config SIFIVE_GPIO
     bool
+
+config STM32L4X5_GPIO
+    bool
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 066ea96480..8470ca1639 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -9,6 +9,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpi=
o.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
+system_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_gp=
io.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c')=
)
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'=
))
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
new file mode 100644
index 0000000000..2199d12c76
--- /dev/null
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -0,0 +1,520 @@
+/*
+ * STM32L4x5 GPIO (General Purpose Input/Ouput)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/gpio/stm32l4x5_gpio.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+
+#define GPIO_MODER 0x00
+#define GPIO_OTYPER 0x04
+#define GPIO_OSPEEDR 0x08
+#define GPIO_PUPDR 0x0C
+#define GPIO_IDR 0x10
+#define GPIO_ODR 0x14
+#define GPIO_BSRR 0x18
+#define GPIO_LCKR 0x1C
+#define GPIO_AFRL 0x20
+#define GPIO_AFRH 0x24
+#define GPIO_BRR 0x28
+#define GPIO_ASCR 0x2C
+/*
+ * DISCONNECTED_PINS isn't actually a GPIO register.
+ * It exists to ensure that :
+ * - push-pull output pins can't be set externally
+ * - open-drain output pins can only be externally set to 0
+ *
+ * This field is accessed for test purposes.
+ */
+#define GPIO_DISCONNECTED_PINS 0x30
+
+/* 0b11111111_11111111_00000000_00000000 */
+#define RESERVED_BITS_MASK 0xFFFF0000
+
+static void update_gpio_idr(Stm32l4x5GpioState *s);
+
+static void stm32l4x5_gpio_reset_hold(Object *obj)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_GET_CLASS(obj);
+
+    s->moder =3D sc->moder_reset;
+    s->otyper =3D 0x00000000;
+    s->ospeedr =3D sc->ospeedr_reset;
+    s->pupdr =3D sc->pupdr_reset;
+    s->idr =3D 0x00000000;
+    s->odr =3D 0x00000000;
+    s->lckr =3D 0x00000000;
+    s->afrl =3D 0x00000000;
+    s->afrh =3D 0x00000000;
+    s->ascr =3D 0x00000000;
+
+    s->disconnected_pins =3D 0xFFFF;
+    s->pins_connected_high =3D 0x0000;
+    update_gpio_idr(s);
+}
+
+static void stm32l4x5_gpio_set(void *opaque, int line, int level)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+    /*
+     * The pin isn't set if line is configured in output mode
+     * except if level is 0 and the output is open-drain.
+     * This way there will be no short-circuit prone situations.
+     */
+    if ((extract32(s->moder, 2 * line, 2) =3D=3D 1) &&
+        !((extract32(s->otyper, line, 1) =3D=3D 1) &&
+          (level =3D=3D 0))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Line %d can't be driven external=
ly\n",
+                      line);
+        return;
+    }
+
+    s->disconnected_pins &=3D ~(1 << line);
+    if (level) {
+        s->pins_connected_high |=3D (1 << line);
+    } else {
+        s->pins_connected_high &=3D ~(1 << line);
+    }
+    trace_stm32l4x5_gpio_pins(s->disconnected_pins,
+                              s->pins_connected_high);
+    update_gpio_idr(s);
+}
+
+
+static void update_gpio_idr(Stm32l4x5GpioState *s)
+{
+    uint32_t new_idr_mask =3D 0;
+    uint32_t new_idr =3D s->odr;
+
+    for (int i =3D 0; i < 16; i++) {
+        /* output mode */
+        if (extract32(s->moder, 2 * i, 2) =3D=3D 1) {
+            if (extract32(s->otyper, i, 1) =3D=3D 0) {
+                /* push-pull */
+                new_idr_mask |=3D (1 << i);
+            } else if (!(s->odr & (1 << i))) {
+                /* open-drain ODR 0 */
+                new_idr_mask |=3D (1 << i);
+            } else if ((s->disconnected_pins & (1 << i)) &&
+                       (extract32(s->pupdr, 2 * i, 2) =3D=3D 1)) {
+                /* open-drain pull-up ODR 1 with floating pin */
+                new_idr_mask |=3D (1 << i);
+            } else if ((s->disconnected_pins & (1 << i)) &&
+                       (extract32(s->pupdr, 2 * i, 2) =3D=3D 2)) {
+                /* open-drain pull-down ODR 1 with floating pin */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            } else if (!(s->pins_connected_high & (1 << i))) {
+                /* open-drain ODR 1 with pin connected low */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            } else {
+                /* open-drain ODR 1 with pin connected high */
+                assert(false);
+            }
+        /* input or analog mode with connected pin */
+        } else if (!(s->disconnected_pins & (1 << i))) {
+            if (s->pins_connected_high & (1 << i)) {
+                /* pin high */
+                new_idr_mask |=3D (1 << i);
+                new_idr |=3D (1 << i);
+            } else {
+                /* pin low */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            }
+        /* input or analog mode with disconnected pin */
+        } else {
+            if (extract32(s->pupdr, 2 * i, 2) =3D=3D 1) {
+                /* pull-up */
+                new_idr_mask |=3D (1 << i);
+                new_idr |=3D (1 << i);
+            } else if (extract32(s->pupdr, 2 * i, 2) =3D=3D 2) {
+                /* pull-down */
+                new_idr_mask |=3D (1 << i);
+                new_idr &=3D ~(1 << i);
+            }
+        }
+    }
+
+    uint32_t old_idr =3D s->idr;
+    s->idr =3D (old_idr & ~new_idr_mask) | (new_idr & new_idr_mask);
+    trace_stm32l4x5_gpio_update_idr(old_idr, s->idr);
+
+    for (int i =3D 0; i < 16; i++) {
+        if (new_idr_mask & (1 << i)) {
+            if ((new_idr & (1 << i)) > (old_idr & (1 << i))) {
+                qemu_irq_raise(s->pin[i]);
+            } else if ((new_idr & (1 << i)) < (old_idr & (1 << i))) {
+                qemu_irq_lower(s->pin[i]);
+            }
+        }
+    }
+}
+
+/*
+ * Return pins both configured in output mode
+ * and externally driven (except pins in open-drain
+ * mode externally set to 0).
+ */
+static uint32_t get_gpio_pins_to_disconnect(Stm32l4x5GpioState *s)
+{
+    uint32_t pins_to_disconnect =3D 0;
+    for (int i =3D 0; i < 16; i++) {
+        /* for each connected pin in output mode */
+        if ((~s->disconnected_pins & (1 << i)) &
+            (extract32(s->moder, 2 * i, 2) =3D=3D 1)) {
+            /* if either push-pull or high level */
+            if ((extract32(s->otyper, i, 1) =3D=3D 0) ||
+                (extract16(s->pins_connected_high, i, 1)) =3D=3D 1) {
+                pins_to_disconnect |=3D (1 << i);
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Line %d can't be driven externally\n",
+                              i);
+            }
+        }
+    }
+    return pins_to_disconnect;
+}
+
+/*
+ * Set field `disconnected_pins` and call `update_gpio_idr()`
+ */
+static void disconnect_gpio_pins(Stm32l4x5GpioState *s, uint16_t lines)
+{
+    s->disconnected_pins |=3D lines;
+    trace_stm32l4x5_gpio_pins(s->disconnected_pins,
+                              s->pins_connected_high);
+    update_gpio_idr(s);
+}
+
+static void stm32l4x5_gpio_write(void *opaque, hwaddr addr,
+                                 uint64_t val64, unsigned int size)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+
+    uint32_t value =3D val64;
+    trace_stm32l4x5_gpio_write(addr, val64);
+
+    switch (addr) {
+    case GPIO_MODER:
+        s->moder =3D value;
+        disconnect_gpio_pins(s, get_gpio_pins_to_disconnect(s));
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Alternate function mode isn't supported\n\
+                      Setting alternate function mode sets analog mode\n=
",
+                      __func__);
+        return;
+    case GPIO_OTYPER:
+        s->otyper =3D value & ~RESERVED_BITS_MASK;
+        disconnect_gpio_pins(s, get_gpio_pins_to_disconnect(s));
+        return;
+    case GPIO_OSPEEDR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Changing the I/O output speed isn't supported=
\n",
+                      __func__);
+        s->ospeedr =3D value;
+        return;
+    case GPIO_PUPDR:
+        s->pupdr =3D value;
+        update_gpio_idr(s);
+        return;
+    case GPIO_IDR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: GPIO->IDR is read-only\n",
+                      __func__);
+        return;
+    case GPIO_ODR:
+        s->odr =3D value & ~RESERVED_BITS_MASK;
+        update_gpio_idr(s);
+        return;
+    case GPIO_BSRR: {
+        uint32_t bits_to_reset =3D (value & RESERVED_BITS_MASK) >> 16;
+        uint32_t bits_to_set =3D value & ~RESERVED_BITS_MASK;
+        /* If both BSx and BRx are set, BSx has priority.*/
+        s->odr &=3D ~bits_to_reset;
+        s->odr |=3D bits_to_set;
+        update_gpio_idr(s);
+        return;
+    }
+    case GPIO_LCKR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Locking port bits configuration isn't support=
ed\n",
+                      __func__);
+        s->lckr =3D value & ~RESERVED_BITS_MASK;
+        return;
+    case GPIO_AFRL:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Alternate functions aren't supported\n",
+                      __func__);
+        s->afrl =3D value;
+        return;
+    case GPIO_AFRH:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Alternate functions aren't supported\n",
+                      __func__);
+        s->afrh =3D value;
+        return;
+    case GPIO_BRR: {
+        uint32_t bits_to_reset =3D value & ~RESERVED_BITS_MASK;
+        s->odr &=3D ~bits_to_reset;
+        update_gpio_idr(s);
+        return;
+    }
+    case GPIO_ASCR:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: ADC function isn't supported\n",
+                      __func__);
+        s->ascr =3D value & ~RESERVED_BITS_MASK;
+        return;
+    /* a tweak to enable the qtest checking disconnected pins */
+    case GPIO_DISCONNECTED_PINS:
+        disconnect_gpio_pins(s, value);
+        return;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
+    }
+}
+
+static uint64_t stm32l4x5_gpio_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Stm32l4x5GpioState *s =3D opaque;
+
+    trace_stm32l4x5_gpio_read(addr);
+
+    switch (addr) {
+    case GPIO_MODER:
+        return s->moder;
+    case GPIO_OTYPER:
+        return s->otyper;
+    case GPIO_OSPEEDR:
+        return s->ospeedr;
+    case GPIO_PUPDR:
+        return s->pupdr;
+    case GPIO_IDR:
+        return s->idr;
+    case GPIO_ODR:
+        return s->odr;
+    case GPIO_BSRR:
+        return 0;
+    case GPIO_LCKR:
+        return s->lckr;
+    case GPIO_AFRL:
+        return s->afrl;
+    case GPIO_AFRH:
+        return s->afrh;
+    case GPIO_BRR:
+        return 0;
+    case GPIO_ASCR:
+        return s->ascr;
+    /* a tweak to enable the qtest checking disconnected pins */
+    case GPIO_DISCONNECTED_PINS:
+        return s->disconnected_pins;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, a=
ddr);
+        return 0;
+    }
+}
+
+static const MemoryRegionOps stm32l4x5_gpio_ops =3D {
+    .read =3D stm32l4x5_gpio_read,
+    .write =3D stm32l4x5_gpio_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+    .valid =3D {
+        .min_access_size =3D 4,
+        .max_access_size =3D 4,
+        .unaligned =3D false,
+    },
+};
+
+static void stm32l4x5_gpio_init(Object *obj)
+{
+    Stm32l4x5GpioState *s =3D STM32L4X5_GPIO(obj);
+    int i;
+
+    for (i =3D 0; i < GPIO_NUM_PINS; i++) {
+        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->pin[i]);
+    }
+
+    memory_region_init_io(&s->mmio, obj, &stm32l4x5_gpio_ops, s,
+                          TYPE_STM32L4X5_GPIO, 0x400);
+
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+    qdev_init_gpio_out(DEVICE(obj), s->pin, GPIO_NUM_PINS);
+    qdev_init_gpio_in(DEVICE(obj), stm32l4x5_gpio_set, GPIO_NUM_PINS);
+}
+
+static const VMStateDescription vmstate_stm32l4x5_gpio =3D {
+    .name =3D TYPE_STM32L4X5_GPIO,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]){
+        VMSTATE_UINT32(moder, Stm32l4x5GpioState),
+        VMSTATE_UINT32(otyper, Stm32l4x5GpioState),
+        VMSTATE_UINT32(ospeedr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(pupdr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(idr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(odr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(lckr, Stm32l4x5GpioState),
+        VMSTATE_UINT32(afrl, Stm32l4x5GpioState),
+        VMSTATE_UINT32(afrh, Stm32l4x5GpioState),
+        VMSTATE_UINT32(ascr, Stm32l4x5GpioState),
+        VMSTATE_UINT16(disconnected_pins, Stm32l4x5GpioState),
+        VMSTATE_UINT16(pins_connected_high, Stm32l4x5GpioState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void stm32l4x5_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_stm32l4x5_gpio;
+    rc->phases.hold =3D stm32l4x5_gpio_reset_hold;
+}
+
+static void stm32l4x5_gpio_a_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xABFFFFFF;
+    sc->ospeedr_reset =3D 0x0C000000;
+    sc->pupdr_reset =3D 0x64000000;
+}
+
+static void stm32l4x5_gpio_b_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFEBF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000100;
+}
+
+static void stm32l4x5_gpio_c_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFFFF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static void stm32l4x5_gpio_d_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFFFF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static void stm32l4x5_gpio_e_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFFFF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static void stm32l4x5_gpio_f_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFFFF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static void stm32l4x5_gpio_g_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0xFFFFFFFF;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static void stm32l4x5_gpio_h_class_init(ObjectClass *klass, void *data)
+{
+    Stm32l4x5GpioClass *sc =3D STM32L4X5_GPIO_CLASS(klass);
+
+    sc->moder_reset =3D 0x0000000F;
+    sc->ospeedr_reset =3D 0x00000000;
+    sc->pupdr_reset =3D 0x00000000;
+}
+
+static const TypeInfo stm32l4x5_gpio_types[] =3D {
+    {
+        .name =3D TYPE_STM32L4X5_GPIO,
+        .parent =3D TYPE_SYS_BUS_DEVICE,
+        .instance_size =3D sizeof(Stm32l4x5GpioState),
+        .instance_init =3D stm32l4x5_gpio_init,
+        .class_size     =3D sizeof(Stm32l4x5GpioClass),
+        .class_init =3D stm32l4x5_gpio_class_init,
+        .abstract =3D true,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_A,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_a_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_B,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_b_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_C,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_c_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_D,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_d_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_E,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_e_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_F,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_f_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_G,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_g_class_init,
+    }, {
+        .name =3D TYPE_STM32L4X5_GPIO_H,
+        .parent =3D TYPE_STM32L4X5_GPIO,
+        .class_init =3D stm32l4x5_gpio_h_class_init,
+    },
+};
+
+DEFINE_TYPES(stm32l4x5_gpio_types)
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 9736b362ac..8cbf75a897 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -31,3 +31,9 @@ sifive_gpio_update_output_irq(int64_t line, int64_t val=
ue) "line %" PRIi64 " val
 # aspeed_gpio.c
 aspeed_gpio_read(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 "=
 value 0x%" PRIx64
 aspeed_gpio_write(uint64_t offset, uint64_t value) "offset: 0x%" PRIx64 =
" value 0x%" PRIx64
+
+# stm32l4x5_gpio.c
+stm32l4x5_gpio_read(uint64_t addr) "reg read: addr: 0x%" PRIx64 " "
+stm32l4x5_gpio_write(uint64_t addr, uint64_t data) "reg write: addr: 0x%=
" PRIx64 " val: 0x%" PRIx64 ""
+stm32l4x5_gpio_update_idr(uint32_t old_idr, uint32_t new_idr) "previous =
idr: 0x%x new idr: 0x%x"
+stm32l4x5_gpio_pins(uint16_t disconnected, uint16_t high) "disconnected =
pins: 0x%x levels: 0x%x"
diff --git a/include/hw/gpio/stm32l4x5_gpio.h b/include/hw/gpio/stm32l4x5=
_gpio.h
new file mode 100644
index 0000000000..7d6c16f6b9
--- /dev/null
+++ b/include/hw/gpio/stm32l4x5_gpio.h
@@ -0,0 +1,79 @@
+/*
+ * STM32L4x5 GPIO (General Purpose Input/Ouput)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * The reference used is the STMicroElectronics RM0351 Reference manual
+ * for STM32L4x5 and STM32L4x6 advanced Arm =C2=AE -based 32-bit MCUs.
+ * https://www.st.com/en/microcontrollers-microprocessors/stm32l4x5/docu=
mentation.html
+ */
+
+#ifndef HW_STM32L4X5_GPIO_H
+#define HW_STM32L4X5_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_STM32L4X5_GPIO "stm32l4x5-gpio"
+#define TYPE_STM32L4X5_GPIO_A "stm32l4x5-gpio-a"
+#define TYPE_STM32L4X5_GPIO_B "stm32l4x5-gpio-b"
+#define TYPE_STM32L4X5_GPIO_C "stm32l4x5-gpio-c"
+#define TYPE_STM32L4X5_GPIO_D "stm32l4x5-gpio-d"
+#define TYPE_STM32L4X5_GPIO_E "stm32l4x5-gpio-e"
+#define TYPE_STM32L4X5_GPIO_F "stm32l4x5-gpio-f"
+#define TYPE_STM32L4X5_GPIO_G "stm32l4x5-gpio-g"
+#define TYPE_STM32L4X5_GPIO_H "stm32l4x5-gpio-h"
+OBJECT_DECLARE_TYPE(Stm32l4x5GpioState, Stm32l4x5GpioClass, STM32L4X5_GP=
IO)
+
+#define GPIO_NUM_PINS 16
+
+struct Stm32l4x5GpioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    /* GPIO registers */
+    uint32_t moder;
+    uint32_t otyper;
+    uint32_t ospeedr;
+    uint32_t pupdr;
+    uint32_t idr;
+    uint32_t odr;
+    uint32_t lckr;
+    uint32_t afrl;
+    uint32_t afrh;
+    uint32_t ascr;
+
+    /*
+     * External driving of pins.
+     * The pins can be set externally through the device
+     * anonymous input GPIOs lines under certain conditions.
+     * The pin must not be in push-pull output mode,
+     * and can't be set high in open-drain mode.
+     * Pins driven externally and configured to
+     * output mode will in general be "disconnected"
+     * (see `get_gpio_pins_to_disconnect()`)
+     */
+    uint16_t disconnected_pins;
+    uint16_t pins_connected_high;
+
+    qemu_irq pin[GPIO_NUM_PINS];
+};
+
+struct Stm32l4x5GpioClass {
+    SysBusDeviceClass parent_class;
+
+    uint32_t moder_reset;
+    uint32_t ospeedr_reset;
+    uint32_t pupdr_reset;
+};
+
+#endif
--=20
2.43.0


