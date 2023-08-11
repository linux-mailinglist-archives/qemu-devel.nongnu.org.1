Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D152778A8B
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 12:02:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOyS-0006fb-W1; Fri, 11 Aug 2023 06:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qUOyQ-0006b0-NI
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qUOyJ-0002FE-Jf
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 06:02:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx5fAoB9Zk0YAVAA--.45960S3;
 Fri, 11 Aug 2023 18:02:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxTSMhB9ZkBcpUAA--.61494S9; 
 Fri, 11 Aug 2023 18:02:15 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, c@jia.je
Subject: [PATCH v2 7/8] target/loongarch: Add avail_LSX to check LSX
 instructions
Date: Fri, 11 Aug 2023 18:02:07 +0800
Message-Id: <20230811100208.271649-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230811100208.271649-1-gaosong@loongson.cn>
References: <20230811100208.271649-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxTSMhB9ZkBcpUAA--.61494S9
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insn_trans/trans_lsx.c.inc | 1482 ++++++++++---------
 target/loongarch/translate.h                |    2 +
 2 files changed, 823 insertions(+), 661 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 45e0e738ad..5fbf2718f7 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -135,16 +135,20 @@ static bool gvec_subi(DisasContext *ctx, arg_vv_i *a, MemOp mop)
     return true;
 }
 
-TRANS(vadd_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_add)
-TRANS(vadd_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_add)
-TRANS(vadd_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_add)
-TRANS(vadd_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_add)
+TRANS(vadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_add)
+TRANS(vadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_add)
+TRANS(vadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_add)
+TRANS(vadd_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_add)
 
 #define VADDSUB_Q(NAME)                                        \
 static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 {                                                              \
     TCGv_i64 rh, rl, ah, al, bh, bl;                           \
                                                                \
+    if (!avail_LSX(ctx)) {                                     \
+        return false;                                          \
+    }                                                          \
+                                                               \
     CHECK_SXE;                                                 \
                                                                \
     rh = tcg_temp_new_i64();                                   \
@@ -170,58 +174,58 @@ static bool trans_v## NAME ##_q(DisasContext *ctx, arg_vvv *a) \
 VADDSUB_Q(add)
 VADDSUB_Q(sub)
 
-TRANS(vsub_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sub)
-TRANS(vsub_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sub)
-TRANS(vsub_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sub)
-TRANS(vsub_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sub)
-
-TRANS(vaddi_bu, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
-TRANS(vaddi_hu, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
-TRANS(vaddi_wu, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_addi)
-TRANS(vaddi_du, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_addi)
-TRANS(vsubi_bu, ALL, gvec_subi, MO_8)
-TRANS(vsubi_hu, ALL, gvec_subi, MO_16)
-TRANS(vsubi_wu, ALL, gvec_subi, MO_32)
-TRANS(vsubi_du, ALL, gvec_subi, MO_64)
-
-TRANS(vneg_b, ALL, gvec_vv, MO_8, tcg_gen_gvec_neg)
-TRANS(vneg_h, ALL, gvec_vv, MO_16, tcg_gen_gvec_neg)
-TRANS(vneg_w, ALL, gvec_vv, MO_32, tcg_gen_gvec_neg)
-TRANS(vneg_d, ALL, gvec_vv, MO_64, tcg_gen_gvec_neg)
-
-TRANS(vsadd_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
-TRANS(vsadd_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
-TRANS(vsadd_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
-TRANS(vsadd_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
-TRANS(vsadd_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
-TRANS(vsadd_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
-TRANS(vsadd_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
-TRANS(vsadd_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
-TRANS(vssub_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
-TRANS(vssub_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
-TRANS(vssub_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
-TRANS(vssub_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
-TRANS(vssub_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
-TRANS(vssub_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
-TRANS(vssub_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
-TRANS(vssub_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
-
-TRANS(vhaddw_h_b, ALL, gen_vvv, gen_helper_vhaddw_h_b)
-TRANS(vhaddw_w_h, ALL, gen_vvv, gen_helper_vhaddw_w_h)
-TRANS(vhaddw_d_w, ALL, gen_vvv, gen_helper_vhaddw_d_w)
-TRANS(vhaddw_q_d, ALL, gen_vvv, gen_helper_vhaddw_q_d)
-TRANS(vhaddw_hu_bu, ALL, gen_vvv, gen_helper_vhaddw_hu_bu)
-TRANS(vhaddw_wu_hu, ALL, gen_vvv, gen_helper_vhaddw_wu_hu)
-TRANS(vhaddw_du_wu, ALL, gen_vvv, gen_helper_vhaddw_du_wu)
-TRANS(vhaddw_qu_du, ALL, gen_vvv, gen_helper_vhaddw_qu_du)
-TRANS(vhsubw_h_b, ALL, gen_vvv, gen_helper_vhsubw_h_b)
-TRANS(vhsubw_w_h, ALL, gen_vvv, gen_helper_vhsubw_w_h)
-TRANS(vhsubw_d_w, ALL, gen_vvv, gen_helper_vhsubw_d_w)
-TRANS(vhsubw_q_d, ALL, gen_vvv, gen_helper_vhsubw_q_d)
-TRANS(vhsubw_hu_bu, ALL, gen_vvv, gen_helper_vhsubw_hu_bu)
-TRANS(vhsubw_wu_hu, ALL, gen_vvv, gen_helper_vhsubw_wu_hu)
-TRANS(vhsubw_du_wu, ALL, gen_vvv, gen_helper_vhsubw_du_wu)
-TRANS(vhsubw_qu_du, ALL, gen_vvv, gen_helper_vhsubw_qu_du)
+TRANS(vsub_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sub)
+TRANS(vsub_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sub)
+TRANS(vsub_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sub)
+TRANS(vsub_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sub)
+
+TRANS(vaddi_bu, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_addi)
+TRANS(vaddi_hu, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_addi)
+TRANS(vaddi_wu, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_addi)
+TRANS(vaddi_du, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_addi)
+TRANS(vsubi_bu, LSX, gvec_subi, MO_8)
+TRANS(vsubi_hu, LSX, gvec_subi, MO_16)
+TRANS(vsubi_wu, LSX, gvec_subi, MO_32)
+TRANS(vsubi_du, LSX, gvec_subi, MO_64)
+
+TRANS(vneg_b, LSX, gvec_vv, MO_8, tcg_gen_gvec_neg)
+TRANS(vneg_h, LSX, gvec_vv, MO_16, tcg_gen_gvec_neg)
+TRANS(vneg_w, LSX, gvec_vv, MO_32, tcg_gen_gvec_neg)
+TRANS(vneg_d, LSX, gvec_vv, MO_64, tcg_gen_gvec_neg)
+
+TRANS(vsadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
+TRANS(vsadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
+TRANS(vsadd_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_ssadd)
+TRANS(vsadd_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_ssadd)
+TRANS(vsadd_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_usadd)
+TRANS(vsadd_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_usadd)
+TRANS(vsadd_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_usadd)
+TRANS(vsadd_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_usadd)
+TRANS(vssub_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sssub)
+TRANS(vssub_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sssub)
+TRANS(vssub_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sssub)
+TRANS(vssub_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sssub)
+TRANS(vssub_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_ussub)
+TRANS(vssub_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_ussub)
+TRANS(vssub_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_ussub)
+TRANS(vssub_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_ussub)
+
+TRANS(vhaddw_h_b, LSX, gen_vvv, gen_helper_vhaddw_h_b)
+TRANS(vhaddw_w_h, LSX, gen_vvv, gen_helper_vhaddw_w_h)
+TRANS(vhaddw_d_w, LSX, gen_vvv, gen_helper_vhaddw_d_w)
+TRANS(vhaddw_q_d, LSX, gen_vvv, gen_helper_vhaddw_q_d)
+TRANS(vhaddw_hu_bu, LSX, gen_vvv, gen_helper_vhaddw_hu_bu)
+TRANS(vhaddw_wu_hu, LSX, gen_vvv, gen_helper_vhaddw_wu_hu)
+TRANS(vhaddw_du_wu, LSX, gen_vvv, gen_helper_vhaddw_du_wu)
+TRANS(vhaddw_qu_du, LSX, gen_vvv, gen_helper_vhaddw_qu_du)
+TRANS(vhsubw_h_b, LSX, gen_vvv, gen_helper_vhsubw_h_b)
+TRANS(vhsubw_w_h, LSX, gen_vvv, gen_helper_vhsubw_w_h)
+TRANS(vhsubw_d_w, LSX, gen_vvv, gen_helper_vhsubw_d_w)
+TRANS(vhsubw_q_d, LSX, gen_vvv, gen_helper_vhsubw_q_d)
+TRANS(vhsubw_hu_bu, LSX, gen_vvv, gen_helper_vhsubw_hu_bu)
+TRANS(vhsubw_wu_hu, LSX, gen_vvv, gen_helper_vhsubw_wu_hu)
+TRANS(vhsubw_du_wu, LSX, gen_vvv, gen_helper_vhsubw_du_wu)
+TRANS(vhsubw_qu_du, LSX, gen_vvv, gen_helper_vhsubw_qu_du)
 
 static void gen_vaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -301,10 +305,10 @@ static void do_vaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_b, ALL, gvec_vvv, MO_8, do_vaddwev_s)
-TRANS(vaddwev_w_h, ALL, gvec_vvv, MO_16, do_vaddwev_s)
-TRANS(vaddwev_d_w, ALL, gvec_vvv, MO_32, do_vaddwev_s)
-TRANS(vaddwev_q_d, ALL, gvec_vvv, MO_64, do_vaddwev_s)
+TRANS(vaddwev_h_b, LSX, gvec_vvv, MO_8, do_vaddwev_s)
+TRANS(vaddwev_w_h, LSX, gvec_vvv, MO_16, do_vaddwev_s)
+TRANS(vaddwev_d_w, LSX, gvec_vvv, MO_32, do_vaddwev_s)
+TRANS(vaddwev_q_d, LSX, gvec_vvv, MO_64, do_vaddwev_s)
 
 static void gen_vaddwod_w_h(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -380,10 +384,10 @@ static void do_vaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_b, ALL, gvec_vvv, MO_8, do_vaddwod_s)
-TRANS(vaddwod_w_h, ALL, gvec_vvv, MO_16, do_vaddwod_s)
-TRANS(vaddwod_d_w, ALL, gvec_vvv, MO_32, do_vaddwod_s)
-TRANS(vaddwod_q_d, ALL, gvec_vvv, MO_64, do_vaddwod_s)
+TRANS(vaddwod_h_b, LSX, gvec_vvv, MO_8, do_vaddwod_s)
+TRANS(vaddwod_w_h, LSX, gvec_vvv, MO_16, do_vaddwod_s)
+TRANS(vaddwod_d_w, LSX, gvec_vvv, MO_32, do_vaddwod_s)
+TRANS(vaddwod_q_d, LSX, gvec_vvv, MO_64, do_vaddwod_s)
 
 static void gen_vsubwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -463,10 +467,10 @@ static void do_vsubwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_b, ALL, gvec_vvv, MO_8, do_vsubwev_s)
-TRANS(vsubwev_w_h, ALL, gvec_vvv, MO_16, do_vsubwev_s)
-TRANS(vsubwev_d_w, ALL, gvec_vvv, MO_32, do_vsubwev_s)
-TRANS(vsubwev_q_d, ALL, gvec_vvv, MO_64, do_vsubwev_s)
+TRANS(vsubwev_h_b, LSX, gvec_vvv, MO_8, do_vsubwev_s)
+TRANS(vsubwev_w_h, LSX, gvec_vvv, MO_16, do_vsubwev_s)
+TRANS(vsubwev_d_w, LSX, gvec_vvv, MO_32, do_vsubwev_s)
+TRANS(vsubwev_q_d, LSX, gvec_vvv, MO_64, do_vsubwev_s)
 
 static void gen_vsubwod_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -542,10 +546,10 @@ static void do_vsubwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_b, ALL, gvec_vvv, MO_8, do_vsubwod_s)
-TRANS(vsubwod_w_h, ALL, gvec_vvv, MO_16, do_vsubwod_s)
-TRANS(vsubwod_d_w, ALL, gvec_vvv, MO_32, do_vsubwod_s)
-TRANS(vsubwod_q_d, ALL, gvec_vvv, MO_64, do_vsubwod_s)
+TRANS(vsubwod_h_b, LSX, gvec_vvv, MO_8, do_vsubwod_s)
+TRANS(vsubwod_w_h, LSX, gvec_vvv, MO_16, do_vsubwod_s)
+TRANS(vsubwod_d_w, LSX, gvec_vvv, MO_32, do_vsubwod_s)
+TRANS(vsubwod_q_d, LSX, gvec_vvv, MO_64, do_vsubwod_s)
 
 static void gen_vaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -617,10 +621,10 @@ static void do_vaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu, ALL, gvec_vvv, MO_8, do_vaddwev_u)
-TRANS(vaddwev_w_hu, ALL, gvec_vvv, MO_16, do_vaddwev_u)
-TRANS(vaddwev_d_wu, ALL, gvec_vvv, MO_32, do_vaddwev_u)
-TRANS(vaddwev_q_du, ALL, gvec_vvv, MO_64, do_vaddwev_u)
+TRANS(vaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vaddwev_u)
+TRANS(vaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vaddwev_u)
+TRANS(vaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vaddwev_u)
+TRANS(vaddwev_q_du, LSX, gvec_vvv, MO_64, do_vaddwev_u)
 
 static void gen_vaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -696,10 +700,10 @@ static void do_vaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu, ALL, gvec_vvv, MO_8, do_vaddwod_u)
-TRANS(vaddwod_w_hu, ALL, gvec_vvv, MO_16, do_vaddwod_u)
-TRANS(vaddwod_d_wu, ALL, gvec_vvv, MO_32, do_vaddwod_u)
-TRANS(vaddwod_q_du, ALL, gvec_vvv, MO_64, do_vaddwod_u)
+TRANS(vaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vaddwod_u)
+TRANS(vaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vaddwod_u)
+TRANS(vaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vaddwod_u)
+TRANS(vaddwod_q_du, LSX, gvec_vvv, MO_64, do_vaddwod_u)
 
 static void gen_vsubwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -771,10 +775,10 @@ static void do_vsubwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwev_h_bu, ALL, gvec_vvv, MO_8, do_vsubwev_u)
-TRANS(vsubwev_w_hu, ALL, gvec_vvv, MO_16, do_vsubwev_u)
-TRANS(vsubwev_d_wu, ALL, gvec_vvv, MO_32, do_vsubwev_u)
-TRANS(vsubwev_q_du, ALL, gvec_vvv, MO_64, do_vsubwev_u)
+TRANS(vsubwev_h_bu, LSX, gvec_vvv, MO_8, do_vsubwev_u)
+TRANS(vsubwev_w_hu, LSX, gvec_vvv, MO_16, do_vsubwev_u)
+TRANS(vsubwev_d_wu, LSX, gvec_vvv, MO_32, do_vsubwev_u)
+TRANS(vsubwev_q_du, LSX, gvec_vvv, MO_64, do_vsubwev_u)
 
 static void gen_vsubwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -850,10 +854,10 @@ static void do_vsubwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsubwod_h_bu, ALL, gvec_vvv, MO_8, do_vsubwod_u)
-TRANS(vsubwod_w_hu, ALL, gvec_vvv, MO_16, do_vsubwod_u)
-TRANS(vsubwod_d_wu, ALL, gvec_vvv, MO_32, do_vsubwod_u)
-TRANS(vsubwod_q_du, ALL, gvec_vvv, MO_64, do_vsubwod_u)
+TRANS(vsubwod_h_bu, LSX, gvec_vvv, MO_8, do_vsubwod_u)
+TRANS(vsubwod_w_hu, LSX, gvec_vvv, MO_16, do_vsubwod_u)
+TRANS(vsubwod_d_wu, LSX, gvec_vvv, MO_32, do_vsubwod_u)
+TRANS(vsubwod_q_du, LSX, gvec_vvv, MO_64, do_vsubwod_u)
 
 static void gen_vaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -933,10 +937,10 @@ static void do_vaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vaddwev_u_s)
-TRANS(vaddwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vaddwev_u_s)
-TRANS(vaddwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vaddwev_u_s)
-TRANS(vaddwev_q_du_d, ALL, gvec_vvv, MO_64, do_vaddwev_u_s)
+TRANS(vaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwev_u_s)
+TRANS(vaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwev_u_s)
+TRANS(vaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwev_u_s)
+TRANS(vaddwev_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwev_u_s)
 
 static void gen_vaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1013,10 +1017,10 @@ static void do_vaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vaddwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vaddwod_u_s)
-TRANS(vaddwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vaddwod_u_s)
-TRANS(vaddwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vaddwod_u_s)
-TRANS(vaddwod_q_du_d, ALL, gvec_vvv, MO_64, do_vaddwod_u_s)
+TRANS(vaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vaddwod_u_s)
+TRANS(vaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vaddwod_u_s)
+TRANS(vaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vaddwod_u_s)
+TRANS(vaddwod_q_du_d, LSX, gvec_vvv, MO_64, do_vaddwod_u_s)
 
 static void do_vavg(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*gen_shr_vec)(unsigned, TCGv_vec,
@@ -1125,14 +1129,14 @@ static void do_vavg_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavg_b, ALL, gvec_vvv, MO_8, do_vavg_s)
-TRANS(vavg_h, ALL, gvec_vvv, MO_16, do_vavg_s)
-TRANS(vavg_w, ALL, gvec_vvv, MO_32, do_vavg_s)
-TRANS(vavg_d, ALL, gvec_vvv, MO_64, do_vavg_s)
-TRANS(vavg_bu, ALL, gvec_vvv, MO_8, do_vavg_u)
-TRANS(vavg_hu, ALL, gvec_vvv, MO_16, do_vavg_u)
-TRANS(vavg_wu, ALL, gvec_vvv, MO_32, do_vavg_u)
-TRANS(vavg_du, ALL, gvec_vvv, MO_64, do_vavg_u)
+TRANS(vavg_b, LSX, gvec_vvv, MO_8, do_vavg_s)
+TRANS(vavg_h, LSX, gvec_vvv, MO_16, do_vavg_s)
+TRANS(vavg_w, LSX, gvec_vvv, MO_32, do_vavg_s)
+TRANS(vavg_d, LSX, gvec_vvv, MO_64, do_vavg_s)
+TRANS(vavg_bu, LSX, gvec_vvv, MO_8, do_vavg_u)
+TRANS(vavg_hu, LSX, gvec_vvv, MO_16, do_vavg_u)
+TRANS(vavg_wu, LSX, gvec_vvv, MO_32, do_vavg_u)
+TRANS(vavg_du, LSX, gvec_vvv, MO_64, do_vavg_u)
 
 static void do_vavgr_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -1206,14 +1210,14 @@ static void do_vavgr_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vavgr_b, ALL, gvec_vvv, MO_8, do_vavgr_s)
-TRANS(vavgr_h, ALL, gvec_vvv, MO_16, do_vavgr_s)
-TRANS(vavgr_w, ALL, gvec_vvv, MO_32, do_vavgr_s)
-TRANS(vavgr_d, ALL, gvec_vvv, MO_64, do_vavgr_s)
-TRANS(vavgr_bu, ALL, gvec_vvv, MO_8, do_vavgr_u)
-TRANS(vavgr_hu, ALL, gvec_vvv, MO_16, do_vavgr_u)
-TRANS(vavgr_wu, ALL, gvec_vvv, MO_32, do_vavgr_u)
-TRANS(vavgr_du, ALL, gvec_vvv, MO_64, do_vavgr_u)
+TRANS(vavgr_b, LSX, gvec_vvv, MO_8, do_vavgr_s)
+TRANS(vavgr_h, LSX, gvec_vvv, MO_16, do_vavgr_s)
+TRANS(vavgr_w, LSX, gvec_vvv, MO_32, do_vavgr_s)
+TRANS(vavgr_d, LSX, gvec_vvv, MO_64, do_vavgr_s)
+TRANS(vavgr_bu, LSX, gvec_vvv, MO_8, do_vavgr_u)
+TRANS(vavgr_hu, LSX, gvec_vvv, MO_16, do_vavgr_u)
+TRANS(vavgr_wu, LSX, gvec_vvv, MO_32, do_vavgr_u)
+TRANS(vavgr_du, LSX, gvec_vvv, MO_64, do_vavgr_u)
 
 static void gen_vabsd_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1301,14 +1305,14 @@ static void do_vabsd_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vabsd_b, ALL, gvec_vvv, MO_8, do_vabsd_s)
-TRANS(vabsd_h, ALL, gvec_vvv, MO_16, do_vabsd_s)
-TRANS(vabsd_w, ALL, gvec_vvv, MO_32, do_vabsd_s)
-TRANS(vabsd_d, ALL, gvec_vvv, MO_64, do_vabsd_s)
-TRANS(vabsd_bu, ALL, gvec_vvv, MO_8, do_vabsd_u)
-TRANS(vabsd_hu, ALL, gvec_vvv, MO_16, do_vabsd_u)
-TRANS(vabsd_wu, ALL, gvec_vvv, MO_32, do_vabsd_u)
-TRANS(vabsd_du, ALL, gvec_vvv, MO_64, do_vabsd_u)
+TRANS(vabsd_b, LSX, gvec_vvv, MO_8, do_vabsd_s)
+TRANS(vabsd_h, LSX, gvec_vvv, MO_16, do_vabsd_s)
+TRANS(vabsd_w, LSX, gvec_vvv, MO_32, do_vabsd_s)
+TRANS(vabsd_d, LSX, gvec_vvv, MO_64, do_vabsd_s)
+TRANS(vabsd_bu, LSX, gvec_vvv, MO_8, do_vabsd_u)
+TRANS(vabsd_hu, LSX, gvec_vvv, MO_16, do_vabsd_u)
+TRANS(vabsd_wu, LSX, gvec_vvv, MO_32, do_vabsd_u)
+TRANS(vabsd_du, LSX, gvec_vvv, MO_64, do_vabsd_u)
 
 static void gen_vadda(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1358,28 +1362,28 @@ static void do_vadda(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vadda_b, ALL, gvec_vvv, MO_8, do_vadda)
-TRANS(vadda_h, ALL, gvec_vvv, MO_16, do_vadda)
-TRANS(vadda_w, ALL, gvec_vvv, MO_32, do_vadda)
-TRANS(vadda_d, ALL, gvec_vvv, MO_64, do_vadda)
-
-TRANS(vmax_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_smax)
-TRANS(vmax_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_smax)
-TRANS(vmax_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_smax)
-TRANS(vmax_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_smax)
-TRANS(vmax_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_umax)
-TRANS(vmax_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_umax)
-TRANS(vmax_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_umax)
-TRANS(vmax_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_umax)
-
-TRANS(vmin_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_smin)
-TRANS(vmin_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_smin)
-TRANS(vmin_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_smin)
-TRANS(vmin_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_smin)
-TRANS(vmin_bu, ALL, gvec_vvv, MO_8, tcg_gen_gvec_umin)
-TRANS(vmin_hu, ALL, gvec_vvv, MO_16, tcg_gen_gvec_umin)
-TRANS(vmin_wu, ALL, gvec_vvv, MO_32, tcg_gen_gvec_umin)
-TRANS(vmin_du, ALL, gvec_vvv, MO_64, tcg_gen_gvec_umin)
+TRANS(vadda_b, LSX, gvec_vvv, MO_8, do_vadda)
+TRANS(vadda_h, LSX, gvec_vvv, MO_16, do_vadda)
+TRANS(vadda_w, LSX, gvec_vvv, MO_32, do_vadda)
+TRANS(vadda_d, LSX, gvec_vvv, MO_64, do_vadda)
+
+TRANS(vmax_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_smax)
+TRANS(vmax_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_smax)
+TRANS(vmax_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_smax)
+TRANS(vmax_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_smax)
+TRANS(vmax_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_umax)
+TRANS(vmax_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_umax)
+TRANS(vmax_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_umax)
+TRANS(vmax_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_umax)
+
+TRANS(vmin_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_smin)
+TRANS(vmin_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_smin)
+TRANS(vmin_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_smin)
+TRANS(vmin_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_smin)
+TRANS(vmin_bu, LSX, gvec_vvv, MO_8, tcg_gen_gvec_umin)
+TRANS(vmin_hu, LSX, gvec_vvv, MO_16, tcg_gen_gvec_umin)
+TRANS(vmin_wu, LSX, gvec_vvv, MO_32, tcg_gen_gvec_umin)
+TRANS(vmin_du, LSX, gvec_vvv, MO_64, tcg_gen_gvec_umin)
 
 static void gen_vmini_s(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -1473,14 +1477,14 @@ static void do_vmini_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmini_b, ALL, gvec_vv_i, MO_8, do_vmini_s)
-TRANS(vmini_h, ALL, gvec_vv_i, MO_16, do_vmini_s)
-TRANS(vmini_w, ALL, gvec_vv_i, MO_32, do_vmini_s)
-TRANS(vmini_d, ALL, gvec_vv_i, MO_64, do_vmini_s)
-TRANS(vmini_bu, ALL, gvec_vv_i, MO_8, do_vmini_u)
-TRANS(vmini_hu, ALL, gvec_vv_i, MO_16, do_vmini_u)
-TRANS(vmini_wu, ALL, gvec_vv_i, MO_32, do_vmini_u)
-TRANS(vmini_du, ALL, gvec_vv_i, MO_64, do_vmini_u)
+TRANS(vmini_b, LSX, gvec_vv_i, MO_8, do_vmini_s)
+TRANS(vmini_h, LSX, gvec_vv_i, MO_16, do_vmini_s)
+TRANS(vmini_w, LSX, gvec_vv_i, MO_32, do_vmini_s)
+TRANS(vmini_d, LSX, gvec_vv_i, MO_64, do_vmini_s)
+TRANS(vmini_bu, LSX, gvec_vv_i, MO_8, do_vmini_u)
+TRANS(vmini_hu, LSX, gvec_vv_i, MO_16, do_vmini_u)
+TRANS(vmini_wu, LSX, gvec_vv_i, MO_32, do_vmini_u)
+TRANS(vmini_du, LSX, gvec_vv_i, MO_64, do_vmini_u)
 
 static void do_vmaxi_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -1554,19 +1558,19 @@ static void do_vmaxi_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vmaxi_b, ALL, gvec_vv_i, MO_8, do_vmaxi_s)
-TRANS(vmaxi_h, ALL, gvec_vv_i, MO_16, do_vmaxi_s)
-TRANS(vmaxi_w, ALL, gvec_vv_i, MO_32, do_vmaxi_s)
-TRANS(vmaxi_d, ALL, gvec_vv_i, MO_64, do_vmaxi_s)
-TRANS(vmaxi_bu, ALL, gvec_vv_i, MO_8, do_vmaxi_u)
-TRANS(vmaxi_hu, ALL, gvec_vv_i, MO_16, do_vmaxi_u)
-TRANS(vmaxi_wu, ALL, gvec_vv_i, MO_32, do_vmaxi_u)
-TRANS(vmaxi_du, ALL, gvec_vv_i, MO_64, do_vmaxi_u)
+TRANS(vmaxi_b, LSX, gvec_vv_i, MO_8, do_vmaxi_s)
+TRANS(vmaxi_h, LSX, gvec_vv_i, MO_16, do_vmaxi_s)
+TRANS(vmaxi_w, LSX, gvec_vv_i, MO_32, do_vmaxi_s)
+TRANS(vmaxi_d, LSX, gvec_vv_i, MO_64, do_vmaxi_s)
+TRANS(vmaxi_bu, LSX, gvec_vv_i, MO_8, do_vmaxi_u)
+TRANS(vmaxi_hu, LSX, gvec_vv_i, MO_16, do_vmaxi_u)
+TRANS(vmaxi_wu, LSX, gvec_vv_i, MO_32, do_vmaxi_u)
+TRANS(vmaxi_du, LSX, gvec_vv_i, MO_64, do_vmaxi_u)
 
-TRANS(vmul_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_mul)
-TRANS(vmul_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_mul)
-TRANS(vmul_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_mul)
-TRANS(vmul_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_mul)
+TRANS(vmul_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_mul)
+TRANS(vmul_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_mul)
+TRANS(vmul_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_mul)
+TRANS(vmul_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_mul)
 
 static void gen_vmuh_w(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1607,10 +1611,10 @@ static void do_vmuh_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_b, ALL, gvec_vvv, MO_8, do_vmuh_s)
-TRANS(vmuh_h, ALL, gvec_vvv, MO_16, do_vmuh_s)
-TRANS(vmuh_w, ALL, gvec_vvv, MO_32, do_vmuh_s)
-TRANS(vmuh_d, ALL, gvec_vvv, MO_64, do_vmuh_s)
+TRANS(vmuh_b, LSX, gvec_vvv, MO_8, do_vmuh_s)
+TRANS(vmuh_h, LSX, gvec_vvv, MO_16, do_vmuh_s)
+TRANS(vmuh_w, LSX, gvec_vvv, MO_32, do_vmuh_s)
+TRANS(vmuh_d, LSX, gvec_vvv, MO_64, do_vmuh_s)
 
 static void gen_vmuh_wu(TCGv_i32 t, TCGv_i32 a, TCGv_i32 b)
 {
@@ -1651,10 +1655,10 @@ static void do_vmuh_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmuh_bu, ALL, gvec_vvv, MO_8,  do_vmuh_u)
-TRANS(vmuh_hu, ALL, gvec_vvv, MO_16, do_vmuh_u)
-TRANS(vmuh_wu, ALL, gvec_vvv, MO_32, do_vmuh_u)
-TRANS(vmuh_du, ALL, gvec_vvv, MO_64, do_vmuh_u)
+TRANS(vmuh_bu, LSX, gvec_vvv, MO_8,  do_vmuh_u)
+TRANS(vmuh_hu, LSX, gvec_vvv, MO_16, do_vmuh_u)
+TRANS(vmuh_wu, LSX, gvec_vvv, MO_32, do_vmuh_u)
+TRANS(vmuh_du, LSX, gvec_vvv, MO_64, do_vmuh_u)
 
 static void gen_vmulwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1724,9 +1728,9 @@ static void do_vmulwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_b, ALL, gvec_vvv, MO_8, do_vmulwev_s)
-TRANS(vmulwev_w_h, ALL, gvec_vvv, MO_16, do_vmulwev_s)
-TRANS(vmulwev_d_w, ALL, gvec_vvv, MO_32, do_vmulwev_s)
+TRANS(vmulwev_h_b, LSX, gvec_vvv, MO_8, do_vmulwev_s)
+TRANS(vmulwev_w_h, LSX, gvec_vvv, MO_16, do_vmulwev_s)
+TRANS(vmulwev_d_w, LSX, gvec_vvv, MO_32, do_vmulwev_s)
 
 static void tcg_gen_mulus2_i64(TCGv_i64 rl, TCGv_i64 rh,
                                TCGv_i64 arg1, TCGv_i64 arg2)
@@ -1739,6 +1743,10 @@ static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
 {                                                         \
     TCGv_i64 rh, rl, arg1, arg2;                          \
                                                           \
+    if (!avail_LSX(ctx)) {                                \
+        return false;                                     \
+    }                                                     \
+                                                          \
     rh = tcg_temp_new_i64();                              \
     rl = tcg_temp_new_i64();                              \
     arg1 = tcg_temp_new_i64();                            \
@@ -1828,9 +1836,9 @@ static void do_vmulwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_b, ALL, gvec_vvv, MO_8, do_vmulwod_s)
-TRANS(vmulwod_w_h, ALL, gvec_vvv, MO_16, do_vmulwod_s)
-TRANS(vmulwod_d_w, ALL, gvec_vvv, MO_32, do_vmulwod_s)
+TRANS(vmulwod_h_b, LSX, gvec_vvv, MO_8, do_vmulwod_s)
+TRANS(vmulwod_w_h, LSX, gvec_vvv, MO_16, do_vmulwod_s)
+TRANS(vmulwod_d_w, LSX, gvec_vvv, MO_32, do_vmulwod_s)
 
 static void gen_vmulwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1898,9 +1906,9 @@ static void do_vmulwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu, ALL, gvec_vvv, MO_8, do_vmulwev_u)
-TRANS(vmulwev_w_hu, ALL, gvec_vvv, MO_16, do_vmulwev_u)
-TRANS(vmulwev_d_wu, ALL, gvec_vvv, MO_32, do_vmulwev_u)
+TRANS(vmulwev_h_bu, LSX, gvec_vvv, MO_8, do_vmulwev_u)
+TRANS(vmulwev_w_hu, LSX, gvec_vvv, MO_16, do_vmulwev_u)
+TRANS(vmulwev_d_wu, LSX, gvec_vvv, MO_32, do_vmulwev_u)
 
 static void gen_vmulwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -1968,9 +1976,9 @@ static void do_vmulwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu, ALL, gvec_vvv, MO_8, do_vmulwod_u)
-TRANS(vmulwod_w_hu, ALL, gvec_vvv, MO_16, do_vmulwod_u)
-TRANS(vmulwod_d_wu, ALL, gvec_vvv, MO_32, do_vmulwod_u)
+TRANS(vmulwod_h_bu, LSX, gvec_vvv, MO_8, do_vmulwod_u)
+TRANS(vmulwod_w_hu, LSX, gvec_vvv, MO_16, do_vmulwod_u)
+TRANS(vmulwod_d_wu, LSX, gvec_vvv, MO_32, do_vmulwod_u)
 
 static void gen_vmulwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2040,9 +2048,9 @@ static void do_vmulwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vmulwev_u_s)
-TRANS(vmulwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vmulwev_u_s)
-TRANS(vmulwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vmulwev_u_s)
+TRANS(vmulwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwev_u_s)
+TRANS(vmulwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwev_u_s)
+TRANS(vmulwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwev_u_s)
 
 static void gen_vmulwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2109,9 +2117,9 @@ static void do_vmulwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmulwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vmulwod_u_s)
-TRANS(vmulwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vmulwod_u_s)
-TRANS(vmulwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vmulwod_u_s)
+TRANS(vmulwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmulwod_u_s)
+TRANS(vmulwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmulwod_u_s)
+TRANS(vmulwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmulwod_u_s)
 
 static void gen_vmadd(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2182,10 +2190,10 @@ static void do_vmadd(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmadd_b, ALL, gvec_vvv, MO_8, do_vmadd)
-TRANS(vmadd_h, ALL, gvec_vvv, MO_16, do_vmadd)
-TRANS(vmadd_w, ALL, gvec_vvv, MO_32, do_vmadd)
-TRANS(vmadd_d, ALL, gvec_vvv, MO_64, do_vmadd)
+TRANS(vmadd_b, LSX, gvec_vvv, MO_8, do_vmadd)
+TRANS(vmadd_h, LSX, gvec_vvv, MO_16, do_vmadd)
+TRANS(vmadd_w, LSX, gvec_vvv, MO_32, do_vmadd)
+TRANS(vmadd_d, LSX, gvec_vvv, MO_64, do_vmadd)
 
 static void gen_vmsub(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2256,10 +2264,10 @@ static void do_vmsub(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmsub_b, ALL, gvec_vvv, MO_8, do_vmsub)
-TRANS(vmsub_h, ALL, gvec_vvv, MO_16, do_vmsub)
-TRANS(vmsub_w, ALL, gvec_vvv, MO_32, do_vmsub)
-TRANS(vmsub_d, ALL, gvec_vvv, MO_64, do_vmsub)
+TRANS(vmsub_b, LSX, gvec_vvv, MO_8, do_vmsub)
+TRANS(vmsub_h, LSX, gvec_vvv, MO_16, do_vmsub)
+TRANS(vmsub_w, LSX, gvec_vvv, MO_32, do_vmsub)
+TRANS(vmsub_d, LSX, gvec_vvv, MO_64, do_vmsub)
 
 static void gen_vmaddwev_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2331,15 +2339,19 @@ static void do_vmaddwev_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_b, ALL, gvec_vvv, MO_8, do_vmaddwev_s)
-TRANS(vmaddwev_w_h, ALL, gvec_vvv, MO_16, do_vmaddwev_s)
-TRANS(vmaddwev_d_w, ALL, gvec_vvv, MO_32, do_vmaddwev_s)
+TRANS(vmaddwev_h_b, LSX, gvec_vvv, MO_8, do_vmaddwev_s)
+TRANS(vmaddwev_w_h, LSX, gvec_vvv, MO_16, do_vmaddwev_s)
+TRANS(vmaddwev_d_w, LSX, gvec_vvv, MO_32, do_vmaddwev_s)
 
 #define VMADD_Q(NAME, FN, idx1, idx2)                     \
 static bool trans_## NAME (DisasContext *ctx, arg_vvv *a) \
 {                                                         \
     TCGv_i64 rh, rl, arg1, arg2, th, tl;                  \
                                                           \
+    if (!avail_LSX(ctx)) {                                \
+        return false;                                     \
+    }                                                     \
+                                                          \
     rh = tcg_temp_new_i64();                              \
     rl = tcg_temp_new_i64();                              \
     arg1 = tcg_temp_new_i64();                            \
@@ -2435,9 +2447,9 @@ static void do_vmaddwod_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_b, ALL, gvec_vvv, MO_8, do_vmaddwod_s)
-TRANS(vmaddwod_w_h, ALL, gvec_vvv, MO_16, do_vmaddwod_s)
-TRANS(vmaddwod_d_w, ALL, gvec_vvv, MO_32, do_vmaddwod_s)
+TRANS(vmaddwod_h_b, LSX, gvec_vvv, MO_8, do_vmaddwod_s)
+TRANS(vmaddwod_w_h, LSX, gvec_vvv, MO_16, do_vmaddwod_s)
+TRANS(vmaddwod_d_w, LSX, gvec_vvv, MO_32, do_vmaddwod_s)
 
 static void gen_vmaddwev_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2505,9 +2517,9 @@ static void do_vmaddwev_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu, ALL, gvec_vvv, MO_8, do_vmaddwev_u)
-TRANS(vmaddwev_w_hu, ALL, gvec_vvv, MO_16, do_vmaddwev_u)
-TRANS(vmaddwev_d_wu, ALL, gvec_vvv, MO_32, do_vmaddwev_u)
+TRANS(vmaddwev_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwev_u)
+TRANS(vmaddwev_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwev_u)
+TRANS(vmaddwev_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwev_u)
 
 static void gen_vmaddwod_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2576,9 +2588,9 @@ static void do_vmaddwod_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu, ALL, gvec_vvv, MO_8, do_vmaddwod_u)
-TRANS(vmaddwod_w_hu, ALL, gvec_vvv, MO_16, do_vmaddwod_u)
-TRANS(vmaddwod_d_wu, ALL, gvec_vvv, MO_32, do_vmaddwod_u)
+TRANS(vmaddwod_h_bu, LSX, gvec_vvv, MO_8, do_vmaddwod_u)
+TRANS(vmaddwod_w_hu, LSX, gvec_vvv, MO_16, do_vmaddwod_u)
+TRANS(vmaddwod_d_wu, LSX, gvec_vvv, MO_32, do_vmaddwod_u)
 
 static void gen_vmaddwev_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2649,9 +2661,9 @@ static void do_vmaddwev_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwev_h_bu_b, ALL, gvec_vvv, MO_8, do_vmaddwev_u_s)
-TRANS(vmaddwev_w_hu_h, ALL, gvec_vvv, MO_16, do_vmaddwev_u_s)
-TRANS(vmaddwev_d_wu_w, ALL, gvec_vvv, MO_32, do_vmaddwev_u_s)
+TRANS(vmaddwev_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwev_u_s)
+TRANS(vmaddwev_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwev_u_s)
+TRANS(vmaddwev_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwev_u_s)
 
 static void gen_vmaddwod_u_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2721,26 +2733,26 @@ static void do_vmaddwod_u_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vmaddwod_h_bu_b, ALL, gvec_vvv, MO_8, do_vmaddwod_u_s)
-TRANS(vmaddwod_w_hu_h, ALL, gvec_vvv, MO_16, do_vmaddwod_u_s)
-TRANS(vmaddwod_d_wu_w, ALL, gvec_vvv, MO_32, do_vmaddwod_u_s)
-
-TRANS(vdiv_b, ALL, gen_vvv, gen_helper_vdiv_b)
-TRANS(vdiv_h, ALL, gen_vvv, gen_helper_vdiv_h)
-TRANS(vdiv_w, ALL, gen_vvv, gen_helper_vdiv_w)
-TRANS(vdiv_d, ALL, gen_vvv, gen_helper_vdiv_d)
-TRANS(vdiv_bu, ALL, gen_vvv, gen_helper_vdiv_bu)
-TRANS(vdiv_hu, ALL, gen_vvv, gen_helper_vdiv_hu)
-TRANS(vdiv_wu, ALL, gen_vvv, gen_helper_vdiv_wu)
-TRANS(vdiv_du, ALL, gen_vvv, gen_helper_vdiv_du)
-TRANS(vmod_b, ALL, gen_vvv, gen_helper_vmod_b)
-TRANS(vmod_h, ALL, gen_vvv, gen_helper_vmod_h)
-TRANS(vmod_w, ALL, gen_vvv, gen_helper_vmod_w)
-TRANS(vmod_d, ALL, gen_vvv, gen_helper_vmod_d)
-TRANS(vmod_bu, ALL, gen_vvv, gen_helper_vmod_bu)
-TRANS(vmod_hu, ALL, gen_vvv, gen_helper_vmod_hu)
-TRANS(vmod_wu, ALL, gen_vvv, gen_helper_vmod_wu)
-TRANS(vmod_du, ALL, gen_vvv, gen_helper_vmod_du)
+TRANS(vmaddwod_h_bu_b, LSX, gvec_vvv, MO_8, do_vmaddwod_u_s)
+TRANS(vmaddwod_w_hu_h, LSX, gvec_vvv, MO_16, do_vmaddwod_u_s)
+TRANS(vmaddwod_d_wu_w, LSX, gvec_vvv, MO_32, do_vmaddwod_u_s)
+
+TRANS(vdiv_b, LSX, gen_vvv, gen_helper_vdiv_b)
+TRANS(vdiv_h, LSX, gen_vvv, gen_helper_vdiv_h)
+TRANS(vdiv_w, LSX, gen_vvv, gen_helper_vdiv_w)
+TRANS(vdiv_d, LSX, gen_vvv, gen_helper_vdiv_d)
+TRANS(vdiv_bu, LSX, gen_vvv, gen_helper_vdiv_bu)
+TRANS(vdiv_hu, LSX, gen_vvv, gen_helper_vdiv_hu)
+TRANS(vdiv_wu, LSX, gen_vvv, gen_helper_vdiv_wu)
+TRANS(vdiv_du, LSX, gen_vvv, gen_helper_vdiv_du)
+TRANS(vmod_b, LSX, gen_vvv, gen_helper_vmod_b)
+TRANS(vmod_h, LSX, gen_vvv, gen_helper_vmod_h)
+TRANS(vmod_w, LSX, gen_vvv, gen_helper_vmod_w)
+TRANS(vmod_d, LSX, gen_vvv, gen_helper_vmod_d)
+TRANS(vmod_bu, LSX, gen_vvv, gen_helper_vmod_bu)
+TRANS(vmod_hu, LSX, gen_vvv, gen_helper_vmod_hu)
+TRANS(vmod_wu, LSX, gen_vvv, gen_helper_vmod_wu)
+TRANS(vmod_du, LSX, gen_vvv, gen_helper_vmod_du)
 
 static void gen_vsat_s(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -2789,10 +2801,10 @@ static void do_vsat_s(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64((1ll<< imm) -1), &op[vece]);
 }
 
-TRANS(vsat_b, ALL, gvec_vv_i, MO_8, do_vsat_s)
-TRANS(vsat_h, ALL, gvec_vv_i, MO_16, do_vsat_s)
-TRANS(vsat_w, ALL, gvec_vv_i, MO_32, do_vsat_s)
-TRANS(vsat_d, ALL, gvec_vv_i, MO_64, do_vsat_s)
+TRANS(vsat_b, LSX, gvec_vv_i, MO_8, do_vsat_s)
+TRANS(vsat_h, LSX, gvec_vv_i, MO_16, do_vsat_s)
+TRANS(vsat_w, LSX, gvec_vv_i, MO_32, do_vsat_s)
+TRANS(vsat_d, LSX, gvec_vv_i, MO_64, do_vsat_s)
 
 static void gen_vsat_u(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec max)
 {
@@ -2838,19 +2850,19 @@ static void do_vsat_u(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                     tcg_constant_i64(max), &op[vece]);
 }
 
-TRANS(vsat_bu, ALL, gvec_vv_i, MO_8, do_vsat_u)
-TRANS(vsat_hu, ALL, gvec_vv_i, MO_16, do_vsat_u)
-TRANS(vsat_wu, ALL, gvec_vv_i, MO_32, do_vsat_u)
-TRANS(vsat_du, ALL, gvec_vv_i, MO_64, do_vsat_u)
+TRANS(vsat_bu, LSX, gvec_vv_i, MO_8, do_vsat_u)
+TRANS(vsat_hu, LSX, gvec_vv_i, MO_16, do_vsat_u)
+TRANS(vsat_wu, LSX, gvec_vv_i, MO_32, do_vsat_u)
+TRANS(vsat_du, LSX, gvec_vv_i, MO_64, do_vsat_u)
 
-TRANS(vexth_h_b, ALL, gen_vv, gen_helper_vexth_h_b)
-TRANS(vexth_w_h, ALL, gen_vv, gen_helper_vexth_w_h)
-TRANS(vexth_d_w, ALL, gen_vv, gen_helper_vexth_d_w)
-TRANS(vexth_q_d, ALL, gen_vv, gen_helper_vexth_q_d)
-TRANS(vexth_hu_bu, ALL, gen_vv, gen_helper_vexth_hu_bu)
-TRANS(vexth_wu_hu, ALL, gen_vv, gen_helper_vexth_wu_hu)
-TRANS(vexth_du_wu, ALL, gen_vv, gen_helper_vexth_du_wu)
-TRANS(vexth_qu_du, ALL, gen_vv, gen_helper_vexth_qu_du)
+TRANS(vexth_h_b, LSX, gen_vv, gen_helper_vexth_h_b)
+TRANS(vexth_w_h, LSX, gen_vv, gen_helper_vexth_w_h)
+TRANS(vexth_d_w, LSX, gen_vv, gen_helper_vexth_d_w)
+TRANS(vexth_q_d, LSX, gen_vv, gen_helper_vexth_q_d)
+TRANS(vexth_hu_bu, LSX, gen_vv, gen_helper_vexth_hu_bu)
+TRANS(vexth_wu_hu, LSX, gen_vv, gen_helper_vexth_wu_hu)
+TRANS(vexth_du_wu, LSX, gen_vv, gen_helper_vexth_du_wu)
+TRANS(vexth_qu_du, LSX, gen_vv, gen_helper_vexth_qu_du)
 
 static void gen_vsigncov(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
@@ -2900,17 +2912,17 @@ static void do_vsigncov(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vsigncov_b, ALL, gvec_vvv, MO_8, do_vsigncov)
-TRANS(vsigncov_h, ALL, gvec_vvv, MO_16, do_vsigncov)
-TRANS(vsigncov_w, ALL, gvec_vvv, MO_32, do_vsigncov)
-TRANS(vsigncov_d, ALL, gvec_vvv, MO_64, do_vsigncov)
+TRANS(vsigncov_b, LSX, gvec_vvv, MO_8, do_vsigncov)
+TRANS(vsigncov_h, LSX, gvec_vvv, MO_16, do_vsigncov)
+TRANS(vsigncov_w, LSX, gvec_vvv, MO_32, do_vsigncov)
+TRANS(vsigncov_d, LSX, gvec_vvv, MO_64, do_vsigncov)
 
-TRANS(vmskltz_b, ALL, gen_vv, gen_helper_vmskltz_b)
-TRANS(vmskltz_h, ALL, gen_vv, gen_helper_vmskltz_h)
-TRANS(vmskltz_w, ALL, gen_vv, gen_helper_vmskltz_w)
-TRANS(vmskltz_d, ALL, gen_vv, gen_helper_vmskltz_d)
-TRANS(vmskgez_b, ALL, gen_vv, gen_helper_vmskgez_b)
-TRANS(vmsknz_b, ALL, gen_vv, gen_helper_vmsknz_b)
+TRANS(vmskltz_b, LSX, gen_vv, gen_helper_vmskltz_b)
+TRANS(vmskltz_h, LSX, gen_vv, gen_helper_vmskltz_h)
+TRANS(vmskltz_w, LSX, gen_vv, gen_helper_vmskltz_w)
+TRANS(vmskltz_d, LSX, gen_vv, gen_helper_vmskltz_d)
+TRANS(vmskgez_b, LSX, gen_vv, gen_helper_vmskgez_b)
+TRANS(vmsknz_b, LSX, gen_vv, gen_helper_vmsknz_b)
 
 #define EXPAND_BYTE(bit)  ((uint64_t)(bit ? 0xff : 0))
 
@@ -3032,6 +3044,11 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
 {
     int sel, vece;
     uint64_t value;
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     sel = (a->imm >> 12) & 0x1;
@@ -3049,15 +3066,19 @@ static bool trans_vldi(DisasContext *ctx, arg_vldi *a)
     return true;
 }
 
-TRANS(vand_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_and)
-TRANS(vor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_or)
-TRANS(vxor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_xor)
-TRANS(vnor_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_nor)
+TRANS(vand_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_and)
+TRANS(vor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_or)
+TRANS(vxor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_xor)
+TRANS(vnor_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_nor)
 
 static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
 {
     uint32_t vd_ofs, vj_ofs, vk_ofs;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     vd_ofs = vec_full_offset(a->vd);
@@ -3067,10 +3088,10 @@ static bool trans_vandn_v(DisasContext *ctx, arg_vvv *a)
     tcg_gen_gvec_andc(MO_64, vd_ofs, vk_ofs, vj_ofs, 16, ctx->vl/8);
     return true;
 }
-TRANS(vorn_v, ALL, gvec_vvv, MO_64, tcg_gen_gvec_orc)
-TRANS(vandi_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
-TRANS(vori_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
-TRANS(vxori_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
+TRANS(vorn_v, LSX, gvec_vvv, MO_64, tcg_gen_gvec_orc)
+TRANS(vandi_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_andi)
+TRANS(vori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_ori)
+TRANS(vxori_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_xori)
 
 static void gen_vnori(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm)
 {
@@ -3103,176 +3124,176 @@ static void do_vnori_b(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op);
 }
 
-TRANS(vnori_b, ALL, gvec_vv_i, MO_8, do_vnori_b)
-
-TRANS(vsll_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
-TRANS(vsll_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
-TRANS(vsll_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
-TRANS(vsll_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
-TRANS(vslli_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
-TRANS(vslli_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
-TRANS(vslli_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
-TRANS(vslli_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
-
-TRANS(vsrl_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
-TRANS(vsrl_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
-TRANS(vsrl_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
-TRANS(vsrl_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
-TRANS(vsrli_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
-TRANS(vsrli_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
-TRANS(vsrli_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
-TRANS(vsrli_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
-
-TRANS(vsra_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
-TRANS(vsra_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
-TRANS(vsra_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
-TRANS(vsra_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
-TRANS(vsrai_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
-TRANS(vsrai_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
-TRANS(vsrai_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
-TRANS(vsrai_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
-
-TRANS(vrotr_b, ALL, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
-TRANS(vrotr_h, ALL, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
-TRANS(vrotr_w, ALL, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
-TRANS(vrotr_d, ALL, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
-TRANS(vrotri_b, ALL, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
-TRANS(vrotri_h, ALL, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
-TRANS(vrotri_w, ALL, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
-TRANS(vrotri_d, ALL, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
-
-TRANS(vsllwil_h_b, ALL, gen_vv_i, gen_helper_vsllwil_h_b)
-TRANS(vsllwil_w_h, ALL, gen_vv_i, gen_helper_vsllwil_w_h)
-TRANS(vsllwil_d_w, ALL, gen_vv_i, gen_helper_vsllwil_d_w)
-TRANS(vextl_q_d, ALL, gen_vv, gen_helper_vextl_q_d)
-TRANS(vsllwil_hu_bu, ALL, gen_vv_i, gen_helper_vsllwil_hu_bu)
-TRANS(vsllwil_wu_hu, ALL, gen_vv_i, gen_helper_vsllwil_wu_hu)
-TRANS(vsllwil_du_wu, ALL, gen_vv_i, gen_helper_vsllwil_du_wu)
-TRANS(vextl_qu_du, ALL, gen_vv, gen_helper_vextl_qu_du)
-
-TRANS(vsrlr_b, ALL, gen_vvv, gen_helper_vsrlr_b)
-TRANS(vsrlr_h, ALL, gen_vvv, gen_helper_vsrlr_h)
-TRANS(vsrlr_w, ALL, gen_vvv, gen_helper_vsrlr_w)
-TRANS(vsrlr_d, ALL, gen_vvv, gen_helper_vsrlr_d)
-TRANS(vsrlri_b, ALL, gen_vv_i, gen_helper_vsrlri_b)
-TRANS(vsrlri_h, ALL, gen_vv_i, gen_helper_vsrlri_h)
-TRANS(vsrlri_w, ALL, gen_vv_i, gen_helper_vsrlri_w)
-TRANS(vsrlri_d, ALL, gen_vv_i, gen_helper_vsrlri_d)
-
-TRANS(vsrar_b, ALL, gen_vvv, gen_helper_vsrar_b)
-TRANS(vsrar_h, ALL, gen_vvv, gen_helper_vsrar_h)
-TRANS(vsrar_w, ALL, gen_vvv, gen_helper_vsrar_w)
-TRANS(vsrar_d, ALL, gen_vvv, gen_helper_vsrar_d)
-TRANS(vsrari_b, ALL, gen_vv_i, gen_helper_vsrari_b)
-TRANS(vsrari_h, ALL, gen_vv_i, gen_helper_vsrari_h)
-TRANS(vsrari_w, ALL, gen_vv_i, gen_helper_vsrari_w)
-TRANS(vsrari_d, ALL, gen_vv_i, gen_helper_vsrari_d)
-
-TRANS(vsrln_b_h, ALL, gen_vvv, gen_helper_vsrln_b_h)
-TRANS(vsrln_h_w, ALL, gen_vvv, gen_helper_vsrln_h_w)
-TRANS(vsrln_w_d, ALL, gen_vvv, gen_helper_vsrln_w_d)
-TRANS(vsran_b_h, ALL, gen_vvv, gen_helper_vsran_b_h)
-TRANS(vsran_h_w, ALL, gen_vvv, gen_helper_vsran_h_w)
-TRANS(vsran_w_d, ALL, gen_vvv, gen_helper_vsran_w_d)
-
-TRANS(vsrlni_b_h, ALL, gen_vv_i, gen_helper_vsrlni_b_h)
-TRANS(vsrlni_h_w, ALL, gen_vv_i, gen_helper_vsrlni_h_w)
-TRANS(vsrlni_w_d, ALL, gen_vv_i, gen_helper_vsrlni_w_d)
-TRANS(vsrlni_d_q, ALL, gen_vv_i, gen_helper_vsrlni_d_q)
-TRANS(vsrani_b_h, ALL, gen_vv_i, gen_helper_vsrani_b_h)
-TRANS(vsrani_h_w, ALL, gen_vv_i, gen_helper_vsrani_h_w)
-TRANS(vsrani_w_d, ALL, gen_vv_i, gen_helper_vsrani_w_d)
-TRANS(vsrani_d_q, ALL, gen_vv_i, gen_helper_vsrani_d_q)
-
-TRANS(vsrlrn_b_h, ALL, gen_vvv, gen_helper_vsrlrn_b_h)
-TRANS(vsrlrn_h_w, ALL, gen_vvv, gen_helper_vsrlrn_h_w)
-TRANS(vsrlrn_w_d, ALL, gen_vvv, gen_helper_vsrlrn_w_d)
-TRANS(vsrarn_b_h, ALL, gen_vvv, gen_helper_vsrarn_b_h)
-TRANS(vsrarn_h_w, ALL, gen_vvv, gen_helper_vsrarn_h_w)
-TRANS(vsrarn_w_d, ALL, gen_vvv, gen_helper_vsrarn_w_d)
-
-TRANS(vsrlrni_b_h, ALL, gen_vv_i, gen_helper_vsrlrni_b_h)
-TRANS(vsrlrni_h_w, ALL, gen_vv_i, gen_helper_vsrlrni_h_w)
-TRANS(vsrlrni_w_d, ALL, gen_vv_i, gen_helper_vsrlrni_w_d)
-TRANS(vsrlrni_d_q, ALL, gen_vv_i, gen_helper_vsrlrni_d_q)
-TRANS(vsrarni_b_h, ALL, gen_vv_i, gen_helper_vsrarni_b_h)
-TRANS(vsrarni_h_w, ALL, gen_vv_i, gen_helper_vsrarni_h_w)
-TRANS(vsrarni_w_d, ALL, gen_vv_i, gen_helper_vsrarni_w_d)
-TRANS(vsrarni_d_q, ALL, gen_vv_i, gen_helper_vsrarni_d_q)
-
-TRANS(vssrln_b_h, ALL, gen_vvv, gen_helper_vssrln_b_h)
-TRANS(vssrln_h_w, ALL, gen_vvv, gen_helper_vssrln_h_w)
-TRANS(vssrln_w_d, ALL, gen_vvv, gen_helper_vssrln_w_d)
-TRANS(vssran_b_h, ALL, gen_vvv, gen_helper_vssran_b_h)
-TRANS(vssran_h_w, ALL, gen_vvv, gen_helper_vssran_h_w)
-TRANS(vssran_w_d, ALL, gen_vvv, gen_helper_vssran_w_d)
-TRANS(vssrln_bu_h, ALL, gen_vvv, gen_helper_vssrln_bu_h)
-TRANS(vssrln_hu_w, ALL, gen_vvv, gen_helper_vssrln_hu_w)
-TRANS(vssrln_wu_d, ALL, gen_vvv, gen_helper_vssrln_wu_d)
-TRANS(vssran_bu_h, ALL, gen_vvv, gen_helper_vssran_bu_h)
-TRANS(vssran_hu_w, ALL, gen_vvv, gen_helper_vssran_hu_w)
-TRANS(vssran_wu_d, ALL, gen_vvv, gen_helper_vssran_wu_d)
-
-TRANS(vssrlni_b_h, ALL, gen_vv_i, gen_helper_vssrlni_b_h)
-TRANS(vssrlni_h_w, ALL, gen_vv_i, gen_helper_vssrlni_h_w)
-TRANS(vssrlni_w_d, ALL, gen_vv_i, gen_helper_vssrlni_w_d)
-TRANS(vssrlni_d_q, ALL, gen_vv_i, gen_helper_vssrlni_d_q)
-TRANS(vssrani_b_h, ALL, gen_vv_i, gen_helper_vssrani_b_h)
-TRANS(vssrani_h_w, ALL, gen_vv_i, gen_helper_vssrani_h_w)
-TRANS(vssrani_w_d, ALL, gen_vv_i, gen_helper_vssrani_w_d)
-TRANS(vssrani_d_q, ALL, gen_vv_i, gen_helper_vssrani_d_q)
-TRANS(vssrlni_bu_h, ALL, gen_vv_i, gen_helper_vssrlni_bu_h)
-TRANS(vssrlni_hu_w, ALL, gen_vv_i, gen_helper_vssrlni_hu_w)
-TRANS(vssrlni_wu_d, ALL, gen_vv_i, gen_helper_vssrlni_wu_d)
-TRANS(vssrlni_du_q, ALL, gen_vv_i, gen_helper_vssrlni_du_q)
-TRANS(vssrani_bu_h, ALL, gen_vv_i, gen_helper_vssrani_bu_h)
-TRANS(vssrani_hu_w, ALL, gen_vv_i, gen_helper_vssrani_hu_w)
-TRANS(vssrani_wu_d, ALL, gen_vv_i, gen_helper_vssrani_wu_d)
-TRANS(vssrani_du_q, ALL, gen_vv_i, gen_helper_vssrani_du_q)
-
-TRANS(vssrlrn_b_h, ALL, gen_vvv, gen_helper_vssrlrn_b_h)
-TRANS(vssrlrn_h_w, ALL, gen_vvv, gen_helper_vssrlrn_h_w)
-TRANS(vssrlrn_w_d, ALL, gen_vvv, gen_helper_vssrlrn_w_d)
-TRANS(vssrarn_b_h, ALL, gen_vvv, gen_helper_vssrarn_b_h)
-TRANS(vssrarn_h_w, ALL, gen_vvv, gen_helper_vssrarn_h_w)
-TRANS(vssrarn_w_d, ALL, gen_vvv, gen_helper_vssrarn_w_d)
-TRANS(vssrlrn_bu_h, ALL, gen_vvv, gen_helper_vssrlrn_bu_h)
-TRANS(vssrlrn_hu_w, ALL, gen_vvv, gen_helper_vssrlrn_hu_w)
-TRANS(vssrlrn_wu_d, ALL, gen_vvv, gen_helper_vssrlrn_wu_d)
-TRANS(vssrarn_bu_h, ALL, gen_vvv, gen_helper_vssrarn_bu_h)
-TRANS(vssrarn_hu_w, ALL, gen_vvv, gen_helper_vssrarn_hu_w)
-TRANS(vssrarn_wu_d, ALL, gen_vvv, gen_helper_vssrarn_wu_d)
-
-TRANS(vssrlrni_b_h, ALL, gen_vv_i, gen_helper_vssrlrni_b_h)
-TRANS(vssrlrni_h_w, ALL, gen_vv_i, gen_helper_vssrlrni_h_w)
-TRANS(vssrlrni_w_d, ALL, gen_vv_i, gen_helper_vssrlrni_w_d)
-TRANS(vssrlrni_d_q, ALL, gen_vv_i, gen_helper_vssrlrni_d_q)
-TRANS(vssrarni_b_h, ALL, gen_vv_i, gen_helper_vssrarni_b_h)
-TRANS(vssrarni_h_w, ALL, gen_vv_i, gen_helper_vssrarni_h_w)
-TRANS(vssrarni_w_d, ALL, gen_vv_i, gen_helper_vssrarni_w_d)
-TRANS(vssrarni_d_q, ALL, gen_vv_i, gen_helper_vssrarni_d_q)
-TRANS(vssrlrni_bu_h, ALL, gen_vv_i, gen_helper_vssrlrni_bu_h)
-TRANS(vssrlrni_hu_w, ALL, gen_vv_i, gen_helper_vssrlrni_hu_w)
-TRANS(vssrlrni_wu_d, ALL, gen_vv_i, gen_helper_vssrlrni_wu_d)
-TRANS(vssrlrni_du_q, ALL, gen_vv_i, gen_helper_vssrlrni_du_q)
-TRANS(vssrarni_bu_h, ALL, gen_vv_i, gen_helper_vssrarni_bu_h)
-TRANS(vssrarni_hu_w, ALL, gen_vv_i, gen_helper_vssrarni_hu_w)
-TRANS(vssrarni_wu_d, ALL, gen_vv_i, gen_helper_vssrarni_wu_d)
-TRANS(vssrarni_du_q, ALL, gen_vv_i, gen_helper_vssrarni_du_q)
-
-TRANS(vclo_b, ALL, gen_vv, gen_helper_vclo_b)
-TRANS(vclo_h, ALL, gen_vv, gen_helper_vclo_h)
-TRANS(vclo_w, ALL, gen_vv, gen_helper_vclo_w)
-TRANS(vclo_d, ALL, gen_vv, gen_helper_vclo_d)
-TRANS(vclz_b, ALL, gen_vv, gen_helper_vclz_b)
-TRANS(vclz_h, ALL, gen_vv, gen_helper_vclz_h)
-TRANS(vclz_w, ALL, gen_vv, gen_helper_vclz_w)
-TRANS(vclz_d, ALL, gen_vv, gen_helper_vclz_d)
-
-TRANS(vpcnt_b, ALL, gen_vv, gen_helper_vpcnt_b)
-TRANS(vpcnt_h, ALL, gen_vv, gen_helper_vpcnt_h)
-TRANS(vpcnt_w, ALL, gen_vv, gen_helper_vpcnt_w)
-TRANS(vpcnt_d, ALL, gen_vv, gen_helper_vpcnt_d)
+TRANS(vnori_b, LSX, gvec_vv_i, MO_8, do_vnori_b)
+
+TRANS(vsll_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shlv)
+TRANS(vsll_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shlv)
+TRANS(vsll_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_shlv)
+TRANS(vsll_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_shlv)
+TRANS(vslli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shli)
+TRANS(vslli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shli)
+TRANS(vslli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shli)
+TRANS(vslli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shli)
+
+TRANS(vsrl_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_shrv)
+TRANS(vsrl_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_shrv)
+TRANS(vsrl_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_shrv)
+TRANS(vsrl_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_shrv)
+TRANS(vsrli_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_shri)
+TRANS(vsrli_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_shri)
+TRANS(vsrli_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_shri)
+TRANS(vsrli_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_shri)
+
+TRANS(vsra_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_sarv)
+TRANS(vsra_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_sarv)
+TRANS(vsra_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_sarv)
+TRANS(vsra_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_sarv)
+TRANS(vsrai_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_sari)
+TRANS(vsrai_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_sari)
+TRANS(vsrai_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_sari)
+TRANS(vsrai_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_sari)
+
+TRANS(vrotr_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_rotrv)
+TRANS(vrotr_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_rotrv)
+TRANS(vrotr_w, LSX, gvec_vvv, MO_32, tcg_gen_gvec_rotrv)
+TRANS(vrotr_d, LSX, gvec_vvv, MO_64, tcg_gen_gvec_rotrv)
+TRANS(vrotri_b, LSX, gvec_vv_i, MO_8, tcg_gen_gvec_rotri)
+TRANS(vrotri_h, LSX, gvec_vv_i, MO_16, tcg_gen_gvec_rotri)
+TRANS(vrotri_w, LSX, gvec_vv_i, MO_32, tcg_gen_gvec_rotri)
+TRANS(vrotri_d, LSX, gvec_vv_i, MO_64, tcg_gen_gvec_rotri)
+
+TRANS(vsllwil_h_b, LSX, gen_vv_i, gen_helper_vsllwil_h_b)
+TRANS(vsllwil_w_h, LSX, gen_vv_i, gen_helper_vsllwil_w_h)
+TRANS(vsllwil_d_w, LSX, gen_vv_i, gen_helper_vsllwil_d_w)
+TRANS(vextl_q_d, LSX, gen_vv, gen_helper_vextl_q_d)
+TRANS(vsllwil_hu_bu, LSX, gen_vv_i, gen_helper_vsllwil_hu_bu)
+TRANS(vsllwil_wu_hu, LSX, gen_vv_i, gen_helper_vsllwil_wu_hu)
+TRANS(vsllwil_du_wu, LSX, gen_vv_i, gen_helper_vsllwil_du_wu)
+TRANS(vextl_qu_du, LSX, gen_vv, gen_helper_vextl_qu_du)
+
+TRANS(vsrlr_b, LSX, gen_vvv, gen_helper_vsrlr_b)
+TRANS(vsrlr_h, LSX, gen_vvv, gen_helper_vsrlr_h)
+TRANS(vsrlr_w, LSX, gen_vvv, gen_helper_vsrlr_w)
+TRANS(vsrlr_d, LSX, gen_vvv, gen_helper_vsrlr_d)
+TRANS(vsrlri_b, LSX, gen_vv_i, gen_helper_vsrlri_b)
+TRANS(vsrlri_h, LSX, gen_vv_i, gen_helper_vsrlri_h)
+TRANS(vsrlri_w, LSX, gen_vv_i, gen_helper_vsrlri_w)
+TRANS(vsrlri_d, LSX, gen_vv_i, gen_helper_vsrlri_d)
+
+TRANS(vsrar_b, LSX, gen_vvv, gen_helper_vsrar_b)
+TRANS(vsrar_h, LSX, gen_vvv, gen_helper_vsrar_h)
+TRANS(vsrar_w, LSX, gen_vvv, gen_helper_vsrar_w)
+TRANS(vsrar_d, LSX, gen_vvv, gen_helper_vsrar_d)
+TRANS(vsrari_b, LSX, gen_vv_i, gen_helper_vsrari_b)
+TRANS(vsrari_h, LSX, gen_vv_i, gen_helper_vsrari_h)
+TRANS(vsrari_w, LSX, gen_vv_i, gen_helper_vsrari_w)
+TRANS(vsrari_d, LSX, gen_vv_i, gen_helper_vsrari_d)
+
+TRANS(vsrln_b_h, LSX, gen_vvv, gen_helper_vsrln_b_h)
+TRANS(vsrln_h_w, LSX, gen_vvv, gen_helper_vsrln_h_w)
+TRANS(vsrln_w_d, LSX, gen_vvv, gen_helper_vsrln_w_d)
+TRANS(vsran_b_h, LSX, gen_vvv, gen_helper_vsran_b_h)
+TRANS(vsran_h_w, LSX, gen_vvv, gen_helper_vsran_h_w)
+TRANS(vsran_w_d, LSX, gen_vvv, gen_helper_vsran_w_d)
+
+TRANS(vsrlni_b_h, LSX, gen_vv_i, gen_helper_vsrlni_b_h)
+TRANS(vsrlni_h_w, LSX, gen_vv_i, gen_helper_vsrlni_h_w)
+TRANS(vsrlni_w_d, LSX, gen_vv_i, gen_helper_vsrlni_w_d)
+TRANS(vsrlni_d_q, LSX, gen_vv_i, gen_helper_vsrlni_d_q)
+TRANS(vsrani_b_h, LSX, gen_vv_i, gen_helper_vsrani_b_h)
+TRANS(vsrani_h_w, LSX, gen_vv_i, gen_helper_vsrani_h_w)
+TRANS(vsrani_w_d, LSX, gen_vv_i, gen_helper_vsrani_w_d)
+TRANS(vsrani_d_q, LSX, gen_vv_i, gen_helper_vsrani_d_q)
+
+TRANS(vsrlrn_b_h, LSX, gen_vvv, gen_helper_vsrlrn_b_h)
+TRANS(vsrlrn_h_w, LSX, gen_vvv, gen_helper_vsrlrn_h_w)
+TRANS(vsrlrn_w_d, LSX, gen_vvv, gen_helper_vsrlrn_w_d)
+TRANS(vsrarn_b_h, LSX, gen_vvv, gen_helper_vsrarn_b_h)
+TRANS(vsrarn_h_w, LSX, gen_vvv, gen_helper_vsrarn_h_w)
+TRANS(vsrarn_w_d, LSX, gen_vvv, gen_helper_vsrarn_w_d)
+
+TRANS(vsrlrni_b_h, LSX, gen_vv_i, gen_helper_vsrlrni_b_h)
+TRANS(vsrlrni_h_w, LSX, gen_vv_i, gen_helper_vsrlrni_h_w)
+TRANS(vsrlrni_w_d, LSX, gen_vv_i, gen_helper_vsrlrni_w_d)
+TRANS(vsrlrni_d_q, LSX, gen_vv_i, gen_helper_vsrlrni_d_q)
+TRANS(vsrarni_b_h, LSX, gen_vv_i, gen_helper_vsrarni_b_h)
+TRANS(vsrarni_h_w, LSX, gen_vv_i, gen_helper_vsrarni_h_w)
+TRANS(vsrarni_w_d, LSX, gen_vv_i, gen_helper_vsrarni_w_d)
+TRANS(vsrarni_d_q, LSX, gen_vv_i, gen_helper_vsrarni_d_q)
+
+TRANS(vssrln_b_h, LSX, gen_vvv, gen_helper_vssrln_b_h)
+TRANS(vssrln_h_w, LSX, gen_vvv, gen_helper_vssrln_h_w)
+TRANS(vssrln_w_d, LSX, gen_vvv, gen_helper_vssrln_w_d)
+TRANS(vssran_b_h, LSX, gen_vvv, gen_helper_vssran_b_h)
+TRANS(vssran_h_w, LSX, gen_vvv, gen_helper_vssran_h_w)
+TRANS(vssran_w_d, LSX, gen_vvv, gen_helper_vssran_w_d)
+TRANS(vssrln_bu_h, LSX, gen_vvv, gen_helper_vssrln_bu_h)
+TRANS(vssrln_hu_w, LSX, gen_vvv, gen_helper_vssrln_hu_w)
+TRANS(vssrln_wu_d, LSX, gen_vvv, gen_helper_vssrln_wu_d)
+TRANS(vssran_bu_h, LSX, gen_vvv, gen_helper_vssran_bu_h)
+TRANS(vssran_hu_w, LSX, gen_vvv, gen_helper_vssran_hu_w)
+TRANS(vssran_wu_d, LSX, gen_vvv, gen_helper_vssran_wu_d)
+
+TRANS(vssrlni_b_h, LSX, gen_vv_i, gen_helper_vssrlni_b_h)
+TRANS(vssrlni_h_w, LSX, gen_vv_i, gen_helper_vssrlni_h_w)
+TRANS(vssrlni_w_d, LSX, gen_vv_i, gen_helper_vssrlni_w_d)
+TRANS(vssrlni_d_q, LSX, gen_vv_i, gen_helper_vssrlni_d_q)
+TRANS(vssrani_b_h, LSX, gen_vv_i, gen_helper_vssrani_b_h)
+TRANS(vssrani_h_w, LSX, gen_vv_i, gen_helper_vssrani_h_w)
+TRANS(vssrani_w_d, LSX, gen_vv_i, gen_helper_vssrani_w_d)
+TRANS(vssrani_d_q, LSX, gen_vv_i, gen_helper_vssrani_d_q)
+TRANS(vssrlni_bu_h, LSX, gen_vv_i, gen_helper_vssrlni_bu_h)
+TRANS(vssrlni_hu_w, LSX, gen_vv_i, gen_helper_vssrlni_hu_w)
+TRANS(vssrlni_wu_d, LSX, gen_vv_i, gen_helper_vssrlni_wu_d)
+TRANS(vssrlni_du_q, LSX, gen_vv_i, gen_helper_vssrlni_du_q)
+TRANS(vssrani_bu_h, LSX, gen_vv_i, gen_helper_vssrani_bu_h)
+TRANS(vssrani_hu_w, LSX, gen_vv_i, gen_helper_vssrani_hu_w)
+TRANS(vssrani_wu_d, LSX, gen_vv_i, gen_helper_vssrani_wu_d)
+TRANS(vssrani_du_q, LSX, gen_vv_i, gen_helper_vssrani_du_q)
+
+TRANS(vssrlrn_b_h, LSX, gen_vvv, gen_helper_vssrlrn_b_h)
+TRANS(vssrlrn_h_w, LSX, gen_vvv, gen_helper_vssrlrn_h_w)
+TRANS(vssrlrn_w_d, LSX, gen_vvv, gen_helper_vssrlrn_w_d)
+TRANS(vssrarn_b_h, LSX, gen_vvv, gen_helper_vssrarn_b_h)
+TRANS(vssrarn_h_w, LSX, gen_vvv, gen_helper_vssrarn_h_w)
+TRANS(vssrarn_w_d, LSX, gen_vvv, gen_helper_vssrarn_w_d)
+TRANS(vssrlrn_bu_h, LSX, gen_vvv, gen_helper_vssrlrn_bu_h)
+TRANS(vssrlrn_hu_w, LSX, gen_vvv, gen_helper_vssrlrn_hu_w)
+TRANS(vssrlrn_wu_d, LSX, gen_vvv, gen_helper_vssrlrn_wu_d)
+TRANS(vssrarn_bu_h, LSX, gen_vvv, gen_helper_vssrarn_bu_h)
+TRANS(vssrarn_hu_w, LSX, gen_vvv, gen_helper_vssrarn_hu_w)
+TRANS(vssrarn_wu_d, LSX, gen_vvv, gen_helper_vssrarn_wu_d)
+
+TRANS(vssrlrni_b_h, LSX, gen_vv_i, gen_helper_vssrlrni_b_h)
+TRANS(vssrlrni_h_w, LSX, gen_vv_i, gen_helper_vssrlrni_h_w)
+TRANS(vssrlrni_w_d, LSX, gen_vv_i, gen_helper_vssrlrni_w_d)
+TRANS(vssrlrni_d_q, LSX, gen_vv_i, gen_helper_vssrlrni_d_q)
+TRANS(vssrarni_b_h, LSX, gen_vv_i, gen_helper_vssrarni_b_h)
+TRANS(vssrarni_h_w, LSX, gen_vv_i, gen_helper_vssrarni_h_w)
+TRANS(vssrarni_w_d, LSX, gen_vv_i, gen_helper_vssrarni_w_d)
+TRANS(vssrarni_d_q, LSX, gen_vv_i, gen_helper_vssrarni_d_q)
+TRANS(vssrlrni_bu_h, LSX, gen_vv_i, gen_helper_vssrlrni_bu_h)
+TRANS(vssrlrni_hu_w, LSX, gen_vv_i, gen_helper_vssrlrni_hu_w)
+TRANS(vssrlrni_wu_d, LSX, gen_vv_i, gen_helper_vssrlrni_wu_d)
+TRANS(vssrlrni_du_q, LSX, gen_vv_i, gen_helper_vssrlrni_du_q)
+TRANS(vssrarni_bu_h, LSX, gen_vv_i, gen_helper_vssrarni_bu_h)
+TRANS(vssrarni_hu_w, LSX, gen_vv_i, gen_helper_vssrarni_hu_w)
+TRANS(vssrarni_wu_d, LSX, gen_vv_i, gen_helper_vssrarni_wu_d)
+TRANS(vssrarni_du_q, LSX, gen_vv_i, gen_helper_vssrarni_du_q)
+
+TRANS(vclo_b, LSX, gen_vv, gen_helper_vclo_b)
+TRANS(vclo_h, LSX, gen_vv, gen_helper_vclo_h)
+TRANS(vclo_w, LSX, gen_vv, gen_helper_vclo_w)
+TRANS(vclo_d, LSX, gen_vv, gen_helper_vclo_d)
+TRANS(vclz_b, LSX, gen_vv, gen_helper_vclz_b)
+TRANS(vclz_h, LSX, gen_vv, gen_helper_vclz_h)
+TRANS(vclz_w, LSX, gen_vv, gen_helper_vclz_w)
+TRANS(vclz_d, LSX, gen_vv, gen_helper_vclz_d)
+
+TRANS(vpcnt_b, LSX, gen_vv, gen_helper_vpcnt_b)
+TRANS(vpcnt_h, LSX, gen_vv, gen_helper_vpcnt_h)
+TRANS(vpcnt_w, LSX, gen_vv, gen_helper_vpcnt_w)
+TRANS(vpcnt_d, LSX, gen_vv, gen_helper_vpcnt_d)
 
 static void do_vbit(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3340,10 +3361,10 @@ static void do_vbitclr(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitclr_b, ALL, gvec_vvv, MO_8, do_vbitclr)
-TRANS(vbitclr_h, ALL, gvec_vvv, MO_16, do_vbitclr)
-TRANS(vbitclr_w, ALL, gvec_vvv, MO_32, do_vbitclr)
-TRANS(vbitclr_d, ALL, gvec_vvv, MO_64, do_vbitclr)
+TRANS(vbitclr_b, LSX, gvec_vvv, MO_8, do_vbitclr)
+TRANS(vbitclr_h, LSX, gvec_vvv, MO_16, do_vbitclr)
+TRANS(vbitclr_w, LSX, gvec_vvv, MO_32, do_vbitclr)
+TRANS(vbitclr_d, LSX, gvec_vvv, MO_64, do_vbitclr)
 
 static void do_vbiti(unsigned vece, TCGv_vec t, TCGv_vec a, int64_t imm,
                      void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3410,10 +3431,10 @@ static void do_vbitclri(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitclri_b, ALL, gvec_vv_i, MO_8, do_vbitclri)
-TRANS(vbitclri_h, ALL, gvec_vv_i, MO_16, do_vbitclri)
-TRANS(vbitclri_w, ALL, gvec_vv_i, MO_32, do_vbitclri)
-TRANS(vbitclri_d, ALL, gvec_vv_i, MO_64, do_vbitclri)
+TRANS(vbitclri_b, LSX, gvec_vv_i, MO_8, do_vbitclri)
+TRANS(vbitclri_h, LSX, gvec_vv_i, MO_16, do_vbitclri)
+TRANS(vbitclri_w, LSX, gvec_vv_i, MO_32, do_vbitclri)
+TRANS(vbitclri_d, LSX, gvec_vv_i, MO_64, do_vbitclri)
 
 static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3451,10 +3472,10 @@ static void do_vbitset(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitset_b, ALL, gvec_vvv, MO_8, do_vbitset)
-TRANS(vbitset_h, ALL, gvec_vvv, MO_16, do_vbitset)
-TRANS(vbitset_w, ALL, gvec_vvv, MO_32, do_vbitset)
-TRANS(vbitset_d, ALL, gvec_vvv, MO_64, do_vbitset)
+TRANS(vbitset_b, LSX, gvec_vvv, MO_8, do_vbitset)
+TRANS(vbitset_h, LSX, gvec_vvv, MO_16, do_vbitset)
+TRANS(vbitset_w, LSX, gvec_vvv, MO_32, do_vbitset)
+TRANS(vbitset_d, LSX, gvec_vvv, MO_64, do_vbitset)
 
 static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3492,10 +3513,10 @@ static void do_vbitseti(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitseti_b, ALL, gvec_vv_i, MO_8, do_vbitseti)
-TRANS(vbitseti_h, ALL, gvec_vv_i, MO_16, do_vbitseti)
-TRANS(vbitseti_w, ALL, gvec_vv_i, MO_32, do_vbitseti)
-TRANS(vbitseti_d, ALL, gvec_vv_i, MO_64, do_vbitseti)
+TRANS(vbitseti_b, LSX, gvec_vv_i, MO_8, do_vbitseti)
+TRANS(vbitseti_h, LSX, gvec_vv_i, MO_16, do_vbitseti)
+TRANS(vbitseti_w, LSX, gvec_vv_i, MO_32, do_vbitseti)
+TRANS(vbitseti_d, LSX, gvec_vv_i, MO_64, do_vbitseti)
 
 static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                        uint32_t vk_ofs, uint32_t oprsz, uint32_t maxsz)
@@ -3533,10 +3554,10 @@ static void do_vbitrev(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_3(vd_ofs, vj_ofs, vk_ofs, oprsz, maxsz, &op[vece]);
 }
 
-TRANS(vbitrev_b, ALL, gvec_vvv, MO_8, do_vbitrev)
-TRANS(vbitrev_h, ALL, gvec_vvv, MO_16, do_vbitrev)
-TRANS(vbitrev_w, ALL, gvec_vvv, MO_32, do_vbitrev)
-TRANS(vbitrev_d, ALL, gvec_vvv, MO_64, do_vbitrev)
+TRANS(vbitrev_b, LSX, gvec_vvv, MO_8, do_vbitrev)
+TRANS(vbitrev_h, LSX, gvec_vvv, MO_16, do_vbitrev)
+TRANS(vbitrev_w, LSX, gvec_vvv, MO_32, do_vbitrev)
+TRANS(vbitrev_d, LSX, gvec_vvv, MO_64, do_vbitrev)
 
 static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
                         int64_t imm, uint32_t oprsz, uint32_t maxsz)
@@ -3574,112 +3595,112 @@ static void do_vbitrevi(unsigned vece, uint32_t vd_ofs, uint32_t vj_ofs,
     tcg_gen_gvec_2i(vd_ofs, vj_ofs, oprsz, maxsz, imm, &op[vece]);
 }
 
-TRANS(vbitrevi_b, ALL, gvec_vv_i, MO_8, do_vbitrevi)
-TRANS(vbitrevi_h, ALL, gvec_vv_i, MO_16, do_vbitrevi)
-TRANS(vbitrevi_w, ALL, gvec_vv_i, MO_32, do_vbitrevi)
-TRANS(vbitrevi_d, ALL, gvec_vv_i, MO_64, do_vbitrevi)
-
-TRANS(vfrstp_b, ALL, gen_vvv, gen_helper_vfrstp_b)
-TRANS(vfrstp_h, ALL, gen_vvv, gen_helper_vfrstp_h)
-TRANS(vfrstpi_b, ALL, gen_vv_i, gen_helper_vfrstpi_b)
-TRANS(vfrstpi_h, ALL, gen_vv_i, gen_helper_vfrstpi_h)
-
-TRANS(vfadd_s, ALL, gen_vvv, gen_helper_vfadd_s)
-TRANS(vfadd_d, ALL, gen_vvv, gen_helper_vfadd_d)
-TRANS(vfsub_s, ALL, gen_vvv, gen_helper_vfsub_s)
-TRANS(vfsub_d, ALL, gen_vvv, gen_helper_vfsub_d)
-TRANS(vfmul_s, ALL, gen_vvv, gen_helper_vfmul_s)
-TRANS(vfmul_d, ALL, gen_vvv, gen_helper_vfmul_d)
-TRANS(vfdiv_s, ALL, gen_vvv, gen_helper_vfdiv_s)
-TRANS(vfdiv_d, ALL, gen_vvv, gen_helper_vfdiv_d)
-
-TRANS(vfmadd_s, ALL, gen_vvvv, gen_helper_vfmadd_s)
-TRANS(vfmadd_d, ALL, gen_vvvv, gen_helper_vfmadd_d)
-TRANS(vfmsub_s, ALL, gen_vvvv, gen_helper_vfmsub_s)
-TRANS(vfmsub_d, ALL, gen_vvvv, gen_helper_vfmsub_d)
-TRANS(vfnmadd_s, ALL, gen_vvvv, gen_helper_vfnmadd_s)
-TRANS(vfnmadd_d, ALL, gen_vvvv, gen_helper_vfnmadd_d)
-TRANS(vfnmsub_s, ALL, gen_vvvv, gen_helper_vfnmsub_s)
-TRANS(vfnmsub_d, ALL, gen_vvvv, gen_helper_vfnmsub_d)
-
-TRANS(vfmax_s, ALL, gen_vvv, gen_helper_vfmax_s)
-TRANS(vfmax_d, ALL, gen_vvv, gen_helper_vfmax_d)
-TRANS(vfmin_s, ALL, gen_vvv, gen_helper_vfmin_s)
-TRANS(vfmin_d, ALL, gen_vvv, gen_helper_vfmin_d)
-
-TRANS(vfmaxa_s, ALL, gen_vvv, gen_helper_vfmaxa_s)
-TRANS(vfmaxa_d, ALL, gen_vvv, gen_helper_vfmaxa_d)
-TRANS(vfmina_s, ALL, gen_vvv, gen_helper_vfmina_s)
-TRANS(vfmina_d, ALL, gen_vvv, gen_helper_vfmina_d)
-
-TRANS(vflogb_s, ALL, gen_vv, gen_helper_vflogb_s)
-TRANS(vflogb_d, ALL, gen_vv, gen_helper_vflogb_d)
-
-TRANS(vfclass_s, ALL, gen_vv, gen_helper_vfclass_s)
-TRANS(vfclass_d, ALL, gen_vv, gen_helper_vfclass_d)
-
-TRANS(vfsqrt_s, ALL, gen_vv, gen_helper_vfsqrt_s)
-TRANS(vfsqrt_d, ALL, gen_vv, gen_helper_vfsqrt_d)
-TRANS(vfrecip_s, ALL, gen_vv, gen_helper_vfrecip_s)
-TRANS(vfrecip_d, ALL, gen_vv, gen_helper_vfrecip_d)
-TRANS(vfrsqrt_s, ALL, gen_vv, gen_helper_vfrsqrt_s)
-TRANS(vfrsqrt_d, ALL, gen_vv, gen_helper_vfrsqrt_d)
-
-TRANS(vfcvtl_s_h, ALL, gen_vv, gen_helper_vfcvtl_s_h)
-TRANS(vfcvth_s_h, ALL, gen_vv, gen_helper_vfcvth_s_h)
-TRANS(vfcvtl_d_s, ALL, gen_vv, gen_helper_vfcvtl_d_s)
-TRANS(vfcvth_d_s, ALL, gen_vv, gen_helper_vfcvth_d_s)
-TRANS(vfcvt_h_s, ALL, gen_vvv, gen_helper_vfcvt_h_s)
-TRANS(vfcvt_s_d, ALL, gen_vvv, gen_helper_vfcvt_s_d)
-
-TRANS(vfrintrne_s, ALL, gen_vv, gen_helper_vfrintrne_s)
-TRANS(vfrintrne_d, ALL, gen_vv, gen_helper_vfrintrne_d)
-TRANS(vfrintrz_s, ALL, gen_vv, gen_helper_vfrintrz_s)
-TRANS(vfrintrz_d, ALL, gen_vv, gen_helper_vfrintrz_d)
-TRANS(vfrintrp_s, ALL, gen_vv, gen_helper_vfrintrp_s)
-TRANS(vfrintrp_d, ALL, gen_vv, gen_helper_vfrintrp_d)
-TRANS(vfrintrm_s, ALL, gen_vv, gen_helper_vfrintrm_s)
-TRANS(vfrintrm_d, ALL, gen_vv, gen_helper_vfrintrm_d)
-TRANS(vfrint_s, ALL, gen_vv, gen_helper_vfrint_s)
-TRANS(vfrint_d, ALL, gen_vv, gen_helper_vfrint_d)
-
-TRANS(vftintrne_w_s, ALL, gen_vv, gen_helper_vftintrne_w_s)
-TRANS(vftintrne_l_d, ALL, gen_vv, gen_helper_vftintrne_l_d)
-TRANS(vftintrz_w_s, ALL, gen_vv, gen_helper_vftintrz_w_s)
-TRANS(vftintrz_l_d, ALL, gen_vv, gen_helper_vftintrz_l_d)
-TRANS(vftintrp_w_s, ALL, gen_vv, gen_helper_vftintrp_w_s)
-TRANS(vftintrp_l_d, ALL, gen_vv, gen_helper_vftintrp_l_d)
-TRANS(vftintrm_w_s, ALL, gen_vv, gen_helper_vftintrm_w_s)
-TRANS(vftintrm_l_d, ALL, gen_vv, gen_helper_vftintrm_l_d)
-TRANS(vftint_w_s, ALL, gen_vv, gen_helper_vftint_w_s)
-TRANS(vftint_l_d, ALL, gen_vv, gen_helper_vftint_l_d)
-TRANS(vftintrz_wu_s, ALL, gen_vv, gen_helper_vftintrz_wu_s)
-TRANS(vftintrz_lu_d, ALL, gen_vv, gen_helper_vftintrz_lu_d)
-TRANS(vftint_wu_s, ALL, gen_vv, gen_helper_vftint_wu_s)
-TRANS(vftint_lu_d, ALL, gen_vv, gen_helper_vftint_lu_d)
-TRANS(vftintrne_w_d, ALL, gen_vvv, gen_helper_vftintrne_w_d)
-TRANS(vftintrz_w_d, ALL, gen_vvv, gen_helper_vftintrz_w_d)
-TRANS(vftintrp_w_d, ALL, gen_vvv, gen_helper_vftintrp_w_d)
-TRANS(vftintrm_w_d, ALL, gen_vvv, gen_helper_vftintrm_w_d)
-TRANS(vftint_w_d, ALL, gen_vvv, gen_helper_vftint_w_d)
-TRANS(vftintrnel_l_s, ALL, gen_vv, gen_helper_vftintrnel_l_s)
-TRANS(vftintrneh_l_s, ALL, gen_vv, gen_helper_vftintrneh_l_s)
-TRANS(vftintrzl_l_s, ALL, gen_vv, gen_helper_vftintrzl_l_s)
-TRANS(vftintrzh_l_s, ALL, gen_vv, gen_helper_vftintrzh_l_s)
-TRANS(vftintrpl_l_s, ALL, gen_vv, gen_helper_vftintrpl_l_s)
-TRANS(vftintrph_l_s, ALL, gen_vv, gen_helper_vftintrph_l_s)
-TRANS(vftintrml_l_s, ALL, gen_vv, gen_helper_vftintrml_l_s)
-TRANS(vftintrmh_l_s, ALL, gen_vv, gen_helper_vftintrmh_l_s)
-TRANS(vftintl_l_s, ALL, gen_vv, gen_helper_vftintl_l_s)
-TRANS(vftinth_l_s, ALL, gen_vv, gen_helper_vftinth_l_s)
-
-TRANS(vffint_s_w, ALL, gen_vv, gen_helper_vffint_s_w)
-TRANS(vffint_d_l, ALL, gen_vv, gen_helper_vffint_d_l)
-TRANS(vffint_s_wu, ALL, gen_vv, gen_helper_vffint_s_wu)
-TRANS(vffint_d_lu, ALL, gen_vv, gen_helper_vffint_d_lu)
-TRANS(vffintl_d_w, ALL, gen_vv, gen_helper_vffintl_d_w)
-TRANS(vffinth_d_w, ALL, gen_vv, gen_helper_vffinth_d_w)
-TRANS(vffint_s_l, ALL, gen_vvv, gen_helper_vffint_s_l)
+TRANS(vbitrevi_b, LSX, gvec_vv_i, MO_8, do_vbitrevi)
+TRANS(vbitrevi_h, LSX, gvec_vv_i, MO_16, do_vbitrevi)
+TRANS(vbitrevi_w, LSX, gvec_vv_i, MO_32, do_vbitrevi)
+TRANS(vbitrevi_d, LSX, gvec_vv_i, MO_64, do_vbitrevi)
+
+TRANS(vfrstp_b, LSX, gen_vvv, gen_helper_vfrstp_b)
+TRANS(vfrstp_h, LSX, gen_vvv, gen_helper_vfrstp_h)
+TRANS(vfrstpi_b, LSX, gen_vv_i, gen_helper_vfrstpi_b)
+TRANS(vfrstpi_h, LSX, gen_vv_i, gen_helper_vfrstpi_h)
+
+TRANS(vfadd_s, LSX, gen_vvv, gen_helper_vfadd_s)
+TRANS(vfadd_d, LSX, gen_vvv, gen_helper_vfadd_d)
+TRANS(vfsub_s, LSX, gen_vvv, gen_helper_vfsub_s)
+TRANS(vfsub_d, LSX, gen_vvv, gen_helper_vfsub_d)
+TRANS(vfmul_s, LSX, gen_vvv, gen_helper_vfmul_s)
+TRANS(vfmul_d, LSX, gen_vvv, gen_helper_vfmul_d)
+TRANS(vfdiv_s, LSX, gen_vvv, gen_helper_vfdiv_s)
+TRANS(vfdiv_d, LSX, gen_vvv, gen_helper_vfdiv_d)
+
+TRANS(vfmadd_s, LSX, gen_vvvv, gen_helper_vfmadd_s)
+TRANS(vfmadd_d, LSX, gen_vvvv, gen_helper_vfmadd_d)
+TRANS(vfmsub_s, LSX, gen_vvvv, gen_helper_vfmsub_s)
+TRANS(vfmsub_d, LSX, gen_vvvv, gen_helper_vfmsub_d)
+TRANS(vfnmadd_s, LSX, gen_vvvv, gen_helper_vfnmadd_s)
+TRANS(vfnmadd_d, LSX, gen_vvvv, gen_helper_vfnmadd_d)
+TRANS(vfnmsub_s, LSX, gen_vvvv, gen_helper_vfnmsub_s)
+TRANS(vfnmsub_d, LSX, gen_vvvv, gen_helper_vfnmsub_d)
+
+TRANS(vfmax_s, LSX, gen_vvv, gen_helper_vfmax_s)
+TRANS(vfmax_d, LSX, gen_vvv, gen_helper_vfmax_d)
+TRANS(vfmin_s, LSX, gen_vvv, gen_helper_vfmin_s)
+TRANS(vfmin_d, LSX, gen_vvv, gen_helper_vfmin_d)
+
+TRANS(vfmaxa_s, LSX, gen_vvv, gen_helper_vfmaxa_s)
+TRANS(vfmaxa_d, LSX, gen_vvv, gen_helper_vfmaxa_d)
+TRANS(vfmina_s, LSX, gen_vvv, gen_helper_vfmina_s)
+TRANS(vfmina_d, LSX, gen_vvv, gen_helper_vfmina_d)
+
+TRANS(vflogb_s, LSX, gen_vv, gen_helper_vflogb_s)
+TRANS(vflogb_d, LSX, gen_vv, gen_helper_vflogb_d)
+
+TRANS(vfclass_s, LSX, gen_vv, gen_helper_vfclass_s)
+TRANS(vfclass_d, LSX, gen_vv, gen_helper_vfclass_d)
+
+TRANS(vfsqrt_s, LSX, gen_vv, gen_helper_vfsqrt_s)
+TRANS(vfsqrt_d, LSX, gen_vv, gen_helper_vfsqrt_d)
+TRANS(vfrecip_s, LSX, gen_vv, gen_helper_vfrecip_s)
+TRANS(vfrecip_d, LSX, gen_vv, gen_helper_vfrecip_d)
+TRANS(vfrsqrt_s, LSX, gen_vv, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrt_d, LSX, gen_vv, gen_helper_vfrsqrt_d)
+
+TRANS(vfcvtl_s_h, LSX, gen_vv, gen_helper_vfcvtl_s_h)
+TRANS(vfcvth_s_h, LSX, gen_vv, gen_helper_vfcvth_s_h)
+TRANS(vfcvtl_d_s, LSX, gen_vv, gen_helper_vfcvtl_d_s)
+TRANS(vfcvth_d_s, LSX, gen_vv, gen_helper_vfcvth_d_s)
+TRANS(vfcvt_h_s, LSX, gen_vvv, gen_helper_vfcvt_h_s)
+TRANS(vfcvt_s_d, LSX, gen_vvv, gen_helper_vfcvt_s_d)
+
+TRANS(vfrintrne_s, LSX, gen_vv, gen_helper_vfrintrne_s)
+TRANS(vfrintrne_d, LSX, gen_vv, gen_helper_vfrintrne_d)
+TRANS(vfrintrz_s, LSX, gen_vv, gen_helper_vfrintrz_s)
+TRANS(vfrintrz_d, LSX, gen_vv, gen_helper_vfrintrz_d)
+TRANS(vfrintrp_s, LSX, gen_vv, gen_helper_vfrintrp_s)
+TRANS(vfrintrp_d, LSX, gen_vv, gen_helper_vfrintrp_d)
+TRANS(vfrintrm_s, LSX, gen_vv, gen_helper_vfrintrm_s)
+TRANS(vfrintrm_d, LSX, gen_vv, gen_helper_vfrintrm_d)
+TRANS(vfrint_s, LSX, gen_vv, gen_helper_vfrint_s)
+TRANS(vfrint_d, LSX, gen_vv, gen_helper_vfrint_d)
+
+TRANS(vftintrne_w_s, LSX, gen_vv, gen_helper_vftintrne_w_s)
+TRANS(vftintrne_l_d, LSX, gen_vv, gen_helper_vftintrne_l_d)
+TRANS(vftintrz_w_s, LSX, gen_vv, gen_helper_vftintrz_w_s)
+TRANS(vftintrz_l_d, LSX, gen_vv, gen_helper_vftintrz_l_d)
+TRANS(vftintrp_w_s, LSX, gen_vv, gen_helper_vftintrp_w_s)
+TRANS(vftintrp_l_d, LSX, gen_vv, gen_helper_vftintrp_l_d)
+TRANS(vftintrm_w_s, LSX, gen_vv, gen_helper_vftintrm_w_s)
+TRANS(vftintrm_l_d, LSX, gen_vv, gen_helper_vftintrm_l_d)
+TRANS(vftint_w_s, LSX, gen_vv, gen_helper_vftint_w_s)
+TRANS(vftint_l_d, LSX, gen_vv, gen_helper_vftint_l_d)
+TRANS(vftintrz_wu_s, LSX, gen_vv, gen_helper_vftintrz_wu_s)
+TRANS(vftintrz_lu_d, LSX, gen_vv, gen_helper_vftintrz_lu_d)
+TRANS(vftint_wu_s, LSX, gen_vv, gen_helper_vftint_wu_s)
+TRANS(vftint_lu_d, LSX, gen_vv, gen_helper_vftint_lu_d)
+TRANS(vftintrne_w_d, LSX, gen_vvv, gen_helper_vftintrne_w_d)
+TRANS(vftintrz_w_d, LSX, gen_vvv, gen_helper_vftintrz_w_d)
+TRANS(vftintrp_w_d, LSX, gen_vvv, gen_helper_vftintrp_w_d)
+TRANS(vftintrm_w_d, LSX, gen_vvv, gen_helper_vftintrm_w_d)
+TRANS(vftint_w_d, LSX, gen_vvv, gen_helper_vftint_w_d)
+TRANS(vftintrnel_l_s, LSX, gen_vv, gen_helper_vftintrnel_l_s)
+TRANS(vftintrneh_l_s, LSX, gen_vv, gen_helper_vftintrneh_l_s)
+TRANS(vftintrzl_l_s, LSX, gen_vv, gen_helper_vftintrzl_l_s)
+TRANS(vftintrzh_l_s, LSX, gen_vv, gen_helper_vftintrzh_l_s)
+TRANS(vftintrpl_l_s, LSX, gen_vv, gen_helper_vftintrpl_l_s)
+TRANS(vftintrph_l_s, LSX, gen_vv, gen_helper_vftintrph_l_s)
+TRANS(vftintrml_l_s, LSX, gen_vv, gen_helper_vftintrml_l_s)
+TRANS(vftintrmh_l_s, LSX, gen_vv, gen_helper_vftintrmh_l_s)
+TRANS(vftintl_l_s, LSX, gen_vv, gen_helper_vftintl_l_s)
+TRANS(vftinth_l_s, LSX, gen_vv, gen_helper_vftinth_l_s)
+
+TRANS(vffint_s_w, LSX, gen_vv, gen_helper_vffint_s_w)
+TRANS(vffint_d_l, LSX, gen_vv, gen_helper_vffint_d_l)
+TRANS(vffint_s_wu, LSX, gen_vv, gen_helper_vffint_s_wu)
+TRANS(vffint_d_lu, LSX, gen_vv, gen_helper_vffint_d_lu)
+TRANS(vffintl_d_w, LSX, gen_vv, gen_helper_vffintl_d_w)
+TRANS(vffinth_d_w, LSX, gen_vv, gen_helper_vffinth_d_w)
+TRANS(vffint_s_l, LSX, gen_vvv, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
@@ -3823,48 +3844,48 @@ static bool do_## NAME ##_u(DisasContext *ctx, arg_vv_i *a, MemOp mop) \
 DO_CMPI_U(vslei)
 DO_CMPI_U(vslti)
 
-TRANS(vseq_b, ALL, do_cmp, MO_8, TCG_COND_EQ)
-TRANS(vseq_h, ALL, do_cmp, MO_16, TCG_COND_EQ)
-TRANS(vseq_w, ALL, do_cmp, MO_32, TCG_COND_EQ)
-TRANS(vseq_d, ALL, do_cmp, MO_64, TCG_COND_EQ)
-TRANS(vseqi_b, ALL, do_vseqi_s, MO_8)
-TRANS(vseqi_h, ALL, do_vseqi_s, MO_16)
-TRANS(vseqi_w, ALL, do_vseqi_s, MO_32)
-TRANS(vseqi_d, ALL, do_vseqi_s, MO_64)
-
-TRANS(vsle_b, ALL, do_cmp, MO_8, TCG_COND_LE)
-TRANS(vsle_h, ALL, do_cmp, MO_16, TCG_COND_LE)
-TRANS(vsle_w, ALL, do_cmp, MO_32, TCG_COND_LE)
-TRANS(vsle_d, ALL, do_cmp, MO_64, TCG_COND_LE)
-TRANS(vslei_b, ALL, do_vslei_s, MO_8)
-TRANS(vslei_h, ALL, do_vslei_s, MO_16)
-TRANS(vslei_w, ALL, do_vslei_s, MO_32)
-TRANS(vslei_d, ALL, do_vslei_s, MO_64)
-TRANS(vsle_bu, ALL, do_cmp, MO_8, TCG_COND_LEU)
-TRANS(vsle_hu, ALL, do_cmp, MO_16, TCG_COND_LEU)
-TRANS(vsle_wu, ALL, do_cmp, MO_32, TCG_COND_LEU)
-TRANS(vsle_du, ALL, do_cmp, MO_64, TCG_COND_LEU)
-TRANS(vslei_bu, ALL, do_vslei_u, MO_8)
-TRANS(vslei_hu, ALL, do_vslei_u, MO_16)
-TRANS(vslei_wu, ALL, do_vslei_u, MO_32)
-TRANS(vslei_du, ALL, do_vslei_u, MO_64)
-
-TRANS(vslt_b, ALL, do_cmp, MO_8, TCG_COND_LT)
-TRANS(vslt_h, ALL, do_cmp, MO_16, TCG_COND_LT)
-TRANS(vslt_w, ALL, do_cmp, MO_32, TCG_COND_LT)
-TRANS(vslt_d, ALL, do_cmp, MO_64, TCG_COND_LT)
-TRANS(vslti_b, ALL, do_vslti_s, MO_8)
-TRANS(vslti_h, ALL, do_vslti_s, MO_16)
-TRANS(vslti_w, ALL, do_vslti_s, MO_32)
-TRANS(vslti_d, ALL, do_vslti_s, MO_64)
-TRANS(vslt_bu, ALL, do_cmp, MO_8, TCG_COND_LTU)
-TRANS(vslt_hu, ALL, do_cmp, MO_16, TCG_COND_LTU)
-TRANS(vslt_wu, ALL, do_cmp, MO_32, TCG_COND_LTU)
-TRANS(vslt_du, ALL, do_cmp, MO_64, TCG_COND_LTU)
-TRANS(vslti_bu, ALL, do_vslti_u, MO_8)
-TRANS(vslti_hu, ALL, do_vslti_u, MO_16)
-TRANS(vslti_wu, ALL, do_vslti_u, MO_32)
-TRANS(vslti_du, ALL, do_vslti_u, MO_64)
+TRANS(vseq_b, LSX, do_cmp, MO_8, TCG_COND_EQ)
+TRANS(vseq_h, LSX, do_cmp, MO_16, TCG_COND_EQ)
+TRANS(vseq_w, LSX, do_cmp, MO_32, TCG_COND_EQ)
+TRANS(vseq_d, LSX, do_cmp, MO_64, TCG_COND_EQ)
+TRANS(vseqi_b, LSX, do_vseqi_s, MO_8)
+TRANS(vseqi_h, LSX, do_vseqi_s, MO_16)
+TRANS(vseqi_w, LSX, do_vseqi_s, MO_32)
+TRANS(vseqi_d, LSX, do_vseqi_s, MO_64)
+
+TRANS(vsle_b, LSX, do_cmp, MO_8, TCG_COND_LE)
+TRANS(vsle_h, LSX, do_cmp, MO_16, TCG_COND_LE)
+TRANS(vsle_w, LSX, do_cmp, MO_32, TCG_COND_LE)
+TRANS(vsle_d, LSX, do_cmp, MO_64, TCG_COND_LE)
+TRANS(vslei_b, LSX, do_vslei_s, MO_8)
+TRANS(vslei_h, LSX, do_vslei_s, MO_16)
+TRANS(vslei_w, LSX, do_vslei_s, MO_32)
+TRANS(vslei_d, LSX, do_vslei_s, MO_64)
+TRANS(vsle_bu, LSX, do_cmp, MO_8, TCG_COND_LEU)
+TRANS(vsle_hu, LSX, do_cmp, MO_16, TCG_COND_LEU)
+TRANS(vsle_wu, LSX, do_cmp, MO_32, TCG_COND_LEU)
+TRANS(vsle_du, LSX, do_cmp, MO_64, TCG_COND_LEU)
+TRANS(vslei_bu, LSX, do_vslei_u, MO_8)
+TRANS(vslei_hu, LSX, do_vslei_u, MO_16)
+TRANS(vslei_wu, LSX, do_vslei_u, MO_32)
+TRANS(vslei_du, LSX, do_vslei_u, MO_64)
+
+TRANS(vslt_b, LSX, do_cmp, MO_8, TCG_COND_LT)
+TRANS(vslt_h, LSX, do_cmp, MO_16, TCG_COND_LT)
+TRANS(vslt_w, LSX, do_cmp, MO_32, TCG_COND_LT)
+TRANS(vslt_d, LSX, do_cmp, MO_64, TCG_COND_LT)
+TRANS(vslti_b, LSX, do_vslti_s, MO_8)
+TRANS(vslti_h, LSX, do_vslti_s, MO_16)
+TRANS(vslti_w, LSX, do_vslti_s, MO_32)
+TRANS(vslti_d, LSX, do_vslti_s, MO_64)
+TRANS(vslt_bu, LSX, do_cmp, MO_8, TCG_COND_LTU)
+TRANS(vslt_hu, LSX, do_cmp, MO_16, TCG_COND_LTU)
+TRANS(vslt_wu, LSX, do_cmp, MO_32, TCG_COND_LTU)
+TRANS(vslt_du, LSX, do_cmp, MO_64, TCG_COND_LTU)
+TRANS(vslti_bu, LSX, do_vslti_u, MO_8)
+TRANS(vslti_hu, LSX, do_vslti_u, MO_16)
+TRANS(vslti_wu, LSX, do_vslti_u, MO_32)
+TRANS(vslti_du, LSX, do_vslti_u, MO_64)
 
 static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
 {
@@ -3874,6 +3895,10 @@ static bool trans_vfcmp_cond_s(DisasContext *ctx, arg_vvv_fcond *a)
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_s : gen_helper_vfcmp_c_s);
@@ -3891,6 +3916,12 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
+    CHECK_SXE;
+
     fn = (a->fcond & 1 ? gen_helper_vfcmp_s_d : gen_helper_vfcmp_c_d);
     flags = get_fcmp_flags(a->fcond >> 1);
     fn(cpu_env, vd, vj, vk, tcg_constant_i32(flags));
@@ -3900,6 +3931,10 @@ static bool trans_vfcmp_cond_d(DisasContext *ctx, arg_vvv_fcond *a)
 
 static bool trans_vbitsel_v(DisasContext *ctx, arg_vvvv *a)
 {
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     tcg_gen_gvec_bitsel(MO_64, vec_full_offset(a->vd), vec_full_offset(a->va),
@@ -3922,6 +3957,10 @@ static bool trans_vbitseli_b(DisasContext *ctx, arg_vv_i *a)
        .load_dest = true
     };
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     tcg_gen_gvec_2i(vec_full_offset(a->vd), vec_full_offset(a->vj),
@@ -3941,6 +3980,10 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
     get_vreg64(ah, a->vj, 1);                                                  \
     get_vreg64(al, a->vj, 0);                                                  \
                                                                                \
+    if (!avail_LSX(ctx)) {                                                     \
+        return false;                                                          \
+    }                                                                          \
+                                                                               \
     CHECK_SXE;                                                                 \
     tcg_gen_or_i64(t1, al, ah);                                                \
     tcg_gen_setcondi_i64(COND, t1, t1, 0);                                     \
@@ -3952,18 +3995,23 @@ static bool trans_## NAME (DisasContext *ctx, arg_cv *a)                       \
 VSET(vseteqz_v, TCG_COND_EQ)
 VSET(vsetnez_v, TCG_COND_NE)
 
-TRANS(vsetanyeqz_b, ALL, gen_cv, gen_helper_vsetanyeqz_b)
-TRANS(vsetanyeqz_h, ALL, gen_cv, gen_helper_vsetanyeqz_h)
-TRANS(vsetanyeqz_w, ALL, gen_cv, gen_helper_vsetanyeqz_w)
-TRANS(vsetanyeqz_d, ALL, gen_cv, gen_helper_vsetanyeqz_d)
-TRANS(vsetallnez_b, ALL, gen_cv, gen_helper_vsetallnez_b)
-TRANS(vsetallnez_h, ALL, gen_cv, gen_helper_vsetallnez_h)
-TRANS(vsetallnez_w, ALL, gen_cv, gen_helper_vsetallnez_w)
-TRANS(vsetallnez_d, ALL, gen_cv, gen_helper_vsetallnez_d)
+TRANS(vsetanyeqz_b, LSX, gen_cv, gen_helper_vsetanyeqz_b)
+TRANS(vsetanyeqz_h, LSX, gen_cv, gen_helper_vsetanyeqz_h)
+TRANS(vsetanyeqz_w, LSX, gen_cv, gen_helper_vsetanyeqz_w)
+TRANS(vsetanyeqz_d, LSX, gen_cv, gen_helper_vsetanyeqz_d)
+TRANS(vsetallnez_b, LSX, gen_cv, gen_helper_vsetallnez_b)
+TRANS(vsetallnez_h, LSX, gen_cv, gen_helper_vsetallnez_h)
+TRANS(vsetallnez_w, LSX, gen_cv, gen_helper_vsetallnez_w)
+TRANS(vsetallnez_d, LSX, gen_cv, gen_helper_vsetallnez_d)
 
 static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_st8_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.B(a->imm)));
@@ -3973,6 +4021,11 @@ static bool trans_vinsgr2vr_b(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_st16_i64(src, cpu_env,
                     offsetof(CPULoongArchState, fpr[a->vd].vreg.H(a->imm)));
@@ -3982,6 +4035,11 @@ static bool trans_vinsgr2vr_h(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_st32_i64(src, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vd].vreg.W(a->imm)));
@@ -3991,6 +4049,11 @@ static bool trans_vinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_st_i64(src, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vd].vreg.D(a->imm)));
@@ -4000,6 +4063,11 @@ static bool trans_vinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
 static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld8s_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
@@ -4009,6 +4077,11 @@ static bool trans_vpickve2gr_b(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld16s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
@@ -4018,6 +4091,11 @@ static bool trans_vpickve2gr_h(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld32s_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
@@ -4027,6 +4105,11 @@ static bool trans_vpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
@@ -4036,6 +4119,11 @@ static bool trans_vpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld8u_i64(dst, cpu_env,
                      offsetof(CPULoongArchState, fpr[a->vj].vreg.B(a->imm)));
@@ -4045,6 +4133,11 @@ static bool trans_vpickve2gr_bu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld16u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.H(a->imm)));
@@ -4054,6 +4147,11 @@ static bool trans_vpickve2gr_hu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld32u_i64(dst, cpu_env,
                       offsetof(CPULoongArchState, fpr[a->vj].vreg.W(a->imm)));
@@ -4063,6 +4161,11 @@ static bool trans_vpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
 static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 {
     TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_ld_i64(dst, cpu_env,
                    offsetof(CPULoongArchState, fpr[a->vj].vreg.D(a->imm)));
@@ -4072,6 +4175,11 @@ static bool trans_vpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
 static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd),
@@ -4079,13 +4187,17 @@ static bool gvec_dup(DisasContext *ctx, arg_vr *a, MemOp mop)
     return true;
 }
 
-TRANS(vreplgr2vr_b, ALL, gvec_dup, MO_8)
-TRANS(vreplgr2vr_h, ALL, gvec_dup, MO_16)
-TRANS(vreplgr2vr_w, ALL, gvec_dup, MO_32)
-TRANS(vreplgr2vr_d, ALL, gvec_dup, MO_64)
+TRANS(vreplgr2vr_b, LSX, gvec_dup, MO_8)
+TRANS(vreplgr2vr_h, LSX, gvec_dup, MO_16)
+TRANS(vreplgr2vr_w, LSX, gvec_dup, MO_32)
+TRANS(vreplgr2vr_d, LSX, gvec_dup, MO_64)
 
 static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 {
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_gvec_dup_mem(MO_8,vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
@@ -4096,6 +4208,10 @@ static bool trans_vreplvei_b(DisasContext *ctx, arg_vv_i *a)
 
 static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 {
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_gvec_dup_mem(MO_16, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
@@ -4105,6 +4221,10 @@ static bool trans_vreplvei_h(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 {
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_gvec_dup_mem(MO_32, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
@@ -4114,6 +4234,10 @@ static bool trans_vreplvei_w(DisasContext *ctx, arg_vv_i *a)
 }
 static bool trans_vreplvei_d(DisasContext *ctx, arg_vv_i *a)
 {
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
     tcg_gen_gvec_dup_mem(MO_64, vec_full_offset(a->vd),
                          offsetof(CPULoongArchState,
@@ -4129,6 +4253,10 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     TCGv_ptr t1 = tcg_temp_new_ptr();
     TCGv_i64 t2 = tcg_temp_new_i64();
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN/bit) -1);
@@ -4145,16 +4273,20 @@ static bool gen_vreplve(DisasContext *ctx, arg_vvr *a, int vece, int bit,
     return true;
 }
 
-TRANS(vreplve_b, ALL, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
-TRANS(vreplve_h, ALL, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
-TRANS(vreplve_w, ALL, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
-TRANS(vreplve_d, ALL, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
+TRANS(vreplve_b, LSX, gen_vreplve, MO_8,  8, tcg_gen_ld8u_i64)
+TRANS(vreplve_h, LSX, gen_vreplve, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(vreplve_w, LSX, gen_vreplve, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(vreplve_d, LSX, gen_vreplve, MO_64, 64, tcg_gen_ld_i64)
 
 static bool trans_vbsll_v(DisasContext *ctx, arg_vv_i *a)
 {
     int ofs;
     TCGv_i64 desthigh, destlow, high, low;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     desthigh = tcg_temp_new_i64();
@@ -4185,6 +4317,10 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     TCGv_i64 desthigh, destlow, high, low;
     int ofs;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     desthigh = tcg_temp_new_i64();
@@ -4210,48 +4346,48 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
     return true;
 }
 
-TRANS(vpackev_b, ALL, gen_vvv, gen_helper_vpackev_b)
-TRANS(vpackev_h, ALL, gen_vvv, gen_helper_vpackev_h)
-TRANS(vpackev_w, ALL, gen_vvv, gen_helper_vpackev_w)
-TRANS(vpackev_d, ALL, gen_vvv, gen_helper_vpackev_d)
-TRANS(vpackod_b, ALL, gen_vvv, gen_helper_vpackod_b)
-TRANS(vpackod_h, ALL, gen_vvv, gen_helper_vpackod_h)
-TRANS(vpackod_w, ALL, gen_vvv, gen_helper_vpackod_w)
-TRANS(vpackod_d, ALL, gen_vvv, gen_helper_vpackod_d)
-
-TRANS(vpickev_b, ALL, gen_vvv, gen_helper_vpickev_b)
-TRANS(vpickev_h, ALL, gen_vvv, gen_helper_vpickev_h)
-TRANS(vpickev_w, ALL, gen_vvv, gen_helper_vpickev_w)
-TRANS(vpickev_d, ALL, gen_vvv, gen_helper_vpickev_d)
-TRANS(vpickod_b, ALL, gen_vvv, gen_helper_vpickod_b)
-TRANS(vpickod_h, ALL, gen_vvv, gen_helper_vpickod_h)
-TRANS(vpickod_w, ALL, gen_vvv, gen_helper_vpickod_w)
-TRANS(vpickod_d, ALL, gen_vvv, gen_helper_vpickod_d)
-
-TRANS(vilvl_b, ALL, gen_vvv, gen_helper_vilvl_b)
-TRANS(vilvl_h, ALL, gen_vvv, gen_helper_vilvl_h)
-TRANS(vilvl_w, ALL, gen_vvv, gen_helper_vilvl_w)
-TRANS(vilvl_d, ALL, gen_vvv, gen_helper_vilvl_d)
-TRANS(vilvh_b, ALL, gen_vvv, gen_helper_vilvh_b)
-TRANS(vilvh_h, ALL, gen_vvv, gen_helper_vilvh_h)
-TRANS(vilvh_w, ALL, gen_vvv, gen_helper_vilvh_w)
-TRANS(vilvh_d, ALL, gen_vvv, gen_helper_vilvh_d)
-
-TRANS(vshuf_b, ALL, gen_vvvv, gen_helper_vshuf_b)
-TRANS(vshuf_h, ALL, gen_vvv, gen_helper_vshuf_h)
-TRANS(vshuf_w, ALL, gen_vvv, gen_helper_vshuf_w)
-TRANS(vshuf_d, ALL, gen_vvv, gen_helper_vshuf_d)
-TRANS(vshuf4i_b, ALL, gen_vv_i, gen_helper_vshuf4i_b)
-TRANS(vshuf4i_h, ALL, gen_vv_i, gen_helper_vshuf4i_h)
-TRANS(vshuf4i_w, ALL, gen_vv_i, gen_helper_vshuf4i_w)
-TRANS(vshuf4i_d, ALL, gen_vv_i, gen_helper_vshuf4i_d)
-
-TRANS(vpermi_w, ALL, gen_vv_i, gen_helper_vpermi_w)
-
-TRANS(vextrins_b, ALL, gen_vv_i, gen_helper_vextrins_b)
-TRANS(vextrins_h, ALL, gen_vv_i, gen_helper_vextrins_h)
-TRANS(vextrins_w, ALL, gen_vv_i, gen_helper_vextrins_w)
-TRANS(vextrins_d, ALL, gen_vv_i, gen_helper_vextrins_d)
+TRANS(vpackev_b, LSX, gen_vvv, gen_helper_vpackev_b)
+TRANS(vpackev_h, LSX, gen_vvv, gen_helper_vpackev_h)
+TRANS(vpackev_w, LSX, gen_vvv, gen_helper_vpackev_w)
+TRANS(vpackev_d, LSX, gen_vvv, gen_helper_vpackev_d)
+TRANS(vpackod_b, LSX, gen_vvv, gen_helper_vpackod_b)
+TRANS(vpackod_h, LSX, gen_vvv, gen_helper_vpackod_h)
+TRANS(vpackod_w, LSX, gen_vvv, gen_helper_vpackod_w)
+TRANS(vpackod_d, LSX, gen_vvv, gen_helper_vpackod_d)
+
+TRANS(vpickev_b, LSX, gen_vvv, gen_helper_vpickev_b)
+TRANS(vpickev_h, LSX, gen_vvv, gen_helper_vpickev_h)
+TRANS(vpickev_w, LSX, gen_vvv, gen_helper_vpickev_w)
+TRANS(vpickev_d, LSX, gen_vvv, gen_helper_vpickev_d)
+TRANS(vpickod_b, LSX, gen_vvv, gen_helper_vpickod_b)
+TRANS(vpickod_h, LSX, gen_vvv, gen_helper_vpickod_h)
+TRANS(vpickod_w, LSX, gen_vvv, gen_helper_vpickod_w)
+TRANS(vpickod_d, LSX, gen_vvv, gen_helper_vpickod_d)
+
+TRANS(vilvl_b, LSX, gen_vvv, gen_helper_vilvl_b)
+TRANS(vilvl_h, LSX, gen_vvv, gen_helper_vilvl_h)
+TRANS(vilvl_w, LSX, gen_vvv, gen_helper_vilvl_w)
+TRANS(vilvl_d, LSX, gen_vvv, gen_helper_vilvl_d)
+TRANS(vilvh_b, LSX, gen_vvv, gen_helper_vilvh_b)
+TRANS(vilvh_h, LSX, gen_vvv, gen_helper_vilvh_h)
+TRANS(vilvh_w, LSX, gen_vvv, gen_helper_vilvh_w)
+TRANS(vilvh_d, LSX, gen_vvv, gen_helper_vilvh_d)
+
+TRANS(vshuf_b, LSX, gen_vvvv, gen_helper_vshuf_b)
+TRANS(vshuf_h, LSX, gen_vvv, gen_helper_vshuf_h)
+TRANS(vshuf_w, LSX, gen_vvv, gen_helper_vshuf_w)
+TRANS(vshuf_d, LSX, gen_vvv, gen_helper_vshuf_d)
+TRANS(vshuf4i_b, LSX, gen_vv_i, gen_helper_vshuf4i_b)
+TRANS(vshuf4i_h, LSX, gen_vv_i, gen_helper_vshuf4i_h)
+TRANS(vshuf4i_w, LSX, gen_vv_i, gen_helper_vshuf4i_w)
+TRANS(vshuf4i_d, LSX, gen_vv_i, gen_helper_vshuf4i_d)
+
+TRANS(vpermi_w, LSX, gen_vv_i, gen_helper_vpermi_w)
+
+TRANS(vextrins_b, LSX, gen_vv_i, gen_helper_vextrins_b)
+TRANS(vextrins_h, LSX, gen_vv_i, gen_helper_vextrins_h)
+TRANS(vextrins_w, LSX, gen_vv_i, gen_helper_vextrins_w)
+TRANS(vextrins_d, LSX, gen_vv_i, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
@@ -4259,6 +4395,10 @@ static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4282,6 +4422,10 @@ static bool trans_vst(DisasContext *ctx, arg_vr_i *a)
     TCGv_i128 val;
     TCGv_i64 ah, al;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     addr = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4305,6 +4449,10 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 rl, rh;
     TCGv_i128 val;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4328,6 +4476,10 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
     TCGv_i64 ah, al;
     TCGv_i128 val;
 
+    if (!avail_LSX(ctx)) {
+        return false;
+    }
+
     CHECK_SXE;
 
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
@@ -4351,6 +4503,10 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_i *a)                \
     TCGv addr;                                                            \
     TCGv_i64 val;                                                         \
                                                                           \
+    if (!avail_LSX(ctx)) {                                                \
+        return false;                                                     \
+    }                                                                     \
+                                                                          \
     CHECK_SXE;                                                            \
                                                                           \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                 \
@@ -4375,6 +4531,10 @@ static bool trans_## NAME (DisasContext *ctx, arg_vr_ii *a)                  \
     TCGv addr;                                                               \
     TCGv_i64 val;                                                            \
                                                                              \
+    if (!avail_LSX(ctx)) {                                                   \
+        return false;                                                        \
+    }                                                                        \
+                                                                             \
     CHECK_SXE;                                                               \
                                                                              \
     addr = gpr_src(ctx, a->rj, EXT_NONE);                                    \
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index faf4ce87f9..db46e9aa0f 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -22,6 +22,8 @@
 #define avail_FP_DP(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
 #define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
+#define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
+
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.39.1


