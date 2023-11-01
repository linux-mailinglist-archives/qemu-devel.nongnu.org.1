Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2468D7DDBC9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:13:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2Zz-0005uV-6f; Wed, 01 Nov 2023 00:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zw-0005tV-Fz
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:40 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zu-0007Ua-FC
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:40 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so4148084a34.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811897; x=1699416697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utggYnwKzfLZC2Lm9oCFCSsyrgo11I+wqXfkXP7b2R8=;
 b=DR3uY1s5VY26HLz1v1ii9IMd6ftHTEJP3ZoptmcaEVqday9APJY6Z+4tHtTqEK5V6J
 9ZCvhh9447ft+1iunmWmdBuCAqnNJDQdNEBtc/n/YszyIa9wei3IS0lFdfRR/zNCzXap
 GLGrjP+sHEy9X79N3sNyISFa2MNcjRC30Z6uthR16cmIOyWzCHLaGiAv2Z0wvYyMNzPp
 CkTeBSzzXIS789ZUmlpBcT6l8WSqOXCpS9Hl3e/ex4WCIREDDvqa6CFDYLdBx7g/yA+0
 EnluJ5DJmf7SVUEpmwvN8TZXoMz0z4c9t5HO/wwcAmwzSVOgSIO1MnLCXCQ+P4+o3j4m
 QYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811897; x=1699416697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=utggYnwKzfLZC2Lm9oCFCSsyrgo11I+wqXfkXP7b2R8=;
 b=lsdLFQ+vCP+myn6tIdyIPJa/Afjtr5PLQftAThbQ5Wm0bJGegKzarBjUFRdAoxKi7K
 00tu6P9HP0xsu8AyLoQUyTxiz0vjPJm1tlBKUpYGS5550EYygLVOnL0Gtsdd0BMrpxoP
 scfCvqoYSUVh6SQtjiqxYeX41lUVrhUeo66aVviyEn6JSfFgtqfoctLULPEyOePHqhm/
 ozCmIZPCckgu6NxLcm4fMFoW7LWcAwGa6EdUflJY4YWkDc7f0bSdYBjKxI7e3pr63i3N
 YL96IagQoQIZc13CgeAO++snQtq+8HT4S0yYVKP/LyBGHZQsfWIPSVVr41f9vm8lLPgO
 lXnA==
X-Gm-Message-State: AOJu0YzXPAeK0++GImqORFm1znyQpLqj8Fd4ILISKWwlUDJviihYT+rY
 VNB3UKPTEYoaJoFosbTymeOtCEnCCVO5xUHLz6Q=
X-Google-Smtp-Source: AGHT+IGBsCd255/IOCCt8gtiTn3hdFgFfYwVhHKGwmAQqYFGKIewsefOM9/Mljg35irUlhGXz0RFqg==
X-Received: by 2002:a9d:6290:0:b0:6cd:92d:c835 with SMTP id
 x16-20020a9d6290000000b006cd092dc835mr15397140otk.27.1698811897106; 
 Tue, 31 Oct 2023 21:11:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 03/21] target/sparc: Remove CC_OP_LOGIC
Date: Tue, 31 Oct 2023 21:11:14 -0700
Message-Id: <20231101041132.174501-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |  1 -
 target/sparc/cc_helper.c | 14 +--------
 target/sparc/translate.c | 66 ++++++++++++++++------------------------
 3 files changed, 28 insertions(+), 53 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ea8a04c6e3..202c34f7ca 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -159,7 +159,6 @@ enum {
     CC_OP_SUBX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TSUB,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TSUBTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
-    CC_OP_LOGIC,   /* modify N and Z, C = V = 0, CC_DST = res */
     CC_OP_NB,
 };
 
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index 46bec69d96..1622300a14 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -378,16 +378,6 @@ static uint32_t compute_all_tsubtv(CPUSPARCState *env)
     return ret;
 }
 
-static uint32_t compute_all_logic(CPUSPARCState *env)
-{
-    return get_NZ_icc(CC_DST);
-}
-
-static uint32_t compute_C_logic(CPUSPARCState *env)
-{
-    return 0;
-}
-
 #ifdef TARGET_SPARC64
 static uint32_t compute_all_logic_xcc(CPUSPARCState *env)
 {
@@ -411,13 +401,12 @@ static const CCTable icc_table[CC_OP_NB] = {
     [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
     [CC_OP_TSUB] = { compute_all_tsub, compute_C_sub },
     [CC_OP_TSUBTV] = { compute_all_tsubtv, compute_C_sub },
-    [CC_OP_LOGIC] = { compute_all_logic, compute_C_logic },
 };
 
 #ifdef TARGET_SPARC64
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_DIV] = { compute_all_logic_xcc, compute_C_logic },
+    [CC_OP_DIV] = { compute_all_logic_xcc, compute_C_div },
     [CC_OP_ADD] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_ADDX] = { compute_all_addx_xcc, compute_C_addx_xcc },
     [CC_OP_TADD] = { compute_all_add_xcc, compute_C_add_xcc },
@@ -426,7 +415,6 @@ static const CCTable xcc_table[CC_OP_NB] = {
     [CC_OP_SUBX] = { compute_all_subx_xcc, compute_C_subx_xcc },
     [CC_OP_TSUB] = { compute_all_sub_xcc, compute_C_sub_xcc },
     [CC_OP_TSUBTV] = { compute_all_sub_xcc, compute_C_sub_xcc },
-    [CC_OP_LOGIC] = { compute_all_logic_xcc, compute_C_logic },
 };
 #endif
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 261f142636..b11d89343b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1117,48 +1117,24 @@ static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
         -1, /* no overflow */
     };
 
-    static int logic_cond[16] = {
-        TCG_COND_NEVER,
-        TCG_COND_EQ,     /* eq:  Z */
-        TCG_COND_LE,     /* le:  Z | (N ^ V) -> Z | N */
-        TCG_COND_LT,     /* lt:  N ^ V -> N */
-        TCG_COND_EQ,     /* leu: C | Z -> Z */
-        TCG_COND_NEVER,  /* ltu: C -> 0 */
-        TCG_COND_LT,     /* neg: N */
-        TCG_COND_NEVER,  /* vs:  V -> 0 */
-        TCG_COND_ALWAYS,
-        TCG_COND_NE,     /* ne:  !Z */
-        TCG_COND_GT,     /* gt:  !(Z | (N ^ V)) -> !(Z | N) */
-        TCG_COND_GE,     /* ge:  !(N ^ V) -> !N */
-        TCG_COND_NE,     /* gtu: !(C | Z) -> !Z */
-        TCG_COND_ALWAYS, /* geu: !C -> 1 */
-        TCG_COND_GE,     /* pos: !N */
-        TCG_COND_ALWAYS, /* vc:  !V -> 1 */
-    };
-
     TCGv t1, t2;
 
     cmp->is_bool = false;
 
     switch (dc->cc_op) {
-    case CC_OP_LOGIC:
-        cmp->cond = logic_cond[cond];
-    do_compare_dst_0:
-        cmp->c2 = tcg_constant_tl(0);
-        if (TARGET_LONG_BITS == 32 || xcc) {
-            cmp->c1 = cpu_cc_dst;
-        } else {
-            cmp->c1 = t1 = tcg_temp_new();
-            tcg_gen_ext32s_tl(t1, cpu_cc_dst);
-        }
-        return;
-
     case CC_OP_SUB:
         switch (cond) {
         case 6:  /* neg */
         case 14: /* pos */
             cmp->cond = (cond == 6 ? TCG_COND_LT : TCG_COND_GE);
-            goto do_compare_dst_0;
+            cmp->c2 = tcg_constant_tl(0);
+            if (TARGET_LONG_BITS == 32 || xcc) {
+                cmp->c1 = cpu_cc_dst;
+            } else {
+                cmp->c1 = t1 = tcg_temp_new();
+                tcg_gen_ext32s_tl(t1, cpu_cc_dst);
+            }
+            return;
 
         case 7: /* overflow */
         case 15: /* !overflow */
@@ -3652,7 +3628,8 @@ TRANS(NOP_v9, 64, trans_NOP, a)
 
 static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
                          void (*func)(TCGv, TCGv, TCGv),
-                         void (*funci)(TCGv, TCGv, target_long))
+                         void (*funci)(TCGv, TCGv, target_long),
+                         bool logic_cc)
 {
     TCGv dst, src1;
 
@@ -3661,7 +3638,9 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
         return false;
     }
 
-    if (a->cc) {
+    if (logic_cc) {
+        dst = cpu_cc_N;
+    } else if (a->cc && cc_op > CC_OP_FLAGS) {
         dst = cpu_cc_dst;
     } else {
         dst = gen_dest_gpr(dc, a->rd);
@@ -3677,6 +3656,17 @@ static bool do_arith_int(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
     } else {
         func(dst, src1, cpu_regs[a->rs2_or_imm]);
     }
+
+    if (logic_cc) {
+        if (TARGET_LONG_BITS == 64) {
+            tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
+            tcg_gen_movi_tl(cpu_icc_C, 0);
+        }
+        tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+        tcg_gen_movi_tl(cpu_cc_C, 0);
+        tcg_gen_movi_tl(cpu_cc_V, 0);
+    }
+
     gen_store_gpr(dc, a->rd, dst);
 
     if (a->cc) {
@@ -3693,16 +3683,16 @@ static bool do_arith(DisasContext *dc, arg_r_r_ri_cc *a, int cc_op,
 {
     if (a->cc) {
         assert(cc_op >= 0);
-        return do_arith_int(dc, a, cc_op, func_cc, NULL);
+        return do_arith_int(dc, a, cc_op, func_cc, NULL, false);
     }
-    return do_arith_int(dc, a, cc_op, func, funci);
+    return do_arith_int(dc, a, cc_op, func, funci, false);
 }
 
 static bool do_logic(DisasContext *dc, arg_r_r_ri_cc *a,
                      void (*func)(TCGv, TCGv, TCGv),
                      void (*funci)(TCGv, TCGv, target_long))
 {
-    return do_arith_int(dc, a, CC_OP_LOGIC, func, funci);
+    return do_arith_int(dc, a, CC_OP_FLAGS, func, funci, a->cc);
 }
 
 TRANS(ADD, ALL, do_arith, a, CC_OP_ADD,
@@ -3754,7 +3744,6 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     switch (dc->cc_op) {
     case CC_OP_DIV:
-    case CC_OP_LOGIC:
         /* Carry is known to be zero.  Fall back to plain ADD.  */
         return do_arith(dc, a, CC_OP_ADD,
                         tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_add_cc);
@@ -3778,7 +3767,6 @@ static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     switch (dc->cc_op) {
     case CC_OP_DIV:
-    case CC_OP_LOGIC:
         /* Carry is known to be zero.  Fall back to plain SUB.  */
         return do_arith(dc, a, CC_OP_SUB,
                         tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc);
-- 
2.34.1


