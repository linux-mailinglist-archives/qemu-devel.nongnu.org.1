Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B317C8F77
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPmn-0003YS-84; Fri, 13 Oct 2023 17:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmF-0002Pp-Tv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:33:00 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPmE-0001au-1Z
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:59 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-58e119bb28eso2887653a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232776; x=1697837576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hHjsCaNNIUE4mjfrX1VgrhnCLgcLGBsr95uVt356Al4=;
 b=p+hNSQCRuurNGsiYxM+aaYji0oxeHcGY3njYwUE0BlD1nvy/TY4F3Mr1RvRIvJDP4G
 7VoKhM4vn/75eyKErUU9fq78cE7TY5GlBJpLQkzrSTCWc8oPEoh4DbeqIxfAtdZN1d0G
 vht7fSAXLjpbyAB8ECHLAW9Lw/mMI1lpcJ+AKgkv4S/rdeFmI4cMVOzIOSpYFqJQsPoX
 TZQXMSOkvx5rkXiWBuuuOxeGHvKPtYF29Af5Ipq1RrldMFQg7OcVGB4itBsDRPGNodvn
 T47rwlmhDW5MT7RkFlH1y9/iyqaqNAWXy8m10QFb1QsONFKj31JXatzTEjYmjvs8gdaE
 5ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232776; x=1697837576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHjsCaNNIUE4mjfrX1VgrhnCLgcLGBsr95uVt356Al4=;
 b=hv0BMyuki//z2tYES9FQPwkg6G/15edfkd6ofqDbezDacRkz/2cCUbopeFL8FXMxQT
 7I5ZtCTN3F3EDnnTiqzmr0sYbG0TYMG4cx11V68edE4XoKfa3rnAK4GDQ7zP+0SkJlp/
 meHUylyK79wG/5Etqh71Jw5ao293hpo4D3hNGMmpkuBT3CFoH5Ckp83t21+4o5pabG/Q
 rPzOVuPTKN+uwat7HVXCQTdIilJZOUUE4io/5Oe4BVvHg8QQaiiPgv5cePw7XA5YbXnk
 3upQYbJK9tLUN3h3oU0cExOVv/MMSgwmyfQ00SQuNq1VfQYmsN/osXTbCWc/fP67BZZ+
 Lm8g==
X-Gm-Message-State: AOJu0Yy2bE+992xffVJmKUXzvUIq9IrTZIqWLzbRr+eOO9Qt/FXE6k1/
 w4B5/rHKYob/ARxMtOttXhgq7A7p0PGssPXeAzc=
X-Google-Smtp-Source: AGHT+IFBvHowYrDI/2m1madi7VMYmTyqkgT0fvAn2NKuExlkKk6fvQu6EPAfK8UfQzTpYKs3vRRXwg==
X-Received: by 2002:a17:90a:b8f:b0:277:3565:30cf with SMTP id
 15-20020a17090a0b8f00b00277356530cfmr1935336pjr.6.1697232776548; 
 Fri, 13 Oct 2023 14:32:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 75/85] target/sparc: Move FqTOs, FqTOi to decodetree
Date: Fri, 13 Oct 2023 14:28:36 -0700
Message-Id: <20231013212846.165724-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
index 4368ac25a9..f38ea9b343 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -262,10 +262,12 @@ FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
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
index 1b1ac9b5f0..ee12a8b9b7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1541,20 +1541,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
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
@@ -4767,6 +4753,30 @@ static bool do_env_qq(DisasContext *dc, arg_r_r *a,
 
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
@@ -5048,11 +5058,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5069,10 +5077,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


