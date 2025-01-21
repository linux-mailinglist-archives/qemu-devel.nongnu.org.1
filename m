Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1B7A1784E
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Jan 2025 08:07:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8KM-0007Wq-B3; Tue, 21 Jan 2025 02:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8KF-0007GT-Av; Tue, 21 Jan 2025 02:05:27 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8KC-0001eA-RL; Tue, 21 Jan 2025 02:05:26 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:28 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:28 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 12/18] hw/arm/aspeed_ast27x0: Support two levels of INTC
 controllers for AST2700 A1
Date: Tue, 21 Jan 2025 15:04:18 +0800
Message-ID: <20250121070424.2465942-13-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

The design of INTC controllers has significantly changed in AST2700 A1.

There are a total of 480 interrupt sources in AST2700 A1. For interrupt numbers
from 0 to 127, they can route directly to PSP, SSP, and TSP. Due to the
limitation of interrupt numbers of processors, the interrupts are merged every
32 sources for interrupt numbers greater than 127.

There are two levels of interrupt controllers, INTC0 and INTC1. The interrupt
sources of INTC0 are the interrupt numbers from INTC_0 to INTC_127 and
interrupts from INTC1. The interrupt sources of INTC1 are the interrupt numbers
greater than INTC_127. INTC1 controls the interrupts INTC_128 to INTC_319 only.

Currently, only GIC 192 to 201 are supported, and their source interrupts are
from INTC1 and connected to INTC0 at input pin 0 and output pins 0 to 9 for
GIC 192-201.

To support both AST2700 A1 and A0, INTC0 input pins 1 to 9 and output pins
10 to 18 remain to support GIC 128-136, which source interrupts from INTC0.
These will be removed if we decide not to support AST2700 A0 in the future.

+---------------------------------------------------------------------------------------+
|                            AST2700 A1 Design                                          |
|                                                                                       |
|                     +--------------------------+                                      |
|                     |         INTC1            |        +---------------+             |
|                     |                          |        |  orgates[0]   |             |
|    orgates[0]+----> |inpin[0]+------->outpin[0]+------> | 0             |             |
|    orgates[1]|----> |inpin[1]|------->outpin[1]|------> | 1   0-31 bits +--+          |
|    orgates[2]|----> |inpin[2]|------->outpin[2]|------> | 2             |  |          |
|    orgates[3]|----> |inpin[3]|------->outpin[3]|------> | 3             |  |          |
|    orgates[4]|----> |inpin[4]|------->outpin[4]|------> | 4             |  |          |
|    orgates[5]+----> |inpin[5]+------->outpin[5]+------> | 5             |  |          |
|                     |                          |        |---------------|  |          |
|                     +--------------------------+                           |          |
|    +-----------------------------------------------------------------------|          |
|    |                                                                                  |
|    |                                                                                  |
|    |                +------------------------------+           +-----------------+    |
|    |                |            INTC0             |           |     GIC         |    |
|    |                |inpin[0:0]--------->outpin[0] +---------> |192              |    |
|    |                |inpin[0:1]|-------->outpin[1] |---------> |193              |    |
|    |                |inpin[0:2]|-------->outpin[2] |---------> |194              |    |
|    |                |inpin[0:3]|-------->outpin[3] |---------> |195              |    |
|    >--------------> |inpin[0:4]|-------->outpin[4] |---------> |196              |    |
|                     |inpin[0:5]|-------->outpin[5] |---------> |197              |    |
|                     |inpin[0:6]|-------->outpin[6] |---------> |198              |    |
|                     |inpin[0:7]|-------->outpin[7] |---------> |199              |    |
|                     |inpin[0:8]|-------->outpin[8] |---------> |200              |    |
|                     |inpin[0:9]|-------->outpin[9] |---------> |201              |    |
+---------------------------------------------------------------------------------------+
+---------------------------------------------------------------------------------------+
|   orgates[1]|-----> |inpin[1]|---------->outpin[10]|---------> |128              |    |
|   orgates[2]|-----> |inpin[2]|---------->outpin[11]|---------> |129              |    |
|   orgates[3]|-----> |inpin[3]|---------->outpin[12]|---------> |130              |    |
|   orgates[4]|-----> |inpin[4]|---------->outpin[13]|---------> |131              |    |
|   orgates[5]|-----> |inpin[5]|---------->outpin[14]|---------> |132              |    |
|   orgates[6]|-----> |inpin[6]|---------->outpin[15]|---------> |133              |    |
|   orgates[7]|-----> |inpin[7]|---------->outpin[16]|---------> |134              |    |
|   orgates[8]|-----> |inpin[8]|---------->outpin[17]|---------> |135              |    |
|   orgates[9]+-----> |inpin[9]|---------->outpin[18]+---------> |136              |    |
|                     +------------------------------+           +-----------------+    |
|                                                                                       |
|                     AST2700 A0 Design                                                 |
|                                                                                       |
+---------------------------------------------------------------------------------------+

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c     | 126 +++++++++++++++++++++++++-----------
 include/hw/arm/aspeed_soc.h |   3 +-
 2 files changed, 92 insertions(+), 37 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d5e521cd38..a95fed30cf 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -67,6 +67,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_RTC]       =  0x12C0F000,
     [ASPEED_DEV_SDHCI]     =  0x14080000,
     [ASPEED_DEV_TIMER1]    =  0x12C10000,
+    [ASPEED_DEV_INTC1]     =  0x14C18000,
 };
 
 #define AST2700_MAX_IRQ 256
@@ -119,21 +120,27 @@ static const int aspeed_soc_ast2700_irqmap[] = {
 };
 
 /* GICINT 128 */
-static const int aspeed_soc_ast2700_gic128_intcmap[] = {
+/* GICINT 192 */
+static const int ast2700_gic128_gic192_intcmap[] = {
     [ASPEED_DEV_LPC]       = 0,
     [ASPEED_DEV_IBT]       = 2,
     [ASPEED_DEV_KCS]       = 4,
 };
 
+/* GICINT 129 */
+/* GICINT 193 */
+
 /* GICINT 130 */
-static const int aspeed_soc_ast2700_gic130_intcmap[] = {
+/* GICINT 194 */
+static const int ast2700_gic130_gic194_intcmap[] = {
     [ASPEED_DEV_I2C]        = 0,
     [ASPEED_DEV_ADC]        = 16,
     [ASPEED_DEV_GPIO]       = 18,
 };
 
 /* GICINT 131 */
-static const int aspeed_soc_ast2700_gic131_intcmap[] = {
+/* GICINT 195 */
+static const int ast2700_gic131_gic195_intcmap[] = {
     [ASPEED_DEV_I3C]       = 0,
     [ASPEED_DEV_WDT]       = 16,
     [ASPEED_DEV_FMC]       = 25,
@@ -141,7 +148,8 @@ static const int aspeed_soc_ast2700_gic131_intcmap[] = {
 };
 
 /* GICINT 132 */
-static const int aspeed_soc_ast2700_gic132_intcmap[] = {
+/* GICINT 196 */
+static const int ast2700_gic132_gic196_intcmap[] = {
     [ASPEED_DEV_ETH1]      = 0,
     [ASPEED_DEV_ETH2]      = 1,
     [ASPEED_DEV_ETH3]      = 2,
@@ -160,40 +168,58 @@ static const int aspeed_soc_ast2700_gic132_intcmap[] = {
 };
 
 /* GICINT 133 */
-static const int aspeed_soc_ast2700_gic133_intcmap[] = {
+/* GICINT 197 */
+static const int ast2700_gic133_gic197_intcmap[] = {
     [ASPEED_DEV_SDHCI]     = 1,
     [ASPEED_DEV_PECI]      = 4,
 };
 
 /* GICINT 128 ~ 136 */
+/* GICINT 192 ~ 201 */
 struct gic_intc_irq_info {
     int irq;
+    int intc_idx;
+    int orgate_idx;
     const int *ptr;
 };
 
-static const struct gic_intc_irq_info aspeed_soc_ast2700_gic_intcmap[] = {
-    {128,  aspeed_soc_ast2700_gic128_intcmap},
-    {129,  NULL},
-    {130,  aspeed_soc_ast2700_gic130_intcmap},
-    {131,  aspeed_soc_ast2700_gic131_intcmap},
-    {132,  aspeed_soc_ast2700_gic132_intcmap},
-    {133,  aspeed_soc_ast2700_gic133_intcmap},
-    {134,  NULL},
-    {135,  NULL},
-    {136,  NULL},
+static struct gic_intc_irq_info ast2700_gic_intcmap[] = {
+    {192, 1, 0, ast2700_gic128_gic192_intcmap},
+    {193, 1, 1, NULL},
+    {194, 1, 2, ast2700_gic130_gic194_intcmap},
+    {195, 1, 3, ast2700_gic131_gic195_intcmap},
+    {196, 1, 4, ast2700_gic132_gic196_intcmap},
+    {197, 1, 5, ast2700_gic133_gic197_intcmap},
+    {198, 1, 6, NULL},
+    {199, 1, 7, NULL},
+    {200, 1, 8, NULL},
+    {201, 1, 9, NULL},
+    {128, 0, 1, ast2700_gic128_gic192_intcmap},
+    {129, 0, 2, NULL},
+    {130, 0, 3, ast2700_gic130_gic194_intcmap},
+    {131, 0, 4, ast2700_gic131_gic195_intcmap},
+    {132, 0, 5, ast2700_gic132_gic196_intcmap},
+    {133, 0, 6, ast2700_gic133_gic197_intcmap},
+    {134, 0, 7, NULL},
+    {135, 0, 8, NULL},
+    {136, 0, 9, NULL},
 };
 
 static qemu_irq aspeed_soc_ast2700_get_irq(AspeedSoCState *s, int dev)
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
-        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
-            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev]);
+    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
+            assert(ast2700_gic_intcmap[i].ptr);
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_gic_intcmap[i].ptr[dev]);
         }
     }
 
@@ -205,13 +231,17 @@ static qemu_irq aspeed_soc_ast2700_get_irq_index(AspeedSoCState *s, int dev,
 {
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int or_idx;
+    int idx;
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(aspeed_soc_ast2700_gic_intcmap); i++) {
-        if (sc->irqmap[dev] == aspeed_soc_ast2700_gic_intcmap[i].irq) {
-            assert(aspeed_soc_ast2700_gic_intcmap[i].ptr);
-            return qdev_get_gpio_in(DEVICE(&a->intc.orgates[i]),
-                aspeed_soc_ast2700_gic_intcmap[i].ptr[dev] + index);
+    for (i = 0; i < ARRAY_SIZE(ast2700_gic_intcmap); i++) {
+        if (sc->irqmap[dev] == ast2700_gic_intcmap[i].irq) {
+            assert(ast2700_gic_intcmap[i].ptr);
+            or_idx = ast2700_gic_intcmap[i].orgate_idx;
+            idx = ast2700_gic_intcmap[i].intc_idx;
+            return qdev_get_gpio_in(DEVICE(&a->intc[idx].orgates[or_idx]),
+                                    ast2700_gic_intcmap[i].ptr[dev] + index);
         }
     }
 
@@ -372,7 +402,8 @@ static void aspeed_soc_ast2700_init(Object *obj)
 
     object_initialize_child(obj, "sli", &s->sli, TYPE_ASPEED_2700_SLI);
     object_initialize_child(obj, "sliio", &s->sliio, TYPE_ASPEED_2700_SLIIO);
-    object_initialize_child(obj, "intc", &a->intc, TYPE_ASPEED_2700_INTC0);
+    object_initialize_child(obj, "intc0", &a->intc[0], TYPE_ASPEED_2700_INTC0);
+    object_initialize_child(obj, "intc1", &a->intc[1], TYPE_ASPEED_2700_INTC1);
 
     snprintf(typename, sizeof(typename), "aspeed.adc-%s", socname);
     object_initialize_child(obj, "adc", &s->adc, typename);
@@ -481,7 +512,6 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
     Aspeed27x0SoCState *a = ASPEED27X0_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    AspeedINTCClass *ic = ASPEED_INTC_GET_CLASS(&a->intc);
     g_autofree char *sram_name = NULL;
     qemu_irq irq;
 
@@ -511,21 +541,45 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    /* INTC */
-    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc), errp)) {
+    /* INTC0 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
         return;
     }
 
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc), 0,
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[0]), 0,
                     sc->memmap[ASPEED_DEV_INTC0]);
 
-    /* GICINT orgates -> INTC -> GIC */
-    for (i = 0; i < ic->num_inpins; i++) {
-        qdev_connect_gpio_out(DEVICE(&a->intc.orgates[i]), 0,
-                                qdev_get_gpio_in(DEVICE(&a->intc), i));
-        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc), i,
+    /* INTC1 */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[1]), errp)) {
+        return;
+    }
+
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->intc[1]), 0,
+                    sc->memmap[ASPEED_DEV_INTC1]);
+
+    /* irq source orgates -> INTC0 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[0].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[0]), i));
+    }
+    /* INTC0 -> GIC192 - GIC201 */
+    /* INTC0 -> GIC128 - GIC136 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[0])->num_outpins; i++) {
+        assert(i < ARRAY_SIZE(ast2700_gic_intcmap));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[0]), i,
                            qdev_get_gpio_in(DEVICE(&a->gic),
-                                aspeed_soc_ast2700_gic_intcmap[i].irq));
+                                            ast2700_gic_intcmap[i].irq));
+    }
+
+    /* irq source orgates -> INTC1 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_inpins; i++) {
+        qdev_connect_gpio_out(DEVICE(&a->intc[1].orgates[i]), 0,
+                              qdev_get_gpio_in(DEVICE(&a->intc[1]), i));
+    }
+    /* INTC1 -> INTC0 */
+    for (i = 0; i < ASPEED_INTC_GET_CLASS(&a->intc[1])->num_outpins; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&a->intc[1]), i,
+                        qdev_get_gpio_in(DEVICE(&a->intc[0].orgates[0]), i));
     }
 
     /* SRAM */
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 51e585e3e4..c079225775 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -128,7 +128,7 @@ struct Aspeed27x0SoCState {
     AspeedSoCState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    AspeedINTCState intc;
+    AspeedINTCState intc[2];
     GICv3State gic;
     MemoryRegion dram_empty;
 };
@@ -195,6 +195,7 @@ enum {
     ASPEED_DEV_EHCI2,
     ASPEED_DEV_VIC,
     ASPEED_DEV_INTC0,
+    ASPEED_DEV_INTC1,
     ASPEED_DEV_SDMC,
     ASPEED_DEV_SCU,
     ASPEED_DEV_ADC,
-- 
2.34.1


