Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFF7D79B5
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA4-0004dm-6i; Wed, 25 Oct 2023 20:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Z-0002JI-Ce
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:14 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9U-0008EJ-Lk
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:13 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d3c886671so234756a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279787; x=1698884587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOv2aXvy/cTQRcQjfdy8YMCe5wBIO8HMxVf+QakBJKM=;
 b=gxsVK33zrqz50Hie0achCX8XpJCLt0SuPEXNo4wvrGyx8d2F0SSPYurTmfwSFpDD7U
 RUtpfQ3Nfaq4hewb1neC4kRwfxSNrgW7VVzl75hNbtsj00Yp9krKN2x03rV0G5lfDvme
 NQ0Xx3zvImMYX77b92Z1B9JWaqCrzu1QJcb7AOTFRaXxpnvYkxRgaIHWBHHYcYH2jJXx
 0ZbBrCr8a7jWGipCzg2Vqqg6/RzHPNlPc96cLgtLbko1pWQzzvsN/9bC5HZmY3IbqkT8
 gcfuj71W4sCBNiRBUjgg2kE+uBJPlyzpejBk8nx/p5VkVPWoR3+aN2nXjE0sGJeYmtLj
 cNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279787; x=1698884587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOv2aXvy/cTQRcQjfdy8YMCe5wBIO8HMxVf+QakBJKM=;
 b=VSJDAJKgbtTCUyHslnarcKOrBmvQnanrasT8AT/7DeY9wDjgZytmxIDOi1pHhC4HtY
 6fMtyYpk1eN5PQagmf36sG6IV4gQiJnaX2kulYjrLTocS7c0JYtRWuy6ehLeeVsIBA9X
 319JESlKEuTfwCzzV1lNkmKFVjni31gNDf/+iJuxZIHeubmrcfFO1aTq3aOflQz7M67F
 f8Sde1fEMGSy95Yq0eMck6UJYWvKoFik+0kEtAQtJg8Z9ZZV1mAY7/5K2LeIpxPWrQOz
 JXZpTinPEQR1fKb2BBGQg991q/PucIGJCErg/ueeQ+PjiV2W1NzgkwGAzkiTXvxYmiTi
 2y8Q==
X-Gm-Message-State: AOJu0YyEEZEkLWmPsOtknjjRRUpl10ktKQT99vbqHc5fbCR3qwOLCNEL
 GPA4Mp6Riu6jI0XmljD9HV2lACAePt+D/Qzu9aA=
X-Google-Smtp-Source: AGHT+IGwqkFNa1Sd9OY6+TGxrP4TIHHlc9gecYxzAu79Vxvk3ihbpgWWsMGwXyRlRyuaHxRNRi5IuQ==
X-Received: by 2002:a17:90a:1a52:b0:27f:bd9e:5a10 with SMTP id
 18-20020a17090a1a5200b0027fbd9e5a10mr8285510pjl.20.1698279787354; 
 Wed, 25 Oct 2023 17:23:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 73/94] target/sparc: Move gen_gsr_fop_DDD insns to decodetree
Date: Wed, 25 Oct 2023 17:15:21 -0700
Message-Id: <20231026001542.1141412-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Move FPACK32, FALIGNDATA, BSHUFFLE.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |   3 ++
 target/sparc/translate.c  | 101 ++++++++++++++++++++------------------
 2 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 42d740ad44..bc449023dd 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -277,9 +277,12 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
     FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
     FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+    FPACK32     10 ..... 110110 ..... 0 0011 1010 .....    @r_r_r
     PDIST       10 ..... 110110 ..... 0 0011 1110 .....    @r_r_r
 
+    FALIGNDATAg 10 ..... 110110 ..... 0 0100 1000 .....    @r_r_r
     FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
+    BSHUFFLE    10 ..... 110110 ..... 0 0100 1100 .....    @r_r_r
     FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
 
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 40ef395d14..197c0bea54 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -752,6 +752,51 @@ static void gen_op_array32(TCGv dst, TCGv src1, TCGv src2)
     tcg_gen_shli_tl(dst, dst, 2);
 }
 
+static void gen_op_fpack32(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_fpack32(dst, cpu_gsr, src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_faligndata(TCGv_i64 dst, TCGv_i64 s1, TCGv_i64 s2)
+{
+#ifdef TARGET_SPARC64
+    TCGv t1, t2, shift;
+
+    t1 = tcg_temp_new();
+    t2 = tcg_temp_new();
+    shift = tcg_temp_new();
+
+    tcg_gen_andi_tl(shift, cpu_gsr, 7);
+    tcg_gen_shli_tl(shift, shift, 3);
+    tcg_gen_shl_tl(t1, s1, shift);
+
+    /*
+     * A shift of 64 does not produce 0 in TCG.  Divide this into a
+     * shift of (up to 63) followed by a constant shift of 1.
+     */
+    tcg_gen_xori_tl(shift, shift, 63);
+    tcg_gen_shr_tl(t2, s2, shift);
+    tcg_gen_shri_tl(t2, t2, 1);
+
+    tcg_gen_or_tl(dst, t1, t2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+static void gen_op_bshuffle(TCGv_i64 dst, TCGv_i64 src1, TCGv_i64 src2)
+{
+#ifdef TARGET_SPARC64
+    gen_helper_bshuffle(dst, cpu_gsr, src1, src2);
+#else
+    g_assert_not_reached();
+#endif
+}
+
 // 1
 static void gen_op_eval_ba(TCGv dst)
 {
@@ -1667,22 +1712,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-#ifdef TARGET_SPARC64
-static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                            void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, cpu_gsr, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
 static void gen_fop_QQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_ptr))
 {
@@ -2720,27 +2749,6 @@ static void gen_load_trap_state_at_tl(TCGv_ptr r_tsptr)
         tcg_gen_add_ptr(r_tsptr, r_tsptr, r_tl_tmp);
     }
 }
-
-static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
-{
-    TCGv t1, t2, shift;
-
-    t1 = tcg_temp_new();
-    t2 = tcg_temp_new();
-    shift = tcg_temp_new();
-
-    tcg_gen_andi_tl(shift, gsr, 7);
-    tcg_gen_shli_tl(shift, shift, 3);
-    tcg_gen_shl_tl(t1, s1, shift);
-
-    /* A shift of 64 does not produce 0 in TCG.  Divide this into a
-       shift of (up to 63) followed by a constant shift of 1.  */
-    tcg_gen_xori_tl(shift, shift, 63);
-    tcg_gen_shr_tl(t2, s2, shift);
-    tcg_gen_shri_tl(t2, t2, 1);
-
-    tcg_gen_or_tl(dst, t1, t2);
-}
 #endif
 
 static int extract_dfpreg(DisasContext *dc, int x)
@@ -4889,6 +4897,10 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5319,6 +5331,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
                 case 0x03e: /* VIS I pdist */
+                case 0x03a: /* VIS I fpack32 */
+                case 0x048: /* VIS I faligndata */
+                case 0x04c: /* VIS II bshuffle */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5376,10 +5391,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fcmpeq32(cpu_dst, cpu_src1_64, cpu_src2_64);
                     gen_store_gpr(dc, rd, cpu_dst);
                     break;
-                case 0x03a: /* VIS I fpack32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpack32);
-                    break;
                 case 0x03b: /* VIS I fpack16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
@@ -5394,14 +5405,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fpackfix(cpu_dst_32, cpu_gsr, cpu_src1_64);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x048: /* VIS I faligndata */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
-                    break;
-                case 0x04c: /* VIS II bshuffle */
-                    CHECK_FPU_FEATURE(dc, VIS2);
-                    gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_bshuffle);
-                    break;
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


