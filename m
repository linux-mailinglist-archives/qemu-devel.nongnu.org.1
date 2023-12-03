Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301A4802838
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:56:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLV-0003FD-0N; Sun, 03 Dec 2023 16:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLK-0002yh-0s; Sun, 03 Dec 2023 16:49:39 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLI-0008Lo-76; Sun, 03 Dec 2023 16:49:37 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d7fa93afe9so1855956a34.2; 
 Sun, 03 Dec 2023 13:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640174; x=1702244974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hlzqq1rIcBw375iNxsrI6JHCl35tGrND0ZoDvB52ZmE=;
 b=UNzjCaVup8AsFaHDTdQypOwl1TWw399R+QUixm0RaOLgCHS0fhAjHYLDjUJ1Gfi7+Z
 1pMWhJc8kddphra6QXogpf5mMT3wsO1DxmOyd8Dklg3I9Ge8d9UvJ2ZGmJphfUFi8zHw
 USOomUHmYW931Gp8m9W1yNc8FjOSLzLolkWUq6C2iJv5GpAYV1Wymxgm6Nq4n6MEJlc3
 6qBj/EMCaUt2f511LZgvj23qr5hFVYIxoEc1d7I4irMpja/SMStM/vwHSsBsYZK97jjK
 7XvzX/DJxY9lM327mcJiHumyXJ8V0ZuSLysJDEhRwAZdvQTcrbUUXAxutfLPQ2PSfe/P
 l3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640174; x=1702244974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hlzqq1rIcBw375iNxsrI6JHCl35tGrND0ZoDvB52ZmE=;
 b=i0iu9z4TlHRj1Cl7zTEnegy1wwWP7I34MnVaMyoxUgvuZaRIgH3/fgMpeQkorzrmQa
 f7Pvuxy8V0H9Tr7USuj8+AFATPKf2iEY1CE7SGtbkIqogWud42MyCPAfKxXl9SL5dum/
 k9+J3TKvbKXSkeHqTXy/EwxOVnz17XA1jPEQVYCyxfXb1QbVCncEAoZYfOMfPH3E1FWp
 U3Srg2eOaKs5XUddC0QZGV4SIimqFO6X0F2mtk3HiA08r1VPMerE7k4EQaO0YEhgVzF3
 zq9m25tPf8WmwNOkEzgkmniXelntw8EfGLNtJF8dJyEKVMx19rVDP//7T7B1aKlKe26l
 dDKw==
X-Gm-Message-State: AOJu0YwDk5pOjNqgkBdbOjgPx2d0YLRALmAEKXxxWr++T5K3em0pnhK7
 KwilUrEcV3YNNGffrbSwMogI3hqfvHTBgQ==
X-Google-Smtp-Source: AGHT+IEGYo+GxPpy4vyWDWdZbkjMjkaDwmR4OU+M49qj5m37+g+zcqf8wQYZXSrf3nDvuSys47IujQ==
X-Received: by 2002:a05:6830:2017:b0:6d9:a17c:35d6 with SMTP id
 e23-20020a056830201700b006d9a17c35d6mr550245otp.2.1701640174492; 
 Sun, 03 Dec 2023 13:49:34 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:34 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 16/45] Enable BCM2838 PCIE
Date: Sun,  3 Dec 2023 15:48:41 -0600
Message-Id: <20231203214910.1364468-17-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-16-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-2-sergey.kambalin@auriga.com>
 <20231203214910.1364468-3-sergey.kambalin@auriga.com>
 <20231203214910.1364468-4-sergey.kambalin@auriga.com>
 <20231203214910.1364468-5-sergey.kambalin@auriga.com>
 <20231203214910.1364468-6-sergey.kambalin@auriga.com>
 <20231203214910.1364468-7-sergey.kambalin@auriga.com>
 <20231203214910.1364468-8-sergey.kambalin@auriga.com>
 <20231203214910.1364468-9-sergey.kambalin@auriga.com>
 <20231203214910.1364468-10-sergey.kambalin@auriga.com>
 <20231203214910.1364468-11-sergey.kambalin@auriga.com>
 <20231203214910.1364468-12-sergey.kambalin@auriga.com>
 <20231203214910.1364468-13-sergey.kambalin@auriga.com>
 <20231203214910.1364468-14-sergey.kambalin@auriga.com>
 <20231203214910.1364468-15-sergey.kambalin@auriga.com>
 <20231203214910.1364468-16-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=serg.oker@gmail.com; helo=mail-ot1-x330.google.com
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


