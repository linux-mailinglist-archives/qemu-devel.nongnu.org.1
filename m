Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A58CD755
	for <lists+qemu-devel@lfdr.de>; Thu, 23 May 2024 17:39:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATe-0007yx-LC; Thu, 23 May 2024 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATZ-0007vj-TH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATU-0002VZ-AU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:28 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-351b683f2d8so1813670f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478523; x=1717083323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WJRgY/sGVmx1LAGLXqVHyDltWn/lhbg50E++AkMA69Y=;
 b=kxWSFKD0vsWgnnJq+Yzc6TXgYbRbE+IAIDTdm1QqbfkKgIFLYLh097iB8BTqvTwBYi
 x+odDguu16rLBqNKHepNxG7rK5DYCYv1QQZfB7ktWLiP2p7Y6JV0eSGsq7bwKUPFYxNI
 dkD0mVdlU+1LZcCOw58tN7PNwgmdlVtOMjeAkB8SnU2dI11t7R69+m9xDuCxP9mduOfb
 ZRXSQMYBgIM8GpwdrFMlQVzP61HJaJAUcTsWstnQI1kv/werpDzzr7rRz4aRoG/wx2Uz
 0n0W/Xw31lE/v1tUxVkpGiJx9Pd3p8AeHukdMaUpMKPh8sg624NbjGfzN+aN6ukDyFlD
 anGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478523; x=1717083323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJRgY/sGVmx1LAGLXqVHyDltWn/lhbg50E++AkMA69Y=;
 b=BsXbriTc/SE1ajEy6Yb0BQLU95DaaRv2x3m7KBFq0BEM5/DnsG5kXfs0RrXwQ6tl1Q
 /dJJoPyNaUiWgmthIgIm9+c0+6JyIlEcbgGVCD/PsxQC92Nj2pElKMnnRdrEvaSXSNL6
 kEEqASCHdbylxkiyA+pZPdfkbTL996Yndif2yHTA8tzWO8TnyxKJ7r5GwsKiTLtHb3FV
 b2psLkaASWoQEdPKhFVSXKxi8ZVuf4611VTZSbLBWmt7wbVvJUEXR3AKd3rsxXGvVXZm
 ksx5dmz7S44BQ/G1ZpzOVl1CjyhW77tGB5gYFIHxo+GjfnqHr1PPu4geTTkYGa6WsIOQ
 tR8Q==
X-Gm-Message-State: AOJu0Ywc8Xo7zMrEp2ZAZvT2zc7oDRcujj7YjBvJ4JGEe+jkXVrEgZQp
 xXqWnb/9nUH4cPmajpmQQU14hs4pc8sQ+1nTYJDsu2DxWQbcd9j6YtAyTHcpCoz3vHbBGJy9CT5
 B
X-Google-Smtp-Source: AGHT+IHtMWS/nX60Nbo1SXhmH1jA+zS4kH4Nq+tXQEnNWECt1aW1ZPgNL2OXk1958k8LRg4J6qCe1Q==
X-Received: by 2002:adf:f304:0:b0:354:fc03:b44 with SMTP id
 ffacd0b85a97d-354fc030c3amr1189967f8f.4.1716478522740; 
 Thu, 23 May 2024 08:35:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/37] target/arm: Use gvec for neon faddp, fmaxp, fminp
Date: Thu, 23 May 2024 16:34:59 +0100
Message-Id: <20240523153505.2900433-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240506010403.6204-24-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             |  7 -----
 target/arm/tcg/translate-neon.c | 55 ++-------------------------------
 target/arm/tcg/vec_helper.c     | 45 ---------------------------
 3 files changed, 3 insertions(+), 104 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 32684773299..065460ea80e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -650,13 +650,6 @@ DEF_HELPER_FLAGS_6(gvec_fcmlas_idx, TCG_CALL_NO_RWG,
 DEF_HELPER_FLAGS_6(gvec_fcmlad, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_5(neon_paddh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pminh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_padds, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmaxs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_5(neon_pmins, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-
 DEF_HELPER_FLAGS_4(gvec_sstoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_sitos, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_ustoh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index 144f18ba22e..2326a05a0aa 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1144,6 +1144,9 @@ DO_3S_FP_GVEC(VFMA, gen_helper_gvec_vfma_s, gen_helper_gvec_vfma_h)
 DO_3S_FP_GVEC(VFMS, gen_helper_gvec_vfms_s, gen_helper_gvec_vfms_h)
 DO_3S_FP_GVEC(VRECPS, gen_helper_gvec_recps_nf_s, gen_helper_gvec_recps_nf_h)
 DO_3S_FP_GVEC(VRSQRTS, gen_helper_gvec_rsqrts_nf_s, gen_helper_gvec_rsqrts_nf_h)
+DO_3S_FP_GVEC(VPADD, gen_helper_gvec_faddp_s, gen_helper_gvec_faddp_h)
+DO_3S_FP_GVEC(VPMAX, gen_helper_gvec_fmaxp_s, gen_helper_gvec_fmaxp_h)
+DO_3S_FP_GVEC(VPMIN, gen_helper_gvec_fminp_s, gen_helper_gvec_fminp_h)
 
 WRAP_FP_GVEC(gen_VMAXNM_fp32_3s, FPST_STD, gen_helper_gvec_fmaxnum_s)
 WRAP_FP_GVEC(gen_VMAXNM_fp16_3s, FPST_STD_F16, gen_helper_gvec_fmaxnum_h)
@@ -1180,58 +1183,6 @@ static bool trans_VMINNM_fp_3s(DisasContext *s, arg_3same *a)
     return do_3same(s, a, gen_VMINNM_fp32_3s);
 }
 
-static bool do_3same_fp_pair(DisasContext *s, arg_3same *a,
-                             gen_helper_gvec_3_ptr *fn)
-{
-    /* FP pairwise operations */
-    TCGv_ptr fpstatus;
-
-    if (!arm_dc_feature(s, ARM_FEATURE_NEON)) {
-        return false;
-    }
-
-    /* UNDEF accesses to D16-D31 if they don't exist. */
-    if (!dc_isar_feature(aa32_simd_r32, s) &&
-        ((a->vd | a->vn | a->vm) & 0x10)) {
-        return false;
-    }
-
-    if (!vfp_access_check(s)) {
-        return true;
-    }
-
-    assert(a->q == 0); /* enforced by decode patterns */
-
-
-    fpstatus = fpstatus_ptr(a->size == MO_16 ? FPST_STD_F16 : FPST_STD);
-    tcg_gen_gvec_3_ptr(vfp_reg_offset(1, a->vd),
-                       vfp_reg_offset(1, a->vn),
-                       vfp_reg_offset(1, a->vm),
-                       fpstatus, 8, 8, 0, fn);
-
-    return true;
-}
-
-/*
- * For all the functions using this macro, size == 1 means fp16,
- * which is an architecture extension we don't implement yet.
- */
-#define DO_3S_FP_PAIR(INSN,FUNC)                                    \
-    static bool trans_##INSN##_fp_3s(DisasContext *s, arg_3same *a) \
-    {                                                               \
-        if (a->size == MO_16) {                                     \
-            if (!dc_isar_feature(aa32_fp16_arith, s)) {             \
-                return false;                                       \
-            }                                                       \
-            return do_3same_fp_pair(s, a, FUNC##h);                 \
-        }                                                           \
-        return do_3same_fp_pair(s, a, FUNC##s);                     \
-    }
-
-DO_3S_FP_PAIR(VPADD, gen_helper_neon_padd)
-DO_3S_FP_PAIR(VPMAX, gen_helper_neon_pmax)
-DO_3S_FP_PAIR(VPMIN, gen_helper_neon_pmin)
-
 static bool do_vector_2sh(DisasContext *s, arg_2reg_shift *a, GVecGen2iFn *fn)
 {
     /* Handle a 2-reg-shift insn which can be vectorized. */
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 79e1fdcaa9f..26a9ca9c14a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2192,51 +2192,6 @@ DO_ABA(gvec_uaba_d, uint64_t)
 
 #undef DO_ABA
 
-#define DO_NEON_PAIRWISE(NAME, OP)                                      \
-    void HELPER(NAME##s)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float32 *d = vd;                                                \
-        float32 *n = vn;                                                \
-        float32 *m = vm;                                                \
-        float32 r0, r1;                                                 \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float32_##OP(n[H4(0)], n[H4(1)], fpst);                    \
-        r1 = float32_##OP(m[H4(0)], m[H4(1)], fpst);                    \
-                                                                        \
-        d[H4(0)] = r0;                                                  \
-        d[H4(1)] = r1;                                                  \
-    }                                                                   \
-                                                                        \
-    void HELPER(NAME##h)(void *vd, void *vn, void *vm,                  \
-                         void *stat, uint32_t oprsz)                    \
-    {                                                                   \
-        float_status *fpst = stat;                                      \
-        float16 *d = vd;                                                \
-        float16 *n = vn;                                                \
-        float16 *m = vm;                                                \
-        float16 r0, r1, r2, r3;                                         \
-                                                                        \
-        /* Read all inputs before writing outputs in case vm == vd */   \
-        r0 = float16_##OP(n[H2(0)], n[H2(1)], fpst);                    \
-        r1 = float16_##OP(n[H2(2)], n[H2(3)], fpst);                    \
-        r2 = float16_##OP(m[H2(0)], m[H2(1)], fpst);                    \
-        r3 = float16_##OP(m[H2(2)], m[H2(3)], fpst);                    \
-                                                                        \
-        d[H2(0)] = r0;                                                  \
-        d[H2(1)] = r1;                                                  \
-        d[H2(2)] = r2;                                                  \
-        d[H2(3)] = r3;                                                  \
-    }
-
-DO_NEON_PAIRWISE(neon_padd, add)
-DO_NEON_PAIRWISE(neon_pmax, max)
-DO_NEON_PAIRWISE(neon_pmin, min)
-
-#undef DO_NEON_PAIRWISE
-
 #define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.34.1


