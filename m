Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D65187970F2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:41:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARH-0003qn-Ug; Thu, 07 Sep 2023 04:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARC-0003lQ-UH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARA-0002JL-74
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:30 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxc_CPivlk+DghAA--.901S3;
 Thu, 07 Sep 2023 16:32:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S17; 
 Thu, 07 Sep 2023 16:32:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 15/57] target/loongarch: Implement xvreplgr2vr
Date: Thu,  7 Sep 2023 16:31:16 +0800
Message-Id: <20230907083158.3975132-16-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S17
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

This patch includes:
- XVREPLGR2VR.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  5 ++++
 target/loongarch/disas.c                    | 10 +++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 29 ++++++++++++++++-----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index bcc18fb6c5..04bd238995 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1310,3 +1310,8 @@ xvsub_h          0111 01000000 11001 ..... ..... .....    @vvv
 xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
 xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
 xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
+
+xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
+xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
+xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
+xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d8b62ba532..c47f455ed0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
 }
 
+static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -1718,3 +1723,8 @@ INSN_LASX(xvsub_h,           vvv)
 INSN_LASX(xvsub_w,           vvv)
 INSN_LASX(xvsub_d,           vvv)
 INSN_LASX(xvsub_q,           vvv)
+
+INSN_LASX(xvreplgr2vr_b,     vr)
+INSN_LASX(xvreplgr2vr_h,     vr)
+INSN_LASX(xvreplgr2vr_w,     vr)
+INSN_LASX(xvreplgr2vr_d,     vr)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 47cf053e0a..a7323e0490 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4407,27 +4407,42 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
     return true;
 }
 
-static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
+static bool gvec_dup_vl(DisasContext *ctx, arg_vr *a,
+                        uint32_t oprsz, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
+    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
+                         oprsz, ctx->vl/8, src);
+    return true;
+}
 
+static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
+{
     if (!check_vec(ctx, 16)) {
         return true;
     }
 
-    tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
-                         16, ctx->vl/8, src);
-    return true;
+    return gvec_dup_vl(ctx, a, 16, mop);
+}
+
+static bool gvec_dupx(DisasContext *ctx, arg_vr *a, MemOp mop)
+{
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    return gvec_dup_vl(ctx, a, 32, mop);
 }
 
 TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
 TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
 TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
 TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
+TRANS(xvreplgr2vr_b, LASX, gvec_dupx, MO_8)
+TRANS(xvreplgr2vr_h, LASX, gvec_dupx, MO_16)
+TRANS(xvreplgr2vr_w, LASX, gvec_dupx, MO_32)
+TRANS(xvreplgr2vr_d, LASX, gvec_dupx, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
-- 
2.39.1


