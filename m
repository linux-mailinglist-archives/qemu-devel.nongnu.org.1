Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A6DA9D4E8
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Apr 2025 00:01:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R50-0004OH-Q9; Fri, 25 Apr 2025 17:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4I-0001ax-Ro
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4F-0000qe-Ur
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2241053582dso43798985ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618322; x=1746223122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t6k5bBoj5WCfrNDrHROtelPcliS5pdmMHq9LoVwgitg=;
 b=kHbD5aXPqvd70hwGD2MY/125okolqYm+Co2siZxupGwSgFdihEvzi5AgNmJe8yGsnt
 fJTWfV6OGoXxogHXhWOwBcNp3VqKLQuV5/9FwQILYPMoFXDs3K3immbS4QPriYneZlMr
 PS6k4lUPWrfTZtGrBwqQbzNmdq76dPyB7phRRLWdUwS5Tg8BoLzOS0omEstidHwcJ6oa
 gAQLEUYT4j8c44yyKZcQujhFkJD3b0YJesWylnlGf2NPxDVkOsTm+F7QBf3a1bw2dPa3
 VE4ze55vI9T8IgEkKl2MQb6Ozn1v/C8joKwuPOWKDGLIzWpLYgcZKZxqMH2otvsFo2Jf
 Y6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618322; x=1746223122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t6k5bBoj5WCfrNDrHROtelPcliS5pdmMHq9LoVwgitg=;
 b=cxGU1D/Gkhunv/m8HChlu11MLGjFxxqYJ3Jln/RE3QOtXwLBSRM+mbTEgE7t2mfT5r
 DUz4TFPDncyZnx5x6SCa0D1lNMh5BJJSxVaIF5X+fZleO3owozGudNMg4Cmdrx7hZmna
 IK8Cui47eX9vfNXZ5Hr/YFr7kw7HgkpDWd+X6foxo+lI1yrSbs5jW0Bw1fhuq4M9MfC4
 3zWpks8QdTnPPWSeDbwjWBUWQETX58FjswES1+KrvG5GzsZtPU+CFf7IRJM/mZbTnako
 NSLBUnIMDF2sjsT/dHQm+Drl03SFcOOxi4g2pXYQbSN23OdO5wEOPAq8YPpVI8QZU6aZ
 sJcA==
X-Gm-Message-State: AOJu0YyfB3/yIoz4BvQIKDAJcqmJVoAR+cL3TiPTPB6A6m45JK7hbdz8
 Tf4fGGRfGu/GZH5nRWUw6HxAgr4lczB5/QhD9LQn61pMbTQm/EWsxQbFXCvqCAY6yMjSY0w+puU
 R
X-Gm-Gg: ASbGncuMgwd4jlcwXnOErSgIsrQ8dIiUnZNboIKVhUtOnSqstgwiXB2kn9GHXlmONnj
 LxFvcFQMbHduuI/4jIGCigpmo0x44vrO7XLvfWwQb1tNCui0CI5kiwiLcD+IKQOF6EbgB7hMOPS
 y8Li25ozJxMU9ICe8t0WU1wiMN3ekG0TmeSmeTbyHjDvd/ErcHTshmsQyeV/A5i3V/ReLvkF4TF
 ymDmk3JH0I5v7qBXQ+SzBgmXeqoDS9w5ixdfL2PTsuQQGMxZ6d/FmCEH8ILcjOj0Xwo0Q949b0J
 KGLZsvcO61KgoyaZH9mkAGTJKsH/PZPxtcN6iURHLaspb9ITVD+6oa5FxJ9BDuvKfr7k6zlMHMU
 =
X-Google-Smtp-Source: AGHT+IHQcpMTaeIztc3sz+DzJJRsGnDxspUC95F//0Us/UqgNXnts3X1zyLCypBZZpO7Y+q+yJGL8A==
X-Received: by 2002:a17:902:c40c:b0:224:1acc:14db with SMTP id
 d9443c01a7336-22dc6a121dbmr15772745ad.29.1745618322263; 
 Fri, 25 Apr 2025 14:58:42 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 060/159] tcg: Merge INDEX_op_shr_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:14 -0700
Message-ID: <20250425215454.886111-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 tcg/optimize.c           | 17 +++++++----------
 tcg/tcg-op.c             |  4 ++--
 tcg/tcg.c                |  6 ++----
 tcg/tci.c                | 11 +++--------
 docs/devel/tcg-ops.rst   |  4 ++--
 tcg/tci/tcg-target.c.inc |  2 +-
 7 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index c2ac25d1b6..35e0be8f80 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -59,6 +59,7 @@ DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
+DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
 DEF(xor, 1, 2, 0, TCG_OPF_INT)
 
@@ -75,7 +76,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shr_i32, 1, 2, 0, 0)
 DEF(sar_i32, 1, 2, 0, 0)
 DEF(rotl_i32, 1, 2, 0, 0)
 DEF(rotr_i32, 1, 2, 0, 0)
@@ -115,7 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(shr_i64, 1, 2, 0, 0)
 DEF(sar_i64, 1, 2, 0, 0)
 DEF(rotl_i64, 1, 2, 0, 0)
 DEF(rotr_i64, 1, 2, 0, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3142daa800..43db079693 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -452,10 +452,10 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (uint64_t)x << (y & 63);
 
-    case INDEX_op_shr_i32:
-        return (uint32_t)x >> (y & 31);
-
-    case INDEX_op_shr_i64:
+    case INDEX_op_shr:
+        if (type == TCG_TYPE_I32) {
+            return (uint32_t)x >> (y & 31);
+        }
         return (uint64_t)x >> (y & 63);
 
     case INDEX_op_sar_i32:
@@ -2342,7 +2342,6 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode shr_opc;
     TCGOpcode uext_opc = 0, sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
@@ -2364,7 +2363,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 
     switch (ctx->type) {
     case TCG_TYPE_I32:
-        shr_opc = INDEX_op_shr_i32;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I32, sh, 1)) {
             uext_opc = INDEX_op_extract_i32;
         }
@@ -2373,7 +2371,6 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         }
         break;
     case TCG_TYPE_I64:
-        shr_opc = INDEX_op_shr_i64;
         if (TCG_TARGET_extract_valid(TCG_TYPE_I64, sh, 1)) {
             uext_opc = INDEX_op_extract_i64;
         }
@@ -2402,7 +2399,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op->args[3] = 1;
     } else {
         if (sh) {
-            op2 = opt_insert_before(ctx, op, shr_opc, 3);
+            op2 = opt_insert_before(ctx, op, INDEX_op_shr, 3);
             op2->args[0] = ret;
             op2->args[1] = src1;
             op2->args[2] = arg_new_constant(ctx, sh);
@@ -2609,7 +2606,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
          * input sign repetitions.
          */
         return fold_masks_s(ctx, op, s_mask);
-    CASE_OP_32_64(shr):
+    case INDEX_op_shr:
         /*
          * If the sign bit is known zero, then logical right shift
          * will not reduce the number of input sign repetitions.
@@ -3032,7 +3029,7 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(rotr):
         CASE_OP_32_64(sar):
         case INDEX_op_shl:
-        CASE_OP_32_64(shr):
+        case INDEX_op_shr:
             done = fold_shift(&ctx, op);
             break;
         CASE_OP_32_64(setcond):
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c85c056726..ef8cf5a1ac 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,7 +496,7 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    tcg_gen_op3_i32(INDEX_op_shr_i32, ret, arg1, arg2);
+    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
 }
 
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -1615,7 +1615,7 @@ void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (TCG_TARGET_REG_BITS == 64) {
-        tcg_gen_op3_i64(INDEX_op_shr_i64, ret, arg1, arg2);
+        tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
     } else {
         gen_helper_shr_i64(ret, arg1, arg2);
     }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 134ab9c6c2..939bbe86e9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1043,8 +1043,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
-    OUTOP(INDEX_op_shr_i32, TCGOutOpBinary, outop_shr),
-    OUTOP(INDEX_op_shr_i64, TCGOutOpBinary, outop_shr),
+    OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
     OUTOP(INDEX_op_xor, TCGOutOpBinary, outop_xor),
 };
@@ -5423,8 +5422,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_rems:
     case INDEX_op_remu:
     case INDEX_op_shl:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
+    case INDEX_op_shr:
     case INDEX_op_xor:
         {
             const TCGOutOpBinary *out =
diff --git a/tcg/tci.c b/tcg/tci.c
index 22401ce1f6..376b1b1ece 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -621,9 +621,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = regs[r1] << (regs[r2] % TCG_TARGET_REG_BITS);
             break;
-        case INDEX_op_shr_i32:
+        case INDEX_op_shr:
             tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = (uint32_t)regs[r1] >> (regs[r2] & 31);
+            regs[r0] = regs[r1] >> (regs[r2] % TCG_TARGET_REG_BITS);
             break;
         case INDEX_op_sar_i32:
             tci_args_rrr(insn, &r0, &r1, &r2);
@@ -787,10 +787,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_shr_i64:
-            tci_args_rrr(insn, &r0, &r1, &r2);
-            regs[r0] = regs[r1] >> (regs[r2] & 63);
-            break;
         case INDEX_op_sar_i64:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = (int64_t)regs[r1] >> (regs[r2] & 63);
@@ -1078,10 +1074,9 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_rems:
     case INDEX_op_remu:
     case INDEX_op_shl:
+    case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_shr_i32:
-    case INDEX_op_shr_i64:
     case INDEX_op_sar_i32:
     case INDEX_op_sar_i64:
     case INDEX_op_rotl_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index f64c881530..f9fd4b0087 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -384,10 +384,10 @@ Shifts/Rotates
      - | *t0* = *t1* << *t2*
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - shr_i32/i64 *t0*, *t1*, *t2*
+   * - shr *t0*, *t1*, *t2*
 
      - | *t0* = *t1* >> *t2* (unsigned)
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
    * - sar_i32/i64 *t0*, *t1*, *t2*
 
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 5651833ac9..c0dbe873f1 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -792,7 +792,7 @@ static void tgen_shr(TCGContext *s, TCGType type,
         tcg_out_ext32u(s, TCG_REG_TMP, a1);
         a1 = TCG_REG_TMP;
     }
-    tcg_out_op_rrr(s, glue(INDEX_op_shr_i,TCG_TARGET_REG_BITS), a0, a1, a2);
+    tcg_out_op_rrr(s, INDEX_op_shr, a0, a1, a2);
 }
 
 static const TCGOutOpBinary outop_shr = {
-- 
2.43.0


