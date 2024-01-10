Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE0A82A41D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJh-0004VT-8x; Wed, 10 Jan 2024 17:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJf-0004Ul-05
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:55 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJd-0002ei-78
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:54 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-429be9fe952so2179131cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926692; x=1705531492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCOb1ACImxEyjzPr7SpomivAS+ARwGZqu81A17yuvPw=;
 b=UM/cDNJiEpfgOuVsnNsDgYmJ5ffqf8VV23QtN0eyI7Q9k5MLlneuOJYFOIK5eQePlV
 nYvD6qCzdRObrOrJmNFKHJy58LgLyK+pChao6Xo329TZWbBVFVJQGN71iNcWupwcTguW
 NOhZnmYLI0Ru5qC5loSFwk0IaYFSMeW9LsnWlW8flV7JA3DAVzn2XDMuDd0fvT0T8UvJ
 knhGPTjpMgptRXmg7j0AGrIutb5BXYTLV4mcQMKeZ9e3O5FEjZoRgk7VntwQ/4RaNgHS
 E6t9TDfG70FtLpWz7Xb9L0Z6Ly+kPXMB+DRe2kDWzQxNWXZOmeZ6MbNs/Y3muzXQtPKc
 +iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926692; x=1705531492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rCOb1ACImxEyjzPr7SpomivAS+ARwGZqu81A17yuvPw=;
 b=ttcSKeW2cvpAxAuqlAEbXAae2CUeXT01gVMGmkvDxdPUTvsKbBj/lbtTq+/dSAPXrN
 mQPz83qJ+CYaL7LQDdcS0lrgrqFCjZEqFqN/6JKEH/XYpr9JtxzPXzALalvL8LtWGo9X
 0mgxlNguydRBN0/NrMYWGm3vNlhGQFXcQC4lGC8QGpIIlYkr69Si5/EFt/s2k1UKlOkH
 gT5QzNwPyaFW5uaszmGSukRafTGkknBi4Yphchma3ER60CSsjRnAYzmqiFUj9Iie4RO5
 /2IvBkAL2hy3OR5R2IfQeZOHN3BzVSDSTcPcy2q/FgzYn4SfacSDiOTZg0dJrsArdWtM
 Aq6w==
X-Gm-Message-State: AOJu0YwROVaxcfascXCZzwGHaVTK7nO636ytpK7a30VKs+MZ6uCIKg2L
 HglKUcvPbVCKXSSXvJmRDMZCHit3RE4+F/1ZKTqDOC7F8HmX5u1b
X-Google-Smtp-Source: AGHT+IEk7fq1MVhUig0WRcqhlci/Egljzz1a0tZWIqxK+LxTfRbzVb6P0+7cM0qnT1hfonGnBJPncA==
X-Received: by 2002:ac8:5941:0:b0:429:9341:ddf2 with SMTP id
 1-20020ac85941000000b004299341ddf2mr1373680qtz.29.1704926692155; 
 Wed, 10 Jan 2024 14:44:52 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:44:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 04/38] tcg/optimize: Split out do_constant_folding_cond1
Date: Thu, 11 Jan 2024 09:43:34 +1100
Message-Id: <20240110224408.10444-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x830.google.com
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

Handle modifications to the arguments and condition
in a single place.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 57 ++++++++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 30 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 73019b9996..9c04dba099 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -796,6 +796,23 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
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
@@ -1193,14 +1210,8 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
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
@@ -1695,21 +1706,18 @@ static bool fold_mov(OptContext *ctx, TCGOp *op)
 
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
@@ -1723,6 +1731,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         uint64_t tv = arg_info(op->args[3])->val;
         uint64_t fv = arg_info(op->args[4])->val;
         TCGOpcode opc, negopc = 0;
+        TCGCond cond = op->args[5];
 
         switch (ctx->type) {
         case TCG_TYPE_I32:
@@ -1950,14 +1959,8 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
 
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
@@ -1969,14 +1972,8 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
 
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


