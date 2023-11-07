Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB3A7E3376
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0COj-0007Zn-RQ; Mon, 06 Nov 2023 22:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COX-00077t-52
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:52 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000hH-6b
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:48 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so47437135ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326273; x=1699931073; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VaXliUFU7zxwYjzIKZW3FE6GrG46gQDaWnQhdZIDG68=;
 b=jegCJZnfPZSHZL1qUX/ubBMLMwVWx7IceQFU21lykAqEWiequcldCbZ6u3BhIR3C7O
 zp9X/xhFJsbpbCC6QXf0i78kZvYmMRGFZ6tVFWbp4xOGEqxcrGhUz1Tf3G7B/PklpnmV
 jxxfZqXn33cE7/2JxNoymyUyExooV8v70Mp2dzb7y/NBfJK+fGwGMV2NfyIfn8cuGbW1
 IlURr67+CbBBdLIkFrG9HqYKylMqVw6fIPE+DB9KRu0zrq82Lk7TjinfTJv/kCmcedOt
 k55qGhiNxzK7Uu6Pt+e1kaVjAXvoAqxtogIA1qPK0LrHz2a57b2+Lc/fCTGQKNI80ev4
 Ij6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326273; x=1699931073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaXliUFU7zxwYjzIKZW3FE6GrG46gQDaWnQhdZIDG68=;
 b=nAx3kgKdlRsZG0s6HOfYA0fkVazZWRXGHD0sZHrGgOwjxk7yaFAR7D+4HoMCowdtM8
 h90S5ERFRcPVGqcIV3DjvTSr98uIouDUnyW8P/eTvpxfHX063jPzc6AwCMvT8DlhQwXn
 kK+awyWOM9p8uTtRF3zecUo5SsSZLe32w9b6OPBF0FTyoGrRDAinPHn2noTy1nqT8FSC
 RaKWew20X14hoa3+O43PAoOCrU/F1lCL50+qsc9z+bPM9eJy3oUY5qDmRiXCDmDjNXOm
 1P50QOz6AOPiYK1D2PTNTHuX3I3Vlhv+t1OLkjVPZSYzFf5Sr6TTqeAVqcsox3w1Bj6n
 db6w==
X-Gm-Message-State: AOJu0YxaoMap2gZIB1uHml7dv3/4lC8sCIIQod/+FAKwjuqMifJ8YBZC
 753bFcli9HJYjevwbGUUcOVsnBfNhGmDrF9x8YM=
X-Google-Smtp-Source: AGHT+IFvD7dL/yyDNFcYXdstZEbQLmfoTSuWM65PXxAQjWTDstVEt4GjJVBmoZ0CXXv0mKXtAK0CMw==
X-Received: by 2002:a17:902:e84b:b0:1cc:4559:f5 with SMTP id
 t11-20020a170902e84b00b001cc455900f5mr29747707plg.14.1699326273229; 
 Mon, 06 Nov 2023 19:04:33 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/85] target/hppa: Pass d to do_sed_cond
Date: Mon,  6 Nov 2023 19:03:15 -0800
Message-Id: <20231107030407.8979-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


