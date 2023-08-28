Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE11178B456
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae31-0006YU-TW; Mon, 28 Aug 2023 11:20:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2s-0005fa-KH
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:52 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2q-0007Q4-72
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:50 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id C4FC1440B7;
 Mon, 28 Aug 2023 15:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236039; bh=bYV/bV05aNexdbaJRRUXdKeqm5AhkcxC9JLdB+wc2hg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QNlIwE4gQaRLCxyR/248sG98aesMInJieEVIjSFC2yDjLQFFoRfeW7IDAkbd+OqaW
 iweKDvjC2naUGVYrFAbbkp4SPu2+JZgr6mAIOp2AXca7+50HVpqUwhCuzZcsy0WdCW
 hg/b22U7lUy4B2cp1poEaXMV0Q/GTHGlIEX8YZ1w=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 05/11] tcg/loongarch64: Lower vector bitwise operations
Date: Mon, 28 Aug 2023 23:19:43 +0800
Message-ID: <20230828152009.352048-6-c@jia.je>
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

- and_vec
- andc_vec
- or_vec
- orc_vec
- xor_vec
- nor_vec

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target.c.inc | 35 ++++++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  6 +++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index eb340a6493..fe741ef045 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1671,6 +1671,29 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         tcg_out_opc_vld(s, a0, base, offset);
         break;
+    case INDEX_op_and_vec:
+        tcg_out_opc_vand_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_andc_vec:
+        /*
+         * vandn vd, vj, vk: vd = vk & ~vj
+         * andc_vec vd, vj, vk: vd = vj & ~vk
+         * vk and vk are swapped
+         */
+        tcg_out_opc_vandn_v(s, a0, a2, a1);
+        break;
+    case INDEX_op_or_vec:
+        tcg_out_opc_vor_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_orc_vec:
+        tcg_out_opc_vorn_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_xor_vec:
+        tcg_out_opc_vxor_v(s, a0, a1, a2);
+        break;
+    case INDEX_op_nor_vec:
+        tcg_out_opc_vnor_v(s, a0, a1, a2);
+        break;
     case INDEX_op_cmp_vec:
         TCGCond cond = args[3];
         insn = cmp_vec_insn[cond][vece];
@@ -1707,6 +1730,12 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_cmp_vec:
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
         return 1;
     default:
         return 0;
@@ -1871,6 +1900,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_cmp_vec:
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
         return C_O1_I2(w, w, w);
 
     default:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index be9343ded9..4ca685e752 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -177,10 +177,10 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_not_vec          0
 #define TCG_TARGET_HAS_neg_vec          0
 #define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
 #define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_nor_vec          1
 #define TCG_TARGET_HAS_eqv_vec          0
 #define TCG_TARGET_HAS_mul_vec          0
 #define TCG_TARGET_HAS_shi_vec          0
-- 
2.42.0


