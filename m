Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871F87CBAFE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNo-0003Mz-Fp; Tue, 17 Oct 2023 02:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNa-0002y5-R9
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:35 -0400
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNY-0004if-K7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:34 -0400
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-57ad95c555eso3048012eaf.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523391; x=1698128191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mX5JvNOr3Qbqbv8+qYdq2/v3jBiGLs5Yv9+4s5C2zOI=;
 b=Wn3E5HbuDK7WlwUn6Dfiw6AdYAZ9hfmNrDnUd7Z01yvDKd0q3gpYUrIdIc/8Kc1UOF
 6LCsneVZ13ZKIdN7N0meTPCGOTCs/DbYCoY+sbh3gT50ATPT4C0gDRuQw08dZV4ln9Pp
 CygxWak8kKWYEQgFp7URs70ZMZorkyxESYnaQR4eRBOK6XxIJZxGOyL+Nz8gShJbcv3J
 KOHyqilcF+8iiPUTUsp2S9I1a4H0+qibev0MOzpDimhQpAZ5DhrnoBNeW9oEBSJq7cxH
 9BNtO6WWNs+RLpH9NC6fOG6yWooRT8f8XW3Gr8g2UvzjMRSApjUjdL7O8rxidtfAHkHQ
 spmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523391; x=1698128191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mX5JvNOr3Qbqbv8+qYdq2/v3jBiGLs5Yv9+4s5C2zOI=;
 b=vfE1OngAJi3UTy1kEXoCmQbCSfkN3mAt/DRYLKYY2lxlmzkFX/wRH35387iquaWG4s
 RiVvuftxn5zqhUlYwXOwJ9yx0WGDQfdfDSchbim843Q2hjW4yXnJ4U9eslxEWpfl9N0f
 NtFSI6BUtyt0uCcbV1VJTU96oz/OQidoiqabIfuQTftdi+/IxRxpg2PxDuEktwJ5hWYE
 L03/hX8TY/zP4SsJHIKUH6WwVkLMvkK+EDk5kSzBNKusQ9cA/sfF3BFUzriyzO8WpF3L
 HjfkE1Kq/hzGAnKc9dYU+LFtnJQrUNJWiK4+nz/eBuMr8z4CZdI2N4DkPFFNs8QJuXob
 Boww==
X-Gm-Message-State: AOJu0Ywt35rn1D0PtoUAz13PKTLXy17QZnBFQlBtKKaFeltoipL9/bdH
 429Pf6+VgtKDorsaiehOC3+2DWZ91NkFtvXmowE=
X-Google-Smtp-Source: AGHT+IGZwRHL3ymFdZ24SLcvGMcUFUJXOS2xs9286hRQsDAgoWac00gRi7xbZCQmP+9PMD6MPBH8JQ==
X-Received: by 2002:a05:6359:2d4d:b0:15b:249:b520 with SMTP id
 rm13-20020a0563592d4d00b0015b0249b520mr1407527rwb.7.1697523391293; 
 Mon, 16 Oct 2023 23:16:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 55/90] target/sparc: Move simple fp load/store to decodetree
Date: Mon, 16 Oct 2023 23:12:09 -0700
Message-Id: <20231017061244.681584-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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
index 86108679eb..ab311055da 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -231,8 +231,16 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
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
@@ -282,6 +290,17 @@ STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
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
index 822e74fa3e..eeec1e751c 100644
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
@@ -2841,6 +2819,16 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
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
 
@@ -2969,6 +2957,20 @@ static bool raise_priv(DisasContext *dc)
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
     target_long target = dc->pc + a->i * 4;
@@ -4721,6 +4723,68 @@ static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 TRANS(CASA, CASA, do_casa, a, MO_TEUL)
 TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
 
+static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
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
+    if ((mop & MO_SIZE) == MO_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+    gen_ldf_asi0(dc, &da, addr, a->rd);
+    gen_update_fprs_dirty(dc, a->rd);
+    return advance_pc(dc);
+}
+
+TRANS(LDF, ALL, do_ld_fpr, a, MO_TEUL)
+TRANS(LDDF, ALL, do_ld_fpr, a, MO_TEUQ)
+TRANS(LDQF, ALL, do_ld_fpr, a, MO_TE | MO_128)
+
+static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
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
+    if ((mop & MO_SIZE) == MO_128 && gen_trap_float128(dc)) {
+        return true;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+    gen_stf_asi0(dc, &da, addr, a->rd);
+    return advance_pc(dc);
+}
+
+TRANS(STF, ALL, do_st_fpr, a, MO_TEUL)
+TRANS(STDF, ALL, do_st_fpr, a, MO_TEUQ)
+TRANS(STQF, ALL, do_st_fpr, a, MO_TE | MO_128)
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
@@ -4735,7 +4799,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     TCGv cpu_src1 __attribute__((unused));
     TCGv cpu_src2 __attribute__((unused));
     TCGv_i32 cpu_src1_32, cpu_src2_32, cpu_dst_32;
-    TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
+    TCGv_i64 cpu_src1_64, cpu_src2_64;
+    TCGv_i64 cpu_dst_64 __attribute__((unused));
     target_long simm;
 
     opc = GET_FIELD(insn, 0, 1);
@@ -5602,12 +5667,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5624,25 +5686,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5652,11 +5695,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5671,43 +5712,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5754,19 +5758,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


