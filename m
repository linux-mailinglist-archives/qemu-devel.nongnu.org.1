Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549C9723E52
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIn-0007gP-Qc; Tue, 06 Jun 2023 05:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0007e0-V2
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TId-0004kO-KB
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:26 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so51011595e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044902; x=1688636902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+8fuW417xdSGSqZdvJha6Pw9eQ4Se/9DxEo3/LgeD2U=;
 b=W4Qa28kcQJbzaoG1x2xJqCHKiZcr2Ulo07h7GiTir2HMWv51jihwa+1HnHwax9iTcC
 MXketIzW1DTFgJR+lmraSWIWA9s/VrMmfQd9iOa7lwwiGnslfQmkYv9O0XrR0crN3yDQ
 ++mewvpP6H3iqSdQTWk/ZpWM4RX8U88cg1+Vl46Ipe47CPk/1CkWEnPM55fuRsdyS3Sm
 YsFyzXGOefOLWGg4S3QBFGKmPtAjKbXAUJWOyUmObrTvrceTG9hG+MZ7mHZRQh5K6D3e
 6YYHpAur073VLb9Zpv16QuERvJcTyFUW1rIQZ7w2KiSON+qMgmroJlQ08z0rrKx54VwN
 MT5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044902; x=1688636902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8fuW417xdSGSqZdvJha6Pw9eQ4Se/9DxEo3/LgeD2U=;
 b=kzO8CsR8hzQ/XlynGQVu0yD70av4mfN6smT2KJHCQC3ryevcYTomjcBes5VRQgm1k+
 KCY3N758Or9dIadSeTNCSLFQsTzyQHVnJ979DZl0F9yX8GlKb1Us0GO8IF4mgBQxdLNO
 W8n1hu7Bb1rXbyXeCiW95RelK9eogCusPJArdr4XCgnBOQMYpyfRZyq+pRAhd4i73Jpz
 HyWMT5jGBzIqi1t3eb3q5K4Eoekw3z04+5qjGjeJp2WKC+6bPNFInUr2Rbr8r6I95CfP
 3W/3nA3RCcWz4ZtSw7XGyD/+P/elX27Ys7qOzYerA4u8DUkvh6btQEKb0UX1oX7nne3H
 uOmA==
X-Gm-Message-State: AC+VfDzh6XZbcb4voAKcWRgXrqERmLmkp737PKQoI0Wp3xy4wsBe19nc
 yTwXTQ0jCrt83kkhWkJb6NJ6FjjoCnpztRmPugc=
X-Google-Smtp-Source: ACHHUZ4v2v+bbEG3loXgvwjtsdFTPNnaWPCxm4GzqaqAEORwKNa+I1AQqRo7LaeBt06j2Xd+Q1uzaQ==
X-Received: by 2002:adf:f547:0:b0:309:38af:91c6 with SMTP id
 j7-20020adff547000000b0030938af91c6mr1438124wrp.68.1686044902129; 
 Tue, 06 Jun 2023 02:48:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/42] hw: arm: allwinner-r40: Add i2c0 device
Date: Tue,  6 Jun 2023 10:47:44 +0100
Message-Id: <20230606094814.3581397-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: qianfan Zhao <qianfanguijin@163.com>

TWI(i2c) is designed to be used as an interface between CPU host and the
serial 2-Wire bus. It can support all standard 2-Wire transfer, can be
operated in standard mode(100kbit/s) or fast-mode, supporting data rate
up to 400kbit/s.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-r40.h |  3 +++
 hw/arm/allwinner-r40.c         | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 959b5dc4e04..95366f4eeef 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -26,6 +26,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
+#include "hw/i2c/allwinner-i2c.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -48,6 +49,7 @@ enum {
     AW_R40_DEV_UART5,
     AW_R40_DEV_UART6,
     AW_R40_DEV_UART7,
+    AW_R40_DEV_TWI0,
     AW_R40_DEV_GIC_DIST,
     AW_R40_DEV_GIC_CPU,
     AW_R40_DEV_GIC_HYP,
@@ -89,6 +91,7 @@ struct AwR40State {
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     AwR40ClockCtlState ccu;
+    AWI2CState i2c0;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 537a90b23d8..4bc582630c4 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -52,6 +52,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_UART5]      = 0x01c29400,
     [AW_R40_DEV_UART6]      = 0x01c29800,
     [AW_R40_DEV_UART7]      = 0x01c29c00,
+    [AW_R40_DEV_TWI0]       = 0x01c2ac00,
     [AW_R40_DEV_GIC_DIST]   = 0x01c81000,
     [AW_R40_DEV_GIC_CPU]    = 0x01c82000,
     [AW_R40_DEV_GIC_HYP]    = 0x01c84000,
@@ -115,7 +116,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "uart7",      0x01c29c00, 1 * KiB },
     { "ps20",       0x01c2a000, 1 * KiB },
     { "ps21",       0x01c2a400, 1 * KiB },
-    { "twi0",       0x01c2ac00, 1 * KiB },
     { "twi1",       0x01c2b000, 1 * KiB },
     { "twi2",       0x01c2b400, 1 * KiB },
     { "twi3",       0x01c2b800, 1 * KiB },
@@ -167,6 +167,7 @@ enum {
     AW_R40_GIC_SPI_UART1     =  2,
     AW_R40_GIC_SPI_UART2     =  3,
     AW_R40_GIC_SPI_UART3     =  4,
+    AW_R40_GIC_SPI_TWI0      =  7,
     AW_R40_GIC_SPI_UART4     = 17,
     AW_R40_GIC_SPI_UART5     = 18,
     AW_R40_GIC_SPI_UART6     = 19,
@@ -270,6 +271,8 @@ static void allwinner_r40_init(Object *obj)
         object_initialize_child(obj, mmc_names[i], &s->mmc[i],
                                 TYPE_AW_SDHOST_SUN5I);
     }
+
+    object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
 }
 
 static void allwinner_r40_realize(DeviceState *dev, Error **errp)
@@ -416,6 +419,12 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
                        115200, serial_hd(i), DEVICE_NATIVE_ENDIAN);
     }
 
+    /* I2C */
+    sysbus_realize(SYS_BUS_DEVICE(&s->i2c0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->i2c0), 0, s->memmap[AW_R40_DEV_TWI0]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c0), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_TWI0));
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
-- 
2.34.1


