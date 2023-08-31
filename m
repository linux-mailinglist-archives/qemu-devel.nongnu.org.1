Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8B678E4DE
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXsM-0004tm-3j; Wed, 30 Aug 2023 22:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsI-0004t2-Hs
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:38 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsF-0007od-QX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-269304c135aso273760a91.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 19:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693450654; x=1694055454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aChezhcTwmznOrUe1OvXxjCsUo8aXEzn0qJIindA1tY=;
 b=g2kNJu3ihPIc0fdZJx8NXfgji8+VyiT0iLZIm/tw26KgdNO1gRENXjTcZKQw+fJwgj
 McDFJLOdtpf1cwe2LtKwmWrHneuE+RJE63U/KrMQPv5n+IZ8EO726U7ioct0FvPbRLw/
 AjpKNp95HbFVHzhMY71dFe5iCLNU8c85uhravcO7lJWQyN0gN51kKpONRPN2LG+FMhrd
 cLm96IKMVTQjuDCogb4JNg0DN8kwBNhTESHcIuK8VBItER6+11D4uzmWoOiSGZbS9wh1
 TTFDLh2zCTmBLa72bFOn08X8agliA6HxnklMWRSaNCRPZ+izqbfBXPyIJudCMJwxgmYt
 Fq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450654; x=1694055454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aChezhcTwmznOrUe1OvXxjCsUo8aXEzn0qJIindA1tY=;
 b=ScQDOy2bmv8CitrnmAnwNJ74STLTyJCTpd6AitvyzlK4epanEAsZeOfjpHzJT86o0c
 2YSniFBFJ8ipO0WlcudkPWEvrv7usYZiS6PMw4BxxYcQgBxFO+r+DJpiRupBaV1R2dgw
 V6230cCDh3uO1Jdfbuis8SVoWKkw6iicG6esMFtxgNHKFmkXs5Ev6JtXs54McENWCfyV
 SBGL0twEDggGCnK/hHBn/1brfqOmT5RdyyPkDr6Wk17oSLvQ7EIeTMZsAEl29cUzaD4u
 olwFkGTRcP39c+G4TbCJr/n85/fLZypEdDMDMbeG4RKRVUO94YTia/dCh+PTT+uZSr03
 hK4w==
X-Gm-Message-State: AOJu0Yyhq22M/lV+DltGfhekaJigcl+DzqFDbf58l+86BH/qyD5mwJTY
 sA1I5BPmLb1nc7+w7sEN/2S62e0CpkugFEed278=
X-Google-Smtp-Source: AGHT+IGJyA9xV1f2ftPyxQPaONw60eUhNc9chErZfHc2uCQwIr0Swi8g1KDh4hjD2BRKBYw7pCuwcQ==
X-Received: by 2002:a17:90a:6945:b0:269:1d16:25fa with SMTP id
 j5-20020a17090a694500b002691d1625famr3934195pjm.12.1693450654044; 
 Wed, 30 Aug 2023 19:57:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm288142pjb.4.2023.08.30.19.57.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:57:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/4] tcg: Optimize env memory operations
Date: Wed, 30 Aug 2023 19:57:28 -0700
Message-Id: <20230831025729.1194388-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Propagate stores to loads, loads to loads.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 199 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index f00db3aa38..51c4c61b9f 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -25,6 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/int128.h"
+#include "qemu/interval-tree.h"
 #include "tcg/tcg-op-common.h"
 #include "tcg-internal.h"
 
@@ -37,10 +38,18 @@
         glue(glue(case INDEX_op_, x), _i64):    \
         glue(glue(case INDEX_op_, x), _vec)
 
+typedef struct MemCopyInfo {
+    IntervalTreeNode itree;
+    QSIMPLEQ_ENTRY (MemCopyInfo) next;
+    TCGTemp *ts;
+    TCGType type;
+} MemCopyInfo;
+
 typedef struct TempOptInfo {
     bool is_const;
     TCGTemp *prev_copy;
     TCGTemp *next_copy;
+    QSIMPLEQ_HEAD(, MemCopyInfo) mem_copy;
     uint64_t val;
     uint64_t z_mask;  /* mask bit is 0 if and only if value bit is 0 */
     uint64_t s_mask;  /* a left-aligned mask of clrsb(value) bits. */
@@ -51,6 +60,9 @@ typedef struct OptContext {
     TCGOp *prev_mb;
     TCGTempSet temps_used;
 
+    IntervalTreeRoot mem_copy;
+    QSIMPLEQ_HEAD(, MemCopyInfo) mem_free;
+
     /* In flight values from optimization. */
     uint64_t a_mask;  /* mask bit is 0 iff value identical to first input */
     uint64_t z_mask;  /* mask bit is 0 iff value bit is 0 */
@@ -128,6 +140,7 @@ static void reset_ts(OptContext *ctx, TCGTemp *ts)
     TempOptInfo *ti = ts_info(ts);
     TempOptInfo *pi = ts_info(ti->prev_copy);
     TempOptInfo *ni = ts_info(ti->next_copy);
+    MemCopyInfo *mc;
 
     ni->prev_copy = ti->prev_copy;
     pi->next_copy = ti->next_copy;
@@ -136,6 +149,11 @@ static void reset_ts(OptContext *ctx, TCGTemp *ts)
     ti->is_const = false;
     ti->z_mask = -1;
     ti->s_mask = 0;
+
+    QSIMPLEQ_FOREACH(mc, &ti->mem_copy, next) {
+        interval_tree_remove(&mc->itree, &ctx->mem_copy);
+    }
+    QSIMPLEQ_CONCAT(&ctx->mem_free, &ti->mem_copy);
 }
 
 static void reset_temp(OptContext *ctx, TCGArg arg)
@@ -162,6 +180,7 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
 
     ti->next_copy = ts;
     ti->prev_copy = ts;
+    QSIMPLEQ_INIT(&ti->mem_copy);
     if (ts->kind == TEMP_CONST) {
         ti->is_const = true;
         ti->val = ts->val;
@@ -174,6 +193,68 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
     }
 }
 
+static MemCopyInfo *mem_copy_first(OptContext *ctx, intptr_t s, intptr_t l)
+{
+    IntervalTreeNode *r = interval_tree_iter_first(&ctx->mem_copy, s, l);
+    return r ? container_of(r, MemCopyInfo, itree) : NULL;
+}
+
+static MemCopyInfo *mem_copy_next(MemCopyInfo *mem, intptr_t s, intptr_t l)
+{
+    IntervalTreeNode *r = interval_tree_iter_next(&mem->itree, s, l);
+    return r ? container_of(r, MemCopyInfo, itree) : NULL;
+}
+
+static void remove_mem_copy(OptContext *ctx, MemCopyInfo *mc)
+{
+    TCGTemp *ts = mc->ts;
+    TempOptInfo *ti = ts_info(ts);
+
+    interval_tree_remove(&mc->itree, &ctx->mem_copy);
+    QSIMPLEQ_REMOVE(&ti->mem_copy, mc, MemCopyInfo, next);
+    QSIMPLEQ_INSERT_TAIL(&ctx->mem_free, mc, next);
+}
+
+static void remove_mem_copy_in(OptContext *ctx, intptr_t s, intptr_t l)
+{
+    while (true) {
+        MemCopyInfo *mc = mem_copy_first(ctx, s, l);
+        if (!mc) {
+            break;
+        }
+        remove_mem_copy(ctx, mc);
+    }
+}
+
+static void remove_mem_copy_all(OptContext *ctx)
+{
+    remove_mem_copy_in(ctx, 0, -1);
+    tcg_debug_assert(interval_tree_is_empty(&ctx->mem_copy));
+}
+
+static void record_mem_copy(OptContext *ctx, TCGType type,
+                            TCGTemp *ts, intptr_t start, intptr_t last)
+{
+    MemCopyInfo *mc;
+    TempOptInfo *ti = ts_info(ts);
+
+    mc = QSIMPLEQ_FIRST(&ctx->mem_free);
+    if (mc) {
+        QSIMPLEQ_REMOVE_HEAD(&ctx->mem_free, next);
+    } else {
+        mc = tcg_malloc(sizeof(*mc));
+    }
+
+    memset(mc, 0, sizeof(*mc));
+    mc->type = type;
+    mc->ts = ts;
+    mc->itree.start = start;
+    mc->itree.last = last;
+
+    interval_tree_insert(&mc->itree, &ctx->mem_copy);
+    QSIMPLEQ_INSERT_TAIL(&ti->mem_copy, mc, next);
+}
+
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
 {
     TCGTemp *i, *g, *l;
@@ -226,6 +307,18 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg2)
     return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
 }
 
+static TCGTemp *find_mem_copy_for(OptContext *ctx, TCGType type, intptr_t s)
+{
+    MemCopyInfo *mc;
+
+    for (mc = mem_copy_first(ctx, s, s); mc; mc = mem_copy_next(mc, s, s)) {
+        if (mc->itree.start == s && mc->type == type) {
+            return find_better_copy(ctx->tcg, mc->ts);
+        }
+    }
+    return NULL;
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -268,6 +361,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 
     if (src_ts->type == dst_ts->type) {
         TempOptInfo *ni = ts_info(si->next_copy);
+        MemCopyInfo *mc;
 
         di->next_copy = si->next_copy;
         di->prev_copy = src_ts;
@@ -275,6 +369,11 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         si->next_copy = dst_ts;
         di->is_const = si->is_const;
         di->val = si->val;
+
+        QSIMPLEQ_FOREACH(mc, &si->mem_copy, next) {
+            record_mem_copy(ctx, mc->type, dst_ts,
+                            mc->itree.start, mc->itree.last);
+        }
     }
     return true;
 }
@@ -693,6 +792,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
      */
     if (def->flags & TCG_OPF_BB_END) {
         memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+        remove_mem_copy_all(ctx);
         ctx->prev_mb = NULL;
         return;
     }
@@ -1218,6 +1318,11 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
         }
     }
 
+    /* If the function has side effects, reset mem data. */
+    if (!(flags & TCG_CALL_NO_SIDE_EFFECTS)) {
+        remove_mem_copy_all(ctx);
+    }
+
     /* Reset temp data for outputs. */
     for (i = 0; i < nb_oargs; i++) {
         reset_temp(ctx, op->args[i]);
@@ -2075,6 +2180,83 @@ static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
+{
+    TCGTemp *dst, *src;
+    intptr_t ofs;
+    TCGType type;
+
+    if (op->args[1] != tcgv_ptr_arg(cpu_env)) {
+        return false;
+    }
+
+    type = ctx->type;
+    ofs = op->args[2];
+    dst = arg_temp(op->args[0]);
+    src = find_mem_copy_for(ctx, type, ofs);
+    if (src && src->base_type == type) {
+        return tcg_opt_gen_mov(ctx, op, temp_arg(dst), temp_arg(src));
+    }
+
+    reset_ts(ctx, dst);
+    record_mem_copy(ctx, type, dst, ofs, ofs + tcg_type_size(type) - 1);
+    return true;
+}
+
+static bool fold_tcg_st(OptContext *ctx, TCGOp *op)
+{
+    intptr_t ofs = op->args[2];
+    intptr_t lm1;
+
+    if (op->args[1] != tcgv_ptr_arg(cpu_env)) {
+        remove_mem_copy_all(ctx);
+        return false;
+    }
+
+    switch (op->opc) {
+    CASE_OP_32_64(st8):
+        lm1 = 0;
+        break;
+    CASE_OP_32_64(st16):
+        lm1 = 1;
+        break;
+    case INDEX_op_st32_i64:
+    case INDEX_op_st_i32:
+        lm1 = 3;
+        break;
+    case INDEX_op_st_i64:
+        lm1 = 7;
+        break;
+    case INDEX_op_st_vec:
+        lm1 = tcg_type_size(ctx->type) - 1;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    remove_mem_copy_in(ctx, ofs, ofs + lm1);
+    return false;
+}
+
+static bool fold_tcg_st_memcopy(OptContext *ctx, TCGOp *op)
+{
+    TCGTemp *src;
+    intptr_t ofs, last;
+    TCGType type;
+
+    if (op->args[1] != tcgv_ptr_arg(cpu_env)) {
+        fold_tcg_st(ctx, op);
+        return false;
+    }
+
+    src = arg_temp(op->args[0]);
+    ofs = op->args[2];
+    type = ctx->type;
+    last = ofs + tcg_type_size(type) - 1;
+    remove_mem_copy_in(ctx, ofs, last);
+    record_mem_copy(ctx, type, src, ofs, last);
+    return false;
+}
+
 static bool fold_xor(OptContext *ctx, TCGOp *op)
 {
     if (fold_const2_commutative(ctx, op) ||
@@ -2098,6 +2280,8 @@ void tcg_optimize(TCGContext *s)
     TCGOp *op, *op_next;
     OptContext ctx = { .tcg = s };
 
+    QSIMPLEQ_INIT(&ctx.mem_free);
+
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
        If this temp is a copy of other ones then the other copies are
@@ -2219,6 +2403,21 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_ld32u_i64:
             done = fold_tcg_ld(&ctx, op);
             break;
+        case INDEX_op_ld_i32:
+        case INDEX_op_ld_i64:
+        case INDEX_op_ld_vec:
+            done = fold_tcg_ld_memcopy(&ctx, op);
+            break;
+        CASE_OP_32_64(st8):
+        CASE_OP_32_64(st16):
+        case INDEX_op_st32_i64:
+            done = fold_tcg_st(&ctx, op);
+            break;
+        case INDEX_op_st_i32:
+        case INDEX_op_st_i64:
+        case INDEX_op_st_vec:
+            done = fold_tcg_st_memcopy(&ctx, op);
+            break;
         case INDEX_op_mb:
             done = fold_mb(&ctx, op);
             break;
-- 
2.34.1


