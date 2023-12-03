Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F9580282C
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:55:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLe-0003W1-TS; Sun, 03 Dec 2023 16:49:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLb-0003RE-JH; Sun, 03 Dec 2023 16:49:55 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLY-0008Q9-RP; Sun, 03 Dec 2023 16:49:55 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5d226f51f71so42067537b3.3; 
 Sun, 03 Dec 2023 13:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640191; x=1702244991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=INQ5Dwf0tjIV2FVVkRHFjMj49peJQhMrLkGV2V3JvTc3jKxJ9lu+GpmPXtZDISqKre
 +T0HwyEhBn0i+KTKogEsWFAQCDKR11bcePC4eKACgpBGoGYZrnsY1+w7aF7EnB1GWC4D
 G+E+wTVIRVAe7HUjVD7aNs5t+3iV1hYvEtnmy38QEpU3vit0f3tpGiADhHolWz9P090o
 0pLPUm+UltsOYM1Qzqi9RrZZvfxKNQAqFG1FcLKr/VSiWGkCDoQHqkMb/yUI6zz4A6Nc
 AkE0QrFFK5wTJFKzwLnLaAAnc057LLLEAK//mFYS0XkDo7Xy1hHIsAXtbSyxWT0355H/
 9rcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640191; x=1702244991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=ofqUOnWEgNU+jcN2CRvSBELgwCWG4lEeXMgnMWEtvRzweztwywdvOaK7Q0/d14fVKS
 To8wBk6Chp3MXXyBjksOVebOlrWvN5cRNBr6J93jq+oOar+xWGWfWRwxFGv71NOxBg+g
 jXdUX1w8YkqIGPA5S+kB2TFNFJ3ss9n2i7A3TDDgS7qc60KGHfKc4+UrgQGii1vlHdXk
 YYchQ5H8VXKmEl/JAWx1+mdOc1/R4SJFjlUPoBjoQ+3W+X6aZ5qb22JiPw9CTl22Yofz
 jxxtBctgk+2c1BvRoYRwo246c8oaJs0J3SEsQ/E5uGDG2arj0XFuW3ZkPhxthGKAv+5/
 cBxw==
X-Gm-Message-State: AOJu0YyV0wO5QjN1izGMgponl7Bd8bHXhzSoT8DED6ytxj8kcTfaqFze
 08ovIcxJ+KsSKJF9NiL9KJzmlch1Xqdybg==
X-Google-Smtp-Source: AGHT+IGIFrBnjGKVM0PiFDx35tmYWh/+PU02IJb65NfItAtode1ogGh623IM7VGyPxFIlxMat5P6uQ==
X-Received: by 2002:a81:f012:0:b0:5d7:9aac:36fc with SMTP id
 p18-20020a81f012000000b005d79aac36fcmr1364403ywm.69.1701640191345; 
 Sun, 03 Dec 2023 13:49:51 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:51 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 32/45] Enable BCM2838 GENET controller
Date: Sun,  3 Dec 2023 15:48:57 -0600
Message-Id: <20231203214910.1364468-33-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-32-sergey.kambalin@auriga.com>
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
 <20231203214910.1364468-17-sergey.kambalin@auriga.com>
 <20231203214910.1364468-18-sergey.kambalin@auriga.com>
 <20231203214910.1364468-19-sergey.kambalin@auriga.com>
 <20231203214910.1364468-20-sergey.kambalin@auriga.com>
 <20231203214910.1364468-21-sergey.kambalin@auriga.com>
 <20231203214910.1364468-22-sergey.kambalin@auriga.com>
 <20231203214910.1364468-23-sergey.kambalin@auriga.com>
 <20231203214910.1364468-24-sergey.kambalin@auriga.com>
 <20231203214910.1364468-25-sergey.kambalin@auriga.com>
 <20231203214910.1364468-26-sergey.kambalin@auriga.com>
 <20231203214910.1364468-27-sergey.kambalin@auriga.com>
 <20231203214910.1364468-28-sergey.kambalin@auriga.com>
 <20231203214910.1364468-29-sergey.kambalin@auriga.com>
 <20231203214910.1364468-30-sergey.kambalin@auriga.com>
 <20231203214910.1364468-31-sergey.kambalin@auriga.com>
 <20231203214910.1364468-32-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
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


