Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D505D7D217D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbT-0004tV-HJ; Sun, 22 Oct 2023 02:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaJ-0002Dc-32
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:12 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaE-0002Ku-Hm
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:08 -0400
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce2988d62eso1493431a34.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954704; x=1698559504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iLY1nbBi2JSUWZ6aOE4fru7zD1vQTmHSnEgemsvB5Y=;
 b=NvpIw5B7WJYkYnDonciwXimTUrVdLlBzr0BKRHdGwOzJQ/XJsIqF88XoT8zcLIp5m1
 B/OB7S66+32f8iyU7b8JX7g7hTnWst6xCGGT6visliRDC35Ken6b62VTx9I5XILNglUz
 vQ4LQk28vdxDpqtmp1vqPHdHXN4FhBKBE+o7U61yoRurRgSaPIQ/sE2/8cnGhnAO19jW
 fp/l8Hxz+L9TY1kbEAx0VP6N1B3MWrA6Qgd60UXdfVEI9mLcoaVJ+w0sUwI4PsuOtHjZ
 0fk8ky0sCyE9Hc0WV6XjdnYMBYgHlERYFjYkFWMv062CuPkhK0Y78IkIreEkZbPpszJz
 a/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954704; x=1698559504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iLY1nbBi2JSUWZ6aOE4fru7zD1vQTmHSnEgemsvB5Y=;
 b=NvpA8yMfALFblqWQ4be2MYFWGs/iKyJaG+cxOpw+D/fkJIikG8bS9PYiB2mYzcBvW6
 hnKDh8uIhTxjOEdpvVmZSgGqhCApl1f962Txs9UV0bqbGOCztpeosew0NkKfpod9pBmD
 0yX/283LICmXfpsYEw97SSz7zS7Jl+2h6vS3l792qMJKKSLYmOMBCalpt/p5fZQmA1q1
 tcmzdXSVtWD9oRqMtgJ0kzSE1rz21WmptPLagJSAHrX9VqBiXvoA0gLVJ1JJv9Stmr6p
 8BbCaLvwGWiwor/omaytt88RJ/FJneu+lk4vHlq7iAqitLc/Mkj50wHLI19S6rkeFVJO
 /KKA==
X-Gm-Message-State: AOJu0Yzt2bMw7vZe2w1KJdDVaZnh/JAAaAniqIZ/tmEoZkdaZeuhrEmH
 HXQSAYUVTkkh0XcVJ+Ee5JkrQz8kj4+q6l4hAIw=
X-Google-Smtp-Source: AGHT+IHuy2Ozm+pNiaIH8Vq0JNN51b7a5CPrZV3cVcR5FTRzeQc/3YNApsya2gazebMuI8Z6zEeObA==
X-Received: by 2002:a05:6358:9895:b0:140:fbfe:d941 with SMTP id
 q21-20020a056358989500b00140fbfed941mr7907096rwa.20.1697954704072; 
 Sat, 21 Oct 2023 23:05:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 74/90] target/sparc: Move gen_fop_DDD insns to decodetree
Date: Sat, 21 Oct 2023 23:00:15 -0700
Message-Id: <20231022060031.490251-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x333.google.com
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
index 1bcdaf31d8..7e0990a021 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1653,21 +1653,6 @@ static int gen_trap_ifnofpu(DisasContext *dc)
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
@@ -5096,6 +5081,30 @@ TRANS(FPACK32, VIS1, do_ddd, a, gen_op_fpack32)
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
@@ -5173,31 +5182,23 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


