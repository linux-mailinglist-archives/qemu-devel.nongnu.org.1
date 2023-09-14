Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A179F823
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:33:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6K-0006Qs-Hc; Wed, 13 Sep 2023 22:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc5r-0004o4-M2
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:28:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc5h-0005FB-Sg
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:28:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxyep1bwJld_gmAA--.447S3;
 Thu, 14 Sep 2023 10:27:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S18; 
 Thu, 14 Sep 2023 10:27:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 16/57] target/loongarch: Implement xvaddi/xvsubi
Date: Thu, 14 Sep 2023 10:26:04 +0800
Message-Id: <20230914022645.1151356-17-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S18
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
- XVADDI.{B/H/W/D}U;
- XVSUBI.{B/H/W/D}U.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  9 ++++++
 target/loongarch/disas.c                    | 14 ++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 36 ++++++++++++++++-----
 3 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 04bd238995..c48dca70b8 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1311,6 +1311,15 @@ xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
 xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
 xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
 
+xvaddi_bu        0111 01101000 10100 ..... ..... .....    @vv_ui5
+xvaddi_hu        0111 01101000 10101 ..... ..... .....    @vv_ui5
+xvaddi_wu        0111 01101000 10110 ..... ..... .....    @vv_ui5
+xvaddi_du        0111 01101000 10111 ..... ..... .....    @vv_ui5
+xvsubi_bu        0111 01101000 11000 ..... ..... .....    @vv_ui5
+xvsubi_hu        0111 01101000 11001 ..... ..... .....    @vv_ui5
+xvsubi_wu        0111 01101000 11010 ..... ..... .....    @vv_ui5
+xvsubi_du        0111 01101000 11011 ..... ..... .....    @vv_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index c47f455ed0..20df9c7c99 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1713,6 +1713,11 @@ static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
 }
 
+static void output_vv_i_x(DisasContext *ctx, arg_vv_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, 0x%x", a->vd, a->vj, a->imm);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -1724,6 +1729,15 @@ INSN_LASX(xvsub_w,           vvv)
 INSN_LASX(xvsub_d,           vvv)
 INSN_LASX(xvsub_q,           vvv)
 
+INSN_LASX(xvaddi_bu,         vv_i)
+INSN_LASX(xvaddi_hu,         vv_i)
+INSN_LASX(xvaddi_wu,         vv_i)
+INSN_LASX(xvaddi_du,         vv_i)
+INSN_LASX(xvsubi_bu,         vv_i)
+INSN_LASX(xvsubi_hu,         vv_i)
+INSN_LASX(xvsubi_wu,         vv_i)
+INSN_LASX(xvsubi_du,         vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 5001042870..689db12d71 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -247,6 +247,10 @@ static bool gvec_vv_i_vl(DisasContext *ctx, arg_vv_i *a,
     uint32_t vd_ofs = vec_full_offset(a->vd);
     uint32_t vj_ofs = vec_full_offset(a->vj);
 
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
     func(mop, vd_ofs, vj_ofs, a->imm, oprsz, ctx->vl / 8);
     return true;
 }
@@ -255,32 +259,40 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
                       void (*func)(unsigned, uint32_t, uint32_t,
                                    int64_t, uint32_t, uint32_t))
 {
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
     return gvec_vv_i_vl(ctx, a, 16, mop, func);
 }
 
+static bool gvec_xx_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
+                      void (*func)(unsigned, uint32_t, uint32_t,
+                                   int64_t, uint32_t, uint32_t))
+{
+    return gvec_vv_i_vl(ctx,a, 32, mop, func);
+}
+
 static bool gvec_subi_vl(DisasContext *ctx, arg_vv_i *a,
                          uint32_t oprsz, MemOp mop)
 {
     uint32_t vd_ofs = vec_full_offset(a->vd);
     uint32_t vj_ofs = vec_full_offset(a->vj);
 
+    if (!check_vec(ctx, oprsz)) {
+        return true;
+    }
+
     tcg_gen_gvec_addi(mop, vd_ofs, vj_ofs, -a->imm, oprsz, ctx->vl / 8);
     return true;
 }
 
 static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
 {
-    if (!check_vec(ctx, 16)) {
-        return true;
-    }
-
     return gvec_subi_vl(ctx, a, 16, mop);
 }
 
+static bool gvec_xsubi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
+{
+    return gvec_subi_vl(ctx, a, 32, mop);
+}
+
 TRANS(vadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_add)
 TRANS(vadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_add)
 TRANS(vadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_add)
@@ -358,6 +370,14 @@ TRANS(vsubi_bu, LSX, gvec_subi, MO_8)
 TRANS(vsubi_hu, LSX, gvec_subi, MO_16)
 TRANS(vsubi_wu, LSX, gvec_subi, MO_32)
 TRANS(vsubi_du, LSX, gvec_subi, MO_64)
+TRANS(xvaddi_bu, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_addi)
+TRANS(xvaddi_hu, LASX, gvec_xx_i, MO_16, tcg_gen_gvec_addi)
+TRANS(xvaddi_wu, LASX, gvec_xx_i, MO_32, tcg_gen_gvec_addi)
+TRANS(xvaddi_du, LASX, gvec_xx_i, MO_64, tcg_gen_gvec_addi)
+TRANS(xvsubi_bu, LASX, gvec_xsubi, MO_8)
+TRANS(xvsubi_hu, LASX, gvec_xsubi, MO_16)
+TRANS(xvsubi_wu, LASX, gvec_xsubi, MO_32)
+TRANS(xvsubi_du, LASX, gvec_xsubi, MO_64)
 
 TRANS(vneg_b, LSX, gvec_vv, MO_8, tcg_gen_gvec_neg)
 TRANS(vneg_h, LSX, gvec_vv, MO_16, tcg_gen_gvec_neg)
-- 
2.39.1


