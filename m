Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC3FA378C1
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Feb 2025 00:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnrn-00064q-B0; Sun, 16 Feb 2025 18:16:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnph-0000fE-2Z
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnpc-0005Pb-TW
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:13:51 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-221206dbd7eso9764075ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747627; x=1740352427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OcHB73MnOPGXPj50e77XALdR+QYb0NF02ijbo0aRq64=;
 b=t5Kgq4m3hYJCoJxJiINhWWpSHwinwy4JpAqtUUgaCHPXeiV3gAbSBNoc3wwd2V6H9u
 uwhvVloWUhY55qAiXejCIxi1MaH83fwDbq+0XQPi4a0ZF0NvaKqYMB4OrZE19JeNq5sp
 73IK0grzFX9mo2gQo3Xgv3BCkOoboztSOrsl7t51wyG4XxlltPqOr7+zWXLganGaQvmB
 JoWfn74r3XuBME+N0JzBClEAU7q5QXqHG7HQDEI0UkffP8xs7XdoPJMSTk+eWrVcpPtH
 zMNb70o6CkqxNFuGHf2GZnwzgWiXQr2itfcwWzbEhCV6yMxYd7pVn+26iN4Wno3M/v3E
 XHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747627; x=1740352427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OcHB73MnOPGXPj50e77XALdR+QYb0NF02ijbo0aRq64=;
 b=fzYOLLefxk026mbzjZ5gR2vE8ljUlTDgXbBVMTQTLuI5jYuQffQEhoMO8jkwwWb4Cv
 pTQhQ6DQpde+YrAMQZxzC5qz4pFWFXSTrMylqBJOjDJ83ANI0/GbeQ0u9reFmWAVhcwL
 MUKHBvqbnybb2MKQNiW7gFFPrQKivlIonVD+P/UoF2jKwiqfPKn3J2Ypr6qWSz/3MdUo
 m99zGjpE+WQwib2yxkWaU5UDQA+XycnsonFAzaMk8gjb43TFX0D3od3s+geMXa1yk8zp
 T+64ACVyEUnMvs46fFLavqZvQOYnrTSb+nzG/wM+0SCHiKB8W2SGYgdRhUSrc6BMPPYN
 axBA==
X-Gm-Message-State: AOJu0YyNud547wuczhYLMozVm5L7OQ1dsiiHA5nZf7zzkqzXrV12nZX7
 whCPd9ddyt+3RL+fRD4fqf5tZVKHpdA1AwfEZTBdQKTmyJ3GQoRJEJdxEdAJWaoliOtCK0u5oKO
 D
X-Gm-Gg: ASbGncvxAKJThMjibxArqu9W9kV9HpVuuzCswDRfx6cfssFSs01kLE/TxLebGCz1Yt0
 FoccYAJxYLqx1WtboXMzHoaEoN+euzimGeQ1vFtlYBgK6idH5/pFUtUbWQOOU7DzgEUdg1eSZdO
 LAyfY1ESLsz9PAIecTlf9V/fBRNiss6bHkjYL/OQfB0/06hzawBK9dob47A2vzLeJAGt/B1fT2o
 bV3/4zppllnxhmb2rbC0+n2HeWQCP2Fo8MAkhibGXVQgQ1LwdLemPtbo4EVBMpxD8bcQWsbrzy9
 93YVQgogBRc57ywREpb7D+NeOIqnzRHLhEPnFafoqMNUbBk=
X-Google-Smtp-Source: AGHT+IFTaRtTmGfidbz3WrSmtyRKR/A2ZgzYyHPORhDCvtR9cT4/zOyx8aAx0/E54gN1vzAHfa0bSw==
X-Received: by 2002:a17:903:986:b0:216:6fb5:fd83 with SMTP id
 d9443c01a7336-22104030d06mr114780575ad.29.1739747627237; 
 Sun, 16 Feb 2025 15:13:47 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366882sm60565615ad.95.2025.02.16.15.13.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:13:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 043/162] tcg: Merge INDEX_op_divu_{i32,i64}
Date: Sun, 16 Feb 2025 15:08:12 -0800
Message-ID: <20250216231012.2808572-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           |  9 +++++----
 tcg/tcg-op.c             | 16 ++++++++--------
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 6d4edd0b16..243f002a61 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -43,6 +43,7 @@ DEF(add, 1, 2, 0, TCG_OPF_INT)
 DEF(and, 1, 2, 0, TCG_OPF_INT)
 DEF(andc, 1, 2, 0, TCG_OPF_INT)
 DEF(divs, 1, 2, 0, TCG_OPF_INT)
+DEF(divu, 1, 2, 0, TCG_OPF_INT)
 DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
@@ -69,7 +70,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i32, 1, 2, 0, 0)
 DEF(rem_i32, 1, 2, 0, 0)
 DEF(remu_i32, 1, 2, 0, 0)
 DEF(div2_i32, 2, 3, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(divu_i64, 1, 2, 0, 0)
 DEF(rem_i64, 1, 2, 0, 0)
 DEF(remu_i64, 1, 2, 0, 0)
 DEF(div2_i64, 2, 3, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 127d0f9390..77386eacb7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -551,9 +551,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x / ((int64_t)y ? : 1);
 
-    case INDEX_op_divu_i32:
-        return (uint32_t)x / ((uint32_t)y ? : 1);
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x / ((uint32_t)y ? : 1);
+        }
         return (uint64_t)x / ((uint64_t)y ? : 1);
 
     case INDEX_op_rem_i32:
@@ -2896,7 +2897,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_deposit(&ctx, op);
             break;
         case INDEX_op_divs:
-        CASE_OP_32_64(divu):
+        case INDEX_op_divu:
             done = fold_divide(&ctx, op);
             break;
         case INDEX_op_dup_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 19be461214..f326c452a4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -635,8 +635,8 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu_i32, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i32) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 zero = tcg_constant_i32(0);
@@ -651,9 +651,9 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (TCG_TARGET_HAS_rem_i32) {
         tcg_gen_op3_i32(INDEX_op_remu_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu_i32, t0, arg1, arg2);
+        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i32(t0, t0, arg2);
         tcg_gen_sub_i32(ret, arg1, t0);
         tcg_temp_free_i32(t0);
@@ -2003,8 +2003,8 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu_i64, ret, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
     } else if (TCG_TARGET_HAS_div2_i64) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 zero = tcg_constant_i64(0);
@@ -2019,9 +2019,9 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_HAS_rem_i64) {
         tcg_gen_op3_i64(INDEX_op_remu_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu_i64, t0, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
         tcg_gen_mul_i64(t0, t0, arg2);
         tcg_gen_sub_i64(ret, arg1, t0);
         tcg_temp_free_i64(t0);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 2f8b99c428..7409aab2b8 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1021,8 +1021,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
     OUTOP(INDEX_op_divs, TCGOutOpBinary, outop_divs),
-    OUTOP(INDEX_op_divu_i32, TCGOutOpBinary, outop_divu),
-    OUTOP(INDEX_op_divu_i64, TCGOutOpBinary, outop_divu),
+    OUTOP(INDEX_op_divu, TCGOutOpBinary, outop_divu),
     OUTOP(INDEX_op_eqv, TCGOutOpBinary, outop_eqv),
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
@@ -5409,8 +5408,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_mulsh:
diff --git a/tcg/tci.c b/tcg/tci.c
index 0691824f97..bf97849bfe 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -724,7 +724,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] / (int64_t)regs[r2];
             break;
-        case INDEX_op_divu_i64:
+        case INDEX_op_divu:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (uint64_t)regs[r1] / (uint64_t)regs[r2];
             break;
@@ -1072,6 +1072,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_and:
     case INDEX_op_andc:
     case INDEX_op_divs:
+    case INDEX_op_divu:
     case INDEX_op_eqv:
     case INDEX_op_mul:
     case INDEX_op_nand:
@@ -1082,8 +1083,6 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_xor:
     case INDEX_op_rem_i32:
     case INDEX_op_rem_i64:
-    case INDEX_op_divu_i32:
-    case INDEX_op_divu_i64:
     case INDEX_op_remu_i32:
     case INDEX_op_remu_i64:
     case INDEX_op_shl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index a833b3b7b2..41985be012 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -282,7 +282,7 @@ Arithmetic
      - | *t0* = *t1* / *t2* (signed)
        | Undefined behavior if division by zero or overflow.
 
-   * - divu_i32/i64 *t0*, *t1*, *t2*
+   * - divu *t0*, *t1*, *t2*
 
      - | *t0* = *t1* / *t2* (unsigned)
        | Undefined behavior if division by zero.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 18a10156a6..dfa8aecc7a 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -663,7 +663,7 @@ static void tgen_divu(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_divu32
-                     : INDEX_op_divu_i64);
+                     : INDEX_op_divu);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


