Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 845887DDBD6
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:14:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy2a0-0005uf-36; Wed, 01 Nov 2023 00:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zx-0005tn-Qh
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qy2Zv-0007V9-HB
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:11:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so6446743b3a.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698811898; x=1699416698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU9kl1tvqp+dGRCb8+cBZp25kZ1mMKvJS8PKPxqM1sQ=;
 b=bhFHdHSy9S7oGDDFLITgPUhdUy7P2p2Hq2v7GPfdFcf8ruHYwGOJsNVaq7wPLYRKeW
 LXO+pF+vWkVkUC+LQ7f4SjuYGcXE9aOmxVWTqjQF+URPVRSWQmPeZIWRD1vdu2yKBqle
 csM2JCbxS2TqxsX4DaylOXoHfHQT3LWVUW0M72auSAmtfN82LAGwm8RmJC+I2JwGIIcq
 2SqgLfet6j71rdu7tCpXe6oa8Qj1gztWMpocGh00B6DHyUzdAR5lelspuwRSFW+JFQnH
 OJVc7Cr8ZjD7l6naw8cxQrvI3gpVdGGdoh1L4Ezrl8Dwm0HwLOOIZo+xnvgxFm7l6F3O
 qSsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698811898; x=1699416698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dU9kl1tvqp+dGRCb8+cBZp25kZ1mMKvJS8PKPxqM1sQ=;
 b=PSvlx/WG6lnluPEV0qaNoK3o8JEeblDIFXL96KRIwDW6Gl1PUakjI68PP7NUZrp+zH
 JUN/Ct1BKxgQv9wPfTuHXMQfIaogG3bv0dNRCyUBUmfigueHxI9Mt0bYgXICAPBASJAJ
 zaRPpOBNTpT33Q+6ZHrYmKze24pf8K+D1QdxBJPOBbh3GulN4aSb1z0Gcg7mzS/iKJx8
 rwfgUgwGcTsIrsic1Ws1WH49a+ivUQw2s6Q/0GiaQYGKrL8+7uGHXPV9WwfTyxtNbcUC
 NekAtgCrLiy0FtF01IQBH5u7G/puA/XmUpzBl/J0W7dE21b668hEx/SBmEQHD7zvUysX
 6afA==
X-Gm-Message-State: AOJu0YzGDgHkeh+ycMKxRwGJvfiqpCdxWd1CsNFS5GXeslPZ+DhKeTOD
 MFtocW3DDMD9cOEDUqhFHWxoDTryPtvsOL92jwY=
X-Google-Smtp-Source: AGHT+IHTfwi/JPeial8CSJ2W2noGdOagqwfJ5dZ5NIJCaK7sFO5t2NAY/95/JZJH7tZDQwHAPA09DQ==
X-Received: by 2002:a05:6a00:16d5:b0:6bb:def8:b0a7 with SMTP id
 l21-20020a056a0016d500b006bbdef8b0a7mr18117249pfc.3.1698811897907; 
 Tue, 31 Oct 2023 21:11:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k8-20020aa79728000000b006875df4773fsm359576pfg.163.2023.10.31.21.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 21:11:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 04/21] target/sparc: Remove CC_OP_DIV
Date: Tue, 31 Oct 2023 21:11:15 -0700
Message-Id: <20231101041132.174501-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101041132.174501-1-richard.henderson@linaro.org>
References: <20231101041132.174501-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Return both result and overflow from helper_[us]div.
Compute all flags explicitly in gen_op_[us]divcc.

Marginally improve the INT64_MIN special case in do_sdiv.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |   1 -
 target/sparc/helper.h    |   6 +--
 target/sparc/cc_helper.c |  33 -------------
 target/sparc/helper.c    | 101 ++++++++++++++-------------------------
 target/sparc/translate.c |  70 ++++++++++++++++++++++-----
 5 files changed, 97 insertions(+), 114 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 202c34f7ca..b16d53b91f 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -150,7 +150,6 @@ enum {
 enum {
     CC_OP_DYNAMIC, /* must use dynamic code to get cc_op */
     CC_OP_FLAGS,   /* all cc are back in cc_*_[NZCV] registers */
-    CC_OP_DIV,     /* modify N, Z and V, C = 0*/
     CC_OP_ADD,     /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_ADDX,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
     CC_OP_TADD,    /* modify all flags, CC_DST = res, CC_SRC = src1 */
diff --git a/target/sparc/helper.h b/target/sparc/helper.h
index dd1721a340..a7b0079c3b 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -27,10 +27,8 @@ DEF_HELPER_FLAGS_2(tick_set_limit, TCG_CALL_NO_RWG, void, ptr, i64)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_1(save, void, env)
 DEF_HELPER_1(restore, void, env)
-DEF_HELPER_3(udiv, tl, env, tl, tl)
-DEF_HELPER_3(udiv_cc, tl, env, tl, tl)
-DEF_HELPER_3(sdiv, tl, env, tl, tl)
-DEF_HELPER_3(sdiv_cc, tl, env, tl, tl)
+DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, i64, env, tl, tl)
+DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, i64, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index 1622300a14..5400dfec15 100644
--- a/target/sparc/cc_helper.c
+++ b/target/sparc/cc_helper.c
@@ -47,30 +47,6 @@ static inline uint32_t get_NZ_xcc(target_long dst)
 }
 #endif
 
-static inline uint32_t get_V_div_icc(target_ulong src2)
-{
-    uint32_t ret = 0;
-
-    if (src2 != 0) {
-        ret = PSR_OVF;
-    }
-    return ret;
-}
-
-static uint32_t compute_all_div(CPUSPARCState *env)
-{
-    uint32_t ret;
-
-    ret = get_NZ_icc(CC_DST);
-    ret |= get_V_div_icc(CC_SRC2);
-    return ret;
-}
-
-static uint32_t compute_C_div(CPUSPARCState *env)
-{
-    return 0;
-}
-
 static inline uint32_t get_C_add_icc(uint32_t dst, uint32_t src1)
 {
     uint32_t ret = 0;
@@ -378,13 +354,6 @@ static uint32_t compute_all_tsubtv(CPUSPARCState *env)
     return ret;
 }
 
-#ifdef TARGET_SPARC64
-static uint32_t compute_all_logic_xcc(CPUSPARCState *env)
-{
-    return get_NZ_xcc(CC_DST);
-}
-#endif
-
 typedef struct CCTable {
     uint32_t (*compute_all)(CPUSPARCState *env); /* return all the flags */
     uint32_t (*compute_c)(CPUSPARCState *env);  /* return the C flag */
@@ -392,7 +361,6 @@ typedef struct CCTable {
 
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_DIV] = { compute_all_div, compute_C_div },
     [CC_OP_ADD] = { compute_all_add, compute_C_add },
     [CC_OP_ADDX] = { compute_all_addx, compute_C_addx },
     [CC_OP_TADD] = { compute_all_tadd, compute_C_add },
@@ -406,7 +374,6 @@ static const CCTable icc_table[CC_OP_NB] = {
 #ifdef TARGET_SPARC64
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_DIV] = { compute_all_logic_xcc, compute_C_div },
     [CC_OP_ADD] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_ADDX] = { compute_all_addx_xcc, compute_C_addx_xcc },
     [CC_OP_TADD] = { compute_all_add_xcc, compute_C_add_xcc },
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 2bcdc81d54..53eec693dd 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -81,79 +81,52 @@ void helper_tick_set_limit(void *opaque, uint64_t limit)
 }
 #endif
 
-static target_ulong do_udiv(CPUSPARCState *env, target_ulong a,
-                            target_ulong b, int cc, uintptr_t ra)
+uint64_t helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
 {
-    int overflow = 0;
-    uint64_t x0;
-    uint32_t x1;
+    uint64_t a64 = (uint32_t)a | ((uint64_t)env->y << 32);
+    uint32_t b32 = b;
+    uint32_t r;
 
-    x0 = (a & 0xffffffff) | ((int64_t) (env->y) << 32);
-    x1 = (b & 0xffffffff);
-
-    if (x1 == 0) {
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, ra);
+    if (b32 == 0) {
+        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
     }
 
-    x0 = x0 / x1;
-    if (x0 > UINT32_MAX) {
-        x0 = UINT32_MAX;
-        overflow = 1;
+    a64 /= b32;
+    r = a64;
+    if (unlikely(a64 > UINT32_MAX)) {
+        return -1; /* r = UINT32_MAX, v = 1 */
+    }
+    return r;
+}
+
+uint64_t helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
+{
+    int64_t a64 = (uint32_t)a | ((uint64_t)env->y << 32);
+    int32_t b32 = b;
+    int32_t r;
+
+    if (b32 == 0) {
+        cpu_raise_exception_ra(env, TT_DIV_ZERO, GETPC());
     }
 
-    if (cc) {
-        env->cc_src2 = overflow;
-    }
-    return x0;
-}
-
-target_ulong helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_udiv(env, a, b, 0, GETPC());
-}
-
-target_ulong helper_udiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_udiv(env, a, b, 1, GETPC());
-}
-
-static target_ulong do_sdiv(CPUSPARCState *env, target_ulong a,
-                            target_ulong b, int cc, uintptr_t ra)
-{
-    int overflow = 0;
-    int64_t x0;
-    int32_t x1;
-
-    x0 = (a & 0xffffffff) | ((int64_t) (env->y) << 32);
-    x1 = (b & 0xffffffff);
-
-    if (x1 == 0) {
-        cpu_raise_exception_ra(env, TT_DIV_ZERO, ra);
-    } else if (x1 == -1 && x0 == INT64_MIN) {
-        x0 = INT32_MAX;
-        overflow = 1;
-    } else {
-        x0 = x0 / x1;
-        if ((int32_t) x0 != x0) {
-            x0 = x0 < 0 ? INT32_MIN : INT32_MAX;
-            overflow = 1;
-        }
+    if (unlikely(a64 == INT64_MIN)) {
+        /*
+         * Special case INT64_MIN / -1 is required to avoid trap on x86 host.
+         * However, with a dividend of INT64_MIN, there is no 32-bit divisor
+         * which can yield a 32-bit result:
+         *    INT64_MIN / INT32_MIN =  0x1_0000_0000
+         *    INT64_MIN / INT32_MAX = -0x1_0000_0002
+         * Therefore we know we must overflow and saturate.
+         */
+        return (uint32_t)(b32 < 0 ? INT32_MAX : INT32_MIN) | (-1ull << 32);
     }
 
-    if (cc) {
-        env->cc_src2 = overflow;
+    a64 /= b;
+    r = a64;
+    if (unlikely(r != a64)) {
+        return (uint32_t)(a64 < 0 ? INT32_MIN : INT32_MAX) | (-1ull << 32);
     }
-    return x0;
-}
-
-target_ulong helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_sdiv(env, a, b, 0, GETPC());
-}
-
-target_ulong helper_sdiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
-{
-    return do_sdiv(env, a, b, 1, GETPC());
+    return (uint32_t)r;
 }
 
 #ifdef TARGET_SPARC64
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b11d89343b..fa4bad6d1f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -693,22 +693,76 @@ static void gen_op_sdivx(TCGv dst, TCGv src1, TCGv src2)
 
 static void gen_op_udiv(TCGv dst, TCGv src1, TCGv src2)
 {
+#ifdef TARGET_SPARC64
     gen_helper_udiv(dst, tcg_env, src1, src2);
+    tcg_gen_ext32u_tl(dst, dst);
+#else
+    TCGv_i64 t64 = tcg_temp_new_i64();
+    gen_helper_udiv(t64, tcg_env, src1, src2);
+    tcg_gen_trunc_i64_tl(dst, t64);
+#endif
 }
 
 static void gen_op_sdiv(TCGv dst, TCGv src1, TCGv src2)
 {
+#ifdef TARGET_SPARC64
     gen_helper_sdiv(dst, tcg_env, src1, src2);
+    tcg_gen_ext32s_tl(dst, dst);
+#else
+    TCGv_i64 t64 = tcg_temp_new_i64();
+    gen_helper_sdiv(t64, tcg_env, src1, src2);
+    tcg_gen_trunc_i64_tl(dst, t64);
+#endif
 }
 
 static void gen_op_udivcc(TCGv dst, TCGv src1, TCGv src2)
 {
-    gen_helper_udiv_cc(dst, tcg_env, src1, src2);
+    TCGv_i64 t64;
+
+#ifdef TARGET_SPARC64
+    t64 = cpu_cc_V;
+#else
+    t64 = tcg_temp_new_i64();
+#endif
+
+    gen_helper_udiv(t64, tcg_env, src1, src2);
+
+#ifdef TARGET_SPARC64
+    tcg_gen_ext32u_tl(cpu_cc_N, t64);
+    tcg_gen_shri_tl(cpu_cc_V, t64, 32);
+    tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
+    tcg_gen_movi_tl(cpu_icc_C, 0);
+#else
+    tcg_gen_extr_i64_tl(cpu_cc_N, cpu_cc_V, t64);
+#endif
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_movi_tl(cpu_cc_C, 0);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
 }
 
 static void gen_op_sdivcc(TCGv dst, TCGv src1, TCGv src2)
 {
-    gen_helper_sdiv_cc(dst, tcg_env, src1, src2);
+    TCGv_i64 t64;
+
+#ifdef TARGET_SPARC64
+    t64 = cpu_cc_V;
+#else
+    t64 = tcg_temp_new_i64();
+#endif
+
+    gen_helper_sdiv(t64, tcg_env, src1, src2);
+
+#ifdef TARGET_SPARC64
+    tcg_gen_ext32s_tl(cpu_cc_N, t64);
+    tcg_gen_shri_tl(cpu_cc_V, t64, 32);
+    tcg_gen_mov_tl(cpu_icc_Z, cpu_cc_N);
+    tcg_gen_movi_tl(cpu_icc_C, 0);
+#else
+    tcg_gen_extr_i64_tl(cpu_cc_N, cpu_cc_V, t64);
+#endif
+    tcg_gen_mov_tl(cpu_cc_Z, cpu_cc_N);
+    tcg_gen_movi_tl(cpu_cc_C, 0);
+    tcg_gen_mov_tl(dst, cpu_cc_N);
 }
 
 static void gen_op_taddcctv(TCGv dst, TCGv src1, TCGv src2)
@@ -3717,8 +3771,8 @@ TRANS(SMUL, MUL, do_logic, a, gen_op_smul, NULL)
 
 TRANS(UDIVX, 64, do_arith, a, -1, gen_op_udivx, NULL, NULL)
 TRANS(SDIVX, 64, do_arith, a, -1, gen_op_sdivx, NULL, NULL)
-TRANS(UDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_udiv, NULL, gen_op_udivcc)
-TRANS(SDIV, DIV, do_arith, a, CC_OP_DIV, gen_op_sdiv, NULL, gen_op_sdivcc)
+TRANS(UDIV, DIV, do_arith, a, CC_OP_FLAGS, gen_op_udiv, NULL, gen_op_udivcc)
+TRANS(SDIV, DIV, do_arith, a, CC_OP_FLAGS, gen_op_sdiv, NULL, gen_op_sdivcc)
 
 /* TODO: Should have feature bit -- comes in with UltraSparc T2. */
 TRANS(POPC, 64, do_arith, a, -1, gen_op_popc, NULL, NULL)
@@ -3743,10 +3797,6 @@ static bool trans_OR(DisasContext *dc, arg_r_r_ri_cc *a)
 static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     switch (dc->cc_op) {
-    case CC_OP_DIV:
-        /* Carry is known to be zero.  Fall back to plain ADD.  */
-        return do_arith(dc, a, CC_OP_ADD,
-                        tcg_gen_add_tl, tcg_gen_addi_tl, gen_op_add_cc);
     case CC_OP_ADD:
     case CC_OP_TADD:
     case CC_OP_TADDTV:
@@ -3766,10 +3816,6 @@ static bool trans_ADDC(DisasContext *dc, arg_r_r_ri_cc *a)
 static bool trans_SUBC(DisasContext *dc, arg_r_r_ri_cc *a)
 {
     switch (dc->cc_op) {
-    case CC_OP_DIV:
-        /* Carry is known to be zero.  Fall back to plain SUB.  */
-        return do_arith(dc, a, CC_OP_SUB,
-                        tcg_gen_sub_tl, tcg_gen_subi_tl, gen_op_sub_cc);
     case CC_OP_ADD:
     case CC_OP_TADD:
     case CC_OP_TADDTV:
-- 
2.34.1


