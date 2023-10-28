Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 011927DA90F
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFs-0004mt-0J; Sat, 28 Oct 2023 15:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFY-0004io-Bu
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFW-00046n-47
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcee9so2858419b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522332; x=1699127132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2ygD5i+6wL7HEXCM8bQfaa1hBE0P2O4Q3y82rtx6wg=;
 b=b+o1ZD3PVb+N2DIV8T0OYPcD7NS7TDTc4urmEwzlieuedNkGQMAjc1GvG+S7P57lGI
 a5amVo1oxbgTF9TQo0flFIbpx8ATKezTuX801joUzBtreZaD4SltSe5Tg7mpAUMdiLbH
 pEG2Sl/2y3AiBtDJmDb4wY9Ac1ZU9CSTzF+x3pI+HHay+LGG+epxZl8K+tFU0kQQmUoP
 35RT4qQMy1Kb83UJIrYPR/AS2tAUzhUz3P9bJJbzuGeJendRwt1DeX3vXimcSGhWuzQx
 M62MhIHpPRoKhV/10f3KLFHDytIR1Kns8Nb+pjZlE3fsIvgQXhMpQvAIjReMFFstL4b4
 vtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522332; x=1699127132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2ygD5i+6wL7HEXCM8bQfaa1hBE0P2O4Q3y82rtx6wg=;
 b=Y6aWAPK9fe5wv0Cmt/8YNOpUyYygJ1DQsjXl1I6TisvaiTIBmhgJJwwSNcaggJxSI4
 ZUKE9nURCf+f32iJnw1R82KPrOMCP5zJiOmvXsdUMHvpw5rPCCf8xOY136jejbsoay5r
 /DkEcb2qp53M4QjhU+PRowKeiMad435KyVolrMVQ/YUfY76NlaiD3g4CHH3FEFCeGr99
 usUTNezAsXR/62raWok+L1nqBgTBWF9bdAcMfMAPFKXFUm2ntRDXgbgcOg5tyZSY1Vef
 u8OFfoURLa5TES+DBcKkZmV4oL5+KHnFyjyTkq/GH6WUbMgW/P/UaBzuhlZrviUE9bwf
 8VNg==
X-Gm-Message-State: AOJu0Ywbcm8Ih7E9jd41hYP2pe/6OxO3Xy4DjmXr6SqChkC5cjNyDYkG
 g2s9C+Ys4aKBDGnWcQAYnzIDVisE0HuoT/zAQ9g=
X-Google-Smtp-Source: AGHT+IEcNy7UIaasPLIk5DlHDbv257Ije2n/izRn/YrUjhQ+6mOuB9MlCSnCJbbjt/ZzvIBfGSU4TQ==
X-Received: by 2002:a05:6a20:8e24:b0:17f:f8f3:ea51 with SMTP id
 y36-20020a056a208e2400b0017ff8f3ea51mr1993364pzj.20.1698522331825; 
 Sat, 28 Oct 2023 12:45:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 08/35] tcg/aarch64: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:44:55 -0700
Message-Id: <20231028194522.245170-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  5 +--
 tcg/aarch64/tcg-target-con-str.h |  1 +
 tcg/aarch64/tcg-target.c.inc     | 56 ++++++++++++++++++++++----------
 3 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 3fdee26a3d..44fcc1206e 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -10,7 +10,7 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(r, rA)
+C_O0_I2(r, rC)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
 C_O0_I3(rZ, rZ, r)
@@ -22,6 +22,7 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rA)
 C_O1_I2(r, r, rAL)
+C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
 C_O1_I2(r, rZ, rZ)
@@ -31,6 +32,6 @@ C_O1_I2(w, w, wN)
 C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, r, rA, rZ, rZ)
+C_O1_I4(r, r, rC, rZ, rZ)
 C_O2_I1(r, r, r)
 C_O2_I4(r, r, rZ, rZ, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target-con-str.h b/tcg/aarch64/tcg-target-con-str.h
index fb1a845b4f..48e1722c68 100644
--- a/tcg/aarch64/tcg-target-con-str.h
+++ b/tcg/aarch64/tcg-target-con-str.h
@@ -16,6 +16,7 @@ REGS('w', ALL_VECTOR_REGS)
  * CONST(letter, TCG_CT_CONST_* bit set)
  */
 CONST('A', TCG_CT_CONST_AIMM)
+CONST('C', TCG_CT_CONST_CMP)
 CONST('L', TCG_CT_CONST_LIMM)
 CONST('M', TCG_CT_CONST_MONE)
 CONST('O', TCG_CT_CONST_ORRI)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 420e4a35ea..70df250c04 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -126,6 +126,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_MONE 0x800
 #define TCG_CT_CONST_ORRI 0x1000
 #define TCG_CT_CONST_ANDI 0x2000
+#define TCG_CT_CONST_CMP  0x4000
 
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
@@ -279,6 +280,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if (type == TCG_TYPE_I32) {
         val = (int32_t)val;
     }
+
+    if (ct & TCG_CT_CONST_CMP) {
+        if (is_tst_cond(cond)) {
+            ct |= TCG_CT_CONST_LIMM;
+        } else {
+            ct |= TCG_CT_CONST_AIMM;
+        }
+    }
+
     if ((ct & TCG_CT_CONST_AIMM) && (is_aimm(val) || is_aimm(-val))) {
         return 1;
     }
@@ -345,6 +355,9 @@ static const enum aarch64_cond_code tcg_cond_to_aarch64[] = {
     [TCG_COND_GTU] = COND_HI,
     [TCG_COND_GEU] = COND_HS,
     [TCG_COND_LEU] = COND_LS,
+    /* bit test */
+    [TCG_COND_TSTEQ] = COND_EQ,
+    [TCG_COND_TSTNE] = COND_NE,
 };
 
 typedef enum {
@@ -1342,19 +1355,26 @@ static inline void tcg_out_dep(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_bfm(s, ext, rd, rn, a, b);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGReg a,
+static void tcg_out_cmp(TCGContext *s, TCGType ext, TCGCond cond, TCGReg a,
                         tcg_target_long b, bool const_b)
 {
-    if (const_b) {
-        /* Using CMP or CMN aliases.  */
-        if (b >= 0) {
-            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+    if (is_tst_cond(cond)) {
+        if (!const_b) {
+            tcg_out_insn(s, 3510, ANDS, ext, TCG_REG_XZR, a, b);
         } else {
-            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+            tcg_debug_assert(is_limm(b));
+            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, a, b);
         }
     } else {
-        /* Using CMP alias SUBS wzr, Wn, Wm */
-        tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        if (!const_b) {
+            tcg_out_insn(s, 3502, SUBS, ext, TCG_REG_XZR, a, b);
+        } else if (b >= 0) {
+            tcg_debug_assert(is_aimm(b));
+            tcg_out_insn(s, 3401, SUBSI, ext, TCG_REG_XZR, a, b);
+        } else {
+            tcg_debug_assert(is_aimm(-b));
+            tcg_out_insn(s, 3401, ADDSI, ext, TCG_REG_XZR, a, -b);
+        }
     }
 }
 
@@ -1402,7 +1422,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
         need_cmp = false;
     } else {
         need_cmp = true;
-        tcg_out_cmp(s, ext, a, b, b_const);
+        tcg_out_cmp(s, ext, c, a, b, b_const);
     }
 
     if (!l->has_value) {
@@ -1575,7 +1595,7 @@ static void tcg_out_cltz(TCGContext *s, TCGType ext, TCGReg d,
     } else {
         AArch64Insn sel = I3506_CSEL;
 
-        tcg_out_cmp(s, ext, a0, 0, 1);
+        tcg_out_cmp(s, ext, TCG_COND_NE, a0, 0, 1);
         tcg_out_insn(s, 3507, CLZ, ext, TCG_REG_TMP0, a1);
 
         if (const_b) {
@@ -1720,7 +1740,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                          addr_adj, compare_mask);
 
         /* Perform the address comparison. */
-        tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
+        tcg_out_cmp(s, addr_type, TCG_COND_NE, TCG_REG_TMP0, TCG_REG_TMP2, 0);
 
         /* If not equal, we jump to the slow path. */
         ldst->label_ptr[0] = s->code_ptr;
@@ -2276,7 +2296,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_setcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSET alias of CSINC Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINC, TCG_TYPE_I32, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2286,7 +2306,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_negsetcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[3], a1, a2, c2);
         /* Use CSETM alias of CSINV Wd, WZR, WZR, invert(cond).  */
         tcg_out_insn(s, 3506, CSINV, ext, a0, TCG_REG_XZR,
                      TCG_REG_XZR, tcg_invert_cond(args[3]));
@@ -2296,7 +2316,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         a2 = (int32_t)a2;
         /* FALLTHRU */
     case INDEX_op_movcond_i64:
-        tcg_out_cmp(s, ext, a1, a2, c2);
+        tcg_out_cmp(s, ext, args[5], a1, a2, c2);
         tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
         break;
 
@@ -2896,11 +2916,13 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_add_i64:
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
+        return C_O1_I2(r, r, rA);
+
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, r, rA);
+        return C_O1_I2(r, r, rC);
 
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
@@ -2950,11 +2972,11 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rA);
+        return C_O0_I2(r, rC);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rA, rZ, rZ);
+        return C_O1_I4(r, r, rC, rZ, rZ);
 
     case INDEX_op_qemu_ld_a32_i32:
     case INDEX_op_qemu_ld_a64_i32:
-- 
2.34.1


