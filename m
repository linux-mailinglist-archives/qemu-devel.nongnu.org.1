Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 982237D79B2
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:41:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoA1-0003pd-02; Wed, 25 Oct 2023 20:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9f-00030r-Eu
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:20 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9Z-0008Fi-R1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:19 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27cfb84432aso240097a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279791; x=1698884591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=llQJzbUwM11Tola+ykfL4GeM3KHqjJx/kOe5B4gTN/o=;
 b=VlTYy12WC47e+z9K/+Fwn1TP665jxWaUUIU/PcwdsxXi6yqmpL6WpDnSsjiJ/47xxf
 H3zFKeoEsE6pWO28OF6H9cRhnhfxbakWsog2JAEn4msgxswwX5EPqsfCp2jkjROIHUxd
 dpuRzBnZliL0sCpRLhlj+gX0b6xDxCTIlc5V8AFhRW3P8Mlr5+21kNXIg4T896PRAV4d
 eOeIg1md0uks3NY0Pn6pT5dZUkXQHNmFSWSKh8PWj2tdhdGg5vyO/q+Df4wTAeS+rWEQ
 o95IYwN2DJF/JGISikGvbPaiIey4AEOSrj21Pwc5OqnkxMbU9VcShyUE78HxLdPir4cR
 iOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279791; x=1698884591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=llQJzbUwM11Tola+ykfL4GeM3KHqjJx/kOe5B4gTN/o=;
 b=kRVFUjHS8k34+BbF25GI4kBZU+YQ8ZRIQCrcJnLx2pZ0LPVX1sSEQrfUiYhPqUyuCV
 k4o/KNC732mxpG+UYiNyzgCY/rxinER4tQlttosDcQWZZuKbceSgXwAVm2pqW0Bnvz7M
 BgGkgOqV4krwQf2AOohSOpXfXA3242x2S+ayHgFtNpHjoia6UsaNBrIVeZ8AXehB4K9h
 jquxfB8zyUQMM5dAoJWTuSgXlIrkKbzN9T7aylkKJSOhboKIMh+T9262xqFhaZi7IhrW
 Pk4O1L103QZs5YvUWry537LA3GfJEUmdT1DRknHStORsNUr4//UN5xFgibal7rvCsDQy
 vQ+g==
X-Gm-Message-State: AOJu0YzyCzOeYWBmreu5QAMwhNbNlzRp2gz74lyuMzylJTE21la7xv3d
 tgcjmc1RRIlCGOMLXprof7UJaPrelHLgNCcZy3U=
X-Google-Smtp-Source: AGHT+IEQ7MMagzWEmxtdEP0KRRwG7pjit8T6tNOJrK1wzQCmwq6ltkFuJYC2aV9DdcZEYASGaJmgAg==
X-Received: by 2002:a17:90b:1c82:b0:27f:df1e:198e with SMTP id
 oo2-20020a17090b1c8200b0027fdf1e198emr3162634pjb.26.1698279791336; 
 Wed, 25 Oct 2023 17:23:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 78/94] target/sparc: Move gen_fop_DDD insns to decodetree
Date: Wed, 25 Oct 2023 17:15:26 -0700
Message-Id: <20231026001542.1141412-108-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
index d2205f7e7d..e2bcb3c7b1 100644
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
@@ -4935,6 +4920,30 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
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
@@ -5012,31 +5021,23 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


