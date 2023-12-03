Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C61802837
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLf-0003WJ-0l; Sun, 03 Dec 2023 16:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLb-0003RH-Jm; Sun, 03 Dec 2023 16:49:55 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLZ-0008Qa-Vw; Sun, 03 Dec 2023 16:49:55 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5d40c728fc4so18874517b3.1; 
 Sun, 03 Dec 2023 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640192; x=1702244992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=lAKGaC8lgskvCZPR1ARTLa2JKPifGGemByfzeQi0QTOiKnaUgrUMn3BINUZxuGbtUY
 uT+DQF0xYDjdWTFo2bYyE+FLxzaqJ2z8a42x2J+i/Uvi2zVrvqwdY+LrztN0Ckuhm9GW
 SstFQxzwHhFcW8ySbGVrmpbRlV/0UpJA2nwyTHg4s7cn36adFEPcnVlIdOv3ARJ7S6sq
 NJe8vC1rz1rkOQMBlXP8XRZMo6RClTLoLp1QflZdztAQnTs3Ywtm+hZTQDKlt2rcN4iH
 nDGw5qtRCoUe6ZDQlDSDhfuAXlmzqAMbKplq3kfJ/UsYnRUor5tzu2HaEwW5+Ziq3neD
 /l7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640192; x=1702244992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=WaMIMjRPURCIdsvup/AeAkOMQunt+Ico9eS+kTrkEbsa9dHkKWVzQpJZ9O2aF25EpE
 0NjvxcxkdthRuJ142rECUty867RdxAtJdIFXHlgHemJJZak0FlWaSc53i14jEUKbSp0G
 tmGk9vhV/FMnyTBZqoq/b6dTkJ7PoCnq4M7Kni94XBnm395zHazjEw9WHCSLMm2lNve6
 noLykRplYs1XLjAEHsBYOBgOxEfAb+IZL3jTLtiwdIoGNIpElK9+R721izeXhEd4n+ms
 DSivEtN6GfoCNMUyrogDX+RyOnQDynOcVNWYc95Aag0cCXI3fT/J/rdUpVPN3bTio1sI
 x8oA==
X-Gm-Message-State: AOJu0Yz3+jAx2dXwiqU7bapvVVOiQ3oFKj/bII3/9e2+kSRF+9d3xXWz
 RRszK/ngu8vrZwRKCFnVDZ7ObIcYuqXBGQ==
X-Google-Smtp-Source: AGHT+IG0zrPyrG2GRqJKENdJB5KxMJckdgUcThe5mVP2gNxVVBK73qO0DD8/rJ3WdW6IJoQJAEEW1A==
X-Received: by 2002:a81:9955:0:b0:5d6:2ebb:3b5d with SMTP id
 q82-20020a819955000000b005d62ebb3b5dmr1887999ywg.21.1701640192348; 
 Sun, 03 Dec 2023 13:49:52 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:52 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 33/45] Connect RNG200, PCIE and GENET to GIC
Date: Sun,  3 Dec 2023 15:48:58 -0600
Message-Id: <20231203214910.1364468-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-33-sergey.kambalin@auriga.com>
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
 <20231203214910.1364468-33-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112a.google.com
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
 hw/arm/bcm2838.c                     | 19 +++++++++++++++++++
 include/hw/arm/bcm2838_peripherals.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index 89cd9d5d8c..83f84b22ad 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -210,6 +210,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
          int_n++) {
@@ -232,6 +236,21 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     qdev_connect_gpio_out(dma_9_10_irq_orgate, 0,
                           qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DMA_9_10));
 
+    /* Connect PCIe host bridge to the interrupt controller */
+    for (n = 0; n < BCM2838_PCIE_NUM_IRQS; n++) {
+        int_n = GIC_SPI_INTERRUPT_PCI_INT_A + n;
+        sysbus_connect_irq(SYS_BUS_DEVICE(&ps->pcie_host), n,
+                           qdev_get_gpio_in(gicdev, int_n));
+        bcm2838_pcie_host_set_irq_num(BCM2838_PCIE_HOST(&ps->pcie_host), n,
+                                      int_n);
+    }
+
+    /* Connect Gigabit Ethernet controller to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_A));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->genet), 1,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_GENET_B));
+
     /* Pass through inbound GPIO lines to the GIC */
     qdev_init_gpio_in(dev, bcm2838_gic_set_irq, GIC_NUM_IRQS);
 
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 1cfcf5dcce..cdeb892f04 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -17,6 +17,8 @@
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
 
+#define GENET_OFFSET            0x1580000
+
 /* SPI */
 #define GIC_SPI_INTERRUPT_MBOX         33
 #define GIC_SPI_INTERRUPT_MPHI         40
-- 
2.34.1


