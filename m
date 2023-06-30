Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159227436B2
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92j-0008GW-Dg; Fri, 30 Jun 2023 03:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92V-0008Ay-BB
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:36 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92S-0007zY-5S
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxxcRXi55kgTQEAA--.6846S3;
 Fri, 30 Jun 2023 15:59:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S21; 
 Fri, 30 Jun 2023 15:59:18 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 19/46] target/loongarch: Implement xvexth
Date: Fri, 30 Jun 2023 15:58:37 +0800
Message-Id: <20230630075904.45940-20-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S21
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
- XVEXTH.{H.B/W.H/D.W/Q.D};
- XVEXTH.{HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |   9 +
 target/loongarch/helper.h                    |  16 +-
 target/loongarch/insn_trans/trans_lasx.c.inc |   9 +
 target/loongarch/insn_trans/trans_lsx.c.inc  | 176 ++++++++++---------
 target/loongarch/insns.decode                |   9 +
 target/loongarch/vec_helper.c                |  39 ++--
 6 files changed, 150 insertions(+), 108 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 09e5981fc3..6ca545956d 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1988,6 +1988,15 @@ INSN_LASX(xvsat_hu,          vv_i)
 INSN_LASX(xvsat_wu,          vv_i)
 INSN_LASX(xvsat_du,          vv_i)
 
+INSN_LASX(xvexth_h_b,        vv)
+INSN_LASX(xvexth_w_h,        vv)
+INSN_LASX(xvexth_d_w,        vv)
+INSN_LASX(xvexth_q_d,        vv)
+INSN_LASX(xvexth_hu_bu,      vv)
+INSN_LASX(xvexth_wu_hu,      vv)
+INSN_LASX(xvexth_du_wu,      vv)
+INSN_LASX(xvexth_qu_du,      vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index f018d6c754..b7eece8d43 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -330,14 +330,14 @@ DEF_HELPER_FLAGS_4(vsat_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vsat_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vsat_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_3(vexth_h_b, void, env, i32, i32)
-DEF_HELPER_3(vexth_w_h, void, env, i32, i32)
-DEF_HELPER_3(vexth_d_w, void, env, i32, i32)
-DEF_HELPER_3(vexth_q_d, void, env, i32, i32)
-DEF_HELPER_3(vexth_hu_bu, void, env, i32, i32)
-DEF_HELPER_3(vexth_wu_hu, void, env, i32, i32)
-DEF_HELPER_3(vexth_du_wu, void, env, i32, i32)
-DEF_HELPER_3(vexth_qu_du, void, env, i32, i32)
+DEF_HELPER_4(vexth_h_b, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_w_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_d_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_q_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_hu_bu, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_wu_hu, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_du_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(vexth_qu_du, void, env, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 75bb216cd6..f100a4a27c 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -370,6 +370,15 @@ TRANS(xvsat_hu, gvec_vv_i, 32, MO_16, do_vsat_u)
 TRANS(xvsat_wu, gvec_vv_i, 32, MO_32, do_vsat_u)
 TRANS(xvsat_du, gvec_vv_i, 32, MO_64, do_vsat_u)
 
+TRANS(xvexth_h_b, gen_vv, 32, gen_helper_vexth_h_b)
+TRANS(xvexth_w_h, gen_vv, 32, gen_helper_vexth_w_h)
+TRANS(xvexth_d_w, gen_vv, 32, gen_helper_vexth_d_w)
+TRANS(xvexth_q_d, gen_vv, 32, gen_helper_vexth_q_d)
+TRANS(xvexth_hu_bu, gen_vv, 32, gen_helper_vexth_hu_bu)
+TRANS(xvexth_wu_hu, gen_vv, 32, gen_helper_vexth_wu_hu)
+TRANS(xvexth_du_wu, gen_vv, 32, gen_helper_vexth_du_wu)
+TRANS(xvexth_qu_du, gen_vv, 32, gen_helper_vexth_qu_du)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index f2f7c7a9aa..e8bad1c9a3 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -33,14 +33,16 @@ static bool gen_vvv(DisasContext *ctx, arg_vvv *a, uint32_t sz,
     return true;
 }
 
-static bool gen_vv(DisasContext *ctx, arg_vv *a,
-                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+static bool gen_vv(DisasContext *ctx, arg_vv *a, uint32_t sz,
+                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
     CHECK_VEC;
-    func(cpu_env, vd, vj);
+
+    func(cpu_env, oprsz, vd, vj);
     return true;
 }
 
@@ -2838,14 +2840,14 @@ TRANS(vsat_hu, gvec_vv_i, 16, MO_16, do_vsat_u)
 TRANS(vsat_wu, gvec_vv_i, 16, MO_32, do_vsat_u)
 TRANS(vsat_du, gvec_vv_i, 16, MO_64, do_vsat_u)
 
-TRANS(vexth_h_b, gen_vv, gen_helper_vexth_h_b)
-TRANS(vexth_w_h, gen_vv, gen_helper_vexth_w_h)
-TRANS(vexth_d_w, gen_vv, gen_helper_vexth_d_w)
-TRANS(vexth_q_d, gen_vv, gen_helper_vexth_q_d)
-TRANS(vexth_hu_bu, gen_vv, gen_helper_vexth_hu_bu)
-TRANS(vexth_wu_hu, gen_vv, gen_helper_vexth_wu_hu)
-TRANS(vexth_du_wu, gen_vv, gen_helper_vexth_du_wu)
-TRANS(vexth_qu_du, gen_vv, gen_helper_vexth_qu_du)
+TRANS(vexth_h_b, gen_vv, 16, gen_helper_vexth_h_b)
+TRANS(vexth_w_h, gen_vv, 16, gen_helper_vexth_w_h)
+TRANS(vexth_d_w, gen_vv, 16, gen_helper_vexth_d_w)
+TRANS(vexth_q_d, gen_vv, 16, gen_helper_vexth_q_d)
+TRANS(vexth_hu_bu, gen_vv, 16, gen_helper_vexth_hu_bu)
+TRANS(vexth_wu_hu, gen_vv, 16, gen_helper_vexth_wu_hu)
+TRANS(vexth_du_wu, gen_vv, 16, gen_helper_vexth_du_wu)
+TRANS(vexth_qu_du, gen_vv, 16, gen_helper_vexth_qu_du)
 
 static void gen_vsigncov(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2900,12 +2902,12 @@ TRANS(vsigncov_h, gvec_vvv, 16, MO_16, do_vsigncov)
 TRANS(vsigncov_w, gvec_vvv, 16, MO_32, do_vsigncov)
 TRANS(vsigncov_d, gvec_vvv, 16, MO_64, do_vsigncov)
 
-TRANS(vmskltz_b, gen_vv, gen_helper_vmskltz_b)
-TRANS(vmskltz_h, gen_vv, gen_helper_vmskltz_h)
-TRANS(vmskltz_w, gen_vv, gen_helper_vmskltz_w)
-TRANS(vmskltz_d, gen_vv, gen_helper_vmskltz_d)
-TRANS(vmskgez_b, gen_vv, gen_helper_vmskgez_b)
-TRANS(vmsknz_b, gen_vv, gen_helper_vmsknz_b)
+TRANS(vmskltz_b, gen_vv, 16, gen_helper_vmskltz_b)
+TRANS(vmskltz_h, gen_vv, 16, gen_helper_vmskltz_h)
+TRANS(vmskltz_w, gen_vv, 16, gen_helper_vmskltz_w)
+TRANS(vmskltz_d, gen_vv, 16, gen_helper_vmskltz_d)
+TRANS(vmskgez_b, gen_vv, 16, gen_helper_vmskgez_b)
+TRANS(vmsknz_b, gen_vv, 16, gen_helper_vmsknz_b)
 
 #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
 
@@ -3139,11 +3141,11 @@ TRANS(vrotri_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_rotri)
 TRANS(vsllwil_h_b, gen_vv_i, gen_helper_vsllwil_h_b)
 TRANS(vsllwil_w_h, gen_vv_i, gen_helper_vsllwil_w_h)
 TRANS(vsllwil_d_w, gen_vv_i, gen_helper_vsllwil_d_w)
-TRANS(vextl_q_d, gen_vv, gen_helper_vextl_q_d)
+TRANS(vextl_q_d, gen_vv, 16, gen_helper_vextl_q_d)
 TRANS(vsllwil_hu_bu, gen_vv_i, gen_helper_vsllwil_hu_bu)
 TRANS(vsllwil_wu_hu, gen_vv_i, gen_helper_vsllwil_wu_hu)
 TRANS(vsllwil_du_wu, gen_vv_i, gen_helper_vsllwil_du_wu)
-TRANS(vextl_qu_du, gen_vv, gen_helper_vextl_qu_du)
+TRANS(vextl_qu_du, gen_vv, 16, gen_helper_vextl_qu_du)
 
 TRANS(vsrlr_b, gen_vvv, 16, gen_helper_vsrlr_b)
 TRANS(vsrlr_h, gen_vvv, 16, gen_helper_vsrlr_h)
@@ -3255,19 +3257,19 @@ TRANS(vssrarni_hu_w, gen_vv_i, gen_helper_vssrarni_hu_w)
 TRANS(vssrarni_wu_d, gen_vv_i, gen_helper_vssrarni_wu_d)
 TRANS(vssrarni_du_q, gen_vv_i, gen_helper_vssrarni_du_q)
 
-TRANS(vclo_b, gen_vv, gen_helper_vclo_b)
-TRANS(vclo_h, gen_vv, gen_helper_vclo_h)
-TRANS(vclo_w, gen_vv, gen_helper_vclo_w)
-TRANS(vclo_d, gen_vv, gen_helper_vclo_d)
-TRANS(vclz_b, gen_vv, gen_helper_vclz_b)
-TRANS(vclz_h, gen_vv, gen_helper_vclz_h)
-TRANS(vclz_w, gen_vv, gen_helper_vclz_w)
-TRANS(vclz_d, gen_vv, gen_helper_vclz_d)
+TRANS(vclo_b, gen_vv, 16, gen_helper_vclo_b)
+TRANS(vclo_h, gen_vv, 16, gen_helper_vclo_h)
+TRANS(vclo_w, gen_vv, 16, gen_helper_vclo_w)
+TRANS(vclo_d, gen_vv, 16, gen_helper_vclo_d)
+TRANS(vclz_b, gen_vv, 16, gen_helper_vclz_b)
+TRANS(vclz_h, gen_vv, 16, gen_helper_vclz_h)
+TRANS(vclz_w, gen_vv, 16, gen_helper_vclz_w)
+TRANS(vclz_d, gen_vv, 16, gen_helper_vclz_d)
 
-TRANS(vpcnt_b, gen_vv, gen_helper_vpcnt_b)
-TRANS(vpcnt_h, gen_vv, gen_helper_vpcnt_h)
-TRANS(vpcnt_w, gen_vv, gen_helper_vpcnt_w)
-TRANS(vpcnt_d, gen_vv, gen_helper_vpcnt_d)
+TRANS(vpcnt_b, gen_vv, 16, gen_helper_vpcnt_b)
+TRANS(vpcnt_h, gen_vv, 16, gen_helper_vpcnt_h)
+TRANS(vpcnt_w, gen_vv, 16, gen_helper_vpcnt_w)
+TRANS(vpcnt_d, gen_vv, 16, gen_helper_vpcnt_d)
 
 static void do_vbit(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3607,73 +3609,73 @@ TRANS(vfmaxa_d, gen_vvv, 16, gen_helper_vfmaxa_d)
 TRANS(vfmina_s, gen_vvv, 16, gen_helper_vfmina_s)
 TRANS(vfmina_d, gen_vvv, 16, gen_helper_vfmina_d)
 
-TRANS(vflogb_s, gen_vv, gen_helper_vflogb_s)
-TRANS(vflogb_d, gen_vv, gen_helper_vflogb_d)
+TRANS(vflogb_s, gen_vv, 16, gen_helper_vflogb_s)
+TRANS(vflogb_d, gen_vv, 16, gen_helper_vflogb_d)
 
-TRANS(vfclass_s, gen_vv, gen_helper_vfclass_s)
-TRANS(vfclass_d, gen_vv, gen_helper_vfclass_d)
+TRANS(vfclass_s, gen_vv, 16, gen_helper_vfclass_s)
+TRANS(vfclass_d, gen_vv, 16, gen_helper_vfclass_d)
 
-TRANS(vfsqrt_s, gen_vv, gen_helper_vfsqrt_s)
-TRANS(vfsqrt_d, gen_vv, gen_helper_vfsqrt_d)
-TRANS(vfrecip_s, gen_vv, gen_helper_vfrecip_s)
-TRANS(vfrecip_d, gen_vv, gen_helper_vfrecip_d)
-TRANS(vfrsqrt_s, gen_vv, gen_helper_vfrsqrt_s)
-TRANS(vfrsqrt_d, gen_vv, gen_helper_vfrsqrt_d)
+TRANS(vfsqrt_s, gen_vv, 16, gen_helper_vfsqrt_s)
+TRANS(vfsqrt_d, gen_vv, 16, gen_helper_vfsqrt_d)
+TRANS(vfrecip_s, gen_vv, 16, gen_helper_vfrecip_s)
+TRANS(vfrecip_d, gen_vv, 16, gen_helper_vfrecip_d)
+TRANS(vfrsqrt_s, gen_vv, 16, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrt_d, gen_vv, 16, gen_helper_vfrsqrt_d)
 
-TRANS(vfcvtl_s_h, gen_vv, gen_helper_vfcvtl_s_h)
-TRANS(vfcvth_s_h, gen_vv, gen_helper_vfcvth_s_h)
-TRANS(vfcvtl_d_s, gen_vv, gen_helper_vfcvtl_d_s)
-TRANS(vfcvth_d_s, gen_vv, gen_helper_vfcvth_d_s)
+TRANS(vfcvtl_s_h, gen_vv, 16, gen_helper_vfcvtl_s_h)
+TRANS(vfcvth_s_h, gen_vv, 16, gen_helper_vfcvth_s_h)
+TRANS(vfcvtl_d_s, gen_vv, 16, gen_helper_vfcvtl_d_s)
+TRANS(vfcvth_d_s, gen_vv, 16, gen_helper_vfcvth_d_s)
 TRANS(vfcvt_h_s, gen_vvv, 16, gen_helper_vfcvt_h_s)
 TRANS(vfcvt_s_d, gen_vvv, 16, gen_helper_vfcvt_s_d)
 
-TRANS(vfrintrne_s, gen_vv, gen_helper_vfrintrne_s)
-TRANS(vfrintrne_d, gen_vv, gen_helper_vfrintrne_d)
-TRANS(vfrintrz_s, gen_vv, gen_helper_vfrintrz_s)
-TRANS(vfrintrz_d, gen_vv, gen_helper_vfrintrz_d)
-TRANS(vfrintrp_s, gen_vv, gen_helper_vfrintrp_s)
-TRANS(vfrintrp_d, gen_vv, gen_helper_vfrintrp_d)
-TRANS(vfrintrm_s, gen_vv, gen_helper_vfrintrm_s)
-TRANS(vfrintrm_d, gen_vv, gen_helper_vfrintrm_d)
-TRANS(vfrint_s, gen_vv, gen_helper_vfrint_s)
-TRANS(vfrint_d, gen_vv, gen_helper_vfrint_d)
-
-TRANS(vftintrne_w_s, gen_vv, gen_helper_vftintrne_w_s)
-TRANS(vftintrne_l_d, gen_vv, gen_helper_vftintrne_l_d)
-TRANS(vftintrz_w_s, gen_vv, gen_helper_vftintrz_w_s)
-TRANS(vftintrz_l_d, gen_vv, gen_helper_vftintrz_l_d)
-TRANS(vftintrp_w_s, gen_vv, gen_helper_vftintrp_w_s)
-TRANS(vftintrp_l_d, gen_vv, gen_helper_vftintrp_l_d)
-TRANS(vftintrm_w_s, gen_vv, gen_helper_vftintrm_w_s)
-TRANS(vftintrm_l_d, gen_vv, gen_helper_vftintrm_l_d)
-TRANS(vftint_w_s, gen_vv, gen_helper_vftint_w_s)
-TRANS(vftint_l_d, gen_vv, gen_helper_vftint_l_d)
-TRANS(vftintrz_wu_s, gen_vv, gen_helper_vftintrz_wu_s)
-TRANS(vftintrz_lu_d, gen_vv, gen_helper_vftintrz_lu_d)
-TRANS(vftint_wu_s, gen_vv, gen_helper_vftint_wu_s)
-TRANS(vftint_lu_d, gen_vv, gen_helper_vftint_lu_d)
+TRANS(vfrintrne_s, gen_vv, 16, gen_helper_vfrintrne_s)
+TRANS(vfrintrne_d, gen_vv, 16, gen_helper_vfrintrne_d)
+TRANS(vfrintrz_s, gen_vv, 16, gen_helper_vfrintrz_s)
+TRANS(vfrintrz_d, gen_vv, 16, gen_helper_vfrintrz_d)
+TRANS(vfrintrp_s, gen_vv, 16, gen_helper_vfrintrp_s)
+TRANS(vfrintrp_d, gen_vv, 16, gen_helper_vfrintrp_d)
+TRANS(vfrintrm_s, gen_vv, 16, gen_helper_vfrintrm_s)
+TRANS(vfrintrm_d, gen_vv, 16, gen_helper_vfrintrm_d)
+TRANS(vfrint_s, gen_vv, 16, gen_helper_vfrint_s)
+TRANS(vfrint_d, gen_vv, 16, gen_helper_vfrint_d)
+
+TRANS(vftintrne_w_s, gen_vv, 16, gen_helper_vftintrne_w_s)
+TRANS(vftintrne_l_d, gen_vv, 16, gen_helper_vftintrne_l_d)
+TRANS(vftintrz_w_s, gen_vv, 16, gen_helper_vftintrz_w_s)
+TRANS(vftintrz_l_d, gen_vv, 16, gen_helper_vftintrz_l_d)
+TRANS(vftintrp_w_s, gen_vv, 16, gen_helper_vftintrp_w_s)
+TRANS(vftintrp_l_d, gen_vv, 16, gen_helper_vftintrp_l_d)
+TRANS(vftintrm_w_s, gen_vv, 16, gen_helper_vftintrm_w_s)
+TRANS(vftintrm_l_d, gen_vv, 16, gen_helper_vftintrm_l_d)
+TRANS(vftint_w_s, gen_vv, 16, gen_helper_vftint_w_s)
+TRANS(vftint_l_d, gen_vv, 16, gen_helper_vftint_l_d)
+TRANS(vftintrz_wu_s, gen_vv, 16, gen_helper_vftintrz_wu_s)
+TRANS(vftintrz_lu_d, gen_vv, 16, gen_helper_vftintrz_lu_d)
+TRANS(vftint_wu_s, gen_vv, 16, gen_helper_vftint_wu_s)
+TRANS(vftint_lu_d, gen_vv, 16, gen_helper_vftint_lu_d)
 TRANS(vftintrne_w_d, gen_vvv, 16, gen_helper_vftintrne_w_d)
 TRANS(vftintrz_w_d, gen_vvv, 16, gen_helper_vftintrz_w_d)
 TRANS(vftintrp_w_d, gen_vvv, 16, gen_helper_vftintrp_w_d)
 TRANS(vftintrm_w_d, gen_vvv, 16, gen_helper_vftintrm_w_d)
 TRANS(vftint_w_d, gen_vvv, 16, gen_helper_vftint_w_d)
-TRANS(vftintrnel_l_s, gen_vv, gen_helper_vftintrnel_l_s)
-TRANS(vftintrneh_l_s, gen_vv, gen_helper_vftintrneh_l_s)
-TRANS(vftintrzl_l_s, gen_vv, gen_helper_vftintrzl_l_s)
-TRANS(vftintrzh_l_s, gen_vv, gen_helper_vftintrzh_l_s)
-TRANS(vftintrpl_l_s, gen_vv, gen_helper_vftintrpl_l_s)
-TRANS(vftintrph_l_s, gen_vv, gen_helper_vftintrph_l_s)
-TRANS(vftintrml_l_s, gen_vv, gen_helper_vftintrml_l_s)
-TRANS(vftintrmh_l_s, gen_vv, gen_helper_vftintrmh_l_s)
-TRANS(vftintl_l_s, gen_vv, gen_helper_vftintl_l_s)
-TRANS(vftinth_l_s, gen_vv, gen_helper_vftinth_l_s)
-
-TRANS(vffint_s_w, gen_vv, gen_helper_vffint_s_w)
-TRANS(vffint_d_l, gen_vv, gen_helper_vffint_d_l)
-TRANS(vffint_s_wu, gen_vv, gen_helper_vffint_s_wu)
-TRANS(vffint_d_lu, gen_vv, gen_helper_vffint_d_lu)
-TRANS(vffintl_d_w, gen_vv, gen_helper_vffintl_d_w)
-TRANS(vffinth_d_w, gen_vv, gen_helper_vffinth_d_w)
+TRANS(vftintrnel_l_s, gen_vv, 16, gen_helper_vftintrnel_l_s)
+TRANS(vftintrneh_l_s, gen_vv, 16, gen_helper_vftintrneh_l_s)
+TRANS(vftintrzl_l_s, gen_vv, 16, gen_helper_vftintrzl_l_s)
+TRANS(vftintrzh_l_s, gen_vv, 16, gen_helper_vftintrzh_l_s)
+TRANS(vftintrpl_l_s, gen_vv, 16, gen_helper_vftintrpl_l_s)
+TRANS(vftintrph_l_s, gen_vv, 16, gen_helper_vftintrph_l_s)
+TRANS(vftintrml_l_s, gen_vv, 16, gen_helper_vftintrml_l_s)
+TRANS(vftintrmh_l_s, gen_vv, 16, gen_helper_vftintrmh_l_s)
+TRANS(vftintl_l_s, gen_vv, 16, gen_helper_vftintl_l_s)
+TRANS(vftinth_l_s, gen_vv, 16, gen_helper_vftinth_l_s)
+
+TRANS(vffint_s_w, gen_vv, 16, gen_helper_vffint_s_w)
+TRANS(vffint_d_l, gen_vv, 16, gen_helper_vffint_d_l)
+TRANS(vffint_s_wu, gen_vv, 16, gen_helper_vffint_s_wu)
+TRANS(vffint_d_lu, gen_vv, 16, gen_helper_vffint_d_lu)
+TRANS(vffintl_d_w, gen_vv, 16, gen_helper_vffintl_d_w)
+TRANS(vffinth_d_w, gen_vv, 16, gen_helper_vffinth_d_w)
 TRANS(vffint_s_l, gen_vvv, 16, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index e366cf7615..7491f295a5 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1571,6 +1571,15 @@ xvsat_hu         0111 01110010 10000 1 .... ..... .....   @vv_ui4
 xvsat_wu         0111 01110010 10001 ..... ..... .....    @vv_ui5
 xvsat_du         0111 01110010 1001 ...... ..... .....    @vv_ui6
 
+xvexth_h_b       0111 01101001 11101 11000 ..... .....    @vv
+xvexth_w_h       0111 01101001 11101 11001 ..... .....    @vv
+xvexth_d_w       0111 01101001 11101 11010 ..... .....    @vv
+xvexth_q_d       0111 01101001 11101 11011 ..... .....    @vv
+xvexth_hu_bu     0111 01101001 11101 11100 ..... .....    @vv
+xvexth_wu_hu     0111 01101001 11101 11101 ..... .....    @vv
+xvexth_du_wu     0111 01101001 11101 11110 ..... .....    @vv
+xvexth_qu_du     0111 01101001 11101 11111 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index d57fd958a8..76c8cda563 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -689,32 +689,45 @@ VSAT_U(vsat_hu, 16, UH)
 VSAT_U(vsat_wu, 32, UW)
 VSAT_U(vsat_du, 64, UD)
 
-#define VEXTH(NAME, BIT, E1, E2)                                    \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E1(i) = Vj->E2(i + LSX_LEN/BIT);                        \
-    }                                                               \
+#define VEXTH(NAME, BIT, E1, E2)                            \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
+{                                                           \
+    int i, max;                                             \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    max = LSX_LEN / BIT;                                    \
+    for (i = 0; i < max; i++) {                             \
+        Vd->E1(i) = Vj->E2(i + max);                        \
+        if (oprsz == 32) {                                  \
+            Vd->E1(i + max) = Vj->E2(i + max * 3);          \
+        }                                                   \
+    }                                                       \
 }
 
-void HELPER(vexth_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_q_d)(CPULoongArchState *env,
+                       uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
     Vd->Q(0) = int128_makes64(Vj->D(1));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_makes64(Vj->D(3));
+    }
 }
 
-void HELPER(vexth_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_qu_du)(CPULoongArchState *env,
+                         uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
-    Vd->Q(0) = int128_make64((uint64_t)Vj->D(1));
+    Vd->Q(0) = int128_make64(Vj->UD(1));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_make64(Vj->UD(3));
+    }
 }
 
 VEXTH(vexth_h_b, 16, H, B)
-- 
2.39.1


