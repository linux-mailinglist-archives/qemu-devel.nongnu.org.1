Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3617D1AF8
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eb-0003MB-VX; Sat, 21 Oct 2023 01:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eW-0003HE-Le
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:00 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eS-00019x-Qw
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1359233b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866555; x=1698471355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X3XLl9fvJjq7Qe2bmoLZfCkTuFprHVjONC5+sd3Vp3A=;
 b=EY8CtUQvd4lj7unyBVcM8WNRQOq5uFxxVonNtsUosA+lOPZLWkESkuVvMFPtV/TLgR
 /7aTERSgDva4rEp+qeT3rf1ovZnXWGFpMbIjO+p69tXcmRD/nGbH10+YzBALfH8Uu9y0
 BOD5UneWQaZlMSGWso01bpzePSsU3Hy867sTG89Lb/GkExhQ8qBVIZxDegbqu7m6TcaT
 94iV64lf+EJg3jIyB/fUOofaprHm3pH3afpaiMSpjf22cSQnLJ4tMSCD48vtfQAkuFTA
 IIltL9hzrnL8BzBhWcVWgnuvNRynH8/Nj9mkEvCZsqEBxXMqMbjFB3nmn+U712+gbeS2
 sUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866555; x=1698471355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X3XLl9fvJjq7Qe2bmoLZfCkTuFprHVjONC5+sd3Vp3A=;
 b=W7801A6hnB+ns9oRWpFI1heZHQ9rQz1YnDOOzzQ79oJCmD0Q22TiG8y8wJlru/C0IJ
 nG0hTnXeyA4x78ClkOaWSsdRT9glD2CiilDzmsfDA5+SgKa19QELy9SREz8dnK6RfJ+P
 6x63fml7ySUln7dE5tNE9Y0ZWUpTf4yM8H6XQkIFY8qrAJhrAT1TLZAelVKY8UnkKX9h
 CF5zNUOHSSVdlYeFBzxzvX/fiCWYCjTyMDh35KJ6QMt3r/vDm7ho4DZ5oGeXSjQdWdFn
 uGXsOYYIy24CezaDgxNLZPi10pFLbIMbLU/FzQjHFZo4KphhuTRIHfap0DsEcHjJb/fc
 1cuw==
X-Gm-Message-State: AOJu0YyH2c/xoM7QOtbRWCP+W0cTCzP3Q6R6bxcR1FcpScvyG6RFU35S
 2hlq/0ZaQM9joYx+i4xoDtiJt67a7XLvif+Iiz0=
X-Google-Smtp-Source: AGHT+IHoiIMm1HPllzV2gCdVVwz37z2FQxH4QN49BMMxR8je/8nHADuCxzAIp7V0TV7No6VWypsU7w==
X-Received: by 2002:a05:6a00:1a15:b0:693:4a43:1c7e with SMTP id
 g21-20020a056a001a1500b006934a431c7emr3622271pfv.29.1697866555443; 
 Fri, 20 Oct 2023 22:35:55 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 67/90] target/sparc: Move gen_ne_fop_DDD insns to decodetree
Date: Fri, 20 Oct 2023 22:31:35 -0700
Message-Id: <20231021053158.278135-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  26 ++++++
 target/sparc/translate.c  | 178 +++++++++++++++-----------------------
 2 files changed, 98 insertions(+), 106 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8142fbdb8a..75832ea503 100644
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
index 5b984fab7d..e80a902c8d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -59,6 +59,15 @@
 #define gen_helper_retry(E)             qemu_build_not_reached()
 #define gen_helper_udivx(D, E, A, B)    qemu_build_not_reached()
 #define gen_helper_sdivx(D, E, A, B)    qemu_build_not_reached()
+#define gen_helper_fmul8x16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmul8x16au           ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmul8x16al           ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmul8sux16           ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmul8ulx16           ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmuld8sux16          ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fmuld8ulx16          ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -1654,20 +1663,6 @@ static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
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
@@ -4985,6 +4980,46 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
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
@@ -5371,6 +5406,29 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5428,34 +5486,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5482,34 +5512,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5522,46 +5528,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


