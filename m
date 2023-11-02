Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAB7DEA14
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYM-0005t5-0d; Wed, 01 Nov 2023 21:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXh-0005i9-IA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXe-0001ZF-Kw
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso466060b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888637; x=1699493437; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xjMvFL2z2wpGvo2uheuj7+QVB72Kx7UDQCtbmE9m1I0=;
 b=XcJ6O+/4CKBcEIm8XHkAJS86qRzJS6af1z+nwaFNB6+5wyZssVb49op/qUUyIYlerq
 uOHaUQIIf1N/TfuXrEqERV5dMOMr/cGeO1n5YvJKDSDeXImDB1ehuInyYKNMF6rCA/9M
 55m2RcbrfQXH4+MmkEBWXO8gdoNxX7wrKm2G0CzkE1WpKcIR1XAQOQGeUhpvtCp7FF92
 X68uACewmCEx0CbOwC5AO5/Gy6JiP9chb3ETxpOvY71Nm8eenzJVkJdbeZAQ92GgIx3u
 5+O3AU/OdAQhu0Q4kgGdy+iOK3HweiDNd88+IN5xLtMnGvD0xekiMVwwjTCezxG2Gszt
 FdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888637; x=1699493437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xjMvFL2z2wpGvo2uheuj7+QVB72Kx7UDQCtbmE9m1I0=;
 b=K07cTQkeFjD/lMOcFs3lQC25stdDd/EdvXLWTW4mrk2uZkdU0MhyexMQrYOxwmJbEu
 3rmL1h1eTzjgHj9iwxl7+hZCP6Ujy5Rt/8J8ukbccEeN5PXaV36w9k51d5uutSi1xZB9
 u1jvoIILBFqmJw2dxgfRpRCNQzoYan0wVk0zw1aY59hyceQ1nNkD1vtYqNgggj+zQ05m
 JmE4SYQyxvimk2Khxjaoaiz2Uu63l6ANUIgt2JAKW+WW2oG7lUezLWVURaQk1AzJdmx3
 fH45yAeKpBJa+cNbgO4H+YrIulF30JNYLKe4lG+JNecTXYDYXA2OY8yOLiSewOZMCyMv
 71dg==
X-Gm-Message-State: AOJu0YzuytMEnjoEVSZ6EzUzKwY2vbOiXenenJCaubjeuHBAxAM7XonL
 RlAfTOkrmE781em6aiBErqAtGb4fpjDy0cjPt1A=
X-Google-Smtp-Source: AGHT+IHfUsUhWYWRejX2zU3KWQx+xbCFMt7tAwKWlS1exXcfEhizN8BvxBM4SIB+URN4/fNKNzMMyw==
X-Received: by 2002:aa7:88cb:0:b0:6be:308:e61b with SMTP id
 k11-20020aa788cb000000b006be0308e61bmr18434471pff.10.1698888631060; 
 Wed, 01 Nov 2023 18:30:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 16/88] target/hppa: Fix do_add, do_sub for hppa64
Date: Wed,  1 Nov 2023 18:29:04 -0700
Message-Id: <20231102013016.369010-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


