Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8DCA17852
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Jan 2025 08:08:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8Kd-0007jG-CV; Tue, 21 Jan 2025 02:05:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8KK-0007Ys-5Z; Tue, 21 Jan 2025 02:05:32 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1ta8KI-0001eA-HK; Tue, 21 Jan 2025 02:05:31 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 21 Jan
 2025 15:04:29 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 21 Jan 2025 15:04:29 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 14/18] hw/arm/aspeed: Add SoC and Machine Support for
 AST2700 A1
Date: Tue, 21 Jan 2025 15:04:20 +0800
Message-ID: <20250121070424.2465942-15-jamin_lin@aspeedtech.com>
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

The memory map for AST2700 A1 remains compatible with AST2700 A0.
However, the IRQ mapping has been updated for AST2700 A1, with GIC interrupts
now ranging from 192 to 201. Add a new IRQ map table for AST2700 A1.

Introduce "aspeed_machine_ast2700_evb_class_init" to initialize the AST2700 EVB
machine. Add "aspeed_soc_ast2700_class_init" to initialize the AST2700 A1 SoC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed.c         | 24 +++++++++++++
 hw/arm/aspeed_ast27x0.c | 80 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 402d55c556..254fa5316d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1672,6 +1672,26 @@ static void aspeed_machine_ast2700a0_evb_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 1 * GiB;
     aspeed_machine_class_init_cpus_defaults(mc);
 }
+
+static void aspeed_machine_ast2700_evb_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
+
+    mc->desc = "Aspeed AST2700 EVB (Cortex-A35)";
+    amc->soc_name  = "ast2700-a1";
+    amc->hw_strap1 = AST2700_EVB_HW_STRAP1;
+    amc->hw_strap2 = AST2700_EVB_HW_STRAP2;
+    amc->fmc_model = "w25q01jvq";
+    amc->spi_model = "w25q512jv";
+    amc->num_cs    = 2;
+    amc->macs_mask = ASPEED_MAC0_ON | ASPEED_MAC1_ON | ASPEED_MAC2_ON;
+    amc->uart_default = ASPEED_DEV_UART12;
+    amc->i2c_init  = ast2700_evb_i2c_init;
+    mc->default_ram_size = 1 * GiB;
+    aspeed_machine_class_init_cpus_defaults(mc);
+}
+
 #endif
 
 static void aspeed_machine_qcom_dc_scm_v1_class_init(ObjectClass *oc,
@@ -1798,6 +1818,10 @@ static const TypeInfo aspeed_machine_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2700a0-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a0_evb_class_init,
+     }, {
+        .name          = MACHINE_TYPE_NAME("ast2700-evb"),
+        .parent        = TYPE_ASPEED_MACHINE,
+        .class_init    = aspeed_machine_ast2700_evb_class_init,
 #endif
     }, {
         .name          = TYPE_ASPEED_MACHINE,
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index b32c4fcc35..e0a29c9053 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -119,6 +119,52 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_SDHCI]     = 133,
 };
 
+static const int aspeed_soc_ast2700_irqmap[] = {
+    [ASPEED_DEV_UART0]     = 196,
+    [ASPEED_DEV_UART1]     = 196,
+    [ASPEED_DEV_UART2]     = 196,
+    [ASPEED_DEV_UART3]     = 196,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_UART5]     = 196,
+    [ASPEED_DEV_UART6]     = 196,
+    [ASPEED_DEV_UART7]     = 196,
+    [ASPEED_DEV_UART8]     = 196,
+    [ASPEED_DEV_UART9]     = 196,
+    [ASPEED_DEV_UART10]    = 196,
+    [ASPEED_DEV_UART11]    = 196,
+    [ASPEED_DEV_UART12]    = 196,
+    [ASPEED_DEV_FMC]       = 195,
+    [ASPEED_DEV_SDMC]      = 0,
+    [ASPEED_DEV_SCU]       = 12,
+    [ASPEED_DEV_ADC]       = 194,
+    [ASPEED_DEV_XDMA]      = 5,
+    [ASPEED_DEV_EMMC]      = 15,
+    [ASPEED_DEV_GPIO]      = 194,
+    [ASPEED_DEV_RTC]       = 13,
+    [ASPEED_DEV_TIMER1]    = 16,
+    [ASPEED_DEV_TIMER2]    = 17,
+    [ASPEED_DEV_TIMER3]    = 18,
+    [ASPEED_DEV_TIMER4]    = 19,
+    [ASPEED_DEV_TIMER5]    = 20,
+    [ASPEED_DEV_TIMER6]    = 21,
+    [ASPEED_DEV_TIMER7]    = 22,
+    [ASPEED_DEV_TIMER8]    = 23,
+    [ASPEED_DEV_WDT]       = 195,
+    [ASPEED_DEV_PWM]       = 195,
+    [ASPEED_DEV_LPC]       = 192,
+    [ASPEED_DEV_IBT]       = 192,
+    [ASPEED_DEV_I2C]       = 194,
+    [ASPEED_DEV_PECI]      = 197,
+    [ASPEED_DEV_ETH1]      = 196,
+    [ASPEED_DEV_ETH2]      = 196,
+    [ASPEED_DEV_ETH3]      = 196,
+    [ASPEED_DEV_HACE]      = 4,
+    [ASPEED_DEV_KCS]       = 192,
+    [ASPEED_DEV_DP]        = 28,
+    [ASPEED_DEV_I3C]       = 195,
+    [ASPEED_DEV_SDHCI]     = 197,
+};
+
 /* GICINT 128 */
 /* GICINT 192 */
 static const int ast2700_gic128_gic192_intcmap[] = {
@@ -822,6 +868,34 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, void *data)
     sc->get_irq      = aspeed_soc_ast2700_get_irq;
 }
 
+static void aspeed_soc_ast2700_class_init(ObjectClass *oc, void *data)
+{
+    static const char * const valid_cpu_types[] = {
+        ARM_CPU_TYPE_NAME("cortex-a35"),
+        NULL
+    };
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
+
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
+    dc->realize      = aspeed_soc_ast2700_realize;
+
+    sc->name         = "ast2700-a1";
+    sc->valid_cpu_types = valid_cpu_types;
+    sc->silicon_rev  = AST2700_A1_SILICON_REV;
+    sc->sram_size    = 0x20000;
+    sc->spis_num     = 3;
+    sc->wdts_num     = 8;
+    sc->macs_num     = 1;
+    sc->uarts_num    = 13;
+    sc->num_cpus     = 4;
+    sc->uarts_base   = ASPEED_DEV_UART0;
+    sc->irqmap       = aspeed_soc_ast2700_irqmap;
+    sc->memmap       = aspeed_soc_ast2700_memmap;
+    sc->get_irq      = aspeed_soc_ast2700_get_irq;
+}
+
 static const TypeInfo aspeed_soc_ast27x0_types[] = {
     {
         .name           = TYPE_ASPEED27X0_SOC,
@@ -834,6 +908,12 @@ static const TypeInfo aspeed_soc_ast27x0_types[] = {
         .instance_init  = aspeed_soc_ast2700_init,
         .class_init     = aspeed_soc_ast2700a0_class_init,
     },
+    {
+        .name           = "ast2700-a1",
+        .parent         = TYPE_ASPEED27X0_SOC,
+        .instance_init  = aspeed_soc_ast2700_init,
+        .class_init     = aspeed_soc_ast2700_class_init,
+    },
 };
 
 DEFINE_TYPES(aspeed_soc_ast27x0_types)
-- 
2.34.1


