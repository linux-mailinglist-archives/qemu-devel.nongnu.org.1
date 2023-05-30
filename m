Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D460716D5A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:18:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o8-0006yQ-E2; Tue, 30 May 2023 15:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nz-000691-VY
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:52 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nx-0004gQ-0Y
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:51 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d24136663so3322609b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474088; x=1688066088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L9J2NnnSlzPHrP6ymAfgvQWzttJWy4QYx3ryvCW/W4k=;
 b=RG0hmTyJW8RpWHxvbqciVrbvXPlI+E5Ch+JjFkn+Xc585Td7DF4nMrSWxt6yG9Unkz
 5eu7wSYr7gV/Hfhtki4psRywqr/unXqQfQiOAPKbLMtPeABGebH5Y8UJUaVgOn/OPjL7
 pzZJNMx3nxmLRFyfRIHuAR08LPpe/oKqS4WPMpgrRyU6fslHFN/rr20C4MblsvkQ4jTR
 ++Y7INs0ykLEu8smzsbI9FxivAXlc4lGYwrWCjlaYGJEJZRyDh3cP8ObMjyPnSoVsqMt
 11/G6BRz14zfN9sChryVcqn5RH0j17pE+x/9ACykUrMYY+wMnPWafhLab94tV7JWBacN
 uLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474088; x=1688066088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L9J2NnnSlzPHrP6ymAfgvQWzttJWy4QYx3ryvCW/W4k=;
 b=TP+3n8/4bYNtgTjuxNX65J+g0IBgvXHHM2E41J/nHQfcbekNu70mn2uP2hn7FvdEHS
 vfC4ErfABceU/Ks+ZJS7KjAuAC31BbSqGI8w7obH8ruKgL+CiyJsaDRAboC3hish08Kd
 IqPOdVL1hHDahCq4sFFtPnCbvDtS8o9UooBbF80jvWrXS8rHzxAdd4AUM5NcoGnqnvVx
 LCFciFDQ8QX3lplwoFicOz0BW+mTZynPH/5tIfcXRlswuIx3UxrqR7bu58rhvQRKjOqC
 0IGzym+sVEi7KEkzXNJIONX2x/JiIT2yHymGeLIlEYfTQ+Ce4RgFAra2k3bYWZLDZry3
 OJQQ==
X-Gm-Message-State: AC+VfDyIt4lxWoO9Gr09NSRzqNBK/iG/VOgpNE1cCnboi9LHqtgIZpIQ
 DyKkN9ECx3HvMA1luM48IPCteozD3098sHQS90U=
X-Google-Smtp-Source: ACHHUZ7GpwyXcV51rpwgHC4InYLzX0/RjPjg6r8lfYABv7nrNSHvNmSQbg4IV2D7jjS/4iFW9Oakbw==
X-Received: by 2002:a05:6a20:7fa7:b0:10f:8499:1b75 with SMTP id
 d39-20020a056a207fa700b0010f84991b75mr3889068pzj.9.1685474087778; 
 Tue, 30 May 2023 12:14:47 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 10/20] target/arm: Hoist finalize_memop out of do_gpr_{ld,
 st}
Date: Tue, 30 May 2023 12:14:28 -0700
Message-Id: <20230530191438.411344-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

We are going to need the complete memop beforehand,
so let's not compute it twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 61 +++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 40c6adc9cc..24e255aa34 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -848,7 +848,6 @@ static void do_gpr_st_memidx(DisasContext *s, TCGv_i64 source,
                              unsigned int iss_srt,
                              bool iss_sf, bool iss_ar)
 {
-    memop = finalize_memop(s, memop);
     tcg_gen_qemu_st_i64(source, tcg_addr, memidx, memop);
 
     if (iss_valid) {
@@ -883,7 +882,6 @@ static void do_gpr_ld_memidx(DisasContext *s, TCGv_i64 dest, TCGv_i64 tcg_addr,
                              bool iss_valid, unsigned int iss_srt,
                              bool iss_sf, bool iss_ar)
 {
-    memop = finalize_memop(s, memop);
     tcg_gen_qemu_ld_i64(dest, tcg_addr, memidx, memop);
 
     if (extend && (memop & MO_SIGN)) {
@@ -2637,6 +2635,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
     int size = extract32(insn, 30, 2);
     TCGv_i64 clean_addr;
+    MemOp memop;
 
     switch (o2_L_o1_o0) {
     case 0x0: /* STXR */
@@ -2673,10 +2672,11 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+        /* TODO: ARMv8.4-LSE SCTLR.nAA */
+        memop = finalize_memop(s, size | MO_ALIGN);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     true, rn != 31, size);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        do_gpr_st(s, cpu_reg(s, rt), clean_addr, size | MO_ALIGN, true, rt,
+        do_gpr_st(s, cpu_reg(s, rt), clean_addr, memop, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
 
@@ -2691,10 +2691,11 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
+        /* TODO: ARMv8.4-LSE SCTLR.nAA */
+        memop = finalize_memop(s, size | MO_ALIGN);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     false, rn != 31, size);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size | MO_ALIGN, false, true,
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, memop, false, true,
                   rt, disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         return;
@@ -2802,9 +2803,9 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
     } else {
         /* Only unsigned 32bit loads target 32bit registers.  */
         bool iss_sf = opc != 0;
+        MemOp memop = finalize_memop(s, size + is_signed * MO_SIGN);
 
-        do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
-                  false, true, rt, iss_sf, false);
+        do_gpr_ld(s, tcg_rt, clean_addr, memop, false, true, rt, iss_sf, false);
     }
 }
 
@@ -3058,7 +3059,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     bool post_index;
     bool writeback;
     int memidx;
-
+    MemOp memop;
     TCGv_i64 clean_addr, dirty_addr;
 
     if (is_vector) {
@@ -3085,7 +3086,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3119,6 +3120,8 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     }
 
     memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
+
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
                                        size, is_unpriv, memidx);
@@ -3134,10 +3137,10 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
 
         if (is_store) {
-            do_gpr_st_memidx(s, tcg_rt, clean_addr, size, memidx,
+            do_gpr_st_memidx(s, tcg_rt, clean_addr, memop, memidx,
                              iss_valid, rt, iss_sf, false);
         } else {
-            do_gpr_ld_memidx(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
+            do_gpr_ld_memidx(s, tcg_rt, clean_addr, memop,
                              is_extended, memidx,
                              iss_valid, rt, iss_sf, false);
         }
@@ -3186,8 +3189,8 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     bool is_signed = false;
     bool is_store = false;
     bool is_extended = false;
-
     TCGv_i64 tcg_rm, clean_addr, dirty_addr;
+    MemOp memop;
 
     if (extract32(opt, 1, 1) == 0) {
         unallocated_encoding(s);
@@ -3214,7 +3217,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3227,6 +3230,8 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
 
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
+
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, size);
 
     if (is_vector) {
@@ -3238,11 +3243,12 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     } else {
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
+
         if (is_store) {
-            do_gpr_st(s, tcg_rt, clean_addr, size,
+            do_gpr_st(s, tcg_rt, clean_addr, memop,
                       true, rt, iss_sf, false);
         } else {
-            do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
+            do_gpr_ld(s, tcg_rt, clean_addr, memop,
                       is_extended, true, rt, iss_sf, false);
         }
     }
@@ -3274,12 +3280,11 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     int rn = extract32(insn, 5, 5);
     unsigned int imm12 = extract32(insn, 10, 12);
     unsigned int offset;
-
     TCGv_i64 clean_addr, dirty_addr;
-
     bool is_store;
     bool is_signed = false;
     bool is_extended = false;
+    MemOp memop;
 
     if (is_vector) {
         size |= (opc & 2) << 1;
@@ -3301,7 +3306,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3311,6 +3316,8 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     offset = imm12 << size;
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, size);
 
     if (is_vector) {
@@ -3323,10 +3330,9 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
         TCGv_i64 tcg_rt = cpu_reg(s, rt);
         bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
         if (is_store) {
-            do_gpr_st(s, tcg_rt, clean_addr, size,
-                      true, rt, iss_sf, false);
+            do_gpr_st(s, tcg_rt, clean_addr, memop, true, rt, iss_sf, false);
         } else {
-            do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
+            do_gpr_ld(s, tcg_rt, clean_addr, memop,
                       is_extended, true, rt, iss_sf, false);
         }
     }
@@ -3356,7 +3362,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, tcg_rt, clean_addr;
     AtomicThreeOpFn *fn = NULL;
-    MemOp mop = s->be_data | size | MO_ALIGN;
+    MemOp mop = finalize_memop(s, size | MO_ALIGN);
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
@@ -3417,7 +3423,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
          * full load-acquire (we only need "load-acquire processor consistent"),
          * but we choose to implement them as full LDAQ.
          */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false,
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, mop, false,
                   true, rt, disas_ldst_compute_iss_sf(size, false, 0), true);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         return;
@@ -3463,6 +3469,7 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     bool use_key_a = !extract32(insn, 23, 1);
     int offset;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    MemOp memop;
 
     if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
         unallocated_encoding(s);
@@ -3489,12 +3496,14 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     offset = sextract32(offset << size, 0, 10 + size);
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
 
+    memop = finalize_memop(s, size);
+
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
     clean_addr = gen_mte_check1(s, dirty_addr, false,
                                 is_wback || rn != 31, size);
 
     tcg_rt = cpu_reg(s, rt);
-    do_gpr_ld(s, tcg_rt, clean_addr, size,
+    do_gpr_ld(s, tcg_rt, clean_addr, memop,
               /* extend */ false, /* iss_valid */ !is_wback,
               /* iss_srt */ rt, /* iss_sf */ true, /* iss_ar */ false);
 
@@ -3536,7 +3545,7 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
     }
 
     /* TODO: ARMv8.4-LSE SCTLR.nAA */
-    mop = size | MO_ALIGN;
+    mop = finalize_memop(s, size | MO_ALIGN);
 
     switch (opc) {
     case 0: /* STLURB */
-- 
2.34.1


