Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 152DEA8A7E8
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 21:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4lwd-0002DW-M3; Tue, 15 Apr 2025 15:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luq-00008W-AA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4luj-00083m-Fv
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:25:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so4277119b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745143; x=1745349943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NlLYvmIN2ii2Ow2p+8S26dwvkZG+AAYujXRMWhZtQKY=;
 b=WS6q4HabwBHzVpJJiav2KPnOmfFn+eBOYptoBilS73Zg/d0iR/pOV3J/CPB98F084l
 LtKSPJ5CeMORU3Z+cqWE5GqVUfooQV2RzbipTucLFQxiI1lCad8vXNIb/Vyx/3fE396B
 PFTMIRLYEB/lyc4zKTfoGtziCOlURZUW5nYNSk5ZH5ym9GNwdUcQPrLKnb5rHLhotD9z
 iSNUqN3FVmbGs1aJNJOLX+kVeT+tHfdp2x1Lbf1OOJFevuRT6msjCAkAHdjvIIwujgqp
 zJgnwpplo47EZ3vO8NFwX7gd1n7O8MAjfjZanYHg9ff8rxKDVZV3HB7dj0k/VVPa9biX
 cjJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745143; x=1745349943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NlLYvmIN2ii2Ow2p+8S26dwvkZG+AAYujXRMWhZtQKY=;
 b=ZDwnPcMfxqGLOKWlYfIeGKpxy8gmaAb/ApW7Rw4PK7htAQBwAGDn7osAe8iQJZO1od
 Ffxxb0u73emWWaH816OeCB6OpYOkjPVRWTN97D00rgMdq5F1CrQ/aK/edJN9bolSGsJS
 7Wt2Wzf8NOWrMMRUjfaB5NxRGYLKxhZRZLnRDkI006mTULYmaMaEkile5cPaEq1E8tiU
 I8v1gFBfZ+bnSvyNkUqE8XxQ0mRFcbb97d9XANlEH0psEQRddt8viRexHx6aQFUdC04G
 lHkRAey5UtDStJuT7n4x8PwyBNXLLrXYZ6zp6+O6bcLN12MRhiu3w5le618CNYNNbdAU
 2gHQ==
X-Gm-Message-State: AOJu0Ywmxgw0t23sbU+7H6FxiiMVJ8A/yKO4Wd3PaiWYZp/EbduP1fim
 LwY5AMcfW/NMv3etOhertjXaJm86qvapD+PZWGgWWqtEuuopRS4/UHFve/BMJbb+fox+jDnzgVX
 B
X-Gm-Gg: ASbGncsLLf50u8eAlmPAlew1aDLj+DHfZMsRSyoVg2AYsQWuhvRY8jKWIHFw4tUacNo
 yDQfI9/UZpoRs/pOe43SnOjqx7tEvVJ6tEJSddZZMAgrz31cCOOB6f7eQiPJV5ZrqQ9cyFGVuEj
 F820ICC/72NHl3gYRc2DDwpwFognB++gp4gN/m9tK48urvjfEWJTvoPEgTLU+1HBwz+GdLt99ol
 TNXaVuaTrduJuUU8oV0+BjKxppkqJj56y7C/NC8w/DnX3uvmdmF02F+4vbsFBfq6rDVD8Masslt
 4wRPj/JBYPyPBfXy5CJoc7CCcDAOeyfdL7v5gAech6VC+2414ycj6MqOVKnk07Od5oQEtoJ/OC+
 jzITWKgHQGQ==
X-Google-Smtp-Source: AGHT+IFCYYghdusirlulkbJPyq87uY2mirJP49VkRvSGgR+hQPBAl6Ou9vj7eiasq48AFkSYOmnp7A==
X-Received: by 2002:a05:6a00:130a:b0:72f:590f:2859 with SMTP id
 d2e1a72fcca58-73c1fa6ff96mr826274b3a.13.1744745143264; 
 Tue, 15 Apr 2025 12:25:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd22f82ebsm9225124b3a.92.2025.04.15.12.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:25:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 030/163] tcg: Merge INDEX_op_sub_{i32,i64}
Date: Tue, 15 Apr 2025 12:23:01 -0700
Message-ID: <20250415192515.232910-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
 tcg/optimize.c           |  4 ++--
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                | 10 +++-------
 tcg/tci.c                |  5 ++---
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index aa9ed393c9..1be9b01caf 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -47,6 +47,7 @@ DEF(nand, 1, 2, 0, TCG_OPF_INT)
 DEF(nor, 1, 2, 0, TCG_OPF_INT)
 DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
+DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
 DEF(setcond_i32, 1, 2, 1, 0)
@@ -62,7 +63,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i32, 1, 2, 0, 0)
 DEF(mul_i32, 1, 2, 0, 0)
 DEF(div_i32, 1, 2, 0, 0)
 DEF(divu_i32, 1, 2, 0, 0)
@@ -116,7 +116,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* arith */
-DEF(sub_i64, 1, 2, 0, 0)
 DEF(mul_i64, 1, 2, 0, 0)
 DEF(div_i64, 1, 2, 0, 0)
 DEF(divu_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 1fe73f70ed..8927b1256c 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -415,7 +415,7 @@ static uint64_t do_constant_folding_2(TCGOpcode op, uint64_t x, uint64_t y)
     case INDEX_op_add:
         return x + y;
 
-    CASE_OP_32_64(sub):
+    case INDEX_op_sub:
         return x - y;
 
     CASE_OP_32_64(mul):
@@ -3054,7 +3054,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(sextract):
             done = fold_sextract(&ctx, op);
             break;
-        CASE_OP_32_64(sub):
+        case INDEX_op_sub:
             done = fold_sub(&ctx, op);
             break;
         case INDEX_op_sub_vec:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 228aa8f088..15faf4dc57 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -377,7 +377,7 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_sub_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
 }
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -1565,7 +1565,7 @@ void tcg_gen_add_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_sub_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_sub_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_sub, ret, arg1, arg2);
     } else {
         tcg_gen_sub2_i32(TCGV_LOW(ret), TCGV_HIGH(ret), TCGV_LOW(arg1),
                          TCGV_HIGH(arg1), TCGV_LOW(arg2), TCGV_HIGH(arg2));
diff --git a/tcg/tcg.c b/tcg/tcg.c
index fd7d7bdd2d..b97d0946d4 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1020,8 +1020,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_nor, TCGOutOpBinary, outop_nor),
     OUTOP(INDEX_op_or, TCGOutOpBinary, outop_or),
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
-    OUTOP(INDEX_op_sub_i32, TCGOutOpSubtract, outop_sub),
-    OUTOP(INDEX_op_sub_i64, TCGOutOpSubtract, outop_sub),
+    OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
 
@@ -4010,10 +4009,8 @@ liveness_pass_1(TCGContext *s)
             opc_new = INDEX_op_add;
             goto do_addsub2;
         case INDEX_op_sub2_i32:
-            opc_new = INDEX_op_sub_i32;
-            goto do_addsub2;
         case INDEX_op_sub2_i64:
-            opc_new = INDEX_op_sub_i64;
+            opc_new = INDEX_op_sub;
         do_addsub2:
             nb_iargs = 4;
             nb_oargs = 2;
@@ -5454,8 +5451,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
+    case INDEX_op_sub:
         {
             const TCGOutOpSubtract *out = &outop_sub;
 
diff --git a/tcg/tci.c b/tcg/tci.c
index ff129266c2..508d1405cd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -527,7 +527,7 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] + regs[r2];
             break;
-        CASE_32_64(sub)
+        case INDEX_op_sub:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] - regs[r2];
             break;
@@ -1080,9 +1080,8 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_nor:
     case INDEX_op_or:
     case INDEX_op_orc:
+    case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_sub_i32:
-    case INDEX_op_sub_i64:
     case INDEX_op_mul_i32:
     case INDEX_op_mul_i64:
     case INDEX_op_div_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 26d464fa38..96b7f05919 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -265,7 +265,7 @@ Arithmetic
 
      - | *t0* = *t1* + *t2*
 
-   * - sub_i32/i64 *t0*, *t1*, *t2*
+   * - sub *t0*, *t1*, *t2*
 
      - | *t0* = *t1* - *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 353994e83f..67a46c6321 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -712,7 +712,7 @@ static const TCGOutOpBinary outop_orc = {
 static void tgen_sub(TCGContext *s, TCGType type,
                      TCGReg a0, TCGReg a1, TCGReg a2)
 {
-    tcg_out_op_rrr(s, glue(INDEX_op_sub_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_sub, a0, a1, a2);
 }
 
 static const TCGOutOpSubtract outop_sub = {
-- 
2.43.0


