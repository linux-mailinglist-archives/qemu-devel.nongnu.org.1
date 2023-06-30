Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8174367B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:06:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92k-0008JE-Tk; Fri, 30 Jun 2023 03:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92X-0008Bq-IM
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92U-00080O-E4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:36 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTcdai55kijQEAA--.6764S3;
 Fri, 30 Jun 2023 15:59:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S25; 
 Fri, 30 Jun 2023 15:59:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 23/46] target/loognarch: Implement xvldi
Date: Fri, 30 Jun 2023 15:58:41 +0800
Message-Id: <20230630075904.45940-24-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S25
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
- XVLDI.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 7 +++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 2 ++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 6 ++++--
 target/loongarch/insns.decode                | 2 ++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 1a11153343..8fa2edf007 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1703,6 +1703,11 @@ static bool trans_##insn(DisasContext *ctx, arg_##type * a) \
     return true;                                            \
 }
 
+static void output_v_i_x(DisasContext *ctx, arg_v_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, 0x%x", a->vd, a->imm);
+}
+
 static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
@@ -2022,6 +2027,8 @@ INSN_LASX(xvsigncov_h,       vvv)
 INSN_LASX(xvsigncov_w,       vvv)
 INSN_LASX(xvsigncov_d,       vvv)
 
+INSN_LASX(xvldi,             v_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5ac866fa87..8e1f4c5d85 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -404,6 +404,8 @@ TRANS(xvmskltz_d, gen_vv, 32, gen_helper_vmskltz_d)
 TRANS(xvmskgez_b, gen_vv, 32, gen_helper_vmskgez_b)
 TRANS(xvmsknz_b, gen_vv, 32, gen_helper_vmsknz_b)
 
+TRANS(xvldi, do_vldi, 32)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index e8bad1c9a3..3c6f54a827 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3025,7 +3025,7 @@ static uint64_t vldi_get_value(DisasContext *ctx, uint32_t imm)
     return data;
 }
 
-static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
+static bool do_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
 {
     int sel, vece;
     uint64_t value;
@@ -3041,11 +3041,13 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
         vece = (a->imm >> 10) & 0x3;
     }
 
-    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), 16, ctx->vl/8,
+    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->vd), oprsz, ctx->vl / 8,
                          tcg_constant_i64(value));
     return true;
 }
 
+TRANS(vldi, do_vldi, 16)
+
 TRANS(vand_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_and)
 TRANS(vor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_or)
 TRANS(vxor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_xor)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 6a161d6d20..edaa756395 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1605,6 +1605,8 @@ xvmskltz_d       0111 01101001 11000 10011 ..... .....    @vv
 xvmskgez_b       0111 01101001 11000 10100 ..... .....    @vv
 xvmsknz_b        0111 01101001 11000 11000 ..... .....    @vv
 
+xvldi            0111 01111110 00 ............. .....     @v_i13
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
-- 
2.39.1


