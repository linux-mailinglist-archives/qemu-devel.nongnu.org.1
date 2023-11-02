Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B97DEA2A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYq-0006hd-Qq; Wed, 01 Nov 2023 21:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXr-0005nT-CH
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:51 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXp-0001dl-Iv
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:51 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so489085b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888648; x=1699493448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hr5vuZ68lJAyQU4cT2RqX4i7gNDgWOQDVCjFWr924pI=;
 b=BlGFREfzzhiSjOBOiiyAQSGv74H5Fee+XlNImF6OaaKIME8f2C4SQPswrzcthj5JNR
 kjdKVfG2u+xf2XZDxrAsKG5bObGbS/AWRwTvOgOQyJ6Ixeto2KhvlUH28Wgv6KGOmHMp
 /YEufXGkQCr6zHCkTVZuYLOoLxuYNt7j6ormmcE8HMbV/45H4tZXuiSsOL0WS0EtTv5I
 bvyryxgnqGaTR3Zr9CftyYSdOaqpKvQnSaFeVW7m08OYscB6GILNu1QQ6FmZAeQz8/o/
 GoiypUJlIR6907dL13qoMrVEvWlcDl5ARGgE4mhf/YAyis+n5fvFEMhoE2FVEpL3hz7D
 TUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888648; x=1699493448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hr5vuZ68lJAyQU4cT2RqX4i7gNDgWOQDVCjFWr924pI=;
 b=RF9jalMixen+ahi5OPOkWZ9okwoIZF1XhAVTFZUcXy5iEkfftmhfTViEyy70ETmqtQ
 n7HAikTY/1IqtRFNWwK9xutEFiqThWwf3e0YA71MwnW/5QldmX1lbqULCLujnWskOPEy
 6sLlzrLhVdO9JBBiAHpgAtEy/QCMi/CksNfPgafCLX5FPtQgbspMlZJJI9nV/dvONx5T
 xN3s/zWF0pvdEwgUZADnxqzVaAwQvMo9OjwVoCFRgzHcFCIepB6e9JAVa0xKc1++0vFZ
 /8BjstueVmusNhr4TGLpFxl1ZsS+Ufan2vy9WtooXPx+F8nESlx93fn4POONphepXys/
 IJRw==
X-Gm-Message-State: AOJu0YymI/AdoNgU4LdMLFz3ryhC4Lv6RE8NL/LJAq0zG8Fl6cxyHMlJ
 G2XVMaXM9kSaUtoS6WiYalPiTrYVClm0xuTVv2k=
X-Google-Smtp-Source: AGHT+IHY5S1WfeeETOTsbGppqKlf3Wb5sdbJ7hgA6v3fyUHaqjDc5EbTWuCKMjsA/DlrXn935tSeLA==
X-Received: by 2002:a05:6a00:392a:b0:693:394f:5d99 with SMTP id
 fh42-20020a056a00392a00b00693394f5d99mr21194285pfb.8.1698888648160; 
 Wed, 01 Nov 2023 18:30:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 33/88] target/hppa: Pass d to do_sub_cond
Date: Wed,  1 Nov 2023 18:29:21 -0700
Message-Id: <20231102013016.369010-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Hoist the resolution of d up one level above do_sub_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7b0e48c42b..72971097bb 100644
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
@@ -923,36 +923,55 @@ static DisasCond do_cond(DisasContext *ctx, unsigned cf, bool d,
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
@@ -1280,7 +1299,7 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 
     /* Compute the condition.  We cannot use the special case for borrow.  */
     if (!is_b) {
-        cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+        cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
     } else {
         cond = do_cond(ctx, cf, d, dest, get_carry(ctx, d, cb, cb_msb), sv);
     }
@@ -1334,6 +1353,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
 {
     TCGv_reg dest, sv;
     DisasCond cond;
+    bool d = false;
 
     dest = tcg_temp_new();
     tcg_gen_sub_reg(dest, in1, in2);
@@ -1345,7 +1365,7 @@ static void do_cmpclr(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     }
 
     /* Form the condition for the compare.  */
-    cond = do_sub_cond(ctx, cf, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, cf, d, dest, in1, in2, sv);
 
     /* Clear.  */
     tcg_gen_movi_reg(dest, 0);
@@ -3049,6 +3069,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
 {
     TCGv_reg dest, in2, sv;
     DisasCond cond;
+    bool d = false;
 
     in2 = load_gpr(ctx, r);
     dest = tcg_temp_new();
@@ -3060,7 +3081,7 @@ static bool do_cmpb(DisasContext *ctx, unsigned r, TCGv_reg in1,
         sv = do_sub_sv(ctx, dest, in1, in2);
     }
 
-    cond = do_sub_cond(ctx, c * 2 + f, dest, in1, in2, sv);
+    cond = do_sub_cond(ctx, c * 2 + f, d, dest, in1, in2, sv);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-- 
2.34.1


