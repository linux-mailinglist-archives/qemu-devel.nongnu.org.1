Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B97E1653
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:16:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU3-0003Dp-Lq; Sun, 05 Nov 2023 15:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU1-0003CD-E4
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:33 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTy-00028D-Pc
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:33 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6c115026985so3978633b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215148; x=1699819948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQpQdg+Ve47t9/0/acUoknVWsHwfL0jjHwsIbvpzlWw=;
 b=sCCu49mScnBIGVo+hEgVbkYAk530aaXCXAnY1JwjgGDqN2YIuMDLpWablajbBbmtiV
 +8yiSIuPiltmClitlvv9pdkJyujDXOgqaRNgjf4vB+vebVDMPjw2oZE3EYUlA7Ou37ei
 YvyP2HevrEjPUOmZEqxCrMvKdAdNAGnlHxDoTp/OYfMZ4v29smp7H9PO8PrSHiPlo0D0
 e/hVKmbLwo/boJZEK3xOfmPsMakQFDqb6M9SsIGZBOzj8tcoK9B4eXoiBah2hmQky+j1
 3O/4TLfyAr8nxq6M5FfNdJovC+ZjYuEZ5z5ZPGy9qDArNCp0cU56+PV6aOURrJqQIsuh
 Ko+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215148; x=1699819948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQpQdg+Ve47t9/0/acUoknVWsHwfL0jjHwsIbvpzlWw=;
 b=k9mqgNNCh7QWti5RUTddR7udi2bj4QieZWXKa6nXAE/x0aH0W5xBCiyT6pc5/IsFbr
 hgY48Fqr46Y811+rF3KaCDI1YD+sfg28TFOY9eq2DGmRks/IwRx38scOAHFQ/GzEsryd
 R3sJNBafGZb6zy6ov9ffMfbinkENt35ZzWtJlTC/+UShS5Ny06Il1VjouWuw2+0kLAxh
 PU3lD41URKhsykkmrrsSUiuxKxuVgD5oFbE5soL1MnyjSgHhnldL1ZPT3nvf4XHNEmrV
 Zklf31x/QFJP0Rz/SRuuTVpx/xcvTdNxqZ594L4rBr+/RlIkZjSLgjkQ8kNg8CfJY00Q
 3wYg==
X-Gm-Message-State: AOJu0YxvAj9zvFycmZ0MDtVx7I2PJ9fqpK2H8yYasvB/DfV8n2/U4aeZ
 9rMQW5YzgjVqw/qhXQxeZACMJ2WtmygpJN6Jkm8=
X-Google-Smtp-Source: AGHT+IHX8FJeVJhPV14OZBmX0hWZ65RBPraYCeNQeVIJXtjxR27nAnWEjKH5/UgCSuI35ZyldFTinQ==
X-Received: by 2002:a05:6a00:190b:b0:6bd:a8a3:cc59 with SMTP id
 y11-20020a056a00190b00b006bda8a3cc59mr30284515pfi.24.1699215148464; 
 Sun, 05 Nov 2023 12:12:28 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 05/21] target/sparc: Remove CC_OP_ADD, CC_OP_ADDX, CC_OP_TADD
Date: Sun,  5 Nov 2023 12:12:06 -0800
Message-Id: <20231105201222.202395-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 target/sparc/cc_helper.c |  92 ---------------
 target/sparc/translate.c | 247 ++++++++++++++-------------------------
 3 files changed, 87 insertions(+), 255 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b16d53b91f..4ee8e2dc92 100644
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
index 5400dfec15..55bac722d2 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -57,28 +57,6 @@ static inline uint32_t get_C_add_icc(uint32_t dst, uint32_t src1)
     return ret;
 }
 
-static inline uint32_t get_C_addx_icc(uint32_t dst, uint32_t src1,
-                                      uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 & src2) | (~dst & (src1 | src2))) & (1U << 31)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
-static inline uint32_t get_V_add_icc(uint32_t dst, uint32_t src1,
-                                     uint32_t src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 ^ src2 ^ -1) & (src1 ^ dst)) & (1U << 31)) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
 #ifdef TARGET_SPARC64
 static inline uint32_t get_C_add_xcc(target_ulong dst, target_ulong src1)
 {
@@ -90,17 +68,6 @@ static inline uint32_t get_C_add_xcc(target_ulong dst, target_ulong src1)
     return ret;
 }
 
-static inline uint32_t get_C_addx_xcc(target_ulong dst, target_ulong src1,
-                                      target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (((src1 & src2) | (~dst & (src1 | src2))) & (1ULL << 63)) {
-        ret = PSR_CARRY;
-    }
-    return ret;
-}
-
 static inline uint32_t get_V_add_xcc(target_ulong dst, target_ulong src1,
                                      target_ulong src2)
 {
@@ -128,53 +95,11 @@ static uint32_t compute_C_add_xcc(CPUSPARCState *env)
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
@@ -185,17 +110,6 @@ static inline uint32_t get_V_tag_icc(target_ulong src1, target_ulong src2)
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
@@ -361,9 +275,6 @@ typedef struct CCTable {
 
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_ADD] = { compute_all_add, compute_C_add },
-    [CC_OP_ADDX] = { compute_all_addx, compute_C_addx },
-    [CC_OP_TADD] = { compute_all_tadd, compute_C_add },
     [CC_OP_TADDTV] = { compute_all_taddtv, compute_C_add },
     [CC_OP_SUB] = { compute_all_sub, compute_C_sub },
     [CC_OP_SUBX] = { compute_all_subx, compute_C_subx },
@@ -374,9 +285,6 @@ static const CCTable icc_table[CC_OP_NB] = {
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
index fa4bad6d1f..cf121a237d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -382,33 +382,71 @@ static void gen_goto_tb(DisasContext *s, int tb_num,
     }
 }
 
-static void gen_op_add_cc(TCGv dst, TCGv src1, TCGv src2)
+static TCGv gen_carry32(void)
 {
-    tcg_gen_mov_tl(cpu_cc_src, src1);
-    tcg_gen_mov_tl(cpu_cc_src2, src2);
-    tcg_gen_add_tl(cpu_cc_dst, cpu_cc_src, cpu_cc_src2);
-    tcg_gen_mov_tl(dst, cpu_cc_dst);
+    if (TARGET_LONG_BITS == 64) {
+        TCGv t = tcg_temp_new();
+        tcg_gen_extract_tl(t, cpu_icc_C, 32, 1);
+        return t;
+    }
+    return cpu_icc_C;
 }
 
-static TCGv_i32 gen_add32_carry32(void)
+static void gen_op_addcc_int(TCGv dst, TCGv src1, TCGv src2, TCGv cin)
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
+    if (cin) {
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, cin, z);
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, cpu_cc_N, cpu_cc_C, src2, z);
+    } else {
+        tcg_gen_add2_tl(cpu_cc_N, cpu_cc_C, src1, z, src2, z);
+    }
+    tcg_gen_xor_tl(cpu_cc_Z, src1, src2);
+    tcg_gen_xor_tl(cpu_cc_V, cpu_cc_N, src2);
+    tcg_gen_andc_tl(cpu_cc_V, cpu_cc_V, cpu_cc_Z);
+    if (TARGET_LONG_BITS == 64) {
+        /*
+         * Carry-in to bit 32 is result ^ src1 ^ src2.
+         * We already have the src xor term in Z, from computation of V.
+         */
+        tcg_gen_xor_tl(cpu_icc_C, cpu_cc_Z, cpu_cc_N);
+        tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
+    }
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
+}
 
-    carry_32 = tcg_temp_new_i32();
-    tcg_gen_setcond_i32(TCG_COND_LTU, carry_32, cc_src1_32, cc_src2_32);
+static void gen_op_addcc(TCGv dst, TCGv src1, TCGv src2)
+{
+    gen_op_addcc_int(dst, src1, src2, NULL);
+}
 
-    return carry_32;
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
+    tcg_gen_or_tl(cpu_cc_V, cpu_cc_V, t);
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
 
 static TCGv_i32 gen_sub32_carry32(void)
@@ -432,89 +470,6 @@ static TCGv_i32 gen_sub32_carry32(void)
     return carry_32;
 }
 
-static void gen_op_addc_int(TCGv dst, TCGv src1, TCGv src2,
-                            TCGv_i32 carry_32, bool update_cc)
-{
-    tcg_gen_add_tl(dst, src1, src2);
-
-#ifdef TARGET_SPARC64
-    TCGv carry = tcg_temp_new();
-    tcg_gen_extu_i32_tl(carry, carry_32);
-    tcg_gen_add_tl(dst, dst, carry);
-#else
-    tcg_gen_add_i32(dst, dst, carry_32);
-#endif
-
-    if (update_cc) {
-        tcg_debug_assert(dst == cpu_cc_dst);
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-    }
-}
-
-static void gen_op_addc_int_add(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
-{
-    TCGv discard;
-
-    if (TARGET_LONG_BITS == 64) {
-        gen_op_addc_int(dst, src1, src2, gen_add32_carry32(), update_cc);
-        return;
-    }
-
-    /*
-     * We can re-use the host's hardware carry generation by using
-     * an ADD2 opcode.  We discard the low part of the output.
-     * Ideally we'd combine this operation with the add that
-     * generated the carry in the first place.
-     */
-    discard = tcg_temp_new();
-    tcg_gen_add2_tl(discard, dst, cpu_cc_src, src1, cpu_cc_src2, src2);
-
-    if (update_cc) {
-        tcg_debug_assert(dst == cpu_cc_dst);
-        tcg_gen_mov_tl(cpu_cc_src, src1);
-        tcg_gen_mov_tl(cpu_cc_src2, src2);
-    }
-}
-
-static void gen_op_addc_add(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int_add(dst, src1, src2, false);
-}
-
-static void gen_op_addccc_add(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int_add(dst, src1, src2, true);
-}
-
-static void gen_op_addc_sub(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), false);
-}
-
-static void gen_op_addccc_sub(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int(dst, src1, src2, gen_sub32_carry32(), true);
-}
-
-static void gen_op_addc_int_generic(TCGv dst, TCGv src1, TCGv src2,
-                                    bool update_cc)
-{
-    TCGv_i32 carry_32 = tcg_temp_new_i32();
-    gen_helper_compute_C_icc(carry_32, tcg_env);
-    gen_op_addc_int(dst, src1, src2, carry_32, update_cc);
-}
-
-static void gen_op_addc_generic(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int_generic(dst, src1, src2, false);
-}
-
-static void gen_op_addccc_generic(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_addc_int_generic(dst, src1, src2, true);
-}
-
 static void gen_op_sub_cc(TCGv dst, TCGv src1, TCGv src2)
 {
     tcg_gen_mov_tl(cpu_cc_src, src1);
@@ -545,16 +500,6 @@ static void gen_op_subc_int(TCGv dst, TCGv src1, TCGv src2,
     }
 }
 
-static void gen_op_subc_add(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int(dst, src1, src2, gen_add32_carry32(), false);
-}
-
-static void gen_op_subccc_add(TCGv dst, TCGv src1, TCGv src2)
-{
-    gen_op_subc_int(dst, src1, src2, gen_add32_carry32(), true);
-}
-
 static void gen_op_subc_int_sub(TCGv dst, TCGv src1, TCGv src2, bool update_cc)
 {
     TCGv discard;
@@ -609,39 +554,39 @@ static void gen_op_subccc_generic(TCGv dst, TCGv src1, TCGv src2)
 
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
@@ -3749,12 +3694,12 @@ static bool do_logic(DisasContext *dc, arg_r_r_ri_cc *a,
     return do_arith_int(dc, a, CC_OP_FLAGS, func, funci, a->cc);
 }
 
-TRANS(ADD, ALL, do_arith, a, CC_OP_ADD,
-      tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_add_cc)
+TRANS(ADD, ALL, do_arith, a, CC_OP_FLAGS,
+      tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_addcc)
 TRANS(SUB, ALL, do_arith, a, CC_OP_SUB,
       tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc)
 
-TRANS(TADDcc, ALL, do_arith, a, CC_OP_TADD, NULL, NULL, gen_op_add_cc)
+TRANS(TADDcc, ALL, do_arith, a, CC_OP_FLAGS, NULL, NULL, gen_op_taddcc)
 TRANS(TSUBcc, ALL, do_arith, a, CC_OP_TSUB, NULL, NULL, gen_op_sub_cc)
 TRANS(TADDccTV, ALL, do_arith, a, CC_OP_TADDTV, NULL, NULL, gen_op_taddcctv)
 TRANS(TSUBccTV, ALL, do_arith, a, CC_OP_TSUBTV, NULL, NULL, gen_op_tsubcctv)
@@ -3796,31 +3741,13 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 
 static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
-    switch (dc->cc_op) {
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        return do_arith(dc, a, CC_OP_ADDX,
-                        gen_op_addc_add, NULL, gen_op_addccc_add);
-    case CC_OP_SUB:
-    case CC_OP_TSUB:
-    case CC_OP_TSUBTV:
-        return do_arith(dc, a, CC_OP_ADDX,
-                        gen_op_addc_sub, NULL, gen_op_addccc_sub);
-    default:
-        return do_arith(dc, a, CC_OP_ADDX,
-                        gen_op_addc_generic, NULL, gen_op_addccc_generic);
-    }
+    update_psr(dc);
+    return do_arith(dc, a, CC_OP_FLAGS, gen_op_addc, NULL, gen_op_addccc);
 }
 
 static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     switch (dc->cc_op) {
-    case CC_OP_ADD:
-    case CC_OP_TADD:
-    case CC_OP_TADDTV:
-        return do_arith(dc, a, CC_OP_SUBX,
-                        gen_op_subc_add, NULL, gen_op_subccc_add);
     case CC_OP_SUB:
     case CC_OP_TSUB:
     case CC_OP_TSUBTV:
@@ -3835,7 +3762,7 @@ static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
 static bool trans_MULScc(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     update_psr(dc);
-    return do_arith(dc, a, CC_OP_ADD, NULL, NULL, gen_op_mulscc);
+    return do_arith(dc, a, CC_OP_FLAGS, NULL, NULL, gen_op_mulscc);
 }
 
 static bool gen_edge(DisasContext *dc, arg_r_r_r *a,
-- 
2.34.1


