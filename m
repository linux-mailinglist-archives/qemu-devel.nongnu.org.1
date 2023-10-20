Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 651817D1763
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLw-0007tt-4j; Fri, 20 Oct 2023 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLj-0007l5-4u
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLd-0008CS-7F
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:44:01 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so1179653b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834635; x=1698439435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BBKuip3A0RhkTWc5ebdaF2DgmzVxIGNwRkilYwMnVKc=;
 b=SkjZHAepIfLdW5H34mCJtRoeu6DC08sS+XTsnGgD0laB6J4BhwQEOTGux1b+qrK+Od
 4+5JZFiTl/3clzl731s+5tdoBB+G2EfVy15KTsDUbaG6cu5/iqEB1LWr1i4FhPht34bm
 +8kIqxAPAxnCxJE9BbWiI+oznXYv0BGtlWKX5bwUTr5d95yhQqyOm3UXETl6E8O4gdiY
 nNqR1qIOiwNfpPQ+JkzIHFGBm5oF9HGpiwK5SlXzxCz3ZVi74n+8Pi33NKB1o6MgCvt7
 oZhzgp+UwLJskfas8TpU8KvuuufzqSSS6hWH4aG7pGNvxIVmk6c6DVOQgvlBGrd5xZ+E
 yQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834635; x=1698439435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BBKuip3A0RhkTWc5ebdaF2DgmzVxIGNwRkilYwMnVKc=;
 b=PfdPDpaNzbzZAtqX7JKgN55sfmuruVA/jGVTqy/X5scLjkzjNjxaishi7bDeFv8RLw
 BcpEGbvMrkj0YULN+t966LMHw8fwF3SkvT1cKg/FQkZDpxmkyOO19HEaQPiymn62vCLc
 /yUyyaNSyY1JVFfZrA+MD8pzfDd+xOUuCaKK08WyZGD9GbIfec5hzdfIhkrptCoIMX/x
 fxcNseVZbPM7lGO8G/l02whSBzX8ixjQ//PncQumt/Hknh+irYAp7I5TaJQwqA+wh0/I
 w45kyTEKpKyZpn9jp1eK3QYbRSJz78lSjCP5DNKpaLz0gaD1Qm+O0BwCYYA3D5XQFybG
 crAA==
X-Gm-Message-State: AOJu0YyYmnKys8FAXgcjt7mj8XGloV1v1MLUzXUM7ib1CMulYcvTZ8o4
 mDLqsr4+YN5jaH8brrnnbkHAIJgYZuBI+w87+8w=
X-Google-Smtp-Source: AGHT+IECPfGRqnaJ8m1ooi4yCKD6HxdZXYTgDHPkARICpKLFcwCCMaURoYHAUno0sR3Zi2nGvdIUug==
X-Received: by 2002:a05:6a20:bb1b:b0:17b:7dda:c0fc with SMTP id
 fc27-20020a056a20bb1b00b0017b7ddac0fcmr2655742pzb.8.1697834634889; 
 Fri, 20 Oct 2023 13:43:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 25/65] target/hppa: Pass d to do_sed_cond
Date: Fri, 20 Oct 2023 13:42:51 -0700
Message-Id: <20231020204331.139847-26-richard.henderson@linaro.org>
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

Hoist the resolution of d up one level above do_sed_cond.
The MOVB comparison and the existing shift/extract/deposit
are all 32-bit.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d629f5f7f8..9995749237 100644
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


