Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9DD97CA0E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 15:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwm-0006JG-Nw; Thu, 19 Sep 2024 09:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005OR-Hz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00013v-Nh
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:31 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2f7ba97ebaaso7105531fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751483; x=1727356283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fMVTkS6JZktWRMeERzzPscqVkFhjmgzyPEGQWzW6mPU=;
 b=wCES+RQwcCNMI5XP8cm91IL7/uMzcYtsZcrfxrs1qNq09TLgzMGnPh9Z4vAf5Vd31v
 UQ7kbe5kVOhahodDby5biPYV1bDNFC0gMCbP3gZFQsXPQbog+Z/v6VPeDFwMRHknr3Ok
 5cJHtsd/OGALaZfkzR3r/fhtdbvO8ADLUuplb838yK7wtbw1NNvIwQ3qFut7hLOQExqI
 8TQpWS+kmOcssXaY3O8IvXI/PQXktqGFMXFWPNgkaqbBayVIgb7c4JZu1ShQLE/tCio+
 uH07rwaS6HIIeiwbbeTVPj2OK7vW5mkbNcQcKx/Rxhkvy0Qi7xjalnhlRwZddfcoJ9Me
 b+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751483; x=1727356283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fMVTkS6JZktWRMeERzzPscqVkFhjmgzyPEGQWzW6mPU=;
 b=wBtbxw17lgFRlbxaBtm2g08PVcc85pxF36QdcTwygRaLeta4+7hIE+jkfu/EloT6o/
 iqvFx7ssbOVEKBPN7Fp4Vd3OfeEqbQKo4RAKqOcAH66e0C+HD8H1IQHnTW2TpTfAI/An
 /3HlgTK9xvchkuAUjUk3HAol2KHiEv12ocrwIVJRqyICctnnrumsEhAqkJCchLEv1I5w
 4uh7htzCxlEgETOPqk4XFNOoK1TqdSwkT9yzwhXatYEbrQbCGHbwR9uC0E3fLbfJdDoY
 tbXScSoDy57XJhM+uXwPAmsDlhS5WdTm1t+U8sxokMqy2LhyuesfLakZPHPA7uFE7l3M
 QE4A==
X-Gm-Message-State: AOJu0Yy+Q+VrKaSm74/41MzgGSEnsLvPvoh4y50HCe1gB3LQ9n+siViW
 Tt94ERmc1Lu8gXGYk8okqMmpHmuko6LhzX+aopGh0YlDZhOZnMQlmSBPe+A0VnFML/briIzJ1uH
 9
X-Google-Smtp-Source: AGHT+IGpLX3AzflCrBG8cIyjK4e+Ldue7KbadzEVfXh/CLbghik3xH+cUMdrkVvBHPwvA2A5hPEtZw==
X-Received: by 2002:a2e:be22:0:b0:2f7:663c:48d7 with SMTP id
 38308e7fff4ca-2f787f44965mr154879771fa.39.1726751483206; 
 Thu, 19 Sep 2024 06:11:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/38] target/arm: Widen NeonGenNarrowEnvFn return to 64 bits
Date: Thu, 19 Sep 2024 14:10:54 +0100
Message-Id: <20240919131106.3362543-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

While these functions really do return a 32-bit value,
widening the return type means that we need do less
marshalling between TCG types.

Remove NeonGenNarrowEnvFn typedef; add NeonGenOne64OpEnvFn.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240912024114.1097832-27-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 22 ++++++------
 target/arm/tcg/translate.h      |  2 +-
 target/arm/tcg/neon_helper.c    | 43 ++++++++++++++---------
 target/arm/tcg/translate-a64.c  | 60 ++++++++++++++++++---------------
 target/arm/tcg/translate-neon.c | 44 ++++++++++++------------
 5 files changed, 93 insertions(+), 78 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index b40589d329f..58919b670ef 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -375,17 +375,17 @@ DEF_HELPER_3(neon_qrdmulh_s32, i32, env, i32, i32)
 DEF_HELPER_4(neon_qrdmlah_s32, i32, env, s32, s32, s32)
 DEF_HELPER_4(neon_qrdmlsh_s32, i32, env, s32, s32, s32)
 
-DEF_HELPER_1(neon_narrow_u8, i32, i64)
-DEF_HELPER_1(neon_narrow_u16, i32, i64)
-DEF_HELPER_2(neon_unarrow_sat8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u8, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s8, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u16, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s16, i32, env, i64)
-DEF_HELPER_2(neon_unarrow_sat32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_u32, i32, env, i64)
-DEF_HELPER_2(neon_narrow_sat_s32, i32, env, i64)
+DEF_HELPER_1(neon_narrow_u8, i64, i64)
+DEF_HELPER_1(neon_narrow_u16, i64, i64)
+DEF_HELPER_2(neon_unarrow_sat8, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u8, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s8, i64, env, i64)
+DEF_HELPER_2(neon_unarrow_sat16, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u16, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s16, i64, env, i64)
+DEF_HELPER_2(neon_unarrow_sat32, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_u32, i64, env, i64)
+DEF_HELPER_2(neon_narrow_sat_s32, i64, env, i64)
 DEF_HELPER_1(neon_narrow_high_u8, i32, i64)
 DEF_HELPER_1(neon_narrow_high_u16, i32, i64)
 DEF_HELPER_1(neon_narrow_round_high_u8, i32, i64)
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 7721c627e9d..5a2e10d64d5 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -605,13 +605,13 @@ typedef void NeonGenThreeOpEnvFn(TCGv_i32, TCGv_env, TCGv_i32,
 typedef void NeonGenTwo64OpFn(TCGv_i64, TCGv_i64, TCGv_i64);
 typedef void NeonGenTwo64OpEnvFn(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64);
 typedef void NeonGenNarrowFn(TCGv_i32, TCGv_i64);
-typedef void NeonGenNarrowEnvFn(TCGv_i32, TCGv_ptr, TCGv_i64);
 typedef void NeonGenWidenFn(TCGv_i64, TCGv_i32);
 typedef void NeonGenTwoOpWidenFn(TCGv_i64, TCGv_i32, TCGv_i32);
 typedef void NeonGenOneSingleOpFn(TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoSingleOpFn(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
 typedef void NeonGenTwoDoubleOpFn(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
 typedef void NeonGenOne64OpFn(TCGv_i64, TCGv_i64);
+typedef void NeonGenOne64OpEnvFn(TCGv_i64, TCGv_env, TCGv_i64);
 typedef void CryptoTwoOpFn(TCGv_ptr, TCGv_ptr);
 typedef void CryptoThreeOpIntFn(TCGv_ptr, TCGv_ptr, TCGv_i32);
 typedef void CryptoThreeOpFn(TCGv_ptr, TCGv_ptr, TCGv_ptr);
diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index 739e16e4411..93b2076c64f 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -598,13 +598,15 @@ NEON_VOP_ENV(qrdmulh_s32, neon_s32, 1)
 #undef NEON_FN
 #undef NEON_QDMULH32
 
-uint32_t HELPER(neon_narrow_u8)(uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_u8)(uint64_t x)
 {
     return (x & 0xffu) | ((x >> 8) & 0xff00u) | ((x >> 16) & 0xff0000u)
            | ((x >> 24) & 0xff000000u);
 }
 
-uint32_t HELPER(neon_narrow_u16)(uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_u16)(uint64_t x)
 {
     return (x & 0xffffu) | ((x >> 16) & 0xffff0000u);
 }
@@ -635,7 +637,8 @@ uint32_t HELPER(neon_narrow_round_high_u16)(uint64_t x)
     return ((x >> 16) & 0xffff) | ((x >> 32) & 0xffff0000);
 }
 
-uint32_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
 {
     uint16_t s;
     uint8_t d;
@@ -662,7 +665,8 @@ uint32_t HELPER(neon_unarrow_sat8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
 {
     uint16_t s;
     uint8_t d;
@@ -685,7 +689,8 @@ uint32_t HELPER(neon_narrow_sat_u8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
 {
     int16_t s;
     uint8_t d;
@@ -708,7 +713,8 @@ uint32_t HELPER(neon_narrow_sat_s8)(CPUARMState *env, uint64_t x)
     return res;
 }
 
-uint32_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
 {
     uint32_t high;
     uint32_t low;
@@ -728,10 +734,11 @@ uint32_t HELPER(neon_unarrow_sat16)(CPUARMState *env, uint64_t x)
         high = 0xffff;
         SET_QC();
     }
-    return low | (high << 16);
+    return deposit32(low, 16, 16, high);
 }
 
-uint32_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
 {
     uint32_t high;
     uint32_t low;
@@ -745,10 +752,11 @@ uint32_t HELPER(neon_narrow_sat_u16)(CPUARMState *env, uint64_t x)
         high = 0xffff;
         SET_QC();
     }
-    return low | (high << 16);
+    return deposit32(low, 16, 16, high);
 }
 
-uint32_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
 {
     int32_t low;
     int32_t high;
@@ -762,10 +770,11 @@ uint32_t HELPER(neon_narrow_sat_s16)(CPUARMState *env, uint64_t x)
         high = (high >> 31) ^ 0x7fff;
         SET_QC();
     }
-    return (uint16_t)low | (high << 16);
+    return deposit32(low, 16, 16, high);
 }
 
-uint32_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
 {
     if (x & 0x8000000000000000ull) {
         SET_QC();
@@ -778,7 +787,8 @@ uint32_t HELPER(neon_unarrow_sat32)(CPUARMState *env, uint64_t x)
     return x;
 }
 
-uint32_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
 {
     if (x > 0xffffffffu) {
         SET_QC();
@@ -787,13 +797,14 @@ uint32_t HELPER(neon_narrow_sat_u32)(CPUARMState *env, uint64_t x)
     return x;
 }
 
-uint32_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
+/* Only the low 32-bits of output are significant. */
+uint64_t HELPER(neon_narrow_sat_s32)(CPUARMState *env, uint64_t x)
 {
     if ((int64_t)x != (int32_t)x) {
         SET_QC();
-        return ((int64_t)x >> 63) ^ 0x7fffffff;
+        return (uint32_t)((int64_t)x >> 63) ^ 0x7fffffff;
     }
-    return x;
+    return (uint32_t)x;
 }
 
 uint64_t HELPER(neon_widen_u8)(uint32_t x)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 934746d2f2c..7918720d9b0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9439,11 +9439,9 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
     int elements = is_scalar ? 1 : (64 / esize);
     bool round = extract32(opcode, 0, 1);
     MemOp ldop = (size + 1) | (is_u_shift ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn, tcg_rd;
-    TCGv_i32 tcg_rd_narrowed;
-    TCGv_i64 tcg_final;
+    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
 
-    static NeonGenNarrowEnvFn * const signed_narrow_fns[4][2] = {
+    static NeonGenOne64OpEnvFn * const signed_narrow_fns[4][2] = {
         { gen_helper_neon_narrow_sat_s8,
           gen_helper_neon_unarrow_sat8 },
         { gen_helper_neon_narrow_sat_s16,
@@ -9452,13 +9450,13 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
           gen_helper_neon_unarrow_sat32 },
         { NULL, NULL },
     };
-    static NeonGenNarrowEnvFn * const unsigned_narrow_fns[4] = {
+    static NeonGenOne64OpEnvFn * const unsigned_narrow_fns[4] = {
         gen_helper_neon_narrow_sat_u8,
         gen_helper_neon_narrow_sat_u16,
         gen_helper_neon_narrow_sat_u32,
         NULL
     };
-    NeonGenNarrowEnvFn *narrowfn;
+    NeonGenOne64OpEnvFn *narrowfn;
 
     int i;
 
@@ -9481,15 +9479,13 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
 
     tcg_rn = tcg_temp_new_i64();
     tcg_rd = tcg_temp_new_i64();
-    tcg_rd_narrowed = tcg_temp_new_i32();
     tcg_final = tcg_temp_new_i64();
 
     for (i = 0; i < elements; i++) {
         read_vec_element(s, tcg_rn, rn, i, ldop);
         handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
                                 false, is_u_shift, size+1, shift);
-        narrowfn(tcg_rd_narrowed, tcg_env, tcg_rd);
-        tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
+        narrowfn(tcg_rd, tcg_env, tcg_rd);
         if (i == 0) {
             tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
         } else {
@@ -10228,35 +10224,35 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
      * in the source becomes a size element in the destination).
      */
     int pass;
-    TCGv_i32 tcg_res[2];
+    TCGv_i64 tcg_res[2];
     int destelt = is_q ? 2 : 0;
     int passes = scalar ? 1 : 2;
 
     if (scalar) {
-        tcg_res[1] = tcg_constant_i32(0);
+        tcg_res[1] = tcg_constant_i64(0);
     }
 
     for (pass = 0; pass < passes; pass++) {
         TCGv_i64 tcg_op = tcg_temp_new_i64();
-        NeonGenNarrowFn *genfn = NULL;
-        NeonGenNarrowEnvFn *genenvfn = NULL;
+        NeonGenOne64OpFn *genfn = NULL;
+        NeonGenOne64OpEnvFn *genenvfn = NULL;
 
         if (scalar) {
             read_vec_element(s, tcg_op, rn, pass, size + 1);
         } else {
             read_vec_element(s, tcg_op, rn, pass, MO_64);
         }
-        tcg_res[pass] = tcg_temp_new_i32();
+        tcg_res[pass] = tcg_temp_new_i64();
 
         switch (opcode) {
         case 0x12: /* XTN, SQXTUN */
         {
-            static NeonGenNarrowFn * const xtnfns[3] = {
+            static NeonGenOne64OpFn * const xtnfns[3] = {
                 gen_helper_neon_narrow_u8,
                 gen_helper_neon_narrow_u16,
-                tcg_gen_extrl_i64_i32,
+                tcg_gen_ext32u_i64,
             };
-            static NeonGenNarrowEnvFn * const sqxtunfns[3] = {
+            static NeonGenOne64OpEnvFn * const sqxtunfns[3] = {
                 gen_helper_neon_unarrow_sat8,
                 gen_helper_neon_unarrow_sat16,
                 gen_helper_neon_unarrow_sat32,
@@ -10270,7 +10266,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         }
         case 0x14: /* SQXTN, UQXTN */
         {
-            static NeonGenNarrowEnvFn * const fns[3][2] = {
+            static NeonGenOne64OpEnvFn * const fns[3][2] = {
                 { gen_helper_neon_narrow_sat_s8,
                   gen_helper_neon_narrow_sat_u8 },
                 { gen_helper_neon_narrow_sat_s16,
@@ -10284,7 +10280,9 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
         case 0x16: /* FCVTN, FCVTN2 */
             /* 32 bit to 16 bit or 64 bit to 32 bit float conversion */
             if (size == 2) {
-                gen_helper_vfp_fcvtsd(tcg_res[pass], tcg_op, tcg_env);
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                gen_helper_vfp_fcvtsd(tmp, tcg_op, tcg_env);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
             } else {
                 TCGv_i32 tcg_lo = tcg_temp_new_i32();
                 TCGv_i32 tcg_hi = tcg_temp_new_i32();
@@ -10294,21 +10292,29 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
                 tcg_gen_extr_i64_i32(tcg_lo, tcg_hi, tcg_op);
                 gen_helper_vfp_fcvt_f32_to_f16(tcg_lo, tcg_lo, fpst, ahp);
                 gen_helper_vfp_fcvt_f32_to_f16(tcg_hi, tcg_hi, fpst, ahp);
-                tcg_gen_deposit_i32(tcg_res[pass], tcg_lo, tcg_hi, 16, 16);
+                tcg_gen_deposit_i32(tcg_lo, tcg_lo, tcg_hi, 16, 16);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tcg_lo);
             }
             break;
         case 0x36: /* BFCVTN, BFCVTN2 */
             {
                 TCGv_ptr fpst = fpstatus_ptr(FPST_FPCR);
-                gen_helper_bfcvt_pair(tcg_res[pass], tcg_op, fpst);
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                gen_helper_bfcvt_pair(tmp, tcg_op, fpst);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
             }
             break;
         case 0x56:  /* FCVTXN, FCVTXN2 */
-            /* 64 bit to 32 bit float conversion
-             * with von Neumann rounding (round to odd)
-             */
-            assert(size == 2);
-            gen_helper_fcvtx_f64_to_f32(tcg_res[pass], tcg_op, tcg_env);
+            {
+                /*
+                 * 64 bit to 32 bit float conversion
+                 * with von Neumann rounding (round to odd)
+                 */
+                TCGv_i32 tmp = tcg_temp_new_i32();
+                assert(size == 2);
+                gen_helper_fcvtx_f64_to_f32(tmp, tcg_op, tcg_env);
+                tcg_gen_extu_i32_i64(tcg_res[pass], tmp);
+            }
             break;
         default:
             g_assert_not_reached();
@@ -10322,7 +10328,7 @@ static void handle_2misc_narrow(DisasContext *s, bool scalar,
     }
 
     for (pass = 0; pass < 2; pass++) {
-        write_vec_element_i32(s, tcg_res[pass], rd, destelt + pass, MO_32);
+        write_vec_element(s, tcg_res[pass], rd, destelt + pass, MO_32);
     }
     clear_vec_high(s, is_q, rd);
 }
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 6dd70d1c539..9c8829ad7d2 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1107,11 +1107,10 @@ DO_2SH(VQSHL_S, gen_neon_sqshli)
 
 static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
                                 NeonGenTwo64OpFn *shiftfn,
-                                NeonGenNarrowEnvFn *narrowfn)
+                                NeonGenOne64OpEnvFn *narrowfn)
 {
     /* 2-reg-and-shift narrowing-shift operations, size == 3 case */
-    TCGv_i64 constimm, rm1, rm2;
-    TCGv_i32 rd;
+    TCGv_i64 constimm, rm1, rm2, rd;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -1138,7 +1137,7 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
     constimm = tcg_constant_i64(-a->shift);
     rm1 = tcg_temp_new_i64();
     rm2 = tcg_temp_new_i64();
-    rd = tcg_temp_new_i32();
+    rd = tcg_temp_new_i64();
 
     /* Load both inputs first to avoid potential overwrite if rm == rd */
     read_neon_element64(rm1, a->vm, 0, MO_64);
@@ -1146,18 +1145,18 @@ static bool do_2shift_narrow_64(DisasContext *s, arg_2reg_shift *a,
 
     shiftfn(rm1, rm1, constimm);
     narrowfn(rd, tcg_env, rm1);
-    write_neon_element32(rd, a->vd, 0, MO_32);
+    write_neon_element64(rd, a->vd, 0, MO_32);
 
     shiftfn(rm2, rm2, constimm);
     narrowfn(rd, tcg_env, rm2);
-    write_neon_element32(rd, a->vd, 1, MO_32);
+    write_neon_element64(rd, a->vd, 1, MO_32);
 
     return true;
 }
 
 static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
                                 NeonGenTwoOpFn *shiftfn,
-                                NeonGenNarrowEnvFn *narrowfn)
+                                NeonGenOne64OpEnvFn *narrowfn)
 {
     /* 2-reg-and-shift narrowing-shift operations, size < 3 case */
     TCGv_i32 constimm, rm1, rm2, rm3, rm4;
@@ -1212,16 +1211,16 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
 
     tcg_gen_concat_i32_i64(rtmp, rm1, rm2);
 
-    narrowfn(rm1, tcg_env, rtmp);
-    write_neon_element32(rm1, a->vd, 0, MO_32);
+    narrowfn(rtmp, tcg_env, rtmp);
+    write_neon_element64(rtmp, a->vd, 0, MO_32);
 
     shiftfn(rm3, rm3, constimm);
     shiftfn(rm4, rm4, constimm);
 
     tcg_gen_concat_i32_i64(rtmp, rm3, rm4);
 
-    narrowfn(rm3, tcg_env, rtmp);
-    write_neon_element32(rm3, a->vd, 1, MO_32);
+    narrowfn(rtmp, tcg_env, rtmp);
+    write_neon_element64(rtmp, a->vd, 1, MO_32);
     return true;
 }
 
@@ -1236,17 +1235,17 @@ static bool do_2shift_narrow_32(DisasContext *s, arg_2reg_shift *a,
         return do_2shift_narrow_32(s, a, FUNC, NARROWFUNC);             \
     }
 
-static void gen_neon_narrow_u32(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u32(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
-    tcg_gen_extrl_i64_i32(dest, src);
+    tcg_gen_ext32u_i64(dest, src);
 }
 
-static void gen_neon_narrow_u16(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u16(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
     gen_helper_neon_narrow_u16(dest, src);
 }
 
-static void gen_neon_narrow_u8(TCGv_i32 dest, TCGv_ptr env, TCGv_i64 src)
+static void gen_neon_narrow_u8(TCGv_i64 dest, TCGv_ptr env, TCGv_i64 src)
 {
     gen_helper_neon_narrow_u8(dest, src);
 }
@@ -2837,10 +2836,9 @@ static bool trans_VZIP(DisasContext *s, arg_2misc *a)
 }
 
 static bool do_vmovn(DisasContext *s, arg_2misc *a,
-                     NeonGenNarrowEnvFn *narrowfn)
+                     NeonGenOne64OpEnvFn *narrowfn)
 {
-    TCGv_i64 rm;
-    TCGv_i32 rd0, rd1;
+    TCGv_i64 rm, rd0, rd1;
 
     if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
         return false;
@@ -2865,22 +2863,22 @@ static bool do_vmovn(DisasContext *s, arg_2misc *a,
     }
 
     rm = tcg_temp_new_i64();
-    rd0 = tcg_temp_new_i32();
-    rd1 = tcg_temp_new_i32();
+    rd0 = tcg_temp_new_i64();
+    rd1 = tcg_temp_new_i64();
 
     read_neon_element64(rm, a->vm, 0, MO_64);
     narrowfn(rd0, tcg_env, rm);
     read_neon_element64(rm, a->vm, 1, MO_64);
     narrowfn(rd1, tcg_env, rm);
-    write_neon_element32(rd0, a->vd, 0, MO_32);
-    write_neon_element32(rd1, a->vd, 1, MO_32);
+    write_neon_element64(rd0, a->vd, 0, MO_32);
+    write_neon_element64(rd1, a->vd, 1, MO_32);
     return true;
 }
 
 #define DO_VMOVN(INSN, FUNC)                                    \
     static bool trans_##INSN(DisasContext *s, arg_2misc *a)     \
     {                                                           \
-        static NeonGenNarrowEnvFn * const narrowfn[] = {        \
+        static NeonGenOne64OpEnvFn * const narrowfn[] = {       \
             FUNC##8,                                            \
             FUNC##16,                                           \
             FUNC##32,                                           \
-- 
2.34.1


