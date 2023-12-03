Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB858027ED
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:36:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u2Q-0002T0-Ha; Sun, 03 Dec 2023 16:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1q-0001Ry-0R; Sun, 03 Dec 2023 16:29:34 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1n-0005RV-3Y; Sun, 03 Dec 2023 16:29:29 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-da37522a363so1873644276.0; 
 Sun, 03 Dec 2023 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638965; x=1702243765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlzqq1rIcBw375iNxsrI6JHCl35tGrND0ZoDvB52ZmE=;
 b=f76ZZ2vLIxOURYLcDiJHCt1hZ6Qk92zx92F7PNNtwOI/dlx1J1w82b/WBzNfxzZk0S
 +Eg//IcKDwXMOsLyMCHyFYnKvYu7kbtm6F2h5fgFgH9ywgVPcQFvPbiOI6D7zHyshVPO
 YEtGw8tiBq8zMDRjGNuOIflPLbYiNMxxh315ultoo8difnZ9kIXUqhHDT8lRYYGJiL9u
 ciI0TKLOwC763MhpjdBdNo41WgL8QxWWClRHQutwBo6GykNrMKI8rBruKE8KFA0JYS+N
 I6lJD+NUIcItjztHtqyn2fumHHrTXKIRXr8dlVEgdt2qSkEebuoRw3g0HaTmONlq9WEO
 s+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638965; x=1702243765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlzqq1rIcBw375iNxsrI6JHCl35tGrND0ZoDvB52ZmE=;
 b=YdNGSdRID7L/dhkU0UX7CaJ7beaOg7WxsYcBK0zrjDgAFIDuZNhELEZjyZcXRzRllo
 nVB/Z2ICQtZsuDX/+m5ZTpFqoFTkelR/ag+xpMjgiuQziIFvpX0kfKzDmch4mFlgV1af
 wF1knA/ohIDDCBHmWPxnWhPNNWWu4+/1k/iGYldgnZUfZ2MxeOJhy0iq5hR6PLB122gh
 lFIYWuhTieAw2nLUFM489J9i89pg6x6b20cZI04GXyQzpLKid0NNuGKV4Ld+CH4i7PMm
 6S8Su6hFYlorinIc8gL5Xrd00JuWpSfmL50rvfXEUD+3wsEs1FggMNAn5EUQHyTXml2/
 Uj3w==
X-Gm-Message-State: AOJu0YwA477wHyEHS4iaG0SH46dRU97pz3Vki28Z/eYfluQ6COivCYxz
 GoT/f+ACTt7xJdHYEv0P6RbF2XuwcgOYRA==
X-Google-Smtp-Source: AGHT+IEjD3cEZiRFcNW7jJ3ve+CEEqFKMCASabG1xEKgjLzavjJRzhL+DqhlDmPhEZZKwf32WBWaew==
X-Received: by 2002:a25:77c2:0:b0:db7:dacf:2f14 with SMTP id
 s185-20020a2577c2000000b00db7dacf2f14mr1801428ybc.91.1701638965660; 
 Sun, 03 Dec 2023 13:29:25 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:25 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 16/45] Enable BCM2838 PCIE
Date: Sun,  3 Dec 2023 15:28:36 -0600
Message-Id: <20231203212905.1364036-17-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-16-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-2-sergey.kambalin@auriga.com>
 <20231203212905.1364036-3-sergey.kambalin@auriga.com>
 <20231203212905.1364036-4-sergey.kambalin@auriga.com>
 <20231203212905.1364036-5-sergey.kambalin@auriga.com>
 <20231203212905.1364036-6-sergey.kambalin@auriga.com>
 <20231203212905.1364036-7-sergey.kambalin@auriga.com>
 <20231203212905.1364036-8-sergey.kambalin@auriga.com>
 <20231203212905.1364036-9-sergey.kambalin@auriga.com>
 <20231203212905.1364036-10-sergey.kambalin@auriga.com>
 <20231203212905.1364036-11-sergey.kambalin@auriga.com>
 <20231203212905.1364036-12-sergey.kambalin@auriga.com>
 <20231203212905.1364036-13-sergey.kambalin@auriga.com>
 <20231203212905.1364036-14-sergey.kambalin@auriga.com>
 <20231203212905.1364036-15-sergey.kambalin@auriga.com>
 <20231203212905.1364036-16-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb35.google.com
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
 hw/arm/bcm2838_pcie.c                |  3 +++
 hw/arm/bcm2838_peripherals.c         | 26 ++++++++++++++++++++++++++
 hw/arm/meson.build                   |  7 ++++---
 hw/arm/raspi4b.c                     |  1 -
 include/hw/arm/bcm2838_peripherals.h |  3 +++
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
index 75146d6c2e..8e046d0ac7 100644
--- a/hw/arm/bcm2838_pcie.c
+++ b/hw/arm/bcm2838_pcie.c
@@ -239,6 +239,9 @@ static void bcm2838_pcie_root_reg_reset(PCIDevice *dev)
 }
 
 static void bcm2838_pcie_root_realize(PCIDevice *dev, Error **errp) {
+    BCM2838PcieRootClass *brpc = BCM2838_PCIE_ROOT_GET_CLASS(dev);
+
+    brpc->parent_realize(dev, errp);
     bcm2838_pcie_root_reg_reset(dev);
 }
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index d3b42cf25b..ee06214715 100644
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
 
@@ -61,6 +70,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     MemoryRegion *mphi_mr;
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
     BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+    MemoryRegion *regs_mr;
+    MemoryRegion *mmio_mr;
+
     int n;
 
     bcm_soc_peripherals_common_realize(dev, errp);
@@ -172,6 +184,20 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
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
index b26ed13c6f..69d199b73e 100644
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
@@ -72,8 +71,10 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 
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
index 10376b62dc..2e8474e1c5 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -67,7 +67,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented*/
     const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-pcie",
         "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index af085934c9..2af96df1c6 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -62,8 +63,10 @@ struct BCM2838PeripheralState {
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


