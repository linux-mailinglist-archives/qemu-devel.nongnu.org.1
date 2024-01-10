Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CC782A41E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJZ-0004TA-Op; Wed, 10 Jan 2024 17:44:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJX-0004Sl-Hg
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:47 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJV-0002b6-RC
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:44:47 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbeff3fefc7so3602925276.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926684; x=1705531484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRwgTLH7x4qjGJwvWHPC6iD3rpKsmYUOnQgcGsFZM2o=;
 b=kr4/GM78hmqsgk48gQ8MzhpqQd0HbrncDA1RLMxF6yZ0grrlilzjLfq7BvYfJ5xin0
 0ICQXkgVG+zAbty4F+69XK5tkTSb30lyqbsDuB+lSi4rfpjEhZNTVIP9qjiBocWwCPBT
 JdWWtO7voEVDMj9q3jSgpyh0wBczBzy0LitICM2dmdet1h/Gh/vKQdjlJ5PCohSvvGUg
 ud/zyZAq2koAs2HEcvl8T3pkWz/+YVPhqc1DtaTVYj6xeQC4jtNDqHrOkUSU8hhzqxax
 vaCttB3VU4V4XktWLth1hE6Op2yjdYh6ZZ0NgofFVTSIc+XubBXCh9m3R6FYwivPIayM
 L3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926684; x=1705531484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRwgTLH7x4qjGJwvWHPC6iD3rpKsmYUOnQgcGsFZM2o=;
 b=eZp/O1hdRrFJDyBbueCfk8AeeRB5p8QyI8IiQaHeylziLLBkMRH1iw1H+sDkFRrU+l
 2t5YauJOglKrteu6sRiJhiltzI+EjdEbsSnUHv8raQHkPElCdMKJAGnXStDStnQ2XqoI
 4u5XAu48l0ph2JZphEGqLrwL9rgzZQrYZZNM1EFyzLOzJoDBeJ5X+wXYa1vQ0Sp0yRxe
 lC9PCYZLkyCv8dNQycbph472UN1bEjhNolW2qJZJbaulXB7aIiB2kz9+1my83h/bqyYZ
 gFlyq67pxD6OwGNmLMWTLV8FVKhVg2podso8hqOnYHFlDNHwcQdrUm4X0BRI+9I79qCU
 xk+A==
X-Gm-Message-State: AOJu0Yz92f/dAJFnel//vcJU0DgwYo7K4V6zLerd2Y7/yWsletxQJITg
 XLrkiWCEOG3ySI+pVTrT5zjKi4JXNuQEGoBYePM5s4waPC9IWic0
X-Google-Smtp-Source: AGHT+IF78akp1YBq1mO/ArcSP7+VRZUtFrVQ+wlzum9zcHHva4z+nhK7yOVXHN0/+AAwhrkJvi2Z7Q==
X-Received: by 2002:a25:9389:0:b0:db9:6ad7:1abb with SMTP id
 a9-20020a259389000000b00db96ad71abbmr355921ybm.12.1704926684684; 
 Wed, 10 Jan 2024 14:44:44 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.44.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:44:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 03/38] tcg/optimize: Split out arg_is_const_val
Date: Thu, 11 Jan 2024 09:43:33 +1100
Message-Id: <20240110224408.10444-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb29.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f2d01654c5..73019b9996 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -124,11 +124,22 @@ static inline bool ts_is_const(TCGTemp *ts)
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
@@ -689,7 +700,7 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
         }
     } else if (args_are_copies(x, y)) {
         return do_constant_folding_cond_eq(c);
-    } else if (arg_is_const(y) && arg_info(y)->val == 0) {
+    } else if (arg_is_const_val(y, 0)) {
         switch (c) {
         case TCG_COND_LTU:
             return 0;
@@ -954,7 +965,7 @@ static bool fold_to_not(OptContext *ctx, TCGOp *op, int idx)
 /* If the binary operation has first argument @i, fold to @i. */
 static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -963,7 +974,7 @@ static bool fold_ix_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has first argument @i, fold to NOT. */
 static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[1]) && arg_info(op->args[1])->val == i) {
+    if (arg_is_const_val(op->args[1], i)) {
         return fold_to_not(ctx, op, 2);
     }
     return false;
@@ -972,7 +983,7 @@ static bool fold_ix_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to @i. */
 static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
     return false;
@@ -981,7 +992,7 @@ static bool fold_xi_to_i(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to identity. */
 static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
     }
     return false;
@@ -990,7 +1001,7 @@ static bool fold_xi_to_x(OptContext *ctx, TCGOp *op, uint64_t i)
 /* If the binary operation has second argument @i, fold to NOT. */
 static bool fold_xi_to_not(OptContext *ctx, TCGOp *op, uint64_t i)
 {
-    if (arg_is_const(op->args[2]) && arg_info(op->args[2])->val == i) {
+    if (arg_is_const_val(op->args[2], i)) {
         return fold_to_not(ctx, op, 1);
     }
     return false;
@@ -1223,8 +1234,8 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
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
@@ -1448,9 +1459,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting a value into zero at offset 0. */
-    if (arg_is_const(op->args[1])
-        && arg_info(op->args[1])->val == 0
-        && op->args[3] == 0) {
+    if (arg_is_const_val(op->args[1], 0) && op->args[3] == 0) {
         uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
 
         op->opc = and_opc;
@@ -1461,8 +1470,7 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
     }
 
     /* Inserting zero into a value. */
-    if (arg_is_const(op->args[2])
-        && arg_info(op->args[2])->val == 0) {
+    if (arg_is_const_val(op->args[2], 0)) {
         uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
 
         op->opc = and_opc;
@@ -2000,8 +2008,8 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
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


