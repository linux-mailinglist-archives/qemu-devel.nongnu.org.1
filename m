Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D8BA37848
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 00:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnme-0005by-SS; Sun, 16 Feb 2025 18:10:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmR-0005X4-Ln
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:31 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnmO-0005Eu-UK
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:10:31 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-220d28c215eso52273205ad.1
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747427; x=1740352227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=66HM3CqjXo3C/YJiL1YAAs2IDO8eeG7JgVlBYwPlTxw=;
 b=HU8nH8xtWuP8AVsVX6JmgGjCz4yRB2izOocCRqRhjYkaJBZemK6GG/uqItXd1e5Bn3
 CbVnlHDagTs+P0G4JIIjiY3Ox2SZOQiTWb3112jZTQ+Q8YvMasVIhXn5+VTLR0B1yQjG
 zS0C8c8TPjcN6ZktodCD/cyrUmT0/8AGgceMS/OOBJAmV5W1JAiO1SwH7yPyhMqTZGnZ
 CpeTtOP4dHysPLVMu2rUq0M7ewZEJKwFYsbkvFCNJbNWUzUcnq0X0KJ2bV3kozKb//bC
 CEDUSJUN0iIPQTUbRnc19xlai4TYQz/ThjpAjvFmPVi5UJyB3Pt8CccCRRQ5jFn6WNk8
 yuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747427; x=1740352227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=66HM3CqjXo3C/YJiL1YAAs2IDO8eeG7JgVlBYwPlTxw=;
 b=h8aZtXKc5WN0LFm/kl1W85XX9i0hYoCqFYEj5pBu/M0NfmFWsyGUulyNdi5dJ0TugW
 0ZqdO4RkQPlRDNXvQ/cQY00z/QI/AlTKlR06plW4RJCH7iKa8AJslIbuRV+VcFpUUBSG
 TS09SXGad4dPWKSwQZyo90kEcg/wD9d1vr8QafBmc/F/X20LHiXvtPQb3drxbZ1nRxVA
 EQBuZVaV6NyPQRoEXU8g52HgylJZY35Z71c2w3YadH63JynHdok8kCqU0ySV6VVsF+ui
 JFpXqE/J14KvajO9+qjd+h0lMqqsujOZYbFlL7gHJ1cSrutkS/iZoq13mlCrU2w/q8dz
 d12A==
X-Gm-Message-State: AOJu0YxXN/5iReMGbmAem1IcTrZqVG08E9falvzeqwucRSbGTJto5Gb5
 btBQzOJs8rpMCF4e+ZfahR5kqohCQi50TxGRa/UBTzZ4kqTcS09UsPLVavvwVWDbAf4ga5oFBQM
 O
X-Gm-Gg: ASbGncsJ98oWD9+ddi7kM0C2ysViNyVlt0GrvUAxWmwpuEwFNY0iXsokHnsNLCWtORH
 ez6Ty7y2TAXBQ0nUR51OMjZYiXUi/9tBUDueQ24Ab22AOzC4z3HtVzVKh9+9iQixBEFchPXhZ7E
 hVOQdvXWjmvJf8N7bPBfvggSg9ujjsMR0YGN876oN9pf3lqLUJTpLGZgx1HLBsRigbaBNZlRceI
 gEOYs50FWDSD9mGgLg3gL+SwCESxAh+Jppphfm1G/q/ezbpvSh/TA0SFeqnDoZVF0WG5GnVdT/f
 XB04Fg1YfRsIm61IR5LVkTeQz1YM4tqQ91FWKM/J5eTs1ZE=
X-Google-Smtp-Source: AGHT+IEX3GDp9B+w/I7AEC6VX0w1Au3GjOampfi5HztFQSNBSQZLpQmaYDl9cQYfwsRg+oBpvMIIqw==
X-Received: by 2002:a17:902:ecc7:b0:216:1543:195d with SMTP id
 d9443c01a7336-22104068654mr90691475ad.25.1739747427361; 
 Sun, 16 Feb 2025 15:10:27 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5596115sm60198415ad.258.2025.02.16.15.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:10:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 018/162] tcg: Merge INDEX_op_xor_{i32,i64}
Date: Sun, 16 Feb 2025 15:07:47 -0800
Message-ID: <20250216231012.2808572-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 target/sh4/translate.c   |  6 +++---
 tcg/optimize.c           | 18 ++++++++----------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 8 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index caf0f01042..8f6115bedb 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -44,6 +44,7 @@ DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
 DEF(negsetcond_i32, 1, 2, 1, 0)
@@ -66,7 +67,6 @@ DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
 DEF(divu2_i32, 2, 3, 0, 0)
-DEF(xor_i32, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i32, 1, 2, 0, 0)
 DEF(shr_i32, 1, 2, 0, 0)
@@ -124,7 +124,6 @@ DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
 DEF(divu2_i64, 2, 3, 0, 0)
-DEF(xor_i64, 1, 2, 0, 0)
 /* shifts/rotates */
 DEF(shl_i64, 1, 2, 0, 0)
 DEF(shr_i64, 1, 2, 0, 0)
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 17e09f3d2a..5cb9ba9434 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1946,7 +1946,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         op_opc = INDEX_op_and;
         goto do_reg_op;
     case 0x200a: /* xor Rm,Rn */
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         goto do_reg_op;
     case 0x200b: /* or Rm,Rn */
         op_opc = INDEX_op_or;
@@ -1976,7 +1976,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
             goto fail;
         }
         op_dst = B11_8;
-        op_opc = INDEX_op_xor_i32;
+        op_opc = INDEX_op_xor;
         op_arg = tcg_constant_i32(-1);
         break;
 
@@ -2133,7 +2133,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
         }
         break;
 
-    case INDEX_op_xor_i32:
+    case INDEX_op_xor:
         if (op_dst != st_src) {
             goto fail;
         }
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 9a7238832f..a4dc88ae71 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -429,7 +429,8 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_or_vec:
         return x | y;
 
-    CASE_OP_32_64_VEC(xor):
+    case INDEX_op_xor:
+    case INDEX_op_xor_vec:
         return x ^ y;
 
     case INDEX_op_shl_i32:
@@ -2277,7 +2278,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             break;
         }
         if (convert) {
-            TCGOpcode xor_opc, neg_opc;
+            TCGOpcode neg_opc;
 
             if (!inv && !neg) {
                 return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
@@ -2286,11 +2287,9 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
             switch (ctx->type) {
             case TCG_TYPE_I32:
                 neg_opc = INDEX_op_neg_i32;
-                xor_opc = INDEX_op_xor_i32;
                 break;
             case TCG_TYPE_I64:
                 neg_opc = INDEX_op_neg_i64;
-                xor_opc = INDEX_op_xor_i64;
                 break;
             default:
                 g_assert_not_reached();
@@ -2302,7 +2301,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
                 op->opc = INDEX_op_add;
                 op->args[2] = arg_new_constant(ctx, -1);
             } else {
-                op->opc = xor_opc;
+                op->opc = INDEX_op_xor;
                 op->args[2] = arg_new_constant(ctx, 1);
             }
             return -1;
@@ -2313,7 +2312,7 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode xor_opc, neg_opc, shr_opc;
+    TCGOpcode neg_opc, shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2335,7 +2334,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
         neg_opc = INDEX_op_neg_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
@@ -2346,7 +2344,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
         neg_opc = INDEX_op_neg_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
@@ -2394,7 +2391,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, -1);
     } else if (inv) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
+        op2 = tcg_op_insert_after(ctx->tcg, op, INDEX_op_xor, 3);
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
@@ -3039,7 +3036,8 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sub2):
             done = fold_sub2(&ctx, op);
             break;
-        CASE_OP_32_64_VEC(xor):
+        case INDEX_op_xor:
+        case INDEX_op_xor_vec:
             done = fold_xor(&ctx, op);
             break;
         case INDEX_op_set_label:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bf481060fa..b10f61435c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -453,7 +453,7 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_xor_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
 }
 
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1595,7 +1595,7 @@ void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_xor_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
     } else {
         tcg_gen_xor_i32(TCGV_LOW(ret), TCGV_LOW(arg1), TCGV_LOW(arg2));
         tcg_gen_xor_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d704ef8643..b1e932e7d9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1009,8 +1009,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_xor_i32, TCGOutOpBinary, outop_xor),
-    OUTOP(INDEX_op_xor_i64, TCGOutOpBinary, outop_xor),
+    OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
 #undef OUTOP
@@ -2215,6 +2214,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_and:
     case INDEX_op_mov:
     case INDEX_op_or:
+    case INDEX_op_xor:
         return has_type;
 
     case INDEX_op_setcond_i32:
@@ -2231,7 +2231,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
-    case INDEX_op_xor_i32:
     case INDEX_op_shl_i32:
     case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
@@ -2308,7 +2307,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i64:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
@@ -5436,8 +5434,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
+    case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
                 container_of(all_outop[op->opc], TCGOutOpBinary, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 68636e70da..cb300c4846 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -543,7 +543,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] | regs[r2];
             break;
-        CASE_32_64(xor)
+        case INDEX_op_xor:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] ^ regs[r2];
             break;
@@ -1083,12 +1083,11 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_andc:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_xor:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
-    case INDEX_op_xor_i32:
-    case INDEX_op_xor_i64:
     case INDEX_op_eqv_i32:
     case INDEX_op_eqv_i64:
     case INDEX_op_nand_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index c5c5a4d19e..a4aa4f8824 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -311,7 +311,7 @@ Logical
 
      - | *t0* = *t1* | *t2*
 
-   * - xor_i32/i64 *t0*, *t1*, *t2*
+   * - xor *t0*, *t1*, *t2*
 
      - | *t0* = *t1* ^ *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 85caff300f..0a912744b3 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -687,7 +687,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_xor_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_xor, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_xor = {
-- 
2.43.0


