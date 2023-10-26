Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5767D794F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2p-00073o-Pm; Wed, 25 Oct 2023 20:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2g-0006za-Ut
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:07 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2P-0004pT-Ua
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:04 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9d3a21f7aso2172795ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279347; x=1698884147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zh61DK1PDe6VrwXTSbb5OfrsTdylybfZGSWnmMjbkM0=;
 b=zQ+n2q0U/wD9g6i3PsfXrc/GEApxL+LCOsqNAVliUCwKECAEwIy/Xte1fDsFCD/NEu
 DVJoqk55g/rzDpd2Uv3laKgnKg846sFJE3D4mWxEtW6JMLcv00QWcZo2/emnndnVKQEL
 MJ5EBtvmo4n+cs7+ljQoU4SRNLB5b9/5KwbmkOt3Vu41JpyyuI8um7KikkumnzcZsc7+
 UXHPZ3wFaSTwP/phxXrdZUpEl6MznE1HrbIIh5L4B4YKJcmAT/YB3fdjJY/kl35/M8Xg
 lQasHPm5nKuuW+kL2kw8PQC9NIgwSygZrjiWYclcHVQ63gwQjDr3/V3FlcfPV7pgjrMx
 LelQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279347; x=1698884147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zh61DK1PDe6VrwXTSbb5OfrsTdylybfZGSWnmMjbkM0=;
 b=E1RMUkXl8LzsfptuPdERHQdOxqxb2h/AMEjXaDSjfj1nRSXC/VeEYeQc4u5Nr/+y9d
 itE/nU+yN3kFv4rSbw3DxwhxJ7i/oEqtJdnO80PPL2ZfC3zA1YZIBEDMSxA28AeEHvHc
 ZKPdEFuFyqsqA/JIZRiMdt0Q4EeIaIQQV2EcLZGygpiKuZWxss7x0bpJfwTwPCFaLS3N
 d533VEzj7nscpYiwb53pVH+QrIew5xfDCVb9Wc3xIQpuhiy7TWzagqcW5WwI32TgVrEv
 GjZ8C9h5aGlftHq4AU7a/uwpztS77R/44rHVnN4LXYX5bGJGCMIsDEdth5YDlrEsuoXm
 r+2A==
X-Gm-Message-State: AOJu0YwTzzdL8Jr0Mkgr0/ayU9wDClRou/O9X3j0qfCQh9lX4zEdWZDh
 0Ywk+vXWtsnwJqv9Xhv1LcT1cZqdynzzxwefa4Y=
X-Google-Smtp-Source: AGHT+IGWgfenrIoCJp6T7iiRAX3aUy+IGLPwbyoayC9XT+tNoZOutwtnV4OkngdabLowJb52rw6QIQ==
X-Received: by 2002:a17:902:ce8d:b0:1c7:4ab6:b3cc with SMTP id
 f13-20020a170902ce8d00b001c74ab6b3ccmr20340249plg.54.1698279347548; 
 Wed, 25 Oct 2023 17:15:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/29] tcg/optimize: Split out arg_is_const_val
Date: Wed, 25 Oct 2023 17:13:43 -0700
Message-Id: <20231026001542.1141412-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


