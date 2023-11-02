Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 884727DEA28
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:36:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYp-0006U8-E6; Wed, 01 Nov 2023 21:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMYH-0005os-TW
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:31:19 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXw-0001fi-FA
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:59 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso487657b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888654; x=1699493454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaXliUFU7zxwYjzIKZW3FE6GrG46gQDaWnQhdZIDG68=;
 b=CteVYpe73wrq96bw/uZzEMDz7LmFUnj4Gq6VBLk0EwNsTTGcx/IPgxJqZ/2WDUwXU3
 U629pgQ/GyIFk1nT06i0TCiXLXTjh8GUNVn0MA2CVatAPfZpKKzCz8zQ1stlAh5w6KrG
 vtYGlpq4Ua5HiT/RAm7Loh14Zwrr8vIexpgBWHMXl2QNq54MlYCrN4Gj60+7SQGpi7cz
 LKQnMDBLR6Ny/m13PGMCka/VtBLdv/wJ3xIPJI2gYC0HNsmS1gvRTH4eUcpoINiv/MAw
 3WajuOAzW5SEVeCHsYkUNIkR0fXPEWWZhuRDNyoGB8kNGkjglj/Iv3VyXU1LuQHFSnhl
 A7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888654; x=1699493454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaXliUFU7zxwYjzIKZW3FE6GrG46gQDaWnQhdZIDG68=;
 b=bkXpUtugs3tnJP8frslPRSj2UuosbpQVXDRjA+46zovY6dWNLCxWCQK8IWGV7QbZXi
 E5J/ltKxdT/1FymJzgKo5ZlAPhHGjHC+7/jVH5zCw1Rs1RrOhKI0ojGOX7RVih0X9c+1
 CyX0M6x7xUQDJ4TL4Y0FF9zddrX0hFLl2Nre/oiCPZ+g+7cYrC1THP7zeE1W4Eqf7rzn
 PyAyuFOpx+8jNV/QKpEVV70s8nNAr4iz/24ieRxsiqlO/D/+biH07qGZQQH4stUhKfiU
 hfNkox4dXegGBYf6OiIPaYm1lmoeSWT3GVbsNgX/xx1H55hbvL1ywGxj5iwosGqFR1QE
 SRSw==
X-Gm-Message-State: AOJu0Yy9IjslnuRffDLMT7mzelfk9Cr9nVy6x9X1VPSkV47g3klu+C6G
 ONNt0E9EqZr9syLr0K72b01sWG882u8fvzW7kIw=
X-Google-Smtp-Source: AGHT+IE8BxWLO167gCN6gr5HIdwMwvfLQ/eTG3s0xepP24u+PeY3fv2jVTTxTHexVh1q2puUWTS3Zg==
X-Received: by 2002:a05:6a21:819e:b0:15e:7323:5c0f with SMTP id
 pd30-20020a056a21819e00b0015e73235c0fmr17973114pzb.16.1698888649492; 
 Wed, 01 Nov 2023 18:30:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 35/88] target/hppa: Pass d to do_sed_cond
Date: Wed,  1 Nov 2023 18:29:23 -0700
Message-Id: <20231102013016.369010-36-richard.henderson@linaro.org>
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

Hoist the resolution of d up one level above do_sed_cond.
The MOVB comparison and the existing shift/extract/deposit
are all 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ac7f1f048c..eb4605a9c7 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1050,10 +1050,10 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
+static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
+                             TCGv_reg res)
 {
     unsigned c, f;
-    bool d = false;
 
     /* Convert the compressed condition codes to standard.
        0-2 are the same as logicals (nv,<,<=), while 3 is OD.
@@ -3224,7 +3224,8 @@ static bool trans_movb(DisasContext *ctx, arg_movb *a)
         tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
     }
 
-    cond = do_sed_cond(ctx, a->c, dest);
+    /* All MOVB conditions are 32-bit. */
+    cond = do_sed_cond(ctx, a->c, false, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3238,7 +3239,8 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     dest = dest_gpr(ctx, a->r);
     tcg_gen_movi_reg(dest, a->i);
 
-    cond = do_sed_cond(ctx, a->c, dest);
+    /* All MOVBI conditions are 32-bit. */
+    cond = do_sed_cond(ctx, a->c, false, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3276,7 +3278,7 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3312,7 +3314,7 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3346,7 +3348,7 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3373,7 +3375,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3410,7 +3412,7 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3440,7 +3442,7 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3477,7 +3479,7 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (c) {
-        ctx->null_cond = do_sed_cond(ctx, c, dest);
+        ctx->null_cond = do_sed_cond(ctx, c, false, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.34.1


