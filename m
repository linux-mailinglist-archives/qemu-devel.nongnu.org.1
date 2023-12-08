Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19F80995F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:40:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQfI-00042I-0W; Thu, 07 Dec 2023 21:32:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfF-00041f-T8; Thu, 07 Dec 2023 21:32:29 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfD-0002Rn-R1; Thu, 07 Dec 2023 21:32:29 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c9e9c2989dso19450471fa.0; 
 Thu, 07 Dec 2023 18:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002745; x=1702607545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eUhfHOrUd6d5xBzm5sqO9HHOnia+nQ7EbvYxlC8xMp8=;
 b=PVCzIDXJunBX89fMHYY/xjyI3WSYdfcKIfjsS8o5lbIETWzGB9m5zI6HJrj2qTvAlL
 dZl1+JVQI8hHt26/7piTrK8Oh5I8I+5fiSbzk7of3wDr3L8B1VcR940gEq+ZTXy7wu2d
 6ti0W93bqjMvxgeq5IFjBnTNIe4se77hNLhGV/Cm5HfoulhwXQ3IWu5h9qTYm2FoJcUG
 ejmGX9h9TKMuPzfOBy8ELBd8htlMxUHPnINK/4jzxydlNV+S3T8grAM6M0scsIDHUYH+
 SLWDnvWtexurCXhF5w6KuE7g8uoQ+i27Kbjzn6rBD8ArYIzhWW9l52ElthpfbQFCBLyy
 hCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002745; x=1702607545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUhfHOrUd6d5xBzm5sqO9HHOnia+nQ7EbvYxlC8xMp8=;
 b=NApU3EB+GEJjOUo09YYGEe6Q79O/EQpfoEpkBUS6hcLvnnpgg1WAbxs6MTlWIfC5od
 o1cg6jsf92NK8SkEir0iX9UwQmKmRXe71nxLQr/Vkoc5MbiRBCE2js21v0NJQC/f0DBt
 QNshZtNWSqZGF+4xAYAtG9Qrz6wC/qu002ZL+cgwGoWe9be2Ubg+EBskIbqPzuLwZTXD
 vcLZeCIkbhs/2a1O7+R4SOZHnCb9PuYvuZVOAEXoTmf68BmUJ9Es2EDj7Ig27P2wUngQ
 YNtSkoy5ZEZSPfWWRF9VwGkJH5L9LD2Vw67PbkAATNfuqN0CIjX34VON8eL7XnKYbpKJ
 2e6Q==
X-Gm-Message-State: AOJu0YwzANQQ1EuzRNlMaruYGQaCVyzhIwl1QlCb/60tEhCwo5jCk4ck
 DcMOTbhPo/1aUiHdFwqgk8VZRZIW0mHtGg==
X-Google-Smtp-Source: AGHT+IEenqXQ7G/IUEk6tq8ZIKGor5VzHRpEfeAUdzwS9Rn2/iij9QW/PXePpcZGTbB1LqH45DQL8w==
X-Received: by 2002:a05:651c:1614:b0:2ca:2556:ef69 with SMTP id
 f20-20020a05651c161400b002ca2556ef69mr2979045ljq.94.1702002745086; 
 Thu, 07 Dec 2023 18:32:25 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:32:24 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 09/45] Add GPIO and SD to BCM2838 periph
Date: Thu,  7 Dec 2023 20:31:09 -0600
Message-Id: <20231208023145.1385775-10-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x22f.google.com
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
 hw/arm/bcm2838_peripherals.c         | 140 +++++++++++++++++++++++++++
 include/hw/arm/bcm2838_peripherals.h |   9 ++
 2 files changed, 149 insertions(+)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 06110c724f..c147b6e453 100644
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
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
 
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
index d07831753a..0a87645e01 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,8 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/sd/sdhci.h"
+#include "hw/gpio/bcm2838_gpio.h"
 
 /* SPI */
 #define GIC_SPI_INTERRUPT_MBOX         33
@@ -45,6 +47,9 @@
 #define GPU_INTERRUPT_DMA14     28
 #define GPU_INTERRUPT_DMA15     31
 
+#define BCM2838_MPHI_OFFSET     0xb200
+#define BCM2838_MPHI_SIZE       0x200
+
 #define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
 OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
                     BCM2838_PERIPHERALS)
@@ -58,6 +63,10 @@ struct BCM2838PeripheralState {
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


