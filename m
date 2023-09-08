Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70A8798085
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 04:24:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeRAO-0002lF-9w; Thu, 07 Sep 2023 22:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAN-0002l6-1a
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:15 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qeRAK-0006xY-Kt
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 22:24:14 -0400
Received: from ls3a6000.. (unknown [223.72.41.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id EB36B44218;
 Fri,  8 Sep 2023 02:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1694139841; bh=Q5Z/SYfeh0dWR8MNSoRWiXQMpV3f30oYafU/hT7IPis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CGiRtZEBFHvlBOB7+51tttgAiDVjNkymgRJHEIjs0ttKaRAfhDa9QEgkPJdva/28p
 918fQw5RUwRM11LCsOtwNc3vv3Ln1WEVMoNobqvZ5nKvb2tzYBxN6GvBwrfpkvwzSj
 7VLfcJXe6eBDNP4ymRn7x1Govb1rITz/Ch0h6nkE=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, git@xen0n.name,
 Jiajie Chen <c@jia.je>
Subject: [PATCH v4 16/16] tcg/loongarch64: Implement 128-bit load & store
Date: Fri,  8 Sep 2023 10:21:23 +0800
Message-ID: <20230908022302.180442-17-c@jia.je>
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

If LSX is available, use LSX instructions to implement 128-bit load &
store when MO_128 is required, otherwise use two 64-bit loads & stores.

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 +
 tcg/loongarch64/tcg-target.c.inc     | 59 ++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h         |  2 +-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 914572d21b..77d62e38e7 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -18,6 +18,7 @@ C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
 C_O0_I2(w, r)
+C_O0_I3(r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
@@ -37,3 +38,4 @@ C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
+C_O2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 82901d678a..6e9f334fed 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1081,6 +1081,48 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi,
+                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr_reg, oi, true);
+
+    if (h.aa.atom == MO_128) {
+        /*
+         * Use VLDX/VSTX when 128-bit atomicity is required.
+         * If address is aligned to 16-bytes, the 128-bit load/store is atomic.
+         */
+        if (is_ld) {
+            tcg_out_opc_vldx(s, TCG_VEC_TMP0, h.base, h.index);
+            tcg_out_opc_vpickve2gr_d(s, data_lo, TCG_VEC_TMP0, 0);
+            tcg_out_opc_vpickve2gr_d(s, data_hi, TCG_VEC_TMP0, 1);
+        } else {
+            tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_lo, 0);
+            tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_hi, 1);
+            tcg_out_opc_vstx(s, TCG_VEC_TMP0, h.base, h.index);
+        }
+    } else {
+        /* otherwise use a pair of LD/ST */
+        tcg_out_opc_add_d(s, TCG_REG_TMP0, h.base, h.index);
+        if (is_ld) {
+            tcg_out_opc_ld_d(s, data_lo, TCG_REG_TMP0, 0);
+            tcg_out_opc_ld_d(s, data_hi, TCG_REG_TMP0, 8);
+        } else {
+            tcg_out_opc_st_d(s, data_lo, TCG_REG_TMP0, 0);
+            tcg_out_opc_st_d(s, data_hi, TCG_REG_TMP0, 8);
+        }
+    }
+
+    if (ldst) {
+        ldst->type = TCG_TYPE_I128;
+        ldst->datalo_reg = data_lo;
+        ldst->datahi_reg = data_hi;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
 /*
  * Entry-points
  */
@@ -1145,6 +1187,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
+    TCGArg a3 = args[3];
     int c2 = const_args[2];
 
     switch (opc) {
@@ -1507,6 +1550,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_ld_a64_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
         break;
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
+        break;
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
@@ -1515,6 +1562,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_st_a64_i64:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
+        break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
@@ -1996,6 +2047,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        return C_O2_I1(r, r, r);
+
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        return C_O0_I3(r, r, r);
+
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rZ, rZ);
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 67b0a95532..03017672f6 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -171,7 +171,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
+#define TCG_TARGET_HAS_qemu_ldst_i128   use_lsx_instructions
 
 #define TCG_TARGET_HAS_v64              0
 #define TCG_TARGET_HAS_v128             use_lsx_instructions
-- 
2.42.0


