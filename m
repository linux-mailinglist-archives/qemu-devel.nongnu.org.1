Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F579808B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeRAJ-0002kA-MH; Thu, 07 Sep 2023 22:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAI-0002jv-Ag
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:10 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAG-0006xA-2n
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:10 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 6BCB143F7E;
 Fri,  8 Sep 2023 02:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139837; bh=GFPrXcWGvjk5a7rYqjrMDtWfKkyOA+O375JHg0KYOd0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ktytKKYgYLMVZ/BS6OSIGgaCB5SM1GPjHDaQbjRQ3ADNqHSnHjRM51Znu1Wa5KtsA
 0pim2bhll5tqw2JjfrYooIlePQx1RyUx/1V1V0S4Y8AUh23xXe7oQ7gdYXGd7kb1gP
 ABi7R+V1i9768TSmXN6ORSnn1zmCP+COriTEljLA=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 14/16] tcg/loongarch64: Lower rotv_vec ops to LSX
Date: Fri,  8 Sep 2023 10:21:21 +0800
Message-ID: <20230908022302.180442-15-c@jia.je>
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

- rotrv_vec
- rotlv_vec

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 14 ++++++++++++++
 tcg/loongarch64/tcg-target.h     |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index c21c917083..8f448823b0 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1743,6 +1743,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     static const LoongArchInsn sari_vec_insn[4] = {
         OPC_VSRAI_B, OPC_VSRAI_H, OPC_VSRAI_W, OPC_VSRAI_D
     };
+    static const LoongArchInsn rotrv_vec_insn[4] = {
+        OPC_VROTR_B, OPC_VROTR_H, OPC_VROTR_W, OPC_VROTR_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1890,6 +1893,15 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_sari_vec:
         tcg_out32(s, encode_vdvjuk3_insn(sari_vec_insn[vece], a0, a1, a2));
         break;
+    case INDEX_op_rotrv_vec:
+        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_rotlv_vec:
+        /* rotlv_vec a1, a2 = rotrv_vec a1, -a2 */
+        tcg_out32(s, encode_vdvj_insn(neg_vec_insn[vece], temp_vec, a2));
+        tcg_out32(s, encode_vdvjvk_insn(rotrv_vec_insn[vece], a0, a1,
+                                        temp_vec));
+        break;
     case INDEX_op_bitsel_vec:
         /* vbitsel vd, vj, vk, va = bitsel_vec vd, va, vk, vj */
         tcg_out_opc_vbitsel_v(s, a0, a3, a2, a1);
@@ -2119,6 +2131,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
+    case INDEX_op_rotrv_vec:
+    case INDEX_op_rotlv_vec:
         return C_O1_I2(w, w, w);
 
     case INDEX_op_not_vec:
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index d7b806e252..d5c69bc192 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -191,7 +191,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_shv_vec          1
 #define TCG_TARGET_HAS_roti_vec         0
 #define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
 #define TCG_TARGET_HAS_sat_vec          1
 #define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       1
-- 
2.42.0


