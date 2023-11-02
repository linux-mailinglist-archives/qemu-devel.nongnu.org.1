Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FC7DEA2E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:37:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYQ-0005wu-7S; Wed, 01 Nov 2023 21:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXr-0005nh-NI
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXq-0001dt-1Z
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:51 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so489095b3a.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888649; x=1699493449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LA/AGLVV6ssagQlxsZX0RjDd9+wOPDPuaHlRJKzssek=;
 b=vxeCJdloKXNzHcCJlF/fmuJyx1PhUFPREEY1ogI+fokduzTDiFQxcUdZVDXr4cByET
 IapZt8gwxt+p0cRd3WejL+ErgRuOz8V4/HOEYUxeK6kh4vCZareSyYKgJRC0ZH2zodit
 pnt/FEinfMJ8zETRD+fKY+IIQjLMv3g7+BWjIMYM4CjEaUoM/kO+1pUQK1WYqbRvbF2q
 oztl5ehMK0N+DrwnbFVF/x3UxHTcpEIzZAU6efBQWe26pXLbUQmGVbRBNYxUI4yFnHsO
 meF26BZIlZSChlyAhjjoj1sft2W+kY8MCFmhOYusexkxpxFVCekNP306wVb4zE2x87Jp
 sSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888649; x=1699493449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LA/AGLVV6ssagQlxsZX0RjDd9+wOPDPuaHlRJKzssek=;
 b=REZKKUJvNpF5p2X5XelmL+luUQX0zhOM8XBX1/KzyQHkXyjUZlzCsuHyhgYLXkz/Jv
 v8QOTRHmZ9UN+QP1ZXDKw4I3HS9Ecnbb1wKG1Su9b1Kpvfc+cS+hWrKv+QZVAAge548L
 nHZwB2WMSYJP5E5hfgQlJ86GN4WfslW2AkbPPruox5YkQ5K7dHD5P0uGjHC/tgs6s3GI
 Rk6g0EkeJoh+FHOBg+byqfqZoGneSMtsbowidqVPOVwIcSjC328gUH0wRBODB7C+ypzP
 d1CJjz9GBIXocEHAreRMrcsfZr/N2XwoxBkfJA6h4EDukm6Z+F0uOl+hp3do/Y7BKr3l
 9Fjw==
X-Gm-Message-State: AOJu0YxIHnHlNFziF2Eid3Rruy/kN+UiMEMbp+iAyv9iSL+R8/cyTTUS
 dPO1TJwzGTY5JGpQWyeotS2dFilosxQQM2UqNeY=
X-Google-Smtp-Source: AGHT+IFKYHo5tHP5zWFBjY507JqfE/rhIs9zGRdbiO2LVyP5ld1fvS06GUddXaPj4ONCoiaK6TvDOA==
X-Received: by 2002:a05:6a00:994:b0:68a:5cf8:dac5 with SMTP id
 u20-20020a056a00099400b0068a5cf8dac5mr20505965pfg.22.1698888648787; 
 Wed, 01 Nov 2023 18:30:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 34/88] target/hppa: Pass d to do_log_cond
Date: Wed,  1 Nov 2023 18:29:22 -0700
Message-Id: <20231102013016.369010-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Hoist the resolution of d up one level above do_log_cond.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 48 ++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 72971097bb..ac7f1f048c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -983,9 +983,11 @@ static DisasCond do_sub_cond(DisasContext *ctx, unsigned cf, bool d,
  * how cases c={2,3} are treated.
  */
 
-static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
+static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
+                             TCGv_reg res)
 {
-    bool d = false;
+    TCGCond tc;
+    bool ext_uns;
 
     switch (cf) {
     case 0:  /* never */
@@ -1001,17 +1003,29 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
         return cond_make_t();
 
     case 2:  /* == */
-        return cond_make_0(TCG_COND_EQ, res);
+        tc = TCG_COND_EQ;
+        ext_uns = true;
+        break;
     case 3:  /* <> */
-        return cond_make_0(TCG_COND_NE, res);
+        tc = TCG_COND_NE;
+        ext_uns = true;
+        break;
     case 4:  /* < */
-        return cond_make_0(TCG_COND_LT, res);
+        tc = TCG_COND_LT;
+        ext_uns = false;
+        break;
     case 5:  /* >= */
-        return cond_make_0(TCG_COND_GE, res);
+        tc = TCG_COND_GE;
+        ext_uns = false;
+        break;
     case 6:  /* <= */
-        return cond_make_0(TCG_COND_LE, res);
+        tc = TCG_COND_LE;
+        ext_uns = false;
+        break;
     case 7:  /* > */
-        return cond_make_0(TCG_COND_GT, res);
+        tc = TCG_COND_GT;
+        ext_uns = false;
+        break;
 
     case 14: /* OD */
     case 15: /* EV */
@@ -1020,6 +1034,18 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
     default:
         g_assert_not_reached();
     }
+
+    if (cond_need_ext(ctx, d)) {
+        TCGv_reg tmp = tcg_temp_new();
+
+        if (ext_uns) {
+            tcg_gen_ext32u_reg(tmp, res);
+        } else {
+            tcg_gen_ext32s_reg(tmp, res);
+        }
+        return cond_make_0_tmp(tc, tmp);
+    }
+    return cond_make_0(tc, res);
 }
 
 /* Similar, but for shift/extract/deposit conditions.  */
@@ -1027,6 +1053,7 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, TCGv_reg res)
 static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
 {
     unsigned c, f;
+    bool d = false;
 
     /* Convert the compressed condition codes to standard.
        0-2 are the same as logicals (nv,<,<=), while 3 is OD.
@@ -1037,7 +1064,7 @@ static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
     }
     f = (orig & 4) / 4;
 
-    return do_log_cond(ctx, c * 2 + f, res);
+    return do_log_cond(ctx, c * 2 + f, d, res);
 }
 
 /* Similar, but for unit conditions.  */
@@ -1381,6 +1408,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
                    void (*fn)(TCGv_reg, TCGv_reg, TCGv_reg))
 {
     TCGv_reg dest = dest_gpr(ctx, rt);
+    bool d = false;
 
     /* Perform the operation, and writeback.  */
     fn(dest, in1, in2);
@@ -1389,7 +1417,7 @@ static void do_log(DisasContext *ctx, unsigned rt, TCGv_reg in1,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (cf) {
-        ctx->null_cond = do_log_cond(ctx, cf, dest);
+        ctx->null_cond = do_log_cond(ctx, cf, d, dest);
     }
 }
 
-- 
2.34.1


