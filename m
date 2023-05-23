Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA2F70D9FB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ota-0004pG-JR; Tue, 23 May 2023 06:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qianfanguijin@163.com>)
 id 1q1OtX-0004kq-2v; Tue, 23 May 2023 06:05:31 -0400
Received: from m12.mail.163.com ([220.181.12.196])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qianfanguijin@163.com>)
 id 1q1OtV-00070L-4n; Tue, 23 May 2023 06:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3Xj1O
 yik9nleFeLnHwW9efP4x4Z2mcv8RHBqm/99bCo=; b=YFmakWUnUYmnc9VSpgxo/
 UNkvpT5XnbWoLuCqNEKx0bbBdj0hnCKkaqMSu/alGpBbEecuXgE8g3KBvQ4FWPBo
 HtNsPuUGWtsJdxSLhJ/hDyQjIMOXqjv+YnL4aRBwacWLZg44bftGZyygXMiwKRiK
 CVFa4nLyDXrzHQuNWDEHUY=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
 by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wAnDC3Wj2xkMfafAQ--.65319S6;
 Tue, 23 May 2023 18:05:20 +0800 (CST)
From: qianfanguijin@163.com
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v5 04/11] hw: arm: allwinner-r40: Add i2c0 device
Date: Tue, 23 May 2023 18:05:01 +0800
Message-Id: <20230523100508.32564-5-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523100508.32564-1-qianfanguijin@163.com>
References: <20230523100508.32564-1-qianfanguijin@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAnDC3Wj2xkMfafAQ--.65319S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxAr4xXF13GF1xGF1kAw1DZFb_yoW5uF1DpF
 W5C398Gryjg3WrAFW8Kws3Zry8t348Grnrt3W0kFWxtF1jgF4v9r42qa15GF45KFZ7WF47
 XrZxtFW3W3W2qaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziec_PUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiQgN47VaEFabILwABsT
Received-SPF: pass client-ip=220.181.12.196;
 envelope-from=qianfanguijin@163.com; helo=m12.mail.163.com
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

From: qianfan Zhao <qianfanguijin@163.com>

TWI(i2c) is designed to be used as an interface between CPU host and the
serial 2-Wire bus. It can support all standard 2-Wire transfer, can be
operated in standard mode(100kbit/s) or fast-mode, supporting data rate
up to 400kbit/s.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
---
 hw/arm/allwinner-r40.c         | 11 ++++++++++-
 include/hw/arm/allwinner-r40.h |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 537a90b23d..4bc582630c 100644
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
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 959b5dc4e0..95366f4eee 100644
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
-- 
2.25.1


