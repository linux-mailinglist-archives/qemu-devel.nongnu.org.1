Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B87D1B24
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:46:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ec-0003Mr-JW; Sat, 21 Oct 2023 01:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eZ-0003LF-RL
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:03 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eY-0001B3-3k
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:36:03 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b2ec5ee2e4so1055532b6e.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866561; x=1698471361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfLo+7ZDRLKxzXXYaZdB7Dw9olKqF5tLqEZN44Lhu3I=;
 b=ahC2ms4VQ6ZdiayhhOOQv35SAMhBJJ6TbvpI18Piusidn5dQJoRjdcNY1etfELOJwx
 enR4UH3v36SsuSNEvSxBeH3W2B7TMLoe0O2lgKa6z+d/EyfdURCRB4xQVCG5Htebv58P
 dbL5rC0zvKXthJ45QmcmToufw/gLGe5tibaZ8z2BN0yuIwBz7zulFovNzFmdHJuCRZdr
 YqXGMEOwHaO5nIwj9PaxTkxePAOgiM4/aRJ9+d8ZkbmCphNihoOOsCXPWRCkSgJ2RCad
 NkwuItRYCP2QmLbZNwrCLgAAmLM3Y6/P3XOwgu6hF6Bs21T+GLdTfNs3sO5ufaknaFCV
 RQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866561; x=1698471361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QfLo+7ZDRLKxzXXYaZdB7Dw9olKqF5tLqEZN44Lhu3I=;
 b=But+yg4CZfzt57Dkz8zqC8LXu9QXn+PUKWUeztPNBUjmZWFJjHvzeO8GDNYPR3oZZV
 rz86N4U71zv8kSyoFyZn1w41QquuDG/8QA6wVLVG7YRnDFplfSsYbUOeKj1gMMZm++K5
 2LakiwewAvwZjRyz//d/dGvhtQvkaDhYwvqsE8YhUXfNxpiVsm7KN04N5LFYST98Xk/x
 Rf0MJlRYXut7QG2dHQ/P6KI4BCkh7WlG+ZK5TRZlndJeyfTjlU1Z5J5nmIixhcuWAmmB
 ySRoKlgH8hXz4qCTC+9EwN4ST8PWHrWIn/37vq+KSNaP1H187+X643Fz6dfJ15xmWhzI
 tcGw==
X-Gm-Message-State: AOJu0YxJ619HdwdyEgGedf9FE/SxBMKd7wICtb5Dp1jGGBWapCWOoJCz
 L4lnTNF7FkYC1M1VAV71JTpLudHdy79tpmD3S3k=
X-Google-Smtp-Source: AGHT+IEawFRFo+w+Zmmnz+dvdavJy5w0lyA8ujZNAcuv9BL2IBJoqNlwY3X29JZK5IyoVegW7FYMbQ==
X-Received: by 2002:a05:6808:10a:b0:3b2:e6a4:e177 with SMTP id
 b10-20020a056808010a00b003b2e6a4e177mr3667169oie.51.1697866560907; 
 Fri, 20 Oct 2023 22:36:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 73/90] target/sparc: Move gen_fop_FFF insns to decodetree
Date: Fri, 20 Oct 2023 22:31:41 -0700
Message-Id: <20231021053158.278135-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Move FADDs, FSUBs, FMULs, FDIVs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 +++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 6994312909..06cab099d8 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -248,6 +248,10 @@ FABSd       10 ..... 110100 00000 0 0000 1010 .....        @r_r2
 FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
+FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
+FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
+FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
+FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2d594ddc9f..8a0de0803b 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1653,21 +1653,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 dst, src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -5001,6 +4986,29 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
 TRANS(FORNOTs, VIS1, do_fff, a, tcg_gen_orc_i32)
 TRANS(FORs, VIS1, do_fff, a, tcg_gen_or_i32)
 
+static bool do_env_fff(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_i32, TCGv_env, TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    func(src1, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, src1);
+    return advance_pc(dc);
+}
+
+TRANS(FADDs, ALL, do_env_fff, a, gen_helper_fadds)
+TRANS(FSUBs, ALL, do_env_fff, a, gen_helper_fsubs)
+TRANS(FMULs, ALL, do_env_fff, a, gen_helper_fmuls)
+TRANS(FDIVs, ALL, do_env_fff, a, gen_helper_fdivs)
+
 static bool do_ddd(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5118,10 +5126,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x82: /* V9 fdtox */
                 case 0x88: /* V9 fxtod */
                 case 0x2b: /* fsqrtq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x41: /* fadds */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fadds);
-                    break;
+                case 0x45: /* fsubs */
+                case 0x49: /* fmuls */
+                case 0x4d: /* fdivs */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x42: /* faddd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_faddd);
                     break;
@@ -5129,9 +5138,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x45: /* fsubs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fsubs);
-                    break;
                 case 0x46: /* fsubd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
                     break;
@@ -5139,9 +5145,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x49: /* fmuls */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
-                    break;
                 case 0x4a: /* fmuld */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
@@ -5149,9 +5152,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
-                case 0x4d: /* fdivs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fdivs);
-                    break;
                 case 0x4e: /* fdivd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fdivd);
                     break;
-- 
2.34.1


