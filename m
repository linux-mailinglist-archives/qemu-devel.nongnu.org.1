Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACE174367E
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:07:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92H-00086U-A8; Fri, 30 Jun 2023 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92E-000849-Jk
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92C-0007vI-15
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxGsZQi55kaTQEAA--.6786S3;
 Fri, 30 Jun 2023 15:59:12 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S9; 
 Fri, 30 Jun 2023 15:59:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 07/46] target/loongarch: Implement xvneg
Date: Fri, 30 Jun 2023 15:58:25 +0800
Message-Id: <20230630075904.45940-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S9
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
- XVNEG.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 10 ++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 +++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 12 ++++++------
 target/loongarch/insns.decode                | 10 +++++-----
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index f59e3cebf0..4e26d49acc 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1713,6 +1713,11 @@ static void output_vv_i_x(DisasContext *ctx, arg_vv_i *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, 0x%x", a->vd, a->vj, a->imm);
 }
 
+static void output_vv_x(DisasContext *ctx, arg_vv *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d", a->vd, a->vj);
+}
+
 static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
@@ -1738,6 +1743,11 @@ INSN_LASX(xvsubi_hu,         vv_i)
 INSN_LASX(xvsubi_wu,         vv_i)
 INSN_LASX(xvsubi_du,         vv_i)
 
+INSN_LASX(xvneg_b,           vv)
+INSN_LASX(xvneg_h,           vv)
+INSN_LASX(xvneg_w,           vv)
+INSN_LASX(xvneg_d,           vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 93932593a5..0c7d2bbffd 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -56,6 +56,11 @@ TRANS(xvsubi_hu, gvec_subi, 32, MO_16)
 TRANS(xvsubi_wu, gvec_subi, 32, MO_32)
 TRANS(xvsubi_du, gvec_subi, 32, MO_64)
 
+TRANS(xvneg_b, gvec_vv, 32, MO_8, tcg_gen_gvec_neg)
+TRANS(xvneg_h, gvec_vv, 32, MO_16, tcg_gen_gvec_neg)
+TRANS(xvneg_w, gvec_vv, 32, MO_32, tcg_gen_gvec_neg)
+TRANS(xvneg_d, gvec_vv, 32, MO_64, tcg_gen_gvec_neg)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index b95a2dffda..a1370b90e6 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -81,7 +81,7 @@ static bool gvec_vvv(DisasContext *ctx, arg_vvv *a, uint32_t oprsz, MemOp mop,
     return true;
 }
 
-static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
+static bool gvec_vv(DisasContext *ctx, arg_vv *a, uint32_t oprsz, MemOp mop,
                     void (*func)(unsigned, uint32_t, uint32_t,
                                  uint32_t, uint32_t))
 {
@@ -92,7 +92,7 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
 
-    func(mop, vd_ofs, vj_ofs, 16, ctx->vl/8);
+    func(mop, vd_ofs, vj_ofs, oprsz, ctx->vl / 8);
     return true;
 }
 
@@ -173,10 +173,10 @@ TRANS(vsubi_hu, gvec_subi, 16, MO_16)
 TRANS(vsubi_wu, gvec_subi, 16, MO_32)
 TRANS(vsubi_du, gvec_subi, 16, MO_64)
 
-TRANS(vneg_b, gvec_vv, MO_8, tcg_gen_gvec_neg)
-TRANS(vneg_h, gvec_vv, MO_16, tcg_gen_gvec_neg)
-TRANS(vneg_w, gvec_vv, MO_32, tcg_gen_gvec_neg)
-TRANS(vneg_d, gvec_vv, MO_64, tcg_gen_gvec_neg)
+TRANS(vneg_b, gvec_vv, 16, MO_8, tcg_gen_gvec_neg)
+TRANS(vneg_h, gvec_vv, 16, MO_16, tcg_gen_gvec_neg)
+TRANS(vneg_w, gvec_vv, 16, MO_32, tcg_gen_gvec_neg)
+TRANS(vneg_d, gvec_vv, 16, MO_64, tcg_gen_gvec_neg)
 
 TRANS(vsadd_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_ssadd)
 TRANS(vsadd_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_ssadd)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 963d0f567a..759172628f 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1311,11 +1311,6 @@ xvsub_w          0111 01000000 11010 ..... ..... .....    @vvv
 xvsub_d          0111 01000000 11011 ..... ..... .....    @vvv
 xvsub_q          0111 01010010 11011 ..... ..... .....    @vvv
 
-xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
-xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
-xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
-xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
-
 xvaddi_bu        0111 01101000 10100 ..... ..... .....    @vv_ui5
 xvaddi_hu        0111 01101000 10101 ..... ..... .....    @vv_ui5
 xvaddi_wu        0111 01101000 10110 ..... ..... .....    @vv_ui5
@@ -1325,6 +1320,11 @@ xvsubi_hu        0111 01101000 11001 ..... ..... .....    @vv_ui5
 xvsubi_wu        0111 01101000 11010 ..... ..... .....    @vv_ui5
 xvsubi_du        0111 01101000 11011 ..... ..... .....    @vv_ui5
 
+xvneg_b          0111 01101001 11000 01100 ..... .....    @vv
+xvneg_h          0111 01101001 11000 01101 ..... .....    @vv
+xvneg_w          0111 01101001 11000 01110 ..... .....    @vv
+xvneg_d          0111 01101001 11000 01111 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
-- 
2.39.1


