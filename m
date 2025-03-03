Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11588A4BB8D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Mar 2025 11:00:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Y1-0003Y8-2I; Mon, 03 Mar 2025 04:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2W1-0007qz-Ni; Mon, 03 Mar 2025 04:55:13 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp2Vz-0001gH-Ao; Mon, 03 Mar 2025 04:55:13 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 3 Mar
 2025 17:54:59 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 3 Mar 2025 17:54:59 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 03/23] hw/intc/aspeed: Reduce regs array size by adding a
 register sub-region
Date: Mon, 3 Mar 2025 17:54:31 +0800
Message-ID: <20250303095457.2337631-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
References: <20250303095457.2337631-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

Currently, the size of the "regs" array is 0x2000, which is too large. So far,
it only uses "GICINT128 to `GICINT134", and the offsets from 0 to 0x1000 are
unused. To save code size and avoid mapping large unused gaps, update to only
map the useful set of registers:

INTC register [0x1000 – 0x1804]

Update "reg_size" to 0x808. Introduce a new class attribute "reg_offset" to set
the start offset of a "INTC" sub-region. Set the "reg_offset" to 0x1000 for INTC
registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/intc/aspeed_intc.h |  3 ++-
 hw/intc/aspeed_intc.c         | 50 ++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index ecaeb15aea..18ca405336 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,7 +16,7 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_REGS (0x2000 >> 2)
+#define ASPEED_INTC_NR_REGS (0x808 >> 2)
 #define ASPEED_INTC_NR_INTS 9
 
 struct AspeedINTCState {
@@ -43,6 +43,7 @@ struct AspeedINTCClass {
     uint32_t num_ints;
     uint64_t mem_size;
     uint64_t reg_size;
+    uint64_t reg_offset;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 316885a27a..0f630ffab7 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -14,25 +14,31 @@
 #include "hw/registerfields.h"
 #include "qapi/error.h"
 
-/* INTC Registers */
-REG32(GICINT128_EN,         0x1000)
-REG32(GICINT128_STATUS,     0x1004)
-REG32(GICINT129_EN,         0x1100)
-REG32(GICINT129_STATUS,     0x1104)
-REG32(GICINT130_EN,         0x1200)
-REG32(GICINT130_STATUS,     0x1204)
-REG32(GICINT131_EN,         0x1300)
-REG32(GICINT131_STATUS,     0x1304)
-REG32(GICINT132_EN,         0x1400)
-REG32(GICINT132_STATUS,     0x1404)
-REG32(GICINT133_EN,         0x1500)
-REG32(GICINT133_STATUS,     0x1504)
-REG32(GICINT134_EN,         0x1600)
-REG32(GICINT134_STATUS,     0x1604)
-REG32(GICINT135_EN,         0x1700)
-REG32(GICINT135_STATUS,     0x1704)
-REG32(GICINT136_EN,         0x1800)
-REG32(GICINT136_STATUS,     0x1804)
+/*
+ * INTC Registers
+ *
+ * values below are offset by - 0x1000 from datasheet
+ * because its memory region is start at 0x1000
+ *
+ */
+REG32(GICINT128_EN,         0x000)
+REG32(GICINT128_STATUS,     0x004)
+REG32(GICINT129_EN,         0x100)
+REG32(GICINT129_STATUS,     0x104)
+REG32(GICINT130_EN,         0x200)
+REG32(GICINT130_STATUS,     0x204)
+REG32(GICINT131_EN,         0x300)
+REG32(GICINT131_STATUS,     0x304)
+REG32(GICINT132_EN,         0x400)
+REG32(GICINT132_STATUS,     0x404)
+REG32(GICINT133_EN,         0x500)
+REG32(GICINT133_STATUS,     0x504)
+REG32(GICINT134_EN,         0x600)
+REG32(GICINT134_STATUS,     0x604)
+REG32(GICINT135_EN,         0x700)
+REG32(GICINT135_STATUS,     0x704)
+REG32(GICINT136_EN,         0x800)
+REG32(GICINT136_STATUS,     0x804)
 
 #define GICINT_STATUS_BASE     R_GICINT128_STATUS
 
@@ -311,7 +317,8 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
                           TYPE_ASPEED_INTC ".regs", aic->reg_size);
 
-    memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
+    memory_region_add_subregion(&s->iomem_container, aic->reg_offset,
+                                &s->iomem);
 
     qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
 
@@ -352,7 +359,8 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->num_lines = 32;
     aic->num_ints = 9;
     aic->mem_size = 0x4000;
-    aic->reg_size = 0x2000;
+    aic->reg_size = 0x808;
+    aic->reg_offset = 0x1000;
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.34.1


