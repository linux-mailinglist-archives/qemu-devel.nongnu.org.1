Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C9B7D2710
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhww-0006Pa-2R; Sun, 22 Oct 2023 19:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwt-0006Bg-Bn
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:35 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwq-0007gB-Av
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so2638556b3a.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017611; x=1698622411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rix4Ofb2gwJFehmYesjhSNGxD6Ae8bBrNTffBMb+Yo0=;
 b=NTI99xDc4Q3Z9LNSdX8Cc1e/kUWqJxKRaULF5PwpeRIwkm16r2J4jNLZ9lJzI3okrG
 pbeV3UdFK76LzlBwvuLQtPOMYAv9jsZ+cDhL6POpvJBKEAye8ltd40Tkq6JV+NSPplJp
 9VPVvRmmcF1K13DbzpGV+uzYCSASgsNWmZKgO25PxYLZEpjzqLhzXzRwFrURxs0SO8Qe
 3GURF/8EDVggEWerxU2gCSjcFMftYb//OvjPCVojnHLYRfkZaJKWf69IqaOwvhQ1QSK5
 EOHgMA7idBYyle3piivExj4CFQDHCaqP0Bs3DVAKcskJMWbyqqgIOrSqAQcQAuFL8+jz
 2bVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017611; x=1698622411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rix4Ofb2gwJFehmYesjhSNGxD6Ae8bBrNTffBMb+Yo0=;
 b=PlpK3BQo7nwCkAFo5zcPlgxTqfQMfx/4OqgxUV+3YGbQl2nNtrbSNHfKLkZAHn0v+N
 wsNVJ2Lw4O4aDRiFJAnyokL4PNpHqOuKNnMZ8uOwG2Bll3cNlfFwxyl8wqZz9sNbgPnN
 5k4Hh/WyhFMm3Us7STe5Ei8+X2yut96J3S/Oq/10mJByPJ9TxWE2bh5ca8sNaPEeguOC
 Yhd31RtfoBA/dAQF78Mfzx2/67Jvckfq2B2G9zw7G2lymKuScoKXK+nGXupz03X4reNy
 VvcqnB6i75feypo9vlDd/tuKFiblBO+JvkJraEz+BcNqvIsMZwi9W8vGqd32Je4WBntQ
 Bi3Q==
X-Gm-Message-State: AOJu0Yz8NvYudA/3ZhAe+C5lrZrQGzCZaa6bZWAhDmbWAcp9Cjjx3B5a
 FzU+WsCcTYCANxvLcN1O04Kxr5hFoCi2DhzLYKQ=
X-Google-Smtp-Source: AGHT+IFStTTtx+SHRUkEndscTDpLFRSdxR7VFGNjb6jUOKCD8tZBg6VdqmisUfzK12WN5tkY7hjZhw==
X-Received: by 2002:a05:6a20:4428:b0:15c:b7ba:6a4d with SMTP id
 ce40-20020a056a20442800b0015cb7ba6a4dmr11131697pzb.50.1698017610941; 
 Sun, 22 Oct 2023 16:33:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 67/94] target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S,
 FNOT*S to decodetree
Date: Sun, 22 Oct 2023 16:29:05 -0700
Message-Id: <20231022232932.80507-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 922ced3b4b..ff6bbc02d1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1397,6 +1397,29 @@ static void gen_compare_reg(DisasCompare *cmp, int cond, TCGv r_src)
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
@@ -1557,11 +1580,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -1576,19 +1594,6 @@ static void gen_fop_FF(DisasContext *dc, int rd, int rs,
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
@@ -4800,6 +4805,27 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -4841,15 +4867,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
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
@@ -5177,6 +5197,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5364,10 +5388,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5380,10 +5400,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5421,11 +5437,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5439,11 +5450,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


