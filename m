Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5635582ACEB
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:09:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssH-0001Ni-OC; Thu, 11 Jan 2024 06:05:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss5-0001KO-NT
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNss2-0004NI-EF
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:13 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33761e291c1so3050938f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971108; x=1705575908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4J8JnVbLxHPqG7/7Gj6ee0tGyPz56E2QBmSZoyA8w7A=;
 b=p3vFm7U4TsGRskbjoq5rwGgL7GgucIajNgBGdepY0PcGT/QXfpbHWDeu5sDK+0kYh5
 emJ9F6zK8oSlulZCbAJ5YYGMdigi9tWL0slFYMMsn3pPLYiGrOxUnmudaAkAZ1HYvKeQ
 4Tin7lMm/p1xZShUjx+a2Gene56ZHWqhk9qw3FdDGSzA2VhfuWGT/t6NyOaVuv+enENe
 y1iSpv60Pf4g6Vt3oXMD25YxKTeMBdBg6qF8jONkZtixwAqufYFAoIH648i2n8U33QIW
 Vp39YNL6KGQ6ixAI1tBFiH+lv1ehpca6/ldKJTl8bGosYOCclaObeKbu8kJaNtSQ3PSL
 bTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971108; x=1705575908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4J8JnVbLxHPqG7/7Gj6ee0tGyPz56E2QBmSZoyA8w7A=;
 b=bYdGzCvxFPuLlqmayjQ9JsyfDediB/+8OlVlB30HOG+IqtHJ3MQG1+Xx0em6Cqp2dU
 tQncNqICxKGkxHCvS4KbXpkqh6qI9ZkpgjwpBeV6mVRsBzKl2nVQ9XllvunA59NZF/U2
 gO6Vz9oQRVrV2JxQpI97GY2y467s/U+H00JqGohl/C9ogRpUg0PNN5c6QwrhFwCa67ha
 jWxzYoI8TaMz5E54BsoK2wM9WgdiyOnam7OpBjc+uCnJCVPs8uoP0nk5mGTPu0EFHXE1
 bL2SZVyUqcvDjSdJlRbQd1hko/15Fu1a9T0F7BqPH0l2ju3pUgehNFujHQk0r7jVhMJZ
 nzfA==
X-Gm-Message-State: AOJu0YwyOXlfKwkX64AkDqoY1pGQNdTyPxDHokbB0DUPAeAxD+2AfL44
 YONNnJ/NfWc/mocLXFAPtg10MVPIhq/PIwUl+V7N7Ma7n1I=
X-Google-Smtp-Source: AGHT+IGLxKTpQPiCgEE4tOofQorMkOglYLKFFwc4hUVwwWWWvEr2AGKKcpjqirsnDqm6amZ5fsSTlA==
X-Received: by 2002:a5d:64e6:0:b0:337:507a:5c59 with SMTP id
 g6-20020a5d64e6000000b00337507a5c59mr473309wri.12.1704971108576; 
 Thu, 11 Jan 2024 03:05:08 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:08 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/41] hw/arm: Add minimal support for the B-L475E-IOT01A board
Date: Thu, 11 Jan 2024 11:04:27 +0000
Message-Id: <20240111110505.1563291-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

This commit adds a new B-L475E-IOT01A board using the STM32L475VG SoC
as well as a dedicated documentation file.
The implementation is derived from the Netduino Plus 2 machine.
There are no peripherals implemented yet, only memory regions.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Message-id: 20240108135849.351719-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                             |  7 +++
 docs/system/arm/b-l475e-iot01a.rst      | 46 ++++++++++++++++
 docs/system/arm/stm32.rst               |  6 ++-
 docs/system/target-arm.rst              |  1 +
 configs/devices/arm-softmmu/default.mak |  1 +
 hw/arm/b-l475e-iot01a.c                 | 72 +++++++++++++++++++++++++
 hw/arm/Kconfig                          |  6 +++
 hw/arm/meson.build                      |  1 +
 8 files changed, 138 insertions(+), 2 deletions(-)
 create mode 100644 docs/system/arm/b-l475e-iot01a.rst
 create mode 100644 hw/arm/b-l475e-iot01a.c

diff --git a/MAINTAINERS b/MAINTAINERS
index da29dcc16ec..b406fb20c05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1130,6 +1130,13 @@ S: Maintained
 F: hw/arm/stm32l4x5_soc.c
 F: include/hw/arm/stm32l4x5_soc.h
 
+B-L475E-IOT01A IoT Node
+M: Arnaud Minier <arnaud.minier@telecom-paris.fr>
+M: Inès Varhol <ines.varhol@telecom-paris.fr>
+L: qemu-arm@nongnu.org
+S: Maintained
+F: hw/arm/b-l475e-iot01a.c
+
 SmartFusion2
 M: Subbaraya Sundeep <sundeep.lkml@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/b-l475e-iot01a.rst b/docs/system/arm/b-l475e-iot01a.rst
new file mode 100644
index 00000000000..2b128e6b847
--- /dev/null
+++ b/docs/system/arm/b-l475e-iot01a.rst
@@ -0,0 +1,46 @@
+B-L475E-IOT01A IoT Node (``b-l475e-iot01a``)
+============================================
+
+The B-L475E-IOT01A IoT Node uses the STM32L475VG SoC which is based on
+ARM Cortex-M4F core. It is part of STMicroelectronics
+:doc:`STM32 boards </system/arm/stm32>` and more specifically the STM32L4
+ultra-low power series. The STM32L4x5 chip runs at up to 80 MHz and
+integrates 128 KiB of SRAM and up to 1MiB of Flash. The B-L475E-IOT01A board
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
index d7265b763d4..3b640f3ee07 100644
--- a/docs/system/arm/stm32.rst
+++ b/docs/system/arm/stm32.rst
@@ -16,11 +16,13 @@ based on this chip :
 
 - ``netduino2``         Netduino 2 board with STM32F205RFT6 microcontroller
 
-The STM32F4 series is based on ARM Cortex-M4F core. This series is pin-to-pin
-compatible with STM32F2 series. The following machines are based on this chip :
+The STM32F4 series is based on ARM Cortex-M4F core, as well as the STM32L4
+ultra-low-power series. The STM32F4 series is pin-to-pin compatible with STM32F2 series.
+The following machines are based on this ARM Cortex-M4F chip :
 
 - ``netduinoplus2``     Netduino Plus 2 board with STM32F405RGT6 microcontroller
 - ``olimex-stm32-h405`` Olimex STM32 H405 board with STM32F405RGT6 microcontroller
+- ``b-l475e-iot01a``     :doc:`B-L475E-IOT01A IoT Node </system/arm/b-l475e-iot01a>` board with STM32L475VG microcontroller
 
 There are many other STM32 series that are currently not supported by QEMU.
 
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 790ac1b8a2b..c9d7c0dda7e 100644
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
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 980c48a7d99..023faa2f750 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -19,6 +19,7 @@ CONFIG_ARM_VIRT=y
 # CONFIG_NSERIES=n
 # CONFIG_STELLARIS=n
 # CONFIG_STM32VLDISCOVERY=n
+# CONFIG_B_L475E_IOT01A=n
 # CONFIG_REALVIEW=n
 # CONFIG_VERSATILE=n
 # CONFIG_VEXPRESS=n
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
new file mode 100644
index 00000000000..6ecde2db15c
--- /dev/null
+++ b/hw/arm/b-l475e-iot01a.c
@@ -0,0 +1,72 @@
+/*
+ * B-L475E-IOT01A Discovery Kit machine
+ * (B-L475E-IOT01A IoT Node)
+ *
+ * Copyright (c) 2023 Arnaud Minier <arnaud.minier@telecom-paris.fr>
+ * Copyright (c) 2023 Inès Varhol <ines.varhol@telecom-paris.fr>
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
+#define MAIN_SYSCLK_FREQ_HZ 80000000ULL
+
+static void b_l475e_iot01a_init(MachineState *machine)
+{
+    const Stm32l4x5SocClass *sc;
+    DeviceState *dev;
+    Clock *sysclk;
+
+    /* This clock doesn't need migration because it is fixed-frequency */
+    sysclk = clock_new(OBJECT(machine), "SYSCLK");
+    clock_set_hz(sysclk, MAIN_SYSCLK_FREQ_HZ);
+
+    dev = qdev_new(TYPE_STM32L4X5XG_SOC);
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
+    qdev_connect_clock_in(dev, "sysclk", sysclk);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    sc = STM32L4X5_SOC_GET_CLASS(dev);
+    armv7m_load_kernel(ARM_CPU(first_cpu),
+                       machine->kernel_filename,
+                       0, sc->flash_size);
+}
+
+static void b_l475e_iot01a_machine_init(MachineClass *mc)
+{
+    static const char *machine_valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-m4"),
+        NULL
+    };
+    mc->desc = "B-L475E-IOT01A Discovery Kit (Cortex-M4)";
+    mc->init = b_l475e_iot01a_init;
+    mc->valid_cpu_types = machine_valid_cpu_types;
+
+    /* SRAM pre-allocated as part of the SoC instantiation */
+    mc->default_ram_size = 0;
+}
+
+DEFINE_MACHINE("b-l475e-iot01a", b_l475e_iot01a_machine_init)
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 5f9780bbceb..39d255425b1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -449,6 +449,12 @@ config STM32F405_SOC
     select STM32F4XX_SYSCFG
     select STM32F4XX_EXTI
 
+config B_L475E_IOT01A
+    bool
+    default y
+    depends on TCG && ARM
+    select STM32L4X5_SOC
+
 config STM32L4X5_SOC
     bool
     select ARM_V7M
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9766da10c48..bb92b27db3e 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -42,6 +42,7 @@ arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
+arm_ss.add(when: 'CONFIG_B_L475E_IOT01A', if_true: files('b-l475e-iot01a.c'))
 arm_ss.add(when: 'CONFIG_STM32L4X5_SOC', if_true: files('stm32l4x5_soc.c'))
 arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
 arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
-- 
2.34.1


