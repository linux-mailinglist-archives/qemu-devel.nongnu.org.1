Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518EC798088
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeR9q-0002YN-D0; Thu, 07 Sep 2023 22:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9n-0002Wk-2u
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:40 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9i-0006sL-S6
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:38 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 66C2B44185;
 Fri,  8 Sep 2023 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139807; bh=Kcd0i5CQWJRvO9Oj6Cj8tYc4HPs2G0flMKWYHfN4Pq0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j7jevQwgrtD7bcqG4n1quId4mFxHaLQc2dqTWvbXvq2kaSFdOnhT8fAFPVB8w1Qvy
 rw7PfF89miQJqgCPmM7TQqdO21y3ZoIC1OyrY+xT44rX2x6GEQ/uxpzqh53dx6eaat
 2XZB91i8Loo2qOO8lVmdgUp9XZYgLDm9khdw7sww=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 02/16] tcg/loongarch64: Lower basic tcg vec ops to LSX
Date: Fri,  8 Sep 2023 10:21:09 +0800
Message-ID: <20230908022302.180442-3-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230908022302.180442-1-c@jia.je>
References: <20230908022302.180442-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

LSX support on host cpu is detected via hwcap.

Lower the following ops to LSX:

- dup_vec
- dupi_vec
- dupm_vec
- ld_vec
- st_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |   2 +
 tcg/loongarch64/tcg-target-con-str.h |   1 +
 tcg/loongarch64/tcg-target.c.inc     | 219 ++++++++++++++++++++++++++-
 tcg/loongarch64/tcg-target.h         |  38 ++++-
 tcg/loongarch64/tcg-target.opc.h     |  12 ++
 5 files changed, 270 insertions(+), 2 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target.opc.h

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index c2bde44613..37b3f80bf9 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -17,7 +17,9 @@
 C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
+C_O0_I2(w, r)
 C_O1_I1(r, r)
+C_O1_I1(w, r)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 6e9ccca3ad..81b8d40278 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -14,6 +14,7 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
+REGS('w', ALL_VECTOR_REGS)
 
 /*
  * Define constraint letters for constants:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index baf5fc3819..150278e112 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -32,6 +32,8 @@
 #include "../tcg-ldst.c.inc"
 #include <asm/hwcap.h>
 
+bool use_lsx_instructions;
+
 #ifdef CONFIG_DEBUG_TCG
 static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "zero",
@@ -65,7 +67,39 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
     "s5",
     "s6",
     "s7",
-    "s8"
+    "s8",
+    "vr0",
+    "vr1",
+    "vr2",
+    "vr3",
+    "vr4",
+    "vr5",
+    "vr6",
+    "vr7",
+    "vr8",
+    "vr9",
+    "vr10",
+    "vr11",
+    "vr12",
+    "vr13",
+    "vr14",
+    "vr15",
+    "vr16",
+    "vr17",
+    "vr18",
+    "vr19",
+    "vr20",
+    "vr21",
+    "vr22",
+    "vr23",
+    "vr24",
+    "vr25",
+    "vr26",
+    "vr27",
+    "vr28",
+    "vr29",
+    "vr30",
+    "vr31",
 };
 #endif
 
@@ -102,6 +136,15 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_A2,
     TCG_REG_A1,
     TCG_REG_A0,
+
+    /* Vector registers */
+    TCG_REG_V0, TCG_REG_V1, TCG_REG_V2, TCG_REG_V3,
+    TCG_REG_V4, TCG_REG_V5, TCG_REG_V6, TCG_REG_V7,
+    TCG_REG_V8, TCG_REG_V9, TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    /* V24 - V31 are caller-saved, and skipped.  */
 };
 
 static const int tcg_target_call_iarg_regs[] = {
@@ -135,6 +178,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_WSZ   0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
+#define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
 
 static inline tcg_target_long sextreg(tcg_target_long val, int pos, int len)
 {
@@ -1486,6 +1530,154 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
+static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
+                            TCGReg rd, TCGReg rs)
+{
+    switch (vece) {
+    case MO_8:
+        tcg_out_opc_vreplgr2vr_b(s, rd, rs);
+        break;
+    case MO_16:
+        tcg_out_opc_vreplgr2vr_h(s, rd, rs);
+        break;
+    case MO_32:
+        tcg_out_opc_vreplgr2vr_w(s, rd, rs);
+        break;
+    case MO_64:
+        tcg_out_opc_vreplgr2vr_d(s, rd, rs);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    /* Handle imm overflow and division (vldrepl.d imm is divided by 8) */
+    if (offset < -0x800 || offset > 0x7ff || \
+        (offset & ((1 << vece) - 1)) != 0) {
+        tcg_out_addi(s, TCG_TYPE_I64, TCG_REG_TMP0, base, offset);
+        base = TCG_REG_TMP0;
+        offset = 0;
+    }
+    offset >>= vece;
+
+    switch (vece) {
+    case MO_8:
+        tcg_out_opc_vldrepl_b(s, r, base, offset);
+        break;
+    case MO_16:
+        tcg_out_opc_vldrepl_h(s, r, base, offset);
+        break;
+    case MO_32:
+        tcg_out_opc_vldrepl_w(s, r, base, offset);
+        break;
+    case MO_64:
+        tcg_out_opc_vldrepl_d(s, r, base, offset);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg rd, int64_t v64)
+{
+    /* Try vldi if imm can fit */
+    int64_t value = sextract64(v64, 0, 8 << vece);
+    if (-0x200 <= value && value <= 0x1FF) {
+        uint32_t imm = (vece << 10) | ((uint32_t)v64 & 0x3FF);
+        tcg_out_opc_vldi(s, rd, imm);
+        return;
+    }
+
+    /* TODO: vldi patterns when imm 12 is set */
+
+    /* Fallback to vreplgr2vr */
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, value);
+    switch (vece) {
+    case MO_8:
+        tcg_out_opc_vreplgr2vr_b(s, rd, TCG_REG_TMP0);
+        break;
+    case MO_16:
+        tcg_out_opc_vreplgr2vr_h(s, rd, TCG_REG_TMP0);
+        break;
+    case MO_32:
+        tcg_out_opc_vreplgr2vr_w(s, rd, TCG_REG_TMP0);
+        break;
+    case MO_64:
+        tcg_out_opc_vreplgr2vr_d(s, rd, TCG_REG_TMP0);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
+                           unsigned vecl, unsigned vece,
+                           const TCGArg args[TCG_MAX_OP_ARGS],
+                           const int const_args[TCG_MAX_OP_ARGS])
+{
+    TCGType type = vecl + TCG_TYPE_V64;
+    TCGArg a0, a1, a2;
+    TCGReg temp = TCG_REG_TMP0;
+
+    a0 = args[0];
+    a1 = args[1];
+    a2 = args[2];
+
+    /* Currently only supports V128 */
+    tcg_debug_assert(type == TCG_TYPE_V128);
+
+    switch (opc) {
+    case INDEX_op_st_vec:
+        /* Try to fit vst imm */
+        if (-0x800 <= a2 && a2 <= 0x7ff) {
+            tcg_out_opc_vst(s, a0, a1, a2);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
+            tcg_out_opc_vstx(s, a0, a1, temp);
+        }
+        break;
+    case INDEX_op_ld_vec:
+        /* Try to fit vld imm */
+        if (-0x800 <= a2 && a2 <= 0x7ff) {
+            tcg_out_opc_vld(s, a0, a1, a2);
+        } else {
+            tcg_out_movi(s, TCG_TYPE_I64, temp, a2);
+            tcg_out_opc_vldx(s, a0, a1, temp);
+        }
+        break;
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+}
+
+int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
+{
+    switch (opc) {
+    case INDEX_op_ld_vec:
+    case INDEX_op_st_vec:
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupm_vec:
+        return 1;
+    default:
+        return 0;
+    }
+}
+
+void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
+                       TCGArg a0, ...)
+{
+    g_assert_not_reached();
+}
+
 static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 {
     switch (op) {
@@ -1627,6 +1819,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_movcond_i64:
         return C_O1_I4(r, rZ, rJ, rZ, rZ);
 
+    case INDEX_op_ld_vec:
+    case INDEX_op_dupm_vec:
+    case INDEX_op_dup_vec:
+        return C_O1_I1(w, r);
+
+    case INDEX_op_st_vec:
+        return C_O0_I2(w, r);
+
     default:
         g_assert_not_reached();
     }
@@ -1708,6 +1908,10 @@ static void tcg_target_init(TCGContext *s)
         exit(EXIT_FAILURE);
     }
 
+    if (hwcap & HWCAP_LOONGARCH_LSX) {
+        use_lsx_instructions = 1;
+    }
+
     tcg_target_available_regs[TCG_TYPE_I32] = ALL_GENERAL_REGS;
     tcg_target_available_regs[TCG_TYPE_I64] = ALL_GENERAL_REGS;
 
@@ -1723,6 +1927,18 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S8);
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
+    if (use_lsx_instructions) {
+        tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V26);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V27);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V28);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V29);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V30);
+        tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V31);
+    }
+
     s->reserved_regs = 0;
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_ZERO);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TMP0);
@@ -1731,6 +1947,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_TP);
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RESERVED);
+    tcg_regset_set_reg(s->reserved_regs, TCG_VEC_TMP0);
 }
 
 typedef struct {
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 559be67186..daaf38ee31 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -30,7 +30,7 @@
 #define LOONGARCH_TCG_TARGET_H
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_NB_REGS 32
+#define TCG_TARGET_NB_REGS 64
 
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
@@ -68,13 +68,25 @@ typedef enum {
     TCG_REG_S7,
     TCG_REG_S8,
 
+    TCG_REG_V0 = 32, TCG_REG_V1, TCG_REG_V2, TCG_REG_V3,
+    TCG_REG_V4, TCG_REG_V5, TCG_REG_V6, TCG_REG_V7,
+    TCG_REG_V8, TCG_REG_V9, TCG_REG_V10, TCG_REG_V11,
+    TCG_REG_V12, TCG_REG_V13, TCG_REG_V14, TCG_REG_V15,
+    TCG_REG_V16, TCG_REG_V17, TCG_REG_V18, TCG_REG_V19,
+    TCG_REG_V20, TCG_REG_V21, TCG_REG_V22, TCG_REG_V23,
+    TCG_REG_V24, TCG_REG_V25, TCG_REG_V26, TCG_REG_V27,
+    TCG_REG_V28, TCG_REG_V29, TCG_REG_V30, TCG_REG_V31,
+
     /* aliases */
     TCG_AREG0    = TCG_REG_S0,
     TCG_REG_TMP0 = TCG_REG_T8,
     TCG_REG_TMP1 = TCG_REG_T7,
     TCG_REG_TMP2 = TCG_REG_T6,
+    TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
+extern bool use_lsx_instructions;
+
 /* used for function call generation */
 #define TCG_REG_CALL_STACK              TCG_REG_SP
 #define TCG_TARGET_STACK_ALIGN          16
@@ -161,6 +173,30 @@ typedef enum {
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
+#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v128             use_lsx_instructions
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+
 #define TCG_TARGET_DEFAULT_MO (0)
 
 #define TCG_TARGET_NEED_LDST_LABELS
diff --git a/tcg/loongarch64/tcg-target.opc.h b/tcg/loongarch64/tcg-target.opc.h
new file mode 100644
index 0000000000..fd1a40b7fd
--- /dev/null
+++ b/tcg/loongarch64/tcg-target.opc.h
@@ -0,0 +1,12 @@
+/*
+ * Copyright (c) 2023 Jiajie Chen
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ * Target-specific opcodes for host vector expansion.  These will be
+ * emitted by tcg_expand_vec_op.  For those familiar with GCC internals,
+ * consider these to be UNSPEC with names.
+ */
-- 
2.42.0


