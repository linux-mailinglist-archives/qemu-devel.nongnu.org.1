Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC4736827
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXon-00073z-63; Tue, 20 Jun 2023 05:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXoh-00071r-Db
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXod-0006HE-Eg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax0OiKc5FkjCUHAA--.12762S3;
 Tue, 20 Jun 2023 17:38:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S8; 
 Tue, 20 Jun 2023 17:38:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 06/46] target/loongarch: Implement xvaddi/xvsubi
Date: Tue, 20 Jun 2023 17:37:34 +0800
Message-Id: <20230620093814.123650-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S8
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
- XVADDI.{B/H/W/D}U;
- XVSUBI.{B/H/W/D}U.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 14 ++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 37 ++++++++++++++++++++
 target/loongarch/insns.decode                | 12 ++++++-
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 78e1fd19ac..7b84766fa8 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_xxx(DisasContext *ctx, arg_xxx * a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, x%d", a->xd, a->xj, a->xk);
 }
 
+static void output_xx_i(DisasContext *ctx, arg_xx_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, 0x%x", a->xd, a->xj, a->imm);
+}
+
 static void output_xr(DisasContext *ctx, arg_xr *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, r%d", a->xd, a->rj);
@@ -1724,6 +1729,15 @@ INSN_LASX(xvsub_w,           xxx)
 INSN_LASX(xvsub_d,           xxx)
 INSN_LASX(xvsub_q,           xxx)
 
+INSN_LASX(xvaddi_bu,         xx_i)
+INSN_LASX(xvaddi_hu,         xx_i)
+INSN_LASX(xvaddi_wu,         xx_i)
+INSN_LASX(xvaddi_du,         xx_i)
+INSN_LASX(xvsubi_bu,         xx_i)
+INSN_LASX(xvsubi_hu,         xx_i)
+INSN_LASX(xvsubi_wu,         xx_i)
+INSN_LASX(xvsubi_du,         xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index d394a4f40a..a42e92f930 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -31,6 +31,34 @@ static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
     return true;
 }
 
+static bool gvec_xx_i(DisasContext *ctx, arg_xx_i *a, MemOp mop,
+                      void (*func)(unsigned, uint32_t, uint32_t,
+                                   int64_t, uint32_t, uint32_t))
+{
+    uint32_t xd_ofs, xj_ofs;
+
+    CHECK_ASXE;
+
+    xd_ofs = vec_full_offset(a->xd);
+    xj_ofs = vec_full_offset(a->xj);
+
+    func(mop, xd_ofs, xj_ofs, a->imm , 32, ctx->vl / 8);
+    return true;
+}
+
+static bool gvec_xsubi(DisasContext *ctx, arg_xx_i *a, MemOp mop)
+{
+    uint32_t xd_ofs, xj_ofs;
+
+    CHECK_ASXE;
+
+    xd_ofs = vec_full_offset(a->xd);
+    xj_ofs = vec_full_offset(a->xj);
+
+    tcg_gen_gvec_addi(mop, xd_ofs, xj_ofs, -a->imm, 32, ctx->vl / 8);
+    return true;
+}
+
 TRANS(xvadd_b, gvec_xxx, MO_8, tcg_gen_gvec_add)
 TRANS(xvadd_h, gvec_xxx, MO_16, tcg_gen_gvec_add)
 TRANS(xvadd_w, gvec_xxx, MO_32, tcg_gen_gvec_add)
@@ -74,6 +102,15 @@ TRANS(xvsub_h, gvec_xxx, MO_16, tcg_gen_gvec_sub)
 TRANS(xvsub_w, gvec_xxx, MO_32, tcg_gen_gvec_sub)
 TRANS(xvsub_d, gvec_xxx, MO_64, tcg_gen_gvec_sub)
 
+TRANS(xvaddi_bu, gvec_xx_i, MO_8, tcg_gen_gvec_addi)
+TRANS(xvaddi_hu, gvec_xx_i, MO_16, tcg_gen_gvec_addi)
+TRANS(xvaddi_wu, gvec_xx_i, MO_32, tcg_gen_gvec_addi)
+TRANS(xvaddi_du, gvec_xx_i, MO_64, tcg_gen_gvec_addi)
+TRANS(xvsubi_bu, gvec_xsubi, MO_8)
+TRANS(xvsubi_hu, gvec_xsubi, MO_16)
+TRANS(xvsubi_wu, gvec_xsubi, MO_32)
+TRANS(xvsubi_du, gvec_xsubi, MO_64)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 2eab7f6a98..0bed748216 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1303,7 +1303,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 
 &xxx          xd xj xk
 &xr           xd rj
-
+&xx_i         xd xj imm
 
 #
 # LASX Formats
@@ -1311,6 +1311,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 
 @xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
 @xr                .... ........ ..... ..... rj:5 xd:5    &xr
+@xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1323,6 +1324,15 @@ xvsub_w          0111 01000000 11010 ..... ..... .....    @xxx
 xvsub_d          0111 01000000 11011 ..... ..... .....    @xxx
 xvsub_q          0111 01010010 11011 ..... ..... .....    @xxx
 
+xvaddi_bu        0111 01101000 10100 ..... ..... .....    @xx_ui5
+xvaddi_hu        0111 01101000 10101 ..... ..... .....    @xx_ui5
+xvaddi_wu        0111 01101000 10110 ..... ..... .....    @xx_ui5
+xvaddi_du        0111 01101000 10111 ..... ..... .....    @xx_ui5
+xvsubi_bu        0111 01101000 11000 ..... ..... .....    @xx_ui5
+xvsubi_hu        0111 01101000 11001 ..... ..... .....    @xx_ui5
+xvsubi_wu        0111 01101000 11010 ..... ..... .....    @xx_ui5
+xvsubi_du        0111 01101000 11011 ..... ..... .....    @xx_ui5
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
-- 
2.39.1


