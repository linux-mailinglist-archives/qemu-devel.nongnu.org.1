Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C746CA8A8B1
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 22:00:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4m4Z-0006hJ-9A; Tue, 15 Apr 2025 15:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1V-0003Ls-Kx
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:32:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m1P-0002pV-ES
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:32:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-227b650504fso59382715ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745558; x=1745350358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qt/bud/KeNJc+y0HGq/uz9Dtr1mfpzAXie+HLrHeqSs=;
 b=homOv7JR5gAd68h1qv2UCO52qOadd+XoRU/2i0zULqw+O/NE/y22NbQDGJ/lk29/MA
 2p8LVbrepwJ9aNd34q95lVxFg/tqN+thMlQHYTAR/xECEqwDVVL3J1Ayf2rrKdFsmdpR
 r/i62rNHjF+uUTdFcRN/pBr0aPp7nalildkI1vZOhfWcvW3v98rlG0piFMk5JlUI5Ylq
 ZGwmOhAqOEBbFbDUdgSHzsbvsbS9jILtKLgginwVZdgmgYcOri2EUXz+PbFO8P5L1T/4
 IFPTXTabLbnz9bFtUyF484au0mGdGITJMDks2gdEmRfpm1LOxJBT/9BOa5UYTAMmVIiT
 8U9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745558; x=1745350358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qt/bud/KeNJc+y0HGq/uz9Dtr1mfpzAXie+HLrHeqSs=;
 b=W6dbBu7RSMHjp9XsfMJ6D++2026Ke33vQYOM2824pT3ldIEN2vkiTcZ0hAYpSsS4Au
 pHt0gmWil64wGMPG1mWLZoWIpXO5REsxe7ot16rWFH0t8Vc0HFbTCDZCJp+BfzG8Y435
 yqfbQz/HwR8IeDZlLV6EyVtWQ8NADEFR+BMJs97k9i5gW/UlRAb3VyjPvoNtw3nbgi/g
 wVFYlwSsUsDGxSpJYYafndn2ObMoyh0f/GwJJvp16EN3TxSY0NAAjUS+R3yXla6s+3+f
 iXeNoebInP0/haZW+qwNCI4gpPjnV4qrlszyp/pkTQ+80nMgsPTQY/x6GVc2y8DzrWH6
 gNIw==
X-Gm-Message-State: AOJu0YyA2XEy06NulhywHYl2PMcZWCX4cnoWrJgTQ2idTfuOlpzkGEGG
 ebTNNFFVpXe8YdJC8zEv7whJBfvzhm5lEE75IpdIYz0pfyZI2CKuSdvEDa6qQg6bdcnlr2fXTnE
 9
X-Gm-Gg: ASbGncuoDchqHckKrKix0ghDBVr4jPVKR7v/JGZrnA61jOlqFAAysUGoIxfqT0YXzih
 fSmX8jpXDSp5wt21nEGJ0gaFGQx1byf70PLXbreUZHVdK5oIREtPCRTcDjl5d2tJd5IjOJ32qFB
 Kdi83R4En9NjynMrz/eQXpif9RnHnDbCBFylChsGXbDGXKfNGktOmm+wCrUgqZ17Z54/YgdMNZL
 C4PLD+2m7wX0HnVivQ+mfRedphBT0zbD57MvRTDWEk8zP7iY+X8eIkyHjhRRtmw+kZ1uqaia5xv
 1BDchL7MjXG2K34BlGBMmvx9NLBYh6wVMABdw597F7JY99rXqJUJPihj0NqGmn9ZRFG6ua8zh1R
 ELLQaOE5OEg==
X-Google-Smtp-Source: AGHT+IGTyKBiZ9/9rRI2SFTfTcO1QVUjwPN+yTzhIE357Wztuw4/cF4fw/1mgF01kNgZGX7q+efONQ==
X-Received: by 2002:a17:903:2b08:b0:21f:ba77:c45e with SMTP id
 d9443c01a7336-22c31adc228mr4646375ad.45.1744745557812; 
 Tue, 15 Apr 2025 12:32:37 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 096/163] tcg: Merge INDEX_op_sextract_{i32,i64}
Date: Tue, 15 Apr 2025 12:24:07 -0700
Message-ID: <20250415192515.232910-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 tcg/optimize.c           | 22 +++-------------------
 tcg/tcg-op.c             | 12 ++++++------
 tcg/tcg.c                |  9 +++------
 tcg/tci.c                | 12 ++++--------
 docs/devel/tcg-ops.rst   |  2 +-
 tcg/tci/tcg-target.c.inc |  5 +----
 7 files changed, 19 insertions(+), 46 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index a8c304ca63..4ace1f85c4 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -74,6 +74,7 @@ DEF(rotl, 1, 2, 0, TCG_OPF_INT)
 DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(setcond, 1, 2, 1, TCG_OPF_INT)
+DEF(sextract, 1, 1, 2, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
 DEF(sub, 1, 2, 0, TCG_OPF_INT)
@@ -90,7 +91,6 @@ DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i32, 1, 2, 2, 0)
-DEF(sextract_i32, 1, 1, 2, 0)
 DEF(extract2_i32, 1, 2, 1, 0)
 
 DEF(add2_i32, 2, 4, 0, 0)
@@ -112,7 +112,6 @@ DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
 DEF(deposit_i64, 1, 2, 2, 0)
-DEF(sextract_i64, 1, 1, 2, 0)
 DEF(extract2_i64, 1, 2, 1, 0)
 
 /* size changing ops */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 6a9effab6b..d19bc19209 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2305,7 +2305,6 @@ static int fold_setcond_zmask(OptContext *ctx, TCGOp *op, bool neg)
 
 static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
 {
-    TCGOpcode sext_opc = 0;
     TCGCond cond = op->args[3];
     TCGArg ret, src1, src2;
     TCGOp *op2;
@@ -2324,27 +2323,12 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
     }
     sh = ctz64(val);
 
-    switch (ctx->type) {
-    case TCG_TYPE_I32:
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i32;
-        }
-        break;
-    case TCG_TYPE_I64:
-        if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, sh, 1)) {
-            sext_opc = INDEX_op_sextract_i64;
-        }
-        break;
-    default:
-        g_assert_not_reached();
-    }
-
     ret = op->args[0];
     src1 = op->args[1];
     inv = cond == TCG_COND_TSTEQ;
 
-    if (sh && sext_opc && neg && !inv) {
-        op->opc = sext_opc;
+    if (sh && neg && !inv && TCG_TARGET_sextract_valid(ctx->type, sh, 1)) {
+        op->opc = INDEX_op_sextract;
         op->args[1] = src1;
         op->args[2] = sh;
         op->args[3] = 1;
@@ -3007,7 +2991,7 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_bitsel_vec:
             done = fold_bitsel_vec(&ctx, op);
             break;
-        CASE_OP_32_64(sextract):
+        case INDEX_op_sextract:
             done = fold_sextract(&ctx, op);
             break;
         case INDEX_op_sub:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ddade73b7b..d3f3c9d248 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1043,19 +1043,19 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, ofs, len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, ofs, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i32(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I32, 0, len)) {
         tcg_gen_shri_i32(ret, arg, ofs);
-        tcg_gen_op4ii_i32(INDEX_op_sextract_i32, ret, ret, 0, len);
+        tcg_gen_op4ii_i32(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
@@ -2747,19 +2747,19 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     }
 
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, ofs, len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, ofs, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, ofs, len);
         return;
     }
 
     /* Assume that sign-extension, if available, is cheaper than a shift.  */
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, arg, 0, ofs + len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, arg, 0, ofs + len);
         tcg_gen_sari_i64(ret, ret, ofs);
         return;
     }
     if (TCG_TARGET_sextract_valid(TCG_TYPE_I64, 0, len)) {
         tcg_gen_shri_i64(ret, arg, ofs);
-        tcg_gen_op4ii_i64(INDEX_op_sextract_i64, ret, ret, 0, len);
+        tcg_gen_op4ii_i64(INDEX_op_sextract, ret, ret, 0, len);
         return;
     }
 
diff --git a/tcg/tcg.c b/tcg/tcg.c
index b86e3daed0..e688cd12b7 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1111,8 +1111,7 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_setcond, TCGOutOpSetcond, outop_setcond),
-    OUTOP(INDEX_op_sextract_i32, TCGOutOpExtract, outop_sextract),
-    OUTOP(INDEX_op_sextract_i64, TCGOutOpExtract, outop_sextract),
+    OUTOP(INDEX_op_sextract, TCGOutOpExtract, outop_sextract),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
     OUTOP(INDEX_op_sub, TCGOutOpSubtract, outop_sub),
@@ -2333,6 +2332,7 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_negsetcond:
     case INDEX_op_or:
     case INDEX_op_setcond:
+    case INDEX_op_sextract:
     case INDEX_op_xor:
         return has_type;
 
@@ -2344,7 +2344,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st8_i32:
     case INDEX_op_st16_i32:
     case INDEX_op_st_i32:
-    case INDEX_op_sextract_i32:
     case INDEX_op_deposit_i32:
         return true;
 
@@ -2372,7 +2371,6 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_ext_i32_i64:
     case INDEX_op_extu_i32_i64:
-    case INDEX_op_sextract_i64:
     case INDEX_op_deposit_i64:
         return TCG_TARGET_REG_BITS == 64;
 
@@ -5517,8 +5515,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         break;
 
     case INDEX_op_extract:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
         {
             const TCGOutOpExtract *out =
                 container_of(all_outop[op->opc], TCGOutOpExtract, base);
diff --git a/tcg/tci.c b/tcg/tci.c
index 6345029802..5a07d65db8 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -28,6 +28,7 @@
 
 #define ctpop_tr    glue(ctpop, TCG_TARGET_REG_BITS)
 #define extract_tr  glue(extract, TCG_TARGET_REG_BITS)
+#define sextract_tr glue(sextract, TCG_TARGET_REG_BITS)
 
 /*
  * Enable TCI assertions only when debugging TCG (and without NDEBUG defined).
@@ -661,9 +662,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = extract_tr(regs[r1], pos, len);
             break;
-        case INDEX_op_sextract_i32:
+        case INDEX_op_sextract:
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract32(regs[r1], pos, len);
+            regs[r0] = sextract_tr(regs[r1], pos, len);
             break;
         case INDEX_op_brcond:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
@@ -773,10 +774,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrrbb(insn, &r0, &r1, &r2, &pos, &len);
             regs[r0] = deposit64(regs[r1], pos, len, regs[r2]);
             break;
-        case INDEX_op_sextract_i64:
-            tci_args_rrbb(insn, &r0, &r1, &pos, &len);
-            regs[r0] = sextract64(regs[r1], pos, len);
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
@@ -1055,8 +1052,7 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
         break;
 
     case INDEX_op_extract:
-    case INDEX_op_sextract_i32:
-    case INDEX_op_sextract_i64:
+    case INDEX_op_sextract:
         tci_args_rrbb(insn, &r0, &r1, &pos, &len);
         info->fprintf_func(info->stream, "%-12s  %s,%s,%d,%d",
                            op_name, str_r(r0), str_r(r1), pos, len);
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 2843f88772..ca7550f68c 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -458,7 +458,7 @@ Misc
 
    * - extract *dest*, *t1*, *pos*, *len*
 
-       sextract_i32/i64 *dest*, *t1*, *pos*, *len*
+       sextract *dest*, *t1*, *pos*, *len*
 
      - | Extract a bitfield from *t1*, placing the result in *dest*.
        |
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index e013321ac7..9ba108ef8d 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -445,10 +445,7 @@ static const TCGOutOpExtract outop_extract = {
 static void tcg_out_sextract(TCGContext *s, TCGType type, TCGReg rd,
                              TCGReg rs, unsigned pos, unsigned len)
 {
-    TCGOpcode opc = type == TCG_TYPE_I32 ?
-                    INDEX_op_sextract_i32 :
-                    INDEX_op_sextract_i64;
-    tcg_out_op_rrbb(s, opc, rd, rs, pos, len);
+    tcg_out_op_rrbb(s, INDEX_op_sextract, rd, rs, pos, len);
 }
 
 static const TCGOutOpExtract outop_sextract = {
-- 
2.43.0


