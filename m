Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 078517CEAE1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESa-0001U0-U0; Wed, 18 Oct 2023 17:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESB-0000z2-Uq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:47 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESA-0004OE-5u
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:51:47 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1dd8304b980so4636093fac.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665904; x=1698270704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj5Zj+Bw57JH4E175sUuTw9SkCPkXc9sWUiIDH26gck=;
 b=qk2aoN7fFmPgsnPWRZCf58T0Ql4TMOdoXep+3P3YljWwveXOho3TkTiTRulA8guso0
 qeNk8JIyckDYB9CTx8oPclLtwPMXguY7a2t+XvuvnZjCfAYFMQ+6ynPkCM+XUL3RnrzZ
 SgA9R+JmcZEFeZAgzDDbXmG/8oYvkVcR5Agdc+WFjHfgvdF/ilYTPlbYSJaVr9Yj5NU8
 aI8TFA/8+zGAD/NH39BBNb9513E8Of+ZE5wkkgeeb6CTPDcsg9vhxGrWTCSVsseGb5Vl
 Y0ZKQszpC/Q3ctx2LzxcMyyfOndlclqLTqqDNOAhksYgjQPjNd2roUlYYp+/ErfQQikZ
 QQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665904; x=1698270704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vj5Zj+Bw57JH4E175sUuTw9SkCPkXc9sWUiIDH26gck=;
 b=JpvBnOdrzB8EAt43VuVltItJEmsW/nEKoIkLUBI5by8FMSFM4g7IVl0RNSQOI+ShIS
 Ir1zRCe7SQcYqw3fe8BhylTViOeGPfucjua3S/v4RjQub4FcBiBD7qTK8JO97/jPwggj
 o7vSITCxarZr0GWbCZro1Rsad+ao7oNSy0N82GW6aPRe531fVsjeIlRhNs+Xl6rRAQ/A
 YEjt4DRahbS3c71tvz8KwmEitRY0GxyAxGj3OEBbgUB3bEjZkRQ4nz2r9j09+EZq4ju8
 s4QVgrNTEIzJ+gaRTs8zTOPVrcXpYNd0z0oNKEAHFAifvQz4u8ucP6Cy1aF8KF/EtHuH
 EHKA==
X-Gm-Message-State: AOJu0Yz964iWVrd2q/t0DfR4/qaf8TjDVhR6k2Jf4qynkZ3Q8Qk4nYJW
 bXDCmGMXrliko/i1s/oSGM8Tk6aX5ZliYVPctn4=
X-Google-Smtp-Source: AGHT+IFFvHDe5GdkLcSPqu4syER2KKNUrOnM5S5I4vhUvz3MmdTZ/1s1nbt+4mW4ttniQTh+xk1VCA==
X-Received: by 2002:a05:6870:8294:b0:1c0:f8a7:ec14 with SMTP id
 q20-20020a056870829400b001c0f8a7ec14mr635442oae.57.1697665904345; 
 Wed, 18 Oct 2023 14:51:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 09/61] target/hppa: Fix do_add, do_sub for hppa64
Date: Wed, 18 Oct 2023 14:50:43 -0700
Message-Id: <20231018215135.1561375-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Select the proper carry bit for input to the arithmetic
and for output for the condition.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 50 ++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index fb7a295367..8ebe7523a7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1094,13 +1094,15 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    TCGv_reg in2, unsigned shift, bool is_l,
                    bool is_tsv, bool is_tc, bool is_c, unsigned cf)
 {
-    TCGv_reg dest, cb, cb_msb, sv, tmp;
+    TCGv_reg dest, cb, cb_msb, cb_cond, sv, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
+    bool d = false;
 
     dest = tcg_temp_new();
     cb = NULL;
     cb_msb = NULL;
+    cb_cond = NULL;
 
     if (shift) {
         tmp = tcg_temp_new();
@@ -1111,19 +1113,22 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     if (!is_l || cond_need_cb(c)) {
         TCGv_reg zero = tcg_constant_reg(0);
         cb_msb = tcg_temp_new();
+        cb = tcg_temp_new();
+
         tcg_gen_add2_reg(dest, cb_msb, in1, zero, in2, zero);
         if (is_c) {
-            tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cpu_psw_cb_msb, zero);
+            tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb,
+                             get_psw_carry(ctx, d), zero);
         }
-        if (!is_l) {
-            cb = tcg_temp_new();
-            tcg_gen_xor_reg(cb, in1, in2);
-            tcg_gen_xor_reg(cb, cb, dest);
+        tcg_gen_xor_reg(cb, in1, in2);
+        tcg_gen_xor_reg(cb, cb, dest);
+        if (cond_need_cb(c)) {
+            cb_cond = get_carry(ctx, d, cb, cb_msb);
         }
     } else {
         tcg_gen_add_reg(dest, in1, in2);
         if (is_c) {
-            tcg_gen_add_reg(dest, dest, cpu_psw_cb_msb);
+            tcg_gen_add_reg(dest, dest, get_psw_carry(ctx, d));
         }
     }
 
@@ -1138,7 +1143,7 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Emit any conditional trap before any writeback.  */
-    cond = do_cond(cf, dest, cb_msb, sv);
+    cond = do_cond(cf, dest, cb_cond, sv);
     if (is_tc) {
         tmp = tcg_temp_new();
         tcg_gen_setcond_reg(cond.c, tmp, cond.a0, cond.a1);
@@ -1192,6 +1197,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     TCGv_reg dest, sv, cb, cb_msb, zero, tmp;
     unsigned c = cf >> 1;
     DisasCond cond;
+    bool d = false;
 
     dest = tcg_temp_new();
     cb = tcg_temp_new();
@@ -1201,15 +1207,17 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     if (is_b) {
         /* DEST,C = IN1 + ~IN2 + C.  */
         tcg_gen_not_reg(cb, in2);
-        tcg_gen_add2_reg(dest, cb_msb, in1, zero, cpu_psw_cb_msb, zero);
+        tcg_gen_add2_reg(dest, cb_msb, in1, zero, get_psw_carry(ctx, d), zero);
         tcg_gen_add2_reg(dest, cb_msb, dest, cb_msb, cb, zero);
         tcg_gen_xor_reg(cb, cb, in1);
         tcg_gen_xor_reg(cb, cb, dest);
     } else {
-        /* DEST,C = IN1 + ~IN2 + 1.  We can produce the same result in fewer
-           operations by seeding the high word with 1 and subtracting.  */
-        tcg_gen_movi_reg(cb_msb, 1);
-        tcg_gen_sub2_reg(dest, cb_msb, in1, cb_msb, in2, zero);
+        /*
+         * DEST,C = IN1 + ~IN2 + 1.  We can produce the same result in fewer
+         * operations by seeding the high word with 1 and subtracting.
+         */
+        TCGv_reg one = tcg_constant_reg(1);
+        tcg_gen_sub2_reg(dest, cb_msb, in1, one, in2, zero);
         tcg_gen_eqv_reg(cb, in1, in2);
         tcg_gen_xor_reg(cb, cb, dest);
     }
@@ -1227,7 +1235,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     if (!is_b) {
         cond = do_sub_cond(cf, dest, in1, in2, sv);
     } else {
-        cond = do_cond(cf, dest, cb_msb, sv);
+        cond = do_cond(cf, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
 
     /* Emit any conditional trap before any writeback.  */
@@ -3019,18 +3027,24 @@ static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
                     unsigned c, unsigned f, unsigned n, int disp)
 {
-    TCGv_reg dest, in2, sv, cb_msb;
+    TCGv_reg dest, in2, sv, cb_cond;
     DisasCond cond;
+    bool d = false;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
     sv = NULL;
-    cb_msb = NULL;
+    cb_cond = NULL;
 
     if (cond_need_cb(c)) {
-        cb_msb = tcg_temp_new();
+        TCGv_reg cb = tcg_temp_new();
+        TCGv_reg cb_msb = tcg_temp_new();
+
         tcg_gen_movi_reg(cb_msb, 0);
         tcg_gen_add2_reg(dest, cb_msb, in1, cb_msb, in2, cb_msb);
+        tcg_gen_xor_reg(cb, in1, in2);
+        tcg_gen_xor_reg(cb, cb, dest);
+        cb_cond = get_carry(ctx, d, cb, cb_msb);
     } else {
         tcg_gen_add_reg(dest, in1, in2);
     }
@@ -3038,7 +3052,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_add_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_cond(c * 2 + f, dest, cb_msb, sv);
+    cond = do_cond(c * 2 + f, dest, cb_cond, sv);
     save_gpr(ctx, r, dest);
     return do_cbranch(ctx, disp, n, &cond);
 }
-- 
2.34.1


