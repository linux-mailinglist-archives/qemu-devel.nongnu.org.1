Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B407C71135C
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQS-00005v-Np; Thu, 25 May 2023 14:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQQ-0008Vh-O9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:58 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQO-00060L-N9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:58 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-53404873a19so1355143a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038255; x=1687630255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XhELp8moK7/6JDjvycSVE/PjyFSTn3Ab+xYUGXGPpO8=;
 b=qhPIRdOfFbixwzgipsFtVCcHvKe19QUFXB0KyOtTxcgUCP36GL/Ur5XG4o6QO+xFbY
 VVnzXtzTURtTx+8CLvg68iuvmzXVMTHtYhSw3XxAeFJIkYkF1GJyssW9/E/+QPygfWk0
 x05hl1J1qzPsnUxeQhLoI1azM1wM2cYFKudYQcrjkJ6XRzyOh67q5QLf700wAbAIIXn7
 hTobevW7AYux1qsB4NzT8F6bT9pt9ZX1pcig9clPSZ6NOoZ06LoL5XD52tnbQdsJU1vB
 CqPXG6YOpf4wXeTYha2xJ2b34x00MV71jcwOHDGps6BqLNmruzYESKGHByibtC+tpUAx
 2H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038255; x=1687630255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XhELp8moK7/6JDjvycSVE/PjyFSTn3Ab+xYUGXGPpO8=;
 b=N4J9pQbVqImSLjKiA5Fmv+Gw8XbfuZsHwbypGiJnThJArJcjlRl/xq/si30VKDu66H
 g4GKPaXvVPrdJb8ctKQzx/XMYcM9Z07lHIPSdojuX8hRy/ESZ9YsXozd23iYKxGF8VQ+
 9RZ5tBdNv5KZpQqMlVt7rbVbxZsgjjTqvefiR7wmR2s+X6dSDvz/E6cc+pRypxMtZ8Pb
 EQfsdHztwMD2EuH7ckn/7yuLgl9/m8JcbTo4LhIyk26E3ofB3E+O+iUugqxnT6cSjfId
 UOojGpkXj4i4mZo+UTOIkF6VadMEMfrYdMVbvqi8uqKW0WSWnE7Lcu4eRIk+nzYRHE1v
 LIBw==
X-Gm-Message-State: AC+VfDxF2BvP+ip51AvyX3113DHQLa75GzYesW81cDEVujgzPwDTfNhc
 FJVAB1i9H42mj04REmD2urweXL9ZxV+PAyWOEhA=
X-Google-Smtp-Source: ACHHUZ4gcplA52XXa1oyOtJa5lLs0nmOf0BFxHKtmGMvcBvLukddPkxYEp/OWyZwBPdRmc5rtYzHMg==
X-Received: by 2002:a17:903:2445:b0:1b0:31a:5f91 with SMTP id
 l5-20020a170903244500b001b0031a5f91mr1339517pls.67.1685038255142; 
 Thu, 25 May 2023 11:10:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 21/23] tcg/riscv: Improve setcond expansion
Date: Thu, 25 May 2023 11:10:34 -0700
Message-Id: <20230525181036.1559435-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Split out a helper function, tcg_out_setcond_int, which does not
always produce the complete boolean result, but returns a set of
flags to do so.

Based on 21af16198425, the same improvement for loongarch64.

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 164 +++++++++++++++++++++++++++----------
 1 file changed, 121 insertions(+), 43 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 05ea9fead8..db328ddc2d 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -812,50 +812,128 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_opc_branch(s, op, arg1, arg2, 0);
 }
 
-static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg arg1, TCGReg arg2)
+#define SETCOND_INV    TCG_TARGET_NB_REGS
+#define SETCOND_NEZ    (SETCOND_INV << 1)
+#define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
+
+static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
+                               TCGReg arg1, tcg_target_long arg2, bool c2)
 {
+    int flags = 0;
+
     switch (cond) {
-    case TCG_COND_EQ:
-        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
-        tcg_out_opc_imm(s, OPC_SLTIU, ret, ret, 1);
-        break;
-    case TCG_COND_NE:
-        tcg_out_opc_reg(s, OPC_SUB, ret, arg1, arg2);
-        tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, ret);
-        break;
-    case TCG_COND_LT:
-        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
-        break;
-    case TCG_COND_GE:
-        tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
-        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
-        break;
-    case TCG_COND_LE:
-        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
-        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
-        break;
-    case TCG_COND_GT:
-        tcg_out_opc_reg(s, OPC_SLT, ret, arg2, arg1);
-        break;
-    case TCG_COND_LTU:
-        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
-        break;
-    case TCG_COND_GEU:
-        tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
-        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
-        break;
-    case TCG_COND_LEU:
-        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
-        tcg_out_opc_imm(s, OPC_XORI, ret, ret, 1);
-        break;
-    case TCG_COND_GTU:
-        tcg_out_opc_reg(s, OPC_SLTU, ret, arg2, arg1);
+    case TCG_COND_EQ:    /* -> NE  */
+    case TCG_COND_GE:    /* -> LT  */
+    case TCG_COND_GEU:   /* -> LTU */
+    case TCG_COND_GT:    /* -> LE  */
+    case TCG_COND_GTU:   /* -> LEU */
+        cond = tcg_invert_cond(cond);
+        flags ^= SETCOND_INV;
         break;
     default:
-         g_assert_not_reached();
-         break;
-     }
+        break;
+    }
+
+    switch (cond) {
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+        /*
+         * If we have a constant input, the most efficient way to implement
+         * LE is by adding 1 and using LT.  Watch out for wrap around for LEU.
+         * We don't need to care for this for LE because the constant input
+         * is constrained to signed 12-bit, and 0x800 is representable in the
+         * temporary register.
+         */
+        if (c2) {
+            if (cond == TCG_COND_LEU) {
+                /* unsigned <= -1 is true */
+                if (arg2 == -1) {
+                    tcg_out_movi(s, TCG_TYPE_REG, ret, !(flags & SETCOND_INV));
+                    return ret;
+                }
+                cond = TCG_COND_LTU;
+            } else {
+                cond = TCG_COND_LT;
+            }
+            tcg_debug_assert(arg2 <= 0x7ff);
+            if (++arg2 == 0x800) {
+                tcg_out_movi(s, TCG_TYPE_REG, TCG_REG_TMP0, arg2);
+                arg2 = TCG_REG_TMP0;
+                c2 = false;
+            }
+        } else {
+            TCGReg tmp = arg2;
+            arg2 = arg1;
+            arg1 = tmp;
+            cond = tcg_swap_cond(cond);    /* LE -> GE */
+            cond = tcg_invert_cond(cond);  /* GE -> LT */
+            flags ^= SETCOND_INV;
+        }
+        break;
+    default:
+        break;
+    }
+
+    switch (cond) {
+    case TCG_COND_NE:
+        flags |= SETCOND_NEZ;
+        if (!c2) {
+            tcg_out_opc_reg(s, OPC_XOR, ret, arg1, arg2);
+        } else if (arg2 == 0) {
+            ret = arg1;
+        } else {
+            tcg_out_opc_imm(s, OPC_XORI, ret, arg1, arg2);
+        }
+        break;
+
+    case TCG_COND_LT:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SLTI, ret, arg1, arg2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLT, ret, arg1, arg2);
+        }
+        break;
+
+    case TCG_COND_LTU:
+        if (c2) {
+            tcg_out_opc_imm(s, OPC_SLTIU, ret, arg1, arg2);
+        } else {
+            tcg_out_opc_reg(s, OPC_SLTU, ret, arg1, arg2);
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    return ret | flags;
+}
+
+static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
+                            TCGReg arg1, tcg_target_long arg2, bool c2)
+{
+    int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
+
+    if (tmpflags != ret) {
+        TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
+
+        switch (tmpflags & SETCOND_FLAGS) {
+        case SETCOND_INV:
+            /* Intermediate result is boolean: simply invert. */
+            tcg_out_opc_imm(s, OPC_XORI, ret, tmp, 1);
+            break;
+        case SETCOND_NEZ:
+            /* Intermediate result is zero/non-zero: test != 0. */
+            tcg_out_opc_reg(s, OPC_SLTU, ret, TCG_REG_ZERO, tmp);
+            break;
+        case SETCOND_NEZ | SETCOND_INV:
+            /* Intermediate result is zero/non-zero: test == 0. */
+            tcg_out_opc_imm(s, OPC_SLTIU, ret, tmp, 1);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+    }
 }
 
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
@@ -1542,7 +1620,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2);
+        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
         break;
 
     case INDEX_op_qemu_ld_a32_i32:
@@ -1665,6 +1743,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
     case INDEX_op_xor_i64:
+    case INDEX_op_setcond_i32:
+    case INDEX_op_setcond_i64:
         return C_O1_I2(r, r, rI);
 
     case INDEX_op_andc_i32:
@@ -1686,7 +1766,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_divu_i32:
     case INDEX_op_rem_i32:
     case INDEX_op_remu_i32:
-    case INDEX_op_setcond_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_mulsh_i64:
     case INDEX_op_muluh_i64:
@@ -1694,7 +1773,6 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_divu_i64:
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i64:
-    case INDEX_op_setcond_i64:
         return C_O1_I2(r, rZ, rZ);
 
     case INDEX_op_shl_i32:
-- 
2.34.1


