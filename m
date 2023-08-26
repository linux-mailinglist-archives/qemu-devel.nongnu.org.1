Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB757897EA
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Aug 2023 18:04:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZvkt-0006YX-Ll; Sat, 26 Aug 2023 12:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvkq-0006Xa-CO
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:16 -0400
Received: from doohan.uni-paderborn.de ([2001:638:502:c003::16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1qZvko-0007uh-0F
 for qemu-devel@nongnu.org; Sat, 26 Aug 2023 12:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wgJZqoNXP65Pw0SqzMzpebmwwenMTo1yITNH8dvQpTk=; b=iLw3CGcXkKdADl7uXAsoriFFpC
 A3b6eVbT9g90wjmYYYjJl/yFl+Z/QXOAX5RJDP1FVNTWyu60q5f+RDxm4nGp//wVtYxLSNfQLVlo5
 wgb+NgPOqJ2IF5ZY/9xiwMzDAqrFG25E8BWg8S8IlbWGu0Jti85twn04L70ZPeo+DCvc=;
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me,
	kbastian@mail.uni-paderborn.de
Subject: [PATCH 07/10] target/tricore: Fix RCPW/RRPW_INSERT insns for width = 0
Date: Sat, 26 Aug 2023 18:02:39 +0200
Message-ID: <20230826160242.312052-8-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-spamd-action: no action
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2023.8.26.155417, AntiVirus-Engine: 6.0.2,
 AntiVirus-Data: 2023.8.20.602000
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

we would crash if width was 0 for these insns, as tcg_gen_deposit() is
undefined for that case. For TriCore, width = 0 is a mov from the src reg
to the dst reg, so we special case this here.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c          | 10 ++++++++--
 tests/tcg/tricore/asm/macros.h      | 15 +++++++++++++++
 tests/tcg/tricore/asm/test_insert.S |  9 +++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4400d2c3cb..d13f85c03a 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -5317,8 +5317,11 @@ static void decode_rcpw_insert(DisasContext *ctx)
         }
         break;
     case OPC2_32_RCPW_INSERT:
+        /* tcg_gen_deposit_tl() does not handle the case of width = 0 */
+        if (width == 0) {
+            tcg_gen_mov_tl(cpu_gpr_d[r2], cpu_gpr_d[r1]);
         /* if pos + width > 32 undefined result */
-        if (pos + width <= 32) {
+        } else if (pos + width <= 32) {
             temp = tcg_constant_i32(const4);
             tcg_gen_deposit_tl(cpu_gpr_d[r2], cpu_gpr_d[r1], temp, pos, width);
         }
@@ -6575,7 +6578,10 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
 
         break;
     case OPC2_32_RRPW_INSERT:
-        if (pos + width <= 32) {
+        /* tcg_gen_deposit_tl() does not handle the case of width = 0 */
+        if (width == 0) {
+            tcg_gen_mov_tl(cpu_gpr_d[r3], cpu_gpr_d[r1]);
+        } else if (pos + width <= 32) {
             tcg_gen_deposit_tl(cpu_gpr_d[r3], cpu_gpr_d[r1], cpu_gpr_d[r2],
                                pos, width);
         }
diff --git a/tests/tcg/tricore/asm/macros.h b/tests/tcg/tricore/asm/macros.h
index b5087b5c97..51f6191ef2 100644
--- a/tests/tcg/tricore/asm/macros.h
+++ b/tests/tcg/tricore/asm/macros.h
@@ -161,6 +161,21 @@ test_ ## num:                                                    \
     insn DREG_CALC_RESULT, DREG_RS1, imm1, DREG_RS2, imm2;   \
     )
 
+#define TEST_D_DDII(insn, num, result, rs1, rs2, imm1, imm2) \
+    TEST_CASE(num, DREG_CALC_RESULT, result,                 \
+    LI(DREG_RS1, rs1);                                       \
+    LI(DREG_RS2, rs2);                                       \
+    rstv;                                                    \
+    insn DREG_CALC_RESULT, DREG_RS1, DREG_RS2, imm1, imm2;   \
+    )
+
+#define TEST_D_DIII(insn, num, result, rs1, imm1, imm2, imm3)\
+    TEST_CASE(num, DREG_CALC_RESULT, result,                 \
+    LI(DREG_RS1, rs1);                                       \
+    rstv;                                                    \
+    insn DREG_CALC_RESULT, DREG_RS1, imm1, imm2, imm3;       \
+    )
+
 #define TEST_E_ED(insn, num, res_hi, res_lo, rs1_hi, rs1_lo, rs2) \
     TEST_CASE_E(num, res_lo, res_hi,                              \
     LI(EREG_RS1_LO, rs1_lo);                                      \
diff --git a/tests/tcg/tricore/asm/test_insert.S b/tests/tcg/tricore/asm/test_insert.S
index d5fd2237e1..3978810121 100644
--- a/tests/tcg/tricore/asm/test_insert.S
+++ b/tests/tcg/tricore/asm/test_insert.S
@@ -6,4 +6,13 @@ _start:
 #                 |     |      |            |       |     |    |
     TEST_D_DIDI(insert, 1, 0x7fffffff, 0xffffffff, 0xa, 0x10, 0x8)
 
+#                insn num    result        rs1    imm1   imm2 imm3
+#                 |     |      |            |       |     |    |
+    TEST_D_DIII(insert, 2, 0xd38fe370, 0xd38fe370, 0x4, 0x4 , 0x0)
+    TEST_D_DIII(insert, 3, 0xd38fe374, 0xd38fe370, 0x4, 0x0 , 0x4)
+
+#                insn  num   result       rs1         rs2      pos  width
+#                 |     |      |           |           |        |    |
+    TEST_D_DDII(insert, 4, 0x03c1e53c, 0x03c1e53c, 0x45821385, 0x7 ,0x0)
+
     TEST_PASSFAIL
-- 
2.41.0


