Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB9A8A901
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 22:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m3h-0006FE-Ji; Tue, 15 Apr 2025 15:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzI-0008UP-M6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:29 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4ly6-0000mc-DP
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:28 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so5263703a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745345; x=1745350145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qetr7RoWoAcNLZszi3yGscqn5GPcugJGfoWDgdb4lIU=;
 b=hA9r6Tn0cB1iHUncJBktGHuUzuMOm2BIidWhzF7CvU4G+ZrLIRjFlH0UGlMS56dte5
 WE55+NFeBiMK+GM5YqKTBF083lsEPHxsJdeY7Uf5agcqaWz9DNERC8v+rqzc6wsUHll9
 IrSqfFxooJR8+LpUW1NRXZDVbvSRZEvZzHqQC1TV3vBGSh8JEQj11kXcfxmU2ymVwsZ7
 Fk+qrbWpf5EgPsTgl34brHjnAKAnAQA5HLMoDbN1EYr+eEKvZsCa/nh4WjkIVGvgj/Ce
 jbh8hkTJMyRvi/lgDhStlPh0GKVW2bQvOnrfSMp27UoHSNQ5gjh6z7VNbs2AvwdvjK/q
 iDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745345; x=1745350145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qetr7RoWoAcNLZszi3yGscqn5GPcugJGfoWDgdb4lIU=;
 b=Pv3jsTjuT3+TA1QNBDNxN6xactc3hon33GnMHaFuvqk+kIpGjdGAmJgQT9Ru2K6Kt/
 gaORONOhjPJ4yOiFmUxxGo/HjpA7P2Py4590pEQm+tohlqAXQIimNKMo3qXwktPENmmM
 BJNKNnTRReDr9LYGsjq5jF5MDAa7Zk3WV0KW6ieAbOiXyJAzDngTh/vUa9pPcS9rIxyy
 hAZ5C84mVFlvY/7rIPVUs3kKienYSFO4fW1/g/ClvFIoqfWG+pT7gzOBqqLtPth/2YLF
 LpsGxwN7nAaTEOwDK0PFp6cAedzvk7wpC1DLgeytKQ4BR6vd9lEW9Oh8F8TGjDOctaC0
 hvRQ==
X-Gm-Message-State: AOJu0Yx8ePmBHz4Vuj4nMEt3FPfCzm1GlQw0Q1spB7VetHUYtcHH66BN
 M1WX6U1VkeDd2dAfkBLPaPx3PjRwiFD93kWPv1voeOw3wJRVR+o5d+VNRbAgXoJ79qcMD3jSIdz
 y
X-Gm-Gg: ASbGncuh+jGypWs0hzSxG14GtL5eOtFQfcUlFPJBA3ABNMUernEaow1vCFxXErw4ixq
 TUia/EbrbLFyZuBs9ideYxQFQSWkSOt8qMNyR0kBuiHrRd63RKKMcwYX6A3iW+Q6ayHG7M+DGpX
 jgvWy4XIEHNtZUnxqlcRFgJjjxWGB/kK2ln842xawI+nXGfAVai+5CpUN1Fy83/YSnVntjpGLdC
 G7HpOhpMLV4hYh6g0fxA2Pwh7dXkOjMo2uACBy9I1L/2uVuVszg4v/7kTXrL6D6R3F+NVrje0ur
 2n0U7fpb1HKiI55ZTsVOZd78YbVr7HvbL9TFaZ5RRG4j7NnGEioaBTuiZ+CtjhdmNWTmKtikhiI
 VzJ7d4YHK1w==
X-Google-Smtp-Source: AGHT+IFSSwoub39a9jc3WrrMFHlcCT/mEU3tiY1RTbXZUb0H2lIzxJhhhXx/3mLitoe/eSuHJgS/1A==
X-Received: by 2002:a17:90a:d2c8:b0:2ff:4bac:6fba with SMTP id
 98e67ed59e1d1-3085ef6c355mr558198a91.24.1744745344685; 
 Tue, 15 Apr 2025 12:29:04 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 055/163] tcg: Convert shr to TCGOutOpBinary
Date: Tue, 15 Apr 2025 12:23:26 -0700
Message-ID: <20250415192515.232910-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 tcg/tcg.c                        |  6 +++--
 tcg/aarch64/tcg-target.c.inc     | 37 ++++++++++++++-------------
 tcg/arm/tcg-target.c.inc         | 24 ++++++++++++++----
 tcg/i386/tcg-target.c.inc        | 33 +++++++++++++++++++-----
 tcg/loongarch64/tcg-target.c.inc | 43 +++++++++++++++++++-------------
 tcg/mips/tcg-target.c.inc        | 35 +++++++++++++++++---------
 tcg/ppc/tcg-target.c.inc         | 42 ++++++++++++++++++-------------
 tcg/riscv/tcg-target.c.inc       | 38 +++++++++++++++-------------
 tcg/s390x/tcg-target.c.inc       | 39 ++++++++++++++++++++++-------
 tcg/sparc64/tcg-target.c.inc     | 29 +++++++++++++++------
 tcg/tci/tcg-target.c.inc         | 18 ++++++++++---
 11 files changed, 229 insertions(+), 115 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 83a7f2c1df..e488a0eb89 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1043,6 +1043,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
+    OUTOP(INDEX_op_shr_i32, TCGOutOpBinary, outop_shr),
+    OUTOP(INDEX_op_shr_i64, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -2263,7 +2265,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_extract_i32:
     case INDEX_op_sextract_i32:
@@ -2314,7 +2315,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
@@ -5420,6 +5420,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_rems:
     case INDEX_op_remu:
     case INDEX_op_shl:
+    case INDEX_op_shr_i32:
+    case INDEX_op_shr_i64:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index b57baa1eec..87b97e852a 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1347,13 +1347,6 @@ static inline void tcg_out_extr(TCGContext *s, TCGType ext, TCGReg rd,
     tcg_out_insn(s, 3403, EXTR, ext, rd, rn, rm, a);
 }
 
-static inline void tcg_out_shr(TCGContext *s, TCGType ext,
-                               TCGReg rd, TCGReg rn, unsigned int m)
-{
-    int max = ext ? 63 : 31;
-    tcg_out_ubfm(s, ext, rd, rn, m & max, max);
-}
-
 static inline void tcg_out_sar(TCGContext *s, TCGType ext,
                                TCGReg rd, TCGReg rn, unsigned int m)
 {
@@ -2310,6 +2303,25 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_insn(s, 3508, LSRV, type, a0, a1, a2);
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int max = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_ubfm(s, type, a0, a1, a2 & max, max);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2427,15 +2439,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_shr_i64:
-    case INDEX_op_shr_i32:
-        if (c2) {
-            tcg_out_shr(s, ext, a0, a1, a2);
-        } else {
-            tcg_out_insn(s, 3508, LSRV, ext, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sar_i64:
     case INDEX_op_sar_i32:
         if (c2) {
@@ -3093,11 +3096,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rC);
 
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 2b9e52914c..247aefd0a1 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1982,6 +1982,25 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1, SHIFT_REG_LSR(a2));
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_dat_reg(s, COND_AL, ARITH_MOV, a0, 0, a1,
+                    SHIFT_IMM_LSR(a2 & 0x1f));
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2133,10 +2152,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_muls2_i32:
         tcg_out_smull32(s, COND_AL, args[0], args[1], args[2], args[3]);
         break;
-    case INDEX_op_shr_i32:
-        c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_LSR(args[2] & 0x1f) :
-                SHIFT_IMM_LSL(0) : SHIFT_REG_LSR(args[2]);
-        goto gen_shift32;
     case INDEX_op_sar_i32:
         c = const_args[2] ? (args[2] & 0x1f) ? SHIFT_IMM_ASR(args[2] & 0x1f) :
                 SHIFT_IMM_LSL(0) : SHIFT_REG_ASR(args[2]);
@@ -2314,7 +2329,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i32:
         return C_O2_I2(r, r, r, r);
 
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 648d9ee66c..93d94e7881 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2787,6 +2787,33 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    if (have_bmi2) {
+        tcg_out_vex_modrm(s, OPC_SHRX + rexw, a0, a2, a1);
+    } else {
+        tcg_out_modrm(s, OPC_SHIFT_cl + rexw, SHIFT_SHR, a0);
+    }
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+
+    tcg_out_mov(s, type, a0, a1);
+    tcg_out_shifti(s, SHIFT_SHR + rexw, a0, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_shift,
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                       TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2922,10 +2949,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(shr):
-        c = SHIFT_SHR;
-        vexop = OPC_SHRX;
-        goto gen_shift_maybe_vex;
     OP_32_64(sar):
         c = SHIFT_SAR;
         vexop = OPC_SARX;
@@ -3787,8 +3810,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
         return have_bmi2 ? C_O1_I2(r, r, ri) : C_O1_I2(r, 0, ci);
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 4aa3126a09..9465b12ce0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1503,6 +1503,32 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_srl_w(s, a0, a1, a2);
+    } else {
+        tcg_out_opc_srl_d(s, a0, a1, a2);
+    }
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
+    } else {
+        tcg_out_opc_srli_d(s, a0, a1, a2 & 0x3f);
+    }
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1674,21 +1700,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_clzctz(s, OPC_CTZ_D, a0, a1, a2, c2, false);
         break;
 
-    case INDEX_op_shr_i32:
-        if (c2) {
-            tcg_out_opc_srli_w(s, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_srl_w(s, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_opc_srli_d(s, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_srl_d(s, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sar_i32:
         if (c2) {
             tcg_out_opc_srai_w(s, a0, a1, a2 & 0x1f);
@@ -2374,8 +2385,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
 
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 30d8872b4f..03b4248ea9 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1931,6 +1931,29 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    MIPSInsn insn = type == TCG_TYPE_I32 ? OPC_SRLV : OPC_DSRLV;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_opc_sa(s, OPC_SRL, a0, a1, a2);
+    } else {
+        tcg_out_dsrl(s, a0, a1, a2);
+    }
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2091,9 +2114,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     case INDEX_op_sar_i32:
         i1 = OPC_SRAV, i2 = OPC_SRA;
         goto do_shift;
-    case INDEX_op_shr_i32:
-        i1 = OPC_SRLV, i2 = OPC_SRL;
-        goto do_shift;
     case INDEX_op_rotr_i32:
         i1 = OPC_ROTRV, i2 = OPC_ROTR;
     do_shift:
@@ -2119,13 +2139,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         i1 = OPC_DSRAV;
         goto do_shiftv;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_dsrl(s, a0, a1, a2);
-            break;
-        }
-        i1 = OPC_DSRLV;
-        goto do_shiftv;
     case INDEX_op_rotr_i64:
         if (c2) {
             tcg_out_opc_sa64(s, OPC_DROTR, OPC_DROTR32, a0, a1, a2);
@@ -2306,11 +2319,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_muls2_i64:
     case INDEX_op_mulu2_i64:
         return C_O2_I2(r, r, r, r);
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotr_i32:
     case INDEX_op_rotl_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotr_i64:
     case INDEX_op_rotl_i64:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 88cfcd1d91..2012734bb3 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3146,6 +3146,30 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SRW : SRD;
+    tcg_out32(s, insn | SAB(a1, a0, a2));
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    /* Limit immediate shift count lest we create an illegal insn.  */
+    if (type == TCG_TYPE_I32) {
+        tcg_out_shri32(s, a0, a1, a2 & 31);
+    } else {
+        tcg_out_shri64(s, a0, a1, a2 & 63);
+    }
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -3296,14 +3320,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out32(s, CNTPOPD | SAB(args[1], args[0], 0));
         break;
 
-    case INDEX_op_shr_i32:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shri32(s, args[0], args[1], args[2] & 31);
-        } else {
-            tcg_out32(s, SRW | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_sar_i32:
         if (const_args[2]) {
             tcg_out_sari32(s, args[0], args[1], args[2]);
@@ -3341,14 +3357,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_brcond2(s, args, const_args);
         break;
 
-    case INDEX_op_shr_i64:
-        if (const_args[2]) {
-            /* Limit immediate shift count lest we create an illegal insn.  */
-            tcg_out_shri64(s, args[0], args[1], args[2] & 63);
-        } else {
-            tcg_out32(s, SRD | SAB(args[1], args[0], args[2]));
-        }
-        break;
     case INDEX_op_sar_i64:
         if (const_args[2]) {
             tcg_out_sari64(s, args[0], args[1], args[2]);
@@ -4214,11 +4222,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 372c4e1651..8020cc0b3f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2165,6 +2165,27 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SRLW : OPC_SRL;
+    tcg_out_opc_reg(s, insn, a0, a1, a2);
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    RISCVInsn insn = type == TCG_TYPE_I32 ? OPC_SRLIW : OPC_SRLI;
+    unsigned mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_opc_imm(s, insn, a0, a1, a2 & mask);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2278,21 +2299,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_shr_i32:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SRLIW, a0, a1, a2 & 0x1f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SRLW, a0, a1, a2);
-        }
-        break;
-    case INDEX_op_shr_i64:
-        if (c2) {
-            tcg_out_opc_imm(s, OPC_SRLI, a0, a1, a2 & 0x3f);
-        } else {
-            tcg_out_opc_reg(s, OPC_SRL, a0, a1, a2);
-        }
-        break;
-
     case INDEX_op_sar_i32:
         if (c2) {
             tcg_out_opc_imm(s, OPC_SRAIW, a0, a1, a2 & 0x1f);
@@ -2764,11 +2770,9 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i64:
     case INDEX_op_rotr_i64:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index ed68054664..0417bbef50 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -2475,6 +2475,36 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr_int(TCGContext *s, TCGType type, TCGReg dst,
+                         TCGReg src, TCGReg v, tcg_target_long i)
+{
+    if (type != TCG_TYPE_I32) {
+        tcg_out_sh64(s, RSY_SRLG, dst, src, v, i);
+    } else if (dst == src) {
+        tcg_out_sh32(s, RS_SRL, dst, v, i);
+    } else {
+        tcg_out_sh64(s, RSY_SRLK, dst, src, v, i);
+    }
+}
+
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    tgen_shr_int(s, type, a0, a1, a2, 0);
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tgen_shr_int(s, type, a0, a1, TCG_REG_NONE, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, ri),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -2621,10 +2651,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             }
         }
         break;
-    case INDEX_op_shr_i32:
-        op = RS_SRL;
-        op2 = RSY_SRLK;
-        goto do_shift32;
     case INDEX_op_sar_i32:
         op = RS_SRA;
         op2 = RSY_SRAK;
@@ -2780,9 +2806,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
             tcg_out_sh64(s, op, args[0], args[1], args[2], 0);
         }
         break;
-    case INDEX_op_shr_i64:
-        op = RSY_SRLG;
-        goto do_shift64;
     case INDEX_op_sar_i64:
         op = RSY_SRAG;
         goto do_shift64;
@@ -3371,7 +3394,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
     case INDEX_op_rotl_i64:
@@ -3387,7 +3409,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_clz_i64:
         return C_O1_I2(r, r, rI);
 
-    case INDEX_op_shr_i32:
     case INDEX_op_sar_i32:
         return C_O1_I2(r, r, ri);
 
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 6b320a8622..f679fa04ea 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1505,6 +1505,27 @@ static const TCGOutOpBinary outop_shl = {
     .out_rri = tgen_shli,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SRL : SHIFT_SRLX;
+    tcg_out_arith(s, a0, a1, a2, insn);
+}
+
+static void tgen_shri(TCGContext *s, TCGType type,
+                      TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    uint32_t insn = type == TCG_TYPE_I32 ? SHIFT_SRL : SHIFT_SRLX;
+    uint32_t mask = type == TCG_TYPE_I32 ? 31 : 63;
+    tcg_out_arithi(s, a0, a1, a2 & mask, insn);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, rJ),
+    .out_rrr = tgen_shr,
+    .out_rri = tgen_shri,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -1612,9 +1633,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 31, c2, c);
         break;
-    case INDEX_op_shr_i32:
-        c = SHIFT_SRL;
-        goto do_shift32;
     case INDEX_op_sar_i32:
         c = SHIFT_SRA;
         goto do_shift32;
@@ -1679,9 +1697,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         /* Limit immediate shift count lest we create an illegal insn.  */
         tcg_out_arithc(s, a0, a1, a2 & 63, c2, c);
         break;
-    case INDEX_op_shr_i64:
-        c = SHIFT_SRLX;
-        goto do_shift64;
     case INDEX_op_sar_i64:
         c = SHIFT_SRAX;
         goto do_shift64;
@@ -1768,8 +1783,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
     case INDEX_op_setcond_i32:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index ca83a097ab..5651833ac9 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -79,8 +79,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
@@ -787,6 +785,21 @@ static const TCGOutOpBinary outop_shl = {
     .out_rrr = tgen_shl,
 };
 
+static void tgen_shr(TCGContext *s, TCGType type,
+                     TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    if (type < TCG_TYPE_REG) {
+        tcg_out_ext32u(s, TCG_REG_TMP, a1);
+        a1 = TCG_REG_TMP;
+    }
+    tcg_out_op_rrr(s, glue(INDEX_op_shr_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+}
+
+static const TCGOutOpBinary outop_shr = {
+    .base.static_constraint = C_O1_I2(r, r, r),
+    .out_rrr = tgen_shr,
+};
+
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
@@ -871,7 +884,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, opc, args[0], args[1], args[2]);
         break;
 
-    CASE_32_64(shr)
     CASE_32_64(sar)
     CASE_32_64(rotl)     /* Optional (TCG_TARGET_HAS_rot_*). */
     CASE_32_64(rotr)     /* Optional (TCG_TARGET_HAS_rot_*). */
-- 
2.43.0


