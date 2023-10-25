Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E277D6298
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIT-0000BA-15; Wed, 25 Oct 2023 03:27:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIQ-00009X-TK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:18 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIK-0004dn-F5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:18 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9a1762b43so45380035ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218831; x=1698823631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zh61DK1PDe6VrwXTSbb5OfrsTdylybfZGSWnmMjbkM0=;
 b=jrgdzKlf6b3iW//kjXNsm0bIvJHWJaoaJ1yXMlHZfcJItDW0aDStMA86HGz2GnBmC7
 LCbcWolr+ULRZoYmQenHbzhUg71/bXJmhfW3ighWF3SbYY9YlTUstpnISbETtLoULhz6
 HiI++GfZq9DDVxbeTa40QFk645j8Clva2jeOA+r046NRmROHUMtUJfmi60ytEKlbzR0J
 iqeYqDBrVfN5V9DVvzPXZw/hKBFqYpK/KkyosS+zSf2SL75uG2bKfmGzRJJHYpYabm5d
 UoKj2uMJpyn6KBCSa74uFLq2k1JT/5Y3/cuV5bp6v2R0stnMRFjQ1cseE8JdBTsrnEKu
 tI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218831; x=1698823631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zh61DK1PDe6VrwXTSbb5OfrsTdylybfZGSWnmMjbkM0=;
 b=u821TosjvUN3B8SPOyLB2aD3oHPOoh7rs6F5Dk956kMsN6o2eQRB61IYm4VzzTHj8Y
 93sEbV03wGp5QEq5iFIyTGXIyaWXC9DgvIPcxnjcnM7GcM+vS2x7aaMQXsMFoiNYyvsE
 S1FqQ83EwqksLfQyISXgdMNUW/n7UfYxcqSDSjh8c2TZaSJ821UW+cF5F5uruB7JoskG
 BY9wU2OzyqRFLnExCyUu1WQlDms0Po/POFEa6LoPaMN3fb7GAK2+j1Lebx/l9tLP3OwO
 4nkvQuANdkpKiL5pj1xydFJMxpc7Y+c/R56Blkc48aMuMD2w5m+bKC5SMLMwLTTkopfb
 KR6w==
X-Gm-Message-State: AOJu0YysmzSw+sItvZt3IAYXx4dS3APBxCyqoqE222751VOCKAZWgOle
 RM24PxO8s/ua8SWFnlhL6yso0aMWrBS8T2DqcLI=
X-Google-Smtp-Source: AGHT+IFTaNFR/aulc8opyTmCT4RzNiSd8wMsJmZ1U7KVN7jzN4Vq5neoJOklf2BffzPRG4f8KNt67g==
X-Received: by 2002:a17:902:ef8e:b0:1c7:2697:ec0a with SMTP id
 iz14-20020a170902ef8e00b001c72697ec0amr14691578plb.30.1698218830797; 
 Wed, 25 Oct 2023 00:27:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 02/29] tcg/optimize: Split out arg_is_const_val
Date: Wed, 25 Oct 2023 00:26:40 -0700
Message-Id: <20231025072707.833943-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tcg/optimize.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2db5177c32..e8a13fedb5 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -112,11 +112,22 @@ static inline bool ts_is_const(TCGTemp *ts)
     return ts_info(ts)->is_const;
 }
 
+static inline bool ts_is_const_val(TCGTemp *ts, uint64_t val)
+{
+    TempOptInfo *ti = ts_info(ts);
+    return ti->is_const && ti->val == val;
+}
+
 static inline bool arg_is_const(TCGArg arg)
 {
     return ts_is_const(arg_temp(arg));
 }
 
+static inline bool arg_is_const_val(TCGArg arg, uint64_t val)
+{
+    return ts_is_const_val(arg_temp(arg), val);
+}
+
 static inline bool ts_is_copy(TCGTemp *ts)
 {
     return ts_info(ts)->next_copy != ts;
@@ -565,7 +576,7 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
         }
     } else if (args_are_copies(x, y)) {
         return do_constant_folding_cond_eq(c);
-    } else if (arg_is_const(y) && arg_info(y)->val == 0) {
+    } else if (arg_is_const_val(y, 0)) {
         switch (c) {
         case TCG_COND_LTU:
             return 0;
@@ -831,7 +842,7 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 /* If the binary operation has first argument @i, fold to @i. */
 static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -840,7 +851,7 @@ static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has first argument @i, fold to NOT. */
 static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return fold_to_not(ctx, op, 2);
     }
     return false;
@@ -849,7 +860,7 @@ static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to @i. */
 static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -858,7 +869,7 @@ static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to identity. */
 static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
     }
     return false;
@@ -867,7 +878,7 @@ static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to NOT. */
 static bool fold_xi_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return fold_to_not(ctx, op, 1);
     }
     return false;
@@ -1083,8 +1094,8 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
-        if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == 0 &&
-            arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0) {
+        if (arg_is_const_val(op->args[2], 0) &&
+            arg_is_const_val(op->args[3], 0)) {
             goto do_brcond_high;
         }
         break;
@@ -1303,9 +1314,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const(op->args[1])
-        && arg_info(op->args[1])->val == 0
-        && op->args[3] == 0) {
+    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
 
         op->opc = and_opc;
@@ -1316,8 +1325,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const(op->args[2])
-        && arg_info(op->args[2])->val == 0) {
+    if (arg_is_const_val(op->args[2], 0)) {
         uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
 
         op->opc = and_opc;
@@ -1855,8 +1863,8 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
          * Simplify LT/GE comparisons vs zero to a single compare
          * vs the high word of the input.
          */
-        if (arg_is_const(op->args[3]) && arg_info(op->args[3])->val == 0 &&
-            arg_is_const(op->args[4]) && arg_info(op->args[4])->val == 0) {
+        if (arg_is_const_val(op->args[3], 0) &&
+            arg_is_const_val(op->args[4], 0)) {
             goto do_setcond_high;
         }
         break;
-- 
2.34.1


