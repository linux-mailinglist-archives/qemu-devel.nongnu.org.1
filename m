Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9467D79BC
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9x-0003bw-DW; Wed, 25 Oct 2023 20:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Q-0000zD-8C
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:04 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9L-0008Bu-E3
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:03 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-27d23f1e3b8so241814a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279778; x=1698884578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K8YU64Za2EkWkchsAfoy1+WnYH0eMyiNHsii8BGP13U=;
 b=QDGyrZSWEACu+JOtqYf/LiVLKYhJ6uIGeg1bKetNcThg4D6c4wRixcEdnUcQyQ+ScD
 2Gjd5YE3lnnW6uPuIk6rgPGFpDOn+5+6M5UZJQtPsdLkMgxg4ar0+UrH7DAp3tEM0GUk
 6BY6/ujxrRGlK8glKO79eBv8NgKrCaASZhq+AqXuTZXPkK/6t/JohRbpcWbGmtIS1m1U
 5PjaEXcET6qeBtQHm/iK7ADyGk+KB5HXE+oajsAPKVjnsnsd2K/dewxaeGS54XaelBUc
 wCpyAuZ0hq2VsphdES42pqohBaCngzrVRGVhTiD2Kl7cWtyLjcqV/NJxE91q5i0MWUIP
 3JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279778; x=1698884578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K8YU64Za2EkWkchsAfoy1+WnYH0eMyiNHsii8BGP13U=;
 b=lF9wAD0/OK5/IbCAP9XtdiS9CbakDjGHZ8a5Xu9ILFxICyOqmmVN8sXi5/+7ZHI0MY
 73Xzha7GKEMOh7UO3dehE2jzDhQI1+FLQlz/d51vMzaEkoa7gmRLBtHj2b8V3RB02n8q
 XzUPMbn4aTW+dMClExKDfWOMDK6f1b5Bykf2kgmhuz7PIxmptKXX64jUaKF+aEUnfd9d
 zvdaMFCH8lXaLAJ+mAfUVqZzz0FdF6/BTdHgx4B9lcOLmIzMnOMmXH4osMbx9MpFjUxM
 G5jAcKEhHlnMEdxR9c62EYjkpW/A9obtAW5rxjy6Fe/K+xTpnPxdhj9pHONfdivQ72ZG
 lW9A==
X-Gm-Message-State: AOJu0Yx9ZAOKEEvrQbKRbxniadOSWMKfJO/3yuwWpdjHQC6+XqGF710L
 aNByUsiVv7p4K5WTIAp+WJ4NVvH3WEoSoEmnDgs=
X-Google-Smtp-Source: AGHT+IFL9YT406zmWjL1O9lMVqM1O74gXcgiVR0+lNj2PFJk3GurvJTkbo98sSovWT93u8xzszm2GA==
X-Received: by 2002:a17:90b:5108:b0:27d:4b6e:b405 with SMTP id
 sc8-20020a17090b510800b0027d4b6eb405mr15351813pjb.33.1698279777670; 
 Wed, 25 Oct 2023 17:22:57 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 60/94] target/sparc: Move asi fp load/store to decodetree
Date: Wed, 25 Oct 2023 17:15:08 -0700
Message-Id: <20231026001542.1141412-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
index dab3dfd09c..ebffcd7393 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2106,12 +2106,6 @@ static DisasASI resolve_asi(DisasContext *dc, int asi, MemOp memop)
     return (DisasASI){ type, asi, mem_idx, memop };
 }
 
-static DisasASI get_asi(DisasContext *dc, int insn, MemOp memop)
-{
-    int asi = IS_IMM ? -2 : GET_FIELD(insn, 19, 26);
-    return resolve_asi(dc, asi, memop);
-}
-
 #if defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
 static void gen_helper_ld_asi(TCGv_i64 r, TCGv_env e, TCGv a,
                               TCGv_i32 asi, TCGv_i32 mop)
@@ -2298,13 +2292,14 @@ static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -2331,8 +2326,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2343,18 +2339,16 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2396,8 +2390,9 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2409,22 +2404,13 @@ static void gen_ldf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2454,8 +2440,9 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2465,18 +2452,16 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -2502,16 +2487,6 @@ static void gen_stf_asi0(DisasContext *dc, DisasASI *da, MemOp orig_size,
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
@@ -4650,7 +4625,7 @@ static bool do_ld_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
         return true;
     }
     da = resolve_asi(dc, a->asi, MO_TE | sz);
-    gen_ldf_asi0(dc, &da, sz, addr, a->rd);
+    gen_ldf_asi(dc, &da, sz, addr, a->rd);
     gen_update_fprs_dirty(dc, a->rd);
     return advance_pc(dc);
 }
@@ -4659,6 +4634,10 @@ TRANS(LDF, ALL, do_ld_fpr, a, MO_32)
 TRANS(LDDF, ALL, do_ld_fpr, a, MO_64)
 TRANS(LDQF, ALL, do_ld_fpr, a, MO_128)
 
+TRANS(LDFA, 64, do_ld_fpr, a, MO_32)
+TRANS(LDDFA, 64, do_ld_fpr, a, MO_64)
+TRANS(LDQFA, 64, do_ld_fpr, a, MO_128)
+
 static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
 {
     TCGv addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
@@ -4674,7 +4653,7 @@ static bool do_st_fpr(DisasContext *dc, arg_r_r_ri_asi *a, MemOp sz)
         return true;
     }
     da = resolve_asi(dc, a->asi, MO_TE | sz);
-    gen_stf_asi0(dc, &da, sz, addr, a->rd);
+    gen_stf_asi(dc, &da, sz, addr, a->rd);
     return advance_pc(dc);
 }
 
@@ -4682,6 +4661,10 @@ TRANS(STF, ALL, do_st_fpr, a, MO_32)
 TRANS(STDF, ALL, do_st_fpr, a, MO_64)
 TRANS(STQF, ALL, do_st_fpr, a, MO_128)
 
+TRANS(STFA, 64, do_st_fpr, a, MO_32)
+TRANS(STDFA, 64, do_st_fpr, a, MO_64)
+TRANS(STQFA, 64, do_st_fpr, a, MO_128)
+
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
     if (!avail_32(dc)) {
@@ -5515,64 +5498,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5628,36 +5554,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


