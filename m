Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF897CA07
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 15:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwn-0006LT-F1; Thu, 19 Sep 2024 09:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwX-0005Tx-0L
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:36 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwR-00014E-1b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f77fe7ccc4so8884391fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751485; x=1727356285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YX3mccd/hP9orfB/TKgT2VwiqPk/5Rtp6hQ5FMQbk2g=;
 b=i2OoEQv5NroWHArbn5+S4JXaZgyNsfTGLBiSTVC75nbVZYRCFsZO151OhbVC6Kral5
 uWaHCTj2IePdKGg5L28QUm8y9FTp9T3LKZQaPb2OwDxbLN4na18G/TsXMwvvgaBM4PxL
 0eUC4NG8lR3l4koQX0rtaVRikF4KCmNVs8rgO98BhBB1aRbkuqLqdZLFJhJ0ApgyqnT0
 8+XXI7oF1RGzpNgabmuOWIvbFdmScFKA66P3V+kom7SvAUM874FnksHTj+C+zAgFb9PO
 kZN7uJdCCyobmH5q8bdk1GXVCT+2eyi70sAxToek9i2tK2/0JklZqAQW4z6MX5NdWCO1
 QpdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751485; x=1727356285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YX3mccd/hP9orfB/TKgT2VwiqPk/5Rtp6hQ5FMQbk2g=;
 b=LKTHCQzaHIR7+oAoH0XxpSJi2JV5qFBSFWWyXTlh/Q12x/Q4lQ/7l6/IQEpP49CcqV
 Mttd3Qoep7rUqxgMk2Dg8Yzq6ViQc8eHGFSfD4t9lgq/wW2WfzR8M0+iB3mWKYO/TBjc
 TqhtXsqmO6rS5k3GKufs5X4nKklnbaell9HaaOqYoHm3353kpbFWEGzZnzm89g3Z/frJ
 lk7DQEShYZ1jsu9vCf2aKJh1rmfW+tWSpF9H4wG7a0zhDGasxoZ8t3/pnflEQsoBg+yn
 chTJ6pY5wpxfsitMfhX4tadblGPzrdZGy1ErkfMs7q4Ru/5XNMb7KxX2vrIeCs/vj/Bq
 XfMg==
X-Gm-Message-State: AOJu0YyHZvDkDdnVH7LDB1ZA0wejnUsCuICslwR6uE6B6wWiDDAfKm2Z
 Ja80IJSkdRmZM+SY7bvSTM2r1DJeHbCfhiBy7Qv1l1iW/S3buC3yzzFsfR/IG+xrnKCBwnt3541
 d
X-Google-Smtp-Source: AGHT+IH7eIXtT4xc9teZwlLRo9LH78kDLVpmqMuTR5Yl9+WgQ6OZul9ueRRKmuRWX1/Qaj00Cu2PoA==
X-Received: by 2002:a2e:be1f:0:b0:2f7:64b9:ff90 with SMTP id
 38308e7fff4ca-2f7918e9558mr116760121fa.9.1726751484816; 
 Thu, 19 Sep 2024 06:11:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/38] target/arm: Convert scalar [US]QSHRN, [US]QRSHRN,
 SQSHRUN to decodetree
Date: Thu, 19 Sep 2024 14:10:57 +0100
Message-Id: <20240919131106.3362543-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-30-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  30 +++++++
 target/arm/tcg/translate-a64.c | 160 +++++++--------------------------
 2 files changed, 63 insertions(+), 127 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 042dc79d88a..331a8e180c0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1328,6 +1328,12 @@ SQRSHRUN_v      0.10 11110 .... ... 10001 1 ..... .....     @q_shri_s
 
 # Advanced SIMD scalar shift by immediate
 
+@shri_b         .... ..... 0001 ... ..... . rn:5 rd:5   \
+                &rri_e esz=0 imm=%neon_rshift_i3
+@shri_h         .... ..... 001 .... ..... . rn:5 rd:5   \
+                &rri_e esz=1 imm=%neon_rshift_i4
+@shri_s         .... ..... 01 ..... ..... . rn:5 rd:5   \
+                &rri_e esz=2 imm=%neon_rshift_i5
 @shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
                 &rri_e esz=3 imm=%neon_rshift_i6
 
@@ -1363,3 +1369,27 @@ SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_b
 SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_h
 SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_s
 SQSHLU_si       0111 11110 .... ... 01100 1 ..... .....     @shli_d
+
+SQSHRN_si       0101 11110 .... ... 10010 1 ..... .....     @shri_b
+SQSHRN_si       0101 11110 .... ... 10010 1 ..... .....     @shri_h
+SQSHRN_si       0101 11110 .... ... 10010 1 ..... .....     @shri_s
+
+UQSHRN_si       0111 11110 .... ... 10010 1 ..... .....     @shri_b
+UQSHRN_si       0111 11110 .... ... 10010 1 ..... .....     @shri_h
+UQSHRN_si       0111 11110 .... ... 10010 1 ..... .....     @shri_s
+
+SQSHRUN_si      0111 11110 .... ... 10000 1 ..... .....     @shri_b
+SQSHRUN_si      0111 11110 .... ... 10000 1 ..... .....     @shri_h
+SQSHRUN_si      0111 11110 .... ... 10000 1 ..... .....     @shri_s
+
+SQRSHRN_si      0101 11110 .... ... 10011 1 ..... .....     @shri_b
+SQRSHRN_si      0101 11110 .... ... 10011 1 ..... .....     @shri_h
+SQRSHRN_si      0101 11110 .... ... 10011 1 ..... .....     @shri_s
+
+UQRSHRN_si      0111 11110 .... ... 10011 1 ..... .....     @shri_b
+UQRSHRN_si      0111 11110 .... ... 10011 1 ..... .....     @shri_h
+UQRSHRN_si      0111 11110 .... ... 10011 1 ..... .....     @shri_s
+
+SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_b
+SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_h
+SQRSHRUN_si     0111 11110 .... ... 10001 1 ..... .....     @shri_s
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index e6290e11453..071b6349fc3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7456,6 +7456,35 @@ TRANS(SQSHL_si, do_scalar_shift_imm, a, f_scalar_sqshli[a->esz], false, 0)
 TRANS(UQSHL_si, do_scalar_shift_imm, a, f_scalar_uqshli[a->esz], false, 0)
 TRANS(SQSHLU_si, do_scalar_shift_imm, a, f_scalar_sqshlui[a->esz], false, 0)
 
+static bool do_scalar_shift_imm_narrow(DisasContext *s, arg_rri_e *a,
+                                       WideShiftImmFn * const fns[3],
+                                       MemOp sign, bool zext)
+{
+    MemOp esz = a->esz;
+
+    tcg_debug_assert(esz >= MO_8 && esz <= MO_32);
+
+    if (fp_access_check(s)) {
+        TCGv_i64 rd = tcg_temp_new_i64();
+        TCGv_i64 rn = tcg_temp_new_i64();
+
+        read_vec_element(s, rn, a->rn, 0, (esz + 1) | sign);
+        fns[esz](rd, rn, a->imm);
+        if (zext) {
+            tcg_gen_ext_i64(rd, rd, esz);
+        }
+        write_fp_dreg(s, a->rd, rd);
+    }
+    return true;
+}
+
+TRANS(SQSHRN_si, do_scalar_shift_imm_narrow, a, sqshrn_fns, MO_SIGN, true)
+TRANS(SQRSHRN_si, do_scalar_shift_imm_narrow, a, sqrshrn_fns, MO_SIGN, true)
+TRANS(UQSHRN_si, do_scalar_shift_imm_narrow, a, uqshrn_fns, 0, false)
+TRANS(UQRSHRN_si, do_scalar_shift_imm_narrow, a, uqrshrn_fns, 0, false)
+TRANS(SQSHRUN_si, do_scalar_shift_imm_narrow, a, sqshrun_fns, MO_SIGN, false)
+TRANS(SQRSHRUN_si, do_scalar_shift_imm_narrow, a, sqrshrun_fns, MO_SIGN, false)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9635,119 +9664,6 @@ static void disas_data_proc_fp(DisasContext *s, uint32_t insn)
     }
 }
 
-/*
- * Common SSHR[RA]/USHR[RA] - Shift right (optional rounding/accumulate)
- *
- * This code is handles the common shifting code and is used by both
- * the vector and scalar code.
- */
-static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
-                                    bool round, bool accumulate,
-                                    bool is_u, int size, int shift)
-{
-    if (!round) {
-        if (is_u) {
-            gen_ushr_d(tcg_src, tcg_src, shift);
-        } else {
-            gen_sshr_d(tcg_src, tcg_src, shift);
-        }
-    } else if (size == MO_64) {
-        if (is_u) {
-            gen_urshr_d(tcg_src, tcg_src, shift);
-        } else {
-            gen_srshr_d(tcg_src, tcg_src, shift);
-        }
-    } else {
-        if (is_u) {
-            gen_urshr_bhs(tcg_src, tcg_src, shift);
-        } else {
-            gen_srshr_bhs(tcg_src, tcg_src, shift);
-        }
-    }
-
-    if (accumulate) {
-        tcg_gen_add_i64(tcg_res, tcg_res, tcg_src);
-    } else {
-        tcg_gen_mov_i64(tcg_res, tcg_src);
-    }
-}
-
-/* SQSHRN/SQSHRUN - Saturating (signed/unsigned) shift right with
- * (signed/unsigned) narrowing */
-static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
-                                   bool is_u_shift, bool is_u_narrow,
-                                   int immh, int immb, int opcode,
-                                   int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int size = 32 - clz32(immh) - 1;
-    int esize = 8 << size;
-    int shift = (2 * esize) - immhb;
-    int elements = is_scalar ? 1 : (64 / esize);
-    bool round = extract32(opcode, 0, 1);
-    MemOp ldop = (size + 1) | (is_u_shift ? 0 : MO_SIGN);
-    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
-
-    static NeonGenOne64OpEnvFn * const signed_narrow_fns[4][2] = {
-        { gen_helper_neon_narrow_sat_s8,
-          gen_helper_neon_unarrow_sat8 },
-        { gen_helper_neon_narrow_sat_s16,
-          gen_helper_neon_unarrow_sat16 },
-        { gen_helper_neon_narrow_sat_s32,
-          gen_helper_neon_unarrow_sat32 },
-        { NULL, NULL },
-    };
-    static NeonGenOne64OpEnvFn * const unsigned_narrow_fns[4] = {
-        gen_helper_neon_narrow_sat_u8,
-        gen_helper_neon_narrow_sat_u16,
-        gen_helper_neon_narrow_sat_u32,
-        NULL
-    };
-    NeonGenOne64OpEnvFn *narrowfn;
-
-    int i;
-
-    assert(size < 4);
-
-    if (extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (is_u_shift) {
-        narrowfn = unsigned_narrow_fns[size];
-    } else {
-        narrowfn = signed_narrow_fns[size][is_u_narrow ? 1 : 0];
-    }
-
-    tcg_rn = tcg_temp_new_i64();
-    tcg_rd = tcg_temp_new_i64();
-    tcg_final = tcg_temp_new_i64();
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, ldop);
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
-                                false, is_u_shift, size+1, shift);
-        narrowfn(tcg_rd, tcg_env, tcg_rd);
-        if (i == 0) {
-            tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
-        } else {
-            tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
-        }
-    }
-
-    if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
-    } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
-    }
-    clear_vec_high(s, is_q, rd);
-}
-
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -10013,20 +9929,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
-    case 0x10: /* SQSHRUN, SQSHRUN2 */
-    case 0x11: /* SQRSHRUN, SQRSHRUN2 */
-        if (!is_u) {
-            unallocated_encoding(s);
-            return;
-        }
-        handle_vec_simd_sqshrn(s, true, false, false, true,
-                               immh, immb, opcode, rn, rd);
-        break;
-    case 0x12: /* SQSHRN, SQSHRN2, UQSHRN */
-    case 0x13: /* SQRSHRN, SQRSHRN2, UQRSHRN, UQRSHRN2 */
-        handle_vec_simd_sqshrn(s, true, false, is_u, is_u,
-                               immh, immb, opcode, rn, rd);
-        break;
     case 0x1f: /* FCVTZS, FCVTZU */
         handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
         break;
@@ -10039,6 +9941,10 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x0a: /* SHL / SLI */
     case 0x0c: /* SQSHLU */
     case 0x0e: /* SQSHL, UQSHL */
+    case 0x10: /* SQSHRUN */
+    case 0x11: /* SQRSHRUN */
+    case 0x12: /* SQSHRN, UQSHRN */
+    case 0x13: /* SQRSHRN, UQRSHRN */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


