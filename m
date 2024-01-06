Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBD98260A7
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 17:40:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM9hk-0002sl-Dt; Sat, 06 Jan 2024 11:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rM9hi-0002sL-Lf; Sat, 06 Jan 2024 11:39:22 -0500
Received: from zproxy2.enst.fr ([137.194.2.221])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rM9hf-0007Al-VZ; Sat, 06 Jan 2024 11:39:22 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 9129A8089B;
 Sat,  6 Jan 2024 17:39:15 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id 1sB6CsmnsrP8; Sat,  6 Jan 2024 17:39:14 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id B873480800;
 Sat,  6 Jan 2024 17:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr B873480800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1704559154;
 bh=6KB2b8B5P/Jtso+W1CaKlzgnOB3ixK228ikk4vY23eg=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=w6rEbaXi0jNsgaVGVQmFrUKBhmrYRG4aI4zybHz7orBVUS+yHOIVKM7ATozAkkxsK
 FkiUk+zj7/QdZE5kYuxyRuvLwoLG8auFHM6fIstffg/Q+WOo8roF8Q0Z7MyqSXGv6K
 Ys7weDgyVU6X7AChD/ETcsK36eozbknzUC7BJDKU=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id q3cBwLISU2zy; Sat,  6 Jan 2024 17:39:14 +0100 (CET)
Received: from localhost.localdomain (74.0.125.80.rev.sfr.net [80.125.0.74])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 75BF48089B;
 Sat,  6 Jan 2024 17:39:14 +0100 (CET)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v5 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A
 board
Date: Sat,  6 Jan 2024 17:38:41 +0100
Message-ID: <20240106163905.42027-3-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106163905.42027-1-ines.varhol@telecom-paris.fr>
References: <20240106163905.42027-1-ines.varhol@telecom-paris.fr>
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

This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC
as well as a dedicated documentation file.
The implementation is derived from the Netduino Plus 2 machine.
There are no peripherals implemented yet, only memory regions.

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 MAINTAINERS                             |  7 +++
 configs/devices/arm-softmmu/default.mak |  1 +
 docs/system/arm/b-l475e-iot01a.rst      | 46 ++++++++++++++++
 docs/system/arm/stm32.rst               |  6 ++-
 docs/system/target-arm.rst              |  1 +
 hw/arm/Kconfig                          |  6 +++
 hw/arm/b-l475e-iot01a.c                 | 72 +++++++++++++++++++++++++
 hw/arm/meson.build                      |  1 +
 8 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/arm/b-l475e-iot01a.rst
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
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/ar=
m-softmmu/default.mak
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
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e=
-iot01a.rst
new file mode 100644
index 0000000000..2b128e6b84
--- /dev/null
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -0,0 +1,46 @@
+B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
+ARM Cortex-M4F core. It is part of STMicroelectronics
+:doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L=
4
+ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
+integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A b=
oard
+namely features 64 Mibit QSPI Flash, BT, WiFi and RF connectivity,
+USART, I2C, SPI, CAN and USB OTG, as well as a variety of sensors.
+
+Supported devices
+"""""""""""""""""
+
+Currently, B-L475E-IOT01A machine's implementation is minimal,
+it only supports the following device:
+
+- Cortex-M4F based STM32L4x5 SoC
+
+Missing devices
+"""""""""""""""
+
+The B-L475E-IOT01A does *not* support the following devices:
+
+- Extended interrupts and events controller (EXTI)
+- Reset and clock control (RCC)
+- Serial ports (UART)
+- System configuration controller (SYSCFG)
+- General-purpose I/Os (GPIO)
+- Analog to Digital Converter (ADC)
+- SPI controller
+- Timer controller (TIMER)
+
+See the complete list of unimplemented peripheral devices
+in the STM32L4x5 module : ``./hw/arm/stm32l4x5_soc.c``
+
+Boot options
+""""""""""""
+
+The B-L475E-IOT01A machine can be started using the ``-kernel``
+option to load a firmware. Example:
+
+.. code-block:: bash
+
+  $ qemu-system-arm -M b-l475e-iot01a -kernel firmware.bin
+
diff --git a/docs/system/arm/stm32.rst b/docs/system/arm/stm32.rst
index d7265b763d..3b640f3ee0 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -16,11 +16,13 @@ based on this chip :
=20
 - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontrol=
ler
=20
-The STM32F4 series is based on ARM Cortex-M4F core. This series is pin-t=
o-pin
-compatible with STM32F2 series. The following machines are based on this=
 chip :
+The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32=
L4
+ultra-low-power series. The STM32F4 series is pin-to-pin compatible with=
 STM32F2 series.
+The following machines are based on this ARM Cortex-M4F chip :
=20
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microco=
ntroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 micro=
controller
+- ``b-l475e-iot01a``     :doc:`B-L475E-IOT01A IoT Node </system/arm/b-l4=
75e-iot01a>` board with STM32L475VG microcontroller
=20
 There are many other STM32 series that are currently not supported by QE=
MU.
=20
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 790ac1b8a2..c9d7c0dda7 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
    arm/vexpress
    arm/aspeed
    arm/bananapi_m2u.rst
+   arm/b-l475e-iot01a.rst
    arm/sabrelite
    arm/digic
    arm/cubieboard
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
index 0000000000..6ecde2db15
--- /dev/null
+++ b/hw/arm/b-l475e-iot01a.c
@@ -0,0 +1,72 @@
+/*
+ * B-L475E-IOT01A Discovery Kit machine
+ * (B-L475E-IOT01A IoT Node)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ * This work is heavily inspired by the netduinoplus2 by Alistair Franci=
s.
+ * Original code is licensed under the MIT License:
+ *
+ * Copyright (c) 2014 Alistair Francis <alistair@alistair23.me>
+ */
+
+/*
+ * The reference used is the STMicroElectronics UM2153 User manual
+ * Discovery kit for IoT node, multi-channel communication with STM32L4.
+ * https://www.st.com/en/evaluation-tools/b-l475e-iot01a.html#documentat=
ion
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
+#define MAIN_SYSCLK_FREQ_HZ 80000000ULL
+
+static void b_l475e_iot01a_init(MachineState *machine)
+{
+    const Stm32l4x5SocClass *sc;
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency *=
/
+    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, MAIN_SYSCLK_FREQ_HZ);
+
+    dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sc =3D STM32L4X5_SOC_GET_CLASS(dev);
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, sc->flash_size);
+}
+
+static void b_l475e_iot01a_machine_init(MachineClass *mc)
+{
+    static const char *machine_valid_cpu_types[] =3D {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
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
@@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm283=
6.c', 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c=
'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c=
'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c=
'))
+arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a=
.c'))
 arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c=
'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c=
', 'xlnx-zcu102.c'))
 arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', '=
xlnx-versal-virt.c'))
--=20
2.43.0


