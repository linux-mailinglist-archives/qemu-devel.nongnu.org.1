Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C1AE2D5D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Jun 2025 02:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT82j-0003Ln-5m; Sat, 21 Jun 2025 19:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82Q-0002GQ-SN
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:23 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82O-00058L-JK
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:22 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2345385b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550059; x=1751154859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b1cvp6nsAYxzmmM9YKoetGAbpi3UBhBUqauTo48a7xE=;
 b=AoT/4snscCoR/LN1V84lLB1fcGLjzAkYVfWqpMMqLtKg5kqH5TYOXEDo795YwOnL04
 R2xTTKWFFJEFHDqt1tzUj5hPfNYKhYALkiqJfpJuWMI0aSFJBGwqvG8XR+2/dFd5tqK4
 DTcoVMYXiVFd7Mh/sJtFGSOftp9QO4PtJ098S4U3sCLV2IILTNycrdrVsf480VhCnWCV
 uegtm7vFQ8nbTMA93g8DfSPYIdYsipGmClh8BfijChDaU37E0/0N1GX4TyGtOOFa7ip9
 /0VcFmxvX7xmN0Wg7wQw4KSqLe2c3AxAIFP6mzjIXLgkx77B7AJtgFJD15hYd7YOGUES
 bhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550059; x=1751154859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b1cvp6nsAYxzmmM9YKoetGAbpi3UBhBUqauTo48a7xE=;
 b=Eg/0K8VWyyIAhRIl63fuN2N2KPqdax+7XFjJwWVChr5FSsM5d+H8iTFEmMQnjoPGHj
 tucTAuZQ4S0rypwwul7nj3jOyyilzgge9i1QKiZ0SD8BNd3Z58QScPy+vPxspslxUjOT
 s5TP2KiJLFKKsf4z6UJbFCgYhd6ICpenh8VJva1eMgB+KbDSUAdKP2vak9+qma90wpkI
 2Y7czjhadJMXaDeboEeVzIVNcvO0e0NNMK9uIIEgi0uyi7CyHSscQarJ8Vx5VVImXL4n
 mApWjXPdF3k3jVoT9NVd2amzA9NQ1aawre1v7zaKI8zKNF8vzLv8Q+nHOisz2cDsMLpA
 4L/g==
X-Gm-Message-State: AOJu0Yz6PEOvPUIp+/3sCpgRXqkVD5TiGlX4WHrMNsPzk6YO1Y6aDlxM
 VWi2vgixmmLlgtkIL7yc8/S/pjxN1f8FAPTxBiu5YbXm+PWOKdIffszoRm9UzKDIHZnsAJ/cEHe
 176Yal7E=
X-Gm-Gg: ASbGncv/oDOvKhHWXEhksKATeLZ0iCF3XZBPfe0KH2YGk90MAXLMiakEa96nUxsPjgB
 Gggqv0BaRapy802uPxGsOE+zf9/SFaY57xJmcBsjrYu1b5clah4zwlFoAtfLnTKK8oaxqb156oT
 lpG2RgoRmuwSYAZvdaX2ACpllCbxCvWJm3Gq8oZThXJdfdHwyHPES7sBsOCCCv7gahakL4duStR
 WtpkkXfpOM1+SSqNaNDnV7ZMSJ5Pow7KMvHMdsaN0s9HOgR74yv2wSAbZFPRlZUFmNJ/2SWRS9D
 EzgkaOSd/FwvwT7ZcnUWLMxWIWAU92+CLKOXIGCbkAIsth8VIxLGUaSmyKGQn2NMWONBL3mGfef
 t/wETM9ZQu4QgEiMif3U4
X-Google-Smtp-Source: AGHT+IHRQIZ4OXpEBVrTBZcz7ebD3I3481AijkntY5DIL3CU2JZksY/WRyx7GkhI2k+FtCMBfn9uEg==
X-Received: by 2002:a05:6a21:3387:b0:21f:4ecc:119d with SMTP id
 adf61e73a8af0-220291cd057mr9748947637.7.1750550059192; 
 Sat, 21 Jun 2025 16:54:19 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 063/101] target/arm: Implement SME2 SQRSHR, UQRSHR, SQRSHRN
Date: Sat, 21 Jun 2025 16:49:59 -0700
Message-ID: <20250621235037.74091-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/arm/tcg/helper-sme.h    |  20 ++++++
 target/arm/tcg/sme_helper.c    | 120 +++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c |  33 +++++++++
 target/arm/tcg/sme.decode      |  37 ++++++++++
 4 files changed, 210 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 83277bdcdb..3e878a2ed3 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -265,3 +265,23 @@ DEF_HELPER_FLAGS_3(sme2_uzp4_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uzp4_q, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshr_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshru_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_sb, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uqrshrn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sqrshrun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f6af876286..a3ef8770bb 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1590,6 +1590,66 @@ SQCVT4(sme2_sqcvtu_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVT4
 
+#define SQRSHR2(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR2(sme2_sqrshr_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHR2(sme2_uqrshr_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHR2(sme2_sqrshru_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR2
+
+#define SQRSHR4(NAME, TW, TN, HW, HN, RSHR, SAT)                \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(i)] = SAT(RSHR(s0[HW(i)], shift));                 \
+        d[HN(i) + n] = SAT(RSHR(s1[HW(i)], shift));             \
+        d[HN(i) + 2 * n] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(i) + 3 * n] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHR4(sme2_sqrshr_sb, int32_t, int8_t, H4, H2, do_srshr, do_ssat_b)
+SQRSHR4(sme2_uqrshr_sb, uint32_t, uint8_t, H4, H2, do_urshr, do_usat_b)
+SQRSHR4(sme2_sqrshru_sb, int32_t, uint8_t, H4, H2, do_srshr, do_usat_b)
+
+SQRSHR4(sme2_sqrshr_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHR4(sme2_uqrshr_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHR4(sme2_sqrshru_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHR4
+
 /* Convert and interleave */
 void HELPER(sme2_bfcvtn)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
@@ -1679,6 +1739,66 @@ SQCVTN4(sme2_sqcvtun_dh, int64_t, uint16_t, H8, H2, do_usat_h)
 
 #undef SQCVTN4
 
+#define SQRSHRN2(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 2 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(2 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(2 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN2(sme2_sqrshrn_sh, int32_t, int16_t, H4, H2, do_srshr, do_ssat_h)
+SQRSHRN2(sme2_uqrshrn_sh, uint32_t, uint16_t, H4, H2, do_urshr, do_usat_h)
+SQRSHRN2(sme2_sqrshrun_sh, int32_t, uint16_t, H4, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN2
+
+#define SQRSHRN4(NAME, TW, TN, HW, HN, RSHR, SAT)               \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    size_t oprsz = simd_oprsz(desc), n = oprsz / sizeof(TW);    \
+    int shift = simd_data(desc);                                \
+    TW *s0 = vs, *s1 = vs + sizeof(ARMVectorReg);               \
+    TW *s2 = vs + 2 * sizeof(ARMVectorReg);                     \
+    TW *s3 = vs + 3 * sizeof(ARMVectorReg);                     \
+    TN *d = vd;                                                 \
+    if ((vd - vs) < 4 * sizeof(ARMVectorReg)) {                 \
+        d = (TN *)&scratch;                                     \
+    }                                                           \
+    for (size_t i = 0; i < n; ++i) {                            \
+        d[HN(4 * i + 0)] = SAT(RSHR(s0[HW(i)], shift));         \
+        d[HN(4 * i + 1)] = SAT(RSHR(s1[HW(i)], shift));         \
+        d[HN(4 * i + 2)] = SAT(RSHR(s2[HW(i)], shift));         \
+        d[HN(4 * i + 3)] = SAT(RSHR(s3[HW(i)], shift));         \
+    }                                                           \
+    if (d != vd) {                                              \
+        memcpy(vd, d, oprsz);                                   \
+    }                                                           \
+}
+
+SQRSHRN4(sme2_sqrshrn_sb, int32_t, int8_t, H4, H1, do_srshr, do_ssat_b)
+SQRSHRN4(sme2_uqrshrn_sb, uint32_t, uint8_t, H4, H1, do_urshr, do_usat_b)
+SQRSHRN4(sme2_sqrshrun_sb, int32_t, uint8_t, H4, H1, do_srshr, do_usat_b)
+
+SQRSHRN4(sme2_sqrshrn_dh, int64_t, int16_t, H8, H2, do_srshr, do_ssat_h)
+SQRSHRN4(sme2_uqrshrn_dh, uint64_t, uint16_t, H8, H2, do_urshr, do_usat_h)
+SQRSHRN4(sme2_sqrshrun_dh, int64_t, uint16_t, H8, H2, do_srshr, do_usat_h)
+
+#undef SQRSHRN4
+
 /* Expand and convert */
 void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b118e34849..a7deb67d3b 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1398,3 +1398,36 @@ static gen_helper_gvec_2 * const uzp4_fns[] = {
     gen_helper_sme2_uzp4_q,
 };
 TRANS_FEAT(UZP_4, aa64_sme2, do_zipuzp_4, a, uzp4_fns)
+
+static bool do_zz_rshr(DisasContext *s, arg_rshr *a, gen_helper_gvec_2 *fn)
+{
+    if (sme_sm_enabled_check(s)) {
+        int svl = streaming_vec_reg_size(s);
+        tcg_gen_gvec_2_ool(vec_full_reg_offset(s, a->zd),
+                           vec_full_reg_offset(s, a->zn),
+                           svl, svl, a->shift, fn);
+    }
+    return true;
+}
+
+TRANS_FEAT(SQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sh)
+TRANS_FEAT(UQRSHR_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sh)
+TRANS_FEAT(SQRSHRU_sh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sh)
+
+TRANS_FEAT(SQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_sb)
+TRANS_FEAT(SQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshr_dh)
+TRANS_FEAT(UQRSHR_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_sb)
+TRANS_FEAT(UQRSHR_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshr_dh)
+TRANS_FEAT(SQRSHRU_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_sb)
+TRANS_FEAT(SQRSHRU_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshru_dh)
+
+TRANS_FEAT(SQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sh)
+TRANS_FEAT(UQRSHRN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sh)
+TRANS_FEAT(SQRSHRUN_sh, aa64_sme2_or_sve2p1, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sh)
+
+TRANS_FEAT(SQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_sb)
+TRANS_FEAT(SQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrn_dh)
+TRANS_FEAT(UQRSHRN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_sb)
+TRANS_FEAT(UQRSHRN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_uqrshrn_dh)
+TRANS_FEAT(SQRSHRUN_sb, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_sb)
+TRANS_FEAT(SQRSHRUN_dh, aa64_sme2, do_zz_rshr, a, gen_helper_sme2_sqrshrun_dh)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a43edb625c..1857f3c1a4 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -810,3 +810,40 @@ UZP_4           11000001 esz:2 1 10110 111000 ...00 ... 10   \
                 &zz_e zd=%zd_ax4 zn=%zn_ax4
 UZP_4           11000001 001     10111 111000 ...00 ... 10   \
                 &zz_e esz=4 zd=%zd_ax4 zn=%zn_ax4
+
+### SME2 Multi-vector SVE Constructive Binary
+
+&rshr           zd zn shift
+
+%rshr_sh_shift  16:4 !function=rsub_16
+%rshr_sb_shift  16:5 !function=rsub_32
+%rshr_dh_shift  22:1 16:5 !function=rsub_64
+
+@rshr_sh        ........ .... .... ...... ..... zd:5        \
+                &rshr zn=%zn_ax2 shift=%rshr_sh_shift
+@rshr_sb        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_sb_shift
+@rshr_dh        ........ ... ..... ...... ..... zd:5        \
+                &rshr zn=%zn_ax4 shift=%rshr_dh_shift
+
+SQRSHR_sh       11000001 1110 .... 110101 ....0 .....       @rshr_sh
+UQRSHR_sh       11000001 1110 .... 110101 ....1 .....       @rshr_sh
+SQRSHRU_sh      11000001 1111 .... 110101 ....0 .....       @rshr_sh
+
+SQRSHR_sb       11000001 011 ..... 110110 ...00 .....       @rshr_sb
+SQRSHR_dh       11000001 1.1 ..... 110110 ...00 .....       @rshr_dh
+UQRSHR_sb       11000001 011 ..... 110110 ...01 .....       @rshr_sb
+UQRSHR_dh       11000001 1.1 ..... 110110 ...01 .....       @rshr_dh
+SQRSHRU_sb      11000001 011 ..... 110110 ...10 .....       @rshr_sb
+SQRSHRU_dh      11000001 1.1 ..... 110110 ...10 .....       @rshr_dh
+
+SQRSHRN_sh      01000101 1011 .... 001010 ....0 .....       @rshr_sh
+UQRSHRN_sh      01000101 1011 .... 001110 ....0 .....       @rshr_sh
+SQRSHRUN_sh     01000101 1011 .... 000010 ....0 .....       @rshr_sh
+
+SQRSHRN_sb      11000001 011 ..... 110111 ...00 .....       @rshr_sb
+SQRSHRN_dh      11000001 1.1 ..... 110111 ...00 .....       @rshr_dh
+UQRSHRN_sb      11000001 011 ..... 110111 ...01 .....       @rshr_sb
+UQRSHRN_dh      11000001 1.1 ..... 110111 ...01 .....       @rshr_dh
+SQRSHRUN_sb     11000001 011 ..... 110111 ...10 .....       @rshr_sb
+SQRSHRUN_dh     11000001 1.1 ..... 110111 ...10 .....       @rshr_dh
-- 
2.43.0


