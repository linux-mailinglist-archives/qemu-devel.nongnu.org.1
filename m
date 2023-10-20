Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C7D7D17A4
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLr-0007oi-6S; Fri, 20 Oct 2023 16:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLN-0007hh-Pp
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:42 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLM-00088k-53
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:41 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6be0277c05bso1102452b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834618; x=1698439418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNZMizemvrujc4XnqyNiXy5WpOSPf3XvMMBFfWR0das=;
 b=RnmRBdrI+h5w9HRYz5jsc0pzZA+pd/07bKZNk8Au1qN48sQiBy5lFCgv9e/RtuLL1q
 GiEs+2tuuz1a8ncXaT2Cq23IvAFsJlYVKN/g0vQiPh6YDH9HsHucPG8y8Ar5D9NAJjbF
 MoIVwKnFUx5adszealubgwGKkZ6+U9ZEVqqRv98m776tw60lSouaS52qEMg8II1i1Hrj
 FhHDoKS356gCCWuigb3/G7XeHUa44lhWBJ7cfoUvt5m2Ddatygycs4EePh4iGrV6qRHP
 NrGPtQ8L0E13C1V+tO5PgLaa0372IWgR0JkylgTmYtRi6eXWVatAkknXLewv0fND5moa
 c1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834618; x=1698439418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mNZMizemvrujc4XnqyNiXy5WpOSPf3XvMMBFfWR0das=;
 b=qyTcaXOfhuDSQQXn0C3g4v1x/7jngbDGdcNQ2kz3tCK9ZX0aCCZn/ENeq2cs4V6BOD
 TOl4ltFaN5Xkx/hk22oWWD3MJXYqWSmfyG40pZXZaTpFL05J8RHYMfQJY9oAZSAOuaj7
 V5THhE6i5LtwZBQgiZC16qeGXt+ZkYGsOgJeBGBgUgjdi41qnkK+yA3GGzkezbXbB68M
 lrW1FZT2JEmcDwASPpZ52EfrS9hJfEQJHm9hL1hMqAzXttaFE999cBvUYenGhVsu9Q1A
 Fjfo/Q1PLpGfKviXO1x+eO8w4+3dq5INb6+hN9YSY8yDMMFOUlj587SwxDP+k+723ocs
 encQ==
X-Gm-Message-State: AOJu0YyHbqR59Y7f+Ot2NLhZ0q6yHGNJsHhDv96/FdXuBeZl7RRyuDyS
 PgP/R5SrFydDoe+Rc7UaHOBuWI0oY+azrmcSRsc=
X-Google-Smtp-Source: AGHT+IE6Vhd2w20Jgcz08xYJXysD2LbJdnbS3UYmvCXAC4bSjDKOBqG6maCGRz6NWoASekZRP/3T9w==
X-Received: by 2002:a05:6a20:728c:b0:15a:836:7239 with SMTP id
 o12-20020a056a20728c00b0015a08367239mr3260263pzk.11.1697834618352; 
 Fri, 20 Oct 2023 13:43:38 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 05/65] target/hppa: Remove load_const
Date: Fri, 20 Oct 2023 13:42:31 -0700
Message-Id: <20231020204331.139847-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Replace with tcg_constant_reg.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 5302381a56..21f97f63a9 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -488,13 +488,6 @@ static void cond_free(DisasCond *cond)
     }
 }
 
-static TCGv_reg load_const(DisasContext *ctx, target_sreg v)
-{
-    TCGv_reg t = tcg_temp_new();
-    tcg_gen_movi_reg(t, v);
-    return t;
-}
-
 static TCGv_reg load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
@@ -1164,7 +1157,7 @@ static bool do_add_imm(DisasContext *ctx, arg_rri_cf *a,
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_add(ctx, a->t, tcg_im, tcg_r2, 0, 0, is_tsv, is_tc, 0, a->cf);
     return nullify_end(ctx);
@@ -1253,7 +1246,7 @@ static bool do_sub_imm(DisasContext *ctx, arg_rri_cf *a, bool is_tsv)
     if (a->cf) {
         nullify_over(ctx);
     }
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_sub(ctx, a->t, tcg_im, tcg_r2, is_tsv, 0, 0, a->cf);
     return nullify_end(ctx);
@@ -2808,7 +2801,7 @@ static bool trans_cmpiclr(DisasContext *ctx, arg_rri_cf *a)
         nullify_over(ctx);
     }
 
-    tcg_im = load_const(ctx, a->i);
+    tcg_im = tcg_constant_reg(a->i);
     tcg_r2 = load_gpr(ctx, a->r);
     do_cmpclr(ctx, a->t, tcg_im, tcg_r2, a->cf);
 
@@ -2994,7 +2987,7 @@ static bool trans_cmpb(DisasContext *ctx, arg_cmpb *a)
 static bool trans_cmpbi(DisasContext *ctx, arg_cmpbi *a)
 {
     nullify_over(ctx);
-    return do_cmpb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_cmpb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
@@ -3033,7 +3026,7 @@ static bool trans_addb(DisasContext *ctx, arg_addb *a)
 static bool trans_addbi(DisasContext *ctx, arg_addbi *a)
 {
     nullify_over(ctx);
-    return do_addb(ctx, a->r, load_const(ctx, a->i), a->c, a->f, a->n, a->disp);
+    return do_addb(ctx, a->r, tcg_constant_reg(a->i), a->c, a->f, a->n, a->disp);
 }
 
 static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
@@ -3345,7 +3338,7 @@ static bool trans_depwi_sar(DisasContext *ctx, arg_depwi_sar *a)
     if (a->c) {
         nullify_over(ctx);
     }
-    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, load_const(ctx, a->i));
+    return do_depw_sar(ctx, a->t, a->c, a->nz, a->clen, tcg_constant_reg(a->i));
 }
 
 static bool trans_be(DisasContext *ctx, arg_be *a)
@@ -3852,7 +3845,7 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             return true;
         }
         if (inv) {
-            TCGv_reg c = load_const(ctx, mask);
+            TCGv_reg c = tcg_constant_reg(mask);
             tcg_gen_or_reg(t, t, c);
             ctx->null_cond = cond_make(TCG_COND_EQ, t, c);
         } else {
-- 
2.34.1


