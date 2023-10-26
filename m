Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 806167D79B9
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA4-0004cw-8H; Wed, 25 Oct 2023 20:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Z-00028J-FG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:14 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9T-0008Dr-5e
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:12 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d4372322aso231096a91.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279786; x=1698884586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HW1LRQw9VDcfdWictsx6e3CwLT7UvGJ/b2nB3wYTzgI=;
 b=yRK6iFriHu1YUXmopEIJREjkX7IeO2QL3ue5MJquFFgFg1bnuLsyyo4mJHkIJ9xBf7
 FvYCUUqJCVlgQR8o7ojFNYLDjJGbTbfQAbvZS2k5br45Iyb39p9s7q+OQFzs/80/6LsO
 wVrRQ2UKKnNT2KUDBMN8vASvMbQnw539ciQAA+WMEXIHmYMfZtnZN5GQGpMuLm4c/e//
 48rttDzemzsNK268EEmXb1HoaGIrWTkMVoRoTwDe4fjue35uVZiIIh+g6Z1KLzQGFxPV
 HL3r9TXzDGjA/nGAuaWJ4u1hLFCwdKiQFjCucron/aJm4hQSSd0RGplO+LH1jcg9ay9i
 n//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279786; x=1698884586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HW1LRQw9VDcfdWictsx6e3CwLT7UvGJ/b2nB3wYTzgI=;
 b=kHRNyn9JSnUZIlrLlhwyjPuGu1+nejam5MAr1S3PZSoE6olPnoqACysAFIlmPlMEJJ
 VpKQHmNJvSVwKntCJstQrazNwYEYXv2mgA+8x9lVqN/T9w73ltYLPMNkKJJHBFOk47hf
 Is8jQY2p0s5+k2D2y3/ASrkpEUdZwH3CQXojy8eQrob+Q933Yi6/WlAazVG5tiD6/w/T
 TFMndZiBEm3cFl0Joo3DdGKRAnlRQABe1tn2LDmJBEZC5oEaE2j7w23Hao3F1jYsbBlY
 EH78+T8opyT3uK3SFeMWHhfPPOOyS+WYe2Tzi1HKx2Uxsh8n3c3J5OXjJ033v4k8x3Gp
 Gpvg==
X-Gm-Message-State: AOJu0Yxo0TDmAMlZR2zemsfii/HP1axzQEMq4AxlXiqIWGjRZbiXHJJZ
 V4zkKePS4vCFDegFzefL4t7Ms/Rrtnow7Qtdmqo=
X-Google-Smtp-Source: AGHT+IFsVw5HzKBb//OFyghDTqW1mvPUazqw6AnrWVzdpqH6Rjwg+sPujYWpkszS56ZtqwCqPtTynw==
X-Received: by 2002:a17:90b:2b46:b0:27d:882f:e6c5 with SMTP id
 rr6-20020a17090b2b4600b0027d882fe6c5mr14563505pjb.9.1698279785824; 
 Wed, 25 Oct 2023 17:23:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 71/94] target/sparc: Move gen_ne_fop_DDD insns to decodetree
Date: Wed, 25 Oct 2023 17:15:19 -0700
Message-Id: <20231026001542.1141412-101-richard.henderson@linaro.org>
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

Move FMUL8x16, FMUL8x16AU, FMUL8x16AL, FMUL8SUx16, FMUL8ULx16,
FMULD8SUx16, FMULD8ULx16, FPMERGE, FEXPAND, FANDNOT1d, FANDNOT2d,
FANDd, FNANDd, FNORd, FORNOT1d, FORNOT2d, FORd, FPADD16d, FPADD32d,
FPSUB16d, FPSUB32d, FXNORd, FXORd.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  26 ++++++
 target/sparc/translate.c  | 178 +++++++++++++++-----------------------
 2 files changed, 98 insertions(+), 106 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0290f2aefb..0e29629b5c 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -270,6 +270,17 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @r_r_r
+    FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @r_r_r
+    FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @r_r_r
+    FMUL8SUx16  10 ..... 110110 ..... 0 0011 0110 .....    @r_r_r
+    FMUL8ULx16  10 ..... 110110 ..... 0 0011 0111 .....    @r_r_r
+    FMULD8SUx16 10 ..... 110110 ..... 0 0011 1000 .....    @r_r_r
+    FMULD8ULx16 10 ..... 110110 ..... 0 0011 1001 .....    @r_r_r
+
+    FPMERGE     10 ..... 110110 ..... 0 0100 1011 .....    @r_r_r
+    FEXPAND     10 ..... 110110 ..... 0 0100 1101 .....    @r_r_r
+
     FSRCd       10 ..... 110110 ..... 0 0111 0100 00000    @r_r1  # FSRC1d
     FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
     FSRCd       10 ..... 110110 00000 0 0111 1000 .....    @r_r2  # FSRC2d
@@ -279,19 +290,34 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
     FNOTd       10 ..... 110110 00000 0 0110 0110 .....    @r_r2  # FNOT2d
     FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
 
+    FPADD16     10 ..... 110110 ..... 0 0101 0000 .....    @r_r_r
     FPADD16s    10 ..... 110110 ..... 0 0101 0001 .....    @r_r_r
+    FPADD32     10 ..... 110110 ..... 0 0101 0010 .....    @r_r_r
     FPADD32s    10 ..... 110110 ..... 0 0101 0011 .....    @r_r_r
+    FPSUB16     10 ..... 110110 ..... 0 0101 0100 .....    @r_r_r
     FPSUB16s    10 ..... 110110 ..... 0 0101 0101 .....    @r_r_r
+    FPSUB32     10 ..... 110110 ..... 0 0101 0110 .....    @r_r_r
     FPSUB32s    10 ..... 110110 ..... 0 0101 0111 .....    @r_r_r
+
+    FNORd       10 ..... 110110 ..... 0 0110 0010 .....    @r_r_r
     FNORs       10 ..... 110110 ..... 0 0110 0011 .....    @r_r_r
+    FANDNOTd    10 ..... 110110 ..... 0 0110 0100 .....    @r_r_r   # FANDNOT2d
     FANDNOTs    10 ..... 110110 ..... 0 0110 0101 .....    @r_r_r   # FANDNOT2s
+    FANDNOTd    10 ..... 110110 ..... 0 0110 1000 .....    @r_r_r_swap # ... 1d
     FANDNOTs    10 ..... 110110 ..... 0 0110 1001 .....    @r_r_r_swap # ... 1s
+    FXORd       10 ..... 110110 ..... 0 0110 1100 .....    @r_r_r
     FXORs       10 ..... 110110 ..... 0 0110 1101 .....    @r_r_r
+    FNANDd      10 ..... 110110 ..... 0 0110 1110 .....    @r_r_r
     FNANDs      10 ..... 110110 ..... 0 0110 1111 .....    @r_r_r
+    FANDd       10 ..... 110110 ..... 0 0111 0000 .....    @r_r_r
     FANDs       10 ..... 110110 ..... 0 0111 0001 .....    @r_r_r
+    FXNORd      10 ..... 110110 ..... 0 0111 0010 .....    @r_r_r
     FXNORs      10 ..... 110110 ..... 0 0111 0011 .....    @r_r_r
+    FORNOTd     10 ..... 110110 ..... 0 0111 0110 .....    @r_r_r    # FORNOT2d
     FORNOTs     10 ..... 110110 ..... 0 0111 0111 .....    @r_r_r    # FORNOT2s
+    FORNOTd     10 ..... 110110 ..... 0 0111 1010 .....    @r_r_r_swap # ... 1d
     FORNOTs     10 ..... 110110 ..... 0 0111 1011 .....    @r_r_r_swap # ... 1s
+    FORd        10 ..... 110110 ..... 0 0111 1100 .....    @r_r_r
     FORs        10 ..... 110110 ..... 0 0111 1101 .....    @r_r_r
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 949d1954a4..35fdcfe4c1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -63,6 +63,15 @@
 # define gen_helper_write_softint(E, S)         qemu_build_not_reached()
 # define gen_helper_wrpil(E, S)                 qemu_build_not_reached()
 # define gen_helper_wrpstate(E, S)              qemu_build_not_reached()
+# define gen_helper_fexpand              ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmul8sux16           ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmul8ulx16           ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmul8x16al           ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmul8x16au           ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmul8x16             ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmuld8sux16          ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fmuld8ulx16          ({ qemu_build_not_reached(); NULL; })
+# define gen_helper_fpmerge              ({ qemu_build_not_reached(); NULL; })
 # define FSR_LDXFSR_MASK                        0
 # define FSR_LDXFSR_OLDMASK                     0
 # define MAXTL_MASK                             0
@@ -1658,20 +1667,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
 }
 
 #ifdef TARGET_SPARC64
-static void gen_ne_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                           void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, src1, src2);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_gsr_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                             void (*gen)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -4868,6 +4863,46 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
 TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
 TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
 
+static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FMUL8x16, VIS1, do_ddd, a, gen_helper_fmul8x16)
+TRANS(FMUL8x16AU, VIS1, do_ddd, a, gen_helper_fmul8x16au)
+TRANS(FMUL8x16AL, VIS1, do_ddd, a, gen_helper_fmul8x16al)
+TRANS(FMUL8SUx16, VIS1, do_ddd, a, gen_helper_fmul8sux16)
+TRANS(FMUL8ULx16, VIS1, do_ddd, a, gen_helper_fmul8ulx16)
+TRANS(FMULD8SUx16, VIS1, do_ddd, a, gen_helper_fmuld8sux16)
+TRANS(FMULD8ULx16, VIS1, do_ddd, a, gen_helper_fmuld8ulx16)
+TRANS(FPMERGE, VIS1, do_ddd, a, gen_helper_fpmerge)
+TRANS(FEXPAND, VIS1, do_ddd, a, gen_helper_fexpand)
+
+TRANS(FPADD16, VIS1, do_ddd, a, tcg_gen_vec_add16_i64)
+TRANS(FPADD32, VIS1, do_ddd, a, tcg_gen_vec_add32_i64)
+TRANS(FPSUB16, VIS1, do_ddd, a, tcg_gen_vec_sub16_i64)
+TRANS(FPSUB32, VIS1, do_ddd, a, tcg_gen_vec_sub32_i64)
+TRANS(FNORd, VIS1, do_ddd, a, tcg_gen_nor_i64)
+TRANS(FANDNOTd, VIS1, do_ddd, a, tcg_gen_andc_i64)
+TRANS(FXORd, VIS1, do_ddd, a, tcg_gen_xor_i64)
+TRANS(FNANDd, VIS1, do_ddd, a, tcg_gen_nand_i64)
+TRANS(FANDd, VIS1, do_ddd, a, tcg_gen_and_i64)
+TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
+TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
+TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5254,6 +5289,29 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x077: /* VIS I fornot2s */
                 case 0x07b: /* VIS I fornot1s */
                 case 0x07d: /* VIS I fors */
+                case 0x050: /* VIS I fpadd16 */
+                case 0x052: /* VIS I fpadd32 */
+                case 0x054: /* VIS I fpsub16 */
+                case 0x056: /* VIS I fpsub32 */
+                case 0x062: /* VIS I fnor */
+                case 0x064: /* VIS I fandnot2 */
+                case 0x068: /* VIS I fandnot1 */
+                case 0x06c: /* VIS I fxor */
+                case 0x06e: /* VIS I fnand */
+                case 0x070: /* VIS I fand */
+                case 0x072: /* VIS I fxnor */
+                case 0x076: /* VIS I fornot2 */
+                case 0x07a: /* VIS I fornot1 */
+                case 0x07c: /* VIS I for */
+                case 0x031: /* VIS I fmul8x16 */
+                case 0x033: /* VIS I fmul8x16au */
+                case 0x035: /* VIS I fmul8x16al */
+                case 0x036: /* VIS I fmul8sux16 */
+                case 0x037: /* VIS I fmul8ulx16 */
+                case 0x038: /* VIS I fmuld8sux16 */
+                case 0x039: /* VIS I fmuld8ulx16 */
+                case 0x04b: /* VIS I fpmerge */
+                case 0x04d: /* VIS I fexpand */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5311,34 +5369,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     gen_helper_fcmpeq32(cpu_dst, cpu_src1_64, cpu_src2_64);
                     gen_store_gpr(dc, rd, cpu_dst);
                     break;
-                case 0x031: /* VIS I fmul8x16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8x16);
-                    break;
-                case 0x033: /* VIS I fmul8x16au */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8x16au);
-                    break;
-                case 0x035: /* VIS I fmul8x16al */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8x16al);
-                    break;
-                case 0x036: /* VIS I fmul8sux16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8sux16);
-                    break;
-                case 0x037: /* VIS I fmul8ulx16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmul8ulx16);
-                    break;
-                case 0x038: /* VIS I fmuld8sux16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld8sux16);
-                    break;
-                case 0x039: /* VIS I fmuld8ulx16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld8ulx16);
-                    break;
                 case 0x03a: /* VIS I fpack32 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpack32);
@@ -5365,34 +5395,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_faligndata);
                     break;
-                case 0x04b: /* VIS I fpmerge */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fpmerge);
-                    break;
                 case 0x04c: /* VIS II bshuffle */
                     CHECK_FPU_FEATURE(dc, VIS2);
                     gen_gsr_fop_DDD(dc, rd, rs1, rs2, gen_helper_bshuffle);
                     break;
-                case 0x04d: /* VIS I fexpand */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, gen_helper_fexpand);
-                    break;
-                case 0x050: /* VIS I fpadd16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add16_i64);
-                    break;
-                case 0x052: /* VIS I fpadd32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
-                    break;
-                case 0x054: /* VIS I fpsub16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_sub16_i64);
-                    break;
-                case 0x056: /* VIS I fpsub32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_vec_add32_i64);
-                    break;
                 case 0x060: /* VIS I fzero */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
@@ -5405,46 +5411,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     tcg_gen_movi_i32(cpu_dst_32, 0);
                     gen_store_fpr_F(dc, rd, cpu_dst_32);
                     break;
-                case 0x062: /* VIS I fnor */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_nor_i64);
-                    break;
-                case 0x064: /* VIS I fandnot2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_andc_i64);
-                    break;
-                case 0x068: /* VIS I fandnot1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
-                    break;
-                case 0x06c: /* VIS I fxor */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
-                    break;
-                case 0x06e: /* VIS I fnand */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_nand_i64);
-                    break;
-                case 0x070: /* VIS I fand */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_and_i64);
-                    break;
-                case 0x072: /* VIS I fxnor */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_eqv_i64);
-                    break;
-                case 0x076: /* VIS I fornot2 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_orc_i64);
-                    break;
-                case 0x07a: /* VIS I fornot1 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
-                    break;
-                case 0x07c: /* VIS I for */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_or_i64);
-                    break;
                 case 0x07e: /* VIS I fone */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-- 
2.34.1


