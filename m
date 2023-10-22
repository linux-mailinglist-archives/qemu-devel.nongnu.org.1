Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE37D214B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbS-0004rk-03; Sun, 22 Oct 2023 02:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaM-0002Ta-QK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:14 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaJ-0002Lt-9S
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:13 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b26a3163acso1594192b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954707; x=1698559507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ABeqit4PGf6JPZHEITpYHYWXwnUNT03h3HPbEbGAqCg=;
 b=cOyEbmlVBXtjGhqOF7oo882dREqGpL5+i8ABpn4v1lhXATFBIXqQA8p9ipniMqmxK0
 GVreoW+HpiCnRIk3Mzd7Rq91OtYrTusHuqg/86Zv2CoduDDDn5fepSsqTNIBeL+GTrcW
 YoPzlG2c251BDytKpdLPBy5luM79Qi5bf2j4h/6fYeUA4TJbt/AExAGZfRSqHHuMl9sA
 unYzjlecpcTYdJjlNznykcE/K55tHxruxWlMsQg1qJroQHYXY20IDV/Jy4XTVS7Rd7EW
 0dv6vqyLuhnqaOnbz4W8hSALKzc5a0JaewgZcM5Osk2al/YUZF0rhNBKbvp3aIGMFhcq
 x2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954707; x=1698559507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABeqit4PGf6JPZHEITpYHYWXwnUNT03h3HPbEbGAqCg=;
 b=gSS1mfX0dOH5DBqsXfyR6ju35Ws10AbCMMl12ONCdjnfHXbyCj6XuWX9JW6UosEzO5
 9UegrTFji3JC7HzE92GkFsQkwwjFz6hy/CiogTkQbp5RZMk2eMZYPKnYdhdHo8QuSeV4
 P+Q267gw9A5pKhH6+XdyXMLUtk9LiEWVSNjF0De1q9rRWZnETkl0aHOYhty5fEwG28oC
 zM/Ij9eCR0pV5vHIrWwxTNk5J4Ai3EAgS8JsM4nLDyfN/ayTHdrC6QeoGZkZx0dFJZKp
 4+GYB6vcBNWFgeCQLkIWX+3Hlw1jH4SFqXLRTEEc3WCd3m1kYAZhmZn5qnV2+Z141KTp
 H3dA==
X-Gm-Message-State: AOJu0YwRBt9UWLKzyI9cvmm6K1Bfm46pXEaHaYG5izPuBXySQ7MvOm0x
 efnrdGycw3ZAVXbS8h6x/qDXv4uUDGlpZNdy4kg=
X-Google-Smtp-Source: AGHT+IHI4lGegKA4MebqGNLtAf3sQgZKvuEHX/TR1D1a/zLsi3JJceqANOB2NwgmzsJcjCh31nS7BA==
X-Received: by 2002:a05:6a00:194c:b0:6b7:18c1:c09a with SMTP id
 s12-20020a056a00194c00b006b718c1c09amr4376912pfk.5.1697954707539; 
 Sat, 21 Oct 2023 23:05:07 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 78/90] target/sparc: Move gen_fop_FD insns to decodetree
Date: Sat, 21 Oct 2023 23:00:19 -0700
Message-Id: <20231022060031.490251-79-richard.henderson@linaro.org>
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

Move FdTOs, FdTOi, FxTOs.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 +++
 target/sparc/translate.c  | 51 +++++++++++++++++++++------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a19d191603..faf2bcef83 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -263,9 +263,12 @@ FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
+FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
+FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
 {
   [
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 6a7788133a..eb66f25a65 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,7 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1697,21 +1698,6 @@ static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_D(dc, rd, dst);
 }
 
-static void gen_fop_FD(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i64))
-{
-    TCGv_i32 dst;
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4876,6 +4862,29 @@ TRANS(FSQRTs, ALL, do_env_ff, a, gen_helper_fsqrts)
 TRANS(FiTOs, ALL, do_env_ff, a, gen_helper_fitos)
 TRANS(FsTOi, ALL, do_env_ff, a, gen_helper_fstoi)
 
+static bool do_env_fd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i32, TCGv_env, TCGv_i64))
+{
+    TCGv_i32 dst;
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_F(dc);
+    src = gen_load_fpr_D(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_F(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FdTOs, ALL, do_env_fd, a, gen_helper_fdtos)
+TRANS(FdTOi, ALL, do_env_fd, a, gen_helper_fdtoi)
+TRANS(FxTOs, 64, do_env_fd, a, gen_helper_fxtos)
+
 static bool do_dd(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i64, TCGv_i64))
 {
@@ -5216,10 +5225,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x4f: /* fdivq */
                 case 0x69: /* fsmuld */
                 case 0x6e: /* fdmulq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xc6: /* fdtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtos);
-                    break;
+                case 0xd2: /* fdtoi */
+                case 0x84: /* V9 fxtos */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
@@ -5246,9 +5255,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
                     break;
-                case 0xd2: /* fdtoi */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fdtoi);
-                    break;
                 case 0xd3: /* fqtoi */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtoi);
@@ -5273,9 +5279,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
                     break;
-                case 0x84: /* V9 fxtos */
-                    gen_fop_FD(dc, rd, rs2, gen_helper_fxtos);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


