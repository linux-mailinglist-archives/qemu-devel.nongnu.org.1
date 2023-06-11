Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6772B377
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 20:54:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8QBZ-0008WI-TN; Sun, 11 Jun 2023 14:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBX-0008W0-D7
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:07 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1q8QBV-0001mU-TI
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 14:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iR+gZOgwary6X5q0Ut5MGPdsyEuKNq/9VuqK6eb2ZxA=; b=O7Il6pc2DrjTYR7kEIm2nz2Ljq
 5f4HJZzJ9qmaz4ANkK85uu19n0u/5BfwbtcdREn6hH2pDLLkG5P/Tj+O+Ou5UeChJ1Qqc8wxv4vdU
 CtVz/gf/+sz6bhxEqtBzKEq1TxDY+P5MGZd9/3IFn0zQ7KrI1MtUZxaBWuFPNMFuu54Q=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: kbastian@mail.uni-paderborn.de,
	richard.henderson@linaro.org
Subject: [PATCH v2 3/6] target/tricore: Add LHA insn
Date: Sun, 11 Jun 2023 20:52:10 +0200
Message-Id: <20230611185213.51345-4-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
References: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.6.11.184517, AntiVirus-Engine: 6.0.0,
 AntiVirus-Data: 2023.6.11.600000
X-Sophos-SenderHistory: ip=79.202.219.6, fs=354475, da=174118648, mc=34, sc=0,
 hc=34, sp=0, fso=354475, re=0, sd=0, hd=0
X-IMT-Source: Intern
X-IMT-Spam-Score: 0.0 ()
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
Received-SPF: pass client-ip=2001:638:502:c003::16;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=doohan.uni-paderborn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c       | 14 ++++++++++++--
 target/tricore/tricore-opcodes.h |  9 ++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 26b284bcec..898557d22a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -7931,7 +7931,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
 
 static void decode_32Bit_opc(DisasContext *ctx)
 {
-    int op1;
+    int op1, op2;
     int32_t r1, r2, r3;
     int32_t address, const16;
     int8_t b, const4;
@@ -7982,9 +7982,19 @@ static void decode_32Bit_opc(DisasContext *ctx)
         tcg_gen_qemu_ld_tl(cpu_gpr_d[r1], temp, ctx->mem_idx, MO_LEUW);
         tcg_gen_shli_tl(cpu_gpr_d[r1], cpu_gpr_d[r1], 16);
         break;
-    case OPC1_32_ABS_LEA:
+    case OPCM_32_ABS_LEA_LHA:
         address = MASK_OP_ABS_OFF18(ctx->opcode);
         r1 = MASK_OP_ABS_S1D(ctx->opcode);
+
+        if (has_feature(ctx, TRICORE_FEATURE_162)) {
+            op2 = MASK_OP_ABS_OP2(ctx->opcode);
+            if (op2 == OPC2_32_ABS_LHA) {
+                tcg_gen_movi_tl(cpu_gpr_a[r1], address << 14);
+                break;
+            }
+            /* otherwise translate regular LEA */
+        }
+
         tcg_gen_movi_tl(cpu_gpr_a[r1], EA_ABS_FORMAT(address));
         break;
 /* ABSB-format */
diff --git a/target/tricore/tricore-opcodes.h b/target/tricore/tricore-opcodes.h
index 59aa39a7a5..9fab4bd75c 100644
--- a/target/tricore/tricore-opcodes.h
+++ b/target/tricore/tricore-opcodes.h
@@ -430,7 +430,7 @@ enum {
     OPCM_32_ABS_STOREB_H                             = 0x25,
     OPC1_32_ABS_STOREQ                               = 0x65,
     OPC1_32_ABS_LD_Q                                 = 0x45,
-    OPC1_32_ABS_LEA                                  = 0xc5,
+    OPCM_32_ABS_LEA_LHA                              = 0xc5,
 /* ABSB Format */
     OPC1_32_ABSB_ST_T                                = 0xd5,
 /* B Format */
@@ -592,6 +592,13 @@ enum {
     OPC2_32_ABS_ST_B                             = 0x00,
     OPC2_32_ABS_ST_H                             = 0x02,
 };
+
+/* OPCM_32_ABS_LEA_LHA */
+enum {
+    OPC2_32_ABS_LEA                              = 0x00,
+    OPC2_32_ABS_LHA                              = 0x01,
+};
+
 /*
  * Bit Format
  */
-- 
2.40.1


