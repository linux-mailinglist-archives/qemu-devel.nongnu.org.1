Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5678B44F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:22:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae30-0006D1-1h; Mon, 28 Aug 2023 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2v-0005r2-Er
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:53 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2s-0007Qc-UU
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:53 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E6E5644188;
 Mon, 28 Aug 2023 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236049; bh=X4k0l2WbyogJT9ucO9tGJ9lSUWCcHzfqJ3zjBk91qvc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GlcTqTdM/tf31D3yPVgOf01Fnt2HLWPXDkIAstDWzR/OLSQgyH8omimnEkDGm2EiN
 ACLQM3A/q5NnwgWJRCQz+EE9WNs/G5K96fzx8q3ap+s99xrDzNSmq03PLf9RoelI1W
 P42+wO2hEFwgqC7RFOKhH6QGyqJOoa43VOU00yM8=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 09/11] tcg/loongarch64: Lower vector saturated ops
Date: Mon, 28 Aug 2023 23:19:47 +0800
Message-ID: <20230828152009.352048-10-c@jia.je>
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

- ssadd_vec
- usadd_vec
- sssub_vec
- ussub_vec

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target.c.inc | 32 ++++++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 91049a80b6..21d2365987 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1656,6 +1656,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn umax_vec_insn[4] = {
         OPC_VMAX_BU, OPC_VMAX_HU, OPC_VMAX_WU, OPC_VMAX_DU
     };
+    static const LoongArchInsn ssadd_vec_insn[4] = {
+        OPC_VSADD_B, OPC_VSADD_H, OPC_VSADD_W, OPC_VSADD_D
+    };
+    static const LoongArchInsn usadd_vec_insn[4] = {
+        OPC_VSADD_BU, OPC_VSADD_HU, OPC_VSADD_WU, OPC_VSADD_DU
+    };
+    static const LoongArchInsn sssub_vec_insn[4] = {
+        OPC_VSSUB_B, OPC_VSSUB_H, OPC_VSSUB_W, OPC_VSSUB_D
+    };
+    static const LoongArchInsn ussub_vec_insn[4] = {
+        OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1748,6 +1760,18 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_umax_vec:
         tcg_out32(s, encode_vdvjvk_insn(umax_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_ssadd_vec:
+        tcg_out32(s, encode_vdvjvk_insn(ssadd_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_usadd_vec:
+        tcg_out32(s, encode_vdvjvk_insn(usadd_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sssub_vec:
+        tcg_out32(s, encode_vdvjvk_insn(sssub_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_ussub_vec:
+        tcg_out32(s, encode_vdvjvk_insn(ussub_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1778,6 +1802,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
         return 1;
     default:
         return 0;
@@ -1953,6 +1981,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_smax_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_umax_vec:
+    case INDEX_op_ssadd_vec:
+    case INDEX_op_usadd_vec:
+    case INDEX_op_sssub_vec:
+    case INDEX_op_ussub_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_neg_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 97af7f8631..4c90a1cf51 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -189,7 +189,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       0
-- 
2.42.0


