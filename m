Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DE382A41F
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:45:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhK9-0004da-G5; Wed, 10 Jan 2024 17:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJz-0004cn-Fc
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:15 -0500
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJx-0002uL-LF
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:15 -0500
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-429c00bf0efso736131cf.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926712; x=1705531512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y2ce6D5ByMe3tDiT00xgPKeYRv8+A16TaFSE/MtfeS0=;
 b=VFS39RS0y8vYnEcaMFmr/G+2y5leAv0vEgk6LgnXLJyijUD7Q3C//I8L4yIYuDYCvb
 7Sa9viokTUv2I722qHFo+Uw3WAdtrd2e04PEHUcNJBHkTphSKvaVqLnNF2fM+XXYQ1ln
 vPFN7pa8dloRpYgZ/DsZCuKLKGJfr/u5zJPOzNyW9+kROsOe30uRxXvgG8ddg8KinJk+
 0BV9W3Elg5TEIkaxxrOBS3gbebUSm28YXxWKTSSOXVDrp16jWvccfdV92ftUoAyY1eN6
 8vFXz2MEPpXWpneBG1gbxCsKXsENtMeqmP9XYkx7T7fGSa2v2MUh/ecZzLG4p+emBhRk
 Aqbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926712; x=1705531512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y2ce6D5ByMe3tDiT00xgPKeYRv8+A16TaFSE/MtfeS0=;
 b=F4IGCEqN1Qad0muBofixZPj1RjR7mtIpt2cGdKC41hgdM4TIcYfENsdiaikaGADOpq
 f2W2TWQn0QwPtzMSj3MLCaZINwH27CbkEl3zlyvOKcP0jakD33EgYP2SYU7n8DtklMiU
 mbfnD+M5Y6GTT1h1Wv4qQPNpY7B3QeaokCZnzOcyBCpXmor3GQMbze+4YmOAd6g6aVtm
 acquU5JNkOjIjj7q0aRp7jqP/iPUuRpM2ZFAh7WogSXTL2NsAkn5L+TYXEIiKju48S3o
 ZtkQv4PfFTuL21NPevYxjpycpwswrg2dIeom+7Gz68vrX5mmjqOBNQl9GQXosr5Onq5f
 6q7A==
X-Gm-Message-State: AOJu0Yxb+RpNxlD0OO5vtbwrZQ7W0pZAX1k3a5NDgmU/YIbCx96vT0E8
 22Go8NKrhyuSNGkqS8IdLSWwJTjum9TUsbn0Au7D0jzoIMVA6TRT
X-Google-Smtp-Source: AGHT+IHdKv3jBs+ypfoFgSjfogUm9LKhVW+JE9Dq65WGNk8GxePySztDJmRzQONs+bztmo/ZbU7ryw==
X-Received: by 2002:ac8:7fcd:0:b0:429:a1e3:d036 with SMTP id
 b13-20020ac87fcd000000b00429a1e3d036mr358917qtk.47.1704926712499; 
 Wed, 10 Jan 2024 14:45:12 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 07/38] tcg/optimize: Lower TCG_COND_TST{EQ,
 NE} if unsupported
Date: Thu, 11 Jan 2024 09:43:37 +1100
Message-Id: <20240110224408.10444-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82b.google.com
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

After having performed other simplifications, lower any
remaining test comparisons with AND.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h |  2 ++
 tcg/optimize.c     | 60 +++++++++++++++++++++++++++++++++++++++-------
 tcg/tcg.c          |  2 +-
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 6c9d9e48db..9b0d982f65 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,6 +83,8 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
+
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2ed6322f97..79e701652b 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -364,6 +364,13 @@ static TCGArg arg_new_constant(OptContext *ctx, uint64_t val)
     return temp_arg(ts);
 }
 
+static TCGArg arg_new_temp(OptContext *ctx)
+{
+    TCGTemp *ts = tcg_temp_new_internal(ctx->type, TEMP_EBB);
+    init_ts_info(ctx, ts);
+    return temp_arg(ts);
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -782,7 +789,7 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
  * Return -1 if the condition can't be simplified,
  * and the result of the condition (0 or 1) if it can.
  */
-static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
+static int do_constant_folding_cond1(OptContext *ctx, TCGOp *op, TCGArg dest,
                                      TCGArg *p1, TCGArg *p2, TCGArg *pcond)
 {
     TCGCond cond;
@@ -818,11 +825,28 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                ? INT32_MIN : INT64_MIN))) {
         *p2 = arg_new_constant(ctx, 0);
         *pcond = tcg_tst_ltge_cond(cond);
+        return -1;
+    }
+
+    /* Expand to AND with a temporary if no backend support. */
+    if (!TCG_TARGET_HAS_tst) {
+        TCGOpcode and_opc = (ctx->type == TCG_TYPE_I32
+                             ? INDEX_op_and_i32 : INDEX_op_and_i64);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, and_opc, 3);
+        TCGArg tmp = arg_new_temp(ctx);
+
+        op2->args[0] = tmp;
+        op2->args[1] = *p1;
+        op2->args[2] = *p2;
+
+        *p1 = tmp;
+        *p2 = arg_new_constant(ctx, 0);
+        *pcond = tcg_tst_eqne_cond(cond);
     }
     return -1;
 }
 
-static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
+static int do_constant_folding_cond2(OptContext *ctx, TCGOp *op, TCGArg *args)
 {
     TCGArg al, ah, bl, bh;
     TCGCond c;
@@ -898,6 +922,26 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
             return -1;
         }
     }
+
+    /* Expand to AND with a temporary if no backend support. */
+    if (!TCG_TARGET_HAS_tst && is_tst_cond(c)) {
+        TCGOp *op1 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGOp *op2 = tcg_op_insert_before(ctx->tcg, op, INDEX_op_and_i32, 3);
+        TCGArg t1 = arg_new_temp(ctx);
+        TCGArg t2 = arg_new_temp(ctx);
+
+        op1->args[0] = t1;
+        op1->args[1] = al;
+        op1->args[2] = bl;
+        op2->args[0] = t2;
+        op2->args[1] = ah;
+        op2->args[2] = bh;
+
+        args[0] = t1;
+        args[1] = t2;
+        args[3] = args[2] = arg_new_constant(ctx, 0);
+        args[4] = tcg_tst_eqne_cond(c);
+    }
     return -1;
 }
 
@@ -1298,7 +1342,7 @@ static bool fold_andc(OptContext *ctx, TCGOp *op)
 
 static bool fold_brcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[0],
+    int i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[0],
                                       &op->args[1], &op->args[2]);
     if (i == 0) {
         tcg_op_remove(ctx->tcg, op);
@@ -1317,7 +1361,7 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
     TCGArg label;
     int i, inv = 0;
 
-    i = do_constant_folding_cond2(ctx, &op->args[0]);
+    i = do_constant_folding_cond2(ctx, op, &op->args[0]);
     cond = op->args[4];
     label = op->args[5];
     if (i >= 0) {
@@ -1815,7 +1859,7 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         op->args[5] = tcg_invert_cond(op->args[5]);
     }
 
-    i = do_constant_folding_cond1(ctx, NO_DEST, &op->args[1],
+    i = do_constant_folding_cond1(ctx, op, NO_DEST, &op->args[1],
                                   &op->args[2], &op->args[5]);
     if (i >= 0) {
         return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[4 - i]);
@@ -2151,7 +2195,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+    int i = do_constant_folding_cond1(ctx, op, op->args[0], &op->args[1],
                                       &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
@@ -2165,7 +2209,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
 
 static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
 {
-    int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
+    int i = do_constant_folding_cond1(ctx, op, op->args[0], &op->args[1],
                                       &op->args[2], &op->args[3]);
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
@@ -2182,7 +2226,7 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
     TCGCond cond;
     int i, inv = 0;
 
-    i = do_constant_folding_cond2(ctx, &op->args[1]);
+    i = do_constant_folding_cond2(ctx, op, &op->args[1]);
     cond = op->args[5];
     if (i >= 0) {
         goto do_setcond_const;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 9d146b13aa..2f4522488a 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1655,7 +1655,7 @@ TCGv_ptr tcg_global_mem_new_ptr(TCGv_ptr reg, intptr_t off, const char *name)
     return temp_tcgv_ptr(ts);
 }
 
-static TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
+TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind)
 {
     TCGContext *s = tcg_ctx;
     TCGTemp *ts;
-- 
2.34.1


