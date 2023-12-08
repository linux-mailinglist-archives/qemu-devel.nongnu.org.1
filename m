Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A9809969
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:42:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQgd-0007Fm-DY; Thu, 07 Dec 2023 21:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQga-0006uW-Kf; Thu, 07 Dec 2023 21:33:52 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgX-0002gQ-Fg; Thu, 07 Dec 2023 21:33:52 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50c0f6b1015so1701749e87.3; 
 Thu, 07 Dec 2023 18:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002827; x=1702607627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=fFuhSMWBQmaEVE6C3pLxgKA1k6bQXkLM6bT7EmzS7kyZ1P6PrEOWjbIzsDzQYkFO8K
 8rxuGXa0tm+OzgAJBX0kxdhca2UX1x0ld5ozeK4Ckr6pqf1SmlZxxVaxGzPI2L38WZIb
 9r1zoAgUDP+ssc8jf1ecFRUigKdsqGn0wXwRJB3M82CXiKBphUOgWAa8qiyJkkntEKqL
 Kp4fMiQlo1NpQfy6gxVxwJLWYzSTYEmfnqhUcJ2tHgWDCOBGy3b6i9PHxm75n/8dsww9
 axp6XjkiWARNnkgzLkR/jsjeSfhagIS7ZWIpJJddFyZw6sU+LSTkEqhql6BYBW6QnjTb
 ATdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002827; x=1702607627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=UdJpYpD8ZijFUE9AxSn75qHJ+u9n5BiwaVuwSm4aCaHEu0IOpIqiTwfF3lnAywJVBx
 NFipN4xRjbHFESAmOMLbfj/3Itu4zblAj35/r4C/x/+K3n0r97eAFoijuTcGVY4MDGFR
 0KcOP6SdmQv0y02PouZq7vnZmzgm6+sjcoqPhRNXCatcH17Tu/dArvS5jjg6E6NAtYQl
 YKv6/9Yzs5OBueEuUwNqo69TeKzmo7pyNdY0rUv/8pmvOc2V89cfEmcX3APFTkDP3V+N
 TOUeOw5kYrSAmLG7U/rXYC2bxVPLi6peeNDj4G/q7bT1PEGlA3j+6jbJmQ+5EL44936P
 xcTQ==
X-Gm-Message-State: AOJu0YztDSJJqvU+UJbnm8p69stStcGamI8V34SQS+E34K0zZ6RgRnoG
 et1uFcQWMezgwyiWGlcIZ89uWVJmlX3+JA==
X-Google-Smtp-Source: AGHT+IFe3MjgxvJ3vT7fFnGKzYjzyeVWdaifCOzwlNw3WZI+rEg1So2Y+PdOKLeDudtTtLApxnRt0Q==
X-Received: by 2002:a2e:a0d5:0:b0:2c9:f7fe:928f with SMTP id
 f21-20020a2ea0d5000000b002c9f7fe928fmr1832063ljm.93.1702002827009; 
 Thu, 07 Dec 2023 18:33:47 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:46 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 32/45] Enable BCM2838 GENET controller
Date: Thu,  7 Dec 2023 20:31:32 -0600
Message-Id: <20231208023145.1385775-33-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12c.google.com
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
 hw/arm/bcm2838_peripherals.c         | 16 ++++++++++++++++
 hw/arm/raspi4b.c                     | 17 -----------------
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 65a659c15c..d962999daf 100644
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
 
@@ -231,6 +240,13 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
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
index fda27d36cb..8aa8dfb087 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -64,23 +64,6 @@ static int raspi_add_memory_node(void *fdt, hwaddr mem_base, hwaddr mem_len)
 
 static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
-
-    /* Temporarily disable following devices until they are implemented*/
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
 
     if (info->ram_size > UPPER_RAM_BASE) {
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 20b7d1eb67..1cfcf5dcce 100644
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
     UnimplementedDeviceState clkisp;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
+    BCM2838GenetState genet;
 
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
-- 
2.34.1


