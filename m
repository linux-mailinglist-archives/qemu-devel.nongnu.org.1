Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9517AAE2D55
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Jun 2025 02:00:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85l-0005f0-OK; Sat, 21 Jun 2025 19:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Y-0004x8-He
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:37 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85V-0006au-Qr
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:36 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso1381591b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550252; x=1751155052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WpWwhaFeTcI96P1vGNnXcuTfAVM57Eo/mqGtBcNNjps=;
 b=CLETw5sAU2kUbcb+elCuIA6lhQggAKpBzyjubPMu07BOfjJnJoVC/k04ndOKqrgVtN
 Jw/kuIC6BXJCwygm5m6sbPYcMVTiLv6HxMsKlgtqD8/4Q+0/D8enaINKORPwhLkgJJAt
 f3oURZqBmBhCPg9YYWUNAcwoamQf5WPHGzB2RSen4Ss+lTQ0A4hb9ynxKm2wiZewTSTI
 mb7cU/BrW+hreXK5Mi3bQj2QZTt5o1gO9+OcYdyaTh+Ty6CIEASMYgjkvDfA83jgLTzZ
 HfuGbqXbeZVlqAoqzDLRfET2s33wc9zxWR4z+1FoLPfPgma8Zq9dcD958koyDGN0EMDc
 o1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550252; x=1751155052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpWwhaFeTcI96P1vGNnXcuTfAVM57Eo/mqGtBcNNjps=;
 b=OLCMHSmHU5lV+8sppYR5chQB8ATuUj/eG/jbqNlFSpEFJfR10qG382GrbVM8ECP0T1
 nBwcBKXHNsUcZ+TKMM9PIRVcNba3dKL9sqlkQqSQGZI4MBE/Pm5hGwRHbuOHhYfZFxRS
 BZ2tfZMHJtikUQagy4MOmZn+34xKMrao4DVQsVKCR7f6CDsA56h9RineKTqoPtpMEkQC
 nEDs6VBWlg2U5U6TQ5OyL2m1J5BHaJXtxjn1U7OFSsiSjumzhVdMvsKA1JO2qNBUMX/h
 PaA3LEKSq6aMLStWPjb6OkgqviAKYn1PqQA1uPGtbR2hP7BUFmDF+OxHjvAES2oOmAU3
 i8aA==
X-Gm-Message-State: AOJu0YwPwHlIJshsKkV7ipMorM8JdfevUUVOkIZhYKBOPLplP9Fp7w7W
 HlMvgUQ0bgfZ3lcsW5PDuIR9+/7fTeZBNIOknp96/VIN1tH1fP2AN8F3aYI0IICZCn9+1fxzLrD
 8Fo28TpM=
X-Gm-Gg: ASbGncuRzN11VNho728OFx66qPYWjXpkOA7kqkIVxnnNHvU1ROZ/i5Qyg7G0d5aVlTZ
 16pTeD1eRTbe+h/D7r0dHnnsnYUMlJqUgp9fn6hTbczinlw/rHZ914OiIUNLjp9MLLexE8liA+J
 4Uu1ogfkGJsh9JlcsOWsguS47LfXj68L+uyOObQlDpyhu+Fx+u78x0FkmeDEN2IE78LUT9I7tL+
 awd5quPO3ZJOq5hSSQYXTa+ZN8mjdMRwLevGbGdIMLd1pyHc7ZIx85e1bTTByKyO7u6v1g0qopq
 UgmTQU+jp5qxoXtUVS2nFsgCKT5euAtg8SaK7PpgOYmd5V98Ux3KpYRcEmW+otu4NpNhB7J9dD3
 wQIvyqHVm1VIZ5CIl9mEp
X-Google-Smtp-Source: AGHT+IF8bmblPGYAsV101ziBCyZkaxoB76/KfzjWl5++ug/NcYWX/zaO3RVVhLCHLgV+HlPG+PL3lw==
X-Received: by 2002:a05:6a20:c992:b0:1ee:dcd3:80d7 with SMTP id
 adf61e73a8af0-22025e2a5femr11150621637.0.1750550252266; 
 Sat, 21 Jun 2025 16:57:32 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 083/101] target/arm: Implement FADDQV, F{MIN,
 MAX}{NM}QV for SVE2p1
Date: Sat, 21 Jun 2025 16:50:19 -0700
Message-ID: <20250621235037.74091-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 49 ++++++++++++++++++++++++
 target/arm/tcg/sve_helper.c    | 70 +++++++++++++++++++++-------------
 target/arm/tcg/translate-sve.c | 48 +++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  8 ++++
 4 files changed, 148 insertions(+), 27 deletions(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 9758613b2d..906da384dc 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -1077,6 +1077,55 @@ DEF_HELPER_FLAGS_4(sve_ah_fminv_s, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_4(sve_ah_fminv_d, TCG_CALL_NO_RWG,
                    i64, ptr, ptr, fpst, i32)
 
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_faddqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminnmqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fmaxqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_5(sve2p1_ah_fminqv_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, fpst, i32)
+
 DEF_HELPER_FLAGS_5(sve_fadda_h, TCG_CALL_NO_RWG,
                    i64, i64, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_5(sve_fadda_s, TCG_CALL_NO_RWG,
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ebe4862784..ac38d62f04 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4379,19 +4379,20 @@ uint32_t HELPER(sve_whilecg)(void *vd, uint32_t count, uint32_t pred_desc)
  * The recursion is bounded to depth 7 (128 fp16 elements), so there's
  * little to gain with a more complex non-recursive form.
  */
-#define DO_REDUCE(NAME, TYPE, H, FUNC, IDENT)                         \
-static TYPE NAME##_reduce(TYPE *data, float_status *status, uintptr_t n) \
+#define DO_REDUCE(NAME, SUF, TYPE, H, FUNC, IDENT)                      \
+static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
 {                                                                     \
     if (n == 1) {                                                     \
         return *data;                                                 \
     } else {                                                          \
         uintptr_t half = n / 2;                                       \
-        TYPE lo = NAME##_reduce(data, status, half);                  \
-        TYPE hi = NAME##_reduce(data + half, status, half);           \
+        TYPE lo = FUNC##_reduce(data, status, half);                  \
+        TYPE hi = FUNC##_reduce(data + half, status, half);           \
         return FUNC(lo, hi, status);                                  \
     }                                                                 \
 }                                                                     \
-uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
+uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
+                                    float_status *s, uint32_t desc)   \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
@@ -4406,39 +4407,54 @@ uint64_t HELPER(NAME)(void *vn, void *vg, float_status *s, uint32_t desc) \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
         *(TYPE *)((void *)data + i) = IDENT;                          \
     }                                                                 \
-    return NAME##_reduce(data, s, maxsz / sizeof(TYPE));              \
+    return FUNC##_reduce(data, s, maxsz / sizeof(TYPE));              \
+}                                                                     \
+void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
+                                    float_status *status, uint32_t desc) \
+{                                                                     \
+    unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
+    for (unsigned e = 0; e < 16; e += sizeof(TYPE)) {                 \
+        TYPE data[ARM_MAX_VQ];                                        \
+        for (unsigned s = 0; s < segments; s++) {                     \
+            uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
+            TYPE nn = *(TYPE *)(vn + H(s * 16 + H(e)));               \
+            data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
+        }                                                             \
+        *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
+    }                                                                 \
+    clear_tail(vd, 16, simd_maxsz(desc));                             \
 }
 
-DO_REDUCE(sve_faddv_h, float16, H1_2, float16_add, float16_zero)
-DO_REDUCE(sve_faddv_s, float32, H1_4, float32_add, float32_zero)
-DO_REDUCE(sve_faddv_d, float64, H1_8, float64_add, float64_zero)
+DO_REDUCE(fadd,h, float16, H1_2, float16_add, float16_zero)
+DO_REDUCE(fadd,s, float32, H1_4, float32_add, float32_zero)
+DO_REDUCE(fadd,d, float64, H1_8, float64_add, float64_zero)
 
 /* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(sve_fminnmv_h, float16, H1_2, float16_minnum, 0x7E00)
-DO_REDUCE(sve_fminnmv_s, float32, H1_4, float32_minnum, 0x7FC00000)
-DO_REDUCE(sve_fminnmv_d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, 0x7E00)
+DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, 0x7FC00000)
+DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fmaxnmv_h, float16, H1_2, float16_maxnum, 0x7E00)
-DO_REDUCE(sve_fmaxnmv_s, float32, H1_4, float32_maxnum, 0x7FC00000)
-DO_REDUCE(sve_fmaxnmv_d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, 0x7E00)
+DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, 0x7FC00000)
+DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
 
-DO_REDUCE(sve_fminv_h, float16, H1_2, float16_min, float16_infinity)
-DO_REDUCE(sve_fminv_s, float32, H1_4, float32_min, float32_infinity)
-DO_REDUCE(sve_fminv_d, float64, H1_8, float64_min, float64_infinity)
+DO_REDUCE(fmin,h, float16, H1_2, float16_min, float16_infinity)
+DO_REDUCE(fmin,s, float32, H1_4, float32_min, float32_infinity)
+DO_REDUCE(fmin,d, float64, H1_8, float64_min, float64_infinity)
 
-DO_REDUCE(sve_fmaxv_h, float16, H1_2, float16_max, float16_chs(float16_infinity))
-DO_REDUCE(sve_fmaxv_s, float32, H1_4, float32_max, float32_chs(float32_infinity))
-DO_REDUCE(sve_fmaxv_d, float64, H1_8, float64_max, float64_chs(float64_infinity))
+DO_REDUCE(fmax,h, float16, H1_2, float16_max, float16_chs(float16_infinity))
+DO_REDUCE(fmax,s, float32, H1_4, float32_max, float32_chs(float32_infinity))
+DO_REDUCE(fmax,d, float64, H1_8, float64_max, float64_chs(float64_infinity))
 
-DO_REDUCE(sve_ah_fminv_h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
-DO_REDUCE(sve_ah_fminv_s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
-DO_REDUCE(sve_ah_fminv_d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
+DO_REDUCE(ah_fmin,h, float16, H1_2, helper_vfp_ah_minh, float16_infinity)
+DO_REDUCE(ah_fmin,s, float32, H1_4, helper_vfp_ah_mins, float32_infinity)
+DO_REDUCE(ah_fmin,d, float64, H1_8, helper_vfp_ah_mind, float64_infinity)
 
-DO_REDUCE(sve_ah_fmaxv_h, float16, H1_2, helper_vfp_ah_maxh,
+DO_REDUCE(ah_fmax,h, float16, H1_2, helper_vfp_ah_maxh,
           float16_chs(float16_infinity))
-DO_REDUCE(sve_ah_fmaxv_s, float32, H1_4, helper_vfp_ah_maxs,
+DO_REDUCE(ah_fmax,s, float32, H1_4, helper_vfp_ah_maxs,
           float32_chs(float32_infinity))
-DO_REDUCE(sve_ah_fmaxv_d, float64, H1_8, helper_vfp_ah_maxd,
+DO_REDUCE(ah_fmax,d, float64, H1_8, helper_vfp_ah_maxd,
           float64_chs(float64_infinity))
 
 #undef DO_REDUCE
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6aca2e3dec..414c3ff759 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3726,6 +3726,54 @@ DO_VPZ_AH(FMAXV, fmaxv)
 
 #undef DO_VPZ
 
+static gen_helper_gvec_3_ptr * const faddqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_faddqv_h,
+    gen_helper_sve2p1_faddqv_s, gen_helper_sve2p1_faddqv_d,
+};
+TRANS_FEAT(FADDQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           faddqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fmaxnmqv_h,
+    gen_helper_sve2p1_fmaxnmqv_s, gen_helper_sve2p1_fmaxnmqv_d,
+};
+TRANS_FEAT(FMAXNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fmaxnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminnmqv_fns[4] = {
+    NULL,                         gen_helper_sve2p1_fminnmqv_h,
+    gen_helper_sve2p1_fminnmqv_s, gen_helper_sve2p1_fminnmqv_d,
+};
+TRANS_FEAT(FMINNMQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           fminnmqv_fns[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fmaxqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fmaxqv_h,
+    gen_helper_sve2p1_fmaxqv_s, gen_helper_sve2p1_fmaxqv_d,
+};
+static gen_helper_gvec_3_ptr * const fmaxqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fmaxqv_h,
+    gen_helper_sve2p1_ah_fmaxqv_s, gen_helper_sve2p1_ah_fmaxqv_d,
+};
+TRANS_FEAT(FMAXQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fmaxqv_fns : fmaxqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
+static gen_helper_gvec_3_ptr * const fminqv_fns[4] = {
+    NULL,                       gen_helper_sve2p1_fminqv_h,
+    gen_helper_sve2p1_fminqv_s, gen_helper_sve2p1_fminqv_d,
+};
+static gen_helper_gvec_3_ptr * const fminqv_ah_fns[4] = {
+    NULL,                          gen_helper_sve2p1_ah_fminqv_h,
+    gen_helper_sve2p1_ah_fminqv_s, gen_helper_sve2p1_ah_fminqv_d,
+};
+TRANS_FEAT(FMINQV, aa64_sme2p1_or_sve2p1, gen_gvec_fpst_arg_zpz,
+           (s->fpcr_ah ? fminqv_fns : fminqv_ah_fns)[a->esz], a, 0,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+
 /*
  *** SVE Floating Point Unary Operations - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index a6541353ce..11ce8bcc6f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1036,6 +1036,14 @@ FMINNMV         01100101 .. 000 101 001 ... ..... .....         @rd_pg_rn
 FMAXV           01100101 .. 000 110 001 ... ..... .....         @rd_pg_rn
 FMINV           01100101 .. 000 111 001 ... ..... .....         @rd_pg_rn
 
+### SVE FP recursive reduction (quadwords)
+
+FADDQV          01100100 .. 010 000 101 ... ..... .....         @rd_pg_rn
+FMAXNMQV        01100100 .. 010 100 101 ... ..... .....         @rd_pg_rn
+FMINNMQV        01100100 .. 010 101 101 ... ..... .....         @rd_pg_rn
+FMAXQV          01100100 .. 010 110 101 ... ..... .....         @rd_pg_rn
+FMINQV          01100100 .. 010 111 101 ... ..... .....         @rd_pg_rn
+
 ## SVE Floating Point Unary Operations - Unpredicated Group
 
 FRECPE          01100101 .. 001 110 001100 ..... .....          @rd_rn
-- 
2.43.0


