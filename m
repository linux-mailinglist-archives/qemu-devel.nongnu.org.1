Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA4C781557
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:18:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7ix-0004z9-Ed; Fri, 18 Aug 2023 18:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iv-0004yT-Mx
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:41 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7it-0004O8-2V
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bc63ef9959so11729655ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396818; x=1693001618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFsJs5cohXv4FIHFtvP+nnr3lW2bGYx/SHq6s9Blass=;
 b=i8ool4LAtFIVuJQH1K0kHIlre/PPpw7/4J/Zt9NMaUJu6ucmFiWavOcX+2gK+5TXh9
 tAwYg6HSiHXQbAiSo85TsZ89kbxvbk5wxu/uYMF7V6b4LI2GARHHpUlPU6wHhTzE1Kdh
 6cyprXj1x7ut3VRJJclMEeTeTfLU6360Z8Hlm0mMD+cTDavb/Ymx9alvBZYwunV1XOor
 nuDVDq8T94WSCf5GXB4FgM//w1RImkRlo3+Gk28qV3+qV+jRPELwjmKjIwpbJPGeQIKz
 NcA9TBFA2qFTkohE8RGFjcJ/K4yG25kT9VC8brnuXyl/PqqAGiqGi7MpnyLN9uNNcdIL
 orzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396818; x=1693001618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WFsJs5cohXv4FIHFtvP+nnr3lW2bGYx/SHq6s9Blass=;
 b=ZVWvkieB9/T86k/vsRZ7eTpzsM7+HlOtsQ6k74mguZ0+NlqCpSCpTINmngWJ8wLzBi
 OdqQ/FMi2fCGFvcsG+68EQNtU+RC5NREu//zrKpbefI7mqdghNTFzjB2t2J+HefSr1UR
 yV1FfJu9GZv5W2hATeOw0JVgJNNgUcNOsTtj2H0aScZ535M/XKg+FQFx/+kDPSbGmrNq
 f1wia88rx492pid3cYCWA25TGCZ8QsYrOXQoYkf13a/eVdqhrasxxk014lKwpsANcAmI
 q2byxnMkc7MXGvmDqhWKAfdKoQr1sqSntk+CM0YFKnud3uR8Zckr5Sj9gd1sUG2Jc6ri
 2WPg==
X-Gm-Message-State: AOJu0YxyxWhu4BUz/t076lBFvUVuAp/S5LcU+jLLT0Rg7qaQMq+ad/7b
 JKS0P5E2tFZD19vAgIldUbBpMtSI/Rx2Roj9VSA=
X-Google-Smtp-Source: AGHT+IEaniGpSAwVmgA22sk3kmMKB6wPM6BDMH7D41MiUKP+GtQPyNMGevT20oPi24c1HBhpFpugXQ==
X-Received: by 2002:a17:903:1cb:b0:1bc:2f17:c628 with SMTP id
 e11-20020a17090301cb00b001bc2f17c628mr555171plh.56.1692396817916; 
 Fri, 18 Aug 2023 15:13:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 10/23] tcg/ppc: Implement negsetcond_*
Date: Fri, 18 Aug 2023 15:13:14 -0700
Message-Id: <20230818221327.150194-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

In the general case we simply negate.  However with isel we
may load -1 instead of 1 with no extra effort.

Consolidate EQ0 and NE0 logic.  Replace the NE0 zero-extension
with inversion+negation of EQ0, which is never worse and may
eliminate one insn.  Provide a special case for -EQ0.

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.h     |   4 +-
 tcg/ppc/tcg-target.c.inc | 127 ++++++++++++++++++++++++---------------
 2 files changed, 82 insertions(+), 49 deletions(-)

diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index ba4fd3eb3a..a143b8f1e0 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -101,7 +101,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -142,7 +142,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 511e14b180..10448aa0e6 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -1548,8 +1548,20 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
 }
 
 static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
-                                TCGReg dst, TCGReg src)
+                                TCGReg dst, TCGReg src, bool neg)
 {
+    if (neg && (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I64)) {
+        /*
+         * X != 0 implies X + -1 generates a carry.
+         * RT = (~X + X) + CA
+         *    = -1 + CA
+         *    = CA ? 0 : -1
+         */
+        tcg_out32(s, ADDIC | TAI(TCG_REG_R0, src, -1));
+        tcg_out32(s, SUBFE | TAB(dst, src, src));
+        return;
+    }
+
     if (type == TCG_TYPE_I32) {
         tcg_out32(s, CNTLZW | RS(src) | RA(dst));
         tcg_out_shri32(s, dst, dst, 5);
@@ -1557,18 +1569,28 @@ static void tcg_out_setcond_eq0(TCGContext *s, TCGType type,
         tcg_out32(s, CNTLZD | RS(src) | RA(dst));
         tcg_out_shri64(s, dst, dst, 6);
     }
+    if (neg) {
+        tcg_out32(s, NEG | RT(dst) | RA(dst));
+    }
 }
 
-static void tcg_out_setcond_ne0(TCGContext *s, TCGReg dst, TCGReg src)
+static void tcg_out_setcond_ne0(TCGContext *s, TCGType type,
+                                TCGReg dst, TCGReg src, bool neg)
 {
-    /* X != 0 implies X + -1 generates a carry.  Extra addition
-       trickery means: R = X-1 + ~X + C = X-1 + (-X+1) + C = C.  */
-    if (dst != src) {
-        tcg_out32(s, ADDIC | TAI(dst, src, -1));
-        tcg_out32(s, SUBFE | TAB(dst, dst, src));
-    } else {
+    if (!neg && (TCG_TARGET_REG_BITS == 32 || type == TCG_TYPE_I64)) {
+        /*
+         * X != 0 implies X + -1 generates a carry.  Extra addition
+         * trickery means: R = X-1 + ~X + C = X-1 + (-X+1) + C = C.
+         */
         tcg_out32(s, ADDIC | TAI(TCG_REG_R0, src, -1));
         tcg_out32(s, SUBFE | TAB(dst, TCG_REG_R0, src));
+        return;
+    }
+    tcg_out_setcond_eq0(s, type, dst, src, false);
+    if (neg) {
+        tcg_out32(s, ADDI | TAI(dst, dst, -1));
+    } else {
+        tcg_out_xori32(s, dst, dst, 1);
     }
 }
 
@@ -1590,9 +1612,10 @@ static TCGReg tcg_gen_setcond_xor(TCGContext *s, TCGReg arg1, TCGArg arg2,
 
 static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGArg arg0, TCGArg arg1, TCGArg arg2,
-                            int const_arg2)
+                            int const_arg2, bool neg)
 {
-    int crop, sh;
+    int sh;
+    bool inv;
 
     tcg_debug_assert(TCG_TARGET_REG_BITS == 64 || type == TCG_TYPE_I32);
 
@@ -1605,14 +1628,10 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (arg2 == 0) {
         switch (cond) {
         case TCG_COND_EQ:
-            tcg_out_setcond_eq0(s, type, arg0, arg1);
+            tcg_out_setcond_eq0(s, type, arg0, arg1, neg);
             return;
         case TCG_COND_NE:
-            if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
-                tcg_out_ext32u(s, TCG_REG_R0, arg1);
-                arg1 = TCG_REG_R0;
-            }
-            tcg_out_setcond_ne0(s, arg0, arg1);
+            tcg_out_setcond_ne0(s, type, arg0, arg1, neg);
             return;
         case TCG_COND_GE:
             tcg_out32(s, NOR | SAB(arg1, arg0, arg1));
@@ -1621,9 +1640,17 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         case TCG_COND_LT:
             /* Extract the sign bit.  */
             if (type == TCG_TYPE_I32) {
-                tcg_out_shri32(s, arg0, arg1, 31);
+                if (neg) {
+                    tcg_out_sari32(s, arg0, arg1, 31);
+                } else {
+                    tcg_out_shri32(s, arg0, arg1, 31);
+                }
             } else {
-                tcg_out_shri64(s, arg0, arg1, 63);
+                if (neg) {
+                    tcg_out_sari64(s, arg0, arg1, 63);
+                } else {
+                    tcg_out_shri64(s, arg0, arg1, 63);
+                }
             }
             return;
         default:
@@ -1641,7 +1668,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
 
         isel = tcg_to_isel[cond];
 
-        tcg_out_movi(s, type, arg0, 1);
+        tcg_out_movi(s, type, arg0, neg ? -1 : 1);
         if (isel & 1) {
             /* arg0 = (bc ? 0 : 1) */
             tab = TAB(arg0, 0, arg0);
@@ -1655,51 +1682,47 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
     }
 
+    inv = false;
     switch (cond) {
     case TCG_COND_EQ:
         arg1 = tcg_gen_setcond_xor(s, arg1, arg2, const_arg2);
-        tcg_out_setcond_eq0(s, type, arg0, arg1);
-        return;
+        tcg_out_setcond_eq0(s, type, arg0, arg1, neg);
+        break;
 
     case TCG_COND_NE:
         arg1 = tcg_gen_setcond_xor(s, arg1, arg2, const_arg2);
-        /* Discard the high bits only once, rather than both inputs.  */
-        if (TCG_TARGET_REG_BITS == 64 && type == TCG_TYPE_I32) {
-            tcg_out_ext32u(s, TCG_REG_R0, arg1);
-            arg1 = TCG_REG_R0;
-        }
-        tcg_out_setcond_ne0(s, arg0, arg1);
-        return;
+        tcg_out_setcond_ne0(s, type, arg0, arg1, neg);
+        break;
 
+    case TCG_COND_LE:
+    case TCG_COND_LEU:
+        inv = true;
+        /* fall through */
     case TCG_COND_GT:
     case TCG_COND_GTU:
-        sh = 30;
-        crop = 0;
-        goto crtest;
-
-    case TCG_COND_LT:
-    case TCG_COND_LTU:
-        sh = 29;
-        crop = 0;
+        sh = 30; /* CR7 CR_GT */
         goto crtest;
 
     case TCG_COND_GE:
     case TCG_COND_GEU:
-        sh = 31;
-        crop = CRNOR | BT(7, CR_EQ) | BA(7, CR_LT) | BB(7, CR_LT);
+        inv = true;
+        /* fall through */
+    case TCG_COND_LT:
+    case TCG_COND_LTU:
+        sh = 29; /* CR7 CR_LT */
         goto crtest;
 
-    case TCG_COND_LE:
-    case TCG_COND_LEU:
-        sh = 31;
-        crop = CRNOR | BT(7, CR_EQ) | BA(7, CR_GT) | BB(7, CR_GT);
     crtest:
         tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
-        if (crop) {
-            tcg_out32(s, crop);
-        }
         tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(7));
         tcg_out_rlw(s, RLWINM, arg0, TCG_REG_R0, sh, 31, 31);
+        if (neg && inv) {
+            tcg_out32(s, ADDI | TAI(arg0, arg0, -1));
+        } else if (neg) {
+            tcg_out32(s, NEG | RT(arg0) | RA(arg0));
+        } else if (inv) {
+            tcg_out_xori32(s, arg0, arg0, 1);
+        }
         break;
 
     default:
@@ -2982,11 +3005,19 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_setcond_i32:
         tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
-                        const_args[2]);
+                        const_args[2], false);
         break;
     case INDEX_op_setcond_i64:
         tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
-                        const_args[2]);
+                        const_args[2], false);
+        break;
+    case INDEX_op_negsetcond_i32:
+        tcg_out_setcond(s, TCG_TYPE_I32, args[3], args[0], args[1], args[2],
+                        const_args[2], true);
+        break;
+    case INDEX_op_negsetcond_i64:
+        tcg_out_setcond(s, TCG_TYPE_I64, args[3], args[0], args[1], args[2],
+                        const_args[2], true);
         break;
     case INDEX_op_setcond2_i32:
         tcg_out_setcond2(s, args, const_args);
@@ -3724,6 +3755,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
     case INDEX_op_setcond_i32:
+    case INDEX_op_negsetcond_i32:
     case INDEX_op_and_i64:
     case INDEX_op_andc_i64:
     case INDEX_op_shl_i64:
@@ -3732,6 +3764,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
     case INDEX_op_setcond_i64:
+    case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, ri);
 
     case INDEX_op_mul_i32:
-- 
2.34.1


