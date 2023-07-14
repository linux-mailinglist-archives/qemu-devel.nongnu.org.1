Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37C753576
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES4-0003JE-Kc; Fri, 14 Jul 2023 04:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERs-0002Dt-T9
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:48 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERq-0004pe-H6
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:48 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_FoC7Fkhs4EAA--.13574S3;
 Fri, 14 Jul 2023 16:46:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S27; 
 Fri, 14 Jul 2023 16:46:31 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 25/47] target/loongarch: Implement LASX logic instructions
Date: Fri, 14 Jul 2023 16:45:53 +0800
Message-Id: <20230714084615.2448038-26-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S27
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
- XV{AND/OR/XOR/NOR/ANDN/ORN}.V;
- XV{AND/OR/XOR/NOR}I.B.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 12 ++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 11 +++++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc  |  5 +++--
 target/loongarch/insns.decode                | 12 ++++++++++++
 target/loongarch/vec_helper.c                |  4 ++--
 5 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 8fa2edf007..59fa249bae 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2029,6 +2029,18 @@ INSN_LASX(xvsigncov_d,       vvv)
 
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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 5e130f9c2e..31967b371c 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -349,6 +349,17 @@ TRANS(xvmsknz_b, gen_vv, 32, gen_helper_vmsknz_b)
 
 TRANS(xvldi, do_vldi, 32)
 
+TRANS(xvand_v, gvec_vvv, 32, MO_64, tcg_gen_gvec_and)
+TRANS(xvor_v, gvec_vvv, 32, MO_64, tcg_gen_gvec_or)
+TRANS(xvxor_v, gvec_vvv, 32, MO_64, tcg_gen_gvec_xor)
+TRANS(xvnor_v, gvec_vvv, 32, MO_64, tcg_gen_gvec_nor)
+TRANS(xvandn_v, do_vandn_v, 32)
+TRANS(xvorn_v, gvec_vvv, 32, MO_64, tcg_gen_gvec_orc)
+TRANS(xvandi_b, gvec_vv_i, 32, MO_8, tcg_gen_gvec_andi)
+TRANS(xvori_b, gvec_vv_i, 32, MO_8, tcg_gen_gvec_ori)
+TRANS(xvxori_b, gvec_vv_i, 32, MO_8, tcg_gen_gvec_xori)
+TRANS(xvnori_b, gvec_vv_i, 32, MO_8, do_vnori_b)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 34811720cf..1e2963446b 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -3092,7 +3092,7 @@ TRANS(vor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_or)
 TRANS(vxor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_xor)
 TRANS(vnor_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_nor)
 
-static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
+static bool do_vandn_v(DisasContext *ctx, arg_vvv *a, uint32_t oprsz)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
@@ -3102,9 +3102,10 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     vj_ofs = vec_full_offset(a->vj);
     vk_ofs = vec_full_offset(a->vk);
 
-    tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
+    tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, oprsz, ctx->vl / 8);
     return true;
 }
+TRANS(vandn_v, do_vandn_v, 16)
 TRANS(vorn_v, gvec_vvv, 16, MO_64, tcg_gen_gvec_orc)
 TRANS(vandi_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_andi)
 TRANS(vori_b, gvec_vv_i, 16, MO_8, tcg_gen_gvec_ori)
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 9d13b6544c..96c9a243e1 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -914,13 +914,13 @@ void HELPER(vmsknz_b)(void *vd, void *vj, uint32_t desc)
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
-- 
2.39.1


