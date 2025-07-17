Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7581FB08388
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Jul 2025 05:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucFXr-0006i3-Se; Wed, 16 Jul 2025 23:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUm-0003XO-ST; Wed, 16 Jul 2025 23:41:25 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ucFUl-0000YT-AB; Wed, 16 Jul 2025 23:41:20 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 17 Jul
 2025 11:40:57 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 17 Jul 2025 11:40:57 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 07/21] hw/arm/ast27x0: Add SRAM alias for TSP and ensure
 correct device realization order
Date: Thu, 17 Jul 2025 11:40:35 +0800
Message-ID: <20250717034054.1903991-8-jamin_lin@aspeedtech.com>
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

AST2700 has a 128KB SRAM, physically mapped at 0x10000000–0x1001FFFF for the
main CA35 processor. The TSP coprocessor accesses this same memory at a
different memory address: 0x70000000–0x7001FFFF.

To support this shared memory model, this commit introduces "tsp.sram_mr_alias",
a "MemoryRegion" alias of the original SRAM region ("s->sram"). The alias is
realized during TSP SoC setup and mapped into the TSP's SoC memory map.

Additionally, because the SRAM must be realized before the TSP can create an
alias to it, the device realization order is explicitly managed:
"aspeed_soc_ast2700_tsp_realize()" is invoked after SRAM is initialized.

This ensures that TSP’s access to shared SRAM functions correctly.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_soc.h | 1 +
 hw/arm/aspeed_ast27x0-tsp.c | 5 +++++
 hw/arm/aspeed_ast27x0.c     | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 9b935b9bca..1e4f8580b1 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -148,6 +148,7 @@ struct Aspeed27x0TSPSoCState {
     UnimplementedDeviceState ipc[2];
     UnimplementedDeviceState scuio;
     MemoryRegion memory;
+    MemoryRegion sram_mr_alias;
 
     ARMv7MState armv7m;
 };
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index a70e30fc16..8438aefee5 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -19,6 +19,7 @@
 
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
+    [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -192,6 +193,10 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->dram_container);
 
+    /* SRAM */
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+                                &a->sram_mr_alias);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 9064249bed..8272a28ad5 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -652,6 +652,7 @@ static bool aspeed_soc_ast2700_tsp_realize(DeviceState *dev, Error **errp)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
+    MemoryRegion *mr;
     Clock *sysclk;
 
     sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
@@ -665,6 +666,9 @@ static bool aspeed_soc_ast2700_tsp_realize(DeviceState *dev, Error **errp)
         return false;
     }
 
+    mr = &s->sram;
+    memory_region_init_alias(&a->tsp.sram_mr_alias, OBJECT(s), "tsp.sram.alias",
+                             mr, 0, memory_region_size(mr));
     if (!qdev_realize(DEVICE(&a->tsp), NULL, &error_abort)) {
         return false;
     }
-- 
2.43.0


