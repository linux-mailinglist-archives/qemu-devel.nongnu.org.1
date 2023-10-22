Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66487D274C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:42:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhxA-0007D4-IL; Sun, 22 Oct 2023 19:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhx2-0006aV-Vz
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwz-0007mf-CT
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso2636137b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017620; x=1698622420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OPV0t+KkzidHL/nIqpbghT6RwB4ddLQklAnDEYMRlfU=;
 b=bNOMxVv5PrsB/w3j/c0ubzeQoWRvJj1/jSb2Zh3ngyg2gwMCuvXaVnoKv1flN4CRKX
 fJy5WkeK2PlgvDRhuTuLfAG312o3huESxSATGVnAR5NI9FUJjLoY4wEf+R0Es7W2awW/
 j5Ef1+Wn7Kubw20ga5MvV3g+ALXblC/sBBjs0DMW9pc7YCIMVT2DS7HY06mZ+4Pk63MZ
 dF4Axb1JkVHrcEc4pOtppOID5X8jYHC2vsCHXbilz+9sbaMwv8Yts1lT1yMTyMGnsDag
 0jBZQM87LbnYjjwBt9f3rvXYeCLs0vplKN2CS7tdDoVD8BSnQQvJ6Q+E+XjJvaQcvXQJ
 0aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017620; x=1698622420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OPV0t+KkzidHL/nIqpbghT6RwB4ddLQklAnDEYMRlfU=;
 b=hUbmQeYUsSLWYDUSl+1EO81YaggzddZZ6UtpLGHTzJ6LGCgyEP7RnsGL8Vcz3xoD8i
 VofUbgdeKGOZiiqdGNuxBAfAgHI1KUHULL7C5ioMZgoWcsoiTfN+Xv+aNw7ykMCb51C3
 rEBwi2KOGn/RMjhn76jnXH5BITTnQES7Bl/UOdaBI1QC19D1+5f457wkAv7mtKnPmEnJ
 KYB/oGThNJfe79C20sZk61Rgv819PnVua+oWubzDWojsIBgUM3OJX2GJrMiROynaPDIE
 MBT9qusV6QZIEZJolYSLnCS8OcdZZ4YiHiT9fjtgU//8M6StI9g0qdADvRFUIyEaRkrE
 7OMw==
X-Gm-Message-State: AOJu0Yz2EF210sAt2l1bIUctKpu/ZQGLdWwRMkks+clfLNaAwictraLR
 YEdWtrPaWjgw5iTYdyqRkaJDbcucGg6571ybo3E=
X-Google-Smtp-Source: AGHT+IGUB6BemNwTE7P2IVkT7vObmHe2sXt3VbwfSETGyJ7FEjpEJYM5+oEwU+iT6uJ+rNoycJNTXA==
X-Received: by 2002:a05:6a21:4984:b0:16b:d137:dfb3 with SMTP id
 ax4-20020a056a21498400b0016bd137dfb3mr7840509pzc.59.1698017620056; 
 Sun, 22 Oct 2023 16:33:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 78/94] target/sparc: Move gen_fop_DDD insns to decodetree
Date: Sun, 22 Oct 2023 16:29:16 -0700
Message-Id: <20231022232932.80507-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Move FADDd, FSUBd, FMULd, FDIVd.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 +++
 target/sparc/translate.c  | 55 ++++++++++++++++++++-------------------
 2 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 09444e313f..a429c04980 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -249,9 +249,13 @@ FSQRTs      10 ..... 110100 00000 0 0010 1001 .....        @r_r2
 FSQRTd      10 ..... 110100 00000 0 0010 1010 .....        @r_r2
 FSQRTq      10 ..... 110100 00000 0 0010 1011 .....        @r_r2
 FADDs       10 ..... 110100 ..... 0 0100 0001 .....        @r_r_r
+FADDd       10 ..... 110100 ..... 0 0100 0010 .....        @r_r_r
 FSUBs       10 ..... 110100 ..... 0 0100 0101 .....        @r_r_r
+FSUBd       10 ..... 110100 ..... 0 0100 0110 .....        @r_r_r
 FMULs       10 ..... 110100 ..... 0 0100 1001 .....        @r_r_r
+FMULd       10 ..... 110100 ..... 0 0100 1010 .....        @r_r_r
 FDIVs       10 ..... 110100 ..... 0 0100 1101 .....        @r_r_r
+FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index c9fbfa6156..c38d09d34d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1656,21 +1656,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
     return 0;
 }
 
-static void gen_fop_DDD(DisasContext *dc, int rd, int rs1, int rs2,
-                        void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i64, TCGv_i64))
-{
-    TCGv_i64 dst, src1, src2;
-
-    src1 = gen_load_fpr_D(dc, rs1);
-    src2 = gen_load_fpr_D(dc, rs2);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src1, src2);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 #ifdef TARGET_SPARC64
 static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr))
@@ -4932,6 +4917,30 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
 TRANS(FALIGNDATAg, VIS1, do_ddd, a, gen_op_faligndata)
 TRANS(BSHUFFLE, VIS2, do_ddd, a, gen_op_bshuffle)
 
+static bool do_env_ddd(DisasContext *dc, arg_r_r_r *a,
+                       void (*func)(TCGv_i64, TCGv_env, TCGv_i64, TCGv_i64))
+{
+    TCGv_i64 dst, src1, src2;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src1 = gen_load_fpr_D(dc, a->rs1);
+    src2 = gen_load_fpr_D(dc, a->rs2);
+    func(dst, tcg_env, src1, src2);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FADDd, ALL, do_env_ddd, a, gen_helper_faddd)
+TRANS(FSUBd, ALL, do_env_ddd, a, gen_helper_fsubd)
+TRANS(FMULd, ALL, do_env_ddd, a, gen_helper_fmuld)
+TRANS(FDIVd, ALL, do_env_ddd, a, gen_helper_fdivd)
+
 static bool do_dddd(DisasContext *dc, arg_r_r_r *a,
                     void (*func)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
@@ -5009,31 +5018,23 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x45: /* fsubs */
                 case 0x49: /* fmuls */
                 case 0x4d: /* fdivs */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0x42: /* faddd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_faddd);
-                    break;
+                case 0x46: /* fsubd */
+                case 0x4a: /* fmuld */
+                case 0x4e: /* fdivd */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x43: /* faddq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_faddq);
                     break;
-                case 0x46: /* fsubd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fsubd);
-                    break;
                 case 0x47: /* fsubq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fsubq);
                     break;
-                case 0x4a: /* fmuld */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fmuld);
-                    break;
                 case 0x4b: /* fmulq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fmulq);
                     break;
-                case 0x4e: /* fdivd */
-                    gen_fop_DDD(dc, rd, rs1, rs2, gen_helper_fdivd);
-                    break;
                 case 0x4f: /* fdivq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_QQQ(dc, rd, rs1, rs2, gen_helper_fdivq);
-- 
2.34.1


