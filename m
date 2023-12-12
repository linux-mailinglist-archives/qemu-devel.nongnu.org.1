Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AC80F2D3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5fO-0004Mx-GO; Tue, 12 Dec 2023 11:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fL-0004Hz-Fq
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:27 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fJ-0007ZV-B1
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:27 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bfd8d5c77so6780075e87.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398683; x=1703003483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mW1Tjy1V0dFWeejxgyNqrmaIo81vn3WijX9+VUqJA5M=;
 b=E/wuBPU5Kto+yFf1JchDxq69jz/aY4PpMbgHFb0k0Xc1B0k1auiL5bpVIKhBDQY9LL
 fvrXEo8ovsVR7J1l00TnpStNyWpTnQUEPl1LVP17nsu13ra3eohGtxKGYOPt6byct9W/
 pqCORBi4m/FJf+jOy8owaWz4MohPTtQYEjJn0KP04MIMv8U0U9NQhCnSnk4StbjpWjKM
 rd8Nil2hFbZcgPeGnog3VyhUpXWvcSB77GzlHfP7Ik1SSl1QlDSJedcV8NnNtSJsxHmQ
 avfkWG/1l3Mt6idmmKGZiT5gE4HvjKlfeITo2qTG1jAJctX6QlFrNTceedR71aBBd9lW
 JPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398683; x=1703003483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mW1Tjy1V0dFWeejxgyNqrmaIo81vn3WijX9+VUqJA5M=;
 b=rXMTFzI3XVp4J5Pk0qYdtTkDAzFJrYYKao84URCedpleMgRG4N+6lhwNIxvIBFEzqr
 4qUqzLK2EPdhq9qFnWdvzSlwN1LDQkIE4ETforUE0AhdwxrdyyIhbjO4I3VmGuBEEBwi
 z0DUETplPdwKkoBeILtl3Vdo38zJJWplWKamOxe+gv8Y3mrtsdAkbJ6pXyzLftVui6og
 3Xep8Ls5VoYRUUV4XXqVIY/NFBZmgzMagTT0PYrSC6uy4Of68ndb5SOtZubW2Rtgulko
 Q7/vjG10JVbfmSxqlNWh9lXRpE5W/L3AZLPu1l7WDSadfeijrFBZlxadOx6lkQcGyAh0
 Pq8A==
X-Gm-Message-State: AOJu0Yw0en0GLEEGdnzmI+KWOF/IT36wKT66srxADXUuCOli1qnjbhbf
 vZZpFVtruO2jPpg2+5snYMmT/+Ho2u++0OF+9Ew=
X-Google-Smtp-Source: AGHT+IEDzsJYFiwAEiaum1z1vfiWqAa0VGAxsCzYVC5oCq/EQ1CH2OgLUHwrEBj5vTmsr68UtzsP5g==
X-Received: by 2002:a05:6512:21d1:b0:50b:f82d:7feb with SMTP id
 d17-20020a05651221d100b0050bf82d7febmr1207545lft.267.1702398683338; 
 Tue, 12 Dec 2023 08:31:23 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 st3-20020a170907c08300b00a1c4fde4e88sm6559801ejc.18.2023.12.12.08.31.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:22 -0800 (PST)
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
Subject: [PATCH 14/33] hw/cpu/arm: Handle 'has_el2/3' properties once in
 MPCore parent
Date: Tue, 12 Dec 2023 17:29:14 +0100
Message-ID: <20231212162935.42910-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
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

Move the 'has_el2' and 'has_el3' properties to the abstract
QOM parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h |  5 +++++
 hw/arm/exynos4210.c            | 10 ++++++++--
 hw/arm/vexpress.c              |  6 ++++++
 hw/arm/xilinx_zynq.c           |  6 ++++++
 hw/cpu/a15mpcore.c             | 18 ++++++------------
 hw/cpu/a9mpcore.c              |  5 +----
 hw/cpu/cortex_mpcore.c         |  3 +++
 7 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 0e7cca9e93..387552468c 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -30,6 +30,8 @@
  * QEMU interface:
  *  + QOM property "num-cores" which set the number of cores present in
  *    the cluster.
+ *  + QOM properties "cpu-has-el3", "cpu-has-el2" which set whether the CPUs
+ *    have the exception level features present.
  */
 #define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
 OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
@@ -53,6 +55,9 @@ struct CortexMPPrivState {
 
     /* Properties */
     uint32_t num_cores;
+
+    bool cpu_has_el3;
+    bool cpu_has_el2;
 };
 
 #define TYPE_A9MPCORE_PRIV "a9mpcore_priv"
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index ea1364499d..7386a8fe57 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -548,7 +548,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     Exynos4210State *s = EXYNOS4210_SOC(socdev);
     MemoryRegion *system_mem = get_system_memory();
     SysBusDevice *busdev;
-    DeviceState *dev, *uart[4], *pl330[3];
+    DeviceState *dev, *mpdev, *uart[4], *pl330[3];
     int i, n;
 
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
@@ -582,7 +582,13 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     }
 
     /* Private memory region and Internal GIC */
-    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cores", EXYNOS4210_NCPUS);
+    mpdev = DEVICE(&s->a9mpcore);
+    qdev_prop_set_uint32(mpdev, "num-cores", EXYNOS4210_NCPUS);
+    /*
+     * By default A9 CPUs have EL3 enabled.  This board does not currently
+     * support EL3 so the CPU EL3 property is disabled before realization.
+     */
+    qdev_prop_set_bit(mpdev, "cpu-has-el3", false);
     busdev = SYS_BUS_DEVICE(&s->a9mpcore);
     sysbus_realize(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index a320d1c181..294b6f15f2 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -239,6 +239,12 @@ static void init_cpus(MachineState *ms, const char *cpu_type,
      * wires itself up to the CPU's generic_timer gpio out lines.
      */
     dev = qdev_new(privdev);
+    if (!secure) {
+        qdev_prop_set_bit(dev, "cpu-has-el3", false);
+    }
+    if (!virt) {
+        qdev_prop_set_bit(dev, "cpu-has-el2", false);
+    }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index fc9c927d09..28430dcfba 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -240,6 +240,12 @@ static void zynq_init(MachineState *machine)
 
     dev = qdev_new(TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
+    /*
+     * By default A9 CPUs have EL3 enabled.  This board does not
+     * currently support EL3 so the CPU EL3 property is disabled before
+     * realization.
+     */
+    qdev_prop_set_bit(dev, "cpu-has-el3", false);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(busdev, &error_fatal);
     sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 16874426e1..a16544fdde 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -52,9 +52,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *gicsbd;
     Error *local_err = NULL;
     int i;
-    bool has_el3;
-    bool has_el2 = false;
-    Object *cpuobj;
 
     cc->parent_realize(dev, &local_err);
     if (local_err) {
@@ -70,14 +67,11 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         /* Make the GIC's TZ support match the CPUs. We assume that
          * either all the CPUs have TZ, or none do.
          */
-        cpuobj = OBJECT(qemu_get_cpu(0));
-        has_el3 = object_property_find(cpuobj, "has_el3") &&
-            object_property_get_bool(cpuobj, "has_el3", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+        qdev_prop_set_bit(gicdev, "has-security-extensions",
+                          c->cpu_has_el3);
         /* Similarly for virtualization support */
-        has_el2 = object_property_find(cpuobj, "has_el2") &&
-            object_property_get_bool(cpuobj, "has_el2", &error_abort);
-        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_el2);
+        qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+                          c->cpu_has_el2);
     }
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
@@ -112,7 +106,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
                                   qdev_get_gpio_in(gicdev,
                                                    ppibase + timer_irq[irq]));
         }
-        if (has_el2) {
+        if (c->cpu_has_el2) {
             /* Connect the GIC maintenance interrupt to PPI ID 25 */
             sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * c->num_cores,
                                qdev_get_gpio_in(gicdev, ppibase + 25));
@@ -134,7 +128,7 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
                                 sysbus_mmio_get_region(gicsbd, 0));
     memory_region_add_subregion(&c->container, 0x2000,
                                 sysbus_mmio_get_region(gicsbd, 1));
-    if (has_el2) {
+    if (c->cpu_has_el2) {
         memory_region_add_subregion(&c->container, 0x4000,
                                     sysbus_mmio_get_region(gicsbd, 2));
         memory_region_add_subregion(&c->container, 0x6000,
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 9c138f4442..54949314f8 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -51,7 +51,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
                  *wdtbusdev;
     Error *local_err = NULL;
-    bool has_el3;
     CPUState *cpu0;
     Object *cpuobj;
 
@@ -86,9 +85,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     /* Make the GIC's TZ support match the CPUs. We assume that
      * either all the CPUs have TZ, or none do.
      */
-    has_el3 = object_property_find(cpuobj, "has_el3") &&
-        object_property_get_bool(cpuobj, "has_el3", &error_abort);
-    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
+    qdev_prop_set_bit(gicdev, "has-security-extensions", c->cpu_has_el3);
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
         return;
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index d7ea633e4e..549b81f708 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -27,6 +27,9 @@ static Property cortex_mpcore_priv_properties[] = {
     DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
     DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* alias */
 
+    DEFINE_PROP_BOOL("cpu-has-el3", CortexMPPrivState, cpu_has_el3, true),
+    DEFINE_PROP_BOOL("cpu-has-el2", CortexMPPrivState, cpu_has_el2, false),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


