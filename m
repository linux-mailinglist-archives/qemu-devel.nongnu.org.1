Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94127705806
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:54:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0f5-0003ww-53; Tue, 16 May 2023 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cU-0000i1-Bh
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:02 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cI-0003mS-3p
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:01 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-24e14a24c9dso58913a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266346; x=1686858346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MS9Et0j5wf1gzEHwKSqAAQ7tPBGo83o+Uozzg1/3C6w=;
 b=qcTOn1hh5/jVMPt2984DyQLjMmkP925dWNmrZZOXllUukAzc935hhBHvQnKAnCQ8Lm
 PwdjRJtAs3ENBwEqAfhaAU7l+gJd559OhkF1jjMR2wjU3i2Iq2JmxPbkQJvd5D/JbPlI
 XXszjQlbI/t6VeMBoURpNdJVlK12dnBVcBtfxcQ9pN7luc6E5ncVbHX3GtOga8fOA1Xf
 lWOUgApctAC3HwrZSTCZbOzPt5mZgO2GxZpcUT48oJuRJDEhidge2xQWYRldYNg1Ckgl
 q5TmuSSiiN+TP6N4aK1cKrGW41hVRTIONW99R85xGFQBGVHWPvL4LjOg3LX5+gMaC1EG
 npLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266346; x=1686858346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MS9Et0j5wf1gzEHwKSqAAQ7tPBGo83o+Uozzg1/3C6w=;
 b=GcnlyBfb+t4RMSOnr1E90z1TBk1r+JDssb0ZvpRaLs+aRhlNSFLfmoh6oQp2bJ1ETu
 JNL59scnZLDBlUiV8VPBM1lkXqkjayLdMj50mO4u322poRaOC5kVoMCngoowwb6IhTvB
 aky1+5ZgHv9ahlQ8p1FH+gNVzQK3siYsq0Yp6fZNoS5xPIPqSrHddFVPcpt3tYUc3Sdk
 eEga1N28Nr8FAhQGdZDS1+ktemdxULkHWS2U0aptW5CgXR1QYBPSNqMZPoDAGymLABLv
 S7bWtfjHHJ5tvaINyLSjvGYc5zMvAFE5nF3vq9befii76+kqZT/4UMSgdYFnDGrqlvzo
 TVLg==
X-Gm-Message-State: AC+VfDzLbl8dVQIR28OSDcCH6/BlKmYNa0uhHnjMkl/nfqcUy3R6TdrH
 XOpK7XhJeolL1Y4JSE0GcCXmMDoPHRtPKsxStlc=
X-Google-Smtp-Source: ACHHUZ7QlZkWVjOpz9jm/d3qOMlw7nmHWYbiNZL/q4PTyNFOAk8fQG5YLpynj0QaMQQPxMBGRR7YNA==
X-Received: by 2002:a17:90b:2289:b0:247:1233:9b28 with SMTP id
 kx9-20020a17090b228900b0024712339b28mr37631768pjb.17.1684266346015; 
 Tue, 16 May 2023 12:45:46 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 67/80] tcg/tci: Elimnate TARGET_LONG_BITS, target_ulong
Date: Tue, 16 May 2023 12:41:32 -0700
Message-Id: <20230516194145.1749305-68-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

We now have the address size as part of the opcode, so
we no longer need to test TARGET_LONG_BITS.  We can use
uint64_t for target_ulong, as passed into load/store helpers.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                | 61 +++++++++++++++++++++++++---------------
 tcg/tci/tcg-target.c.inc | 15 +++++-----
 2 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 742c791726..bab4397bc5 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -286,7 +286,7 @@ static bool tci_compare64(uint64_t u0, uint64_t u1, TCGCond condition)
     return result;
 }
 
-static uint64_t tci_qemu_ld(CPUArchState *env, target_ulong taddr,
+static uint64_t tci_qemu_ld(CPUArchState *env, uint64_t taddr,
                             MemOpIdx oi, const void *tb_ptr)
 {
     MemOp mop = get_memop(oi);
@@ -312,7 +312,7 @@ static uint64_t tci_qemu_ld(CPUArchState *env, target_ulong taddr,
     }
 }
 
-static void tci_qemu_st(CPUArchState *env, target_ulong taddr, uint64_t val,
+static void tci_qemu_st(CPUArchState *env, uint64_t taddr, uint64_t val,
                         MemOpIdx oi, const void *tb_ptr)
 {
     MemOp mop = get_memop(oi);
@@ -372,10 +372,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
         TCGReg r0, r1, r2, r3, r4, r5;
         tcg_target_ulong t1;
         TCGCond condition;
-        target_ulong taddr;
         uint8_t pos, len;
         uint32_t tmp32;
-        uint64_t tmp64;
+        uint64_t tmp64, taddr;
         uint64_t T1, T2;
         MemOpIdx oi;
         int32_t ofs;
@@ -923,31 +922,40 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
 
         case INDEX_op_qemu_ld_a32_i32:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = (uint32_t)regs[r1];
+            goto do_ld_i32;
         case INDEX_op_qemu_ld_a64_i32:
-            if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+            if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
             } else {
                 tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
                 taddr = tci_uint64(regs[r2], regs[r1]);
             }
-            tmp32 = tci_qemu_ld(env, taddr, oi, tb_ptr);
-            regs[r0] = tmp32;
+        do_ld_i32:
+            regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
             break;
 
         case INDEX_op_qemu_ld_a32_i64:
+            if (TCG_TARGET_REG_BITS == 64) {
+                tci_args_rrm(insn, &r0, &r1, &oi);
+                taddr = (uint32_t)regs[r1];
+            } else {
+                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                taddr = (uint32_t)regs[r2];
+            }
+            goto do_ld_i64;
         case INDEX_op_qemu_ld_a64_i64:
             if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
-            } else if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
-                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
-                taddr = regs[r2];
             } else {
                 tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
                 taddr = tci_uint64(regs[r3], regs[r2]);
                 oi = regs[r4];
             }
+        do_ld_i64:
             tmp64 = tci_qemu_ld(env, taddr, oi, tb_ptr);
             if (TCG_TARGET_REG_BITS == 32) {
                 tci_write_reg64(regs, r1, r0, tmp64);
@@ -957,35 +965,44 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             break;
 
         case INDEX_op_qemu_st_a32_i32:
+            tci_args_rrm(insn, &r0, &r1, &oi);
+            taddr = (uint32_t)regs[r1];
+            goto do_st_i32;
         case INDEX_op_qemu_st_a64_i32:
-            if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+            if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
             } else {
                 tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
                 taddr = tci_uint64(regs[r2], regs[r1]);
             }
-            tmp32 = regs[r0];
-            tci_qemu_st(env, taddr, tmp32, oi, tb_ptr);
+        do_st_i32:
+            tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
             break;
 
         case INDEX_op_qemu_st_a32_i64:
+            if (TCG_TARGET_REG_BITS == 64) {
+                tci_args_rrm(insn, &r0, &r1, &oi);
+                tmp64 = regs[r0];
+                taddr = (uint32_t)regs[r1];
+            } else {
+                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                tmp64 = tci_uint64(regs[r1], regs[r0]);
+                taddr = (uint32_t)regs[r2];
+            }
+            goto do_st_i64;
         case INDEX_op_qemu_st_a64_i64:
             if (TCG_TARGET_REG_BITS == 64) {
                 tci_args_rrm(insn, &r0, &r1, &oi);
-                taddr = regs[r1];
                 tmp64 = regs[r0];
+                taddr = regs[r1];
             } else {
-                if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
-                    tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
-                    taddr = regs[r2];
-                } else {
-                    tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
-                    taddr = tci_uint64(regs[r3], regs[r2]);
-                    oi = regs[r4];
-                }
+                tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
                 tmp64 = tci_uint64(regs[r1], regs[r0]);
+                taddr = tci_uint64(regs[r3], regs[r2]);
+                oi = regs[r4];
             }
+        do_st_i64:
             tci_qemu_st(env, taddr, tmp64, oi, tb_ptr);
             break;
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 586b2e6a08..c9516a5e8b 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -243,7 +243,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     return false;
 }
 
-static void stack_bounds_check(TCGReg base, target_long offset)
+static void stack_bounds_check(TCGReg base, intptr_t offset)
 {
     if (base == TCG_REG_CALL_STACK) {
         tcg_debug_assert(offset >= 0);
@@ -850,24 +850,23 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         break;
 
     case INDEX_op_qemu_ld_a32_i32:
-    case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_st_a32_i32:
+        tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
+        break;
+    case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_st_a64_i32:
-        if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
+    case INDEX_op_qemu_ld_a32_i64:
+    case INDEX_op_qemu_st_a32_i64:
+        if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
         } else {
             tcg_out_op_rrrm(s, opc, args[0], args[1], args[2], args[3]);
         }
         break;
-
-    case INDEX_op_qemu_ld_a32_i64:
     case INDEX_op_qemu_ld_a64_i64:
-    case INDEX_op_qemu_st_a32_i64:
     case INDEX_op_qemu_st_a64_i64:
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
-        } else if (TARGET_LONG_BITS <= TCG_TARGET_REG_BITS) {
-            tcg_out_op_rrrm(s, opc, args[0], args[1], args[2], args[3]);
         } else {
             tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[4]);
             tcg_out_op_rrrrr(s, opc, args[0], args[1],
-- 
2.34.1


