Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C9479052A
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 07:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcIoq-0008TU-Bi; Sat, 02 Sep 2023 01:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoZ-0008I6-H7
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:05:01 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoU-0001Cq-MZ
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:04:52 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id D16FB44460;
 Sat,  2 Sep 2023 05:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693631089; bh=ydTkNZTrpifOUvKO02DNWWNx0HH1LNALyjbJdsbR67A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IzCK/3aCfKH7GhiefWryCJCbnSU8UFoRBqBGASGp1yePCzejux4e+ZQ6SnFc1Et/7
 TfroqeAgeKU6JnlyNgGEu4i7nP9RoPii97LKYbIsm1AL/nV0RpMxW3Oitj/FwER9/T
 8RO6X+hrL9HDBB7Js30cT5GmJFPpsUum13zVJS/Q=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v3 05/16] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Date: Sat,  2 Sep 2023 13:02:05 +0800
Message-ID: <20230902050415.1832700-6-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230902050415.1832700-1-c@jia.je>
References: <20230902050415.1832700-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Lower the following ops:

- add_vec
- sub_vec

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target-con-str.h |  1 +
 tcg/loongarch64/tcg-target.c.inc     | 60 ++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 8c8ea5d919..2d5dce75c3 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -32,4 +32,5 @@ C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, w, wM)
+C_O1_I2(w, w, wA)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target-con-str.h b/tcg/loongarch64/tcg-target-con-str.h
index a8a1c44014..2ba9c135ac 100644
--- a/tcg/loongarch64/tcg-target-con-str.h
+++ b/tcg/loongarch64/tcg-target-con-str.h
@@ -27,3 +27,4 @@ CONST('Z', TCG_CT_CONST_ZERO)
 CONST('C', TCG_CT_CONST_C12)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('M', TCG_CT_CONST_VCMP)
+CONST('A', TCG_CT_CONST_VADD)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 129dd92910..0edcf5be35 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -177,6 +177,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_C12   0x1000
 #define TCG_CT_CONST_WSZ   0x2000
 #define TCG_CT_CONST_VCMP  0x4000
+#define TCG_CT_CONST_VADD  0x8000
 
 #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
 #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)
@@ -214,6 +215,9 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
     if ((ct & TCG_CT_CONST_VCMP) && -0x10 <= vec_val && vec_val <= 0x1f) {
         return true;
     }
+    if ((ct & TCG_CT_CONST_VADD) && -0x1f <= vec_val && vec_val <= 0x1f) {
+        return true;
+    }
     return false;
 }
 
@@ -1646,6 +1650,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
     };
     LoongArchInsn insn;
+    static const LoongArchInsn add_vec_insn[4] = {
+        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
+    };
+    static const LoongArchInsn add_vec_imm_insn[4] = {
+        OPC_VADDI_BU, OPC_VADDI_HU, OPC_VADDI_WU, OPC_VADDI_DU
+    };
+    static const LoongArchInsn sub_vec_insn[4] = {
+        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
+    };
+    static const LoongArchInsn sub_vec_imm_insn[4] = {
+        OPC_VSUBI_BU, OPC_VSUBI_HU, OPC_VSUBI_WU, OPC_VSUBI_DU
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1712,6 +1728,44 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
+    case INDEX_op_add_vec:
+        if (const_args[2]) {
+            int64_t value = sextract64(a2, 0, 8 << vece);
+            /* Try vaddi/vsubi */
+            if (0 <= value && value <= 0x1f) {
+                tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
+                                                 a1, value));
+                break;
+            } else if (-0x1f <= value && value < 0) {
+                tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
+                                                 a1, -value));
+                break;
+            }
+
+            /* constraint TCG_CT_CONST_VADD ensures unreachable */
+            g_assert_not_reached();
+        }
+        tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sub_vec:
+        if (const_args[2]) {
+            int64_t value = sextract64(a2, 0, 8 << vece);
+            /* Try vaddi/vsubi */
+            if (0 <= value && value <= 0x1f) {
+                tcg_out32(s, encode_vdvjuk5_insn(sub_vec_imm_insn[vece], a0, \
+                                                 a1, value));
+                break;
+            } else if (-0x1f <= value && value < 0) {
+                tcg_out32(s, encode_vdvjuk5_insn(add_vec_imm_insn[vece], a0, \
+                                                 a1, -value));
+                break;
+            }
+
+            /* constraint TCG_CT_CONST_VADD ensures unreachable */
+            g_assert_not_reached();
+        }
+        tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1728,6 +1782,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
         return 1;
     default:
         return 0;
@@ -1892,6 +1948,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_cmp_vec:
         return C_O1_I2(w, w, wM);
 
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
+        return C_O1_I2(w, w, wA);
+
     default:
         g_assert_not_reached();
     }
-- 
2.42.0


