Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4EEA8A86A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 21:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m6S-0000VU-Se; Tue, 15 Apr 2025 15:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lzN-0000O1-Ld
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:34 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4lyB-0000v4-HW
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:30:32 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-af5085f7861so3835807a12.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745357; x=1745350157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CFiROwBqZBHU/qhRBn2JCLpO4xL269OJILxpmeWAZxw=;
 b=HItomEUg7P7FwlvJ35Rmg5+5XOMnmoM5JA9YKjbMEQ5Ac+xo20agZf8tF7MAt9hzvy
 mh+rS/WmlalSxgQHzltt/C0PPtEpgJ7vE8WDLkg5W2Q6EsHm9/4KIp9y6V5cW5jbIDwR
 /nGUL0t3VFwGpPBv8bFg0xzlCdBWmqHcgznUhGKQVwsYW5kgh2rAIRUb8hvGyB707xTM
 4QE+dNMUU37YBlij+uv1RWzbzuwZtd9L1mugZq6DMDJ3D1T5Sl9ZwiaHPwytNQhCwE6J
 CPPrSqAXXo8RWbzl7GYyAx/Duau/sg0FhawEv5uAQjpYkX5uraX5novs2SHdHOpW/Pps
 12Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745357; x=1745350157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CFiROwBqZBHU/qhRBn2JCLpO4xL269OJILxpmeWAZxw=;
 b=ciYWIJXJUON6xff7lxvlnsuXsH5mmbYaogIxFouPN1lEQcfBHHwsrQeNdkQeRB9HVW
 oYshlI3xMm4E3ikCXAGAvqor4WX6c6ZoTz9Anu+kGn2m0+IHsgE8bndymb2qTMIt+WHm
 AmMT6Vf6tdU2+MrDkcywrzUfuBm4bJQ1j10vOyaJcOw0a4ZYT3HhgyY62oVsmvlPediq
 SzAFLVeaufVYd9Vu4nYBRMn/b2SuuzqLb1CErLMb0JsWtS0+eatvZ8iLCamNdRQAxTut
 DGyLISshbPe416CKh0C5Jg1ynHjjqv8Z1pP5Rdqf9f0tsIbvBZhB4DiyRSclGXu+vVG/
 2mPQ==
X-Gm-Message-State: AOJu0Yz3jaVheDJvudyozSOeA994PXaJliegwaCJSoszwAVopasIjGck
 S/J9QWMmcXIEISnjm/IzqIL5SqoNBkFuWR02gur8MgiJQ4nnXNVHBs442Esg4oBWCQWOCrXFFnx
 8
X-Gm-Gg: ASbGnctkKkoTYa3iqAyoh4Qz77FWlr6QvOGRQT2PQ/DgtmLaEGhdUEot5esMxCIAsqW
 Lqws9NPtrUOZpfSTk+HTZTUSWS2FZhyk8MARoliIDFsURmjQECMOktW8LvvR7XDBxcROWnd9gYe
 Igm3yvMxGYaGc/NVwwjlC+UrNH/ud+QeAyw1pjp8yu6rOCxTdTikmY+AHTkN3/utniJhjxsKX59
 vYxV3T5GjSFRwYuALpjygPas9LV45dsefX/vz3pqqcFA/13pgGDSH0IvtluLVUzU89YtNxMckAc
 UdB1eXHjJEagOj6NmU5sU95WHAKCM3mer7ZqBDlpusd0PwCOchVl6WUTKsgFAIaAJHPjoDkUXJQ
 =
X-Google-Smtp-Source: AGHT+IEeeeFyy5IHuZZdqJIsOAQZEcis1fTWypu4CVBxrC3jP0NxzqOGgxvx7nto0EvojBTon8BAhQ==
X-Received: by 2002:a17:90a:d2d0:b0:301:1d9f:4ba2 with SMTP id
 98e67ed59e1d1-3085ef53fecmr558308a91.28.1744745357259; 
 Tue, 15 Apr 2025 12:29:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df06a165sm13534812a91.4.2025.04.15.12.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:29:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 071/163] tcg: Merge INDEX_op_mulu2_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:42 -0700
Message-ID: <20250415192515.232910-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  3 +--
 tcg/optimize.c           | 17 +++++++++--------
 tcg/tcg-op.c             | 10 +++++-----
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                |  6 ++----
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  3 +--
 7 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a45b22ca1a..287bdf3473 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -53,6 +53,7 @@ DEF(eqv, 1, 2, 0, TCG_OPF_INT)
 DEF(mul, 1, 2, 0, TCG_OPF_INT)
 DEF(muls2, 2, 2, 0, TCG_OPF_INT)
 DEF(mulsh, 1, 2, 0, TCG_OPF_INT)
+DEF(mulu2, 2, 2, 0, TCG_OPF_INT)
 DEF(muluh, 1, 2, 0, TCG_OPF_INT)
 DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(neg, 1, 1, 0, TCG_OPF_INT)
@@ -92,7 +93,6 @@ DEF(brcond_i32, 0, 2, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 
 DEF(add2_i32, 2, 4, 0, 0)
 DEF(sub2_i32, 2, 4, 0, 0)
-DEF(mulu2_i32, 2, 2, 0, 0)
 DEF(brcond2_i32, 0, 4, 2, TCG_OPF_BB_END | TCG_OPF_COND_BRANCH)
 DEF(setcond2_i32, 1, 4, 1, 0)
 
@@ -133,7 +133,6 @@ DEF(bswap64_i64, 1, 1, 1, 0)
 
 DEF(add2_i64, 2, 4, 0, 0)
 DEF(sub2_i64, 2, 4, 0, 0)
-DEF(mulu2_i64, 2, 2, 0, 0)
 
 #define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
 
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 2b0ae4c12d..a4b9e5dec0 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2057,13 +2057,14 @@ static bool fold_multiply2(OptContext *ctx, TCGOp *op)
         TCGOp *op2;
 
         switch (op->opc) {
-        case INDEX_op_mulu2_i32:
-            l = (uint64_t)(uint32_t)a * (uint32_t)b;
-            h = (int32_t)(l >> 32);
-            l = (int32_t)l;
-            break;
-        case INDEX_op_mulu2_i64:
-            mulu64(&l, &h, a, b);
+        case INDEX_op_mulu2:
+            if (ctx->type == TCG_TYPE_I32) {
+                l = (uint64_t)(uint32_t)a * (uint32_t)b;
+                h = (int32_t)(l >> 32);
+                l = (int32_t)l;
+            } else {
+                mulu64(&l, &h, a, b);
+            }
             break;
         case INDEX_op_muls2:
             if (ctx->type == TCG_TYPE_I32) {
@@ -2963,7 +2964,7 @@ void tcg_optimize(TCGContext *s)
             done = fold_mul_highpart(&ctx, op);
             break;
         case INDEX_op_muls2:
-        CASE_OP_32_64(mulu2):
+        case INDEX_op_mulu2:
             done = fold_multiply2(&ctx, op);
             break;
         case INDEX_op_nand:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a4d976242a..22af3b12bc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1138,8 +1138,8 @@ void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
 
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_mulu2_i32, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I32, 0)) {
+        tcg_gen_op4_i32(INDEX_op_mulu2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I32, 0)) {
         TCGv_i32 t = tcg_temp_ebb_new_i32();
         tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
@@ -2861,8 +2861,8 @@ void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
 
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_mulu2_i64, rl, rh, arg1, arg2);
+    if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0)) {
+        tcg_gen_op4_i64(INDEX_op_mulu2, rl, rh, arg1, arg2);
     } else if (tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t = tcg_temp_ebb_new_i64();
         tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
@@ -2888,7 +2888,7 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
         tcg_gen_mov_i64(rl, t);
         tcg_temp_free_i64(t);
-    } else if (tcg_op_supported(INDEX_op_mulu2_i64, TCG_TYPE_I64, 0) ||
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
                tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 1291865575..356c935894 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1043,8 +1043,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_mul, TCGOutOpBinary, outop_mul),
     OUTOP(INDEX_op_muls2, TCGOutOpMul2, outop_muls2),
     OUTOP(INDEX_op_mulsh, TCGOutOpBinary, outop_mulsh),
-    OUTOP(INDEX_op_mulu2_i32, TCGOutOpMul2, outop_mulu2),
-    OUTOP(INDEX_op_mulu2_i64, TCGOutOpMul2, outop_mulu2),
+    OUTOP(INDEX_op_mulu2, TCGOutOpMul2, outop_mulu2),
     OUTOP(INDEX_op_muluh, TCGOutOpBinary, outop_muluh),
     OUTOP(INDEX_op_nand, TCGOutOpBinary, outop_nand),
     OUTOP(INDEX_op_neg, TCGOutOpUnary, outop_neg),
@@ -4009,8 +4008,7 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_mulsh;
             goto do_mul2;
-        case INDEX_op_mulu2_i32:
-        case INDEX_op_mulu2_i64:
+        case INDEX_op_mulu2:
             opc_new = INDEX_op_mul;
             opc_new2 = INDEX_op_muluh;
         do_mul2:
@@ -5471,8 +5469,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_muls2:
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         {
             const TCGOutOpMul2 *out =
                 container_of(all_outop[op->opc], TCGOutOpMul2, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 5c8c62c0ef..569b5c7ed0 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -590,8 +590,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             muls64(&regs[r0], &regs[r1], regs[r2], regs[r3]);
 #endif
             break;
-        case INDEX_op_mulu2_i32:
-        case INDEX_op_mulu2_i64:
+        case INDEX_op_mulu2:
             tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
 #if TCG_TARGET_REG_BITS == 32
             tmp64 = (uint64_t)(uint32_t)regs[r2] * (uint32_t)regs[r3];
@@ -1092,8 +1091,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_muls2:
-    case INDEX_op_mulu2_i32:
-    case INDEX_op_mulu2_i64:
+    case INDEX_op_mulu2:
         tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
         info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
                            op_name, str_r(r0), str_r(r1),
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 0394767291..592e002971 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -599,7 +599,7 @@ Multiword arithmetic support
          formed from two single-word arguments, and the double-word output *t0*
          is returned in two single-word outputs.
 
-   * - mulu2_i32/i64 *t0_low*, *t0_high*, *t1*, *t2*
+   * - mulu2 *t0_low*, *t0_high*, *t1*, *t2*
 
      - | Similar to mul, except two unsigned inputs *t1* and *t2* yielding the full
          double-word product *t0*. The latter is returned in two single-word outputs.
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 4bce206f80..563529e055 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -728,8 +728,7 @@ static const TCGOutOpBinary outop_mulsh = {
 static void tgen_mulu2(TCGContext *s, TCGType type,
                        TCGReg a0, TCGReg a1, TCGReg a2, TCGReg a3)
 {
-    tcg_out_op_rrrr(s, glue(INDEX_op_mulu2_i,TCG_TARGET_REG_BITS),
-                    a0, a1, a2, a3);
+    tcg_out_op_rrrr(s, INDEX_op_mulu2, a0, a1, a2, a3);
 }
 
 static const TCGOutOpMul2 outop_mulu2 = {
-- 
2.43.0


