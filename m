Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D6E790526
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Sep 2023 07:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcIp1-0000X3-IK; Sat, 02 Sep 2023 01:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoy-0000WY-Ko
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:05:20 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qcIoi-0001Ed-MW
 for qemu-devel@nongnu.org; Sat, 02 Sep 2023 01:05:20 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 67E1E44478;
 Sat,  2 Sep 2023 05:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693631103; bh=+bMAYLC6asPVVLqc5LAUWwhaGG3UrRGWdevObyu8oec=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=spWE6X/jPxnAfEc+4HEc5XNaLAy/1x5LQkQ7Z4Seduf8Ox/931eAe2ul0nyx5NUlu
 ZSpZw+O20o9SI+RV084zPab7RVe4AeDsyUO6RgdJXbfmdleo0o/Rhwqtu/gs6s81r6
 LlasmLxX+t3AAE8HvzqWC+DA8RqklIFRAZLi5a3s=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v3 11/16] tcg/loongarch64: Lower vector shift vector ops
Date: Sat,  2 Sep 2023 13:02:11 +0800
Message-ID: <20230902050415.1832700-12-c@jia.je>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

- shlv_vec
- shrv_vec
- sarv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 24 ++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 89db41002c..ef1cd7c621 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1692,6 +1692,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn ussub_vec_insn[4] = {
         OPC_VSSUB_BU, OPC_VSSUB_HU, OPC_VSSUB_WU, OPC_VSSUB_DU
     };
+    static const LoongArchInsn shlv_vec_insn[4] = {
+        OPC_VSLL_B, OPC_VSLL_H, OPC_VSLL_W, OPC_VSLL_D
+    };
+    static const LoongArchInsn shrv_vec_insn[4] = {
+        OPC_VSRL_B, OPC_VSRL_H, OPC_VSRL_W, OPC_VSRL_D
+    };
+    static const LoongArchInsn sarv_vec_insn[4] = {
+        OPC_VSRA_B, OPC_VSRA_H, OPC_VSRA_W, OPC_VSRA_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1852,6 +1861,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_ussub_vec:
         tcg_out32(s, encode_vdvjvk_insn(ussub_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_shlv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(shlv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_shrv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(shrv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sarv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(sarv_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1887,6 +1905,9 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return 1;
     default:
         return 0;
@@ -2070,6 +2091,9 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_shlv_vec:
+    case INDEX_op_shrv_vec:
+    case INDEX_op_sarv_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index fa14558275..7e9fb61c47 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -188,7 +188,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_shi_vec          0
 #define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         0
-- 
2.42.0


