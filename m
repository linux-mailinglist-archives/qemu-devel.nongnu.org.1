Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8FA934854
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jul 2024 08:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUKyZ-0006DR-Ax; Thu, 18 Jul 2024 02:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUKyE-0005Zk-Vi; Thu, 18 Jul 2024 02:50:30 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sUKyC-0004L5-Pt; Thu, 18 Jul 2024 02:50:30 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 18 Jul
 2024 14:50:16 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 18 Jul 2024 14:50:16 +0800
To: Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@kaod.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:STM32F205" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 05/15] hw/i2c/aspeed: rename the I2C class pool attribute
 to share_pool
Date: Thu, 18 Jul 2024 14:49:15 +0800
Message-ID: <20240718064925.1846074-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
References: <20240718064925.1846074-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the datasheet of ASPEED SOCs,
each I2C bus has their own pool buffer since AST2500.

Only AST2400 utilized a pool buffer share to all I2C bus.
And firmware required to set the offset of pool buffer
by writing "Function Control Register(I2CD 00)"

To make this model more readable, will change to introduce
a new bus pool buffer attribute in AspeedI2Cbus.
So, it does not need to calculate the pool buffer offset
for different I2C bus.

This patch rename the I2C class pool attribute to share_pool.
It make user more understand share pool and bus pool
are different.

Incrementing the version of aspeed_i2c_vmstate to 3.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/i2c/aspeed_i2c.c         | 39 ++++++++++++++++++++-----------------
 include/hw/i2c/aspeed_i2c.h |  4 ++--
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 462ad78a13..9c222a02fe 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -906,7 +906,7 @@ static const MemoryRegionOps aspeed_i2c_ctrl_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
+static uint64_t aspeed_i2c_share_pool_read(void *opaque, hwaddr offset,
                                      unsigned size)
 {
     AspeedI2CState *s = opaque;
@@ -914,26 +914,26 @@ static uint64_t aspeed_i2c_pool_read(void *opaque, hwaddr offset,
     int i;
 
     for (i = 0; i < size; i++) {
-        ret |= (uint64_t) s->pool[offset + i] << (8 * i);
+        ret |= (uint64_t) s->share_pool[offset + i] << (8 * i);
     }
 
     return ret;
 }
 
-static void aspeed_i2c_pool_write(void *opaque, hwaddr offset,
+static void aspeed_i2c_share_pool_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
     AspeedI2CState *s = opaque;
     int i;
 
     for (i = 0; i < size; i++) {
-        s->pool[offset + i] = (value >> (8 * i)) & 0xFF;
+        s->share_pool[offset + i] = (value >> (8 * i)) & 0xFF;
     }
 }
 
-static const MemoryRegionOps aspeed_i2c_pool_ops = {
-    .read = aspeed_i2c_pool_read,
-    .write = aspeed_i2c_pool_write,
+static const MemoryRegionOps aspeed_i2c_share_pool_ops = {
+    .read = aspeed_i2c_share_pool_read,
+    .write = aspeed_i2c_share_pool_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
         .min_access_size = 1,
@@ -953,14 +953,15 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
 
 static const VMStateDescription aspeed_i2c_vmstate = {
     .name = TYPE_ASPEED_I2C,
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intr_status, AspeedI2CState),
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
                              ASPEED_I2C_NR_BUSSES, 1, aspeed_i2c_bus_vmstate,
                              AspeedI2CBus),
-        VMSTATE_UINT8_ARRAY(pool, AspeedI2CState, ASPEED_I2C_MAX_POOL_SIZE),
+        VMSTATE_UINT8_ARRAY(share_pool, AspeedI2CState,
+                            ASPEED_I2C_SHARE_POOL_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -995,7 +996,7 @@ static void aspeed_i2c_instance_init(Object *obj)
  *   0x140 ... 0x17F: Device 5
  *   0x180 ... 0x1BF: Device 6
  *   0x1C0 ... 0x1FF: Device 7
- *   0x200 ... 0x2FF: Buffer Pool  (unused in linux driver)
+ *   0x200 ... 0x2FF: Buffer Pool (AST2500 unused in linux driver)
  *   0x300 ... 0x33F: Device 8
  *   0x340 ... 0x37F: Device 9
  *   0x380 ... 0x3BF: Device 10
@@ -1003,7 +1004,7 @@ static void aspeed_i2c_instance_init(Object *obj)
  *   0x400 ... 0x43F: Device 12
  *   0x440 ... 0x47F: Device 13
  *   0x480 ... 0x4BF: Device 14
- *   0x800 ... 0xFFF: Buffer Pool  (unused in linux driver)
+ *   0x800 ... 0xFFF: Buffer Pool (AST2400 unused in linux driver)
  */
 static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
 {
@@ -1038,8 +1039,9 @@ static void aspeed_i2c_realize(DeviceState *dev, Error **errp)
                                     &s->busses[i].mr);
     }
 
-    memory_region_init_io(&s->pool_iomem, OBJECT(s), &aspeed_i2c_pool_ops, s,
-                          "aspeed.i2c-pool", aic->pool_size);
+    memory_region_init_io(&s->pool_iomem, OBJECT(s),
+                          &aspeed_i2c_share_pool_ops, s,
+                          "aspeed.i2c-share-pool", aic->pool_size);
     memory_region_add_subregion(&s->iomem, aic->pool_base, &s->pool_iomem);
 
     if (aic->has_dma) {
@@ -1267,8 +1269,9 @@ static qemu_irq aspeed_2400_i2c_bus_get_irq(AspeedI2CBus *bus)
 static uint8_t *aspeed_2400_i2c_bus_pool_base(AspeedI2CBus *bus)
 {
     uint8_t *pool_page =
-        &bus->controller->pool[ARRAY_FIELD_EX32(bus->regs, I2CD_FUN_CTRL,
-                                                POOL_PAGE_SEL) * 0x100];
+        &bus->controller->share_pool[ARRAY_FIELD_EX32(bus->regs,
+                                                      I2CD_FUN_CTRL,
+                                                      POOL_PAGE_SEL) * 0x100];
 
     return &pool_page[ARRAY_FIELD_EX32(bus->regs, I2CD_POOL_CTRL, OFFSET)];
 }
@@ -1303,7 +1306,7 @@ static qemu_irq aspeed_2500_i2c_bus_get_irq(AspeedI2CBus *bus)
 
 static uint8_t *aspeed_2500_i2c_bus_pool_base(AspeedI2CBus *bus)
 {
-    return &bus->controller->pool[bus->id * 0x10];
+    return &bus->controller->share_pool[bus->id * 0x10];
 }
 
 static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
@@ -1338,7 +1341,7 @@ static qemu_irq aspeed_2600_i2c_bus_get_irq(AspeedI2CBus *bus)
 
 static uint8_t *aspeed_2600_i2c_bus_pool_base(AspeedI2CBus *bus)
 {
-   return &bus->controller->pool[bus->id * 0x20];
+   return &bus->controller->share_pool[bus->id * 0x20];
 }
 
 static void aspeed_2600_i2c_class_init(ObjectClass *klass, void *data)
diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 422ee0e298..02ede85906 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -34,7 +34,7 @@
 OBJECT_DECLARE_TYPE(AspeedI2CState, AspeedI2CClass, ASPEED_I2C)
 
 #define ASPEED_I2C_NR_BUSSES 16
-#define ASPEED_I2C_MAX_POOL_SIZE 0x800
+#define ASPEED_I2C_SHARE_POOL_SIZE 0x800
 #define ASPEED_I2C_OLD_NUM_REG 11
 #define ASPEED_I2C_NEW_NUM_REG 22
 
@@ -257,7 +257,7 @@ struct AspeedI2CState {
     uint32_t ctrl_global;
     uint32_t new_clk_divider;
     MemoryRegion pool_iomem;
-    uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
+    uint8_t share_pool[ASPEED_I2C_SHARE_POOL_SIZE];
 
     AspeedI2CBus busses[ASPEED_I2C_NR_BUSSES];
     MemoryRegion *dram_mr;
-- 
2.34.1


