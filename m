Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E154BD17F2
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Oct 2025 07:47:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8BNW-0000kz-0G; Mon, 13 Oct 2025 01:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BMh-00005v-0d; Mon, 13 Oct 2025 01:44:59 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1v8BMe-0002Gm-WA; Mon, 13 Oct 2025 01:44:58 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 13 Oct
 2025 13:43:40 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 13 Oct 2025 13:43:40 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v3 14/16] hw/arm/aspeed_ast27x0-ssp: Rename type to
 TYPE_ASPEED27X0SSP_COPROCESSOR
Date: Mon, 13 Oct 2025 13:43:26 +0800
Message-ID: <20251013054334.955331-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
References: <20251013054334.955331-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Rename the AST27x0 SSP type from TYPE_ASPEED27X0SSP_SOC to
TYPE_ASPEED27X0SSP_COPROCESSOR to better reflect its role as a coprocessor
rather than a standalone SoC. This aligns naming conventions with the
coprocessor-based design introduced in earlier refactors.

This change improves naming consistency across SSP and TSP coprocessor
implementations and clarifies their relationship to the unified
Aspeed27x0CoprocessorState.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed_coprocessor.h |  5 +++--
 hw/arm/aspeed_ast27x0-fc.c          |  3 ++-
 hw/arm/aspeed_ast27x0-ssp.c         | 10 +++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
index 110e776c62..1c201a15c6 100644
--- a/include/hw/arm/aspeed_coprocessor.h
+++ b/include/hw/arm/aspeed_coprocessor.h
@@ -50,8 +50,9 @@ struct Aspeed27x0CoprocessorState {
     ARMv7MState armv7m;
 };
 
-#define TYPE_ASPEED27X0SSP_SOC "aspeed27x0ssp-soc"
-OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState, ASPEED27X0SSP_SOC)
+#define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed27x0CoprocessorState,
+                           ASPEED27X0SSP_COPROCESSOR)
 
 #define TYPE_ASPEED27X0TSP_SOC "aspeed27x0tsp-soc"
 DECLARE_OBJ_CHECKERS(Aspeed27x0CoprocessorState, AspeedCoprocessorClass,
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index c2fa8df33c..67982d2fa0 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -121,7 +121,8 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
 
-    object_initialize_child(OBJECT(s), "ssp", &s->ssp, TYPE_ASPEED27X0SSP_SOC);
+    object_initialize_child(OBJECT(s), "ssp", &s->ssp,
+                            TYPE_ASPEED27X0SSP_COPROCESSOR);
     memory_region_init(&s->ssp_memory, OBJECT(&s->ssp), "ssp-memory",
                        UINT64_MAX);
 
diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
index f8319c95fd..d27be8b925 100644
--- a/hw/arm/aspeed_ast27x0-ssp.c
+++ b/hw/arm/aspeed_ast27x0-ssp.c
@@ -1,5 +1,5 @@
 /*
- * ASPEED Ast27x0 SSP SoC
+ * ASPEED Ast27x0 SSP Coprocessor
  *
  * Copyright (C) 2025 ASPEED Technology Inc.
  *
@@ -108,7 +108,7 @@ static struct nvic_intc_irq_info ast2700_ssp_intcmap[] = {
 static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
                                               int dev)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(s);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(s);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
 
     int or_idx;
@@ -130,7 +130,7 @@ static qemu_irq aspeed_soc_ast27x0ssp_get_irq(AspeedCoprocessorState *s,
 
 static void aspeed_soc_ast27x0ssp_init(Object *obj)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(obj);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(obj);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(obj);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     int i;
@@ -161,7 +161,7 @@ static void aspeed_soc_ast27x0ssp_init(Object *obj)
 
 static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
 {
-    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_SOC(dev_soc);
+    Aspeed27x0CoprocessorState *a = ASPEED27X0SSP_COPROCESSOR(dev_soc);
     AspeedCoprocessorState *s = ASPEED_COPROCESSOR(dev_soc);
     AspeedCoprocessorClass *sc = ASPEED_COPROCESSOR_GET_CLASS(s);
     DeviceState *armv7m;
@@ -286,7 +286,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass, const void *dat
 
 static const TypeInfo aspeed_soc_ast27x0ssp_types[] = {
     {
-        .name           = TYPE_ASPEED27X0SSP_SOC,
+        .name           = TYPE_ASPEED27X0SSP_COPROCESSOR,
         .parent         = TYPE_ASPEED_COPROCESSOR,
         .instance_size  = sizeof(Aspeed27x0CoprocessorState),
         .instance_init  = aspeed_soc_ast27x0ssp_init,
-- 
2.43.0


