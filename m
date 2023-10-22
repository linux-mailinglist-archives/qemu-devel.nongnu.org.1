Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C864A7D2188
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:16:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdT-0006PY-48; Sun, 22 Oct 2023 02:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdP-0006Hb-QP
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:23 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdH-00035x-IR
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:23 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so12920155ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954892; x=1698559692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdlq9ySgTJbA8I7iN++KlU5WoLHtRW8xODa9W7sCPyQ=;
 b=RZrwcbjWWlqgnUn8Qv9wXjeMWo3T/zcO3gbcle4L93o+Yp2fdgA5x1YVmlLAawd5fu
 7ov5rWAsCvxwrNC8wqIMwelz7eAZA0ns8cqWCwoezyCqFRFYuBZ25aGNQNRttXCAuibJ
 fUD9lAaSEQhlFqnjrpRNDA+1iytKiQn1MkE1opGeOoTgBxHtLB8DjqgKfu2A7+o3sE94
 Wp4hFjsJuQNLbLS4cmW4DeHSuuTC8c2dYj0UMivD9dM1REX2LAdR+5uYcy5rH+06l7hk
 e1aDxw2IGToIlwK4BhfJnClzRYngBeJHVyYUIs9NCXkt3oUP8ivBXL27VI/mpAU+44fy
 uj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954892; x=1698559692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jdlq9ySgTJbA8I7iN++KlU5WoLHtRW8xODa9W7sCPyQ=;
 b=JBv9IbBeah/FJfxDfUx7iXlqyMLJpDWZ9178z+hcdm6sgwHv/oZFEnxYcmg377rDlT
 p48AOhK6/q8qzFZeULDRDY+2VB7JUahiaDyiidKLNRKjzOXsdz+br3qXSEgquqTgRkK5
 Fs6KpeIByZRUaiJRRia1P1vaVvXTDHAs6wXR3hJpUztt0DvW+21awM5WmEyIzVDB9oNz
 DvD8y2rUzBhUThz8BF+0lGuwTHs9TezuUdE6pDaBUHHt5WT2zHVpTE8iXEAf7f9JIAe+
 4pSQvX3got7aR5hV8o0lfFK2EIAQ0nIr/L5X0EnGsT17/m8Zmde1abeNX4YaG+yjmcq6
 EQIw==
X-Gm-Message-State: AOJu0Yx3AtpLDzFfXc9Nxa6DA6aiusUENlD62PmLTuKhqo3X0bKS7mYp
 oOrqpk+8DJ5eh2QXBxtVp6T3wYEAU2DahxcP37I=
X-Google-Smtp-Source: AGHT+IGEXIx5MqlhjVrcIfV09WA79DZ2+rBx2E09m49zoRiO7E0J3B522+Yj4CT43speKm+w31lGuA==
X-Received: by 2002:a17:903:2301:b0:1ca:811e:dcf7 with SMTP id
 d1-20020a170903230100b001ca811edcf7mr5104033plh.31.1697954892099; 
 Sat, 21 Oct 2023 23:08:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 83/90] target/sparc: Move FdTOq, FxTOq to decodetree
Date: Sat, 21 Oct 2023 23:00:24 -0700
Message-Id: <20231022060031.490251-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/sparc/translate.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 28 insertions(+), 21 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index c76e603f2d..e1f5394d17 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -267,6 +267,7 @@ FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
 FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
+FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
 FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
@@ -275,6 +276,7 @@ FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
 FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
+FdTOq       10 ..... 110100 00000 0 1100 1110 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f2b7fec72a..9c03252985 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -58,6 +58,7 @@
 #define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fxtoq                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
 #define gen_helper_fabsd(D, S)          qemu_build_not_reached()
 #define gen_helper_done(E)              qemu_build_not_reached()
@@ -1669,19 +1670,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i64))
-{
-    TCGv_i64 src;
-
-    src = gen_load_fpr_D(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -4974,6 +4962,29 @@ static bool do_env_qf(DisasContext *dc, arg_r_r *a,
 TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
 TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
 
+static bool do_env_qd(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i64))
+{
+    TCGv_i64 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_D(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FdTOq, ALL, do_env_qd, a, gen_helper_fdtoq)
+TRANS(FxTOq, 64, do_env_qd, a, gen_helper_fxtoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5261,11 +5272,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x83: /* V9 fqtox */
                 case 0xcc: /* fitoq */
                 case 0xcd: /* fstoq */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-                    break;
+                case 0x8c: /* V9 fxtoq */
+                    g_assert_not_reached(); /* in decodetree */
 #ifdef TARGET_SPARC64
                 case 0x3: /* V9 fmovq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
@@ -5279,10 +5288,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x8c: /* V9 fxtoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-                    break;
 #endif
                 default:
                     goto illegal_insn;
-- 
2.34.1


