Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE997638E5
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:18:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWw-00038R-FZ; Wed, 26 Jul 2023 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWm-0002xK-7r; Wed, 26 Jul 2023 09:26:09 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWi-0003R2-KN; Wed, 26 Jul 2023 09:26:07 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fde022de07so9479595e87.1; 
 Wed, 26 Jul 2023 06:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377959; x=1690982759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ebz4zaPSB825b//nKL9QitZqZj2Z1dkYisPYbSRA790=;
 b=HGCIL8mfEGIwy2M8kHfaOd/T2gZoXEJ0wBgnVZQOJIX/tKhXAPbHS1quaubY8m2DZs
 LPvKQzPD/+dvHzJX5YFRp36n4hPIf83LqUMIjlH6Aomf+fpYn4kuNt1crVrzUIDyyWkL
 iMFMbfPC0I8KJ73aQeXaGDC0/ym5f13bXKod7/z6p1mAfIsJo3MLTBYwatMsb3D94GNC
 P6kv24LfRjVf9FLDIWWGcqMOXFfp/b+qMLQf3/xdDLYsNQb0CdNzUGYgCiH+DsaAqcZ+
 S6TCfC+wmk2hEzGCsNbHZQnXfnseRZ6D8Y92MovBPqZSiQO7iLWEXfLMBCuObvueJsPp
 pTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377959; x=1690982759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ebz4zaPSB825b//nKL9QitZqZj2Z1dkYisPYbSRA790=;
 b=kZZXuA4gLVGWZyrKIwfCHA9vUYwFkb01+0zeIr7qaUH042f7xcVTKXPLLOOVmZv1sK
 I1doU6E3NfYAYT5yhH2/tg81r7Q4/86muTw7ReEChiHYuWvi/4a0c2RQBcbtWyE1RYn7
 bUXQ0Iq0oEP9fmY/akZfq1fUXCN4z0HohIvrdnfPOOiPBmEzMLyOoKyaj+6ChkUDL1ae
 pP5aaARQAD4Y5ZJknF+GI1dVwNpuTg3Wa9+qGUaK3el2RnGafRv4KZmKOShBqq559IqR
 ZDEib48ZOIPY9ueueDkY8DMFv9f1EB/6MW4tEOTXauyKX15rIfhKQYewh3njfZVmFCMZ
 k7CQ==
X-Gm-Message-State: ABy/qLZ60fFAGgplNRl811J3HRQ7hYq1izU8F7Wtatv5QCg/bKferj7+
 ciQ6sfyxGUlVx/ziujIuXkjoCqsMr9g=
X-Google-Smtp-Source: APBJJlGvQDzrVUTmQUN4K5HJQIVmqdyOhwK7uTxVO7AkhYmlZQzlU+bI58SuzYCUdcgzf/v/u78vMg==
X-Received: by 2002:ac2:5f48:0:b0:4fb:820a:f87f with SMTP id
 8-20020ac25f48000000b004fb820af87fmr1395658lfz.10.1690377958989; 
 Wed, 26 Jul 2023 06:25:58 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:58 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 33/44] Connect RNG200, PCIE and GENET to GIC
Date: Wed, 26 Jul 2023 16:25:01 +0300
Message-Id: <20230726132512.149618-34-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x129.google.com
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
 hw/arm/bcm2838.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
index a1980cc181..83bfbc2cae 100644
--- a/hw/arm/bcm2838.c
+++ b/hw/arm/bcm2838.c
@@ -217,6 +217,10 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&ps_base->dwc2), 0,
                        qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_DWC2));
 
+    /* Connect RNG200 to the interrupt controller */
+    sysbus_connect_irq(SYS_BUS_DEVICE(&ps->rng200), 0,
+                       qdev_get_gpio_in(gicdev, GIC_SPI_INTERRUPT_RNG200));
+
     /* Connect DMA 0-6 to the interrupt controller */
     for (int_n = GIC_SPI_INTERRUPT_DMA_0; int_n <= GIC_SPI_INTERRUPT_DMA_6;
          int_n++) {
@@ -239,6 +243,21 @@ static void bcm2838_realize(DeviceState *dev, Error **errp)
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
 
-- 
2.34.1


