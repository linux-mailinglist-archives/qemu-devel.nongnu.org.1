Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 803817C8F47
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPly-00007Q-Rv; Fri, 13 Oct 2023 17:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlv-0008IK-Dn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:39 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPls-0001NW-S6
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:39 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57de9237410so1475383eaf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232755; x=1697837555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8+NgySZzPFDTGs1XP+LEiHgXbVzLT4/zRq+iTuScaFk=;
 b=I1El1tx+fy5p25DEqwZVanXpTegjqbaz2YfuS7Q1/7e2qHuDrVfePYHwyt8tM74ihb
 z3HuVs/xmRsjwZiTNjLg6YoWqK8XiT/qKgV51B/6AoYplb8vSezyC1m/7bvGaSo6sxgE
 PBRZiOc3xmzCdkr2lzg5Zxf16x/U0iwvJBx6E+ail4WTsF6iJ9IspMrwhWAKw68B2BhG
 Mhke7jLGIasUhcsREOWOF8kAxMzpcfPUEtD3SI6LhZKDZ0uH39EU8AObnUQTxy4fFF5W
 COJbLKK3Hd5aZEUxtXyhBPomLOGKfH5UfJJ1ZOyz1s/UdVnOKPOqwcdq22YbsmYW49W0
 SpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232755; x=1697837555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8+NgySZzPFDTGs1XP+LEiHgXbVzLT4/zRq+iTuScaFk=;
 b=tuqNATisoDHBsitdGxSNJXH9/xJs6eZ8RcnjAOoQana2L94j04JUF+6cMP1yFH1Vgr
 LXniIMoOL2Qnl/56LaX/rt1IWEa3NFKEWjS5vDEpxnrIREUmU967bceeOOJCcHGvZRdC
 EJdKYMvg1lQ1NK42b6/n9E2tuVi+aZFbVbL9ZviTDRUTmSIQfgWfY5alwKVL6jumWY4F
 jElM+9QaEpcIbr9XaA0tTkDHIcNJMFwGz5ak4SGqoEgIAxHBdcVEQXXqvihmuwkJD4Dt
 5OG1DyZdZgG0dSkABf8gp7jxgvsGK6zlyUXlhjZSYeY/WUlhK4vFStsZrHB+YcQCFmuB
 e9SA==
X-Gm-Message-State: AOJu0YwSECkVwY5QXsPNoh5CjChgcwfO5QFeJBMrPEFb1f2jl31i2ijz
 6ZD1i+QJ3Y3ZBaBJZd9onL+u0fGP4Tj95/dl3zQ=
X-Google-Smtp-Source: AGHT+IE30+hmoYUVsvdjbJbfqsiUBJ9Mu19zPwwQuhvyez1ictL5d00TXyHBSTY1MukLCObZs11YFQ==
X-Received: by 2002:a05:6358:918c:b0:14e:28f9:53fd with SMTP id
 j12-20020a056358918c00b0014e28f953fdmr26777488rwa.15.1697232755385; 
 Fri, 13 Oct 2023 14:32:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 51/85] target/sparc: Move asi fp load/store to decodetree
Date: Fri, 13 Oct 2023 14:28:12 -0700
Message-Id: <20231013212846.165724-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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
index 00ddc7a93b..b354bb97c4 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -245,6 +245,14 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
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
 
@@ -319,10 +327,43 @@ NOP_v9      11 ----- 101101 ----- 0 00000000 -----         # PREFETCH
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
index abf6c7fc32..f53b45aa38 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2014,12 +2014,6 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
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
@@ -2192,12 +2186,13 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -2224,8 +2219,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2236,18 +2232,16 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2289,8 +2283,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2302,21 +2297,12 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2346,8 +2332,9 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2357,18 +2344,16 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2394,16 +2379,6 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -4672,7 +4647,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
         return true;
     }
     da = resolve_asi(dc, a->asi, mop);
-    gen_ldf_asi0(dc, &da, addr, a->rd);
+    gen_ldf_asi(dc, &da, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
 }
@@ -4681,6 +4656,10 @@ TRANS(LDF, ALL, do_ld_fpr, a, MO_TEUL)
 TRANS(LDDF, ALL, do_ld_fpr, a, MO_TEUQ)
 TRANS(LDQF, ALL, do_ld_fpr, a, MO_TE | MO_128)
 
+TRANS(LDFA, 64, do_ld_fpr, a, MO_TEUL)
+TRANS(LDDFA, 64, do_ld_fpr, a, MO_TEUQ)
+TRANS(LDQFA, 64, do_ld_fpr, a, MO_TE | MO_128)
+
 static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4696,7 +4675,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
         return true;
     }
     da = resolve_asi(dc, a->asi, mop);
-    gen_stf_asi0(dc, &da, addr, a->rd);
+    gen_stf_asi(dc, &da, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -4704,6 +4683,10 @@ TRANS(STF, ALL, do_st_fpr, a, MO_TEUL)
 TRANS(STDF, ALL, do_st_fpr, a, MO_TEUQ)
 TRANS(STQF, ALL, do_st_fpr, a, MO_TE | MO_128)
 
+TRANS(STFA, 64, do_st_fpr, a, MO_TEUL)
+TRANS(STDFA, 64, do_st_fpr, a, MO_TEUQ)
+TRANS(STQFA, 64, do_st_fpr, a, MO_TE | MO_128)
+
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
     if (!avail_32(dc)) {
@@ -5537,64 +5520,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5650,36 +5576,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


