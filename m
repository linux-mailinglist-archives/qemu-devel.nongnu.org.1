Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008608027CB
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:31:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u2G-00026u-QT; Sun, 03 Dec 2023 16:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1n-0001RH-BQ; Sun, 03 Dec 2023 16:29:27 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1k-0005Qu-De; Sun, 03 Dec 2023 16:29:27 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-da41acaea52so2056732276.3; 
 Sun, 03 Dec 2023 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638962; x=1702243762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVH9O9un+zwSeBPQSL0IeMDZWUWBtxU0cSyYzIJS41g=;
 b=m1mbg05DqHhpzuq1Kzak32tVcM7hSOa4g3HZ6QxlhlLeCVmG6Va4iJM1YugbbMOPxm
 TXjfzR6gkAWOTVxuV4LmZ04X3P28FA8KG/WHl39rzLtJFcVPLG7blsSG0sKRX8zkLlRc
 b7PcPiLyONEXuSsvrgQZNMdNRcwwkO5dDQJ+bywVRgMCx6xsCbIYY/gNAvAaHv5EZoo2
 +pOx24m460vtzreGvSL75Mp+IGG6KZtZa/UKiliJ4vXGMi4Wqm5bLrUZr6xwef7mhG1Z
 EvCTVCm7EZ9Y0zMWD8H8QW2Pnr0qMgU/LhOTFez4rQOxEz8GGrNfoxmUFTP7dDpiMgRi
 1BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638962; x=1702243762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fVH9O9un+zwSeBPQSL0IeMDZWUWBtxU0cSyYzIJS41g=;
 b=ErGp4LdOz41M5lbVkQmoRFTauNb4T8JJK6SlKGZlcVxXkeGCzkdVQ6YI3LhOS+Op1f
 YiCAjzmkNz+Ei9zG2sBwLHJzy9GMUpkw/MYT06eVZBsoVsvn+6JTUhwfp+Bf7RdZ2owR
 5QcesFa25m1o/qBzTIPY3Tfmsl7GJAp3o7mjueD1/pgyLTmoaH4DTh58lwiWW9u33OjR
 OBH91Z4VwOq38bf0V6VVfrRZPcAg4TIn7rfoWiPxojquHmtWtQjTqTvR9oOdgisPuCxA
 URBmTd9iTFAPWnnOAIgltwDQv909ui6wxSS0kV4ggDbwixl5DFM9yKjJApx4m/eOfyDO
 Lq4g==
X-Gm-Message-State: AOJu0YyqZk7MDHKZ076qSrvVdG3k7+vrb3YIzRrBVu02PR7JnI0OmS1i
 683uvQ4ybZeSHJN3O94dYr6faVhopPjCSw==
X-Google-Smtp-Source: AGHT+IGJkEoXyYSNQk8YBFhKcgSjICdPhBXSBuXj82XV1e4XIfy/9vF5pUaafVEBnG2GpudoWoOvfw==
X-Received: by 2002:a25:908c:0:b0:db7:dacf:3fb1 with SMTP id
 t12-20020a25908c000000b00db7dacf3fb1mr1697054ybl.94.1701638962729; 
 Sun, 03 Dec 2023 13:29:22 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:22 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 13/45] Add memory region for BCM2837 RPiVid ASB
Date: Sun,  3 Dec 2023 15:28:33 -0600
Message-Id: <20231203212905.1364036-14-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-13-sergey.kambalin@auriga.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb32.google.com
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
 hw/arm/bcm2838_peripherals.c         | 3 +++
 include/hw/arm/bcm2838_peripherals.h | 3 ++-
 include/hw/arm/raspi_platform.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index 196fb890a2..d3b42cf25b 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -182,6 +182,9 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
         sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
 
     object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
+
+    /* BCM2838 RPiVid ASB must be mapped to prevent kernel crash */
+    create_unimp(s_base, &s->asb, "bcm2838-asb", RPI4B_ASB_OFFSET, 0x24);
 }
 
 static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 0a87645e01..af085934c9 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -64,12 +64,13 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
 
     SDHCIState emmc2;
-    UnimplementedDeviceState clkisp;
     BCM2838GpioState gpio;
 
     OrIRQState mmc_irq_orgate;
     OrIRQState dma_7_8_irq_orgate;
     OrIRQState dma_9_10_irq_orgate;
+
+    UnimplementedDeviceState asb;
 };
 
 struct BCM2838PeripheralClass {
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 0db146e592..537fc6b4af 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -74,6 +74,7 @@ uint64_t board_ram_size(uint32_t board_rev);
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
 #define ARBA_OFFSET             0x9000
 #define BRDG_OFFSET             0xa000
+#define RPI4B_ASB_OFFSET        0xa000   /* BCM2838 (BCM2711) RPiVid ASB */
 #define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
-- 
2.34.1


