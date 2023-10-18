Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 970747CEA53
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:53:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtESk-0001wP-Sm; Wed, 18 Oct 2023 17:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESQ-00019p-Ay
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:05 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtESN-0004Ra-6y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:52:01 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57babef76deso4060173eaf.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697665918; x=1698270718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pahNvfSbaXH7GCmgh8txSi9o/B1oidjE9rEfxQaDzTc=;
 b=Crh1We5TM6avpIpDTdEZaZHk5/WK/BAj4bMe+eHLo/FETb3TWr9uCy5cJsbwiSZhuq
 UsBvF61sVudl4y4ZRGGA90vSJZc6QPoMXxSG6ga73eJppyHiiG1vKYKSsFCtaX/DWOOR
 ZEaO0Y20Y0QfAaUDHypIPZ0J1LZEFC/tJ5uVP3tKW33zjHe1RqTZE09zLFM+PZoW0cmV
 1Bfpx2O7NW/YkL1+kdbXSM3mKWl6nZ7E7p8G8LBSMe6BR5xYY6ss8IYSZDRMXhi+6v2E
 XXJbm2tYd6m3m+3nnjYw1BiNpPv3Jvi6fNpEgLhrcd5/jvidXsxbZIIjyuuMxom9O8VJ
 8ZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697665918; x=1698270718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pahNvfSbaXH7GCmgh8txSi9o/B1oidjE9rEfxQaDzTc=;
 b=nkZe47GGAEL0gozueS2sYR4Lgy4FY4gqFYkT/WPzD14vao9bUqLXAw7tdX3vb2DcVN
 E9sHBOtz6eve+nfC7y0i0bkd0LkVjeSnL6wZn5NtWNk2BMHCbatPdw2BEKvkAcMxkqlw
 /V/wAv4pvUFiHjKVQZGqaO6Qg+F65heQagtUrqj3P/USr7Xz8qNfI8Sx7ZFEOhzxn1eL
 DgQHZ9Pu9mUiQ5btf3muOPVSSqCVDQTM8NcP3jHxLjMlcTvcSM72cDBEfguBA9F3iKg0
 OKapwVx0sMGQkvyltUxmvH5BxoEvaYrrFvbGZmIefRAT2LxVjzI2gqGusL5gx9lgUnSn
 aC1Q==
X-Gm-Message-State: AOJu0YxJtB8mYHqmxt27iE/Rl9kvuWGG1MNm+11R5AD4k3hSn0gur/10
 /urhFhcLiFy+JxedFnaCnsZuRR+GJKRQ6gZmsBU=
X-Google-Smtp-Source: AGHT+IGf5Q7xFJ+Oxqmpxgr4D5D9Q4oe/j7REOL0a973jv2jA6owJP63G9YuXXF942I86CwWdMHF+g==
X-Received: by 2002:a05:6359:3015:b0:166:dcf6:cd82 with SMTP id
 rf21-20020a056359301500b00166dcf6cd82mr248039rwb.14.1697665918070; 
 Wed, 18 Oct 2023 14:51:58 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 w17-20020a63f511000000b005b61a024ec7sm2176380pgh.74.2023.10.18.14.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:51:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 25/61] target/hppa: Pass d to do_sed_cond
Date: Wed, 18 Oct 2023 14:50:59 -0700
Message-Id: <20231018215135.1561375-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Hoist the resolution of d up one level above do_sed_cond.
The MOVB comparison and the existing shift/extract/deposit
are all 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 7a3b0f1de7..1a51ac4869 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1037,10 +1037,10 @@ static DisasCond do_log_cond(DisasContext *ctx, unsigned cf, bool d,
 
 /* Similar, but for shift/extract/deposit conditions.  */
 
-static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, TCGv_reg res)
+static DisasCond do_sed_cond(DisasContext *ctx, unsigned orig, bool d,
+                             TCGv_reg res)
 {
     unsigned c, f;
-    bool d = false;
 
     /* Convert the compressed condition codes to standard.
        0-2 are the same as logicals (nv,<,<=), while 3 is OD.
@@ -3203,7 +3203,8 @@ static bool trans_movb(DisasContext *ctx, arg_movb *a)
         tcg_gen_mov_reg(dest, cpu_gr[a->r1]);
     }
 
-    cond = do_sed_cond(ctx, a->c, dest);
+    /* All MOVB conditions are 32-bit. */
+    cond = do_sed_cond(ctx, a->c, false, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3217,7 +3218,8 @@ static bool trans_movbi(DisasContext *ctx, arg_movbi *a)
     dest = dest_gpr(ctx, a->r);
     tcg_gen_movi_reg(dest, a->i);
 
-    cond = do_sed_cond(ctx, a->c, dest);
+    /* All MOVBI conditions are 32-bit. */
+    cond = do_sed_cond(ctx, a->c, false, dest);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3255,7 +3257,7 @@ static bool trans_shrpw_sar(DisasContext *ctx, arg_shrpw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3291,7 +3293,7 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3325,7 +3327,7 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3352,7 +3354,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3389,7 +3391,7 @@ static bool trans_depwi_imm(DisasContext *ctx, arg_depwi_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3419,7 +3421,7 @@ static bool trans_depw_imm(DisasContext *ctx, arg_depw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
     }
     return nullify_end(ctx);
 }
@@ -3456,7 +3458,7 @@ static bool do_depw_sar(DisasContext *ctx, unsigned rt, unsigned c,
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


