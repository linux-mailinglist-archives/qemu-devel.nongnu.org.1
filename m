Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6DB8D1E2A
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 16:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxV5-0001ki-3j; Tue, 28 May 2024 10:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxV1-0001iG-OT
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:23 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUx-00077U-Ow
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:22 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-35bf77ba8fbso244492f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905298; x=1717510098; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+Q84CTXM19IVDYjWje//MGb/GIXnxXHoqK8YpmK1ovQ=;
 b=U3WDYD7FqaJ+y0VvYpJI9d4o8YMxNMhJMl8SGEfK+LY/bdb8zzTj0bF0jFkVYVIlRK
 ovuEGyk3+5MO42l4aER5uGuU4O050j/IsIEVOSFVWR3EI9U53otsusLHotqWBWqS5KUZ
 QmNIRiLOg53mJtc67/AqFh249FWf3oTHcID5gAWLRZGwwJgS3zGbgkj/5r0hasffRWdW
 7jUIFZOx2FjzDSBaw+PeZZJBamcHsYQi0xUjdg3w4TDMw6BjfbyyCDt48VVyJ9STPIHi
 kZDgef+bNbGk3i5WD7Ea4X2HEUDzBYOmAmcO1wEAstpEsllfDRT8kFgMFWdVDCSX61AW
 uyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905298; x=1717510098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Q84CTXM19IVDYjWje//MGb/GIXnxXHoqK8YpmK1ovQ=;
 b=qZBX5mMzfPCJmpGMt/SVp/hUAdNS2VMFEKd2prp8fH9205xmhg3kCf5NnbLbM5TZ6S
 yrxljlshVeXzcVXh8Uyu2H3FV8n5dUwxCRcAdYmo3fQAh0IuyPGiWtt0dXrgwbTLYC/8
 9Z4oDe2wuizcAc18GVx+Wz79kAxAapZRMosijkNMXQSSn6u7CynrwTHSeWTMimoKAFR/
 K3Hi7t/+R1fAt9SqjbLoZIGEEvfpxjBQsXXBb+r2f+jDuS7uEWtd70H3kLvovilY0OrG
 1dL2yYuzsF7H5iEBHRZ3Kv15OiF48bbZ/dXIzlpkXzpkyzJ4aDbz8bNdd20KOKGwy78+
 uToQ==
X-Gm-Message-State: AOJu0YyinHpmqFfrQqqSRbXiAs99qRovgIyPfcDMfh1YEz133GwlvF/C
 NkvAfoaJhXu8yW31g10OERYoUixyYL3amkh9D+ZdrlfNt7kflMDmFkDbdNk09a5+IX+fBhn1uox
 F
X-Google-Smtp-Source: AGHT+IGzpYHp1XnFNY6wJo+vJ1rzMJHU1El7vp7YJWokRj1dmcPORknGQZyeDvyIpNVhlgYWD5JOIw==
X-Received: by 2002:a5d:5221:0:b0:351:b56e:8bc3 with SMTP id
 ffacd0b85a97d-3552fe02a52mr10742832f8f.53.1716905298228; 
 Tue, 28 May 2024 07:08:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.08.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:08:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/42] target/arm: Convert ADDP to decodetree
Date: Tue, 28 May 2024 15:07:48 +0100
Message-Id: <20240528140753.3620597-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240524232121.284515-32-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h            |   5 ++
 target/arm/tcg/translate.h     |   3 +
 target/arm/tcg/a64.decode      |   6 ++
 target/arm/tcg/gengvec.c       |  12 ++++
 target/arm/tcg/translate-a64.c | 128 ++++++---------------------------
 target/arm/tcg/vec_helper.c    |  30 ++++++++
 6 files changed, 77 insertions(+), 107 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 065460ea80e..d3579a101f4 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1061,6 +1061,11 @@ DEF_HELPER_FLAGS_5(gvec_fminnump_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i
 DEF_HELPER_FLAGS_5(gvec_fminnump_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(gvec_fminnump_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(gvec_addp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_addp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_addp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_addp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "tcg/helper-a64.h"
 #include "tcg/helper-sve.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b05a9eb6685..04771f483b6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -514,6 +514,9 @@ void gen_gvec_saba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
                    uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_addp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz);
+
 /*
  * Forward to the isar_feature_* tests given a DisasContext pointer.
  */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 43557fdccc6..84f5bcc0e08 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -38,6 +38,7 @@
 &qrrrr_e        q rd rn rm ra esz
 
 @rr_h           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=1
+@rr_d           ........ ... ..... ...... rn:5 rd:5     &rr_e esz=3
 @rr_sd          ........ ... ..... ...... rn:5 rd:5     &rr_e esz=%esz_sd
 
 @rrr_h          ........ ... rm:5 ...... rn:5 rd:5      &rrr_e esz=1
@@ -56,6 +57,7 @@
 
 @qrrr_h         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=1
 @qrrr_sd        . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=%esz_sd
+@qrrr_e         . q:1 ...... esz:2 . rm:5 ...... rn:5 rd:5  &qrrr_e
 
 @qrrx_h         . q:1 .. .... .. .. rm:4 .... . . rn:5 rd:5 \
                 &qrrx_e esz=1 idx=%hlm
@@ -758,6 +760,8 @@ FMAXNMP_s       0111 1110 0.11 0000 1100 10 ..... ..... @rr_sd
 FMINNMP_s       0101 1110 1011 0000 1100 10 ..... ..... @rr_h
 FMINNMP_s       0111 1110 1.11 0000 1100 10 ..... ..... @rr_sd
 
+ADDP_s          0101 1110 1111 0001 1011 10 ..... ..... @rr_d
+
 ### Advanced SIMD three same
 
 FADD_v          0.00 1110 010 ..... 00010 1 ..... ..... @qrrr_h
@@ -832,6 +836,8 @@ FMAXNMP_v       0.10 1110 0.1 ..... 11000 1 ..... ..... @qrrr_sd
 FMINNMP_v       0.10 1110 110 ..... 00000 1 ..... ..... @qrrr_h
 FMINNMP_v       0.10 1110 1.1 ..... 11000 1 ..... ..... @qrrr_sd
 
+ADDP_v          0.00 1110 ..1 ..... 10111 1 ..... ..... @qrrr_e
+
 ### Advanced SIMD scalar x indexed element
 
 FMUL_si         0101 1111 00 .. .... 1001 . 0 ..... .....   @rrx_h
diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 7a1856253ff..f010dd5a0e8 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1610,3 +1610,15 @@ void gen_gvec_uaba(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
     };
     tcg_gen_gvec_3(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
+
+void gen_gvec_addp(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
+                   uint32_t rm_ofs, uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_addp_b,
+        gen_helper_gvec_addp_h,
+        gen_helper_gvec_addp_s,
+        gen_helper_gvec_addp_d,
+    };
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 07415bd2855..b8add91112d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5245,6 +5245,8 @@ static gen_helper_gvec_3_ptr * const f_vector_fminnmp[3] = {
 };
 TRANS(FMINNMP_v, do_fp3_vector, a, f_vector_fminnmp)
 
+TRANS(ADDP_v, do_gvec_fn3, a, gen_gvec_addp)
+
 /*
  * Advanced SIMD scalar/vector x indexed element
  */
@@ -5485,6 +5487,20 @@ TRANS(FMINP_s, do_fp3_scalar_pair, a, &f_scalar_fmin)
 TRANS(FMAXNMP_s, do_fp3_scalar_pair, a, &f_scalar_fmaxnm)
 TRANS(FMINNMP_s, do_fp3_scalar_pair, a, &f_scalar_fminnm)
 
+static bool trans_ADDP_s(DisasContext *s, arg_rr_e *a)
+{
+    if (fp_access_check(s)) {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        TCGv_i64 t1 = tcg_temp_new_i64();
+
+        read_vec_element(s, t0, a->rn, 0, MO_64);
+        read_vec_element(s, t1, a->rn, 1, MO_64);
+        tcg_gen_add_i64(t0, t0, t1);
+        write_fp_dreg(s, a->rd, t0);
+    }
+    return true;
+}
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -8412,73 +8428,6 @@ static void disas_simd_mod_imm(DisasContext *s, uint32_t insn)
     }
 }
 
-/* AdvSIMD scalar pairwise
- *  31 30  29 28       24 23  22 21       17 16    12 11 10 9    5 4    0
- * +-----+---+-----------+------+-----------+--------+-----+------+------+
- * | 0 1 | U | 1 1 1 1 0 | size | 1 1 0 0 0 | opcode | 1 0 |  Rn  |  Rd  |
- * +-----+---+-----------+------+-----------+--------+-----+------+------+
- */
-static void disas_simd_scalar_pairwise(DisasContext *s, uint32_t insn)
-{
-    int u = extract32(insn, 29, 1);
-    int size = extract32(insn, 22, 2);
-    int opcode = extract32(insn, 12, 5);
-    int rn = extract32(insn, 5, 5);
-    int rd = extract32(insn, 0, 5);
-
-    /* For some ops (the FP ones), size[1] is part of the encoding.
-     * For ADDP strictly it is not but size[1] is always 1 for valid
-     * encodings.
-     */
-    opcode |= (extract32(size, 1, 1) << 5);
-
-    switch (opcode) {
-    case 0x3b: /* ADDP */
-        if (u || size != 3) {
-            unallocated_encoding(s);
-            return;
-        }
-        if (!fp_access_check(s)) {
-            return;
-        }
-        break;
-    default:
-    case 0xc: /* FMAXNMP */
-    case 0xd: /* FADDP */
-    case 0xf: /* FMAXP */
-    case 0x2c: /* FMINNMP */
-    case 0x2f: /* FMINP */
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (size == MO_64) {
-        TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-        TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-        TCGv_i64 tcg_res = tcg_temp_new_i64();
-
-        read_vec_element(s, tcg_op1, rn, 0, MO_64);
-        read_vec_element(s, tcg_op2, rn, 1, MO_64);
-
-        switch (opcode) {
-        case 0x3b: /* ADDP */
-            tcg_gen_add_i64(tcg_res, tcg_op1, tcg_op2);
-            break;
-        default:
-        case 0xc: /* FMAXNMP */
-        case 0xd: /* FADDP */
-        case 0xf: /* FMAXP */
-        case 0x2c: /* FMINNMP */
-        case 0x2f: /* FMINP */
-            g_assert_not_reached();
-        }
-
-        write_fp_dreg(s, rd, tcg_res);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 /*
  * Common SSHR[RA]/USHR[RA] - Shift right (optional rounding/accumulate)
  *
@@ -10965,34 +10914,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
      * adjacent elements being operated on to produce an element in the result.
      */
     if (size == 3) {
-        TCGv_i64 tcg_res[2];
-
-        for (pass = 0; pass < 2; pass++) {
-            TCGv_i64 tcg_op1 = tcg_temp_new_i64();
-            TCGv_i64 tcg_op2 = tcg_temp_new_i64();
-            int passreg = (pass == 0) ? rn : rm;
-
-            read_vec_element(s, tcg_op1, passreg, 0, MO_64);
-            read_vec_element(s, tcg_op2, passreg, 1, MO_64);
-            tcg_res[pass] = tcg_temp_new_i64();
-
-            switch (opcode) {
-            case 0x17: /* ADDP */
-                tcg_gen_add_i64(tcg_res[pass], tcg_op1, tcg_op2);
-                break;
-            default:
-            case 0x58: /* FMAXNMP */
-            case 0x5a: /* FADDP */
-            case 0x5e: /* FMAXP */
-            case 0x78: /* FMINNMP */
-            case 0x7e: /* FMINP */
-                g_assert_not_reached();
-            }
-        }
-
-        for (pass = 0; pass < 2; pass++) {
-            write_vec_element(s, tcg_res[pass], rd, pass, MO_64);
-        }
+        g_assert_not_reached();
     } else {
         int maxpass = is_q ? 4 : 2;
         TCGv_i32 tcg_res[4];
@@ -11009,16 +10931,6 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
             tcg_res[pass] = tcg_temp_new_i32();
 
             switch (opcode) {
-            case 0x17: /* ADDP */
-            {
-                static NeonGenTwoOpFn * const fns[3] = {
-                    gen_helper_neon_padd_u8,
-                    gen_helper_neon_padd_u16,
-                    tcg_gen_add_i32,
-                };
-                genfn = fns[size];
-                break;
-            }
             case 0x14: /* SMAXP, UMAXP */
             {
                 static NeonGenTwoOpFn * const fns[3][2] = {
@@ -11040,6 +10952,7 @@ static void handle_simd_3same_pair(DisasContext *s, int is_q, int u, int opcode,
                 break;
             }
             default:
+            case 0x17: /* ADDP */
             case 0x58: /* FMAXNMP */
             case 0x5a: /* FADDP */
             case 0x5e: /* FMAXP */
@@ -11401,7 +11314,6 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     case 0x3: /* logic ops */
         disas_simd_3same_logic(s, insn);
         break;
-    case 0x17: /* ADDP */
     case 0x14: /* SMAXP, UMAXP */
     case 0x15: /* SMINP, UMINP */
     {
@@ -11433,6 +11345,9 @@ static void disas_simd_three_reg_same(DisasContext *s, uint32_t insn)
     default:
         disas_simd_3same_int(s, insn);
         break;
+    case 0x17: /* ADDP */
+        unallocated_encoding(s);
+        break;
     }
 }
 
@@ -13195,7 +13110,6 @@ static const AArch64DecodeTable data_proc_simd[] = {
     { 0x5e008400, 0xdf208400, disas_simd_scalar_three_reg_same_extra },
     { 0x5e200000, 0xdf200c00, disas_simd_scalar_three_reg_diff },
     { 0x5e200800, 0xdf3e0c00, disas_simd_scalar_two_reg_misc },
-    { 0x5e300800, 0xdf3e0c00, disas_simd_scalar_pairwise },
     { 0x5f000000, 0xdf000400, disas_simd_indexed }, /* scalar indexed */
     { 0x5f000400, 0xdf800400, disas_simd_scalar_shift_imm },
     { 0x0e780800, 0x8f7e0c00, disas_simd_two_reg_misc_fp16 },
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 26a9ca9c14a..5069899415c 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2231,6 +2231,36 @@ DO_3OP_PAIR(gvec_fminnump_h, float16_minnum, float16, H2)
 DO_3OP_PAIR(gvec_fminnump_s, float32_minnum, float32, H4)
 DO_3OP_PAIR(gvec_fminnump_d, float64_minnum, float64, )
 
+#undef DO_3OP_PAIR
+
+#define DO_3OP_PAIR(NAME, FUNC, TYPE, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)  \
+{                                                               \
+    ARMVectorReg scratch;                                       \
+    intptr_t oprsz = simd_oprsz(desc);                          \
+    intptr_t half = oprsz / sizeof(TYPE) / 2;                   \
+    TYPE *d = vd, *n = vn, *m = vm;                             \
+    if (unlikely(d == m)) {                                     \
+        m = memcpy(&scratch, m, oprsz);                         \
+    }                                                           \
+    for (intptr_t i = 0; i < half; ++i) {                       \
+        d[H(i)] = FUNC(n[H(i * 2)], n[H(i * 2 + 1)]);           \
+    }                                                           \
+    for (intptr_t i = 0; i < half; ++i) {                       \
+        d[H(i + half)] = FUNC(m[H(i * 2)], m[H(i * 2 + 1)]);    \
+    }                                                           \
+    clear_tail(d, oprsz, simd_maxsz(desc));                     \
+}
+
+#define ADD(A, B) (A + B)
+DO_3OP_PAIR(gvec_addp_b, ADD, uint8_t, H1)
+DO_3OP_PAIR(gvec_addp_h, ADD, uint16_t, H2)
+DO_3OP_PAIR(gvec_addp_s, ADD, uint32_t, H4)
+DO_3OP_PAIR(gvec_addp_d, ADD, uint64_t, )
+#undef  ADD
+
+#undef DO_3OP_PAIR
+
 #define DO_VCVT_FIXED(NAME, FUNC, TYPE)                                 \
     void HELPER(NAME)(void *vd, void *vn, void *stat, uint32_t desc)    \
     {                                                                   \
-- 
2.34.1


