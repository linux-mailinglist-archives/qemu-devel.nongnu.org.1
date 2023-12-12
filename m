Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A9680F2A8
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5eu-00023P-4q; Tue, 12 Dec 2023 11:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5eo-0001l5-9M
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5ej-0007Q9-GZ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:30:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so55676065e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398646; x=1703003446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uK+/eXbsQikvtIa3jiivOrpMiNjRekumIvW6+nwidaM=;
 b=u1wNDEUZzGeQA26iGx8DVse3/epW9EqbdkqemFzv4SfBju7RFGPoGZ+LTzZ6e5LpZP
 VI8d9rWJijj71nDfmo99W5arOoRpcY9+QasdVJVmH/WVhxv9HhO9g4JxJe2tMdxRpmD5
 CiMbGaEHsvLToQf0bvYsl3ESKSJezvC2omCFuy92qTIMApTCcrz/qx7GY6VapCpyN5J0
 cNAOGtg25LZp097uhAIEq9cyiONXk965fqoph12XtgsXUjxuUPhF7gwAHqNEF+PL20QC
 BE83ZD4tmBkzDUd+mCsyyezdw7XjnXQN7nLkL1CEiVSGwNwMtAIURNsDnB2GRe6jPZeN
 RY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398646; x=1703003446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uK+/eXbsQikvtIa3jiivOrpMiNjRekumIvW6+nwidaM=;
 b=aWfkQfav8tSAOYeTVmy/qySRrPumJ0M057QpbmfDEyGNjhaz7Lgk4coDbGNvWSvPHT
 pcRN4AZ+zOK2vrzP4A4JIz/5M35b8GxG+i9Yj7RClsNHxA5gcxPQVAdamlxURkge5g50
 Js5HArgMp0nuNdRUcMVzVy//lqXGRMzXFae7mfH1GKCS2HKMkDyJgYmRu4Mv3UJytvgX
 8Y+fh7awJzlv2XyVQelbKOzrDuWWxBeIAqNPw8GCCaoAFN+/Yqrmp3EUW8XWt6K2wyX9
 XdLbiZ9hLnKVWk0IJ9IUGyFOVHAU8hUJihCQh9J+GmWnsXSkCe3ove2fVQLkH0icvaGi
 Mf6w==
X-Gm-Message-State: AOJu0Yx4EAOvXzeeCs4RF4E0smbQlTRcyRb/lQQOMy3SA604dia/phlv
 m0TNvIpk5z7894r9yXGPhNGyZRbAMj/bCZbwN8g=
X-Google-Smtp-Source: AGHT+IH49nO/38Y9PCaqsS10X0Sfke1KgNjL8HSRN5iwXCfSQ014Sc3FQgmv7OklSPauN8RnVZdPkQ==
X-Received: by 2002:a05:600c:4f41:b0:40c:1ce0:a24 with SMTP id
 m1-20020a05600c4f4100b0040c1ce00a24mr3134669wmq.88.1702398646501; 
 Tue, 12 Dec 2023 08:30:46 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 qo4-20020a170907874400b00a1933a57960sm6373321ejc.22.2023.12.12.08.30.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:30:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/33] hw/cpu/arm: Merge {a9mpcore.h,
 a15mpcore.h} as cortex_mpcore.h
Date: Tue, 12 Dec 2023 17:29:09 +0100
Message-ID: <20231212162935.42910-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Merge Cortex-A{9,15} MPCore devices in the same header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |  3 +-
 include/hw/arm/aspeed_soc.h                   |  2 +-
 include/hw/arm/exynos4210.h                   |  2 +-
 include/hw/arm/fsl-imx6.h                     |  2 +-
 include/hw/arm/fsl-imx6ul.h                   |  2 +-
 include/hw/arm/fsl-imx7.h                     |  2 +-
 include/hw/arm/npcm7xx.h                      |  2 +-
 include/hw/cpu/a15mpcore.h                    | 44 -------------------
 .../hw/cpu/{a9mpcore.h => cortex_mpcore.h}    | 29 ++++++++----
 hw/arm/exynos4210.c                           |  2 +-
 hw/arm/highbank.c                             |  3 +-
 hw/arm/realview.c                             |  2 +-
 hw/arm/vexpress.c                             |  3 +-
 hw/arm/xilinx_zynq.c                          |  2 +-
 hw/cpu/a15mpcore.c                            |  2 +-
 hw/cpu/a9mpcore.c                             |  2 +-
 16 files changed, 35 insertions(+), 69 deletions(-)
 delete mode 100644 include/hw/cpu/a15mpcore.h
 rename include/hw/cpu/{a9mpcore.h => cortex_mpcore.h} (57%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 695e0bd34f..8a37e5962f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -203,7 +203,8 @@ F: tests/tcg/aarch64/
 F: tests/qtest/arm-cpu-features.c
 F: hw/arm/
 F: hw/cpu/a*mpcore.c
-F: include/hw/cpu/a*mpcore.h
+F: include/hw/cpu/arm11mpcore.h
+F: include/hw/cpu/cortex_mpcore.h
 F: docs/system/target-arm.rst
 F: docs/system/arm/cpu-features.rst
 
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index cb832bc1ee..e0663ab50d 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -12,7 +12,7 @@
 #ifndef ASPEED_SOC_H
 #define ASPEED_SOC_H
 
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/arm/armv7m.h"
 #include "hw/intc/aspeed_vic.h"
 #include "hw/misc/aspeed_scu.h"
diff --git a/include/hw/arm/exynos4210.h b/include/hw/arm/exynos4210.h
index d33fe38586..f95e3232c5 100644
--- a/include/hw/arm/exynos4210.h
+++ b/include/hw/arm/exynos4210.h
@@ -26,7 +26,7 @@
 
 #include "hw/or-irq.h"
 #include "hw/sysbus.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/intc/exynos4210_gic.h"
 #include "hw/intc/exynos4210_combiner.h"
 #include "hw/core/split-irq.h"
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 519b871014..21a3b035a4 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -17,7 +17,7 @@
 #ifndef FSL_IMX6_H
 #define FSL_IMX6_H
 
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/misc/imx6_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 14390f6014..5ed22004d1 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -17,7 +17,7 @@
 #ifndef FSL_IMX6UL_H
 #define FSL_IMX6UL_H
 
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index 411fa1c2e3..87faee33c2 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -19,7 +19,7 @@
 #ifndef FSL_IMX7_H
 #define FSL_IMX7_H
 
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/intc/imx_gpcv2.h"
 #include "hw/misc/imx7_ccm.h"
 #include "hw/misc/imx7_snvs.h"
diff --git a/include/hw/arm/npcm7xx.h b/include/hw/arm/npcm7xx.h
index 72c7722096..7abbf85cbf 100644
--- a/include/hw/arm/npcm7xx.h
+++ b/include/hw/arm/npcm7xx.h
@@ -19,7 +19,7 @@
 #include "hw/boards.h"
 #include "hw/adc/npcm7xx_adc.h"
 #include "hw/core/split-irq.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/gpio/npcm7xx_gpio.h"
 #include "hw/i2c/npcm7xx_smbus.h"
 #include "hw/mem/npcm7xx_mc.h"
diff --git a/include/hw/cpu/a15mpcore.h b/include/hw/cpu/a15mpcore.h
deleted file mode 100644
index 75d39e5458..0000000000
--- a/include/hw/cpu/a15mpcore.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Cortex-A15MPCore internal peripheral emulation.
- *
- * Copyright (c) 2012 Linaro Limited.
- * Written by Peter Maydell.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef HW_CPU_A15MPCORE_H
-#define HW_CPU_A15MPCORE_H
-
-#include "hw/sysbus.h"
-#include "hw/intc/arm_gic.h"
-#include "qom/object.h"
-
-/* A15MP private memory region.  */
-
-#define TYPE_A15MPCORE_PRIV "a15mpcore_priv"
-OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
-
-struct A15MPPrivState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    uint32_t num_cpu;
-    uint32_t num_irq;
-    MemoryRegion container;
-
-    GICState gic;
-};
-
-#endif
diff --git a/include/hw/cpu/a9mpcore.h b/include/hw/cpu/cortex_mpcore.h
similarity index 57%
rename from include/hw/cpu/a9mpcore.h
rename to include/hw/cpu/cortex_mpcore.h
index e0396ab6af..9147f35c2a 100644
--- a/include/hw/cpu/a9mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -1,29 +1,27 @@
 /*
- * Cortex-A9MPCore internal peripheral emulation.
+ * Cortex-MPCore internal peripheral emulation.
  *
  * Copyright (c) 2009 CodeSourcery.
- * Copyright (c) 2011 Linaro Limited.
+ * Copyright (c) 2011, 2012, 2023 Linaro Limited.
  * Written by Paul Brook, Peter Maydell.
  *
- * This code is licensed under the GPL.
+ * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#ifndef HW_CPU_A9MPCORE_H
-#define HW_CPU_A9MPCORE_H
+#ifndef HW_CPU_CORTEX_MPCORE_H
+#define HW_CPU_CORTEX_MPCORE_H
 
+#include "qom/object.h"
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/misc/a9scu.h"
-#include "hw/timer/arm_mptimer.h"
 #include "hw/timer/a9gtimer.h"
-#include "qom/object.h"
+#include "hw/timer/arm_mptimer.h"
 
 #define TYPE_A9MPCORE_PRIV "a9mpcore_priv"
 OBJECT_DECLARE_SIMPLE_TYPE(A9MPPrivState, A9MPCORE_PRIV)
 
 struct A9MPPrivState {
-    /*< private >*/
     SysBusDevice parent_obj;
-    /*< public >*/
 
     uint32_t num_cpu;
     MemoryRegion container;
@@ -36,4 +34,17 @@ struct A9MPPrivState {
     ARMMPTimerState wdt;
 };
 
+#define TYPE_A15MPCORE_PRIV "a15mpcore_priv"
+OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
+
+struct A15MPPrivState {
+    SysBusDevice parent_obj;
+
+    uint32_t num_cpu;
+    uint32_t num_irq;
+    MemoryRegion container;
+
+    GICState gic;
+};
+
 #endif
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index de39fb0ece..2e6423f74d 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "cpu.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/irq.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f12aacea6b..a184bee993 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -31,8 +31,7 @@
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
 #include "hw/ide/ahci.h"
-#include "hw/cpu/a9mpcore.h"
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "qemu/log.h"
 #include "qom/object.h"
 #include "cpu.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 132217b2ed..a112a6b529 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -24,7 +24,7 @@
 #include "hw/i2c/i2c.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/intc/realview_gic.h"
 #include "hw/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index fd981f4c33..a320d1c181 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -39,8 +39,7 @@
 #include "qemu/error-report.h"
 #include <libfdt.h>
 #include "hw/char/pl011.h"
-#include "hw/cpu/a9mpcore.h"
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
 #include "qapi/qmp/qlist.h"
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index dbb9793aa1..fc9c927d09 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -33,7 +33,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/net/cadence_gem.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/qdev-clock.h"
 #include "sysemu/reset.h"
 #include "qom/object.h"
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index c2ee985fb4..0f56c40b86 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -21,7 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/cpu/a15mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "sysemu/kvm.h"
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 6b5ce01246..e9cd71e92f 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -11,7 +11,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
-#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/cortex_mpcore.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
-- 
2.41.0


