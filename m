Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1357D216D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbM-0004Xn-Qr; Sun, 22 Oct 2023 02:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa7-00016R-Jc
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:00 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa3-0002HS-Ty
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:59 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5844bc378feso381458eaf.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954694; x=1698559494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MShxFeIoGzyVU+5tfjMPw7APYYdHVl4qBa32XHP3hTg=;
 b=ze3w13uwWm3ALDfZipyBF/Mp/Ac0u/yaIp2xQUe4d1viNMoJA3MHbsE4Z0GUCogI1L
 DUXilarFS6FgkC4laNT7Cuh9dH6IO7CQXujiV9bPaNeKi9Lb4+mvPiBpJQIFOZqkpmvv
 049cKxPjEDa20svUpdRAVCbDzH9PwHfVdXE5nSAmbke0wmo503zzwNt0NWL20tdWn8LX
 vuoTu5IsabrOQyQapWknU73L/m3PRiHviJbQxJsFqcizrzlwUZ9toJ5N2sqy+l2ii1jp
 77QuV0KfxbadOE0yhjq8BQucDLRIdKEGdlyL77RcxYBLG09mB+jvQAFnpkR12O+okbpU
 d7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954694; x=1698559494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MShxFeIoGzyVU+5tfjMPw7APYYdHVl4qBa32XHP3hTg=;
 b=uTtkOtXPKcHeY+WoVuUU+3LqnD+s/xtg5z0t0ovzVPmCVemMQS+FWyitNeTXcAGmNY
 7N1i0vXYBt+GZnD1+KWqqC8qIUJeYws6F4swZcyzHKZrkSIbuRN7aTbWa5BtQc7ITsOc
 idqsiOoDDDU9bE7Ml9oA9FUl/N9z6UP6d5HHUKojDlgUK4BSw8dyZsOi8kz1QAq6UAo4
 rA+8sYa63G53uCTZQgFLTx30IOdwLlDT5AAEwEUWbz2YyK4P2ATgHu8ckZBqdFPwwhXG
 J+iEQEXYI9lrcHqgTqmex8s91I1a2iHc1d8lIWNMw5yaCZk4EL2DKHgia3R4IM7eGhZo
 /4sA==
X-Gm-Message-State: AOJu0YxUqYwJBaPtiDDDvUkDdLP/aGzb+WIKx43LPSS7MbcGsA7jEzCk
 MMk81ZrqCnywuCNYYWw0NDBFh08V5HuRCRAOd9g=
X-Google-Smtp-Source: AGHT+IFgXeWoL5eMkHzB8xRDZELUIQiHeYsOuszczu1brXXnnfTqqPadMymBTgzhJ9N4CJfoqib1VQ==
X-Received: by 2002:a05:6358:9895:b0:143:1063:d1f4 with SMTP id
 q21-20020a056358989500b001431063d1f4mr8106298rwa.13.1697954694476; 
 Sat, 21 Oct 2023 23:04:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 63/90] target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S,
 FNOT*S to decodetree
Date: Sat, 21 Oct 2023 23:00:04 -0700
Message-Id: <20231022060031.490251-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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
index db372573a2..669a54e297 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -38,6 +38,10 @@ CALL    01 i:s30
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
 
+&r_r        rd rs
+@r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
+@r_r2       .. rd:5  ...... ..... . ........ rs:5          &r_r
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -234,6 +238,10 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
+FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
+FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
+
 {
   [
     EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
@@ -257,6 +265,11 @@ RETRY       10 00001 111110 00000 0 0000000000000
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
index f91b7ae0c0..206cdd0e1b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1393,6 +1393,29 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
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
@@ -1553,11 +1576,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -1572,19 +1590,6 @@ static void gen_fop_FF(DisasContext *dc, int rd, int rs,
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
@@ -4963,6 +4968,27 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -5004,15 +5030,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
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
@@ -5340,6 +5360,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5527,10 +5551,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5543,10 +5563,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5584,11 +5600,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5602,11 +5613,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


