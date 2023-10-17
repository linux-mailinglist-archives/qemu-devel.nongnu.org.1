Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D14EB7CBB21
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNo-0003Mh-GE; Tue, 17 Oct 2023 02:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-00038A-Q7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNZ-0004iz-Gv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:35 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b497c8575aso3476960b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523392; x=1698128192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2AlexsC5+7X5knpxNybFFvyGTBkJYOC+d65ljDHcS8=;
 b=jxl3/klEKpZDVzc3JOgpV8hCpKRuvBy5KiRrHjXBYzZMgaQiU9BtAxtJyufgXYa0Un
 v3E12fAxddOD/q4h/tLBRY3kbBt4UQJMSwJQ6jpEVSCn5MQAdrjIQUjL19oUApXqgsyU
 M/Lldb8LEEN9W5ruMes4r6ZhyC+DBxQ2kcMdkWnwZhwU8vdC6/RVlJA2qLiblwPHLVMc
 w7GdoxUmdkrpgmog1PDRs97brcaNAXLgFWwCBmrzR/6D2Rv+Tf2UarCYQ51CacOzTI3q
 GXKcD9v+4qVaE+i6tuw/qx3oRoS9v+V6nnI8dyBf3P0GBNOoOt3jAM4E34Gp22t3D7lD
 YLfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523392; x=1698128192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2AlexsC5+7X5knpxNybFFvyGTBkJYOC+d65ljDHcS8=;
 b=Vh1Vs2TsT5DdenNgditJqCEEScXa3kpzJ03YfDwKjNlUUsy5bvHsz20CjL/MCM+rB/
 B4S+HW9d9054jdHEY9l1gNEgxHOJIgUdKC313Nf0b94iMB18Ya+Q/2BtTzyD2zbo7NTG
 FRxLWhbS1sC3k0qrZGQn2QnUdTNLQME0P/y4E9q0aC6xIYrZXC2AgcOmSHRLWqkUYZ/B
 R4ma/LlP8bY/bpJZjUj4Pas/XQvpaRp4utCelss/8VJYFgabPZwpjOEO2J3qFVvmnWeO
 ksI/YYdKR7pUDuPJ1DFFFDLIF99wj+J7zC4PSAbRmDM8FJre/AS+TnLkfzRnrOsyfvZX
 sRWg==
X-Gm-Message-State: AOJu0YxG8XfWqBnwFpW+0Kk33u1AbXXUrcwT41Cv3f0U9GZTuOwYs9u5
 hSTV3a+qcX5ngChKFYgULCVzMZFz2S3+FwAuFPo=
X-Google-Smtp-Source: AGHT+IGwpEhcUQ+Jh4m2tKzW/v0RrMbgFTzXJma7nPGBl1IkDxCp2UsXnbqlO+ewN6TNCkIJCLLvdw==
X-Received: by 2002:a05:6a00:23d1:b0:6bd:b3b9:649f with SMTP id
 g17-20020a056a0023d100b006bdb3b9649fmr1280433pfc.7.1697523392185; 
 Mon, 16 Oct 2023 23:16:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 56/90] target/sparc: Move asi fp load/store to decodetree
Date: Mon, 16 Oct 2023 23:12:10 -0700
Message-Id: <20231017061244.681584-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
 target/sparc/insns.decode |  51 ++++++++++--
 target/sparc/translate.c  | 169 ++++++++------------------------------
 2 files changed, 79 insertions(+), 141 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index ab311055da..fa9c8d3d8b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -244,6 +244,14 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 @r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
 @r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
             &r_r_ri_asi imm=1 asi=-2
+@d_r_r_asi  .. ..... ...... rs1:5 0     asi:8 rs2_or_imm:5 \
+            &r_r_ri_asi rd=%dfp_rd imm=0
+@d_r_i_asi  .. ..... ...... rs1:5 1     rs2_or_imm:s13     \
+            &r_r_ri_asi rd=%dfp_rd imm=1 asi=-2
+@q_r_r_asi  .. ..... ...... rs1:5 0     asi:8 rs2_or_imm:5 \
+            &r_r_ri_asi rd=%qfp_rd imm=0
+@q_r_i_asi  .. ..... ...... rs1:5 1     rs2_or_imm:s13     \
+            &r_r_ri_asi rd=%qfp_rd imm=1 asi=-2
 @casa_imm   .. rd:5  ...... rs1:5 1 00000000 rs2_or_imm:5  \
             &r_r_ri_asi imm=1 asi=-2
 
@@ -318,10 +326,43 @@ NOP_v9      11 ----- 101101 ----- 0 00000000 -----         # PREFETCH
 NOP_v9      11 ----- 101101 ----- 1 -------------          # PREFETCH
 NOP_v9      11 ----- 111101 ----- - -------------          # PREFETCHA
 
-NCP         11 ----- 110000 ----- --------- -----          # v8 LDC
+{
+  [
+    LDFA    11 ..... 110000 ..... . .............          @r_r_r_asi
+    LDFA    11 ..... 110000 ..... . .............          @r_r_i_asi
+  ]
+  NCP       11 ----- 110000 ----- --------- -----          # v8 LDC
+}
 NCP         11 ----- 110001 ----- --------- -----          # v8 LDCSR
-NCP         11 ----- 110011 ----- --------- -----          # v8 LDDC
-NCP         11 ----- 110100 ----- --------- -----          # v8 STC
+LDQFA       11 ..... 110010 ..... . .............          @q_r_r_asi
+LDQFA       11 ..... 110010 ..... . .............          @q_r_i_asi
+{
+  [
+    LDDFA   11 ..... 110011 ..... . .............          @d_r_r_asi
+    LDDFA   11 ..... 110011 ..... . .............          @d_r_i_asi
+  ]
+  NCP       11 ----- 110011 ----- --------- -----          # v8 LDDC
+}
+
+{
+  [
+    STFA    11 ..... 110100 ..... . .............          @r_r_r_asi
+    STFA    11 ..... 110100 ..... . .............          @r_r_i_asi
+  ]
+  NCP       11 ----- 110100 ----- --------- -----          # v8 STC
+}
 NCP         11 ----- 110101 ----- --------- -----          # v8 STCSR
-NCP         11 ----- 110110 ----- --------- -----          # v8 STDCQ
-NCP         11 ----- 110111 ----- --------- -----          # v8 STDC
+{
+  [
+    STQFA   11 ..... 110110 ..... . .............          @q_r_r_asi
+    STQFA   11 ..... 110110 ..... . .............          @q_r_i_asi
+  ]
+  NCP       11 ----- 110110 ----- --------- -----          # v8 STDCQ
+}
+{
+  [
+    STDFA   11 ..... 110111 ..... . .............          @d_r_r_asi
+    STDFA   11 ..... 110111 ..... . .............          @d_r_i_asi
+  ]
+  NCP       11 ----- 110111 ----- --------- -----          # v8 STDC
+}
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eeec1e751c..6fdcfebe55 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2063,12 +2063,6 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
     return (DisasASI){ type, asi, mem_idx, memop };
 }
 
-static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
-{
-    int asi = IS_IMM ? -2 : GET_FIELD(insn, 19, 26);
-    return resolve_asi(dc, asi, memop);
-}
-
 static void gen_ld_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
     switch (da->type) {
@@ -2241,12 +2235,13 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
+static void gen_ldf_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
     TCGv_i64 d64;
+    TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
     if (size == MO_128) {
@@ -2273,8 +2268,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         case MO_128:
             d64 = tcg_temp_new_i64();
             tcg_gen_qemu_ld_i64(d64, addr, da->mem_idx, memop);
-            tcg_gen_addi_tl(addr, addr, 8);
-            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + 1], addr, da->mem_idx, memop);
+            addr_tmp = tcg_temp_new();
+            tcg_gen_addi_tl(addr_tmp, addr, 8);
+            tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + 1], addr_tmp, da->mem_idx, memop);
             tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
             break;
         default:
@@ -2285,18 +2281,16 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     case GET_ASI_BLOCK:
         /* Valid for lddfa on aligned registers only.  */
         if (size == MO_64 && (rd & 7) == 0) {
-            TCGv eight;
-            int i;
-
             /* The first operation checks required alignment.  */
-            eight = tcg_constant_tl(8);
-            for (i = 0; ; ++i) {
+            addr_tmp = tcg_temp_new();
+            for (int i = 0; ; ++i) {
                 tcg_gen_qemu_ld_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
                                     memop | (i == 0 ? MO_ALIGN_64 : 0));
                 if (i == 7) {
                     break;
                 }
-                tcg_gen_add_tl(addr, addr, eight);
+                tcg_gen_addi_tl(addr_tmp, addr, 8);
+                addr = addr_tmp;
             }
         } else {
             gen_exception(dc, TT_ILL_INSN);
@@ -2338,8 +2332,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
             case MO_128:
                 d64 = tcg_temp_new_i64();
                 gen_helper_ld_asi(d64, tcg_env, addr, r_asi, r_mop);
-                tcg_gen_addi_tl(addr, addr, 8);
-                gen_helper_ld_asi(cpu_fpr[rd / 2 + 1], tcg_env, addr,
+                addr_tmp = tcg_temp_new();
+                tcg_gen_addi_tl(addr_tmp, addr, 8);
+                gen_helper_ld_asi(cpu_fpr[rd / 2 + 1], tcg_env, addr_tmp,
                                   r_asi, r_mop);
                 tcg_gen_mov_i64(cpu_fpr[rd / 2], d64);
                 break;
@@ -2351,21 +2346,12 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     }
 }
 
-static void __attribute__((unused))
-gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
-{
-    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL :
-                                     size == 8 ? MO_TEUQ : MO_TE | MO_128));
-
-    gen_address_mask(dc, addr);
-    gen_ldf_asi0(dc, &da, addr, rd);
-}
-
-static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
+static void gen_stf_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
+    TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
     if (size == MO_128) {
@@ -2395,8 +2381,9 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
                write.  */
             tcg_gen_qemu_st_i64(cpu_fpr[rd / 2], addr, da->mem_idx,
                                 memop | MO_ALIGN_16);
-            tcg_gen_addi_tl(addr, addr, 8);
-            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + 1], addr, da->mem_idx, memop);
+            addr_tmp = tcg_temp_new();
+            tcg_gen_addi_tl(addr_tmp, addr, 8);
+            tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + 1], addr_tmp, da->mem_idx, memop);
             break;
         default:
             g_assert_not_reached();
@@ -2406,18 +2393,16 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
         if (size == MO_64 && (rd & 7) == 0) {
-            TCGv eight;
-            int i;
-
             /* The first operation checks required alignment.  */
-            eight = tcg_constant_tl(8);
-            for (i = 0; ; ++i) {
+            addr_tmp = tcg_temp_new();
+            for (int i = 0; ; ++i) {
                 tcg_gen_qemu_st_i64(cpu_fpr[rd / 2 + i], addr, da->mem_idx,
                                     memop | (i == 0 ? MO_ALIGN_64 : 0));
                 if (i == 7) {
                     break;
                 }
-                tcg_gen_add_tl(addr, addr, eight);
+                tcg_gen_addi_tl(addr_tmp, addr, 8);
+                addr = addr_tmp;
             }
         } else {
             gen_exception(dc, TT_ILL_INSN);
@@ -2443,16 +2428,6 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
     }
 }
 
-static void __attribute__((unused))
-gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
-{
-    DisasASI da = get_asi(dc, insn, (size == 4 ? MO_TEUL :
-                                     size == 8 ? MO_TEUQ : MO_TE | MO_128));
-
-    gen_address_mask(dc, addr);
-    gen_stf_asi0(dc, &da, addr, rd);
-}
-
 static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_dest_gpr(dc, rd);
@@ -4738,7 +4713,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
         return true;
     }
     da = resolve_asi(dc, a->asi, mop);
-    gen_ldf_asi0(dc, &da, addr, a->rd);
+    gen_ldf_asi(dc, &da, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
 }
@@ -4747,6 +4722,10 @@ TRANS(LDF, ALL, do_ld_fpr, a, MO_TEUL)
 TRANS(LDDF, ALL, do_ld_fpr, a, MO_TEUQ)
 TRANS(LDQF, ALL, do_ld_fpr, a, MO_TE | MO_128)
 
+TRANS(LDFA, 64, do_ld_fpr, a, MO_TEUL)
+TRANS(LDDFA, 64, do_ld_fpr, a, MO_TEUQ)
+TRANS(LDQFA, 64, do_ld_fpr, a, MO_TE | MO_128)
+
 static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4762,7 +4741,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
         return true;
     }
     da = resolve_asi(dc, a->asi, mop);
-    gen_stf_asi0(dc, &da, addr, a->rd);
+    gen_stf_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -4770,6 +4749,10 @@ TRANS(STF, ALL, do_st_fpr, a, MO_TEUL)
 TRANS(STDF, ALL, do_st_fpr, a, MO_TEUQ)
 TRANS(STQF, ALL, do_st_fpr, a, MO_TE | MO_128)
 
+TRANS(STFA, 64, do_st_fpr, a, MO_TEUL)
+TRANS(STDFA, 64, do_st_fpr, a, MO_TEUQ)
+TRANS(STQFA, 64, do_st_fpr, a, MO_TE | MO_128)
+
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
     if (!avail_32(dc)) {
@@ -5603,64 +5586,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             if (xop < 4 || (xop > 7 && xop < 0x14 && xop != 0x0e) ||
                 (xop > 0x17 && xop <= 0x1d ) ||
                 (xop > 0x2c && xop <= 0x33) || xop == 0x1f || xop == 0x3d) {
-                TCGv cpu_val = gen_dest_gpr(dc, rd);
-
-                switch (xop) {
-                case 0x0:       /* ld, V9 lduw, load unsigned word */
-                case 0x1:       /* ldub, load unsigned byte */
-                case 0x2:       /* lduh, load unsigned halfword */
-                case 0x3:       /* ldd, load double word */
-                case 0x9:       /* ldsb, load signed byte */
-                case 0xa:       /* ldsh, load signed halfword */
-                case 0xd:       /* ldstub */
-                case 0x0f:      /* swap */
-                case 0x10:      /* lda, V9 lduwa, load word alternate */
-                case 0x11:      /* lduba, load unsigned byte alternate */
-                case 0x12:      /* lduha, load unsigned halfword alternate */
-                case 0x13:      /* ldda, load double word alternate */
-                case 0x19:      /* ldsba, load signed byte alternate */
-                case 0x1a:      /* ldsha, load signed halfword alternate */
-                case 0x1d:      /* ldstuba */
-                case 0x1f:      /* swapa */
-                    g_assert_not_reached();  /* in decodetree */
-                case 0x08:      /* V9 ldsw */
-                case 0x0b:      /* V9 ldx */
-                case 0x18:      /* V9 ldswa */
-                case 0x1b:      /* V9 ldxa */
-                case 0x2d:      /* V9 prefetch */
-                case 0x3d:      /* V9 prefetcha */
-                    goto illegal_insn;  /* in decodetree */
-#ifdef TARGET_SPARC64
-                case 0x30: /* V9 ldfa */
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_ldf_asi(dc, cpu_addr, insn, 4, rd);
-                    gen_update_fprs_dirty(dc, rd);
-                    goto skip_move;
-                case 0x33: /* V9 lddfa */
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_ldf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
-                    gen_update_fprs_dirty(dc, DFPREG(rd));
-                    goto skip_move;
-                case 0x32: /* V9 ldqfa */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_ldf_asi(dc, cpu_addr, insn, 16, QFPREG(rd));
-                    gen_update_fprs_dirty(dc, QFPREG(rd));
-                    goto skip_move;
-#endif
-                default:
-                    goto illegal_insn;
-                }
-                gen_store_gpr(dc, rd, cpu_val);
-#if defined(TARGET_SPARC64)
-            skip_move: ;
-#endif
+                goto illegal_insn;  /* in decodetree */
             } else if (xop >= 0x20 && xop < 0x24) {
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5716,36 +5642,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     goto illegal_insn;
                 }
             } else if (xop > 0x33 && xop < 0x3f) {
-                switch (xop) {
-#ifdef TARGET_SPARC64
-                case 0x34: /* V9 stfa */
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_stf_asi(dc, cpu_addr, insn, 4, rd);
-                    break;
-                case 0x36: /* V9 stqfa */
-                    {
-                        CHECK_FPU_FEATURE(dc, FLOAT128);
-                        if (gen_trap_ifnofpu(dc)) {
-                            goto jmp_insn;
-                        }
-                        gen_stf_asi(dc, cpu_addr, insn, 16, QFPREG(rd));
-                    }
-                    break;
-                case 0x37: /* V9 stdfa */
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_stf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
-                    break;
-#endif
-                case 0x3e: /* V9 casxa */
-                case 0x3c: /* V9 or LEON3 casa */
-                    goto illegal_insn; /* in decodetree */
-                default:
-                    goto illegal_insn;
-                }
+                goto illegal_insn; /* in decodetree */
             } else {
                 goto illegal_insn;
             }
-- 
2.34.1


