Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF677D1775
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwM5-0007yR-8R; Fri, 20 Oct 2023 16:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLj-0007l7-6D
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0008C5-I1
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:02 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b20a48522fso1169465b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834633; x=1698439433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=61l8ExG3pdb1L+cR7hfS5b3i51MeOrIbY/vnXSWadm4=;
 b=dCiXlaK2kHSljTK/igJI3QQU27804QsS/5MbTT86LN5C7FvSVIJYoHeS4RkX4i3Irm
 6rEgfgFKtTrgcLNULyI97/GK5TuBXtgV9wgNW7acObHqJcSs2SkJFRD7X98Pal/3ISkI
 Ckkiac44HnIjOlGCNMU7td/asBS7zicdwy8DMt5ptu/5y9ykaFaF7EZrtkOZV8Kgq62q
 5pPOzc0QVZ8E9wHabjRJ72F6DHd27JHSNUWrPhE1uSivEDeFuKu/urfupTKFxg+H8IAQ
 5lHh3hGn0fBAqZVCnUoyRx2khhiAi+70t9qCH+xuMMlPNYB+kEeD6pvrppL+Z6K85laS
 PsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834633; x=1698439433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=61l8ExG3pdb1L+cR7hfS5b3i51MeOrIbY/vnXSWadm4=;
 b=THgxj04q5Pmt6OrZpaSeeGXYffnUmf5opypimKVc52MNfTIVemxwD3wtVyhrM+zpYb
 Qyzxb5Va91FdzeocBJrBXRYiFe4aG9SVrkGFgW9dUTGUdOjlivxPJa6EzQhQnEBnuDwP
 3IkbVAPUYCke5lrE3ymriayd/L3fUv+GPKDAkn+1gIMLlGtIhCAxjVsqyptfWgn+LI8W
 Vnct6zGDq5EYb7nYJc18+pyukVdykVZRwNT6nOBE/WkeUJjA3Ekr9H+gKmGdv6mngiIH
 6dlXoolHfVb0hPwxAdzXpsDQVFCTy36zsG8wkBV4RvHSNdFX8ixn6t3bngT4BmBveqIF
 Zs7w==
X-Gm-Message-State: AOJu0Yw1UYkW7zz0OsxKX8NdRAsM1w9W4v/cPPMX+HNzvyx9ir8CL7Lh
 CXK5tu2GxGT9HhbzSfAyrA4uiEi0TEeL3F69O7k=
X-Google-Smtp-Source: AGHT+IF3jRXXKUZw52u4NGvgTX5AK2C0vSZFmtW2TDzykD2d1Pnm9DdeB0LmCeMR6bjDBztfeyF5Uw==
X-Received: by 2002:a05:6a00:138f:b0:68f:dd50:aef8 with SMTP id
 t15-20020a056a00138f00b0068fdd50aef8mr3484027pfg.4.1697834633290; 
 Fri, 20 Oct 2023 13:43:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 23/65] target/hppa: Pass d to do_sub_cond
Date: Fri, 20 Oct 2023 13:42:49 -0700
Message-Id: <20231020204331.139847-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Hoist the resolution of d up one level above do_sub_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index e84311d886..d480bac03d 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -446,12 +446,15 @@ static DisasCond cond_make_n(void)
     };
 }
 
-static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+static DisasCond cond_make_tmp(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 {
     assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
-    return (DisasCond){
-        .c = c, .a0 = a0, .a1 = tcg_constant_reg(0)
-    };
+    return (DisasCond){ .c = c, .a0 = a0, .a1 = a1 };
+}
+
+static DisasCond cond_make_0_tmp(TCGCond c, TCGv_reg a0)
+{
+    return cond_make_tmp(c, a0, tcg_constant_reg(0));
 }
 
 static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
@@ -463,15 +466,12 @@ static DisasCond cond_make_0(TCGCond c, TCGv_reg a0)
 
 static DisasCond cond_make(TCGCond c, TCGv_reg a0, TCGv_reg a1)
 {
-    DisasCond r = { .c = c };
+    TCGv_reg t0 = tcg_temp_new();
+    TCGv_reg t1 = tcg_temp_new();
 
-    assert (c != TCG_COND_NEVER && c != TCG_COND_ALWAYS);
-    r.a0 = tcg_temp_new();
-    tcg_gen_mov_reg(r.a0, a0);
-    r.a1 = tcg_temp_new();
-    tcg_gen_mov_reg(r.a1, a1);
-
-    return r;
+    tcg_gen_mov_reg(t0, a0);
+    tcg_gen_mov_reg(t1, a1);
+    return cond_make_tmp(c, t0, t1);
 }
 
 static void cond_free(DisasCond *cond)
@@ -910,36 +910,55 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
    can use the inputs directly.  This can allow other computation to be
    deleted as unused.  */
 
-static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, TCGv_reg res,
-                             TCGv_reg in1, TCGv_reg in2, TCGv_reg sv)
+static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
+                             TCGv_reg res, TCGv_reg in1,
+                             TCGv_reg in2, TCGv_reg sv)
 {
-    DisasCond cond;
-    bool d = false;
+    TCGCond tc;
+    bool ext_uns;
 
     switch (cf >> 1) {
     case 1: /* = / <> */
-        cond = cond_make(TCG_COND_EQ, in1, in2);
+        tc = TCG_COND_EQ;
+        ext_uns = true;
         break;
     case 2: /* < / >= */
-        cond = cond_make(TCG_COND_LT, in1, in2);
+        tc = TCG_COND_LT;
+        ext_uns = false;
         break;
     case 3: /* <= / > */
-        cond = cond_make(TCG_COND_LE, in1, in2);
+        tc = TCG_COND_LE;
+        ext_uns = false;
         break;
     case 4: /* << / >>= */
-        cond = cond_make(TCG_COND_LTU, in1, in2);
+        tc = TCG_COND_LTU;
+        ext_uns = true;
         break;
     case 5: /* <<= / >> */
-        cond = cond_make(TCG_COND_LEU, in1, in2);
+        tc = TCG_COND_LEU;
+        ext_uns = true;
         break;
     default:
         return do_cond(ctx, cf, d, res, NULL, sv);
     }
-    if (cf & 1) {
-        cond.c = tcg_invert_cond(cond.c);
-    }
 
-    return cond;
+    if (cf & 1) {
+        tc = tcg_invert_cond(tc);
+    }
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg t1 = tcg_temp_new();
+        TCGv_reg t2 = tcg_temp_new();
+
+        if (ext_uns) {
+            tcg_gen_ext32u_reg(t1, in1);
+            tcg_gen_ext32u_reg(t2, in2);
+        } else {
+            tcg_gen_ext32s_reg(t1, in1);
+            tcg_gen_ext32s_reg(t2, in2);
+        }
+        return cond_make_tmp(tc, t1, t2);
+    }
+    return cond_make(tc, in1, in2);
 }
 
 /*
@@ -1267,7 +1286,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute the condition.  We cannot use the special case for borrow.  */
     if (!is_b) {
-        cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+        cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
     } else {
         cond = do_cond(ctx, cf, d, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
@@ -1321,6 +1340,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest, sv;
     DisasCond cond;
+    bool d = false;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
@@ -1332,7 +1352,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Form the condition for the compare.  */
-    cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
 
     /* Clear.  */
     tcg_gen_movi_reg(dest, 0);
@@ -3028,6 +3048,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
 {
     TCGv_reg dest, in2, sv;
     DisasCond cond;
+    bool d = false;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
@@ -3039,7 +3060,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(ctx, c * 2 + f, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, c * 2 + f, d, dest, in1, in2, sv);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-- 
2.34.1


