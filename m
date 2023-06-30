Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B674367C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92k-0008JD-Ts; Fri, 30 Jun 2023 03:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92Z-0008CV-NW
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92V-00080w-Sd
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:39 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxycVbi55kkDQEAA--.6677S3;
 Fri, 30 Jun 2023 15:59:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S28; 
 Fri, 30 Jun 2023 15:59:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 26/46] target/loongarch: Implement xvsllwil xvextl
Date: Fri, 30 Jun 2023 15:58:44 +0800
Message-Id: <20230630075904.45940-27-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S28
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
- XVSLLWIL.{H.B/W.H/D.W};
- XVSLLWIL.{HU.BU/WU.HU/DU.WU};
- XVEXTL.Q.D, VEXTL.QU.DU.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |   9 ++
 target/loongarch/helper.h                    |  16 +-
 target/loongarch/insn_trans/trans_lasx.c.inc |   9 ++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 155 ++++++++++---------
 target/loongarch/insns.decode                |   9 ++
 target/loongarch/vec_helper.c                |  58 ++++---
 6 files changed, 151 insertions(+), 105 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e081a11aba..93c205fa32 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2077,6 +2077,15 @@ INSN_LASX(xvrotri_h,         vv_i)
 INSN_LASX(xvrotri_w,         vv_i)
 INSN_LASX(xvrotri_d,         vv_i)
 
+INSN_LASX(xvsllwil_h_b,      vv_i)
+INSN_LASX(xvsllwil_w_h,      vv_i)
+INSN_LASX(xvsllwil_d_w,      vv_i)
+INSN_LASX(xvextl_q_d,        vv)
+INSN_LASX(xvsllwil_hu_bu,    vv_i)
+INSN_LASX(xvsllwil_wu_hu,    vv_i)
+INSN_LASX(xvsllwil_du_wu,    vv_i)
+INSN_LASX(xvextl_qu_du,      vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 33bf60e82d..81c3ad4cc0 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -366,14 +366,14 @@ DEF_HELPER_4(vmsknz_b, void, env, i32, i32,i32)
 
 DEF_HELPER_FLAGS_4(vnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vsllwil_h_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_w_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_d_w, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_q_d, void, env, i32, i32)
-DEF_HELPER_4(vsllwil_hu_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_wu_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_du_wu, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_qu_du, void, env, i32, i32)
+DEF_HELPER_5(vsllwil_h_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsllwil_w_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsllwil_d_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(vextl_q_d, void, env, i32, i32, i32)
+DEF_HELPER_5(vsllwil_hu_bu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsllwil_wu_hu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vsllwil_du_wu, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(vextl_qu_du, void, env, i32, i32, i32)
 
 DEF_HELPER_4(vsrlr_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlr_h, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index b275d95174..497940b6fd 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -453,6 +453,15 @@ TRANS(xvrotri_h, gvec_vv_i, 32, MO_16, tcg_gen_gvec_rotri)
 TRANS(xvrotri_w, gvec_vv_i, 32, MO_32, tcg_gen_gvec_rotri)
 TRANS(xvrotri_d, gvec_vv_i, 32, MO_64, tcg_gen_gvec_rotri)
 
+TRANS(xvsllwil_h_b, gen_vv_i, 32, gen_helper_vsllwil_h_b)
+TRANS(xvsllwil_w_h, gen_vv_i, 32, gen_helper_vsllwil_w_h)
+TRANS(xvsllwil_d_w, gen_vv_i, 32, gen_helper_vsllwil_d_w)
+TRANS(xvextl_q_d, gen_vv, 32, gen_helper_vextl_q_d)
+TRANS(xvsllwil_hu_bu, gen_vv_i, 32, gen_helper_vsllwil_hu_bu)
+TRANS(xvsllwil_wu_hu, gen_vv_i, 32, gen_helper_vsllwil_wu_hu)
+TRANS(xvsllwil_du_wu, gen_vv_i, 32, gen_helper_vsllwil_du_wu)
+TRANS(xvextl_qu_du, gen_vv, 32, gen_helper_vextl_qu_du)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index a7c61e0de0..27fcadd1d4 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -46,15 +46,18 @@ static bool gen_vv(DisasContext *ctx, arg_vv *a, uint32_t sz,
     return true;
 }
 
-static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
-                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a, uint32_t sz,
+                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
+                                  TCGv_i32, TCGv_i32))
 {
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 imm = tcg_constant_i32(a->imm);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
     CHECK_VEC;
-    func(cpu_env, vd, vj, imm);
+
+    func(cpu_env, oprsz, vd, vj, imm);
     return true;
 }
 
@@ -3141,32 +3144,32 @@ TRANS(vrotri_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_rotri)
 TRANS(vrotri_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_rotri)
 TRANS(vrotri_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_rotri)
 
-TRANS(vsllwil_h_b, gen_vv_i, gen_helper_vsllwil_h_b)
-TRANS(vsllwil_w_h, gen_vv_i, gen_helper_vsllwil_w_h)
-TRANS(vsllwil_d_w, gen_vv_i, gen_helper_vsllwil_d_w)
+TRANS(vsllwil_h_b, gen_vv_i, 16, gen_helper_vsllwil_h_b)
+TRANS(vsllwil_w_h, gen_vv_i, 16, gen_helper_vsllwil_w_h)
+TRANS(vsllwil_d_w, gen_vv_i, 16, gen_helper_vsllwil_d_w)
 TRANS(vextl_q_d, gen_vv, 16, gen_helper_vextl_q_d)
-TRANS(vsllwil_hu_bu, gen_vv_i, gen_helper_vsllwil_hu_bu)
-TRANS(vsllwil_wu_hu, gen_vv_i, gen_helper_vsllwil_wu_hu)
-TRANS(vsllwil_du_wu, gen_vv_i, gen_helper_vsllwil_du_wu)
+TRANS(vsllwil_hu_bu, gen_vv_i, 16, gen_helper_vsllwil_hu_bu)
+TRANS(vsllwil_wu_hu, gen_vv_i, 16, gen_helper_vsllwil_wu_hu)
+TRANS(vsllwil_du_wu, gen_vv_i, 16, gen_helper_vsllwil_du_wu)
 TRANS(vextl_qu_du, gen_vv, 16, gen_helper_vextl_qu_du)
 
 TRANS(vsrlr_b, gen_vvv, 16, gen_helper_vsrlr_b)
 TRANS(vsrlr_h, gen_vvv, 16, gen_helper_vsrlr_h)
 TRANS(vsrlr_w, gen_vvv, 16, gen_helper_vsrlr_w)
 TRANS(vsrlr_d, gen_vvv, 16, gen_helper_vsrlr_d)
-TRANS(vsrlri_b, gen_vv_i, gen_helper_vsrlri_b)
-TRANS(vsrlri_h, gen_vv_i, gen_helper_vsrlri_h)
-TRANS(vsrlri_w, gen_vv_i, gen_helper_vsrlri_w)
-TRANS(vsrlri_d, gen_vv_i, gen_helper_vsrlri_d)
+TRANS(vsrlri_b, gen_vv_i, 16, gen_helper_vsrlri_b)
+TRANS(vsrlri_h, gen_vv_i, 16, gen_helper_vsrlri_h)
+TRANS(vsrlri_w, gen_vv_i, 16, gen_helper_vsrlri_w)
+TRANS(vsrlri_d, gen_vv_i, 16, gen_helper_vsrlri_d)
 
 TRANS(vsrar_b, gen_vvv, 16, gen_helper_vsrar_b)
 TRANS(vsrar_h, gen_vvv, 16, gen_helper_vsrar_h)
 TRANS(vsrar_w, gen_vvv, 16, gen_helper_vsrar_w)
 TRANS(vsrar_d, gen_vvv, 16, gen_helper_vsrar_d)
-TRANS(vsrari_b, gen_vv_i, gen_helper_vsrari_b)
-TRANS(vsrari_h, gen_vv_i, gen_helper_vsrari_h)
-TRANS(vsrari_w, gen_vv_i, gen_helper_vsrari_w)
-TRANS(vsrari_d, gen_vv_i, gen_helper_vsrari_d)
+TRANS(vsrari_b, gen_vv_i, 16, gen_helper_vsrari_b)
+TRANS(vsrari_h, gen_vv_i, 16, gen_helper_vsrari_h)
+TRANS(vsrari_w, gen_vv_i, 16, gen_helper_vsrari_w)
+TRANS(vsrari_d, gen_vv_i, 16, gen_helper_vsrari_d)
 
 TRANS(vsrln_b_h, gen_vvv, 16, gen_helper_vsrln_b_h)
 TRANS(vsrln_h_w, gen_vvv, 16, gen_helper_vsrln_h_w)
@@ -3175,14 +3178,14 @@ TRANS(vsran_b_h, gen_vvv, 16, gen_helper_vsran_b_h)
 TRANS(vsran_h_w, gen_vvv, 16, gen_helper_vsran_h_w)
 TRANS(vsran_w_d, gen_vvv, 16, gen_helper_vsran_w_d)
 
-TRANS(vsrlni_b_h, gen_vv_i, gen_helper_vsrlni_b_h)
-TRANS(vsrlni_h_w, gen_vv_i, gen_helper_vsrlni_h_w)
-TRANS(vsrlni_w_d, gen_vv_i, gen_helper_vsrlni_w_d)
-TRANS(vsrlni_d_q, gen_vv_i, gen_helper_vsrlni_d_q)
-TRANS(vsrani_b_h, gen_vv_i, gen_helper_vsrani_b_h)
-TRANS(vsrani_h_w, gen_vv_i, gen_helper_vsrani_h_w)
-TRANS(vsrani_w_d, gen_vv_i, gen_helper_vsrani_w_d)
-TRANS(vsrani_d_q, gen_vv_i, gen_helper_vsrani_d_q)
+TRANS(vsrlni_b_h, gen_vv_i, 16, gen_helper_vsrlni_b_h)
+TRANS(vsrlni_h_w, gen_vv_i, 16, gen_helper_vsrlni_h_w)
+TRANS(vsrlni_w_d, gen_vv_i, 16, gen_helper_vsrlni_w_d)
+TRANS(vsrlni_d_q, gen_vv_i, 16, gen_helper_vsrlni_d_q)
+TRANS(vsrani_b_h, gen_vv_i, 16, gen_helper_vsrani_b_h)
+TRANS(vsrani_h_w, gen_vv_i, 16, gen_helper_vsrani_h_w)
+TRANS(vsrani_w_d, gen_vv_i, 16, gen_helper_vsrani_w_d)
+TRANS(vsrani_d_q, gen_vv_i, 16, gen_helper_vsrani_d_q)
 
 TRANS(vsrlrn_b_h, gen_vvv, 16, gen_helper_vsrlrn_b_h)
 TRANS(vsrlrn_h_w, gen_vvv, 16, gen_helper_vsrlrn_h_w)
@@ -3191,14 +3194,14 @@ TRANS(vsrarn_b_h, gen_vvv, 16, gen_helper_vsrarn_b_h)
 TRANS(vsrarn_h_w, gen_vvv, 16, gen_helper_vsrarn_h_w)
 TRANS(vsrarn_w_d, gen_vvv, 16, gen_helper_vsrarn_w_d)
 
-TRANS(vsrlrni_b_h, gen_vv_i, gen_helper_vsrlrni_b_h)
-TRANS(vsrlrni_h_w, gen_vv_i, gen_helper_vsrlrni_h_w)
-TRANS(vsrlrni_w_d, gen_vv_i, gen_helper_vsrlrni_w_d)
-TRANS(vsrlrni_d_q, gen_vv_i, gen_helper_vsrlrni_d_q)
-TRANS(vsrarni_b_h, gen_vv_i, gen_helper_vsrarni_b_h)
-TRANS(vsrarni_h_w, gen_vv_i, gen_helper_vsrarni_h_w)
-TRANS(vsrarni_w_d, gen_vv_i, gen_helper_vsrarni_w_d)
-TRANS(vsrarni_d_q, gen_vv_i, gen_helper_vsrarni_d_q)
+TRANS(vsrlrni_b_h, gen_vv_i, 16, gen_helper_vsrlrni_b_h)
+TRANS(vsrlrni_h_w, gen_vv_i, 16, gen_helper_vsrlrni_h_w)
+TRANS(vsrlrni_w_d, gen_vv_i, 16, gen_helper_vsrlrni_w_d)
+TRANS(vsrlrni_d_q, gen_vv_i, 16, gen_helper_vsrlrni_d_q)
+TRANS(vsrarni_b_h, gen_vv_i, 16, gen_helper_vsrarni_b_h)
+TRANS(vsrarni_h_w, gen_vv_i, 16, gen_helper_vsrarni_h_w)
+TRANS(vsrarni_w_d, gen_vv_i, 16, gen_helper_vsrarni_w_d)
+TRANS(vsrarni_d_q, gen_vv_i, 16, gen_helper_vsrarni_d_q)
 
 TRANS(vssrln_b_h, gen_vvv, 16, gen_helper_vssrln_b_h)
 TRANS(vssrln_h_w, gen_vvv, 16, gen_helper_vssrln_h_w)
@@ -3213,22 +3216,22 @@ TRANS(vssran_bu_h, gen_vvv, 16, gen_helper_vssran_bu_h)
 TRANS(vssran_hu_w, gen_vvv, 16, gen_helper_vssran_hu_w)
 TRANS(vssran_wu_d, gen_vvv, 16, gen_helper_vssran_wu_d)
 
-TRANS(vssrlni_b_h, gen_vv_i, gen_helper_vssrlni_b_h)
-TRANS(vssrlni_h_w, gen_vv_i, gen_helper_vssrlni_h_w)
-TRANS(vssrlni_w_d, gen_vv_i, gen_helper_vssrlni_w_d)
-TRANS(vssrlni_d_q, gen_vv_i, gen_helper_vssrlni_d_q)
-TRANS(vssrani_b_h, gen_vv_i, gen_helper_vssrani_b_h)
-TRANS(vssrani_h_w, gen_vv_i, gen_helper_vssrani_h_w)
-TRANS(vssrani_w_d, gen_vv_i, gen_helper_vssrani_w_d)
-TRANS(vssrani_d_q, gen_vv_i, gen_helper_vssrani_d_q)
-TRANS(vssrlni_bu_h, gen_vv_i, gen_helper_vssrlni_bu_h)
-TRANS(vssrlni_hu_w, gen_vv_i, gen_helper_vssrlni_hu_w)
-TRANS(vssrlni_wu_d, gen_vv_i, gen_helper_vssrlni_wu_d)
-TRANS(vssrlni_du_q, gen_vv_i, gen_helper_vssrlni_du_q)
-TRANS(vssrani_bu_h, gen_vv_i, gen_helper_vssrani_bu_h)
-TRANS(vssrani_hu_w, gen_vv_i, gen_helper_vssrani_hu_w)
-TRANS(vssrani_wu_d, gen_vv_i, gen_helper_vssrani_wu_d)
-TRANS(vssrani_du_q, gen_vv_i, gen_helper_vssrani_du_q)
+TRANS(vssrlni_b_h, gen_vv_i, 16, gen_helper_vssrlni_b_h)
+TRANS(vssrlni_h_w, gen_vv_i, 16, gen_helper_vssrlni_h_w)
+TRANS(vssrlni_w_d, gen_vv_i, 16, gen_helper_vssrlni_w_d)
+TRANS(vssrlni_d_q, gen_vv_i, 16, gen_helper_vssrlni_d_q)
+TRANS(vssrani_b_h, gen_vv_i, 16, gen_helper_vssrani_b_h)
+TRANS(vssrani_h_w, gen_vv_i, 16, gen_helper_vssrani_h_w)
+TRANS(vssrani_w_d, gen_vv_i, 16, gen_helper_vssrani_w_d)
+TRANS(vssrani_d_q, gen_vv_i, 16, gen_helper_vssrani_d_q)
+TRANS(vssrlni_bu_h, gen_vv_i, 16, gen_helper_vssrlni_bu_h)
+TRANS(vssrlni_hu_w, gen_vv_i, 16, gen_helper_vssrlni_hu_w)
+TRANS(vssrlni_wu_d, gen_vv_i, 16, gen_helper_vssrlni_wu_d)
+TRANS(vssrlni_du_q, gen_vv_i, 16, gen_helper_vssrlni_du_q)
+TRANS(vssrani_bu_h, gen_vv_i, 16, gen_helper_vssrani_bu_h)
+TRANS(vssrani_hu_w, gen_vv_i, 16, gen_helper_vssrani_hu_w)
+TRANS(vssrani_wu_d, gen_vv_i, 16, gen_helper_vssrani_wu_d)
+TRANS(vssrani_du_q, gen_vv_i, 16, gen_helper_vssrani_du_q)
 
 TRANS(vssrlrn_b_h, gen_vvv, 16, gen_helper_vssrlrn_b_h)
 TRANS(vssrlrn_h_w, gen_vvv, 16, gen_helper_vssrlrn_h_w)
@@ -3243,22 +3246,22 @@ TRANS(vssrarn_bu_h, gen_vvv, 16, gen_helper_vssrarn_bu_h)
 TRANS(vssrarn_hu_w, gen_vvv, 16, gen_helper_vssrarn_hu_w)
 TRANS(vssrarn_wu_d, gen_vvv, 16, gen_helper_vssrarn_wu_d)
 
-TRANS(vssrlrni_b_h, gen_vv_i, gen_helper_vssrlrni_b_h)
-TRANS(vssrlrni_h_w, gen_vv_i, gen_helper_vssrlrni_h_w)
-TRANS(vssrlrni_w_d, gen_vv_i, gen_helper_vssrlrni_w_d)
-TRANS(vssrlrni_d_q, gen_vv_i, gen_helper_vssrlrni_d_q)
-TRANS(vssrarni_b_h, gen_vv_i, gen_helper_vssrarni_b_h)
-TRANS(vssrarni_h_w, gen_vv_i, gen_helper_vssrarni_h_w)
-TRANS(vssrarni_w_d, gen_vv_i, gen_helper_vssrarni_w_d)
-TRANS(vssrarni_d_q, gen_vv_i, gen_helper_vssrarni_d_q)
-TRANS(vssrlrni_bu_h, gen_vv_i, gen_helper_vssrlrni_bu_h)
-TRANS(vssrlrni_hu_w, gen_vv_i, gen_helper_vssrlrni_hu_w)
-TRANS(vssrlrni_wu_d, gen_vv_i, gen_helper_vssrlrni_wu_d)
-TRANS(vssrlrni_du_q, gen_vv_i, gen_helper_vssrlrni_du_q)
-TRANS(vssrarni_bu_h, gen_vv_i, gen_helper_vssrarni_bu_h)
-TRANS(vssrarni_hu_w, gen_vv_i, gen_helper_vssrarni_hu_w)
-TRANS(vssrarni_wu_d, gen_vv_i, gen_helper_vssrarni_wu_d)
-TRANS(vssrarni_du_q, gen_vv_i, gen_helper_vssrarni_du_q)
+TRANS(vssrlrni_b_h, gen_vv_i, 16, gen_helper_vssrlrni_b_h)
+TRANS(vssrlrni_h_w, gen_vv_i, 16, gen_helper_vssrlrni_h_w)
+TRANS(vssrlrni_w_d, gen_vv_i, 16, gen_helper_vssrlrni_w_d)
+TRANS(vssrlrni_d_q, gen_vv_i, 16, gen_helper_vssrlrni_d_q)
+TRANS(vssrarni_b_h, gen_vv_i, 16, gen_helper_vssrarni_b_h)
+TRANS(vssrarni_h_w, gen_vv_i, 16, gen_helper_vssrarni_h_w)
+TRANS(vssrarni_w_d, gen_vv_i, 16, gen_helper_vssrarni_w_d)
+TRANS(vssrarni_d_q, gen_vv_i, 16, gen_helper_vssrarni_d_q)
+TRANS(vssrlrni_bu_h, gen_vv_i, 16, gen_helper_vssrlrni_bu_h)
+TRANS(vssrlrni_hu_w, gen_vv_i, 16, gen_helper_vssrlrni_hu_w)
+TRANS(vssrlrni_wu_d, gen_vv_i, 16, gen_helper_vssrlrni_wu_d)
+TRANS(vssrlrni_du_q, gen_vv_i, 16, gen_helper_vssrlrni_du_q)
+TRANS(vssrarni_bu_h, gen_vv_i, 16, gen_helper_vssrarni_bu_h)
+TRANS(vssrarni_hu_w, gen_vv_i, 16, gen_helper_vssrarni_hu_w)
+TRANS(vssrarni_wu_d, gen_vv_i, 16, gen_helper_vssrarni_wu_d)
+TRANS(vssrarni_du_q, gen_vv_i, 16, gen_helper_vssrarni_du_q)
 
 TRANS(vclo_b, gen_vv, 16, gen_helper_vclo_b)
 TRANS(vclo_h, gen_vv, 16, gen_helper_vclo_h)
@@ -3581,8 +3584,8 @@ TRANS(vbitrevi_d, gvec_vv_i, 16, MO_64, do_vbitrevi)
 
 TRANS(vfrstp_b, gen_vvv, 16, gen_helper_vfrstp_b)
 TRANS(vfrstp_h, gen_vvv, 16, gen_helper_vfrstp_h)
-TRANS(vfrstpi_b, gen_vv_i, gen_helper_vfrstpi_b)
-TRANS(vfrstpi_h, gen_vv_i, gen_helper_vfrstpi_h)
+TRANS(vfrstpi_b, gen_vv_i, 16, gen_helper_vfrstpi_b)
+TRANS(vfrstpi_h, gen_vv_i, 16, gen_helper_vfrstpi_h)
 
 TRANS(vfadd_s, gen_vvv, 16, gen_helper_vfadd_s)
 TRANS(vfadd_d, gen_vvv, 16, gen_helper_vfadd_d)
@@ -4242,17 +4245,17 @@ TRANS(vshuf_b, gen_vvvv, gen_helper_vshuf_b)
 TRANS(vshuf_h, gen_vvv, 16, gen_helper_vshuf_h)
 TRANS(vshuf_w, gen_vvv, 16, gen_helper_vshuf_w)
 TRANS(vshuf_d, gen_vvv, 16, gen_helper_vshuf_d)
-TRANS(vshuf4i_b, gen_vv_i, gen_helper_vshuf4i_b)
-TRANS(vshuf4i_h, gen_vv_i, gen_helper_vshuf4i_h)
-TRANS(vshuf4i_w, gen_vv_i, gen_helper_vshuf4i_w)
-TRANS(vshuf4i_d, gen_vv_i, gen_helper_vshuf4i_d)
+TRANS(vshuf4i_b, gen_vv_i, 16, gen_helper_vshuf4i_b)
+TRANS(vshuf4i_h, gen_vv_i, 16, gen_helper_vshuf4i_h)
+TRANS(vshuf4i_w, gen_vv_i, 16, gen_helper_vshuf4i_w)
+TRANS(vshuf4i_d, gen_vv_i, 16, gen_helper_vshuf4i_d)
 
-TRANS(vpermi_w, gen_vv_i, gen_helper_vpermi_w)
+TRANS(vpermi_w, gen_vv_i, 16, gen_helper_vpermi_w)
 
-TRANS(vextrins_b, gen_vv_i, gen_helper_vextrins_b)
-TRANS(vextrins_h, gen_vv_i, gen_helper_vextrins_h)
-TRANS(vextrins_w, gen_vv_i, gen_helper_vextrins_w)
-TRANS(vextrins_d, gen_vv_i, gen_helper_vextrins_d)
+TRANS(vextrins_b, gen_vv_i, 16, gen_helper_vextrins_b)
+TRANS(vextrins_h, gen_vv_i, 16, gen_helper_vextrins_h)
+TRANS(vextrins_w, gen_vv_i, 16, gen_helper_vextrins_w)
+TRANS(vextrins_d, gen_vv_i, 16, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fb7bd9fb34..8a7933eccc 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1652,6 +1652,15 @@ xvrotri_h        0111 01101010 00000 1 .... ..... .....   @vv_ui4
 xvrotri_w        0111 01101010 00001 ..... ..... .....    @vv_ui5
 xvrotri_d        0111 01101010 0001 ...... ..... .....    @vv_ui6
 
+xvsllwil_h_b     0111 01110000 10000 01 ... ..... .....   @vv_ui3
+xvsllwil_w_h     0111 01110000 10000 1 .... ..... .....   @vv_ui4
+xvsllwil_d_w     0111 01110000 10001 ..... ..... .....    @vv_ui5
+xvextl_q_d       0111 01110000 10010 00000 ..... .....    @vv
+xvsllwil_hu_bu   0111 01110000 11000 01 ... ..... .....   @vv_ui3
+xvsllwil_wu_hu   0111 01110000 11000 1 .... ..... .....   @vv_ui4
+xvsllwil_du_wu   0111 01110000 11001 ..... ..... .....    @vv_ui5
+xvextl_qu_du     0111 01110000 11010 00000 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 9609cc93f4..58b2b7da12 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -939,38 +939,54 @@ void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t v)
     }
 }
 
-#define VSLLWIL(NAME, BIT, E1, E2)                        \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i;                                                \
-    VReg temp;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-    typedef __typeof(temp.E1(0)) TD;                      \
-                                                          \
-    temp.D(0) = 0;                                        \
-    temp.D(1) = 0;                                        \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-        temp.E1(i) = (TD)Vj->E2(i) << (imm % BIT);        \
-    }                                                     \
-    *Vd = temp;                                           \
-}
-
-void HELPER(vextl_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+#define VSLLWIL(NAME, BIT, E1, E2)                                     \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,              \
+                  uint32_t vd, uint32_t vj, uint32_t imm)              \
+{                                                                      \
+    int i, max;                                                        \
+    VReg temp;                                                         \
+    VReg *Vd = &(env->fpr[vd].vreg);                                   \
+    VReg *Vj = &(env->fpr[vj].vreg);                                   \
+    typedef __typeof(temp.E1(0)) TD;                                   \
+                                                                       \
+    temp.Q(0) = int128_zero();                                         \
+                                                                       \
+    if (oprsz == 32) {                                                 \
+        temp.Q(1) = int128_zero();                                     \
+    }                                                                  \
+                                                                       \
+    max = LSX_LEN / BIT;                                               \
+    for (i = 0; i < max; i++) {                                        \
+        temp.E1(i) = (TD)Vj->E2(i) << (imm % BIT);                     \
+        if (oprsz == 32) {                                             \
+            temp.E1(i + max) = (TD)Vj->E2(i + max * 2) << (imm % BIT); \
+        }                                                              \
+    }                                                                  \
+    *Vd = temp;                                                        \
+}
+
+void HELPER(vextl_q_d)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
     Vd->Q(0) = int128_makes64(Vj->D(0));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_makes64(Vj->D(2));
+    }
 }
 
-void HELPER(vextl_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vextl_qu_du)(CPULoongArchState *env,
+                         uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    Vd->Q(0) = int128_make64(Vj->D(0));
+    Vd->Q(0) = int128_make64(Vj->UD(0));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_make64(Vj->UD(2));
+    }
 }
 
 VSLLWIL(vsllwil_h_b, 16, H, B)
-- 
2.39.1


