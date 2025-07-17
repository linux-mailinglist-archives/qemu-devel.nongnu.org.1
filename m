Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFC4B08382
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 05:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFWf-0004hY-Vn; Wed, 16 Jul 2025 23:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUj-0003WO-JQ; Wed, 16 Jul 2025 23:41:18 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUh-0000YT-Uu; Wed, 16 Jul 2025 23:41:17 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:56 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:56 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 05/21] hw/arm/aspeed_ast27x0-tsp: Switch TSP memory to
 SDRAM and use dram_container for remap support
Date: Thu, 17 Jul 2025 11:40:33 +0800
Message-ID: <20250717034054.1903991-6-jamin_lin@aspeedtech.com>
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

According to the AST2700 design, the TSP coprocessor uses its own SDRAM
instead of SRAM. Additionally, all three coprocessors—SSP, TSP, and PSP—share
a common SRAM block. In the previous implementation, the TSP memory region
was labeled and sized as "SRAM", but in practice it was being used as TSP's
local SDRAM.

This commit updates the TSP memory mapping to reflect the correct hardware
design:

- Replace the SRAM region with a 512MB SDRAM region starting at 0x0.
- Rename the internal variable from `sram` to `dram_container` for clarity.
- Use "AST2700_TSP_SDRAM_SIZE" (512MB) instead of the previous 32MB SRAM size.
- Map the new region using "ASPEED_DEV_SDRAM" instead of "ASPEED_DEV_SRAM".

This change also prepares for future enhancements where PSP DRAM will be
remapped into this TSP SDRAM container using subregions at specific offsets.
Using "dram_container" makes it easier to manage aliases and remap logic.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-tsp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 4e0efaef07..a70e30fc16 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -15,10 +15,10 @@
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 
-#define AST2700_TSP_RAM_SIZE (32 * MiB)
+#define AST2700_TSP_SDRAM_SIZE (512 * MiB)
 
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
-    [ASPEED_DEV_SRAM]      =  0x00000000,
+    [ASPEED_DEV_SDRAM]     =  0x00000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -163,7 +163,7 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
     AspeedSoCState *s = ASPEED_SOC(dev_soc);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     DeviceState *armv7m;
-    g_autofree char *sram_name = NULL;
+    g_autofree char *name = NULL;
     int i;
 
     if (!clock_has_source(s->sysclk)) {
@@ -180,16 +180,17 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                              OBJECT(s->memory), &error_abort);
     sysbus_realize(SYS_BUS_DEVICE(&a->armv7m), &error_abort);
 
-    sram_name = g_strdup_printf("aspeed.dram.%d",
-                                CPU(a->armv7m.cpu)->cpu_index);
+    /* SDRAM */
+    name = g_strdup_printf("aspeed.sdram-container.%d",
+                           CPU(a->armv7m.cpu)->cpu_index);
 
-    if (!memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size,
-                                errp)) {
+    if (!memory_region_init_ram(&s->dram_container, OBJECT(s), name,
+                                AST2700_TSP_SDRAM_SIZE, errp)) {
         return;
     }
     memory_region_add_subregion(s->memory,
-                                sc->memmap[ASPEED_DEV_SRAM],
-                                &s->sram);
+                                sc->memmap[ASPEED_DEV_SDRAM],
+                                &s->dram_container);
 
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
@@ -268,7 +269,6 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *dat
 
     sc->valid_cpu_types = valid_cpu_types;
     sc->silicon_rev = AST2700_A1_SILICON_REV;
-    sc->sram_size = AST2700_TSP_RAM_SIZE;
     sc->spis_num = 0;
     sc->ehcis_num = 0;
     sc->wdts_num = 0;
-- 
2.43.0


