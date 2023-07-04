Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444D574747C
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNh-0006vv-7x; Tue, 04 Jul 2023 10:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNa-0006gK-Lc
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:46 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNY-0003Il-Ji
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3143798f542so2366808f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482303; x=1691074303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoiopN5m4eo81u2lGvLxlfXk+Lie1Jj0bV1bknAcSnc=;
 b=NLlf2MXbxKxVRsfadigRs4LvNadXGP0v8RuNq6kz02Q9WjFHArpZ9pl73sChV6e4uI
 OIw2/hyLCBAvrmTJVR8Du4fp0khwf06IjRahypseTwQgxkvtQ68PYlqyc59weq0o2Jj8
 e/5d3eUWtRU854AKzoOsV4TveqsiIcOVYGsNttbKqVsDrT/sktvA7BwegqqfazCiLSlD
 bj25lbdZJP7pSNxzbWG4iILncHH9OOnI03z7GFS6QFQqRM/E9Pk+aiCmlLOJwr1Z/JkR
 MHgl4T/UAYBLgp/8PnuUQfSO/aspqQlkUTR0GMSSZLlgAHdWtrc2Gu4h2FMiGyYmA3CB
 sIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482303; x=1691074303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FoiopN5m4eo81u2lGvLxlfXk+Lie1Jj0bV1bknAcSnc=;
 b=jm/RYGmnfNfFxLLinihfS5+25VVMC4SMTMBOCS3wzQimaui4xEoH5FvCHDZ3RCBG16
 90psyfvefO82rBeF82Kgf7BuMeZB8igWDZ7NijaeGABGs3FjusEjYP532DWE91odN6vw
 ef8g1QRn7I2i0Ox2VOzas1dc5ViEaz7kLjQPNKeYtUxw1J0+A6Kxic9+f9OuLWpgbVFV
 H0nMOXcO7DNzzTby3YKOwK/r1jw6K2lkJZFdtVSkyzoyBdjaLZ+RocXI+KvrejRDCed9
 gc1QqTdXxjDK4yca1vF8I1tZefmJI9rv3EvLD5u10fgPUgqh3Nx34meSnfzaAskOma1U
 zU+g==
X-Gm-Message-State: ABy/qLbrpY94Jcca+ncr+FFM7rlQQ+ntIwcsCCQcoMVOP8X20ihDRvU4
 81bnil1AtfWOjLwvtZ6amHkRwkYpYoENwwcTUbA=
X-Google-Smtp-Source: APBJJlEmg1oLt8QRg8dAdJwOttyoU2v3efC25T4NR91EyYdcc/+VFnF2MBXYEN5kCf+1tLu7rbkDpQ==
X-Received: by 2002:adf:f210:0:b0:314:1aed:8f5f with SMTP id
 p16-20020adff210000000b003141aed8f5fmr11837753wro.34.1688482303020; 
 Tue, 04 Jul 2023 07:51:43 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d50cd000000b003143b7449ffsm3865602wrt.25.2023.07.04.07.51.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 17/19] hw/timer/arm_timer: QDev'ify ARM_TIMER
Date: Tue,  4 Jul 2023 16:50:10 +0200
Message-Id: <20230704145012.49870-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Introduce the ARM_TIMER sysbus device, exposing one output IRQ
and a single MMIO region.

arm_timer_new() is converted as QOM instance init()/finalize()
handlers. Note in arm_timer_finalize() we release a ptimer handle
which was previously leaked.

ArmTimer is directly embedded into SP804Timer/IntegratorPIT,
and is initialized as a QOM child.

Since the timer frequency belongs to ARM_TIMER, have it hold the
QOM property. SP804Timer/IntegratorPIT directly access it.

For IntegratorPIT, each ARM_TIMER sysbus output IRQ is wired as
input IRQ.

For the SP804Timer, we add a TYPE_OR_IRQ to OR the ARM_TIMER sysbus
output IRQs together, exposing a single output IRQ.
The Kconfig entry have to select the OR_IRQ dependency.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 139 ++++++++++++++++++++++++++++++++-----------
 hw/timer/Kconfig     |   1 +
 2 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 30e29cc166..8207723ab5 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -12,11 +12,13 @@
 #include "migration/vmstate.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
+#include "hw/or-irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 /* Common timer implementation.  */
 
@@ -29,14 +31,20 @@
 #define TIMER_CTRL_PERIODIC     (1 << 6)
 #define TIMER_CTRL_ENABLE       (1 << 7)
 
-typedef struct {
+#define TYPE_ARM_TIMER "arm-timer"
+OBJECT_DECLARE_SIMPLE_TYPE(ArmTimer, ARM_TIMER)
+
+struct ArmTimer {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
     ptimer_state *timer;
     uint32_t control;
     uint32_t limit;
     uint32_t freq;
     int int_level;
     qemu_irq irq;
-} ArmTimer;
+};
 
 /* Check all active timers, and schedule the next timer interrupt.  */
 
@@ -152,6 +160,14 @@ static void arm_timer_write(void *opaque, hwaddr offset,
     arm_timer_update(s);
 }
 
+static const MemoryRegionOps arm_timer_ops = {
+    .read = arm_timer_read,
+    .write = arm_timer_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
+};
+
 static void arm_timer_tick(void *opaque)
 {
     ArmTimer *s = opaque;
@@ -172,25 +188,49 @@ static const VMStateDescription vmstate_arm_timer = {
     }
 };
 
-static void arm_timer_reset_hold(ArmTimer *s)
+static void arm_timer_reset_hold(Object *obj)
 {
+    ArmTimer *s = ARM_TIMER(obj);
+
     s->limit = 0;
     s->int_level = 0;
     s->control = TIMER_CTRL_IE;
 }
 
-static ArmTimer *arm_timer_new(uint32_t freq, qemu_irq irq_out)
+static void arm_timer_init(Object *obj)
 {
-    ArmTimer *s;
+    ArmTimer *s = ARM_TIMER(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    s = g_new0(ArmTimer, 1);
-    s->freq = freq;
-    arm_timer_reset_hold(s);
-
-    s->irq = irq_out;
     s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_LEGACY);
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY, &vmstate_arm_timer, s);
-    return s;
+
+    sysbus_init_irq(sbd, &s->irq);
+
+    memory_region_init_io(&s->iomem, obj, &arm_timer_ops, s,
+                          "arm_timer", 0x20);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void arm_timer_finalize(Object *obj)
+{
+    ArmTimer *s = ARM_TIMER(obj);
+
+    ptimer_free(s->timer);
+}
+
+static Property arm_timer_properties[] = {
+    DEFINE_PROP_UINT32("freq", ArmTimer, freq, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void arm_timer_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    dc->vmsd = &vmstate_arm_timer;
+    device_class_set_props(dc, arm_timer_properties);
+    rc->phases.hold = arm_timer_reset_hold;
 }
 
 /*
@@ -206,11 +246,10 @@ struct SP804Timer {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    ArmTimer *timer[2];
-    uint32_t freq[2];
-    int level[2];
+    ArmTimer timer[2];
+    int mig_v1_level[2];
+    OrIRQState irq_orgate;
     qemu_irq irq;
-    qemu_irq irq_in[2];
 };
 
 static const uint8_t sp804_ids[] = {
@@ -220,15 +259,6 @@ static const uint8_t sp804_ids[] = {
     0xd, 0xf0, 0x05, 0xb1
 };
 
-/* Merge the IRQs from the two component devices.  */
-static void sp804_set_irq(void *opaque, int irq, int level)
-{
-    SP804Timer *s = opaque;
-
-    s->level[irq] = level;
-    qemu_set_irq(s->irq, s->level[0] || s->level[1]);
-}
-
 static uint64_t sp804_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
@@ -287,12 +317,26 @@ static const MemoryRegionOps sp804_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static int sp804_post_load(void *opaque, int version_id)
+{
+    SP804Timer *s = opaque;
+
+    if (version_id < 2) {
+        for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+            qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->irq_orgate), i),
+                         s->mig_v1_level[i]);
+        }
+    }
+    return 0;
+}
+
 static const VMStateDescription vmstate_sp804 = {
     .name = "sp804",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = sp804_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32_ARRAY(level, SP804Timer, 2),
+        VMSTATE_INT32_ARRAY(mig_v1_level, SP804Timer, 2),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -306,21 +350,36 @@ static void sp804_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &sp804_ops, s,
                           "sp804", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    object_initialize_child(obj, "timer-irq-orgate",
+                            &s->irq_orgate, TYPE_OR_IRQ);
+
+    for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
+        object_initialize_child(obj, "timer[*]", &s->timer[i], TYPE_ARM_TIMER);
+    }
 }
 
 static void sp804_realize(DeviceState *dev, Error **errp)
 {
     SP804Timer *s = SP804_TIMER(dev);
 
+    object_property_set_int(OBJECT(&s->irq_orgate),
+                            "num-lines", 2, &error_fatal);
+    qdev_realize(DEVICE(&s->irq_orgate), NULL, &error_fatal);
+
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
-        s->irq_in[i] = qemu_allocate_irq(sp804_set_irq, s, i);
-        s->timer[i] = arm_timer_new(s->freq[i], s->irq_in[i]);
+        SysBusDevice *tmr = SYS_BUS_DEVICE(&s->timer[i]);
+
+        if (!sysbus_realize(tmr, errp)) {
+            return;
+        }
+        sysbus_connect_irq(tmr, 0, qdev_get_gpio_in(DEVICE(&s->irq_orgate), i));
     }
 }
 
 static Property sp804_properties[] = {
-    DEFINE_PROP_UINT32("freq0", SP804Timer, freq[0], 1000000),
-    DEFINE_PROP_UINT32("freq1", SP804Timer, freq[1], 1000000),
+    DEFINE_PROP_UINT32("freq0", SP804Timer, timer[0].freq, 1000000),
+    DEFINE_PROP_UINT32("freq1", SP804Timer, timer[1].freq, 1000000),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -342,8 +401,7 @@ struct IntegratorPIT {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    ArmTimer *timer[3];
-    qemu_irq irq_in[3];
+    ArmTimer timer[3];
     qemu_irq irq[3];
 };
 
@@ -406,7 +464,8 @@ static void icp_pit_init(Object *obj)
                             "timer-in", ARRAY_SIZE(s->timer));
 
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
-        s->timer[i] = arm_timer_new(tmr_freq[i], s->irq_in[i]);
+        object_initialize_child(obj, "timer[*]", &s->timer[i], TYPE_ARM_TIMER);
+        qdev_prop_set_uint32(DEVICE(&s->timer[i]), "freq", tmr_freq[i]);
         sysbus_init_irq(dev, &s->irq[i]);
     }
 
@@ -424,7 +483,10 @@ static void icp_pit_realize(DeviceState *dev, Error **errp)
     for (unsigned i = 0; i < ARRAY_SIZE(s->timer); i++) {
         SysBusDevice *tmr = SYS_BUS_DEVICE(&s->timer[i]);
 
-        sysbus_connect_irq(tmr, i, qdev_get_gpio_in_named(dev, "timer-in", i));
+        if (!sysbus_realize(tmr, errp)) {
+            return;
+        }
+        sysbus_connect_irq(tmr, 0, qdev_get_gpio_in_named(dev, "timer-in", i));
     }
 }
 
@@ -437,6 +499,13 @@ static void icp_pit_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo arm_timer_types[] = {
     {
+        .name           = TYPE_ARM_TIMER,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(ArmTimer),
+        .instance_init  = arm_timer_init,
+        .instance_finalize = arm_timer_finalize,
+        .class_init     = arm_timer_class_init,
+    }, {
         .name           = TYPE_INTEGRATOR_PIT,
         .parent         = TYPE_SYS_BUS_DEVICE,
         .instance_size  = sizeof(IntegratorPIT),
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index 010be7ed1f..61b048f49c 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -1,6 +1,7 @@
 config ARM_TIMER
     bool
     select PTIMER
+    select OR_IRQ
 
 config ARM_MPTIMER
     bool
-- 
2.38.1


