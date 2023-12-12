Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D86B180F332
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:37:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5h9-0000cB-29; Tue, 12 Dec 2023 11:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gb-00083K-Pj
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:46 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5gY-0007pT-PS
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:32:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c1e3ea2f2so59586865e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398761; x=1703003561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBOGPnHHB3911qXPeC7joHkuSv4mKQWNp402DQT8HUM=;
 b=XrIvR5RVOW1wE7od5xrI9dea0UCa1ShAe32m4CJuIiFcO49+KofkhvdusklXau1DjS
 DHY8oiLXyDu1qveFiMjp8AfEBF2m9D2Q6yvuvNkEWsjFAt9ovGVv3exomZ7f/LTKH8Vz
 hxr8SYg16ZQHUmXtM7NGzjJnKf2orga3R7Uw05n/z2ps9B20QFIQNvUPs84PGa1TOM30
 NSaPE7ip1krVe5ziOA/OaJ1gIVrqX36sk2qovBW4Lw8wJubYd7JBE3ogILR44RZiINYc
 RP9XPX0e9cBqJBbIjlYdKJEt2CAb6Tv86y0pWHOCK/0W8SvjQYc5M9cBK6+Si5n0v0Sc
 N1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398761; x=1703003561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBOGPnHHB3911qXPeC7joHkuSv4mKQWNp402DQT8HUM=;
 b=OYsTZS1JNORg5OnYi8cJMUlKatlrkKqArAxIA5+NA8saURzESe+WfwGGLuuzKlDqsp
 7Ucx2pZvcTnxTV7/443EYJW97dHcDC8uCiWSjZVvDPMaeORFuUB6yJmlcmSeden6SbCy
 UKA1k3i91SyQH8YpECVYNeGzUApGsD7wqAu+B4kogwHySCS+PccrBtAvUZEjsIHk6365
 t2phsewuvVEzvyv30fZfRHxfh/3jPilSWdMcD/9lFQ3FzAKeWXsaQK5WFESA/P6xTCdV
 ii6sD7J8sEaYz99oDm7OwyQoMqKxEFW/5wtOQGfzkUJ6G3MTUdoGjC7/8CKyVpfT+BFX
 VmIQ==
X-Gm-Message-State: AOJu0YxWmzYErUwlltxd/jKF7V7AKq85X/dPB0Bp9TM5iJS3mt1Mnt62
 /uzUOVSBQbFA9Yfs2XDoPOgO1p/KicKVtZy7e3E=
X-Google-Smtp-Source: AGHT+IHdDnlbdk7OHM8tTTeyyle5mW0FYFGDZn5ZKs+vQ26Fe4J2l4AZ68x14i6EIP/rf8xO94PXYg==
X-Received: by 2002:a05:600c:c8d:b0:40c:2b85:5b87 with SMTP id
 fj13-20020a05600c0c8d00b0040c2b855b87mr4315249wmb.98.1702398760868; 
 Tue, 12 Dec 2023 08:32:40 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 t4-20020adff044000000b0033340937da6sm11071845wro.95.2023.12.12.08.32.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:32:40 -0800 (PST)
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
Subject: [PATCH 25/33] hw/arm/fsl-imx6ul: Let the A7MPcore create/wire the CPU
 cores
Date: Tue, 12 Dec 2023 17:29:25 +0100
Message-ID: <20231212162935.42910-26-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Set the properties on the a7mpcore object to let it create and
wire the CPU cores. Remove the redundant code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx6ul.h |  4 ----
 hw/arm/fsl-imx6ul.c         | 24 ++++++------------------
 hw/arm/mcimx6ul-evk.c       |  3 ++-
 3 files changed, 8 insertions(+), 23 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index b37d544319..9957ab5be0 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -34,7 +34,6 @@
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "exec/memory.h"
-#include "cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -63,11 +62,8 @@ enum FslIMX6ULConfiguration {
 };
 
 struct FslIMX6ULState {
-    /*< private >*/
     DeviceState    parent_obj;
 
-    /*< public >*/
-    ARMCPU             cpu;
     CortexMPPrivState  a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
     IMXEPITState       epit[FSL_IMX6UL_NUM_EPITS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 6e4343efaa..512973e3c1 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -25,6 +25,7 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "target/arm/cpu.h" /* qom */
 
 #define NAME_SIZE 20
 
@@ -34,9 +35,6 @@ static void fsl_imx6ul_init(Object *obj)
     char name[NAME_SIZE];
     int i;
 
-    object_initialize_child(obj, "cpu0", &s->cpu,
-                            ARM_CPU_TYPE_NAME("cortex-a7"));
-
     /*
      * A7MPCORE
      */
@@ -158,8 +156,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     DeviceState *gic;
     int i;
     char name[NAME_SIZE];
-    SysBusDevice *sbd;
-    DeviceState *d;
 
     if (ms->smp.cpus > 1) {
         error_setg(errp, "%s: Only a single CPU is supported (%d requested)",
@@ -167,26 +163,18 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
-
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cores", 1, &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
-                            FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL, &error_abort);
+    qdev_prop_set_uint32(DEVICE(&s->a7mpcore), "num-cores", 1);
+    qdev_prop_set_string(DEVICE(&s->a7mpcore), "cpu-type",
+                         ARM_CPU_TYPE_NAME("cortex-a7"));
+    qdev_prop_set_uint32(DEVICE(&s->a7mpcore), "gic-spi-num",
+                         FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL);
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->a7mpcore), 0, FSL_IMX6UL_A7MPCORE_ADDR);
     gic = DEVICE(&s->a7mpcore);
 
-    sbd = SYS_BUS_DEVICE(&s->a7mpcore);
-    d = DEVICE(&s->cpu);
-
-    sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(d, ARM_CPU_IRQ));
-    sysbus_connect_irq(sbd, 1, qdev_get_gpio_in(d, ARM_CPU_FIQ));
-    sysbus_connect_irq(sbd, 2, qdev_get_gpio_in(d, ARM_CPU_VIRQ));
-    sysbus_connect_irq(sbd, 3, qdev_get_gpio_in(d, ARM_CPU_VFIQ));
-
     /*
      * A7MPCORE DAP
      */
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 500427e94b..a19834930f 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -18,6 +18,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
+#include "target/arm/cpu.h" /* qom */
 
 static void mcimx6ul_evk_init(MachineState *machine)
 {
@@ -64,7 +65,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu, machine, &boot_info);
+        arm_load_kernel(s->a7mpcore.cpu[0], machine, &boot_info);
     }
 }
 
-- 
2.41.0


