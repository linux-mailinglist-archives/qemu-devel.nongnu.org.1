Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B71763952
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:36:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWv-00038I-DI; Wed, 26 Jul 2023 09:26:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWN-0002kt-03; Wed, 26 Jul 2023 09:25:47 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWK-0003FW-34; Wed, 26 Jul 2023 09:25:41 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so301384e87.0; 
 Wed, 26 Jul 2023 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377938; x=1690982738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DcjTBpgUXCMa94BSfuoxaT1DYJcIHKCAbWEP0TuNZfk=;
 b=lmPoPOewpXJ2TWukGeNdW61fBrjAQ0/P6J6NjzJdqjM5LGBmqFeU0jlD5lC1B6CO/X
 KqU0XhwA2LGDj8GaCsy1pwzPe2jubHdbTEHhEkoRxdD/N2HUAkj1F5XIAG+7ODuEiplI
 f5wMkGqY2jeE32L5MSjG3TYJHtiqVsZsLdgM+LPWdxs6lmkz09BWSHsZ7HfRmGV68qTA
 0rjnnWE/T79vCApyO9eltdNTeZmpcvi/XzWjVCU35huxakCo7r2CZ6cgJ3kIyT/yjTrS
 xtHTqkvU6b+8v7GeZr8SnI4Yz0rCb4HheDqLG59i0BCuxSB6s8lsAXxjx+YcC2xQEWlC
 dKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377938; x=1690982738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DcjTBpgUXCMa94BSfuoxaT1DYJcIHKCAbWEP0TuNZfk=;
 b=RU+Hqv+GVsVEJMiboITW5MfReRxpGJ6hUgRQOGh0lLu8NmVD002D5b2HcKKYgxB6gt
 /sDQYtdZAmzMHo9nHx/lhZfg2OrJhrAE+Yj+Y9xnBSt0kWD2v20tGSWjzSz8YFm2kSsn
 RACtAkvbq4MbDUEkk6uUC5jxtPkmNLlvNagRNGxVwqALBA8/slmtglUTNNxIXUYFolGO
 8krynCM1UlRwka1BFn6GXOsTEebmb89luBdX5cQE2vQP/A5WvAlcrDROllgaKCJLh0ua
 591PpcvkuzowreBq95Ds5QuUPpb2i52QKSPaXe65oJJlrxu524nJlLJk51BaHi2TRfVH
 OC3w==
X-Gm-Message-State: ABy/qLarhWoEUs713r/PGWz5r0UlkPNd7o+08giJ0R5tMSixJvT3HmLQ
 vdvtHIRQkv6J4Vs6cf5Iwu2E9xH5/Lg=
X-Google-Smtp-Source: APBJJlHyTCkbmyRcgeVBmsdnXo681huzm+T4Q02aeKgoNX10O0GbzZTQCDG9S6Hc7VSqZSmGcvvEXw==
X-Received: by 2002:a05:6512:3241:b0:4fd:f878:c3fe with SMTP id
 c1-20020a056512324100b004fdf878c3femr1367662lfr.43.1690377937673; 
 Wed, 26 Jul 2023 06:25:37 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:37 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 16/44] Enable BCM2838 PCIE
Date: Wed, 26 Jul 2023 16:24:44 +0300
Message-Id: <20230726132512.149618-17-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12e.google.com
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


