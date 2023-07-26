Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965A763824
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWq-00031R-2i; Wed, 26 Jul 2023 09:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWJ-0002kd-Do; Wed, 26 Jul 2023 09:25:42 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWG-0003Du-VM; Wed, 26 Jul 2023 09:25:38 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fe07f0636bso3041707e87.1; 
 Wed, 26 Jul 2023 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377934; x=1690982734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0cTjRFQUPbt6KEjWvLsa9EHTGGdXwsYH3fauhWiZlKw=;
 b=W8CmYjzVtR7HblAuUXKtcRPSbUWm0BQh1zQNhoX+eGTwEFNOiw1v21VtGKOExYXXqk
 p1taoCbXiMGYvgln1EK60m8mW4ADjefHKGG8s9iBW/NPyIpDd5RsViIkAQ4+L0nJyfEl
 HVn/EIMvxxhp1GOCKPH+L4PZxyOO49hMP2dJHerN3cnx/aMaQiYYIkxXy6yVtVDVwRqx
 lLb5qGcovcXVGM17SBxKsz0Ogt+bis67ZSd2qSkJEEphoQW6tRUzv/ZTpHNYEB5hLvlL
 adq8nlFJAE87DN3GLfexMWZa2Ftg0NbIeKGD4y6rWJ75VUBVer83rR8O8Sdk0+cuUWmY
 uXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377934; x=1690982734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0cTjRFQUPbt6KEjWvLsa9EHTGGdXwsYH3fauhWiZlKw=;
 b=eZSu057wIb6TiJJV7yjg8byQLLdjYgYW9hcpsyXoTeDHdn16oeTW/hPul2UcEAXi8G
 Q6pYY9rFdyg/4yg/OGO37Lz0ISB8xRdqTC0gZfYBQisB3kzrCcyirxxMEvPieFCa1hZ2
 jN29o0nCixD+HEWAt8QcoNa2idvaveszR6Rgd1aY/8+YLB0TUgUeRy/xbnTHPQN+N7Bm
 U4OQxxp7mn1KHOHMIH2A7Ac1PjRRQ7ABSfccvHGcQ8ru53WWEn6Cd1N00gS6Ur2QxBX8
 Ow+YYt1uvE1P1AgNy8wQfN/d3vcfJGXEo2mDwkNRRnWn6BKUwB/nzwe6EygthTS20eOk
 kwwg==
X-Gm-Message-State: ABy/qLa6BjpBrI2bOJz5Xgxxa9CL1mSh4XMQosGPiK9rlek+w8SwWcet
 huTrWUS/VfhpkInvhhPM/FH7e2vOFNw=
X-Google-Smtp-Source: APBJJlGldKr5Pza3ucVHw5yqeMlZN2xLtNXxlX1M0Otz5QyO1ry6lC30MTo8LI2C+jy5CVq8RpVY6g==
X-Received: by 2002:a05:6512:3286:b0:4fe:c6c:ac95 with SMTP id
 p6-20020a056512328600b004fe0c6cac95mr1423401lfe.35.1690377934351; 
 Wed, 26 Jul 2023 06:25:34 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:33 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 13/44] Add memory region for BCM2837 RPiVid ASB
Date: Wed, 26 Jul 2023 16:24:41 +0300
Message-Id: <20230726132512.149618-14-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x130.google.com
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
index 0c5e716853..f689e16535 100644
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
index aba38a18f0..ebed11dd40 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -66,12 +66,13 @@ struct BCM2838PeripheralState {
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
index 30b114f6e0..4a5e8c1cc8 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -71,6 +71,7 @@ uint64_t board_ram_size(uint32_t board_rev);
 #define DMA_OFFSET              0x7000   /* DMA controller, channels 0-14 */
 #define ARBA_OFFSET             0x9000
 #define BRDG_OFFSET             0xa000
+#define RPI4B_ASB_OFFSET        0xa000   /* BCM2838 (BCM2711) RPiVid ASB */
 #define ARM_OFFSET              0xB000   /* ARM control block */
 #define ARMCTRL_OFFSET          (ARM_OFFSET + 0x000)
 #define ARMCTRL_IC_OFFSET       (ARM_OFFSET + 0x200) /* Interrupt controller */
-- 
2.34.1


