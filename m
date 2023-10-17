Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFFA7CBB8D
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:46:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmU-0008I7-I8; Tue, 17 Oct 2023 02:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlk-0007vE-83
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlU-0001qb-K2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso35997385ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524875; x=1698129675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXWrxOLh0hy4zGD+VY2suBXWmSC9zzwSi5d/2qfqkNE=;
 b=fMdRvMei5fl4zFNydzJTMOYtp8wb8NyfIwdj4qRXv1IYM0CSKzZmNJqbwq5HrnHSWM
 +CC1km9jt/G0tOfWboMipiEgU/cootQtBh7/n7pTPuTDDW8vS5gZ+C2C7q0n/YCOz6tH
 MKvuu6o1440R3ohYU8bdsQTSPJ6U7GzUgWGtsB59CLoWfh1Vfo3xou8c73MWBgS/SbYY
 /OjUinEFewt8h4b6Yy3hvxgZwFGflwMnGxP6G0B9qoJf6GtMnaVinJpO3rRFbv/L3FFg
 scrSuO9ZOvhXEojYjIIgE0kbfYrXAoUr4nZ9DrnSK+5GknXP7wKcEDy1Vv6ZMidcHRB/
 eKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524875; x=1698129675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXWrxOLh0hy4zGD+VY2suBXWmSC9zzwSi5d/2qfqkNE=;
 b=YBbyJtBcATrhh0eE82m2k1Z49wX8vmjXCniobV5dWM/O3L8yci6q1r7ithI6tOTIB0
 DZ6PCiejdl055aW94XjxbcQZH5C8u0B/osC8+hLwC6ZE2SPYc6DpgNwT7GmGCKk1NazK
 c1to3MFBadQWsreKnaMAEwj6MJlW0D+bsU1NwvN6OW8kA/E75HM0USXEzvMrPAD3x8s9
 SdUIYjkTzHlntnJcNH7oTCpmVQvYUZjjCCdLbk/XMbM3snUF6r74d7oM3p552DI6caj5
 Df3ck3THfkbzEw7FJGiiIAhLh86qEBZMNPX3u65isCD8nbYPeE0VV9yVelBkUoQZl3d/
 8g7A==
X-Gm-Message-State: AOJu0YxAOLpLgKLAKYWbtHuoQP0IrFXRDUPJf5nJ7d2GugapCxd5cFYL
 p3kLZWP4NrS39sFn7Huorb0AK7ACqutLPV9kQWQ=
X-Google-Smtp-Source: AGHT+IEf4yWUMT1TV7DwHPd5FCXF+z3aMuIrGrycEKoWk7QTi3gSBLquDrrH2YSQJFuBX2bOdoGigQ==
X-Received: by 2002:a17:903:32d0:b0:1b5:561a:5ca9 with SMTP id
 i16-20020a17090332d000b001b5561a5ca9mr1455121plr.50.1697524875057; 
 Mon, 16 Oct 2023 23:41:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/20] target/sparc: Remove CC_OP_SUB, CC_OP_SUBX, CC_OP_TSUB
Date: Mon, 16 Oct 2023 23:40:55 -0700
Message-Id: <20231017064109.681935-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

These are all related and implementable with common code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   3 -
 target/sparc/cc_helper.c |  59 ----------
 target/sparc/translate.c | 226 ++++++++++-----------------------------
 3 files changed, 54 insertions(+), 234 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4925b35859..8498bd07db 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -151,9 +151,6 @@ enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
     CC_OP_TADDTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
-    CC_OP_SUB,     /* modify all flags, CC_DST = res, CC_SRC = src1 */
-    CC_OP_SUBX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
-    CC_OP_TSUB,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TSUBTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
     CC_OP_NB,
 };
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index c004a9b1d8..d31aa24b5d 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -234,64 +234,11 @@ static uint32_t compute_C_sub_xcc(CPUSPARCState *env)
 }
 #endif
 
-static uint32_t compute_all_sub(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_sub_icc(CC_SRC, CC_SRC2);
-    ret |= get_V_sub_icc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
 static uint32_t compute_C_sub(CPUSPARCState *env)
 {
     return get_C_sub_icc(CC_SRC, CC_SRC2);
 }
 
-#ifdef TARGET_SPARC64
-static uint32_t compute_all_subx_xcc(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_xcc(CC_DST);
-    ret |= get_C_subx_xcc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_sub_xcc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_subx_xcc(CPUSPARCState *env)
-{
-    return get_C_subx_xcc(CC_DST, CC_SRC, CC_SRC2);
-}
-#endif
-
-static uint32_t compute_all_subx(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_subx_icc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_sub_icc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_subx(CPUSPARCState *env)
-{
-    return get_C_subx_icc(CC_DST, CC_SRC, CC_SRC2);
-}
-
-static uint32_t compute_all_tsub(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_sub_icc(CC_SRC, CC_SRC2);
-    ret |= get_V_sub_icc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_tag_icc(CC_SRC, CC_SRC2);
-    return ret;
-}
-
 static uint32_t compute_all_tsubtv(CPUSPARCState *env)
 {
     uint32_t ret;
@@ -309,9 +256,6 @@ typedef struct CCTable {
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
     [CC_OP_TADDTV] = { compute_all_taddtv, compute_C_add },
-    [CC_OP_SUB] = { compute_all_sub, compute_C_sub },
-    [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
-    [CC_OP_TSUB] = { compute_all_tsub, compute_C_sub },
     [CC_OP_TSUBTV] = { compute_all_tsubtv, compute_C_sub },
 };
 
@@ -319,9 +263,6 @@ static const CCTable icc_table[CC_OP_NB] = {
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
     [CC_OP_TADDTV] = { compute_all_add_xcc, compute_C_add_xcc },
-    [CC_OP_SUB] = { compute_all_sub_xcc, compute_C_sub_xcc },
-    [CC_OP_SUBX] = { compute_all_subx_xcc, compute_C_subx_xcc },
-    [CC_OP_TSUB] = { compute_all_sub_xcc, compute_C_sub_xcc },
     [CC_OP_TSUBTV] = { compute_all_sub_xcc, compute_C_sub_xcc },
 };
 #endif
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 59e96bf39d..ff523a4e7d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -448,107 +448,58 @@ static void gen_op_addccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_addcc_int(dst, src1, src2, gen_carry32());
 }
 
-static TCGv_i32 gen_add32_carry32(void)
+static void gen_op_subcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
 {
-    TCGv_i32 carry_32, cc_src1_32, cc_src2_32;
+    TCGv z = tcg_constant_tl(0);
 
-    /* Carry is computed from a previous add: (dst < src)  */
-#if TARGET_LONG_BITS == 64
-    cc_src1_32 = tcg_temp_new_i32();
-    cc_src2_32 = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(cc_src1_32, cpu_cc_dst);
-    tcg_gen_extrl_i64_i32(cc_src2_32, cpu_cc_src);
-#else
-    cc_src1_32 = cpu_cc_dst;
-    cc_src2_32 = cpu_cc_src;
-#endif
-
-    carry_32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i32(TCG_COND_LTU, carry_32, cc_src1_32, cc_src2_32);
-
-    return carry_32;
-}
-
-static TCGv_i32 gen_sub32_carry32(void)
-{
-    TCGv_i32 carry_32, cc_src1_32, cc_src2_32;
-
-    /* Carry is computed from a previous borrow: (src1 < src2)  */
-#if TARGET_LONG_BITS == 64
-    cc_src1_32 = tcg_temp_new_i32();
-    cc_src2_32 = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(cc_src1_32, cpu_cc_src);
-    tcg_gen_extrl_i64_i32(cc_src2_32, cpu_cc_src2);
-#else
-    cc_src1_32 = cpu_cc_src;
-    cc_src2_32 = cpu_cc_src2;
-#endif
-
-    carry_32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i32(TCG_COND_LTU, carry_32, cc_src1_32, cc_src2_32);
-
-    return carry_32;
-}
-
-static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
-{
-    tcg_gen_mov_tl(cpu_cc_src, src1);
-    tcg_gen_mov_tl(cpu_cc_src2, src2);
-    tcg_gen_sub_tl(cpu_cc_dst, cpu_cc_src, cpu_cc_src2);
-    tcg_gen_mov_tl(dst, cpu_cc_dst);
-}
-
-static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
-{
-    TCGv_i32 carry_32;
-    TCGv carry;
-
-    switch (dc->cc_op) {
-    case CC_OP_TADDTV:
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               a SUB2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_sub2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto sub_done;
-        }
-        carry_32 = gen_sub32_carry32();
-        break;
-
-    default:
-        /* We need external help to produce the carry.  */
-        carry_32 = tcg_temp_new_i32();
-        gen_helper_compute_C_icc(carry_32, tcg_env);
-        break;
+    if (cin) {
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+    } else {
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
     }
-
-#if TARGET_LONG_BITS == 64
-    carry = tcg_temp_new();
-    tcg_gen_extu_i32_i64(carry, carry_32);
-#else
-    carry = carry_32;
+    tcg_gen_neg_tl(cpu_cc_C, cpu_cc_C);
+    tcg_gen_xor_tl(cpu_cc_Z, src1, src2);
+    tcg_gen_xor_tl(cpu_cc_V, cpu_cc_N, src1);
+    tcg_gen_and_tl(cpu_cc_V, cpu_cc_V, cpu_cc_Z);
+#ifdef TARGET_SPARC64
+    tcg_gen_xor_tl(cpu_icc_C, cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
 #endif
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
+}
 
+static void gen_op_subcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subcc_int(dst, src1, src2, NULL);
+}
+
+static void gen_op_tsubcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    TCGv t = tcg_temp_new();
+
+    /* Save the tag bits around modification of dst. */
+    tcg_gen_or_tl(t, src1, src2);
+
+    gen_op_subcc(dst, src1, src2);
+
+    /* Incorprate tag bits into icc.V */
+    tcg_gen_andi_tl(t, t, 3);
+    tcg_gen_neg_tl(t, t);
+    tcg_gen_ext32u_tl(t, t);
+    tcg_gen_or_tl(cpu_cc_N, cpu_cc_N, t);
+}
+
+static void gen_op_subc(TCGv dst, TCGv src1, TCGv src2)
+{
     tcg_gen_sub_tl(dst, src1, src2);
-    tcg_gen_sub_tl(dst, dst, carry);
+    tcg_gen_sub_tl(dst, dst, gen_carry32());
+}
 
- sub_done:
-    if (update_cc) {
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUBX);
-        dc->cc_op = CC_OP_SUBX;
-    }
+static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_subcc_int(dst, src1, src2, gen_carry32());
 }
 
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
@@ -1035,66 +986,11 @@ static void gen_op_next_insn(void)
 static void gen_compare(DisasCompare *cmp, bool xcc, unsigned int cond,
                         DisasContext *dc)
 {
-    static int subcc_cond[16] = {
-        TCG_COND_NEVER,
-        TCG_COND_EQ,
-        TCG_COND_LE,
-        TCG_COND_LT,
-        TCG_COND_LEU,
-        TCG_COND_LTU,
-        -1, /* neg */
-        -1, /* overflow */
-        TCG_COND_ALWAYS,
-        TCG_COND_NE,
-        TCG_COND_GT,
-        TCG_COND_GE,
-        TCG_COND_GTU,
-        TCG_COND_GEU,
-        -1, /* pos */
-        -1, /* no overflow */
-    };
-
     TCGv t1, t2;
 
     cmp->is_bool = false;
 
     switch (dc->cc_op) {
-
-    case CC_OP_SUB:
-        switch (cond) {
-        case 6:  /* neg */
-        case 14: /* pos */
-            cmp->cond = (cond == 6 ? TCG_COND_LT : TCG_COND_GE);
-            cmp->c2 = tcg_constant_tl(0);
-            if (TARGET_LONG_BITS == 32 || xcc) {
-                cmp->c1 = cpu_cc_dst;
-            } else {
-                cmp->c1 = t1 = tcg_temp_new();
-                tcg_gen_ext32s_tl(t1, cpu_cc_dst);
-            }
-            return;
-
-        case 7: /* overflow */
-        case 15: /* !overflow */
-            break;
-
-        default:
-            cmp->cond = subcc_cond[cond];
-            if (TARGET_LONG_BITS == 32 || xcc) {
-                cmp->c1 = cpu_cc_src;
-                cmp->c2 = cpu_cc_src2;
-            } else {
-                /* Note that sign-extension works for unsigned compares as
-                   long as both operands are sign-extended.  */
-                cmp->c1 = t1 = tcg_temp_new();
-                tcg_gen_ext32s_tl(t1, cpu_cc_src);
-                cmp->c2 = t2 = tcg_temp_new();
-                tcg_gen_ext32s_tl(t2, cpu_cc_src2);
-            }
-            return;
-        }
-        break;
-
     default:
         gen_helper_compute_psr(tcg_env);
         dc->cc_op = CC_OP_FLAGS;
@@ -3794,7 +3690,7 @@ TRANS(ADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_addcc)
 TRANS(ANDcc, ALL, do_logic_cc, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(ORcc, ALL, do_logic_cc, a, tcg_gen_or_tl, tcg_gen_ori_tl)
 TRANS(XORcc, ALL, do_logic_cc, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
-TRANS(SUBcc, ALL, do_cc_arith, a, CC_OP_SUB, gen_op_sub_cc, NULL)
+TRANS(SUBcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_subcc)
 TRANS(ANDNcc, ALL, do_logic_cc, a, tcg_gen_andc_tl, NULL)
 TRANS(ORNcc, ALL, do_logic_cc, a, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_logic_cc, a, tcg_gen_eqv_tl, NULL)
@@ -3803,7 +3699,7 @@ TRANS(SMULcc, MUL, do_logic_cc, a, gen_op_smul, NULL)
 TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
 TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
 TRANS(TADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcc)
-TRANS(TSUBcc, ALL, do_cc_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
+TRANS(TSUBcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_tsubcc)
 TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_TADDTV, gen_op_taddcctv)
 TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv)
 
@@ -3834,26 +3730,14 @@ static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
 
 static bool trans_SUBC(DisasContext *dc, arg_r_r_ri *a)
 {
-    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
-
-    if (src2 == NULL) {
-        return false;
-    }
-    gen_op_subx_int(dc, gen_dest_gpr(dc, a->rd),
-                    gen_load_gpr(dc, a->rs1), src2, false);
-    return advance_pc(dc);
+    update_psr(dc);
+    return do_arith(dc, a, gen_op_subc, NULL);
 }
 
 static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
 {
-    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
-
-    if (src2 == NULL) {
-        return false;
-    }
-    gen_op_subx_int(dc, gen_dest_gpr(dc, a->rd),
-                    gen_load_gpr(dc, a->rs1), src2, true);
-    return advance_pc(dc);
+    update_psr(dc);
+    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_subccc);
 }
 
 static bool trans_MULScc(DisasContext *dc, arg_r_r_ri *a)
@@ -3874,11 +3758,9 @@ static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
     s2 = gen_load_gpr(dc, a->rs2);
 
     if (cc) {
-        tcg_gen_mov_tl(cpu_cc_src, s1);
-        tcg_gen_mov_tl(cpu_cc_src2, s2);
-        tcg_gen_sub_tl(cpu_cc_dst, s1, s2);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_SUB);
-        dc->cc_op = CC_OP_SUB;
+        gen_op_subcc(cpu_cc_N, s1, s2);
+        tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
+        dc->cc_op = CC_OP_FLAGS;
     }
 
     /*
-- 
2.34.1


