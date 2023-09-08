Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A979808C
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:25:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeR9q-0002YM-4B; Thu, 07 Sep 2023 22:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9m-0002W8-81
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:38 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9j-0006tO-5O
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:38 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 80FD943F56;
 Fri,  8 Sep 2023 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139814; bh=9XQWHer0xAzj7iqnibcamHPV1nyaE7BIWTUDLztIfvs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A+vRO8xs6ZPldZaQnL53sTbHxK2adCGWz2Z0JxnGRVtgxGEg0qDpbDvDeaROUer3a
 qXu50V0cEJO0SXomjVrmqw9XPgZXMc//XEobS0UacLTmo7l0bRi0GnT7VIyVeR44ID
 AvKxZXxKfAzqOJ9nbypN+WdhAbhYRT12ME/AehTk=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 04/16] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Date: Fri,  8 Sep 2023 10:21:11 +0800
Message-ID: <20230908022302.180442-5-c@jia.je>
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

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target-con-str.h |  1 +
 tcg/loongarch64/tcg-target.c.inc     | 65 ++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 37b3f80bf9..8c8ea5d919 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, w, wM)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index 81b8d40278..a8a1c44014 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -26,3 +26,4 @@ CONST('U', TCG_CT_CONST_U12)
 CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
+CONST('M', TCG_CT_CONST_VCMP)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 07a0326e5d..129dd92910 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -176,6 +176,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_U12   0x800
 #define TCG_CT_CONST_C12   0x1000
 #define TCG_CT_CONST_WSZ   0x2000
+#define TCG_CT_CONST_VCMP  0x4000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -209,6 +210,10 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return true;
     }
+    int64_t vec_val = sextract64(val, 0, 8 << vece);
+    if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
+        return true;
+    }
     return false;
 }
 
@@ -1624,6 +1629,23 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     TCGType type = vecl + TCG_TYPE_V64;
     TCGArg a0, a1, a2;
     TCGReg temp = TCG_REG_TMP0;
+    TCGReg temp_vec = TCG_VEC_TMP0;
+
+    static const LoongArchInsn cmp_vec_insn[16][4] = {
+        [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
+        [TCG_COND_LE] = {OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D},
+        [TCG_COND_LEU] = {OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU},
+        [TCG_COND_LT] = {OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D},
+        [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
+    };
+    static const LoongArchInsn cmp_vec_imm_insn[16][4] = {
+        [TCG_COND_EQ] = {OPC_VSEQI_B, OPC_VSEQI_H, OPC_VSEQI_W, OPC_VSEQI_D},
+        [TCG_COND_LE] = {OPC_VSLEI_B, OPC_VSLEI_H, OPC_VSLEI_W, OPC_VSLEI_D},
+        [TCG_COND_LEU] = {OPC_VSLEI_BU, OPC_VSLEI_HU, OPC_VSLEI_WU, OPC_VSLEI_DU},
+        [TCG_COND_LT] = {OPC_VSLTI_B, OPC_VSLTI_H, OPC_VSLTI_W, OPC_VSLTI_D},
+        [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
+    };
+    LoongArchInsn insn;
 
     a0 = args[0];
     a1 = args[1];
@@ -1651,6 +1673,45 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             tcg_out_opc_vldx(s, a0, a1, temp);
         }
         break;
+    case INDEX_op_cmp_vec:
+        TCGCond cond = args[3];
+        if (const_args[2]) {
+            /*
+             * cmp_vec dest, src, value
+             * Try vseqi/vslei/vslti
+             */
+            int64_t value = sextract64(a2, 0, 8 << vece);
+            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
+                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
+                tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                 a0, a1, value));
+                break;
+            } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
+                (0x00 <= value && value <= 0x1f)) {
+                tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                 a0, a1, value));
+                break;
+            }
+
+            /*
+             * Fallback to:
+             * dupi_vec temp, a2
+             * cmp_vec a0, a1, temp, cond
+             */
+            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
+            a2 = temp_vec;
+        }
+
+        insn = cmp_vec_insn[cond][vece];
+        if (insn == 0) {
+            TCGArg t;
+            t = a1, a1 = a2, a2 = t;
+            cond = tcg_swap_cond(cond);
+            insn = cmp_vec_insn[cond][vece];
+            tcg_debug_assert(insn != 0);
+        }
+        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1666,6 +1727,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_st_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
+    case INDEX_op_cmp_vec:
         return 1;
     default:
         return 0;
@@ -1827,6 +1889,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
         return C_O0_I2(w, r);
 
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(w, w, wM);
+
     default:
         g_assert_not_reached();
     }
-- 
2.42.0


