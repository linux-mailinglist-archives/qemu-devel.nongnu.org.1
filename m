Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78737A2A535
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 10:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyZY-00023L-Tk; Thu, 06 Feb 2025 04:53:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfyZR-000201-PT; Thu, 06 Feb 2025 04:53:18 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfyZQ-00051a-Bf; Thu, 06 Feb 2025 04:53:17 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Feb
 2025 17:52:54 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Feb 2025 17:52:54 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 5/6] hw/arm/aspeed_ast27x0: Sort the IRQ table by IRQ number
Date: Thu, 6 Feb 2025 17:52:51 +0800
Message-ID: <20250206095253.928308-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
References: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
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
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

To improve readability, sort the IRQ table by IRQ number.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 50 ++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 39567fcab9..6a8487fee6 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -73,27 +73,13 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
 static const int aspeed_soc_ast2700a0_irqmap[] = {
-    [ASPEED_DEV_UART0]     = 132,
-    [ASPEED_DEV_UART1]     = 132,
-    [ASPEED_DEV_UART2]     = 132,
-    [ASPEED_DEV_UART3]     = 132,
-    [ASPEED_DEV_UART4]     = 8,
-    [ASPEED_DEV_UART5]     = 132,
-    [ASPEED_DEV_UART6]     = 132,
-    [ASPEED_DEV_UART7]     = 132,
-    [ASPEED_DEV_UART8]     = 132,
-    [ASPEED_DEV_UART9]     = 132,
-    [ASPEED_DEV_UART10]    = 132,
-    [ASPEED_DEV_UART11]    = 132,
-    [ASPEED_DEV_UART12]    = 132,
-    [ASPEED_DEV_FMC]       = 131,
     [ASPEED_DEV_SDMC]      = 0,
-    [ASPEED_DEV_SCU]       = 12,
-    [ASPEED_DEV_ADC]       = 130,
+    [ASPEED_DEV_HACE]      = 4,
     [ASPEED_DEV_XDMA]      = 5,
-    [ASPEED_DEV_EMMC]      = 15,
-    [ASPEED_DEV_GPIO]      = 130,
+    [ASPEED_DEV_UART4]     = 8,
+    [ASPEED_DEV_SCU]       = 12,
     [ASPEED_DEV_RTC]       = 13,
+    [ASPEED_DEV_EMMC]      = 15,
     [ASPEED_DEV_TIMER1]    = 16,
     [ASPEED_DEV_TIMER2]    = 17,
     [ASPEED_DEV_TIMER3]    = 18,
@@ -102,19 +88,33 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
     [ASPEED_DEV_TIMER6]    = 21,
     [ASPEED_DEV_TIMER7]    = 22,
     [ASPEED_DEV_TIMER8]    = 23,
-    [ASPEED_DEV_WDT]       = 131,
-    [ASPEED_DEV_PWM]       = 131,
+    [ASPEED_DEV_DP]        = 28,
     [ASPEED_DEV_LPC]       = 128,
     [ASPEED_DEV_IBT]       = 128,
+    [ASPEED_DEV_KCS]       = 128,
+    [ASPEED_DEV_ADC]       = 130,
+    [ASPEED_DEV_GPIO]      = 130,
     [ASPEED_DEV_I2C]       = 130,
-    [ASPEED_DEV_PECI]      = 133,
+    [ASPEED_DEV_FMC]       = 131,
+    [ASPEED_DEV_WDT]       = 131,
+    [ASPEED_DEV_PWM]       = 131,
+    [ASPEED_DEV_I3C]       = 131,
+    [ASPEED_DEV_UART0]     = 132,
+    [ASPEED_DEV_UART1]     = 132,
+    [ASPEED_DEV_UART2]     = 132,
+    [ASPEED_DEV_UART3]     = 132,
+    [ASPEED_DEV_UART5]     = 132,
+    [ASPEED_DEV_UART6]     = 132,
+    [ASPEED_DEV_UART7]     = 132,
+    [ASPEED_DEV_UART8]     = 132,
+    [ASPEED_DEV_UART9]     = 132,
+    [ASPEED_DEV_UART10]    = 132,
+    [ASPEED_DEV_UART11]    = 132,
+    [ASPEED_DEV_UART12]    = 132,
     [ASPEED_DEV_ETH1]      = 132,
     [ASPEED_DEV_ETH2]      = 132,
     [ASPEED_DEV_ETH3]      = 132,
-    [ASPEED_DEV_HACE]      = 4,
-    [ASPEED_DEV_KCS]       = 128,
-    [ASPEED_DEV_DP]        = 28,
-    [ASPEED_DEV_I3C]       = 131,
+    [ASPEED_DEV_PECI]      = 133,
     [ASPEED_DEV_SDHCI]     = 133,
 };
 
-- 
2.34.1


