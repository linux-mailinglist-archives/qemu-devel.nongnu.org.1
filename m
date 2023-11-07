Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F77E3377
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COT-0006mX-EN; Mon, 06 Nov 2023 22:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO7-0006OP-6S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:30 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CO5-0000eh-90
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:22 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc394f4cdfso35676525ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326259; x=1699931059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xjMvFL2z2wpGvo2uheuj7+QVB72Kx7UDQCtbmE9m1I0=;
 b=jbz3z1fCFk/J+gLMNb/piKFGO5TA1VeKHnG0MoChMayh7z54k9frICr41Fx4eTlmf+
 2NrnUCyYkFcGkkJLei1DLv9d/FdavTZyPO/wYRpGgqbsCZ3/3d3/7jceCPypZhewNOkJ
 3FCHeyxRCjgieJtyZ6ePNDckPBI0+//mc4dsq2KKZh3AtBnBGPjGHEphWU2jAC2RtaOe
 PH+aBisHQasGGj7SWPUDHZwZ79T2QjUSf7UYuJ2VEkIVwSTdQF+emmYKPaH25hFqwfvF
 JvFRCsTLc9LwhprnphAmQGOIOkyn+LplaNQfmPayOIJDYV+J7JqjtYU/V/h+6FWgEWIM
 qkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326259; x=1699931059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjMvFL2z2wpGvo2uheuj7+QVB72Kx7UDQCtbmE9m1I0=;
 b=nM5kykBGn/MnrTXdePi9xJYvaRnwTfOeXwUiDkVXxsRNn0QLNhxqAN2tu5ZnvyvOl9
 hEv49/bZN0QwIWrCDCltRhqXxZveAXUyhmDRTndTbYbF4ACVazQ8vrbHrLi6/XQcise4
 QEb0Yf9YdD8Abawc5YBIGB+zPZK+lla8ZmcYojCxSTj4JH2SpZr3p1imgBRAdRx7rsha
 q6pxnSLFAKdzl6RidrfLojgM0fomFZlb3PIhOxQ20e44HyjWepDCr4GOC2lf1rawiqie
 50rZVUSGzicCejD/8ffdCwcltxTmFMycRry/M3qOUg+ZX3Ng84+okW7AGZX2+VBhHLEK
 cyOw==
X-Gm-Message-State: AOJu0YwnjOwH445qFt3mFI4YQf6LVWSui2i68Hn+pit57hYPJwVJJdJO
 m+c017khVzD10T07AxGD1246EZuFLuHwQzC1v+k=
X-Google-Smtp-Source: AGHT+IFuscRIAOWNfs7XVf+ffPgGdlzUnYan333wbJombTbt7LTGJAT909lXTfzp1pjhHUdY2oqHow==
X-Received: by 2002:a17:902:bb89:b0:1cc:7adb:16a5 with SMTP id
 m9-20020a170902bb8900b001cc7adb16a5mr12427661pls.13.1699326259503; 
 Mon, 06 Nov 2023 19:04:19 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/85] target/hppa: Fix do_add, do_sub for hppa64
Date: Mon,  6 Nov 2023 19:02:56 -0800
Message-Id: <20231107030407.8979-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 8ba95ae320..b0cd12a2d0 100644
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


