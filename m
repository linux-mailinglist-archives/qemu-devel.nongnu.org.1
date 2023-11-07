Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E69447E3354
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:55:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9R-0008Qv-3f; Mon, 06 Nov 2023 21:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9O-0008Pn-9W
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:10 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9M-0005vz-5q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:09 -0500
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3b2ea7cca04so3341372b6e.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325347; x=1699930147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8jIe+ljgU19ERgfvxJVRf4ZOPpcLIdY66wFze/QZuDU=;
 b=bIZ+gDpo8eLnZHal3RRvk96PQ5twnxFWSFqD+RsXAy4YT1un+fzBZPQKAH5q4kFm6N
 09Vw7ONRtNf9bu7G4yEgmVc0zeYDw9FwSN4wwSdWsKaQeFrnHZZfTGRdTxsDQeZmmR6C
 WG4UYbG9UvGQZTfw8STFA+N65w4yC0sMegmLGj5kq5A5gLWr1+QxxeUPAABPNrmd5MhM
 IPvL3LHkN7riXzT0+9xfaJ/rZPbcdyKAzoLs6chmR28HKqcj0f4fUmD//BKfkhM54YYD
 orY5zXsLIAYBXP4FwPbPbmWULyt3hBMYG73ji8SdSA+GEVXmnhmGSHRwjr4ykemuFd8d
 7kAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325347; x=1699930147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8jIe+ljgU19ERgfvxJVRf4ZOPpcLIdY66wFze/QZuDU=;
 b=RFe2NHpmHJe3AYx6bOOH8Cjmhjq2Gu/oQqpySyNtiLRQI4L0mAYplH1jzaziChbIMh
 KnhEhilKeNbnjfsWYSoKqLA4McP3tGmJQ/gEfTZ5EsBXw/f55avUoQ9fWSJ4j8b4f4dV
 3oGIL5s2UK2mu10drnFR6zef723kmerEZJx03pE2k0gQuQEYcKvWlnDE9gt5rqQhL8nN
 KJMsJZvd6S/jAPgkxJt9xco2un/AqDee75riYv9+2Z+v82hAfUKJwPdlAGj0/vQfjiGX
 VODNXCXcpyy5i0O3saxKg9B9Vz9vye5kPS/2osEuDAmJLe7kHnq8JieqdZHgM0Tn3fSr
 5vQw==
X-Gm-Message-State: AOJu0YwC1hcx73LANVRdfPcjeD21klz70OdUXiDyxkO4x8g65jWT5DsZ
 XerHipNkvXYakc7HW1SdD1OIOmvzs5vqV9bXyiM=
X-Google-Smtp-Source: AGHT+IGKdzK+1+yCBjZ4PF9TzPf77GrhxLYjVYxCA5DKT/wC4cj/CGIlDfg1M2SdOdxfiFZlOZQqaA==
X-Received: by 2002:a05:6808:23c3:b0:3b2:f2a8:1a4c with SMTP id
 bq3-20020a05680823c300b003b2f2a81a4cmr39844049oib.44.1699325347161; 
 Mon, 06 Nov 2023 18:49:07 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PATCH 29/35] tcg/optimize: Optimize env memory operations
Date: Mon,  6 Nov 2023 18:48:36 -0800
Message-Id: <20231107024842.7650-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
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

Propagate stores to loads, loads to loads.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 264 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 243 insertions(+), 21 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 118561f56d..b32ef0be0f 100644
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
@@ -127,27 +139,6 @@ static TCGTemp *cmp_better_copy(TCGTemp *a, TCGTemp *b)
     return a->kind < b->kind ? b : a;
 }
 
-/* Reset TEMP's state, possibly removing the temp for the list of copies.  */
-static void reset_ts(OptContext *ctx, TCGTemp *ts)
-{
-    TempOptInfo *ti = ts_info(ts);
-    TempOptInfo *pi = ts_info(ti->prev_copy);
-    TempOptInfo *ni = ts_info(ti->next_copy);
-
-    ni->prev_copy = ti->prev_copy;
-    pi->next_copy = ti->next_copy;
-    ti->next_copy = ts;
-    ti->prev_copy = ts;
-    ti->is_const = false;
-    ti->z_mask = -1;
-    ti->s_mask = 0;
-}
-
-static void reset_temp(OptContext *ctx, TCGArg arg)
-{
-    reset_ts(ctx, arg_temp(arg));
-}
-
 /* Initialize and activate a temporary.  */
 static void init_ts_info(OptContext *ctx, TCGTemp *ts)
 {
@@ -167,6 +158,7 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
 
     ti->next_copy = ts;
     ti->prev_copy = ts;
+    QSIMPLEQ_INIT(&ti->mem_copy);
     if (ts->kind == TEMP_CONST) {
         ti->is_const = true;
         ti->val = ts->val;
@@ -179,6 +171,45 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
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
 static TCGTemp *find_better_copy(TCGTemp *ts)
 {
     TCGTemp *i, *ret;
@@ -195,6 +226,80 @@ static TCGTemp *find_better_copy(TCGTemp *ts)
     return ret;
 }
 
+static void move_mem_copies(TCGTemp *dst_ts, TCGTemp *src_ts)
+{
+    TempOptInfo *si = ts_info(src_ts);
+    TempOptInfo *di = ts_info(dst_ts);
+    MemCopyInfo *mc;
+
+    QSIMPLEQ_FOREACH(mc, &si->mem_copy, next) {
+        tcg_debug_assert(mc->ts == src_ts);
+        mc->ts = dst_ts;
+    }
+    QSIMPLEQ_CONCAT(&di->mem_copy, &si->mem_copy);
+}
+
+/* Reset TEMP's state, possibly removing the temp for the list of copies.  */
+static void reset_ts(OptContext *ctx, TCGTemp *ts)
+{
+    TempOptInfo *ti = ts_info(ts);
+    TCGTemp *pts = ti->prev_copy;
+    TCGTemp *nts = ti->next_copy;
+    TempOptInfo *pi = ts_info(pts);
+    TempOptInfo *ni = ts_info(nts);
+
+    ni->prev_copy = ti->prev_copy;
+    pi->next_copy = ti->next_copy;
+    ti->next_copy = ts;
+    ti->prev_copy = ts;
+    ti->is_const = false;
+    ti->z_mask = -1;
+    ti->s_mask = 0;
+
+    if (!QSIMPLEQ_EMPTY(&ti->mem_copy)) {
+        if (ts == nts) {
+            /* Last temp copy being removed, the mem copies die. */
+            MemCopyInfo *mc;
+            QSIMPLEQ_FOREACH(mc, &ti->mem_copy, next) {
+                interval_tree_remove(&mc->itree, &ctx->mem_copy);
+            }
+            QSIMPLEQ_CONCAT(&ctx->mem_free, &ti->mem_copy);
+        } else {
+            move_mem_copies(find_better_copy(nts), ts);
+        }
+    }
+}
+
+static void reset_temp(OptContext *ctx, TCGArg arg)
+{
+    reset_ts(ctx, arg_temp(arg));
+}
+
+static void record_mem_copy(OptContext *ctx, TCGType type,
+                            TCGTemp *ts, intptr_t start, intptr_t last)
+{
+    MemCopyInfo *mc;
+    TempOptInfo *ti;
+
+    mc = QSIMPLEQ_FIRST(&ctx->mem_free);
+    if (mc) {
+        QSIMPLEQ_REMOVE_HEAD(&ctx->mem_free, next);
+    } else {
+        mc = tcg_malloc(sizeof(*mc));
+    }
+
+    memset(mc, 0, sizeof(*mc));
+    mc->itree.start = start;
+    mc->itree.last = last;
+    mc->type = type;
+    interval_tree_insert(&mc->itree, &ctx->mem_copy);
+
+    ts = find_better_copy(ts);
+    ti = ts_info(ts);
+    mc->ts = ts;
+    QSIMPLEQ_INSERT_TAIL(&ti->mem_copy, mc, next);
+}
+
 static bool ts_are_copies(TCGTemp *ts1, TCGTemp *ts2)
 {
     TCGTemp *i;
@@ -221,6 +326,18 @@ static bool args_are_copies(TCGArg arg1, TCGArg arg2)
     return ts_are_copies(arg_temp(arg1), arg_temp(arg2));
 }
 
+static TCGTemp *find_mem_copy_for(OptContext *ctx, TCGType type, intptr_t s)
+{
+    MemCopyInfo *mc;
+
+    for (mc = mem_copy_first(ctx, s, s); mc; mc = mem_copy_next(mc, s, s)) {
+        if (mc->itree.start == s && mc->type == type) {
+            return find_better_copy(mc->ts);
+        }
+    }
+    return NULL;
+}
+
 static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
 {
     TCGTemp *dst_ts = arg_temp(dst);
@@ -270,6 +387,11 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         si->next_copy = dst_ts;
         di->is_const = si->is_const;
         di->val = si->val;
+
+        if (!QSIMPLEQ_EMPTY(&si->mem_copy)
+            && cmp_better_copy(src_ts, dst_ts) == dst_ts) {
+            move_mem_copies(dst_ts, src_ts);
+        }
     }
     return true;
 }
@@ -688,6 +810,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
         ctx->prev_mb = NULL;
         if (!(def->flags & TCG_OPF_COND_BRANCH)) {
             memset(&ctx->temps_used, 0, sizeof(ctx->temps_used));
+            remove_mem_copy_all(ctx);
         }
         return;
     }
@@ -1213,6 +1336,11 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
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
@@ -2070,6 +2198,83 @@ static bool fold_tcg_ld(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static bool fold_tcg_ld_memcopy(OptContext *ctx, TCGOp *op)
+{
+    TCGTemp *dst, *src;
+    intptr_t ofs;
+    TCGType type;
+
+    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
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
+    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
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
+    if (op->args[1] != tcgv_ptr_arg(tcg_env)) {
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
@@ -2093,6 +2298,8 @@ void tcg_optimize(TCGContext *s)
     TCGOp *op, *op_next;
     OptContext ctx = { .tcg = s };
 
+    QSIMPLEQ_INIT(&ctx.mem_free);
+
     /* Array VALS has an element for each temp.
        If this temp holds a constant then its value is kept in VALS' element.
        If this temp is a copy of other ones then the other copies are
@@ -2214,6 +2421,21 @@ void tcg_optimize(TCGContext *s)
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


