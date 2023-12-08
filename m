Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC680993E
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:33:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQf4-0003xS-Dr; Thu, 07 Dec 2023 21:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQf1-0003vz-L4; Thu, 07 Dec 2023 21:32:15 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQez-0002Ph-HB; Thu, 07 Dec 2023 21:32:15 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c9bd3ec4f6so18857051fa.2; 
 Thu, 07 Dec 2023 18:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002731; x=1702607531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfYRXu2++EiNfxFS//da1r77rkXtLqsXyrHlBY61ejo=;
 b=dwaDZoCWgpLuOWyGHY0qXMgWkYmrkC+Y71Sr5KOzJveXrL9eWgDC28+gHKeVkJyOmn
 kzV+mRXghmFi0tqcxBX2Ki+OtXYMw/5V0ofnzGcGtp8EF9hk+N0QuqDALfGn1bNozchU
 W03fAaFdxebmy9RWAdRGEKuZrhvm/HTEZpCVrafVtGw8Y0yIRlemmz2/zA766S1JqFdO
 R0MQrtmsNyLlqQbrugjNO1se9HT7flI6I3ylTobwxkD9CZOZ9T+8dQhnC9mjI+7A9Ji6
 qtIScTh59VCNjTiLJVGYNjxV6JdtIU+oZlU2jMkeX+esGHDe0OfERxKpDOhbjgvMOY3b
 +cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002731; x=1702607531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfYRXu2++EiNfxFS//da1r77rkXtLqsXyrHlBY61ejo=;
 b=oxAM8IbRoY4j/dF07t0D2HMaQTqro1f2mHYxEbOvTRfs8tw1fr93RO7YjAlQfCZ2SH
 Arr0tnZFJYb0Y1lclpAn5NTP5bEFG5gxdveU9ePe/v/vp/aJ2MihmG/HHxbGxrR9NiTv
 T0Eoksl562wONNfEEyhSUVLsh7hxvVMOX7BMPIa6EXNJebu5LkAi+xI62wZ9iTWjtOyv
 0tdqgxdIX17HPi7xtWiYIRHmpHVYDxw1mtGzKgey9+6r/9XVTbvzDjfIEtt+d9fLXoru
 KP9nvohaGpaQS6/3235o9Un5hCyp73FNc6EXabuqUWX1VrnPOThZ2iLYZA8rrizcPFwx
 hbKA==
X-Gm-Message-State: AOJu0YytMQmze284HuO8WEEjgLC1tgwOJ7xM/5RJcLVu9FqPmLMsREqh
 CQDq4+MM4SE2vXRQsi7gXV+XlkcgdvFzvg==
X-Google-Smtp-Source: AGHT+IFsW07cn8HxIumEUlSHXMbwUCTQZOszHP9GfSIfmdznkSHfC1S8oeTXuT+Kb9GRej4DEmAxFQ==
X-Received: by 2002:a2e:918d:0:b0:2ca:d4c:14c6 with SMTP id
 f13-20020a2e918d000000b002ca0d4c14c6mr1415851ljg.62.1702002731316; 
 Thu, 07 Dec 2023 18:32:11 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:32:10 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 05/45] Add GIC-400 to BCM2838 SoC
Date: Thu,  7 Dec 2023 20:31:05 -0600
Message-Id: <20231208023145.1385775-6-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x229.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     | 167 +++++++++++++++++++++++++++
 hw/arm/trace-events                  |   2 +
 include/hw/arm/bcm2838.h             |   2 +
 include/hw/arm/bcm2838_peripherals.h |  39 +++++++
 4 files changed, 210 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c61c59661b..042e543006 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -14,8 +14,36 @@
 #include "hw/arm/bcm2838.h"
 #include "trace.h"
 
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
@@ -28,11 +56,14 @@ static void bcm2838_init(Object *obj)
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
     BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
@@ -56,6 +87,13 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
         /* TODO: this should be converted to a property of ARM_CPU */
         s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;
 
+        /* set periphbase/CBAR value for CPU-local registers */
+        if (!object_property_set_int(OBJECT(&s_base->cpu[n].core), "reset-cbar",
+                                     bc_base->ctrl_base + BCM2838_GIC_BASE,
+                                     errp)) {
+            return;
+        }
+
         /* start powered off if not enabled */
         if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
                                       "start-powered-off",
@@ -68,6 +106,135 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_DIST_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_CPU_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 2,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VIFACE_THIS_OFS);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 3,
+                    bc_base->ctrl_base + BCM2838_GIC_BASE + GIC_VCPU_OFS);
+
+    for (n = 0; n < BCM283X_NCPUS; n++) {
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 4 + n,
+                        bc_base->ctrl_base + BCM2838_GIC_BASE
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
index bddc25ca9a..e53c7bedf9 100644
--- a/include/hw/arm/bcm2838.h
+++ b/include/hw/arm/bcm2838.h
@@ -10,6 +10,7 @@
 #define BCM2838_H
 
 #include "hw/arm/bcm2836.h"
+#include "hw/intc/arm_gic.h"
 #include "hw/arm/bcm2838_peripherals.h"
 
 #define BCM2838_PERI_LOW_BASE 0xfc000000
@@ -24,6 +25,7 @@ struct BCM2838State {
     BCM283XBaseState parent_obj;
     /*< public >*/
     BCM2838PeripheralState peripherals;
+    GICState gic;
 };
 
 #endif /* BCM2838_H */
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 7039b67cc9..5a72355183 100644
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


