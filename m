Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F5866737
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Feb 2024 01:11:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOUu-0000eq-9S; Sun, 25 Feb 2024 19:05:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOT7-0006sS-3d; Sun, 25 Feb 2024 19:03:41 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOT5-0000Wr-GU; Sun, 25 Feb 2024 19:03:40 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-607eefeea90so24211107b3.1; 
 Sun, 25 Feb 2024 16:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905817; x=1709510617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ew6YCPyRzsR4OvP0dhPLsagtmi7jAL+CxSm+Z7Aj5ns=;
 b=DkBxMpn9zwRXJipzGEOW0o4UaCcB84veKMUWACS12Y9v4MtmLkGbmjBcEcP+qCE5c7
 EIyTi9ohvHHeufP6gyu1Zau896mwVATfdu43Pyw3ca5urYJu4S7IuILGqhy7BdtAovx6
 pQ1zSR1HCGVm1rpmPiHTLMma6YSBKcHtTawmsIyYwcDpBrucFlO1GUcw7E3UEjO4hf2H
 vs9e+OMPQAkMCdpvnRBG2rM75JDteOXIpDFZ1RCwT+MD7fEdSeX6xqjaeJ+Ro5XVwu91
 W4TEt0NatvTq6uICXslHgWD1wmlMPtmYxtb2GDwBM8rGi/63lD/ffO9yaedRaP+O1CpW
 uJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905817; x=1709510617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew6YCPyRzsR4OvP0dhPLsagtmi7jAL+CxSm+Z7Aj5ns=;
 b=grVm96SCtm3b7rzcG88m8GFnqpnPjGQ3LLuPw/gLYr2Lvn6fkPokQKGLI3oS9OlEX/
 h8gzWktZvE6Z3aBy38HxhIoinc5k8WcCEN0U/G8gOjMY6Ycr4FTE0Y6Id3UOCfJzjvi1
 jRfCsxJh8nC+5mSolWq2WKnSKiQgsZSVhCA3QSkRcZim+ghxLdTD0rmJVxWBB2wDjxj2
 Pez87KrlbPSul/eUlPbXEs5qLUC0sTitjVu8PnVJrmm12Co1zuOVyqItagQloCne2mSd
 VktL7d75DOzI2MmcjoWPlxiAAX5hNNAJx2IxI+ld3RoSsZsyXezX5CwJ9BQ4P/TbK3Ds
 Fl6w==
X-Gm-Message-State: AOJu0YxvsUUdjET2tBtaylw0h0yURAsrvDI+88jz1TaBXGD1kIk2kVHb
 tigsIsP3X4tcQv7gqi4WQyDpwF/xWcF2GENyzeptUgmsHwjqgCivw6Rt4i3VNCkWrQ==
X-Google-Smtp-Source: AGHT+IHU1/z5SxiYoty/SEQJ9NIAr/Ko98Mu6Y2k9045OjxE8dzC1zRp/MTa9DUVxq3BsTSx4dJyig==
X-Received: by 2002:a81:ad12:0:b0:608:9594:8de with SMTP id
 l18-20020a81ad12000000b00608959408demr2786620ywh.26.1708905817611; 
 Sun, 25 Feb 2024 16:03:37 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:37 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 29/41] Enable BCM2838 GENET controller
Date: Sun, 25 Feb 2024 18:02:47 -0600
Message-Id: <20240226000259.2752893-30-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838.c                     |  6 ++++++
 hw/arm/bcm2838_peripherals.c         | 11 +++++++++++
 hw/arm/raspi4b.c                     | 20 +-------------------
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 4 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index c330322bd5..a873162f09 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -239,6 +239,12 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
                                       int_n);
     }
 
+    /* Connect Gigabit Ethernet controller to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 1f41028649..c6083e36de 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -47,6 +47,10 @@ static void bcm2838_peripherals_init(Object *obj)
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
 
+    /* Gigabit Ethernet */
+    object_initialize_child(obj, "genet", &s->genet, TYPE_BCM2838_GENET);
+    qemu_configure_nic_device(DEVICE(&s->genet), true, NULL);
+
     /* Extended Mass Media Controller 2 */
     object_initialize_child(obj, "emmc2", &s->emmc2, TYPE_SYSBUS_SDHCI);
 
@@ -231,6 +235,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), PCIE_MMIO_ARM_OFFSET,
                                 mmio_mr);
 
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
index 175fd2c4fa..d498bc6215 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -63,25 +63,7 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
 
 static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
-    uint64_t ram_size;
-
-    /* Temporarily disable following devices until they are implemented */
-    const char *nodes_to_remove[] = {
-        "brcm,bcm2711-genet-v5",
-    };
-
-    for (int i = 0; i < ARRAY_SIZE(nodes_to_remove); i++) {
-        const char *dev_str = nodes_to_remove[i];
-
-        int offset = fdt_node_offset_by_compatible(fdt, -1, dev_str);
-        if (offset >= 0) {
-            if (!fdt_nop_node(fdt, offset)) {
-                warn_report("bcm2711 dtc: %s has been disabled!", dev_str);
-            }
-        }
-    }
-
-    ram_size = board_ram_size(info->board_id);
+    uint64_t ram_size = board_ram_size(info->board_id);
 
     if (info->ram_size > UPPER_RAM_BASE) {
         raspi_add_memory_node(fdt, UPPER_RAM_BASE, ram_size - UPPER_RAM_BASE);
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 555d3a393f..5588b99098 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -13,6 +13,7 @@
 #include "hw/misc/bcm2838_rng200.h"
 #include "hw/misc/bcm2838_thermal.h"
 #include "hw/arm/bcm2838_pcie.h"
+#include "hw/net/bcm2838_genet.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
@@ -73,6 +74,7 @@ struct BCM2838PeripheralState {
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
+    BCM2838GenetState genet;
 
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
-- 
2.34.1


