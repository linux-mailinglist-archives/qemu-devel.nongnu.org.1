Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 070E1A9D567
	for <lists+qemu-devel@lfdr.de>; Sat, 26 Apr 2025 00:23:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R81-0005xs-VS; Fri, 25 Apr 2025 18:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7X-0004hT-6l
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:07 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7Q-0001JM-Vw
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:06 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-309fac646adso965125a91.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618519; x=1746223319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkaNBcYOpnokkPM7NGOT7wTlXuzQCUH328esPRYUkkI=;
 b=VR/g/Ge+5T5lEvt6GKrUHhf1Ms0tMLrjV+pH/k5sbxOPXmoIGWp31O//XgcM7aGwih
 +Rd6Xl+w3/zP2Gjpg8/wL9+s3JC8JpByjTzCfXSfK5JAmQMlzv3NB1JsIJletfETmiJn
 owxC+CIJi27F8VfUdJRm7uxyCTP2gyNITJI1wqNe8pU7lXOI+UITscN4qlhX6Bag1i7m
 NRcE87EKr8/jOv+qfd8gNGoSA5wzJXTTvlIPjtTjb3wK3mDURpiLzsCR02uGiHNBPYdl
 BKGcjecVwJ3B08GvaW8JWpxI7Iu/5vkrlMqCXas/10XEPP7h9reMh5CvNhZsnHU8ATBp
 iS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618519; x=1746223319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EkaNBcYOpnokkPM7NGOT7wTlXuzQCUH328esPRYUkkI=;
 b=fr2Qq524rC49L9h1i1zkGqczGgUV3jQ3v6Cq2T6KcbrPDijfSgRdYzPPW4zOPAm3O6
 BvI1JCNHKWsg6a2LwNdKJllD4cReeBUvC9y31rIbB1slWQ1ekK00MRsrzniOpXaD5dCI
 ueU9m9JnUUcXtNUF8MWSbH0MwiE4lMq9JtinrBKKVI3STjm4n1tVhdVg5sULU3JBHfEz
 Qz2BO+iK+BgGviGBPXdCy+xg2Oo9s73+tmxeJdH6dvu1fRGuryahsM124+9aEWatHIlC
 TmLYoFf8eFK+NdS1v+p+KVtdlCCRYG7BmNf62JxTB/SsQuvkgui6ZDmWrth23DIpMgsZ
 DXfw==
X-Gm-Message-State: AOJu0YzQl3qe0z9oC7i6xdOH++8xCR5vVWzGtasmAfh2v+Os3AZ/qsfn
 nuV1sfcQwu0Mn74q4sAT0ncS1t8o14r2Vnu1664xLPesso9RHh/g4fr0f5I7LNTiswrLWUI7stj
 B
X-Gm-Gg: ASbGncvxoegJyMKOUBLaC1mIK69fX9vNupZmzkDA7XKBeTbUHChQkLtiFUoLwPok18/
 WpiRfYwnPC9f40oYmN3IhCLtaumtl1xvJgrIY1de+Vgr8DVFNSqSKDGYLKULubmcRijy5Nph8Pm
 SrIZF1PbIspYEyK32nK4RQcW/cVOTMM3AFAR2vR8XI4W0BEipmtzSsqQK++5i9XlMGeTLWLRMs/
 Ekvh4pWZwbftfXp6IHq41YPJR877oWCGttxZHUMgedbTFh21pnNHXSTCNqeGogcbbQJBNrV+gmf
 J7S0WbktLgLsdMpckWb1ACGCgE19Nb3dwitpk2GjLoFybGUg+sCGiX7QomZrzjEso9umQGtoYbn
 mh1ieuCeNhQ==
X-Google-Smtp-Source: AGHT+IEH+4+ZZs0bEWlDgP/RPZ0mCfF1hv9KrAmH5fMtWHOVODTNjJePrhhqPgzHsszT/qAMY/lncQ==
X-Received: by 2002:a17:90a:da83:b0:2e2:c2b0:d03e with SMTP id
 98e67ed59e1d1-309f8992d11mr5224487a91.5.1745618518718; 
 Fri, 25 Apr 2025 15:01:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:01:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 082/159] tcg: Convert brcond to TCGOutOpBrcond
Date: Fri, 25 Apr 2025 14:53:36 -0700
Message-ID: <20250425215454.886111-83-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 +-
 tcg/mips/tcg-target-con-set.h        |  4 +--
 tcg/riscv/tcg-target-con-set.h       |  2 +-
 tcg/sparc64/tcg-target-con-set.h     |  2 +-
 tcg/tcg.c                            | 26 +++++++++++++++++++
 tcg/tci.c                            |  9 ++-----
 tcg/aarch64/tcg-target.c.inc         | 39 +++++++++++++++-------------
 tcg/arm/tcg-target.c.inc             | 27 ++++++++++++++-----
 tcg/i386/tcg-target.c.inc            | 28 ++++++++++++++------
 tcg/loongarch64/tcg-target.c.inc     | 18 +++++--------
 tcg/mips/tcg-target.c.inc            | 20 +++++++-------
 tcg/ppc/tcg-target.c.inc             | 31 +++++++++++-----------
 tcg/riscv/tcg-target.c.inc           | 18 +++++--------
 tcg/s390x/tcg-target.c.inc           | 31 ++++++++++++----------
 tcg/sparc64/tcg-target.c.inc         | 38 ++++++++++++++++++++-------
 tcg/tci/tcg-target.c.inc             | 20 +++++++-------
 16 files changed, 190 insertions(+), 125 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index c145d4ab66..dfe55c6fe8 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -16,7 +16,7 @@
  */
 C_O0_I1(r)
 C_O0_I2(rz, r)
-C_O0_I2(rz, rz)
+C_O0_I2(r, rz)
 C_O0_I2(w, r)
 C_O0_I3(r, r, r)
 C_O1_I1(r, r)
diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 67dfab2aed..a80630a8b4 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -10,12 +10,10 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
+C_O0_I2(r, rz)
 C_O0_I2(rz, r)
-C_O0_I2(rz, rz)
-C_O0_I3(rz, r, r)
 C_O0_I3(rz, rz, r)
 C_O0_I4(rz, rz, rz, rz)
-C_O0_I4(rz, rz, r, r)
 C_O1_I1(r, r)
 C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index f0d3cb81bd..5ff2c2db60 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -11,7 +11,7 @@
  */
 C_O0_I1(r)
 C_O0_I2(rz, r)
-C_O0_I2(rz, rz)
+C_O0_I2(r, rz)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index ca7bbf0a2f..9f66e52ec6 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -11,7 +11,7 @@
  */
 C_O0_I1(r)
 C_O0_I2(rz, r)
-C_O0_I2(rz, rJ)
+C_O0_I2(r, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rJ)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 49fbf1f561..dbaa574cb5 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -986,6 +986,14 @@ typedef struct TCGOutOpBinary {
                     TCGReg a0, TCGReg a1, tcg_target_long a2);
 } TCGOutOpBinary;
 
+typedef struct TCGOutOpBrcond {
+    TCGOutOp base;
+    void (*out_rr)(TCGContext *s, TCGType type, TCGCond cond,
+                   TCGReg a1, TCGReg a2, TCGLabel *label);
+    void (*out_ri)(TCGContext *s, TCGType type, TCGCond cond,
+                   TCGReg a1, tcg_target_long a2, TCGLabel *label);
+} TCGOutOpBrcond;
+
 typedef struct TCGOutOpDivRem {
     TCGOutOp base;
     void (*out_rr01r)(TCGContext *s, TCGType type,
@@ -1040,6 +1048,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_add, TCGOutOpBinary, outop_add),
     OUTOP(INDEX_op_and, TCGOutOpBinary, outop_and),
     OUTOP(INDEX_op_andc, TCGOutOpBinary, outop_andc),
+    OUTOP(INDEX_op_brcond_i32, TCGOutOpBrcond, outop_brcond),
+    OUTOP(INDEX_op_brcond_i64, TCGOutOpBrcond, outop_brcond),
     OUTOP(INDEX_op_clz, TCGOutOpBinary, outop_clz),
     OUTOP(INDEX_op_ctpop, TCGOutOpUnary, outop_ctpop),
     OUTOP(INDEX_op_ctz, TCGOutOpBinary, outop_ctz),
@@ -5486,6 +5496,22 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         }
         break;
 
+    case INDEX_op_brcond_i32:
+    case INDEX_op_brcond_i64:
+        {
+            const TCGOutOpBrcond *out = &outop_brcond;
+            TCGCond cond = new_args[2];
+            TCGLabel *label = arg_label(new_args[3]);
+
+            tcg_debug_assert(!const_args[0]);
+            if (const_args[1]) {
+                out->out_ri(s, type, cond, new_args[0], new_args[1], label);
+            } else {
+                out->out_rr(s, type, cond, new_args[0], new_args[1], label);
+            }
+        }
+        break;
+
     case INDEX_op_setcond:
     case INDEX_op_negsetcond:
         {
diff --git a/tcg/tci.c b/tcg/tci.c
index d97ca1fade..d431cad6fd 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -665,8 +665,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = sextract32(regs[r1], pos, len);
             break;
         case INDEX_op_brcond_i32:
+        case INDEX_op_brcond_i64:
             tci_args_rl(insn, tb_ptr, &r0, &ptr);
-            if ((uint32_t)regs[r0]) {
+            if (regs[r0]) {
                 tb_ptr = ptr;
             }
             break;
@@ -784,12 +785,6 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             tci_args_rrbb(insn, &r0, &r1, &pos, &len);
             regs[r0] = sextract64(regs[r1], pos, len);
             break;
-        case INDEX_op_brcond_i64:
-            tci_args_rl(insn, tb_ptr, &r0, &ptr);
-            if (regs[r0]) {
-                tb_ptr = ptr;
-            }
-            break;
         case INDEX_op_ext_i32_i64:
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = (int32_t)regs[r1];
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 2524e73ff4..e3d8e9090f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1424,8 +1424,16 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
     }
 }
 
-static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
-                           TCGArg b, bool b_const, TCGLabel *l)
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
+                        TCGReg a, TCGReg b, TCGLabel *l)
+{
+    tgen_cmp(s, type, c, a, b);
+    tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+    tcg_out_insn(s, 3202, B_C, c, 0);
+}
+
+static void tgen_brcondi(TCGContext *s, TCGType ext, TCGCond c,
+                         TCGReg a, tcg_target_long b, TCGLabel *l)
 {
     int tbit = -1;
     bool need_cmp = true;
@@ -1434,14 +1442,14 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     case TCG_COND_EQ:
     case TCG_COND_NE:
         /* cmp xN,0; b.ne L -> cbnz xN,L */
-        if (b_const && b == 0) {
+        if (b == 0) {
             need_cmp = false;
         }
         break;
     case TCG_COND_LT:
     case TCG_COND_GE:
         /* cmp xN,0; b.mi L -> tbnz xN,63,L */
-        if (b_const && b == 0) {
+        if (b == 0) {
             c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
             tbit = ext ? 63 : 31;
             need_cmp = false;
@@ -1450,14 +1458,14 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     case TCG_COND_TSTEQ:
     case TCG_COND_TSTNE:
         /* tst xN,0xffffffff; b.ne L -> cbnz wN,L */
-        if (b_const && b == UINT32_MAX) {
+        if (b == UINT32_MAX) {
             c = tcg_tst_eqne_cond(c);
             ext = TCG_TYPE_I32;
             need_cmp = false;
             break;
         }
         /* tst xN,1<<B; b.ne L -> tbnz xN,B,L */
-        if (b_const && is_power_of_2(b)) {
+        if (is_power_of_2(b)) {
             tbit = ctz64(b);
             need_cmp = false;
         }
@@ -1467,7 +1475,7 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     }
 
     if (need_cmp) {
-        tcg_out_cmp(s, ext, c, a, b, b_const);
+        tgen_cmpi(s, ext, c, a, b);
         tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
         tcg_out_insn(s, 3202, B_C, c, 0);
         return;
@@ -1500,6 +1508,12 @@ static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
     }
 }
 
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rC),
+    .out_rr = tgen_brcond,
+    .out_ri = tgen_brcondi,
+};
+
 static inline void tcg_out_rev(TCGContext *s, int ext, MemOp s_bits,
                                TCGReg rd, TCGReg rn)
 {
@@ -2565,13 +2579,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
-    case INDEX_op_brcond_i32:
-        a1 = (int32_t)a1;
-        /* FALLTHRU */
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, ext, a2, a0, a1, const_args[1], arg_label(args[3]));
-        break;
-
     case INDEX_op_movcond_i32:
         a2 = (int32_t)a2;
         /* FALLTHRU */
@@ -3159,10 +3166,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rC);
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rz, rz);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 0f2a029f6d..4c7537cbeb 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2181,6 +2181,26 @@ static const TCGOutOpUnary outop_not = {
     .out_rr = tgen_not,
 };
 
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg a0, TCGReg a1, TCGLabel *l)
+{
+    cond = tgen_cmp(s, cond, a0, a1);
+    tcg_out_goto_label(s, tcg_cond_to_arm_cond[cond], l);
+}
+
+static void tgen_brcondi(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg a0, tcg_target_long a1, TCGLabel *l)
+{
+    cond = tgen_cmpi(s, cond, a0, a1);
+    tcg_out_goto_label(s, tcg_cond_to_arm_cond[cond], l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rIN),
+    .out_rr = tgen_brcond,
+    .out_ri = tgen_brcondi,
+};
+
 static void finish_setcond(TCGContext *s, TCGCond cond, TCGReg ret, bool neg)
 {
     tcg_out_movi32(s, tcg_cond_to_arm_cond[tcg_invert_cond(cond)], ret, 0);
@@ -2317,11 +2337,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mov_reg(s, COND_AL, args[0], a0);
         break;
 
-    case INDEX_op_brcond_i32:
-        c = tcg_out_cmp(s, args[2], args[0], args[1], const_args[1]);
-        tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[3]));
-        break;
-
     case INDEX_op_brcond2_i32:
         c = tcg_out_cmp2(s, args, const_args);
         tcg_out_goto_label(s, tcg_cond_to_arm_cond[c], arg_label(args[5]));
@@ -2421,8 +2436,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_brcond_i32:
-        return C_O0_I2(r, rIN);
     case INDEX_op_deposit_i32:
         return C_O1_I2(r, 0, rZ);
     case INDEX_op_extract2_i32:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index d3a3f1f7fb..d2eff3b617 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1642,6 +1642,26 @@ static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
     tcg_out_jxx(s, jcc, label, small);
 }
 
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *label)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_brcond(s, rexw, cond, arg1, arg2, false, label, false);
+}
+
+static void tgen_brcondi(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg arg1, tcg_target_long arg2, TCGLabel *label)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_brcond(s, rexw, cond, arg1, arg2, true, label, false);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, reT),
+    .out_rr = tgen_brcond,
+    .out_ri = tgen_brcondi,
+};
+
 #if TCG_TARGET_REG_BITS == 32
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
                             const int *const_args, bool small)
@@ -3124,10 +3144,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    OP_32_64(brcond):
-        tcg_out_brcond(s, rexw, a2, a0, a1, const_args[1],
-                       arg_label(args[3]), 0);
-        break;
     OP_32_64(movcond):
         tcg_out_movcond(s, rexw, args[5], a0, a1, a2, const_a2, args[3]);
         break;
@@ -3936,10 +3952,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(re, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, reT);
-
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 87e8b843f8..53bba07c49 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -767,8 +767,8 @@ static const struct {
     [TCG_COND_GTU] = { OPC_BGTU, false }
 };
 
-static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
-                           TCGReg arg2, TCGLabel *l)
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *l)
 {
     LoongArchInsn op = tcg_brcond_to_loongarch[cond].op;
 
@@ -785,6 +785,11 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out32(s, encode_djsk16_insn(op, arg1, arg2, 0));
 }
 
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rz),
+    .out_rr = tgen_brcond,
+};
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
 {
     TCGReg link = tail ? TCG_REG_ZERO : TCG_REG_RA;
@@ -1771,11 +1776,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_opc_b(s, 0);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
-        break;
-
     case INDEX_op_extrh_i64_i32:
         tcg_out_opc_srai_d(s, a0, a1, 32);
         break;
@@ -2441,10 +2441,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i128:
         return C_O0_I3(r, r, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(rz, rz);
-
     case INDEX_op_extu_i32_i64:
     case INDEX_op_extrl_i64_i32:
     case INDEX_op_extrh_i64_i32:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 51b3ea4bb0..a942905dc4 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -988,8 +988,8 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rrr = tgen_negsetcond,
 };
 
-static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
-                           TCGReg arg2, TCGLabel *l)
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *l)
 {
     static const MIPSInsn b_zero[16] = {
         [TCG_COND_LT] = OPC_BLTZ,
@@ -1034,6 +1034,11 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_nop(s);
 }
 
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rz),
+    .out_rr = tgen_brcond,
+};
+
 static int tcg_out_setcond2_int(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg al, TCGReg ah, TCGReg bl, TCGReg bh)
 {
@@ -2178,8 +2183,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
     case INDEX_op_br:
-        tcg_out_brcond(s, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO,
-                       arg_label(a0));
+        tgen_brcond(s, TCG_TYPE_I32, TCG_COND_EQ,
+                    TCG_REG_ZERO, TCG_REG_ZERO, arg_label(a0));
         break;
 
     case INDEX_op_ld8u_i32:
@@ -2283,10 +2288,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
-        break;
     case INDEX_op_brcond2_i32:
         tcg_out_brcond2(s, args[4], a0, a1, a2, args[3], arg_label(args[5]));
         break;
@@ -2391,9 +2392,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, 0, rz);
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(rz, rz);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return (use_mips32r6_instructions
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0a66351124..819abdc906 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2124,14 +2124,26 @@ static void tcg_out_bc_lab(TCGContext *s, TCGCond cond, TCGLabel *l)
     tcg_out_bc(s, cond, bd);
 }
 
-static void tcg_out_brcond(TCGContext *s, TCGCond cond,
-                           TCGArg arg1, TCGArg arg2, int const_arg2,
-                           TCGLabel *l, TCGType type)
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *l)
 {
-    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
+    tcg_out_cmp(s, cond, arg1, arg2, false, 0, type);
     tcg_out_bc_lab(s, cond, l);
 }
 
+static void tgen_brcondi(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg arg1, tcg_target_long arg2, TCGLabel *l)
+{
+    tcg_out_cmp(s, cond, arg1, arg2, true, 0, type);
+    tcg_out_bc_lab(s, cond, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rC),
+    .out_rr = tgen_brcond,
+    .out_ri = tgen_brcondi,
+};
+
 static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGArg dest, TCGArg c1, TCGArg c2, TCGArg v1,
                             TCGArg v2, bool const_c2)
@@ -3457,14 +3469,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_mem_long(s, STD, STDX, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_brcond_i32:
-        tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
-                       arg_label(args[3]), TCG_TYPE_I32);
-        break;
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, args[2], args[0], args[1], const_args[1],
-                       arg_label(args[3]), TCG_TYPE_I64);
-        break;
     case INDEX_op_brcond2_i32:
         tcg_out_brcond2(s, args, const_args);
         break;
@@ -4293,9 +4297,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rC);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rC, rZ, rZ);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 05114b5c5f..1d7194e883 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1184,8 +1184,8 @@ static const struct {
     [TCG_COND_GTU] = { OPC_BLTU, true  }
 };
 
-static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
-                           TCGReg arg2, TCGLabel *l)
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *l)
 {
     RISCVInsn op = tcg_brcond_to_riscv[cond].op;
 
@@ -1201,6 +1201,11 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_opc_branch(s, op, arg1, arg2, 0);
 }
 
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rz),
+    .out_rr = tgen_brcond,
+};
+
 #define SETCOND_INV    TCG_TARGET_NB_REGS
 #define SETCOND_NEZ    (SETCOND_INV << 1)
 #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
@@ -2516,11 +2521,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                         const_args[4], const_args[5], true, false);
         break;
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond(s, a2, a0, a1, arg_label(args[3]));
-        break;
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         tcg_out_movcond(s, args[5], a0, a1, a2, c2,
@@ -2863,10 +2863,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(rz, rz);
-
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, r, rI, rM, rM);
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 3c04b87109..d3650636aa 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1693,6 +1693,24 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
     tgen_branch(s, cc, l);
 }
 
+static void tgen_brcondr(TCGContext *s, TCGType type, TCGCond c,
+                         TCGReg a0, TCGReg a1, TCGLabel *l)
+{
+    tgen_brcond(s, type, c, a0, a1, false, l);
+}
+
+static void tgen_brcondi(TCGContext *s, TCGType type, TCGCond c,
+                         TCGReg a0, tcg_target_long a1, TCGLabel *l)
+{
+    tgen_brcond(s, type, c, a0, a1, true, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rC),
+    .out_rr = tgen_brcondr,
+    .out_ri = tgen_brcondi,
+};
+
 static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *dest)
 {
     ptrdiff_t off = tcg_pcrel_diff(s, dest) >> 1;
@@ -2857,10 +2875,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tgen_branch(s, S390_CC_ALWAYS, arg_label(args[0]));
         break;
 
-    case INDEX_op_brcond_i32:
-        tgen_brcond(s, TCG_TYPE_I32, args[2], args[0],
-                    args[1], const_args[1], arg_label(args[3]));
-        break;
     case INDEX_op_movcond_i32:
         tgen_movcond(s, TCG_TYPE_I32, args[5], args[0], args[1],
                      args[2], const_args[2], args[3], const_args[3], args[4]);
@@ -2934,10 +2948,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_insn(s, RRE, SLBGR, args[1], args[5]);
         break;
 
-    case INDEX_op_brcond_i64:
-        tgen_brcond(s, TCG_TYPE_I64, args[2], args[0],
-                    args[1], const_args[1], arg_label(args[3]));
-        break;
     case INDEX_op_movcond_i64:
         tgen_movcond(s, TCG_TYPE_I64, args[5], args[0], args[1],
                      args[2], const_args[2], args[3], const_args[3], args[4]);
@@ -3454,11 +3464,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_brcond_i32:
-        return C_O0_I2(r, ri);
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, rC);
-
     case INDEX_op_bswap16_i32:
     case INDEX_op_bswap16_i64:
     case INDEX_op_bswap32_i32:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index dcbe6a8f47..68f38b7d71 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -822,6 +822,35 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     }
 }
 
+static void tcg_out_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                           TCGReg arg1, TCGArg arg2, bool const_arg2,
+                           TCGLabel *l)
+{
+    if (type == TCG_TYPE_I32) {
+        tcg_out_brcond_i32(s, cond, arg1, arg2, const_arg2, l);
+    } else {
+        tcg_out_brcond_i64(s, cond, arg1, arg2, const_arg2, l);
+    }
+}
+
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg1, TCGReg arg2, TCGLabel *l)
+{
+    tcg_out_brcond(s, type, cond, arg1, arg2, false, l);
+}
+
+static void tgen_brcondi(TCGContext *s, TCGType type, TCGCond cond,
+                         TCGReg arg1, tcg_target_long arg2, TCGLabel *l)
+{
+    tcg_out_brcond(s, type, cond, arg1, arg2, true, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, rJ),
+    .out_rr = tgen_brcond,
+    .out_ri = tgen_brcondi,
+};
+
 static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
                             TCGReg ret, TCGReg c1,
                             TCGArg c2, bool c2const, bool neg)
@@ -1755,9 +1784,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STW);
         break;
 
-    case INDEX_op_brcond_i32:
-        tcg_out_brcond_i32(s, a2, a0, a1, const_args[1], arg_label(args[3]));
-        break;
     case INDEX_op_movcond_i32:
         tcg_out_movcond_i32(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
@@ -1796,9 +1822,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, a0, a1, a2, STX);
         break;
 
-    case INDEX_op_brcond_i64:
-        tcg_out_brcond_i64(s, a2, a0, a1, const_args[1], arg_label(args[3]));
-        break;
     case INDEX_op_movcond_i64:
         tcg_out_movcond_i64(s, args[5], a0, a1, a2, c2, args[3], const_args[3]);
         break;
@@ -1872,9 +1895,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_qemu_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(rz, rJ);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, rz, rJ, rI, 0);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index d49c767de5..2c7fb5d75f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -81,10 +81,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_deposit_i64:
         return C_O1_I2(r, r, r);
 
-    case INDEX_op_brcond_i32:
-    case INDEX_op_brcond_i64:
-        return C_O0_I2(r, r);
-
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
@@ -964,6 +960,17 @@ static const TCGOutOpSetcond outop_negsetcond = {
     .out_rrr = tgen_negsetcond,
 };
 
+static void tgen_brcond(TCGContext *s, TCGType type, TCGCond cond,
+                        TCGReg arg0, TCGReg arg1, TCGLabel *l)
+{
+    tgen_setcond(s, type, cond, TCG_REG_TMP, arg0, arg1);
+    tcg_out_op_rl(s, INDEX_op_brcond_i32, TCG_REG_TMP, l);
+}
+
+static const TCGOutOpBrcond outop_brcond = {
+    .base.static_constraint = C_O0_I2(r, r),
+    .out_rr = tgen_brcond,
+};
 
 static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
@@ -1011,11 +1018,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_op_rrbb(s, opc, args[0], args[1], args[2], args[3]);
         break;
 
-    CASE_32_64(brcond)
-        tgen_setcond(s, type, args[2], TCG_REG_TMP, args[0], args[1]);
-        tcg_out_op_rl(s, opc, TCG_REG_TMP, arg_label(args[3]));
-        break;
-
     case INDEX_op_bswap32_i32: /* Optional (TCG_TARGET_HAS_bswap32_i32). */
     case INDEX_op_bswap64_i64: /* Optional (TCG_TARGET_HAS_bswap64_i64). */
         tcg_out_op_rr(s, opc, args[0], args[1]);
-- 
2.43.0


