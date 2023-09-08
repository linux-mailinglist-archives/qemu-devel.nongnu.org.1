Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1775B798087
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeR9t-0002aO-KG; Thu, 07 Sep 2023 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9s-0002Zu-6P
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:44 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9q-0006uW-1E
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:43 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 6241D43F56;
 Fri,  8 Sep 2023 02:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139821; bh=LuIrLO2/7+kJnnPlZe/iI+MS0Y12b8UIpaTKNeZDTY8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YfQoujC/uiuWK5EHCgTH9r6bVPt1P+33NVAtMo5xHWUaalqrqVxvTNzUf1e8Rm7o4
 YXbzqHlQdbPYPcSb8fIA/OvCCz+qK3xamPuL6LIiHRmfVTy0Y5oTnTxnfYZ7iysBKX
 VoEyKECtB3tDL2+L0irJxwNdBlwll9KxG4sgpW6c=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 07/16] tcg/loongarch64: Lower neg_vec to vneg
Date: Fri,  8 Sep 2023 10:21:14 +0800
Message-ID: <20230908022302.180442-8-c@jia.je>
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
 tcg/loongarch64/tcg-target.c.inc | 8 ++++++++
 tcg/loongarch64/tcg-target.h     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index d569e443dd..b36b706e39 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1695,6 +1695,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         [TCG_COND_LTU] = {OPC_VSLTI_BU, OPC_VSLTI_HU, OPC_VSLTI_WU, OPC_VSLTI_DU},
     };
     LoongArchInsn insn;
+    static const LoongArchInsn neg_vec_insn[4] = {
+        OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1793,6 +1796,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], false);
         break;
+    case INDEX_op_neg_vec:
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1818,6 +1824,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
         return 1;
     default:
         return 0;
@@ -1995,6 +2002,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
+    case INDEX_op_neg_vec:
         return C_O1_I1(w, w);
 
     default:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index f9c5cb12ca..64c72d0857 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -178,7 +178,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_v256             0
 
 #define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_andc_vec         1
 #define TCG_TARGET_HAS_orc_vec          1
-- 
2.42.0


