Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0783204C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 21:11:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQYgx-00072T-Fs; Thu, 18 Jan 2024 15:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgw-00070u-0h
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:46 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQYgt-00078n-ET
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 15:08:45 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e80046246so437705e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 12:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705608522; x=1706213322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2EqqFckSbhbAC8zOQO19ZG9GyZSFLJsrPZ+inqnxX0=;
 b=s21r6hZoU3IyB4qFYH7XWmswRVM7hTfqNC/yRsIECrwAoWy1MrcirwNOypkkhmPfAx
 AD3h8YJpfIA4gCvPdwpL589Ff1+raZ9DnTw0/ttRimTckQpktwD0D/SrSJVa44ZQTXLO
 IVohSQrwpWea1E6mlc/nshUAF+KKBeXBcKJn+N5MhNnkBI7YApQCY37F38Y4akGx0fFG
 7eJdVwAZG5gB/rPLyZ2A2wvKNAEbiU2sqYJv2CTkqze0Z/tDrYGMsrI4l0lB3ZCjIvf3
 1BzlDGMkugn6wAR9mKNVY2ACdgm+UzRniu2TaDlp3ZIugLucWeO7C1jhE/tILTnS+4bg
 3qoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705608522; x=1706213322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2EqqFckSbhbAC8zOQO19ZG9GyZSFLJsrPZ+inqnxX0=;
 b=EsujIXNywA01wcNI0Ts5z7SjOVEN9SkfeEqxQ41j/l23MVjlWdCJLQvoP+DlvfLymS
 aW9aPHnY+QM+eFfCVaO+NI8dXT02Vn2HdycJb6s9Fw2zTdn2fZ1Jgj9aPW7powbiH8yg
 Ivhd4kUVH9yU55K+yBzwsIA9P/REinh+GNmaMKUMETrpLAhTmyT0gZqgAA/czA4OgajB
 dXrcIM6taR7a0H05dfBKhFf4E9GYwc4Erb4ik6ll56OKCiiIq3m+elxxY9zB/G5nTxMR
 /WFBzouduCE6yomg5DhhJW7qRx+UOIRggKCGnZT5jhWeBbhqwRJlSd6U8/SmYPg+g5mU
 1mRQ==
X-Gm-Message-State: AOJu0YwxYZVSid8g/EhLlkowZssjGHcY8RKHqDcYpTpw0kFAyrxhcti8
 m5AzAPvobsCqdcjta4ySQ5OZGI+pHsVK2ZaQdcNbl1JBYXsb4Nw3hJEPitlwyCJc9s/cEf5+qHf
 T4UNW0Vc7
X-Google-Smtp-Source: AGHT+IH7zFlM4uZe06b8ga74Kf+PzprHQyg3rj1390uuJyNrZrrpz8w44YQIbwVnedgHquAxLohniA==
X-Received: by 2002:a1c:4c18:0:b0:40d:5897:bf52 with SMTP id
 z24-20020a1c4c18000000b0040d5897bf52mr868484wmf.183.1705608521804; 
 Thu, 18 Jan 2024 12:08:41 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b0040d6b91efd9sm30506762wmq.44.2024.01.18.12.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jan 2024 12:08:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@web.de>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Rob Herring <robh@kernel.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Beniamino Galvani <b.galvani@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Joel Stanley <joel@jms.id.au>, Hao Wu <wuhaotsh@google.com>,
 kvm@vger.kernel.org
Subject: [PATCH 20/20] hw/arm: Build various units only once
Date: Thu, 18 Jan 2024 21:06:41 +0100
Message-ID: <20240118200643.29037-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240118200643.29037-1-philmd@linaro.org>
References: <20240118200643.29037-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Various files in hw/arm/ don't require "cpu.h" anymore.
Except virt-acpi-build.c, all of them don't require any
ARM specific knowledge anymore and can be build once as
target agnostic units. Update meson accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/collie.c           |  1 -
 hw/arm/gumstix.c          |  1 -
 hw/arm/integratorcp.c     |  1 -
 hw/arm/mainstone.c        |  1 -
 hw/arm/musicpal.c         |  1 -
 hw/arm/omap2.c            |  1 -
 hw/arm/omap_sx1.c         |  1 -
 hw/arm/palm.c             |  1 -
 hw/arm/spitz.c            |  1 -
 hw/arm/strongarm.c        |  1 -
 hw/arm/versatilepb.c      |  1 -
 hw/arm/vexpress.c         |  1 -
 hw/arm/virt-acpi-build.c  |  1 -
 hw/arm/xilinx_zynq.c      |  1 -
 hw/arm/xlnx-versal-virt.c |  1 -
 hw/arm/z2.c               |  1 -
 hw/arm/meson.build        | 23 ++++++++++++-----------
 17 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index a0ad1b8dc7..eaa5c52d45 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -17,7 +17,6 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index 2ca4140c9f..3f2bcaa24e 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -44,7 +44,6 @@
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
 #include "sysemu/qtest.h"
-#include "cpu.h"
 
 #define CONNEX_FLASH_SIZE   (16 * MiB)
 #define CONNEX_RAM_SIZE     (64 * MiB)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 5600616a4d..793262eca8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/boards.h"
diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 68329c4617..fc14e05060 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -23,7 +23,6 @@
 #include "hw/block/flash.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 
 /* Device addresses */
 #define MST_FPGA_PHYS	0x08000000
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index d89824f600..e46aa91807 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index f159fb73ea..d9683276c6 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -21,7 +21,6 @@
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "exec/address-spaces.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/qtest.h"
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 4bf1579f8c..62d7915fb8 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -35,7 +35,6 @@
 #include "hw/block/flash.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qemu/cutils.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index b86f2c331b..8c4c831614 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -29,7 +29,6 @@
 #include "hw/input/tsc2xxx.h"
 #include "hw/irq.h"
 #include "hw/loader.h"
-#include "cpu.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 1d680b61e2..643a02b180 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -33,7 +33,6 @@
 #include "hw/adc/max111x.h"
 #include "migration/vmstate.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "audio/audio.h"
 
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index 75637869cb..7fd99a0f14 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -28,7 +28,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 15b5ed0ced..1d813aa23b 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -9,7 +9,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 49dbcdcbf0..f1b45245d5 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -24,7 +24,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/primecell.h"
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 43ccc60f43..17aeec7a6f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -32,7 +32,6 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "hw/core/cpu.h"
-#include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg_acpi.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 5809fc32af..66d0de139f 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -18,7 +18,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
-#include "cpu.h"
 #include "hw/sysbus.h"
 #include "hw/arm/boot.h"
 #include "net/net.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 29f4d2c2dc..94942c55df 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -16,7 +16,6 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/arm/fdt.h"
-#include "cpu.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 83741a4909..a67fba2cfd 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -25,7 +25,6 @@
 #include "hw/audio/wm8750.h"
 #include "audio/audio.h"
 #include "exec/address-spaces.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qapi/error.h"
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index bb92b27db3..c401779067 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -9,23 +9,14 @@ arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
 arm_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mainstone.c'))
 arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
 arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
-arm_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
 arm_ss.add(when: 'CONFIG_NSERIES', if_true: files('nseries.c'))
-arm_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
-arm_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
-arm_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
-arm_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
-arm_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
 arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
 arm_ss.add(when: 'CONFIG_STM32VLDISCOVERY', if_true: files('stm32vldiscovery.c'))
-arm_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
-arm_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
-arm_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
 arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
 
@@ -33,8 +24,7 @@ arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
 arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
 arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c', 'pxa2xx_gpio.c', 'pxa2xx_pic.c'))
 arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
-arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c', 'omap2.c'))
-arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
@@ -69,8 +59,19 @@ arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
+system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
+system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+system_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
+system_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
+system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap2.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+system_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
+system_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+system_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
+system_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
+system_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+system_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
 
 hw_arch += {'arm': arm_ss}
-- 
2.41.0


