Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7417D79B8
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoAW-0006US-5h; Wed, 25 Oct 2023 20:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9j-0003Eq-TV
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:25 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9e-0008H7-Ej
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:23:23 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5b837dc2855so228072a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279797; x=1698884597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/fjzgfpQS9oPQQPd/gylCCDrHsUezvD1M5UxyFdfsBQ=;
 b=OKH/ojwifOY2iKhO2+CVn+m55IzO4yKpEEeeJ0uSi77nHinGw4USvow1AgGoh+w20h
 McgKWLHaE60+CkRB7EXBuCFOoTcc2XPmZOPTtv/ZDv7hveEMAQ+xds7UWk9OcRHMFqeM
 z2lM3sc7zAJnMDyBcBSIb9FvXqIwhxx3mfgrv6dU1wYsJgu6r0Do3MIJnKzRihfJRxLO
 XBi/RZn+mLHg0rr+XkRJZTBoU1UJtodWxfAfL5Tu0tzoTOmv2JXN21KMrJWXne9zP9Hl
 7V4I6fRAR3Ja0B0jIm0BmfN2tSDwjknM8JNmczw6tOrfY3+dVxM2rWHg6qTjG3ihrbUJ
 znHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279797; x=1698884597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/fjzgfpQS9oPQQPd/gylCCDrHsUezvD1M5UxyFdfsBQ=;
 b=IZpDN7/WQCHNc7Yi0XZgHtndbBdpVyZ8oyxduJE7tFflQSPabDpvYFUcOr2naGGCQD
 QeQzwtFRhZ+zVdAsPoQ8lm2T+gpgMsI9IFRIGdAQEwzuWyF9LDQXELtj6gKFws6Y5i90
 aPdz1jjs0BU5d0un8YdS+yIaAMBtGFtYqM1ERALPSlfExb+H0/ypQmgCVD19GTOXq/Wq
 YpFtvf8U4pUSRfErwM23UhrrsknMySD39v/O79OYhzVzuXY8/7ZRGcRYKUSET6Nx+cL3
 lJ6+Ry3J+THMiPvmShpOzfFP7S0PRI73R/mWVE8RZwrT8vwmvkmhpMS8o6gia5PzpVc5
 213g==
X-Gm-Message-State: AOJu0Yz2VjVxOtIL5WIujDRYDRqL7853BytPdAIanSytmotkkfTg1dCP
 6IzA72Uoh/UKCBdEg78ih/x+gqnpyjsyr1GoyZ0=
X-Google-Smtp-Source: AGHT+IFKJTWFZJPuFngqSrQHtDk5d8fXy9TxIFIWSU2LurBGw9PL5AAiaA1Vn+YE5ZPE8zrZ9/vwzg==
X-Received: by 2002:a17:90a:fb53:b0:27d:5568:e867 with SMTP id
 iq19-20020a17090afb5300b0027d5568e867mr1499468pjb.9.1698279796958; 
 Wed, 25 Oct 2023 17:23:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:23:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 86/94] target/sparc: Move FiTOq, FsTOq to decodetree
Date: Wed, 25 Oct 2023 17:15:34 -0700
Message-Id: <20231026001542.1141412-116-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 target/sparc/insns.decode |  2 ++
 target/sparc/translate.c  | 44 +++++++++++++++++++++------------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7b65b31f89..c76e603f2d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -273,6 +273,8 @@ FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_r2
 FiTOd       10 ..... 110100 00000 0 1100 1000 .....        @r_r2
 FsTOd       10 ..... 110100 00000 0 1100 1001 .....        @r_r2
 FqTOd       10 ..... 110100 00000 0 1100 1011 .....        @r_r2
+FiTOq       10 ..... 110100 00000 0 1100 1100 .....        @r_r2
+FsTOq       10 ..... 110100 00000 0 1100 1101 .....        @r_r2
 FsTOi       10 ..... 110100 00000 0 1101 0001 .....        @r_r2
 FdTOi       10 ..... 110100 00000 0 1101 0010 .....        @r_r2
 FqTOi       10 ..... 110100 00000 0 1101 0011 .....        @r_r2
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 39da3f1705..ad2d794b3d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1672,19 +1672,6 @@ static void gen_ne_fop_QQ(DisasContext *dc, int rd, int rs,
 }
 #endif
 
-static void gen_ne_fop_QF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_ptr, TCGv_i32))
-{
-    TCGv_i32 src;
-
-    src = gen_load_fpr_F(dc, rs);
-
-    gen(tcg_env, src);
-
-    gen_op_store_QT0_fpr(QFPREG(rd));
-    gen_update_fprs_dirty(dc, QFPREG(rd));
-}
-
 static void gen_ne_fop_QD(DisasContext *dc, int rd, int rs,
                           void (*gen)(TCGv_ptr, TCGv_i64))
 {
@@ -4803,6 +4790,29 @@ static bool do_env_dq(DisasContext *dc, arg_r_r *a,
 TRANS(FqTOd, ALL, do_env_dq, a, gen_helper_fqtod)
 TRANS(FqTOx, 64, do_env_dq, a, gen_helper_fqtox)
 
+static bool do_env_qf(DisasContext *dc, arg_r_r *a,
+                      void (*func)(TCGv_env, TCGv_i32))
+{
+    TCGv_i32 src;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+    if (gen_trap_float128(dc)) {
+        return true;
+    }
+
+    gen_op_clear_ieee_excp_and_FTT();
+    src = gen_load_fpr_F(dc, a->rs);
+    func(tcg_env, src);
+    gen_op_store_QT0_fpr(QFPREG(a->rd));
+    gen_update_fprs_dirty(dc, QFPREG(a->rd));
+    return advance_pc(dc);
+}
+
+TRANS(FiTOq, ALL, do_env_qf, a, gen_helper_fitoq)
+TRANS(FsTOq, ALL, do_env_qf, a, gen_helper_fstoq)
+
 static bool do_fff(DisasContext *dc, arg_r_r_r *a,
                    void (*func)(TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -5088,15 +5098,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0xd3: /* fqtoi */
                 case 0xcb: /* fqtod */
                 case 0x83: /* V9 fqtox */
-                    g_assert_not_reached(); /* in decodetree */
                 case 0xcc: /* fitoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fitoq);
-                    break;
                 case 0xcd: /* fstoq */
-                    CHECK_FPU_FEATURE(dc, FLOAT128);
-                    gen_ne_fop_QF(dc, rd, rs2, gen_helper_fstoq);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0xce: /* fdtoq */
                     CHECK_FPU_FEATURE(dc, FLOAT128);
                     gen_ne_fop_QD(dc, rd, rs2, gen_helper_fdtoq);
-- 
2.34.1


