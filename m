Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835380F2CE
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 17:34:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD5fb-0005FT-LV; Tue, 12 Dec 2023 11:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fZ-00059S-So
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:41 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD5fX-0007d3-L7
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 11:31:41 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a1db6c63028so676399466b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 08:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702398698; x=1703003498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3j4GMJw9r0IPrbqt7Mxx5UEV3EPUWQl/QPDzc+842IA=;
 b=jFXO5Kt+h600Opvuk01eOhqTWjhlR5onKgadKQ/He36e/NWkWQ2KZCNHN02sPlhmpp
 O27JLe+xjiB5UNsHKDs1QzmERWjWJhG0SDeAFTm9HC7e1mgUWh6RTo+zXJ8D8/EQyl4Y
 k5jpK24+wGp/rXLrYLyUik2+ZKq21TxXeEcYIPyFttbdrubHVRI73DVi0g/ldWQy/sQg
 mGdzgFuyi13L0QVRr3PLKnuLFaQ8eaIdFRXuKZFGR2kkA5wwOIkgaghaHte1Yeqe9bDN
 ktKp8xYgbU3NiByrTMMxljN3Kp/72ynoI3mhAR/zm/GZ64qGOZo0FSSY24SKa3PeRCY6
 D94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702398698; x=1703003498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3j4GMJw9r0IPrbqt7Mxx5UEV3EPUWQl/QPDzc+842IA=;
 b=qDPwpGj72Uk7aS0WtKvwgRtI3K+ELNJ5+4ufWvvXG49VxgXGvYEcpASSmmShr8p8De
 NZCzvS2zJr8oSZcs69dIIJHWoi8zxUk9kTa8za5fyUOVp8qzhIs+Br4AW1gk0m4UyFPV
 OXN9coUcBDRvm/Kh3MkYDHcgJwxoi1Hk930I1JUnEs/9v3j/YH+BsanuC/5yU1qpUOTv
 DdamSVUQNeJveiopsbBbOf6i3Qv0P0QXI6MolkknwQ77IV6C/q4RljYSe/RMVx1vTO/d
 bsxZ4sJyvPrRljiUjSP/niYS+pSmMCUovY/OERNHMoZdxOe7aF4SpMwTu5NJHARJVY77
 ABGw==
X-Gm-Message-State: AOJu0YxIRS5G4lAfLirwaQhtOSfXOljeKPe8Hd9Tiyg14JNymbpaxVc8
 GNbRiJmkHSjBiEDMFZaAiN09ohAHNwAm6IoCE8s=
X-Google-Smtp-Source: AGHT+IHVzeK7eLbEsTf/lbyD48d0NSeaKQvvyFsowkCt5jCygzHLQa16nnrL6AoUwlKgtmQ7yWMfvA==
X-Received: by 2002:a17:907:d8b:b0:a19:85ae:e0c3 with SMTP id
 go11-20020a1709070d8b00b00a1985aee0c3mr4074916ejc.35.1702398697998; 
 Tue, 12 Dec 2023 08:31:37 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 cx12-20020a170907168c00b00a1caa9dd507sm6518524ejd.52.2023.12.12.08.31.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Dec 2023 08:31:37 -0800 (PST)
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
Subject: [PATCH 16/33] hw/cpu/arm: Handle GIC once in MPCore parent
Date: Tue, 12 Dec 2023 17:29:16 +0100
Message-ID: <20231212162935.42910-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Move the GIC instance creation to the abstract QOM parent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/cpu/cortex_mpcore.h | 31 +++++++++++++++++--
 hw/cpu/a15mpcore.c             | 56 ++++------------------------------
 hw/cpu/a9mpcore.c              | 43 +++++---------------------
 hw/cpu/cortex_mpcore.c         | 46 ++++++++++++++++++++++++++++
 hw/arm/Kconfig                 |  3 +-
 5 files changed, 88 insertions(+), 91 deletions(-)

diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcore.h
index 96da713be9..4697fd47c7 100644
--- a/include/hw/cpu/cortex_mpcore.h
+++ b/include/hw/cpu/cortex_mpcore.h
@@ -34,6 +34,28 @@
  *    have the exception level features present.
  *  + QOM property "gic-spi-num" sets the number of GIC Shared Peripheral
  *    Interrupts.
+ * QEMU interface forwarded from the GIC:
+ *  + unnamed GPIO inputs: (where P is number of GIC SPIs, i.e. num-irq - 32)
+ *    [0..P-1]  GIC SPIs
+ *    [P..P+31] PPIs for CPU 0
+ *    [P+32..P+63] PPIs for CPU 1
+ *    ...
+ *  + sysbus output IRQs: (in order; number will vary depending on number of
+ *    cores)
+ *    - IRQ for CPU 0
+ *    - IRQ for CPU 1
+ *      ...
+ *    - FIQ for CPU 0
+ *    - FIQ for CPU 1
+ *      ...
+ *    - VIRQ for CPU 0 (exists even if virt extensions not present)
+ *    - VIRQ for CPU 1 (exists even if virt extensions not present)
+ *      ...
+ *    - VFIQ for CPU 0 (exists even if virt extensions not present)
+ *    - VFIQ for CPU 1 (exists even if virt extensions not present)
+ *      ...
+ *    - maintenance IRQ for CPU i/f 0 (only if virt extensions present)
+ *    - maintenance IRQ for CPU i/f 1 (only if virt extensions present)
  */
 #define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
 OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
@@ -41,8 +63,10 @@ OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_PRIV)
 /**
  * CortexMPPrivClass:
  * @container_size - size of the device's MMIO region
+ * @gic_class_name - GIC QOM class name
  * @gic_spi_default - default number of GIC SPIs
  * @gic_spi_max - maximum number of GIC SPIs
+ * @gic_revision - revision of the GIC
  */
 struct CortexMPPrivClass {
     SysBusDeviceClass parent_class;
@@ -51,14 +75,18 @@ struct CortexMPPrivClass {
 
     uint64_t container_size;
 
+    const char *gic_class_name;
     unsigned gic_spi_default;
     unsigned gic_spi_max;
+    unsigned gic_revision;
+    uint32_t gic_priority_bits;
 };
 
 struct CortexMPPrivState {
     SysBusDevice parent_obj;
 
     MemoryRegion container;
+    GICState gic;
 
     /* Properties */
     uint32_t num_cores;
@@ -76,7 +104,6 @@ struct A9MPPrivState {
     CortexMPPrivState parent_obj;
 
     A9SCUState scu;
-    GICState gic;
     A9GTimerState gtimer;
     ARMMPTimerState mptimer;
     ARMMPTimerState wdt;
@@ -87,8 +114,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(A15MPPrivState, A15MPCORE_PRIV)
 
 struct A15MPPrivState {
     CortexMPPrivState parent_obj;
-
-    GICState gic;
 };
 
 #endif
diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
index 195355b589..ecd04b7af1 100644
--- a/hw/cpu/a15mpcore.c
+++ b/hw/cpu/a15mpcore.c
@@ -22,34 +22,15 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/cortex_mpcore.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
-#include "sysemu/kvm.h"
-#include "kvm_arm.h"
-
-static void a15mp_priv_set_irq(void *opaque, int irq, int level)
-{
-    A15MPPrivState *s = (A15MPPrivState *)opaque;
-
-    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
-}
-
-static void a15mp_priv_initfn(Object *obj)
-{
-    A15MPPrivState *s = A15MPCORE_PRIV(obj);
-
-    object_initialize_child(obj, "gic", &s->gic, gic_class_name());
-    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", 2);
-}
+#include "hw/core/cpu.h"
+#include "target/arm/cpu.h"
 
 static void a15mp_priv_realize(DeviceState *dev, Error **errp)
 {
     CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    A15MPPrivState *s = A15MPCORE_PRIV(dev);
     CortexMPPrivState *c = CORTEX_MPCORE_PRIV(dev);
-    DeviceState *gicdev;
-    SysBusDevice *gicsbd;
+    DeviceState *gicdev = DEVICE(&c->gic);
+    SysBusDevice *gicsbd = SYS_BUS_DEVICE(&c->gic);
     Error *local_err = NULL;
     int i;
 
@@ -59,32 +40,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    gicdev = DEVICE(&s->gic);
-    qdev_prop_set_uint32(gicdev, "num-cpu", c->num_cores);
-    qdev_prop_set_uint32(gicdev, "num-irq", c->gic_spi_num);
-
-    if (!kvm_irqchip_in_kernel()) {
-        /* Make the GIC's TZ support match the CPUs. We assume that
-         * either all the CPUs have TZ, or none do.
-         */
-        qdev_prop_set_bit(gicdev, "has-security-extensions",
-                          c->cpu_has_el3);
-        /* Similarly for virtualization support */
-        qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
-                          c->cpu_has_el2);
-    }
-
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
-        return;
-    }
-    gicsbd = SYS_BUS_DEVICE(&s->gic);
-
-    /* Pass through outbound IRQ lines from the GIC */
-    sysbus_pass_irq(sbd, gicsbd);
-
-    /* Pass through inbound GPIO lines to the GIC */
-    qdev_init_gpio_in(dev, a15mp_priv_set_irq, c->gic_spi_num - 32);
-
     /* Wire the outputs from each CPU's generic timer to the
      * appropriate GIC PPI inputs
      */
@@ -149,6 +104,8 @@ static void a15mp_priv_class_init(ObjectClass *klass, void *data)
 
     cc->container_size = 0x8000;
 
+    cc->gic_class_name = gic_class_name();
+    cc->gic_revision = 2;
     /*
      * The Cortex-A15MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 128+32, which
@@ -169,7 +126,6 @@ static const TypeInfo a15mp_types[] = {
         .name           = TYPE_A15MPCORE_PRIV,
         .parent         = TYPE_CORTEX_MPCORE_PRIV,
         .instance_size  = sizeof(A15MPPrivState),
-        .instance_init  = a15mp_priv_initfn,
         .class_init     = a15mp_priv_class_init,
     },
 };
diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
index 72621bce64..ffdaf392fc 100644
--- a/hw/cpu/a9mpcore.c
+++ b/hw/cpu/a9mpcore.c
@@ -12,28 +12,18 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "hw/cpu/cortex_mpcore.h"
-#include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/core/cpu.h"
 #include "cpu.h"
 
 #define A9_GIC_NUM_PRIORITY_BITS    5
 
-static void a9mp_priv_set_irq(void *opaque, int irq, int level)
-{
-    A9MPPrivState *s = (A9MPPrivState *)opaque;
-
-    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
-}
-
 static void a9mp_priv_initfn(Object *obj)
 {
     A9MPPrivState *s = A9MPCORE_PRIV(obj);
 
     object_initialize_child(obj, "scu", &s->scu, TYPE_A9_SCU);
 
-    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
-
     object_initialize_child(obj, "gtimer", &s->gtimer, TYPE_A9_GTIMER);
 
     object_initialize_child(obj, "mptimer", &s->mptimer, TYPE_ARM_MPTIMER);
@@ -45,11 +35,11 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
 {
     CortexMPPrivClass *cc = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
     CortexMPPrivState *c = CORTEX_MPCORE_PRIV(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     A9MPPrivState *s = A9MPCORE_PRIV(dev);
-    DeviceState *scudev, *gicdev, *gtimerdev, *mptimerdev, *wdtdev;
-    SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
-                 *wdtbusdev;
+    DeviceState *gicdev = DEVICE(&c->gic);
+    SysBusDevice *gicbusdev = SYS_BUS_DEVICE(&c->gic);
+    DeviceState *scudev, *gtimerdev, *mptimerdev, *wdtdev;
+    SysBusDevice *scubusdev, *gtimerbusdev, *mptimerbusdev, *wdtbusdev;
     Error *local_err = NULL;
     CPUState *cpu0;
     Object *cpuobj;
@@ -76,28 +66,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error **errp)
     }
     scubusdev = SYS_BUS_DEVICE(&s->scu);
 
-    gicdev = DEVICE(&s->gic);
-    qdev_prop_set_uint32(gicdev, "num-cpu", c->num_cores);
-    qdev_prop_set_uint32(gicdev, "num-irq", c->gic_spi_num);
-    qdev_prop_set_uint32(gicdev, "num-priority-bits",
-                         A9_GIC_NUM_PRIORITY_BITS);
-
-    /* Make the GIC's TZ support match the CPUs. We assume that
-     * either all the CPUs have TZ, or none do.
-     */
-    qdev_prop_set_bit(gicdev, "has-security-extensions", c->cpu_has_el3);
-
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
-        return;
-    }
-    gicbusdev = SYS_BUS_DEVICE(&s->gic);
-
-    /* Pass through outbound IRQ lines from the GIC */
-    sysbus_pass_irq(sbd, gicbusdev);
-
-    /* Pass through inbound GPIO lines to the GIC */
-    qdev_init_gpio_in(dev, a9mp_priv_set_irq, c->gic_spi_num - 32);
-
     gtimerdev = DEVICE(&s->gtimer);
     qdev_prop_set_uint32(gtimerdev, "num-cpu", c->num_cores);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gtimer), errp)) {
@@ -167,6 +135,9 @@ static void a9mp_priv_class_init(ObjectClass *klass, void *data)
 
     cc->container_size = 0x2000;
 
+    cc->gic_class_name = TYPE_ARM_GIC;
+    cc->gic_revision = 1;
+    cc->gic_priority_bits = A9_GIC_NUM_PRIORITY_BITS;
     /*
      * The Cortex-A9MP may have anything from 0 to 224 external interrupt
      * IRQ lines (with another 32 internal). We default to 64+32, which
diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
index dee40a7bf2..c9ba254818 100644
--- a/hw/cpu/cortex_mpcore.c
+++ b/hw/cpu/cortex_mpcore.c
@@ -10,6 +10,15 @@
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/cpu/cortex_mpcore.h"
+#include "hw/irq.h"
+#include "sysemu/kvm.h"
+
+static void cortex_mpcore_priv_set_irq(void *opaque, int irq, int level)
+{
+    CortexMPPrivState *s = (CortexMPPrivState *)opaque;
+
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
+}
 
 static void cortex_mpcore_priv_instance_init(Object *obj)
 {
@@ -23,6 +32,42 @@ static void cortex_mpcore_priv_instance_init(Object *obj)
     sysbus_init_mmio(sbd, &s->container);
 
     s->gic_spi_num = k->gic_spi_default;
+    object_initialize_child(obj, "gic", &s->gic, k->gic_class_name);
+    qdev_prop_set_uint32(DEVICE(&s->gic), "revision", k->gic_revision);
+}
+
+static void cortex_mpcore_priv_realize(DeviceState *dev, Error **errp)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    CortexMPPrivState *s = CORTEX_MPCORE_PRIV(dev);
+    CortexMPPrivClass *k = CORTEX_MPCORE_PRIV_GET_CLASS(dev);
+    DeviceState *gicdev = DEVICE(&s->gic);
+
+    qdev_prop_set_uint32(gicdev, "num-cpu", s->num_cores);
+    qdev_prop_set_uint32(gicdev, "num-irq", s->gic_spi_num);
+    if (k->gic_priority_bits) {
+        qdev_prop_set_uint32(gicdev, "num-priority-bits", k->gic_priority_bits);
+    }
+    if (!kvm_irqchip_in_kernel()) {
+        /*
+         * Make the GIC's TZ support match the CPUs. We assume that
+         * either all the CPUs have TZ, or none do.
+         */
+        qdev_prop_set_bit(gicdev, "has-security-extensions",
+                          s->cpu_has_el3);
+        /* Similarly for virtualization support */
+        qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
+                          s->cpu_has_el2);
+    }
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
+        return;
+    }
+
+    /* Pass through outbound IRQ lines from the GIC */
+    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->gic));
+
+    /* Pass through inbound GPIO lines to the GIC */
+    qdev_init_gpio_in(dev, cortex_mpcore_priv_set_irq, s->gic_spi_num - 32);
 }
 
 static Property cortex_mpcore_priv_properties[] = {
@@ -42,6 +87,7 @@ static void cortex_mpcore_priv_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = cortex_mpcore_priv_realize;
     device_class_set_props(dc, cortex_mpcore_priv_properties);
     /* We currently have no saveable state */
 }
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ec6e585797..6c4fa5108b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -645,19 +645,18 @@ config ZAURUS
 
 config CORTEX_MPCORE
     bool
+    select ARM_GIC
 
 config A9MPCORE
     bool
     select CORTEX_MPCORE
     select A9_GTIMER
     select A9SCU       # snoop control unit
-    select ARM_GIC
     select ARM_MPTIMER
 
 config A15MPCORE
     bool
     select CORTEX_MPCORE
-    select ARM_GIC
 
 config ARM11MPCORE
     bool
-- 
2.41.0


