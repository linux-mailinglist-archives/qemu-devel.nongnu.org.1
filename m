Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6CBC737A
	for <lists+qemu-devel@lfdr.de>; Thu, 09 Oct 2025 04:36:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gUx-0008B7-24; Wed, 08 Oct 2025 22:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6gUu-00088Y-37; Wed, 08 Oct 2025 22:35:16 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v6gUq-0007jC-5Q; Wed, 08 Oct 2025 22:35:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 9 Oct
 2025 10:33:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 9 Oct 2025 10:33:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 16/16] hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style
Date: Thu, 9 Oct 2025 10:32:55 +0800
Message-ID: <20251009023301.4085829-17-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009023301.4085829-1-jamin_lin@aspeedtech.com>
References: <20251009023301.4085829-1-jamin_lin@aspeedtech.com>
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

Fix coding style warnings in aspeed_ast27x0-ssp.c and aspeed_ast27x0-tsp.c
reported by checkpatch.pl regarding line length exceeding 80 characters.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0-ssp.c | 3 ++-
 hw/arm/aspeed_ast27x0-tsp.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index a0b8289c35..6800d7b6b2 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -263,7 +263,8 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
 
-static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *data)
+static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO: cortex-m4f */
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index 8d3d457919..e409d94e28 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -263,7 +263,8 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                   sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
 }
 
-static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass, const void *data)
+static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
+                                             const void *data)
 {
     static const char * const valid_cpu_types[] = {
         ARM_CPU_TYPE_NAME("cortex-m4"), /* TODO cortex-m4f */
-- 
2.43.0


