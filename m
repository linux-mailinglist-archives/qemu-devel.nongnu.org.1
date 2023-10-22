Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD37D2184
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdY-0006wD-3w; Sun, 22 Oct 2023 02:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdT-0006Wp-8z
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:27 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdN-00037b-7N
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:26 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so1744683b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954895; x=1698559695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XsNnFrEXDzNI5ZBm2Uh3OFwIpNm92O4Amms6buapB9k=;
 b=YFxwx/jnSzETi1RxhmtkiAgi43Fcu5caWNBJmOkcRZQkZiKMijRB9YBNOldePSAfEb
 IJ2f0dOriIZja1n1QDLmSISSO7ZZL/JRT/VPMat1/wOMLqhjbJI5LCo7NYqXO0I7gI6P
 dsQ5r8e8kZr2OINDarbdzRMsJ57uNEpIbEkog8H5AqWsSBdcvDSbQBmTPGyXmTyWMPe4
 NU1C4yAQKaw2fKxxuiE1kHHQe/0UJs1rM7gxgqc2DqXW1kODrO9h+Rm6gUXY7kIFBl3b
 pSNrMKmV5y9YsKxKslKaR4fbb20ubBG5nK8iyLy9xzyPMTfqJGVfRvmt2tFLf6jcvmH5
 BIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954895; x=1698559695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XsNnFrEXDzNI5ZBm2Uh3OFwIpNm92O4Amms6buapB9k=;
 b=JUr8u6oeOAkNKTuJR/LrpvkgEWaZBEWigyhyi9jVmrMdtVRuakKR9BWNCTb9pnMmCv
 Snvgf/BiqHeCzROGpcRJ2dhQh3NXdDUUtylZt+rn0Rs/ZAR4O9f6zW7P7Mk1DYnDL7DZ
 7r4MDPdpwWmgMs0ve04buWy5DNMcP6eIg0WmNsANAZ0XuWHRpcgcwERr8KXjx/B/UMxB
 v8/Zz/PF+B7epX1DEvLqS/ah7QNf1zryyR10usLR47d6wF7NkbSZ4lgoSHds4ugA9hNQ
 b9heoKGtKBsbJ63mdy3Ubl9yq+lH4nf5QC/9RAt8+yuR4GAfBmrfdMMAU0YoghWNZ/PW
 0/AQ==
X-Gm-Message-State: AOJu0YzpEz48cBhiYYGagySxnnLBvJE0lMcltJFzXkeU4i+eQkhE2H0l
 xFwXwQMeXVLebACnnxAMXgMBFHI3kZOWP1peYD8=
X-Google-Smtp-Source: AGHT+IGv6r0RKIyLwbTEr7aXStfc1Wsa5nhqs93StqtBFle9PM38IQtID2hCuVhF4WoEQfAlHpQyNQ==
X-Received: by 2002:a05:6a21:33a0:b0:17e:466:ea62 with SMTP id
 yy32-20020a056a2133a000b0017e0466ea62mr174638pzb.42.1697954895308; 
 Sat, 21 Oct 2023 23:08:15 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 87/90] target/sparc: Move FPCMP* to decodetree
Date: Sat, 21 Oct 2023 23:00:28 -0700
Message-Id: <20231022060031.490251-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
 target/sparc/insns.decode |  9 ++++
 target/sparc/translate.c  | 94 +++++++++++++++++----------------------
 2 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f197bb0b36..781c3cd7f7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -327,6 +327,15 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
 
+    FPCMPLE16   10 ..... 110110 ..... 0 0010 0000 .....    @r_r_r
+    FPCMPNE16   10 ..... 110110 ..... 0 0010 0010 .....    @r_r_r
+    FPCMPGT16   10 ..... 110110 ..... 0 0010 1000 .....    @r_r_r
+    FPCMPEQ16   10 ..... 110110 ..... 0 0010 1010 .....    @r_r_r
+    FPCMPLE32   10 ..... 110110 ..... 0 0010 0100 .....    @r_r_r
+    FPCMPNE32   10 ..... 110110 ..... 0 0010 0110 .....    @r_r_r
+    FPCMPGT32   10 ..... 110110 ..... 0 0010 1100 .....    @r_r_r
+    FPCMPEQ32   10 ..... 110110 ..... 0 0010 1110 .....    @r_r_r
+
     FMUL8x16    10 ..... 110110 ..... 0 0011 0001 .....    @r_r_r
     FMUL8x16AU  10 ..... 110110 ..... 0 0011 0011 .....    @r_r_r
     FMUL8x16AL  10 ..... 110110 ..... 0 0011 0101 .....    @r_r_r
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dee155143c..ff849f33e4 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -77,7 +77,14 @@
 #define gen_helper_fpmerge              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_fexpand              ({ g_assert_not_reached(); NULL; })
 #define gen_helper_pdist                ({ g_assert_not_reached(); NULL; })
-#define gen_helper_fsqrtq               ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpeq16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpne16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmple16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpgt16             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpeq32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpne32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmple32             ({ g_assert_not_reached(); NULL; })
+#define gen_helper_fcmpgt32             ({ g_assert_not_reached(); NULL; })
 #define FSR_LDXFSR_MASK      ({ qemu_build_not_reached(); 0; })
 #define FSR_LDXFSR_OLDMASK   ({ qemu_build_not_reached(); 0; })
 # ifdef CONFIG_USER_ONLY
@@ -5108,6 +5115,37 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_rdd(DisasContext *dc, arg_r_r_r *a,
+                   void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
+{
+#ifdef TARGET_SPARC64
+    TCGv_i64 dst, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    dst = gen_dest_gpr(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, src1, src2);
+    gen_store_gpr(dc, a->rd, dst);
+    return advance_pc(dc);
+#else
+    g_assert_not_reached();
+#endif
+}
+
+TRANS(FPCMPLE16, VIS1, do_rdd, a, gen_helper_fcmple16)
+TRANS(FPCMPNE16, VIS1, do_rdd, a, gen_helper_fcmpne16)
+TRANS(FPCMPGT16, VIS1, do_rdd, a, gen_helper_fcmpgt16)
+TRANS(FPCMPEQ16, VIS1, do_rdd, a, gen_helper_fcmpeq16)
+
+TRANS(FPCMPLE32, VIS1, do_rdd, a, gen_helper_fcmple32)
+TRANS(FPCMPNE32, VIS1, do_rdd, a, gen_helper_fcmpne32)
+TRANS(FPCMPGT32, VIS1, do_rdd, a, gen_helper_fcmpgt32)
+TRANS(FPCMPEQ32, VIS1, do_rdd, a, gen_helper_fcmpeq32)
+
 static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
                        void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
 {
@@ -5390,11 +5428,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_src1_64, cpu_src2_64, cpu_dst_64;
+                TCGv_i64 cpu_src1_64, cpu_dst_64;
                 TCGv_i32 cpu_dst_32;
-                TCGv cpu_dst = tcg_temp_new();
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rs1 = GET_FIELD(insn, 13, 17);
                 int rs2 = GET_FIELD(insn, 27, 31);
                 int rd = GET_FIELD(insn, 2, 6);
 
@@ -5470,63 +5506,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x03a: /* VIS I fpack32 */
                 case 0x048: /* VIS I faligndata */
                 case 0x04c: /* VIS II bshuffle */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmple16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x022: /* VIS I fcmpne16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpne16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x024: /* VIS I fcmple32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmple32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x026: /* VIS I fcmpne32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpne32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x028: /* VIS I fcmpgt16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpgt16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02a: /* VIS I fcmpeq16 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpeq16(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02c: /* VIS I fcmpgt32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpgt32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
                 case 0x02e: /* VIS I fcmpeq32 */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_64 = gen_load_fpr_D(dc, rs1);
-                    cpu_src2_64 = gen_load_fpr_D(dc, rs2);
-                    gen_helper_fcmpeq32(cpu_dst, cpu_src1_64, cpu_src2_64);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x03b: /* VIS I fpack16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
-- 
2.34.1


