Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01769718E97
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 00:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4UOk-0004gn-O6; Wed, 31 May 2023 18:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOf-0004d5-0K
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:28 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4UOY-00058H-Hb
 for qemu-devel@nongnu.org; Wed, 31 May 2023 18:34:24 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4eed764a10cso61364e87.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685572456; x=1688164456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hD5SWLVogZIj3Sd56IpeZ4SmSKFNXjKZY8kepnkg57M=;
 b=Dymjd7WeZ8qXDW9Nz0cUc23yk9qePvTvCqSrGPDU5t1Fn9kHI8heCCsUZBwJUtFKF2
 4KtZiJ3m8FblnhBwU4v5PPk3BtfpIO6GBbZfGWyq8Pj4qP7TjYjOGAx9NC8AOyQ9DvgF
 1UX16bYh2QTxYv5KXDUsfmj60fDS++1ahuw/Amsfmo70Mvy0O09f4bZhe6KXQaUrFfat
 k6RKZHZTyi/L0xOb2HmEmQggFZSGGOnEP1eoPaOH49/0WibE9moOMJK1vnEl6qX0x3m+
 r5MASR5rBHDgLILuXEfdT0Vl8joBhWCllV1L8lDND8vVox8wwcqja/lL8lIMoNrEd1M9
 ge7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685572456; x=1688164456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hD5SWLVogZIj3Sd56IpeZ4SmSKFNXjKZY8kepnkg57M=;
 b=QkoHrv8F28FNhCpJ2SkORiD/zBmUpt6+x9deL0vPOtnnD9oeMjs2ziEgAG7Durw8ks
 hHOv4BRzI6smHJ/pBfIEg+tXlZB4mIV0FABF0DWMQhQv2WJNy3cIPrDRfM7NyI+s+YSg
 3pQBwQRmt3BB/wyuX94JaUo0DBYh/VigWyY1u8EjkzXinHzRBcj/agjzRgYspa2k8rhL
 fsSM3xeQ7m27Mnr48uaFLj2SKKhAJrtrIgbbTct8d8ZwkwUyTYJjAVMXz3Zgsx6Uvjc7
 +IpV93yhEBRM5JJt9V8nacJx6qtlbTK/FCRaIZ1RjAvIYcgkWe8EI+bRFZhBI/dtP8aW
 QboA==
X-Gm-Message-State: AC+VfDxeYVIX50hK1FWUxK8AbhVAwxwgy3jTI0fB7d/TZ8BiPWQBK5n2
 eBaMLQ5frZmdtAdArhwRM5Sne5gU87fxEsnau14=
X-Google-Smtp-Source: ACHHUZ5fVMWAe3pV2PYSWI4VrYZv5nyGy2YWrSFPfog35FqBDCttXTCIkeGwjLV+sUUAy0W1BTjZyw==
X-Received: by 2002:ac2:4149:0:b0:4f4:af57:19af with SMTP id
 c9-20020ac24149000000b004f4af5719afmr227239lfi.2.1685572455961; 
 Wed, 31 May 2023 15:34:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a7bc448000000b003f42158288dsm106427wmi.20.2023.05.31.15.34.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 31 May 2023 15:34:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] hw: Simplify using sysbus_init_irqs() [automatic]
Date: Thu,  1 Jun 2023 00:33:40 +0200
Message-Id: <20230531223341.34827-7-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531223341.34827-1-philmd@linaro.org>
References: <20230531223341.34827-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
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

Change created mechanically using the following coccinelle
semantic patch:

    @@
    expression array;
    identifier i;
    expression sbd, count;
    @@

    -    for (i = 0; i < count; i++) {
    -        sysbus_init_irq(sbd, &array[i]);
    -    }
    +    sysbus_init_irqs(sbd, array, count);

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/smmuv3.c               |  6 +-----
 hw/arm/stellaris.c            |  5 +----
 hw/arm/strongarm.c            |  5 +----
 hw/arm/versatilepb.c          |  5 +----
 hw/char/pl011.c               |  5 +----
 hw/char/renesas_sci.c         |  5 +----
 hw/core/platform-bus.c        |  5 +----
 hw/dma/pl330.c                |  4 +---
 hw/dma/sifive_pdma.c          |  5 +----
 hw/gpio/sifive_gpio.c         |  5 +----
 hw/i386/kvm/xen_evtchn.c      |  5 +----
 hw/intc/arm_gic_common.c      | 20 +++++---------------
 hw/intc/arm_gicv2m.c          |  5 +----
 hw/intc/exynos4210_combiner.c |  5 +----
 hw/intc/loongarch_extioi.c    |  6 ++----
 hw/intc/loongson_liointc.c    |  5 +----
 hw/intc/openpic.c             |  6 ++----
 hw/intc/slavio_intctl.c       |  6 ++----
 hw/misc/avr_power.c           |  4 +---
 hw/misc/macio/gpio.c          |  5 +----
 hw/misc/stm32f4xx_exti.c      |  5 +----
 hw/net/cadence_gem.c          |  5 +----
 hw/net/mcf_fec.c              |  5 +----
 hw/pci-host/designware.c      |  5 +----
 hw/pci-host/ppce500.c         |  4 +---
 hw/pci-host/raven.c           |  4 +---
 hw/pci-host/sh_pci.c          |  5 +----
 hw/pci-host/versatile.c       |  4 +---
 hw/ppc/ppc405_uc.c            | 10 ++--------
 hw/ppc/ppc440_uc.c            |  6 ++----
 hw/ppc/ppc4xx_devs.c          |  4 +---
 hw/ppc/ppc4xx_pci.c           |  5 +----
 hw/ssi/ibex_spi_host.c        |  5 +----
 hw/ssi/imx_spi.c              |  5 +----
 hw/ssi/sifive_spi.c           |  5 +----
 hw/ssi/xilinx_spi.c           |  5 +----
 hw/ssi/xilinx_spips.c         |  4 +---
 hw/ssi/xlnx-versal-ospi.c     |  4 +---
 hw/timer/allwinner-a10-pit.c  |  4 +---
 hw/timer/exynos4210_mct.c     |  4 +---
 hw/timer/hpet.c               |  4 +---
 hw/timer/renesas_cmt.c        |  5 +----
 hw/timer/sifive_pwm.c         |  5 +----
 43 files changed, 52 insertions(+), 177 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 932f009697..f080d97d3f 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1692,11 +1692,7 @@ static const MemoryRegionOps smmu_mem_ops = {
 
 static void smmu_init_irq(SMMUv3State *s, SysBusDevice *dev)
 {
-    int i;
-
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
-    }
+    sysbus_init_irqs(dev, s->irq, ARRAY_SIZE(s->irq));
 }
 
 static void smmu_reset_hold(Object *obj)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f7e99baf62..4bf9ef05c8 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -934,11 +934,8 @@ static void stellaris_adc_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     StellarisADCState *s = STELLARIS_ADC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int n;
 
-    for (n = 0; n < 4; n++) {
-        sysbus_init_irq(sbd, &s->irq[n]);
-    }
+    sysbus_init_irqs(sbd, s->irq, 4);
 
     memory_region_init_io(&s->iomem, obj, &stellaris_adc_ops, s,
                           "adc", 0x1000);
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index cc73145053..f785dcf08e 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -658,7 +658,6 @@ static void strongarm_gpio_initfn(Object *obj)
     DeviceState *dev = DEVICE(obj);
     StrongARMGPIOInfo *s = STRONGARM_GPIO(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     qdev_init_gpio_in(dev, strongarm_gpio_set, 28);
     qdev_init_gpio_out(dev, s->handler, 28);
@@ -667,9 +666,7 @@ static void strongarm_gpio_initfn(Object *obj)
                           "gpio", 0x1000);
 
     sysbus_init_mmio(sbd, &s->iomem);
-    for (i = 0; i < 11; i++) {
-        sysbus_init_irq(sbd, &s->irqs[i]);
-    }
+    sysbus_init_irqs(sbd, s->irqs, 11);
     sysbus_init_irq(sbd, &s->irqX);
 }
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 05b9462a5b..6a5b1fc53e 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -160,12 +160,9 @@ static void vpb_sic_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     vpb_sic_state *s = VERSATILE_PB_SIC(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    int i;
 
     qdev_init_gpio_in(dev, vpb_sic_set_irq, 32);
-    for (i = 0; i < 32; i++) {
-        sysbus_init_irq(sbd, &s->parent[i]);
-    }
+    sysbus_init_irqs(sbd, s->parent, 32);
     s->irq = 31;
     memory_region_init_io(&s->iomem, obj, &vpb_sic_ops, s,
                           "vpb-sic", 0x1000);
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 77bbc2a982..2056e32385 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -442,13 +442,10 @@ static void pl011_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PL011State *s = PL011(obj);
-    int i;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, ARRAY_SIZE(s->irq));
 
     s->clk = qdev_init_clock_in(DEVICE(obj), "clk", pl011_clock_update, s,
                                 ClockUpdate);
diff --git a/hw/char/renesas_sci.c b/hw/char/renesas_sci.c
index 1c63467290..d404976279 100644
--- a/hw/char/renesas_sci.c
+++ b/hw/char/renesas_sci.c
@@ -286,15 +286,12 @@ static void rsci_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
     RSCIState *sci = RSCI(obj);
-    int i;
 
     memory_region_init_io(&sci->memory, OBJECT(sci), &sci_ops,
                           sci, "renesas-sci", 0x8);
     sysbus_init_mmio(d, &sci->memory);
 
-    for (i = 0; i < SCI_NR_IRQ; i++) {
-        sysbus_init_irq(d, &sci->irq[i]);
-    }
+    sysbus_init_irqs(d, sci->irq, SCI_NR_IRQ);
     timer_init_ns(&sci->timer, QEMU_CLOCK_VIRTUAL, txend, sci);
 }
 
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index b8487b26b6..5e75324434 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -182,7 +182,6 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
 {
     PlatformBusDevice *pbus;
     SysBusDevice *d;
-    int i;
 
     d = SYS_BUS_DEVICE(dev);
     pbus = PLATFORM_BUS_DEVICE(dev);
@@ -193,9 +192,7 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
 
     pbus->used_irqs = bitmap_new(pbus->num_irqs);
     pbus->irqs = g_new0(qemu_irq, pbus->num_irqs);
-    for (i = 0; i < pbus->num_irqs; i++) {
-        sysbus_init_irq(d, &pbus->irqs[i]);
-    }
+    sysbus_init_irqs(d, pbus->irqs, pbus->num_irqs);
 
     /* some devices might be initialized before so update used IRQs map */
     plaform_bus_refresh_irqs(pbus);
diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
index e7e67dd8b6..d1c24fa7b8 100644
--- a/hw/dma/pl330.c
+++ b/hw/dma/pl330.c
@@ -1620,9 +1620,7 @@ static void pl330_realize(DeviceState *dev, Error **errp)
     s->manager.is_manager = true;
 
     s->irq = g_new0(qemu_irq, s->num_events);
-    for (i = 0; i < s->num_events; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, s->num_events);
 
     qdev_init_gpio_in(dev, pl330_dma_stop_irq, PL330_PERIPH_NUM);
 
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 1dd88f3479..61c138323b 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -454,15 +454,12 @@ static const MemoryRegionOps sifive_pdma_ops = {
 static void sifive_pdma_realize(DeviceState *dev, Error **errp)
 {
     SiFivePDMAState *s = SIFIVE_PDMA(dev);
-    int i;
 
     memory_region_init_io(&s->iomem, OBJECT(dev), &sifive_pdma_ops, s,
                           TYPE_SIFIVE_PDMA, SIFIVE_PDMA_REG_SIZE);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
 
-    for (i = 0; i < SIFIVE_PDMA_IRQS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, SIFIVE_PDMA_IRQS);
 }
 
 static void sifive_pdma_class_init(ObjectClass *klass, void *data)
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 78bf29e996..fcb863a3ef 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -362,10 +362,7 @@ static void sifive_gpio_realize(DeviceState *dev, Error **errp)
             TYPE_SIFIVE_GPIO, SIFIVE_GPIO_SIZE);
 
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->mmio);
-
-    for (int i = 0; i < s->ngpio; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, s->ngpio);
 
     qdev_init_gpio_in(DEVICE(s), sifive_gpio_set, s->ngpio);
     qdev_init_gpio_out(DEVICE(s), s->output, s->ngpio);
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index 3048329474..12c4419907 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -303,16 +303,13 @@ void xen_evtchn_create(void)
 {
     XenEvtchnState *s = XEN_EVTCHN(sysbus_create_simple(TYPE_XEN_EVTCHN,
                                                         -1, NULL));
-    int i;
 
     xen_evtchn_singleton = s;
 
     qemu_mutex_init(&s->port_lock);
     s->gsi_bh = aio_bh_new(qemu_get_aio_context(), gsi_assert_bh, s);
 
-    for (i = 0; i < IOAPIC_NUM_PINS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(s), &s->gsis[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(s), s->gsis, IOAPIC_NUM_PINS);
 
     /*
      * The Xen scheme for encoding PIRQ# into an MSI message is not
diff --git a/hw/intc/arm_gic_common.c b/hw/intc/arm_gic_common.c
index a379cea395..1742c752eb 100644
--- a/hw/intc/arm_gic_common.c
+++ b/hw/intc/arm_gic_common.c
@@ -143,22 +143,12 @@ void gic_init_irqs_and_mmio(GICState *s, qemu_irq_handler handler,
     i += (GIC_INTERNAL * s->num_cpu);
     qdev_init_gpio_in(DEVICE(s), handler, i);
 
-    for (i = 0; i < s->num_cpu; i++) {
-        sysbus_init_irq(sbd, &s->parent_irq[i]);
-    }
-    for (i = 0; i < s->num_cpu; i++) {
-        sysbus_init_irq(sbd, &s->parent_fiq[i]);
-    }
-    for (i = 0; i < s->num_cpu; i++) {
-        sysbus_init_irq(sbd, &s->parent_virq[i]);
-    }
-    for (i = 0; i < s->num_cpu; i++) {
-        sysbus_init_irq(sbd, &s->parent_vfiq[i]);
-    }
+    sysbus_init_irqs(sbd, s->parent_irq, s->num_cpu);
+    sysbus_init_irqs(sbd, s->parent_fiq, s->num_cpu);
+    sysbus_init_irqs(sbd, s->parent_virq, s->num_cpu);
+    sysbus_init_irqs(sbd, s->parent_vfiq, s->num_cpu);
     if (s->virt_extn) {
-        for (i = 0; i < s->num_cpu; i++) {
-            sysbus_init_irq(sbd, &s->maintenance_irq[i]);
-        }
+        sysbus_init_irqs(sbd, s->maintenance_irq, s->num_cpu);
     }
 
     /* Distributor */
diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index d564b857eb..8167d5886c 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -135,7 +135,6 @@ static const MemoryRegionOps gicv2m_ops = {
 static void gicv2m_realize(DeviceState *dev, Error **errp)
 {
     ARMGICv2mState *s = ARM_GICV2M(dev);
-    int i;
 
     if (s->num_spi > GICV2M_NUM_SPI_MAX) {
         error_setg(errp,
@@ -151,9 +150,7 @@ static void gicv2m_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < s->num_spi; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->spi[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->spi, s->num_spi);
 
     msi_nonbroken = true;
     kvm_gsi_direct_mapping = true;
diff --git a/hw/intc/exynos4210_combiner.c b/hw/intc/exynos4210_combiner.c
index 4ba448fdb1..eb793e5623 100644
--- a/hw/intc/exynos4210_combiner.c
+++ b/hw/intc/exynos4210_combiner.c
@@ -309,16 +309,13 @@ static void exynos4210_combiner_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     Exynos4210CombinerState *s = EXYNOS4210_COMBINER(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    unsigned int i;
 
     /* Allocate general purpose input signals and connect a handler to each of
      * them */
     qdev_init_gpio_in(dev, exynos4210_combiner_handler, IIC_NIRQ);
 
     /* Connect SysBusDev irqs to device specific irqs */
-    for (i = 0; i < IIC_NGRP; i++) {
-        sysbus_init_irq(sbd, &s->output_irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->output_irq, IIC_NGRP);
 
     memory_region_init_io(&s->iomem, obj, &exynos4210_combiner_ops, s,
                           "exynos4210-combiner", IIC_REGION_SIZE);
diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 0e7a3e32f3..db941de20e 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -273,11 +273,9 @@ static void loongarch_extioi_instance_init(Object *obj)
 {
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
-    int i, cpu, pin;
+    int cpu, pin;
 
-    for (i = 0; i < EXTIOI_IRQS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, EXTIOI_IRQS);
 
     qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);
 
diff --git a/hw/intc/loongson_liointc.c b/hw/intc/loongson_liointc.c
index cc11b544cb..37b5f473d4 100644
--- a/hw/intc/loongson_liointc.c
+++ b/hw/intc/loongson_liointc.c
@@ -221,13 +221,10 @@ static void irq_handler(void *opaque, int irq, int level)
 static void loongson_liointc_init(Object *obj)
 {
     struct loongson_liointc *p = LOONGSON_LIOINTC(obj);
-    int i;
 
     qdev_init_gpio_in(DEVICE(obj), irq_handler, 32);
 
-    for (i = 0; i < NUM_PARENTS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &p->parent_irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(obj), p->parent_irq, NUM_PARENTS);
 
     memory_region_init_io(&p->mmio, obj, &pic_ops, p,
                          TYPE_LOONGSON_LIOINTC, R_END);
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index c757adbe53..da9b833c33 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1505,7 +1505,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(dev);
     OpenPICState *opp = OPENPIC(dev);
-    int i, j;
+    int i;
     int list_count = 0;
     static const MemReg list_le[] = {
         {"glb", &openpic_glb_ops_le,
@@ -1597,9 +1597,7 @@ static void openpic_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < opp->nb_cpus; i++) {
         opp->dst[i].irqs = g_new0(qemu_irq, OPENPIC_OUTPUT_NB);
-        for (j = 0; j < OPENPIC_OUTPUT_NB; j++) {
-            sysbus_init_irq(d, &opp->dst[i].irqs[j]);
-        }
+        sysbus_init_irqs(d, opp->dst[i].irqs, OPENPIC_OUTPUT_NB);
 
         opp->dst[i].raised.queue_size = IRQQUEUE_SIZE_BITS;
         opp->dst[i].raised.queue = bitmap_new(IRQQUEUE_SIZE_BITS);
diff --git a/hw/intc/slavio_intctl.c b/hw/intc/slavio_intctl.c
index f7e59ba643..e2a3bd3e86 100644
--- a/hw/intc/slavio_intctl.c
+++ b/hw/intc/slavio_intctl.c
@@ -419,7 +419,7 @@ static void slavio_intctl_init(Object *obj)
     DeviceState *dev = DEVICE(obj);
     SLAVIO_INTCTLState *s = SLAVIO_INTCTL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    unsigned int i, j;
+    unsigned int i;
     char slave_name[45];
 
     qdev_init_gpio_in(dev, slavio_set_irq_all, 32 + MAX_CPUS);
@@ -430,9 +430,7 @@ static void slavio_intctl_init(Object *obj)
     for (i = 0; i < MAX_CPUS; i++) {
         snprintf(slave_name, sizeof(slave_name),
                  "slave-interrupt-controller-%i", i);
-        for (j = 0; j < MAX_PILS; j++) {
-            sysbus_init_irq(sbd, &s->cpu_irqs[i][j]);
-        }
+        sysbus_init_irqs(sbd, s->cpu_irqs[i], MAX_PILS);
         memory_region_init_io(&s->slaves[i].iomem, OBJECT(s),
                               &slavio_intctl_mem_ops,
                               &s->slaves[i], slave_name, INTCTL_SIZE);
diff --git a/hw/misc/avr_power.c b/hw/misc/avr_power.c
index a5412f2cfe..5c6806ecbc 100644
--- a/hw/misc/avr_power.c
+++ b/hw/misc/avr_power.c
@@ -83,10 +83,8 @@ static void avr_mask_init(Object *dev)
     memory_region_init_io(&s->iomem, dev, &avr_mask_ops, s, TYPE_AVR_MASK,
                           0x01);
     sysbus_init_mmio(busdev, &s->iomem);
+    sysbus_init_irqs(busdev, s->irq, 8);
 
-    for (int i = 0; i < 8; i++) {
-        sysbus_init_irq(busdev, &s->irq[i]);
-    }
     s->val = 0x00;
 }
 
diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 4deb330471..bfbcf4ed87 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -153,11 +153,8 @@ static void macio_gpio_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     MacIOGPIOState *s = MACIO_GPIO(obj);
-    int i;
 
-    for (i = 0; i < 10; i++) {
-        sysbus_init_irq(sbd, &s->gpio_extirqs[i]);
-    }
+    sysbus_init_irqs(sbd, s->gpio_extirqs, 10);
 
     memory_region_init_io(&s->gpiomem, OBJECT(s), &macio_gpio_ops, obj,
                           "gpio", 0x30);
diff --git a/hw/misc/stm32f4xx_exti.c b/hw/misc/stm32f4xx_exti.c
index 02e7810046..3bfefbf49b 100644
--- a/hw/misc/stm32f4xx_exti.c
+++ b/hw/misc/stm32f4xx_exti.c
@@ -135,11 +135,8 @@ static const MemoryRegionOps stm32f4xx_exti_ops = {
 static void stm32f4xx_exti_init(Object *obj)
 {
     STM32F4xxExtiState *s = STM32F4XX_EXTI(obj);
-    int i;
 
-    for (i = 0; i < NUM_INTERRUPT_OUT_LINES; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(obj), s->irq, NUM_INTERRUPT_OUT_LINES);
 
     memory_region_init_io(&s->mmio, obj, &stm32f4xx_exti_ops, s,
                           TYPE_STM32F4XX_EXTI, 0x400);
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 42ea2411a2..2a2293e0cc 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1606,7 +1606,6 @@ static NetClientInfo net_gem_info = {
 static void gem_realize(DeviceState *dev, Error **errp)
 {
     CadenceGEMState *s = CADENCE_GEM(dev);
-    int i;
 
     address_space_init(&s->dma_as,
                        s->dma_mr ? s->dma_mr : get_system_memory(), "dma");
@@ -1626,9 +1625,7 @@ static void gem_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    for (i = 0; i < s->num_priority_queues; ++i) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, s->num_priority_queues);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8aa27bd322..34d5ecce5e 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -651,13 +651,10 @@ static void mcf_fec_instance_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     mcf_fec_state *s = MCF_FEC_NET(obj);
-    int i;
 
     memory_region_init_io(&s->iomem, obj, &mcf_fec_ops, s, "fec", 0x400);
     sysbus_init_mmio(sbd, &s->iomem);
-    for (i = 0; i < FEC_NUM_IRQ; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, FEC_NUM_IRQ);
 }
 
 static Property mcf_fec_properties[] = {
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 9e183caa48..b75fd3d5f5 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -668,11 +668,8 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
     DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    size_t i;
 
-    for (i = 0; i < ARRAY_SIZE(s->pci.irqs); i++) {
-        sysbus_init_irq(sbd, &s->pci.irqs[i]);
-    }
+    sysbus_init_irqs(sbd, s->pci.irqs, ARRAY_SIZE(s->pci.irqs));
 
     memory_region_init_io(&s->mmio,
                           OBJECT(s),
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 38814247f2..98ee49e4ee 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -446,9 +446,7 @@ static void e500_pcihost_realize(DeviceState *dev, Error **errp)
     h = PCI_HOST_BRIDGE(dev);
     s = PPC_E500_PCI_HOST_BRIDGE(dev);
 
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, ARRAY_SIZE(s->irq));
 
     for (i = 0; i < PCI_NUM_PINS; i++) {
         s->irq_num[i] = s->first_pin_irq + i;
diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 9a11ac4b2b..dd22964c27 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -239,9 +239,7 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
     int i;
 
     if (s->is_legacy_prep) {
-        for (i = 0; i < PCI_NUM_PINS; i++) {
-            sysbus_init_irq(dev, &s->pci_irqs[i]);
-        }
+        sysbus_init_irqs(dev, s->pci_irqs, PCI_NUM_PINS);
     } else {
         /* According to PReP specification section 6.1.6 "System Interrupt
          * Assignments", all PCI interrupts are routed via IRQ 15 */
diff --git a/hw/pci-host/sh_pci.c b/hw/pci-host/sh_pci.c
index 77e7bbc65f..6aade6e5d7 100644
--- a/hw/pci-host/sh_pci.c
+++ b/hw/pci-host/sh_pci.c
@@ -121,11 +121,8 @@ static void sh_pci_device_realize(DeviceState *dev, Error **errp)
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SHPCIState *s = SH_PCI_HOST_BRIDGE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
-    int i;
 
-    for (i = 0; i < 4; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, 4);
     phb->bus = pci_register_root_bus(dev, "pci",
                                      sh_pci_set_irq, sh_pci_map_irq,
                                      s->irq,
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index 60d4e7cd92..3eb9ad6f5c 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -412,9 +412,7 @@ static void pci_vpb_realize(DeviceState *dev, Error **errp)
 
     object_initialize(&s->pci_dev, sizeof(s->pci_dev), TYPE_VERSATILE_PCI_HOST);
 
-    for (i = 0; i < 4; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, 4);
 
     if (s->realview) {
         mapfn = pci_vpb_rv_map_irq;
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 0cc68178ad..5faa40a9d4 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -265,11 +265,8 @@ static void ppc405_dma_realize(DeviceState *dev, Error **errp)
 {
     Ppc405DmaState *dma = PPC405_DMA(dev);
     Ppc4xxDcrDeviceState *dcr = PPC4xx_DCR_DEVICE(dev);
-    int i;
 
-    for (i = 0; i < ARRAY_SIZE(dma->irqs); i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dma), &dma->irqs[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dma), dma->irqs, ARRAY_SIZE(dma->irqs));
 
     ppc4xx_dcr_register(dcr, DMA0_CR0, dma, &dcr_read_dma, &dcr_write_dma);
     ppc4xx_dcr_register(dcr, DMA0_CT0, dma, &dcr_read_dma, &dcr_write_dma);
@@ -702,15 +699,12 @@ static void ppc405_gpt_realize(DeviceState *dev, Error **errp)
 {
     Ppc405GptState *s = PPC405_GPT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    int i;
 
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, &ppc4xx_gpt_cb, s);
     memory_region_init_io(&s->iomem, OBJECT(s), &gpt_ops, s, "gpt", 0xd4);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    for (i = 0; i < ARRAY_SIZE(s->irqs); i++) {
-        sysbus_init_irq(sbd, &s->irqs[i]);
-    }
+    sysbus_init_irqs(sbd, s->irqs, ARRAY_SIZE(s->irqs));
 }
 
 static void ppc405_gpt_finalize(Object *obj)
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 651263926e..89e16766e4 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -1004,7 +1004,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
 {
     PPC460EXPCIEState *s = PPC460EX_PCIE_HOST(dev);
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
-    int i, id;
+    int id;
     char buf[16];
 
     switch (s->dcrn_base) {
@@ -1020,9 +1020,7 @@ static void ppc460ex_pcie_realize(DeviceState *dev, Error **errp)
     }
     snprintf(buf, sizeof(buf), "pcie%d-io", id);
     memory_region_init(&s->iomem, OBJECT(s), buf, UINT64_MAX);
-    for (i = 0; i < 4; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, 4);
     snprintf(buf, sizeof(buf), "pcie.%d", id);
     pci->bus = pci_register_root_bus(DEVICE(s), buf, ppc460ex_set_irq,
                                 pci_swizzle_map_irq_fn, s, &s->iomem,
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index c1d111465d..f938ac80a4 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -193,9 +193,7 @@ static void ppc4xx_mal_realize(DeviceState *dev, Error **errp)
     mal->rxctpr = g_new0(uint32_t, mal->rxcnum);
     mal->rcbs = g_new0(uint32_t, mal->rxcnum);
 
-    for (i = 0; i < ARRAY_SIZE(mal->irqs); i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &mal->irqs[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), mal->irqs, ARRAY_SIZE(mal->irqs));
 
     ppc4xx_dcr_register(dcr, MAL0_CFG, mal, &dcr_read_mal, &dcr_write_mal);
     ppc4xx_dcr_register(dcr, MAL0_ESR, mal, &dcr_read_mal, &dcr_write_mal);
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 1d4a50fa7c..55957af77d 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -318,14 +318,11 @@ static void ppc4xx_pcihost_realize(DeviceState *dev, Error **errp)
     PPC4xxPCIState *s;
     PCIHostState *h;
     PCIBus *b;
-    int i;
 
     h = PCI_HOST_BRIDGE(dev);
     s = PPC4xx_PCI_HOST_BRIDGE(dev);
 
-    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, ARRAY_SIZE(s->irq));
 
     b = pci_register_root_bus(dev, NULL, ppc4xx_pci_set_irq,
                               ppc4xx_pci_map_irq, s->irq, get_system_memory(),
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 1ee7d88c22..512b09d13e 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -589,14 +589,11 @@ static void fifo_trigger_update(void *opaque)
 static void ibex_spi_host_realize(DeviceState *dev, Error **errp)
 {
     IbexSPIHostState *s = IBEX_SPI_HOST(dev);
-    int i;
 
     s->ssi = ssi_create_bus(dev, "ssi");
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
 
-    for (i = 0; i < s->num_cs; ++i) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->cs_lines, s->num_cs);
 
     /* Setup CONFIGOPTS Multi-register */
     s->config_opts = g_new0(uint32_t, s->num_cs);
diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
index 189423bb3a..86c130c77b 100644
--- a/hw/ssi/imx_spi.c
+++ b/hw/ssi/imx_spi.c
@@ -458,7 +458,6 @@ static const struct MemoryRegionOps imx_spi_ops = {
 static void imx_spi_realize(DeviceState *dev, Error **errp)
 {
     IMXSPIState *s = IMX_SPI(dev);
-    int i;
 
     s->bus = ssi_create_bus(dev, "spi");
 
@@ -467,9 +466,7 @@ static void imx_spi_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 
-    for (i = 0; i < ECSPI_NUM_CS; ++i) {
-        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->cs_lines, ECSPI_NUM_CS);
 
     fifo32_create(&s->tx_fifo, ECSPI_FIFO_SIZE);
     fifo32_create(&s->rx_fifo, ECSPI_FIFO_SIZE);
diff --git a/hw/ssi/sifive_spi.c b/hw/ssi/sifive_spi.c
index 1b4a401ca1..928c7c5035 100644
--- a/hw/ssi/sifive_spi.c
+++ b/hw/ssi/sifive_spi.c
@@ -310,15 +310,12 @@ static void sifive_spi_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     SiFiveSPIState *s = SIFIVE_SPI(dev);
-    int i;
 
     s->spi = ssi_create_bus(dev, "spi");
     sysbus_init_irq(sbd, &s->irq);
 
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
-    for (i = 0; i < s->num_cs; i++) {
-        sysbus_init_irq(sbd, &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(sbd, s->cs_lines, s->num_cs);
 
     memory_region_init_io(&s->mmio, OBJECT(s), &sifive_spi_ops, s,
                           TYPE_SIFIVE_SPI, 0x1000);
diff --git a/hw/ssi/xilinx_spi.c b/hw/ssi/xilinx_spi.c
index d4de2e7aab..e0ea0bb1cf 100644
--- a/hw/ssi/xilinx_spi.c
+++ b/hw/ssi/xilinx_spi.c
@@ -327,7 +327,6 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     XilinxSPI *s = XILINX_SPI(dev);
-    int i;
 
     DB_PRINT("\n");
 
@@ -335,9 +334,7 @@ static void xilinx_spi_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
-    for (i = 0; i < s->num_cs; ++i) {
-        sysbus_init_irq(sbd, &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(sbd, s->cs_lines, s->num_cs);
 
     memory_region_init_io(&s->mmio, OBJECT(s), &spi_ops, s,
                           "xilinx-spi", R_MAX * 4);
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index 97009d3a5d..c696a07916 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -1294,9 +1294,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
     s->cs_lines_state = g_new0(bool, s->num_cs * s->num_busses);
 
     sysbus_init_irq(sbd, &s->irq);
-    for (i = 0; i < s->num_cs * s->num_busses; ++i) {
-        sysbus_init_irq(sbd, &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(sbd, s->cs_lines, s->num_cs * s->num_busses);
 
     memory_region_init_io(&s->iomem, OBJECT(s), xsc->reg_ops, s,
                           "spi", XLNX_ZYNQMP_SPIPS_R_MAX * 4);
diff --git a/hw/ssi/xlnx-versal-ospi.c b/hw/ssi/xlnx-versal-ospi.c
index c762e0b367..b280fbedaf 100644
--- a/hw/ssi/xlnx-versal-ospi.c
+++ b/hw/ssi/xlnx-versal-ospi.c
@@ -1740,9 +1740,7 @@ static void xlnx_versal_ospi_realize(DeviceState *dev, Error **errp)
     s->num_cs = 4;
     s->spi = ssi_create_bus(dev, "spi0");
     s->cs_lines = g_new0(qemu_irq, s->num_cs);
-    for (int i = 0; i < s->num_cs; ++i) {
-        sysbus_init_irq(sbd, &s->cs_lines[i]);
-    }
+    sysbus_init_irqs(sbd, s->cs_lines, s->num_cs);
 
     fifo8_create(&s->rx_fifo, RXFF_SZ);
     fifo8_create(&s->tx_fifo, TXFF_SZ);
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 971f78462a..1126d19127 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -263,9 +263,7 @@ static void a10_pit_init(Object *obj)
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     uint8_t i;
 
-    for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-    }
+    sysbus_init_irqs(sbd, s->irq, AW_A10_PIT_TIMER_NR);
     memory_region_init_io(&s->iomem, OBJECT(s), &a10_pit_ops, s,
                           TYPE_AW_A10_PIT, 0x400);
     sysbus_init_mmio(sbd, &s->iomem);
diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 446bbd2b96..6a53068a1d 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -1521,9 +1521,7 @@ static void exynos4210_mct_init(Object *obj)
     }
 
     /* IRQs */
-    for (i = 0; i < MCT_GT_CMP_NUM; i++) {
-        sysbus_init_irq(dev, &s->g_timer.irq[i]);
-    }
+    sysbus_init_irqs(dev, s->g_timer.irq, MCT_GT_CMP_NUM);
     for (i = 0; i < 2; i++) {
         sysbus_init_irq(dev, &s->l_timer[i].irq);
     }
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 6998094233..95b68f1c90 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -756,9 +756,7 @@ static void hpet_realize(DeviceState *dev, Error **errp)
 
     s->hpet_id = hpet_cfg.count++;
 
-    for (i = 0; i < HPET_NUM_IRQ_ROUTES; i++) {
-        sysbus_init_irq(sbd, &s->irqs[i]);
-    }
+    sysbus_init_irqs(sbd, s->irqs, HPET_NUM_IRQ_ROUTES);
 
     if (s->num_timers < HPET_MIN_TIMERS) {
         s->num_timers = HPET_MIN_TIMERS;
diff --git a/hw/timer/renesas_cmt.c b/hw/timer/renesas_cmt.c
index 69eabc678a..3fae6d40d7 100644
--- a/hw/timer/renesas_cmt.c
+++ b/hw/timer/renesas_cmt.c
@@ -225,15 +225,12 @@ static void rcmt_init(Object *obj)
 {
     SysBusDevice *d = SYS_BUS_DEVICE(obj);
     RCMTState *cmt = RCMT(obj);
-    int i;
 
     memory_region_init_io(&cmt->memory, OBJECT(cmt), &cmt_ops,
                           cmt, "renesas-cmt", 0x10);
     sysbus_init_mmio(d, &cmt->memory);
 
-    for (i = 0; i < ARRAY_SIZE(cmt->cmi); i++) {
-        sysbus_init_irq(d, &cmt->cmi[i]);
-    }
+    sysbus_init_irqs(d, cmt->cmi, ARRAY_SIZE(cmt->cmi));
     timer_init_ns(&cmt->timer[0], QEMU_CLOCK_VIRTUAL, timer_event0, cmt);
     timer_init_ns(&cmt->timer[1], QEMU_CLOCK_VIRTUAL, timer_event1, cmt);
 }
diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
index c664480ccf..d5f1273232 100644
--- a/hw/timer/sifive_pwm.c
+++ b/hw/timer/sifive_pwm.c
@@ -414,11 +414,8 @@ static Property sifive_pwm_properties[] = {
 static void sifive_pwm_init(Object *obj)
 {
     SiFivePwmState *s = SIFIVE_PWM(obj);
-    int i;
 
-    for (i = 0; i < SIFIVE_PWM_IRQS; i++) {
-        sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irqs[i]);
-    }
+    sysbus_init_irqs(SYS_BUS_DEVICE(obj), s->irqs, SIFIVE_PWM_IRQS);
 
     memory_region_init_io(&s->mmio, obj, &sifive_pwm_ops, s,
                           TYPE_SIFIVE_PWM, 0x100);
-- 
2.38.1


