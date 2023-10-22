Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0337F7D216B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:13:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdR-0006Jo-JG; Sun, 22 Oct 2023 02:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdO-00067u-1I
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:22 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdD-00035Y-GO
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:21 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2b1ae4c21so1677733b6e.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954890; x=1698559690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2h7nOSdKbn+qf684EsPSz1FDCTilXbAvf6WAk/B9s4E=;
 b=F8tY8hB9QAKG4xU1hB82D/itxnyKw7ON5uPsFSpR6Gl97yxjNua5CI/BbQ27ZbpJya
 9Nj/oYdl6tll3iB9MpWR7+jyJRFOGIN60dn9TAH34zqh3iZCcPn29v+0zVfbtKr79fzj
 ryRh4C1PZIyNMQCyItO5nteNWfimhozdm3OsCO0wjniZ7gBtc47sfC26eM87cTEc2P1n
 1jQm52z5WJIIlNsYfh1975kT5kF+uZeOwtT4CLrNtkUNhvaLbdb6a1o4v4B9eFgLW51h
 rvmXLGOk1kYS5tQ2444VbBg2Vy7mufo1Zq0xzaJUcNb6Av/Ns3uO3ym0XMHsbWtihnoZ
 /EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954890; x=1698559690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2h7nOSdKbn+qf684EsPSz1FDCTilXbAvf6WAk/B9s4E=;
 b=sRbmbO/7p1XhzYjQ8ruA6FL6FwzuhM2UukFv6091cjTqbqf/8DofcWzIfw8AyzX/MO
 VLbcuyhcqJj64YrbyhxCeWBtU/fwqhlzffZSj0job84GuhrJVClCrPMP7Fzp1Gkfm+FR
 3XYddMWC7Xf1B2pDXhF0zccLQ2sGslB0k6/m96YBLmiWMNbx6tAbqp+Ss4Ymk779Ag9t
 PfFZkBd/QEvVVsuiXYku5jkNVAmsG8QWjHSHLrWpGUJSHbSbXL3GFZ4tvSD2V/YpZslE
 vimYtJrIRY3nce/vyzUoH0+hrhA3huRNuGSFZyunjxSZH0SV25xufMGWRMtv7oR4XZLN
 utYA==
X-Gm-Message-State: AOJu0YzpFC+889lVreM6wOMMloCCSVjXuL8Ql8ooXFT2prhRsLD9Rf1J
 Xi1+IXOXHCeLDdQWktU9YQubAc1B+iZmIZ9377Q=
X-Google-Smtp-Source: AGHT+IGexN5kZLzpSHWdj0I/aTaQhCQtgQ2ds7DBVuLy4Q3jbWLiCLBnF4s1O6oJZ6hz26NqvSy+vg==
X-Received: by 2002:a05:6808:2d1:b0:3ae:3d0:d74a with SMTP id
 a17-20020a05680802d100b003ae03d0d74amr6862299oid.52.1697954890341; 
 Sat, 21 Oct 2023 23:08:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 81/90] target/sparc: Move FqTOd, FqTOx to decodetree
Date: Sat, 21 Oct 2023 23:00:22 -0700
Message-Id: <20231022060031.490251-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
 target/sparc/translate.c  | 49 +++++++++++++++++++++------------------
 2 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 33f0c738e6..7b65b31f89 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -264,6 +264,7 @@ FsMULd      10 ..... 110100 ..... 0 0110 1001 .....        @r_r_r
 FdMULq      10 ..... 110100 ..... 0 0110 1110 .....        @r_r_r
 FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
 FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @r_r2
+FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @r_r2
 FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
 FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @r_r2
 FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
@@ -271,6 +272,7 @@ FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_r2
 FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
+FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e0d5f01887..6d3b0d6ce1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -55,6 +55,7 @@
 #define gen_helper_restored             ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fdtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fstox                ({ qemu_build_not_reached(); NULL; })
+#define gen_helper_fqtox                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtod                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fxtos                ({ qemu_build_not_reached(); NULL; })
 #define gen_helper_fnegd(D, S)          qemu_build_not_reached()
@@ -1668,20 +1669,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_fop_DQ(DisasContext *dc, int rd, int rs,
-                       void (*gen)(TCGv_i64, TCGv_ptr))
-{
-    TCGv_i64 dst;
-
-    gen_op_load_fpr_QT1(QFPREG(rs));
-    dst = gen_dest_fpr_D(dc, rd);
-
-    gen(dst, tcg_env);
-    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
-
-    gen_store_fpr_D(dc, rd, dst);
-}
-
 static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i32))
 {
@@ -4953,6 +4940,30 @@ static bool do_env_fq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOs, ALL, do_env_fq, a, gen_helper_fqtos)
 TRANS(FqTOi, ALL, do_env_fq, a, gen_helper_fqtoi)
 
+static bool do_env_dq(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_i64, TCGv_env))
+{
+    TCGv_i64 dst;
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
+    dst = gen_dest_fpr_D(dc, a->rd);
+    func(dst, tcg_env);
+    gen_helper_check_ieee_exceptions(cpu_fsr, tcg_env);
+    gen_store_fpr_D(dc, a->rd, dst);
+    return advance_pc(dc);
+}
+
+TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
+TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5236,11 +5247,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x81: /* V9 fstox */
                 case 0xc7: /* fqtos */
                 case 0xd3: /* fqtoi */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcb: /* fqtod */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtod);
-                    break;
+                case 0x83: /* V9 fqtox */
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
@@ -5266,10 +5275,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QQ(dc, rd, rs2, gen_helper_fabsq);
                     break;
-                case 0x83: /* V9 fqtox */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_fop_DQ(dc, rd, rs2, gen_helper_fqtox);
-                    break;
                 case 0x8c: /* V9 fxtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fxtoq);
-- 
2.34.1


