Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01450809942
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:34:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQge-0007Md-Nv; Thu, 07 Dec 2023 21:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgc-0007DU-9w; Thu, 07 Dec 2023 21:33:54 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQga-0002iT-F8; Thu, 07 Dec 2023 21:33:54 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ca00dffc23so18896441fa.2; 
 Thu, 07 Dec 2023 18:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002830; x=1702607630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=VZYk1uTtoAQsmrmf/ufaMbQQPCi4lRzIGpZst9sTdzXIexDcErtJm6tw6y3w6RnpRo
 HZYu5G408A/T2wTXZ75LgJbn+ZdpU/Jjn9wm+ECrE2yOFWQl3Zk5xORLDTEsE79by6TH
 vKU0sDtgkGv105lKIUXIXU6A6qa5unyn/pEaEPwDhmRasJfTYoQacNcLoyGXtgwTZ6b0
 KLF06Brnx53o0a1aqf91yTwv52TGTxvHgpBT6pQzqt4f3g5f2gQ/y7hjKF80YoDU/Zx1
 d9BrKf7e1IC0XKPZSBal+APQ6LE8/n6q1IhTf0PyicDTmrhgOP30JjH+TKsc9Orrb2tE
 w/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002830; x=1702607630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt9YUbIlO6FMtWaTdWEGV74ka7r2AOm7LpJmnrybMmM=;
 b=qn2gF23wmXaBFyHficEV2s1poh/0zjgNRFOgWbwvKzVj6LpHauF/LhfSSsZ+FZLFtd
 EIAgUco3e7P4j2vSUk0awoQYuCPtM65ZX1RdB+2bDtqJ4b3D2S9sMLwtgpE0WJ8v3PWn
 +gjowElTa7qu7ToY4/JWNZo2TjQ5hlvJTQdZaUxFXj6Sw2XYeMrT/BJ+2i7YwLGCjCgI
 gh+IO31/h4aR7v2Uan4gy05Xu7AIdsy1jJoVJiM5a3bIxEfnPAypYd0PtSxZkDvAMQyI
 8xVCmVTGQ4AxHDeCtqNz0Hv6KrONPOemX4dBempsfjoL1i1ApBJADcm6dtJ0AKPcR/VU
 97Fw==
X-Gm-Message-State: AOJu0YyQXGMJ5jq4FhLg7JSPd1YmWoHrb0An8KYad80ZPnE9OC/it6qE
 4OQEZPUL1TeSpKEH970ibBQGnaLRsB6kJQ==
X-Google-Smtp-Source: AGHT+IGWc2kXrNmwm51m1X/Nw+Bc9tDX/h4RGaQGYgJhDcqG86x1tG0mkTgPgUI34V3TwnlQqplb+A==
X-Received: by 2002:a2e:300b:0:b0:2ca:cb5:2ed8 with SMTP id
 w11-20020a2e300b000000b002ca0cb52ed8mr2034303ljw.103.1702002830057; 
 Thu, 07 Dec 2023 18:33:50 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:49 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 33/45] Connect RNG200, PCIE and GENET to GIC
Date: Thu,  7 Dec 2023 20:31:33 -0600
Message-Id: <20231208023145.1385775-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x22f.google.com
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


