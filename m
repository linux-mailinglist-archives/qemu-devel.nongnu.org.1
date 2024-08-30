Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DA6965788
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 08:20:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjv01-0005Xs-LA; Fri, 30 Aug 2024 02:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuzt-0005Er-OV; Fri, 30 Aug 2024 02:20:38 -0400
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sjuzq-0005Lp-4F; Fri, 30 Aug 2024 02:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1724998829; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=/T8AJk8YTkndYTR58Ly9XEojetXhU1CqgEEfDCweXwc=;
 b=OSemA5biYYUIzElLnFF0UDl1yNFRSW0oQuiM6a4pY4cL24AnjeEhlYLg2l0G5ZMOdPG8VSvt4kBT1lTznvHX8wrinK+qZcTBl2WzMzYub+xwLu8U1G5BmGxQhZM0iRdzT44kpNL9P8g/QOFNf7vC8i+YJQXFPOCwrwfZuuz3k3k=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WDvasOZ_1724998827) by smtp.aliyun-inc.com;
 Fri, 30 Aug 2024 14:20:28 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v2 07/14] tcg/riscv: Add support for basic vector opcodes
Date: Fri, 30 Aug 2024 14:16:00 +0800
Message-Id: <20240830061607.1940-8-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.113;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-113.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
---
 tcg/riscv/tcg-target-con-set.h |  2 ++
 tcg/riscv/tcg-target-con-str.h |  1 +
 tcg/riscv/tcg-target.c.inc     | 54 ++++++++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h         |  2 +-
 4 files changed, 58 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index d73a62b0f2..7277cb9af8 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -22,4 +22,6 @@ C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
 C_O2_I4(r, r, rZ, rZ, rM, rM)
 C_O0_I2(v, r)
+C_O0_I2(v, vK)
 C_O1_I1(v, r)
+C_O1_I1(v, v)
diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target-con-str.h
index 21c4a0a0e0..a4ae7b49c8 100644
--- a/tcg/riscv/tcg-target-con-str.h
+++ b/tcg/riscv/tcg-target-con-str.h
@@ -17,6 +17,7 @@ REGS('v', GET_VREG_SET(riscv_vlen))
  */
 CONST('I', TCG_CT_CONST_S12)
 CONST('J', TCG_CT_CONST_J12)
+CONST('K', TCG_CT_CONST_S5)
 CONST('N', TCG_CT_CONST_N12)
 CONST('M', TCG_CT_CONST_M12)
 CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index b6b4bdc269..fde4e71260 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -111,6 +111,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_N12   0x400
 #define TCG_CT_CONST_M12   0x800
 #define TCG_CT_CONST_J12  0x1000
+#define TCG_CT_CONST_S5   0x2000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(33, 31)
@@ -162,6 +163,13 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_J12) && ~val >= -0x800 && ~val <= 0x7ff) {
         return 1;
     }
+    /*
+     * Sign extended from 5 bits: [-0x10, 0x0f].
+     * Used for vector-immediate.
+     */
+    if ((ct & TCG_CT_CONST_S5) && val >= -0x10 && val <= 0x0f) {
+        return 1;
+    }
     return 0;
 }
 
@@ -304,6 +312,13 @@ typedef enum {
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
 
+    OPC_VADD_VV = 0x57 | V_OPIVV,
+    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
+    OPC_VAND_VV = 0x24000057 | V_OPIVV,
+    OPC_VOR_VV = 0x28000057 | V_OPIVV,
+    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,
+    OPC_VXOR_VI = 0x2c000057 | V_OPIVI,
+
     OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
     OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
     OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
@@ -2228,6 +2243,30 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_st_vec:
         tcg_out_st(s, type, a0, a1, a2);
         break;
+    case INDEX_op_add_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VADD_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_sub_vec:
+        riscv_set_vec_config_vl_vece(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_and_vec:
+        riscv_set_vec_config_vl(s, type);
+        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_or_vec:
+        riscv_set_vec_config_vl(s, type);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_xor_vec:
+        riscv_set_vec_config_vl(s, type);
+        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_not_vec:
+        riscv_set_vec_config_vl(s, type);
+        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
+        break;
     case INDEX_op_mov_vec: /* Always emitted via tcg_out_mov.  */
     case INDEX_op_dup_vec: /* Always emitted via tcg_out_dup_vec.  */
     default:
@@ -2247,6 +2286,13 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
 int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
 {
     switch (opc) {
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_not_vec:
+        return 1;
     default:
         return 0;
     }
@@ -2397,6 +2443,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
+    case INDEX_op_not_vec:
+        return C_O1_I1(v, v);
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
+        return C_O1_I2(v, v, v);
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 12a7a37aaa..acb8dfdf16 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -151,7 +151,7 @@ typedef enum {
 #define TCG_TARGET_HAS_nand_vec         0
 #define TCG_TARGET_HAS_nor_vec          0
 #define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_roti_vec         0
-- 
2.43.0


