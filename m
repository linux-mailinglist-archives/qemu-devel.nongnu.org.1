Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B397D2727
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:35:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhxC-0007S0-Df; Sun, 22 Oct 2023 19:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx1-0006Zd-SA
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:44 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwy-0007mR-4U
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:43 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-581e5a9413bso1737730eaf.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017619; x=1698622419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjvNslxxZoj1sln9fyiiyE/eZDTHPPHTcSLAG6H4NHc=;
 b=PTJW2jzUx+mBUDc2Lq/yxP4z0IJVMVUeJyKWelmxnPs1dylkluVE9QWJ6jluzUN87v
 zBBznfFaRhKUm0i+xMsZTC6D6u0ZKMBBcf25CcRTzn5vnKv50tei/baGxWDVHNd9botr
 PM7PLUu/3cHzmmJGD7UJPeQYRo9MfUG5Y/P2+QriQB8E23kqJCRm0laX1It2qtUFX9L0
 kOT34jWcnccepYKYzHqTlsmUOSOUfc+Sn0CR8fpLI3tmDYesOkaNoZYEADb47L7Y8OsE
 x3QXT1R6ilcFo61Zcre+PtXxPjd6qW38Eh6gtFlzXQXfiKxc5+AHL65OsZV0Q1VQbUyU
 znvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017619; x=1698622419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SjvNslxxZoj1sln9fyiiyE/eZDTHPPHTcSLAG6H4NHc=;
 b=lgVmsUS5nf+YSy2jRC3VfvFlPS/3aKkwBwVjKWgNKeIXETl/fqyDb3uUSca+e7IWNW
 IYd45q2Ogm8kOHqLyDn/8y7ZKJuqBTBD5d5qglyZO9tw2RguWh9eRWTVBSye98Vs1t6+
 aL1k20y4MmGbItHPeNsaY9C6p6P3cbUFgwdp1qwPVTbqxNYwepe0ZK+w29ta3eUfKA28
 JEgFsP/e3lG+vCrM92WNeY58hRoUEvQbSfizDKclpPbrRowKmOPUmdJjfhqv+S9dmGxD
 W81cgPREPrA2idm0f7L/XTWKZFO1U0WsdtmWK+y5zeCM+PVaO5BLBJc0/3A4x1QIrBt8
 C9gQ==
X-Gm-Message-State: AOJu0YzKCmPWWBnMlMxz95ksGH8BBGGYPnw9rVcI7ga4sBNmI4WerPwg
 Eo/nM6IeSZOfz4N9OjVL5qsykfrZiSzn6a/6yBk=
X-Google-Smtp-Source: AGHT+IGGKlWWTgL5cv429TcNGOeQtJEMfZx5CXQ32GOLEQhdrLRXxfA2i8ROt/xp+TtWd0kxfYr9Tg==
X-Received: by 2002:a05:6808:188d:b0:3ae:5c0c:df0f with SMTP id
 bi13-20020a056808188d00b003ae5c0cdf0fmr9701512oib.44.1698017619033; 
 Sun, 22 Oct 2023 16:33:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 77/94] target/sparc: Move gen_fop_FFF insns to decodetree
Date: Sun, 22 Oct 2023 16:29:15 -0700
Message-Id: <20231022232932.80507-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 54 +++++++++++++++++++--------------------
 2 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4cb250265d..09444e313f 100644
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
index 23e191aabd..c9fbfa6156 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1656,21 +1656,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -4880,6 +4865,29 @@ TRANS(FXNORs, VIS1, do_fff, a, tcg_gen_eqv_i32)
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
@@ -4997,10 +5005,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5008,9 +5017,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x45: /* fsubs */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fsubs);
-                    break;
                 case 0x46: /* fsubd */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
                     break;
@@ -5018,9 +5024,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x49: /* fmuls */
-                    gen_fop_FFF(dc, rd, rs1, rs2, gen_helper_fmuls);
-                    break;
                 case 0x4a: /* fmuld */
                     gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
                     break;
@@ -5028,9 +5031,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


