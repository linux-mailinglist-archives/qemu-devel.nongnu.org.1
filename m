Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A638723E65
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TJ0-0007rW-Kv; Tue, 06 Jun 2023 05:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIq-0007jm-9W
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIm-0004p7-FC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so4631096f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044911; x=1688636911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ub+LXaoDfm6/NiLVcWnRCgeXoPDahUp5J7Et7A7qcTk=;
 b=ylBtcSP0+tGYw9TSHgvxoLM2lPz3+kCF4Kk0v3EyB0LRCxJ9KkPWDSV5UsXb84efZ1
 i8dW/bf5RB5ZG5gIn0D+JRj1zK6kF8Ar0V1SDHAsdPnb3p2Hm6GLYDaZUw+Z51wR0FTy
 lJiCja8u37x7RA7NVN+DBQ+VxrKrvA/1RauXlgo4DRwVW5/pYpnhj/s5K9lSUZKLIMEU
 QnkRH/xlHnItrlcVtYqIPdIj/gqVxGU7voR1b6hm7yxMyMgaJzVWmT3BIyg0sQcZFL43
 4WPWe14e/TKAcBA26xFP8rzxSOVNBkgpOjCMQJFvODQrD6oIfmgt2iyhk/0v/WV5RvHR
 Qsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044911; x=1688636911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ub+LXaoDfm6/NiLVcWnRCgeXoPDahUp5J7Et7A7qcTk=;
 b=A2rWNez5k3j6XEhMImQFheaeQ1/mcgv5oS41ZwMxdtKvRKpJbwCG6cudiRaxz5LsjG
 26xUWZWtTkVcAi9CIYXZkrnaL/JbWmILbMDELdWJSn9J+kmO4D+k8WKRb8rT7/fVFtXD
 CULae1oyQx8W8MwGhYzMUbDvbh7Iyw19jaq4WF2n4eYp+/Dyi+uNkJeq7Qwag9uulOTU
 PWgkLYhfsC6ZxnPEYfMIcwk+KroX9So1IbJOjeIliG8IgImLMsSl2WOC6s1OkFdo0dt5
 EM5pv0ynl6Thj2eMrprxtRPktjoBWPMoe3GysWG/JNAjBOuMdpRhmeSDoYX+kHrtMjLM
 Sf/A==
X-Gm-Message-State: AC+VfDzCKwYmPP5aMRAhBSB7I6Wmntp68hyIDOgNTucoQiO/X2W10RVG
 V4GWljA3iLs0Tqt80wVGK1DgBp1bF2KO+1F9bVg=
X-Google-Smtp-Source: ACHHUZ4dNqSYsdtdRDJ/xL8DJpjMMxlWIia93PJKM2+6KTn5ljx12xJ4kb4Nm3PbQ0ELm21aNPjJww==
X-Received: by 2002:adf:f78a:0:b0:30a:e7c0:de86 with SMTP id
 q10-20020adff78a000000b0030ae7c0de86mr1472688wrp.56.1686044911062; 
 Tue, 06 Jun 2023 02:48:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/42] target/arm: Pass memop to gen_mte_check1*
Date: Tue,  6 Jun 2023 10:48:03 +0100
Message-Id: <20230606094814.3581397-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

Pass the completed memop to gen_mte_check1_mmuidx.
For the moment, do nothing more than extract the size.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-13-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.h |  2 +-
 target/arm/tcg/translate-a64.c | 82 ++++++++++++++++++----------------
 target/arm/tcg/translate-sve.c |  7 +--
 3 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 0576c4ea120..cecf2bab8f6 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -49,7 +49,7 @@ static inline bool sme_smza_enabled_check(DisasContext *s)
 
 TCGv_i64 clean_data_tbi(DisasContext *s, TCGv_i64 addr);
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
-                        bool tag_checked, int log2_size);
+                        bool tag_checked, MemOp memop);
 TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
                         bool tag_checked, int size);
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 3e93f6e848e..85d896e9752 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -253,7 +253,7 @@ static void gen_probe_access(DisasContext *s, TCGv_i64 ptr,
  */
 static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
                                       bool is_write, bool tag_checked,
-                                      int log2_size, bool is_unpriv,
+                                      MemOp memop, bool is_unpriv,
                                       int core_idx)
 {
     if (tag_checked && s->mte_active[is_unpriv]) {
@@ -264,7 +264,7 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (1 << log2_size) - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, memop_size(memop) - 1);
 
         ret = tcg_temp_new_i64();
         gen_helper_mte_check(ret, cpu_env, tcg_constant_i32(desc), addr);
@@ -275,9 +275,9 @@ static TCGv_i64 gen_mte_check1_mmuidx(DisasContext *s, TCGv_i64 addr,
 }
 
 TCGv_i64 gen_mte_check1(DisasContext *s, TCGv_i64 addr, bool is_write,
-                        bool tag_checked, int log2_size)
+                        bool tag_checked, MemOp memop)
 {
-    return gen_mte_check1_mmuidx(s, addr, is_write, tag_checked, log2_size,
+    return gen_mte_check1_mmuidx(s, addr, is_write, tag_checked, memop,
                                  false, get_mem_index(s));
 }
 
@@ -2369,19 +2369,31 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
                                int size, bool is_pair)
 {
     int idx = get_mem_index(s);
-    MemOp memop;
     TCGv_i64 dirty_addr, clean_addr;
+    MemOp memop;
+
+    /*
+     * For pairs:
+     * if size == 2, the operation is single-copy atomic for the doubleword.
+     * if size == 3, the operation is single-copy atomic for *each* doubleword,
+     * not the entire quadword, however it must be quadword aligned.
+     */
+    memop = size + is_pair;
+    if (memop == MO_128) {
+        memop = finalize_memop_atom(s, MO_128 | MO_ALIGN,
+                                    MO_ATOM_IFALIGN_PAIR);
+    } else {
+        memop = finalize_memop(s, memop | MO_ALIGN);
+    }
 
     s->is_ldex = true;
     dirty_addr = cpu_reg_sp(s, rn);
-    clean_addr = gen_mte_check1(s, dirty_addr, false, rn != 31, size);
+    clean_addr = gen_mte_check1(s, dirty_addr, false, rn != 31, memop);
 
     g_assert(size <= 3);
     if (is_pair) {
         g_assert(size >= 2);
         if (size == 2) {
-            /* The pair must be single-copy atomic for the doubleword.  */
-            memop = finalize_memop(s, MO_64 | MO_ALIGN);
             tcg_gen_qemu_ld_i64(cpu_exclusive_val, clean_addr, idx, memop);
             if (s->be_data == MO_LE) {
                 tcg_gen_extract_i64(cpu_reg(s, rt), cpu_exclusive_val, 0, 32);
@@ -2391,16 +2403,8 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
                 tcg_gen_extract_i64(cpu_reg(s, rt2), cpu_exclusive_val, 0, 32);
             }
         } else {
-            /*
-             * The pair must be single-copy atomic for *each* doubleword, not
-             * the entire quadword, however it must be quadword aligned.
-             * Expose the complete load to tcg, for ease of tlb lookup,
-             * but indicate that only 8-byte atomicity is required.
-             */
             TCGv_i128 t16 = tcg_temp_new_i128();
 
-            memop = finalize_memop_atom(s, MO_128 | MO_ALIGN_16,
-                                        MO_ATOM_IFALIGN_PAIR);
             tcg_gen_qemu_ld_i128(t16, clean_addr, idx, memop);
 
             if (s->be_data == MO_LE) {
@@ -2414,7 +2418,6 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
             tcg_gen_mov_i64(cpu_reg(s, rt2), cpu_exclusive_high);
         }
     } else {
-        memop = finalize_memop(s, size | MO_ALIGN);
         tcg_gen_qemu_ld_i64(cpu_exclusive_val, clean_addr, idx, memop);
         tcg_gen_mov_i64(cpu_reg(s, rt), cpu_exclusive_val);
     }
@@ -2439,9 +2442,13 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
     TCGLabel *fail_label = gen_new_label();
     TCGLabel *done_label = gen_new_label();
     TCGv_i64 tmp, dirty_addr, clean_addr;
+    MemOp memop;
+
+    memop = (size + is_pair) | MO_ALIGN;
+    memop = finalize_memop(s, memop);
 
     dirty_addr = cpu_reg_sp(s, rn);
-    clean_addr = gen_mte_check1(s, dirty_addr, true, rn != 31, size);
+    clean_addr = gen_mte_check1(s, dirty_addr, true, rn != 31, memop);
 
     tcg_gen_brcond_i64(TCG_COND_NE, clean_addr, cpu_exclusive_addr, fail_label);
 
@@ -2455,8 +2462,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
             }
             tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr,
                                        cpu_exclusive_val, tmp,
-                                       get_mem_index(s),
-                                       MO_64 | MO_ALIGN | s->be_data);
+                                       get_mem_index(s), memop);
             tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
         } else {
             TCGv_i128 t16 = tcg_temp_new_i128();
@@ -2474,8 +2480,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
             }
 
             tcg_gen_atomic_cmpxchg_i128(t16, cpu_exclusive_addr, c16, t16,
-                                        get_mem_index(s),
-                                        MO_128 | MO_ALIGN | s->be_data);
+                                        get_mem_index(s), memop);
 
             a = tcg_temp_new_i64();
             b = tcg_temp_new_i64();
@@ -2493,8 +2498,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
         }
     } else {
         tcg_gen_atomic_cmpxchg_i64(tmp, cpu_exclusive_addr, cpu_exclusive_val,
-                                   cpu_reg(s, rt), get_mem_index(s),
-                                   size | MO_ALIGN | s->be_data);
+                                   cpu_reg(s, rt), get_mem_index(s), memop);
         tcg_gen_setcond_i64(TCG_COND_NE, tmp, tmp, cpu_exclusive_val);
     }
     tcg_gen_mov_i64(cpu_reg(s, rd), tmp);
@@ -2513,13 +2517,15 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     TCGv_i64 tcg_rt = cpu_reg(s, rt);
     int memidx = get_mem_index(s);
     TCGv_i64 clean_addr;
+    MemOp memop;
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, size);
-    tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt, memidx,
-                               size | MO_ALIGN | s->be_data);
+    memop = finalize_memop(s, size | MO_ALIGN);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
+    tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt,
+                               memidx, memop);
 }
 
 static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
@@ -2531,13 +2537,15 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     TCGv_i64 t2 = cpu_reg(s, rt + 1);
     TCGv_i64 clean_addr;
     int memidx = get_mem_index(s);
+    MemOp memop;
 
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
 
     /* This is a single atomic access, despite the "pair". */
-    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, size + 1);
+    memop = finalize_memop(s, (size + 1) | MO_ALIGN);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
 
     if (size == 2) {
         TCGv_i64 cmp = tcg_temp_new_i64();
@@ -2551,8 +2559,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
             tcg_gen_concat32_i64(cmp, s2, s1);
         }
 
-        tcg_gen_atomic_cmpxchg_i64(cmp, clean_addr, cmp, val, memidx,
-                                   MO_64 | MO_ALIGN | s->be_data);
+        tcg_gen_atomic_cmpxchg_i64(cmp, clean_addr, cmp, val, memidx, memop);
 
         if (s->be_data == MO_LE) {
             tcg_gen_extr32_i64(s1, s2, cmp);
@@ -2571,8 +2578,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
             tcg_gen_concat_i64_i128(cmp, s2, s1);
         }
 
-        tcg_gen_atomic_cmpxchg_i128(cmp, clean_addr, cmp, val, memidx,
-                                    MO_128 | MO_ALIGN | s->be_data);
+        tcg_gen_atomic_cmpxchg_i128(cmp, clean_addr, cmp, val, memidx, memop);
 
         if (s->be_data == MO_LE) {
             tcg_gen_extr_i128_i64(s1, s2, cmp);
@@ -2661,7 +2667,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         /* TODO: ARMv8.4-LSE SCTLR.nAA */
         memop = finalize_memop(s, size | MO_ALIGN);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, size);
+                                    true, rn != 31, memop);
         do_gpr_st(s, cpu_reg(s, rt), clean_addr, memop, true, rt,
                   disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         return;
@@ -2680,7 +2686,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         /* TODO: ARMv8.4-LSE SCTLR.nAA */
         memop = finalize_memop(s, size | MO_ALIGN);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    false, rn != 31, size);
+                                    false, rn != 31, memop);
         do_gpr_ld(s, cpu_reg(s, rt), clean_addr, memop, false, true,
                   rt, disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -3223,7 +3229,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
 
     memop = finalize_memop(s, size + is_signed * MO_SIGN);
-    clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, size);
+    clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, memop);
 
     if (is_vector) {
         if (is_store) {
@@ -3309,7 +3315,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
 
     memop = finalize_memop(s, size + is_signed * MO_SIGN);
-    clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, size);
+    clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, memop);
 
     if (is_vector) {
         if (is_store) {
@@ -3404,7 +3410,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, size);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, mop);
 
     if (o3_opc == 014) {
         /*
@@ -3491,7 +3497,7 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
 
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
     clean_addr = gen_mte_check1(s, dirty_addr, false,
-                                is_wback || rn != 31, size);
+                                is_wback || rn != 31, memop);
 
     tcg_rt = cpu_reg(s, rt);
     do_gpr_ld(s, tcg_rt, clean_addr, memop,
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 57051a4729a..671d2efa85d 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5009,6 +5009,7 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     unsigned msz = dtype_msz(a->dtype);
     TCGLabel *over;
     TCGv_i64 temp, clean_addr;
+    MemOp memop;
 
     if (!dc_isar_feature(aa64_sve, s)) {
         return false;
@@ -5038,10 +5039,10 @@ static bool trans_LD1R_zpri(DisasContext *s, arg_rpri_load *a)
     /* Load the data.  */
     temp = tcg_temp_new_i64();
     tcg_gen_addi_i64(temp, cpu_reg_sp(s, a->rn), a->imm << msz);
-    clean_addr = gen_mte_check1(s, temp, false, true, msz);
 
-    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s),
-                        finalize_memop(s, dtype_mop[a->dtype]));
+    memop = finalize_memop(s, dtype_mop[a->dtype]);
+    clean_addr = gen_mte_check1(s, temp, false, true, memop);
+    tcg_gen_qemu_ld_i64(temp, clean_addr, get_mem_index(s), memop);
 
     /* Broadcast to *all* elements.  */
     tcg_gen_gvec_dup_i64(esz, vec_full_reg_offset(s, a->rd),
-- 
2.34.1


