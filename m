Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACF27DA8FF
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFW-0004iF-9w; Sat, 28 Oct 2023 15:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFU-0004hQ-2n
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFR-00045u-Do
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:31 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc329ce84cso5535385ad.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522327; x=1699127127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9eXocbu34bghBLrSPFKvIsugn7thygfTREC245booiE=;
 b=rBhhkWQxpF2oT1zxDz5F8C4hPHo14o7GLjmOrhyne6qJvLQ9gFlJPrQsO4tSowAFCS
 rCmZaWM1Adn6xpjoQO8YE7K0eDGkkK9K1ZZS6g1lUReWCnxvfVhtAXaOsJl3+VADMYZo
 d11HQOHqaMtOoigW2sV8CFrXdHTEykdpAvaODVUvBNrIkj94J/vnHbyT1Z/U4es0Elq3
 qEmX0+zBNa0hdGFISiqqaQucpiG7yEeiznzcG5vzMp9Z8WbImbi950xYzG/B5Q5BPHLx
 TXeBvbKhHg/Fl38VPAx8w3BzWrsDFVBajoZVuy0vdClYrbfpZ/PuRoQumi+B5mR1tf/z
 enVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522327; x=1699127127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9eXocbu34bghBLrSPFKvIsugn7thygfTREC245booiE=;
 b=klhcRdtZXppz4v+HgvZp5gxPmIeW+AS12PEDz4YSK0fNYzJ5lw5JQVtBTrIf44Z/eE
 auo7P6BXovNOxSBtFMYOxd0y7Gw5gzV3riVuvhfIBxhHL/oYIwhSPB1P9iC1RQX30BE+
 v1LM8E6Diy4WNMm1lPxxSgOL4nvsbsykk20QiTP2H6ZGm1qt5NmdFvTJwx0H7665GmeO
 lnvwjX6K46h4U8fRHewEKw9gqEJa6jIyKeVsEOfA2dBAQOUFzm5UQZzR55QBJAc6kFrW
 r4oDwh+33W61ARMg2HLKI8T62wDIY7z+dsFdCKLEgc/Q3OBvxUlvgM/ZVre9cI/3armv
 dDXQ==
X-Gm-Message-State: AOJu0YwF3XeX6o145zQfn6McG7rAuJbEmhBLFEdDT5Fo6F6EEHv06n3n
 /AB+T/9I8aM2E9g3kJfd9SK2LkDOArY9o06W8XY=
X-Google-Smtp-Source: AGHT+IErm9bRzlS9SU4a8GvEQOlWDnORwYyUOQbS91PuWs9WFbhLq8NonqrEqN4vpNtDt4eKloOgqw==
X-Received: by 2002:a17:902:e5c2:b0:1cc:3fc9:7d09 with SMTP id
 u2-20020a170902e5c200b001cc3fc97d09mr523622plf.15.1698522327098; 
 Sat, 28 Oct 2023 12:45:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 03/35] tcg/optimize: Split out do_constant_folding_cond1
Date: Sat, 28 Oct 2023 12:44:50 -0700
Message-Id: <20231028194522.245170-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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


