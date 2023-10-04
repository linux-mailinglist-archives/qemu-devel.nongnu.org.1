Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E4F7B79B2
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwve-0008Li-Ri; Wed, 04 Oct 2023 04:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwte-000629-3d; Wed, 04 Oct 2023 04:06:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwtZ-0003iP-K4; Wed, 04 Oct 2023 04:06:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A6FD275B6;
 Wed,  4 Oct 2023 11:02:31 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A594F2CBEF;
 Wed,  4 Oct 2023 11:02:30 +0300 (MSK)
Received: (nullmailer pid 2702874 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 41/45] target/tricore: Fix RCPW/RRPW_INSERT insns for
 width = 0
Date: Wed,  4 Oct 2023 11:02:02 +0300
Message-Id: <20231004080221.2702636-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

we would crash if width was 0 for these insns, as tcg_gen_deposit() is
undefined for that case. For TriCore, width = 0 is a mov from the src reg
to the dst reg, so we special case this here.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20230828112651.522058-9-kbastian@mail.uni-paderborn.de>
(cherry picked from commit 23fa6f56b33f8fddf86ba4d027fb7d3081440cd9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 1947733870..e7fa5a825a 100644
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
@@ -6558,7 +6561,10 @@ static void decode_rrpw_extract_insert(DisasContext *ctx)
 
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
2.39.2


