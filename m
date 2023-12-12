Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 178AC80F323
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:36:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5h9-0000cX-59; Tue, 12 Dec 2023 11:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gj-0008S0-TQ
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:33:00 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gh-0007so-BY
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:53 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3331752d2b9so3987791f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398769; x=1703003569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uwsCbOQwC9LRQg37XGNzhzNIEGJSgHKY9wlcygMw6kk=;
 b=bz6iM7cG9T1jq/ndztSoLMibc69ADT/bQfXeLkTXigMhzOqVcMwKoquVVt0bm6rPG8
 PfTWYMN5wgApfE0yfHSiudMWwmDjkKjk8WZjfvupcKrqZjPfnROhI9ewaIxD9dkpHpX3
 yEUPUPqCyfZHHKwCBVizHxDkdBSFooqeGZ9Kvhkxvs4YtQ5XWnfQas56TzbiRrwPMixf
 +BeEP7JkWj/eOsV/xCwtmAosTHpmjfF1PWNA8RKrPGW8g/mlyPncyIFJPzJ/mE61EBmA
 IkDkBgYpnCinx5nZ2Q0ZQ+fD1jODGIDEsNKKXErNNJ72E/Cd53GvNc8Cd59jxVx1bFZ7
 EPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398769; x=1703003569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uwsCbOQwC9LRQg37XGNzhzNIEGJSgHKY9wlcygMw6kk=;
 b=EeGOfHL6p1Hdj3i21jgMpwHzsDYIkzFjePlXDCejI/VjP4eFH2FUl6OoGeHlQnkeBS
 HDXD8RXzdDupvkJFs9dsob8Wq+0tkTK51tVbG7XtyvVanLXMgaCrPSwQtZUTIFCAFtgt
 wZjZ0Q9QfX6h8INDP+hukIxqsnbsuKJlWnubgIEUoxA92xKaG2veZ5jx4R5PWejTwMPY
 K697kAy14XI75/ytIDjiUlvPqTP8OOrX6q14lKmZzKjgI8z55/3vMoR0InGIDNEBBVtr
 +tQkV+DsJT6hD8iMsvB9i21ub7tsIJv5Bd/230BaEV3wzMtS4a5tDa335BrZHNTJx/AG
 UaHA==
X-Gm-Message-State: AOJu0YzXF+qgk/k5RV/1yG0n+6FSRG1sCz1sKBnZKQeFBHmCBt/v3vVK
 Ff//6a3Ab8JzBPIvLI8mJPTpty/PEn0ojdwwMgI=
X-Google-Smtp-Source: AGHT+IHNLFmdvtFn8m/sQjbujNGsQXLq5wQ3u72VZDuHI9d3Z+DgXmGoeA/vWenMC/ayDY9pCkjT8g==
X-Received: by 2002:adf:fcc9:0:b0:336:9f9:6e6 with SMTP id
 f9-20020adffcc9000000b0033609f906e6mr3118511wrs.97.1702398768756; 
 Tue, 12 Dec 2023 08:32:48 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 v4-20020a5d4a44000000b003342e0745absm11105691wrs.93.2023.12.12.08.32.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:48 -0800 (PST)
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
Subject: [PATCH 26/33] hw/arm/fsl-imx7: Let the A7MPcore create/wire the CPU
 cores
Date: Tue, 12 Dec 2023 17:29:26 +0100
Message-ID: <20231212162935.42910-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Set the properties on the a7mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx7.h |  4 ---
 hw/arm/fsl-imx7.c         | 62 +++++----------------------------------
 hw/arm/mcimx7d-sabre.c    |  3 +-
 3 files changed, 10 insertions(+), 59 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index a6f3a96029..77771f916c 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -36,7 +36,6 @@
 #include "hw/net/imx_fec.h"
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -63,11 +62,8 @@ enum FslIMX7Configuration {
 };
 
 struct FslIMX7State {
-    /*< private >*/
     DeviceState    parent_obj;
 
-    /*< public >*/
-    ARMCPU             cpu[FSL_IMX7_NUM_CPUS];
     CortexMPPrivState  a7mpcore;
     IMXGPTState        gpt[FSL_IMX7_NUM_GPTS];
     IMXGPIOState       gpio[FSL_IMX7_NUM_GPIOS];
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index bd9266b8b5..f71ffe7910 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -26,25 +26,16 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu.h" /* qom */
 
 #define NAME_SIZE 20
 
 static void fsl_imx7_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(obj);
     char name[NAME_SIZE];
     int i;
 
-    /*
-     * CPUs
-     */
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX7_NUM_CPUS); i++) {
-        snprintf(name, NAME_SIZE, "cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i],
-                                ARM_CPU_TYPE_NAME("cortex-a7"));
-    }
-
     /*
      * A7MPCORE
      */
@@ -163,7 +154,6 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX7State *s = FSL_IMX7(dev);
     DeviceState *gic;
-    Object *o;
     int i;
     qemu_irq irq;
     char name[NAME_SIZE];
@@ -175,56 +165,20 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /*
-     * CPUs
-     */
-    for (i = 0; i < smp_cpus; i++) {
-        o = OBJECT(&s->cpu[i]);
-
-        /* On uniprocessor, the CBAR is set to 0 */
-        if (smp_cpus > 1) {
-            object_property_set_int(o, "reset-cbar", FSL_IMX7_A7MPCORE_ADDR,
-                                    &error_abort);
-        }
-
-        if (i) {
-            /*
-             * Secondary CPUs start in powered-down state (and can be
-             * powered up via the SRC system reset controller)
-             */
-            object_property_set_bool(o, "start-powered-off", true,
-                                     &error_abort);
-        }
-
-        qdev_realize(DEVICE(o), NULL, &error_abort);
-    }
-
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cores", smp_cpus,
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
-                            FSL_IMX7_MAX_IRQ + GIC_INTERNAL, &error_abort);
-
+    qdev_prop_set_uint32(DEVICE(&s->a7mpcore), "num-cores", ms->smp.cpus);
+    qdev_prop_set_string(DEVICE(&s->a7mpcore), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-a7"));
+    qdev_prop_set_uint64(DEVICE(&s->a7mpcore), "cpu-reset-cbar",
+                         FSL_IMX7_A7MPCORE_ADDR);
+    qdev_prop_set_uint32(DEVICE(&s->a7mpcore), "gic-spi-num",
+                         FSL_IMX7_MAX_IRQ + GIC_INTERNAL);
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX7_A7MPCORE_ADDR);
     gic = DEVICE(&s->a7mpcore);
 
-    for (i = 0; i < smp_cpus; i++) {
-        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
-        DeviceState  *d   = DEVICE(qemu_get_cpu(i));
-
-        irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
-        sysbus_connect_irq(sbd, i, irq);
-        irq = qdev_get_gpio_in(d, ARM_CPU_FIQ);
-        sysbus_connect_irq(sbd, i + smp_cpus, irq);
-        irq = qdev_get_gpio_in(d, ARM_CPU_VIRQ);
-        sysbus_connect_irq(sbd, i + 2 * smp_cpus, irq);
-        irq = qdev_get_gpio_in(d, ARM_CPU_VFIQ);
-        sysbus_connect_irq(sbd, i + 3 * smp_cpus, irq);
-    }
-
     /*
      * A7MPCORE DAP
      */
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 693a1023b6..782f7591db 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -20,6 +20,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "target/arm/cpu.h" /* qom */
 
 static void mcimx7d_sabre_init(MachineState *machine)
 {
@@ -64,7 +65,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(s->a7mpcore.cpu[0], machine, &boot_info);
     }
 }
 
-- 
2.41.0


