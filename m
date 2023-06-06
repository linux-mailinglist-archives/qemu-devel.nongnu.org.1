Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E45D723E66
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIy-0007ok-1y; Tue, 06 Jun 2023 05:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIq-0007jg-7y
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIl-0004oV-EN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f7353993cbso20881265e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044910; x=1688636910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=shirMCVat1ANUxDCq/6z2swO2ZjovBkHEb+yOZF6W9E=;
 b=epwX0wZUqnlxJYjIzdqObgdNIPFwITyVnmHtaVElulMZrsXhvXUbFF55p+vkECoAZ8
 tEHl93jh8Fq88Dy5P0klncyk9ToAetXKBkOFTNx2gR4bmyOofreIhL4po0UR5A7JWSHw
 q87Qu0qokqE5nDasNn9krkqwLhNW+pr0Fpj6RpcIumrbNvFBnEj4PhfDrdxjxZexn9Yz
 QyukcNxEOIlFjx17iQ6kBreHuquintQ51HZYxmN3WXOlHmP7OXaag6pZVIjOPpmE+YTL
 JhXJ0oos9tFvahsOdb8dI6G/8UpCgow7zsjMt512j6I6IoVzxJqJIIabujZmQ/yKXqem
 0m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044910; x=1688636910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shirMCVat1ANUxDCq/6z2swO2ZjovBkHEb+yOZF6W9E=;
 b=BdVNZWSigrhWZyiymCjdtP6qd8hfoC6uMRXBs9ImaJp5fGYml1GbQzbCjMcOgARLsV
 Hdl6yfbods0QF4TdmCmMVfT2UxjfnZLcQP0P4KcNez/+C4zVMAFJLcVR4jZmSZ5amapV
 vaPELsEh6/347psWMNVvzLjkJzomEoNvh1Aa/idExbvIwgmtrSMAg44/26NlkN+4CRal
 CPskKlppTxpeTba4esANoj67IkaLX2ECA/mY3IqrTcpsrZxzfocAXAlFnHKsmXXwqlPV
 1a1nZr0BmFqWpQgerT3ja47/DT9ZG89s6/me8n8aasUB7p/0uOW0c1WY9kXH5F356VG1
 bLmA==
X-Gm-Message-State: AC+VfDzsRjf2luC7RVC230j6K6vcDVnR8YkHj1xXmeVF9iUEH8rPOEwU
 zJ/aMRE0GEhzQ8WyceTaB98+sdEG/CViY7Jh4uA=
X-Google-Smtp-Source: ACHHUZ4xCVZz2/EVCKksqv/2khWdHTUpfgG49OYbymw9J1bU1q7cRK2c/CeelBZJBzJQXi2zOV9iDA==
X-Received: by 2002:a05:600c:1d28:b0:3f7:6238:8103 with SMTP id
 l40-20020a05600c1d2800b003f762388103mr4973911wms.11.1686044909993; 
 Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/42] target/arm: Hoist finalize_memop out of do_gpr_{ld, st}
Date: Tue,  6 Jun 2023 10:48:01 +0100
Message-Id: <20230606094814.3581397-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

We are going to need the complete memop beforehand,
so let's not compute it twice.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 61 +++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 88183f9dca1..d90e8661ca5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -838,7 +838,6 @@ static void do_gpr_st_memidx(DisasContext *s, TCGv_i64 source,
                              unsigned int iss_srt,
                              bool iss_sf, bool iss_ar)
 {
-    memop = finalize_memop(s, memop);
     tcg_gen_qemu_st_i64(source, tcg_addr, memidx, memop);
 
     if (iss_valid) {
@@ -873,7 +872,6 @@ static void do_gpr_ld_memidx(DisasContext *s, TCGv_i64 dest, TCGv_i64 tcg_addr,
                              bool iss_valid, unsigned int iss_srt,
                              bool iss_sf, bool iss_ar)
 {
-    memop = finalize_memop(s, memop);
     tcg_gen_qemu_ld_i64(dest, tcg_addr, memidx, memop);
 
     if (extend && (memop & MO_SIGN)) {
@@ -2625,6 +2623,7 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
     int size = extract32(insn, 30, 2);
     TCGv_i64 clean_addr;
+    MemOp memop;
 
     switch (o2_L_o1_o0) {
     case 0x0: /* STXR */
@@ -2661,10 +2660,11 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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
 
@@ -2679,10 +2679,11 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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
@@ -2790,9 +2791,9 @@ static void disas_ld_lit(DisasContext *s, uint32_t insn)
     } else {
         /* Only unsigned 32bit loads target 32bit registers.  */
         bool iss_sf = opc != 0;
+        MemOp memop = finalize_memop(s, size + is_signed * MO_SIGN);
 
-        do_gpr_ld(s, tcg_rt, clean_addr, size + is_signed * MO_SIGN,
-                  false, true, rt, iss_sf, false);
+        do_gpr_ld(s, tcg_rt, clean_addr, memop, false, true, rt, iss_sf, false);
     }
 }
 
@@ -3046,7 +3047,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     bool post_index;
     bool writeback;
     int memidx;
-
+    MemOp memop;
     TCGv_i64 clean_addr, dirty_addr;
 
     if (is_vector) {
@@ -3073,7 +3074,7 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3107,6 +3108,8 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
     }
 
     memidx = is_unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
+
     clean_addr = gen_mte_check1_mmuidx(s, dirty_addr, is_store,
                                        writeback || rn != 31,
                                        size, is_unpriv, memidx);
@@ -3122,10 +3125,10 @@ static void disas_ldst_reg_imm9(DisasContext *s, uint32_t insn,
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
@@ -3174,8 +3177,8 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     bool is_signed = false;
     bool is_store = false;
     bool is_extended = false;
-
     TCGv_i64 tcg_rm, clean_addr, dirty_addr;
+    MemOp memop;
 
     if (extract32(opt, 1, 1) == 0) {
         unallocated_encoding(s);
@@ -3202,7 +3205,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3215,6 +3218,8 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     ext_and_shift_reg(tcg_rm, tcg_rm, opt, shift ? size : 0);
 
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
+
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, size);
 
     if (is_vector) {
@@ -3226,11 +3231,12 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
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
@@ -3262,12 +3268,11 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
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
@@ -3289,7 +3294,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
             return;
         }
         is_store = (opc == 0);
-        is_signed = extract32(opc, 1, 1);
+        is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
     }
 
@@ -3299,6 +3304,8 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     dirty_addr = read_cpu_reg_sp(s, rn, 1);
     offset = imm12 << size;
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+
+    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, size);
 
     if (is_vector) {
@@ -3311,10 +3318,9 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
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
@@ -3344,7 +3350,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
     bool a = extract32(insn, 23, 1);
     TCGv_i64 tcg_rs, tcg_rt, clean_addr;
     AtomicThreeOpFn *fn = NULL;
-    MemOp mop = s->be_data | size | MO_ALIGN;
+    MemOp mop = finalize_memop(s, size | MO_ALIGN);
 
     if (is_vector || !dc_isar_feature(aa64_atomics, s)) {
         unallocated_encoding(s);
@@ -3405,7 +3411,7 @@ static void disas_ldst_atomic(DisasContext *s, uint32_t insn,
          * full load-acquire (we only need "load-acquire processor consistent"),
          * but we choose to implement them as full LDAQ.
          */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size, false,
+        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, mop, false,
                   true, rt, disas_ldst_compute_iss_sf(size, false, 0), true);
         tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
         return;
@@ -3451,6 +3457,7 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
     bool use_key_a = !extract32(insn, 23, 1);
     int offset;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
+    MemOp memop;
 
     if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
         unallocated_encoding(s);
@@ -3477,12 +3484,14 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
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
 
@@ -3524,7 +3533,7 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
     }
 
     /* TODO: ARMv8.4-LSE SCTLR.nAA */
-    mop = size | MO_ALIGN;
+    mop = finalize_memop(s, size | MO_ALIGN);
 
     switch (opc) {
     case 0: /* STLURB */
-- 
2.34.1


