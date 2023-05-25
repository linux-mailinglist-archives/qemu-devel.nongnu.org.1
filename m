Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B218711A94
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLl-00060h-5w; Thu, 25 May 2023 19:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLc-0005uk-QF
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:24 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLW-0005oy-AD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:20 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-52c30fa5271so67920a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057172; x=1687649172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3uZjZZOr3HW4FRprJ8Kd+x2DjMsbg7oiFeCX+0gI5c=;
 b=YevBkewTMsMqFh9i/gleEcvBZ1ItXyDRSiq4CyxHQYK195Uvh14PcLvGALIf75F5FD
 SUknx9WIQm2u/gRbG9n67NFLaX4c4qB8rpHdmWWYXVJ7tzkoTCDcs7SPl18OivpPkEHo
 U8K2nfOsL8b2O482xGExtYBfhmrYpbIX6nCm2XvH7rduWWb0UqlsY01HaRco5Ieau339
 eZdTnLIE5IOYwmW14k9C2+lge8J9bChScUFu0Y8OlvICLgCtESJBui9P/jQqLRupdQ7a
 tSSGtqI/HDqgJRmQp8eqaoJ7hpwzNJwHfyke9rc1ovMm4QUm6a5P+9a3dNlLTNNtD9lb
 b2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057172; x=1687649172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3uZjZZOr3HW4FRprJ8Kd+x2DjMsbg7oiFeCX+0gI5c=;
 b=aZGyo3Hwwj2TGDlNfcAiV4xoima/3en+Jv5lEMe8WunTDPIGoSWkF6cgLyTeJfhJsR
 O2Cw+IZ4mh8cf5sUFHPZH/H8Q1Gjwa7rQiEBS+Eb7jXVwEQ3slwtvrGZIeDkcR+SHRm3
 VcjGyOOWXGPah7Jpp9c5p/FLauYA20TYHHkTnYr/LRPr/HomQzcFBBjuUmhkqsCt/cL4
 fsEV/o7cVIvQLgw0AFDhOOi2kSRclqGlrYMUvQ5frEee4yzdUF800U2/xuSrnvbus62b
 e074pGG01VtAEW8rG9T/rcRukGpMCfGSS/Vi0czDHJFsH25sqfuNpEfTQwtyFKvHYll7
 hqOA==
X-Gm-Message-State: AC+VfDwu+a/6m//nVKdmUIuJLVfTIPbWg6uvTJZ9dN2ojhElLU1G8xJJ
 djgZDpn6csilzb0NoAp+G9+OTQhrGLT3jcYbLsI=
X-Google-Smtp-Source: ACHHUZ6eYws78U9Vb5Vo1Ro39TK2ptwNLH4IocYuGXtV8g24JmdzgTnXDro0NanvImZ9WfOgq1iZtg==
X-Received: by 2002:a17:903:22cf:b0:1ac:a28e:4b1d with SMTP id
 y15-20020a17090322cf00b001aca28e4b1dmr524866plg.34.1685057172617; 
 Thu, 25 May 2023 16:26:12 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 16/20] target/arm: Relax ordered/atomic alignment checks
 for LSE2
Date: Thu, 25 May 2023 16:25:54 -0700
Message-Id: <20230525232558.1758967-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

FEAT_LSE2 only requires that atomic operations not cross a
16-byte boundary.  Ordered operations may be completely
unaligned if SCTLR.nAA is set.

Because this alignment check is so special, do it by hand.
Make sure not to keep TCG temps live across the branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   3 +
 target/arm/tcg/helper-a64.c    |   7 ++
 target/arm/tcg/translate-a64.c | 120 ++++++++++++++++++++++++++-------
 3 files changed, 104 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index ff56807247..3d5957c11f 100644
--- a/target/arm/tcg/helper-a64.h
+++ b/target/arm/tcg/helper-a64.h
@@ -110,3 +110,6 @@ DEF_HELPER_FLAGS_2(st2g_stub, TCG_CALL_NO_WG, void, env, i64)
 DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm_tags, TCG_CALL_NO_WG, void, env, i64, i64)
+
+DEF_HELPER_FLAGS_4(unaligned_access, TCG_CALL_NO_WG,
+                   noreturn, env, i64, i32, i32)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index c3edf163be..1c9370f07b 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -952,3 +952,10 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
 
     memset(mem, 0, blocklen);
 }
+
+void HELPER(unaligned_access)(CPUARMState *env, uint64_t addr,
+                              uint32_t access_type, uint32_t mmu_idx)
+{
+    arm_cpu_do_unaligned_access(env_cpu(env), addr, access_type,
+                                mmu_idx, GETPC());
+}
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bbcdf31728..49cb7a7dd5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -317,6 +317,89 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
     return clean_data_tbi(s, addr);
 }
 
+/*
+ * Generate the special alignment check that applies to AccType_ATOMIC
+ * and AccType_ORDERED insns under FEAT_LSE2: the access need not be
+ * naturally aligned, but it must not cross a 16-byte boundary.
+ * See AArch64.CheckAlignment().
+ */
+static void check_lse2_align(DisasContext *s, int rn, int imm,
+                             bool is_write, MemOp mop)
+{
+    TCGv_i32 tmp;
+    TCGv_i64 addr;
+    TCGLabel *over_label;
+    MMUAccessType type;
+    int mmu_idx;
+
+    tmp = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(tmp, cpu_reg_sp(s, rn));
+    tcg_gen_addi_i32(tmp, tmp, imm & 15);
+    tcg_gen_andi_i32(tmp, tmp, 15);
+    tcg_gen_addi_i32(tmp, tmp, memop_size(mop));
+
+    over_label = gen_new_label();
+    tcg_gen_brcondi_i32(TCG_COND_LEU, tmp, 16, over_label);
+
+    addr = tcg_temp_new_i64();
+    tcg_gen_addi_i64(addr, cpu_reg_sp(s, rn), imm);
+
+    type = is_write ? MMU_DATA_STORE : MMU_DATA_LOAD,
+    mmu_idx = get_mem_index(s);
+    gen_helper_unaligned_access(cpu_env, addr, tcg_constant_i32(type),
+                                tcg_constant_i32(mmu_idx));
+
+    gen_set_label(over_label);
+
+}
+
+/* Handle the alignment check for AccType_ATOMIC instructions. */
+static MemOp check_atomic_align(DisasContext *s, int rn, MemOp mop)
+{
+    MemOp size = mop & MO_SIZE;
+
+    if (size == MO_8) {
+        return mop;
+    }
+
+    /*
+     * If size == MO_128, this is a LDXP, and the operation is single-copy
+     * atomic for each doubleword, not the entire quadword; it still must
+     * be quadword aligned.
+     */
+    if (size == MO_128) {
+        return finalize_memop_atom(s, MO_128 | MO_ALIGN,
+                                   MO_ATOM_IFALIGN_PAIR);
+    }
+    if (dc_isar_feature(aa64_lse2, s)) {
+        check_lse2_align(s, rn, 0, true, mop);
+    } else {
+        mop |= MO_ALIGN;
+    }
+    return finalize_memop(s, mop);
+}
+
+/* Handle the alignment check for AccType_ORDERED instructions. */
+static MemOp check_ordered_align(DisasContext *s, int rn, int imm,
+                                 bool is_write, MemOp mop)
+{
+    MemOp size = mop & MO_SIZE;
+
+    if (size == MO_8) {
+        return mop;
+    }
+    if (size == MO_128) {
+        return finalize_memop_atom(s, MO_128 | MO_ALIGN,
+                                   MO_ATOM_IFALIGN_PAIR);
+    }
+    if (!dc_isar_feature(aa64_lse2, s)) {
+        mop |= MO_ALIGN;
+    } else if (!s->naa) {
+        check_lse2_align(s, rn, imm, is_write, mop);
+    }
+    return finalize_memop(s, mop);
+}
+
 typedef struct DisasCompare64 {
     TCGCond cond;
     TCGv_i64 value;
@@ -2384,21 +2467,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
 {
     int idx = get_mem_index(s);
     TCGv_i64 dirty_addr, clean_addr;
-    MemOp memop;
-
-    /*
-     * For pairs:
-     * if size == 2, the operation is single-copy atomic for the doubleword.
-     * if size == 3, the operation is single-copy atomic for *each* doubleword,
-     * not the entire quadword, however it must be quadword aligned.
-     */
-    memop = size + is_pair;
-    if (memop == MO_128) {
-        memop = finalize_memop_atom(s, MO_128 | MO_ALIGN,
-                                    MO_ATOM_IFALIGN_PAIR);
-    } else {
-        memop = finalize_memop(s, memop | MO_ALIGN);
-    }
+    MemOp memop = check_atomic_align(s, rn, size + is_pair);
 
     s->is_ldex = true;
     dirty_addr = cpu_reg_sp(s, rn);
@@ -2536,7 +2605,7 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    memop = finalize_memop(s, size | MO_ALIGN);
+    memop = check_atomic_align(s, rn, size);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
     tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt,
                                memidx, memop);
@@ -2558,7 +2627,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     }
 
     /* This is a single atomic access, despite the "pair". */
-    memop = finalize_memop(s, (size + 1) | MO_ALIGN);
+    memop = check_atomic_align(s, rn, size + 1);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
 
     if (size == 2) {
@@ -2678,8 +2747,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        memop = finalize_memop(s, size | MO_ALIGN);
+        memop = check_ordered_align(s, rn, 0, true, size);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     true, rn != 31, memop);
         do_gpr_st(s, cpu_reg(s, rt), clean_addr, memop, true, rt,
@@ -2697,8 +2765,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        memop = finalize_memop(s, size | MO_ALIGN);
+        memop = check_ordered_align(s, rn, 0, false, size);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     false, rn != 31, memop);
         do_gpr_ld(s, cpu_reg(s, rt), clean_addr, memop, false, true,
@@ -3379,7 +3446,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, tcg_rt, clean_addr;
     AtomicThreeOpFn *fn = NULL;
-    MemOp mop = finalize_memop(s, size | MO_ALIGN);
+    MemOp mop = size;
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
@@ -3430,6 +3497,8 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
+
+    mop = check_atomic_align(s, rn, mop);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, mop);
 
     if (o3_opc == 014) {
@@ -3554,16 +3623,13 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
     bool is_store = false;
     bool extend = false;
     bool iss_sf;
-    MemOp mop;
+    MemOp mop = size;
 
     if (!dc_isar_feature(aa64_rcpc_8_4, s)) {
         unallocated_encoding(s);
         return;
     }
 
-    /* TODO: ARMv8.4-LSE SCTLR.nAA */
-    mop = finalize_memop(s, size | MO_ALIGN);
-
     switch (opc) {
     case 0: /* STLURB */
         is_store = true;
@@ -3595,6 +3661,8 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
         gen_check_sp_alignment(s);
     }
 
+    mop = check_ordered_align(s, rn, offset, is_store, mop);
+
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     clean_addr = clean_data_tbi(s, dirty_addr);
-- 
2.34.1


