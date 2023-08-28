Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F69678B44B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 17:21:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qae2w-0005sX-N5; Mon, 28 Aug 2023 11:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2p-0005bY-Hv
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:49 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qae2m-0007Pc-V0
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 11:20:47 -0400
Received: from ls3a6000.. (unknown [223.72.44.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 6848C441AD;
 Mon, 28 Aug 2023 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1693236037; bh=2iGgi9Jgkkl5DitnRjr9xytPqDoY93M/WN+8WFCG0xY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HrtsQHqbtmOKoXOe5wI/K3FNbuQIZ7+IFkr2ImA0PHX8mnh+lSnir77m3oRgSGYid
 As4q+8RmnAYgqhxMdzB/quz27sipFUBdvD1wNklZ7t+XLwI/4LCN7RLwV6huPYyz5n
 arYRbD6prrri32Z+pxKLLP66XsT3qHpLCMT43iPY=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, gaosong@loongson.cn, Jiajie Chen <c@jia.je>,
 WANG Xuerui <git@xen0n.name>
Subject: [PATCH 04/11] tcg/loongarch64: Lower add/sub_vec to vadd/vsub
Date: Mon, 28 Aug 2023 23:19:42 +0800
Message-ID: <20230828152009.352048-5-c@jia.je>
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

- add_vec
- sub_vec

Signed-off-by: Jiajie Chen <c@jia.je>
---
 tcg/loongarch64/tcg-target.c.inc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index cc80e5fa20..eb340a6493 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1632,6 +1632,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         [TCG_COND_LTU] = {OPC_VSLT_BU, OPC_VSLT_HU, OPC_VSLT_WU, OPC_VSLT_DU},
     };
     LoongArchInsn insn;
+    static const LoongArchInsn add_vec_insn[4] = {
+        OPC_VADD_B, OPC_VADD_H, OPC_VADD_W, OPC_VADD_D
+    };
+    static const LoongArchInsn sub_vec_insn[4] = {
+        OPC_VSUB_B, OPC_VSUB_H, OPC_VSUB_W, OPC_VSUB_D
+    };
 
     a0 = args[0];
     a1 = args[1];
@@ -1677,6 +1683,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         }
         tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
+    case INDEX_op_add_vec:
+        tcg_out32(s, encode_vdvjvk_insn(add_vec_insn[vece], a0, a1, a2));
+        break;
+    case INDEX_op_sub_vec:
+        tcg_out32(s, encode_vdvjvk_insn(sub_vec_insn[vece], a0, a1, a2));
+        break;
     case INDEX_op_dupm_vec:
         tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
         break;
@@ -1693,6 +1705,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     case INDEX_op_dup_vec:
     case INDEX_op_dupm_vec:
     case INDEX_op_cmp_vec:
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
         return 1;
     default:
         return 0;
@@ -1855,6 +1869,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
         return C_O0_I2(w, r);
 
     case INDEX_op_cmp_vec:
+    case INDEX_op_add_vec:
+    case INDEX_op_sub_vec:
         return C_O1_I2(w, w, w);
 
     default:
-- 
2.42.0


