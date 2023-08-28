Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A578B44D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:22:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae30-0006IO-Na; Mon, 28 Aug 2023 11:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2s-0005fZ-Hh
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:52 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2q-0007Q5-89
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:50 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 572DA4415E;
 Mon, 28 Aug 2023 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236042; bh=sw3I5da4dL8j4Etl48tBFhVWaO6ZntIPG9Xt6JTCf+U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JWj9SnAEMqReM8tg55Mx0HidY7p92AEpdsbkNbfPW79L5hDANOlj3K3BRVlL4BejY
 mhaJkMCoUhxWkFaq+W27qKE/DinMm6AIzUi0mocXrrp4MN3W4GZ7l69boRb/uWJUGN
 kJ4Zui3euUumECt7tzCc3hMKRSv5YZLd1gItrHCg=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 06/11] tcg/loongarch64: Lower neg_vec to vneg
Date: Mon, 28 Aug 2023 23:19:44 +0800
Message-ID: <20230828152009.352048-7-c@jia.je>
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
 tcg/loongarch64/tcg-target.c.inc     | 10 ++++++++++
 tcg/loongarch64/tcg-target.h         |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index e80fc7f3f7..9fce856012 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -20,6 +20,7 @@ C_O0_I2(rZ, rZ)
 C_O0_I2(w, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
+C_O1_I1(w, w)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index fe741ef045..819dcdba77 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1638,6 +1638,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn sub_vec_insn[4] = {
         OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
     };
+    static const LoongArchInsn neg_vec_insn[4] = {
+        OPC_VNEG_B, OPC_VNEG_H, OPC_VNEG_W, OPC_VNEG_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1712,6 +1715,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sub_vec:
         tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_neg_vec:
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], a0, a1));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1736,6 +1742,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_orc_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_nor_vec:
+    case INDEX_op_neg_vec:
         return 1;
     default:
         return 0;
@@ -1908,6 +1915,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_nor_vec:
         return C_O1_I2(w, w, w);
 
+    case INDEX_op_neg_vec:
+        return C_O1_I1(w, w);
+
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 4ca685e752..6a8147875a 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -175,7 +175,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_v256             0
 
 #define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_neg_vec          1
 #define TCG_TARGET_HAS_abs_vec          0
 #define TCG_TARGET_HAS_andc_vec         1
 #define TCG_TARGET_HAS_orc_vec          1
-- 
2.42.0


