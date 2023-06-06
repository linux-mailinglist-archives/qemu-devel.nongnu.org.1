Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E70E4723E5A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIy-0007ot-Pq; Tue, 06 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIs-0007m7-1F
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:38 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIo-0004qJ-HX
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:37 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30aebe2602fso4804977f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044913; x=1688636913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rT8Xx5/P10U6iTrs9RRJliLfQfYkVopMnjeOx7S580Y=;
 b=CPLUkaGhbj2cZLMbKUk3jU7l6lv0+J0vtaH6gWvOrcow7WTI+YFz9tHmsKUC2aQ2jF
 OK832ehrKj8vr6PhcQ4U1Sp1FywHVw8zZkYNMX6pDpIm2QF3xfMZbnvCspHVxQN5oIT1
 LnRx1q35ZTm+acjG6i7Ik6rETCuWqGfJCqPg+ehtDxvbxboUf8LOKknf48+VLSjzpdLh
 /m+yGxUPbpCG+Jh75WutzSnkUBK724wbmaeWFxChcGq8nicr+p9rcs7R1pAskxm69Wo9
 PWCxXNJAlhlbeQUb2Sc/Z9q0MmfkXASMa855b1GYNc/GKGBJybV4++yaNbMP2LB5/82Q
 TKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044913; x=1688636913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rT8Xx5/P10U6iTrs9RRJliLfQfYkVopMnjeOx7S580Y=;
 b=GTmzpiBKuLuQ4/6qBlQqq+N/sdAZLUNik+8MpsXqgly88tfZBKhb9FB0NZ1G7JWZpN
 clZKsouoeziPcL96wvXCfDkVNqDO9yIAFaGAtWaZ0MR0EchgBhHMxlRefKB6N8mu7sbs
 VTmu+1auePWO84NkRDG0DE4s3Q5pAdmU4nohunNkWidoj3J3kF7rkmHX939sGlnElBN4
 zyS0FXXwXvvzR/tKt0LFh/QDaFiukBQRVAKJHnmCBL5xaxEYr6Q2KJQMmqgqivIiwpFp
 8DVQPm8uYF3IfMQt+NiGMTDk2R3ZxsD7U/V+BGuG2AfI8Oq0dWnXDX4GkH+bqLAVgks0
 g9Rg==
X-Gm-Message-State: AC+VfDzFSGygdrKEugucEuodPhSqJasWXm5ALXs4O6WMVkac5pJDGAi1
 XSDdPiIdhKjCa8DS5bZMRLufbCm3tM4FdCSSeBg=
X-Google-Smtp-Source: ACHHUZ479Qs2q8F45oNUAxQmNNWLlwZSPZTjzYYad9O7VAlEeDeBvGtYgDbj8CLccsG8FOs2VFAdHA==
X-Received: by 2002:a5d:458c:0:b0:309:4e85:897e with SMTP id
 p12-20020a5d458c000000b003094e85897emr1289275wrq.17.1686044912952; 
 Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/42] target/arm: Relax ordered/atomic alignment checks for
 LSE2
Date: Tue,  6 Jun 2023 10:48:07 +0100
Message-Id: <20230606094814.3581397-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

FEAT_LSE2 only requires that atomic operations not cross a
16-byte boundary.  Ordered operations may be completely
unaligned if SCTLR.nAA is set.

Because this alignment check is so special, do it by hand.
Make sure not to keep TCG temps live across the branch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-17-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-a64.h    |   3 +
 target/arm/tcg/helper-a64.c    |   7 ++
 target/arm/tcg/translate-a64.c | 120 ++++++++++++++++++++++++++-------
 3 files changed, 104 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/helper-a64.h b/target/arm/tcg/helper-a64.h
index ff56807247f..3d5957c11f4 100644
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
index c3edf163be4..1c9370f07bd 100644
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
index 91d28f86620..adedebd1c22 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -307,6 +307,89 @@ TCGv_i64 gen_mte_checkN(DisasContext *s, TCGv_i64 addr, bool is_write,
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
@@ -2372,21 +2455,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2, int rn,
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
@@ -2524,7 +2593,7 @@ static void gen_compare_and_swap(DisasContext *s, int rs, int rt,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
-    memop = finalize_memop(s, size | MO_ALIGN);
+    memop = check_atomic_align(s, rn, size);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
     tcg_gen_atomic_cmpxchg_i64(tcg_rs, clean_addr, tcg_rs, tcg_rt,
                                memidx, memop);
@@ -2546,7 +2615,7 @@ static void gen_compare_and_swap_pair(DisasContext *s, int rs, int rt,
     }
 
     /* This is a single atomic access, despite the "pair". */
-    memop = finalize_memop(s, (size + 1) | MO_ALIGN);
+    memop = check_atomic_align(s, rn, size + 1);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), true, rn != 31, memop);
 
     if (size == 2) {
@@ -2666,8 +2735,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             gen_check_sp_alignment(s);
         }
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        memop = finalize_memop(s, size | MO_ALIGN);
+        memop = check_ordered_align(s, rn, 0, true, size);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     true, rn != 31, memop);
         do_gpr_st(s, cpu_reg(s, rt), clean_addr, memop, true, rt,
@@ -2685,8 +2753,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
         if (rn == 31) {
             gen_check_sp_alignment(s);
         }
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        memop = finalize_memop(s, size | MO_ALIGN);
+        memop = check_ordered_align(s, rn, 0, false, size);
         clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
                                     false, rn != 31, memop);
         do_gpr_ld(s, cpu_reg(s, rt), clean_addr, memop, false, true,
@@ -3367,7 +3434,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, tcg_rt, clean_addr;
     AtomicThreeOpFn *fn = NULL;
-    MemOp mop = finalize_memop(s, size | MO_ALIGN);
+    MemOp mop = size;
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
@@ -3418,6 +3485,8 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     if (rn == 31) {
         gen_check_sp_alignment(s);
     }
+
+    mop = check_atomic_align(s, rn, mop);
     clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn), false, rn != 31, mop);
 
     if (o3_opc == 014) {
@@ -3542,16 +3611,13 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
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
@@ -3583,6 +3649,8 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
         gen_check_sp_alignment(s);
     }
 
+    mop = check_ordered_align(s, rn, offset, is_store, mop);
+
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
     clean_addr = clean_data_tbi(s, dirty_addr);
-- 
2.34.1


