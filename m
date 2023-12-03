Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F383F8027C8
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:30:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u1f-0001Md-CT; Sun, 03 Dec 2023 16:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1c-0001JF-Cx; Sun, 03 Dec 2023 16:29:16 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1Y-0005Mp-4b; Sun, 03 Dec 2023 16:29:16 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-db3fa47c2f7so2142586276.0; 
 Sun, 03 Dec 2023 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638950; x=1702243750; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DToKVpvlexd+YNhAs9MVA6EGWpl46MywNEXdi2wvJUE=;
 b=ew7KUbkzPr4t2ApPOquepFUXq/QOVTcbwAO5jOH/5a3foBmaSrDpaTuw2sqlImOkSO
 jy9UD5SgvFqFMAfzJmU9GEHu4DK9ku69VY7UgYyCE6BtQVkoOdRdxggIPEKMq/tLbgI1
 gbDrP5x9gj1X7wS0+eOJUDwwzJeQUTlu+FxdXlQl/BbbWvpEuWbSqYhG7OjeHf7MaFCB
 ijsP6g/UW5FDh9mbph5nlzy6t7WmNaoQhi3khbJlaB21MjP+faDUTjUHtMxxMJ4eNkGU
 d51gccYDQ13HdJovxLYyI/CZAO99uDLJB9HrmkBXsoxuAwTSRJD58iTaS3QbEfF6H9zA
 OiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638950; x=1702243750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DToKVpvlexd+YNhAs9MVA6EGWpl46MywNEXdi2wvJUE=;
 b=bn7VzR6tYOmTiSqfrE+NBSDsdeXMUuv0Yi8XdSKYsK6i0ttDTeRml1bySByM1SCAen
 bmLbq+vlF5VAzTB0+PNiHnML/dsrO/2mGq5aIa05rRYj4Km7QKRzLzqVxG1/C9o77zqa
 GPJHXQqL6sYArvR33y255Lpx35DHk+k+a8JbACBp4iY1M2+Ymvt5XOVkS+V6/CuEuwRc
 8nJrc1C59p8aVVvw04ToOylsnweIYFHTFHNgtA00sNdAI0hu/P5Z78tYpqp+Y3p/1G8y
 n4FD+1wwKFVzW+qobOyQdG8nipRU0ZAX8Vm8tgxhBQNHBTx3UhZimj4bbHr4AWxCgbs/
 Dm5g==
X-Gm-Message-State: AOJu0YzjNLrgcpIdqAQV6dg+F82iISdZy9TCxCKTm6I4Xm3lPBDwgxcf
 FSH/QqvXwb8RMi/eKFWHFqH/nT9ff7qIqQ==
X-Google-Smtp-Source: AGHT+IEct+v3oCke6S5wvxFlQYDjJzgjZ2vbsu8yzRfsWHTZLcOhRpCzCTKme0yZ5b0U3a+BMuOdiw==
X-Received: by 2002:a5b:4c1:0:b0:db7:dad0:60b8 with SMTP id
 u1-20020a5b04c1000000b00db7dad060b8mr1820995ybp.69.1701638950255; 
 Sun, 03 Dec 2023 13:29:10 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:10 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 01/45] Split out common part of BCM283X classes
Date: Sun,  3 Dec 2023 15:28:21 -0600
Message-Id: <20231203212905.1364036-2-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Pre setup for BCM2838 introduction

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2836.c         | 102 ++++++++++++++++++++++-----------------
 hw/arm/raspi.c           |   2 +-
 include/hw/arm/bcm2836.h |  26 +++++++++-
 3 files changed, 83 insertions(+), 47 deletions(-)

diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 166dc896c0..66a2b57b38 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -29,12 +29,12 @@ struct BCM283XClass {
 };
 
 static Property bcm2836_enabled_cores_property =
-    DEFINE_PROP_UINT32("enabled-cpus", BCM283XState, enabled_cpus, 0);
+    DEFINE_PROP_UINT32("enabled-cpus", BCM283XBaseState, enabled_cpus, 0);
 
-static void bcm2836_init(Object *obj)
+static void bcm283x_base_init(Object *obj)
 {
-    BCM283XState *s = BCM283X(obj);
-    BCM283XClass *bc = BCM283X_GET_CLASS(obj);
+    BCM283XBaseState *s = BCM283X_BASE(obj);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
     int n;
 
     for (n = 0; n < bc->core_count; n++) {
@@ -50,6 +50,11 @@ static void bcm2836_init(Object *obj)
         object_initialize_child(obj, "control", &s->control,
                                 TYPE_BCM2836_CONTROL);
     }
+}
+
+static void bcm283x_init(Object *obj)
+{
+    BCM283XState *s = BCM283X(obj);
 
     object_initialize_child(obj, "peripherals", &s->peripherals,
                             TYPE_BCM2835_PERIPHERALS);
@@ -61,10 +66,11 @@ static void bcm2836_init(Object *obj)
                               "vcram-size");
 }
 
-static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
+bool bcm283x_common_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
-    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
     /* common peripherals from bcm2835 */
@@ -77,96 +83,98 @@ static bool bcm283x_common_realize(DeviceState *dev, Error **errp)
         return false;
     }
 
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
-                              "sd-bus");
+    object_property_add_alias(OBJECT(s_base), "sd-bus",
+                              OBJECT(&s->peripherals), "sd-bus");
 
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
-                            bc->peri_base, 1);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals),
+                            0, bc->peri_base, 1);
     return true;
 }
 
 static void bcm2835_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
 
     if (!bcm283x_common_realize(dev, errp)) {
         return;
     }
 
-    if (!qdev_realize(DEVICE(&s->cpu[0].core), NULL, errp)) {
+    if (!qdev_realize(DEVICE(&s_base->cpu[0].core), NULL, errp)) {
         return;
     }
 
     /* Connect irq/fiq outputs from the interrupt controller. */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_IRQ));
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[0].core), ARM_CPU_IRQ));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-            qdev_get_gpio_in(DEVICE(&s->cpu[0].core), ARM_CPU_FIQ));
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[0].core), ARM_CPU_FIQ));
 }
 
 static void bcm2836_realize(DeviceState *dev, Error **errp)
 {
-    BCM283XState *s = BCM283X(dev);
-    BCM283XClass *bc = BCM283X_GET_CLASS(dev);
     int n;
+    BCM283XState *s = BCM283X(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
 
     if (!bcm283x_common_realize(dev, errp)) {
         return;
     }
 
     /* bcm2836 interrupt controller (and mailboxes, etc.) */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->control), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s_base->control), errp)) {
         return;
     }
 
-    sysbus_mmio_map(SYS_BUS_DEVICE(&s->control), 0, bc->ctrl_base);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc->ctrl_base);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-irq", 0));
+        qdev_get_gpio_in_named(DEVICE(&s_base->control), "gpu-irq", 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
-        qdev_get_gpio_in_named(DEVICE(&s->control), "gpu-fiq", 0));
+        qdev_get_gpio_in_named(DEVICE(&s_base->control), "gpu-fiq", 0));
 
     for (n = 0; n < BCM283X_NCPUS; n++) {
         /* TODO: this should be converted to a property of ARM_CPU */
-        s->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
+        s_base->cpu[n].core.mp_affinity = (bc->clusterid << 8) | n;
 
         /* set periphbase/CBAR value for CPU-local registers */
-        if (!object_property_set_int(OBJECT(&s->cpu[n].core), "reset-cbar",
+        if (!object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
                                      bc->peri_base, errp)) {
             return;
         }
 
         /* start powered off if not enabled */
-        if (!object_property_set_bool(OBJECT(&s->cpu[n].core),
+        if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
                                       "start-powered-off",
-                                      n >= s->enabled_cpus,
+                                      n >= s_base->enabled_cpus,
                                       errp)) {
             return;
         }
 
-        if (!qdev_realize(DEVICE(&s->cpu[n].core), NULL, errp)) {
+        if (!qdev_realize(DEVICE(&s_base->cpu[n].core), NULL, errp)) {
             return;
         }
 
         /* Connect irq/fiq outputs from the interrupt controller. */
-        qdev_connect_gpio_out_named(DEVICE(&s->control), "irq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_IRQ));
-        qdev_connect_gpio_out_named(DEVICE(&s->control), "fiq", n,
-                qdev_get_gpio_in(DEVICE(&s->cpu[n].core), ARM_CPU_FIQ));
+        qdev_connect_gpio_out_named(DEVICE(&s_base->control), "irq", n,
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[n].core), ARM_CPU_IRQ));
+        qdev_connect_gpio_out_named(DEVICE(&s_base->control), "fiq", n,
+            qdev_get_gpio_in(DEVICE(&s_base->cpu[n].core), ARM_CPU_FIQ));
 
         /* Connect timers from the CPU to the interrupt controller */
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_PHYS,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntpnsirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_VIRT,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntvirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_HYP,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cnthpirq", n));
-        qdev_connect_gpio_out(DEVICE(&s->cpu[n].core), GTIMER_SEC,
-                qdev_get_gpio_in_named(DEVICE(&s->control), "cntpsirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_PHYS,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntpnsirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_VIRT,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntvirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_HYP,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cnthpirq", n));
+        qdev_connect_gpio_out(DEVICE(&s_base->cpu[n].core), GTIMER_SEC,
+            qdev_get_gpio_in_named(DEVICE(&s_base->control), "cntpsirq", n));
     }
 }
 
-static void bcm283x_class_init(ObjectClass *oc, void *data)
+static void bcm283x_base_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
@@ -177,7 +185,7 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
 static void bcm2835_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("arm1176");
     bc->core_count = 1;
@@ -188,7 +196,7 @@ static void bcm2835_class_init(ObjectClass *oc, void *data)
 static void bcm2836_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a7");
     bc->core_count = BCM283X_NCPUS;
@@ -202,7 +210,7 @@ static void bcm2836_class_init(ObjectClass *oc, void *data)
 static void bcm2837_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
-    BCM283XClass *bc = BCM283X_CLASS(oc);
+    BCM283XBaseClass *bc = BCM283X_BASE_CLASS(oc);
 
     bc->cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
     bc->core_count = BCM283X_NCPUS;
@@ -230,11 +238,17 @@ static const TypeInfo bcm283x_types[] = {
 #endif
     }, {
         .name           = TYPE_BCM283X,
-        .parent         = TYPE_DEVICE,
+        .parent         = TYPE_BCM283X_BASE,
         .instance_size  = sizeof(BCM283XState),
-        .instance_init  = bcm2836_init,
-        .class_size     = sizeof(BCM283XClass),
-        .class_init     = bcm283x_class_init,
+        .instance_init  = bcm283x_init,
+        .abstract       = true,
+    }, {
+        .name           = TYPE_BCM283X_BASE,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(BCM283XBaseState),
+        .instance_init  = bcm283x_base_init,
+        .class_size     = sizeof(BCM283XBaseClass),
+        .class_init     = bcm283x_base_class_init,
         .abstract       = true,
     }
 };
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index cc4c4ec9bf..af866ebce2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -252,7 +252,7 @@ static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
         s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.cpu[0].core, machine, &s->binfo);
+    arm_load_kernel(&s->soc.parent_obj.cpu[0].core, machine, &s->binfo);
 }
 
 static void raspi_machine_init(MachineState *machine)
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 6f90cabfa3..5a6717ca91 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -17,8 +17,10 @@
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 
+#define TYPE_BCM283X_BASE "bcm283x-base"
+OBJECT_DECLARE_TYPE(BCM283XBaseState, BCM283XBaseClass, BCM283X_BASE)
 #define TYPE_BCM283X "bcm283x"
-OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
+OBJECT_DECLARE_SIMPLE_TYPE(BCM283XState, BCM283X)
 
 #define BCM283X_NCPUS 4
 
@@ -30,7 +32,7 @@ OBJECT_DECLARE_TYPE(BCM283XState, BCM283XClass, BCM283X)
 #define TYPE_BCM2836 "bcm2836"
 #define TYPE_BCM2837 "bcm2837"
 
-struct BCM283XState {
+struct BCM283XBaseState {
     /*< private >*/
     DeviceState parent_obj;
     /*< public >*/
@@ -41,7 +43,27 @@ struct BCM283XState {
         ARMCPU core;
     } cpu[BCM283X_NCPUS];
     BCM2836ControlState control;
+};
+
+struct BCM283XBaseClass {
+    /*< private >*/
+    DeviceClass parent_class;
+    /*< public >*/
+    const char *name;
+    const char *cpu_type;
+    unsigned core_count;
+    hwaddr peri_base; /* Peripheral base address seen by the CPU */
+    hwaddr ctrl_base; /* Interrupt controller and mailboxes etc. */
+    int clusterid;
+};
+
+struct BCM283XState {
+    /*< private >*/
+    BCM283XBaseState parent_obj;
+    /*< public >*/
     BCM2835PeripheralState peripherals;
 };
 
+bool bcm283x_common_realize(DeviceState *dev, Error **errp);
+
 #endif /* BCM2836_H */
-- 
2.34.1


