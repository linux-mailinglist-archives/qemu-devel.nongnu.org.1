Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 821487CBB73
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdle-0007rb-2O; Tue, 17 Oct 2023 02:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlU-0007qf-R2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlS-0001q3-RI
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:16 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c894e4573bso34251695ad.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524873; x=1698129673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riTrpJJNJySZ4F/xCzfMwlO3A4jK43J/Vq77RdnNG0Q=;
 b=ZBQQCIhxtiu6+Yjz+B9MjvftoawPV/a81cNPXhTkbMZy87iPn/gqYYc5ZrqNR8WFJK
 xE31JoPCnq7PJLKZcUhaQ+WWhmBUn+4TqdEk+1zNMaA13BhhDylNGXf+/NgqoZOklkc/
 slHe5VXAmfAjWt3c4hfUHV3Ser2iJoHIxyNOwnNryXcHEFJbhD8hoXn+S9j+sqGpziXK
 h8h6knktTKAfek7g4onWlQBc0LBk355HEEXiY1571H9PZqtf2aOxlsgg5RMgQWZ+2nMt
 5hjeR6haGuD5VP2V7j6Ug6jR8ByZ/9lOAmxnWB+7uuE+VKbdcpX354hh8NWUTjMgsFFt
 bn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524873; x=1698129673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riTrpJJNJySZ4F/xCzfMwlO3A4jK43J/Vq77RdnNG0Q=;
 b=hX162AYRUVUM1oA6bm1Ydi38a0WRGL0R2nTKGkuvUevtsbIQ64ogf0zPuELAN5aD0B
 rFPaV91B8aR7/X4hook+dOS4SI4GiTUqF6zkqx9Yu0FVLPk9tAiTChMp/a3CpNqCe9bz
 +Zq8u/96m72BmrpaA6X1dWU6MRitA2YeNDF3NX9Fk2yM2QJKFgWxJk6P1qNBuIA93hlv
 zzFsLasa+hUUWgpfW0Emm6zeXSZSOnBihbOXlEkW2KDZgpc3aehQbn6jqbwX30ij6tZ7
 CgsxHaYPv0j0HAYO4M1TbXx3G77eVSmIkeiMAvGymSEMg04v6fZnnnQvIxUk6UJZLTgi
 JXUQ==
X-Gm-Message-State: AOJu0Ywo905xi3k6tP93Wk5kTMo5sgkHldyKwVE80YmOUgCGjxVmcZwR
 EQFBpq03OnceaY2MtAWzFW4XGYCP8ULqLQYZt+U=
X-Google-Smtp-Source: AGHT+IEK/FgVxY1kAs415N3blFrmWlAIBhKLEPpyhiZBFruXDorY/X4eooW9VShnn4K/HJj3zegoyw==
X-Received: by 2002:a17:903:80c:b0:1c3:5f05:922a with SMTP id
 kr12-20020a170903080c00b001c35f05922amr1323794plb.60.1697524872702; 
 Mon, 16 Oct 2023 23:41:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 03/20] target/sparc: Remove CC_OP_DIV
Date: Mon, 16 Oct 2023 23:40:52 -0700
Message-Id: <20231017064109.681935-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Return both result and overflow from helper_[us]div.
Compute all flags explicitly in gen_op_[us]divcc.

Marginally improve the INT64_MIN special case in do_sdiv.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h       |  1 -
 target/sparc/helper.h    |  4 +--
 target/sparc/cc_helper.c | 26 --------------
 target/sparc/helper.c    | 75 ++++++++++++++++++++++++----------------
 target/sparc/translate.c |  8 ++---
 5 files changed, 51 insertions(+), 63 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index ac93658c33..df49d8423a 100644
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
index dd1721a340..58d3c979d4 100644
--- a/target/sparc/helper.h
+++ b/target/sparc/helper.h
@@ -27,9 +27,9 @@ DEF_HELPER_FLAGS_2(tick_set_limit, TCG_CALL_NO_RWG, void, ptr, i64)
 DEF_HELPER_1(debug, void, env)
 DEF_HELPER_1(save, void, env)
 DEF_HELPER_1(restore, void, env)
-DEF_HELPER_3(udiv, tl, env, tl, tl)
+DEF_HELPER_FLAGS_3(udiv, TCG_CALL_NO_WG, tl, env, tl, tl)
+DEF_HELPER_FLAGS_3(sdiv, TCG_CALL_NO_WG, tl, env, tl, tl)
 DEF_HELPER_3(udiv_cc, tl, env, tl, tl)
-DEF_HELPER_3(sdiv, tl, env, tl, tl)
 DEF_HELPER_3(sdiv_cc, tl, env, tl, tl)
 DEF_HELPER_3(taddcctv, tl, env, tl, tl)
 DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
diff --git a/target/sparc/cc_helper.c b/target/sparc/cc_helper.c
index fe4618ad34..a6d1a4b9ae 100644
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
@@ -402,7 +378,6 @@ typedef struct CCTable {
 
 static const CCTable icc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_DIV] = { compute_all_div, compute_C_div },
     [CC_OP_ADD] = { compute_all_add, compute_C_add },
     [CC_OP_ADDX] = { compute_all_addx, compute_C_addx },
     [CC_OP_TADD] = { compute_all_tadd, compute_C_add },
@@ -417,7 +392,6 @@ static const CCTable icc_table[CC_OP_NB] = {
 #ifdef TARGET_SPARC64
 static const CCTable xcc_table[CC_OP_NB] = {
     /* CC_OP_DYNAMIC should never happen */
-    [CC_OP_DIV] = { compute_all_logic_xcc, compute_C_logic },
     [CC_OP_ADD] = { compute_all_add_xcc, compute_C_add_xcc },
     [CC_OP_ADDX] = { compute_all_addx_xcc, compute_C_addx_xcc },
     [CC_OP_TADD] = { compute_all_add_xcc, compute_C_add_xcc },
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index c4358bba84..87a4258792 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -84,29 +84,32 @@ void helper_tick_set_limit(void *opaque, uint64_t limit)
 static target_ulong do_udiv(CPUSPARCState *env, target_ulong a,
                             target_ulong b, int cc, uintptr_t ra)
 {
-    int overflow = 0;
-    uint64_t x0;
-    uint32_t x1;
-
-    x0 = (a & 0xffffffff) | ((int64_t) (env->y) << 32);
-    x1 = (b & 0xffffffff);
+    target_ulong v, r;
+    uint64_t x0 = (uint32_t)a | ((uint64_t)env->y << 32);
+    uint32_t x1 = b;
 
     if (x1 == 0) {
         cpu_raise_exception_ra(env, TT_DIV_ZERO, ra);
     }
 
     x0 = x0 / x1;
-    if (x0 > UINT32_MAX) {
-        x0 = UINT32_MAX;
-        overflow = 1;
+    r = x0;
+    v = 0;
+    if (unlikely(x0 > UINT32_MAX)) {
+        v = r = UINT32_MAX;
     }
 
     if (cc) {
-        env->cc_dst = x0;
-        env->cc_src2 = overflow;
-        env->cc_op = CC_OP_DIV;
+        env->cc_N = r;
+        env->cc_V = v;
+        env->cc_icc_Z = r;
+        env->cc_icc_C = 0;
+#ifdef TARGET_SPARC64
+        env->cc_xcc_Z = r;
+        env->cc_xcc_C = 0;
+#endif
     }
-    return x0;
+    return r;
 }
 
 target_ulong helper_udiv(CPUSPARCState *env, target_ulong a, target_ulong b)
@@ -122,32 +125,46 @@ target_ulong helper_udiv_cc(CPUSPARCState *env, target_ulong a, target_ulong b)
 static target_ulong do_sdiv(CPUSPARCState *env, target_ulong a,
                             target_ulong b, int cc, uintptr_t ra)
 {
-    int overflow = 0;
-    int64_t x0;
-    int32_t x1;
-
-    x0 = (a & 0xffffffff) | ((int64_t) (env->y) << 32);
-    x1 = (b & 0xffffffff);
+    target_ulong v;
+    target_long r;
+    int64_t x0 = (uint32_t)a | ((uint64_t)env->y << 32);
+    int32_t x1 = b;
 
     if (x1 == 0) {
         cpu_raise_exception_ra(env, TT_DIV_ZERO, ra);
-    } else if (x1 == -1 && x0 == INT64_MIN) {
-        x0 = INT32_MAX;
-        overflow = 1;
+    }
+    if (unlikely(x0 == INT64_MIN)) {
+        /*
+         * Special case INT64_MIN / -1 is required to avoid trap on x86 host.
+         * However, with a dividend of INT64_MIN, there is no 32-bit divisor
+         * which can yield a 32-bit result:
+         *    INT64_MIN / INT32_MIN =  0x1_0000_0000
+         *    INT64_MIN / INT32_MAX = -0x1_0000_0002
+         * Therefore we know we must overflow and saturate.
+         */
+        r = x1 < 0 ? INT32_MAX : INT32_MIN;
+        v = UINT32_MAX;
     } else {
         x0 = x0 / x1;
-        if ((int32_t) x0 != x0) {
-            x0 = x0 < 0 ? INT32_MIN : INT32_MAX;
-            overflow = 1;
+        r = (int32_t)x0;
+        v = 0;
+        if (unlikely(r != x0)) {
+            r = x0 < 0 ? INT32_MIN : INT32_MAX;
+            v = UINT32_MAX;
         }
     }
 
     if (cc) {
-        env->cc_dst = x0;
-        env->cc_src2 = overflow;
-        env->cc_op = CC_OP_DIV;
+        env->cc_N = r;
+        env->cc_V = v;
+        env->cc_icc_Z = r;
+        env->cc_icc_C = 0;
+#ifdef TARGET_SPARC64
+        env->cc_xcc_Z = r;
+        env->cc_xcc_C = 0;
+#endif
     }
-    return x0;
+    return r;
 }
 
 target_ulong helper_sdiv(CPUSPARCState *env, target_ulong a, target_ulong b)
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f2a2d69f91..2ca20ba110 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -437,7 +437,6 @@ static void gen_op_addx_int(DisasContext *dc, TCGv dst, TCGv src1,
     TCGv carry;
 
     switch (dc->cc_op) {
-    case CC_OP_DIV:
     case CC_OP_LOGIC:
         /* Carry is known to be zero.  Fall back to plain ADD.  */
         if (update_cc) {
@@ -510,7 +509,6 @@ static void gen_op_subx_int(DisasContext *dc, TCGv dst, TCGv src1,
     TCGv carry;
 
     switch (dc->cc_op) {
-    case CC_OP_DIV:
     case CC_OP_LOGIC:
         /* Carry is known to be zero.  Fall back to plain SUB.  */
         if (update_cc) {
@@ -3759,7 +3757,7 @@ static bool do_flags_arith(DisasContext *dc, arg_r_r_ri *a, int cc_op,
                            void (*func)(TCGv, TCGv, TCGv))
 {
     if (do_arith(dc, a, func, NULL)) {
-        /* Assume FUNC has set env->cc_op and all cc_foo variables. */
+        tcg_gen_movi_i32(cpu_cc_op, cc_op);
         dc->cc_op = cc_op;
         return true;
     }
@@ -3816,8 +3814,8 @@ TRANS(ORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_orc_tl, NULL)
 TRANS(XORNcc, ALL, do_cc_arith, a, CC_OP_LOGIC, tcg_gen_eqv_tl, NULL)
 TRANS(UMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_umul, NULL)
 TRANS(SMULcc, MUL, do_cc_arith, a, CC_OP_LOGIC, gen_op_smul, NULL)
-TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_udivcc)
-TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_DIV, gen_op_sdivcc)
+TRANS(UDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_udivcc)
+TRANS(SDIVcc, DIV, do_flags_arith, a, CC_OP_FLAGS, gen_op_sdivcc)
 TRANS(TADDcc, ALL, do_cc_arith, a, CC_OP_TADD, gen_op_add_cc, NULL)
 TRANS(TSUBcc, ALL, do_cc_arith, a, CC_OP_TSUB, gen_op_sub_cc, NULL)
 TRANS(TADDccTV, ALL, do_flags_arith, a, CC_OP_TADDTV, gen_op_taddcctv)
-- 
2.34.1


