Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514687F18BB
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 17:36:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57FC-0001B1-F2; Mon, 20 Nov 2023 11:35:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r57Ey-00017a-Db; Mon, 20 Nov 2023 11:35:18 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1r57Eq-0006z1-JM; Mon, 20 Nov 2023 11:35:15 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 51DED11F058;
 Mon, 20 Nov 2023 16:35:05 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Wed, 15 Nov 2023 09:04:50 +0100
Subject: [PATCH RFC v3 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A
 board
MIME-Version: 1.0
Message-ID: <170049810484.22920.612074576971878323-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170049810484.22920.612074576971878323-0@git.sr.ht>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, philmd@linaro.org,
 peter.maydell@linaro.org, ines.varhol@telecom-paris.fr,
 arnaud.minier@telecom-paris.fr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=173.195.146.151; envelope-from=outgoing@sr.ht;
 helo=mail-b.sr.ht
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: ~inesvarhol <inesvarhol@proton.me>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>

This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC.
The implementation is derived from the Netduino Plus 2 machine.
There are no peripherals implemented, only memory regions.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 configs/devices/arm-softmmu/default.mak |  1 +
 hw/arm/Kconfig                          |  6 ++
 hw/arm/b-l475e-iot01a.c                 | 77 +++++++++++++++++++++++++
 hw/arm/meson.build                      |  1 +
 4 files changed, 85 insertions(+)
 create mode 100644 hw/arm/b-l475e-iot01a.c

diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-so=
ftmmu/default.mak
index 980c48a7d9..023faa2f75 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -19,6 +19,7 @@ CONFIG_ARM_VIRT=3Dy
 # CONFIG_NSERIES=3Dn
 # CONFIG_STELLARIS=3Dn
 # CONFIG_STM32VLDISCOVERY=3Dn
+# CONFIG_B_L475E_IOT01A=3Dn
 # CONFIG_REALVIEW=3Dn
 # CONFIG_VERSATILE=3Dn
 # CONFIG_VEXPRESS=3Dn
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d2b94d9a47..7520dc5cc0 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -448,6 +448,12 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
=20
+config B_L475E_IOT01A
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32L4X5_SOC
+
 config STM32L4X5_SOC
     bool
     select ARM_V7M
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
new file mode 100644
index 0000000000..8e2501aeae
--- /dev/null
+++ b/hw/arm/b-l475e-iot01a.c
@@ -0,0 +1,77 @@
+/*
+ * B-L475E-IOT01A Discovery Kit machine
+ * (B-L475E-IOT01A IoT Node)
+ *
+ * SPDX-License-Identifier: MIT
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Ines Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a c=
opy
+ * of this software and associated documentation files (the "Software"), to =
deal
+ * in the Software without restriction, including without limitation the rig=
hts
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
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING F=
ROM,
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
+#include "hw/arm/stm32l4x5_soc.h"
+#include "hw/arm/boot.h"
+
+/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
+
+/* Main SYSCLK frequency in Hz (80MHz) */
+#define SYSCLK_FRQ 80000000ULL
+
+static void b_l475e_iot01a_init(MachineState *machine)
+{
+    const Stm32l4x5SocClass *sc;
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency */
+    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, SYSCLK_FRQ);
+
+    dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
+    sc =3D STM32L4X5_SOC_GET_CLASS(dev);
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, sc->flash_size);
+}
+
+static void b_l475e_iot01a_machine_init(MachineClass *mc)
+{
+    static const char *machine_valid_cpu_types[] =3D {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL};
+    mc->desc =3D "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
+    mc->init =3D b_l475e_iot01a_init;
+    mc->valid_cpu_types =3D machine_valid_cpu_types;
+
+    /* SRAM pre-allocated as part of the SoC instantiation */
+    mc->default_ram_size =3D 0;
+}
+
+DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9766da10c4..bb92b27db3 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c'=
, 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
 arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', '=
xlnx-zcu102.c'))
 arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx=
-versal-virt.c'))
--=20
2.38.5

