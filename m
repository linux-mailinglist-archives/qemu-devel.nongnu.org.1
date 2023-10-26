Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E217D79BB
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2x-0007IG-Kn; Wed, 25 Oct 2023 20:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2m-00071Q-Oq
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004qp-MC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cbf47fa563so2273145ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279354; x=1698884154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/3tyPErdBidq6AacxwJD8cDdKu9xx4iNX0WzEVUzfVw=;
 b=J/067aruZyZvE70TK3ULa+HzCEgXHUXIDP9t7r1Hk11grFDVYkUMT61W/P2yKRmMMG
 C7D+39SdPz+VoUQ5+Rz+Ubg4/P6c4UiHQ+QjAJji4lGsTyOi0aijQEr7bLUDuvOYLPIl
 347IzrJaRkA1hGACsnLsr509sObYiSyckC2yTSl7kJ/babrjo18svpwaPibv+WR30DTn
 3c8ruly7GABPlCeFip8H1qIenCIZzuKjZVcA2IpYrTL+hzk3TL5wYpi3y9Qqlg8Pxo5X
 PVW4a4m+QtRl7UP0xFSBTX39FMnUctuKiCJLh343+tnTk1b2Oy5w3L3AAvp6iGLVZcs3
 KRLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279354; x=1698884154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/3tyPErdBidq6AacxwJD8cDdKu9xx4iNX0WzEVUzfVw=;
 b=eTE7k5JzKOEZ9BdC+wB75h9ma8/ELVCK3cH+YM1rWUekXVA/HNtACocYXJ1tnsC2kZ
 QgHmo02VJppQU/uHPxwyWqNcFKCCRsqgEGihDmO1KwBadepgNqHutGefJByIBR+Iwv9w
 lyNhWgl+OpuKj4sLGyhIukZxswPdIUGdq+KRVDEH/2LjA+hi1tifAp6R9Zgrp7i0rKYn
 ccp0FagwSKR+3Era9aQDAGOM3Dv8VmYTM6BzTPB+GgpPY7N0hkGF4ucismwfYwmtkbDE
 U8PdDQ0gvmoVzFNTIgKouIQKDlQKLRJd5FJ4avJI1f6a9k8RUBPYe68FFTkqqzPNkCtu
 Mkjw==
X-Gm-Message-State: AOJu0YwoWdtsCo+5fn6c/UEhr4dYD2Vw2s3IatcLjG6uYBHiot6BfV3n
 QFk3gzRzUkZufJl1Yu/z7dD2LDdJZWAH/qg/w7M=
X-Google-Smtp-Source: AGHT+IH73VacN0HKtOd5jyyWinWoVMO8NThyjnQyzHpSnA+FU/g09XUq7dxsBfDdBpTdY/wYvwdemA==
X-Received: by 2002:a17:903:1210:b0:1c5:d8a3:8789 with SMTP id
 l16-20020a170903121000b001c5d8a38789mr17803639plh.4.1698279354218; 
 Wed, 25 Oct 2023 17:15:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/29] tcg/optimize: Handle TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:13:51 -0700
Message-Id: <20231026001542.1141412-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
 tcg/optimize.c | 225 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 205 insertions(+), 20 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2f2d1c3001..27b1eaaa8d 100644
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
@@ -660,7 +677,27 @@ static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
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
+    /* TSTNE x,x -> NE x,0 */
+    if (args_are_copies(*p1, *p2)) {
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
@@ -668,6 +705,7 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
     TCGArg al, ah, bl, bh;
     TCGCond c;
     bool swap;
+    int r;
 
     swap = swap_commutative2(args, args + 2);
     c = args[4];
@@ -689,8 +727,13 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
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
@@ -701,9 +744,28 @@ static int do_constant_folding_cond2(OptContext *ctx, TCGArg *args)
                 break;
             }
         }
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
@@ -1151,17 +1213,30 @@ static bool fold_brcond2(OptContext *ctx, TCGOp *op)
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
+        break;
+
     do_brcond_high:
         op->opc = INDEX_op_brcond_i32;
         op->args[0] = op->args[1];
@@ -1829,6 +1904,100 @@ static bool fold_remainder(OptContext *ctx, TCGOp *op)
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
+
+    switch (ctx->type) {
+    case TCG_TYPE_I32:
+        and_opc = INDEX_op_and_i32;
+        sub_opc = INDEX_op_sub_i32;
+        xor_opc = INDEX_op_xor_i32;
+        shr_opc = INDEX_op_shr_i32;
+        neg_opc = TCG_TARGET_HAS_neg_i32 ? INDEX_op_neg_i32 : 0;
+        uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
+        sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
+        break;
+    case TCG_TYPE_I64:
+        and_opc = INDEX_op_and_i64;
+        sub_opc = INDEX_op_sub_i64;
+        xor_opc = INDEX_op_xor_i64;
+        shr_opc = INDEX_op_shr_i64;
+        neg_opc = TCG_TARGET_HAS_neg_i64 ? INDEX_op_neg_i64 : 0;
+        uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
+        sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    sh = ctz64(val);
+    ret = op->args[0];
+    src1 = op->args[1];
+    inv = cond == TCG_COND_TSTEQ;
+
+    if (neg && !inv && sext_opc) {
+        op->opc = sext_opc;
+        op->args[1] = src1;
+        op->args[2] = sh;
+        op->args[3] = 1;
+        neg = false;
+    } else if (uext_opc) {
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
@@ -1836,6 +2005,7 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     if (i >= 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], i);
     }
+    fold_setcond_tst_pow2(ctx, op, false);
 
     ctx->z_mask = 1;
     ctx->s_mask = smask_from_zmask(1);
@@ -1849,13 +2019,13 @@ static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
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
@@ -1903,21 +2073,36 @@ static bool fold_setcond2(OptContext *ctx, TCGOp *op)
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
+        fold_setcond_tst_pow2(ctx, op, false);
+        break;
+
     do_setcond_high:
         op->args[1] = op->args[2];
         op->args[2] = op->args[4];
         op->args[3] = cond;
         op->opc = INDEX_op_setcond_i32;
+        fold_setcond_tst_pow2(ctx, op, false);
         break;
     }
 
-- 
2.34.1


