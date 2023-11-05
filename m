Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FAD7E164B
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU2-0003DB-JP; Sun, 05 Nov 2023 15:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU0-0003Br-Ri
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:32 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTy-00028L-IF
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:32 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6c3363a2b93so3349222b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215149; x=1699819949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=stMYGoZRgleysnGySsVwfhS7UeFFRKuKyGfp9j97in4=;
 b=tsPxpLQictrvEZHwV/OMGMEvhXH+YZAryGFaOBQiibq4ZTs+GlsyHO+L/8dsUZP2pP
 60sWR+Wt+QMlQ/Ey747sNVmxVhYofdLB7tmWrCfrXfCCchf5uvhqrjDtea4U/Df4CS/y
 wY2DSbpunlkL3NGLD2NucV6sC/j5zGD+8EZZkX1vaedWkknkJ1qqwFGDvKQLzaqgRPxX
 W9lZ3rcog3ZmTn2sM9i57jhNDWgKBm8cGhzIx5f714+bO0RQ3Wmi66kl3EO4M1Gjoqm6
 AJJ+GjpV2wJghBwXgajE0AsmsUh6bLaCxi8hW4fABFIlP4ac7QwMd5UcoS0r0G9/6X0s
 FKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215149; x=1699819949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=stMYGoZRgleysnGySsVwfhS7UeFFRKuKyGfp9j97in4=;
 b=qKjVzb3pX0Oh21G8MAFKtACku+KUWrA87yBUvj+xH5jyn/1yeH205gglGLZa8q8BgO
 J3c0bDCgo77B+5k/33vICdDzTAx5NEW+Y6TkwiYWAFA2V137TLuOAeEeP/T3cPiA1sUH
 96Lk3qF2CSOECA3bBZTqxJqPYVmJdSS2zFEYJKmbB4WdJF4ZSFZOOlDppB0QPTojwz4Y
 O9UurlbGJ/sde3rmpJdNmfjfw4qsRzvDLTS+gWD3mGli9VOneC/uz3U+4STc/a/xhj+z
 e/k1MNuObbKk1TWdZe+4Xzseq5Y4kZ8glnNW1/m929WzZmmXHXNleaUT3UbfGExSz9hU
 TvtQ==
X-Gm-Message-State: AOJu0Yy3FbLGcGwuAOAC1F/Sx4et3ShEF7nP9E7NN1MiCXf192EY2s5a
 PZqpRe6D2ngGd15iBC+4zVqbngGDPGm0bAM2YuM=
X-Google-Smtp-Source: AGHT+IFbO75Gzl4GHwne12FNniijtGApAyq0tb5n2F2hCuJoz63mayIQcdk4N0vzPC3kmIj+DAsCdQ==
X-Received: by 2002:a05:6a00:134b:b0:6be:1f19:e604 with SMTP id
 k11-20020a056a00134b00b006be1f19e604mr34549028pfu.21.1699215149262; 
 Sun, 05 Nov 2023 12:12:29 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 06/21] target/sparc: Remove CC_OP_SUB, CC_OP_SUBX, CC_OP_TSUB
Date: Sun,  5 Nov 2023 12:12:07 -0800
Message-Id: <20231105201222.202395-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

These are all related and implementable with common code.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   3 -
 target/sparc/cc_helper.c | 103 --------------------
 target/sparc/translate.c | 203 +++++++++------------------------------
 3 files changed, 45 insertions(+), 264 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 4ee8e2dc92..9884bd416a 100644
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
index 55bac722d2..20d451aa65 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -100,16 +100,6 @@ static uint32_t compute_C_add(CPUSPARCState *env)
     return get_C_add_icc(CC_DST, CC_SRC);
 }
 
-static inline uint32_t get_V_tag_icc(target_ulong src1, target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if ((src1 | src2) & 0x3) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
 static uint32_t compute_all_taddtv(CPUSPARCState *env)
 {
     uint32_t ret;
@@ -129,29 +119,6 @@ static inline uint32_t get_C_sub_icc(uint32_t src1, uint32_t src2)
     return ret;
 }
 
-static inline uint32_t get_C_subx_icc(uint32_t dst, uint32_t src1,
-                                      uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((~src1 & src2) | (dst & (~src1 | src2))) & (1U << 31)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_sub_icc(uint32_t dst, uint32_t src1,
-                                     uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2) & (src1 ^ dst)) & (1U << 31)) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
-
 #ifdef TARGET_SPARC64
 static inline uint32_t get_C_sub_xcc(target_ulong src1, target_ulong src2)
 {
@@ -163,17 +130,6 @@ static inline uint32_t get_C_sub_xcc(target_ulong src1, target_ulong src2)
     return ret;
 }
 
-static inline uint32_t get_C_subx_xcc(target_ulong dst, target_ulong src1,
-                                      target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((~src1 & src2) | (dst & (~src1 | src2))) & (1ULL << 63)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
 static inline uint32_t get_V_sub_xcc(target_ulong dst, target_ulong src1,
                                      target_ulong src2)
 {
@@ -201,64 +157,11 @@ static uint32_t compute_C_sub_xcc(CPUSPARCState *env)
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
@@ -276,9 +179,6 @@ typedef struct CCTable {
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
     [CC_OP_TADDTV] = { compute_all_taddtv, compute_C_add },
-    [CC_OP_SUB] = { compute_all_sub, compute_C_sub },
-    [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
-    [CC_OP_TSUB] = { compute_all_tsub, compute_C_sub },
     [CC_OP_TSUBTV] = { compute_all_tsubtv, compute_C_sub },
 };
 
@@ -286,9 +186,6 @@ static const CCTable icc_table[CC_OP_NB] = {
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
index cf121a237d..d119ce4c94 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -449,107 +449,58 @@ static void gen_op_addccc(TCGv dst, TCGv src1, TCGv src2)
     gen_op_addcc_int(dst, src1, src2, gen_carry32());
 }
 
-static TCGv_i32 gen_sub32_carry32(void)
+static void gen_op_subcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
 {
-    TCGv_i32 carry_32, cc_src1_32, cc_src2_32;
+    TCGv z = tcg_constant_tl(0);
 
-    /* Carry is computed from a previous borrow: (src1 < src2)  */
-#if TARGET_LONG_BITS == 64
-    cc_src1_32 = tcg_temp_new_i32();
-    cc_src2_32 = tcg_temp_new_i32();
-    tcg_gen_extrl_i64_i32(cc_src1_32, cpu_cc_src);
-    tcg_gen_extrl_i64_i32(cc_src2_32, cpu_cc_src2);
-#else
-    cc_src1_32 = cpu_cc_src;
-    cc_src2_32 = cpu_cc_src2;
+    if (cin) {
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+    } else {
+        tcg_gen_sub2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
+    }
+    tcg_gen_neg_tl(cpu_cc_C, cpu_cc_C);
+    tcg_gen_xor_tl(cpu_cc_Z, src1, src2);
+    tcg_gen_xor_tl(cpu_cc_V, cpu_cc_N, src1);
+    tcg_gen_and_tl(cpu_cc_V, cpu_cc_V, cpu_cc_Z);
+#ifdef TARGET_SPARC64
+    tcg_gen_xor_tl(cpu_icc_C, cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
 #endif
-
-    carry_32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i32(TCG_COND_LTU, carry_32, cc_src1_32, cc_src2_32);
-
-    return carry_32;
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
 }
 
-static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
+static void gen_op_subcc(TCGv dst, TCGv src1, TCGv src2)
 {
-    tcg_gen_mov_tl(cpu_cc_src, src1);
-    tcg_gen_mov_tl(cpu_cc_src2, src2);
-    tcg_gen_sub_tl(cpu_cc_dst, cpu_cc_src, cpu_cc_src2);
-    tcg_gen_mov_tl(dst, cpu_cc_dst);
+    gen_op_subcc_int(dst, src1, src2, NULL);
 }
 
-static void gen_op_subc_int(TCGv dst, TCGv src1, TCGv src2,
-                            TCGv_i32 carry_32, bool update_cc)
+static void gen_op_tsubcc(TCGv dst, TCGv src1, TCGv src2)
 {
-    TCGv carry;
+    TCGv t = tcg_temp_new();
 
-#if TARGET_LONG_BITS == 64
-    carry = tcg_temp_new();
-    tcg_gen_extu_i32_i64(carry, carry_32);
-#else
-    carry = carry_32;
-#endif
+    /* Save the tag bits around modification of dst. */
+    tcg_gen_or_tl(t, src1, src2);
 
+    gen_op_subcc(dst, src1, src2);
+
+    /* Incorprate tag bits into icc.V */
+    tcg_gen_andi_tl(t, t, 3);
+    tcg_gen_neg_tl(t, t);
+    tcg_gen_ext32u_tl(t, t);
+    tcg_gen_or_tl(cpu_cc_V, cpu_cc_V, t);
+}
+
+static void gen_op_subc(TCGv dst, TCGv src1, TCGv src2)
+{
     tcg_gen_sub_tl(dst, src1, src2);
-    tcg_gen_sub_tl(dst, dst, carry);
-
-    if (update_cc) {
-        tcg_debug_assert(dst == cpu_cc_dst);
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-    }
+    tcg_gen_sub_tl(dst, dst, gen_carry32());
 }
 
-static void gen_op_subc_int_sub(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
+static void gen_op_subccc(TCGv dst, TCGv src1, TCGv src2)
 {
-    TCGv discard;
-
-    if (TARGET_LONG_BITS == 64) {
-        gen_op_subc_int(dst, src1, src2, gen_sub32_carry32(), update_cc);
-        return;
-    }
-
-    /*
-     * We can re-use the host's hardware carry generation by using
-     * a SUB2 opcode.  We discard the low part of the output.
-     */
-    discard = tcg_temp_new();
-    tcg_gen_sub2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-
-    if (update_cc) {
-        tcg_debug_assert(dst == cpu_cc_dst);
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-    }
-}
-
-static void gen_op_subc_sub(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int_sub(dst, src1, src2, false);
-}
-
-static void gen_op_subccc_sub(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int_sub(dst, src1, src2, true);
-}
-
-static void gen_op_subc_int_generic(TCGv dst, TCGv src1, TCGv src2,
-                                    bool update_cc)
-{
-    TCGv_i32 carry_32 = tcg_temp_new_i32();
-
-    gen_helper_compute_C_icc(carry_32, tcg_env);
-    gen_op_subc_int(dst, src1, src2, carry_32, update_cc);
-}
-
-static void gen_op_subc_generic(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int_generic(dst, src1, src2, false);
-}
-
-static void gen_op_subccc_generic(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int_generic(dst, src1, src2, true);
+    gen_op_subcc_int(dst, src1, src2, gen_carry32());
 }
 
 static void gen_op_mulscc(TCGv dst, TCGv src1, TCGv src2)
@@ -1097,65 +1048,11 @@ static void gen_op_next_insn(void)
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
@@ -3696,11 +3593,11 @@ static bool do_logic(DisasContext *dc, arg_r_r_ri_cc *a,
 
 TRANS(ADD, ALL, do_arith, a, CC_OP_FLAGS,
       tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_addcc)
-TRANS(SUB, ALL, do_arith, a, CC_OP_SUB,
-      tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc)
+TRANS(SUB, ALL, do_arith, a, CC_OP_FLAGS,
+      tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_subcc)
 
 TRANS(TADDcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcc)
-TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, NULL, NULL, gen_op_sub_cc)
+TRANS(TSUBcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_tsubcc)
 TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
 TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
 
@@ -3747,16 +3644,8 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
 
 static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
-    switch (dc->cc_op) {
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        return do_arith(dc, a, CC_OP_SUBX,
-                        gen_op_subc_sub, NULL, gen_op_subccc_sub);
-    default:
-        return do_arith(dc, a, CC_OP_SUBX,
-                        gen_op_subc_generic, NULL, gen_op_subccc_generic);
-    }
+    update_psr(dc);
+    return do_arith(dc, a, CC_OP_FLAGS, gen_op_subc, NULL, gen_op_subccc);
 }
 
 static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
@@ -3777,11 +3666,9 @@ static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
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


