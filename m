Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF22C7D271B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhx6-0006gV-7p; Sun, 22 Oct 2023 19:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx0-0006Ys-H1
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:43 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhww-0007lL-4B
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:42 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6b1ef786b7fso2601104b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017616; x=1698622416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+IonrZy7jQDABUyEb0B5/C3J3veYR3ig45p5II7Cv/4=;
 b=HTSou7hBBxRS8u30aQz39dCSifdO+PTmsSRwScjwkGqkslnd0pDbzSqnjN5fgALUN/
 CP3/B4MR6LmnDPDO8v7DkVsc+0Sr0ExPEGx895+szOpNx2lUu91NUB2zlyl5YHAviXtj
 arz7Qf5tb6/k+JqJ3Jkyg8HHaM9vaF7UL/RD2opX1bhbFOsc78c54ZMdLS7TnwX8qhkN
 Zv8TDCYRMfquGvJ2ScMikH87FVl2e0k2/6QF8ecmEe6rVnjzvfpWg1f3N2PduP7/DIXo
 bP5VQAMOT4/FsBbOurZC538OwAnLfPwqNiMaYMF5NsprVsTy1gVgXsLPMrB++G4jN1a4
 8MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017616; x=1698622416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+IonrZy7jQDABUyEb0B5/C3J3veYR3ig45p5II7Cv/4=;
 b=h9spFGurawAafdI9oQruDsgg47AZGHhv5BUUv15FHWrveXBdJMDwsv8t7PACSiKkrt
 s6n8YXvBuDVPMHqZ907a69uoCbPcJnUksVVpIrK4QUIr/p6mR5dz1/pUHfYgxY4fHkH/
 5IE5yGYDWqjd2cJhxmn3L7V7dfRkPd18KTIQqBpeBnKIxDeX0Otv58a/EeHtGxHpA4O0
 UeUzojbK8+UHsMWZW0uXQzFviGBmPW6iu8FrwtXDsr4eP+J7PWsHGklN4WWFC+NqBPxN
 lA5MA5uoOocnrLkVX3XCb+OCVHP5a8AgLRKsbz2QoyWPqOckivfSCiboa6DV7BC018fq
 n3JA==
X-Gm-Message-State: AOJu0YwamHg2W+2x4AqlMyZEqgDIi393lbhANRoY0bqH6zGpZZ08F5R4
 L+hetHIWmzwbVBHUDR+gKplzVGuYSHCaax/D3QE=
X-Google-Smtp-Source: AGHT+IGAvoYJN5sH2Z1bHUQZSy/Za+V4uSUYCdhxNLBXlBh5zGtjgvDqS/3s6XFwYERDrhEKzUGXmg==
X-Received: by 2002:aa7:94aa:0:b0:6be:30f1:45f8 with SMTP id
 a10-20020aa794aa000000b006be30f145f8mr8328817pfl.20.1698017615807; 
 Sun, 22 Oct 2023 16:33:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 73/94] target/sparc: Move gen_gsr_fop_DDD insns to
 decodetree
Date: Sun, 22 Oct 2023 16:29:11 -0700
Message-Id: <20231022232932.80507-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
index 60ae716802..25f3fea74e 100644
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
@@ -4886,6 +4894,10 @@ TRANS(FXNORd, VIS1, do_ddd, a, tcg_gen_eqv_i64)
 TRANS(FORNOTd, VIS1, do_ddd, a, tcg_gen_orc_i64)
 TRANS(FORd, VIS1, do_ddd, a, tcg_gen_or_i64)
 
+TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
+TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
+TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5316,6 +5328,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x04b: /* VIS I fpmerge */
                 case 0x04d: /* VIS I fexpand */
                 case 0x03e: /* VIS I pdist */
+                case 0x03a: /* VIS I fpack32 */
+                case 0x048: /* VIS I faligndata */
+                case 0x04c: /* VIS II bshuffle */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5373,10 +5388,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5391,14 +5402,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


