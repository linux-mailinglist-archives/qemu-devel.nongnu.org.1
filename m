Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5C8CECB9
	for <lists+qemu-devel@lfdr.de>; Sat, 25 May 2024 01:23:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAeEd-0006ok-2l; Fri, 24 May 2024 19:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEN-0006Y3-RQ
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:47 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAeEH-0005nN-I4
 for qemu-devel@nongnu.org; Fri, 24 May 2024 19:21:47 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f3469382f2so16980035ad.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 16:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716592899; x=1717197699; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AUu9ImPu+PJ6nwVQRGFf6BOKQ5seZeCZAivr++UdtqU=;
 b=B/OyBElF7JTlH4LH5e3NWhAA9piMBD9hDXXxLua0j7FDvU69xj7mrbghfdxccl7pqh
 0AMZcCobUZ56XUubnOHRmE8VJxTS0JVdO4hJvKC55KacQNecYyeketM/zXm+nDJb0B6z
 +tRTT2H/oSl2wKJMSmQu3euqil+8H+kaR8IG+acOZbv//cWlZ9SUeSE10UYkUcWcpvAV
 svAr6n6MX1644ejWf/4QBDEGKMPl9FKThHKhji7AIO9ups4CTgXyJJITRpaBPSPAszE2
 mFMTOycera22YaUJEHrI5/5bTY562U+7tGZRz1ionD+9U/55mkymVRxgvwL/2tfZCEzA
 BYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716592899; x=1717197699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AUu9ImPu+PJ6nwVQRGFf6BOKQ5seZeCZAivr++UdtqU=;
 b=mdRkmD78lc/+Go9Xh4mNHVjT8CvaTCgSfFplPWMTTGu+bi8Ba5hIFx7sBeyv848cE7
 ZQuIQs2NYXUbQtiNRqWKWd8gh1tFTeg2SEQLxiQMMQHjBI0aclnP24JE/CtJd9NMNetS
 DyPNvzw0ivYD2mJs8sJg0w/g9OoIAhv0PPLjdydbg24apnfby0HMZfexNPImtdsyAnr5
 qU6Xf4rgCUU0DOF8bTnQB9fIexv4ArnbB+0pUwAFPSqwO43ATK6oPYT8YFEtR03t0pG6
 nxWl8nLhX5GXkslrU8uJlgAiFnKvKhI+O6vRh2fJvAVZaVBgC3uQwApENfnTRCks7qya
 2UMg==
X-Gm-Message-State: AOJu0Yx1K4qCEumsNmIn70TrtgTk4XF1v6ZUZdxGMlayt+KUfVcz04Z8
 0ZcrcD30S1Jj42cQhnZi3f0kfFM2VxE6DItdng9r8eFCM+Dexm6r4EsKLXp/nl++dEFkZpkOKAW
 C
X-Google-Smtp-Source: AGHT+IEzm0wkFppPosA4YhyJRG4ql/peW7v2FyzD0PJjn2/v3dG502J27rUIR6AC6XefCc+6dV0sDw==
X-Received: by 2002:a17:902:f688:b0:1f3:14e7:8ba2 with SMTP id
 d9443c01a7336-1f4486c55ebmr51631875ad.1.1716592898806; 
 Fri, 24 May 2024 16:21:38 -0700 (PDT)
Received: from stoup.. (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c759ceesm19178305ad.10.2024.05.24.16.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 16:21:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 18/67] target/arm: Convert FMULX to decodetree
Date: Fri, 24 May 2024 16:20:32 -0700
Message-Id: <20240524232121.284515-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524232121.284515-1-richard.henderson@linaro.org>
References: <20240524232121.284515-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Convert all forms (scalar, vector, scalar indexed, vector indexed),
which allows us to remove switch table entries elsewhere.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   8 ++
 target/arm/tcg/a64.decode      |  45 +++++++
 target/arm/tcg/translate-a64.c | 221 +++++++++++++++++++++++++++------
 target/arm/tcg/vec_helper.c    |  39 +++---
 4 files changed, 259 insertions(+), 54 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index 0518165399..b79751a717 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -132,3 +132,11 @@ DEF_HELPER_4(cpye, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfp, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfm, void, env, i32, i32, i32)
 DEF_HELPER_4(cpyfe, void, env, i32, i32, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmulx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_fmulx_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d5bfeae7a8..2e0e01be01 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -20,21 +20,44 @@
 #
 
 %rd             0:5
+%esz_sd         22:1 !function=plus_2
+%hl             11:1 21:1
+%hlm            11:1 20:2
 
 &r              rn
 &ri             rd imm
 &rri_sf         rd rn imm sf
 &i              imm
+&rrr_e          rd rn rm esz
+&rrx_e          rd rn rm idx esz
 &qrr_e          q rd rn esz
 &qrrr_e         q rd rn rm esz
+&qrrx_e         q rd rn rm idx esz
 &qrrrr_e        q rd rn rm ra esz
 
+@rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
+@rrr_sd         ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=%esz_sd
+
+@rrx_h          ........ .. .. rm:4 .... . . rn:5 rd:5  &rrx_e esz=1 idx=%hlm
+@rrx_s          ........ .. . rm:5  .... . . rn:5 rd:5  &rrx_e esz=2 idx=%hl
+@rrx_d          ........ .. . rm:5  .... idx:1 . rn:5 rd:5  &rrx_e esz=3
+
 @rr_q1e0        ........ ........ ...... rn:5 rd:5      &qrr_e q=1 esz=0
 @r2r_q1e0       ........ ........ ...... rm:5 rd:5      &qrrr_e rn=%rd q=1 esz=0
 @rrr_q1e0       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=0
 @rrr_q1e3       ........ ... rm:5 ...... rn:5 rd:5      &qrrr_e q=1 esz=3
 @rrrr_q1e3      ........ ... rm:5 . ra:5 rn:5 rd:5      &qrrrr_e q=1 esz=3
 
+@qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
+@qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
+
+@qrrx_h         . q:1 .. .... .. .. rm:4 .... . . rn:5 rd:5 \
+                &qrrx_e esz=1 idx=%hlm
+@qrrx_s         . q:1 .. .... .. . rm:5  .... . . rn:5 rd:5 \
+                &qrrx_e esz=2 idx=%hl
+@qrrx_d         . q:1 .. .... .. . rm:5  .... idx:1 . rn:5 rd:5 \
+                &qrrx_e esz=3
+
 ### Data Processing - Immediate
 
 # PC-rel addressing
@@ -671,3 +694,25 @@ INS_general     0 1   00 1110 000 imm:5 0 0011 1 rn:5 rd:5
 SMOV            0 q:1 00 1110 000 imm:5 0 0101 1 rn:5 rd:5
 UMOV            0 q:1 00 1110 000 imm:5 0 0111 1 rn:5 rd:5
 INS_element     0 1   10 1110 000 di:5  0 si:4 1 rn:5 rd:5
+
+### Advanced SIMD scalar three same
+
+FMULX_s         0101 1110 010 ..... 00011 1 ..... ..... @rrr_h
+FMULX_s         0101 1110 0.1 ..... 11011 1 ..... ..... @rrr_sd
+
+### Advanced SIMD three same
+
+FMULX_v         0.00 1110 010 ..... 00011 1 ..... ..... @qrrr_h
+FMULX_v         0.00 1110 0.1 ..... 11011 1 ..... ..... @qrrr_sd
+
+### Advanced SIMD scalar x indexed element
+
+FMULX_si        0111 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
+FMULX_si        0111 1111 10 . ..... 1001 . 0 ..... .....   @rrx_s
+FMULX_si        0111 1111 11 0 ..... 1001 . 0 ..... .....   @rrx_d
+
+### Advanced SIMD vector x indexed element
+
+FMULX_vi        0.10 1111 00 .. .... 1001 . 0 ..... .....   @qrrx_h
+FMULX_vi        0.10 1111 10 . ..... 1001 . 0 ..... .....   @qrrx_s
+FMULX_vi        0.10 1111 11 0 ..... 1001 . 0 ..... .....   @qrrx_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1a12bf22fd..8cbe6cd70f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4841,6 +4841,178 @@ static bool trans_INS_element(DisasContext *s, arg_INS_element *a)
     return true;
 }
 
+/*
+ * Advanced SIMD three same
+ */
+
+typedef struct FPScalar {
+    void (*gen_h)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_s)(TCGv_i32, TCGv_i32, TCGv_i32, TCGv_ptr);
+    void (*gen_d)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_ptr);
+} FPScalar;
+
+static bool do_fp3_scalar(DisasContext *s, arg_rrr_e *a, const FPScalar *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = read_fp_dreg(s, a->rn);
+            TCGv_i64 t1 = read_fp_dreg(s, a->rm);
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_sreg(s, a->rn);
+            TCGv_i32 t1 = read_fp_sreg(s, a->rm);
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_hreg(s, a->rn);
+            TCGv_i32 t1 = read_fp_hreg(s, a->rm);
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        return false;
+    }
+    return true;
+}
+
+static const FPScalar f_scalar_fmulx = {
+    gen_helper_advsimd_mulxh,
+    gen_helper_vfp_mulxs,
+    gen_helper_vfp_mulxd,
+};
+TRANS(FMULX_s, do_fp3_scalar, a, &f_scalar_fmulx)
+
+static bool do_fp3_vector(DisasContext *s, arg_qrrr_e *a,
+                          gen_helper_gvec_3_ptr * const fns[3])
+{
+    MemOp esz = a->esz;
+
+    switch (esz) {
+    case MO_64:
+        if (!a->q) {
+            return false;
+        }
+        break;
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        return false;
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
+                          esz == MO_16, 0, fns[esz - 1]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_3_ptr * const f_vector_fmulx[3] = {
+    gen_helper_gvec_fmulx_h,
+    gen_helper_gvec_fmulx_s,
+    gen_helper_gvec_fmulx_d,
+};
+TRANS(FMULX_v, do_fp3_vector, a, f_vector_fmulx)
+
+/*
+ * Advanced SIMD scalar/vector x indexed element
+ */
+
+static bool do_fp3_scalar_idx(DisasContext *s, arg_rrx_e *a, const FPScalar *f)
+{
+    switch (a->esz) {
+    case MO_64:
+        if (fp_access_check(s)) {
+            TCGv_i64 t0 = read_fp_dreg(s, a->rn);
+            TCGv_i64 t1 = tcg_temp_new_i64();
+
+            read_vec_element(s, t1, a->rm, a->idx, MO_64);
+            f->gen_d(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_dreg(s, a->rd, t0);
+        }
+        break;
+    case MO_32:
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_sreg(s, a->rn);
+            TCGv_i32 t1 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t1, a->rm, a->idx, MO_32);
+            f->gen_s(t0, t0, t1, fpstatus_ptr(FPST_FPCR));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        if (fp_access_check(s)) {
+            TCGv_i32 t0 = read_fp_hreg(s, a->rn);
+            TCGv_i32 t1 = tcg_temp_new_i32();
+
+            read_vec_element_i32(s, t1, a->rm, a->idx, MO_16);
+            f->gen_h(t0, t0, t1, fpstatus_ptr(FPST_FPCR_F16));
+            write_fp_sreg(s, a->rd, t0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+TRANS(FMULX_si, do_fp3_scalar_idx, a, &f_scalar_fmulx)
+
+static bool do_fp3_vector_idx(DisasContext *s, arg_qrrx_e *a,
+                              gen_helper_gvec_3_ptr * const fns[3])
+{
+    MemOp esz = a->esz;
+
+    switch (esz) {
+    case MO_64:
+        if (!a->q) {
+            return false;
+        }
+        break;
+    case MO_32:
+        break;
+    case MO_16:
+        if (!dc_isar_feature(aa64_fp16, s)) {
+            return false;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    if (fp_access_check(s)) {
+        gen_gvec_op3_fpst(s, a->q, a->rd, a->rn, a->rm,
+                          esz == MO_16, a->idx, fns[esz - 1]);
+    }
+    return true;
+}
+
+static gen_helper_gvec_3_ptr * const f_vector_idx_fmulx[3] = {
+    gen_helper_gvec_fmulx_idx_h,
+    gen_helper_gvec_fmulx_idx_s,
+    gen_helper_gvec_fmulx_idx_d,
+};
+TRANS(FMULX_vi, do_fp3_vector_idx, a, f_vector_idx_fmulx)
+
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9011,9 +9183,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x1a: /* FADD */
                 gen_helper_vfp_addd(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1b: /* FMULX */
-                gen_helper_vfp_mulxd(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9058,6 +9227,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f64(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1b: /* FMULX */
                 g_assert_not_reached();
             }
 
@@ -9084,9 +9254,6 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
             case 0x1a: /* FADD */
                 gen_helper_vfp_adds(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x1b: /* FMULX */
-                gen_helper_vfp_mulxs(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x1c: /* FCMEQ */
                 gen_helper_neon_ceq_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -9134,6 +9301,7 @@ static void handle_3same_float(DisasContext *s, int size, int elements,
                 gen_helper_neon_acgt_f32(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x1b: /* FMULX */
                 g_assert_not_reached();
             }
 
@@ -9172,7 +9340,6 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         /* Floating point: U, size[1] and opcode indicate operation */
         int fpopcode = opcode | (extract32(size, 1, 1) << 5) | (u << 6);
         switch (fpopcode) {
-        case 0x1b: /* FMULX */
         case 0x1f: /* FRECPS */
         case 0x3f: /* FRSQRTS */
         case 0x5d: /* FACGE */
@@ -9183,6 +9350,7 @@ static void disas_simd_scalar_three_reg_same(DisasContext *s, uint32_t insn)
         case 0x7a: /* FABD */
             break;
         default:
+        case 0x1b: /* FMULX */
             unallocated_encoding(s);
             return;
         }
@@ -9335,7 +9503,6 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     TCGv_i32 tcg_res;
 
     switch (fpopcode) {
-    case 0x03: /* FMULX */
     case 0x04: /* FCMEQ (reg) */
     case 0x07: /* FRECPS */
     case 0x0f: /* FRSQRTS */
@@ -9346,6 +9513,7 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     case 0x1d: /* FACGT */
         break;
     default:
+    case 0x03: /* FMULX */
         unallocated_encoding(s);
         return;
     }
@@ -9365,9 +9533,6 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
     tcg_res = tcg_temp_new_i32();
 
     switch (fpopcode) {
-    case 0x03: /* FMULX */
-        gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
-        break;
     case 0x04: /* FCMEQ (reg) */
         gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
@@ -9394,6 +9559,7 @@ static void disas_simd_scalar_three_reg_same_fp16(DisasContext *s,
         gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
         break;
     default:
+    case 0x03: /* FMULX */
         g_assert_not_reached();
     }
 
@@ -11051,7 +11217,6 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         handle_simd_3same_pair(s, is_q, 0, fpopcode, size ? MO_64 : MO_32,
                                rn, rm, rd);
         return;
-    case 0x1b: /* FMULX */
     case 0x1f: /* FRECPS */
     case 0x3f: /* FRSQRTS */
     case 0x5d: /* FACGE */
@@ -11097,6 +11262,7 @@ static void disas_simd_3same_float(DisasContext *s, uint32_t insn)
         return;
 
     default:
+    case 0x1b: /* FMULX */
         unallocated_encoding(s);
         return;
     }
@@ -11441,7 +11607,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
     case 0x0: /* FMAXNM */
     case 0x1: /* FMLA */
     case 0x2: /* FADD */
-    case 0x3: /* FMULX */
     case 0x4: /* FCMEQ */
     case 0x6: /* FMAX */
     case 0x7: /* FRECPS */
@@ -11467,6 +11632,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         pairwise = true;
         break;
     default:
+    case 0x3: /* FMULX */
         unallocated_encoding(s);
         return;
     }
@@ -11543,9 +11709,6 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
             case 0x2: /* FADD */
                 gen_helper_advsimd_addh(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
-            case 0x3: /* FMULX */
-                gen_helper_advsimd_mulxh(tcg_res, tcg_op1, tcg_op2, fpst);
-                break;
             case 0x4: /* FCMEQ */
                 gen_helper_advsimd_ceq_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
@@ -11597,6 +11760,7 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
                 gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
                 break;
             default:
+            case 0x3: /* FMULX */
                 g_assert_not_reached();
             }
 
@@ -12816,7 +12980,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
     case 0x01: /* FMLA */
     case 0x05: /* FMLS */
     case 0x09: /* FMUL */
-    case 0x19: /* FMULX */
         is_fp = 1;
         break;
     case 0x1d: /* SQRDMLAH */
@@ -12885,6 +13048,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
         /* is_fp, but we pass tcg_env not fp_status.  */
         break;
     default:
+    case 0x19: /* FMULX */
         unallocated_encoding(s);
         return;
     }
@@ -13108,10 +13272,8 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             case 0x09: /* FMUL */
                 gen_helper_vfp_muld(tcg_res, tcg_op, tcg_idx, fpst);
                 break;
-            case 0x19: /* FMULX */
-                gen_helper_vfp_mulxd(tcg_res, tcg_op, tcg_idx, fpst);
-                break;
             default:
+            case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
 
@@ -13224,24 +13386,6 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                     g_assert_not_reached();
                 }
                 break;
-            case 0x19: /* FMULX */
-                switch (size) {
-                case 1:
-                    if (is_scalar) {
-                        gen_helper_advsimd_mulxh(tcg_res, tcg_op,
-                                                 tcg_idx, fpst);
-                    } else {
-                        gen_helper_advsimd_mulx2h(tcg_res, tcg_op,
-                                                  tcg_idx, fpst);
-                    }
-                    break;
-                case 2:
-                    gen_helper_vfp_mulxs(tcg_res, tcg_op, tcg_idx, fpst);
-                    break;
-                default:
-                    g_assert_not_reached();
-                }
-                break;
             case 0x0c: /* SQDMULH */
                 if (size == 1) {
                     gen_helper_neon_qdmulh_s16(tcg_res, tcg_env,
@@ -13283,6 +13427,7 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
                 }
                 break;
             default:
+            case 0x19: /* FMULX */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 1f93510b85..8684581923 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -1248,6 +1248,9 @@ DO_3OP(gvec_rsqrts_nf_h, float16_rsqrts_nf, float16)
 DO_3OP(gvec_rsqrts_nf_s, float32_rsqrts_nf, float32)
 
 #ifdef TARGET_AARCH64
+DO_3OP(gvec_fmulx_h, helper_advsimd_mulxh, float16)
+DO_3OP(gvec_fmulx_s, helper_vfp_mulxs, float32)
+DO_3OP(gvec_fmulx_d, helper_vfp_mulxd, float64)
 
 DO_3OP(gvec_recps_h, helper_recpsf_f16, float16)
 DO_3OP(gvec_recps_s, helper_recpsf_f32, float32)
@@ -1385,7 +1388,7 @@ DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -, H8)
 
 #undef DO_MLA_IDX
 
-#define DO_FMUL_IDX(NAME, ADD, TYPE, H)                                    \
+#define DO_FMUL_IDX(NAME, ADD, MUL, TYPE, H)                               \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
     intptr_t i, j, oprsz = simd_oprsz(desc);                               \
@@ -1395,33 +1398,37 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
     for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
         TYPE mm = m[H(i + idx)];                                           \
         for (j = 0; j < segment; j++) {                                    \
-            d[i + j] = TYPE##_##ADD(d[i + j],                              \
-                                    TYPE##_mul(n[i + j], mm, stat), stat); \
+            d[i + j] = ADD(d[i + j], MUL(n[i + j], mm, stat), stat);       \
         }                                                                  \
     }                                                                      \
     clear_tail(d, oprsz, simd_maxsz(desc));                                \
 }
 
-#define float16_nop(N, M, S) (M)
-#define float32_nop(N, M, S) (M)
-#define float64_nop(N, M, S) (M)
+#define nop(N, M, S) (M)
 
-DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16, H2)
-DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32, H4)
-DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64, H8)
+DO_FMUL_IDX(gvec_fmul_idx_h, nop, float16_mul, float16, H2)
+DO_FMUL_IDX(gvec_fmul_idx_s, nop, float32_mul, float32, H4)
+DO_FMUL_IDX(gvec_fmul_idx_d, nop, float64_mul, float64, H8)
+
+#ifdef TARGET_AARCH64
+
+DO_FMUL_IDX(gvec_fmulx_idx_h, nop, helper_advsimd_mulxh, float16, H2)
+DO_FMUL_IDX(gvec_fmulx_idx_s, nop, helper_vfp_mulxs, float32, H4)
+DO_FMUL_IDX(gvec_fmulx_idx_d, nop, helper_vfp_mulxd, float64, H8)
+
+#endif
+
+#undef nop
 
 /*
  * Non-fused multiply-accumulate operations, for Neon. NB that unlike
  * the fused ops below they assume accumulate both from and into Vd.
  */
-DO_FMUL_IDX(gvec_fmla_nf_idx_h, add, float16, H2)
-DO_FMUL_IDX(gvec_fmla_nf_idx_s, add, float32, H4)
-DO_FMUL_IDX(gvec_fmls_nf_idx_h, sub, float16, H2)
-DO_FMUL_IDX(gvec_fmls_nf_idx_s, sub, float32, H4)
+DO_FMUL_IDX(gvec_fmla_nf_idx_h, float16_add, float16_mul, float16, H2)
+DO_FMUL_IDX(gvec_fmla_nf_idx_s, float32_add, float32_mul, float32, H4)
+DO_FMUL_IDX(gvec_fmls_nf_idx_h, float16_sub, float16_mul, float16, H2)
+DO_FMUL_IDX(gvec_fmls_nf_idx_s, float32_sub, float32_mul, float32, H4)
 
-#undef float16_nop
-#undef float32_nop
-#undef float64_nop
 #undef DO_FMUL_IDX
 
 #define DO_FMLA_IDX(NAME, TYPE, H)                                         \
-- 
2.34.1


