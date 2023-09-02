Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E42790523
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 07:07:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcIp5-0000YX-Vn; Sat, 02 Sep 2023 01:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIp2-0000Xa-Vn
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:05:24 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIon-0001Ez-8J
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:05:24 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id E9B5744378;
 Sat,  2 Sep 2023 05:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693631107; bh=IF1n+BiA98dcwSGLOLmh858I9nrPUJFnOMA6Frl9/Ao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oZhEBFBhdgc5O11E8w2I5bJhYCAGzap2NJn99c5VwFRdttrivKAdlFliZL8s+V4rV
 YMEoWUFY78pdZIsp/uhZT0z7HzhPNMMaOYhAhHCixYdwA1enLxtZo9gsBRNpT662Tg
 kESV7dAna3tI3K59VyvQo7nQaz9+2Cu18C3mHybk=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v3 13/16] tcg/loongarch64: Lower vector shift integer ops
Date: Sat,  2 Sep 2023 13:02:13 +0800
Message-ID: <20230902050415.1832700-14-c@jia.je>
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

- shli_vec
- shrv_vec
- sarv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 2db4369a9e..8ac008b907 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1701,6 +1701,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn sarv_vec_insn[4] = {
         OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D
     };
+    static const LoongArchInsn shli_vec_insn[4] = {
+        OPC_VSLLI_B, OPC_VSLLI_H, OPC_VSLLI_W, OPC_VSLLI_D
+    };
+    static const LoongArchInsn shri_vec_insn[4] = {
+        OPC_VSRLI_B, OPC_VSRLI_H, OPC_VSRLI_W, OPC_VSRLI_D
+    };
+    static const LoongArchInsn sari_vec_insn[4] = {
+        OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1871,6 +1880,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_shli_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(shli_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_shri_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(shri_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sari_vec:
+        tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2104,6 +2122,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_not_vec:
     case INDEX_op_neg_vec:
+    case INDEX_op_shli_vec:
+    case INDEX_op_shri_vec:
+    case INDEX_op_sari_vec:
         return C_O1_I1(w, w);
 
     case INDEX_op_bitsel_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index bc56939a57..d7b806e252 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -186,7 +186,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_nor_vec          1
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
-- 
2.42.0


