Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F99FA4B86B
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Mar 2025 08:37:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp0MD-0001Yv-Sa; Mon, 03 Mar 2025 02:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp0LZ-0000o5-37; Mon, 03 Mar 2025 02:36:20 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tp0LU-0001xL-79; Mon, 03 Mar 2025 02:36:14 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 3 Mar
 2025 15:35:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 3 Mar 2025 15:35:48 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v4 5/6] hw/arm/aspeed_ast27x0.c Separate HW Strap Registers
 for SCU and SCUIO
Date: Mon, 3 Mar 2025 15:35:45 +0800
Message-ID: <20250303073547.1145080-6-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250303073547.1145080-1-jamin_lin@aspeedtech.com>
References: <20250303073547.1145080-1-jamin_lin@aspeedtech.com>
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

There is one hw-strap1 register in the SCU (CPU DIE) and another hw-strap1
register in the SCUIO (IO DIE). The values of these two registers should not be
the same. To reuse the current design of hw-strap, hw-strap1 is assigned to the
SCU and sets the value in the SCU hw-strap1 register, while hw-strap2 is
assigned to the SCUIO and sets the value in the SCUIO hw-strap1 register.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/arm/aspeed_ast27x0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index a48f47b74e..8c225d4f90 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -331,16 +331,23 @@ static void aspeed_soc_ast2700_init(Object *obj)
     object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
     qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
                          sc->silicon_rev);
+    /*
+     * There is one hw-strap1 register in the SCU (CPU DIE) and another
+     * hw-strap1 register in the SCUIO (IO DIE). To reuse the current design
+     * of hw-strap, hw-strap1 is assigned to the SCU and sets the value in the
+     * SCU hw-strap1 register, while hw-strap2 is assigned to the SCUIO and
+     * sets the value in the SCUIO hw-strap1 register.
+     */
     object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
                               "hw-strap1");
-    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
-                              "hw-strap2");
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
     object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
     qdev_prop_set_uint32(DEVICE(&s->scuio), "silicon-rev",
                          sc->silicon_rev);
+    object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scuio),
+                                  "hw-strap1");
 
     snprintf(typename, sizeof(typename), "aspeed.fmc-%s", socname);
     object_initialize_child(obj, "fmc", &s->fmc, typename);
-- 
2.34.1


