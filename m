Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CEC82A427
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:46:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhJz-0004b9-KB; Wed, 10 Jan 2024 17:45:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJv-0004XK-7k
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:11 -0500
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhJs-0002tN-Lw
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:10 -0500
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-429be9fe952so2180471cf.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926708; x=1705531508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WPFWKge9Cibe1+P1uYI+mpRsrAd20eTdoBjuJnsUMU=;
 b=U7ihqSinGXyf4OriAo9qBxbCwk0re9yY4H2PWwYc3tUM6bw9JwIhK9bEJhHL08yM6H
 P+VdEpPQ0l76JtrCc5lQBTZAit6MbCaygnz3CgyQfGZsPhsmhKvfbH9QUKu5OFL+eBy/
 1vrjEhQf/opLbUkutkbl7vFfI/pPtG8uJeDjXfn+88rYD6XWej9ERjwRF1umf2gufvz8
 1RrPJgrFkhgDxi+bpBkqbrnpCdisPE3FSkW7QAXkUboZGh44KqHK1l4ycDT8T90JRZb3
 kU4n+Y8e8JFm1ZU0KvajZEX9pOUSro8i5kK5ASseY8rWYROHCsR1erEaTcBWsJQu5/0n
 BvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926708; x=1705531508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WPFWKge9Cibe1+P1uYI+mpRsrAd20eTdoBjuJnsUMU=;
 b=CfpUfu3Ocxj9bR4s6+ncwAxNjLG0iOSaH+qScJAXSXPImIDpvUd2oj7jag6VlDt48u
 VFYc+d8I5PzRV3BEfkUQv4xb8+tTyA7sXaynbkc/bKi5WmYyyjhBBJ3y37mkU5EP5Bst
 GMrcaew9VITS3vYDtM2jfZ01Qd7sniGdkxihDv9wqnvuzimwYQeeY0TASnyanSCb+vE2
 sVyUugbc/N3XenHqi2DJY4T8P+Y9BXsH+MxNS9O8xut+tQAutf9Pv1UcUJ9ml6is55sC
 TR8UOHFYpNZCiXtbuDi+PtYKWHGBApeTmH9+2LRUg7vP5EFYQlUPE0hWBY/KmNTHLg+9
 qw7g==
X-Gm-Message-State: AOJu0Yy3z0f1FQkbnRtBsMRXj45G9Pkmt8VOpR9Onl0kWtenJ/mRRHsO
 yEAhJIekCaYw3XVXhoqRAZh736BVIAk2ygJkAoJEWE3eK/xaaijV
X-Google-Smtp-Source: AGHT+IFEXXc9FPOw/i4DdLRSFfj45YIIwXvllfe7yDGf2oB57ZxU5gK12aqp/jDGBLDrLNFgImn24w==
X-Received: by 2002:ac8:584d:0:b0:429:8a1c:8cdd with SMTP id
 h13-20020ac8584d000000b004298a1c8cddmr1411571qth.57.1704926707734; 
 Wed, 10 Jan 2024 14:45:07 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 06/38] tcg/optimize: Handle TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:36 +1100
Message-Id: <20240110224408.10444-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

Fold constant comparisons.
Canonicalize "tst x,x" to equality vs zero.
Canonicalize "tst x,sign" to sign test vs zero.
Fold double-word comparisons with zero parts.
Fold setcond of "tst x,pow2" to a bit extract.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 240 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 218 insertions(+), 22 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 08a9280432..2ed6322f97 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -625,9 +625,15 @@ static bool do_constant_folding_cond_32(uint32_t x, uint32_t y, TCGCond c)
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
@@ -653,12 +659,18 @@ static bool do_constant_folding_cond_64(uint64_t x, uint64_t y, TCGCond c)
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
@@ -673,9 +685,14 @@ static bool do_constant_folding_cond_eq(TCGCond c)
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
@@ -703,8 +720,10 @@ static int do_constant_folding_cond(TCGType type, TCGArg x,
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
@@ -777,7 +796,30 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
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
@@ -785,6 +827,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
     TCGArg al, ah, bl, bh;
     TCGCond c;
     bool swap;
+    int r;
 
     swap = swap_commutative2(args, args + 2);
     c = args[4];
@@ -806,21 +849,54 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
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
@@ -1284,24 +1360,37 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
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
@@ -1967,6 +2056,99 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
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
+        neg_opc = INDEX_op_neg_i32;
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
+        neg_opc = INDEX_op_neg_i64;
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
+    } else if (neg) {
+        op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
+        op2->args[0] = ret;
+        op2->args[1] = ret;
+    }
+}
+
 static bool fold_setcond(OptContext *ctx, TCGOp *op)
 {
     int i = do_constant_folding_cond1(ctx, op->args[0], &op->args[1],
@@ -1974,6 +2156,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
+    fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
     ctx->s_mask = smask_from_zmask(1);
@@ -1987,13 +2170,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
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
@@ -2041,22 +2224,35 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
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


