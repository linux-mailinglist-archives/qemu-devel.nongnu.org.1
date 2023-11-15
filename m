Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6338134AC
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 16:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDnYo-0003DS-OX; Thu, 14 Dec 2023 10:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rDnYW-0003Ak-S8; Thu, 14 Dec 2023 10:23:20 -0500
Received: from mail-b.sr.ht ([173.195.146.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1rDnYU-0000xk-GZ; Thu, 14 Dec 2023 10:23:20 -0500
Authentication-Results: mail-b.sr.ht; dkim=none 
Received: from git.sr.ht (unknown [173.195.146.142])
 by mail-b.sr.ht (Postfix) with ESMTPSA id 27A2211EEFB;
 Thu, 14 Dec 2023 15:23:16 +0000 (UTC)
From: ~inesvarhol <inesvarhol@git.sr.ht>
Date: Wed, 15 Nov 2023 09:04:50 +0100
Subject: [PATCH qemu v3 2/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
MIME-Version: 1.0
Message-ID: <170256739558.25729.14053113716470464567-2@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <170256739558.25729.14053113716470464567-0@git.sr.ht>
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
There are no peripherals implemented yet, only memory regions.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 MAINTAINERS                             |  7 +++
 configs/devices/arm-softmmu/default.mak |  1 +
 hw/arm/Kconfig                          |  6 +++
 hw/arm/b-l475e-iot01a.c                 | 70 +++++++++++++++++++++++++
 hw/arm/meson.build                      |  1 +
 5 files changed, 85 insertions(+)
 create mode 100644 hw/arm/b-l475e-iot01a.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5b28aee28..3f3831c92a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1131,6 +1131,13 @@ S: Maintained
 F: hw/arm/stm32l4x5_soc.c
 F: include/hw/arm/stm32l4x5_soc.h
=20
+B-L475E-IOT01A IoT Node
+M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
+M: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/b-l475e-iot01a.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
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
index 0000000000..c3790e3dc8
--- /dev/null
+++ b/hw/arm/b-l475e-iot01a.c
@@ -0,0 +1,70 @@
+/*
+ * B-L475E-IOT01A Discovery Kit machine
+ * (B-L475E-IOT01A IoT Node)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is heavily inspired by the netduinoplus2 by Alistair Francis.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics UM2153 User manual
+ * Discovery kit for IoT node, multi-channel communication with STM32L4.
+ * https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html#documentation
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

