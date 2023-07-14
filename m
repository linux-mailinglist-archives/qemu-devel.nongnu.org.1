Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16975355A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERs-00026U-Mo; Fri, 14 Jul 2023 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERc-0001WM-45
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERW-0004n7-5F
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:30 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnutdC7FkQs4EAA--.10839S3;
 Fri, 14 Jul 2023 16:46:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S8; 
 Fri, 14 Jul 2023 16:46:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 06/47] target/loongarch: Implement xvaddi/xvsubi
Date: Fri, 14 Jul 2023 16:45:34 +0800
Message-Id: <20230714084615.2448038-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S8
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/disas.c                     |  14 ++
 target/loongarch/insn_trans/trans_lasx.c.inc |   9 ++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 136 +++++++++----------
 target/loongarch/insns.decode                |   9 ++
 4 files changed, 100 insertions(+), 68 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index c47f455ed0..f59e3cebf0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
 }
 
+static void output_vv_i_x(DisasContext *ctx, arg_vv_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, 0x%x", a->vd, a->vj, a->imm);
+}
+
 static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 9bbf6c48ec..93932593a5 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -47,6 +47,15 @@ TRANS(xvsub_h, gvec_vvv, 32, MO_16, tcg_gen_gvec_sub)
 TRANS(xvsub_w, gvec_vvv, 32, MO_32, tcg_gen_gvec_sub)
 TRANS(xvsub_d, gvec_vvv, 32, MO_64, tcg_gen_gvec_sub)
 
+TRANS(xvaddi_bu, gvec_vv_i, 32, MO_8, tcg_gen_gvec_addi)
+TRANS(xvaddi_hu, gvec_vv_i, 32, MO_16, tcg_gen_gvec_addi)
+TRANS(xvaddi_wu, gvec_vv_i, 32, MO_32, tcg_gen_gvec_addi)
+TRANS(xvaddi_du, gvec_vv_i, 32, MO_64, tcg_gen_gvec_addi)
+TRANS(xvsubi_bu, gvec_subi, 32, MO_8)
+TRANS(xvsubi_hu, gvec_subi, 32, MO_16)
+TRANS(xvsubi_wu, gvec_subi, 32, MO_32)
+TRANS(xvsubi_du, gvec_subi, 32, MO_64)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 4667dba4b4..b95a2dffda 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -96,7 +96,7 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
     return true;
 }
 
-static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
+static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz, MemOp mop,
                       void (*func)(unsigned, uint32_t, uint32_t,
                                    int64_t, uint32_t, uint32_t))
 {
@@ -107,11 +107,11 @@ static bool gvec_vv_i(DisasContext *ctx, arg_vv_i *a, MemOp mop,
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
 
-    func(mop, vd_ofs, vj_ofs, a->imm , 16, ctx->vl/8);
+    func(mop, vd_ofs, vj_ofs, a->imm, oprsz, ctx->vl / 8);
     return true;
 }
 
-static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
+static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz, MemOp mop)
 {
     uint32_t vd_ofs, vj_ofs;
 
@@ -120,7 +120,7 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     vd_ofs = vec_full_offset(a->vd);
     vj_ofs = vec_full_offset(a->vj);
 
-    tcg_gen_gvec_addi(mop, vd_ofs, vj_ofs, -a->imm, 16, ctx->vl/8);
+    tcg_gen_gvec_addi(mop, vd_ofs, vj_ofs, -a->imm, oprsz, ctx->vl / 8);
     return true;
 }
 
@@ -164,14 +164,14 @@ TRANS(vsub_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_sub)
 TRANS(vsub_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_sub)
 TRANS(vsub_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_sub)
 
-TRANS(vaddi_bu, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
-TRANS(vaddi_hu, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
-TRANS(vaddi_wu, gvec_vv_i, MO_32, tcg_gen_gvec_addi)
-TRANS(vaddi_du, gvec_vv_i, MO_64, tcg_gen_gvec_addi)
-TRANS(vsubi_bu, gvec_subi, MO_8)
-TRANS(vsubi_hu, gvec_subi, MO_16)
-TRANS(vsubi_wu, gvec_subi, MO_32)
-TRANS(vsubi_du, gvec_subi, MO_64)
+TRANS(vaddi_bu, gvec_vv_i, 16, MO_8, tcg_gen_gvec_addi)
+TRANS(vaddi_hu, gvec_vv_i, 16, MO_16, tcg_gen_gvec_addi)
+TRANS(vaddi_wu, gvec_vv_i, 16, MO_32, tcg_gen_gvec_addi)
+TRANS(vaddi_du, gvec_vv_i, 16, MO_64, tcg_gen_gvec_addi)
+TRANS(vsubi_bu, gvec_subi, 16, MO_8)
+TRANS(vsubi_hu, gvec_subi, 16, MO_16)
+TRANS(vsubi_wu, gvec_subi, 16, MO_32)
+TRANS(vsubi_du, gvec_subi, 16, MO_64)
 
 TRANS(vneg_b, gvec_vv, MO_8, tcg_gen_gvec_neg)
 TRANS(vneg_h, gvec_vv, MO_16, tcg_gen_gvec_neg)
@@ -1462,14 +1462,14 @@ static void do_vmini_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmini_b, gvec_vv_i, MO_8, do_vmini_s)
-TRANS(vmini_h, gvec_vv_i, MO_16, do_vmini_s)
-TRANS(vmini_w, gvec_vv_i, MO_32, do_vmini_s)
-TRANS(vmini_d, gvec_vv_i, MO_64, do_vmini_s)
-TRANS(vmini_bu, gvec_vv_i, MO_8, do_vmini_u)
-TRANS(vmini_hu, gvec_vv_i, MO_16, do_vmini_u)
-TRANS(vmini_wu, gvec_vv_i, MO_32, do_vmini_u)
-TRANS(vmini_du, gvec_vv_i, MO_64, do_vmini_u)
+TRANS(vmini_b, gvec_vv_i, 16, MO_8, do_vmini_s)
+TRANS(vmini_h, gvec_vv_i, 16, MO_16, do_vmini_s)
+TRANS(vmini_w, gvec_vv_i, 16, MO_32, do_vmini_s)
+TRANS(vmini_d, gvec_vv_i, 16, MO_64, do_vmini_s)
+TRANS(vmini_bu, gvec_vv_i, 16, MO_8, do_vmini_u)
+TRANS(vmini_hu, gvec_vv_i, 16, MO_16, do_vmini_u)
+TRANS(vmini_wu, gvec_vv_i, 16, MO_32, do_vmini_u)
+TRANS(vmini_du, gvec_vv_i, 16, MO_64, do_vmini_u)
 
 static void do_vmaxi_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -1543,14 +1543,14 @@ static void do_vmaxi_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmaxi_b, gvec_vv_i, MO_8, do_vmaxi_s)
-TRANS(vmaxi_h, gvec_vv_i, MO_16, do_vmaxi_s)
-TRANS(vmaxi_w, gvec_vv_i, MO_32, do_vmaxi_s)
-TRANS(vmaxi_d, gvec_vv_i, MO_64, do_vmaxi_s)
-TRANS(vmaxi_bu, gvec_vv_i, MO_8, do_vmaxi_u)
-TRANS(vmaxi_hu, gvec_vv_i, MO_16, do_vmaxi_u)
-TRANS(vmaxi_wu, gvec_vv_i, MO_32, do_vmaxi_u)
-TRANS(vmaxi_du, gvec_vv_i, MO_64, do_vmaxi_u)
+TRANS(vmaxi_b, gvec_vv_i, 16, MO_8, do_vmaxi_s)
+TRANS(vmaxi_h, gvec_vv_i, 16, MO_16, do_vmaxi_s)
+TRANS(vmaxi_w, gvec_vv_i, 16, MO_32, do_vmaxi_s)
+TRANS(vmaxi_d, gvec_vv_i, 16, MO_64, do_vmaxi_s)
+TRANS(vmaxi_bu, gvec_vv_i, 16, MO_8, do_vmaxi_u)
+TRANS(vmaxi_hu, gvec_vv_i, 16, MO_16, do_vmaxi_u)
+TRANS(vmaxi_wu, gvec_vv_i, 16, MO_32, do_vmaxi_u)
+TRANS(vmaxi_du, gvec_vv_i, 16, MO_64, do_vmaxi_u)
 
 TRANS(vmul_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_mul)
 TRANS(vmul_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_mul)
@@ -2778,10 +2778,10 @@ static void do_vsat_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64((1ll<< imm) -1), &op[vece]);
 }
 
-TRANS(vsat_b, gvec_vv_i, MO_8, do_vsat_s)
-TRANS(vsat_h, gvec_vv_i, MO_16, do_vsat_s)
-TRANS(vsat_w, gvec_vv_i, MO_32, do_vsat_s)
-TRANS(vsat_d, gvec_vv_i, MO_64, do_vsat_s)
+TRANS(vsat_b, gvec_vv_i, 16, MO_8, do_vsat_s)
+TRANS(vsat_h, gvec_vv_i, 16, MO_16, do_vsat_s)
+TRANS(vsat_w, gvec_vv_i, 16, MO_32, do_vsat_s)
+TRANS(vsat_d, gvec_vv_i, 16, MO_64, do_vsat_s)
 
 static void gen_vsat_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -2827,10 +2827,10 @@ static void do_vsat_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64(max), &op[vece]);
 }
 
-TRANS(vsat_bu, gvec_vv_i, MO_8, do_vsat_u)
-TRANS(vsat_hu, gvec_vv_i, MO_16, do_vsat_u)
-TRANS(vsat_wu, gvec_vv_i, MO_32, do_vsat_u)
-TRANS(vsat_du, gvec_vv_i, MO_64, do_vsat_u)
+TRANS(vsat_bu, gvec_vv_i, 16, MO_8, do_vsat_u)
+TRANS(vsat_hu, gvec_vv_i, 16, MO_16, do_vsat_u)
+TRANS(vsat_wu, gvec_vv_i, 16, MO_32, do_vsat_u)
+TRANS(vsat_du, gvec_vv_i, 16, MO_64, do_vsat_u)
 
 TRANS(vexth_h_b, gen_vv, gen_helper_vexth_h_b)
 TRANS(vexth_w_h, gen_vv, gen_helper_vexth_w_h)
@@ -3057,9 +3057,9 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     return true;
 }
 TRANS(vorn_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_orc)
-TRANS(vandi_b, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
-TRANS(vori_b, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
-TRANS(vxori_b, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
+TRANS(vandi_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_andi)
+TRANS(vori_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_ori)
+TRANS(vxori_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_xori)
 
 static void gen_vnori(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -3092,43 +3092,43 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op);
 }
 
-TRANS(vnori_b, gvec_vv_i, MO_8, do_vnori_b)
+TRANS(vnori_b, gvec_vv_i, 16, MO_8, do_vnori_b)
 
 TRANS(vsll_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_shlv)
 TRANS(vsll_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_shlv)
 TRANS(vsll_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_shlv)
 TRANS(vsll_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_shlv)
-TRANS(vslli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
-TRANS(vslli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
-TRANS(vslli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
-TRANS(vslli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
+TRANS(vslli_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_shli)
+TRANS(vslli_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_shli)
+TRANS(vslli_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_shli)
+TRANS(vslli_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_shli)
 
 TRANS(vsrl_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_shrv)
 TRANS(vsrl_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_shrv)
 TRANS(vsrl_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_shrv)
 TRANS(vsrl_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_shrv)
-TRANS(vsrli_b, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
-TRANS(vsrli_h, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
-TRANS(vsrli_w, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
-TRANS(vsrli_d, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
+TRANS(vsrli_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_shri)
+TRANS(vsrli_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_shri)
+TRANS(vsrli_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_shri)
+TRANS(vsrli_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_shri)
 
 TRANS(vsra_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_sarv)
 TRANS(vsra_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_sarv)
 TRANS(vsra_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_sarv)
 TRANS(vsra_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_sarv)
-TRANS(vsrai_b, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
-TRANS(vsrai_h, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
-TRANS(vsrai_w, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
-TRANS(vsrai_d, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
+TRANS(vsrai_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_sari)
+TRANS(vsrai_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_sari)
+TRANS(vsrai_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_sari)
+TRANS(vsrai_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_sari)
 
 TRANS(vrotr_b, gvec_vvv, 16, MO_8, tcg_gen_gvec_rotrv)
 TRANS(vrotr_h, gvec_vvv, 16, MO_16, tcg_gen_gvec_rotrv)
 TRANS(vrotr_w, gvec_vvv, 16, MO_32, tcg_gen_gvec_rotrv)
 TRANS(vrotr_d, gvec_vvv, 16, MO_64, tcg_gen_gvec_rotrv)
-TRANS(vrotri_b, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
-TRANS(vrotri_h, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
-TRANS(vrotri_w, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
-TRANS(vrotri_d, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
+TRANS(vrotri_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_rotri)
+TRANS(vrotri_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_rotri)
+TRANS(vrotri_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_rotri)
+TRANS(vrotri_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_rotri)
 
 TRANS(vsllwil_h_b, gen_vv_i, gen_helper_vsllwil_h_b)
 TRANS(vsllwil_w_h, gen_vv_i, gen_helper_vsllwil_w_h)
@@ -3399,10 +3399,10 @@ static void do_vbitclri(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitclri_b, gvec_vv_i, MO_8, do_vbitclri)
-TRANS(vbitclri_h, gvec_vv_i, MO_16, do_vbitclri)
-TRANS(vbitclri_w, gvec_vv_i, MO_32, do_vbitclri)
-TRANS(vbitclri_d, gvec_vv_i, MO_64, do_vbitclri)
+TRANS(vbitclri_b, gvec_vv_i, 16, MO_8, do_vbitclri)
+TRANS(vbitclri_h, gvec_vv_i, 16, MO_16, do_vbitclri)
+TRANS(vbitclri_w, gvec_vv_i, 16, MO_32, do_vbitclri)
+TRANS(vbitclri_d, gvec_vv_i, 16, MO_64, do_vbitclri)
 
 static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3481,10 +3481,10 @@ static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitseti_b, gvec_vv_i, MO_8, do_vbitseti)
-TRANS(vbitseti_h, gvec_vv_i, MO_16, do_vbitseti)
-TRANS(vbitseti_w, gvec_vv_i, MO_32, do_vbitseti)
-TRANS(vbitseti_d, gvec_vv_i, MO_64, do_vbitseti)
+TRANS(vbitseti_b, gvec_vv_i, 16, MO_8, do_vbitseti)
+TRANS(vbitseti_h, gvec_vv_i, 16, MO_16, do_vbitseti)
+TRANS(vbitseti_w, gvec_vv_i, 16, MO_32, do_vbitseti)
+TRANS(vbitseti_d, gvec_vv_i, 16, MO_64, do_vbitseti)
 
 static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3563,10 +3563,10 @@ static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitrevi_b, gvec_vv_i, MO_8, do_vbitrevi)
-TRANS(vbitrevi_h, gvec_vv_i, MO_16, do_vbitrevi)
-TRANS(vbitrevi_w, gvec_vv_i, MO_32, do_vbitrevi)
-TRANS(vbitrevi_d, gvec_vv_i, MO_64, do_vbitrevi)
+TRANS(vbitrevi_b, gvec_vv_i, 16, MO_8, do_vbitrevi)
+TRANS(vbitrevi_h, gvec_vv_i, 16, MO_16, do_vbitrevi)
+TRANS(vbitrevi_w, gvec_vv_i, 16, MO_32, do_vbitrevi)
+TRANS(vbitrevi_d, gvec_vv_i, 16, MO_64, do_vbitrevi)
 
 TRANS(vfrstp_b, gen_vvv, gen_helper_vfrstp_b)
 TRANS(vfrstp_h, gen_vvv, gen_helper_vfrstp_h)
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
-- 
2.39.1


