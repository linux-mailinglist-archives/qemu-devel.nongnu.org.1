Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0957CBBB3
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:47:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdls-0007vf-I2; Tue, 17 Oct 2023 02:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlW-0007r7-8N
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:18 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlT-0001qO-SE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:17 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9d7a98abbso35091695ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524874; x=1698129674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WB3jX7hDpS1YvwpXfJb6MXptcFpyUOv6GNIkU/8LrOg=;
 b=PKYbhE2vY9DTA/LbQIub89QMJQNELhRRZHkN0nCwurimHirLNTagX1CZmjA2e7REPp
 mUs6/2MwC2+5u/hDs41qQGOepSqVwIyAlspjSsID+cB6dqj67c57dSv1l72OaGPIYnhw
 VseBDVx5bvmHXiE0I1qt+suz2wNh+qZUeL8b07Mk3w11xZhfuVobrURits78HTDJKE0G
 IrPI8mKp/PyAWslqjMjIszV9J1WOJtNnHN1Q2WHJwuC7J05ChuHM9vyF/5uH5GQazGa2
 4ggIAbeirrTbxIIO4Xs4++ZlQBglmmUhhwDDRyRQB2bJ8gpPnmZ7DsgjOP5od/D1JZVu
 mQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524874; x=1698129674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WB3jX7hDpS1YvwpXfJb6MXptcFpyUOv6GNIkU/8LrOg=;
 b=PaWsgCdveth4nlWhrlebW2KWGDH6mokj6rAJKgptdSc88fukjJz9/y2utMeN9Or/Vj
 r569QusNdAiWrnIroVG9A5tfHDn4tPpR3iVnMeDAonHeRgSZ6gid7vR035ESPmYt+ghK
 BKlzG6DFre8GIZ56rhmXnUZxcRr/Rj0GAiXGR1gZHY9g6HI8kCHLfbJ7+t/gouO28X8X
 0VvRfEvCAwwg0y0KReB0IbQrxUaAKXIKwRROKYqkqYQIr9GTPmkc+SgfvmaoOVU83S1p
 TbegOofNHzKBCkElP7z0jfFLtg6DI8qtJughESrgv4sM7BBRpcbYE9Pk+eC21lYJ5aF5
 +GEw==
X-Gm-Message-State: AOJu0Yw9TnTbpzB2pTJNiSnn53dsp+RIp++M+lnxtE8XmjumyMb7EEZe
 zfHmvpvjTfFKi95QDQdSddXXBXlA49IAE/X1Fhw=
X-Google-Smtp-Source: AGHT+IFT/nV8CoYPSNt3ZknvYe1drtvGKZUtC71oq5ZjUJaWlCaJZD5vPDjDwuO7lAVwUyFBxV0i8A==
X-Received: by 2002:a17:903:23ca:b0:1c9:d667:4e4a with SMTP id
 o10-20020a17090323ca00b001c9d6674e4amr1333891plh.69.1697524874332; 
 Mon, 16 Oct 2023 23:41:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 05/20] target/sparc: Remove CC_OP_ADD, CC_OP_ADDX, CC_OP_TADD
Date: Mon, 16 Oct 2023 23:40:54 -0700
Message-Id: <20231017064109.681935-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

These are all related and implementable with common code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   3 -
 target/sparc/cc_helper.c |  59 ------------
 target/sparc/translate.c | 199 +++++++++++++++++++--------------------
 3 files changed, 95 insertions(+), 166 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 48e549f7cb..4925b35859 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -150,9 +150,6 @@ enum {
 enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
-    CC_OP_ADD,     /* modify all flags, CC_DST = res, CC_SRC = src1 */
-    CC_OP_ADDX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
-    CC_OP_TADD,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TADDTV,  /* modify all flags except V, CC_DST = res, CC_SRC = src1 */
     CC_OP_SUB,     /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_SUBX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index a88399d74a..c004a9b1d8 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -128,53 +128,11 @@ static uint32_t compute_C_add_xcc(CPUSPARCState *env)
 }
 #endif
 
-static uint32_t compute_all_add(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_add_icc(CC_DST, CC_SRC);
-    ret |= get_V_add_icc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
 static uint32_t compute_C_add(CPUSPARCState *env)
 {
     return get_C_add_icc(CC_DST, CC_SRC);
 }
 
-#ifdef TARGET_SPARC64
-static uint32_t compute_all_addx_xcc(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_xcc(CC_DST);
-    ret |= get_C_addx_xcc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_add_xcc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_addx_xcc(CPUSPARCState *env)
-{
-    return get_C_addx_xcc(CC_DST, CC_SRC, CC_SRC2);
-}
-#endif
-
-static uint32_t compute_all_addx(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_addx_icc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_add_icc(CC_DST, CC_SRC, CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_addx(CPUSPARCState *env)
-{
-    return get_C_addx_icc(CC_DST, CC_SRC, CC_SRC2);
-}
-
 static inline uint32_t get_V_tag_icc(target_ulong src1, target_ulong src2)
 {
     uint32_t ret = 0;
@@ -185,17 +143,6 @@ static inline uint32_t get_V_tag_icc(target_ulong src1, target_ulong src2)
     return ret;
 }
 
-static uint32_t compute_all_tadd(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_C_add_icc(CC_DST, CC_SRC);
-    ret |= get_V_add_icc(CC_DST, CC_SRC, CC_SRC2);
-    ret |= get_V_tag_icc(CC_SRC, CC_SRC2);
-    return ret;
-}
-
 static uint32_t compute_all_taddtv(CPUSPARCState *env)
 {
     uint32_t ret;
@@ -361,9 +308,6 @@ typedef struct CCTable {
 
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_ADD] = { compute_all_add, compute_C_add },
-    [CC_OP_ADDX] = { compute_all_addx, compute_C_addx },
-    [CC_OP_TADD] = { compute_all_tadd, compute_C_add },
     [CC_OP_TADDTV] = { compute_all_taddtv, compute_C_add },
     [CC_OP_SUB] = { compute_all_sub, compute_C_sub },
     [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
@@ -374,9 +318,6 @@ static const CCTable icc_table[CC_OP_NB] = {
 #ifdef TARGET_SPARC64
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_ADD] = { compute_all_add_xcc, compute_C_add_xcc },
-    [CC_OP_ADDX] = { compute_all_addx_xcc, compute_C_addx_xcc },
-    [CC_OP_TADD] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_TADDTV] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_SUB] = { compute_all_sub_xcc, compute_C_sub_xcc },
     [CC_OP_SUBX] = { compute_all_subx_xcc, compute_C_subx_xcc },
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 989275b17d..59e96bf39d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -380,12 +380,72 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
     }
 }
 
-static void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
+static TCGv gen_carry32(void)
 {
-    tcg_gen_mov_tl(cpu_cc_src, src1);
-    tcg_gen_mov_tl(cpu_cc_src2, src2);
-    tcg_gen_add_tl(cpu_cc_dst, cpu_cc_src, cpu_cc_src2);
-    tcg_gen_mov_tl(dst, cpu_cc_dst);
+#ifdef TARGET_SPARC64
+    TCGv t = tcg_temp_new();
+    tcg_gen_extract_tl(t, cpu_icc_C, 32, 1);
+    return t;
+#else
+    return cpu_icc_C;
+#endif
+}
+
+static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
+{
+    TCGv z = tcg_constant_tl(0);
+
+    if (cin) {
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+    } else {
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
+    }
+    tcg_gen_xor_tl(cpu_cc_Z, src1, src2);
+    tcg_gen_xor_tl(cpu_cc_V, cpu_cc_N, src2);
+    tcg_gen_andc_tl(cpu_cc_V, cpu_cc_V, cpu_cc_Z);
+#ifdef TARGET_SPARC64
+    /*
+     * Carry-in to bit 32 is result ^ src1 ^ src2.
+     * We already have the src xor term in Z, from computation of V.
+     */
+    tcg_gen_xor_tl(cpu_icc_C, cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
+#endif
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
+}
+
+static void gen_op_addcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addcc_int(dst, src1, src2, NULL);
+}
+
+static void gen_op_taddcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    TCGv t = tcg_temp_new();
+
+    /* Save the tag bits around modification of dst. */
+    tcg_gen_or_tl(t, src1, src2);
+
+    gen_op_addcc(dst, src1, src2);
+
+    /* Incorprate tag bits into icc.V */
+    tcg_gen_andi_tl(t, t, 3);
+    tcg_gen_neg_tl(t, t);
+    tcg_gen_ext32u_tl(t, t);
+    tcg_gen_or_tl(cpu_cc_N, cpu_cc_N, t);
+}
+
+static void gen_op_addc(TCGv dst, TCGv src1, TCGv src2)
+{
+    tcg_gen_add_tl(dst, src1, src2);
+    tcg_gen_add_tl(dst, dst, gen_carry32());
+}
+
+static void gen_op_addccc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addcc_int(dst, src1, src2, gen_carry32());
 }
 
 static TCGv_i32 gen_add32_carry32(void)
@@ -430,61 +490,6 @@ static TCGv_i32 gen_sub32_carry32(void)
     return carry_32;
 }
 
-static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
-                            TCGv src2, int update_cc)
-{
-    TCGv_i32 carry_32;
-    TCGv carry;
-
-    switch (dc->cc_op) {
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        if (TARGET_LONG_BITS == 32) {
-            /* We can re-use the host's hardware carry generation by using
-               an ADD2 opcode.  We discard the low part of the output.
-               Ideally we'd combine this operation with the add that
-               generated the carry in the first place.  */
-            carry = tcg_temp_new();
-            tcg_gen_add2_tl(carry, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-            goto add_done;
-        }
-        carry_32 = gen_add32_carry32();
-        break;
-
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        carry_32 = gen_sub32_carry32();
-        break;
-
-    default:
-        /* We need external help to produce the carry.  */
-        carry_32 = tcg_temp_new_i32();
-        gen_helper_compute_C_icc(carry_32, tcg_env);
-        break;
-    }
-
-#if TARGET_LONG_BITS == 64
-    carry = tcg_temp_new();
-    tcg_gen_extu_i32_i64(carry, carry_32);
-#else
-    carry = carry_32;
-#endif
-
-    tcg_gen_add_tl(dst, src1, src2);
-    tcg_gen_add_tl(dst, dst, carry);
-
- add_done:
-    if (update_cc) {
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-        tcg_gen_mov_tl(cpu_cc_dst, dst);
-        tcg_gen_movi_i32(cpu_cc_op, CC_OP_ADDX);
-        dc->cc_op = CC_OP_ADDX;
-    }
-}
-
 static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
@@ -500,8 +505,6 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     TCGv carry;
 
     switch (dc->cc_op) {
-    case CC_OP_ADD:
-    case CC_OP_TADD:
     case CC_OP_TADDTV:
         carry_32 = gen_add32_carry32();
         break;
@@ -550,39 +553,39 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
 
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
 {
-    TCGv r_temp, zero, t0;
+    TCGv zero = tcg_constant_tl(0);
+    TCGv t_src1 = tcg_temp_new();
+    TCGv t_src2 = tcg_temp_new();
+    TCGv t0 = tcg_temp_new();
 
-    r_temp = tcg_temp_new();
-    t0 = tcg_temp_new();
+    tcg_gen_ext32u_tl(t_src1, src1);
+    tcg_gen_ext32u_tl(t_src2, src2);
 
-    /* old op:
-    if (!(env->y & 1))
-        T1 = 0;
-    */
-    zero = tcg_constant_tl(0);
-    tcg_gen_andi_tl(cpu_cc_src, src1, 0xffffffff);
-    tcg_gen_andi_tl(r_temp, cpu_y, 0x1);
-    tcg_gen_andi_tl(cpu_cc_src2, src2, 0xffffffff);
-    tcg_gen_movcond_tl(TCG_COND_EQ, cpu_cc_src2, r_temp, zero,
-                       zero, cpu_cc_src2);
+    /*
+     * if (!(env->y & 1))
+     *   src2 = 0;
+     */
+    tcg_gen_andi_tl(t0, cpu_y, 0x1);
+    tcg_gen_movcond_tl(TCG_COND_EQ, t_src2, t0, zero, zero, t_src2);
 
-    // b2 = T0 & 1;
-    // env->y = (b2 << 31) | (env->y >> 1);
+    /*
+     * b2 = src1 & 1;
+     * y = (b2 << 31) | (y >> 1);
+     */
     tcg_gen_extract_tl(t0, cpu_y, 1, 31);
-    tcg_gen_deposit_tl(cpu_y, t0, cpu_cc_src, 31, 1);
+    tcg_gen_deposit_tl(cpu_y, t0, src1, 31, 1);
 
     // b1 = N ^ V;
     tcg_gen_xor_tl(t0, cpu_cc_N, cpu_cc_V);
 
-    // T0 = (b1 << 31) | (T0 >> 1);
-    // src1 = T0;
+    /*
+     * src1 = (b1 << 31) | (src1 >> 1)
+     */
     tcg_gen_andi_tl(t0, t0, 1u << 31);
-    tcg_gen_shri_tl(cpu_cc_src, cpu_cc_src, 1);
-    tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, t0);
+    tcg_gen_shri_tl(t_src1, t_src1, 1);
+    tcg_gen_or_tl(t_src1, t_src1, t0);
 
-    tcg_gen_add_tl(cpu_cc_dst, cpu_cc_src, cpu_cc_src2);
-
-    tcg_gen_mov_tl(dst, cpu_cc_dst);
+    gen_op_addcc(dst, t_src1, t_src2);
 }
 
 static void gen_op_multiply(TCGv dst, TCGv src1, TCGv src2, int sign_ext)
@@ -3787,7 +3790,7 @@ TRANS(SDIV, DIV, do_arith, a, gen_op_sdiv, NULL)
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
 TRANS(POPC, 64, do_arith, a, gen_op_popc, NULL)
 
-TRANS(ADDcc, ALL, do_cc_arith, a, CC_OP_ADD, gen_op_add_cc, NULL)
+TRANS(ADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_addcc)
 TRANS(ANDcc, ALL, do_logic_cc, a, tcg_gen_and_tl, tcg_gen_andi_tl)
 TRANS(ORcc, ALL, do_logic_cc, a, tcg_gen_or_tl, tcg_gen_ori_tl)
 TRANS(XORcc, ALL, do_logic_cc, a, tcg_gen_xor_tl, tcg_gen_xori_tl)
@@ -3799,7 +3802,7 @@ TRANS(UMULcc, MUL, do_logic_cc, a, gen_op_umul, NULL)
 TRANS(SMULcc, MUL, do_logic_cc, a, gen_op_smul, NULL)
 TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
 TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
-TRANS(TADDcc, ALL, do_cc_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
+TRANS(TADDcc, ALL, do_flags_arith, a, CC_OP_FLAGS, gen_op_taddcc)
 TRANS(TSUBcc, ALL, do_cc_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
 TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_TADDTV, gen_op_taddcctv)
 TRANS(TSUBccTV, ALL, do_flags_arith, a, CC_OP_TSUBTV, gen_op_tsubcctv)
@@ -3819,26 +3822,14 @@ static TCGv gen_rs2_or_imm(DisasContext *dc, bool imm, int rs2_or_imm)
 
 static bool trans_ADDC(DisasContext *dc, arg_r_r_ri *a)
 {
-    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
-
-    if (src2 == NULL) {
-        return false;
-    }
-    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
-                    gen_load_gpr(dc, a->rs1), src2, false);
-    return advance_pc(dc);
+    update_psr(dc);
+    return do_arith(dc, a, gen_op_addc, NULL);
 }
 
 static bool trans_ADDCcc(DisasContext *dc, arg_r_r_ri *a)
 {
-    TCGv src2 = gen_rs2_or_imm(dc, a->imm, a->rs2_or_imm);
-
-    if (src2 == NULL) {
-        return false;
-    }
-    gen_op_addx_int(dc, gen_dest_gpr(dc, a->rd),
-                    gen_load_gpr(dc, a->rs1), src2, true);
-    return advance_pc(dc);
+    update_psr(dc);
+    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_addccc);
 }
 
 static bool trans_SUBC(DisasContext *dc, arg_r_r_ri *a)
@@ -3868,7 +3859,7 @@ static bool trans_SUBCcc(DisasContext *dc, arg_r_r_ri *a)
 static bool trans_MULScc(DisasContext *dc, arg_r_r_ri *a)
 {
     update_psr(dc);
-    return do_cc_arith(dc, a, CC_OP_ADD, gen_op_mulscc, NULL);
+    return do_flags_arith(dc, a, CC_OP_FLAGS, gen_op_mulscc);
 }
 
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
-- 
2.34.1


