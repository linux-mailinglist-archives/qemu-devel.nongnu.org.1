Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E674364B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92L-00087u-2Y; Fri, 30 Jun 2023 03:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92H-000870-FK
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92C-0007vR-Ux
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxR8VRi55kbTQEAA--.6846S3;
 Fri, 30 Jun 2023 15:59:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S11; 
 Fri, 30 Jun 2023 15:59:13 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 09/46] target/loongarch: Implement xvhaddw/xvhsubw
Date: Fri, 30 Jun 2023 15:58:27 +0800
Message-Id: <20230630075904.45940-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S11
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
- XVHADDW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU};
- XVHSUBW.{H.B/W.H/D.W/Q.D/HU.BU/WU.HU/DU.WU/QU.DU}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                      |  17 ++
 target/loongarch/helper.h                     |  34 +--
 target/loongarch/insn_trans/trans_lasx.c.inc  |  17 ++
 target/loongarch/insn_trans/trans_lsx.c.inc   | 270 +++++++++---------
 target/loongarch/insns.decode                 |  18 ++
 target/loongarch/meson.build                  |   2 +-
 target/loongarch/vec.h                        |   3 +
 .../loongarch/{lsx_helper.c => vec_helper.c}  |  40 ++-
 8 files changed, 235 insertions(+), 166 deletions(-)
 rename target/loongarch/{lsx_helper.c => vec_helper.c} (99%)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0fd88a56c1..e188220519 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1765,6 +1765,23 @@ INSN_LASX(xvssub_hu,         vvv)
 INSN_LASX(xvssub_wu,         vvv)
 INSN_LASX(xvssub_du,         vvv)
 
+INSN_LASX(xvhaddw_h_b,       vvv)
+INSN_LASX(xvhaddw_w_h,       vvv)
+INSN_LASX(xvhaddw_d_w,       vvv)
+INSN_LASX(xvhaddw_q_d,       vvv)
+INSN_LASX(xvhaddw_hu_bu,     vvv)
+INSN_LASX(xvhaddw_wu_hu,     vvv)
+INSN_LASX(xvhaddw_du_wu,     vvv)
+INSN_LASX(xvhaddw_qu_du,     vvv)
+INSN_LASX(xvhsubw_h_b,       vvv)
+INSN_LASX(xvhsubw_w_h,       vvv)
+INSN_LASX(xvhsubw_d_w,       vvv)
+INSN_LASX(xvhsubw_q_d,       vvv)
+INSN_LASX(xvhsubw_hu_bu,     vvv)
+INSN_LASX(xvhsubw_wu_hu,     vvv)
+INSN_LASX(xvhsubw_du_wu,     vvv)
+INSN_LASX(xvhsubw_qu_du,     vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b9de77d926..b0dd098e26 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -131,23 +131,23 @@ DEF_HELPER_1(ertn, void, env)
 DEF_HELPER_1(idle, void, env)
 #endif
 
-/* LoongArch LSX  */
-DEF_HELPER_4(vhaddw_h_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_w_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_d_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_q_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_hu_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_wu_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_du_wu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhaddw_qu_du, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_h_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_w_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_d_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_q_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_hu_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_wu_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_du_wu, void, env, i32, i32, i32)
-DEF_HELPER_4(vhsubw_qu_du, void, env, i32, i32, i32)
+/* LoongArch Vec */
+DEF_HELPER_5(vhaddw_h_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_w_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_d_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_q_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_hu_bu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_wu_hu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_du_wu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhaddw_qu_du, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_h_b, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_w_h, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_d_w, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_q_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_hu_bu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_wu_hu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_du_wu, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vhsubw_qu_du, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vaddwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vaddwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 275c6172b4..4272bafda2 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -78,6 +78,23 @@ TRANS(xvssub_hu, gvec_vvv, 32, MO_16, tcg_gen_gvec_ussub)
 TRANS(xvssub_wu, gvec_vvv, 32, MO_32, tcg_gen_gvec_ussub)
 TRANS(xvssub_du, gvec_vvv, 32, MO_64, tcg_gen_gvec_ussub)
 
+TRANS(xvhaddw_h_b, gen_vvv, 32, gen_helper_vhaddw_h_b)
+TRANS(xvhaddw_w_h, gen_vvv, 32, gen_helper_vhaddw_w_h)
+TRANS(xvhaddw_d_w, gen_vvv, 32, gen_helper_vhaddw_d_w)
+TRANS(xvhaddw_q_d, gen_vvv, 32, gen_helper_vhaddw_q_d)
+TRANS(xvhaddw_hu_bu, gen_vvv, 32, gen_helper_vhaddw_hu_bu)
+TRANS(xvhaddw_wu_hu, gen_vvv, 32, gen_helper_vhaddw_wu_hu)
+TRANS(xvhaddw_du_wu, gen_vvv, 32, gen_helper_vhaddw_du_wu)
+TRANS(xvhaddw_qu_du, gen_vvv, 32, gen_helper_vhaddw_qu_du)
+TRANS(xvhsubw_h_b, gen_vvv, 32, gen_helper_vhsubw_h_b)
+TRANS(xvhsubw_w_h, gen_vvv, 32, gen_helper_vhsubw_w_h)
+TRANS(xvhsubw_d_w, gen_vvv, 32, gen_helper_vhsubw_d_w)
+TRANS(xvhsubw_q_d, gen_vvv, 32, gen_helper_vhsubw_q_d)
+TRANS(xvhsubw_hu_bu, gen_vvv, 32, gen_helper_vhsubw_hu_bu)
+TRANS(xvhsubw_wu_hu, gen_vvv, 32, gen_helper_vhsubw_wu_hu)
+TRANS(xvhsubw_du_wu, gen_vvv, 32, gen_helper_vhsubw_du_wu)
+TRANS(xvhsubw_qu_du, gen_vvv, 32, gen_helper_vhsubw_qu_du)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index a1370b90e6..109f852388 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -18,16 +18,18 @@ static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
     return true;
 }
 
-static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
-                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vvv(DisasContext *ctx, arg_vvv *a, uint32_t sz,
+                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
+                                 TCGv_i32, TCGv_i32))
 {
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
     CHECK_VEC;
 
-    func(cpu_env, vd, vj, vk);
+    func(cpu_env, oprsz, vd, vj, vk);
     return true;
 }
 
@@ -195,22 +197,22 @@ TRANS(vssub_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_ussub)
 TRANS(vssub_wu, gvec_vvv, 16, MO_32, tcg_gen_gvec_ussub)
 TRANS(vssub_du, gvec_vvv, 16, MO_64, tcg_gen_gvec_ussub)
 
-TRANS(vhaddw_h_b, gen_vvv, gen_helper_vhaddw_h_b)
-TRANS(vhaddw_w_h, gen_vvv, gen_helper_vhaddw_w_h)
-TRANS(vhaddw_d_w, gen_vvv, gen_helper_vhaddw_d_w)
-TRANS(vhaddw_q_d, gen_vvv, gen_helper_vhaddw_q_d)
-TRANS(vhaddw_hu_bu, gen_vvv, gen_helper_vhaddw_hu_bu)
-TRANS(vhaddw_wu_hu, gen_vvv, gen_helper_vhaddw_wu_hu)
-TRANS(vhaddw_du_wu, gen_vvv, gen_helper_vhaddw_du_wu)
-TRANS(vhaddw_qu_du, gen_vvv, gen_helper_vhaddw_qu_du)
-TRANS(vhsubw_h_b, gen_vvv, gen_helper_vhsubw_h_b)
-TRANS(vhsubw_w_h, gen_vvv, gen_helper_vhsubw_w_h)
-TRANS(vhsubw_d_w, gen_vvv, gen_helper_vhsubw_d_w)
-TRANS(vhsubw_q_d, gen_vvv, gen_helper_vhsubw_q_d)
-TRANS(vhsubw_hu_bu, gen_vvv, gen_helper_vhsubw_hu_bu)
-TRANS(vhsubw_wu_hu, gen_vvv, gen_helper_vhsubw_wu_hu)
-TRANS(vhsubw_du_wu, gen_vvv, gen_helper_vhsubw_du_wu)
-TRANS(vhsubw_qu_du, gen_vvv, gen_helper_vhsubw_qu_du)
+TRANS(vhaddw_h_b, gen_vvv, 16, gen_helper_vhaddw_h_b)
+TRANS(vhaddw_w_h, gen_vvv, 16, gen_helper_vhaddw_w_h)
+TRANS(vhaddw_d_w, gen_vvv, 16, gen_helper_vhaddw_d_w)
+TRANS(vhaddw_q_d, gen_vvv, 16, gen_helper_vhaddw_q_d)
+TRANS(vhaddw_hu_bu, gen_vvv, 16, gen_helper_vhaddw_hu_bu)
+TRANS(vhaddw_wu_hu, gen_vvv, 16, gen_helper_vhaddw_wu_hu)
+TRANS(vhaddw_du_wu, gen_vvv, 16, gen_helper_vhaddw_du_wu)
+TRANS(vhaddw_qu_du, gen_vvv, 16, gen_helper_vhaddw_qu_du)
+TRANS(vhsubw_h_b, gen_vvv, 16, gen_helper_vhsubw_h_b)
+TRANS(vhsubw_w_h, gen_vvv, 16, gen_helper_vhsubw_w_h)
+TRANS(vhsubw_d_w, gen_vvv, 16, gen_helper_vhsubw_d_w)
+TRANS(vhsubw_q_d, gen_vvv, 16, gen_helper_vhsubw_q_d)
+TRANS(vhsubw_hu_bu, gen_vvv, 16, gen_helper_vhsubw_hu_bu)
+TRANS(vhsubw_wu_hu, gen_vvv, 16, gen_helper_vhsubw_wu_hu)
+TRANS(vhsubw_du_wu, gen_vvv, 16, gen_helper_vhsubw_du_wu)
+TRANS(vhsubw_qu_du, gen_vvv, 16, gen_helper_vhsubw_qu_du)
 
 static void gen_vaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2714,22 +2716,22 @@ TRANS(vmaddwod_h_bu_b, gvec_vvv, 16, MO_8, do_vmaddwod_u_s)
 TRANS(vmaddwod_w_hu_h, gvec_vvv, 16, MO_16, do_vmaddwod_u_s)
 TRANS(vmaddwod_d_wu_w, gvec_vvv, 16, MO_32, do_vmaddwod_u_s)
 
-TRANS(vdiv_b, gen_vvv, gen_helper_vdiv_b)
-TRANS(vdiv_h, gen_vvv, gen_helper_vdiv_h)
-TRANS(vdiv_w, gen_vvv, gen_helper_vdiv_w)
-TRANS(vdiv_d, gen_vvv, gen_helper_vdiv_d)
-TRANS(vdiv_bu, gen_vvv, gen_helper_vdiv_bu)
-TRANS(vdiv_hu, gen_vvv, gen_helper_vdiv_hu)
-TRANS(vdiv_wu, gen_vvv, gen_helper_vdiv_wu)
-TRANS(vdiv_du, gen_vvv, gen_helper_vdiv_du)
-TRANS(vmod_b, gen_vvv, gen_helper_vmod_b)
-TRANS(vmod_h, gen_vvv, gen_helper_vmod_h)
-TRANS(vmod_w, gen_vvv, gen_helper_vmod_w)
-TRANS(vmod_d, gen_vvv, gen_helper_vmod_d)
-TRANS(vmod_bu, gen_vvv, gen_helper_vmod_bu)
-TRANS(vmod_hu, gen_vvv, gen_helper_vmod_hu)
-TRANS(vmod_wu, gen_vvv, gen_helper_vmod_wu)
-TRANS(vmod_du, gen_vvv, gen_helper_vmod_du)
+TRANS(vdiv_b, gen_vvv, 16, gen_helper_vdiv_b)
+TRANS(vdiv_h, gen_vvv, 16, gen_helper_vdiv_h)
+TRANS(vdiv_w, gen_vvv, 16, gen_helper_vdiv_w)
+TRANS(vdiv_d, gen_vvv, 16, gen_helper_vdiv_d)
+TRANS(vdiv_bu, gen_vvv, 16, gen_helper_vdiv_bu)
+TRANS(vdiv_hu, gen_vvv, 16, gen_helper_vdiv_hu)
+TRANS(vdiv_wu, gen_vvv, 16, gen_helper_vdiv_wu)
+TRANS(vdiv_du, gen_vvv, 16, gen_helper_vdiv_du)
+TRANS(vmod_b, gen_vvv, 16, gen_helper_vmod_b)
+TRANS(vmod_h, gen_vvv, 16, gen_helper_vmod_h)
+TRANS(vmod_w, gen_vvv, 16, gen_helper_vmod_w)
+TRANS(vmod_d, gen_vvv, 16, gen_helper_vmod_d)
+TRANS(vmod_bu, gen_vvv, 16, gen_helper_vmod_bu)
+TRANS(vmod_hu, gen_vvv, 16, gen_helper_vmod_hu)
+TRANS(vmod_wu, gen_vvv, 16, gen_helper_vmod_wu)
+TRANS(vmod_du, gen_vvv, 16, gen_helper_vmod_du)
 
 static void gen_vsat_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -3139,30 +3141,30 @@ TRANS(vsllwil_wu_hu, gen_vv_i, gen_helper_vsllwil_wu_hu)
 TRANS(vsllwil_du_wu, gen_vv_i, gen_helper_vsllwil_du_wu)
 TRANS(vextl_qu_du, gen_vv, gen_helper_vextl_qu_du)
 
-TRANS(vsrlr_b, gen_vvv, gen_helper_vsrlr_b)
-TRANS(vsrlr_h, gen_vvv, gen_helper_vsrlr_h)
-TRANS(vsrlr_w, gen_vvv, gen_helper_vsrlr_w)
-TRANS(vsrlr_d, gen_vvv, gen_helper_vsrlr_d)
+TRANS(vsrlr_b, gen_vvv, 16, gen_helper_vsrlr_b)
+TRANS(vsrlr_h, gen_vvv, 16, gen_helper_vsrlr_h)
+TRANS(vsrlr_w, gen_vvv, 16, gen_helper_vsrlr_w)
+TRANS(vsrlr_d, gen_vvv, 16, gen_helper_vsrlr_d)
 TRANS(vsrlri_b, gen_vv_i, gen_helper_vsrlri_b)
 TRANS(vsrlri_h, gen_vv_i, gen_helper_vsrlri_h)
 TRANS(vsrlri_w, gen_vv_i, gen_helper_vsrlri_w)
 TRANS(vsrlri_d, gen_vv_i, gen_helper_vsrlri_d)
 
-TRANS(vsrar_b, gen_vvv, gen_helper_vsrar_b)
-TRANS(vsrar_h, gen_vvv, gen_helper_vsrar_h)
-TRANS(vsrar_w, gen_vvv, gen_helper_vsrar_w)
-TRANS(vsrar_d, gen_vvv, gen_helper_vsrar_d)
+TRANS(vsrar_b, gen_vvv, 16, gen_helper_vsrar_b)
+TRANS(vsrar_h, gen_vvv, 16, gen_helper_vsrar_h)
+TRANS(vsrar_w, gen_vvv, 16, gen_helper_vsrar_w)
+TRANS(vsrar_d, gen_vvv, 16, gen_helper_vsrar_d)
 TRANS(vsrari_b, gen_vv_i, gen_helper_vsrari_b)
 TRANS(vsrari_h, gen_vv_i, gen_helper_vsrari_h)
 TRANS(vsrari_w, gen_vv_i, gen_helper_vsrari_w)
 TRANS(vsrari_d, gen_vv_i, gen_helper_vsrari_d)
 
-TRANS(vsrln_b_h, gen_vvv, gen_helper_vsrln_b_h)
-TRANS(vsrln_h_w, gen_vvv, gen_helper_vsrln_h_w)
-TRANS(vsrln_w_d, gen_vvv, gen_helper_vsrln_w_d)
-TRANS(vsran_b_h, gen_vvv, gen_helper_vsran_b_h)
-TRANS(vsran_h_w, gen_vvv, gen_helper_vsran_h_w)
-TRANS(vsran_w_d, gen_vvv, gen_helper_vsran_w_d)
+TRANS(vsrln_b_h, gen_vvv, 16, gen_helper_vsrln_b_h)
+TRANS(vsrln_h_w, gen_vvv, 16, gen_helper_vsrln_h_w)
+TRANS(vsrln_w_d, gen_vvv, 16, gen_helper_vsrln_w_d)
+TRANS(vsran_b_h, gen_vvv, 16, gen_helper_vsran_b_h)
+TRANS(vsran_h_w, gen_vvv, 16, gen_helper_vsran_h_w)
+TRANS(vsran_w_d, gen_vvv, 16, gen_helper_vsran_w_d)
 
 TRANS(vsrlni_b_h, gen_vv_i, gen_helper_vsrlni_b_h)
 TRANS(vsrlni_h_w, gen_vv_i, gen_helper_vsrlni_h_w)
@@ -3173,12 +3175,12 @@ TRANS(vsrani_h_w, gen_vv_i, gen_helper_vsrani_h_w)
 TRANS(vsrani_w_d, gen_vv_i, gen_helper_vsrani_w_d)
 TRANS(vsrani_d_q, gen_vv_i, gen_helper_vsrani_d_q)
 
-TRANS(vsrlrn_b_h, gen_vvv, gen_helper_vsrlrn_b_h)
-TRANS(vsrlrn_h_w, gen_vvv, gen_helper_vsrlrn_h_w)
-TRANS(vsrlrn_w_d, gen_vvv, gen_helper_vsrlrn_w_d)
-TRANS(vsrarn_b_h, gen_vvv, gen_helper_vsrarn_b_h)
-TRANS(vsrarn_h_w, gen_vvv, gen_helper_vsrarn_h_w)
-TRANS(vsrarn_w_d, gen_vvv, gen_helper_vsrarn_w_d)
+TRANS(vsrlrn_b_h, gen_vvv, 16, gen_helper_vsrlrn_b_h)
+TRANS(vsrlrn_h_w, gen_vvv, 16, gen_helper_vsrlrn_h_w)
+TRANS(vsrlrn_w_d, gen_vvv, 16, gen_helper_vsrlrn_w_d)
+TRANS(vsrarn_b_h, gen_vvv, 16, gen_helper_vsrarn_b_h)
+TRANS(vsrarn_h_w, gen_vvv, 16, gen_helper_vsrarn_h_w)
+TRANS(vsrarn_w_d, gen_vvv, 16, gen_helper_vsrarn_w_d)
 
 TRANS(vsrlrni_b_h, gen_vv_i, gen_helper_vsrlrni_b_h)
 TRANS(vsrlrni_h_w, gen_vv_i, gen_helper_vsrlrni_h_w)
@@ -3189,18 +3191,18 @@ TRANS(vsrarni_h_w, gen_vv_i, gen_helper_vsrarni_h_w)
 TRANS(vsrarni_w_d, gen_vv_i, gen_helper_vsrarni_w_d)
 TRANS(vsrarni_d_q, gen_vv_i, gen_helper_vsrarni_d_q)
 
-TRANS(vssrln_b_h, gen_vvv, gen_helper_vssrln_b_h)
-TRANS(vssrln_h_w, gen_vvv, gen_helper_vssrln_h_w)
-TRANS(vssrln_w_d, gen_vvv, gen_helper_vssrln_w_d)
-TRANS(vssran_b_h, gen_vvv, gen_helper_vssran_b_h)
-TRANS(vssran_h_w, gen_vvv, gen_helper_vssran_h_w)
-TRANS(vssran_w_d, gen_vvv, gen_helper_vssran_w_d)
-TRANS(vssrln_bu_h, gen_vvv, gen_helper_vssrln_bu_h)
-TRANS(vssrln_hu_w, gen_vvv, gen_helper_vssrln_hu_w)
-TRANS(vssrln_wu_d, gen_vvv, gen_helper_vssrln_wu_d)
-TRANS(vssran_bu_h, gen_vvv, gen_helper_vssran_bu_h)
-TRANS(vssran_hu_w, gen_vvv, gen_helper_vssran_hu_w)
-TRANS(vssran_wu_d, gen_vvv, gen_helper_vssran_wu_d)
+TRANS(vssrln_b_h, gen_vvv, 16, gen_helper_vssrln_b_h)
+TRANS(vssrln_h_w, gen_vvv, 16, gen_helper_vssrln_h_w)
+TRANS(vssrln_w_d, gen_vvv, 16, gen_helper_vssrln_w_d)
+TRANS(vssran_b_h, gen_vvv, 16, gen_helper_vssran_b_h)
+TRANS(vssran_h_w, gen_vvv, 16, gen_helper_vssran_h_w)
+TRANS(vssran_w_d, gen_vvv, 16, gen_helper_vssran_w_d)
+TRANS(vssrln_bu_h, gen_vvv, 16, gen_helper_vssrln_bu_h)
+TRANS(vssrln_hu_w, gen_vvv, 16, gen_helper_vssrln_hu_w)
+TRANS(vssrln_wu_d, gen_vvv, 16, gen_helper_vssrln_wu_d)
+TRANS(vssran_bu_h, gen_vvv, 16, gen_helper_vssran_bu_h)
+TRANS(vssran_hu_w, gen_vvv, 16, gen_helper_vssran_hu_w)
+TRANS(vssran_wu_d, gen_vvv, 16, gen_helper_vssran_wu_d)
 
 TRANS(vssrlni_b_h, gen_vv_i, gen_helper_vssrlni_b_h)
 TRANS(vssrlni_h_w, gen_vv_i, gen_helper_vssrlni_h_w)
@@ -3219,18 +3221,18 @@ TRANS(vssrani_hu_w, gen_vv_i, gen_helper_vssrani_hu_w)
 TRANS(vssrani_wu_d, gen_vv_i, gen_helper_vssrani_wu_d)
 TRANS(vssrani_du_q, gen_vv_i, gen_helper_vssrani_du_q)
 
-TRANS(vssrlrn_b_h, gen_vvv, gen_helper_vssrlrn_b_h)
-TRANS(vssrlrn_h_w, gen_vvv, gen_helper_vssrlrn_h_w)
-TRANS(vssrlrn_w_d, gen_vvv, gen_helper_vssrlrn_w_d)
-TRANS(vssrarn_b_h, gen_vvv, gen_helper_vssrarn_b_h)
-TRANS(vssrarn_h_w, gen_vvv, gen_helper_vssrarn_h_w)
-TRANS(vssrarn_w_d, gen_vvv, gen_helper_vssrarn_w_d)
-TRANS(vssrlrn_bu_h, gen_vvv, gen_helper_vssrlrn_bu_h)
-TRANS(vssrlrn_hu_w, gen_vvv, gen_helper_vssrlrn_hu_w)
-TRANS(vssrlrn_wu_d, gen_vvv, gen_helper_vssrlrn_wu_d)
-TRANS(vssrarn_bu_h, gen_vvv, gen_helper_vssrarn_bu_h)
-TRANS(vssrarn_hu_w, gen_vvv, gen_helper_vssrarn_hu_w)
-TRANS(vssrarn_wu_d, gen_vvv, gen_helper_vssrarn_wu_d)
+TRANS(vssrlrn_b_h, gen_vvv, 16, gen_helper_vssrlrn_b_h)
+TRANS(vssrlrn_h_w, gen_vvv, 16, gen_helper_vssrlrn_h_w)
+TRANS(vssrlrn_w_d, gen_vvv, 16, gen_helper_vssrlrn_w_d)
+TRANS(vssrarn_b_h, gen_vvv, 16, gen_helper_vssrarn_b_h)
+TRANS(vssrarn_h_w, gen_vvv, 16, gen_helper_vssrarn_h_w)
+TRANS(vssrarn_w_d, gen_vvv, 16, gen_helper_vssrarn_w_d)
+TRANS(vssrlrn_bu_h, gen_vvv, 16, gen_helper_vssrlrn_bu_h)
+TRANS(vssrlrn_hu_w, gen_vvv, 16, gen_helper_vssrlrn_hu_w)
+TRANS(vssrlrn_wu_d, gen_vvv, 16, gen_helper_vssrlrn_wu_d)
+TRANS(vssrarn_bu_h, gen_vvv, 16, gen_helper_vssrarn_bu_h)
+TRANS(vssrarn_hu_w, gen_vvv, 16, gen_helper_vssrarn_hu_w)
+TRANS(vssrarn_wu_d, gen_vvv, 16, gen_helper_vssrarn_wu_d)
 
 TRANS(vssrlrni_b_h, gen_vv_i, gen_helper_vssrlrni_b_h)
 TRANS(vssrlrni_h_w, gen_vv_i, gen_helper_vssrlrni_h_w)
@@ -3568,19 +3570,19 @@ TRANS(vbitrevi_h, gvec_vv_i, 16, MO_16, do_vbitrevi)
 TRANS(vbitrevi_w, gvec_vv_i, 16, MO_32, do_vbitrevi)
 TRANS(vbitrevi_d, gvec_vv_i, 16, MO_64, do_vbitrevi)
 
-TRANS(vfrstp_b, gen_vvv, gen_helper_vfrstp_b)
-TRANS(vfrstp_h, gen_vvv, gen_helper_vfrstp_h)
+TRANS(vfrstp_b, gen_vvv, 16, gen_helper_vfrstp_b)
+TRANS(vfrstp_h, gen_vvv, 16, gen_helper_vfrstp_h)
 TRANS(vfrstpi_b, gen_vv_i, gen_helper_vfrstpi_b)
 TRANS(vfrstpi_h, gen_vv_i, gen_helper_vfrstpi_h)
 
-TRANS(vfadd_s, gen_vvv, gen_helper_vfadd_s)
-TRANS(vfadd_d, gen_vvv, gen_helper_vfadd_d)
-TRANS(vfsub_s, gen_vvv, gen_helper_vfsub_s)
-TRANS(vfsub_d, gen_vvv, gen_helper_vfsub_d)
-TRANS(vfmul_s, gen_vvv, gen_helper_vfmul_s)
-TRANS(vfmul_d, gen_vvv, gen_helper_vfmul_d)
-TRANS(vfdiv_s, gen_vvv, gen_helper_vfdiv_s)
-TRANS(vfdiv_d, gen_vvv, gen_helper_vfdiv_d)
+TRANS(vfadd_s, gen_vvv, 16, gen_helper_vfadd_s)
+TRANS(vfadd_d, gen_vvv, 16, gen_helper_vfadd_d)
+TRANS(vfsub_s, gen_vvv, 16, gen_helper_vfsub_s)
+TRANS(vfsub_d, gen_vvv, 16, gen_helper_vfsub_d)
+TRANS(vfmul_s, gen_vvv, 16, gen_helper_vfmul_s)
+TRANS(vfmul_d, gen_vvv, 16, gen_helper_vfmul_d)
+TRANS(vfdiv_s, gen_vvv, 16, gen_helper_vfdiv_s)
+TRANS(vfdiv_d, gen_vvv, 16, gen_helper_vfdiv_d)
 
 TRANS(vfmadd_s, gen_vvvv, gen_helper_vfmadd_s)
 TRANS(vfmadd_d, gen_vvvv, gen_helper_vfmadd_d)
@@ -3591,15 +3593,15 @@ TRANS(vfnmadd_d, gen_vvvv, gen_helper_vfnmadd_d)
 TRANS(vfnmsub_s, gen_vvvv, gen_helper_vfnmsub_s)
 TRANS(vfnmsub_d, gen_vvvv, gen_helper_vfnmsub_d)
 
-TRANS(vfmax_s, gen_vvv, gen_helper_vfmax_s)
-TRANS(vfmax_d, gen_vvv, gen_helper_vfmax_d)
-TRANS(vfmin_s, gen_vvv, gen_helper_vfmin_s)
-TRANS(vfmin_d, gen_vvv, gen_helper_vfmin_d)
+TRANS(vfmax_s, gen_vvv, 16, gen_helper_vfmax_s)
+TRANS(vfmax_d, gen_vvv, 16, gen_helper_vfmax_d)
+TRANS(vfmin_s, gen_vvv, 16, gen_helper_vfmin_s)
+TRANS(vfmin_d, gen_vvv, 16, gen_helper_vfmin_d)
 
-TRANS(vfmaxa_s, gen_vvv, gen_helper_vfmaxa_s)
-TRANS(vfmaxa_d, gen_vvv, gen_helper_vfmaxa_d)
-TRANS(vfmina_s, gen_vvv, gen_helper_vfmina_s)
-TRANS(vfmina_d, gen_vvv, gen_helper_vfmina_d)
+TRANS(vfmaxa_s, gen_vvv, 16, gen_helper_vfmaxa_s)
+TRANS(vfmaxa_d, gen_vvv, 16, gen_helper_vfmaxa_d)
+TRANS(vfmina_s, gen_vvv, 16, gen_helper_vfmina_s)
+TRANS(vfmina_d, gen_vvv, 16, gen_helper_vfmina_d)
 
 TRANS(vflogb_s, gen_vv, gen_helper_vflogb_s)
 TRANS(vflogb_d, gen_vv, gen_helper_vflogb_d)
@@ -3618,8 +3620,8 @@ TRANS(vfcvtl_s_h, gen_vv, gen_helper_vfcvtl_s_h)
 TRANS(vfcvth_s_h, gen_vv, gen_helper_vfcvth_s_h)
 TRANS(vfcvtl_d_s, gen_vv, gen_helper_vfcvtl_d_s)
 TRANS(vfcvth_d_s, gen_vv, gen_helper_vfcvth_d_s)
-TRANS(vfcvt_h_s, gen_vvv, gen_helper_vfcvt_h_s)
-TRANS(vfcvt_s_d, gen_vvv, gen_helper_vfcvt_s_d)
+TRANS(vfcvt_h_s, gen_vvv, 16, gen_helper_vfcvt_h_s)
+TRANS(vfcvt_s_d, gen_vvv, 16, gen_helper_vfcvt_s_d)
 
 TRANS(vfrintrne_s, gen_vv, gen_helper_vfrintrne_s)
 TRANS(vfrintrne_d, gen_vv, gen_helper_vfrintrne_d)
@@ -3646,11 +3648,11 @@ TRANS(vftintrz_wu_s, gen_vv, gen_helper_vftintrz_wu_s)
 TRANS(vftintrz_lu_d, gen_vv, gen_helper_vftintrz_lu_d)
 TRANS(vftint_wu_s, gen_vv, gen_helper_vftint_wu_s)
 TRANS(vftint_lu_d, gen_vv, gen_helper_vftint_lu_d)
-TRANS(vftintrne_w_d, gen_vvv, gen_helper_vftintrne_w_d)
-TRANS(vftintrz_w_d, gen_vvv, gen_helper_vftintrz_w_d)
-TRANS(vftintrp_w_d, gen_vvv, gen_helper_vftintrp_w_d)
-TRANS(vftintrm_w_d, gen_vvv, gen_helper_vftintrm_w_d)
-TRANS(vftint_w_d, gen_vvv, gen_helper_vftint_w_d)
+TRANS(vftintrne_w_d, gen_vvv, 16, gen_helper_vftintrne_w_d)
+TRANS(vftintrz_w_d, gen_vvv, 16, gen_helper_vftintrz_w_d)
+TRANS(vftintrp_w_d, gen_vvv, 16, gen_helper_vftintrp_w_d)
+TRANS(vftintrm_w_d, gen_vvv, 16, gen_helper_vftintrm_w_d)
+TRANS(vftint_w_d, gen_vvv, 16, gen_helper_vftint_w_d)
 TRANS(vftintrnel_l_s, gen_vv, gen_helper_vftintrnel_l_s)
 TRANS(vftintrneh_l_s, gen_vv, gen_helper_vftintrneh_l_s)
 TRANS(vftintrzl_l_s, gen_vv, gen_helper_vftintrzl_l_s)
@@ -3668,7 +3670,7 @@ TRANS(vffint_s_wu, gen_vv, gen_helper_vffint_s_wu)
 TRANS(vffint_d_lu, gen_vv, gen_helper_vffint_d_lu)
 TRANS(vffintl_d_w, gen_vv, gen_helper_vffintl_d_w)
 TRANS(vffinth_d_w, gen_vv, gen_helper_vffinth_d_w)
-TRANS(vffint_s_l, gen_vvv, gen_helper_vffint_s_l)
+TRANS(vffint_s_l, gen_vvv, 16, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
@@ -4200,37 +4202,37 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     return true;
 }
 
-TRANS(vpackev_b, gen_vvv, gen_helper_vpackev_b)
-TRANS(vpackev_h, gen_vvv, gen_helper_vpackev_h)
-TRANS(vpackev_w, gen_vvv, gen_helper_vpackev_w)
-TRANS(vpackev_d, gen_vvv, gen_helper_vpackev_d)
-TRANS(vpackod_b, gen_vvv, gen_helper_vpackod_b)
-TRANS(vpackod_h, gen_vvv, gen_helper_vpackod_h)
-TRANS(vpackod_w, gen_vvv, gen_helper_vpackod_w)
-TRANS(vpackod_d, gen_vvv, gen_helper_vpackod_d)
-
-TRANS(vpickev_b, gen_vvv, gen_helper_vpickev_b)
-TRANS(vpickev_h, gen_vvv, gen_helper_vpickev_h)
-TRANS(vpickev_w, gen_vvv, gen_helper_vpickev_w)
-TRANS(vpickev_d, gen_vvv, gen_helper_vpickev_d)
-TRANS(vpickod_b, gen_vvv, gen_helper_vpickod_b)
-TRANS(vpickod_h, gen_vvv, gen_helper_vpickod_h)
-TRANS(vpickod_w, gen_vvv, gen_helper_vpickod_w)
-TRANS(vpickod_d, gen_vvv, gen_helper_vpickod_d)
-
-TRANS(vilvl_b, gen_vvv, gen_helper_vilvl_b)
-TRANS(vilvl_h, gen_vvv, gen_helper_vilvl_h)
-TRANS(vilvl_w, gen_vvv, gen_helper_vilvl_w)
-TRANS(vilvl_d, gen_vvv, gen_helper_vilvl_d)
-TRANS(vilvh_b, gen_vvv, gen_helper_vilvh_b)
-TRANS(vilvh_h, gen_vvv, gen_helper_vilvh_h)
-TRANS(vilvh_w, gen_vvv, gen_helper_vilvh_w)
-TRANS(vilvh_d, gen_vvv, gen_helper_vilvh_d)
+TRANS(vpackev_b, gen_vvv, 16, gen_helper_vpackev_b)
+TRANS(vpackev_h, gen_vvv, 16, gen_helper_vpackev_h)
+TRANS(vpackev_w, gen_vvv, 16, gen_helper_vpackev_w)
+TRANS(vpackev_d, gen_vvv, 16, gen_helper_vpackev_d)
+TRANS(vpackod_b, gen_vvv, 16, gen_helper_vpackod_b)
+TRANS(vpackod_h, gen_vvv, 16, gen_helper_vpackod_h)
+TRANS(vpackod_w, gen_vvv, 16, gen_helper_vpackod_w)
+TRANS(vpackod_d, gen_vvv, 16, gen_helper_vpackod_d)
+
+TRANS(vpickev_b, gen_vvv, 16, gen_helper_vpickev_b)
+TRANS(vpickev_h, gen_vvv, 16, gen_helper_vpickev_h)
+TRANS(vpickev_w, gen_vvv, 16, gen_helper_vpickev_w)
+TRANS(vpickev_d, gen_vvv, 16, gen_helper_vpickev_d)
+TRANS(vpickod_b, gen_vvv, 16, gen_helper_vpickod_b)
+TRANS(vpickod_h, gen_vvv, 16, gen_helper_vpickod_h)
+TRANS(vpickod_w, gen_vvv, 16, gen_helper_vpickod_w)
+TRANS(vpickod_d, gen_vvv, 16, gen_helper_vpickod_d)
+
+TRANS(vilvl_b, gen_vvv, 16, gen_helper_vilvl_b)
+TRANS(vilvl_h, gen_vvv, 16, gen_helper_vilvl_h)
+TRANS(vilvl_w, gen_vvv, 16, gen_helper_vilvl_w)
+TRANS(vilvl_d, gen_vvv, 16, gen_helper_vilvl_d)
+TRANS(vilvh_b, gen_vvv, 16, gen_helper_vilvh_b)
+TRANS(vilvh_h, gen_vvv, 16, gen_helper_vilvh_h)
+TRANS(vilvh_w, gen_vvv, 16, gen_helper_vilvh_w)
+TRANS(vilvh_d, gen_vvv, 16, gen_helper_vilvh_d)
 
 TRANS(vshuf_b, gen_vvvv, gen_helper_vshuf_b)
-TRANS(vshuf_h, gen_vvv, gen_helper_vshuf_h)
-TRANS(vshuf_w, gen_vvv, gen_helper_vshuf_w)
-TRANS(vshuf_d, gen_vvv, gen_helper_vshuf_d)
+TRANS(vshuf_h, gen_vvv, 16, gen_helper_vshuf_h)
+TRANS(vshuf_w, gen_vvv, 16, gen_helper_vshuf_w)
+TRANS(vshuf_d, gen_vvv, 16, gen_helper_vshuf_d)
 TRANS(vshuf4i_b, gen_vv_i, gen_helper_vshuf4i_b)
 TRANS(vshuf4i_h, gen_vv_i, gen_helper_vshuf4i_h)
 TRANS(vshuf4i_w, gen_vv_i, gen_helper_vshuf4i_w)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 32f857ff7c..ba0b36f4a7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1343,6 +1343,24 @@ xvssub_hu        0111 01000100 11001 ..... ..... .....    @vvv
 xvssub_wu        0111 01000100 11010 ..... ..... .....    @vvv
 xvssub_du        0111 01000100 11011 ..... ..... .....    @vvv
 
+xvhaddw_h_b      0111 01000101 01000 ..... ..... .....    @vvv
+xvhaddw_w_h      0111 01000101 01001 ..... ..... .....    @vvv
+xvhaddw_d_w      0111 01000101 01010 ..... ..... .....    @vvv
+xvhaddw_q_d      0111 01000101 01011 ..... ..... .....    @vvv
+xvhaddw_hu_bu    0111 01000101 10000 ..... ..... .....    @vvv
+xvhaddw_wu_hu    0111 01000101 10001 ..... ..... .....    @vvv
+xvhaddw_du_wu    0111 01000101 10010 ..... ..... .....    @vvv
+xvhaddw_qu_du    0111 01000101 10011 ..... ..... .....    @vvv
+
+xvhsubw_h_b      0111 01000101 01100 ..... ..... .....    @vvv
+xvhsubw_w_h      0111 01000101 01101 ..... ..... .....    @vvv
+xvhsubw_d_w      0111 01000101 01110 ..... ..... .....    @vvv
+xvhsubw_q_d      0111 01000101 01111 ..... ..... .....    @vvv
+xvhsubw_hu_bu    0111 01000101 10100 ..... ..... .....    @vvv
+xvhsubw_wu_hu    0111 01000101 10101 ..... ..... .....    @vvv
+xvhsubw_du_wu    0111 01000101 10110 ..... ..... .....    @vvv
+xvhsubw_qu_du    0111 01000101 10111 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
index b7a27df5a9..7fbf045a5d 100644
--- a/target/loongarch/meson.build
+++ b/target/loongarch/meson.build
@@ -11,7 +11,7 @@ loongarch_tcg_ss.add(files(
   'op_helper.c',
   'translate.c',
   'gdbstub.c',
-  'lsx_helper.c',
+  'vec_helper.c',
 ))
 loongarch_tcg_ss.add(zlib)
 
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index f032aee327..6ff89ebda8 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -47,4 +47,7 @@
 #define Q(x)  Q[x]
 #endif /* HOST_BIG_ENDIAN */
 
+#define DO_ADD(a, b)  (a + b)
+#define DO_SUB(a, b)  (a - b)
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/vec_helper.c
similarity index 99%
rename from target/loongarch/lsx_helper.c
rename to target/loongarch/vec_helper.c
index b231a2798b..bd7389407b 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -14,20 +14,18 @@
 #include "tcg/tcg.h"
 #include "vec.h"
 
-#define DO_ADD(a, b)  (a + b)
-#define DO_SUB(a, b)  (a - b)
-
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
-void HELPER(NAME)(CPULoongArchState *env,                            \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,            \
                   uint32_t vd, uint32_t vj, uint32_t vk)             \
 {                                                                    \
-    int i;                                                           \
+    int i, len;                                                      \
     VReg *Vd = &(env->fpr[vd].vreg);                                 \
     VReg *Vj = &(env->fpr[vj].vreg);                                 \
     VReg *Vk = &(env->fpr[vk].vreg);                                 \
     typedef __typeof(Vd->E1(0)) TD;                                  \
                                                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                              \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                        \
+    for (i = 0; i < len / BIT ; i++) {                               \
         Vd->E1(i) = DO_OP((TD)Vj->E2(2 * i + 1), (TD)Vk->E2(2 * i)); \
     }                                                                \
 }
@@ -36,7 +34,7 @@ DO_ODD_EVEN(vhaddw_h_b, 16, H, B, DO_ADD)
 DO_ODD_EVEN(vhaddw_w_h, 32, W, H, DO_ADD)
 DO_ODD_EVEN(vhaddw_d_w, 64, D, W, DO_ADD)
 
-void HELPER(vhaddw_q_d)(CPULoongArchState *env,
+void HELPER(vhaddw_q_d)(CPULoongArchState *env, uint32_t oprsz,
                         uint32_t vd, uint32_t vj, uint32_t vk)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
@@ -44,13 +42,17 @@ void HELPER(vhaddw_q_d)(CPULoongArchState *env,
     VReg *Vk = &(env->fpr[vk].vreg);
 
     Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_add(int128_makes64(Vj->D(3)),
+                              int128_makes64(Vk->D(2)));
+    }
 }
 
 DO_ODD_EVEN(vhsubw_h_b, 16, H, B, DO_SUB)
 DO_ODD_EVEN(vhsubw_w_h, 32, W, H, DO_SUB)
 DO_ODD_EVEN(vhsubw_d_w, 64, D, W, DO_SUB)
 
-void HELPER(vhsubw_q_d)(CPULoongArchState *env,
+void HELPER(vhsubw_q_d)(CPULoongArchState *env, uint32_t oprsz,
                         uint32_t vd, uint32_t vj, uint32_t vk)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
@@ -58,36 +60,46 @@ void HELPER(vhsubw_q_d)(CPULoongArchState *env,
     VReg *Vk = &(env->fpr[vk].vreg);
 
     Vd->Q(0) = int128_sub(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_sub(int128_makes64(Vj->D(3)),
+                              int128_makes64(Vk->D(2)));
+    }
 }
 
 DO_ODD_EVEN(vhaddw_hu_bu, 16, UH, UB, DO_ADD)
 DO_ODD_EVEN(vhaddw_wu_hu, 32, UW, UH, DO_ADD)
 DO_ODD_EVEN(vhaddw_du_wu, 64, UD, UW, DO_ADD)
 
-void HELPER(vhaddw_qu_du)(CPULoongArchState *env,
+void HELPER(vhaddw_qu_du)(CPULoongArchState *env, uint32_t oprsz,
                           uint32_t vd, uint32_t vj, uint32_t vk)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
     VReg *Vk = &(env->fpr[vk].vreg);
 
-    Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    Vd->Q(0) = int128_add(int128_make64(Vj->UD(1)), int128_make64(Vk->UD(0)));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_add(int128_make64(Vj->UD(3)),
+                              int128_make64(Vk->UD(2)));
+    }
 }
 
 DO_ODD_EVEN(vhsubw_hu_bu, 16, UH, UB, DO_SUB)
 DO_ODD_EVEN(vhsubw_wu_hu, 32, UW, UH, DO_SUB)
 DO_ODD_EVEN(vhsubw_du_wu, 64, UD, UW, DO_SUB)
 
-void HELPER(vhsubw_qu_du)(CPULoongArchState *env,
+void HELPER(vhsubw_qu_du)(CPULoongArchState *env, uint32_t oprsz,
                           uint32_t vd, uint32_t vj, uint32_t vk)
 {
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
     VReg *Vk = &(env->fpr[vk].vreg);
 
-    Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(1)),
-                          int128_make64((uint64_t)Vk->D(0)));
+    Vd->Q(0) = int128_sub(int128_make64(Vj->UD(1)), int128_make64(Vk->UD(0)));
+    if (oprsz == 32) {
+        Vd->Q(1) = int128_sub(int128_make64(Vj->UD(3)),
+                              int128_make64(Vk->UD(2)));
+    }
 }
 
 #define DO_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
-- 
2.39.1


