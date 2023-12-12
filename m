Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E763F80F314
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5h7-0000Qe-PH; Tue, 12 Dec 2023 11:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gX-0007qb-3y
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:42 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gS-0007o9-6q
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c1e3ea2f2so59585785e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398754; x=1703003554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnrJeszID6i8q/rfFXlglmf1g+vLhk9+fH8LuiS5wFg=;
 b=BfZgyCHdUtjyJG80e0h5YUm4fviq/L1E8Clu3/CLVncREq8DuKCsGXWpJ9dcK84cEP
 1475nHpyB3+8JWxOXb5aCtIuwZF0MSa6KzsQTHVfcZwQ0cNtDkIcH88O0zqUA/SK4g8H
 iqlnZdLDA9WfSbiIrZWfDR7n86flgZf3/opj/KdNmkIgWABXLapP3nSIv8pXJZBNO6Y6
 Q+KKCoeBc7sxTEF5g2NoD/ImhbcWYEm+a4Yl8iegHne6LSoxGeOjj9FAS1nC1M/3w8PE
 jaAn7uZyycUCMnGnVHtYeBjZeH/4c/ghA3IYvNvpkO9CtUIQrCHyZ88N13ikWW8eY40n
 pJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398754; x=1703003554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnrJeszID6i8q/rfFXlglmf1g+vLhk9+fH8LuiS5wFg=;
 b=rI+AyxdldKAwbPsaWGES+xxtChe5SXfIb/1L9Omk0rur3c0hhnAUJDXNqrXTz2A1XV
 nXBnZMGIAjtGyNTijkXz90pcq7kuFtcv73JO+z+fuuUBwrjgPKt3Gm+utl/PCql3S550
 fauotpndOxgOU0V3TDCUWQlUdLVMCBdvxT9f27uXWYYRyzy/2elRpm0DGkxXLdTaEWp8
 xWmxmH994iVTTuMWj04LleYwG5H+bt1DaVmZPBGOzPSoPpMzhBFvL1UOfNyFexA8Ss6l
 f8u+zxCYflHaoVU02QApwQpM0M/JjcMMSF/sp2dk3JWiqW76GC7eIwO0E6AvUdu7T59n
 Rw4Q==
X-Gm-Message-State: AOJu0Yy8ngpYDMWIHK0IvoZS5JRhfFG7AKIXYX1DA/gdRMggyooI4eWZ
 DjZl4OyFsyTZ9khKG5CEodAIexGw9P2+QadlnXk=
X-Google-Smtp-Source: AGHT+IEhW3hPy0t/OW5VOfIFyP55JLvXgdi7wpqvG7SRznYraFPkiWLXOuJE1nlKRmvwPMhtNIbh8g==
X-Received: by 2002:a05:600c:3648:b0:40c:2671:1550 with SMTP id
 y8-20020a05600c364800b0040c26711550mr3735117wmq.24.1702398754443; 
 Tue, 12 Dec 2023 08:32:34 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 m27-20020a05600c3b1b00b0040b38292253sm19428074wms.30.2023.12.12.08.32.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:34 -0800 (PST)
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
Subject: [PATCH 24/33] hw/arm/fsl-imx6: Let the A9MPcore create/wire the CPU
 cores
Date: Tue, 12 Dec 2023 17:29:24 +0100
Message-ID: <20231212162935.42910-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Set the properties on the a9mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx6.h |  4 ----
 hw/arm/fsl-imx6.c         | 47 +++++++--------------------------------
 hw/arm/sabrelite.c        |  4 +++-
 3 files changed, 11 insertions(+), 44 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 21a3b035a4..643c3160c7 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -33,7 +33,6 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "exec/memory.h"
-#include "cpu.h"
 #include "qom/object.h"
 
 #define TYPE_FSL_IMX6 "fsl-imx6"
@@ -51,11 +50,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_USBS 4
 
 struct FslIMX6State {
-    /*< private >*/
     DeviceState parent_obj;
 
-    /*< public >*/
-    ARMCPU         cpu[FSL_IMX6_NUM_CPUS];
     A9MPPrivState  a9mpcore;
     IMX6CCMState   ccm;
     IMX6SRCState   src;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index 65c7c1a0f9..f05ea62351 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -29,6 +29,7 @@
 #include "chardev/char.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu.h"
 
 #define IMX6_ESDHC_CAPABILITIES     0x057834b4
 
@@ -36,17 +37,10 @@
 
 static void fsl_imx6_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(obj);
     char name[NAME_SIZE];
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX6_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a9"));
-    }
-
     object_initialize_child(obj, "a9mpcore", &s->a9mpcore, TYPE_A9MPCORE_PRIV);
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX6_CCM);
@@ -119,43 +113,18 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < smp_cpus; i++) {
-
-        /* On uniprocessor, the CBAR is set to 0 */
-        if (smp_cpus > 1) {
-            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
-                                    FSL_IMX6_A9MPCORE_ADDR, &error_abort);
-        }
-
-        /* All CPU but CPU 0 start in power off mode */
-        if (i) {
-            object_property_set_bool(OBJECT(&s->cpu[i]), "start-powered-off",
-                                     true, &error_abort);
-        }
-
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
-            return;
-        }
-    }
-
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-cores", smp_cpus,
-                            &error_abort);
-
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-irq",
-                            FSL_IMX6_MAX_IRQ + GIC_INTERNAL, &error_abort);
-
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cores", smp_cpus);
+    qdev_prop_set_string(DEVICE(&s->a9mpcore), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-a9"));
+    qdev_prop_set_uint64(DEVICE(&s->a9mpcore), "cpu-reset-cbar",
+                         FSL_IMX6_A9MPCORE_ADDR);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "gic-spi-num",
+                         FSL_IMX6_MAX_IRQ + GIC_INTERNAL);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->a9mpcore), errp)) {
         return;
     }
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a9mpcore), 0, FSL_IMX6_A9MPCORE_ADDR);
 
-    for (i = 0; i < smp_cpus; i++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i,
-                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->a9mpcore), i + smp_cpus,
-                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
-    }
-
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->ccm), errp)) {
         return;
     }
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 56f184b9ae..751053e8e3 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -99,7 +99,9 @@ static void sabrelite_init(MachineState *machine)
     sabrelite_binfo.secondary_cpu_reset_hook = sabrelite_reset_secondary;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &sabrelite_binfo);
+        CortexMPPrivState *mp = CORTEX_MPCORE_PRIV(&s->a9mpcore);
+
+        arm_load_kernel(mp->cpu[0], machine, &sabrelite_binfo);
     }
 }
 
-- 
2.41.0


