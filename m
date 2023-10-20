Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A277D176C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLs-0007pG-JI; Fri, 20 Oct 2023 16:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLU-0007jO-Dj
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:51 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLQ-0008A0-DB
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:48 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b709048d8eso1082101b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834622; x=1698439422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vj5Zj+Bw57JH4E175sUuTw9SkCPkXc9sWUiIDH26gck=;
 b=enH7rGJb+3DB9sJMVEgD+exnNafObOJfJKbLWTeia8Ssb5b3w6rToSXFOq/Dh8umAx
 tae8x8ddcnEBiLLpXdXQKupb8i5YFRhd01eqjgTR8CeYCPMhPvCHOFFQSPJhQRjFvu2e
 ZU7DCHb65I2sbZ97V1vbp6YgsLes4Zp8B6kdmwOG9s08Ull1yiPr11hhdaamK4k6r3aW
 0m1nS4Zrb5NXLqasSu043ZwShouPHK/Ntsxibhr5UBa0rY7mROFgmyz2Voip0LYHVetF
 OUtnuPe8/Q3+J29BdLPtGwPhmka6rI6fQLzmWXHnU7gnaRyKA6vvA8rc0gbVFXxyCYRy
 yzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834622; x=1698439422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vj5Zj+Bw57JH4E175sUuTw9SkCPkXc9sWUiIDH26gck=;
 b=oL7Pl2l4Aj/1fMdPq4ZfDmxtF7lvQAf8bchkKD2VrOkdWmXVgOONr9GD4kfA49E0IE
 x8wgPPNIzde2+VcqPF1cjjGSJfsRVqvPz1tuIwOpzEIOwPOCgCdrzdGxSH6Ky7vMmmXV
 XXJJYFI9mmYgSkpMsm37iL4dB1q1DigOEVZ27CtzY/1QfgjcLs8PQFW419zwQf+JJrEz
 CDQOQOcqZr7wO3sHXo0CAGsDqK9vIj9ivSK/EhkSWlfZzKs+ksE5P/OC0aGF+xJHTtvF
 jdDtbmutyZ2GR/75qmH+DC11EgVdajlHT5PM4W8c2R+ct+WXu5GsPGL1uIPQPortpL9J
 DFDQ==
X-Gm-Message-State: AOJu0Yw1y6YpTDyoMi9guTdSJvLaXBNjHDZEsQ/X7EdbXBg/YV69k7vW
 ZFKngXpnZAbpbMYvYbUbREbRgZSMiusXwWubqYQ=
X-Google-Smtp-Source: AGHT+IH/mrDpKNwmCG2mQMKMC6ffKpRFf7JQe6WGYDPrM5+djX73VlIdwTtQdb66sUM1WrqnLAOIrQ==
X-Received: by 2002:a05:6a00:99e:b0:6be:265:1bf5 with SMTP id
 u30-20020a056a00099e00b006be02651bf5mr3314607pfg.24.1697834622534; 
 Fri, 20 Oct 2023 13:43:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 10/65] target/hppa: Fix do_add, do_sub for hppa64
Date: Fri, 20 Oct 2023 13:42:36 -0700
Message-Id: <20231020204331.139847-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


