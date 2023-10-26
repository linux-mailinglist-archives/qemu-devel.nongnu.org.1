Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1957D79B1
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAP-00063r-Eo; Wed, 25 Oct 2023 20:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9g-00033s-MV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:21 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Z-0008G0-UH
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-27d4b280e4eso219803a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279792; x=1698884592; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Igz27nAt1G4kcSZCVnTvSOQq2ldt0OLkmfH9kT7xTEQ=;
 b=B1SP3Ha7pj7SXx517FwGyw60E1Dq8TRR3UMfXReVznf6getWdawLEEGSVn+V4CTF1y
 dc0J3nEMioXhk1M1nXFb5OmbaD1BLdxeRM5qyfObGs+AMllG8y/CekDIBhAwF/lyUy/O
 2eSgKDIxJTwoS6OnIQ8tDP1ibavf2pnL0P5a4mXYbfk2D5+wB+IaC9+gytNHmIbCJkdw
 GBmfJUjxSQ7n6ZX3VLhQMq6NHH72om4FbYOBzWl8eu04PY0+CcZB63GmIK9EEe3jNt3x
 mcPCFlUfQrlI2IVsrggnN0Z3JqPY7OdJ5RodZC2HAOikeLvL9xjwZozqc/39oqJhK8hl
 c9Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279792; x=1698884592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Igz27nAt1G4kcSZCVnTvSOQq2ldt0OLkmfH9kT7xTEQ=;
 b=NurUcrQAL+RiXSowuZcovHgHPHHbvl5sGKYafKup7IwEdyfZTyk+yLsRbFhiw457bH
 0RsAI/HG3IqN9WroE/8GOkdQzL3HfpRmmW9Cs0iMf1P1rqkPWZ1J5qkwcUHdq1MbNto3
 G1Ho7/ODv1uwuqtIOK2DcV4TS+1xfSy1cDRqRTLieSoh2OEWMa8JFNTE4HGQYRIF+06Z
 z1Dm+1T6EdMDPMLMczPOVDWqgUyZcagy1Mn8myHNYKfcVcwffiYwFSjEvQrfnrhGzRs7
 k7KZuvzM+z6rWyfvgcqji8MRGFyApnWz792dpoVPDp811UZcsM9PHt2Zdp0x1CSm3Mv4
 47xA==
X-Gm-Message-State: AOJu0YyOW27FSsKf2Imykf1QXBHgnqwQ6iVW4x8PNab9eDmogCiaPcbC
 PiPJfUPglF6W8HHMDTP8x32KmWlR7eBHT992KqQ=
X-Google-Smtp-Source: AGHT+IHNjutKQW2XcjQtMTwF8G87JUiAgvzY3c2tUniwtdcpDNiEPAUM4kON3C73v5yOoQouZ8cvWw==
X-Received: by 2002:a17:90a:b396:b0:27c:ecec:8854 with SMTP id
 e22-20020a17090ab39600b0027cecec8854mr1512703pjr.7.1698279792688; 
 Wed, 25 Oct 2023 17:23:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 80/94] target/sparc: Move FSMULD to decodetree
Date: Wed, 25 Oct 2023 17:15:28 -0700
Message-Id: <20231026001542.1141412-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 43 +++++++++++++++++++++------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f18fd99476..6817d52ca2 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -260,6 +260,7 @@ FMULq       10 ..... 110100 ..... 0 0100 1011 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
 FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
+FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 94ad75b897..6626042776 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1669,22 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DFF(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src1, src2;
-
-    src1 = gen_load_fpr_F(dc, rs1);
-    src2 = gen_load_fpr_F(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_QDD(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_ptr, TCGv_i64, TCGv_i64))
 {
@@ -4931,6 +4915,28 @@ TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
 TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
 TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
 
+static bool trans_FsMULd(DisasContext *dc, arg_r_r_r *a)
+{
+    TCGv_i64 dst;
+    TCGv_i32 src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (!(dc->def->features & CPU_FEATURE_FSMULD)) {
+        return raise_unimpfpop(dc);
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_F(dc, a->rs1);
+    src2 = gen_load_fpr_F(dc, a->rs2);
+    gen_helper_fsmuld(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5041,11 +5047,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x47: /* fsubq */
                 case 0x4b: /* fmulq */
                 case 0x4f: /* fdivq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x69: /* fsmuld */
-                    CHECK_FPU_FEATURE(dc, FSMULD);
-                    gen_fop_DFF(dc, rd, rs1, rs2, gen_helper_fsmuld);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x6e: /* fdmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QDD(dc, rd, rs1, rs2, gen_helper_fdmulq);
-- 
2.34.1


