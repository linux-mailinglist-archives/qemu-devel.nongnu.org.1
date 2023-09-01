Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DCC78FAF2
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 11:35:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc0Y4-0005Fv-6G; Fri, 01 Sep 2023 05:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc0XY-00054H-KR
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:34:09 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qc0XS-0000Zz-IQ
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 05:34:07 -0400
Received: from ls3a6000.. (unknown [223.72.40.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id CCC8744470;
 Fri,  1 Sep 2023 09:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693560831; bh=32SlQyD3SIyzxtyd1pmcYkrZHHAhgAihMV8Lj5s6cYM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ut6cJnr7pEjmJ/HK50swXu1gZpXFym9akw1mU+YzJ/NbtLe32IwDqB8JavQMmPgiW
 vTwEEkOksN/MFYw9JSK+ndmL/enbbto1xBhgc6PdNA3ujA22uKXAGXZ0d23OV+aVgq
 6YZXpp3NMhaheTI+A0gS7+KGGVzQcXXPY4Mk8WXM=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v2 14/14] tcg/loongarch64: Lower rotli_vec to vrotri
Date: Fri,  1 Sep 2023 17:31:07 +0800
Message-ID: <20230901093258.942357-15-c@jia.je>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230901093258.942357-1-c@jia.je>
References: <20230901093258.942357-1-c@jia.je>
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
 tcg/loongarch64/tcg-target.c.inc | 21 +++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 6fe319a77e..c4e9e0309e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1894,6 +1894,26 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1,
                                         temp_vec));
         break;
+    case INDEX_op_rotli_vec:
+        /* rotli_vec a1, a2 = rotri_vec a1, -a2 */
+        a2 = extract32(-a2, 0, 3 + vece);
+        switch (vece) {
+        case MO_8:
+            tcg_out_opc_vrotri_b(s, a0, a1, a2);
+            break;
+        case MO_16:
+            tcg_out_opc_vrotri_h(s, a0, a1, a2);
+            break;
+        case MO_32:
+            tcg_out_opc_vrotri_w(s, a0, a1, a2);
+            break;
+        case MO_64:
+            tcg_out_opc_vrotri_d(s, a0, a1, a2);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2132,6 +2152,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
+    case INDEX_op_rotli_vec:
         return C_O1_I1(w, w);
 
     case INDEX_op_bitsel_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index f6eb3cf7a6..3dc2dbf800 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -187,7 +187,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_shi_vec          1
 #define TCG_TARGET_HAS_shs_vec          0
 #define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_roti_vec         1
 #define TCG_TARGET_HAS_rots_vec         0
 #define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_sat_vec          1
-- 
2.42.0


