Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9317BDCB67
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 08:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8uur-00016p-6y; Wed, 15 Oct 2025 02:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uud-0000yt-Oh; Wed, 15 Oct 2025 02:23:04 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8uuY-0002xW-Km; Wed, 15 Oct 2025 02:23:03 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 15 Oct
 2025 14:22:12 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 15 Oct 2025 14:22:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 04/12] hw/arm/ast27x0: Add SRAM link and alias mapping for
 TSP coprocessor
Date: Wed, 15 Oct 2025 14:21:59 +0800
Message-ID: <20251015062210.3128710-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
References: <20251015062210.3128710-1-jamin_lin@aspeedtech.com>
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

AST2700 has a 128KB SRAM, physically mapped at 0x10000000–0x1001FFFF for
the PSP (CA35) processor. The TSP coprocessor shares this same SRAM but
accesses it through a different address window at 0x70000000–0x7001FFFF.

To model this shared-memory behavior in QEMU, this commit introduces a
linked SRAM property and alias mapping between the PSP and TSP subsystems.

Changes include:
- Add the SRAM alias mapping at 0x70000000 in aspeed_ast27x0-tsp.c.
- In aspeed_ast27x0-fc.c, connect the TSP coprocessor’s "sram" link to
  the PSP’s SRAM region.
- Ensure the alias region is initialized during TSP SoC realization so
  the TSP can correctly access shared SRAM through its own address space.

This ensures that the TSP and PSP share the same physical SRAM backing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 4 ++++
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 25e668a648..dfac7d1e17 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -150,6 +150,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     AspeedCoprocessorState *soc;
     AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
+    AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
+
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
 
@@ -166,6 +168,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
                             sc->uarts_num, serial_hd(2));
+    object_property_set_link(OBJECT(&s->tsp), "sram",
+                             OBJECT(&psp->sram), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index caeb3392a8..56b68adf54 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -20,6 +20,7 @@
 
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
+    [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -195,6 +196,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->sdram);
 
+    /* SRAM */
+    memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",
+                             s->sram, 0, memory_region_size(s->sram));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram_alias);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
-- 
2.43.0


