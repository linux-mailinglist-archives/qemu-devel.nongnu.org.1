Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30442B0838A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 05:47:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFY3-0007ed-5c; Wed, 16 Jul 2025 23:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUr-0003Yo-Fu; Wed, 16 Jul 2025 23:41:31 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUo-0000YT-S4; Wed, 16 Jul 2025 23:41:24 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:58 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:58 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 09/21] hw/arm/ast27x0: Add SCU alias for TSP and ensure
 correct device realization order
Date: Thu, 17 Jul 2025 11:40:37 +0800
Message-ID: <20250717034054.1903991-10-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
References: <20250717034054.1903991-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

AST2700 has a single SCU hardware block, memory-mapped at 0x12C02000–0x12C03FFF
from the perspective of the main CA35 processor (PSP). The TSP coprocessor accesses
this same SCU block at a different address: 0x72C02000–0x72C03FFF.

To support this shared SCU model, this commit introduces "tsp.scu_mr_alias",
a "MemoryRegion" alias of the original SCU region ("s->scu.iomem"). The alias is
realized during TSP SoC setup and mapped into the TSP's SoC memory map.

Additionally, because the SCU must be realized before the TSP can create an alias
to it, the device realization order is explicitly managed:
"aspeed_soc_ast2700_tsp_realize()" is invoked after the SCU is initialized.

This ensures that PSP and TSP access a consistent SCU state, as expected by hardware.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast27x0-tsp.c | 9 ++-------
 hw/arm/aspeed_ast27x0.c     | 4 ++++
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 65a452123b..4152fbf495 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -150,6 +150,7 @@ struct Aspeed27x0TSPSoCState {
     UnimplementedDeviceState scuio;
     MemoryRegion memory;
     MemoryRegion sram_mr_alias;
+    MemoryRegion scu_mr_alias;
 
     ARMv7MState armv7m;
 };
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 8438aefee5..6b035e2612 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -135,9 +135,7 @@ static void aspeed_soc_ast27x0tsp_init(Object *obj)
     int i;
 
     object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
-    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
-    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev", sc->silicon_rev);
 
     for (i = 0; i < sc->uarts_num; i++) {
         object_initialize_child(obj, "uart[*]", &s->uart[i], TYPE_SERIAL_MM);
@@ -198,10 +196,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 &a->sram_mr_alias);
 
     /* SCU */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
-        return;
-    }
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->scu), 0, sc->memmap[ASPEED_DEV_SCU]);
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
+                                &a->scu_mr_alias);
 
     /* INTC */
     if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
@@ -273,7 +269,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
     dc->realize = aspeed_soc_ast27x0tsp_realize;
 
     sc->valid_cpu_types = valid_cpu_types;
-    sc->silicon_rev = AST2700_A1_SILICON_REV;
     sc->spis_num = 0;
     sc->ehcis_num = 0;
     sc->wdts_num = 0;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 04b8b340ba..2d27eb1deb 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -673,6 +673,10 @@ static bool aspeed_soc_ast2700_tsp_realize(DeviceState *dev, Error **errp)
     mr = &s->sram;
     memory_region_init_alias(&a->tsp.sram_mr_alias, OBJECT(s), "tsp.sram.alias",
                              mr, 0, memory_region_size(mr));
+
+    mr = &s->scu.iomem;
+    memory_region_init_alias(&a->tsp.scu_mr_alias, OBJECT(s), "tsp.scu.alias",
+                             mr, 0, memory_region_size(mr));
     if (!qdev_realize(DEVICE(&a->tsp), NULL, &error_abort)) {
         return false;
     }
-- 
2.43.0


