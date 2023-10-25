Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D2D7D62A0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIS-0000AC-3P; Wed, 25 Oct 2023 03:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIN-00008V-41
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIL-0004dz-Cq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:14 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso35342085ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218832; x=1698823632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eXocbu34bghBLrSPFKvIsugn7thygfTREC245booiE=;
 b=VhkYNyup9hyWgyQjSCrfqG8ZSEUoNYIKdOhahB6iPscVbVJCCezrjKJHhuHvPWx7FG
 07omVMQTf2MlDAqeDOYP160OX7CWhm/QP6rhXogBRHrKGjta8TPSoKjPsRQq5ktbDNpe
 7v7tqsl+KbnV+P6ZzfFOWm6oQwnvQNpkYHoh30uRMVVHra4Lw0WX/0zPuRo7Yb4i73OU
 /IHMm26nkyh6nT8bJjsoptHdvQlIVGs7VJnwa7i1rjXtw435Dg/8uPs5TglbXmtpUEsU
 6nPKzfnwtGipqFYLVWiLSMdfDv4NOGeb325RpswIqtYYArEvgymO3RMo83b/KXPRaRGp
 Arsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218832; x=1698823632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eXocbu34bghBLrSPFKvIsugn7thygfTREC245booiE=;
 b=wWUZOKUFJHLJ1NbrI/4/mnHU9xxEjoDIOT6iwsE/WkqSQJNBPWm5aiF4+uR7fYJyEj
 ZXhAG66ij4bWUeNlPCN1y6G84lF6G91fU6jMzZva4qSPR4AwmNyG/U8ipNj8ZKQl+A7Y
 GcC4R2PNH6Zq99ndIa58eaqczBFFZvD7VsKGIp3L29OdjHjbKL5VGdSOzPfOV/US/Vdt
 +BVJe/CqfJBUwkwZJ2biECO/x1kD17VRG0ZCBRdJADLC6Mgkzb/6wlmSYB7igtrPnugx
 Ncaz7H7CH3uBDOsk1e+KffvETCpi0r4NoMJytKZZF88Kg5biDt2Yfq7AnyYnnVHGk2BQ
 xUrg==
X-Gm-Message-State: AOJu0YyH3IxYLF2B7QVc0S2QKlBSfbI9MBVz6KSb2NLWij/cniNB0BQR
 45/xsM/tMQmBDyXKHAt/5Ild4x53DxbPRaD722A=
X-Google-Smtp-Source: AGHT+IH++Ad8b2a6bCWsoLHsWy/AkDgmNO6QhAzyldvAeOQ6lvwoPsp7yegcsoFS+byIjx6C407T+g==
X-Received: by 2002:a17:902:e887:b0:1ca:79b6:ce38 with SMTP id
 w7-20020a170902e88700b001ca79b6ce38mr11679045plg.17.1698218831856; 
 Wed, 25 Oct 2023 00:27:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 03/29] tcg/optimize: Split out do_constant_folding_cond1
Date: Wed, 25 Oct 2023 00:26:41 -0700
Message-Id: <20231025072707.833943-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Handle modifications to the arguments and condition
in a single place.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 57 ++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index e8a13fedb5..89cc794d24 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -672,6 +672,23 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
     return false;
 }
 
+static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
+                                     TCGArg *p1, TCGArg *p2, TCGArg *pcond)
+{
+    TCGCond cond;
+    bool swap;
+    int r;
+
+    swap = swap_commutative(dest, p1, p2);
+    cond = *pcond;
+    if (swap) {
+        *pcond = cond = tcg_swap_cond(cond);
+    }
+
+    r = do_constant_folding_cond(ctx->type, *p1, *p2, cond);
+    return r;
+}
+
 static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 {
     for (int i = 0; i < nb_args; i++) {
@@ -1053,14 +1070,8 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[2];
-    int i;
-
-    if (swap_commutative(NO_DEST, &op->args[0], &op->args[1])) {
-        op->args[2] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[0], op->args[1], cond);
+    int i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[0],
+                                      &op->args[1], &op->args[2]);
     if (i == 0) {
         tcg_op_remove(ctx->tcg, op);
         return true;
@@ -1550,21 +1561,18 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
 static bool fold_movcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[5];
     int i;
 
-    if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
-        op->args[5] = cond = tcg_swap_cond(cond);
-    }
     /*
      * Canonicalize the "false" input reg to match the destination reg so
      * that the tcg backend can implement a "move if true" operation.
      */
     if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
-        op->args[5] = cond = tcg_invert_cond(cond);
+        op->args[5] = tcg_invert_cond(op->args[5]);
     }
 
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[1],
+                                  &op->args[2], &op->args[5]);
     if (i >= 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
     }
@@ -1578,6 +1586,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         uint64_t tv = arg_info(op->args[3])->val;
         uint64_t fv = arg_info(op->args[4])->val;
         TCGOpcode opc, negopc = 0;
+        TCGCond cond = op->args[5];
 
         switch (ctx->type) {
         case TCG_TYPE_I32:
@@ -1805,14 +1814,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
 
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[3];
-    int i;
-
-    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
-        op->args[3] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+                                      &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
@@ -1824,14 +1827,8 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 {
-    TCGCond cond = op->args[3];
-    int i;
-
-    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
-        op->args[3] = cond = tcg_swap_cond(cond);
-    }
-
-    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+                                      &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
-- 
2.34.1


