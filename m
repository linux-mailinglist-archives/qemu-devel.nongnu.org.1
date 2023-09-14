Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B11D79F82E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:34:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc6b-0000a3-7B; Wed, 13 Sep 2023 22:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc6Y-0000KG-5t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:29:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc6V-0005Nl-Tj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:29:17 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnuuBbwJlnPgmAA--.7687S3;
 Thu, 14 Sep 2023 10:27:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S36; 
 Thu, 14 Sep 2023 10:27:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 34/57] target/loongarch: Implement LASX logic instructions
Date: Thu, 14 Sep 2023 10:26:22 +0800
Message-Id: <20230914022645.1151356-35-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S36
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
- XV{AND/OR/XOR/NOR/ANDN/ORN}.V;
- XV{AND/OR/XOR/NOR}I.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               | 12 +++++++
 target/loongarch/disas.c                    | 12 +++++++
 target/loongarch/vec_helper.c               |  4 +--
 target/loongarch/insn_trans/trans_vec.c.inc | 38 ++++++++++++---------
 4 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index edaa756395..fb28666577 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1607,6 +1607,18 @@ xvmsknz_b        0111 01101001 11000 11000 ..... .....    @vv
 
 xvldi            0111 01111110 00 ............. .....     @v_i13
 
+xvand_v          0111 01010010 01100 ..... ..... .....    @vvv
+xvor_v           0111 01010010 01101 ..... ..... .....    @vvv
+xvxor_v          0111 01010010 01110 ..... ..... .....    @vvv
+xvnor_v          0111 01010010 01111 ..... ..... .....    @vvv
+xvandn_v         0111 01010010 10000 ..... ..... .....    @vvv
+xvorn_v          0111 01010010 10001 ..... ..... .....    @vvv
+
+xvandi_b         0111 01111101 00 ........ ..... .....    @vv_ui8
+xvori_b          0111 01111101 01 ........ ..... .....    @vv_ui8
+xvxori_b         0111 01111101 10 ........ ..... .....    @vv_ui8
+xvnori_b         0111 01111101 11 ........ ..... .....    @vv_ui8
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3f6fbeddd7..e9adc017db 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2029,6 +2029,18 @@ INSN_LASX(xvmsknz_b,         vv)
 
 INSN_LASX(xvldi,             v_i)
 
+INSN_LASX(xvand_v,           vvv)
+INSN_LASX(xvor_v,            vvv)
+INSN_LASX(xvxor_v,           vvv)
+INSN_LASX(xvnor_v,           vvv)
+INSN_LASX(xvandn_v,          vvv)
+INSN_LASX(xvorn_v,           vvv)
+
+INSN_LASX(xvandi_b,          vv_i)
+INSN_LASX(xvori_b,           vv_i)
+INSN_LASX(xvxori_b,          vv_i)
+INSN_LASX(xvnori_b,          vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index f749800880..1a602ee548 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -941,13 +941,13 @@ void HELPER(vmsknz_b)(void *vd, void *vj, uint32_t desc)
     }
 }
 
-void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t v)
+void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
 
-    for (i = 0; i < LSX_LEN/8; i++) {
+    for (i = 0; i < simd_oprsz(desc); i++) {
         Vd->B(i) = ~(Vj->B(i) | (uint8_t)imm);
     }
 }
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 7ebe971ad9..5b14d0f894 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3573,20 +3573,11 @@ static bool gen_vldi(DisasContext *ctx, arg_vldi *a, uint32_t oprsz)
 TRANS(vldi, LSX, gen_vldi, 16)
 TRANS(xvldi, LASX, gen_vldi, 32)
 
-TRANS(vand_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_and)
-TRANS(vor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_or)
-TRANS(vxor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_xor)
-TRANS(vnor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_nor)
-
-static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
+static bool gen_vandn_v(DisasContext *ctx, arg_vvv *a, uint32_t oprsz)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
-    if (!avail_LSX(ctx)) {
-        return false;
-    }
-
-    if (!check_vec(ctx, 16)) {
+    if (!check_vec(ctx, oprsz)) {
         return true;
     }
 
@@ -3594,13 +3585,9 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     vj_ofs = vec_full_offset(a->vj);
     vk_ofs = vec_full_offset(a->vk);
 
-    tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
+    tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, oprsz, ctx->vl / 8);
     return true;
 }
-TRANS(vorn_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_orc)
-TRANS(vandi_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
-TRANS(vori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
-TRANS(vxori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
 
 static void gen_vnori(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -3633,7 +3620,26 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op);
 }
 
+TRANS(vand_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_and)
+TRANS(vor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_or)
+TRANS(vxor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_xor)
+TRANS(vnor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_nor)
+TRANS(vandn_v, LSX, gen_vandn_v, 16)
+TRANS(vorn_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_orc)
+TRANS(vandi_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
+TRANS(vori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
+TRANS(vxori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
 TRANS(vnori_b, LSX, gvec_vv_i, MO_8, do_vnori_b)
+TRANS(xvand_v, LASX, gvec_xxx, MO_64, tcg_gen_gvec_and)
+TRANS(xvor_v, LASX, gvec_xxx, MO_64, tcg_gen_gvec_or)
+TRANS(xvxor_v, LASX, gvec_xxx, MO_64, tcg_gen_gvec_xor)
+TRANS(xvnor_v, LASX, gvec_xxx, MO_64, tcg_gen_gvec_nor)
+TRANS(xvandn_v, LASX, gen_vandn_v, 32)
+TRANS(xvorn_v, LASX, gvec_xxx, MO_64, tcg_gen_gvec_orc)
+TRANS(xvandi_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_andi)
+TRANS(xvori_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_ori)
+TRANS(xvxori_b, LASX, gvec_xx_i, MO_8, tcg_gen_gvec_xori)
+TRANS(xvnori_b, LASX, gvec_xx_i, MO_8, do_vnori_b)
 
 TRANS(vsll_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
 TRANS(vsll_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
-- 
2.39.1


