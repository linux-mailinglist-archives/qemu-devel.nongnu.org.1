Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0BC975545
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 16:28:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soOK7-00087L-DH; Wed, 11 Sep 2024 10:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOJL-000722-9K; Wed, 11 Sep 2024 10:27:16 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1soOJJ-0003I9-2j; Wed, 11 Sep 2024 10:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1726064825; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=D+DGhp8EGAz6oAl5x8R6s8Pt8k34I/9PIYiqLkcvXNk=;
 b=ExE/wN7Pm1WU5rm1rMC5v7M65eTHtQLApu3siyQURNzQ/KRVm4ye3aCgzIV6klqqnzoCe1sLI9Oanf6LdBiZMrYKcJDQvPbhPRX9RvaGXK+2Skx6pw9bwcAtDd6bljhbsdlPK92fYACgnYNMfxL/YQXUqMaiyrvSZqDxfMjFFQU=
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEo89Dv_1726061533) by smtp.aliyun-inc.com;
 Wed, 11 Sep 2024 21:32:14 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 zhiwei_liu@linux.alibaba.com, richard.henderson@linaro.org,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v4 09/12] tcg/riscv: Implement vector min/max ops
Date: Wed, 11 Sep 2024 21:26:27 +0800
Message-Id: <20240911132630.461-10-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
References: <20240911132630.461-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 29 +++++++++++++++++++++++++++++
 tcg/riscv/tcg-target.h     |  2 +-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 0a091c12d2..c068d83a97 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -287,6 +287,11 @@ typedef enum {
     OPC_VSADDU_VV = 0x80000057 | V_OPIVV,
     OPC_VSSUBU_VV = 0x88000057 | V_OPIVV,
 
+    OPC_VMAX_VV = 0x1c000057 | V_OPIVV,
+    OPC_VMAXU_VV = 0x18000057 | V_OPIVV,
+    OPC_VMIN_VV = 0x14000057 | V_OPIVV,
+    OPC_VMINU_VV = 0x10000057 | V_OPIVV,
+
     OPC_VMSEQ_VV = 0x60000057 | V_OPIVV,
     OPC_VMSEQ_VI = 0x60000057 | V_OPIVI,
     OPC_VMSEQ_VX = 0x60000057 | V_OPIVX,
@@ -2416,6 +2421,22 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         set_vtype_len_sew(s, type, vece);
         tcg_out_opc_vv(s, OPC_VSSUBU_VV, a0, a1, a2, true);
         break;
+    case INDEX_op_smax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAX_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_smin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMIN_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umax_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMAXU_VV, a0, a1, a2, true);
+        break;
+    case INDEX_op_umin_vec:
+        set_vtype_len_sew(s, type, vece);
+        tcg_out_opc_vv(s, OPC_VMINU_VV, a0, a1, a2, true);
+        break;
     case INDEX_op_cmpsel_vec:
         tcg_out_cmpsel(s, type, vece, args[5], a0, a1, a2, const_args[2],
                        args[3], const_args[3], args[4], const_args[4]);
@@ -2465,6 +2486,10 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
     case INDEX_op_cmpsel_vec:
         return 1;
     case INDEX_op_cmp_vec:
@@ -2632,6 +2657,10 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_sssub_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_ussub_vec:
+    case INDEX_op_smax_vec:
+    case INDEX_op_smin_vec:
+    case INDEX_op_umax_vec:
+    case INDEX_op_umin_vec:
         return C_O1_I2(v, v, v);
     case INDEX_op_cmp_vec:
         return C_O1_I2(v, v, vL);
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 1d4d8878ce..7005099810 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -162,7 +162,7 @@ typedef enum {
 #define TCG_TARGET_HAS_shv_vec          0
 #define TCG_TARGET_HAS_mul_vec          1
 #define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_minmax_vec       1
 #define TCG_TARGET_HAS_bitsel_vec       0
 #define TCG_TARGET_HAS_cmpsel_vec       1
 
-- 
2.43.0


