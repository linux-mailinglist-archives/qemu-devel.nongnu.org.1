Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E9CA9D49B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 23:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R19-0007c7-RE; Fri, 25 Apr 2025 17:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R13-0007Yl-5k
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R0z-0000Zm-Dh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:55:24 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so2433299b3a.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618120; x=1746222920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOP3QhQKXnzq6U2HJJWxywXpSAUdFC4c8yCUMe7JPeg=;
 b=MobPmB9F14nZwUsEZT2FMzYl1PW5r9jVOYR7SQXi+p6BJNM7nLDw8266rnXTyfHSrx
 m5eTIVjqcy6QbArJnuYhICTa0XaNUaAz1XN5AUxx15tjKXHkAEMouyWJiyMsw5qATcQT
 DwAyC6838azzlwJycLaikaIaXlysTnV5LLQHJglLjKlTezjq0mHD0I2E3SzOhr+/EcDC
 N09nRww/+bNVXAUCSbkAQ1ViVf3fIEGXN8tu/bh9uGb8ZSGHwnDx+xbejhoTZyufO5Sd
 hdhLQeIrnLcCCHdlMnR3jtrdbe/WzTK0P6/A/27kqwuZLZzys5GoPyWaL1ib77E7dcJ9
 U2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618120; x=1746222920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOP3QhQKXnzq6U2HJJWxywXpSAUdFC4c8yCUMe7JPeg=;
 b=GYDIt+hrSrblLPIjAET9w6RDy/qMg168PVG/M9t0xXAj/hICs77kf+Hpzu3fmGzclR
 OYnaduHwWIo0WBH4iqr8gQeSPoqjCQYTXmRLa4Z7/i0kr4Qyzd0bkMjqv2T+kQJJsM/n
 aeRe+iIxYGL5nkWAOilKfBs3SsRN86QuJJ1xbiYEOFp1knfs+Pjx+N9x5BCDFVUk22fI
 vs8bOg5zhKJmPmP+M4KhtGfZLhWufLWZMD6ZIDAB2adQ+ezoLkfEs3pcLTzgrYawHeZ1
 QrvP7+jOlt0YGzRQK5vPidc8qJ+uJYGCTiie//oUzf0heFrmcpyq1hF5K5TrdA7Ct0u2
 rXmw==
X-Gm-Message-State: AOJu0YxhS7aqNZL8f+X73XilDduTkE/fMOIHLBeOHCMvpq7UeQOJlxGf
 cvqL5UKmi/1h/Jz4zIAwHBlGXbh+L8OfsiCtEBL2AGpUOjYUklknYRdUxy+4Jt2R6x0DrIfAiDK
 7
X-Gm-Gg: ASbGncubg9r8Q3nauxlgUbRo2hUqx1Grp6xGC7/o7SDROvLFggHOVN9DsBE7eD8me5H
 O8JrYPijd5Vpf69C0SL0mV62SMpwD2uZl0IqGClEu8UMWqeZfBHukaCFlk9tnXqlAGNUNi6++wJ
 2tacRZsmErLQVD2B18K83t+JPq49kGZJ3C2zuaxN/TAlxGGIUvhAPs0PohP2vNpPQ/ajLvXktIE
 5CKUhWOWUWHfP07tG/FJtDutNoYFP2Nwoi7pAjlMv8s/K8HZ5Ki2zCXcAzjssMUvwrGecKsXnAN
 CpYdRn5B1kJUXvY0Pll73FXaB9upVgYrYP8T9uHbXBLOaxRwSlC8Q66AVMXoNAsJvjGQZlmVqwU
 =
X-Google-Smtp-Source: AGHT+IHrqL0IXFDUtLymQAlajh1kjGU90dpKIn8/WykIXYrI9zoVcPHyd75DRMA9oPPoGDrRrtzHTw==
X-Received: by 2002:a05:6a20:9c97:b0:1f5:7d57:8309 with SMTP id
 adf61e73a8af0-2046a57d7e5mr1010177637.21.1745618119583; 
 Fri, 25 Apr 2025 14:55:19 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e259414b0sm3664392b3a.48.2025.04.25.14.55.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:55:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 033/159] tcg: Convert sub to TCGOutOpSubtract
Date: Fri, 25 Apr 2025 14:52:47 -0700
Message-ID: <20250425215454.886111-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Create a special subclass for sub, because two backends can
support "subtract from immediate".  Drop all backend support
for an immediate as the second operand, as we transform sub
to add during optimize.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-con-set.h    |  1 -
 tcg/ppc/tcg-target-con-set.h     |  3 +-
 tcg/riscv/tcg-target-con-set.h   |  1 -
 tcg/riscv/tcg-target-con-str.h   |  1 -
 tcg/tcg.c                        | 30 ++++++++++++++++--
 tcg/aarch64/tcg-target.c.inc     | 24 +++++++--------
 tcg/arm/tcg-target.c.inc         | 29 +++++++++++-------
 tcg/i386/tcg-target.c.inc        | 23 +++++++-------
 tcg/loongarch64/tcg-target.c.inc | 32 +++++++++-----------
 tcg/mips/tcg-target.c.inc        | 31 ++++++++-----------
 tcg/ppc/tcg-target.c.inc         | 52 +++++++++++---------------------
 tcg/riscv/tcg-target.c.inc       | 45 +++++++++------------------
 tcg/s390x/tcg-target.c.inc       | 41 +++++++++++--------------
 tcg/sparc64/tcg-target.c.inc     | 16 +++++++---
 tcg/tci/tcg-target.c.inc         | 14 +++++++--
 15 files changed, 169 insertions(+), 174 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 06ab04cc4d..248bc95d9b 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -24,7 +24,6 @@ C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rzW)
-C_O1_I2(r, rz, rN)
 C_O1_I2(r, rz, rz)
 C_O1_I4(r, rz, rz, rz, 0)
 C_O1_I4(r, rz, rz, rz, rz)
diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 453abde6c1..77a1038d51 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -22,8 +22,7 @@ C_O1_I1(v, r)
 C_O1_I1(v, v)
 C_O1_I1(v, vr)
 C_O1_I2(r, 0, rZ)
-C_O1_I2(r, rI, ri)
-C_O1_I2(r, rI, rT)
+C_O1_I2(r, rI, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rC)
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 21f8833b3b..f3a6f7a7ed 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -16,7 +16,6 @@ C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
-C_O1_I2(r, rz, rN)
 C_O1_I2(r, rz, rz)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 1956f75f9a..c04e15ddfa 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -18,5 +18,4 @@ REGS('v', ALL_VECTOR_REGS)
 CONST('I', TCG_CT_CONST_S12)
 CONST('K', TCG_CT_CONST_S5)
 CONST('L', TCG_CT_CONST_CMP_VI)
-CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index c0178030ce..d7a44ac1b1 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,14 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpSubtract {
+    TCGOutOp base;
+    void (*out_rrr)(TCGContext *s, TCGType type,
+                    TCGReg a0, TCGReg a1, TCGReg a2);
+    void (*out_rir)(TCGContext *s, TCGType type,
+                    TCGReg a0, tcg_target_long a1, TCGReg a2);
+} TCGOutOpSubtract;
+
 #include "tcg-target.c.inc"
 
 #ifndef CONFIG_TCG_INTERPRETER
@@ -1012,6 +1020,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
+    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
@@ -2231,7 +2241,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_sub_i32:
     case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_shl_i32:
@@ -2301,7 +2310,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_sub_i64:
     case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i64:
@@ -5449,6 +5457,24 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_sub_i32:
+    case INDEX_op_sub_i64:
+        {
+            const TCGOutOpSubtract *out = &outop_sub;
+
+            /*
+             * Constants should never appear in the second source operand.
+             * These are folded to add with negative constant.
+             */
+            tcg_debug_assert(!const_args[2]);
+            if (const_args[1]) {
+                out->out_rir(s, type, new_args[0], new_args[1], new_args[2]);
+            } else {
+                out->out_rrr(s, type, new_args[0], new_args[1], new_args[2]);
+            }
+        }
+        break;
+
     default:
         if (def->flags & TCG_OPF_VECTOR) {
             tcg_out_vec_op(s, op->opc, type - TCG_TYPE_V64,
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 30cad937b7..dfe67c1261 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2205,6 +2205,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3502, SUB, type, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2290,15 +2301,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tgen_addi(s, ext, a0, a1, -a2);
-        } else {
-            tcg_out_insn(s, 3502, SUB, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i64:
     case INDEX_op_neg_i32:
         tcg_out_insn(s, 3502, SUB, ext, a0, TCG_REG_XZR, a1);
@@ -3014,10 +3016,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, rA);
-
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 47c09ff2b1..13b78f0ada 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1915,6 +1915,24 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_SUB, a0, a1, a2, SHIFT_IMM_LSL(0));
+}
+
+static void tgen_subfi(TCGContext *s, TCGType type,
+                       TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out_dat_imm(s, COND_AL, ARITH_RSB, a0, a2, encode_imm_nofail(a1));
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, rI, r),
+    .out_rrr = tgen_sub,
+    .out_rir = tgen_subfi,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1982,15 +2000,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_dat_rIK(s, tcg_cond_to_arm_cond[c], ARITH_MOV,
                         ARITH_MVN, args[0], 0, args[3], const_args[3]);
         break;
-    case INDEX_op_sub_i32:
-        if (const_args[1]) {
-            tcg_out_dat_imm(s, COND_AL, ARITH_RSB,
-                            args[0], args[2], encode_imm_nofail(args[1]));
-        } else {
-            tcg_out_dat_rIN(s, COND_AL, ARITH_SUB, ARITH_ADD,
-                            args[0], args[1], args[2], const_args[2]);
-        }
-        break;
     case INDEX_op_add2_i32:
         a0 = args[0], a1 = args[1], a2 = args[2];
         a3 = args[3], a4 = args[4], a5 = args[5];
@@ -2233,8 +2242,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i32:
     case INDEX_op_negsetcond_i32:
         return C_O1_I2(r, r, rIN);
-    case INDEX_op_sub_i32:
-        return C_O1_I2(r, rI, r);
 
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9185f6879c..104f1b010a 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2669,6 +2669,18 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tgen_arithr(s, ARITH_SUB + rexw, a0, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, 0, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2770,15 +2782,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(sub):
-        c = ARITH_SUB;
-        if (const_a2) {
-            tgen_arithi(s, c + rexw, a0, a2, 0);
-        } else {
-            tgen_arithr(s, c + rexw, a0, a2);
-        }
-        break;
-
     OP_32_64(mul):
         if (const_a2) {
             int32_t val;
@@ -3689,8 +3692,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
         return C_O1_I2(r, 0, re);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index dc4ed0e8b0..f01b19463b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1376,6 +1376,21 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sub_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_sub_d(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1596,21 +1611,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_sub_i32:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I32, a0, a1, -a2);
-        } else {
-            tcg_out_opc_sub_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_addi(s, TCG_TYPE_I64, a0, a1, -a2);
-        } else {
-            tcg_out_opc_sub_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i32:
         tcg_out_opc_sub_w(s, a0, TCG_REG_ZERO, a1);
         break;
@@ -2324,10 +2324,8 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         /* Must deposit into the same register as input */
         return C_O1_I2(r, 0, rz);
 
-    case INDEX_op_sub_i32:
     case INDEX_op_setcond_i32:
         return C_O1_I2(r, rz, ri);
-    case INDEX_op_sub_i64:
     case INDEX_op_setcond_i64:
         return C_O1_I2(r, rz, rJ);
 
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index bfe329b3ef..15c5661fb8 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1753,6 +1753,18 @@ static const TCGOutOpBinary outop_orc = {
     .base.static_constraint = C_NotImplemented,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SUBU : OPC_DSUBU;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1844,22 +1856,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, i1, a0, a1, a2);
         break;
 
-    do_binaryv:
-        tcg_out_opc_reg(s, i1, a0, a1, a2);
-        break;
-
-    case INDEX_op_sub_i32:
-        i1 = OPC_SUBU, i2 = OPC_ADDIU;
-        goto do_subtract;
-    case INDEX_op_sub_i64:
-        i1 = OPC_DSUBU, i2 = OPC_DADDIU;
-    do_subtract:
-        if (c2) {
-            tcg_out_opc_imm(s, i2, a0, a1, -a2);
-            break;
-        }
-        goto do_binaryv;
-
     case INDEX_op_mul_i32:
         if (use_mips32_instructions) {
             tcg_out_opc_reg(s, OPC_MUL, a0, a1, a2);
@@ -2234,9 +2230,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rz, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index c3366e4316..bfbfdc2dfa 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3016,6 +3016,24 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out32(s, SUBF | TAB(a0, a2, a1));
+}
+
+static void tgen_subfi(TCGContext *s, TCGType type,
+                       TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, rI, r),
+    .out_rrr = tgen_sub,
+    .out_rir = tgen_subfi,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3104,21 +3122,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I32, a0, a1 - a2);
-            } else {
-                tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
-            }
-        } else if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, (int32_t)-a2);
-        } else {
-            tcg_out32(s, SUBF | TAB(a0, a2, a1));
-        }
-        break;
-
     case INDEX_op_clz_i32:
         tcg_out_cntxz(s, TCG_TYPE_I32, CNTLZW, args[0], args[1],
                       args[2], const_args[2]);
@@ -3231,21 +3234,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, NOR | SAB(args[1], args[0], args[1]));
         break;
 
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[1]) {
-            if (const_args[2]) {
-                tcg_out_movi(s, TCG_TYPE_I64, a0, a1 - a2);
-            } else {
-                tcg_out32(s, SUBFIC | TAI(a0, a2, a1));
-            }
-        } else if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, -a2);
-        } else {
-            tcg_out32(s, SUBF | TAB(a0, a2, a1));
-        }
-        break;
-
     case INDEX_op_shl_i64:
         if (const_args[2]) {
             /* Limit immediate shift count lest we create an illegal insn.  */
@@ -4195,10 +4183,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_sub_i32:
-        return C_O1_I2(r, rI, ri);
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rI, rT);
     case INDEX_op_clz_i32:
     case INDEX_op_ctz_i32:
     case INDEX_op_clz_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 887f20d4cb..54da432ab1 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -113,10 +113,9 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 }
 
 #define TCG_CT_CONST_S12     0x100
-#define TCG_CT_CONST_N12     0x200
-#define TCG_CT_CONST_M12     0x400
-#define TCG_CT_CONST_S5      0x800
-#define TCG_CT_CONST_CMP_VI 0x1000
+#define TCG_CT_CONST_M12     0x200
+#define TCG_CT_CONST_S5      0x400
+#define TCG_CT_CONST_CMP_VI  0x800
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -400,13 +399,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_S12) && val >= -0x800 && val <= 0x7ff) {
         return 1;
     }
-    /*
-     * Sign extended from 12 bits, negated: [-0x7ff, 0x800].
-     * Used for subtraction, where a constant must be handled by ADDI.
-     */
-    if ((ct & TCG_CT_CONST_N12) && val >= -0x7ff && val <= 0x800) {
-        return 1;
-    }
     /*
      * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
      * Used by addsub2 and movcond, which may need the negative value,
@@ -2055,6 +2047,18 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SUBW : OPC_SUB;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2136,21 +2140,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_sub_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDIW, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUBW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_sub_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_ADDI, a0, a1, -a2);
-        } else {
-            tcg_out_opc_reg(s, OPC_SUB, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_not_i32:
     case INDEX_op_not_i64:
         tcg_out_opc_imm(s, OPC_XORI, a0, a1, -1);
@@ -2713,10 +2702,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, rz, rN);
-
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 29570d3be1..662984f733 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2331,6 +2331,23 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
+    } else if (a0 == a1) {
+        tcg_out_insn(s, RR, SR, a0, a2);
+    } else {
+        tcg_out_insn(s, RRFa, SRK, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2413,17 +2430,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I32, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, (int32_t)-a2);
-        } else if (a0 == a1) {
-            tcg_out_insn(s, RR, SR, a0, a2);
-        } else {
-            tcg_out_insn(s, RRFa, SRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i32:
         tcg_out_insn(s, RR, LCR, args[0], args[1]);
         break;
@@ -2618,15 +2624,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st(s, TCG_TYPE_I64, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_sub_i64:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        if (const_args[2]) {
-            tgen_addi(s, type, a0, a1, -a2);
-        } else {
-            tcg_out_insn(s, RRFa, SGRK, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_neg_i64:
         tcg_out_insn(s, RRE, LCGR, args[0], args[1]);
         break;
@@ -3302,10 +3299,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
-        return C_O1_I2(r, r, ri);
-
     case INDEX_op_mul_i32:
         return (HAVE_FACILITY(MISC_INSN_EXT2)
                 ? C_O1_I2(r, r, ri)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 1ebff04af4..04b2b3b195 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1374,6 +1374,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_arith(s, a0, a1, a2, ARITH_SUB);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1446,9 +1457,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_st32_i64:
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
-    OP_32_64(sub):
-        c = ARITH_SUB;
-        goto gen_arith;
     case INDEX_op_shl_i32:
         c = SHIFT_SLL;
     do_shift32:
@@ -1660,8 +1668,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_div_i64:
     case INDEX_op_divu_i32:
     case INDEX_op_divu_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_shl_i32:
     case INDEX_op_shl_i64:
     case INDEX_op_shr_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index dec51692f0..353994e83f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -91,8 +91,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_rem_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_shl_i32:
@@ -711,6 +709,17 @@ static const TCGOutOpBinary outop_orc = {
     .out_rrr = tgen_orc,
 };
 
+static void tgen_sub(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_op_rrr(s, glue(INDEX_op_sub_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpSubtract outop_sub = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_sub,
+};
+
 static void tgen_xor(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -764,7 +773,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(sub)
     CASE_32_64(mul)
     CASE_32_64(shl)
     CASE_32_64(shr)
-- 
2.43.0


