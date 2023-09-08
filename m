Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAE579808A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeRAG-0002jE-LO; Thu, 07 Sep 2023 22:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAD-0002ig-TT
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:05 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAB-0006wQ-I4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:05 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CCF1743FF0;
 Fri,  8 Sep 2023 02:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139832; bh=YmEF2ETPtsR/8m1G1mEYbfjOG6ULqYifL3LgJ0PVaWw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rmAA8W4nUvUnodZ2UWt18wf+KovJH/ummL7kJblPHYd8sOVbJhEOYcfQz1DXMvuMx
 GvjcKtDM1LYYjBV6GuP/CyQq9s6fJABiy5N3cQIVjiY8KjmDXB5koE1rB/vX/ht/sG
 0wZmhIuzpgke5Fd1uaipwN1uoyCwx/RHihj1PXiA=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 12/16] tcg/loongarch64: Lower bitsel_vec to vbitsel
Date: Fri,  8 Sep 2023 10:21:19 +0800
Message-ID: <20230908022302.180442-13-c@jia.je>
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
 tcg/loongarch64/tcg-target.c.inc     | 11 ++++++++++-
 tcg/loongarch64/tcg-target.h         |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 3f530ad4d8..914572d21b 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -35,4 +35,5 @@ C_O1_I2(r, rZ, rZ)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
+C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 6958fd219c..a33ec594ee 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1676,7 +1676,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
                            const int const_args[TCG_MAX_OP_ARGS])
 {
     TCGType type = vecl + TCG_TYPE_V64;
-    TCGArg a0, a1, a2;
+    TCGArg a0, a1, a2, a3;
     TCGReg temp = TCG_REG_TMP0;
     TCGReg temp_vec = TCG_VEC_TMP0;
 
@@ -1738,6 +1738,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
+    a3 = args[3];
 
     /* Currently only supports V128 */
     tcg_debug_assert(type == TCG_TYPE_V128);
@@ -1871,6 +1872,10 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sarv_vec:
         tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_bitsel_vec:
+        /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
+        tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1909,6 +1914,7 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_bitsel_vec:
         return 1;
     default:
         return 0;
@@ -2101,6 +2107,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_neg_vec:
         return C_O1_I1(w, w);
 
+    case INDEX_op_bitsel_vec:
+        return C_O1_I3(w, w, w, w);
+
     default:
         g_assert_not_reached();
     }
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 7e9fb61c47..bc56939a57 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -194,7 +194,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_rotv_vec         0
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       1
 #define TCG_TARGET_HAS_cmpsel_vec       0
 
 #define TCG_TARGET_DEFAULT_MO (0)
-- 
2.42.0


