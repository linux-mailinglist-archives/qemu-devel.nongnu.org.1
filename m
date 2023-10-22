Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F247D218C
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdX-0006oq-6x; Sun, 22 Oct 2023 02:08:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdR-0006Oh-KE
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdD-00035S-G5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1764550b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954890; x=1698559690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k6ZWMTynXcmQhzUUaDVajkzlr4pmWr9Um9ZbZoPbXHM=;
 b=XjPBV5tuuKids9kGovcmHo1nkBpgGlIqYGHGc+7Et8pSZ6T0vZaQQ4JSNRdbOfA4AV
 ijHAa7bFpO+3v5hIbM73IJ0Cyju4Qid9NPANG0QSXx6A3YgkoxlLTzcwAXYjwZBba6Ia
 9Tg7DKJROWg/94ebUqueoeTcqb6tRstEAmOlzidg95CjLoG3D4B0ZR4VJNu92gFXDl0d
 WcZ4kAmkIm3ORo6XSDgydr7F+0k+x0bDZWy5Dn/rPWjAVXeN3GYaDAT8nD0EVTSOIr11
 Y+6l4wiZ+S4VyQQMXR05y4GRKQeAYEe5mWip7wJQaimps+fjuRVt7Yl2QdvJ4Nue2F+u
 ywgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954890; x=1698559690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k6ZWMTynXcmQhzUUaDVajkzlr4pmWr9Um9ZbZoPbXHM=;
 b=DYICcEY4zaj9eTuayyzfnre2fjis1ds0MPaEcfIYJVJtYtd9yLNo8i+tGz9PZyoOFd
 N+FstGWI8KmOUtO6W2Gq7rYpl6eoVEirfCYj8SoOxAO+43CmbIk8vwN8aYAje0VInGJF
 yfJ0P40nOhaHqbH9sW4f83YBI9MHFkuumJ8Mu6GlG2crphCsZSA9+zIFoypQlafPRGkV
 fCfyqXtFfslHc3A7cXeuWDJvk8c5dgzcDG3Evm4DMj54Vyp5kyBeJqWoyeXiw3pua591
 ffvE+YBmlE0n0IxbygauVZjkxWC2T9uOH1j3LgGre1G0Ut6iZd/eHlNp58P9vSCjydSn
 NXgg==
X-Gm-Message-State: AOJu0YwMHLO9zdiEAmHWD4s4dXr04UtxFQeY3UMrCN86V6YZBwUG9U0s
 s6sF5WPl2sSR6wC0KTqwkpOjHsd7enWhMaqzBRY=
X-Google-Smtp-Source: AGHT+IHjuj6zySBBErE16GbJXJMjllUYPhKIqg7SAH/QVr+YCUF/w6Ovim7AfetvdibPgBlV4/Qscw==
X-Received: by 2002:a17:903:41c4:b0:1ca:e05a:93a2 with SMTP id
 u4-20020a17090341c400b001cae05a93a2mr491532ple.32.1697954889402; 
 Sat, 21 Oct 2023 23:08:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 80/90] target/sparc: Move FqTOs, FqTOi to decodetree
Date: Sat, 21 Oct 2023 23:00:21 -0700
Message-Id: <20231022060031.490251-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 48 +++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index ee9262061b..33f0c738e6 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -268,10 +268,12 @@ FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
+FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5630dd24f0..e0d5f01887 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1668,20 +1668,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr))
-{
-    TCGv_i32 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i64, TCGv_ptr))
 {
@@ -4943,6 +4929,30 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
 TRANS(FSQRTq, ALL, do_env_qq, a, gen_helper_fsqrtq)
 
+static bool do_env_fq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env))
+{
+    TCGv_i32 dst;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    gen_op_load_fpr_QT1(QFPREG(a->rs));
+    dst = gen_dest_fpr_F(dc);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
+TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5224,11 +5234,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc8: /* fitod */
                 case 0xc9: /* fstod */
                 case 0x81: /* V9 fstox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
-                    break;
+                case 0xd3: /* fqtoi */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5245,10 +5253,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd3: /* fqtoi */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
-                    break;
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
-- 
2.34.1


