Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 531D27CBAFA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:21:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNs-0003Ur-2y; Tue, 17 Oct 2023 02:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNn-0003Lr-8I
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:47 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNj-0004kR-Ip
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:46 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7ab31fb8bso63471217b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523398; x=1698128198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhpcpPleeDxxc/XEAW/TxFnZJ12WYojxzkQnIH6VleQ=;
 b=aHTNfrseGVvpPnt5B7oa7W/xoacHf0okWSmDJVZKsTZ7LP8pldqMK9k5ITd57vu47U
 EU348GDhjIp8HYG/GgFVdIxg9YY4ctmv1nM0XKZDqLjFDFjOgLJKotydvT3C0ssRMLT5
 biZut5vJ7NUy0Rc5PpDdqhVEMbXT8pin2bxbTn6DJS3DM2yRLpEyUsj1SmJuClmP1tgF
 Spl/6Z4RGl3+XO55AHOXXFtjn5qK8UyZ0Mzee7xPonkQvdtl4akeASgExxthMB6SfDHm
 78vi1KFHUN/Wy3Pe7A0hlcNvBpYODf2qSAI3Z/Byd1tI4XL8VHPlE3DpMxy5KSsE4oA6
 wX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523398; x=1698128198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhpcpPleeDxxc/XEAW/TxFnZJ12WYojxzkQnIH6VleQ=;
 b=PZIwwoyF3pbinpTkQJ/cJxVX1Z9Ey0MYZne5dz/0uY+56sKxkN8GgEhMPQNW03yVhX
 qH6zpRGQHAzvyIdp43BMZmpqfbKsShjXrxR0dz0iIVRPDH8Lbrr0x9D/YRl0k/vyOtBV
 HsAKLYgfb5NwU1TNGQCphrezuGSR8547Y6wzgap3lzrO+xdl3InvJACiMwiP5KumvgaA
 nKX//GPvcWnoB7/wPn4q7yzr+aMbrfO2dGqjp317L7pkQaIylJR0MODommrztK0GnJ3M
 acrg/SRyIFmllzB0hiTnCWE+1+YC7c5Upw1TVNo4GdJiV+YJ2i6mabCrveOnp6WPgBcn
 V2vw==
X-Gm-Message-State: AOJu0Yw295sWPeAO3ieitK1hoLXgCXxiu8Uh2bwwUra31WUyz6ol1mnW
 Xx8yg+iEl28a3O1DPvF6rMqKpJMxUCl7rGNgo4o=
X-Google-Smtp-Source: AGHT+IF6u3Av9Ed4XJxCN7WmuwHklfn9neTxNpdb9sYQw1fsDZGQ9yhtEYTnhh9+ivOGxQVwrsZz6g==
X-Received: by 2002:a0d:c447:0:b0:59f:21c1:30b6 with SMTP id
 g68-20020a0dc447000000b0059f21c130b6mr1281220ywd.51.1697523398665; 
 Mon, 16 Oct 2023 23:16:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 63/90] target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S,
 FNOT*S to decodetree
Date: Mon, 16 Oct 2023 23:12:17 -0700
Message-Id: <20231017061244.681584-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112b.google.com
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
 target/sparc/insns.decode | 13 ++++++
 target/sparc/translate.c  | 92 +++++++++++++++++++++------------------
 2 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6f136e0602..d591efb0f9 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -33,6 +33,10 @@ CALL    01 i:s30
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
 
+&r_r        rd rs
+@r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
+@r_r2       .. rd:5  ...... ..... . ........ rs:5          &r_r
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -227,6 +231,10 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
+FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
+FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
+
 {
   [
     EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
@@ -250,6 +258,11 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
+
+    FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
+    FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
+    FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
+    FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 64f1999cba..3b0ce1adcc 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1351,6 +1351,29 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
     cmp->c2 = tcg_constant_tl(0);
 }
 
+static void gen_op_clear_ieee_excp_and_FTT(void)
+{
+    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
+}
+
+static void gen_op_fmovs(TCGv_i32 dst, TCGv_i32 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    tcg_gen_mov_i32(dst, src);
+}
+
+static void gen_op_fnegs(TCGv_i32 dst, TCGv_i32 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_helper_fnegs(dst, src);
+}
+
+static void gen_op_fabss(TCGv_i32 dst, TCGv_i32 src)
+{
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_helper_fabss(dst, src);
+}
+
 #ifdef TARGET_SPARC64
 static void gen_op_fcmps(int fccno, TCGv_i32 r_rs1, TCGv_i32 r_rs2)
 {
@@ -1511,11 +1534,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_op_clear_ieee_excp_and_FTT(void)
-{
-    tcg_gen_andi_tl(cpu_fsr, cpu_fsr, FSR_FTT_CEXC_NMASK);
-}
-
 static void gen_fop_FF(DisasContext *dc, int rd, int rs,
                               void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32))
 {
@@ -1530,19 +1548,6 @@ static void gen_fop_FF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static void gen_ne_fop_FF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, src);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4889,6 +4894,27 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
 TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
 
+static bool do_ff(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tmp);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVs, ALL, do_ff, a, gen_op_fmovs)
+TRANS(FNEGs, ALL, do_ff, a, gen_op_fnegs)
+TRANS(FABSs, ALL, do_ff, a, gen_op_fabss)
+TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
+TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4930,15 +4956,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
                 switch (xop) {
                 case 0x1: /* fmovs */
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs2);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x5: /* fnegs */
-                    gen_ne_fop_FF(dc, rd, rs2, gen_helper_fnegs);
-                    break;
                 case 0x9: /* fabss */
-                    gen_ne_fop_FF(dc, rd, rs2, gen_helper_fabss);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
                     gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
                     break;
@@ -5266,6 +5286,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x018: /* VIS I alignaddr */
                 case 0x01a: /* VIS I alignaddrl */
                 case 0x019: /* VIS II bmask */
+                case 0x067: /* VIS I fnot2s */
+                case 0x06b: /* VIS I fnot1s */
+                case 0x075: /* VIS I fsrc1s */
+                case 0x079: /* VIS I fsrc2s */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5453,10 +5477,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DD(dc, rd, rs2, tcg_gen_not_i64);
                     break;
-                case 0x067: /* VIS I fnot2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FF(dc, rd, rs2, tcg_gen_not_i32);
-                    break;
                 case 0x068: /* VIS I fandnot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
@@ -5469,10 +5489,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DD(dc, rd, rs1, tcg_gen_not_i64);
                     break;
-                case 0x06b: /* VIS I fnot1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FF(dc, rd, rs1, tcg_gen_not_i32);
-                    break;
                 case 0x06c: /* VIS I fxor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
@@ -5510,11 +5526,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1_64 = gen_load_fpr_D(dc, rs1);
                     gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
-                case 0x075: /* VIS I fsrc1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x076: /* VIS I fornot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_orc_i64);
@@ -5528,11 +5539,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
                     gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
-                case 0x079: /* VIS I fsrc2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs2);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x07a: /* VIS I fornot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
-- 
2.34.1


