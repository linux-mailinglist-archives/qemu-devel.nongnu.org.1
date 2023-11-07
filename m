Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE577E341D
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRj-0004rN-CY; Mon, 06 Nov 2023 22:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRb-0004ko-Ty
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:59 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRO-0001NR-N9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:07:59 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so5354659b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326465; x=1699931265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oL/Q9k4VdGpuvjlQ5aW5bW/J8E3SoDMupdQ5tQzg65o=;
 b=w0eVguLubF61dHHNI592T5NRFaMJiqcWrlhY+X+8Wi9IuQBZc6OSbGMaEY8TRgi9rg
 hZz89TQNk3E+xPiad7RvDuSkGihLqouwUDwDyGhmkqP6qaIMVsmjJWnX3APcJDYuyda1
 +9uQWXglDhxaXl0hz8vPSdHbJZQY1yg5tidDOA6qAmn3F9JC11I/SIAATfzkMRjWorBo
 Udq7cgiIzULOYGyeOu1P3qTfLpP8FaxNaUVA/594DCRBaQIfs3So3kzP0+42cyGVtrAE
 2U8YcSJA5RHSwoSW9LB8/TqtZ9TAZ6B67IdOe8Lm+KwXq+1nStwE6GXCNzy+qdhfeDLw
 oETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326465; x=1699931265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oL/Q9k4VdGpuvjlQ5aW5bW/J8E3SoDMupdQ5tQzg65o=;
 b=IvF7fkODGXQdNE/mir0glK9ubOlmVXNSkZtz2+3e7w53H+dW9ryg3a7lBELmFfc9zu
 JDnYzm1Iot8G0dTMa41ILzNwg9IlD2vcV4oeQIc3dbf43xkV21ahHpAbm+6la/+YQO1M
 Qkx+WvJp0NQOTK+RxN3OCwUhg7hFs+9wDs6YzGY1JoFuUCQDZzOpm/9A6fAascjePL93
 OIZ9C3tKMNxcVWTJp1ldePt1VAo+6XElvBk896bM457f/Ui4m5KZeZFnz2AC4XPXV8sZ
 471o/dV3bO6sLya6ipN5LiKpjcudJMDx3qLdPXmkpuoYr1ZvBZawipU0ByjXNF5B2Uw6
 Ffrg==
X-Gm-Message-State: AOJu0Ywe7XneRrGRFNjNgP/va3DSe4SJ4uIhxcvZyw2NaSsC8dtUiHL0
 CHqlwKdniRyHlBC/GCtBSqS7Vgxt8G6aiT/4yr8=
X-Google-Smtp-Source: AGHT+IHpgHXJGmxwPn7/1Bc2xPhLv8GQkbDpwwxelvwlqx56TnhnqrnbBQy4t2XW+0d5T+zHoXTABg==
X-Received: by 2002:a05:6a21:3d8d:b0:180:d66b:7f1 with SMTP id
 bj13-20020a056a213d8d00b00180d66b07f1mr26229834pzc.62.1699326465338; 
 Mon, 06 Nov 2023 19:07:45 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/85] target/hppa: Implement EXTRD
Date: Mon,  6 Nov 2023 19:03:31 -0800
Message-Id: <20231107030407.8979-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/insns.decode |  7 +++++--
 target/hppa/translate.c  | 42 +++++++++++++++++++++++++++++-----------
 2 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 12684b590e..7b51f39b9e 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -335,8 +335,11 @@ addbi           101011 ..... ..... ... ........... . .  @rib_cf f=1
 shrpw_sar       110100 r2:5 r1:5 c:3 00 0    00000  t:5
 shrpw_imm       110100 r2:5 r1:5 c:3 01 0    cpos:5 t:5
 
-extrw_sar       110100 r:5  t:5  c:3 10 se:1 00000  clen:5
-extrw_imm       110100 r:5  t:5  c:3 11 se:1 pos:5  clen:5
+extr_sar        110100 r:5  t:5  c:3 10 se:1 00 000 .....     d=0 len=%len5
+extr_sar        110100 r:5  t:5  c:3 10 se:1 1. 000 .....     d=1 len=%len6_8
+extr_imm        110100 r:5  t:5  c:3 11 se:1 pos:5  .....     d=0 len=%len5
+extr_imm        110110 r:5  t:5  c:3 .. se:1 ..... .....      \
+                d=1 len=%len6_12 pos=%cpos6_11
 
 dep_sar         110101 t:5 r:5   c:3 00 nz:1 00 000 .....     d=0 len=%len5
 dep_sar         110101 t:5 r:5   c:3 00 nz:1 1. 000 .....     d=1 len=%len6_8
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ea2150cc55..533e29879e 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3354,11 +3354,14 @@ static bool trans_shrpw_imm(DisasContext *ctx, arg_shrpw_imm *a)
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
+static bool trans_extr_sar(DisasContext *ctx, arg_extr_sar *a)
 {
-    unsigned len = 32 - a->clen;
+    unsigned widthm1 = a->d ? 63 : 31;
     TCGv_reg dest, src, tmp;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
@@ -3368,36 +3371,53 @@ static bool trans_extrw_sar(DisasContext *ctx, arg_extrw_sar *a)
     tmp = tcg_temp_new();
 
     /* Recall that SAR is using big-endian bit numbering.  */
-    tcg_gen_andi_reg(tmp, cpu_sar, 31);
-    tcg_gen_xori_reg(tmp, tmp, 31);
+    tcg_gen_andi_reg(tmp, cpu_sar, widthm1);
+    tcg_gen_xori_reg(tmp, tmp, widthm1);
 
     if (a->se) {
+        if (!a->d) {
+            tcg_gen_ext32s_reg(dest, src);
+            src = dest;
+        }
         tcg_gen_sar_reg(dest, src, tmp);
-        tcg_gen_sextract_reg(dest, dest, 0, len);
+        tcg_gen_sextract_reg(dest, dest, 0, a->len);
     } else {
+        if (!a->d) {
+            tcg_gen_ext32u_reg(dest, src);
+            src = dest;
+        }
         tcg_gen_shr_reg(dest, src, tmp);
-        tcg_gen_extract_reg(dest, dest, 0, len);
+        tcg_gen_extract_reg(dest, dest, 0, a->len);
     }
     save_gpr(ctx, a->t, dest);
 
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
 
-static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
+static bool trans_extr_imm(DisasContext *ctx, arg_extr_imm *a)
 {
-    unsigned len = 32 - a->clen;
-    unsigned cpos = 31 - a->pos;
+    unsigned len, cpos, width;
     TCGv_reg dest, src;
 
+    if (!ctx->is_pa20 && a->d) {
+        return false;
+    }
     if (a->c) {
         nullify_over(ctx);
     }
 
+    len = a->len;
+    width = a->d ? 64 : 32;
+    cpos = width - 1 - a->pos;
+    if (cpos + len > width) {
+        len = width - cpos;
+    }
+
     dest = dest_gpr(ctx, a->t);
     src = load_gpr(ctx, a->r);
     if (a->se) {
@@ -3410,7 +3430,7 @@ static bool trans_extrw_imm(DisasContext *ctx, arg_extrw_imm *a)
     /* Install the new nullification.  */
     cond_free(&ctx->null_cond);
     if (a->c) {
-        ctx->null_cond = do_sed_cond(ctx, a->c, false, dest);
+        ctx->null_cond = do_sed_cond(ctx, a->c, a->d, dest);
     }
     return nullify_end(ctx);
 }
-- 
2.34.1


