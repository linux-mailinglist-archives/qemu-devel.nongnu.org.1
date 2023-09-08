Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78766798091
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeR9t-0002a2-1O; Thu, 07 Sep 2023 22:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9q-0002YO-4C
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:42 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeR9n-0006u2-Or
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:23:41 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 1AC4944260;
 Fri,  8 Sep 2023 02:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139818; bh=YSWDjTBSc60yhP7qDBBWb+70YITWI/E0tRcjnCT+ZA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZCaz9WK4gL07QZsm0Y7s2ES6T71O4Yzb0DVRt0nc2PYknwtUyW9kIRdeEmnpgQJiG
 wcr2dUuDA83IzkNTf3slKcwGB0XuPzGMlfW3VkoJrNZ1XEVF/KCGbxAg/HNgl4CmbR
 chc/jE6B49O1pROy2ZrpehOce7+q/HUPlbEVObTY=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 06/16] tcg/loongarch64: Lower vector bitwise operations
Date: Fri,  8 Sep 2023 10:21:13 +0800
Message-ID: <20230908022302.180442-7-c@jia.je>
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

Lower the following ops:

- and_vec
- andc_vec
- or_vec
- orc_vec
- xor_vec
- nor_vec
- not_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 ++
 tcg/loongarch64/tcg-target.c.inc     | 44 ++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h         |  8 ++---
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 2d5dce75c3..3f530ad4d8 100644
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
@@ -31,6 +32,7 @@ C_O1_I2(r, 0, rZ)
 C_O1_I2(r, rZ, ri)
 C_O1_I2(r, rZ, rJ)
 C_O1_I2(r, rZ, rZ)
+C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 1a369b237c..d569e443dd 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1722,6 +1722,32 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
             tcg_out_opc_vldx(s, a0, a1, temp);
         }
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
+    case INDEX_op_not_vec:
+        tcg_out_opc_vnor_v(s, a0, a1, a1);
+        break;
     case INDEX_op_cmp_vec:
         TCGCond cond = args[3];
         if (const_args[2]) {
@@ -1785,6 +1811,13 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_cmp_vec:
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
+    case INDEX_op_not_vec:
         return 1;
     default:
         return 0;
@@ -1953,6 +1986,17 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sub_vec:
         return C_O1_I2(w, w, wA);
 
+    case INDEX_op_and_vec:
+    case INDEX_op_andc_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_orc_vec:
+    case INDEX_op_xor_vec:
+    case INDEX_op_nor_vec:
+        return C_O1_I2(w, w, w);
+
+    case INDEX_op_not_vec:
+        return C_O1_I1(w, w);
+
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index daaf38ee31..f9c5cb12ca 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -177,13 +177,13 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_v128             use_lsx_instructions
 #define TCG_TARGET_HAS_v256             0
 
-#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_not_vec          1
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


