Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D8C183DC
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 05:39:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDxwg-0007GK-CF; Wed, 29 Oct 2025 00:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDxwe-0007G6-Pz; Wed, 29 Oct 2025 00:38:00 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1vDxwb-0004M3-Kw; Wed, 29 Oct 2025 00:37:59 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 29 Oct
 2025 12:37:12 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 29 Oct 2025 12:37:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <kane_chen@aspeedtech.com>
Subject: [PATCH v2 04/17] hw/arm/aspeed: Move ASPEED_RAM_SIZE() macro to
 common header for reuse
Date: Wed, 29 Oct 2025 12:36:50 +0800
Message-ID: <20251029043710.1486573-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029043710.1486573-1-jamin_lin@aspeedtech.com>
References: <20251029043710.1486573-1-jamin_lin@aspeedtech.com>
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

Moving it into aspeed.h allows all Aspeed machine source files
(AST2400, AST2500, AST2600, AST2700, etc.) to reuse the same macro
definition for consistent behavior and maintainability.

No functional changes.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 include/hw/arm/aspeed.h | 7 +++++++
 hw/arm/aspeed.c         | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index fbe684d505..414c181c3a 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -25,6 +25,13 @@ DECLARE_OBJ_CHECKERS(AspeedMachineState, AspeedMachineClass,
 #define ASPEED_MAC2_ON   (1 << 2)
 #define ASPEED_MAC3_ON   (1 << 3)
 
+/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
+#if HOST_LONG_BITS == 32
+#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
+#else
+#define ASPEED_RAM_SIZE(sz) (sz)
+#endif
+
 struct AspeedMachineState {
     /* Private */
     MachineState parent_obj;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f58245456a..690ad0be87 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -35,13 +35,6 @@ static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
 };
 
-/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
-#if HOST_LONG_BITS == 32
-#define ASPEED_RAM_SIZE(sz) MIN((sz), 1 * GiB)
-#else
-#define ASPEED_RAM_SIZE(sz) (sz)
-#endif
-
 /* AST2600 evb hardware value */
 #define AST2600_EVB_HW_STRAP1 0x000000C0
 #define AST2600_EVB_HW_STRAP2 0x00000003
-- 
2.43.0


