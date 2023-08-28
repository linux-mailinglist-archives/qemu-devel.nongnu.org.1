Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1E78B44E
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:22:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae2x-00063Z-UH; Mon, 28 Aug 2023 11:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2r-0005cm-F1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:49 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2m-0007P8-Ux
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:49 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id EB10F4415D;
 Mon, 28 Aug 2023 15:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236034; bh=sjaFC7yAp+wHHwch5hvv3SYKafwoBB7+k+YrWWJuukE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vhyg2X94wlOXbD9/xJ5mOG1c7x1MLGcIeruVdLqeFfBJfrafL4Ma99qM0cndOebPl
 b+q83Lww69B32eebPUfnhtUFBsHdQJ/VhMxZu541SECrUZ7nkwZaiZcvjWnKD7YkSU
 4n9t03yNGFkWjVMaif1Whh+76HROD7zQnUuOBs1Y=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 03/11] tcg/loongarch64: Lower cmp_vec to vseq/vsle/vslt
Date: Mon, 28 Aug 2023 23:19:41 +0800
Message-ID: <20230828152009.352048-4-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828152009.352048-1-c@jia.je>
References: <20230828152009.352048-1-c@jia.je>
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
---
 tcg/loongarch64/tcg-target-con-set.h |  1 +
 tcg/loongarch64/tcg-target.c.inc     | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 37b3f80bf9..e80fc7f3f7 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -31,4 +31,5 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 0f9427572c..cc80e5fa20 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1624,6 +1624,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     TCGReg temp = TCG_REG_TMP0;
     int32_t offset;
 
+    static const LoongArchInsn cmp_vec_insn[16][4] = {
+        [TCG_COND_EQ] = {OPC_VSEQ_B, OPC_VSEQ_H, OPC_VSEQ_W, OPC_VSEQ_D},
+        [TCG_COND_LE] = {OPC_VSLE_B, OPC_VSLE_H, OPC_VSLE_W, OPC_VSLE_D},
+        [TCG_COND_LEU] = {OPC_VSLE_BU, OPC_VSLE_HU, OPC_VSLE_WU, OPC_VSLE_DU},
+        [TCG_COND_LT] = {OPC_VSLT_B, OPC_VSLT_H, OPC_VSLT_W, OPC_VSLT_D},
+        [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
+    };
+    LoongArchInsn insn;
+
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
@@ -1656,6 +1665,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         tcg_out_opc_vld(s, a0, base, offset);
         break;
+    case INDEX_op_cmp_vec:
+        TCGCond cond = args[3];
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
@@ -1671,6 +1692,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_st_vec:
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
+    case INDEX_op_cmp_vec:
         return 1;
     default:
         return 0;
@@ -1832,6 +1854,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_st_vec:
         return C_O0_I2(w, r);
 
+    case INDEX_op_cmp_vec:
+        return C_O1_I2(w, w, w);
+
     default:
         g_assert_not_reached();
     }
-- 
2.42.0


