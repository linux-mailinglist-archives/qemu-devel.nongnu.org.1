Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C5580F2A1
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:31:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5fG-0003tS-IO; Tue, 12 Dec 2023 11:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fE-0003ob-I9
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:20 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fB-0007WQ-HV
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:20 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ca09601127so79357501fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398675; x=1703003475; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwVMkWLl0EUpwv2GUG276xuKiVo6DPainD8/hY+18Wo=;
 b=OBswllIdcqawd3Xozp8QziYqVuTbsONyI2CK1pd98CEd+ms9+mozkrX3kLrckaMgCb
 VSWcx8yEuelO2qDEsh6CtlG1Tc8chOul54JtZ4wDWOwjmhnrQgK41ZhIj3ot4Ao9lhAm
 yXQUzWi7AkI6esfOl2KZ/kmtIdZvFnLD/fPGhLWQMqtJF+1VKmk+Sc/Ki9o3+GedH2BW
 Fr527RW4R7MZfz3yBMn29mq/LVLZ4+vexe7o4ampgxR0WwYXSa/q7GHTb5nnSRh34QR0
 ldRYzQjhmZxjEdGgEUwhorCG3cAPwyT+FDartVPfcOqJ2tbOYHaCcrotca8a5HZ9mX1c
 eDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398675; x=1703003475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PwVMkWLl0EUpwv2GUG276xuKiVo6DPainD8/hY+18Wo=;
 b=u9524tcFnnAMHEst+RzakjrlMa/S0VAFk4O30cu5EyTVc3vbcZzOTJe1r2vXBmqx6n
 Tsqb7yPcCDCRlRtDhQJAVczCQuwa01aN5CgerP1v/HqHi2tB6ZRG20c+almQfbDJwQYT
 QKXtQpelnK0lYv81tH1qbiFX5RtwSdoxIQbkAAhxo32RtqmsyXEMy6uBJRK21QL0j6vz
 lZRDZaqFLhQQElPjfwxVkOIavkkDnAdeKjqK5dVLhgPKqK92RMtVGHoYtpgoNQtAodwA
 ThkTCCiYbdPJoPr9uE6LQ4O+CMATJo7/ryhUP1uQ5d/LvlxdRMVhQrNK67H7AFra45aT
 nZJg==
X-Gm-Message-State: AOJu0YwdzL96sIgwFUI6XBP5E5/kZCVUQpQ7NQbfsEwHn/dMgTw/M5jS
 iRaB8DRc3rYazT9Wz97Bu/UsjIAxlXyrVU8PVbI=
X-Google-Smtp-Source: AGHT+IFX+oJH4RBa6r7e+MBulJ7O/dbV4gctv7Mw6GaHEVqY6p5ImBS6hbxsmrohZRY553eCxoQBIQ==
X-Received: by 2002:a2e:8447:0:b0:2ca:31a:4e8 with SMTP id
 u7-20020a2e8447000000b002ca031a04e8mr2831187ljh.72.1702398675493; 
 Tue, 12 Dec 2023 08:31:15 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a509e84000000b0054ccc3b2109sm5031675edf.57.2023.12.12.08.31.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:15 -0800 (PST)
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
Subject: [PATCH 13/33] hw/cpu/arm: Handle 'num_cores' property once in MPCore
 parent
Date: Tue, 12 Dec 2023 17:29:13 +0100
Message-ID: <20231212162935.42910-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Move the 'num_cpu' property to the abstract QOM parent.
Rename it as 'num_cores', keeping it aliased as 'num_cpu'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h |  9 +++++++--
 hw/arm/aspeed_ast2600.c        |  2 +-
 hw/arm/exynos4210.c            |  2 +-
 hw/arm/fsl-imx6.c              |  2 +-
 hw/arm/fsl-imx6ul.c            |  2 +-
 hw/arm/fsl-imx7.c              |  2 +-
 hw/arm/npcm7xx.c               |  2 +-
 hw/arm/realview.c              |  2 +-
 hw/cpu/a15mpcore.c             | 11 +++++------
 hw/cpu/a9mpcore.c              | 14 ++++++--------
 hw/cpu/arm11mpcore.c           |  3 ++-
 hw/cpu/cortex_mpcore.c         | 17 +++++++++++++++++
 hw/cpu/realview_mpcore.c       |  3 ++-
 13 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 1d94c8769d..0e7cca9e93 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -26,6 +26,10 @@
  * The A9 MPCore additionally contains:
  *  a System Control Unit
  *  some timers and watchdogs
+ *
+ * QEMU interface:
+ *  + QOM property "num-cores" which set the number of cores present in
+ *    the cluster.
  */
 #define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
 OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
@@ -46,6 +50,9 @@ struct CortexMPPrivState {
     SysBusDevice parent_obj;
 
     MemoryRegion container;
+
+    /* Properties */
+    uint32_t num_cores;
 };
 
 #define TYPE_A9MPCORE_PRIV "a9mpcore_priv"
@@ -54,7 +61,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(A9MPPrivState, A9MPCORE_PRIV)
 struct A9MPPrivState {
     CortexMPPrivState parent_obj;
 
-    uint32_t num_cpu;
     uint32_t num_irq;
 
     A9SCUState scu;
@@ -70,7 +76,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
 struct A15MPPrivState {
     CortexMPPrivState parent_obj;
 
-    uint32_t num_cpu;
     uint32_t num_irq;
 
     GICState gic;
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index b965fbab5e..ca788e1cf0 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -330,7 +330,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&a->a7mpcore), "num-cpu", sc->num_cpus,
+    object_property_set_int(OBJECT(&a->a7mpcore), "num-cores", sc->num_cpus,
                             &error_abort);
     object_property_set_int(OBJECT(&a->a7mpcore), "num-irq",
                             ROUND_UP(AST2600_MAX_IRQ + GIC_INTERNAL, 32),
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 2e6423f74d..ea1364499d 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -582,7 +582,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Private memory region and Internal GIC */
-    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cpu", EXYNOS4210_NCPUS);
+    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cores", EXYNOS4210_NCPUS);
     busdev = SYS_BUS_DEVICE(&s->a9mpcore);
     sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index f6edbd7465..65c7c1a0f9 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -138,7 +138,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", smp_cpus,
+    object_property_set_int(OBJECT(&s->a9mpcore), "num-cores", smp_cpus,
                             &error_abort);
 
     object_property_set_int(OBJECT(&s->a9mpcore), "num-irq",
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 59032263cf..93908811c5 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -173,7 +173,7 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", 1, &error_abort);
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-cores", 1, &error_abort);
     object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
                             FSL_IMX6UL_MAX_IRQ + GIC_INTERNAL, &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index a283dcb45f..8a3e9933c4 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -203,7 +203,7 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
     /*
      * A7MPCORE
      */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", smp_cpus,
+    object_property_set_int(OBJECT(&s->a7mpcore), "num-cores", smp_cpus,
                             &error_abort);
     object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
                             FSL_IMX7_MAX_IRQ + GIC_INTERNAL, &error_abort);
diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index 15ff21d047..5b6e968fa9 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -491,7 +491,7 @@ static void npcm7xx_realize(DeviceState *dev, Error **errp)
     }
 
     /* A9MPCORE peripherals. Can only fail if we pass bad parameters here. */
-    object_property_set_int(OBJECT(&s->a9mpcore), "num-cpu", nc->num_cpus,
+    object_property_set_int(OBJECT(&s->a9mpcore), "num-cores", nc->num_cpus,
                             &error_abort);
     object_property_set_int(OBJECT(&s->a9mpcore), "num-irq", NPCM7XX_NUM_IRQ,
                             &error_abort);
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index a112a6b529..bb6bab12c8 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -187,7 +187,7 @@ static void realview_init(MachineState *machine,
 
     if (is_mpcore) {
         dev = qdev_new(is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
-        qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
+        qdev_prop_set_uint32(dev, "num-cores", smp_cpus);
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_realize_and_unref(busdev, &error_fatal);
         sysbus_mmio_map(busdev, 0, periphbase);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 128941eb50..16874426e1 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -63,7 +63,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     }
 
     gicdev = DEVICE(&s->gic);
-    qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(gicdev, "num-cpu", c->num_cores);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
 
     if (!kvm_irqchip_in_kernel()) {
@@ -94,7 +94,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     /* Wire the outputs from each CPU's generic timer to the
      * appropriate GIC PPI inputs
      */
-    for (i = 0; i < s->num_cpu; i++) {
+    for (i = 0; i < c->num_cores; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
         int ppibase = s->num_irq - 32 + i * 32;
         int irq;
@@ -114,7 +114,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         }
         if (has_el2) {
             /* Connect the GIC maintenance interrupt to PPI ID 25 */
-            sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * s->num_cpu,
+            sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * c->num_cores,
                                qdev_get_gpio_in(gicdev, ppibase + 25));
         }
     }
@@ -139,17 +139,16 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
                                     sysbus_mmio_get_region(gicsbd, 2));
         memory_region_add_subregion(&c->container, 0x6000,
                                     sysbus_mmio_get_region(gicsbd, 3));
-        for (i = 0; i < s->num_cpu; i++) {
+        for (i = 0; i < c->num_cores; i++) {
             hwaddr base = 0x5000 + i * 0x200;
             MemoryRegion *mr = sysbus_mmio_get_region(gicsbd,
-                                                      4 + s->num_cpu + i);
+                                                      4 + c->num_cores + i);
             memory_region_add_subregion(&c->container, base, mr);
         }
     }
 }
 
 static Property a15mp_priv_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", A15MPPrivState, num_cpu, 1),
     /* The Cortex-A15MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 128+32, which
      * is the number provided by the Cortex-A15MP test chip in the
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 08346b0049..9c138f4442 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -51,7 +51,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
     Error *local_err = NULL;
-    int i;
     bool has_el3;
     CPUState *cpu0;
     Object *cpuobj;
@@ -72,14 +71,14 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     }
 
     scudev = DEVICE(&s->scu);
-    qdev_prop_set_uint32(scudev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(scudev, "num-cpu", c->num_cores);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
 
     gicdev = DEVICE(&s->gic);
-    qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(gicdev, "num-cpu", c->num_cores);
     qdev_prop_set_uint32(gicdev, "num-irq", s->num_irq);
     qdev_prop_set_uint32(gicdev, "num-priority-bits",
                          A9_GIC_NUM_PRIORITY_BITS);
@@ -103,21 +102,21 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     qdev_init_gpio_in(dev, a9mp_priv_set_irq, s->num_irq - 32);
 
     gtimerdev = DEVICE(&s->gtimer);
-    qdev_prop_set_uint32(gtimerdev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(gtimerdev, "num-cpu", c->num_cores);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), errp)) {
         return;
     }
     gtimerbusdev = SYS_BUS_DEVICE(&s->gtimer);
 
     mptimerdev = DEVICE(&s->mptimer);
-    qdev_prop_set_uint32(mptimerdev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(mptimerdev, "num-cpu", c->num_cores);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->mptimer), errp)) {
         return;
     }
     mptimerbusdev = SYS_BUS_DEVICE(&s->mptimer);
 
     wdtdev = DEVICE(&s->wdt);
-    qdev_prop_set_uint32(wdtdev, "num-cpu", s->num_cpu);
+    qdev_prop_set_uint32(wdtdev, "num-cpu", c->num_cores);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt), errp)) {
         return;
     }
@@ -153,7 +152,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
      * For each core the global timer is PPI 27, the private
      * timer is PPI 29 and the watchdog PPI 30.
      */
-    for (i = 0; i < s->num_cpu; i++) {
+    for (unsigned i = 0; i < c->num_cores; i++) {
         int ppibase = (s->num_irq - 32) + i * 32;
         sysbus_connect_irq(gtimerbusdev, i,
                            qdev_get_gpio_in(gicdev, ppibase + 27));
@@ -165,7 +164,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 }
 
 static Property a9mp_priv_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", A9MPPrivState, num_cpu, 1),
     /* The Cortex-A9MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 64+32, which
      * is the number provided by the Cortex-A9MP test chip in the
diff --git a/hw/cpu/arm11mpcore.c b/hw/cpu/arm11mpcore.c
index 74f44434de..67c96a3a7c 100644
--- a/hw/cpu/arm11mpcore.c
+++ b/hw/cpu/arm11mpcore.c
@@ -132,7 +132,8 @@ static void mpcore_priv_initfn(Object *obj)
 }
 
 static Property mpcore_priv_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", ARM11MPCorePriveState, num_cpu, 1),
+    DEFINE_PROP_UINT32("num-cores", ARM11MPCorePriveState, num_cpu, 1),
+    DEFINE_PROP_UINT32("num-cpu", ARM11MPCorePriveState, num_cpu, 1), /* alias */
     /* The ARM11 MPCORE TRM says the on-chip controller may have
      * anything from 0 to 224 external interrupt IRQ lines (with another
      * 32 internal). We default to 32+32, which is the number provided by
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index 0c12f99610..d7ea633e4e 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
 #include "hw/cpu/cortex_mpcore.h"
 
 static void cortex_mpcore_priv_instance_init(Object *obj)
@@ -22,6 +23,21 @@ static void cortex_mpcore_priv_instance_init(Object *obj)
     sysbus_init_mmio(sbd, &s->container);
 }
 
+static Property cortex_mpcore_priv_properties[] = {
+    DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
+    DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* alias */
+
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void cortex_mpcore_priv_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, cortex_mpcore_priv_properties);
+    /* We currently have no saveable state */
+}
+
 static const TypeInfo cortex_mpcore_types[] = {
     {
         .name           = TYPE_CORTEX_MPCORE_PRIV,
@@ -29,6 +45,7 @@ static const TypeInfo cortex_mpcore_types[] = {
         .instance_size  = sizeof(CortexMPPrivState),
         .instance_init  = cortex_mpcore_priv_instance_init,
         .class_size     = sizeof(CortexMPPrivClass),
+        .class_init     = cortex_mpcore_priv_class_init,
         .abstract       = true,
     },
 };
diff --git a/hw/cpu/realview_mpcore.c b/hw/cpu/realview_mpcore.c
index b140888618..e985d230e0 100644
--- a/hw/cpu/realview_mpcore.c
+++ b/hw/cpu/realview_mpcore.c
@@ -98,7 +98,8 @@ static void mpcore_rirq_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "a11priv", &s->priv, TYPE_ARM11MPCORE_PRIV);
-    object_property_add_alias(obj, "num-cpu", OBJECT(&s->priv), "num-cpu");
+    object_property_add_alias(obj, "num-cores", OBJECT(&s->priv), "num-cores");
+    object_property_add_alias(obj, "num-cpu", OBJECT(&s->priv), "num-cores");
     privbusdev = SYS_BUS_DEVICE(&s->priv);
     sysbus_init_mmio(sbd, sysbus_mmio_get_region(privbusdev, 0));
 
-- 
2.41.0


