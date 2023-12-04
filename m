Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C93802984
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:34:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9woM-0006RK-Qm; Sun, 03 Dec 2023 19:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnl-0004if-Rg; Sun, 03 Dec 2023 19:27:09 -0500
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wni-0000F8-P4; Sun, 03 Dec 2023 19:27:08 -0500
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-5cece20f006so46001797b3.3; 
 Sun, 03 Dec 2023 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649625; x=1702254425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=fx54FCYvWHj1JSVlZGPL4vEwqXQ+3eyqtuG8nw0sMaSV+5Azc7Dz6nCLHd9zlqlMPC
 p7kfXpN9lT9vppVwmM5MrgY97NaqhdjuCLHcNoNM+l4juOd2ko9zUFqLYPFYwL/DDiTH
 jbPbZzJUsekOun6DVNoIhVj064rS8TSLP/O+MBSiYpLfiQGKH4H59MBojtOmimIvlEkx
 fKFPKcJoHS8y4m3YJ/9KLyD8nJqlzuPvuK9LhOid3kGU6QiQBml16Hww13kc2+JFsFnX
 y6oZPSr1Ee8vQYN6K5t6czYSMIanX0NHXOFN4Umvd+zAe4W6TWXdJF1glAFW1SlLJQ/A
 KkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649625; x=1702254425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgtBxKk/YnE0/ZchwODTjsH1Cpkh2DZnmTE8Tpp7q3Y=;
 b=Cmh3h9bDFVCB6pYspE5b7nFszsZ3Q8Kuca1EmFzvFepEE1lxNvpWoQ9p6/LHki9Z7e
 fxFDA1UAPy1zBfCCaZ5K4V0rtz0bi5PnzUzM04zQxIq1B2sU64aas6h7yh+ymmi8cvqi
 mV2/CflYLGpffhom1S4z7AL1YyBzntXkWd/ccvBs++c7hW2iNfN5esy4rM1Nb4X60JwK
 i9UQJygpu+iA0OYz1eC/FaglJA7WNIMs3o8M3eVLJX8YE9DLZwVEvOz2jJYl5yDDUjAN
 eUzFPX39IOwqnLxsjViIe1l+NfoYArWsX3PldUB9iqovZalz1PvBuS/iPZsfsFD6SlF1
 ZIbQ==
X-Gm-Message-State: AOJu0YyueEoLxaulXEpjTaKqt8+qaT0dUrfcSQcNgIh0d1t70SfByleP
 OSUzme1VvmBYtzOzk8/esSCATsAA2PjQyg==
X-Google-Smtp-Source: AGHT+IH6yfWYdTUxLjZpC3nKhJSq81qf61r+CayFoRMeaDJRZVrLXFd934Mbwma1pAQsw0hZHOLgpA==
X-Received: by 2002:a81:b65c:0:b0:5d7:1940:f3d1 with SMTP id
 h28-20020a81b65c000000b005d71940f3d1mr2664448ywk.57.1701649624739; 
 Sun, 03 Dec 2023 16:27:04 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:04 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 32/45] Enable BCM2838 GENET controller
Date: Sun,  3 Dec 2023 18:26:06 -0600
Message-Id: <20231204002619.1367044-33-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1132.google.com
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


