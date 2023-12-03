Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3BE80293B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 00:49:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9w7W-0007Us-0B; Sun, 03 Dec 2023 18:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w71-0007IS-Bl; Sun, 03 Dec 2023 18:42:59 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9w6y-0002pX-0x; Sun, 03 Dec 2023 18:42:59 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6d875809921so1276779a34.3; 
 Sun, 03 Dec 2023 15:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701646974; x=1702251774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=Vm5B2DHpFItJ2XdoDswyVmO7VfMhUZHaZi+VnqepwKdMmaEnvOe2xQ5zp+m7Q/rQIP
 nzuRtC38etBjvXf6ZzNdsjzkSnfNXyNdkSsKDQUAuKy3JA0uFNSY9hoybI6CxAaH7WVJ
 AgLnKRBZVJ1qLhsvMJcH7qEq7UsN0xot5jD/ucJ3Sr51hLdmT3DsDS/zhZvwftbBzIr0
 ZORgzeGiger78iToUelxCGUgaiWXeFigH3l4emkluS5pylhxrR35KhQeOJWWofT9LrvQ
 VMBdkT9dII6xtYVmpUAXyoCZelDtEYeCcuqaI+vSLd8ij0u9kCh7N3UzsprBZtnbs+Ho
 owkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701646974; x=1702251774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=FUCchLh5g/zTuTEf5R9ZOv1+mWpywzOXLUr4KbZ60ZX42IMbzgdW/+9wqAEAXhB1JV
 t9+JYA7OQZ2YfjaBn645nqcjSA00Rl7pFsLX15eSfcFOGqG1tAI/jDEJqpTXbzcGM3mb
 2cj/aZaEB023sbkhuA0BRAm61IHSRWdtF8BGUgY8aJ47Lgnn/OerJ3GwVVTdDei0Xpq+
 lOl90v5RE+n3GPO5ldzU2nm+9qo/+4IwcZYYvHPMFYVIV43AleZShHeBk4gqdfbU/FqR
 gWt2iw2m40RB3KijMPckyEo7SnuwzT2nEdmoSr3oETBKG//xmtkPpE6CBnr8SRBtigVh
 Fznw==
X-Gm-Message-State: AOJu0YwZOSHMmBzsSu4URfttl+QrSeRynETaBIvVx8OgK5m8NW1iTwwg
 VlQC5Dx1qa/H3xbgV9u6XE9nvclgR8J7UA==
X-Google-Smtp-Source: AGHT+IGHeKHTaWCDh+YD/mwautx5L0fDvYQs6eZGM2CG+KaKv9TXLxD43H0705IIts6F3d0v2+v7wA==
X-Received: by 2002:a05:6830:411d:b0:6d8:7a55:e293 with SMTP id
 w29-20020a056830411d00b006d87a55e293mr3099295ott.54.1701646974257; 
 Sun, 03 Dec 2023 15:42:54 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c126-20020a0dda84000000b005d718fff165sm1536299ywe.78.2023.12.03.15.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 15:42:54 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 33/45] Connect RNG200, PCIE and GENET to GIC
Date: Sun,  3 Dec 2023 17:42:01 -0600
Message-Id: <20231203234213.1366214-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=serg.oker@gmail.com; helo=mail-ot1-x32f.google.com
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


