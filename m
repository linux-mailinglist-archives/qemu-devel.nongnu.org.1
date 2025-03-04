Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB52A4D41A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Mar 2025 07:50:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpM4L-0006ZF-Ai; Tue, 04 Mar 2025 01:47:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpM4G-0006Yb-0h; Tue, 04 Mar 2025 01:47:52 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tpM4E-0003IK-82; Tue, 04 Mar 2025 01:47:51 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 4 Mar
 2025 14:47:10 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 4 Mar 2025 14:47:10 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v5 2/6] hw/misc/aspeed_scu: Fix the revision ID cannot be set
 in the SOC layer for AST2700
Date: Tue, 4 Mar 2025 14:47:04 +0800
Message-ID: <20250304064710.2128993-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250304064710.2128993-1-jamin_lin@aspeedtech.com>
References: <20250304064710.2128993-1-jamin_lin@aspeedtech.com>
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

According to the design of the AST2600, it has a Silicon Revision ID Register,
specifically SCU004 and SCU014, to set the Revision ID for the AST2600.
For the AST2600 A3, SCU004 is set to 0x05030303 and SCU014 is set to 0x05030303.
In the "aspeed_ast2600_scu_reset" function, the hardcoded value
"AST2600_A3_SILICON_REV" is set in SCU004, and "s->silicon_rev" is set in
SCU014. The value of "s->silicon_rev" is set by the SOC layer via the
"silicon-rev" property.

However, the design of the AST2700 is different. There are two SCU controllers:
SCU0 (CPU Die) and SCU1 (IO Die). In the AST2700, the firmware reads the SCU
Silicon Revision ID register (SCU0_000) and the SCUIO Silicon Revision ID
register (SCU1_000), combining them into a single 64-bit value.

The upper 32 bits represent the SCUIO, while the lower 32 bits correspond to the
SCU. For example, the AST2700-A1 revision is represented as 0x0601010306010103.
SCUIO_000 occupies bits [63:32] with a value of 0x06010103 and SCU_000 occupies
bits [31:0] with a value of 0x06010103.

Reference:
https://github.com/AspeedTech-BMC/u-boot/blob/aspeed-master-v2023.10/arch/arm/mach-aspeed/ast2700/cpu-info.c

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/misc/aspeed_scu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 50f74fbabd..545d004749 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -910,7 +910,6 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops = {
 };
 
 static const uint32_t ast2700_a0_resets[ASPEED_AST2700_SCU_NR_REGS] = {
-    [AST2700_SILICON_REV]           = AST2700_A0_SILICON_REV,
     [AST2700_HW_STRAP1]             = 0x00000800,
     [AST2700_HW_STRAP1_CLR]         = 0xFFF0FFF0,
     [AST2700_HW_STRAP1_LOCK]        = 0x00000FFF,
@@ -940,6 +939,7 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
     AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(dev);
 
     memcpy(s->regs, asc->resets, asc->nr_regs * 4);
+    s->regs[AST2700_SILICON_REV] = s->silicon_rev;
 }
 
 static void aspeed_2700_scu_class_init(ObjectClass *klass, void *data)
@@ -1032,7 +1032,6 @@ static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
 };
 
 static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
-    [AST2700_SILICON_REV]               = 0x06000003,
     [AST2700_HW_STRAP1]                 = 0x00000504,
     [AST2700_HW_STRAP1_CLR]             = 0xFFF0FFF0,
     [AST2700_HW_STRAP1_LOCK]            = 0x00000FFF,
-- 
2.34.1


