Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D0E7D216A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaV-0002lJ-2S; Sun, 22 Oct 2023 02:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa4-0000po-Bf
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:56 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZy-0002GC-6D
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:54 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-581de3e691dso1357457eaf.3
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954689; x=1698559489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oZQhXKAL/opxiwegqNL6OXID+/btYCfjYspMKwXz4p0=;
 b=xyETqqBA6f1wq387SCWGsRDLzNB+61F3WIX36lDFnMi2PVyXxG/H95o67yLkUl4pp2
 I1hdxQ8WpDZA0fSVggBry80U//yieb3YUzDPXz7taM70IY4SPZN+5cS/YXJDEfpzc5sb
 /hC7H+cole20axABgAgspkhUoPkfcsGsuNEec0S/2sHnsY2G0CoacFeG7+MtaNecoSBF
 nB6xcFPszIOXIKxsLGRQ0MmfwX3tkbpjLw3nLJiRyDWqpOFrkNIeRvkKHleIZBToloBg
 CYL5HECbstNQMcFhfijL1d9LzY5jsPpRMkpVOmUxcwXiNr4wF3vuzGGO0woDB++hfPNh
 j8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954689; x=1698559489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZQhXKAL/opxiwegqNL6OXID+/btYCfjYspMKwXz4p0=;
 b=lZux/vB3yqZqr+thV5Mk/rd+JJIKH5CUbdgq7vqE7q+eylRpAg7atnrHK4gjIXF7QS
 pcxvDsrIrS9ai2eanPv3wvMxNwJY/TCLh31fg4ZoTylV4mQhTtvK0Au++wLf+tn6rHSs
 LW8Y2vjY5qaCLgqDbdEfDsRt8Vt5SYLoSw9wzt3O1QXl4C7yzsRdGYjmG2S+ljbYuJSQ
 9UYT9QRwBT/7CrcHuCXSUivinIYrxqBMA+9Gu2A0XTF1oysa0BgxZPdjJvt/7mtaHmmD
 gCRRmuu1X8sNnLcRpVDq/b0mHBI037phdUQtD5fZ9ExUSBBcLlK+u1/b8zS21uNgEnnx
 HLYg==
X-Gm-Message-State: AOJu0YxDjL3WT/hXt4hku6pCKXbyDdt7jjnfrOGhTFmOU7VskMir+yyd
 1hwPJy51mPc/WbbwBm9LuTQARbaFX0KVv3M4qCE=
X-Google-Smtp-Source: AGHT+IFqiEyuvURIevTmFPRug4/vNKrj3qjedWzaoeMZb+7PTaGvd7c+3EWBy5iKphJEPtP2CdPT7g==
X-Received: by 2002:a05:6359:809a:b0:168:d284:50b5 with SMTP id
 re26-20020a056359809a00b00168d28450b5mr1770031rwb.21.1697954688671; 
 Sat, 21 Oct 2023 23:04:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 56/90] target/sparc: Move asi fp load/store to decodetree
Date: Sat, 21 Oct 2023 22:59:57 -0700
Message-Id: <20231022060031.490251-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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
 target/sparc/insns.decode |  51 +++++++++--
 target/sparc/translate.c  | 173 ++++++++------------------------------
 2 files changed, 81 insertions(+), 143 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1150890e44..45eb6a967f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -251,6 +251,14 @@ NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
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
 
@@ -325,10 +333,43 @@ NOP_v9      11 ----- 101101 ----- 0 00000000 -----         # PREFETCH
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
index 2770d4d84f..5710d1e381 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2105,12 +2105,6 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
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
@@ -2283,13 +2277,14 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
-                         TCGv addr, int rd)
+static void gen_ldf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
+                        TCGv addr, int rd)
 {
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
     TCGv_i64 d64;
+    TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
     if (size == MO_128) {
@@ -2316,8 +2311,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2328,18 +2324,16 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
     case GET_ASI_BLOCK:
         /* Valid for lddfa on aligned registers only.  */
         if (orig_size == MO_64 && (rd & 7) == 0) {
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
@@ -2381,8 +2375,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2394,22 +2389,13 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
     }
 }
 
-static void __attribute__((unused))
-gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
-{
-    MemOp sz = ctz32(size);
-    DisasASI da = get_asi(dc, insn, MO_TE | sz);
-
-    gen_address_mask(dc, addr);
-    gen_ldf_asi0(dc, &da, sz, addr, rd);
-}
-
-static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
-                         TCGv addr, int rd)
+static void gen_stf_asi(DisasContext *dc, DisasASI *da, MemOp orig_size,
+                        TCGv addr, int rd)
 {
     MemOp memop = da->memop;
     MemOp size = memop & MO_SIZE;
     TCGv_i32 d32;
+    TCGv addr_tmp;
 
     /* TODO: Use 128-bit load/store below. */
     if (size == MO_128) {
@@ -2439,8 +2425,9 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2450,18 +2437,16 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
     case GET_ASI_BLOCK:
         /* Valid for stdfa on aligned registers only.  */
         if (orig_size == MO_64 && (rd & 7) == 0) {
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
@@ -2487,16 +2472,6 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
     }
 }
 
-static void __attribute__((unused))
-gen_stf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
-{
-    MemOp sz = ctz32(size);
-    DisasASI da = get_asi(dc, insn, MO_TE | sz);
-
-    gen_address_mask(dc, addr);
-    gen_stf_asi0(dc, &da, sz, addr, rd);
-}
-
 static void gen_ldda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 {
     TCGv hi = gen_dest_gpr(dc, rd);
@@ -4815,7 +4790,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
         return true;
     }
     da = resolve_asi(dc, a->asi, MO_TE | sz);
-    gen_ldf_asi0(dc, &da, sz, addr, a->rd);
+    gen_ldf_asi(dc, &da, sz, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
 }
@@ -4824,6 +4799,10 @@ TRANS(LDF, ALL, do_ld_fpr, a, MO_32)
 TRANS(LDDF, ALL, do_ld_fpr, a, MO_64)
 TRANS(LDQF, ALL, do_ld_fpr, a, MO_128)
 
+TRANS(LDFA, 64, do_ld_fpr, a, MO_32)
+TRANS(LDDFA, 64, do_ld_fpr, a, MO_64)
+TRANS(LDQFA, 64, do_ld_fpr, a, MO_128)
+
 static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4839,7 +4818,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
         return true;
     }
     da = resolve_asi(dc, a->asi, MO_TE | sz);
-    gen_stf_asi0(dc, &da, sz, addr, a->rd);
+    gen_stf_asi(dc, &da, sz, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -4847,6 +4826,10 @@ TRANS(STF, ALL, do_st_fpr, a, MO_32)
 TRANS(STDF, ALL, do_st_fpr, a, MO_64)
 TRANS(STQF, ALL, do_st_fpr, a, MO_128)
 
+TRANS(STFA, 64, do_st_fpr, a, MO_32)
+TRANS(STDFA, 64, do_st_fpr, a, MO_64)
+TRANS(STQFA, 64, do_st_fpr, a, MO_128)
+
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
     if (!avail_32(dc)) {
@@ -5680,64 +5663,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5793,36 +5719,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


