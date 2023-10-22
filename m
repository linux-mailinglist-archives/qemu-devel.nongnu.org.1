Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A85F57D2163
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:12:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRbV-0004wR-6k; Sun, 22 Oct 2023 02:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaM-0002Ur-To
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:14 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRaK-0002PK-20
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:05:14 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso1659090b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954708; x=1698559508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKFFFf4efePSH6sF6nnca+VgvTu6GHbtsFBpYuPsvcQ=;
 b=ts4WQvFQm9AJdOUuCbl7s4kV4QC0ZPI7oqOauTwXKmqJ6QG4TX36GAJpirupjARfnm
 Dv3h79GnnbxTbSu+KDmlMVVNkoXyBRK92ANyT2qs6aiire7ikRfaxIRiUnNS9LF86nzB
 dlJHOfFUP8090rjQDqnpZXC6k157ZhucK1kTaD5f+eCTsjZCQbPJ2yE5FAEtTzJWCvQ/
 p83Tf7LREiCzoGg+75SpSkIXMGpYwknSeWtMGkI3vHD3s/+PnvOf/bQJQ5xRkgf1l5r+
 s0HSjohb7o1B1GK9GbzdZPrM08iOiVs2+LNrUokaifFZJBaTN7way18pUY3fPSrDojKh
 W0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954708; x=1698559508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CKFFFf4efePSH6sF6nnca+VgvTu6GHbtsFBpYuPsvcQ=;
 b=m2TrQ5XCKwRaQKJDKzT5RIDZKTfGt02jzNN478wbfzNE1ZzDCuAvoPR1B6iu99e8S3
 Gys5XJcl0gZxXHhIOmzP0qxtoWUEvHOvjd2f10qTdQQ7NhTkbohy4O35mB0HHDDQ89Jl
 UL99Oz2GEW3BhfCUWPGUAqF/Rg2D3gkeIFMnFjbzd26XJ9iuWz2Goo7sr/tF5RZELI7J
 sDB5S89wjGlRt4IsDiMm8SeiYbN/Bxi2Jdp5jo/0+ac+QgTfilfE52UFwX65+k9aAhim
 PU81JZmtgYgOPBD8y5aZ32xZfrcxN76DTOcl7q4c1AN/MG7vfrzeqAZJheeJxGNlY8XM
 Jdww==
X-Gm-Message-State: AOJu0Yx8Zm+1cfhlyW1F/NQ3u7jaBPokLz9EPqSLtUKrFM08TcWKESW0
 c+3pRWfX2ls1/THFVmaJQ3EaFQnAOxwE/AHhTR4=
X-Google-Smtp-Source: AGHT+IGHQRMhdRI6imLioNkxsqDwbLYfVz3+mb9GkMO8HF88P/2Y/AWzhBe39SvnZMi02qBZZcK+4A==
X-Received: by 2002:a05:6a00:150a:b0:68e:3772:4e40 with SMTP id
 q10-20020a056a00150a00b0068e37724e40mr4980549pfu.3.1697954708333; 
 Sat, 21 Oct 2023 23:05:08 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:05:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 79/90] target/sparc: Move FiTOd, FsTOd, FsTOx to decodetree
Date: Sat, 21 Oct 2023 23:00:20 -0700
Message-Id: <20231022060031.490251-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Note that gen_ne_fop_DF was incorrectly named and does pass env.
The two sets of helpers should have been unified.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  3 ++
 target/sparc/translate.c  | 67 ++++++++++++++++-----------------------
 2 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index faf2bcef83..ee9262061b 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -262,11 +262,14 @@ FDIVd       10 ..... 110100 ..... 0 0100 1110 .....        @r_r_r
 FDIVq       10 ..... 110100 ..... 0 0100 1111 .....        @r_r_r
 FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
+FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
+FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
+FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eb66f25a65..5630dd24f0 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -54,6 +54,7 @@
 #define gen_helper_saved                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
@@ -1667,37 +1668,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-#ifdef TARGET_SPARC64
-static void gen_fop_DF(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-#endif
-
-static void gen_ne_fop_DF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i64, TCGv_ptr, TCGv_i32))
-{
-    TCGv_i64 dst;
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env, src);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_fop_FQ(DisasContext *dc, int rd, int rs,
                        void (*gen)(TCGv_i32, TCGv_ptr))
 {
@@ -4929,6 +4899,29 @@ TRANS(FSQRTd, ALL, do_env_dd, a, gen_helper_fsqrtd)
 TRANS(FxTOd, 64, do_env_dd, a, gen_helper_fxtod)
 TRANS(FdTOx, 64, do_env_dd, a, gen_helper_fdtox)
 
+static bool do_env_df(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env, TCGv_i32))
+{
+    TCGv_i64 dst;
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    dst = gen_dest_fpr_D(dc, a->rd);
+    src = gen_load_fpr_F(dc, a->rs);
+    func(dst, tcg_env, src);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FiTOd, ALL, do_env_df, a, gen_helper_fitod)
+TRANS(FsTOd, ALL, do_env_df, a, gen_helper_fstod)
+TRANS(FsTOx, 64, do_env_df, a, gen_helper_fstox)
+
 static bool do_env_qq(DisasContext *dc, arg_r_r *a,
                        void (*func)(TCGv_env))
 {
@@ -5228,17 +5221,14 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xc6: /* fdtos */
                 case 0xd2: /* fdtoi */
                 case 0x84: /* V9 fxtos */
+                case 0xc8: /* fitod */
+                case 0xc9: /* fstod */
+                case 0x81: /* V9 fstox */
                     g_assert_not_reached(); /* in decodetree */
                 case 0xc7: /* fqtos */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_FQ(dc, rd, rs2, gen_helper_fqtos);
                     break;
-                case 0xc8: /* fitod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fitod);
-                    break;
-                case 0xc9: /* fstod */
-                    gen_ne_fop_DF(dc, rd, rs2, gen_helper_fstod);
-                    break;
                 case 0xcb: /* fqtod */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
@@ -5272,9 +5262,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x81: /* V9 fstox */
-                    gen_fop_DF(dc, rd, rs2, gen_helper_fstox);
-                    break;
                 case 0x83: /* V9 fqtox */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-- 
2.34.1


