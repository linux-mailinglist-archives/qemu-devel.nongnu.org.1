Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12317CBB30
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRn-0004jJ-Pb; Tue, 17 Oct 2023 02:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR3-0003k8-5O
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQv-0005DH-6r
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:03 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3ae2ec1a222so3299492b6e.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523599; x=1698128399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5rSJ4iR2yjI4iXFqavGkYqZhvRD1R5Bp8SKWlo9pj0=;
 b=LEE1Gs/taD01HtGG1eISf/1cQPVsYOvUdOy/bhLRS+GwCdrGDF544us9dzS7twrY9s
 u+26stq5j6HW8B8avOlaUEe2rhacJ1Iw1stCwkSICm6ZukC9plqoCozF8jPZSFT/3pnC
 Qbj5SQPf+GK/5cBfGUSpnmxLIPT8jjdx8ornADGIqVJQXMKPulgH0gP7HvbWdj9zqsjp
 Yu0sSbQI+OQHwK5LKLFdozbVXwucJai2951TAfOzCY6UydZFaIQYqkbGKzikv5z/zfp3
 a8+QCJnaJ4AvkIemP+hWI2ni1yihnqntS5GPYiQHqKCa8UATXMYjxuT2I86pCXg7ZYHO
 4VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523599; x=1698128399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5rSJ4iR2yjI4iXFqavGkYqZhvRD1R5Bp8SKWlo9pj0=;
 b=NSA8hfhAQsuUQIs8OZiMMTvHt+fdS8wZqi1pgrkzaiHTSVYFl1m9FXLNrkEN0/nZAI
 KvMuzDyvydfejE4W1eFW9amhXA0jDDOx9yGWLmxQUYxtw+/JCuqxE77cCdwyfMIXvfX8
 9NkqdTq42Gd9jW4s8zAsN6HoB2nWDs+4dy7mpynKibr+JVURvzey9AG8N7K7nvSq8kZF
 D4A7qxpHUhIgt/MN4lFkz6L4wEDPUHXwVanGSOIeNVKHCOSJXFMfgAIS21cK1HvSaLn3
 i2aQUQC2+mGxNB6nKJK4Ty+V4fBGpJHXQG2L9I/4HC3IPbriLMUI12y29o0WHVzFtdpF
 X2wA==
X-Gm-Message-State: AOJu0YykclBL1ZGBr/7cjPBbTCoUn/50F30WJiirKF8XhIJmeDaGrqR/
 elQCVQDcD/WeBGzr1honfSIDRt8STNJcYmLSuj4=
X-Google-Smtp-Source: AGHT+IG6MaHlnfK9Qt3466pI4xe1Mf264ceJm3smss/KE/6ZArUS8S49XgYcdBSZEdAywf02fcpklQ==
X-Received: by 2002:aca:1212:0:b0:3ae:170f:a39b with SMTP id
 18-20020aca1212000000b003ae170fa39bmr1523236ois.17.1697523599251; 
 Mon, 16 Oct 2023 23:19:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:19:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 87/90] target/sparc: Move FPCMP* to decodetree
Date: Mon, 16 Oct 2023 23:12:41 -0700
Message-Id: <20231017061244.681584-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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
index 3167797854..0a0c5b2505 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -320,6 +320,15 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
 
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
index 8dd5ef0c92..01063afa30 100644
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
@@ -5034,6 +5041,37 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
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
@@ -5316,11 +5354,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
 
@@ -5396,63 +5432,15 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


