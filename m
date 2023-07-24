Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E5B75FDE7
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:38:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzUD-0005Cq-78; Mon, 24 Jul 2023 13:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qNzUA-0005Cc-Qy; Mon, 24 Jul 2023 13:36:42 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qNzU5-0002bL-11; Mon, 24 Jul 2023 13:36:42 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so3656738f8f.1; 
 Mon, 24 Jul 2023 10:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690220194; x=1690824994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5MMtZvYdpfbUBJ7IwpKMYpvEOwfd5+xAY6NktwQFOA=;
 b=IkxzZCiO62fkrpTffOmwEX5NdCWJg/EfGdOsOfK7d2CaCjeNMsk1XVaZaen9mqjljs
 ZCq9ZrO0R3jhYNAL1WcxJwh5fGsjNkmqrPmVWKxLyqdOC/QhmQZTzowRc3aBSIMvA4FL
 lIxmGNkJrpi5YNtktFNPpgTlCRJwcpo6LvJ9JhhbErCL2/2wgl2uD2CpOZbNW2dA7l2B
 rEJBQdhXAbPOsPRwQro+yYKgII5C1IHvr67LGk0Nzwv/93Y/PrFeboEPPdmF1ETji/Yh
 KdJgmZh1VDD6W1PY8pcJbWMZv3ke8E+1WEPtfkvnsWKc/40vp03hy0TwWEt+UBk4/HeQ
 rImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690220194; x=1690824994;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z5MMtZvYdpfbUBJ7IwpKMYpvEOwfd5+xAY6NktwQFOA=;
 b=kQAQ89i4Xz24BzNnK6889aoQeu36xoMSiENC0jJ6CAGlMhpBUQYP2lFM0eCtEGRjG6
 tqY/3EfqBGddNmuRq9zuGerDurTRb/lx9jtalJtjjKLYJAizalhBUPevQLvGqgGgfttV
 7y9OUnYLoAmYDp1qv9TPQc5nIxLchGRMT3ZKOFhBQC3dpQDM3hk68nVCNSHw5GZojRKd
 qLHPOlfiEgMf1cEIk5yXcjaUjNihUL2CR53dcCuaUQiR2kJPosMLawJYbmtXSZjCaNds
 qDQIiMWQFMO08X8YmU8kK4uTCx3bSNV23wI1ngtQuTDIGdpweFom8UuiZFelBIpd220w
 qKBw==
X-Gm-Message-State: ABy/qLZCc3yHef9KzE2oCdHeeWvrU2URM3cRSb3FeA7hZCTMGXFmbQlj
 ZPo1KbOebOkyhRYxNIPwZKMaYRF1HHI=
X-Google-Smtp-Source: APBJJlHgEKI+gQfs2xhnys1bdkj/6oz3NcQOq0kLHpRNWGB+JaLy9lXgWoOeUnO6Gi08eBkIjKUr0Q==
X-Received: by 2002:a5d:6b84:0:b0:317:6570:afec with SMTP id
 n4-20020a5d6b84000000b003176570afecmr1305600wrx.3.1690220192973; 
 Mon, 24 Jul 2023 10:36:32 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 q6-20020adff506000000b003141e629cb6sm13629551wro.101.2023.07.24.10.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 10:36:32 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 01/44] Split out common part of BCM283X classes
Date: Mon, 24 Jul 2023 20:36:28 +0300
Message-Id: <20230724173628.1726845-1-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=serg.oker@gmail.com; helo=mail-wr1-x42a.google.com
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

Introduce Raspberry Pi 4B machine.
It contains new BCM2838 SoC, PCIE subsystem,
RNG200, Thermal sensor and Genet network controller.

It can work with recent linux kernels 6.x.x.
Two avocado tests was added to check that.

Unit tests has been made as read/write operations
via mailbox properties.

Genet integration test is under development.

Every single commit
1) builds without errors
2) passes regression tests
3) passes style check*
*the only exception is bcm2838-mbox-property-test.c file
containing heavy macros usage which cause a lot of
false-positives of checkpatch.pl.

I did my best to keep the commits less than 200 changes,
but had to make some of them a bit more in order to
keep their integrity.
 

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


From 522cc9f95b7640f573470750522f7795048f492e Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 02/44] Split out common part of peripherals

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2835_peripherals.c         | 198 +++++++++++++++------------
 hw/arm/bcm2836.c                     |  24 ++--
 include/hw/arm/bcm2835_peripherals.h |  29 +++-
 include/hw/arm/bcm2836.h             |   3 +-
 4 files changed, 154 insertions(+), 100 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 0233038b95..4c0c0b1e7d 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -30,9 +30,9 @@
 #define SEPARATE_DMA_IRQ_MAX 10
 #define ORGATED_DMA_IRQ_COUNT 4
 
-static void create_unimp(BCM2835PeripheralState *ps,
-                         UnimplementedDeviceState *uds,
-                         const char *name, hwaddr ofs, hwaddr size)
+void create_unimp(RaspiPeripheralBaseState *ps,
+                  UnimplementedDeviceState *uds,
+                  const char *name, hwaddr ofs, hwaddr size)
 {
     object_initialize_child(OBJECT(ps), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
@@ -45,9 +45,36 @@ static void create_unimp(BCM2835PeripheralState *ps,
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
+    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(obj);
+
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng", &s->rng, TYPE_BCM2835_RNG);
+
+    /* Thermal */
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2835_THERMAL);
+
+    /* GPIO */
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2835_GPIO);
+
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
+                                   OBJECT(&s_base->sdhci.sdbus));
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
+                                   OBJECT(&s_base->sdhost.sdbus));
+
+    /* Gated DMA interrupts */
+    object_initialize_child(obj, "orgated-dma-irq",
+                            &s_base->orgated_dma_irq, TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s_base->orgated_dma_irq), "num-lines",
+                            ORGATED_DMA_IRQ_COUNT, &error_abort);
+}
+
+static void raspi_peripherals_base_init(Object *obj)
+{
+    RaspiPeripheralBaseState *s = RASPI_PERIPHERALS_BASE(obj);
+    RaspiPeripheralBaseClass *bc = RASPI_PERIPHERALS_BASE_GET_CLASS(obj);
 
     /* Memory region for peripheral devices, which we export to our parent */
-    memory_region_init(&s->peri_mr, obj,"bcm2835-peripherals", 0x1000000);
+    memory_region_init(&s->peri_mr, obj, "bcm2835-peripherals", bc->peri_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_mr);
 
     /* Internal memory region for peripheral bus addresses (not exported) */
@@ -98,9 +125,6 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_const_link(OBJECT(&s->property), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
-    /* Random Number Generator */
-    object_initialize_child(obj, "rng", &s->rng, TYPE_BCM2835_RNG);
-
     /* Extended Mass Media Controller */
     object_initialize_child(obj, "sdhci", &s->sdhci, TYPE_SYSBUS_SDHCI);
 
@@ -110,25 +134,9 @@ static void bcm2835_peripherals_init(Object *obj)
     /* DMA Channels */
     object_initialize_child(obj, "dma", &s->dma, TYPE_BCM2835_DMA);
 
-    object_initialize_child(obj, "orgated-dma-irq",
-                            &s->orgated_dma_irq, TYPE_OR_IRQ);
-    object_property_set_int(OBJECT(&s->orgated_dma_irq), "num-lines",
-                            ORGATED_DMA_IRQ_COUNT, &error_abort);
-
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
 
-    /* Thermal */
-    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2835_THERMAL);
-
-    /* GPIO */
-    object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2835_GPIO);
-
-    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
-                                   OBJECT(&s->sdhci.sdbus));
-    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
-                                   OBJECT(&s->sdhost.sdbus));
-
     /* Mphi */
     object_initialize_child(obj, "mphi", &s->mphi, TYPE_BCM2835_MPHI);
 
@@ -148,7 +156,72 @@ static void bcm2835_peripherals_init(Object *obj)
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 {
+    MemoryRegion *mphi_mr;
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(dev);
+    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(dev);
+    int n;
+
+    raspi_peripherals_common_realize(dev, errp);
+
+    /* Extended Mass Media Controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->sdhci), 0,
+        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_ARASANSDIO));
+
+     /* Connect DMA 0-12 to the interrupt controller */
+    for (n = 0; n <= SEPARATE_DMA_IRQ_MAX; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), n,
+                           qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                  BCM2835_IC_GPU_IRQ,
+                                                  INTERRUPT_DMA0 + n));
+    }
+
+    if (!qdev_realize(DEVICE(&s_base->orgated_dma_irq), NULL, errp)) {
+        return;
+    }
+    for (n = 0; n < ORGATED_DMA_IRQ_COUNT; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma),
+                           SEPARATE_DMA_IRQ_MAX + 1 + n,
+                           qdev_get_gpio_in(DEVICE(&s_base->orgated_dma_irq), n));
+    }
+    qdev_connect_gpio_out(DEVICE(&s_base->orgated_dma_irq), 0,
+                          qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                              BCM2835_IC_GPU_IRQ,
+                              INTERRUPT_DMA0 + SEPARATE_DMA_IRQ_MAX + 1));
+
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, RNG_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
+
+    /* THERMAL */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
+        return;
+    }
+    memory_region_add_subregion(&s_base->peri_mr, THERMAL_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
+
+    /* Map MPHI to the peripherals memory map */
+    mphi_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s_base->mphi), 0);
+    memory_region_add_subregion(&s_base->peri_mr, MPHI_OFFSET, mphi_mr);
+
+    /* GPIO */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, GPIO_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
+}
+
+void raspi_peripherals_common_realize(DeviceState *dev, Error **errp)
+{
+    RaspiPeripheralBaseState *s = RASPI_PERIPHERALS_BASE(dev);
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
@@ -281,14 +354,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->property), 0,
                       qdev_get_gpio_in(DEVICE(&s->mboxes), MBOX_CHAN_PROPERTY));
 
-    /* Random Number Generator */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng), errp)) {
-        return;
-    }
-
-    memory_region_add_subregion(&s->peri_mr, RNG_OFFSET,
-                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng), 0));
-
     /* Extended Mass Media Controller
      *
      * Compatible with:
@@ -311,9 +376,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), errp)) {
@@ -336,49 +398,11 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(&s->peri_mr, DMA15_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->dma), 1));
 
-    for (n = 0; n <= SEPARATE_DMA_IRQ_MAX; n++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma), n,
-                           qdev_get_gpio_in_named(DEVICE(&s->ic),
-                                                  BCM2835_IC_GPU_IRQ,
-                                                  INTERRUPT_DMA0 + n));
-    }
-    if (!qdev_realize(DEVICE(&s->orgated_dma_irq), NULL, errp)) {
-        return;
-    }
-    for (n = 0; n < ORGATED_DMA_IRQ_COUNT; n++) {
-        sysbus_connect_irq(SYS_BUS_DEVICE(&s->dma),
-                           SEPARATE_DMA_IRQ_MAX + 1 + n,
-                           qdev_get_gpio_in(DEVICE(&s->orgated_dma_irq), n));
-    }
-    qdev_connect_gpio_out(DEVICE(&s->orgated_dma_irq), 0,
-                          qdev_get_gpio_in_named(DEVICE(&s->ic),
-                              BCM2835_IC_GPU_IRQ,
-                              INTERRUPT_DMA0 + SEPARATE_DMA_IRQ_MAX + 1));
-
-    /* THERMAL */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
-        return;
-    }
-    memory_region_add_subregion(&s->peri_mr, THERMAL_OFFSET,
-                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
-
-    /* GPIO */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
-        return;
-    }
-
-    memory_region_add_subregion(&s->peri_mr, GPIO_OFFSET,
-                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
-
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
-
     /* Mphi */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->mphi), errp)) {
         return;
     }
 
-    memory_region_add_subregion(&s->peri_mr, MPHI_OFFSET,
-                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mphi), 0));
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->mphi), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_HOSTPORT));
@@ -421,21 +445,27 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    RaspiPeripheralBaseClass *bc = RASPI_PERIPHERALS_BASE_CLASS(oc);
 
+    bc->peri_size = 0x1000000;
     dc->realize = bcm2835_peripherals_realize;
 }
 
-static const TypeInfo bcm2835_peripherals_type_info = {
-    .name = TYPE_BCM2835_PERIPHERALS,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(BCM2835PeripheralState),
-    .instance_init = bcm2835_peripherals_init,
-    .class_init = bcm2835_peripherals_class_init,
+static const TypeInfo bcm2835_peripherals_types[] = {
+    {
+        .name = TYPE_BCM2835_PERIPHERALS,
+        .parent = TYPE_RASPI_PERIPHERALS_BASE,
+        .instance_size = sizeof(BCM2835PeripheralState),
+        .instance_init = bcm2835_peripherals_init,
+        .class_init = bcm2835_peripherals_class_init,
+    }, {
+        .name = TYPE_RASPI_PERIPHERALS_BASE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(RaspiPeripheralBaseState),
+        .instance_init = raspi_peripherals_base_init,
+        .class_size = sizeof(RaspiPeripheralBaseClass),
+        .abstract = true,
+    }
 };
 
-static void bcm2835_peripherals_register_types(void)
-{
-    type_register_static(&bcm2835_peripherals_type_info);
-}
-
-type_init(bcm2835_peripherals_register_types)
+DEFINE_TYPES(bcm2835_peripherals_types)
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 66a2b57b38..8beafb97f0 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -66,10 +66,10 @@ static void bcm283x_init(Object *obj)
                               "vcram-size");
 }
 
-bool bcm283x_common_realize(DeviceState *dev, Error **errp)
+bool bcm283x_common_realize(DeviceState *dev, RaspiPeripheralBaseState *ps,
+                            Error **errp)
 {
-    BCM283XState *s = BCM283X(dev);
-    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseState *s = BCM283X_BASE(dev);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
@@ -77,17 +77,15 @@ bool bcm283x_common_realize(DeviceState *dev, Error **errp)
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
 
-    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj);
+    object_property_add_const_link(OBJECT(ps), "ram", obj);
 
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->peripherals), errp)) {
+    if (!sysbus_realize(SYS_BUS_DEVICE(ps), errp)) {
         return false;
     }
 
-    object_property_add_alias(OBJECT(s_base), "sd-bus",
-                              OBJECT(&s->peripherals), "sd-bus");
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(ps), "sd-bus");
 
-    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals),
-                            0, bc->peri_base, 1);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(ps), 0, bc->peri_base, 1);
     return true;
 }
 
@@ -95,8 +93,10 @@ static void bcm2835_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    RaspiPeripheralBaseState *ps_base
+        = RASPI_PERIPHERALS_BASE(&s->peripherals);
 
-    if (!bcm283x_common_realize(dev, errp)) {
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
         return;
     }
 
@@ -117,8 +117,10 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XState *s = BCM283X(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
+    RaspiPeripheralBaseState *ps_base
+        = RASPI_PERIPHERALS_BASE(&s->peripherals);
 
-    if (!bcm283x_common_realize(dev, errp)) {
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
         return;
     }
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index d724a2fc28..dec61e2fd8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -34,10 +34,13 @@
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
+#define TYPE_RASPI_PERIPHERALS_BASE "raspi-peripherals-base"
+OBJECT_DECLARE_TYPE(RaspiPeripheralBaseState, RaspiPeripheralBaseClass,
+                    RASPI_PERIPHERALS_BASE)
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835PeripheralState, BCM2835_PERIPHERALS)
 
-struct BCM2835PeripheralState {
+struct RaspiPeripheralBaseState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
@@ -59,12 +62,9 @@ struct BCM2835PeripheralState {
     OrIRQState orgated_dma_irq;
     BCM2835ICState ic;
     BCM2835PropertyState property;
-    BCM2835RngState rng;
     BCM2835MboxState mboxes;
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
-    BCM2835GpioState gpio;
-    Bcm2835ThermalState thermal;
     UnimplementedDeviceState i2s;
     UnimplementedDeviceState spi[1];
     UnimplementedDeviceState i2c[3];
@@ -78,4 +78,25 @@ struct BCM2835PeripheralState {
     UnimplementedDeviceState sdramc;
 };
 
+struct RaspiPeripheralBaseClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+    uint64_t peri_size; /* Peripheral range size */
+};
+
+struct BCM2835PeripheralState {
+    /*< private >*/
+    RaspiPeripheralBaseState parent_obj;
+    /*< public >*/
+    BCM2835RngState rng;
+    Bcm2835ThermalState thermal;
+    BCM2835GpioState gpio;
+};
+
+void create_unimp(RaspiPeripheralBaseState *ps,
+                  UnimplementedDeviceState *uds,
+                  const char *name, hwaddr ofs, hwaddr size);
+void raspi_peripherals_common_realize(DeviceState *dev, Error **errp);
+
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 5a6717ca91..67bab7f3df 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -64,6 +64,7 @@ struct BCM283XState {
     BCM2835PeripheralState peripherals;
 };
 
-bool bcm283x_common_realize(DeviceState *dev, Error **errp);
+bool bcm283x_common_realize(DeviceState *dev, RaspiPeripheralBaseState *ps,
+                            Error **errp);
 
 #endif /* BCM2836_H */
-- 
2.34.1


From ac8bfdf5459fdf429bee454ef64d057acc186723 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 03/44] Split out raspi machine common part

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/raspi.c                  | 112 ++++++++++++++++++--------------
 include/hw/arm/raspi_platform.h |  21 ++++++
 2 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index af866ebce2..7d04734cd2 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
@@ -25,6 +26,9 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 
+#define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
+OBJECT_DECLARE_SIMPLE_TYPE(RaspiMachineState, RASPI_MACHINE)
+
 #define SMPBOOT_ADDR    0x300 /* this should leave enough space for ATAGS */
 #define MVBAR_ADDR      0x400 /* secure vectors */
 #define BOARDSETUP_ADDR (MVBAR_ADDR + 0x20) /* board setup code */
@@ -37,25 +41,10 @@
 
 struct RaspiMachineState {
     /*< private >*/
-    MachineState parent_obj;
+    RaspiBaseMachineState parent_obj;
     /*< public >*/
     BCM283XState soc;
-    struct arm_boot_info binfo;
-};
-typedef struct RaspiMachineState RaspiMachineState;
-
-struct RaspiMachineClass {
-    /*< private >*/
-    MachineClass parent_obj;
-    /*< public >*/
-    uint32_t board_rev;
 };
-typedef struct RaspiMachineClass RaspiMachineClass;
-
-#define TYPE_RASPI_MACHINE       MACHINE_TYPE_NAME("raspi-common")
-DECLARE_OBJ_CHECKERS(RaspiMachineState, RaspiMachineClass,
-                     RASPI_MACHINE, TYPE_RASPI_MACHINE)
-
 
 /*
  * Board revision codes:
@@ -83,6 +72,11 @@ static const struct {
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
 };
 
+static void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc);
+static void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev);
+
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -200,13 +194,12 @@ static void reset_secondary(ARMCPU *cpu, const struct arm_boot_info *info)
     cpu_set_pc(cs, info->smp_loader_start);
 }
 
-static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
-                       size_t ram_size)
+static void setup_boot(MachineState *machine, ARMCPU *cpu,
+                       RaspiProcessorId processor_id, size_t ram_size)
 {
-    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineState *s = RASPI_BASE_MACHINE(machine);
     int r;
 
-    s->binfo.board_id = MACH_TYPE_BCM2708;
     s->binfo.ram_size = ram_size;
 
     if (processor_id <= PROCESSOR_ID_BCM2836) {
@@ -252,13 +245,13 @@ static void setup_boot(MachineState *machine, RaspiProcessorId processor_id,
         s->binfo.firmware_loaded = true;
     }
 
-    arm_load_kernel(&s->soc.parent_obj.cpu[0].core, machine, &s->binfo);
+    arm_load_kernel(cpu, machine, &s->binfo);
 }
 
-static void raspi_machine_init(MachineState *machine)
+static void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc)
 {
-    RaspiMachineClass *mc = RASPI_MACHINE_GET_CLASS(machine);
-    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
     uint32_t vcram_size;
@@ -279,19 +272,17 @@ static void raspi_machine_init(MachineState *machine)
                                         machine->ram, 0);
 
     /* Setup the SOC */
-    object_initialize_child(OBJECT(machine), "soc", &s->soc,
-                            board_soc_type(board_rev));
-    object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(machine->ram));
-    object_property_set_int(OBJECT(&s->soc), "board-rev", board_rev,
+    object_property_add_const_link(OBJECT(soc), "ram", OBJECT(machine->ram));
+    object_property_set_int(OBJECT(soc), "board-rev", board_rev,
                             &error_abort);
-    object_property_set_str(OBJECT(&s->soc), "command-line",
+    object_property_set_str(OBJECT(soc), "command-line",
                             machine->kernel_cmdline, &error_abort);
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    qdev_realize(DEVICE(soc), NULL, &error_fatal);
 
     /* Create and plug in the SD cards */
     di = drive_get(IF_SD, 0, 0);
     blk = di ? blk_by_legacy_dinfo(di) : NULL;
-    bus = qdev_get_child_bus(DEVICE(&s->soc), "sd-bus");
+    bus = qdev_get_child_bus(DEVICE(soc), "sd-bus");
     if (bus == NULL) {
         error_report("No SD bus found in SOC object");
         exit(1);
@@ -300,19 +291,32 @@ static void raspi_machine_init(MachineState *machine)
     qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
     qdev_realize_and_unref(carddev, bus, &error_fatal);
 
-    vcram_size = object_property_get_uint(OBJECT(&s->soc), "vcram-size",
+    vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
-    setup_boot(machine, board_processor_id(mc->board_rev),
+    setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
                machine->ram_size - vcram_size);
 }
 
-static void raspi_machine_class_common_init(MachineClass *mc,
-                                            uint32_t board_rev)
+static void raspi_machine_init(MachineState *machine)
+{
+    RaspiMachineState *s = RASPI_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM283XState *soc = &s->soc;
+
+    s_base->binfo.board_id = MACH_TYPE_BCM2708;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev)
 {
     mc->desc = g_strdup_printf("Raspberry Pi %s (revision 1.%u)",
                                board_type(board_rev),
                                FIELD_EX32(board_rev, REV_CODE, REVISION));
-    mc->init = raspi_machine_init;
     mc->block_default_type = IF_SD;
     mc->no_parallel = 1;
     mc->no_floppy = 1;
@@ -322,50 +326,57 @@ static void raspi_machine_class_common_init(MachineClass *mc,
     mc->default_ram_id = "ram";
 };
 
+static void raspi_machine_class_init(MachineClass *mc,
+                                     uint32_t board_rev)
+{
+    raspi_machine_class_common_init(mc, board_rev);
+    mc->init = raspi_machine_init;
+};
+
 static void raspi0_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x920092; /* Revision 1.2 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi1ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x900021; /* Revision 1.1 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi2b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0xa21041;
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 #ifdef TARGET_AARCH64
 static void raspi3ap_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0x9020e0; /* Revision 1.0 */
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 
 static void raspi3b_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-    RaspiMachineClass *rmc = RASPI_MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
 
     rmc->board_rev = 0xa02082;
-    raspi_machine_class_common_init(mc, rmc->board_rev);
+    raspi_machine_class_init(mc, rmc->board_rev);
 };
 #endif /* TARGET_AARCH64 */
 
@@ -394,9 +405,14 @@ static const TypeInfo raspi_machine_types[] = {
 #endif
     }, {
         .name           = TYPE_RASPI_MACHINE,
-        .parent         = TYPE_MACHINE,
+        .parent         = TYPE_RASPI_BASE_MACHINE,
         .instance_size  = sizeof(RaspiMachineState),
-        .class_size     = sizeof(RaspiMachineClass),
+        .abstract       = true,
+    }, {
+        .name           = TYPE_RASPI_BASE_MACHINE,
+        .parent         = TYPE_MACHINE,
+        .instance_size  = sizeof(RaspiBaseMachineState),
+        .class_size     = sizeof(RaspiBaseMachineClass),
         .abstract       = true,
     }
 };
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index ede98e63c3..3018e8fcf3 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -28,6 +28,27 @@
 #ifndef HW_ARM_RASPI_PLATFORM_H
 #define HW_ARM_RASPI_PLATFORM_H
 
+#include "hw/boards.h"
+#include "hw/arm/boot.h"
+
+#define TYPE_RASPI_BASE_MACHINE MACHINE_TYPE_NAME("raspi-base")
+OBJECT_DECLARE_TYPE(RaspiBaseMachineState, RaspiBaseMachineClass,
+                    RASPI_BASE_MACHINE)
+
+struct RaspiBaseMachineState {
+    /*< private >*/
+    MachineState parent_obj;
+    /*< public >*/
+    struct arm_boot_info binfo;
+};
+
+struct RaspiBaseMachineClass {
+    /*< private >*/
+    MachineClass parent_obj;
+    /*< public >*/
+    uint32_t board_rev;
+};
+
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
 #define INTE_OFFSET             0x2000   /* VC Interrupt controller */
-- 
2.34.1


From 6966e09b156d3c8d5610f639e47736505c88fcb2 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 04/44] Introduce BCM2838 SoC

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     | 110 +++++++++++++++++++++++++++
 hw/arm/bcm2838_peripherals.c         |  72 ++++++++++++++++++
 hw/arm/meson.build                   |   2 +
 include/hw/arm/bcm2838.h             |  26 +++++++
 include/hw/arm/bcm2838_peripherals.h |  36 +++++++++
 5 files changed, 246 insertions(+)
 create mode 100644 hw/arm/bcm2838.c
 create mode 100644 hw/arm/bcm2838_peripherals.c
 create mode 100644 include/hw/arm/bcm2838.h
 create mode 100644 include/hw/arm/bcm2838_peripherals.h

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
new file mode 100644
index 0000000000..dd650c8148
--- /dev/null
+++ b/hw/arm/bcm2838.c
@@ -0,0 +1,110 @@
+/*
+ * BCM2838 SoC emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/sysbus.h"
+#include "hw/arm/bcm2838.h"
+#include "trace.h"
+
+struct BCM2838Class {
+    /*< private >*/
+    BCM283XBaseClass parent_class;
+    /*< public >*/
+    hwaddr peri_low_base; /* Lower peripheral base address seen by the CPU */
+    hwaddr gic_base; /* GIC base address inside ARM local peripherals region */
+};
+
+#define VIRTUAL_PMU_IRQ 7
+
+static void bcm2838_init(Object *obj)
+{
+    BCM2838State *s = BCM2838(obj);
+
+    object_initialize_child(obj, "peripherals", &s->peripherals,
+                            TYPE_BCM2838_PERIPHERALS);
+    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
+                              "board-rev");
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
+                              "vcram-size");
+    object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
+                              "command-line");
+}
+
+static void bcm2838_realize(DeviceState *dev, Error **errp)
+{
+    int n;
+    BCM2838State *s = BCM2838(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM2838Class *bc = BCM2838_GET_CLASS(dev);
+    BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
+    BCM2838PeripheralState *ps = BCM2838_PERIPHERALS(&s->peripherals);
+    RaspiPeripheralBaseState *ps_base = RASPI_PERIPHERALS_BASE(&s->peripherals);
+
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
+        return;
+    }
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(ps), 1, bc->peri_low_base, 1);
+
+    /* bcm2836 interrupt controller (and mailboxes, etc.) */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s_base->control), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc_base->ctrl_base);
+
+    /* Create cores */
+    for (n = 0; n < bc_base->core_count; n++) {
+        /* TODO: this should be converted to a property of ARM_CPU */
+        s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;
+
+        /* start powered off if not enabled */
+        if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
+                                      "start-powered-off",
+                                      n >= s_base->enabled_cpus,
+                                      errp)) {
+            return;
+        }
+
+        if (!qdev_realize(DEVICE(&s_base->cpu[n].core), NULL, errp)) {
+            return;
+        }
+    }
+}
+
+static void bcm2838_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM2838Class *bc = BCM2838_CLASS(oc);
+    BCM283XBaseClass *bc_base = BCM283X_BASE_CLASS(oc);
+
+    bc_base->cpu_type = ARM_CPU_TYPE_NAME("cortex-a72");
+    bc_base->core_count = BCM283X_NCPUS;
+    bc_base->peri_base = 0xfe000000;
+    bc_base->ctrl_base = 0xff800000;
+    bc_base->clusterid = 0x0;
+    bc->peri_low_base = 0xfc000000;
+    dc->realize = bcm2838_realize;
+}
+
+static const TypeInfo bcm2838_type = {
+    .name           = TYPE_BCM2838,
+    .parent         = TYPE_BCM283X_BASE,
+    .instance_size  = sizeof(BCM2838State),
+    .instance_init  = bcm2838_init,
+    .class_size     = sizeof(BCM2838Class),
+    .class_init     = bcm2838_class_init,
+};
+
+static void bcm2838_register_types(void)
+{
+    type_register_static(&bcm2838_type);
+}
+
+type_init(bcm2838_register_types);
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
new file mode 100644
index 0000000000..864941c231
--- /dev/null
+++ b/hw/arm/bcm2838_peripherals.c
@@ -0,0 +1,72 @@
+/*
+ * BCM2838 peripherals emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/arm/bcm2838_peripherals.h"
+
+/* Lower peripheral base address on the VC (GPU) system bus */
+#define BCM2838_VC_PERI_LOW_BASE 0x7c000000
+
+static void bcm2838_peripherals_init(Object *obj)
+{
+    BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
+    BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
+
+    /* Lower memory region for peripheral devices (exported to the Soc) */
+    memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
+                       bc->peri_low_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
+
+}
+
+static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
+    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(dev);
+
+    raspi_peripherals_common_realize(dev, errp);
+
+    /* Map lower peripherals into the GPU address space */
+    memory_region_init_alias(&s->peri_low_mr_alias, OBJECT(s),
+                             "bcm2838-peripherals", &s->peri_low_mr, 0,
+                             memory_region_size(&s->peri_low_mr));
+    memory_region_add_subregion_overlap(&s_base->gpu_bus_mr,
+                                        BCM2838_VC_PERI_LOW_BASE,
+                                        &s->peri_low_mr_alias, 1);
+
+}
+
+static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_CLASS(oc);
+    RaspiPeripheralBaseClass *bc_base = RASPI_PERIPHERALS_BASE_CLASS(oc);
+
+    bc->peri_low_size = 0x2000000;
+    bc_base->peri_size = 0x1800000;
+    dc->realize = bcm2838_peripherals_realize;
+}
+
+static const TypeInfo bcm2838_peripherals_type_info = {
+    .name = TYPE_BCM2838_PERIPHERALS,
+    .parent = TYPE_RASPI_PERIPHERALS_BASE,
+    .instance_size = sizeof(BCM2838PeripheralState),
+    .instance_init = bcm2838_peripherals_init,
+    .class_size = sizeof(BCM2838PeripheralClass),
+    .class_init = bcm2838_peripherals_class_init,
+};
+
+static void bcm2838_peripherals_register_types(void)
+{
+    type_register_static(&bcm2838_peripherals_type_info);
+}
+
+type_init(bcm2838_peripherals_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 11eb9112f8..071819b527 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,6 +39,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
@@ -69,6 +70,7 @@ arm_ss.add_all(xen_ss)
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/include/hw/arm/bcm2838.h b/include/hw/arm/bcm2838.h
new file mode 100644
index 0000000000..6e5a8ec30e
--- /dev/null
+++ b/include/hw/arm/bcm2838.h
@@ -0,0 +1,26 @@
+/*
+ * BCM2838 SoC emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_H
+#define BCM2838_H
+
+#include "hw/arm/bcm2836.h"
+#include "hw/arm/bcm2838_peripherals.h"
+
+#define TYPE_BCM2838 "bcm2838"
+
+OBJECT_DECLARE_TYPE(BCM2838State, BCM2838Class, BCM2838)
+
+struct BCM2838State {
+    /*< private >*/
+    BCM283XBaseState parent_obj;
+    /*< public >*/
+    BCM2838PeripheralState peripherals;
+};
+
+#endif /* BCM2838_H */
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
new file mode 100644
index 0000000000..8214003baf
--- /dev/null
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -0,0 +1,36 @@
+/*
+ * BCM2838 peripherals emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_PERIPHERALS_H
+#define BCM2838_PERIPHERALS_H
+
+#include "hw/arm/bcm2835_peripherals.h"
+
+
+#define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
+OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
+                    BCM2838_PERIPHERALS)
+
+struct BCM2838PeripheralState {
+    /*< private >*/
+    RaspiPeripheralBaseState parent_obj;
+
+    /*< public >*/
+    MemoryRegion peri_low_mr;
+    MemoryRegion peri_low_mr_alias;
+    MemoryRegion mphi_mr_alias;
+};
+
+struct BCM2838PeripheralClass {
+    /*< private >*/
+    RaspiPeripheralBaseClass parent_class;
+    /*< public >*/
+    uint64_t peri_low_size; /* Peripheral lower range size */
+};
+
+#endif /* BCM2838_PERIPHERALS_H */
-- 
2.34.1


From c6cc954233f89136ba7ca5f47a6dd802948befe8 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 05/44] Add GIC-400 to BCM2838 SoC

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     | 167 +++++++++++++++++++++++++++
 hw/arm/trace-events                  |   2 +
 include/hw/arm/bcm2838.h             |   2 +
 include/hw/arm/bcm2838_peripherals.h |  39 +++++++
 4 files changed, 210 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index dd650c8148..c687f38a39 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -22,8 +22,36 @@ struct BCM2838Class {
     hwaddr gic_base; /* GIC base address inside ARM local peripherals region */
 };
 
+#define GIC400_MAINTAINANCE_IRQ      9
+#define GIC400_TIMER_NS_EL2_IRQ     10
+#define GIC400_TIMER_VIRT_IRQ       11
+#define GIC400_LEGACY_FIQ           12
+#define GIC400_TIMER_S_EL1_IRQ      13
+#define GIC400_TIMER_NS_EL1_IRQ     14
+#define GIC400_LEGACY_IRQ           15
+
+/* Number of external interrupt lines to configure the GIC with */
+#define GIC_NUM_IRQS                192
+
+#define PPI(cpu, irq) (GIC_NUM_IRQS + (cpu) * GIC_INTERNAL + GIC_NR_SGIS + irq)
+
+#define GIC_BASE_OFS                0x0000
+#define GIC_DIST_OFS                0x1000
+#define GIC_CPU_OFS                 0x2000
+#define GIC_VIFACE_THIS_OFS         0x4000
+#define GIC_VIFACE_OTHER_OFS(cpu)  (0x5000 + (cpu) * 0x200)
+#define GIC_VCPU_OFS                0x6000
+
 #define VIRTUAL_PMU_IRQ 7
 
+static void bcm2838_gic_set_irq(void *opaque, int irq, int level)
+{
+    BCM2838State *s = (BCM2838State *)opaque;
+
+    trace_bcm2838_gic_set_irq(irq, level);
+    qemu_set_irq(qdev_get_gpio_in(DEVICE(&s->gic), irq), level);
+}
+
 static void bcm2838_init(Object *obj)
 {
     BCM2838State *s = BCM2838(obj);
@@ -36,11 +64,14 @@ static void bcm2838_init(Object *obj)
                               "vcram-size");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
+
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
 }
 
 static void bcm2838_realize(DeviceState *dev, Error **errp)
 {
     int n;
+    int int_n;
     BCM2838State *s = BCM2838(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
     BCM2838Class *bc = BCM2838_GET_CLASS(dev);
@@ -64,6 +95,12 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
         /* TODO: this should be converted to a property of ARM_CPU */
         s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;
 
+        /* set periphbase/CBAR value for CPU-local registers */
+        if (!object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
+                                     bc_base->ctrl_base + bc->gic_base, errp)) {
+            return;
+        }
+
         /* start powered off if not enabled */
         if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
                                       "start-powered-off",
@@ -76,6 +113,135 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
             return;
         }
     }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "revision", 2, errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "num-cpu", BCM283X_NCPUS,
+                                  errp)) {
+        return;
+    }
+
+    if (!object_property_set_uint(OBJECT(&s->gic), "num-irq",
+                                  GIC_NUM_IRQS + GIC_INTERNAL, errp)) {
+        return;
+    }
+
+    if (!object_property_set_bool(OBJECT(&s->gic),
+                                  "has-virtualization-extensions", true,
+                                  errp)) {
+        return;
+    }
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
+        return;
+    }
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0,
+                    bc_base->ctrl_base + bc->gic_base + GIC_DIST_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                    bc_base->ctrl_base + bc->gic_base + GIC_CPU_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                    bc_base->ctrl_base + bc->gic_base + GIC_VIFACE_THIS_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                    bc_base->ctrl_base + bc->gic_base + GIC_VCPU_OFS);
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
+                        bc_base->ctrl_base + bc->gic_base
+                            + GIC_VIFACE_OTHER_OFS(n));
+    }
+
+    DeviceState *gicdev = DEVICE(&s->gic);
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        DeviceState *cpudev = DEVICE(&s_base->cpu[n]);
+
+        /* Connect the GICv2 outputs to the CPU */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 2 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 3 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), n + 4 * BCM283X_NCPUS,
+                           qdev_get_gpio_in(gicdev,
+                                            PPI(n, GIC400_MAINTAINANCE_IRQ)));
+
+        /* Connect timers from the CPU to the interrupt controller */
+        qdev_connect_gpio_out(cpudev, GTIMER_PHYS,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL1_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_VIRT,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_VIRT_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_HYP,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_NS_EL2_IRQ)));
+        qdev_connect_gpio_out(cpudev, GTIMER_SEC,
+                    qdev_get_gpio_in(gicdev, PPI(n, GIC400_TIMER_S_EL1_IRQ)));
+        /* PMU interrupt */
+        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                    qdev_get_gpio_in(gicdev, PPI(n, VIRTUAL_PMU_IRQ)));
+    }
+
+    /* Connect UART0 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->uart0), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_UART0));
+
+    /* Connect AUX / UART1 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->aux), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_AUX_UART1));
+
+    /* Connect VC mailbox to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mboxes), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MBOX));
+
+    /* Connect SD host to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->sdhost), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_SDHOST));
+
+    /* According to DTS, EMMC and EMMC2 share one irq */
+    DeviceState *mmc_irq_orgate = DEVICE(&ps->mmc_irq_orgate);
+
+    /* Connect EMMC and EMMC2 to the interrupt controller */
+    qdev_connect_gpio_out(mmc_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_EMMC_EMMC2));
+
+    /* Connect USB OTG and MPHI to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->mphi), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_MPHI));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
+
+    /* Connect DMA 0-6 to the interrupt controller */
+    for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
+         int_n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dma),
+                           int_n - GIC_SPI_INTERRUPT_DMA_0,
+                           qdev_get_gpio_in(gicdev, int_n));
+    }
+
+    /* According to DTS, DMA 7 and 8 share one irq */
+    DeviceState *dma_7_8_irq_orgate = DEVICE(&ps->dma_7_8_irq_orgate);
+
+    /* Connect DMA 7-8 to the interrupt controller */
+    qdev_connect_gpio_out(dma_7_8_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_7_8));
+
+    /* According to DTS, DMA 9 and 10 share one irq */
+    DeviceState *dma_9_10_irq_orgate = DEVICE(&ps->dma_9_10_irq_orgate);
+
+    /* Connect DMA 9-10 to the interrupt controller */
+    qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
+                          qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
+
+    /* Pass through inbound GPIO lines to the GIC */
+    qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
+
+    /* Pass through outbound IRQ lines from the GIC */
+    qdev_pass_gpios(DEVICE(&s->gic), DEVICE(&s->peripherals), NULL);
 }
 
 static void bcm2838_class_init(ObjectClass *oc, void *data)
@@ -90,6 +256,7 @@ static void bcm2838_class_init(ObjectClass *oc, void *data)
     bc_base->ctrl_base = 0xff800000;
     bc_base->clusterid = 0x0;
     bc->peri_low_base = 0xfc000000;
+    bc->gic_base = 0x40000;
     dc->realize = bcm2838_realize;
 }
 
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cdc1ea06a8..4f0167e638 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,3 +55,5 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# bcm2838.c
+bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
diff --git a/include/hw/arm/bcm2838.h b/include/hw/arm/bcm2838.h
index 6e5a8ec30e..a0d67ac85a 100644
--- a/include/hw/arm/bcm2838.h
+++ b/include/hw/arm/bcm2838.h
@@ -10,6 +10,7 @@
 #define BCM2838_H
 
 #include "hw/arm/bcm2836.h"
+#include "hw/intc/arm_gic.h"
 #include "hw/arm/bcm2838_peripherals.h"
 
 #define TYPE_BCM2838 "bcm2838"
@@ -21,6 +22,7 @@ struct BCM2838State {
     BCM283XBaseState parent_obj;
     /*< public >*/
     BCM2838PeripheralState peripherals;
+    GICState gic;
 };
 
 #endif /* BCM2838_H */
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 8214003baf..0aed6f1bec 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,41 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 
+#define GENET_OFFSET            0x1580000
+
+/* SPI */
+#define GIC_SPI_INTERRUPT_MBOX         33
+#define GIC_SPI_INTERRUPT_MPHI         40
+#define GIC_SPI_INTERRUPT_DWC2         73
+#define GIC_SPI_INTERRUPT_DMA_0        80
+#define GIC_SPI_INTERRUPT_DMA_6        86
+#define GIC_SPI_INTERRUPT_DMA_7_8      87
+#define GIC_SPI_INTERRUPT_DMA_9_10     88
+#define GIC_SPI_INTERRUPT_AUX_UART1    93
+#define GIC_SPI_INTERRUPT_SDHOST       120
+#define GIC_SPI_INTERRUPT_UART0        121
+#define GIC_SPI_INTERRUPT_RNG200       125
+#define GIC_SPI_INTERRUPT_EMMC_EMMC2   126
+#define GIC_SPI_INTERRUPT_PCI_INT_A    143
+#define GIC_SPI_INTERRUPT_GENET_A      157
+#define GIC_SPI_INTERRUPT_GENET_B      158
+
+
+/* GPU (legacy) DMA interrupts */
+#define GPU_INTERRUPT_DMA0      16
+#define GPU_INTERRUPT_DMA1      17
+#define GPU_INTERRUPT_DMA2      18
+#define GPU_INTERRUPT_DMA3      19
+#define GPU_INTERRUPT_DMA4      20
+#define GPU_INTERRUPT_DMA5      21
+#define GPU_INTERRUPT_DMA6      22
+#define GPU_INTERRUPT_DMA7_8    23
+#define GPU_INTERRUPT_DMA9_10   24
+#define GPU_INTERRUPT_DMA11     25
+#define GPU_INTERRUPT_DMA12     26
+#define GPU_INTERRUPT_DMA13     27
+#define GPU_INTERRUPT_DMA14     28
+#define GPU_INTERRUPT_DMA15     31
 
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
@@ -24,6 +59,10 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr;
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
+
+    OrIRQState mmc_irq_orgate;
+    OrIRQState dma_7_8_irq_orgate;
+    OrIRQState dma_9_10_irq_orgate;
 };
 
 struct BCM2838PeripheralClass {
-- 
2.34.1


From e99309513608d7b115f8ab422aa7599448afb7cf Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 06/44] Add BCM2838 GPIO stub

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c         | 136 +++++++++++++++++++++++++++++++++
 hw/gpio/meson.build            |   5 +-
 include/hw/gpio/bcm2838_gpio.h |  39 ++++++++++
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 hw/gpio/bcm2838_gpio.c
 create mode 100644 include/hw/gpio/bcm2838_gpio.h

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
new file mode 100644
index 0000000000..59be608250
--- /dev/null
+++ b/hw/gpio/bcm2838_gpio.c
@@ -0,0 +1,136 @@
+/*
+ * Raspberry Pi (BCM2838) GPIO Controller
+ * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
+ *
+ * Copyright (c) 2022 Auriga LLC
+ *
+ * Authors:
+ *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/timer.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/gpio/bcm2838_gpio.h"
+
+#define GPFSEL0   0x00
+#define GPFSEL1   0x04
+#define GPFSEL2   0x08
+#define GPFSEL3   0x0C
+#define GPFSEL4   0x10
+#define GPFSEL5   0x14
+#define GPSET0    0x1C
+#define GPSET1    0x20
+#define GPCLR0    0x28
+#define GPCLR1    0x2C
+#define GPLEV0    0x34
+#define GPLEV1    0x38
+#define GPEDS0    0x40
+#define GPEDS1    0x44
+#define GPREN0    0x4C
+#define GPREN1    0x50
+#define GPFEN0    0x58
+#define GPFEN1    0x5C
+#define GPHEN0    0x64
+#define GPHEN1    0x68
+#define GPLEN0    0x70
+#define GPLEN1    0x74
+#define GPAREN0   0x7C
+#define GPAREN1   0x80
+#define GPAFEN0   0x88
+#define GPAFEN1   0x8C
+
+#define GPIO_PUP_PDN_CNTRL_REG0 0xE4
+#define GPIO_PUP_PDN_CNTRL_REG1 0xE8
+#define GPIO_PUP_PDN_CNTRL_REG2 0xEC
+#define GPIO_PUP_PDN_CNTRL_REG3 0xF0
+
+#define RESET_VAL_CNTRL_REG0 0xAAA95555;
+#define RESET_VAL_CNTRL_REG1 0xA0AAAAAA;
+#define RESET_VAL_CNTRL_REG2 0x50AAA95A;
+#define RESET_VAL_CNTRL_REG3 0x00055555;
+
+#define BYTES_IN_WORD        4
+
+static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = 0;
+
+    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                    TYPE_BCM2838_GPIO, __func__, offset);
+
+    return value;
+}
+
+static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
+                               unsigned size)
+{
+    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                    TYPE_BCM2838_GPIO, __func__, offset);
+}
+
+static void bcm2838_gpio_reset(DeviceState *dev)
+{
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+
+    s->lev0 = 0;
+    s->lev1 = 0;
+
+    s->pup_cntrl_reg[0] = RESET_VAL_CNTRL_REG0;
+    s->pup_cntrl_reg[1] = RESET_VAL_CNTRL_REG1;
+    s->pup_cntrl_reg[2] = RESET_VAL_CNTRL_REG2;
+    s->pup_cntrl_reg[3] = RESET_VAL_CNTRL_REG3;
+}
+
+static const MemoryRegionOps bcm2838_gpio_ops = {
+    .read = bcm2838_gpio_read,
+    .write = bcm2838_gpio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2838_gpio_init(Object *obj)
+{
+    BCM2838GpioState *s = BCM2838_GPIO(obj);
+    DeviceState *dev = DEVICE(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(
+        &s->iomem, obj,
+        &bcm2838_gpio_ops, s, "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    qdev_init_gpio_out(dev, s->out, BCM2838_GPIO_NUM);
+}
+
+static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
+{
+    /* Temporary stub. Do nothing */
+}
+
+static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = &bcm2838_gpio_realize;
+    dc->reset = &bcm2838_gpio_reset;
+}
+
+static const TypeInfo bcm2838_gpio_info = {
+    .name          = TYPE_BCM2838_GPIO,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GpioState),
+    .instance_init = bcm2838_gpio_init,
+    .class_init    = bcm2838_gpio_class_init,
+};
+
+static void bcm2838_gpio_register_types(void)
+{
+    type_register_static(&bcm2838_gpio_info);
+}
+
+type_init(bcm2838_gpio_register_types)
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 066ea96480..8a8d03d885 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -9,6 +9,9 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpio.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_gpio.c'))
 system_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_gpio.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_gpio.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files(
+    'bcm2835_gpio.c',
+    'bcm2838_gpio.c'
+))
 system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio.c'))
 system_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpio.c'))
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
new file mode 100644
index 0000000000..54baf01692
--- /dev/null
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -0,0 +1,39 @@
+/*
+ * Raspberry Pi (BCM2838) GPIO Controller
+ * This implementation is based on bcm2835_gpio (hw/gpio/bcm2835_gpio.c)
+ *
+ * Copyright (c) 2022 Auriga LLC
+ *
+ * Authors:
+ *  Lotosh, Aleksey <aleksey.lotosh@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_GPIO_H
+#define BCM2838_GPIO_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_GPIO "bcm2838-gpio"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GpioState, BCM2838_GPIO)
+
+#define BCM2838_GPIO_REGS_SIZE 0x1000
+#define BCM2838_GPIO_NUM       58
+#define GPIO_PUP_PDN_CNTRL_NUM 4
+
+struct BCM2838GpioState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+
+    uint8_t fsel[BCM2838_GPIO_NUM];
+    uint32_t lev0, lev1;
+    qemu_irq out[BCM2838_GPIO_NUM];
+    uint32_t pup_cntrl_reg[GPIO_PUP_PDN_CNTRL_NUM];
+};
+
+#endif
-- 
2.34.1


From 064d70579d27cea45271e959c07f8dd58ad74a3e Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 07/44] Implement BCM2838 GPIO functionality

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c | 197 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 193 insertions(+), 4 deletions(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 59be608250..cc9f4f74a0 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/gpio/bcm2838_gpio.h"
+#include "hw/irq.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
@@ -56,14 +57,139 @@
 #define RESET_VAL_CNTRL_REG2 0x50AAA95A;
 #define RESET_VAL_CNTRL_REG3 0x00055555;
 
+#define NUM_FSELN_IN_GPFSELN 10
+#define NUM_BITS_FSELN       3
+#define MASK_FSELN           0x7
+
 #define BYTES_IN_WORD        4
 
+static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
+{
+    int i;
+    uint32_t value = 0;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            value |= (s->fsel[index] & MASK_FSELN) << (NUM_BITS_FSELN * i);
+        }
+    }
+    return value;
+}
+
+static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
+{
+    int i;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            int fsel = (value >> (NUM_BITS_FSELN * i)) & MASK_FSELN;
+            s->fsel[index] = fsel;
+        }
+    }
+}
+
+static int gpfsel_is_out(BCM2838GpioState *s, int index)
+{
+    if (index >= 0 && index < BCM2838_GPIO_NUM) {
+        return s->fsel[index] == 1;
+    }
+    return 0;
+}
+
+static void gpset(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & ~*lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 1);
+        }
+        cur <<= 1;
+    }
+
+    *lev |= val;
+}
+
+static void gpclr(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & *lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 0);
+        }
+        cur <<= 1;
+    }
+
+    *lev &= ~val;
+}
+
 static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 {
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
     uint64_t value = 0;
 
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
-                    TYPE_BCM2838_GPIO, __func__, offset);
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        value = gpfsel_get(s, offset / BYTES_IN_WORD);
+        break;
+    case GPSET0:
+    case GPSET1:
+    case GPCLR0:
+    case GPCLR1:
+        /* Write Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt reading from write only"
+                      " register. %lu will be returned. Address 0x%"HWADDR_PRIx
+                      ", size %u\n", TYPE_BCM2838_GPIO, __func__, value, offset,
+                      size);
+        break;
+    case GPLEV0:
+        value = s->lev0;
+        break;
+    case GPLEV1:
+        value = s->lev1;
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        value = s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                                 / sizeof(s->pup_cntrl_reg[0])];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    }
 
     return value;
 }
@@ -71,14 +197,77 @@ static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
                                unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
-                    TYPE_BCM2838_GPIO, __func__, offset);
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
+
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        gpfsel_set(s, offset / BYTES_IN_WORD, value);
+        break;
+    case GPSET0:
+        gpset(s, value, 0, 32, &s->lev0);
+        break;
+    case GPSET1:
+        gpset(s, value, 32, 22, &s->lev1);
+        break;
+    case GPCLR0:
+        gpclr(s, value, 0, 32, &s->lev0);
+        break;
+    case GPCLR1:
+        gpclr(s, value, 32, 22, &s->lev1);
+        break;
+    case GPLEV0:
+    case GPLEV1:
+        /* Read Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt writing %lu to read "
+                      "only register. Ignored. Address 0x%"HWADDR_PRIx", size "
+                      "%u\n", TYPE_BCM2838_GPIO, __func__, value, offset, size);
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                         / sizeof(s->pup_cntrl_reg[0])] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
+                  TYPE_BCM2838_GPIO, __func__, offset);
+    }
+    return;
 }
 
 static void bcm2838_gpio_reset(DeviceState *dev)
 {
     BCM2838GpioState *s = BCM2838_GPIO(dev);
 
+    int i;
+    for (i = 0; i < 6; i++) {
+        gpfsel_set(s, i, 0);
+    }
+
     s->lev0 = 0;
     s->lev1 = 0;
 
-- 
2.34.1


From db35faec05776774c2e0f2c0a62ef91a4de17308 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 08/44] Connect SD controller to BCM2838 GPIO

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c         | 52 +++++++++++++++++++++++++++++++++-
 include/hw/gpio/bcm2838_gpio.h |  6 ++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index cc9f4f74a0..7291e473dc 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,6 +17,7 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
 
@@ -63,6 +64,16 @@
 
 #define BYTES_IN_WORD        4
 
+/* bcm,function property */
+#define BCM2838_FSEL_GPIO_IN    0
+#define BCM2838_FSEL_GPIO_OUT   1
+#define BCM2838_FSEL_ALT5       2
+#define BCM2838_FSEL_ALT4       3
+#define BCM2838_FSEL_ALT0       4
+#define BCM2838_FSEL_ALT1       5
+#define BCM2838_FSEL_ALT2       6
+#define BCM2838_FSEL_ALT3       7
+
 static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
 {
     int i;
@@ -86,6 +97,31 @@ static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
             s->fsel[index] = fsel;
         }
     }
+
+    /* SD controller selection (48-53) */
+    if (s->sd_fsel != BCM2838_FSEL_GPIO_IN
+        && (s->fsel[48] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[49] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[50] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[51] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[52] == BCM2838_FSEL_GPIO_IN)
+        && (s->fsel[53] == BCM2838_FSEL_GPIO_IN)
+       ) {
+        /* SDHCI controller selected */
+        sdbus_reparent_card(s->sdbus_sdhost, s->sdbus_sdhci);
+        s->sd_fsel = BCM2838_FSEL_GPIO_IN;
+    } else if (s->sd_fsel != BCM2838_FSEL_ALT0
+               && (s->fsel[48] == BCM2838_FSEL_ALT0) /* SD_CLK_R */
+               && (s->fsel[49] == BCM2838_FSEL_ALT0) /* SD_CMD_R */
+               && (s->fsel[50] == BCM2838_FSEL_ALT0) /* SD_DATA0_R */
+               && (s->fsel[51] == BCM2838_FSEL_ALT0) /* SD_DATA1_R */
+               && (s->fsel[52] == BCM2838_FSEL_ALT0) /* SD_DATA2_R */
+               && (s->fsel[53] == BCM2838_FSEL_ALT0) /* SD_DATA3_R */
+              ) {
+        /* SDHost controller selected */
+        sdbus_reparent_card(s->sdbus_sdhci, s->sdbus_sdhost);
+        s->sd_fsel = BCM2838_FSEL_ALT0;
+    }
 }
 
 static int gpfsel_is_out(BCM2838GpioState *s, int index)
@@ -268,6 +304,11 @@ static void bcm2838_gpio_reset(DeviceState *dev)
         gpfsel_set(s, i, 0);
     }
 
+    s->sd_fsel = 0;
+
+    /* SDHCI is selected by default */
+    sdbus_reparent_card(&s->sdbus, s->sdbus_sdhci);
+
     s->lev0 = 0;
     s->lev1 = 0;
 
@@ -289,6 +330,8 @@ static void bcm2838_gpio_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
+    qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SD_BUS, DEVICE(s), "sd-bus");
+
     memory_region_init_io(
         &s->iomem, obj,
         &bcm2838_gpio_ops, s, "bcm2838_gpio", BCM2838_GPIO_REGS_SIZE);
@@ -298,7 +341,14 @@ static void bcm2838_gpio_init(Object *obj)
 
 static void bcm2838_gpio_realize(DeviceState *dev, Error **errp)
 {
-    /* Temporary stub. Do nothing */
+    BCM2838GpioState *s = BCM2838_GPIO(dev);
+    Object *obj;
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhci", &error_abort);
+    s->sdbus_sdhci = SD_BUS(obj);
+
+    obj = object_property_get_link(OBJECT(dev), "sdbus-sdhost", &error_abort);
+    s->sdbus_sdhost = SD_BUS(obj);
 }
 
 static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/gpio/bcm2838_gpio.h b/include/hw/gpio/bcm2838_gpio.h
index 54baf01692..f2a57a697f 100644
--- a/include/hw/gpio/bcm2838_gpio.h
+++ b/include/hw/gpio/bcm2838_gpio.h
@@ -14,6 +14,7 @@
 #ifndef BCM2838_GPIO_H
 #define BCM2838_GPIO_H
 
+#include "hw/sd/sd.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
 
@@ -29,9 +30,14 @@ struct BCM2838GpioState {
 
     MemoryRegion iomem;
 
+    /* SDBus selector */
+    SDBus sdbus;
+    SDBus *sdbus_sdhci;
+    SDBus *sdbus_sdhost;
 
     uint8_t fsel[BCM2838_GPIO_NUM];
     uint32_t lev0, lev1;
+    uint8_t sd_fsel;
     qemu_irq out[BCM2838_GPIO_NUM];
     uint32_t pup_cntrl_reg[GPIO_PUP_PDN_CNTRL_NUM];
 };
-- 
2.34.1


From c53ed2b69e3220faa87c2134acd0625892477f93 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 09/44] Add GPIO and SD to BCM2838 periph

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 140 +++++++++++++++++++++++++++
 include/hw/arm/bcm2838_peripherals.h |   9 ++
 2 files changed, 149 insertions(+)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 864941c231..0c5e716853 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -15,22 +15,53 @@
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
+/* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
+#define BCM2835_SDHC_CAPAREG 0x52134b4
+
 static void bcm2838_peripherals_init(Object *obj)
 {
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
     BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
+    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(obj);
 
     /* Lower memory region for peripheral devices (exported to the Soc) */
     memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
                        bc->peri_low_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
 
+    /* Extended Mass Media Controller 2 */
+    object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
+
+    /* GPIO */
+    object_initialize_child(obj, "gpio", &s->gpio, TYPE_BCM2838_GPIO);
+
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
+                                   OBJECT(&s_base->sdhci.sdbus));
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
+                                   OBJECT(&s_base->sdhost.sdbus));
+
+    object_initialize_child(obj, "mmc_irq_orgate", &s->mmc_irq_orgate,
+                            TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s->mmc_irq_orgate), "num-lines", 2,
+                            &error_abort);
+
+    object_initialize_child(obj, "dma_7_8_irq_orgate", &s->dma_7_8_irq_orgate,
+                            TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s->dma_7_8_irq_orgate), "num-lines", 2,
+                            &error_abort);
+
+    object_initialize_child(obj, "dma_9_10_irq_orgate", &s->dma_9_10_irq_orgate,
+                            TYPE_OR_IRQ);
+    object_property_set_int(OBJECT(&s->dma_9_10_irq_orgate), "num-lines", 2,
+                            &error_abort);
 }
 
 static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
 {
+    MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(dev);
+    int n;
 
     raspi_peripherals_common_realize(dev, errp);
 
@@ -42,6 +73,115 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Extended Mass Media Controller 2 */
+    object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
+                             &error_abort);
+    object_property_set_uint(OBJECT(&s->emmc2), "capareg",
+                             BCM2835_SDHC_CAPAREG, &error_abort);
+    object_property_set_bool(OBJECT(&s->emmc2), "pending-insert-quirk", true,
+                             &error_abort);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->emmc2), errp)) {
+        return;
+    }
+
+    memory_region_add_subregion(
+        &s_base->peri_mr, EMMC2_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->emmc2), 0));
+
+    /* According to DTS, EMMC and EMMC2 share one irq */
+    if (!qdev_realize(DEVICE(&s->mmc_irq_orgate), NULL, errp)) {
+        return;
+    }
+
+    DeviceState *mmc_irq_orgate = DEVICE(&s->mmc_irq_orgate);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emmc2), 0,
+                        qdev_get_gpio_in(mmc_irq_orgate, 0));
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->sdhci), 0,
+                        qdev_get_gpio_in(mmc_irq_orgate, 1));
+
+   /* Connect EMMC and EMMC2 to the interrupt controller */
+    qdev_connect_gpio_out(mmc_irq_orgate, 0,
+                          qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                 BCM2835_IC_GPU_IRQ,
+                                                 INTERRUPT_ARASANSDIO));
+
+    /* Connect DMA 0-6 to the interrupt controller */
+    for (n = 0; n < 7; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), n,
+                           qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                  BCM2835_IC_GPU_IRQ,
+                                                  GPU_INTERRUPT_DMA0 + n));
+    }
+
+   /* According to DTS, DMA 7 and 8 share one irq */
+    if (!qdev_realize(DEVICE(&s->dma_7_8_irq_orgate), NULL, errp)) {
+        return;
+    }
+    DeviceState *dma_7_8_irq_orgate = DEVICE(&s->dma_7_8_irq_orgate);
+
+    /* Connect DMA 7-8 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), 7,
+                       qdev_get_gpio_in(dma_7_8_irq_orgate, 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), 8,
+                       qdev_get_gpio_in(dma_7_8_irq_orgate, 1));
+
+    qdev_connect_gpio_out(dma_7_8_irq_orgate, 0,
+                          qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                 BCM2835_IC_GPU_IRQ,
+                                                 GPU_INTERRUPT_DMA7_8));
+
+     /* According to DTS, DMA 9 and 10 share one irq */
+    if (!qdev_realize(DEVICE(&s->dma_9_10_irq_orgate), NULL, errp)) {
+        return;
+    }
+    DeviceState *dma_9_10_irq_orgate = DEVICE(&s->dma_9_10_irq_orgate);
+
+   /* Connect DMA 9-10 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), 9,
+                       qdev_get_gpio_in(dma_9_10_irq_orgate, 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), 10,
+                       qdev_get_gpio_in(dma_9_10_irq_orgate, 1));
+
+    qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
+                          qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                 BCM2835_IC_GPU_IRQ,
+                                                 GPU_INTERRUPT_DMA9_10));
+
+    /* Connect DMA 11-14 to the interrupt controller */
+    for (n = 11; n < 15; n++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), n,
+                           qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                                  BCM2835_IC_GPU_IRQ,
+                                                  GPU_INTERRUPT_DMA11 + n
+                                                  - 11));
+    }
+
+    /*
+     * Connect DMA 15 to the interrupt controller, it is physically removed
+     * from other DMA channels and exclusively used by the GPU
+     */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s_base->dma), 15,
+                        qdev_get_gpio_in_named(DEVICE(&s_base->ic),
+                                               BCM2835_IC_GPU_IRQ,
+                                               GPU_INTERRUPT_DMA15));
+
+    /* Map MPHI to BCM2838 memory map */
+    mphi_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s_base->mphi), 0);
+    memory_region_init_alias(&s->mphi_mr_alias, OBJECT(s), "mphi", mphi_mr, 0,
+                             BCM2838_MPHI_SIZE);
+    memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
+                                &s->mphi_mr_alias);
+
+    /* GPIO */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, GPIO_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
 }
 
 static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0aed6f1bec..aba38a18f0 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,8 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/sd/sdhci.h"
+#include "hw/gpio/bcm2838_gpio.h"
 
 #define GENET_OFFSET            0x1580000
 
@@ -47,6 +49,9 @@
 #define GPU_INTERRUPT_DMA14     28
 #define GPU_INTERRUPT_DMA15     31
 
+#define BCM2838_MPHI_OFFSET     0xb200
+#define BCM2838_MPHI_SIZE       0x200
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
@@ -60,6 +65,10 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
 
+    SDHCIState emmc2;
+    UnimplementedDeviceState clkisp;
+    BCM2838GpioState gpio;
+
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
     OrIRQState dma_9_10_irq_orgate;
-- 
2.34.1


From aa760c91fdc8309fce34c8e3f892a3246bf88dfc Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 10/44] Add BCM2838 checkpoint support

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 7291e473dc..f1121f9c58 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -17,6 +17,7 @@
 #include "qemu/timer.h"
 #include "qapi/error.h"
 #include "hw/sysbus.h"
+#include "migration/vmstate.h"
 #include "hw/sd/sd.h"
 #include "hw/gpio/bcm2838_gpio.h"
 #include "hw/irq.h"
@@ -324,6 +325,21 @@ static const MemoryRegionOps bcm2838_gpio_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+static const VMStateDescription vmstate_bcm2838_gpio = {
+    .name = "bcm2838_gpio",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(fsel, BCM2838GpioState, BCM2838_GPIO_NUM),
+        VMSTATE_UINT32(lev0, BCM2838GpioState),
+        VMSTATE_UINT32(lev1, BCM2838GpioState),
+        VMSTATE_UINT8(sd_fsel, BCM2838GpioState),
+        VMSTATE_UINT32_ARRAY(pup_cntrl_reg, BCM2838GpioState,
+                             GPIO_PUP_PDN_CNTRL_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void bcm2838_gpio_init(Object *obj)
 {
     BCM2838GpioState *s = BCM2838_GPIO(obj);
@@ -355,6 +371,7 @@ static void bcm2838_gpio_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->vmsd = &vmstate_bcm2838_gpio;
     dc->realize = &bcm2838_gpio_realize;
     dc->reset = &bcm2838_gpio_reset;
 }
-- 
2.34.1


From 17606f9887a563a2b96bf266a07242d4d0d6225f Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 11/44] Introduce Raspberry PI 4 machine

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2835_peripherals.c    |  20 +++-
 hw/arm/bcm2836.c                |   2 +
 hw/arm/bcm2838.c                |   2 +
 hw/arm/meson.build              |   2 +-
 hw/arm/raspi.c                  |  28 +++--
 hw/arm/raspi4b.c                | 182 ++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h |  11 ++
 include/hw/display/bcm2835_fb.h |   2 +
 8 files changed, 235 insertions(+), 14 deletions(-)
 create mode 100644 hw/arm/raspi4b.c

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 4c0c0b1e7d..9e4153936f 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -108,6 +108,7 @@ static void raspi_peripherals_base_init(Object *obj)
     /* Framebuffer */
     object_initialize_child(obj, "fb", &s->fb, TYPE_BCM2835_FB);
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->fb), "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->fb), "vcram-base");
 
     object_property_add_const_link(OBJECT(&s->fb), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr));
@@ -225,7 +226,7 @@ void raspi_peripherals_common_realize(DeviceState *dev, Error **errp)
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
-    uint64_t ram_size, vcram_size;
+    uint64_t ram_size, vcram_size, vcram_base;
     int n;
 
     obj = object_property_get_link(OBJECT(dev), "ram", &error_abort);
@@ -329,11 +330,24 @@ void raspi_peripherals_common_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base",
-                                  ram_size - vcram_size, errp)) {
+    vcram_base = object_property_get_uint(OBJECT(s), "vcram-base", &err);
+    if (err) {
+        error_propagate(errp, err);
         return;
     }
 
+    if (vcram_base == 0) {
+        vcram_base = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
+            - vcram_size;
+    } else {
+        if (vcram_base + vcram_size > UPPER_RAM_BASE) {
+            vcram_base = UPPER_RAM_BASE - vcram_size;
+        }
+    }
+    if (!object_property_set_uint(OBJECT(&s->fb), "vcram-base", vcram_base,
+                                  errp)) {
+        return;
+    }
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->fb), errp)) {
         return;
     }
diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
index 8beafb97f0..34883d29ff 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -64,6 +64,8 @@ static void bcm283x_init(Object *obj)
                               "command-line");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
 }
 
 bool bcm283x_common_realize(DeviceState *dev, RaspiPeripheralBaseState *ps,
diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c687f38a39..a1980cc181 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -62,6 +62,8 @@ static void bcm2838_init(Object *obj)
                               "board-rev");
     object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
                               "vcram-size");
+    object_property_add_alias(obj, "vcram-base", OBJECT(&s->peripherals),
+                              "vcram-base");
     object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
                               "command-line");
 
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 071819b527..768b2608c1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,7 +39,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7d04734cd2..da1e9e7c13 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -18,6 +18,7 @@
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bcm2836.h"
+#include "hw/arm/bcm2838.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/registerfields.h"
 #include "qemu/error-report.h"
@@ -61,6 +62,7 @@ typedef enum RaspiProcessorId {
     PROCESSOR_ID_BCM2835 = 0,
     PROCESSOR_ID_BCM2836 = 1,
     PROCESSOR_ID_BCM2837 = 2,
+    PROCESSOR_ID_BCM2838 = 3,
 } RaspiProcessorId;
 
 static const struct {
@@ -70,13 +72,9 @@ static const struct {
     [PROCESSOR_ID_BCM2835] = {TYPE_BCM2835, 1},
     [PROCESSOR_ID_BCM2836] = {TYPE_BCM2836, BCM283X_NCPUS},
     [PROCESSOR_ID_BCM2837] = {TYPE_BCM2837, BCM283X_NCPUS},
+    [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static void raspi_base_machine_init(MachineState *machine,
-                             BCM283XBaseState *soc);
-static void raspi_machine_class_common_init(MachineClass *mc,
-                                     uint32_t board_rev);
-
 static uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
@@ -93,7 +91,7 @@ static RaspiProcessorId board_processor_id(uint32_t board_rev)
     return proc_id;
 }
 
-static const char *board_soc_type(uint32_t board_rev)
+const char *board_soc_type(uint32_t board_rev)
 {
     return soc_property[board_processor_id(board_rev)].type;
 }
@@ -248,13 +246,14 @@ static void setup_boot(MachineState *machine, ARMCPU *cpu,
     arm_load_kernel(cpu, machine, &s->binfo);
 }
 
-static void raspi_base_machine_init(MachineState *machine,
+void raspi_base_machine_init(MachineState *machine,
                              BCM283XBaseState *soc)
 {
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     uint32_t board_rev = mc->board_rev;
     uint64_t ram_size = board_ram_size(board_rev);
-    uint32_t vcram_size;
+    uint32_t vcram_base, vcram_size;
+    size_t boot_ram_size;
     DriveInfo *di;
     BlockBackend *blk;
     BusState *bus;
@@ -293,11 +292,20 @@ static void raspi_base_machine_init(MachineState *machine,
 
     vcram_size = object_property_get_uint(OBJECT(soc), "vcram-size",
                                           &error_abort);
+    vcram_base = object_property_get_uint(OBJECT(soc), "vcram-base",
+                                          &error_abort);
+    if (!vcram_base) {
+        boot_ram_size = (ram_size > UPPER_RAM_BASE ? UPPER_RAM_BASE : ram_size)
+            - vcram_size;
+    } else {
+        boot_ram_size = (vcram_base + vcram_size > UPPER_RAM_BASE ?
+                                UPPER_RAM_BASE - vcram_size : vcram_base);
+    }
     setup_boot(machine, &soc->cpu[0].core, board_processor_id(board_rev),
-               machine->ram_size - vcram_size);
+               boot_ram_size);
 }
 
-static void raspi_machine_init(MachineState *machine)
+void raspi_machine_init(MachineState *machine)
 {
     RaspiMachineState *s = RASPI_MACHINE(machine);
     RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
new file mode 100644
index 0000000000..4096522d85
--- /dev/null
+++ b/hw/arm/raspi4b.c
@@ -0,0 +1,182 @@
+/*
+ * Raspberry Pi 4B emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/cutils.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/display/bcm2835_fb.h"
+#include "hw/registerfields.h"
+#include "qemu/error-report.h"
+#include "sysemu/device_tree.h"
+#include "hw/boards.h"
+#include "hw/loader.h"
+#include "hw/arm/boot.h"
+#include "qom/object.h"
+#include "hw/arm/bcm2838.h"
+
+#define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-common")
+OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
+
+struct Raspi4bMachineState {
+    /*< private >*/
+    RaspiBaseMachineState parent_obj;
+    /*< public >*/
+    BCM2838State soc;
+    uint32_t vcram_base;
+    uint32_t vcram_size;
+};
+
+static void raspi4b_machine_init(MachineState *machine)
+{
+    Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
+    RaspiBaseMachineState *s_base = RASPI_BASE_MACHINE(machine);
+    RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
+    BCM2838State *soc = &s->soc;
+
+    s_base->binfo.board_id = mc->board_rev;
+
+    object_initialize_child(OBJECT(machine), "soc", soc,
+                            board_soc_type(mc->board_rev));
+
+    if (s->vcram_base) {
+        object_property_set_uint(OBJECT(soc), "vcram-base",
+                                        s->vcram_base, NULL);
+    }
+
+    if (s->vcram_size) {
+        object_property_set_uint(OBJECT(soc), "vcram-size",
+                                 s->vcram_size, NULL);
+    }
+
+    raspi_base_machine_init(machine, &soc->parent_obj);
+}
+
+static void get_vcram_base(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value = ms->vcram_base;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void set_vcram_base(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    ms->vcram_base = value;
+}
+
+static void get_vcram_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value = ms->vcram_size;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void set_vcram_size(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    Raspi4bMachineState *ms = RASPI4B_MACHINE(obj);
+    hwaddr value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    ms->vcram_size = value;
+}
+
+static void raspi4b_machine_class_init(MachineClass *mc, uint32_t board_rev)
+{
+    object_class_property_add(OBJECT_CLASS(mc), "vcram-size", "uint32",
+                              get_vcram_size, set_vcram_size, NULL, NULL);
+    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-size",
+                                            "VideoCore RAM base address");
+    object_class_property_add(OBJECT_CLASS(mc), "vcram-base", "uint32",
+                              get_vcram_base, set_vcram_base, NULL, NULL);
+    object_class_property_set_description(OBJECT_CLASS(mc), "vcram-base",
+                                            "VideoCore RAM size");
+
+    raspi_machine_class_common_init(mc, board_rev);
+    mc->init = raspi4b_machine_init;
+}
+
+static void raspi4b1g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xa03111;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b2g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xb03112;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b4g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xc03114;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static void raspi4b8g_machine_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
+
+    rmc->board_rev = 0xd03114;
+    raspi4b_machine_class_init(mc, rmc->board_rev);
+}
+
+static const TypeInfo raspi4b_machine_types[] = {
+    {
+        .name           = MACHINE_TYPE_NAME("raspi4b1g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b1g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b2g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b2g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b4g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b4g_machine_class_init,
+    }, {
+        .name           = MACHINE_TYPE_NAME("raspi4b8g"),
+        .parent         = TYPE_RASPI4B_MACHINE,
+        .class_init     = raspi4b8g_machine_class_init,
+    }, {
+        .name           = TYPE_RASPI4B_MACHINE,
+        .parent         = TYPE_RASPI_BASE_MACHINE,
+        .instance_size  = sizeof(Raspi4bMachineState),
+        .abstract       = true,
+    }
+};
+
+DEFINE_TYPES(raspi4b_machine_types)
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 3018e8fcf3..45003e2425 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -49,6 +49,17 @@ struct RaspiBaseMachineClass {
     uint32_t board_rev;
 };
 
+/* Common functions for raspberry pi machines */
+const char *board_soc_type(uint32_t board_rev);
+void raspi_machine_init(MachineState *machine);
+
+typedef struct BCM283XBaseState BCM283XBaseState;
+void raspi_base_machine_init(MachineState *machine,
+                             BCM283XBaseState *soc);
+
+void raspi_machine_class_common_init(MachineClass *mc,
+                                     uint32_t board_rev);
+
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
 #define INTE_OFFSET             0x2000   /* VC Interrupt controller */
diff --git a/include/hw/display/bcm2835_fb.h b/include/hw/display/bcm2835_fb.h
index 38671afffd..49541bf08f 100644
--- a/include/hw/display/bcm2835_fb.h
+++ b/include/hw/display/bcm2835_fb.h
@@ -16,6 +16,8 @@
 #include "ui/console.h"
 #include "qom/object.h"
 
+#define UPPER_RAM_BASE 0x40000000
+
 #define TYPE_BCM2835_FB "bcm2835-fb"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835FBState, BCM2835_FB)
 
-- 
2.34.1


From 2ac90e952cfbd9f2079cb3d8c21c57f9d0e2153a Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 12/44] Temporary disable unimplemented rpi4b devices

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/raspi.c                  |  2 +-
 hw/arm/raspi4b.c                | 63 +++++++++++++++++++++++++++++++++
 include/hw/arm/raspi_platform.h |  1 +
 3 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index da1e9e7c13..cffdd8de4e 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -75,7 +75,7 @@ static const struct {
     [PROCESSOR_ID_BCM2838] = {TYPE_BCM2838, BCM283X_NCPUS},
 };
 
-static uint64_t board_ram_size(uint32_t board_rev)
+uint64_t board_ram_size(uint32_t board_rev)
 {
     assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style */
     return 256 * MiB << FIELD_EX32(board_rev, REV_CODE, MEMORY_SIZE);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 4096522d85..d2053c9380 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -21,6 +21,7 @@
 #include "hw/arm/boot.h"
 #include "qom/object.h"
 #include "hw/arm/bcm2838.h"
+#include <libfdt.h>
 
 #define TYPE_RASPI4B_MACHINE MACHINE_TYPE_NAME("raspi4b-common")
 OBJECT_DECLARE_SIMPLE_TYPE(Raspi4bMachineState, RASPI4B_MACHINE)
@@ -34,6 +35,61 @@ struct Raspi4bMachineState {
     uint32_t vcram_size;
 };
 
+
+static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
+{
+    int ret;
+    uint32_t acells, scells;
+    char *nodename = g_strdup_printf("/memory@%" PRIx64, mem_base);
+
+    acells = qemu_fdt_getprop_cell(fdt, "/", "#address-cells",
+                                   NULL, &error_fatal);
+    scells = qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
+                                   NULL, &error_fatal);
+    if (acells == 0 || scells == 0) {
+        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells 0)\n");
+        ret = -1;
+    } else {
+        qemu_fdt_add_subnode(fdt, nodename);
+        qemu_fdt_setprop_string(fdt, nodename, "device_type", "memory");
+        ret = qemu_fdt_setprop_sized_cells(fdt, nodename, "reg",
+                                           acells, mem_base,
+                                           scells, mem_len);
+    }
+
+    g_free(nodename);
+    return ret;
+}
+
+static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
+{
+
+    /* Temporary disable following devices until they are implemented*/
+    const char *to_be_removed_from_dt_as_wa[] = {
+        "brcm,bcm2711-pcie",
+        "brcm,bcm2711-rng200",
+        "brcm,bcm2711-thermal",
+        "brcm,bcm2711-genet-v5",
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(to_be_removed_from_dt_as_wa); i++) {
+        const char *dev_str = to_be_removed_from_dt_as_wa[i];
+
+        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
+        if (offset >= 0) {
+            if (!fdt_nop_node(fdt, offset)) {
+                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
+            }
+        }
+    }
+
+    uint64_t ram_size = board_ram_size(info->board_id);
+
+    if (ram_size > UPPER_RAM_BASE) {
+        raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
+    }
+}
+
 static void raspi4b_machine_init(MachineState *machine)
 {
     Raspi4bMachineState *s = RASPI4B_MACHINE(machine);
@@ -41,6 +97,13 @@ static void raspi4b_machine_init(MachineState *machine)
     RaspiBaseMachineClass *mc = RASPI_BASE_MACHINE_GET_CLASS(machine);
     BCM2838State *soc = &s->soc;
 
+    s_base->binfo.modify_dtb = raspi4_modify_dtb;
+    /*
+     * Hack to get board revision during device tree modification without
+     * changes of common code.
+     * The correct way is to set board_id to MACH_TYPE_BCM2708 and add board_rev
+     * to the arm_boot_info structure.
+     */
     s_base->binfo.board_id = mc->board_rev;
 
     object_initialize_child(OBJECT(machine), "soc", soc,
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 45003e2425..30b114f6e0 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -59,6 +59,7 @@ void raspi_base_machine_init(MachineState *machine,
 
 void raspi_machine_class_common_init(MachineClass *mc,
                                      uint32_t board_rev);
+uint64_t board_ram_size(uint32_t board_rev);
 
 #define MSYNC_OFFSET            0x0000   /* Multicore Sync Block */
 #define CCPT_OFFSET             0x1000   /* Compact Camera Port 2 TX */
-- 
2.34.1


From 9dde9b275469918c7574981b0d4a51e48631fedf Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 13/44] Add memory region for BCM2837 RPiVid ASB

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 3 +++
 include/hw/arm/bcm2838_peripherals.h | 3 ++-
 include/hw/arm/raspi_platform.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 0c5e716853..f689e16535 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -182,6 +182,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
+
+    /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
+    create_unimp(s_base, &s->asb, "bcm2838-asb", RPI4B_ASB_OFFSET, 0x24);
 }
 
 static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index aba38a18f0..ebed11dd40 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -66,12 +66,13 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     SDHCIState emmc2;
-    UnimplementedDeviceState clkisp;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
     OrIRQState dma_9_10_irq_orgate;
+
+    UnimplementedDeviceState asb;
 };
 
 struct BCM2838PeripheralClass {
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 30b114f6e0..4a5e8c1cc8 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -71,6 +71,7 @@ uint64_t board_ram_size(uint32_t board_rev);
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
 #define ARBA_OFFSET             0x9000
 #define BRDG_OFFSET             0xa000
+#define RPI4B_ASB_OFFSET        0xa000   /* BCM2838 (BCM2711) RPiVid ASB */
 #define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
-- 
2.34.1


From 5671881c9b193668cb9c848378fed13f9bb6a236 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 14/44] Add BCM2838 PCIE Root Complex

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_pcie.c         | 65 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |  5 ++-
 hw/arm/trace-events           |  4 +++
 include/hw/arm/bcm2838_pcie.h | 44 ++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
new file mode 100644
index 0000000000..522e19f3cf
--- /dev/null
+++ b/hw/arm/bcm2838_pcie.c
@@ -0,0 +1,65 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "hw/arm/bcm2838_pcie.h"
+#include "trace.h"
+
+/*
+ * RC root part (D0:F0)
+ */
+
+static void bcm2838_pcie_root_init(Object *obj)
+{
+    PCIBridge *br = PCI_BRIDGE(obj);
+    BCM2838PcieRootState *s = BCM2838_PCIE_ROOT(obj);
+
+    br->bus_name = "pcie.1";
+    memset(s->regs, 0xFF, sizeof(s->regs));
+}
+
+static void bcm2838_pcie_root_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
+    PCIERootPortClass *rpc = PCIE_ROOT_PORT_CLASS(class);
+
+    dc->desc = "BCM2711 PCIe Bridge";
+    /*
+     * PCI-facing part of the host bridge, not usable without the host-facing
+     * part, which can't be device_add'ed.
+     */
+    dc->user_creatable = false;
+    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
+    k->device_id = BCM2838_PCIE_DEVICE_ID;
+    k->revision = BCM2838_PCIE_REVISION;
+    rpc->exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
+    rpc->aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
+}
+
+static const TypeInfo bcm2838_pcie_root_info = {
+    .name = TYPE_BCM2838_PCIE_ROOT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(BCM2838PcieRootState),
+    .instance_init = bcm2838_pcie_root_init,
+    .class_init = bcm2838_pcie_root_class_init,
+};
+
+static void bcm2838_pcie_register(void)
+{
+    type_register_static(&bcm2838_pcie_root_info);
+}
+
+type_init(bcm2838_pcie_register)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 768b2608c1..72680fa534 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,7 +39,10 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files(
+  'bcm2838.c',
+  'bcm2838_pcie.c',
+  'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 4f0167e638..6cfab31539 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,5 +55,9 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# bcm2838_pcie.c
+bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+
 # bcm2838.c
 bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
new file mode 100644
index 0000000000..b3d39b808d
--- /dev/null
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -0,0 +1,44 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_PCIE_H
+#define BCM2838_PCIE_H
+
+#include "exec/hwaddr.h"
+#include "hw/sysbus.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieRootState, BCM2838_PCIE_ROOT)
+
+#define BCM2838_PCIE_VENDOR_ID      0x14E4
+#define BCM2838_PCIE_DEVICE_ID      0x2711
+#define BCM2838_PCIE_REVISION       20
+
+#define BCM2838_PCIE_REGS_SIZE      0x9310
+#define BCM2838_PCIE_NUM_IRQS       4
+
+#define BCM2838_PCIE_EXP_CAP_OFFSET 0xAC
+#define BCM2838_PCIE_AER_CAP_OFFSET 0x100
+
+#define BCM2838_PCIE_EXT_CFG_DATA   0x8000
+#define BCM2838_PCIE_EXT_CFG_INDEX  0x9000
+
+struct BCM2838PcieRootState {
+    /*< private >*/
+    PCIESlot parent_obj;
+
+    /*< public >*/
+    uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
+};
+
+
+#endif /* BCM2838_PCIE_H */
-- 
2.34.1


From d889852ee2b5d94587a91e1309af8c8e8c84d5e9 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 15/44] Add BCM2838 PCIE host

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_pcie.c         | 232 +++++++++++++++++++++++++++++++++-
 include/hw/arm/bcm2838_pcie.h |  23 ++++
 2 files changed, 253 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index 522e19f3cf..dd9629ff79 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -12,11 +12,238 @@
 #include "hw/irq.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
-#include "migration/vmstate.h"
-#include "qemu/module.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "trace.h"
 
+/*
+ * RC host part
+ */
+
+static uint64_t bcm2838_pcie_host_read(void *opaque, hwaddr offset,
+                                       unsigned size) {
+    hwaddr mmcfg_addr;
+    uint64_t value = ~0;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
+    uint8_t *root_regs = s->root_port.regs;
+    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                                     - PCIE_CONFIG_SPACE_SIZE);
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        value = pci_host_config_read_common(root_pci_dev, offset,
+                                            PCIE_CONFIG_SPACE_SIZE, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = *cfg_idx
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            value = pcie_hb->mmio.ops->read(opaque, mmcfg_addr, size);
+            break;
+        default:
+            memcpy(&value, root_regs + offset - PCIE_CONFIG_SPACE_SIZE, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+
+    trace_bcm2838_pcie_host_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_pcie_host_write(void *opaque, hwaddr offset,
+                                    uint64_t value, unsigned size) {
+    hwaddr mmcfg_addr;
+    BCM2838PcieHostState *s = opaque;
+    PCIExpressHost *pcie_hb = PCIE_HOST_BRIDGE(s);
+    PCIDevice *root_pci_dev = PCI_DEVICE(&s->root_port);
+    uint8_t *root_regs = s->root_port.regs;
+    uint32_t *cfg_idx = (uint32_t *)(root_regs + BCM2838_PCIE_EXT_CFG_INDEX
+                                     - PCIE_CONFIG_SPACE_SIZE);
+
+    trace_bcm2838_pcie_host_write(size, offset, value);
+
+    if (offset < PCIE_CONFIG_SPACE_SIZE) {
+        pci_host_config_write_common(root_pci_dev, offset,
+                                     PCIE_CONFIG_SPACE_SIZE, value, size);
+    } else if (offset - PCIE_CONFIG_SPACE_SIZE + size
+               <= sizeof(s->root_port.regs)) {
+        switch (offset) {
+        case BCM2838_PCIE_EXT_CFG_DATA
+            ... BCM2838_PCIE_EXT_CFG_DATA + PCIE_CONFIG_SPACE_SIZE - 1:
+            mmcfg_addr = *cfg_idx
+                | PCIE_MMCFG_CONFOFFSET(offset - BCM2838_PCIE_EXT_CFG_DATA);
+            pcie_hb->mmio.ops->write(opaque, mmcfg_addr, value, size);
+            break;
+        default:
+            memcpy(root_regs + offset - PCIE_CONFIG_SPACE_SIZE, &value, size);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
+}
+
+static const MemoryRegionOps bcm2838_pcie_host_ops = {
+    .read = bcm2838_pcie_host_read,
+    .write = bcm2838_pcie_host_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = sizeof(uint64_t)},
+};
+
+int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi)
+{
+    if (index >= BCM2838_PCIE_NUM_IRQS) {
+        return -EINVAL;
+    }
+
+    s->irq_num[index] = spi;
+    return 0;
+}
+
+static void bcm2838_pcie_host_set_irq(void *opaque, int irq_num, int level)
+{
+    BCM2838PcieHostState *s = opaque;
+
+    qemu_set_irq(s->irq[irq_num], level);
+}
+
+static PCIINTxRoute bcm2838_pcie_host_route_intx_pin_to_irq(void *opaque,
+                                                            int pin)
+{
+    PCIINTxRoute route;
+    BCM2838PcieHostState *s = opaque;
+
+    route.irq = s->irq_num[pin];
+    route.mode = route.irq < 0 ? PCI_INTX_DISABLED : PCI_INTX_ENABLED;
+
+    return route;
+}
+
+static int bcm2838_pcie_host_map_irq(PCIDevice *pci_dev, int pin)
+{
+    return pin;
+}
+
+static void bcm2838_pcie_host_realize(DeviceState *dev, Error **errp)
+{
+    PCIHostState *pci = PCI_HOST_BRIDGE(dev);
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    int i;
+
+    memory_region_init_io(&s->cfg_regs, OBJECT(s), &bcm2838_pcie_host_ops, s,
+                          "bcm2838_pcie_cfg_regs", BCM2838_PCIE_REGS_SIZE);
+    sysbus_init_mmio(sbd, &s->cfg_regs);
+
+    /*
+     * The MemoryRegions io_mmio and io_ioport that we pass to
+     * pci_register_root_bus() are not the same as the MemoryRegions
+     * io_mmio_window and io_ioport_window that we expose as SysBus MRs.
+     * The difference is in the behavior of accesses to addresses where no PCI
+     * device has been mapped.
+     *
+     * io_mmio and io_ioport are the underlying PCI view of the PCI address
+     * space, and when a PCI device does a bus master access to a bad address
+     * this is reported back to it as a transaction failure.
+     *
+     * io_mmio_window and io_ioport_window implement "unmapped addresses read as
+     * -1 and ignore writes"; this is a traditional x86 PC behavior, which is
+     * not mandated properly by the PCI spec but expected by the majority of
+     * PCI-using guest software, including Linux.
+     *
+     * We implement it in the PCIe host controller, by providing the *_window
+     * MRs, which are containers with io ops that implement the 'background'
+     * behavior and which hold the real PCI MRs as sub-regions.
+     */
+    memory_region_init(&s->io_mmio, OBJECT(s), "bcm2838_pcie_mmio", UINT64_MAX);
+    memory_region_init(&s->io_ioport, OBJECT(s), "bcm2838_pcie_ioport",
+                       64 * 1024);
+
+    if (s->allow_unmapped_accesses) {
+        memory_region_init_io(&s->io_mmio_window, OBJECT(s),
+                              &unassigned_io_ops, OBJECT(s),
+                              "bcm2838_pcie_mmio_window", UINT64_MAX);
+        memory_region_init_io(&s->io_ioport_window, OBJECT(s),
+                              &unassigned_io_ops, OBJECT(s),
+                              "bcm2838_pcie_ioport_window", 64 * 1024);
+
+        memory_region_add_subregion(&s->io_mmio_window, 0, &s->io_mmio);
+        memory_region_add_subregion(&s->io_ioport_window, 0, &s->io_ioport);
+        sysbus_init_mmio(sbd, &s->io_mmio_window);
+        sysbus_init_mmio(sbd, &s->io_ioport_window);
+    } else {
+        sysbus_init_mmio(sbd, &s->io_mmio);
+        sysbus_init_mmio(sbd, &s->io_ioport);
+    }
+
+    for (i = 0; i < BCM2838_PCIE_NUM_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+        s->irq_num[i] = -1;
+    }
+
+    pci->bus = pci_register_root_bus(dev, "pcie.0", bcm2838_pcie_host_set_irq,
+                                     bcm2838_pcie_host_map_irq, s, &s->io_mmio,
+                                     &s->io_ioport, 0, BCM2838_PCIE_NUM_IRQS,
+                                     TYPE_PCIE_BUS);
+    pci_bus_set_route_irq_fn(pci->bus, bcm2838_pcie_host_route_intx_pin_to_irq);
+    qdev_realize(DEVICE(&s->root_port), BUS(pci->bus), &error_fatal);
+}
+
+static const char *bcm2838_pcie_host_root_bus_path(PCIHostState *host_bridge,
+                                                   PCIBus *rootbus)
+{
+    return "0000:00";
+}
+
+static Property bcm2838_pcie_host_properties[] = {
+    /*
+     * Permit CPU accesses to unmapped areas of the PIO and MMIO windows
+     * (discarding writes and returning -1 for reads) rather than aborting.
+     */
+    DEFINE_PROP_BOOL("allow-unmapped-accesses", BCM2838PcieHostState,
+                     allow_unmapped_accesses, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2838_pcie_host_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
+
+    hc->root_bus_path = bcm2838_pcie_host_root_bus_path;
+    dc->realize = bcm2838_pcie_host_realize;
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->fw_name = "pci";
+    device_class_set_props(dc, bcm2838_pcie_host_properties);
+}
+
+static void bcm2838_pcie_host_initfn(Object *obj)
+{
+    BCM2838PcieHostState *s = BCM2838_PCIE_HOST(obj);
+    BCM2838PcieRootState *root = &s->root_port;
+
+    object_initialize_child(obj, "root_port", root, TYPE_BCM2838_PCIE_ROOT);
+    qdev_prop_set_int32(DEVICE(root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(root), "multifunction", false);
+}
+
+static const TypeInfo bcm2838_pcie_host_info = {
+    .name       = TYPE_BCM2838_PCIE_HOST,
+    .parent     = TYPE_PCIE_HOST_BRIDGE,
+    .instance_size = sizeof(BCM2838PcieHostState),
+    .instance_init = bcm2838_pcie_host_initfn,
+    .class_init = bcm2838_pcie_host_class_init,
+};
+
 /*
  * RC root part (D0:F0)
  */
@@ -60,6 +287,7 @@ static const TypeInfo bcm2838_pcie_root_info = {
 static void bcm2838_pcie_register(void)
 {
     type_register_static(&bcm2838_pcie_root_info);
+    type_register_static(&bcm2838_pcie_host_info);
 }
 
 type_init(bcm2838_pcie_register)
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
index b3d39b808d..14e80fd1d7 100644
--- a/include/hw/arm/bcm2838_pcie.h
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -16,6 +16,9 @@
 #include "hw/pci/pcie_port.h"
 #include "qom/object.h"
 
+#define TYPE_BCM2838_PCIE_HOST "bcm2838-pcie-host"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieHostState, BCM2838_PCIE_HOST)
+
 #define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2838PcieRootState, BCM2838_PCIE_ROOT)
 
@@ -40,5 +43,25 @@ struct BCM2838PcieRootState {
     uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
 };
 
+struct BCM2838PcieHostState {
+    /*< private >*/
+    PCIExpressHost parent_obj;
+
+    /*< public >*/
+    BCM2838PcieRootState root_port;
+
+    MemoryRegion cfg_regs;
+    MemoryRegion io_ioport;
+    MemoryRegion io_mmio;
+    MemoryRegion io_ioport_window;
+    MemoryRegion io_mmio_window;
+
+    qemu_irq irq[BCM2838_PCIE_NUM_IRQS];
+    int irq_num[BCM2838_PCIE_NUM_IRQS];
+
+    bool allow_unmapped_accesses;
+};
+
+int bcm2838_pcie_host_set_irq_num(BCM2838PcieHostState *s, int index, int spi);
 
 #endif /* BCM2838_PCIE_H */
-- 
2.34.1


From f80993ad4495421a19f44043e2b46475d9139a79 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 16/44] Enable BCM2838 PCIE

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 25 +++++++++++++++++++++++++
 hw/arm/meson.build                   |  7 ++++---
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index f689e16535..41b321b254 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -12,6 +12,11 @@
 #include "hw/arm/raspi_platform.h"
 #include "hw/arm/bcm2838_peripherals.h"
 
+#define PCIE_RC_OFFSET          0x1500000
+#define PCIE_MMIO_OFFSET        0xc0000000
+#define PCIE_MMIO_ARM_OFFSET    0x600000000
+#define PCIE_MMIO_SIZE          0x40000000
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -29,6 +34,10 @@ static void bcm2838_peripherals_init(Object *obj)
                        bc->peri_low_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
 
+    /* PCIe Host Bridge */
+    object_initialize_child(obj, "pcie-host", &s->pcie_host,
+                            TYPE_BCM2838_PCIE_HOST);
+
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
@@ -61,6 +70,8 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(dev);
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
     int n;
 
     raspi_peripherals_common_realize(dev, errp);
@@ -172,6 +183,20 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                              BCM2838_MPHI_SIZE);
     memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
                                 &s->mphi_mr_alias);
+    /* PCIe Root Complex */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
+        return;
+    }
+    /* RC registers region */
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 0);
+    memory_region_add_subregion(&s->peri_low_mr, PCIE_RC_OFFSET, regs_mr);
+    /* MMIO region */
+    mmio_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->pcie_host), 1);
+    memory_region_init_alias(&s->pcie_mmio_alias, OBJECT(&s->pcie_host),
+                             "pcie-mmio", mmio_mr, PCIE_MMIO_OFFSET,
+                             PCIE_MMIO_SIZE);
+    memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
+                                &s->pcie_mmio_alias);
 
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 72680fa534..7f1d3b1e12 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -41,7 +41,6 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bana
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
 arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files(
   'bcm2838.c',
-  'bcm2838_pcie.c',
   'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
@@ -72,8 +71,10 @@ arm_ss.add_all(xen_ss)
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
-system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files(
+    'bcm2835_peripherals.c',
+    'bcm2838_peripherals.c',
+    'bcm2838_pcie.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index d2053c9380..115359e451 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -66,7 +66,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporary disable following devices until they are implemented*/
     const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index ebed11dd40..d3e3449b2b 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -64,8 +65,10 @@ struct BCM2838PeripheralState {
     MemoryRegion peri_low_mr;
     MemoryRegion peri_low_mr_alias;
     MemoryRegion mphi_mr_alias;
+    MemoryRegion pcie_mmio_alias;
 
     SDHCIState emmc2;
+    BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
-- 
2.34.1


From 8aefdb03db1849eee2f0b0107211f266222c7228 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 17/44] Add RNG200 skeleton

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2838_rng200.c         | 118 +++++++++++++++++++++++++++++++
 hw/misc/meson.build              |   1 +
 hw/misc/trace-events             |  10 +++
 include/hw/misc/bcm2838_rng200.h |  77 ++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h

diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
new file mode 100644
index 0000000000..a17e8f2cda
--- /dev/null
+++ b/hw/misc/bcm2838_rng200.c
@@ -0,0 +1,118 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/bcm2838_rng200.h"
+#include "trace.h"
+
+static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
+{
+    state->rng_ctrl.value = 0;
+
+    trace_bcm2838_rng200_rng_soft_reset();
+}
+
+static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    uint32_t res = 0;
+
+    trace_bcm2838_rng200_read((void *)offset, size, res);
+    return res;
+}
+
+static void bcm2838_rng200_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+
+    trace_bcm2838_rng200_write((void *)offset, value, size);
+}
+
+static const MemoryRegionOps bcm2838_rng200_ops = {
+    .read = bcm2838_rng200_read,
+    .write = bcm2838_rng200_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    if (s->rng == NULL) {
+        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
+
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend);
+        object_unref(default_backend);
+
+        object_property_set_link(OBJECT(dev), "rng", default_backend,
+                                 errp);
+    }
+
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void bcm2838_rng200_init(Object *obj)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
+                                  NULL, s,
+                                  ClockPreUpdate);
+    if (s->clock == NULL) {
+        error_setg(&error_fatal, "Failed to init RBG clock");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, obj, &bcm2838_rng200_ops, s,
+                          TYPE_BCM2838_RNG200, 0x28);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void bcm2838_rng200_reset(DeviceState *dev)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+    bcm2838_rng200_rng_reset(s);
+}
+
+static Property bcm2838_rng200_properties[] = {
+    DEFINE_PROP_UINT32("rbg-period", BCM2838Rng200State, rbg_period, 250),
+    DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
+    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
+                     TYPE_RNG_BACKEND, RngBackend *),
+    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2838_rng200_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_rng200_realize;
+    dc->reset = bcm2838_rng200_reset;
+    device_class_set_props(dc, bcm2838_rng200_properties);
+}
+
+static const TypeInfo bcm2838_rng200_info = {
+    .name          = TYPE_BCM2838_RNG200,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838Rng200State),
+    .class_init    = bcm2838_rng200_class_init,
+    .instance_init = bcm2838_rng200_init,
+};
+
+static void bcm2838_rng200_register_types(void)
+{
+    type_register_static(&bcm2838_rng200_info);
+}
+
+type_init(bcm2838_rng200_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 892f8b91c5..a6230ced43 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -88,6 +88,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
+  'bcm2838_rng200.c'
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4d1a0e17af..d26cd2d22d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -297,3 +297,13 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# bcm2838_rng200.c
+bcm2838_rng200_rng_soft_reset(void) "========= RNumG SOFT RESET ========="
+bcm2838_rng200_rbg_soft_reset(void) "========= RBitG SOFT RESET ========="
+bcm2838_rng200_enable_rbg(void)     "========= RBitG ENABLED ========="
+bcm2838_rng200_disable_rbg(void)    "========= RBitG DISABLED ========="
+bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
+bcm2838_rng200_fifo_full(void) "========= RNumG FIFO FULL ========="
+bcm2838_rng200_write(void *addr, uint64_t value, unsigned size) "addr %p, value 0x%016" PRIx64 ", size %u"
+bcm2838_rng200_read(void *addr, unsigned size, uint64_t value) "addr %p, size %u, value 0x%016" PRIx64
diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
new file mode 100644
index 0000000000..77f6cd8df4
--- /dev/null
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -0,0 +1,77 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_RNG200_H
+#define BCM2838_RNG200_H
+
+#include <stdbool.h>
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+#include "sysemu/rng.h"
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+#include "hw/qdev-clock.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
+
+typedef union BCM2838Rng200Ctrl {
+    uint32_t value;
+    struct {
+        uint32_t rbg_enable:1;
+        uint32_t __r0:12;
+        uint32_t div:8;
+    };
+} BCM2838Rng200Ctrl;
+
+typedef union BCM2838Rng200Int {
+    uint32_t value;
+    struct {
+        uint32_t total_bits_count_irq:1;
+        uint32_t __r0:4;
+        uint32_t nist_fail_irq:1;
+        uint32_t __r1:11;
+        uint32_t startup_transition_met_irq:1;
+        uint32_t __r2:13;
+        uint32_t master_fail_lockout_irq:1;
+    };
+} BCM2838Rng200Int;
+
+typedef union BCM2838Rng200FifoCount {
+    uint32_t value;
+    struct {
+        uint32_t count:8;
+        uint32_t thld:8;
+    };
+} BCM2838Rng200FifoCount;
+
+struct BCM2838Rng200State {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    ptimer_state *ptimer;
+    RngBackend *rng;
+    Clock *clock;
+
+    uint32_t rbg_period;
+    uint32_t rng_fifo_cap;
+    bool use_timer;
+
+    Fifo8    fifo;
+    qemu_irq irq;
+    BCM2838Rng200Ctrl rng_ctrl;
+    BCM2838Rng200Int rng_int_status;
+    BCM2838Rng200Int rng_int_enable;
+    uint32_t rng_total_bit_count;
+    BCM2838Rng200FifoCount rng_fifo_count;
+    uint32_t rng_bit_count_threshold;
+};
+
+#endif /* BCM2838_RNG200_H */
-- 
2.34.1


From 2648301877cbdf8c613fc003bec693d6f609531b Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 18/44] Add RNG200 RNG and RBG

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2838_rng200.c | 218 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 1 deletion(-)

diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
index a17e8f2cda..bfc40658e2 100644
--- a/hw/misc/bcm2838_rng200.c
+++ b/hw/misc/bcm2838_rng200.c
@@ -8,23 +8,194 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/bcm2838_rng200.h"
 #include "trace.h"
 
+#define RNG_CTRL_OFFSET                      0x00
+#define RNG_SOFT_RESET                       0x01
+#define RNG_SOFT_RESET_OFFSET                0x04
+#define RBG_SOFT_RESET_OFFSET                0x08
+#define RNG_TOTAL_BIT_COUNT_OFFSET           0x0C
+#define RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET 0x10
+#define RNG_INT_STATUS_OFFSET                0x18
+#define RNG_INT_ENABLE_OFFSET                0x1C
+#define RNG_FIFO_DATA_OFFSET                 0x20
+#define RNG_FIFO_COUNT_OFFSET                0x24
+
+#define RNG_WARM_UP_PERIOD_ELAPSED           17
+
+#define BCM2838_RNG200_PTIMER_POLICY         (PTIMER_POLICY_CONTINUOUS_TRIGGER)
+
+static void bcm2838_rng200_update_irq(BCM2838Rng200State *state)
+{
+    qemu_set_irq(state->irq, !!(state->rng_int_enable.value
+                              & state->rng_int_status.value));
+}
+
+static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
+                                       size_t size)
+{
+    BCM2838Rng200State *state = (BCM2838Rng200State *)opaque;
+    Fifo8 *fifo = &state->fifo;
+    size_t num = MIN(size, fifo8_num_free(fifo));
+    uint32_t num_bits = num * 8;
+    uint32_t bit_threshold_left = 0;
+
+    state->rng_total_bit_count += num_bits;
+    if (state->rng_bit_count_threshold > state->rng_total_bit_count) {
+        bit_threshold_left =
+            state->rng_bit_count_threshold - state->rng_total_bit_count;
+    } else {
+        bit_threshold_left = 0;
+    }
+
+    if (bit_threshold_left < num_bits) {
+        num_bits -= bit_threshold_left;
+    } else {
+        num_bits = 0;
+    }
+
+    num = num_bits / 8;
+    if ((num == 0) && (num_bits > 0)) {
+        num = 1;
+    }
+    if (num > 0) {
+        fifo8_push_all(fifo, buf, num);
+
+        if (fifo8_num_used(fifo) > state->rng_fifo_count.thld) {
+            state->rng_int_status.total_bits_count_irq = 1;
+        }
+    }
+
+    state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
+    bcm2838_rng200_update_irq(state);
+    trace_bcm2838_rng200_update_fifo(num, fifo8_num_used(fifo));
+}
+
+static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *state)
+{
+    rng_backend_request_entropy(state->rng,
+                                fifo8_num_free(&state->fifo),
+                                bcm2838_rng200_update_fifo, state);
+}
+
+/* state is temporary unused */
+static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state
+                                       __attribute__((unused)))
+{
+    trace_bcm2838_rng200_disable_rbg();
+}
+
+static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *state)
+{
+    state->rng_total_bit_count = RNG_WARM_UP_PERIOD_ELAPSED;
+
+    bcm2838_rng200_fill_fifo(state);
+
+    trace_bcm2838_rng200_enable_rbg();
+}
+
 static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
 {
     state->rng_ctrl.value = 0;
+    state->rng_total_bit_count = 0;
+    state->rng_bit_count_threshold = 0;
+    state->rng_fifo_count.value = 0;
+    state->rng_int_status.value = 0;
+    state->rng_int_status.startup_transition_met_irq = 1;
+    state->rng_int_enable.value = 0;
+    fifo8_reset(&state->fifo);
 
     trace_bcm2838_rng200_rng_soft_reset();
 }
 
+static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *state)
+{
+    trace_bcm2838_rng200_rbg_soft_reset();
+}
+
+static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
+{
+    Fifo8 *fifo = &state->fifo;
+    const uint8_t *buf;
+    uint32_t ret = 0;
+    uint32_t num = 0;
+    uint32_t max = MIN(fifo8_num_used(fifo), sizeof(ret));
+
+    if (max > 0) {
+        buf = fifo8_pop_buf(fifo, max, &num);
+        if ((buf != NULL) && (num > 0)) {
+            memcpy(&ret, buf, num);
+        }
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read_fifo_data: FIFO is empty\n"
+        );
+    }
+
+    state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
+    bcm2838_rng200_fill_fifo(state);
+
+    return ret;
+}
+
+static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint64_t value)
+{
+    bool rng_enable = s->rng_ctrl.rbg_enable;
+
+    s->rng_ctrl.value = value;
+    if (!s->rng_ctrl.rbg_enable && rng_enable) {
+        bcm2838_rng200_disable_rbg(s);
+    } else if (s->rng_ctrl.rbg_enable && !rng_enable) {
+        bcm2838_rng200_enable_rbg(s);
+    }
+}
+
 static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
                                     unsigned size)
 {
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
     uint32_t res = 0;
 
+    switch (offset) {
+    case RNG_CTRL_OFFSET:
+        res = s->rng_ctrl.value;
+        break;
+    case RNG_SOFT_RESET_OFFSET:
+    case RBG_SOFT_RESET_OFFSET:
+        break;
+    case RNG_INT_STATUS_OFFSET:
+        res = s->rng_int_status.value;
+        break;
+    case RNG_INT_ENABLE_OFFSET:
+        res = s->rng_int_enable.value;
+        break;
+    case RNG_FIFO_DATA_OFFSET:
+        res = bcm2838_rng200_read_fifo_data(s);
+        break;
+    case RNG_FIFO_COUNT_OFFSET:
+        res = s->rng_fifo_count.value;
+        break;
+    case RNG_TOTAL_BIT_COUNT_OFFSET:
+        res = s->rng_total_bit_count;
+        break;
+    case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
+        res = s->rng_bit_count_threshold;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_read: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        res = 0;
+        break;
+    }
+
     trace_bcm2838_rng200_read((void *)offset, size, res);
     return res;
 }
@@ -32,8 +203,50 @@ static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
 static void bcm2838_rng200_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
 
     trace_bcm2838_rng200_write((void *)offset, value, size);
+
+    switch (offset) {
+    case RNG_CTRL_OFFSET:
+        bcm2838_rng200_ctrl_write(s, value);
+        break;
+    case RNG_SOFT_RESET_OFFSET:
+        if (value & RNG_SOFT_RESET) {
+            bcm2838_rng200_rng_reset(s);
+        }
+        break;
+    case RBG_SOFT_RESET_OFFSET:
+        if (value & RNG_SOFT_RESET) {
+            bcm2838_rng200_rbg_reset(s);
+        }
+        break;
+    case RNG_INT_STATUS_OFFSET:
+        s->rng_int_status.value &= ~value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case RNG_INT_ENABLE_OFFSET:
+        s->rng_int_enable.value = value;
+        bcm2838_rng200_update_irq(s);
+        break;
+    case RNG_FIFO_COUNT_OFFSET:
+        {
+            BCM2838Rng200FifoCount tmp = {.value = value};
+            s->rng_fifo_count.thld = tmp.thld;
+        }
+        break;
+    case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
+        s->rng_bit_count_threshold = value;
+        s->rng_total_bit_count = value + 1;
+        break;
+    default:
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "bcm2838_rng200_write: Bad offset 0x%" HWADDR_PRIx "\n",
+            offset
+        );
+        break;
+    }
 }
 
 static const MemoryRegionOps bcm2838_rng200_ops = {
@@ -57,6 +270,7 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
                                  errp);
     }
 
+    fifo8_create(&s->fifo, s->rng_fifo_cap);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
 
@@ -81,6 +295,8 @@ static void bcm2838_rng200_init(Object *obj)
 static void bcm2838_rng200_reset(DeviceState *dev)
 {
     BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    bcm2838_rng200_rbg_reset(s);
     bcm2838_rng200_rng_reset(s);
 }
 
@@ -89,7 +305,7 @@ static Property bcm2838_rng200_properties[] = {
     DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
     DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
                      TYPE_RNG_BACKEND, RngBackend *),
-    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),
+    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


From 608e2daf57d37a889b23ae36544303632c46e32b Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 19/44] Add RNG200 timer

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         |  14 ++++
 hw/arm/raspi4b.c                     |   1 -
 hw/misc/bcm2838_rng200.c             | 105 ++++++++++++++++++++++++---
 include/hw/arm/bcm2838_peripherals.h |   2 +
 4 files changed, 111 insertions(+), 11 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 41b321b254..df97953bbe 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -34,6 +34,9 @@ static void bcm2838_peripherals_init(Object *obj)
                        bc->peri_low_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -84,6 +87,17 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, RNG_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
+        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_RNG));
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 115359e451..82b6b48d3c 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -66,7 +66,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporary disable following devices until they are implemented*/
     const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
index bfc40658e2..face1e9579 100644
--- a/hw/misc/bcm2838_rng200.c
+++ b/hw/misc/bcm2838_rng200.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/bcm2838_rng200.h"
@@ -35,6 +36,15 @@ static void bcm2838_rng200_update_irq(BCM2838Rng200State *state)
                               & state->rng_int_status.value));
 }
 
+static void bcm2838_rng200_update_rbg_period(void *opaque, ClockEvent event)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_set_period_from_clock(s->ptimer, s->clock, s->rng_fifo_cap * 8);
+    ptimer_transaction_commit(s->ptimer);
+}
+
 static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
                                        size_t size)
 {
@@ -62,10 +72,11 @@ static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
     if ((num == 0) && (num_bits > 0)) {
         num = 1;
     }
-    if (num > 0) {
+    if (!state->use_timer || (num > 0)) {
         fifo8_push_all(fifo, buf, num);
 
-        if (fifo8_num_used(fifo) > state->rng_fifo_count.thld) {
+        if (!state->use_timer
+                || (fifo8_num_used(fifo) > state->rng_fifo_count.thld)) {
             state->rng_int_status.total_bits_count_irq = 1;
         }
     }
@@ -82,10 +93,14 @@ static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *state)
                                 bcm2838_rng200_update_fifo, state);
 }
 
-/* state is temporary unused */
-static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state
-                                       __attribute__((unused)))
+static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *state)
 {
+    if (state->use_timer) {
+        ptimer_transaction_begin(state->ptimer);
+        ptimer_stop(state->ptimer);
+        ptimer_transaction_commit(state->ptimer);
+    }
+
     trace_bcm2838_rng200_disable_rbg();
 }
 
@@ -93,11 +108,38 @@ static void bcm2838_rng200_enable_rbg(BCM2838Rng200State *state)
 {
     state->rng_total_bit_count = RNG_WARM_UP_PERIOD_ELAPSED;
 
-    bcm2838_rng200_fill_fifo(state);
+    if (state->use_timer) {
+        uint32_t div = state->rng_ctrl.div + 1;
+
+        ptimer_transaction_begin(state->ptimer);
+        ptimer_set_limit(state->ptimer, div, 1);
+        ptimer_set_count(state->ptimer, div);
+        ptimer_run(state->ptimer, 0);
+        ptimer_transaction_commit(state->ptimer);
+    } else {
+        bcm2838_rng200_fill_fifo(state);
+    }
 
     trace_bcm2838_rng200_enable_rbg();
 }
 
+static void bcm2838_rng200_ptimer_cb(void *arg)
+{
+    BCM2838Rng200State *state = (BCM2838Rng200State *)arg;
+    Fifo8 *fifo = &state->fifo;
+    size_t size = fifo8_num_free(fifo);
+
+    assert(state->rng_ctrl.rbg_enable);
+
+    if (size > 0) {
+        rng_backend_request_entropy(state->rng, size,
+                                    bcm2838_rng200_update_fifo, state);
+    } else {
+        ptimer_stop(state->ptimer);
+        trace_bcm2838_rng200_fifo_full();
+    }
+}
+
 static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
 {
     state->rng_ctrl.value = 0;
@@ -129,6 +171,12 @@ static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
         buf = fifo8_pop_buf(fifo, max, &num);
         if ((buf != NULL) && (num > 0)) {
             memcpy(&ret, buf, num);
+
+            if (state->rng_ctrl.rbg_enable && state->use_timer) {
+                ptimer_transaction_begin(state->ptimer);
+                ptimer_run(state->ptimer, 0);
+                ptimer_transaction_commit(state->ptimer);
+            }
         }
     } else {
         qemu_log_mask(
@@ -138,7 +186,10 @@ static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *state)
     }
 
     state->rng_fifo_count.count = fifo8_num_used(fifo) >> 2;
-    bcm2838_rng200_fill_fifo(state);
+
+    if (!state->use_timer) {
+        bcm2838_rng200_fill_fifo(state);
+    }
 
     return ret;
 }
@@ -237,7 +288,11 @@ static void bcm2838_rng200_write(void *opaque, hwaddr offset,
         break;
     case RNG_TOTAL_BIT_COUNT_THRESHOLD_OFFSET:
         s->rng_bit_count_threshold = value;
-        s->rng_total_bit_count = value + 1;
+        if (s->use_timer) {
+            s->rng_total_bit_count = 0;
+        } else {
+            s->rng_total_bit_count = value + 1;
+        }
         break;
     default:
         qemu_log_mask(
@@ -253,15 +308,39 @@ static const MemoryRegionOps bcm2838_rng200_ops = {
     .read = bcm2838_rng200_read,
     .write = bcm2838_rng200_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+    },
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4
+    },
 };
 
 static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
 {
     BCM2838Rng200State *s = BCM2838_RNG200(dev);
 
+    if (s->use_timer) {
+        s->ptimer = ptimer_init(bcm2838_rng200_ptimer_cb, s,
+                                BCM2838_RNG200_PTIMER_POLICY);
+        if (s->ptimer == NULL) {
+            error_setg(&error_fatal, "Failed to init RBG timer");
+            return;
+        }
+    }
+
     if (s->rng == NULL) {
         Object *default_backend = object_new(TYPE_RNG_BUILTIN);
 
+        if (!user_creatable_complete(USER_CREATABLE(default_backend),
+                                     errp)) {
+            object_unref(default_backend);
+            error_setg(errp, "Failed to create user creatable RNG backend");
+            return;
+        }
+
         object_property_add_child(OBJECT(dev), "default-backend",
                                   default_backend);
         object_unref(default_backend);
@@ -270,6 +349,12 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
                                  errp);
     }
 
+    if (s->use_timer && !clock_has_source(s->clock)) {
+        ptimer_transaction_begin(s->ptimer);
+        ptimer_set_period(s->ptimer, s->rbg_period * s->rng_fifo_cap * 8);
+        ptimer_transaction_commit(s->ptimer);
+    }
+
     fifo8_create(&s->fifo, s->rng_fifo_cap);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
@@ -280,7 +365,7 @@ static void bcm2838_rng200_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
     s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
-                                  NULL, s,
+                                  bcm2838_rng200_update_rbg_period, s,
                                   ClockPreUpdate);
     if (s->clock == NULL) {
         error_setg(&error_fatal, "Failed to init RBG clock");
@@ -305,7 +390,7 @@ static Property bcm2838_rng200_properties[] = {
     DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
     DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
                      TYPE_RNG_BACKEND, RngBackend *),
-    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, false),
+    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index d3e3449b2b..d52617f3bd 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
@@ -67,6 +68,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
     MemoryRegion pcie_mmio_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
-- 
2.34.1


From a1ff0a9db64b485765e5dd7f9e74ad44b3017f68 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 20/44] Implement BCM2838 thermal sensor

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 12 ++++
 hw/arm/raspi4b.c                     |  1 -
 hw/misc/bcm2838_thermal.c            | 96 ++++++++++++++++++++++++++++
 hw/misc/meson.build                  |  3 +-
 include/hw/arm/bcm2838_peripherals.h |  2 +
 include/hw/misc/bcm2838_thermal.h    | 24 +++++++
 6 files changed, 136 insertions(+), 2 deletions(-)
 create mode 100644 hw/misc/bcm2838_thermal.c
 create mode 100644 include/hw/misc/bcm2838_thermal.h

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index df97953bbe..e7a9db97ab 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -37,6 +37,9 @@ static void bcm2838_peripherals_init(Object *obj)
     /* Random Number Generator */
     object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
 
+    /* Thermal */
+    object_initialize_child(obj, "thermal", &s->thermal, TYPE_BCM2838_THERMAL);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -98,6 +101,14 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
         qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_RNG));
 
+    /* THERMAL */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->thermal), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s->peri_low_mr, 0x15D2000,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->thermal), 0));
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
@@ -197,6 +208,7 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                              BCM2838_MPHI_SIZE);
     memory_region_add_subregion(&s_base->peri_mr, BCM2838_MPHI_OFFSET,
                                 &s->mphi_mr_alias);
+
     /* PCIe Root Complex */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->pcie_host), errp)) {
         return;
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 82b6b48d3c..c7fdf791d5 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -66,7 +66,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporary disable following devices until they are implemented*/
     const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
 
diff --git a/hw/misc/bcm2838_thermal.c b/hw/misc/bcm2838_thermal.c
new file mode 100644
index 0000000000..a488dc3da1
--- /dev/null
+++ b/hw/misc/bcm2838_thermal.c
@@ -0,0 +1,96 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/misc/bcm2838_thermal.h"
+#include "hw/registerfields.h"
+#include "migration/vmstate.h"
+#include "qemu/error-report.h"
+
+REG32(STAT, 0x200)
+FIELD(STAT, DATA, 0, 10)
+FIELD(STAT, VALID_1, 10, 1)
+FIELD(STAT, VALID_2, 16, 1)
+
+#define BCM2838_THERMAL_SIZE 0xf00
+
+#define THERMAL_OFFSET_C 410040
+#define THERMAL_COEFF  (-487.0f)
+#define MILLIDEGREE_COEFF 1000
+
+static uint16_t bcm2838_thermal_temp2adc(int temp_C)
+{
+    return (temp_C * MILLIDEGREE_COEFF - THERMAL_OFFSET_C) / THERMAL_COEFF;
+}
+
+static uint64_t bcm2838_thermal_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val = 0;
+
+    switch (addr) {
+    case A_STAT:
+        /* Temperature is always 25°C */
+         val = FIELD_DP32(val, STAT, DATA, bcm2838_thermal_temp2adc(25));
+         val = FIELD_DP32(val, STAT, VALID_1, 1);
+         val = FIELD_DP32(val, STAT, VALID_2, 1);
+
+         break;
+    default:
+         /* MemoryRegionOps are aligned, so this can not happen. */
+         warn_report("%s can't access addr: 0x%"PRIx64,
+                     TYPE_BCM2838_THERMAL, addr);
+         g_assert_not_reached();
+    }
+    return val;
+}
+
+static const MemoryRegionOps bcm2838_thermal_ops = {
+    .read = bcm2838_thermal_read,
+    .impl.max_access_size = 4,
+    .valid.min_access_size = 4,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2838_thermal_realize(DeviceState *dev, Error **errp)
+{
+    Bcm2838ThermalState *s = BCM2838_THERMAL(dev);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &bcm2838_thermal_ops,
+                          s, TYPE_BCM2838_THERMAL, BCM2838_THERMAL_SIZE);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
+}
+
+static const VMStateDescription bcm2838_thermal_vmstate = {
+    .name = TYPE_BCM2838_THERMAL,
+    .version_id = 1,
+    .minimum_version_id = 1,
+};
+
+static void bcm2838_thermal_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_thermal_realize;
+    dc->vmsd = &bcm2838_thermal_vmstate;
+}
+
+static const TypeInfo bcm2838_thermal_info = {
+    .name = TYPE_BCM2838_THERMAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Bcm2838ThermalState),
+    .class_init = bcm2838_thermal_class_init,
+};
+
+static void bcm2838_thermal_register_types(void)
+{
+    type_register_static(&bcm2838_thermal_info);
+}
+
+type_init(bcm2838_thermal_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index a6230ced43..dc67e6be3c 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -88,7 +88,8 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
-  'bcm2838_rng200.c'
+  'bcm2838_rng200.c',
+  'bcm2838_thermal.c'
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index d52617f3bd..bb26aceb13 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -11,6 +11,7 @@
 
 #include "hw/arm/bcm2835_peripherals.h"
 #include "hw/misc/bcm2838_rng200.h"
+#include "hw/misc/bcm2838_thermal.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
@@ -69,6 +70,7 @@ struct BCM2838PeripheralState {
     MemoryRegion pcie_mmio_alias;
 
     BCM2838Rng200State rng200;
+    Bcm2838ThermalState thermal;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
diff --git a/include/hw/misc/bcm2838_thermal.h b/include/hw/misc/bcm2838_thermal.h
new file mode 100644
index 0000000000..bb6302a037
--- /dev/null
+++ b/include/hw/misc/bcm2838_thermal.h
@@ -0,0 +1,24 @@
+/*
+ * BCM2838 dummy thermal sensor
+ *
+ * Copyright (C) 2022 Maksim Kopusov <maksim.kopusov@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_THERMAL_H
+#define BCM2838_THERMAL_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_THERMAL "bcm2838-thermal"
+OBJECT_DECLARE_SIMPLE_TYPE(Bcm2838ThermalState, BCM2838_THERMAL)
+
+struct Bcm2838ThermalState {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+};
+
+#endif /* BCM2838_THERMAL_H */
-- 
2.34.1


From efb4e209f7a7b83d38b91eea85f2c769fa3e6dc1 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 21/44] Add clock_isp stub

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 6 ++++++
 include/hw/arm/bcm2838_peripherals.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index e7a9db97ab..60ed535673 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -17,6 +17,9 @@
 #define PCIE_MMIO_ARM_OFFSET    0x600000000
 #define PCIE_MMIO_SIZE          0x40000000
 
+#define CLOCK_ISP_OFFSET        0xc11000
+#define CLOCK_ISP_SIZE          0x100
+
 /* Lower peripheral base address on the VC (GPU) system bus */
 #define BCM2838_VC_PERI_LOW_BASE 0x7c000000
 
@@ -224,6 +227,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
+                 CLOCK_ISP_SIZE);
+
     /* GPIO */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
         return;
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index bb26aceb13..be4fc20f11 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -72,6 +72,7 @@ struct BCM2838PeripheralState {
     BCM2838Rng200State rng200;
     Bcm2838ThermalState thermal;
     SDHCIState emmc2;
+    UnimplementedDeviceState clkisp;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
 
-- 
2.34.1


From d68f7b8a3bb0c4823ecb9dc43c41146e86f60b8d Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 22/44] Add GENET stub

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 100 +++++++++++++++++++++++++++++++++
 hw/net/meson.build             |   2 +
 hw/net/trace-events            |  17 ++++++
 include/hw/net/bcm2838_genet.h |  40 +++++++++++++
 4 files changed, 159 insertions(+)
 create mode 100644 hw/net/bcm2838_genet.c
 create mode 100644 include/hw/net/bcm2838_genet.h

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
new file mode 100644
index 0000000000..c3e7d90451
--- /dev/null
+++ b/hw/net/bcm2838_genet.c
@@ -0,0 +1,100 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/log.h"
+#include "qemu/error-report.h"
+#include "net/eth.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "net/checksum.h"
+#include "sysemu/dma.h"
+#include "hw/net/bcm2838_genet.h"
+#include "trace.h"
+
+
+static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
+{
+    uint64_t value = ~0;
+
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+
+    trace_bcm2838_genet_read(size, offset, value);
+    return value;
+}
+
+static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
+                                unsigned size) {
+    qemu_log_mask(
+        LOG_GUEST_ERROR,
+        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+        __func__, size, offset);
+}
+
+static const MemoryRegionOps bcm2838_genet_ops = {
+    .read = bcm2838_genet_read,
+    .write = bcm2838_genet_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {.max_access_size = sizeof(uint32_t)},
+    .valid = {.min_access_size = sizeof(uint32_t)},
+};
+
+
+static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838GenetState *s = BCM2838_GENET(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    /* Controller registers */
+    memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
+                          "bcm2838_genet_regs", sizeof(s->regs));
+    sysbus_init_mmio(sbd, &s->regs_mr);
+}
+
+static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
+{
+    /* Temporary unimplemented */
+    trace_bcm2838_genet_phy_reset("done");
+}
+
+static void bcm2838_genet_reset(DeviceState *d)
+{
+    BCM2838GenetState *s = BCM2838_GENET(d);
+
+    memset(&s->regs, 0x00, sizeof(s->regs));
+
+    trace_bcm2838_genet_reset("done");
+
+    bcm2838_genet_phy_reset(s);
+}
+
+static void bcm2838_genet_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+
+    dc->realize = bcm2838_genet_realize;
+    dc->reset = bcm2838_genet_reset;
+}
+
+static const TypeInfo bcm2838_genet_info = {
+    .name       = TYPE_BCM2838_GENET,
+    .parent     = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838GenetState),
+    .class_init = bcm2838_genet_class_init,
+};
+
+static void bcm2838_genet_register(void)
+{
+    type_register_static(&bcm2838_genet_info);
+}
+
+type_init(bcm2838_genet_register)
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 2632634df3..9bb01f45e2 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -72,4 +72,6 @@ system_ss.add(when: 'CONFIG_ROCKER', if_true: files(
 system_ss.add(when: 'CONFIG_ALL', if_true: files('rocker/qmp-norocker.c'))
 system_ss.add(files('rocker/rocker-hmp-cmds.c'))
 
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_genet.c'))
+
 subdir('can')
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 6b5ba669a2..f9e4f76776 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -480,3 +480,20 @@ dp8393x_receive_oversize(int size) "oversize packet, pkt_size is %d"
 dp8393x_receive_not_netcard(void) "packet not for netcard"
 dp8393x_receive_packet(int crba) "Receive packet at 0x%"PRIx32
 dp8393x_receive_write_status(int crba) "Write status at 0x%"PRIx32
+
+# bcm2838_genet.c
+bcm2838_genet_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04" PRIx64 ": 0x%016" PRIx64
+bcm2838_genet_can_receive(const char *state) "receive is %s"
+bcm2838_genet_receive(ssize_t bytes_received) "%ld bytes received"
+bcm2838_genet_phy_update_link(const char *link_state) "link is %s"
+bcm2838_genet_phy_reset(const char *status) "PHY reset %s"
+bcm2838_genet_reset(const char *status) "MAC reset %s"
+bcm2838_genet_mac_address(const char *info) "%s"
+bcm2838_genet_tx_dma(const char *dma_state) "TX DMA %s"
+bcm2838_genet_tx_dma_ring(uint32_t ring_en) "TX DMA enabled rings: 0x%05x"
+bcm2838_genet_tx_dma_ring_buf(uint32_t ring_buf_en) "TX DMA enabled ring buffers: 0x%05x"
+bcm2838_genet_tx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
+bcm2838_genet_tx_request(unsigned int ring_idx, uint32_t prod_idx, uint32_t cons_idx) "ring %u, PROD_INDEX %u, CONS_INDEX %u"
+bcm2838_genet_tx(unsigned int ring_idx, uint64_t desc_idx, uint32_t desc_status, uint64_t data_addr) "ring %u, descriptor %" PRIu64 ": 0x%08x, data @ 0x%08" PRIx64
+bcm2838_genet_rx_dma_ring_active(unsigned int ring, const char *ring_state) "ring %u is %s"
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
new file mode 100644
index 0000000000..f62b24fa2f
--- /dev/null
+++ b/include/hw/net/bcm2838_genet.h
@@ -0,0 +1,40 @@
+/*
+ * BCM2838 Gigabit Ethernet emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_GENET_H
+#define BCM2838_GENET_H
+
+#include "net/net.h"
+#include "hw/sysbus.h"
+
+#define TYPE_BCM2838_GENET "bcm2838-genet"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
+
+#define BCM2838_GENET_REV_MAJOR         6
+#define BCM2838_GENET_REV_MINOR         0
+
+typedef struct {
+    uint8_t stub_area[0x10000]; /* temporary stub */
+} __attribute__((__packed__)) BCM2838GenetRegs;
+
+struct BCM2838GenetState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+
+    MemoryRegion regs_mr;
+    AddressSpace dma_as;
+
+    BCM2838GenetRegs regs;
+
+    qemu_irq irq_default;
+    qemu_irq irq_prio;
+};
+
+#endif /* BCM2838_GENET_H */
-- 
2.34.1


From 948d7ecff2bd0bca469d121efc7c109e13d25d65 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 23/44] Add GENET register structs. Part 1

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 125 ++++++++++++++++++++++++++++++++-
 1 file changed, 124 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index f62b24fa2f..89b45eb39f 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,8 +18,131 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t gphy_rev:16;
+        uint32_t minor_rev:4;
+        uint32_t reserved_20_23:4;
+        uint32_t major_rev:4;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetSysRevCtrl;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t scb:1;
+        uint32_t ephy:1;
+        uint32_t phy_det_r:1;
+        uint32_t phy_det_f:1;
+        uint32_t link_up:1;
+        uint32_t link_down:1;
+        uint32_t umac:1;
+        uint32_t umac_tsv:1;
+        uint32_t tbuf_underrun:1;
+        uint32_t rbuf_overflow:1;
+        uint32_t hfb_sm:1;
+        uint32_t hfb_mm:1;
+        uint32_t mpd_r:1;
+        uint32_t rxdma_mbdone:1;
+        uint32_t rxdma_pdone:1;
+        uint32_t rxdma_bdone:1;
+        uint32_t txdma_mbdone:1;
+        uint32_t txdma_pdone:1;
+        uint32_t txdma_bdone:1;
+        uint32_t reserved_19_22:4;
+        uint32_t mdio_done:1;
+        uint32_t mdio_error:1;
+        uint32_t reserved_25_31:7;
+    } fields;
+} BCM2838GenetIntrl0;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t tx_intrs:16;
+        uint32_t rx_intrs:16;
+    } fields;
+} BCM2838GenetIntrl1;
+
+typedef struct {
+    BCM2838GenetSysRevCtrl rev_ctrl;
+    uint32_t port_ctrl;
+    uint32_t rbuf_flush_ctrl;
+    uint32_t tbuf_flush_ctrl;
+    uint8_t reserved_0x10[0x30];
+} __attribute__((__packed__)) BCM2838GenetRegsSys;
+
+typedef struct {
+    uint8_t reserved_0x0[0x40];
+} __attribute__((__packed__)) BCM2838GenetRegsGrBridge;
+
+typedef struct {
+    uint32_t pwr_mgmt;
+    uint8_t reserved_0x4[0x8];
+    uint32_t rgmii_oob_ctrl;
+    uint8_t reserved_0x10[0xC];
+    uint32_t gphy_ctrl;
+    uint8_t reserved_0x20[0x60];
+} __attribute__((__packed__)) BCM2838GenetRegsExt;
+
+typedef struct {
+    BCM2838GenetIntrl0 stat;
+    BCM2838GenetIntrl0 set;
+    BCM2838GenetIntrl0 clear;
+    BCM2838GenetIntrl0 mask_status;
+    BCM2838GenetIntrl0 mask_set;
+    BCM2838GenetIntrl0 mask_clear;
+    uint8_t reserved_0x18[0x28];
+} __attribute__((__packed__)) BCM2838GenetRegsIntrl0;
+
+typedef struct {
+    BCM2838GenetIntrl1 stat;
+    BCM2838GenetIntrl1 set;
+    BCM2838GenetIntrl1 clear;
+    BCM2838GenetIntrl1 mask_status;
+    BCM2838GenetIntrl1 mask_set;
+    BCM2838GenetIntrl1 mask_clear;
+    uint8_t reserved_0x18[0x28];
+} __attribute__((__packed__)) BCM2838GenetRegsIntrl1;
+
+typedef struct {
+    uint32_t ctrl;
+    uint8_t reserved_0x4[0x8];
+    uint32_t status;
+    uint8_t reserved_0x10[0x4];
+    uint32_t chk_ctrl;
+    uint8_t reserved_0x18[0x7C];
+    uint32_t ovfl_cnt;
+    uint32_t err_cnt;
+    uint32_t energy_ctrl;
+    uint8_t reserved_0xA0[0x14];
+    uint32_t size_ctrl;
+    uint8_t reserved_0xB8[0x48];
+} __attribute__((__packed__)) BCM2838GenetRegsRbuf;
+
+typedef struct {
+    uint32_t ctrl;
+    uint8_t reserved_0x4[0x8];
+    uint32_t bp_mc;
+    uint8_t reserved_0x10[0x4];
+    uint32_t energy_ctrl;
+    uint8_t reserved_0x18[0xE8];
+} __attribute__((__packed__)) BCM2838GenetRegsTbuf;
+
 typedef struct {
-    uint8_t stub_area[0x10000]; /* temporary stub */
+    BCM2838GenetRegsSys sys;
+    BCM2838GenetRegsGrBridge gr_bridge;
+    BCM2838GenetRegsExt ext;
+    uint8_t reserved_0x100[0x100];
+    BCM2838GenetRegsIntrl0 intrl0;
+    BCM2838GenetRegsIntrl1 intrl1;
+    uint8_t reserved_0x280[0x80];
+    BCM2838GenetRegsRbuf rbuf;
+    uint8_t reserved_0x400[0x200];
+    BCM2838GenetRegsTbuf tbuf;
+    uint8_t reserved_0x700[0x100];
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.34.1


From be7ce41443c7745b862c6029be43ffe1488c18e9 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 24/44] Add GENET register structs. Part 2

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 218 +++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 89b45eb39f..4542f27eba 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -18,6 +18,10 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_REV_MAJOR         6
 #define BCM2838_GENET_REV_MINOR         0
 
+#define BCM2838_GENET_DMA_DESC_CNT      256
+#define BCM2838_GENET_DMA_RING_CNT      17
+#define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
+
 typedef union {
     uint32_t value;
     struct {
@@ -66,6 +70,135 @@ typedef union {
     } fields;
 } BCM2838GenetIntrl1;
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t tx_en:1;
+        uint32_t rx_en:1;
+        uint32_t speed:2;
+        uint32_t promisc:1;
+        uint32_t pad_en:1;
+        uint32_t crc_fwd:1;
+        uint32_t pause_fwd:1;
+        uint32_t rx_pause_ignore:1;
+        uint32_t tx_addr_ins:1;
+        uint32_t hd_en:1;
+        uint32_t sw_reset_old:1;
+        uint32_t reserved_12:1;
+        uint32_t sw_reset:1;
+        uint32_t reserved_14:1;
+        uint32_t lcl_loop_en:1;
+        uint32_t reserved_16_21:6;
+        uint32_t auto_config:1;
+        uint32_t cntl_frm_en:1;
+        uint32_t no_len_chk:1;
+        uint32_t rmt_loop_en:1;
+        uint32_t rx_err_disc:1;
+        uint32_t prbl_en:1;
+        uint32_t tx_pause_ignore:1;
+        uint32_t tx_rx_en:1;
+        uint32_t runt_filter_dis:1;
+        uint32_t reserved_31:1;
+    } fields;
+} BCM2838GenetUmacCmd;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t addr_3:8;
+        uint32_t addr_2:8;
+        uint32_t addr_1:8;
+        uint32_t addr_0:8;
+    } fields;
+} BCM2838GenetUmacMac0;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t addr_5:8;
+        uint32_t addr_4:8;
+        uint32_t reserved_16_31:16;
+    } fields;
+} BCM2838GenetUmacMac1;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t reg_data:16;
+        uint32_t reg_id:5;
+        uint32_t phy_id:5;
+        uint32_t wr:1;
+        uint32_t rd:1;
+        uint32_t rd_fail:1;
+        uint32_t start_busy:1;
+        uint32_t reserved_30_31:2;
+    } fields;
+} BCM2838GenetUmacMdioCmd;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t en:17;
+        uint32_t reserved_17_31:15;
+    } fields;
+} BCM2838GenetDmaRingCfg;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t en:1;
+        uint32_t ring_buf_en:17;
+        uint32_t reserved_18_19:2;
+        uint32_t tsb_swap_en:1;
+        uint32_t reserved_21_31:11;
+    } fields;
+} BCM2838GenetDmaCtrl;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t index:16;
+        uint32_t discard_cnt:16;
+    } fields;
+} BCM2838GenetDmaProdIndex;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t index:16;
+        uint32_t reserved_16_31:16;
+    } fields;
+} BCM2838GenetDmaConsIndex;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t disabled:1;
+        uint32_t desc_ram_init_busy:1;
+        uint32_t reserved_2_31:30;
+    } fields;
+} BCM2838GenetDmaStatus;
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t overrun:1;
+        uint32_t crc_error:1;
+        uint32_t rxerr:1;
+        uint32_t no:1;
+        uint32_t lg:1;
+        uint32_t multicast:1;
+        uint32_t broadcast:1;
+        uint32_t reserved_7_11:5;
+        uint32_t wrap:1;
+        uint32_t sop:1;
+        uint32_t eop:1;
+        uint32_t own:1;
+        uint32_t buflength:12;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetRdmaLengthStatus;
+
 typedef struct {
     BCM2838GenetSysRevCtrl rev_ctrl;
     uint32_t port_ctrl;
@@ -131,6 +264,88 @@ typedef struct {
     uint8_t reserved_0x18[0xE8];
 } __attribute__((__packed__)) BCM2838GenetRegsTbuf;
 
+typedef struct {
+    uint8_t reserved_0x0[0x4];
+    uint32_t hd_bkp_ctrl;
+    BCM2838GenetUmacCmd cmd;
+    BCM2838GenetUmacMac0 mac0;
+    BCM2838GenetUmacMac1 mac1;
+    uint32_t max_frame_len;
+    uint32_t pause_quanta;
+    uint8_t reserved_0x1C[0x28];
+    uint32_t mode;
+    uint32_t frm_tag0;
+    uint32_t frm_tag1;
+    uint8_t reserved_0x50[0xC];
+    uint32_t tx_ipg_len;
+    uint8_t reserved_0x60[0x4];
+    uint32_t eee_ctrl;
+    uint32_t eee_lpi_timer;
+    uint32_t eee_wake_timer;
+    uint32_t eee_ref_count;
+    uint8_t reserved_0x74[0x4];
+    uint32_t rx_ipg_inv;
+    uint8_t reserved_0x7C[0x294];
+    uint32_t macsec_prog_tx_crc;
+    uint32_t macsec_ctrl;
+    uint8_t reserved_0x318[0x18];
+    uint32_t pause_ctrl;
+    uint32_t tx_flush;
+    uint32_t rx_fifo_status;
+    uint32_t tx_fifo_status;
+    uint8_t reserved_0x340[0xC0];
+    uint8_t mib[0x180];
+    uint32_t mib_ctrl;
+    uint8_t reserved_0x584[0x90];
+    BCM2838GenetUmacMdioCmd mdio_cmd;
+    uint8_t reserved_0x618[0x8];
+    uint32_t mpd_ctrl;
+    uint32_t mpd_pw_ms;
+    uint32_t mpd_pw_ls;
+    uint8_t reserved_0x62C[0xC];
+    uint32_t mdf_err_cnt;
+    uint8_t reserved_0x63C[0x14];
+    uint32_t mdf_ctrl;
+    uint32_t mdf_addr;
+    uint8_t reserved_0x658[0x1A8];
+} __attribute__((__packed__)) BCM2838GenetRegsUmac;
+
+typedef struct {
+    BCM2838GenetRdmaLengthStatus length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} __attribute__((__packed__)) BCM2838GenetRdmaDesc;
+
+typedef struct {
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    BCM2838GenetDmaProdIndex prod_index;
+    BCM2838GenetDmaConsIndex cons_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t xon_xoff_tresh;
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    uint8_t reserved_0x34[0xC];
+} __attribute__((__packed__)) BCM2838GenetRdmaRing;
+
+typedef struct {
+    BCM2838GenetRdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetRdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    BCM2838GenetDmaRingCfg ring_cfg;
+    BCM2838GenetDmaCtrl ctrl;
+    BCM2838GenetDmaStatus status;
+    uint32_t scb_burst_size;
+    uint8_t reserved_0x1050[0x1C];
+    uint32_t ring_timeout[17];
+    uint32_t index2ring[8];
+    uint8_t reserved_0x10D0[0xF30];
+} __attribute__((__packed__)) BCM2838GenetRegsRdma;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -143,6 +358,9 @@ typedef struct {
     uint8_t reserved_0x400[0x200];
     BCM2838GenetRegsTbuf tbuf;
     uint8_t reserved_0x700[0x100];
+    BCM2838GenetRegsUmac umac;
+    uint8_t reserved_0x1000[0x1000];
+    BCM2838GenetRegsRdma rdma;
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
 struct BCM2838GenetState {
-- 
2.34.1


From 7f50a2738493eee4b40afe7553a4107daa407851 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 25/44] Add GENET register structs. Part 3

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 206 +++++++++++++++++++++++++++++++++
 1 file changed, 206 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 4542f27eba..4cf70a17d3 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,6 +22,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_CNT      48
+#define BCM2838_GENET_HFB_FILTER_SIZE     128
+
 typedef union {
     uint32_t value;
     struct {
@@ -179,6 +182,25 @@ typedef union {
     } fields;
 } BCM2838GenetDmaStatus;
 
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t reserved_0_3:4;
+        uint32_t do_csum:1;
+        uint32_t ow_crc:1;
+        uint32_t append_crc:1;
+        uint32_t reserved_7_8:2;
+        uint32_t underrun:1;
+        uint32_t reserved_10_11:2;
+        uint32_t wrap:1;
+        uint32_t sop:1;
+        uint32_t eop:1;
+        uint32_t own:1;
+        uint32_t buflength:12;
+        uint32_t reserved_28_31:4;
+    } fields;
+} BCM2838GenetTdmaLengthStatus;
+
 typedef union {
     uint32_t value;
     struct {
@@ -346,6 +368,53 @@ typedef struct {
     uint8_t reserved_0x10D0[0xF30];
 } __attribute__((__packed__)) BCM2838GenetRegsRdma;
 
+typedef struct {
+    BCM2838GenetTdmaLengthStatus length_status;
+    uint32_t address_lo;
+    uint32_t address_hi;
+} __attribute__((__packed__)) BCM2838GenetTdmaDesc;
+
+typedef struct {
+    uint32_t read_ptr;
+    uint32_t read_ptr_hi;
+    BCM2838GenetDmaConsIndex cons_index;
+    BCM2838GenetDmaProdIndex prod_index;
+    uint32_t ring_buf_size;
+    uint32_t start_addr;
+    uint32_t start_addr_hi;
+    uint32_t end_addr;
+    uint32_t end_addr_hi;
+    uint32_t mbuf_done_tresh;
+    uint32_t flow_period;
+    uint32_t write_ptr;
+    uint32_t write_ptr_hi;
+    uint8_t reserved_0x34[0xC];
+} __attribute__((__packed__)) BCM2838GenetTdmaRing;
+
+typedef struct {
+    BCM2838GenetTdmaDesc descs[BCM2838_GENET_DMA_DESC_CNT];
+    BCM2838GenetTdmaRing rings[BCM2838_GENET_DMA_RING_CNT];
+    BCM2838GenetDmaRingCfg ring_cfg;
+    BCM2838GenetDmaCtrl ctrl;
+    BCM2838GenetDmaStatus status;
+    uint32_t scb_burst_size;
+    uint8_t reserved_0x1050[0x1C];
+    uint32_t arb_ctrl;
+    uint32_t priority[3];
+    uint8_t reserved_0x10D0[0xF84];
+} __attribute__((__packed__)) BCM2838GenetRegsTdma;
+
+typedef struct {
+    uint8_t flt[BCM2838_GENET_HFB_FILTER_CNT * BCM2838_GENET_HFB_FILTER_SIZE
+                * sizeof(uint32_t)];
+    uint8_t reserved_0x6000[0x1C00];
+    uint32_t ctrl;
+    uint32_t flt_enable[2];
+    uint8_t reserved_0x7C0C[0x10];
+    uint32_t flt_len[BCM2838_GENET_HFB_FILTER_CNT / sizeof(uint32_t)];
+    uint8_t reserved_0x7C4C[0x3B4];
+} __attribute__((__packed__)) BCM2838GenetRegsHfb;
+
 typedef struct {
     BCM2838GenetRegsSys sys;
     BCM2838GenetRegsGrBridge gr_bridge;
@@ -361,8 +430,144 @@ typedef struct {
     BCM2838GenetRegsUmac umac;
     uint8_t reserved_0x1000[0x1000];
     BCM2838GenetRegsRdma rdma;
+    BCM2838GenetRegsTdma tdma;
+    uint8_t reserved_0x6000[0x2000];
+    BCM2838GenetRegsHfb hfb;
 } __attribute__((__packed__)) BCM2838GenetRegs;
 
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reserved_0_5:6;
+        uint16_t speed1000:1;
+        uint16_t ctst:1;
+        uint16_t fulldplx:1;
+        uint16_t anrestart:1;
+        uint16_t isolate:1;
+        uint16_t pdown:1;
+        uint16_t aenable:1;
+        uint16_t speed100:1;
+        uint16_t loopback:1;
+        uint16_t reset:1;
+    } fields;
+} BCM2838GenetPhyBmcr;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t ercap:1;
+        uint16_t jcd:1;
+        uint16_t lstatus:1;
+        uint16_t anegcapable:1;
+        uint16_t rfault:1;
+        uint16_t anegcomplete:1;
+        uint16_t reserved_6_7:2;
+        uint16_t estaten:1;
+        uint16_t _100half2:1;
+        uint16_t _100full2:1;
+        uint16_t _10half:1;
+        uint16_t _10full:1;
+        uint16_t _100half:1;
+        uint16_t _100full:1;
+        uint16_t _100base4:1;
+    } fields;
+} BCM2838GenetPhyBmsr;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t slct:5;
+        uint16_t _10half_1000xfull:1;
+        uint16_t _10full_1000xhalf:1;
+        uint16_t _100half_1000xpause:1;
+        uint16_t _100full_1000xpause_asym:1;
+        uint16_t _100base4:1;
+        uint16_t pause_cap:1;
+        uint16_t pause_asym:1;
+        uint16_t reserved_12:1;
+        uint16_t rfault:1;
+        uint16_t lpack:1;
+        uint16_t npage:1;
+    } fields;
+} BCM2838GenetPhyLpa;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reserved_0_9:10;
+        uint16_t _1000half:1;
+        uint16_t _1000full:1;
+        uint16_t _1000remrxok:1;
+        uint16_t _1000localrxok:1;
+        uint16_t _1000msres:1;
+        uint16_t _1000msfail:1;
+    } fields;
+} BCM2838GenetPhyStat1000;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reg_id_mask:3;
+        uint16_t reserved_3:1;
+        uint16_t reg_data:8;
+        uint16_t reg_id:3;
+        uint16_t misc_wren:1;
+    } fields_1;
+    struct {
+        uint16_t reserved_0_3:4;
+        uint16_t reg_data:12;
+    } fields_2;
+} BCM2838GenetPhyAuxCtl;
+
+typedef union {
+    uint16_t value;
+    struct {
+        uint16_t reg_data:10;
+        uint16_t reg_id:5;
+        uint16_t wr:1;
+    } fields;
+} BCM2838GenetPhyShadow;
+
+
+typedef struct {
+    uint8_t reg_id;
+    uint8_t block_id;
+}  __attribute__((__packed__)) BCM2838GenetPhyExpSel;
+
+typedef struct {
+    BCM2838GenetPhyBmcr bmcr;
+    BCM2838GenetPhyBmsr bmsr;
+    uint16_t sid1;
+    uint16_t sid2;
+    uint16_t advertise;
+    BCM2838GenetPhyLpa lpa;
+    uint16_t expansion;
+    uint16_t next_page;
+    uint16_t lpa_next_page;
+    uint16_t ctrl1000;
+    BCM2838GenetPhyStat1000 stat1000;
+    uint16_t reserved_11_12[2];
+    uint16_t mmd_ctrl;
+    uint16_t mmd_data;
+    uint16_t estatus;
+    uint16_t ecr;
+    uint16_t esr;
+    uint16_t dcounter;
+    uint16_t fcscounter;
+    uint16_t nwaytest;
+    uint16_t exp_data;
+    uint16_t srevision;
+    BCM2838GenetPhyExpSel exp_ctrl;
+    BCM2838GenetPhyAuxCtl aux_ctl;
+    uint16_t phyaddr;
+    uint16_t isr;
+    uint16_t imr;
+    BCM2838GenetPhyShadow shd;
+    uint16_t reserved_29;
+    uint16_t rdb_addr;
+    uint16_t rdb_data;
+} __attribute__((__packed__)) BCM2838GenetPhyRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -373,6 +578,7 @@ struct BCM2838GenetState {
     AddressSpace dma_as;
 
     BCM2838GenetRegs regs;
+    BCM2838GenetPhyRegs phy_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


From c7585a3007cbdfda413b0d80bae79c54d0f70f0f Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 26/44] Add GENET register structs. Part 4

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 4cf70a17d3..4b549ed431 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -25,6 +25,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
+#define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
+
+#define SIZEOF_FIELD(type, field)      sizeof(((type*) 0)->field)
+#define BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT \
+    (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, block_id)))
+#define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT \
+    (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, reg_id)))
+
 typedef union {
     uint32_t value;
     struct {
@@ -568,6 +577,34 @@ typedef struct {
     uint16_t rdb_data;
 } __attribute__((__packed__)) BCM2838GenetPhyRegs;
 
+typedef struct {
+    uint16_t reserved_0_2[3];
+    uint16_t clk_ctl;
+    uint16_t scr2;
+    uint16_t scr3;
+    uint16_t reserved_6_9[4];
+    uint16_t apd;
+    uint16_t rgmii_mode;
+    uint16_t reserved_12;
+    uint16_t leds1;
+    uint16_t reserved_14_18[5];
+    uint16_t _100fx_ctrl;
+    uint16_t ssd;
+    uint16_t reserved_21_30[10];
+    uint16_t mode;
+} __attribute__((__packed__)) BCM2838GenetPhyShdRegs;
+
+typedef struct {
+    uint16_t auxctl;
+    uint16_t reserved_1_6[BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE - 2];
+    uint16_t misc;
+} __attribute__((__packed__)) BCM2838GenetPhyAuxShdRegs;
+
+typedef struct {
+    uint16_t regs[BCM2838_GENET_PHY_EXP_SHD_BLOCKS_CNT]
+                 [BCM2838_GENET_PHY_EXP_SHD_REGS_CNT];
+} __attribute__((__packed__)) BCM2838GenetPhyExpShdRegs;
+
 struct BCM2838GenetState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -579,6 +616,9 @@ struct BCM2838GenetState {
 
     BCM2838GenetRegs regs;
     BCM2838GenetPhyRegs phy_regs;
+    BCM2838GenetPhyShdRegs phy_shd_regs;
+    BCM2838GenetPhyAuxShdRegs phy_aux_ctl_shd_regs;
+    BCM2838GenetPhyExpShdRegs phy_exp_shd_regs;
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
-- 
2.34.1


From 028809730f7589d8f69a7a76e6cf99dc63456a02 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 27/44] Add GENET register access macros

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 include/hw/net/bcm2838_genet.h | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 4b549ed431..bfe5e3ab31 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -22,9 +22,85 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_DMA_RING_CNT      17
 #define BCM2838_GENET_DMA_RING_DEFAULT  (BCM2838_GENET_DMA_RING_CNT - 1)
 
+#define BCM2838_GENET_HFB_FILTER_REGS     offsetof(BCM2838GenetRegs, hfb)
+#define BCM2838_GENET_HFB_FILTER_REG(reg) (BCM2838_GENET_HFB_FILTER_REGS \
+                                           + offsetof(BCM2838GenetRegsHfb, reg))
 #define BCM2838_GENET_HFB_FILTER_CNT      48
 #define BCM2838_GENET_HFB_FILTER_SIZE     128
 
+#define BCM2838_GENET_INTRL0_REG(reg)   (offsetof(BCM2838GenetRegs, intrl0) \
+                                        + offsetof(BCM2838GenetRegsIntrl0, reg))
+#define BCM2838_GENET_INTRL0_SET        BCM2838_GENET_INTRL0_REG(set)
+#define BCM2838_GENET_INTRL0_CLEAR      BCM2838_GENET_INTRL0_REG(clear)
+#define BCM2838_GENET_INTRL0_MASK_SET   BCM2838_GENET_INTRL0_REG(mask_set)
+#define BCM2838_GENET_INTRL0_MASK_CLEAR BCM2838_GENET_INTRL0_REG(mask_clear)
+
+#define BCM2838_GENET_INTRL1_REG(reg)   (offsetof(BCM2838GenetRegs, intrl1) \
+                                        + offsetof(BCM2838GenetRegsIntrl1, reg))
+#define BCM2838_GENET_INTRL1_SET        BCM2838_GENET_INTRL1_REG(set)
+#define BCM2838_GENET_INTRL1_CLEAR      BCM2838_GENET_INTRL1_REG(clear)
+#define BCM2838_GENET_INTRL1_MASK_SET   BCM2838_GENET_INTRL1_REG(mask_set)
+#define BCM2838_GENET_INTRL1_MASK_CLEAR BCM2838_GENET_INTRL1_REG(mask_clear)
+
+#define BCM2838_GENET_UMAC_REG(reg)     (offsetof(BCM2838GenetRegs, umac) \
+                                         + offsetof(BCM2838GenetRegsUmac, reg))
+#define BCM2838_GENET_UMAC_CMD          BCM2838_GENET_UMAC_REG(cmd)
+#define BCM2838_GENET_UMAC_MAC0         BCM2838_GENET_UMAC_REG(mac0)
+#define BCM2838_GENET_UMAC_MAC1         BCM2838_GENET_UMAC_REG(mac1)
+#define BCM2838_GENET_UMAC_MDIO_CMD     BCM2838_GENET_UMAC_REG(mdio_cmd)
+
+#define BCM2838_GENET_TDMA_REGS         offsetof(BCM2838GenetRegs, tdma)
+#define BCM2838_GENET_TDMA_REG(reg)     (BCM2838_GENET_TDMA_REGS \
+                                         + offsetof(BCM2838GenetRegsTdma, reg))
+#define BCM2838_GENET_TDMA_RINGS        BCM2838_GENET_TDMA_REG(rings)
+#define BCM2838_GENET_TDMA_RING_CFG     BCM2838_GENET_TDMA_REG(ring_cfg)
+#define BCM2838_GENET_TDMA_CTRL         BCM2838_GENET_TDMA_REG(ctrl)
+
+#define BCM2838_GENET_RDMA_REGS         offsetof(BCM2838GenetRegs, rdma)
+#define BCM2838_GENET_RDMA_REG(reg)     (BCM2838_GENET_RDMA_REGS \
+                                         + offsetof(BCM2838GenetRegsRdma, reg))
+#define BCM2838_GENET_RDMA_RINGS        BCM2838_GENET_RDMA_REG(rings)
+#define BCM2838_GENET_RDMA_RING_CFG     BCM2838_GENET_RDMA_REG(ring_cfg)
+#define BCM2838_GENET_RDMA_CTRL         BCM2838_GENET_RDMA_REG(ctrl)
+
+#define BCM2838_GENET_TRING_REG(reg)    offsetof(BCM2838GenetTdmaRing, reg)
+#define BCM2838_GENET_TRING_WRITE_PTR BCM2838_GENET_TRING_REG(write_ptr)
+#define BCM2838_GENET_TRING_WRITE_PTR_HI BCM2838_GENET_TRING_REG(write_ptr_hi)
+#define BCM2838_GENET_TRING_PROD_INDEX BCM2838_GENET_TRING_REG(prod_index)
+#define BCM2838_GENET_TRING_CONS_INDEX BCM2838_GENET_TRING_REG(cons_index)
+#define BCM2838_GENET_TRING_RING_BUF_SIZE BCM2838_GENET_TRING_REG(ring_buf_size)
+#define BCM2838_GENET_TRING_RING_START_ADDR BCM2838_GENET_TRING_REG(start_addr)
+#define BCM2838_GENET_TRING_RING_START_ADDR_HI BCM2838_GENET_TRING_REG(start_addr_hi)
+#define BCM2838_GENET_TRING_RING_END_ADDR BCM2838_GENET_TRING_REG(end_addr)
+#define BCM2838_GENET_TRING_RING_END_ADDR_HI BCM2838_GENET_TRING_REG(end_addr_hi)
+#define BCM2838_GENET_TRING_RING_MBUF_DONE_TRESH BCM2838_GENET_TRING_REG(mbuf_done_tresh)
+#define BCM2838_GENET_TRING_RING_FLOW_PERIOD BCM2838_GENET_TRING_REG(flow_period)
+#define BCM2838_GENET_TRING_RING_READ_PTR BCM2838_GENET_TRING_REG(read_ptr)
+#define BCM2838_GENET_TRING_RING_READ_PTR_HI BCM2838_GENET_TRING_REG(read_ptr_hi)
+
+#define BCM2838_GENET_RRING_REG(reg)    offsetof(BCM2838GenetRdmaRing, reg)
+#define BCM2838_GENET_RRING_WRITE_PTR BCM2838_GENET_RRING_REG(write_ptr)
+#define BCM2838_GENET_RRING_WRITE_PTR_HI BCM2838_GENET_RRING_REG(write_ptr_hi)
+#define BCM2838_GENET_RRING_PROD_INDEX BCM2838_GENET_RRING_REG(prod_index)
+#define BCM2838_GENET_RRING_CONS_INDEX BCM2838_GENET_RRING_REG(cons_index)
+#define BCM2838_GENET_RRING_RING_BUF_SIZE BCM2838_GENET_RRING_REG(ring_buf_size)
+#define BCM2838_GENET_RRING_RING_START_ADDR BCM2838_GENET_RRING_REG(start_addr)
+#define BCM2838_GENET_RRING_RING_START_ADDR_HI BCM2838_GENET_RRING_REG(start_addr_hi)
+#define BCM2838_GENET_RRING_RING_END_ADDR BCM2838_GENET_RRING_REG(end_addr)
+#define BCM2838_GENET_RRING_RING_END_ADDR_HI BCM2838_GENET_RRING_REG(end_addr_hi)
+#define BCM2838_GENET_RRING_RING_MBUF_DONE_TRESH BCM2838_GENET_RRING_REG(mbuf_done_tresh)
+#define BCM2838_GENET_RRING_RING_XON_XOFF_TRESH BCM2838_GENET_RRING_REG(xon_xoff_tresh)
+#define BCM2838_GENET_RRING_RING_READ_PTR BCM2838_GENET_RRING_REG(read_ptr)
+#define BCM2838_GENET_RRING_RING_READ_PTR_HI BCM2838_GENET_RRING_REG(read_ptr_hi)
+
+
+#define BCM2838_GENET_PHY_REG(reg)      (offsetof(BCM2838GenetPhyRegs, reg) / 2)
+#define BCM2838_GENET_PHY_BMCR          BCM2838_GENET_PHY_REG(bmcr)
+#define BCM2838_GENET_PHY_AUX_CTL       BCM2838_GENET_PHY_REG(aux_ctl)
+#define BCM2838_GENET_PHY_SHD           BCM2838_GENET_PHY_REG(shd)
+#define BCM2838_GENET_EXP_DATA          BCM2838_GENET_PHY_REG(exp_data)
+#define BCM2838_GENET_EXP_SEL           BCM2838_GENET_PHY_REG(exp_ctrl)
+
 #define BCM2838_GENET_PHY_AUX_CTL_MISC  0x7
 #define BCM2838_GENET_PHY_AUX_CTL_REGS_SIZE 8
 
-- 
2.34.1


From 39bd2ff5ed5230768c4b8ca2b0531dfd75d75f51 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 28/44] Impl GENET register ops.

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 183 +++++++++++++++++++++++++++++++--
 include/hw/net/bcm2838_genet.h |   2 +
 2 files changed, 175 insertions(+), 10 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index c3e7d90451..01e6819df4 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -19,25 +19,139 @@
 #include "trace.h"
 
 
+static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
+{
+    s->regs.umac.mac0.fields.addr_0 = s->nic_conf.macaddr.a[0];
+    s->regs.umac.mac0.fields.addr_1 = s->nic_conf.macaddr.a[1];
+    s->regs.umac.mac0.fields.addr_2 = s->nic_conf.macaddr.a[2];
+    s->regs.umac.mac0.fields.addr_3 = s->nic_conf.macaddr.a[3];
+    s->regs.umac.mac1.fields.addr_4 = s->nic_conf.macaddr.a[4];
+    s->regs.umac.mac1.fields.addr_5 = s->nic_conf.macaddr.a[5];
+}
+
+static void bcm2838_genet_set_irq_default(BCM2838GenetState *s)
+{
+    uint32_t intrl_0_status = s->regs.intrl0.stat.value;
+    uint32_t intrl_0_mask = s->regs.intrl0.mask_status.value;
+    int level = (intrl_0_status & ~intrl_0_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_default, level);
+}
+
+static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
+{
+    uint32_t intrl_1_status = s->regs.intrl1.stat.value;
+    uint32_t intrl_1_mask = s->regs.intrl1.mask_status.value;
+    int level = (intrl_1_status & ~intrl_1_mask) == 0 ? 0 : 1;
+
+    qemu_set_irq(s->irq_prio, level);
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
+    BCM2838GenetState *s = opaque;
 
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+    if (offset + size < sizeof(s->regs)) {
+        memcpy(&value, (uint8_t *)&s->regs + offset, size);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 
     trace_bcm2838_genet_read(size, offset, value);
     return value;
 }
 
 static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
-                                unsigned size) {
-    qemu_log_mask(
-        LOG_GUEST_ERROR,
-        "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
-        __func__, size, offset);
+                                unsigned size)
+{
+    BCM2838GenetState *s = opaque;
+    NetClientState *ncs = qemu_get_queue(s->nic);
+    BCM2838GenetUmacCmd umac_cmd = {.value = value};
+    BCM2838GenetUmacMac0 umac_mac0 = {.value = value};
+    BCM2838GenetUmacMac1 umac_mac1 = {.value = value};
+
+    trace_bcm2838_genet_write(size, offset, value);
+
+    if (offset + size < sizeof(s->regs)) {
+        switch (offset) {
+        case BCM2838_GENET_INTRL0_SET:
+            s->regs.intrl0.stat.value |= value;
+            break;
+        case BCM2838_GENET_INTRL0_CLEAR:
+            s->regs.intrl0.stat.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_SET:
+            s->regs.intrl0.mask_status.value |= value;
+            break;
+        case BCM2838_GENET_INTRL0_MASK_CLEAR:
+            s->regs.intrl0.mask_status.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_SET:
+            s->regs.intrl1.stat.value |= value;
+            break;
+        case BCM2838_GENET_INTRL1_CLEAR:
+            s->regs.intrl1.stat.value &= ~value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_SET:
+            s->regs.intrl1.mask_status.value |= value;
+            break;
+        case BCM2838_GENET_INTRL1_MASK_CLEAR:
+            s->regs.intrl1.mask_status.value &= ~value;
+            break;
+        case BCM2838_GENET_UMAC_CMD:
+            /* Complete SW reset as soon as it has been requested */
+            if (umac_cmd.fields.sw_reset == 1) {
+                device_cold_reset(DEVICE(s));
+                umac_cmd.fields.sw_reset = 0;
+                value = umac_cmd.value;
+            }
+            break;
+        /*
+         * TODO: before changing MAC address we'd better inform QEMU
+         * network subsystem about freeing previously used one, but
+         * qemu_macaddr_set_free function isn't accessible for us (marked
+         * as static in net/net.c), see also https://lists.nongnu.org/
+         * archive/html/qemu-devel/2022-07/msg02123.html
+         */
+        case BCM2838_GENET_UMAC_MAC0:
+            s->nic_conf.macaddr.a[0] = umac_mac0.fields.addr_0;
+            s->nic_conf.macaddr.a[1] = umac_mac0.fields.addr_1;
+            s->nic_conf.macaddr.a[2] = umac_mac0.fields.addr_2;
+            s->nic_conf.macaddr.a[3] = umac_mac0.fields.addr_3;
+            qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+            qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MAC1:
+            s->nic_conf.macaddr.a[4] = umac_mac1.fields.addr_4;
+            s->nic_conf.macaddr.a[5] = umac_mac1.fields.addr_5;
+            qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+            qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+            trace_bcm2838_genet_mac_address(ncs->info_str);
+            break;
+        case BCM2838_GENET_UMAC_MDIO_CMD:
+        case BCM2838_GENET_TDMA_REGS
+            ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
+            qemu_log_mask(LOG_UNIMP,
+                "UMAC MDIO and TDMA aren't implemented yet");
+            break;
+        default:
+            break;
+        }
+
+        memcpy((uint8_t *)&s->regs + offset, &value, size);
+        bcm2838_genet_set_irq_default(s);
+        bcm2838_genet_set_irq_prio(s);
+    } else {
+        qemu_log_mask(
+            LOG_GUEST_ERROR,
+            "%s: out-of-range access, %u bytes @ offset 0x%04" PRIx64 "\n",
+            __func__, size, offset);
+    }
 }
 
 static const MemoryRegionOps bcm2838_genet_ops = {
@@ -48,9 +162,14 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = sizeof(uint32_t)},
 };
 
+static NetClientInfo bcm2838_genet_client_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState)
+};
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
 {
+    NetClientState *ncs;
     BCM2838GenetState *s = BCM2838_GENET(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
@@ -58,11 +177,45 @@ static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->regs_mr, OBJECT(s), &bcm2838_genet_ops, s,
                           "bcm2838_genet_regs", sizeof(s->regs));
     sysbus_init_mmio(sbd, &s->regs_mr);
+
+    /* QEMU-managed NIC (host network back-end connection) */
+    qemu_macaddr_default_if_unset(&s->nic_conf.macaddr);
+    s->nic = qemu_new_nic(&bcm2838_genet_client_info, &s->nic_conf,
+                          object_get_typename(OBJECT(dev)), dev->id, s);
+    bcm2838_genet_set_qemu_mac(s);
+    ncs = qemu_get_queue(s->nic);
+    qemu_format_nic_info_str(ncs, s->nic_conf.macaddr.a);
+    trace_bcm2838_genet_mac_address(ncs->info_str);
+
+    /* Interrupts */
+    sysbus_init_irq(sbd, &s->irq_default);
+    sysbus_init_irq(sbd, &s->irq_prio);
+
+    /* DMA space */
+    address_space_init(&s->dma_as, get_system_memory(), "bcm2838_genet_dma");
 }
 
 static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
 {
-    /* Temporary unimplemented */
+    memset(&s->phy_regs, 0x00, sizeof(s->phy_regs));
+    memset(&s->phy_shd_regs, 0x00, sizeof(s->phy_shd_regs));
+    memset(&s->phy_aux_ctl_shd_regs, 0x00, sizeof(s->phy_aux_ctl_shd_regs));
+
+    /* All the below values were taken from the real HW trace and logs */
+    s->phy_regs.bmcr.value = 0x1140;
+    s->phy_regs.bmsr.value = 0x7949;
+    s->phy_regs.sid1 = 0x600D;
+    s->phy_regs.sid2 = 0x84A2;
+    s->phy_regs.advertise = 0x01E1;
+    s->phy_regs.ctrl1000 = 0x0200;
+    s->phy_regs.estatus = 0x3000;
+
+    s->phy_shd_regs.clk_ctl = 0x0200;
+    s->phy_shd_regs.scr3 = 0x001F;
+    s->phy_shd_regs.apd = 0x0001;
+
+    s->phy_aux_ctl_shd_regs.misc = 0x1E;
+
     trace_bcm2838_genet_phy_reset("done");
 }
 
@@ -72,17 +225,27 @@ static void bcm2838_genet_reset(DeviceState *d)
 
     memset(&s->regs, 0x00, sizeof(s->regs));
 
+    /* All the below values were taken from the real HW trace and logs */
+    s->regs.sys.rev_ctrl.fields.major_rev = BCM2838_GENET_REV_MAJOR;
+    s->regs.sys.rev_ctrl.fields.minor_rev = BCM2838_GENET_REV_MINOR;
+
     trace_bcm2838_genet_reset("done");
 
     bcm2838_genet_phy_reset(s);
 }
 
+static Property genet_properties[] = {
+    DEFINE_NIC_PROPERTIES(BCM2838GenetState, nic_conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void bcm2838_genet_class_init(ObjectClass *class, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(class);
 
     dc->realize = bcm2838_genet_realize;
     dc->reset = bcm2838_genet_reset;
+    device_class_set_props(dc, genet_properties);
 }
 
 static const TypeInfo bcm2838_genet_info = {
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index bfe5e3ab31..025ac467d7 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -686,6 +686,8 @@ struct BCM2838GenetState {
     SysBusDevice parent_obj;
 
     /*< public >*/
+    NICState *nic;
+    NICConf nic_conf;
 
     MemoryRegion regs_mr;
     AddressSpace dma_as;
-- 
2.34.1


From 4d6a6147448e586f81a750c1e386b9f0db07966e Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 29/44] Impl GENET MDIO

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c | 109 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 2 deletions(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 01e6819df4..e633323d17 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -47,6 +47,108 @@ static void bcm2838_genet_set_irq_prio(BCM2838GenetState *s)
     qemu_set_irq(s->irq_prio, level);
 }
 
+static void bcm2838_genet_phy_aux_ctl_write(BCM2838GenetState *s,
+                                            uint16_t value)
+{
+    BCM2838GenetPhyAuxCtl phy_aux_ctl = {.value = value};
+    uint16_t *phy_aux_ctl_shd_reg_id
+        = (uint16_t *)&s->phy_aux_ctl_shd_regs + phy_aux_ctl.fields_1.reg_id;
+    uint16_t *phy_aux_ctl_shd_reg_id_mask
+        = (uint16_t *)&s->phy_aux_ctl_shd_regs + phy_aux_ctl.fields_1.reg_id_mask;
+
+    if (phy_aux_ctl.fields_1.reg_id_mask == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+        if (phy_aux_ctl.fields_1.reg_id == BCM2838_GENET_PHY_AUX_CTL_MISC) {
+            if (phy_aux_ctl.fields_1.misc_wren == 0) {
+                /* write for subsequent read (8-bit from AUX_CTL_MISC) */
+                phy_aux_ctl.fields_1.reg_data = *phy_aux_ctl_shd_reg_id;
+            } else {
+                /* write 8 bits to AUX_CTL_MISC */
+                *phy_aux_ctl_shd_reg_id_mask = phy_aux_ctl.fields_1.reg_data;
+            }
+        } else {
+            /* write for subsequent read (12-bit) */
+            phy_aux_ctl.fields_2.reg_data = *phy_aux_ctl_shd_reg_id;
+        }
+    } else {
+        /* write 12 bits */
+        *phy_aux_ctl_shd_reg_id_mask = phy_aux_ctl.fields_2.reg_data;
+    }
+
+    s->phy_regs.aux_ctl.value = phy_aux_ctl.value;
+}
+
+static void bcm2838_genet_phy_shadow_write(BCM2838GenetState *s,
+                                           uint16_t value)
+{
+    BCM2838GenetPhyShadow phy_shadow = {.value = value};
+    uint16_t *phy_shd_reg
+        = (uint16_t *)&s->phy_shd_regs + phy_shadow.fields.reg_id;
+
+    if (phy_shadow.fields.wr == 0) {
+        phy_shadow.fields.reg_data = *phy_shd_reg;
+    } else {
+        *phy_shd_reg = phy_shadow.fields.reg_data;
+    }
+
+    s->phy_regs.shd.value = phy_shadow.value;
+}
+
+static void bcm2838_genet_phy_exp_shadow_write(BCM2838GenetState *s,
+                                               uint16_t value)
+{
+    /* TODO Stub implementation without side effect,
+            just storing registers values */
+    BCM2838GenetPhyExpSel* exp_ctrl = &s->phy_regs.exp_ctrl;
+    s->phy_exp_shd_regs.regs[exp_ctrl->block_id][exp_ctrl->reg_id] = value;
+}
+
+static uint16_t bcm2838_genet_phy_exp_shadow_read(BCM2838GenetState *s)
+{
+    BCM2838GenetPhyExpSel* exp_ctrl = &s->phy_regs.exp_ctrl;
+    return s->phy_exp_shd_regs.regs[exp_ctrl->block_id][exp_ctrl->reg_id];
+}
+
+static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
+{
+    BCM2838GenetUmacMdioCmd umac_mdio_cmd = {.value = cmd};
+    uint8_t phy_reg_id = umac_mdio_cmd.fields.reg_id;
+    uint16_t phy_reg_data = umac_mdio_cmd.fields.reg_data;
+    uint16_t *phy_reg = (uint16_t *)&s->phy_regs + phy_reg_id;
+    BCM2838GenetPhyBmcr phy_bmcr = {.value = phy_reg_data};
+
+    if (umac_mdio_cmd.fields.start_busy != 0) {
+        umac_mdio_cmd.fields.start_busy = 0;
+
+        if (umac_mdio_cmd.fields.rd != 0) {
+            if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                umac_mdio_cmd.fields.reg_data
+                    = bcm2838_genet_phy_exp_shadow_read(s);
+            } else {
+                umac_mdio_cmd.fields.reg_data = *phy_reg;
+            }
+        } else if (umac_mdio_cmd.fields.wr != 0) {
+            if (phy_reg_id == BCM2838_GENET_PHY_AUX_CTL) {
+                bcm2838_genet_phy_aux_ctl_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_PHY_SHD) {
+                bcm2838_genet_phy_shadow_write(s, phy_reg_data);
+            } else if (phy_reg_id == BCM2838_GENET_EXP_DATA) {
+                bcm2838_genet_phy_exp_shadow_write(s, phy_reg_data);
+            } else {
+                if (phy_reg_id == BCM2838_GENET_PHY_BMCR) {
+                    /* Initiate auto-negotiation once it has been restarted */
+                    if (phy_bmcr.fields.anrestart == 1) {
+                        phy_bmcr.fields.anrestart = 0;
+                        phy_reg_data = phy_bmcr.value;
+                    }
+                }
+                *phy_reg = phy_reg_data;
+            }
+        }
+    }
+
+    return umac_mdio_cmd.value;
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -134,10 +236,12 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             trace_bcm2838_genet_mac_address(ncs->info_str);
             break;
         case BCM2838_GENET_UMAC_MDIO_CMD:
+            value = bcm2838_genet_mdio_cmd(s, value);
+            s->regs.intrl0.stat.fields.mdio_done = 1;
+            break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP,
-                "UMAC MDIO and TDMA aren't implemented yet");
+            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
             break;
         default:
             break;
@@ -231,6 +335,7 @@ static void bcm2838_genet_reset(DeviceState *d)
 
     trace_bcm2838_genet_reset("done");
 
+    bcm2838_genet_set_qemu_mac(s);
     bcm2838_genet_phy_reset(s);
 }
 
-- 
2.34.1


From 8c4167f97f31812b9fbdf52160871509490298e1 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 30/44] Impl GENET TX path

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 170 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |  26 +++++
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index e633323d17..98030216f4 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -149,6 +149,174 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
     return umac_mdio_cmd.value;
 }
 
+static void bcm2838_genet_xmit_packet(NetClientState *s, void *packet,
+                                      size_t size)
+{
+    uint8_t *buf = packet + sizeof(BCM2838GenetXmitStatus);
+    size_t len = size;
+    uint16_t len_type = 0;
+
+    len -= sizeof(BCM2838GenetXmitStatus);
+    net_checksum_calculate(buf, len, CSUM_ALL);
+
+    memcpy(&len_type, &buf[12], sizeof(len_type));
+    len_type = ntohs(len_type);
+    if (len_type < MAX_PAYLOAD_SIZE) {
+        len_type = len;
+        len_type = htons(len_type);
+        memcpy(&buf[12], &len_type, sizeof(len_type));
+    }
+
+    qemu_send_packet(s, buf, len);
+}
+
+static uint64_t bcm2838_genet_tx(BCM2838GenetState *s, unsigned int ring_index,
+                                 BCM2838GenetDmaProdIndex prod_index,
+                                 BCM2838GenetDmaConsIndex cons_index)
+{
+    const unsigned int DESC_SIZE_WORDS
+        = sizeof(BCM2838GenetTdmaDesc) / sizeof(uint32_t);
+    const uint64_t RING_START_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].start_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].start_addr;
+    const uint64_t RING_END_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].end_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].end_addr;
+
+    hwaddr data_addr;
+    uint64_t desc_index;
+    BCM2838GenetTdmaLengthStatus desc_status;
+    uint64_t num_descs = 0;
+    uint64_t read_ptr
+        = ((uint64_t)s->regs.tdma.rings[ring_index].read_ptr_hi << 32)
+            + s->regs.tdma.rings[ring_index].read_ptr;
+    off_t packet_off = 0;
+
+    while (cons_index.fields.index != prod_index.fields.index) {
+        desc_index = read_ptr / DESC_SIZE_WORDS;
+        if (desc_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: invalid TX descriptor index %" PRIu64 " (exceeds %u)\n",
+                __func__, desc_index, BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc_status.value = s->regs.tdma.descs[desc_index].length_status.value;
+        data_addr = ((uint64_t)s->regs.tdma.descs[desc_index].address_hi << 32)
+            + s->regs.tdma.descs[desc_index].address_lo;
+        trace_bcm2838_genet_tx(ring_index, desc_index, desc_status.value,
+                               data_addr);
+
+        if (desc_status.fields.sop) {
+            packet_off = 0;
+        }
+
+        /* TODO: Add address_space_read() return value check */
+        address_space_read(&s->dma_as, data_addr,
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        s->tx_packet + packet_off,
+                                        desc_status.fields.buflength);
+        packet_off += desc_status.fields.buflength;
+
+        if (desc_status.fields.eop) {
+            bcm2838_genet_xmit_packet(qemu_get_queue(s->nic), s->tx_packet,
+                                                     packet_off);
+            packet_off = 0;
+        }
+
+        num_descs++;
+        cons_index.fields.index++;
+        s->regs.tdma.descs[desc_index].length_status.fields.own = 1;
+        read_ptr = read_ptr == RING_END_ADDR + 1 - DESC_SIZE_WORDS
+            ? RING_START_ADDR : read_ptr + DESC_SIZE_WORDS;
+    }
+
+    s->regs.tdma.rings[ring_index].read_ptr = read_ptr;
+    s->regs.tdma.rings[ring_index].read_ptr_hi = read_ptr >> 32;
+
+    return num_descs;
+}
+
+static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+    bool dma_en = s->regs.tdma.ctrl.fields.en == 1;
+    bool ring_en = (s->regs.tdma.ring_cfg.fields.en & ring_mask) != 0;
+    bool ring_buf_en = (s->regs.tdma.ctrl.fields.ring_buf_en & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_tx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+    return active;
+}
+
+static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
+                               uint64_t value)
+{
+    hwaddr ring_offset;
+    uint64_t num_descs_tx;
+    unsigned int ring_index;
+    BCM2838GenetDmaConsIndex cons_index;
+    BCM2838GenetDmaRingCfg ring_cfg = {.value = value};
+    BCM2838GenetDmaCtrl ctrl = {.value = value};
+    BCM2838GenetDmaProdIndex prod_index = {.value = value};
+
+    switch (offset) {
+    case BCM2838_GENET_TDMA_RINGS
+        ... BCM2838_GENET_TDMA_RINGS + sizeof(s->regs.tdma.rings) - 1:
+        ring_index = (offset - BCM2838_GENET_TDMA_RINGS)
+            / sizeof(BCM2838GenetTdmaRing);
+        if (bcm2838_genet_tdma_ring_active(s, ring_index)) {
+            ring_offset = offset - BCM2838_GENET_TDMA_RINGS
+                - ring_index * sizeof(BCM2838GenetTdmaRing);
+            switch (ring_offset) {
+            case BCM2838_GENET_TRING_PROD_INDEX:
+                cons_index.value
+                    = s->regs.tdma.rings[ring_index].cons_index.value;
+                if (cons_index.fields.index != prod_index.fields.index) {
+                    trace_bcm2838_genet_tx_request(ring_index,
+                                                   prod_index.fields.index,
+                                                   cons_index.fields.index);
+                    num_descs_tx = bcm2838_genet_tx(s, ring_index, prod_index,
+                                                    cons_index);
+                    if (num_descs_tx > 0) {
+                        s->regs.tdma.rings[ring_index].cons_index.fields.index
+                            += num_descs_tx;
+                        if (ring_index == BCM2838_GENET_DMA_RING_DEFAULT) {
+                            s->regs.intrl0.stat.fields.txdma_mbdone = 1;
+                        } else {
+                            s->regs.intrl1.stat.fields.tx_intrs
+                                |= 1 << ring_index;
+                        }
+                    }
+                }
+                break;
+            default:
+                break;
+            }
+        }
+        break;
+    case BCM2838_GENET_TDMA_RING_CFG:
+        if (s->regs.tdma.ring_cfg.fields.en != ring_cfg.fields.en) {
+            trace_bcm2838_genet_tx_dma_ring(ring_cfg.fields.en);
+        }
+        break;
+    case BCM2838_GENET_TDMA_CTRL:
+        if (s->regs.tdma.ctrl.fields.en != ctrl.fields.en) {
+            s->regs.tdma.status.fields.disabled = s->regs.tdma.ctrl.fields.en;
+            trace_bcm2838_genet_tx_dma(
+                ctrl.fields.en == 1 ? "enabled" : "disabled");
+        }
+        if (s->regs.tdma.ctrl.fields.ring_buf_en != ctrl.fields.ring_buf_en) {
+            trace_bcm2838_genet_tx_dma_ring_buf(ctrl.fields.ring_buf_en);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -241,7 +409,7 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
+            bcm2838_genet_tdma(s, offset, value);
             break;
         default:
             break;
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 025ac467d7..7fbe4d3ea5 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -110,6 +110,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT \
     (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, reg_id)))
 
+#define MAX_FRAME_SIZE                  0xFFF
+#define MAX_PACKET_SIZE                 1518
+#define MAX_PAYLOAD_SIZE                1500
+#define TX_MIN_PKT_SIZE                 60
+
+typedef union BCM2838GenetTxCsumInfo {
+    uint32_t value;
+    struct {
+        uint32_t offset:15;
+        uint32_t proto_udp:1;
+        uint32_t start:15;
+        uint32_t lv:1;
+    };
+} BCM2838GenetTxCsumInfo;
+
+typedef struct QEMU_PACKED BCM2838GenetXmitStatus {
+    uint32_t                length_status;  /* length and peripheral status */
+    uint32_t                ext_status;     /* Extended status */
+    uint32_t                rx_csum;        /* partial rx checksum */
+    uint32_t                unused1[9];     /* unused */
+    BCM2838GenetTxCsumInfo  tx_csum_info;   /* Tx checksum info. */
+    uint32_t                unused2[3];     /* unused */
+} BCM2838GenetXmitStatus;
+
 typedef union {
     uint32_t value;
     struct {
@@ -700,6 +724,8 @@ struct BCM2838GenetState {
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
+
+    uint8_t tx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.34.1


From 1bd297a639e76fb4a139d7a7d79e69bbb5245303 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 31/44] Impl GENET RX path

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 222 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 98030216f4..0686cb5002 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -251,6 +251,21 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     return active;
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+    bool dma_en = s->regs.rdma.ctrl.fields.en == 1;
+    bool ring_en = (s->regs.rdma.ring_cfg.fields.en & ring_mask) != 0;
+    bool ring_buf_en = (s->regs.rdma.ctrl.fields.ring_buf_en & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_rx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+
+    return active;
+}
+
 static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
                                uint64_t value)
 {
@@ -434,9 +449,212 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = sizeof(uint32_t)},
 };
 
+static int32_t bcm2838_genet_filter(BCM2838GenetState *s, const void *buf,
+                                    size_t size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static int32_t bcm2838_genet_filter2ring(BCM2838GenetState *s,
+                                         uint32_t filter_idx)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static bool is_packet_broadcast(const uint8_t *buf, size_t size)
+{
+    static const uint8_t bcst_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+    if (size < sizeof(bcst_addr)) {
+        return false;
+    }
+
+    return !memcmp(buf, bcst_addr, sizeof(bcst_addr));
+}
+
+static bool is_packet_multicast(const uint8_t *buf, size_t size)
+{
+    return !!(buf[0] & 0x01);
+}
+
+static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
+                                  const void *buf, size_t size)
+{
+    const size_t DESC_WORD_SIZE =
+        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
+
+    ssize_t len = 0;
+    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
+    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
+    hwaddr write_index =
+        (ring->write_ptr + ((hwaddr)ring->write_ptr_hi << 32)) / DESC_WORD_SIZE;
+    BCM2838GenetRdmaDesc *desc = &rdma->descs[write_index];
+
+    const hwaddr START_INDEX =
+        (ring->start_addr + ((hwaddr)ring->start_addr_hi << 32))
+            / DESC_WORD_SIZE;
+    const hwaddr END_INDEX =
+        (ring->end_addr + ((hwaddr)ring->end_addr_hi << 32)) / DESC_WORD_SIZE;
+
+    if (!bcm2838_genet_rdma_ring_active(s, ring_idx)) {
+        return -1;
+    }
+
+    desc->length_status.fields.sop = 1;
+
+    while (len < size) {
+        size_t l = size - len;
+        size_t buf_size = ring->ring_buf_size & 0xffff;
+        uint8_t *dma_buf = s->rx_packet;
+        hwaddr dma_buf_addr =
+            desc->address_lo + ((hwaddr)desc->address_hi << 32);
+        MemTxResult mem_tx_result = MEMTX_OK;
+        uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
+        BCM2838GenetXmitStatus *xmit_status = (BCM2838GenetXmitStatus *)dma_buf;
+        struct iovec iov;
+        bool isip4, isip6;
+        size_t l3hdr_off, l4hdr_off, l5hdr_off;
+        eth_ip6_hdr_info ip6hdr_info;
+        eth_ip4_hdr_info ip4hdr_info;
+        eth_l4_hdr_info  l4hdr_info;
+
+        if (l > ring->ring_buf_size) {
+            l = ring->ring_buf_size;
+        }
+
+        memcpy(frame_buf, buf + len, l);
+        iov.iov_base = frame_buf;
+        iov.iov_len = l;
+        eth_get_protocols(&iov, 1, 0,
+                          &isip4, &isip6,
+                          &l3hdr_off, &l4hdr_off, &l5hdr_off,
+                          &ip6hdr_info, &ip4hdr_info, &l4hdr_info);
+
+        len += l;
+
+        desc->length_status.fields.eop = !!(len >= size);
+        desc->length_status.fields.buflength = l
+            + sizeof(BCM2838GenetXmitStatus) + 2;
+        if (s->regs.umac.cmd.fields.crc_fwd) {
+            desc->length_status.fields.buflength += 4;
+        }
+        desc->length_status.fields.broadcast =
+            !!is_packet_broadcast(frame_buf, l);
+        desc->length_status.fields.multicast =
+            !!is_packet_multicast(frame_buf, l);
+
+        xmit_status->rx_csum = 0;
+        if (isip4) {
+            xmit_status->rx_csum = ip4hdr_info.ip4_hdr.ip_sum;
+        }
+        xmit_status->length_status = desc->length_status.value;
+
+        mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            dma_buf, buf_size);
+        if (mem_tx_result != MEMTX_OK) {
+            desc->length_status.fields.rxerr = 1;
+        }
+
+        if (desc->length_status.fields.rxerr) {
+            break;
+        }
+
+        ++ring->prod_index.fields.index;
+        if (++write_index > END_INDEX) {
+            write_index = START_INDEX;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * DESC_WORD_SIZE;
+        ring->write_ptr_hi = ((hwaddr)write_index * DESC_WORD_SIZE) >> 32;
+    }
+
+    if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
+        s->regs.intrl0.stat.fields.rxdma_mbdone = 1;
+    } else {
+        s->regs.intrl1.stat.fields.rx_intrs |= 1 << ring_idx;
+    }
+
+    return len;
+}
+
+static ssize_t bcm2838_genet_receive(NetClientState *nc, const uint8_t *buf,
+                                     size_t size)
+{
+    BCM2838GenetState *s = (BCM2838GenetState *)qemu_get_nic_opaque(nc);
+    ssize_t bytes_received = -1;
+    int32_t filter_index = -1;
+    int32_t ring_index = -1;
+
+    if (s->regs.rdma.ctrl.fields.en) {
+        filter_index = bcm2838_genet_filter(s, buf, size);
+
+        if (filter_index >= 0) {
+            ring_index = bcm2838_genet_filter2ring(s, filter_index);
+        } else {
+            ring_index = BCM2838_GENET_DMA_RING_CNT - 1;
+        }
+
+        if (size <= MAX_PACKET_SIZE) {
+            bytes_received = bcm2838_genet_rdma(s, ring_index, buf, size);
+        }
+    }
+
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
+
+    return bytes_received;
+}
+
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s)
+{
+    bool qemu_link_down = qemu_get_queue(s->nic)->link_down != 0;
+
+    if (qemu_link_down && s->phy_regs.bmsr.fields.lstatus == 1) {
+        trace_bcm2838_genet_phy_update_link("down");
+
+        s->phy_regs.bmsr.fields.anegcomplete = 0;
+
+        s->phy_regs.bmsr.fields.lstatus = 0;
+        s->regs.intrl0.stat.fields.link_down = 1;
+    } else if (!qemu_link_down && s->phy_regs.bmsr.fields.lstatus == 0) {
+        trace_bcm2838_genet_phy_update_link("up");
+
+        /*
+         * Complete auto-negotiation (fixed link partner's abilities for now:
+         * 1Gbps with flow control)
+         */
+        s->phy_regs.stat1000.fields._1000half = 1;
+        s->phy_regs.stat1000.fields._1000full = 1;
+
+        s->phy_regs.lpa.fields.pause_cap = 1;
+        s->phy_regs.lpa.fields.pause_asym = 1;
+        s->phy_regs.lpa.fields.lpack = 1;
+
+        s->phy_regs.bmsr.fields.anegcomplete = 1;
+
+        s->phy_regs.bmsr.fields.lstatus = 1;
+        s->regs.intrl0.stat.fields.link_up = 1;
+    }
+
+    bcm2838_genet_set_irq_default(s);
+}
+static void bcm2838_genet_set_link(NetClientState *nc)
+{
+    BCM2838GenetState *s = qemu_get_nic_opaque(nc);
+
+    bcm2838_genet_phy_update_link(s);
+}
+
 static NetClientInfo bcm2838_genet_client_info = {
     .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState)
+    .size = sizeof(NICState),
+    .receive = bcm2838_genet_receive,
+    .link_status_changed = bcm2838_genet_set_link,
 };
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
@@ -489,6 +707,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.misc = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(DeviceState *d)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 7fbe4d3ea5..8bcf560f87 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -726,6 +726,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.34.1


From 040b2460fdf307b0aa6d32c88a51c2c539e3d200 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Thu, 22 Jun 2023 19:18:35 +0300
Subject: [PATCH 32/44] Enable BCM2838 GENET controller

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c         | 16 ++++++++++++++++
 hw/arm/raspi4b.c                     | 17 -----------------
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 60ed535673..e4ad8927fc 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -47,6 +47,15 @@ static void bcm2838_peripherals_init(Object *obj)
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
 
+    /* Gigabit Ethernet */
+    object_initialize_child(obj, "genet", &s->genet, TYPE_BCM2838_GENET);
+    for (int i = 0; i < nb_nics; i++) {
+        if ((nd_table[i].used && nd_table[i].model) && !strcmp(nd_table[i].model, "bcmgenet")) {
+            qdev_set_nic_properties(DEVICE(&s->genet), &nd_table[i]);
+            break;
+        }
+    }
+
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
@@ -227,6 +236,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 &s->pcie_mmio_alias);
 
+    /* Gigabit Ethernet */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->genet), errp)) {
+        return;
+    }
+    regs_mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->genet), 0);
+    memory_region_add_subregion(&s->peri_low_mr, GENET_OFFSET, regs_mr);
+
     create_unimp(s_base, &s->clkisp, "bcm2835-clkisp", CLOCK_ISP_OFFSET,
                  CLOCK_ISP_SIZE);
 
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index c7fdf791d5..9a35e939f6 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -63,23 +63,6 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
 
 static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
-
-    /* Temporary disable following devices until they are implemented*/
-    const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-genet-v5",
-    };
-
-    for (int i = 0; i < ARRAY_SIZE(to_be_removed_from_dt_as_wa); i++) {
-        const char *dev_str = to_be_removed_from_dt_as_wa[i];
-
-        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        if (offset >= 0) {
-            if (!fdt_nop_node(fdt, offset)) {
-                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
-            }
-        }
-    }
-
     uint64_t ram_size = board_ram_size(info->board_id);
 
     if (ram_size > UPPER_RAM_BASE) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index be4fc20f11..2cd405efc8 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -13,6 +13,7 @@
 #include "hw/misc/bcm2838_rng200.h"
 #include "hw/misc/bcm2838_thermal.h"
 #include "hw/arm/bcm2838_pcie.h"
+#include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -75,6 +76,7 @@ struct BCM2838PeripheralState {
     UnimplementedDeviceState clkisp;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
+    BCM2838GenetState genet;
 
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
-- 
2.34.1


From 4ca35a5c30e7ee99f05abbb61edcf4a92f784519 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 21:51:57 +0300
Subject: [PATCH 33/44] Connect RNG200, PCIE and GENET to GIC

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index a1980cc181..83bfbc2cae 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -217,6 +217,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
          int_n++) {
@@ -239,6 +243,21 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
+        bcm2838_pcie_host_set_irq_num(BCM2838_PCIE_HOST(&ps->pcie_host), n,
+                                      int_n);
+    }
+
+    /* Connect Gigabit Ethernet controller to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
-- 
2.34.1


From 254c74d8970491ae9636bdb4aa77c5e1f7e22b92 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 22:22:56 +0300
Subject: [PATCH 34/44] Add Rpi4b boot tests

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/avocado/boot_linux_console.py | 92 +++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 6eab515718..62aac02bbb 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -501,6 +501,98 @@ def test_arm_raspi2_initrd(self):
         # Wait for VM to shut down gracefully
         self.vm.wait()
 
+    def test_arm_raspi4(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi4b2g
+        :avocado: tags=device:pl011
+        :avocado: tags=accel:tcg
+        :avocado: tags=rpi4b
+
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+            'pool/main/r/raspberrypi-firmware/'
+            'raspberrypi-kernel_1.20230106-1_arm64.deb')
+        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'root=/dev/mmcblk1p2 rootwait ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-append', kernel_command_line,
+                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+                         '-device', 'usb-kbd,bus=xhci.0')
+        self.vm.launch()
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.wait_for_console_pattern(console_pattern)
+        console_pattern = 'Product: QEMU USB Keyboard'
+        self.wait_for_console_pattern(console_pattern)
+
+
+    def test_arm_raspi4_initrd(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:raspi4b2g
+        :avocado: tags=device:pl011
+        :avocado: tags=accel:tcg
+        :avocado: tags=rpi4b
+
+        The kernel can be rebuilt using the kernel source referenced
+        and following the instructions on the on:
+        https://www.raspberrypi.org/documentation/linux/kernel/building.md
+        """
+        deb_url = ('http://archive.raspberrypi.org/debian/'
+            'pool/main/r/raspberrypi-firmware/'
+            'raspberrypi-kernel_1.20230106-1_arm64.deb')
+        deb_hash = '08dc55696535b18a6d4fe6fa10d4c0d905cbb2ed'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path, '/boot/kernel8.img')
+        dtb_path = self.extract_from_deb(deb_path, '/boot/bcm2711-rpi-4-b.dtb')
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '86b2be1384d41c8c388e63078a847f1e1c4cb1de/rootfs/'
+                      'arm64/rootfs.cpio.gz')
+        initrd_hash = 'f3d4f9fa92a49aa542f1b44d34be77bbf8ca5b9d'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-device', 'qemu-xhci,bus=pcie.1,id=xhci',
+                         '-device', 'usb-kbd,bus=xhci.0',
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
+                                                'BCM2835')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
+                                                'cprman@7e101000')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+        # TODO: Raspberry Pi4 doesn't shut down properly with recent kernels
+        # Wait for VM to shut down gracefully
+        #self.vm.wait()
+
     def test_arm_exynos4210_initrd(self):
         """
         :avocado: tags=arch:arm
-- 
2.34.1


From 400f647d1b1b3970dbebe35c49a031774f8d4e4c Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 35/44] Add mailbox test stub

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.c | 70 +++++++++++++++++++++++++++++++++++
 tests/qtest/bcm2838-mailbox.h | 48 ++++++++++++++++++++++++
 tests/qtest/meson.build       |  1 +
 3 files changed, 119 insertions(+)
 create mode 100644 tests/qtest/bcm2838-mailbox.c
 create mode 100644 tests/qtest/bcm2838-mailbox.h

diff --git a/tests/qtest/bcm2838-mailbox.c b/tests/qtest/bcm2838-mailbox.c
new file mode 100644
index 0000000000..211d167ff8
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.c
@@ -0,0 +1,70 @@
+/*
+ * Helper functions to work with BCM2838 mailbox via qtest interface.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "bcm2838-mailbox.h"
+
+
+static uint32_t qtest_mbox0_read_reg32(QTestState *s, uint32_t offset)
+{
+    return qtest_readl(s, MBOX0_BASE + offset);
+}
+
+static void qtest_mbox1_write_reg32(QTestState *s, uint32_t offset, uint32_t value)
+{
+    return qtest_writel(s, MBOX1_BASE + offset, value);
+}
+
+static void qtest_mbox1_write(QTestState *s, uint8_t channel, uint32_t data)
+{
+    MboxRegWrite reg;
+
+    reg.fields.channel = channel;
+    reg.fields.data = data;
+    qtest_mbox1_write_reg32(s, MBOX_REG_WRITE, reg.value);
+}
+
+int qtest_mbox0_has_data(QTestState *s) {
+    return !(qtest_mbox0_read_reg32(s, MBOX_REG_STATUS) & MBOX_READ_EMPTY);
+}
+
+int mbox0_has_data(void) {
+    return qtest_mbox0_has_data(global_qtest);
+}
+
+void qtest_mbox0_read_message(QTestState *s,
+                              uint8_t channel,
+                              void *msgbuf,
+                              size_t msgbuf_size)
+{
+    MboxRegRead reg;
+    uint32_t msgaddr;
+
+    g_assert(qtest_mbox0_has_data(s));
+    reg.value = qtest_mbox0_read_reg32(s, MBOX_REG_READ);
+    g_assert_cmphex(reg.fields.channel, ==, channel);
+    msgaddr = reg.fields.data << 4;
+    qtest_memread(s, msgaddr, msgbuf, msgbuf_size);
+}
+
+void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size) {
+    qtest_mbox0_read_message(global_qtest, channel, msgbuf, msgbuf_size);
+}
+
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr)
+{
+    qtest_mbox1_write(s, channel, msg_addr >> 4);
+}
+
+
+void mbox1_write_message(uint8_t channel, uint32_t msg_addr)
+{
+    qtest_mbox1_write_message(global_qtest, channel, msg_addr);
+}
diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
new file mode 100644
index 0000000000..a81b325af9
--- /dev/null
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -0,0 +1,48 @@
+/*
+ * Declarations for BCM2838 mailbox test.
+ *
+ * Copyright (c) 2023 Auriga LLC
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+typedef union {
+    uint32_t value;
+    struct {
+        uint32_t channel: 4;
+        uint32_t data   : 28;
+    } fields;
+} MboxRegWrite;
+
+typedef MboxRegWrite MboxRegRead;
+
+typedef struct {
+    uint32_t size;
+    uint32_t req_resp_code;
+} MboxBufHeader;
+
+#define DECLARE_TAG_TYPE(TypeName, RequestValueType, ResponseValueType) \
+typedef struct {                                                        \
+    uint32_t id;                                                        \
+    uint32_t value_buffer_size;                                         \
+    union {                                                             \
+        struct {                                                        \
+            uint32_t zero;                                              \
+            RequestValueType __attribute__((packed)) value;             \
+        } request;                                                      \
+        struct {                                                        \
+            uint32_t size   : 31;                                       \
+            uint32_t success: 1;                                        \
+            ResponseValueType __attribute__((packed)) value;            \
+        } response;                                                     \
+    };                                                                  \
+} TypeName
+
+
+int mbox0_has_data(void);
+void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
+int qtest_mbox0_has_data(QTestState *s);
+void qtest_mbox0_read_message(QTestState *s, uint8_t channel, void *msgbuf, size_t msgbuf_size);
+void qtest_mbox1_write_message(QTestState *s, uint8_t channel, uint32_t msg_addr);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b071d400b3..61e9aab835 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -318,6 +318,7 @@ qtests = {
   'tpm-tis-device-test': [io, tpmemu_files, 'tpm-tis-util.c'],
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
+  'bcm2838-mbox-property-test' : files('bcm2838-mailbox.c'),
 }
 
 if vnc.found()
-- 
2.34.1


From 6616b4b5a27f75d91d34b0cad7b5b69abacacb68 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 36/44] Add mailbox test constants

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 140 ++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index a81b325af9..df223f2cf7 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -7,6 +7,146 @@
  * See the COPYING file in the top-level directory.
  */
 
+#define MBOX0_BASE 0xFE00B880
+#define MBOX1_BASE 0xFE00B8A0
+
+#define MBOX_REG_READ   0x00
+#define MBOX_REG_WRITE  0x00
+#define MBOX_REG_PEEK   0x10
+#define MBOX_REG_SENDER 0x14
+#define MBOX_REG_STATUS 0x18
+#define MBOX_REG_CONFIG 0x1C
+
+#define MBOX_READ_EMPTY 0x40000000
+
+#define MBOX_CHANNEL_ID_PROPERTY 8
+
+#define MBOX_PROCESS_REQUEST      0x00000000
+#define MBOX_SUCCESS              0x80000000
+#define MBOX_ERROR_PARSING_BUFFER 0x80000001
+
+#define TAG_END                    0x00000000
+#define TAG_GET_FIRMWARE_REVISION  0x00000001
+#define TAG_GET_FIRMWARE_VARIANT   0x00000002
+#define TAG_GET_BOARD_REVISION     0x00010002
+#define TAG_GET_ARM_MEMORY         0x00010005
+#define TAG_GET_VC_MEMORY          0x00010006
+#define TAG_SET_DEVICE_POWER_STATE 0x00028001
+#define TAG_GET_CLOCK_STATE        0x00030001
+#define TAG_GET_CLOCK_RATE         0x00030002
+#define TAG_GET_MAX_CLOCK_RATE     0x00030004
+#define TAG_GET_MIN_CLOCK_RATE     0x00030007
+#define TAG_GET_CLOCKS             0x00010007
+#define TAG_GET_TEMPERATURE        0x00030006
+#define TAG_GET_MAX_TEMPERATURE    0x0003000a
+#define TAG_ALLOCATE_BUFFER        0x00040001
+#define TAG_RELEASE_FRAMEBUFFER    0x00048001
+#define TAG_BLANK_FRAMEBUFFER      0x00040002
+#define TAG_GET_FB_PHYS_WIDTH      0x00040003
+#define TAG_TEST_FB_PHYS_WIDTH     0x00044003
+#define TAG_SET_FB_PHYS_WIDTH      0x00048003
+#define TAG_GET_FB_VIRT_WIDTH      0x00040004
+#define TAG_TEST_FB_VIRT_WIDTH     0x00044004
+#define TAG_SET_FB_VIRT_WIDTH      0x00048004
+#define TAG_GET_FB_DEPTH           0x00040005
+#define TAG_TEST_FB_DEPTH          0x00044005
+#define TAG_SET_FB_DEPTH           0x00048005
+#define TAG_GET_PIXEL_ORDER        0x00040006
+#define TAG_TEST_PIXEL_ORDER       0x00044006
+#define TAG_SET_PIXEL_ORDER        0x00048006
+#define TAG_GET_FB_ALPHA_MODE      0x00040007
+#define TAG_TEST_FB_ALPHA_MODE     0x00044007
+#define TAG_SET_FB_ALPHA_MODE      0x00048007
+#define TAG_GET_PITCH              0x00040008
+#define TAG_SET_PITCH              0x00048008
+#define TAG_GET_VIRTUAL_OFFSET     0x00040009
+#define TAG_TEST_VIRTUAL_OFFSET    0x00044009
+#define TAG_SET_VIRTUAL_OFFSET     0x00048009
+#define TAG_GET_OVERSCAN           0x0004000a
+#define TAG_TEST_OVERSCAN          0x0004400a
+#define TAG_SET_OVERSCAN           0x0004800a
+#define TAG_SET_PALETTE            0x0004800b
+#define TAG_GET_COMMANDLINE        0x00050001
+#define TAG_GET_DMA_CHANNELS       0x00060001
+#define TAG_GET_THROTTLED          0x00030046
+#define TAG_GET_NUM_DISPLAYS       0x00040013
+#define TAG_GET_DISPLAY_SETTINGS   0x00040014
+#define TAG_GET_GPIO_CONFIG        0x00030043
+#define TAG_SET_GPIO_CONFIG        0x00038043
+#define TAG_GET_GPIO_STATE         0x00030041
+#define TAG_SET_GPIO_STATE         0x00038041
+#define TAG_INITIALIZE_VCHIQ       0x00048010
+
+#define BOARD_REVISION    11546898
+#define FIRMWARE_REVISION 346337
+#define FIRMWARE_VARIANT  0x77777777 /* TODO: Find the real value */
+
+#define ARM_MEMORY_BASE 0x00000000
+#define ARM_MEMORY_SIZE 0x3c000000
+#define VC_MEMORY_BASE  0x3c000000
+#define VC_MEMORY_SIZE  0x04000000
+#define VC_FB_BASE      0x3c100000
+#define VC_FB_SIZE      0x00096000
+
+#define CLOCK_ID_ROOT      0x00000000
+#define CLOCK_ID_EMMC      0x00000001
+#define CLOCK_ID_UART      0x00000002
+#define CLOCK_ID_ARM       0x00000003
+#define CLOCK_ID_CORE      0x00000004
+#define CLOCK_ID_UNDEFINED 0x12345678
+
+#define CLOCK_RATE_EMMC 50000000
+#define CLOCK_RATE_UART 3000000
+#define CLOCK_RATE_CORE 350000000
+#define CLOCK_RATE_ANY  700000000
+
+#define DEVICE_ID_SD_CARD   0x00000000
+#define DEVICE_ID_UART0     0x00000001
+#define DEVICE_ID_UART1     0x00000002
+#define DEVICE_ID_USB HCD   0x00000003
+#define DEVICE_ID_I2C0      0x00000004
+#define DEVICE_ID_I2C1      0x00000005
+#define DEVICE_ID_I2C2      0x00000006
+#define DEVICE_ID_SPI       0x00000007
+#define DEVICE_ID_CCP2TX    0x00000008
+#define DEVICE_ID_UNKNOWN_0 0x00000009
+#define DEVICE_ID_UNKNOWN_1 0x0000000a
+
+#define TEMPERATURE_ID_SOC 0x00000000
+
+#define TEMPERATURE_SOC     25000
+#define TEMPERATURE_SOC_MAX 99000
+
+#define ALIGN_4K 4096
+
+#define PIXEL_ORDER_BGR 0
+#define PIXEL_ORDER_RGB 1
+
+#define ALPHA_MODE_ENABLED  0
+#define ALPHA_MODE_REVERSED 1
+#define ALPHA_MODE_IGNORED  2
+
+#define GPIO_MASK 0x003c
+
+#define GPIO_0 0x00000080
+
+#define GPIO_DIRECTION_IN  0
+#define GPIO_DIRECTION_OUT 1
+
+#define GPIO_TERMINATION_DISABLED 0
+#define GPIO_TERMINATION_ENABLED  1
+
+#define GPIO_TERMINATION_PULLUP_DISABLED 0
+#define GPIO_TERMINATION_PULLUP_ENABLED  1
+
+#define GPIO_POLARITY_LOW  0
+#define GPIO_POLARITY_HIGH 1
+
+#define GPIO_STATE_DOWN 0
+
+/* Used to test stubs that don't perform actual work */
+#define DUMMY_VALUE 0x12345678
+
 typedef union {
     uint32_t value;
     struct {
-- 
2.34.1


From d78ec8ffc61b36c1f420b8f4eb295f98ee9c916e Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 37/44] Add mailbox tests tags. Part 1

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 185 ++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index df223f2cf7..1fc34d092d 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -179,6 +179,191 @@ typedef struct {                                                        \
     };                                                                  \
 } TypeName
 
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FIRMWARE_VARIANT_t,
+    struct {},
+    struct {
+        uint32_t variant;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_BOARD_REVISION_t,
+    struct {},
+    struct {
+        uint32_t revision;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_ARM_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_VC_MEMORY_t,
+    struct {},
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_DEVICE_POWER_STATE_t,
+    struct {
+        uint32_t device_id;
+        uint32_t enabled : 1;
+        uint32_t wait    : 1;
+        uint32_t reserved: 30;
+    },
+    struct {
+        uint32_t device_id;
+        uint32_t enabled : 1;
+        uint32_t wait    : 1;
+        uint32_t reserved: 30;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_STATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t enabled    : 1;
+        uint32_t not_present: 1;
+        uint32_t reserved   : 30;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MIN_CLOCK_RATE_t,
+    struct {
+        uint32_t clock_id;
+    },
+    struct {
+        uint32_t clock_id;
+        uint32_t rate;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_CLOCKS_t,
+    struct {},
+    struct {
+        uint32_t root_clock;
+        uint32_t arm_clock;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_MAX_TEMPERATURE_t,
+    struct {
+        uint32_t temperature_id;
+    },
+    struct {
+        uint32_t temperature_id;
+        uint32_t temperature;
+    });
+
+DECLARE_TAG_TYPE(TAG_ALLOCATE_BUFFER_t,
+    struct {
+        uint32_t alignment;
+    },
+    struct {
+        uint32_t base;
+        uint32_t size;
+    });
+
+DECLARE_TAG_TYPE(TAG_RELEASE_FRAMEBUFFER_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_BLANK_FRAMEBUFFER_t,
+    struct {
+        uint32_t on      : 1;
+        uint32_t reserved: 31;
+    },
+    struct {
+        uint32_t on      : 1;
+        uint32_t reserved: 31;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FB_PHYS_WIDTH_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_PHYS_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_PHYS_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FB_VIRT_WIDTH_t,
+    struct {},
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_VIRT_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_VIRT_WIDTH_t,
+    struct {
+        uint32_t width;
+        uint32_t height;
+    },
+    struct {
+        uint32_t width;
+        uint32_t height;
+    });
 
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
-- 
2.34.1


From 45a429a714ea63b59a96e58d607adea6c5fec997 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 38/44] Add mailbox tests tags. Part 2

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 152 ++++++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 1fc34d092d..2231c2c596 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -365,6 +365,158 @@ DECLARE_TAG_TYPE(TAG_SET_FB_VIRT_WIDTH_t,
         uint32_t height;
     });
 
+DECLARE_TAG_TYPE(TAG_GET_FB_DEPTH_t,
+    struct {},
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_DEPTH_t,
+    struct {
+        uint32_t bpp;
+    },
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_DEPTH_t,
+    struct {
+        uint32_t bpp;
+    },
+    struct {
+        uint32_t bpp;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_PIXEL_ORDER_t,
+    struct {},
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_PIXEL_ORDER_t,
+    struct {
+        uint32_t pixel_order;
+    },
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_PIXEL_ORDER_t,
+    struct {
+        uint32_t pixel_order;
+    },
+    struct {
+        uint32_t pixel_order;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_FB_ALPHA_MODE_t,
+    struct {},
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_FB_ALPHA_MODE_t,
+    struct {
+        uint32_t alpha_mode;
+    },
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_FB_ALPHA_MODE_t,
+    struct {
+        uint32_t alpha_mode;
+    },
+    struct {
+        uint32_t alpha_mode;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_PITCH_t,
+    struct {},
+    struct {
+        uint32_t pitch;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_PITCH_t,
+    struct {
+        uint32_t pitch;
+    },
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_GET_VIRTUAL_OFFSET_t,
+    struct {},
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_VIRTUAL_OFFSET_t,
+    struct {
+        uint32_t x;
+        uint32_t y;
+    },
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_VIRTUAL_OFFSET_t,
+    struct {
+        uint32_t x;
+        uint32_t y;
+    },
+    struct {
+        uint32_t x;
+        uint32_t y;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_OVERSCAN_t,
+    struct {},
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_TEST_OVERSCAN_t,
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    },
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_OVERSCAN_t,
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    },
+    struct {
+        uint32_t top;
+        uint32_t bottom;
+        uint32_t left;
+        uint32_t right;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_COMMANDLINE_t,
+    struct {},
+    struct {});
+
+DECLARE_TAG_TYPE(TAG_GET_DMA_CHANNELS_t,
+    struct {},
+    struct {
+        uint32_t mask;
+    });
+
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
 void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
-- 
2.34.1


From f3a67350e241ea7e9d05f5a2854f7b4c4b35e001 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 39/44] Add mailbox tests tags. Part 3

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mailbox.h | 78 +++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tests/qtest/bcm2838-mailbox.h b/tests/qtest/bcm2838-mailbox.h
index 2231c2c596..d8975b11ea 100644
--- a/tests/qtest/bcm2838-mailbox.h
+++ b/tests/qtest/bcm2838-mailbox.h
@@ -517,6 +517,84 @@ DECLARE_TAG_TYPE(TAG_GET_DMA_CHANNELS_t,
         uint32_t mask;
     });
 
+DECLARE_TAG_TYPE(TAG_GET_THROTTLED_t,
+    struct {},
+    struct {
+        uint32_t throttled;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_NUM_DISPLAYS_t,
+    struct {},
+    struct {
+        uint32_t num_displays;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_DISPLAY_SETTINGS_t,
+    struct {},
+    struct {
+        uint32_t display_num;
+        uint32_t phys_width;
+        uint32_t phys_height;
+        uint32_t bpp;
+        uint16_t pitch;
+        uint32_t virt_width;
+        uint32_t virt_height;
+        uint16_t virt_width_offset;
+        uint32_t virt_height_offset;
+        uint32_t fb_bus_address_lo;
+        uint32_t fb_bus_address_hi;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+    });
+
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_CONFIG_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t direction;
+        uint32_t polarity;
+        uint32_t term_en;
+        uint32_t term_pull_up;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_GET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+    },
+    struct {
+        uint32_t zero;
+        uint32_t state;
+    });
+
+DECLARE_TAG_TYPE(TAG_SET_GPIO_STATE_t,
+    struct {
+        uint32_t gpio_num;
+        uint32_t state;
+    },
+    struct {
+        uint32_t zero;
+    });
+
+DECLARE_TAG_TYPE(TAG_INITIALIZE_VCHIQ_t,
+    struct {},
+    struct {
+        uint32_t zero;
+    });
+
 int mbox0_has_data(void);
 void mbox0_read_message(uint8_t channel, void *msgbuf, size_t msgbuf_size);
 void mbox1_write_message(uint8_t channel, uint32_t msg_addr);
-- 
2.34.1


From c5ed4b872060c647583e4a493e821b5d700733a3 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 40/44] Add mailbox property tests. Part 1

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 179 +++++++++++++++++++++++
 tests/qtest/meson.build                  |   2 +-
 2 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/bcm2838-mbox-property-test.c

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
new file mode 100644
index 0000000000..ac173ed3ff
--- /dev/null
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -0,0 +1,179 @@
+/*
+ * Tests set for BCM2838 mailbox property interface.
+ *
+ * Copyright (c) 2022 Auriga
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "libqtest-single.h"
+#include "bcm2838-mailbox.h"
+
+#define MBOX_TEST_MESSAGE_ADDRESS 0x10000000
+
+#define TEST_TAG(x) TAG_ ## x
+#define TEST_TAG_TYPE(x) TAG_##x##_t
+
+#define TEST_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _test
+
+#define SETUP_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _setup
+
+#define CHECK_FN_NAME(test, subtest) \
+    test ## _ ## subtest ## _spec_check
+
+#define DECLARE_TEST_CASE_SETUP(testname, ...)              \
+    void SETUP_FN_NAME(testname, __VA_ARGS__)               \
+                             (TEST_TAG_TYPE(testname) * tag)
+
+/*----------------------------------------------------------------------------*/
+#define DECLARE_TEST_CASE(testname, ...)                                       \
+    __attribute__((weak))                                                      \
+    void SETUP_FN_NAME(testname, __VA_ARGS__)                                  \
+                      (TEST_TAG_TYPE(testname) * tag);                         \
+    static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
+                             (TEST_TAG_TYPE(testname) *tag);                   \
+    static void TEST_FN_NAME(testname, __VA_ARGS__)(void) {                    \
+        struct {                                                               \
+            MboxBufHeader header;                                              \
+            TEST_TAG_TYPE(testname) tag;                                       \
+            uint32_t end_tag;                                                  \
+        } mailbox_buffer = { 0 };                                              \
+                                                                               \
+        QTestState *qts = qtest_init("-machine raspi4b2g");                    \
+                                                                               \
+        mailbox_buffer.header.size = sizeof(mailbox_buffer);                   \
+        mailbox_buffer.header.req_resp_code = MBOX_PROCESS_REQUEST;            \
+                                                                               \
+        mailbox_buffer.tag.id = TEST_TAG(testname);                            \
+        mailbox_buffer.tag.value_buffer_size = MAX(                            \
+            sizeof(mailbox_buffer.tag.request.value),                          \
+            sizeof(mailbox_buffer.tag.response.value));                        \
+        mailbox_buffer.tag.request.zero = 0;                                   \
+                                                                               \
+        mailbox_buffer.end_tag = TAG_END;                                      \
+                                                                               \
+        if (SETUP_FN_NAME(testname, __VA_ARGS__)) {                            \
+            SETUP_FN_NAME(testname, __VA_ARGS__)(&mailbox_buffer.tag);         \
+        }                                                                      \
+                                                                               \
+        qtest_memwrite(qts, MBOX_TEST_MESSAGE_ADDRESS,                         \
+                    &mailbox_buffer, sizeof(mailbox_buffer));                  \
+        qtest_mbox1_write_message(qts, MBOX_CHANNEL_ID_PROPERTY,               \
+                            MBOX_TEST_MESSAGE_ADDRESS);                        \
+                                                                               \
+        qtest_mbox0_read_message(qts, MBOX_CHANNEL_ID_PROPERTY,                \
+                            &mailbox_buffer, sizeof(mailbox_buffer));          \
+                                                                               \
+        g_assert_cmphex(mailbox_buffer.header.req_resp_code, ==, MBOX_SUCCESS);\
+                                                                               \
+        g_assert_cmphex(mailbox_buffer.tag.id, ==, TEST_TAG(testname));        \
+        g_assert_cmpint(mailbox_buffer.tag.response.size, ==,                  \
+                    sizeof(mailbox_buffer.tag.response.value));                \
+        g_assert_cmpint(mailbox_buffer.tag.response.success, ==, 1);           \
+                                                                               \
+        CHECK_FN_NAME(testname, __VA_ARGS__)(&mailbox_buffer.tag);             \
+                                                                               \
+        qtest_quit(qts);                                                       \
+    }                                                                          \
+    static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
+                             (TEST_TAG_TYPE(testname) * tag)
+
+/*----------------------------------------------------------------------------*/
+
+#define QTEST_ADD_TEST_CASE(testname, ...)                                     \
+    qtest_add_func(stringify(/bcm2838/mbox/property/                           \
+                   TEST_FN_NAME(testname, __VA_ARGS__)-test),                  \
+                   TEST_FN_NAME(testname, __VA_ARGS__))
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FIRMWARE_REVISION) {
+    g_assert_cmpint(tag->response.value.revision, ==, FIRMWARE_REVISION);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_BOARD_REVISION) {
+    g_assert_cmpint(tag->response.value.revision, ==, BOARD_REVISION);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_ARM_MEMORY) {
+    g_assert_cmphex(tag->response.value.base, ==, ARM_MEMORY_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, ARM_MEMORY_SIZE);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_VC_MEMORY) {
+    g_assert_cmphex(tag->response.value.base, ==, VC_MEMORY_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, VC_MEMORY_SIZE);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_DEVICE_POWER_STATE) {
+    g_assert_cmphex(tag->response.value.device_id, ==, DEVICE_ID_UART0);
+    g_assert_cmpint(tag->response.value.enabled, ==, 1);
+    g_assert_cmpint(tag->response.value.wait, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_DEVICE_POWER_STATE) {
+    tag->request.value.device_id = DEVICE_ID_UART0;
+    tag->request.value.enabled = 1;
+    tag->request.value.wait = 1;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_STATE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.enabled, ==, 1);
+    g_assert_cmphex(tag->response.value.not_present, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_STATE) {
+   tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_EMMC);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_EMMC);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, EMMC) {
+    tag->request.value.clock_id = CLOCK_ID_EMMC;
+}
+
+/*----------------------------------------------------------------------------*/
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    QTEST_ADD_TEST_CASE(GET_FIRMWARE_REVISION);
+    QTEST_ADD_TEST_CASE(GET_BOARD_REVISION);
+    QTEST_ADD_TEST_CASE(GET_ARM_MEMORY);
+    QTEST_ADD_TEST_CASE(GET_VC_MEMORY);
+    QTEST_ADD_TEST_CASE(SET_DEVICE_POWER_STATE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_STATE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC);
+
+    return g_test_run();
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 61e9aab835..91393fcbd9 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -217,7 +217,7 @@ qtests_aarch64 = \
     ['tpm-tis-device-test', 'tpm-tis-device-swtpm-test'] : []) +                                         \
   (config_all_devices.has_key('CONFIG_XLNX_ZYNQMP_ARM') ? ['xlnx-can-test', 'fuzz-xlnx-dp-test'] : []) + \
   (config_all_devices.has_key('CONFIG_XLNX_VERSAL') ? ['xlnx-canfd-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test'] : []) +  \
+  (config_all_devices.has_key('CONFIG_RASPI') ? ['bcm2835-dma-test', 'bcm2838-mbox-property-test'] : []) +  \
   (config_all.has_key('CONFIG_TCG') and                                            \
    config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
   ['arm-cpu-features',
-- 
2.34.1


From 71e2b2c5e7c688c447167d151e7b76d79ff731f0 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 41/44] Add mailbox property tests. Part 2

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 196 ++++++++++++++++++++++-
 1 file changed, 195 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index ac173ed3ff..bcee9971c6 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -36,7 +36,8 @@
                       (TEST_TAG_TYPE(testname) * tag);                         \
     static void CHECK_FN_NAME(testname, __VA_ARGS__)                           \
                              (TEST_TAG_TYPE(testname) *tag);                   \
-    static void TEST_FN_NAME(testname, __VA_ARGS__)(void) {                    \
+    static void TEST_FN_NAME(testname, __VA_ARGS__)(void)                      \
+    {                                                                          \
         struct {                                                               \
             MboxBufHeader header;                                              \
             TEST_TAG_TYPE(testname) tag;                                       \
@@ -161,6 +162,179 @@ DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, EMMC) {
 }
 
 /*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, UART) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UART);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_UART);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, UART) {
+    tag->request.value.clock_id = CLOCK_ID_UART;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, CORE) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_CORE);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_CORE);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, CORE) {
+    tag->request.value.clock_id = CLOCK_ID_CORE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MIN_CLOCK_RATE, ANY) {
+    g_assert_cmphex(tag->response.value.clock_id, ==, CLOCK_ID_UNDEFINED);
+    g_assert_cmphex(tag->response.value.rate, ==, CLOCK_RATE_ANY);
+}
+DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, ANY) {
+    tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_TEMPERATURE) {
+    g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
+    g_assert_cmpint(tag->response.value.temperature, ==, TEMPERATURE_SOC);
+}
+DECLARE_TEST_CASE_SETUP(GET_TEMPERATURE) {
+    tag->request.value.temperature_id = TEMPERATURE_ID_SOC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_MAX_TEMPERATURE) {
+    g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
+    g_assert_cmpint(tag->response.value.temperature, ==, TEMPERATURE_SOC_MAX);
+}
+DECLARE_TEST_CASE_SETUP(GET_MAX_TEMPERATURE) {
+    tag->request.value.temperature_id = TEMPERATURE_ID_SOC;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(ALLOCATE_BUFFER) {
+    g_assert_cmphex(tag->response.value.base, ==, VC_FB_BASE);
+    g_assert_cmphex(tag->response.value.size, ==, VC_FB_SIZE);
+}
+DECLARE_TEST_CASE_SETUP(ALLOCATE_BUFFER) {
+    tag->request.value.alignment = ALIGN_4K;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(RELEASE_FRAMEBUFFER) { 
+    /* No special checks are needed for this test */
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(BLANK_FRAMEBUFFER) {
+    g_assert_cmphex(tag->response.value.on, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(BLANK_FRAMEBUFFER) {
+    tag->request.value.on = 0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_PHYS_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.height, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_PHYS_WIDTH) {
+    tag->request.value.width = DUMMY_VALUE;
+    tag->request.value.height = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_PHYS_WIDTH, INITIAL) {
+    g_assert_cmpint(tag->response.value.width, ==, 640);
+    g_assert_cmpint(tag->response.value.height, ==, 480);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_PHYS_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, 800);
+    g_assert_cmpint(tag->response.value.height, ==, 600);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_PHYS_WIDTH) {
+    tag->request.value.width = 800;
+    tag->request.value.height = 600;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_VIRT_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.height, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_VIRT_WIDTH) {
+    tag->request.value.width = DUMMY_VALUE;
+    tag->request.value.height = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL) {
+    g_assert_cmpint(tag->response.value.width, ==, 640);
+    g_assert_cmpint(tag->response.value.height, ==, 480);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_VIRT_WIDTH) {
+    g_assert_cmpint(tag->response.value.width, ==, 800);
+    g_assert_cmpint(tag->response.value.height, ==, 600);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_VIRT_WIDTH) {
+    tag->request.value.width = 800;
+    tag->request.value.height = 600;
+}
+
+//==============================================================================
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -174,6 +348,26 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, EMMC);
     QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, EMMC);
     QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, EMMC);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, UART);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, CORE);
+    QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_TEMPERATURE);
+    QTEST_ADD_TEST_CASE(GET_MAX_TEMPERATURE);
+    QTEST_ADD_TEST_CASE(ALLOCATE_BUFFER);
+    QTEST_ADD_TEST_CASE(RELEASE_FRAMEBUFFER);
+    QTEST_ADD_TEST_CASE(BLANK_FRAMEBUFFER);
+    QTEST_ADD_TEST_CASE(TEST_FB_PHYS_WIDTH);
+    QTEST_ADD_TEST_CASE(GET_FB_PHYS_WIDTH, INITIAL);
+    QTEST_ADD_TEST_CASE(SET_FB_PHYS_WIDTH);
+    QTEST_ADD_TEST_CASE(TEST_FB_VIRT_WIDTH);
+    QTEST_ADD_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL);
+    QTEST_ADD_TEST_CASE(SET_FB_VIRT_WIDTH);
 
     return g_test_run();
 }
-- 
2.34.1


From b19a844a74d1fc1cd02002946d6eeb45813fa756 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 42/44] Add mailbox property tests. Part 3

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 213 ++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index bcee9971c6..e833529a00 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -334,7 +334,194 @@ DECLARE_TEST_CASE_SETUP(SET_FB_VIRT_WIDTH) {
     tag->request.value.height = 600;
 }
 
-//==============================================================================
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_DEPTH) {
+    tag->request.value.bpp = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 16);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 24);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_DEPTH) {
+    tag->request.value.bpp = 24;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_PIXEL_ORDER) {
+    tag->request.value.pixel_order = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_RGB);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PIXEL_ORDER, BGR) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(SET_PIXEL_ORDER, BGR) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PIXEL_ORDER, RGB) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(SET_PIXEL_ORDER, RGB) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_FB_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_FB_ALPHA_MODE) {
+    tag->request.value.alpha_mode = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_FB_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, ENABLED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_ENABLED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, ENABLED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_ENABLED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, REVERSED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_REVERSED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, REVERSED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_REVERSED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_FB_ALPHA_MODE, IGNORED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+DECLARE_TEST_CASE_SETUP(SET_FB_ALPHA_MODE, IGNORED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_IGNORED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_PITCH) {
+    g_assert_cmpint(tag->response.value.pitch, ==, 1280);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.y, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(TEST_VIRTUAL_OFFSET) {
+    tag->request.value.x = DUMMY_VALUE;
+    tag->request.value.y = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_VIRTUAL_OFFSET, _0_) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_VIRTUAL_OFFSET, _0_) {
+    tag->request.value.x = 0;
+    tag->request.value.y = 0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_VIRTUAL_OFFSET, _42_) {
+    g_assert_cmpint(tag->response.value.x, ==, 42);
+    g_assert_cmpint(tag->response.value.y, ==, 42);
+}
+DECLARE_TEST_CASE_SETUP(SET_VIRTUAL_OFFSET, _42_) {
+    tag->request.value.x = 42;
+    tag->request.value.y = 42;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(TEST_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(TEST_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_DMA_CHANNELS) {
+    g_assert_cmphex(tag->response.value.mask, ==, GPIO_MASK);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_COMMANDLINE) {
+    /* No special checks are needed for this test case */
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_NUM_DISPLAYS) {
+    g_assert_cmpint(tag->response.value.num_displays, ==, 1);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_PITCH) {
+    /* No special checks are needed for this test case */
+}
+DECLARE_TEST_CASE_SETUP(SET_PITCH) {
+    tag->request.value.pitch = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -368,6 +555,30 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(TEST_FB_VIRT_WIDTH);
     QTEST_ADD_TEST_CASE(GET_FB_VIRT_WIDTH, INITIAL);
     QTEST_ADD_TEST_CASE(SET_FB_VIRT_WIDTH);
+    QTEST_ADD_TEST_CASE(TEST_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(GET_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(SET_FB_DEPTH);
+    QTEST_ADD_TEST_CASE(TEST_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(GET_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(SET_PIXEL_ORDER, BGR);
+    QTEST_ADD_TEST_CASE(SET_PIXEL_ORDER, RGB);
+    QTEST_ADD_TEST_CASE(TEST_FB_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(GET_FB_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, ENABLED);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, REVERSED);
+    QTEST_ADD_TEST_CASE(SET_FB_ALPHA_MODE, IGNORED);
+    QTEST_ADD_TEST_CASE(GET_PITCH);
+    QTEST_ADD_TEST_CASE(TEST_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(GET_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(SET_VIRTUAL_OFFSET, _0_);
+    QTEST_ADD_TEST_CASE(SET_VIRTUAL_OFFSET, _42_);
+    QTEST_ADD_TEST_CASE(GET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(TEST_OVERSCAN);
+    QTEST_ADD_TEST_CASE(SET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(GET_DMA_CHANNELS);
+    QTEST_ADD_TEST_CASE(GET_COMMANDLINE);
+    QTEST_ADD_TEST_CASE(GET_NUM_DISPLAYS);
+    QTEST_ADD_TEST_CASE(SET_PITCH);
 
     return g_test_run();
 }
-- 
2.34.1


From 8a9f57880230ee91b4b5ce87442c5a94a2301330 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 43/44] Add missed BCM2835 properties

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/misc/bcm2835_property.c            | 170 ++++++++++++++++++++++++++
 include/hw/misc/raspberrypi-fw-defs.h |  11 ++
 2 files changed, 181 insertions(+)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 4ed9faa54a..7d2d6e518d 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -19,6 +19,31 @@
 #include "trace.h"
 #include "hw/arm/raspi_platform.h"
 
+#define RPI_EXP_GPIO_BASE       128
+#define VC4_GPIO_EXPANDER_COUNT 8
+#define VCHI_BUSADDR_SIZE       sizeof(uint32_t)
+
+struct vc4_display_settings_t {
+    uint32_t display_num;
+    uint32_t width;
+    uint32_t height;
+    uint32_t depth;
+    uint16_t pitch;
+    uint32_t virtual_width;
+    uint32_t virtual_height;
+    uint16_t virtual_width_offset;
+    uint32_t virtual_height_offset;
+    unsigned long fb_bus_address;
+} QEMU_PACKED;
+
+struct vc4_gpio_expander_t {
+    uint32_t direction;
+    uint32_t polarity;
+    uint32_t term_en;
+    uint32_t term_pull_up;
+    uint32_t state;
+} vc4_gpio_expander[VC4_GPIO_EXPANDER_COUNT];
+
 /* https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface */
 
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
@@ -30,6 +55,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     uint32_t tmp;
     int n;
     uint32_t offset, length, color;
+    uint32_t gpio_num;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -138,6 +164,13 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
 
+        case RPI_FWREQ_GET_CLOCKS:
+            /* TODO: add more clock IDs if needed */
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 16, RPI_FIRMWARE_ARM_CLK_ID);
+            resplen = 8;
+            break;
+
         case RPI_FWREQ_SET_CLOCK_RATE:
         case RPI_FWREQ_SET_MAX_CLOCK_RATE:
         case RPI_FWREQ_SET_MIN_CLOCK_RATE:
@@ -276,6 +309,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             stl_le_phys(&s->dma_as, value + 12, 0);
             resplen = 4;
             break;
+
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
@@ -301,6 +335,142 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
                                     resplen);
             break;
 
+        case RPI_FWREQ_GET_THROTTLED:
+            stl_le_phys(&s->dma_as, value + 12, 0);
+            resplen = 4;
+            break;
+
+        case RPI_FWREQ_FRAMEBUFFER_GET_DISPLAY_SETTINGS:
+            stl_le_phys(&s->dma_as, value + 12, 0); /* display_num */
+            stl_le_phys(&s->dma_as, value + 16, 800); /* width */
+            stl_le_phys(&s->dma_as, value + 20, 600); /* height */
+            stl_le_phys(&s->dma_as, value + 24, 32); /* depth */
+            stl_le_phys(&s->dma_as, value + 28, 32); /* pitch */
+            stl_le_phys(&s->dma_as, value + 30, 0); /* virtual_width */
+            stl_le_phys(&s->dma_as, value + 34, 0); /* virtual_height */
+            stl_le_phys(&s->dma_as, value + 38, 0); /* virtual_width_offset */
+            stl_le_phys(&s->dma_as, value + 40, 0); /* virtual_height_offset */
+            stl_le_phys(&s->dma_as, value + 44, 0); /* fb_bus_address low */
+            stl_le_phys(&s->dma_as, value + 48, 0); /* fb_bus_address hi */
+            resplen = sizeof(struct vc4_display_settings_t);
+            break;
+
+        case RPI_FWREQ_FRAMEBUFFER_SET_PITCH:
+            resplen = 0;
+            break;
+
+        case RPI_FWREQ_GET_GPIO_CONFIG:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_CONFIG "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    stl_le_phys(&s->dma_as, value + 16,
+                                vc4_gpio_expander[gpio_num].direction);
+                    stl_le_phys(&s->dma_as, value + 20,
+                                vc4_gpio_expander[gpio_num].polarity);
+                    stl_le_phys(&s->dma_as, value + 24,
+                                vc4_gpio_expander[gpio_num].term_en);
+                    stl_le_phys(&s->dma_as, value + 28,
+                                vc4_gpio_expander[gpio_num].term_pull_up);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4 * 5;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_GET_GPIO_CONFIG "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_SET_GPIO_CONFIG:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_CONFIG "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    vc4_gpio_expander[gpio_num].direction =
+                        ldl_le_phys(&s->dma_as, value + 16);
+                    vc4_gpio_expander[gpio_num].polarity =
+                        ldl_le_phys(&s->dma_as, value + 20);
+                    vc4_gpio_expander[gpio_num].term_en =
+                        ldl_le_phys(&s->dma_as, value + 24);
+                    vc4_gpio_expander[gpio_num].term_pull_up =
+                        ldl_le_phys(&s->dma_as, value + 28);
+                    vc4_gpio_expander[gpio_num].state =
+                        ldl_le_phys(&s->dma_as, value + 32);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_SET_GPIO_CONFIG "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_GET_GPIO_STATE:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_GET_GPIO_STATE "
+                              "not implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    stl_le_phys(&s->dma_as, value + 16,
+                                vc4_gpio_expander[gpio_num].state);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 8;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_GET_GPIO_STATE "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_SET_GPIO_STATE:
+            if (ldl_le_phys(&s->dma_as, value + 12) < RPI_EXP_GPIO_BASE) {
+                qemu_log_mask(LOG_UNIMP, "RPI_FWREQ_SET_GPIO_STATE not "
+                              "implemented for gpiochip0\n");
+            } else {
+                gpio_num = ldl_le_phys(&s->dma_as, value + 12)
+                           - RPI_EXP_GPIO_BASE;
+
+                if (gpio_num < VC4_GPIO_EXPANDER_COUNT) {
+                    vc4_gpio_expander[gpio_num].state = ldl_le_phys(&s->dma_as,
+                                                                    value + 16);
+                    /* must be equal 0 */
+                    stl_le_phys(&s->dma_as, value + 12, 0);
+                    resplen = 4;
+                } else {
+                    qemu_log_mask(LOG_GUEST_ERROR,
+                                  "RPI_FWREQ_SET_GPIO_STATE "
+                                  "gpio num must be < %d",
+                                  RPI_EXP_GPIO_BASE + VC4_GPIO_EXPANDER_COUNT);
+                }
+            }
+            break;
+
+        case RPI_FWREQ_VCHIQ_INIT:
+            stl_le_phys(&s->dma_as,
+                        value + offsetof(rpi_firmware_prop_request_t, payload),
+                        0);
+            resplen = VCHI_BUSADDR_SIZE;
+            break;
         default:
             qemu_log_mask(LOG_UNIMP,
                           "bcm2835_property: unhandled tag 0x%08x\n", tag);
diff --git a/include/hw/misc/raspberrypi-fw-defs.h b/include/hw/misc/raspberrypi-fw-defs.h
index 4551fe7450..d461b30749 100644
--- a/include/hw/misc/raspberrypi-fw-defs.h
+++ b/include/hw/misc/raspberrypi-fw-defs.h
@@ -160,4 +160,15 @@ enum rpi_firmware_clk_id {
     RPI_FIRMWARE_NUM_CLK_ID,
 };
 
+struct rpi_firmware_property_tag_header {
+    uint32_t tag;
+    uint32_t buf_size;
+    uint32_t req_resp_size;
+};
+
+typedef struct rpi_firmware_prop_request {
+    struct rpi_firmware_property_tag_header hdr;
+    uint8_t payload[0];
+} rpi_firmware_prop_request_t;
+
 #endif /* INCLUDE_HW_MISC_RASPBERRYPI_FW_DEFS_H_ */
-- 
2.34.1


From 9b53771a53889c191c7904543d76d8c089c9de85 Mon Sep 17 00:00:00 2001
From: Sergey Kambalin <sergey.kambalin@auriga.com>
Date: Sun, 23 Jul 2023 23:01:13 +0300
Subject: [PATCH 44/44] Append added properties to mailbox test

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 82 ++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index e833529a00..68e2b11db6 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -242,6 +242,12 @@ DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, ANY) {
     tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCKS) {
+    g_assert_cmphex(tag->response.value.root_clock, ==, CLOCK_ID_ROOT);
+    g_assert_cmphex(tag->response.value.arm_clock, ==, CLOCK_ID_ARM);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_TEMPERATURE) {
     g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
@@ -508,11 +514,31 @@ DECLARE_TEST_CASE(GET_COMMANDLINE) {
     /* No special checks are needed for this test case */
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_THROTTLED) {
+    g_assert_cmpint(tag->response.value.throttled, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_NUM_DISPLAYS) {
     g_assert_cmpint(tag->response.value.num_displays, ==, 1);
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_DISPLAY_SETTINGS) {
+    g_assert_cmpint(tag->response.value.display_num, ==, 0);
+    g_assert_cmpint(tag->response.value.phys_width, ==, 800);
+    g_assert_cmpint(tag->response.value.phys_height, ==, 600);
+    g_assert_cmpint(tag->response.value.bpp, ==, 32);
+    g_assert_cmpint(tag->response.value.pitch, ==, 32);
+    g_assert_cmpint(tag->response.value.virt_width, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_height, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_width_offset, ==, 0);
+    g_assert_cmpint(tag->response.value.virt_height_offset, ==, 0);
+    g_assert_cmphex(tag->response.value.fb_bus_address_lo, ==, 0x00000000);
+    g_assert_cmphex(tag->response.value.fb_bus_address_hi, ==, 0x00000000);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(SET_PITCH) {
     /* No special checks are needed for this test case */
@@ -521,6 +547,54 @@ DECLARE_TEST_CASE_SETUP(SET_PITCH) {
     tag->request.value.pitch = DUMMY_VALUE;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_GPIO_CONFIG) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+    g_assert_cmphex(tag->response.value.direction, ==, GPIO_DIRECTION_IN);
+    g_assert_cmphex(tag->response.value.polarity, ==, GPIO_POLARITY_LOW);
+    g_assert_cmphex(tag->response.value.term_en, ==, GPIO_TERMINATION_DISABLED);
+    g_assert_cmphex(tag->response.value.term_pull_up, ==, GPIO_TERMINATION_PULLUP_DISABLED);
+}
+DECLARE_TEST_CASE_SETUP(GET_GPIO_CONFIG) {
+    tag->request.value.gpio_num = GPIO_0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_GPIO_CONFIG) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_GPIO_CONFIG) {
+    tag->request.value.gpio_num = GPIO_0;
+    tag->request.value.direction = DUMMY_VALUE;
+    tag->request.value.polarity = DUMMY_VALUE;
+    tag->request.value.term_en = DUMMY_VALUE;
+    tag->request.value.term_pull_up = DUMMY_VALUE;
+    tag->request.value.state = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_GPIO_STATE) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+    g_assert_cmphex(tag->response.value.state, ==, GPIO_STATE_DOWN);
+}
+DECLARE_TEST_CASE_SETUP(GET_GPIO_STATE) {
+    tag->request.value.gpio_num = GPIO_0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(SET_GPIO_STATE) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(SET_GPIO_STATE) {
+    tag->request.value.gpio_num = GPIO_0;
+    tag->request.value.state = GPIO_STATE_DOWN;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(INITIALIZE_VCHIQ) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
@@ -544,6 +618,7 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_CLOCKS);
     QTEST_ADD_TEST_CASE(GET_TEMPERATURE);
     QTEST_ADD_TEST_CASE(GET_MAX_TEMPERATURE);
     QTEST_ADD_TEST_CASE(ALLOCATE_BUFFER);
@@ -577,8 +652,15 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(SET_OVERSCAN);
     QTEST_ADD_TEST_CASE(GET_DMA_CHANNELS);
     QTEST_ADD_TEST_CASE(GET_COMMANDLINE);
+    QTEST_ADD_TEST_CASE(GET_THROTTLED);
     QTEST_ADD_TEST_CASE(GET_NUM_DISPLAYS);
+    QTEST_ADD_TEST_CASE(GET_DISPLAY_SETTINGS);
     QTEST_ADD_TEST_CASE(SET_PITCH);
+    QTEST_ADD_TEST_CASE(GET_GPIO_CONFIG);
+    QTEST_ADD_TEST_CASE(SET_GPIO_CONFIG);
+    QTEST_ADD_TEST_CASE(GET_GPIO_STATE);
+    QTEST_ADD_TEST_CASE(SET_GPIO_STATE);
+    QTEST_ADD_TEST_CASE(INITIALIZE_VCHIQ);
 
     return g_test_run();
 }
-- 
2.34.1


