Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B69C7E1657
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:16:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUD-0003Rs-2K; Sun, 05 Nov 2023 15:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU9-0003Pi-Ql
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:41 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjTx-000288-1c
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:41 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b3c2607d9bso3078737b3a.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215147; x=1699819947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mfDnd1VBHVT7dNbMDcpBms0JCPxWtw5Xo9ZcnrHrk30=;
 b=lsGOsAxEUv2r2SRq2OqtnhUogp8ZyDmCiLDVgGZSNbsayIpGU/wp8e8VhOjqAxvyBo
 66nwk8DB4eKLkmrr7RVcB/v2rWXBQSTRcTRnkY3i+3gsnwxJf51prMMD0EXEGCyoig+c
 3rPWjfgOZ7qfAIMFSfWaU1f9Tk31e7LnvEht0BYxJdW7zwuNocIs4T/1x9HMAyECEtYN
 PN/xNytR8SeNBXhV7FZtsBFhIqkb48QGN/InAUAOzwgExpBdCJAnjjutkWqLScVOckur
 UyktuhyQLCiv6QaXG6981OHiT/OCkqG6oIL+B3im/msQAXo3r8jcuahDhTNm4fVCqoYJ
 tdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215147; x=1699819947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mfDnd1VBHVT7dNbMDcpBms0JCPxWtw5Xo9ZcnrHrk30=;
 b=o2KEIhgZHNcME8YpJKwfBteob48ZAHV6WEPFFNarWT56pgxAp9dwN8KPkDc5D+Cqup
 AOiASgiunD8FdXfOEStJxQpNx+4RvUW0ZEZG6bljmC1KHLTlSCXkb2U1VTQE3hWuUyVh
 nYbLqlpyqvODAG/s3DOhGH9rZ1EpPH6bHpCIX/EIEwKfy7algC/Xp8umiSgMuy3fZfxJ
 PG+obKXzGfduIz+QUbNhXUSBwNatlsvjyZyXdaKUZyFuWeWAb/h08T4P5OBduMdDphYJ
 udedJ3DOMrOtpEdcvnuZqbKzllAaeuEo4B6Zug3f3l47JYHD19RccBoPhknDxEK8g1SS
 wodA==
X-Gm-Message-State: AOJu0YyXL4gFcQhkwiQdxFUamRhWjT1jn5/QujjL7+rub9mw5h6tcBEQ
 T9rC882xeeGughaMtKFUgPIhRmTXoBtnkv9toiI=
X-Google-Smtp-Source: AGHT+IHbtSoikb3ZzCKUfSVaVcxB+viy6bSD4g0e76A/uphAsulj049cATQKyvNprxdlpjPehciedA==
X-Received: by 2002:a05:6a00:2e28:b0:68e:41e9:10be with SMTP id
 fc40-20020a056a002e2800b0068e41e910bemr26215550pfb.20.1699215147535; 
 Sun, 05 Nov 2023 12:12:27 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 04/21] target/sparc: Remove CC_OP_DIV
Date: Sun,  5 Nov 2023 12:12:05 -0800
Message-Id: <20231105201222.202395-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Marginally improve the INT64_MIN special case in helper_sdiv.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


