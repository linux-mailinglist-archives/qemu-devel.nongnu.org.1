Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B878B449
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae33-0006i2-9o; Mon, 28 Aug 2023 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2u-0005gG-GD
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:52 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2r-0007QH-1N
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:51 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 6ABF54419A;
 Mon, 28 Aug 2023 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236047; bh=wxra4kg7LA1djzAkRnIlMvaIuriX8v5zj3jeONhlGes=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VqskSWdLW7knsHnzJpooTX26LOK97xOIhg+3dhYCOEq0BnYMkhFPgU+nlSSx4srL/
 Dcwj0zrQY/Fv4PBNLf90BRachPYH8sKU5kuNREN6bkcvGOZg8mceReo4YqRLBGFrnf
 YRIvFTh5tkWTWAu/8Qd8pTrSkBsN9R3AIgfjgT9E=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 08/11] tcg/loongarch64: Lower vector min max ops
Date: Mon, 28 Aug 2023 23:19:46 +0800
Message-ID: <20230828152009.352048-9-c@jia.je>
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

Lower the following ops:

- smin_vec
- smax_vec
- umin_vec
- umax_vec

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index bca24b6a20..91049a80b6 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1644,6 +1644,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn mul_vec_insn[4] = {
         OPC_VMUL_B, OPC_VMUL_H, OPC_VMUL_W, OPC_VMUL_D
     };
+    static const LoongArchInsn smin_vec_insn[4] = {
+        OPC_VMIN_B, OPC_VMIN_H, OPC_VMIN_W, OPC_VMIN_D
+    };
+    static const LoongArchInsn umin_vec_insn[4] = {
+        OPC_VMIN_BU, OPC_VMIN_HU, OPC_VMIN_WU, OPC_VMIN_DU
+    };
+    static const LoongArchInsn smax_vec_insn[4] = {
+        OPC_VMAX_B, OPC_VMAX_H, OPC_VMAX_W, OPC_VMAX_D
+    };
+    static const LoongArchInsn umax_vec_insn[4] = {
+        OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1724,6 +1736,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_mul_vec:
         tcg_out32(s, encode_vdvjvk_insn(mul_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_smin_vec:
+        tcg_out32(s, encode_vdvjvk_insn(smin_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_smax_vec:
+        tcg_out32(s, encode_vdvjvk_insn(smax_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_umin_vec:
+        tcg_out32(s, encode_vdvjvk_insn(umin_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_umax_vec:
+        tcg_out32(s, encode_vdvjvk_insn(umax_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1750,6 +1774,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_nor_vec:
     case INDEX_op_neg_vec:
     case INDEX_op_mul_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
         return 1;
     default:
         return 0;
@@ -1921,6 +1949,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
     case INDEX_op_mul_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_umin_vec:
+    case INDEX_op_umax_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_neg_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 6b97abcb5b..97af7f8631 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -190,7 +190,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
-- 
2.42.0


