Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E269880295A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:28:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wo9-0005CO-HA; Sun, 03 Dec 2023 19:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnl-0004ir-SZ; Sun, 03 Dec 2023 19:27:09 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnj-0000G2-Ko; Sun, 03 Dec 2023 19:27:09 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5d3d5b10197so29484697b3.2; 
 Sun, 03 Dec 2023 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649626; x=1702254426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=N/dLHllnVy7f1S22hTr+XfLb20a7jkp0BlLZ73aOFTwpYmW56Ehw/qj7r+33mLAPou
 nzGHF58SskIFMOajyBn9YjwDt53WfiUBUXa5by4Ns4Ib7XAAFL99hZkHsnpRHHtO8dv5
 uMimnmcqGrRObK2Od/YWA7+VJJUq4X5K+qgtbOv8G3tz9zBxjstw7s0g1vni8X06ggvE
 M7pw2BIPIEqC3VNf501MevG6wRlQykUVQ36TnhjU5fwvrLt+St3q0Uay0DFg4cKU3rKl
 4LcCBRcB/4fkzLewP5CUS0AF2wnzIs9hKjCJPJtlSwKBBe7ibRvpphyEhhlLR5v+sGnD
 LmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649626; x=1702254426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=HnTtlWF5mGPvd+x+Jy75eYPzrvgIcSd+b6cFSgX3r3t/DFz9wo3W5srJIXNcYwaG4v
 yBM/6ZcmEN+KCf5GCXgd39EP0SN7yQYXTAv9l39fXwzGG78atqdPaWGrcM5Bm8LB8J+t
 HHeOP5QpP2CBIC+CvlgGO77Kh1fpWOFKQqItCtTGyr6f+3DuKHNIdDNPM/5rS0t2fvw8
 utx9ulDZXVacMFq/LM1cfA/CAeV7QdJwZp1NK4CVvoqmu1i1qEqEZ8laLwB45IrNJq0o
 FbG2w8DGvtxMhUxefMHViktK87+ZGvyyTnjYMZTqjZRbGva1uqBD1T5nVK+WJ670vJ63
 kuOQ==
X-Gm-Message-State: AOJu0YzoosThnPrIF8vmgx9ZT+TV5ABTy+hl2yzVbIkYI2SbDoWifjFx
 Yokk/RE07DjK1HQLjPlIp92FcKrxZiNtOQ==
X-Google-Smtp-Source: AGHT+IGG1nYyCjZCoakttghxzUb65QDja7D3a1TVZhh8zBOWx+aycmm9My2nI9He8Cb+Kt9BwQh4FQ==
X-Received: by 2002:a81:ae1b:0:b0:5d7:1941:a9c with SMTP id
 m27-20020a81ae1b000000b005d719410a9cmr2000696ywh.55.1701649626027; 
 Sun, 03 Dec 2023 16:27:06 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:27:05 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 33/45] Connect RNG200, PCIE and GENET to GIC
Date: Sun,  3 Dec 2023 18:26:07 -0600
Message-Id: <20231204002619.1367044-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1131.google.com
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


