Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A36F0859A61
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 02:19:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsIB-0003E0-By; Sun, 18 Feb 2024 20:17:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsI9-0003CL-Hn; Sun, 18 Feb 2024 20:17:57 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsI6-0004CB-6F; Sun, 18 Feb 2024 20:17:57 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-6083dc087b3so2137527b3.0; 
 Sun, 18 Feb 2024 17:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305472; x=1708910272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMPrdv4T+WGwInCWbTokJR2DjVi4X6NMjHv+VJofIwM=;
 b=gTrFxrjqHsD+QWQ6jzDgXz1Q5xQfYTWw/TD91w03MvRzaHAi/P9ZQopeNLSv4H+MgV
 dEoOeYA2JmcLMi7/tQ+v1DswSyZM5+eMGh5wro7LQnB28u9uOZpVBeG9bCxiB3nocTvw
 p/B9CyjiY622WkY99ouLfqh4c3ukAl/Wbh+thT2DQKgZ0cwoZoU3SWkz9h66DB+OvVYm
 Wlc1h7B2SRpxizeraGY9IGErp3MdiJE4dqWnPv58bm/dt2djtp9zuVT6GlX6dqCBtDpK
 gxBrCBFgeT1P90BdYpMBN+hiST6kHYyw37tuUNiG+Vhmv85rh9Ef5YrVkNecS83QDXrW
 NkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305472; x=1708910272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMPrdv4T+WGwInCWbTokJR2DjVi4X6NMjHv+VJofIwM=;
 b=mViImNFJj9fPFHSEghYo0O2AXY9IFNhosAO2q27k+XN06kDCnp1WusSKUdxULc22Eq
 yq4riKio5UIpPENpFVZ6px54o4O0CP4p5df4v8izggsybdcNGdqjovWY/KwhQo/UVgWJ
 2y2KYblqJcwSLPLhzFLSTE0hA/LIbgmCsg9mqMEcVwETsfMh41AOXEcc8s5V6UhSw+DM
 ZwuLUSvm7I5QY8fyG37cwlW16gAjAjVnc/NIv+tJLlwvbZLl7CKKxJJydyZlFxxLiOYI
 KK25b81euEsTxpqyyS1GIvOlbO+jGxtJQDDsv/z+axyhve9XlXRomI7dVdqGCNEaOTFK
 bgJg==
X-Gm-Message-State: AOJu0Yw8Mk7QXAmoz7LNH+M8vq0YftT9JTRVMwBb8CD+qAURL/5V0Tmu
 K+tRzYTEYsXoEvlRbxbn8hvZJqnSYFEXuYgJOM/DAHOTGKOCgjuFUvOYYu6hxeA=
X-Google-Smtp-Source: AGHT+IHhljDiJ/8cJBQXLSB3cn25hN1uG+vyEk8+X50SNEaaZw19TdAasCa/Fa3MhsWXB310CIqY1w==
X-Received: by 2002:a81:4f4d:0:b0:608:1b39:245e with SMTP id
 d74-20020a814f4d000000b006081b39245emr3300033ywb.44.1708305472552; 
 Sun, 18 Feb 2024 17:17:52 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:17:52 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 02/41] Split out common part of peripherals
Date: Sun, 18 Feb 2024 19:17:00 -0600
Message-Id: <20240219011739.2316619-3-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1134.google.com
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

Pre-setup for BCM2838 introduction

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2835_peripherals.c         | 198 +++++++++++++++------------
 hw/arm/bcm2836.c                     |  24 ++--
 include/hw/arm/bcm2835_peripherals.h |  29 +++-
 include/hw/arm/bcm2836.h             |   3 +-
 4 files changed, 154 insertions(+), 100 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index d5573fd954..ed38a08a57 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -30,9 +30,9 @@
 #define SEPARATE_DMA_IRQ_MAX 10
 #define ORGATED_DMA_IRQ_COUNT 4
 
-static void create_unimp(BCM2835PeripheralState *ps,
-                         UnimplementedDeviceState *uds,
-                         const char *name, hwaddr ofs, hwaddr size)
+void create_unimp(BCMSocPeripheralBaseState *ps,
+                  UnimplementedDeviceState *uds,
+                  const char *name, hwaddr ofs, hwaddr size)
 {
     object_initialize_child(OBJECT(ps), name, uds, TYPE_UNIMPLEMENTED_DEVICE);
     qdev_prop_set_string(DEVICE(uds), "name", name);
@@ -45,9 +45,36 @@ static void create_unimp(BCM2835PeripheralState *ps,
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
+    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(obj);
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
+    BCMSocPeripheralBaseState *s = BCM_SOC_PERIPHERALS_BASE(obj);
+    BCMSocPeripheralBaseClass *bc = BCM_SOC_PERIPHERALS_BASE_GET_CLASS(obj);
 
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
 
@@ -152,7 +160,72 @@ static void bcm2835_peripherals_init(Object *obj)
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 {
+    MemoryRegion *mphi_mr;
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(dev);
+    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    int n;
+
+    bcm_soc_peripherals_common_realize(dev, errp);
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
+void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp)
+{
+    BCMSocPeripheralBaseState *s = BCM_SOC_PERIPHERALS_BASE(dev);
     Object *obj;
     MemoryRegion *ram;
     Error *err = NULL;
@@ -285,14 +358,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
@@ -315,9 +380,6 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(&s->peri_mr, EMMC1_OFFSET,
                 sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhci), 0));
-    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
-        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
-                               INTERRUPT_ARASANSDIO));
 
     /* SDHOST */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->sdhost), errp)) {
@@ -340,49 +402,11 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
@@ -436,21 +460,27 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
+    BCMSocPeripheralBaseClass *bc = BCM_SOC_PERIPHERALS_BASE_CLASS(oc);
 
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
+        .parent = TYPE_BCM_SOC_PERIPHERALS_BASE,
+        .instance_size = sizeof(BCM2835PeripheralState),
+        .instance_init = bcm2835_peripherals_init,
+        .class_init = bcm2835_peripherals_class_init,
+    }, {
+        .name = TYPE_BCM_SOC_PERIPHERALS_BASE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(BCMSocPeripheralBaseState),
+        .instance_init = raspi_peripherals_base_init,
+        .class_size = sizeof(BCMSocPeripheralBaseClass),
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
index e9768f2ab9..7e4c60dd80 100644
--- a/hw/arm/bcm2836.c
+++ b/hw/arm/bcm2836.c
@@ -68,10 +68,10 @@ static void bcm283x_init(Object *obj)
                               "vcram-size");
 }
 
-bool bcm283x_common_realize(DeviceState *dev, Error **errp)
+bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
+                            Error **errp)
 {
-    BCM283XState *s = BCM283X(dev);
-    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseState *s = BCM283X_BASE(dev);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
     Object *obj;
 
@@ -79,17 +79,15 @@ bool bcm283x_common_realize(DeviceState *dev, Error **errp)
 
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
 
@@ -97,8 +95,10 @@ static void bcm2835_realize(DeviceState *dev, Error **errp)
 {
     BCM283XState *s = BCM283X(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCMSocPeripheralBaseState *ps_base
+        = BCM_SOC_PERIPHERALS_BASE(&s->peripherals);
 
-    if (!bcm283x_common_realize(dev, errp)) {
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
         return;
     }
 
@@ -119,8 +119,10 @@ static void bcm2836_realize(DeviceState *dev, Error **errp)
     BCM283XState *s = BCM283X(dev);
     BCM283XBaseState *s_base = BCM283X_BASE(dev);
     BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
+    BCMSocPeripheralBaseState *ps_base
+        = BCM_SOC_PERIPHERALS_BASE(&s->peripherals);
 
-    if (!bcm283x_common_realize(dev, errp)) {
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
         return;
     }
 
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index 0203bb79d8..1fc96218f8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -35,10 +35,13 @@
 #include "hw/misc/unimp.h"
 #include "qom/object.h"
 
+#define TYPE_BCM_SOC_PERIPHERALS_BASE "bcm-soc-peripherals-base"
+OBJECT_DECLARE_TYPE(BCMSocPeripheralBaseState, BCMSocPeripheralBaseClass,
+                    BCM_SOC_PERIPHERALS_BASE)
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 OBJECT_DECLARE_SIMPLE_TYPE(BCM2835PeripheralState, BCM2835_PERIPHERALS)
 
-struct BCM2835PeripheralState {
+struct BCMSocPeripheralBaseState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
@@ -60,12 +63,9 @@ struct BCM2835PeripheralState {
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
     BCM2835SPIState spi[1];
     UnimplementedDeviceState i2c[3];
@@ -79,4 +79,25 @@ struct BCM2835PeripheralState {
     UnimplementedDeviceState sdramc;
 };
 
+struct BCMSocPeripheralBaseClass {
+    /*< private >*/
+    SysBusDeviceClass parent_class;
+    /*< public >*/
+    uint64_t peri_size; /* Peripheral range size */
+};
+
+struct BCM2835PeripheralState {
+    /*< private >*/
+    BCMSocPeripheralBaseState parent_obj;
+    /*< public >*/
+    BCM2835RngState rng;
+    Bcm2835ThermalState thermal;
+    BCM2835GpioState gpio;
+};
+
+void create_unimp(BCMSocPeripheralBaseState *ps,
+                  UnimplementedDeviceState *uds,
+                  const char *name, hwaddr ofs, hwaddr size);
+void bcm_soc_peripherals_common_realize(DeviceState *dev, Error **errp);
+
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/arm/bcm2836.h b/include/hw/arm/bcm2836.h
index 5a6717ca91..918fb3bf14 100644
--- a/include/hw/arm/bcm2836.h
+++ b/include/hw/arm/bcm2836.h
@@ -64,6 +64,7 @@ struct BCM283XState {
     BCM2835PeripheralState peripherals;
 };
 
-bool bcm283x_common_realize(DeviceState *dev, Error **errp);
+bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
+                            Error **errp);
 
 #endif /* BCM2836_H */
-- 
2.34.1


