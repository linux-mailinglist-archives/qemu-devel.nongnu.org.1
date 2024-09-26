Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB04986E00
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Sep 2024 09:47:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stjCi-0002hS-91; Thu, 26 Sep 2024 03:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stjCf-0002Zf-F6; Thu, 26 Sep 2024 03:46:21 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1stjCa-0006Ef-GJ; Thu, 26 Sep 2024 03:46:21 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 26 Sep
 2024 15:45:38 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 26 Sep 2024 15:45:38 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 6/6] aspeed/soc: Support GPIO for AST2700
Date: Thu, 26 Sep 2024 15:45:35 +0800
Message-ID: <20240926074535.1286209-7-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
References: <20240926074535.1286209-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add GPIO model for AST2700 GPIO support.
The GPIO controller registers base address is start at
0x14C0_B000 and its address space is 0x1000.

The AST2700 GPIO controller interrupt is connected to
GICINT130_INTC at bit 18.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 761ee11657..dca660eb6b 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -62,6 +62,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_GIC_REDIST]    =  0x12280000,
     [ASPEED_DEV_ADC]       =  0x14C00000,
     [ASPEED_DEV_I2C]       =  0x14C0F000,
+    [ASPEED_DEV_GPIO]      =  0x14C0B000,
 };
 
 #define AST2700_MAX_IRQ 288
@@ -87,8 +88,7 @@ static const int aspeed_soc_ast2700_irqmap[] = {
     [ASPEED_DEV_ADC]       = 130,
     [ASPEED_DEV_XDMA]      = 5,
     [ASPEED_DEV_EMMC]      = 15,
-    [ASPEED_DEV_GPIO]      = 11,
-    [ASPEED_DEV_GPIO_1_8V] = 130,
+    [ASPEED_DEV_GPIO]      = 130,
     [ASPEED_DEV_RTC]       = 13,
     [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_TIMER2]    = 17,
@@ -124,7 +124,7 @@ static const int aspeed_soc_ast2700_gic128_intcmap[] = {
 static const int aspeed_soc_ast2700_gic130_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
-    [ASPEED_DEV_GPIO_1_8V]  = 18,
+    [ASPEED_DEV_GPIO]       = 18,
 };
 
 /* GICINT 131 */
@@ -373,6 +373,9 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     snprintf(typename, sizeof(typename), "aspeed.i2c-%s", socname);
     object_initialize_child(obj, "i2c", &s->i2c, typename);
+
+    snprintf(typename, sizeof(typename), "aspeed.gpio-%s", socname);
+    object_initialize_child(obj, "gpio", &s->gpio, typename);
 }
 
 /*
@@ -658,6 +661,15 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
     }
 
+    /* GPIO */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
+        return;
+    }
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->gpio), 0,
+                    sc->memmap[ASPEED_DEV_GPIO]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gpio), 0,
+                       aspeed_soc_get_irq(s, ASPEED_DEV_GPIO));
+
     create_unimplemented_device("ast2700.dpmcu", 0x11000000, 0x40000);
     create_unimplemented_device("ast2700.iomem0", 0x12000000, 0x01000000);
     create_unimplemented_device("ast2700.iomem1", 0x14000000, 0x01000000);
-- 
2.34.1


