Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DBE7DA90B
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFs-0004nz-9O; Sat, 28 Oct 2023 15:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFX-0004ie-J7
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:35 -0400
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFU-00046S-Ir
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:35 -0400
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so97169139f.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522330; x=1699127130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k5lsHDsasK4zIrruyQZlXl4wlS973HJoMzMc8iwOmM4=;
 b=yzpQrP4wpnU9pgkOoqER6fXyN3hbtTHTtczyGf/R0X/XF4KWYJo8y1QeJPm92d4F/8
 oGcspEW9Q9MKqPW/6EGG8u1MgJqaw/GIlvCtaN3CM0HNyDewVYJoSDZidmbpPfNJIGMb
 sfU1vgB6J66ToQGnXVfFJRwNxcICTc+rpxJxhZ0rc1UoAvTIITgUP6eT4H2Wqh4OVjlb
 T7j1ZDoHTodeS0FrUwjnKizgkoIhO7kqiUaEe4sFLFwy2HQbA32m/gyNsOr2h4BU68ry
 ZaTrOPJIj/z8ShXI03lp/1Z5I5xYT3wD5HLOsXCFSpxMV+mYt83F6x0q41W/Md+COocT
 6meA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522330; x=1699127130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5lsHDsasK4zIrruyQZlXl4wlS973HJoMzMc8iwOmM4=;
 b=sAegQKBwVxcXkAaldvoPK+MH8tLUpR+6/NBM8O3qFsDB7K5RapVbkMTo3XkBIpXhln
 wy2Xg1ASxxYJ6/UUpyQo/GQ+3pejqS5i520an3KcLK+33MRVFVYNcBTE+uFKQI+LGHEZ
 a+RPdC1BPna25TFQoTrnMooSYh+NCKdg33dAYovxnccUrKFomnnDLUZozUoux/PySRu3
 OBhHwnldcNgUvqw9hm/PMIXyv7Bjjmd9Q204rxCkiY6Aydb33NWUPVmt4M9POKeC5lMV
 n5BYfG7ckV66YX83ozK8vB3u1522ngUnSJzQiKqCSbdl0fI0/DL7azg/iWcvgWJTW4Ha
 GjIQ==
X-Gm-Message-State: AOJu0YxTXjp5wdkV1wDwwtQCaOT7FdwoUw6MFWfqruyEHHQRNVQuZ/s+
 vTZeNc8tLciVPSSGkLMP4eEs3MqthrqQH2cTXaM=
X-Google-Smtp-Source: AGHT+IGY/WpQVHw0Ya+CVSbs96C4B7wXcWmYdOdGNhUu6oTyE3DXpwSwQanwZFdg/Cl9Hm/wZcagGg==
X-Received: by 2002:a05:6e02:1be7:b0:357:a25a:572a with SMTP id
 y7-20020a056e021be700b00357a25a572amr9930623ilv.21.1698522330043; 
 Sat, 28 Oct 2023 12:45:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 06/35] tcg/optimize: Handle TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:44:53 -0700
Message-Id: <20231028194522.245170-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d30;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd30.google.com
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

Fold constant comparisons.
Canonicalize "tst x,x" to equality vs zero.
Canonicalize "tst x,sign" to sign test vs zero.
Fold double-word comparisons with zero parts.
Fold setcond of "tst x,pow2" to a bit extract.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 245 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 223 insertions(+), 22 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2f2d1c3001..891c28acef 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -508,9 +508,15 @@ static bool do_constant_folding_cond_32(uint32_t x, uint32_t y, TCGCond c)
         return x <= y;
     case TCG_COND_GTU:
         return x > y;
-    default:
-        g_assert_not_reached();
+    case TCG_COND_TSTEQ:
+        return (x & y) == 0;
+    case TCG_COND_TSTNE:
+        return (x & y) != 0;
+    case TCG_COND_ALWAYS:
+    case TCG_COND_NEVER:
+        break;
     }
+    g_assert_not_reached();
 }
 
 static bool do_constant_folding_cond_64(uint64_t x, uint64_t y, TCGCond c)
@@ -536,12 +542,18 @@ static bool do_constant_folding_cond_64(uint64_t x, uint64_t y, TCGCond c)
         return x <= y;
     case TCG_COND_GTU:
         return x > y;
-    default:
-        g_assert_not_reached();
+    case TCG_COND_TSTEQ:
+        return (x & y) == 0;
+    case TCG_COND_TSTNE:
+        return (x & y) != 0;
+    case TCG_COND_ALWAYS:
+    case TCG_COND_NEVER:
+        break;
     }
+    g_assert_not_reached();
 }
 
-static bool do_constant_folding_cond_eq(TCGCond c)
+static int do_constant_folding_cond_eq(TCGCond c)
 {
     switch (c) {
     case TCG_COND_GT:
@@ -556,9 +568,14 @@ static bool do_constant_folding_cond_eq(TCGCond c)
     case TCG_COND_LEU:
     case TCG_COND_EQ:
         return 1;
-    default:
-        g_assert_not_reached();
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        return -1;
+    case TCG_COND_ALWAYS:
+    case TCG_COND_NEVER:
+        break;
     }
+    g_assert_not_reached();
 }
 
 /*
@@ -586,8 +603,10 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
     } else if (arg_is_const_val(y, 0)) {
         switch (c) {
         case TCG_COND_LTU:
+        case TCG_COND_TSTNE:
             return 0;
         case TCG_COND_GEU:
+        case TCG_COND_TSTEQ:
             return 1;
         default:
             return -1;
@@ -660,7 +679,30 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
     }
 
     r = do_constant_folding_cond(ctx->type, *p1, *p2, cond);
-    return r;
+    if (r >= 0) {
+        return r;
+    }
+    if (!is_tst_cond(cond)) {
+        return -1;
+    }
+
+    /*
+     * TSTNE x,x -> NE x,0
+     * TSTNE x,-1 -> NE x,0
+     */
+    if (args_are_copies(*p1, *p2) || arg_is_const_val(*p2, -1)) {
+        *p2 = arg_new_constant(ctx, 0);
+        *pcond = tcg_tst_eqne_cond(cond);
+        return -1;
+    }
+
+    /* TSTNE x,sign -> LT x,0 */
+    if (arg_is_const_val(*p2, (ctx->type == TCG_TYPE_I32
+                               ? INT32_MIN : INT64_MIN))) {
+        *p2 = arg_new_constant(ctx, 0);
+        *pcond = tcg_tst_ltge_cond(cond);
+    }
+    return -1;
 }
 
 static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
@@ -668,6 +710,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
     TCGArg al, ah, bl, bh;
     TCGCond c;
     bool swap;
+    int r;
 
     swap = swap_commutative2(args, args + 2);
     c = args[4];
@@ -689,21 +732,54 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
             tcg_target_ulong alv = arg_info(al)->val;
             tcg_target_ulong ahv = arg_info(ah)->val;
             uint64_t a = deposit64(alv, 32, 32, ahv);
-            return do_constant_folding_cond_64(a, b, c);
+
+            r = do_constant_folding_cond_64(a, b, c);
+            if (r >= 0) {
+                return r;
+            }
         }
+
         if (b == 0) {
             switch (c) {
             case TCG_COND_LTU:
+            case TCG_COND_TSTNE:
                 return 0;
             case TCG_COND_GEU:
+            case TCG_COND_TSTEQ:
                 return 1;
             default:
                 break;
             }
         }
+
+        /* TSTNE x,-1 -> NE x,0 */
+        if (b == -1 && is_tst_cond(c)) {
+            args[3] = args[2] = arg_new_constant(ctx, 0);
+            args[4] = tcg_tst_eqne_cond(c);
+            return -1;
+        }
+
+        /* TSTNE x,sign -> LT x,0 */
+        if (b == INT64_MIN && is_tst_cond(c)) {
+            /* bl must be 0, so copy that to bh */
+            args[3] = bl;
+            args[4] = tcg_tst_ltge_cond(c);
+            return -1;
+        }
     }
+
     if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
-        return do_constant_folding_cond_eq(c);
+        r = do_constant_folding_cond_eq(c);
+        if (r >= 0) {
+            return r;
+        }
+
+        /* TSTNE x,x -> NE x,0 */
+        if (is_tst_cond(c)) {
+            args[3] = args[2] = arg_new_constant(ctx, 0);
+            args[4] = tcg_tst_eqne_cond(c);
+            return -1;
+        }
     }
     return -1;
 }
@@ -1151,24 +1227,37 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
         case 0:
             goto do_brcond_const;
         case 1:
-            op->opc = INDEX_op_brcond_i32;
-            op->args[1] = op->args[2];
-            op->args[2] = cond;
-            op->args[3] = label;
-            break;
+            goto do_brcond_low;
+        }
+        break;
+
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (arg_is_const_val(op->args[2], 0)) {
+            goto do_brcond_high;
+        }
+        if (arg_is_const_val(op->args[3], 0)) {
+            goto do_brcond_low;
         }
         break;
 
     default:
         break;
 
+    do_brcond_low:
+        op->opc = INDEX_op_brcond_i32;
+        op->args[1] = op->args[2];
+        op->args[2] = cond;
+        op->args[3] = label;
+        return fold_brcond(ctx, op);
+
     do_brcond_high:
         op->opc = INDEX_op_brcond_i32;
         op->args[0] = op->args[1];
         op->args[1] = op->args[3];
         op->args[2] = cond;
         op->args[3] = label;
-        break;
+        return fold_brcond(ctx, op);
 
     do_brcond_const:
         if (i == 0) {
@@ -1829,6 +1918,104 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
+{
+    TCGOpcode and_opc, sub_opc, xor_opc, neg_opc, shr_opc, uext_opc, sext_opc;
+    TCGCond cond = op->args[3];
+    TCGArg ret, src1, src2;
+    TCGOp *op2;
+    uint64_t val;
+    int sh;
+    bool inv;
+
+    if (!is_tst_cond(cond) || !arg_is_const(op->args[2])) {
+        return;
+    }
+
+    src2 = op->args[2];
+    val = arg_info(src2)->val;
+    if (!is_power_of_2(val)) {
+        return;
+    }
+    sh = ctz64(val);
+
+    switch (ctx->type) {
+    case TCG_TYPE_I32:
+        and_opc = INDEX_op_and_i32;
+        sub_opc = INDEX_op_sub_i32;
+        xor_opc = INDEX_op_xor_i32;
+        shr_opc = INDEX_op_shr_i32;
+        neg_opc = TCG_TARGET_HAS_neg_i32 ? INDEX_op_neg_i32 : 0;
+        if (TCG_TARGET_extract_i32_valid(sh, 1)) {
+            uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
+            sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
+        }
+        break;
+    case TCG_TYPE_I64:
+        and_opc = INDEX_op_and_i64;
+        sub_opc = INDEX_op_sub_i64;
+        xor_opc = INDEX_op_xor_i64;
+        shr_opc = INDEX_op_shr_i64;
+        neg_opc = TCG_TARGET_HAS_neg_i64 ? INDEX_op_neg_i64 : 0;
+        if (TCG_TARGET_extract_i64_valid(sh, 1)) {
+            uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
+            sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    ret = op->args[0];
+    src1 = op->args[1];
+    inv = cond == TCG_COND_TSTEQ;
+
+    if (sh && sext_opc && neg && !inv) {
+        op->opc = sext_opc;
+        op->args[1] = src1;
+        op->args[2] = sh;
+        op->args[3] = 1;
+        return;
+    } else if (sh && uext_opc) {
+        op->opc = uext_opc;
+        op->args[1] = src1;
+        op->args[2] = sh;
+        op->args[3] = 1;
+    } else {
+        if (sh) {
+            op2 = tcg_op_insert_before(ctx->tcg, op, shr_opc, 3);
+            op2->args[0] = ret;
+            op2->args[1] = src1;
+            op2->args[2] = arg_new_constant(ctx, sh);
+            src1 = ret;
+        }
+        op->opc = and_opc;
+        op->args[1] = src1;
+        op->args[2] = arg_new_constant(ctx, 1);
+    }
+
+    if (neg && inv) {
+        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2->args[0] = ret;
+        op2->args[1] = ret;
+        op2->args[2] = arg_new_constant(ctx, 1);
+    } else if (inv) {
+        op2 = tcg_op_insert_after(ctx->tcg, op, xor_opc, 3);
+        op2->args[0] = ret;
+        op2->args[1] = ret;
+        op2->args[2] = arg_new_constant(ctx, 1);
+    } else if (neg && neg_opc) {
+        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2->args[0] = ret;
+        op2->args[1] = ret;
+    } else if (neg) {
+        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
+        op2->args[0] = ret;
+        op2->args[1] = arg_new_constant(ctx, 0);
+        op2->args[2] = ret;
+    }
+}
+
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
     int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
@@ -1836,6 +2023,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
+    fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
     ctx->s_mask = smask_from_zmask(1);
@@ -1849,13 +2037,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
     }
+    fold_setcond_tst_pow2(ctx, op, true);
 
     /* Value is {0,-1} so all bits are repetitions of the sign. */
     ctx->s_mask = -1;
     return false;
 }
 
-
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 {
     TCGCond cond;
@@ -1903,22 +2091,35 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
         case 0:
             goto do_setcond_const;
         case 1:
-            op->args[2] = op->args[3];
-            op->args[3] = cond;
-            op->opc = INDEX_op_setcond_i32;
-            break;
+            goto do_setcond_low;
+        }
+        break;
+
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (arg_is_const_val(op->args[2], 0)) {
+            goto do_setcond_high;
+        }
+        if (arg_is_const_val(op->args[4], 0)) {
+            goto do_setcond_low;
         }
         break;
 
     default:
         break;
 
+    do_setcond_low:
+        op->args[2] = op->args[3];
+        op->args[3] = cond;
+        op->opc = INDEX_op_setcond_i32;
+        return fold_setcond(ctx, op);
+
     do_setcond_high:
         op->args[1] = op->args[2];
         op->args[2] = op->args[4];
         op->args[3] = cond;
         op->opc = INDEX_op_setcond_i32;
-        break;
+        return fold_setcond(ctx, op);
     }
 
     ctx->z_mask = 1;
-- 
2.34.1


