Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415B7D2172
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaO-0002RU-Bg; Sun, 22 Oct 2023 02:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa4-0000pl-9r
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:56 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZx-0002Fh-CE
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso1593410b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954688; x=1698559488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e/5geg+qbsrgszhS9EeejwZMl4IzQHNLDfvAQNYRYVk=;
 b=INZsUoxP6hs34P6F1Q2AaIM25DqoE/jOkYqPTT7vkFPP5ScmUvx0ZJGo9HRcQxXK8T
 dPe7Eh0TdTHP7KSuq1nnRPUMfeQlVIZepNBlZYNGqmgv/JOepthnk6SKYiOgearUul1P
 p+eiYbIyPfC+8jdNJWTJsQurqKcAeJKzMezq4PJjBihruIjsPXSnY9h15stumMSnkjRR
 IYlGyIBdX2F42RDas8GpaHCAbdwztSxBPC00zDcjhv/ULhg4bTvA8sMAYHz2t5eyFmmN
 mC5npyamEB28tNwWWwEUYr2ZMQ3Re9IXge0psoN5LQClpW4zBVGG7EoYCH2AXBtObVdA
 HXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954688; x=1698559488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e/5geg+qbsrgszhS9EeejwZMl4IzQHNLDfvAQNYRYVk=;
 b=OintEUFtqtcrMUJBJ/mjf/ZxFt6Ue//7YaQBl773QgorYaLzwBfvfhVyfATsOBy3Gj
 /6XjK6p268yfdMtr/jWhO6brRYz2+F3W+QBN1fo7GekMEY9akRDKvNp/a6oZOZMgrqk4
 8RT02l7yGDRUzjzkJxTYKw7V1ZUEBm8uDvJF0RT74EnJ9FuNGpzgDuUKNRbdNED+8GlX
 qPojYYSuy4/pr5VcRhpjDnPVJ+Eixr2whjHYE/CgjvuqSDrCPh605wJaGXImeF06cTFl
 ACimzF+5AmSLTD8vrmgp1LY95dsR8N69z6UKpKv8RqgkojueIcT41rayCuxUsV/xP+xN
 VBDw==
X-Gm-Message-State: AOJu0Yw/muY5Dv5kBJSfj5FaBaPzpYrLUXIM81BwHc5DRfZvidPqdKP7
 RPfqJzXcyFmhXugo/g+qoSiGKlZvj2NkNmPdcgQ=
X-Google-Smtp-Source: AGHT+IFzGvaYx2tlhBOn7B7GinPiPTWvC+1u6iypLrSP+1l+FQi6a7D//C2D89wSRTmlItyp1lW4mg==
X-Received: by 2002:aa7:8b85:0:b0:68f:c2f7:cef0 with SMTP id
 r5-20020aa78b85000000b0068fc2f7cef0mr11549411pfd.4.1697954687895; 
 Sat, 21 Oct 2023 23:04:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 55/90] target/sparc: Move simple fp load/store to decodetree
Date: Sat, 21 Oct 2023 22:59:56 -0700
Message-Id: <20231022060031.490251-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
 target/sparc/insns.decode |  19 ++++
 target/sparc/translate.c  | 194 ++++++++++++++++++--------------------
 2 files changed, 113 insertions(+), 100 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index aa452f1d00..1150890e44 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -238,8 +238,16 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 ## Major Opcode 11 -- load and store instructions
 ##
 
+%dfp_rd     25:5 !function=extract_dfpreg
+%qfp_rd     25:5 !function=extract_qfpreg
+
 &r_r_ri_asi rd rs1 rs2_or_imm asi imm:bool
 @r_r_ri_na  .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri_asi asi=-1
+@d_r_ri_na  .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     \
+            &r_r_ri_asi rd=%dfp_rd asi=-1
+@q_r_ri_na  .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     \
+            &r_r_ri_asi rd=%qfp_rd asi=-1
+
 @r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
 @r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
             &r_r_ri_asi imm=1 asi=-2
@@ -289,6 +297,17 @@ STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
 STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
 STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 
+LDF         11 ..... 100000 ..... . .............          @r_r_ri_na
+LDQF        11 ..... 100010 ..... . .............          @q_r_ri_na
+LDDF        11 ..... 100011 ..... . .............          @d_r_ri_na
+
+STF         11 ..... 100100 ..... . .............          @r_r_ri_na
+{
+  STQF      11 ..... 100110 ..... . .............          @q_r_ri_na
+  STDFQ     11 ----- 100110 ----- - -------------
+}
+STDF        11 ..... 100111 ..... . .............          @d_r_ri_na
+
 LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
 LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5a385024ce..2770d4d84f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -253,29 +253,7 @@ static void gen_op_store_QT0_fpr(unsigned int dst)
                    offsetof(CPU_QuadU, ll.lower));
 }
 
-static void gen_store_fpr_Q(DisasContext *dc, unsigned int dst,
-                            TCGv_i64 v1, TCGv_i64 v2)
-{
-    dst = QFPREG(dst);
-
-    tcg_gen_mov_i64(cpu_fpr[dst / 2], v1);
-    tcg_gen_mov_i64(cpu_fpr[dst / 2 + 1], v2);
-    gen_update_fprs_dirty(dc, dst);
-}
-
 #ifdef TARGET_SPARC64
-static TCGv_i64 gen_load_fpr_Q0(DisasContext *dc, unsigned int src)
-{
-    src = QFPREG(src);
-    return cpu_fpr[src / 2];
-}
-
-static TCGv_i64 gen_load_fpr_Q1(DisasContext *dc, unsigned int src)
-{
-    src = QFPREG(src);
-    return cpu_fpr[src / 2 + 1];
-}
-
 static void gen_move_Q(DisasContext *dc, unsigned int rd, unsigned int rs)
 {
     rd = QFPREG(rd);
@@ -2885,6 +2863,16 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 }
 #endif
 
+static int extract_dfpreg(DisasContext *dc, int x)
+{
+    return DFPREG(x);
+}
+
+static int extract_qfpreg(DisasContext *dc, int x)
+{
+    return QFPREG(x);
+}
+
 /* Include the auto-generated decoder.  */
 #include "decode-insns.c.inc"
 
@@ -3013,6 +3001,20 @@ static bool raise_priv(DisasContext *dc)
     return true;
 }
 
+static bool raise_unimpfpop(DisasContext *dc)
+{
+    gen_op_fpexception_im(dc, FSR_FTT_UNIMPFPOP);
+    return true;
+}
+
+static bool gen_trap_float128(DisasContext *dc)
+{
+    if (dc->def->features & CPU_FEATURE_FLOAT128) {
+        return false;
+    }
+    return raise_unimpfpop(dc);
+}
+
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
@@ -4798,6 +4800,68 @@ static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 TRANS(CASA, CASA, do_casa, a, MO_TEUL)
 TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
 
+static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
+{
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (sz == MO_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    gen_ldf_asi0(dc, &da, sz, addr, a->rd);
+    gen_update_fprs_dirty(dc, a->rd);
+    return advance_pc(dc);
+}
+
+TRANS(LDF, ALL, do_ld_fpr, a, MO_32)
+TRANS(LDDF, ALL, do_ld_fpr, a, MO_64)
+TRANS(LDQF, ALL, do_ld_fpr, a, MO_128)
+
+static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
+{
+    TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    DisasASI da;
+
+    if (addr == NULL) {
+        return false;
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (sz == MO_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+    da = resolve_asi(dc, a->asi, MO_TE | sz);
+    gen_stf_asi0(dc, &da, sz, addr, a->rd);
+    return advance_pc(dc);
+}
+
+TRANS(STF, ALL, do_st_fpr, a, MO_32)
+TRANS(STDF, ALL, do_st_fpr, a, MO_64)
+TRANS(STQF, ALL, do_st_fpr, a, MO_128)
+
+static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
+{
+    if (!avail_32(dc)) {
+        return false;
+    }
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4812,7 +4876,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     TCGv cpu_src1 __attribute__((unused));
     TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
-    TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
+    TCGv_i64 cpu_src1_64, cpu_src2_64;
+    TCGv_i64 cpu_dst_64 __attribute__((unused));
     target_long simm;
 
     opc = GET_FIELD(insn, 0, 1);
@@ -5679,12 +5744,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
                 switch (xop) {
                 case 0x20:      /* ldf, load fpreg */
-                    gen_address_mask(dc, cpu_addr);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    tcg_gen_qemu_ld_i32(cpu_dst_32, cpu_addr,
-                                        dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
+                case 0x22:      /* ldqf, load quad fpreg */
+                case 0x23:      /* lddf, load double fpreg */
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x21:      /* ldfsr, V9 ldxfsr */
 #ifdef TARGET_SPARC64
                     gen_address_mask(dc, cpu_addr);
@@ -5701,25 +5763,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                         dc->mem_idx, MO_TEUL | MO_ALIGN);
                     gen_helper_ldfsr(cpu_fsr, tcg_env, cpu_fsr, cpu_dst_32);
                     break;
-                case 0x22:      /* ldqf, load quad fpreg */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_address_mask(dc, cpu_addr);
-                    cpu_src1_64 = tcg_temp_new_i64();
-                    tcg_gen_qemu_ld_i64(cpu_src1_64, cpu_addr, dc->mem_idx,
-                                        MO_TEUQ | MO_ALIGN_4);
-                    tcg_gen_addi_tl(cpu_addr, cpu_addr, 8);
-                    cpu_src2_64 = tcg_temp_new_i64();
-                    tcg_gen_qemu_ld_i64(cpu_src2_64, cpu_addr, dc->mem_idx,
-                                        MO_TEUQ | MO_ALIGN_4);
-                    gen_store_fpr_Q(dc, rd, cpu_src1_64, cpu_src2_64);
-                    break;
-                case 0x23:      /* lddf, load double fpreg */
-                    gen_address_mask(dc, cpu_addr);
-                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-                    tcg_gen_qemu_ld_i64(cpu_dst_64, cpu_addr, dc->mem_idx,
-                                        MO_TEUQ | MO_ALIGN_4);
-                    gen_store_fpr_D(dc, rd, cpu_dst_64);
-                    break;
                 default:
                     goto illegal_insn;
                 }
@@ -5729,11 +5772,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
                 switch (xop) {
                 case 0x24: /* stf, store fpreg */
-                    gen_address_mask(dc, cpu_addr);
-                    cpu_src1_32 = gen_load_fpr_F(dc, rd);
-                    tcg_gen_qemu_st_i32(cpu_src1_32, cpu_addr,
-                                        dc->mem_idx, MO_TEUL | MO_ALIGN);
-                    break;
+                case 0x26: /* v9 stqf, v8 stdfq */
+                case 0x27: /* stdf, store double fpreg */
+                    g_assert_not_reached();
                 case 0x25: /* stfsr, V9 stxfsr */
                     {
 #ifdef TARGET_SPARC64
@@ -5748,43 +5789,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                                            dc->mem_idx, MO_TEUL | MO_ALIGN);
                     }
                     break;
-                case 0x26:
-#ifdef TARGET_SPARC64
-                    /* V9 stqf, store quad fpreg */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_address_mask(dc, cpu_addr);
-                    /* ??? While stqf only requires 4-byte alignment, it is
-                       legal for the cpu to signal the unaligned exception.
-                       The OS trap handler is then required to fix it up.
-                       For qemu, this avoids having to probe the second page
-                       before performing the first write.  */
-                    cpu_src1_64 = gen_load_fpr_Q0(dc, rd);
-                    tcg_gen_qemu_st_i64(cpu_src1_64, cpu_addr,
-                                        dc->mem_idx, MO_TEUQ | MO_ALIGN_16);
-                    tcg_gen_addi_tl(cpu_addr, cpu_addr, 8);
-                    cpu_src2_64 = gen_load_fpr_Q1(dc, rd);
-                    tcg_gen_qemu_st_i64(cpu_src1_64, cpu_addr,
-                                        dc->mem_idx, MO_TEUQ);
-                    break;
-#else /* !TARGET_SPARC64 */
-                    /* stdfq, store floating point queue */
-#if defined(CONFIG_USER_ONLY)
-                    goto illegal_insn;
-#else
-                    if (!supervisor(dc))
-                        goto priv_insn;
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    goto nfq_insn;
-#endif
-#endif
-                case 0x27: /* stdf, store double fpreg */
-                    gen_address_mask(dc, cpu_addr);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rd);
-                    tcg_gen_qemu_st_i64(cpu_src1_64, cpu_addr, dc->mem_idx,
-                                        MO_TEUQ | MO_ALIGN_4);
-                    break;
                 default:
                     goto illegal_insn;
                 }
@@ -5831,19 +5835,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
  illegal_insn:
     gen_exception(dc, TT_ILL_INSN);
     return;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
- priv_insn:
-    gen_exception(dc, TT_PRIV_INSN);
-    return;
-#endif
  nfpu_insn:
     gen_op_fpexception_im(dc, FSR_FTT_UNIMPFPOP);
     return;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
- nfq_insn:
-    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
-    return;
-#endif
 }
 
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


