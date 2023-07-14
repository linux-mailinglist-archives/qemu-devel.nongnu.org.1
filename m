Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90B75358C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERv-0002KW-56; Fri, 14 Jul 2023 04:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERe-0001Xe-Oc
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERW-0004nW-U6
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:34 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx5_FeC7FkSM4EAA--.13570S3;
 Fri, 14 Jul 2023 16:46:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S11; 
 Fri, 14 Jul 2023 16:46:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 09/47] target/loongarch: rename lsx_helper.c to vec_helper.c
Date: Fri, 14 Jul 2023 16:45:37 +0800
Message-Id: <20230714084615.2448038-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S11
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

Use gen_helper_gvec_* series function.
and rename lsx_helper.c to vec_helper.c.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/helper.h                     |  642 ++++----
 target/loongarch/insn_trans/trans_lsx.c.inc   |  731 +++++-----
 .../loongarch/{lsx_helper.c => vec_helper.c}  | 1299 ++++++++---------
 3 files changed, 1329 insertions(+), 1343 deletions(-)
 rename target/loongarch/{lsx_helper.c => vec_helper.c} (71%)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index b9de77d926..3b3b179a2b 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -132,22 +132,22 @@ DEF_HELPER_1(idle, void, env)
 #endif
 
 /* LoongArch LSX  */
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
+DEF_HELPER_FLAGS_4(vhaddw_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhaddw_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vhsubw_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vaddwev_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vaddwev_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -304,22 +304,22 @@ DEF_HELPER_FLAGS_4(vmaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vmaddwod_w_hu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vmaddwod_d_wu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_4(vdiv_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_wu, void, env, i32, i32, i32)
-DEF_HELPER_4(vdiv_du, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_wu, void, env, i32, i32, i32)
-DEF_HELPER_4(vmod_du, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vdiv_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vdiv_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_bu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_wu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vmod_du, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vsat_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vsat_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
@@ -330,161 +330,161 @@ DEF_HELPER_FLAGS_4(vsat_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
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
+DEF_HELPER_FLAGS_3(vexth_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vexth_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_3(vmskltz_b, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_h, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_w, void, env, i32, i32)
-DEF_HELPER_3(vmskltz_d, void, env, i32, i32)
-DEF_HELPER_3(vmskgez_b, void, env, i32, i32)
-DEF_HELPER_3(vmsknz_b, void, env, i32,i32)
+DEF_HELPER_FLAGS_3(vmskltz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskltz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmskgez_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vmsknz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vsllwil_h_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_w_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_d_w, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_q_d, void, env, i32, i32)
-DEF_HELPER_4(vsllwil_hu_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_wu_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_du_wu, void, env, i32, i32, i32)
-DEF_HELPER_3(vextl_qu_du, void, env, i32, i32)
-
-DEF_HELPER_4(vsrlr_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrar_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrln_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_w_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrlni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_d_q, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrlrn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_w_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vsrlrni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_d_q, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vssrln_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrln_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrln_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrln_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrln_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrln_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssran_wu_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vssrlni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlni_du_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrani_du_q, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vssrlrn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrn_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrn_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrn_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrn_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarn_wu_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vssrlrni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrlrni_du_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_bu_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_hu_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_wu_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vssrarni_du_q, void, env, i32, i32, i32)
-
-DEF_HELPER_3(vclo_b, void, env, i32, i32)
-DEF_HELPER_3(vclo_h, void, env, i32, i32)
-DEF_HELPER_3(vclo_w, void, env, i32, i32)
-DEF_HELPER_3(vclo_d, void, env, i32, i32)
-DEF_HELPER_3(vclz_b, void, env, i32, i32)
-DEF_HELPER_3(vclz_h, void, env, i32, i32)
-DEF_HELPER_3(vclz_w, void, env, i32, i32)
-DEF_HELPER_3(vclz_d, void, env, i32, i32)
-
-DEF_HELPER_3(vpcnt_b, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_h, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_w, void, env, i32, i32)
-DEF_HELPER_3(vpcnt_d, void, env, i32, i32)
+DEF_HELPER_FLAGS_4(vsllwil_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_3(vextl_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsllwil_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_3(vextl_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vsrlr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vsrar_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrari_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vsrln_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrln_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrln_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vsrlni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vsrlrn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlrn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlrn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vsrlrni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vssrln_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrln_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrln_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrln_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrln_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrln_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssran_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vssrlni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlni_du_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrani_du_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vssrlrn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrlrn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrlrn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrlrn_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrlrn_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrlrn_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vssrarn_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vssrlrni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrlrni_du_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vssrarni_du_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_3(vclo_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclo_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vclz_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(vpcnt_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vpcnt_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vbitclr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vbitclr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -513,107 +513,107 @@ DEF_HELPER_FLAGS_4(vbitrevi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vfrstp_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstp_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstpi_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstpi_h, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vfadd_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfadd_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_d, void, env, i32, i32, i32)
-
-DEF_HELPER_5(vfmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_d, void, env, i32, i32, i32, i32)
-
-DEF_HELPER_4(vfmax_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmax_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vfmaxa_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmaxa_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_d, void, env, i32, i32, i32)
-
-DEF_HELPER_3(vflogb_s, void, env, i32, i32)
-DEF_HELPER_3(vflogb_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfclass_s, void, env, i32, i32)
-DEF_HELPER_3(vfclass_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfsqrt_d, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_s, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_d, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfcvtl_s_h, void, env, i32, i32)
-DEF_HELPER_3(vfcvth_s_h, void, env, i32, i32)
-DEF_HELPER_3(vfcvtl_d_s, void, env, i32, i32)
-DEF_HELPER_3(vfcvth_d_s, void, env, i32, i32)
-DEF_HELPER_4(vfcvt_h_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfcvt_s_d, void, env, i32, i32, i32)
-
-DEF_HELPER_3(vfrintrne_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrne_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrz_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrz_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrp_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrp_d, void, env, i32, i32)
-DEF_HELPER_3(vfrintrm_s, void, env, i32, i32)
-DEF_HELPER_3(vfrintrm_d, void, env, i32, i32)
-DEF_HELPER_3(vfrint_s, void, env, i32, i32)
-DEF_HELPER_3(vfrint_d, void, env, i32, i32)
-
-DEF_HELPER_3(vftintrne_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrne_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrp_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrp_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrm_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrm_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftint_w_s, void, env, i32, i32)
-DEF_HELPER_3(vftint_l_d, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_wu_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrz_lu_d, void, env, i32, i32)
-DEF_HELPER_3(vftint_wu_s, void, env, i32, i32)
-DEF_HELPER_3(vftint_lu_d, void, env, i32, i32)
-DEF_HELPER_4(vftintrne_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrz_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrp_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftintrm_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vftint_w_d, void, env, i32, i32, i32)
-DEF_HELPER_3(vftintrnel_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrneh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrzl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrzh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrpl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrph_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrml_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintrmh_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftintl_l_s, void, env, i32, i32)
-DEF_HELPER_3(vftinth_l_s, void, env, i32, i32)
-
-DEF_HELPER_3(vffint_s_w, void, env, i32, i32)
-DEF_HELPER_3(vffint_d_l, void, env, i32, i32)
-DEF_HELPER_3(vffint_s_wu, void, env, i32, i32)
-DEF_HELPER_3(vffint_d_lu, void, env, i32, i32)
-DEF_HELPER_3(vffintl_d_w, void, env, i32, i32)
-DEF_HELPER_3(vffinth_d_w, void, env, i32, i32)
-DEF_HELPER_4(vffint_s_l, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vfrstp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vfrstp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vfrstpi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vfrstpi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_5(vfadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmul_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmul_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfdiv_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfdiv_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_6(vfmadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmsub_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_6(vfnmsub_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(vfmax_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmax_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmin_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmin_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_5(vfmaxa_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmaxa_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmina_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfmina_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vflogb_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vflogb_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfclass_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfclass_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfsqrt_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfsqrt_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrecip_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrecip_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrsqrt_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrsqrt_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfcvtl_s_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvth_s_h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvtl_d_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfcvth_d_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfcvt_h_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vfcvt_s_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vfrintrne_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrne_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrz_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrz_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrp_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrp_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrm_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrintrm_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrint_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vfrint_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vftintrne_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrne_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrp_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrp_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrm_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrm_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_w_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_l_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_wu_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrz_lu_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_wu_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftint_lu_d, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrne_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrz_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrp_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftintrm_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vftint_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrnel_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrneh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrzl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrzh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrpl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrph_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrml_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintrmh_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftintl_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vftinth_l_s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+
+DEF_HELPER_FLAGS_4(vffint_s_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_d_l, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_s_wu, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffint_d_lu, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffintl_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_4(vffinth_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
+DEF_HELPER_FLAGS_5(vffint_s_l, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 
 DEF_HELPER_FLAGS_4(vseqi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vseqi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
@@ -654,45 +654,45 @@ DEF_HELPER_3(vsetallnez_h, void, env, i32, i32)
 DEF_HELPER_3(vsetallnez_w, void, env, i32, i32)
 DEF_HELPER_3(vsetallnez_d, void, env, i32, i32)
 
-DEF_HELPER_4(vpackev_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackev_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpackod_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vpickev_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickev_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vpickod_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vilvl_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvl_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vilvh_d, void, env, i32, i32, i32)
-
-DEF_HELPER_5(vshuf_b, void, env, i32, i32, i32, i32)
-DEF_HELPER_4(vshuf_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vpermi_w, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vextrins_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vpackev_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackev_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackev_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackev_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackod_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackod_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackod_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpackod_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vpickev_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickev_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickev_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickev_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickod_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickod_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickod_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vpickod_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(vilvl_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvl_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvh_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvh_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvh_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vilvh_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(vshuf_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vpermi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+
+DEF_HELPER_FLAGS_4(vextrins_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index a1370b90e6..e689e409ce 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4,53 +4,90 @@
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
-static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
-                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
-                                  TCGv_i32, TCGv_i32))
+static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a, int oprsz,
+                     gen_helper_gvec_4 *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 vk = tcg_constant_i32(a->vk);
-    TCGv_i32 va = tcg_constant_i32(a->va);
-
     CHECK_VEC;
-    func(cpu_env, vd, vj, vk, va);
+
+    tcg_gen_gvec_4_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       vec_full_offset(a->va),
+                       oprsz, ctx->vl / 8, oprsz, fn);
     return true;
 }
 
-static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
-                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vvv(DisasContext *ctx, arg_vvv *a, int oprsz,
+                    gen_helper_gvec_3 * fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 vk = tcg_constant_i32(a->vk);
+    CHECK_VEC;
+
+    tcg_gen_gvec_3_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       oprsz, ctx->vl / 8, oprsz, fn);
+    return true;
+}
 
+static bool gen_vv(DisasContext *ctx, arg_vv *a, int oprsz,
+                   gen_helper_gvec_2 * fn)
+{
     CHECK_VEC;
 
-    func(cpu_env, vd, vj, vk);
+    tcg_gen_gvec_2_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       oprsz, ctx->vl / 8, oprsz, fn);
     return true;
 }
 
-static bool gen_vv(DisasContext *ctx, arg_vv *a,
-                   void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32))
+static bool gen_vvvv_f(DisasContext *ctx, arg_vvvv *a, int oprsz,
+                       gen_helper_gvec_4_ptr *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
+    CHECK_VEC;
+
+    tcg_gen_gvec_4_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       vec_full_offset(a->va),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, oprsz, fn);
+    return true;
+}
 
+static bool gen_vvv_f(DisasContext *ctx, arg_vvv *a, int oprsz,
+                      gen_helper_gvec_3_ptr * fn)
+{
     CHECK_VEC;
-    func(cpu_env, vd, vj);
+
+    tcg_gen_gvec_3_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, oprsz, fn);
     return true;
 }
 
-static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
-                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vv_f(DisasContext *ctx, arg_vv *a, int oprsz,
+                     gen_helper_gvec_2_ptr * fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 imm = tcg_constant_i32(a->imm);
+    CHECK_VEC;
 
+    tcg_gen_gvec_2_ptr(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       cpu_env,
+                       oprsz, ctx->vl / 8, oprsz, fn);
+    return true;
+}
+
+static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a, int oprsz,
+                     gen_helper_gvec_2i * fn)
+{
     CHECK_VEC;
-    func(cpu_env, vd, vj, imm);
+
+    tcg_gen_gvec_2i_ool(vec_full_offset(a->vd),
+                        vec_full_offset(a->vj),
+                        tcg_constant_i64(a->imm),
+                        oprsz, ctx->vl / 8, oprsz, fn);
     return true;
 }
 
@@ -195,22 +232,22 @@ TRANS(vssub_hu, gvec_vvv, 16, MO_16, tcg_gen_gvec_ussub)
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
@@ -2714,22 +2751,22 @@ TRANS(vmaddwod_h_bu_b, gvec_vvv, 16, MO_8, do_vmaddwod_u_s)
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
@@ -2832,14 +2869,14 @@ TRANS(vsat_hu, gvec_vv_i, 16, MO_16, do_vsat_u)
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
@@ -2894,12 +2931,12 @@ TRANS(vsigncov_h, gvec_vvv, 16, MO_16, do_vsigncov)
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
 
@@ -3130,138 +3167,138 @@ TRANS(vrotri_h, gvec_vv_i, 16, MO_16, tcg_gen_gvec_rotri)
 TRANS(vrotri_w, gvec_vv_i, 16, MO_32, tcg_gen_gvec_rotri)
 TRANS(vrotri_d, gvec_vv_i, 16, MO_64, tcg_gen_gvec_rotri)
 
-TRANS(vsllwil_h_b, gen_vv_i, gen_helper_vsllwil_h_b)
-TRANS(vsllwil_w_h, gen_vv_i, gen_helper_vsllwil_w_h)
-TRANS(vsllwil_d_w, gen_vv_i, gen_helper_vsllwil_d_w)
-TRANS(vextl_q_d, gen_vv, gen_helper_vextl_q_d)
-TRANS(vsllwil_hu_bu, gen_vv_i, gen_helper_vsllwil_hu_bu)
-TRANS(vsllwil_wu_hu, gen_vv_i, gen_helper_vsllwil_wu_hu)
-TRANS(vsllwil_du_wu, gen_vv_i, gen_helper_vsllwil_du_wu)
-TRANS(vextl_qu_du, gen_vv, gen_helper_vextl_qu_du)
-
-TRANS(vsrlr_b, gen_vvv, gen_helper_vsrlr_b)
-TRANS(vsrlr_h, gen_vvv, gen_helper_vsrlr_h)
-TRANS(vsrlr_w, gen_vvv, gen_helper_vsrlr_w)
-TRANS(vsrlr_d, gen_vvv, gen_helper_vsrlr_d)
-TRANS(vsrlri_b, gen_vv_i, gen_helper_vsrlri_b)
-TRANS(vsrlri_h, gen_vv_i, gen_helper_vsrlri_h)
-TRANS(vsrlri_w, gen_vv_i, gen_helper_vsrlri_w)
-TRANS(vsrlri_d, gen_vv_i, gen_helper_vsrlri_d)
-
-TRANS(vsrar_b, gen_vvv, gen_helper_vsrar_b)
-TRANS(vsrar_h, gen_vvv, gen_helper_vsrar_h)
-TRANS(vsrar_w, gen_vvv, gen_helper_vsrar_w)
-TRANS(vsrar_d, gen_vvv, gen_helper_vsrar_d)
-TRANS(vsrari_b, gen_vv_i, gen_helper_vsrari_b)
-TRANS(vsrari_h, gen_vv_i, gen_helper_vsrari_h)
-TRANS(vsrari_w, gen_vv_i, gen_helper_vsrari_w)
-TRANS(vsrari_d, gen_vv_i, gen_helper_vsrari_d)
-
-TRANS(vsrln_b_h, gen_vvv, gen_helper_vsrln_b_h)
-TRANS(vsrln_h_w, gen_vvv, gen_helper_vsrln_h_w)
-TRANS(vsrln_w_d, gen_vvv, gen_helper_vsrln_w_d)
-TRANS(vsran_b_h, gen_vvv, gen_helper_vsran_b_h)
-TRANS(vsran_h_w, gen_vvv, gen_helper_vsran_h_w)
-TRANS(vsran_w_d, gen_vvv, gen_helper_vsran_w_d)
-
-TRANS(vsrlni_b_h, gen_vv_i, gen_helper_vsrlni_b_h)
-TRANS(vsrlni_h_w, gen_vv_i, gen_helper_vsrlni_h_w)
-TRANS(vsrlni_w_d, gen_vv_i, gen_helper_vsrlni_w_d)
-TRANS(vsrlni_d_q, gen_vv_i, gen_helper_vsrlni_d_q)
-TRANS(vsrani_b_h, gen_vv_i, gen_helper_vsrani_b_h)
-TRANS(vsrani_h_w, gen_vv_i, gen_helper_vsrani_h_w)
-TRANS(vsrani_w_d, gen_vv_i, gen_helper_vsrani_w_d)
-TRANS(vsrani_d_q, gen_vv_i, gen_helper_vsrani_d_q)
-
-TRANS(vsrlrn_b_h, gen_vvv, gen_helper_vsrlrn_b_h)
-TRANS(vsrlrn_h_w, gen_vvv, gen_helper_vsrlrn_h_w)
-TRANS(vsrlrn_w_d, gen_vvv, gen_helper_vsrlrn_w_d)
-TRANS(vsrarn_b_h, gen_vvv, gen_helper_vsrarn_b_h)
-TRANS(vsrarn_h_w, gen_vvv, gen_helper_vsrarn_h_w)
-TRANS(vsrarn_w_d, gen_vvv, gen_helper_vsrarn_w_d)
-
-TRANS(vsrlrni_b_h, gen_vv_i, gen_helper_vsrlrni_b_h)
-TRANS(vsrlrni_h_w, gen_vv_i, gen_helper_vsrlrni_h_w)
-TRANS(vsrlrni_w_d, gen_vv_i, gen_helper_vsrlrni_w_d)
-TRANS(vsrlrni_d_q, gen_vv_i, gen_helper_vsrlrni_d_q)
-TRANS(vsrarni_b_h, gen_vv_i, gen_helper_vsrarni_b_h)
-TRANS(vsrarni_h_w, gen_vv_i, gen_helper_vsrarni_h_w)
-TRANS(vsrarni_w_d, gen_vv_i, gen_helper_vsrarni_w_d)
-TRANS(vsrarni_d_q, gen_vv_i, gen_helper_vsrarni_d_q)
-
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
-
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
-
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
-
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
-
-TRANS(vclo_b, gen_vv, gen_helper_vclo_b)
-TRANS(vclo_h, gen_vv, gen_helper_vclo_h)
-TRANS(vclo_w, gen_vv, gen_helper_vclo_w)
-TRANS(vclo_d, gen_vv, gen_helper_vclo_d)
-TRANS(vclz_b, gen_vv, gen_helper_vclz_b)
-TRANS(vclz_h, gen_vv, gen_helper_vclz_h)
-TRANS(vclz_w, gen_vv, gen_helper_vclz_w)
-TRANS(vclz_d, gen_vv, gen_helper_vclz_d)
-
-TRANS(vpcnt_b, gen_vv, gen_helper_vpcnt_b)
-TRANS(vpcnt_h, gen_vv, gen_helper_vpcnt_h)
-TRANS(vpcnt_w, gen_vv, gen_helper_vpcnt_w)
-TRANS(vpcnt_d, gen_vv, gen_helper_vpcnt_d)
+TRANS(vsllwil_h_b, gen_vv_i, 16, gen_helper_vsllwil_h_b)
+TRANS(vsllwil_w_h, gen_vv_i, 16, gen_helper_vsllwil_w_h)
+TRANS(vsllwil_d_w, gen_vv_i, 16, gen_helper_vsllwil_d_w)
+TRANS(vextl_q_d, gen_vv, 16, gen_helper_vextl_q_d)
+TRANS(vsllwil_hu_bu, gen_vv_i, 16, gen_helper_vsllwil_hu_bu)
+TRANS(vsllwil_wu_hu, gen_vv_i, 16, gen_helper_vsllwil_wu_hu)
+TRANS(vsllwil_du_wu, gen_vv_i, 16, gen_helper_vsllwil_du_wu)
+TRANS(vextl_qu_du, gen_vv, 16, gen_helper_vextl_qu_du)
+
+TRANS(vsrlr_b, gen_vvv, 16, gen_helper_vsrlr_b)
+TRANS(vsrlr_h, gen_vvv, 16, gen_helper_vsrlr_h)
+TRANS(vsrlr_w, gen_vvv, 16, gen_helper_vsrlr_w)
+TRANS(vsrlr_d, gen_vvv, 16, gen_helper_vsrlr_d)
+TRANS(vsrlri_b, gen_vv_i, 16, gen_helper_vsrlri_b)
+TRANS(vsrlri_h, gen_vv_i, 16, gen_helper_vsrlri_h)
+TRANS(vsrlri_w, gen_vv_i, 16, gen_helper_vsrlri_w)
+TRANS(vsrlri_d, gen_vv_i, 16, gen_helper_vsrlri_d)
+
+TRANS(vsrar_b, gen_vvv, 16, gen_helper_vsrar_b)
+TRANS(vsrar_h, gen_vvv, 16, gen_helper_vsrar_h)
+TRANS(vsrar_w, gen_vvv, 16, gen_helper_vsrar_w)
+TRANS(vsrar_d, gen_vvv, 16, gen_helper_vsrar_d)
+TRANS(vsrari_b, gen_vv_i, 16, gen_helper_vsrari_b)
+TRANS(vsrari_h, gen_vv_i, 16, gen_helper_vsrari_h)
+TRANS(vsrari_w, gen_vv_i, 16, gen_helper_vsrari_w)
+TRANS(vsrari_d, gen_vv_i, 16, gen_helper_vsrari_d)
+
+TRANS(vsrln_b_h, gen_vvv, 16, gen_helper_vsrln_b_h)
+TRANS(vsrln_h_w, gen_vvv, 16, gen_helper_vsrln_h_w)
+TRANS(vsrln_w_d, gen_vvv, 16, gen_helper_vsrln_w_d)
+TRANS(vsran_b_h, gen_vvv, 16, gen_helper_vsran_b_h)
+TRANS(vsran_h_w, gen_vvv, 16, gen_helper_vsran_h_w)
+TRANS(vsran_w_d, gen_vvv, 16, gen_helper_vsran_w_d)
+
+TRANS(vsrlni_b_h, gen_vv_i, 16, gen_helper_vsrlni_b_h)
+TRANS(vsrlni_h_w, gen_vv_i, 16, gen_helper_vsrlni_h_w)
+TRANS(vsrlni_w_d, gen_vv_i, 16, gen_helper_vsrlni_w_d)
+TRANS(vsrlni_d_q, gen_vv_i, 16, gen_helper_vsrlni_d_q)
+TRANS(vsrani_b_h, gen_vv_i, 16, gen_helper_vsrani_b_h)
+TRANS(vsrani_h_w, gen_vv_i, 16, gen_helper_vsrani_h_w)
+TRANS(vsrani_w_d, gen_vv_i, 16, gen_helper_vsrani_w_d)
+TRANS(vsrani_d_q, gen_vv_i, 16, gen_helper_vsrani_d_q)
+
+TRANS(vsrlrn_b_h, gen_vvv, 16, gen_helper_vsrlrn_b_h)
+TRANS(vsrlrn_h_w, gen_vvv, 16, gen_helper_vsrlrn_h_w)
+TRANS(vsrlrn_w_d, gen_vvv, 16, gen_helper_vsrlrn_w_d)
+TRANS(vsrarn_b_h, gen_vvv, 16, gen_helper_vsrarn_b_h)
+TRANS(vsrarn_h_w, gen_vvv, 16, gen_helper_vsrarn_h_w)
+TRANS(vsrarn_w_d, gen_vvv, 16, gen_helper_vsrarn_w_d)
+
+TRANS(vsrlrni_b_h, gen_vv_i, 16, gen_helper_vsrlrni_b_h)
+TRANS(vsrlrni_h_w, gen_vv_i, 16, gen_helper_vsrlrni_h_w)
+TRANS(vsrlrni_w_d, gen_vv_i, 16, gen_helper_vsrlrni_w_d)
+TRANS(vsrlrni_d_q, gen_vv_i, 16, gen_helper_vsrlrni_d_q)
+TRANS(vsrarni_b_h, gen_vv_i, 16, gen_helper_vsrarni_b_h)
+TRANS(vsrarni_h_w, gen_vv_i, 16, gen_helper_vsrarni_h_w)
+TRANS(vsrarni_w_d, gen_vv_i, 16, gen_helper_vsrarni_w_d)
+TRANS(vsrarni_d_q, gen_vv_i, 16, gen_helper_vsrarni_d_q)
+
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
+
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
+
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
+
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
+
+TRANS(vclo_b, gen_vv, 16, gen_helper_vclo_b)
+TRANS(vclo_h, gen_vv, 16, gen_helper_vclo_h)
+TRANS(vclo_w, gen_vv, 16, gen_helper_vclo_w)
+TRANS(vclo_d, gen_vv, 16, gen_helper_vclo_d)
+TRANS(vclz_b, gen_vv, 16, gen_helper_vclz_b)
+TRANS(vclz_h, gen_vv, 16, gen_helper_vclz_h)
+TRANS(vclz_w, gen_vv, 16, gen_helper_vclz_w)
+TRANS(vclz_d, gen_vv, 16, gen_helper_vclz_d)
+
+TRANS(vpcnt_b, gen_vv, 16, gen_helper_vpcnt_b)
+TRANS(vpcnt_h, gen_vv, 16, gen_helper_vpcnt_h)
+TRANS(vpcnt_w, gen_vv, 16, gen_helper_vpcnt_w)
+TRANS(vpcnt_d, gen_vv, 16, gen_helper_vpcnt_d)
 
 static void do_vbit(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b,
                     void (*func)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
@@ -3568,107 +3605,107 @@ TRANS(vbitrevi_h, gvec_vv_i, 16, MO_16, do_vbitrevi)
 TRANS(vbitrevi_w, gvec_vv_i, 16, MO_32, do_vbitrevi)
 TRANS(vbitrevi_d, gvec_vv_i, 16, MO_64, do_vbitrevi)
 
-TRANS(vfrstp_b, gen_vvv, gen_helper_vfrstp_b)
-TRANS(vfrstp_h, gen_vvv, gen_helper_vfrstp_h)
-TRANS(vfrstpi_b, gen_vv_i, gen_helper_vfrstpi_b)
-TRANS(vfrstpi_h, gen_vv_i, gen_helper_vfrstpi_h)
-
-TRANS(vfadd_s, gen_vvv, gen_helper_vfadd_s)
-TRANS(vfadd_d, gen_vvv, gen_helper_vfadd_d)
-TRANS(vfsub_s, gen_vvv, gen_helper_vfsub_s)
-TRANS(vfsub_d, gen_vvv, gen_helper_vfsub_d)
-TRANS(vfmul_s, gen_vvv, gen_helper_vfmul_s)
-TRANS(vfmul_d, gen_vvv, gen_helper_vfmul_d)
-TRANS(vfdiv_s, gen_vvv, gen_helper_vfdiv_s)
-TRANS(vfdiv_d, gen_vvv, gen_helper_vfdiv_d)
-
-TRANS(vfmadd_s, gen_vvvv, gen_helper_vfmadd_s)
-TRANS(vfmadd_d, gen_vvvv, gen_helper_vfmadd_d)
-TRANS(vfmsub_s, gen_vvvv, gen_helper_vfmsub_s)
-TRANS(vfmsub_d, gen_vvvv, gen_helper_vfmsub_d)
-TRANS(vfnmadd_s, gen_vvvv, gen_helper_vfnmadd_s)
-TRANS(vfnmadd_d, gen_vvvv, gen_helper_vfnmadd_d)
-TRANS(vfnmsub_s, gen_vvvv, gen_helper_vfnmsub_s)
-TRANS(vfnmsub_d, gen_vvvv, gen_helper_vfnmsub_d)
-
-TRANS(vfmax_s, gen_vvv, gen_helper_vfmax_s)
-TRANS(vfmax_d, gen_vvv, gen_helper_vfmax_d)
-TRANS(vfmin_s, gen_vvv, gen_helper_vfmin_s)
-TRANS(vfmin_d, gen_vvv, gen_helper_vfmin_d)
-
-TRANS(vfmaxa_s, gen_vvv, gen_helper_vfmaxa_s)
-TRANS(vfmaxa_d, gen_vvv, gen_helper_vfmaxa_d)
-TRANS(vfmina_s, gen_vvv, gen_helper_vfmina_s)
-TRANS(vfmina_d, gen_vvv, gen_helper_vfmina_d)
-
-TRANS(vflogb_s, gen_vv, gen_helper_vflogb_s)
-TRANS(vflogb_d, gen_vv, gen_helper_vflogb_d)
-
-TRANS(vfclass_s, gen_vv, gen_helper_vfclass_s)
-TRANS(vfclass_d, gen_vv, gen_helper_vfclass_d)
-
-TRANS(vfsqrt_s, gen_vv, gen_helper_vfsqrt_s)
-TRANS(vfsqrt_d, gen_vv, gen_helper_vfsqrt_d)
-TRANS(vfrecip_s, gen_vv, gen_helper_vfrecip_s)
-TRANS(vfrecip_d, gen_vv, gen_helper_vfrecip_d)
-TRANS(vfrsqrt_s, gen_vv, gen_helper_vfrsqrt_s)
-TRANS(vfrsqrt_d, gen_vv, gen_helper_vfrsqrt_d)
-
-TRANS(vfcvtl_s_h, gen_vv, gen_helper_vfcvtl_s_h)
-TRANS(vfcvth_s_h, gen_vv, gen_helper_vfcvth_s_h)
-TRANS(vfcvtl_d_s, gen_vv, gen_helper_vfcvtl_d_s)
-TRANS(vfcvth_d_s, gen_vv, gen_helper_vfcvth_d_s)
-TRANS(vfcvt_h_s, gen_vvv, gen_helper_vfcvt_h_s)
-TRANS(vfcvt_s_d, gen_vvv, gen_helper_vfcvt_s_d)
-
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
-TRANS(vftintrne_w_d, gen_vvv, gen_helper_vftintrne_w_d)
-TRANS(vftintrz_w_d, gen_vvv, gen_helper_vftintrz_w_d)
-TRANS(vftintrp_w_d, gen_vvv, gen_helper_vftintrp_w_d)
-TRANS(vftintrm_w_d, gen_vvv, gen_helper_vftintrm_w_d)
-TRANS(vftint_w_d, gen_vvv, gen_helper_vftint_w_d)
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
-TRANS(vffint_s_l, gen_vvv, gen_helper_vffint_s_l)
+TRANS(vfrstp_b, gen_vvv, 16, gen_helper_vfrstp_b)
+TRANS(vfrstp_h, gen_vvv, 16, gen_helper_vfrstp_h)
+TRANS(vfrstpi_b, gen_vv_i, 16, gen_helper_vfrstpi_b)
+TRANS(vfrstpi_h, gen_vv_i, 16, gen_helper_vfrstpi_h)
+
+TRANS(vfadd_s, gen_vvv_f, 16, gen_helper_vfadd_s)
+TRANS(vfadd_d, gen_vvv_f, 16, gen_helper_vfadd_d)
+TRANS(vfsub_s, gen_vvv_f, 16, gen_helper_vfsub_s)
+TRANS(vfsub_d, gen_vvv_f, 16, gen_helper_vfsub_d)
+TRANS(vfmul_s, gen_vvv_f, 16, gen_helper_vfmul_s)
+TRANS(vfmul_d, gen_vvv_f, 16, gen_helper_vfmul_d)
+TRANS(vfdiv_s, gen_vvv_f, 16, gen_helper_vfdiv_s)
+TRANS(vfdiv_d, gen_vvv_f, 16, gen_helper_vfdiv_d)
+
+TRANS(vfmadd_s, gen_vvvv_f, 16, gen_helper_vfmadd_s)
+TRANS(vfmadd_d, gen_vvvv_f, 16, gen_helper_vfmadd_d)
+TRANS(vfmsub_s, gen_vvvv_f, 16, gen_helper_vfmsub_s)
+TRANS(vfmsub_d, gen_vvvv_f, 16, gen_helper_vfmsub_d)
+TRANS(vfnmadd_s, gen_vvvv_f, 16, gen_helper_vfnmadd_s)
+TRANS(vfnmadd_d, gen_vvvv_f, 16, gen_helper_vfnmadd_d)
+TRANS(vfnmsub_s, gen_vvvv_f, 16, gen_helper_vfnmsub_s)
+TRANS(vfnmsub_d, gen_vvvv_f, 16, gen_helper_vfnmsub_d)
+
+TRANS(vfmax_s, gen_vvv_f, 16, gen_helper_vfmax_s)
+TRANS(vfmax_d, gen_vvv_f, 16, gen_helper_vfmax_d)
+TRANS(vfmin_s, gen_vvv_f, 16, gen_helper_vfmin_s)
+TRANS(vfmin_d, gen_vvv_f, 16, gen_helper_vfmin_d)
+
+TRANS(vfmaxa_s, gen_vvv_f, 16, gen_helper_vfmaxa_s)
+TRANS(vfmaxa_d, gen_vvv_f, 16, gen_helper_vfmaxa_d)
+TRANS(vfmina_s, gen_vvv_f, 16, gen_helper_vfmina_s)
+TRANS(vfmina_d, gen_vvv_f, 16, gen_helper_vfmina_d)
+
+TRANS(vflogb_s, gen_vv_f, 16, gen_helper_vflogb_s)
+TRANS(vflogb_d, gen_vv_f, 16, gen_helper_vflogb_d)
+
+TRANS(vfclass_s, gen_vv_f, 16, gen_helper_vfclass_s)
+TRANS(vfclass_d, gen_vv_f, 16, gen_helper_vfclass_d)
+
+TRANS(vfsqrt_s, gen_vv_f, 16, gen_helper_vfsqrt_s)
+TRANS(vfsqrt_d, gen_vv_f, 16, gen_helper_vfsqrt_d)
+TRANS(vfrecip_s, gen_vv_f, 16, gen_helper_vfrecip_s)
+TRANS(vfrecip_d, gen_vv_f, 16, gen_helper_vfrecip_d)
+TRANS(vfrsqrt_s, gen_vv_f, 16, gen_helper_vfrsqrt_s)
+TRANS(vfrsqrt_d, gen_vv_f, 16, gen_helper_vfrsqrt_d)
+
+TRANS(vfcvtl_s_h, gen_vv_f, 16, gen_helper_vfcvtl_s_h)
+TRANS(vfcvth_s_h, gen_vv_f, 16, gen_helper_vfcvth_s_h)
+TRANS(vfcvtl_d_s, gen_vv_f, 16, gen_helper_vfcvtl_d_s)
+TRANS(vfcvth_d_s, gen_vv_f, 16, gen_helper_vfcvth_d_s)
+TRANS(vfcvt_h_s, gen_vvv_f, 16, gen_helper_vfcvt_h_s)
+TRANS(vfcvt_s_d, gen_vvv_f, 16, gen_helper_vfcvt_s_d)
+
+TRANS(vfrintrne_s, gen_vv_f, 16, gen_helper_vfrintrne_s)
+TRANS(vfrintrne_d, gen_vv_f, 16, gen_helper_vfrintrne_d)
+TRANS(vfrintrz_s, gen_vv_f, 16, gen_helper_vfrintrz_s)
+TRANS(vfrintrz_d, gen_vv_f, 16, gen_helper_vfrintrz_d)
+TRANS(vfrintrp_s, gen_vv_f, 16, gen_helper_vfrintrp_s)
+TRANS(vfrintrp_d, gen_vv_f, 16, gen_helper_vfrintrp_d)
+TRANS(vfrintrm_s, gen_vv_f, 16, gen_helper_vfrintrm_s)
+TRANS(vfrintrm_d, gen_vv_f, 16, gen_helper_vfrintrm_d)
+TRANS(vfrint_s, gen_vv_f, 16, gen_helper_vfrint_s)
+TRANS(vfrint_d, gen_vv_f, 16, gen_helper_vfrint_d)
+
+TRANS(vftintrne_w_s, gen_vv_f, 16, gen_helper_vftintrne_w_s)
+TRANS(vftintrne_l_d, gen_vv_f, 16, gen_helper_vftintrne_l_d)
+TRANS(vftintrz_w_s, gen_vv_f, 16, gen_helper_vftintrz_w_s)
+TRANS(vftintrz_l_d, gen_vv_f, 16, gen_helper_vftintrz_l_d)
+TRANS(vftintrp_w_s, gen_vv_f, 16, gen_helper_vftintrp_w_s)
+TRANS(vftintrp_l_d, gen_vv_f, 16, gen_helper_vftintrp_l_d)
+TRANS(vftintrm_w_s, gen_vv_f, 16, gen_helper_vftintrm_w_s)
+TRANS(vftintrm_l_d, gen_vv_f, 16, gen_helper_vftintrm_l_d)
+TRANS(vftint_w_s, gen_vv_f, 16, gen_helper_vftint_w_s)
+TRANS(vftint_l_d, gen_vv_f, 16, gen_helper_vftint_l_d)
+TRANS(vftintrz_wu_s, gen_vv_f, 16, gen_helper_vftintrz_wu_s)
+TRANS(vftintrz_lu_d, gen_vv_f, 16, gen_helper_vftintrz_lu_d)
+TRANS(vftint_wu_s, gen_vv_f, 16, gen_helper_vftint_wu_s)
+TRANS(vftint_lu_d, gen_vv_f, 16, gen_helper_vftint_lu_d)
+TRANS(vftintrne_w_d, gen_vvv_f, 16, gen_helper_vftintrne_w_d)
+TRANS(vftintrz_w_d, gen_vvv_f, 16, gen_helper_vftintrz_w_d)
+TRANS(vftintrp_w_d, gen_vvv_f, 16, gen_helper_vftintrp_w_d)
+TRANS(vftintrm_w_d, gen_vvv_f, 16, gen_helper_vftintrm_w_d)
+TRANS(vftint_w_d, gen_vvv_f, 16, gen_helper_vftint_w_d)
+TRANS(vftintrnel_l_s, gen_vv_f, 16, gen_helper_vftintrnel_l_s)
+TRANS(vftintrneh_l_s, gen_vv_f, 16, gen_helper_vftintrneh_l_s)
+TRANS(vftintrzl_l_s, gen_vv_f, 16, gen_helper_vftintrzl_l_s)
+TRANS(vftintrzh_l_s, gen_vv_f, 16, gen_helper_vftintrzh_l_s)
+TRANS(vftintrpl_l_s, gen_vv_f, 16, gen_helper_vftintrpl_l_s)
+TRANS(vftintrph_l_s, gen_vv_f, 16, gen_helper_vftintrph_l_s)
+TRANS(vftintrml_l_s, gen_vv_f, 16, gen_helper_vftintrml_l_s)
+TRANS(vftintrmh_l_s, gen_vv_f, 16, gen_helper_vftintrmh_l_s)
+TRANS(vftintl_l_s, gen_vv_f, 16, gen_helper_vftintl_l_s)
+TRANS(vftinth_l_s, gen_vv_f, 16, gen_helper_vftinth_l_s)
+
+TRANS(vffint_s_w, gen_vv_f, 16, gen_helper_vffint_s_w)
+TRANS(vffint_d_l, gen_vv_f, 16, gen_helper_vffint_d_l)
+TRANS(vffint_s_wu, gen_vv_f, 16, gen_helper_vffint_s_wu)
+TRANS(vffint_d_lu, gen_vv_f, 16, gen_helper_vffint_d_lu)
+TRANS(vffintl_d_w, gen_vv_f, 16, gen_helper_vffintl_d_w)
+TRANS(vffinth_d_w, gen_vv_f, 16, gen_helper_vffinth_d_w)
+TRANS(vffint_s_l, gen_vvv_f, 16, gen_helper_vffint_s_l)
 
 static bool do_cmp(DisasContext *ctx, arg_vvv *a, MemOp mop, TCGCond cond)
 {
@@ -4200,48 +4237,48 @@ static bool trans_vbsrl_v(DisasContext *ctx, arg_vv_i *a)
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
-
-TRANS(vshuf_b, gen_vvvv, gen_helper_vshuf_b)
-TRANS(vshuf_h, gen_vvv, gen_helper_vshuf_h)
-TRANS(vshuf_w, gen_vvv, gen_helper_vshuf_w)
-TRANS(vshuf_d, gen_vvv, gen_helper_vshuf_d)
-TRANS(vshuf4i_b, gen_vv_i, gen_helper_vshuf4i_b)
-TRANS(vshuf4i_h, gen_vv_i, gen_helper_vshuf4i_h)
-TRANS(vshuf4i_w, gen_vv_i, gen_helper_vshuf4i_w)
-TRANS(vshuf4i_d, gen_vv_i, gen_helper_vshuf4i_d)
-
-TRANS(vpermi_w, gen_vv_i, gen_helper_vpermi_w)
-
-TRANS(vextrins_b, gen_vv_i, gen_helper_vextrins_b)
-TRANS(vextrins_h, gen_vv_i, gen_helper_vextrins_h)
-TRANS(vextrins_w, gen_vv_i, gen_helper_vextrins_w)
-TRANS(vextrins_d, gen_vv_i, gen_helper_vextrins_d)
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
+
+TRANS(vshuf_b, gen_vvvv, 16, gen_helper_vshuf_b)
+TRANS(vshuf_h, gen_vvv, 16, gen_helper_vshuf_h)
+TRANS(vshuf_w, gen_vvv, 16, gen_helper_vshuf_w)
+TRANS(vshuf_d, gen_vvv, 16, gen_helper_vshuf_d)
+TRANS(vshuf4i_b, gen_vv_i, 16, gen_helper_vshuf4i_b)
+TRANS(vshuf4i_h, gen_vv_i, 16, gen_helper_vshuf4i_h)
+TRANS(vshuf4i_w, gen_vv_i, 16, gen_helper_vshuf4i_w)
+TRANS(vshuf4i_d, gen_vv_i, 16, gen_helper_vshuf4i_d)
+
+TRANS(vpermi_w, gen_vv_i, 16, gen_helper_vpermi_w)
+
+TRANS(vextrins_b, gen_vv_i, 16, gen_helper_vextrins_b)
+TRANS(vextrins_h, gen_vv_i, 16, gen_helper_vextrins_h)
+TRANS(vextrins_w, gen_vv_i, 16, gen_helper_vextrins_w)
+TRANS(vextrins_d, gen_vv_i, 16, gen_helper_vextrins_d)
 
 static bool trans_vld(DisasContext *ctx, arg_vr_i *a)
 {
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/vec_helper.c
similarity index 71%
rename from target/loongarch/lsx_helper.c
rename to target/loongarch/vec_helper.c
index b231a2798b..7c6efe77eb 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -18,13 +18,12 @@
 #define DO_SUB(a, b)  (a - b)
 
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
-void HELPER(NAME)(CPULoongArchState *env,                            \
-                  uint32_t vd, uint32_t vj, uint32_t vk)             \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
 {                                                                    \
     int i;                                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                                 \
-    VReg *Vj = &(env->fpr[vj].vreg);                                 \
-    VReg *Vk = &(env->fpr[vk].vreg);                                 \
+    VReg *Vd = (VReg *)vd;                                           \
+    VReg *Vj = (VReg *)vj;                                           \
+    VReg *Vk = (VReg *)vk;                                           \
     typedef __typeof(Vd->E1(0)) TD;                                  \
                                                                      \
     for (i = 0; i < LSX_LEN/BIT; i++) {                              \
@@ -36,12 +35,11 @@ DO_ODD_EVEN(vhaddw_h_b, 16, H, B, DO_ADD)
 DO_ODD_EVEN(vhaddw_w_h, 32, W, H, DO_ADD)
 DO_ODD_EVEN(vhaddw_d_w, 64, D, W, DO_ADD)
 
-void HELPER(vhaddw_q_d)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vhaddw_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_add(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
 }
@@ -50,12 +48,11 @@ DO_ODD_EVEN(vhsubw_h_b, 16, H, B, DO_SUB)
 DO_ODD_EVEN(vhsubw_w_h, 32, W, H, DO_SUB)
 DO_ODD_EVEN(vhsubw_d_w, 64, D, W, DO_SUB)
 
-void HELPER(vhsubw_q_d)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vhsubw_q_d)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_sub(int128_makes64(Vj->D(1)), int128_makes64(Vk->D(0)));
 }
@@ -64,12 +61,11 @@ DO_ODD_EVEN(vhaddw_hu_bu, 16, UH, UB, DO_ADD)
 DO_ODD_EVEN(vhaddw_wu_hu, 32, UW, UH, DO_ADD)
 DO_ODD_EVEN(vhaddw_du_wu, 64, UD, UW, DO_ADD)
 
-void HELPER(vhaddw_qu_du)(CPULoongArchState *env,
-                          uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vhaddw_qu_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_add(int128_make64((uint64_t)Vj->D(1)),
                           int128_make64((uint64_t)Vk->D(0)));
@@ -79,12 +75,11 @@ DO_ODD_EVEN(vhsubw_hu_bu, 16, UH, UB, DO_SUB)
 DO_ODD_EVEN(vhsubw_wu_hu, 32, UW, UH, DO_SUB)
 DO_ODD_EVEN(vhsubw_du_wu, 64, UD, UW, DO_SUB)
 
-void HELPER(vhsubw_qu_du)(CPULoongArchState *env,
-                          uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vhsubw_qu_du)(void *vd, void *vj, void *vk, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     Vd->Q(0) = int128_sub(int128_make64((uint64_t)Vj->D(1)),
                           int128_make64((uint64_t)Vk->D(0)));
@@ -539,7 +534,7 @@ VMADDWEV_U_S(vmaddwev_w_hu_h, 32, W, UW, H, UH, DO_MUL)
 VMADDWEV_U_S(vmaddwev_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 
 #define VMADDWOD_U_S(NAME, BIT, ES1, EU1, ES2, EU2, DO_OP)  \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
 {                                                           \
     int i;                                                  \
     VReg *Vd = (VReg *)vd;                                  \
@@ -549,8 +544,8 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
     typedef __typeof(Vd->EU1(0)) TU1;                       \
                                                             \
     for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i + 1),         \
-                            (TS1)Vk->ES2(2 * i + 1));        \
+        Vd->ES1(i) += DO_OP((TU1)Vj->EU2(2 * i + 1),        \
+                            (TS1)Vk->ES2(2 * i + 1));       \
     }                                                       \
 }
 
@@ -565,17 +560,17 @@ VMADDWOD_U_S(vmaddwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
 #define DO_REM(N, M)  (unlikely(M == 0) ? 0 :\
         unlikely((N == -N) && (M == (__typeof(N))(-1))) ? 0 : N % M)
 
-#define VDIV(NAME, BIT, E, DO_OP)                           \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t vk)    \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-    VReg *Vk = &(env->fpr[vk].vreg);                        \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));               \
-    }                                                       \
+#define VDIV(NAME, BIT, E, DO_OP)                              \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));                  \
+    }                                                          \
 }
 
 VDIV(vdiv_b, 8, B, DO_DIV)
@@ -632,30 +627,30 @@ VSAT_U(vsat_hu, 16, UH)
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
+#define VEXTH(NAME, BIT, E1, E2)                     \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++) {              \
+        Vd->E1(i) = Vj->E2(i + LSX_LEN/BIT);         \
+    }                                                \
 }
 
-void HELPER(vexth_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_q_d)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_makes64(Vj->D(1));
 }
 
-void HELPER(vexth_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vexth_qu_du)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_make64((uint64_t)Vj->D(1));
 }
@@ -684,11 +679,11 @@ static uint64_t do_vmskltz_b(int64_t val)
     return c >> 56;
 }
 
-void HELPER(vmskltz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_b)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_b(Vj->D(0));
     temp |= (do_vmskltz_b(Vj->D(1)) << 8);
@@ -705,11 +700,11 @@ static uint64_t do_vmskltz_h(int64_t val)
     return c >> 60;
 }
 
-void HELPER(vmskltz_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_h)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_h(Vj->D(0));
     temp |= (do_vmskltz_h(Vj->D(1)) << 4);
@@ -725,11 +720,11 @@ static uint64_t do_vmskltz_w(int64_t val)
     return c >> 62;
 }
 
-void HELPER(vmskltz_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_w)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_w(Vj->D(0));
     temp |= (do_vmskltz_w(Vj->D(1)) << 2);
@@ -741,11 +736,11 @@ static uint64_t do_vmskltz_d(int64_t val)
 {
     return (uint64_t)val >> 63;
 }
-void HELPER(vmskltz_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskltz_d)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskltz_d(Vj->D(0));
     temp |= (do_vmskltz_d(Vj->D(1)) << 1);
@@ -753,11 +748,11 @@ void HELPER(vmskltz_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     Vd->D(1) = 0;
 }
 
-void HELPER(vmskgez_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmskgez_b)(void *vd, void *vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp =  do_vmskltz_b(Vj->D(0));
     temp |= (do_vmskltz_b(Vj->D(1)) << 8);
@@ -775,11 +770,11 @@ static uint64_t do_vmskez_b(uint64_t a)
     return c >> 56;
 }
 
-void HELPER(vmsknz_b)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vmsknz_b)(void vd, void vj, uint32_t desc)
 {
     uint16_t temp = 0;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp = do_vmskez_b(Vj->D(0));
     temp |= (do_vmskez_b(Vj->D(1)) << 8);
@@ -798,36 +793,35 @@ void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t v)
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
+#define VSLLWIL(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(temp.E1(0)) TD;                               \
+                                                                   \
+    temp.D(0) = 0;                                                 \
+    temp.D(1) = 0;                                                 \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+        temp.E1(i) = (TD)Vj->E2(i) << (imm % BIT);                 \
+    }                                                              \
+    *Vd = temp;                                                    \
 }
 
-void HELPER(vextl_q_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vextl_q_d)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_makes64(Vj->D(0));
 }
 
-void HELPER(vextl_qu_du)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vextl_qu_du)(void *vd, void *vj, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     Vd->Q(0) = int128_make64(Vj->D(0));
 }
@@ -855,13 +849,12 @@ do_vsrlr(W, uint32_t)
 do_vsrlr(D, uint64_t)
 
 #define VSRLR(NAME, BIT, T, E)                                  \
-void HELPER(NAME)(CPULoongArchState *env,                       \
-                  uint32_t vd, uint32_t vj, uint32_t vk)        \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)  \
 {                                                               \
     int i;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                            \
-    VReg *Vj = &(env->fpr[vj].vreg);                            \
-    VReg *Vk = &(env->fpr[vk].vreg);                            \
+    VReg *Vd = (VReg *)vd;                                      \
+    VReg *Vj = (VReg *)vj;                                      \
+    VReg *Vk = (VReg *)vk;                                      \
                                                                 \
     for (i = 0; i < LSX_LEN/BIT; i++) {                         \
         Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
@@ -873,17 +866,16 @@ VSRLR(vsrlr_h, 16, uint16_t, H)
 VSRLR(vsrlr_w, 32, uint32_t, W)
 VSRLR(vsrlr_d, 64, uint64_t, D)
 
-#define VSRLRI(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i;                                                \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-        Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), imm);         \
-    }                                                     \
+#define VSRLRI(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+        Vd->E(i) = do_vsrlr_ ## E(Vj->E(i), imm);                  \
+    }                                                              \
 }
 
 VSRLRI(vsrlri_b, 8, B)
@@ -907,13 +899,12 @@ do_vsrar(W, int32_t)
 do_vsrar(D, int64_t)
 
 #define VSRAR(NAME, BIT, T, E)                                  \
-void HELPER(NAME)(CPULoongArchState *env,                       \
-                  uint32_t vd, uint32_t vj, uint32_t vk)        \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)  \
 {                                                               \
     int i;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                            \
-    VReg *Vj = &(env->fpr[vj].vreg);                            \
-    VReg *Vk = &(env->fpr[vk].vreg);                            \
+    VReg *Vd = (VReg *)vd;                                      \
+    VReg *Vj = (VReg *)vj;                                      \
+    VReg *Vk = (VReg *)vk;                                      \
                                                                 \
     for (i = 0; i < LSX_LEN/BIT; i++) {                         \
         Vd->E(i) = do_vsrar_ ## E(Vj->E(i), ((T)Vk->E(i))%BIT); \
@@ -925,17 +916,16 @@ VSRAR(vsrar_h, 16, uint16_t, H)
 VSRAR(vsrar_w, 32, uint32_t, W)
 VSRAR(vsrar_d, 64, uint64_t, D)
 
-#define VSRARI(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i;                                                \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-        Vd->E(i) = do_vsrar_ ## E(Vj->E(i), imm);         \
-    }                                                     \
+#define VSRARI(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+        Vd->E(i) = do_vsrar_ ## E(Vj->E(i), imm);                  \
+    }                                                              \
 }
 
 VSRARI(vsrari_b, 8, B)
@@ -946,13 +936,12 @@ VSRARI(vsrari_d, 64, D)
 #define R_SHIFT(a, b) (a >> b)
 
 #define VSRLN(NAME, BIT, T, E1, E2)                             \
-void HELPER(NAME)(CPULoongArchState *env,                       \
-                  uint32_t vd, uint32_t vj, uint32_t vk)        \
+void HELPER(NAME)(void *vd, void *v, void *vk, uint32_t desc)   \
 {                                                               \
     int i;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                            \
-    VReg *Vj = &(env->fpr[vj].vreg);                            \
-    VReg *Vk = &(env->fpr[vk].vreg);                            \
+    VReg *Vd = (VReg *)vd;                                      \
+    VReg *Vj = (VReg *)vj;                                      \
+    VReg *Vk = (VReg *)vk;                                      \
                                                                 \
     for (i = 0; i < LSX_LEN/BIT; i++) {                         \
         Vd->E1(i) = R_SHIFT((T)Vj->E2(i),((T)Vk->E2(i)) % BIT); \
@@ -964,50 +953,47 @@ VSRLN(vsrln_b_h, 16, uint16_t, B, H)
 VSRLN(vsrln_h_w, 32, uint32_t, H, W)
 VSRLN(vsrln_w_d, 64, uint64_t, W, D)
 
-#define VSRAN(NAME, BIT, T, E1, E2)                           \
-void HELPER(NAME)(CPULoongArchState *env,                     \
-                  uint32_t vd, uint32_t vj, uint32_t vk)      \
-{                                                             \
-    int i;                                                    \
-    VReg *Vd = &(env->fpr[vd].vreg);                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                          \
-    VReg *Vk = &(env->fpr[vk].vreg);                          \
-                                                              \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                       \
-        Vd->E1(i) = R_SHIFT(Vj->E2(i), ((T)Vk->E2(i)) % BIT); \
-    }                                                         \
-    Vd->D(1) = 0;                                             \
+#define VSRAN(NAME, BIT, T, E1, E2)                            \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        Vd->E1(i) = R_SHIFT(Vj->E2(i), ((T)Vk->E2(i)) % BIT);  \
+    }                                                          \
+    Vd->D(1) = 0;                                              \
 }
 
 VSRAN(vsran_b_h, 16, uint16_t, B, H)
 VSRAN(vsran_h_w, 32, uint32_t, H, W)
 VSRAN(vsran_w_d, 64, uint64_t, W, D)
 
-#define VSRLNI(NAME, BIT, T, E1, E2)                         \
-void HELPER(NAME)(CPULoongArchState *env,                    \
-                  uint32_t vd, uint32_t vj, uint32_t imm)    \
-{                                                            \
-    int i, max;                                              \
-    VReg temp;                                               \
-    VReg *Vd = &(env->fpr[vd].vreg);                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                         \
-                                                             \
-    temp.D(0) = 0;                                           \
-    temp.D(1) = 0;                                           \
-    max = LSX_LEN/BIT;                                       \
-    for (i = 0; i < max; i++) {                              \
-        temp.E1(i) = R_SHIFT((T)Vj->E2(i), imm);             \
-        temp.E1(i + max) = R_SHIFT((T)Vd->E2(i), imm);       \
-    }                                                        \
-    *Vd = temp;                                              \
-}
-
-void HELPER(vsrlni_d_q)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t imm)
+#define VSRLNI(NAME, BIT, T, E1, E2)                               \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i, max;                                                    \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    temp.D(0) = 0;                                                 \
+    temp.D(1) = 0;                                                 \
+    max = LSX_LEN/BIT;                                             \
+    for (i = 0; i < max; i++) {                                    \
+        temp.E1(i) = R_SHIFT((T)Vj->E2(i), imm);                   \
+        temp.E1(i + max) = R_SHIFT((T)Vd->E2(i), imm);             \
+    }                                                              \
+    *Vd = temp;                                                    \
+}
+
+void HELPER(vsrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp.D(0) = 0;
     temp.D(1) = 0;
@@ -1020,31 +1006,29 @@ VSRLNI(vsrlni_b_h, 16, uint16_t, B, H)
 VSRLNI(vsrlni_h_w, 32, uint32_t, H, W)
 VSRLNI(vsrlni_w_d, 64, uint64_t, W, D)
 
-#define VSRANI(NAME, BIT, E1, E2)                         \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i, max;                                           \
-    VReg temp;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    temp.D(0) = 0;                                        \
-    temp.D(1) = 0;                                        \
-    max = LSX_LEN/BIT;                                    \
-    for (i = 0; i < max; i++) {                           \
-        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);             \
-        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);       \
-    }                                                     \
-    *Vd = temp;                                           \
-}
-
-void HELPER(vsrani_d_q)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t imm)
+#define VSRANI(NAME, BIT, E1, E2)                                  \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i, max;                                                    \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    temp.D(0) = 0;                                                 \
+    temp.D(1) = 0;                                                 \
+    max = LSX_LEN/BIT;                                             \
+    for (i = 0; i < max; i++) {                                    \
+        temp.E1(i) = R_SHIFT(Vj->E2(i), imm);                      \
+        temp.E1(i + max) = R_SHIFT(Vd->E2(i), imm);                \
+    }                                                              \
+    *Vd = temp;                                                    \
+}
+
+void HELPER(vsrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp.D(0) = 0;
     temp.D(1) = 0;
@@ -1058,13 +1042,12 @@ VSRANI(vsrani_h_w, 32, H, W)
 VSRANI(vsrani_w_d, 64, W, D)
 
 #define VSRLRN(NAME, BIT, T, E1, E2)                                \
-void HELPER(NAME)(CPULoongArchState *env,                           \
-                  uint32_t vd, uint32_t vj, uint32_t vk)            \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)      \
 {                                                                   \
     int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-    VReg *Vk = &(env->fpr[vk].vreg);                                \
+    VReg *Vd = (VReg *)vd;                                          \
+    VReg *Vj = (VReg *)vj;                                          \
+    VReg *Vk = (VReg *)vk;                                          \
                                                                     \
     for (i = 0; i < LSX_LEN/BIT; i++) {                             \
         Vd->E1(i) = do_vsrlr_ ## E2(Vj->E2(i), ((T)Vk->E2(i))%BIT); \
@@ -1077,13 +1060,12 @@ VSRLRN(vsrlrn_h_w, 32, uint32_t, H, W)
 VSRLRN(vsrlrn_w_d, 64, uint64_t, W, D)
 
 #define VSRARN(NAME, BIT, T, E1, E2)                                \
-void HELPER(NAME)(CPULoongArchState *env,                           \
-                  uint32_t vd, uint32_t vj, uint32_t vk)            \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)      \
 {                                                                   \
     int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-    VReg *Vk = &(env->fpr[vk].vreg);                                \
+    VReg *Vd = (VReg *)vd;                                          \
+    VReg *Vj = (VReg *)vj;                                          \
+    VReg *Vk = (VReg *)vk;                                          \
                                                                     \
     for (i = 0; i < LSX_LEN/BIT; i++) {                             \
         Vd->E1(i) = do_vsrar_ ## E2(Vj->E2(i), ((T)Vk->E2(i))%BIT); \
@@ -1095,31 +1077,29 @@ VSRARN(vsrarn_b_h, 16, uint8_t,  B, H)
 VSRARN(vsrarn_h_w, 32, uint16_t, H, W)
 VSRARN(vsrarn_w_d, 64, uint32_t, W, D)
 
-#define VSRLRNI(NAME, BIT, E1, E2)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)   \
-{                                                           \
-    int i, max;                                             \
-    VReg temp;                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-                                                            \
-    temp.D(0) = 0;                                          \
-    temp.D(1) = 0;                                          \
-    max = LSX_LEN/BIT;                                      \
-    for (i = 0; i < max; i++) {                             \
-        temp.E1(i) = do_vsrlr_ ## E2(Vj->E2(i), imm);       \
-        temp.E1(i + max) = do_vsrlr_ ## E2(Vd->E2(i), imm); \
-    }                                                       \
-    *Vd = temp;                                             \
-}
-
-void HELPER(vsrlrni_d_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+#define VSRLRNI(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i, max;                                                    \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    temp.D(0) = 0;                                                 \
+    temp.D(1) = 0;                                                 \
+    max = LSX_LEN/BIT;                                             \
+    for (i = 0; i < max; i++) {                                    \
+        temp.E1(i) = do_vsrlr_ ## E2(Vj->E2(i), imm);              \
+        temp.E1(i + max) = do_vsrlr_ ## E2(Vd->E2(i), imm);        \
+    }                                                              \
+    *Vd = temp;                                                    \
+}
+
+void HELPER(vsrlrni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
     Int128 r1, r2;
 
     if (imm == 0) {
@@ -1139,31 +1119,29 @@ VSRLRNI(vsrlrni_b_h, 16, B, H)
 VSRLRNI(vsrlrni_h_w, 32, H, W)
 VSRLRNI(vsrlrni_w_d, 64, W, D)
 
-#define VSRARNI(NAME, BIT, E1, E2)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)   \
-{                                                           \
-    int i, max;                                             \
-    VReg temp;                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-                                                            \
-    temp.D(0) = 0;                                          \
-    temp.D(1) = 0;                                          \
-    max = LSX_LEN/BIT;                                      \
-    for (i = 0; i < max; i++) {                             \
-        temp.E1(i) = do_vsrar_ ## E2(Vj->E2(i), imm);       \
-        temp.E1(i + max) = do_vsrar_ ## E2(Vd->E2(i), imm); \
-    }                                                       \
-    *Vd = temp;                                             \
-}
-
-void HELPER(vsrarni_d_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+#define VSRARNI(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i, max;                                                    \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    temp.D(0) = 0;                                                 \
+    temp.D(1) = 0;                                                 \
+    max = LSX_LEN/BIT;                                             \
+    for (i = 0; i < max; i++) {                                    \
+        temp.E1(i) = do_vsrar_ ## E2(Vj->E2(i), imm);              \
+        temp.E1(i + max) = do_vsrar_ ## E2(Vd->E2(i), imm);        \
+    }                                                              \
+    *Vd = temp;                                                    \
+}
+
+void HELPER(vsrarni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
     Int128 r1, r2;
 
     if (imm == 0) {
@@ -1206,13 +1184,12 @@ SSRLNS(H, uint32_t, int32_t, uint16_t)
 SSRLNS(W, uint64_t, int64_t, uint32_t)
 
 #define VSSRLN(NAME, BIT, T, E1, E2)                                          \
-void HELPER(NAME)(CPULoongArchState *env,                                     \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
 {                                                                             \
     int i;                                                                    \
-    VReg *Vd = &(env->fpr[vd].vreg);                                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                                          \
-    VReg *Vk = &(env->fpr[vk].vreg);                                          \
+    VReg *Vd = (VReg *)vd;                                                    \
+    VReg *Vj = (VReg *)vj;                                                    \
+    VReg *Vk = (VReg *)vk;                                                    \
                                                                               \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
         Vd->E1(i) = do_ssrlns_ ## E1(Vj->E2(i), (T)Vk->E2(i)% BIT, BIT/2 -1); \
@@ -1249,13 +1226,12 @@ SSRANS(H, int32_t, int16_t)
 SSRANS(W, int64_t, int32_t)
 
 #define VSSRAN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                     \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)               \
 {                                                                            \
     int i;                                                                   \
-    VReg *Vd = &(env->fpr[vd].vreg);                                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                                         \
-    VReg *Vk = &(env->fpr[vk].vreg);                                         \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+    VReg *Vk = (VReg *)vk;                                                   \
                                                                              \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
         Vd->E1(i) = do_ssrans_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
@@ -1290,13 +1266,12 @@ SSRLNU(H, uint32_t, uint16_t, int32_t)
 SSRLNU(W, uint64_t, uint32_t, int64_t)
 
 #define VSSRLNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(CPULoongArchState *env,                                 \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
 {                                                                         \
     int i;                                                                \
-    VReg *Vd = &(env->fpr[vd].vreg);                                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                                      \
-    VReg *Vk = &(env->fpr[vk].vreg);                                      \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
                                                                           \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                   \
         Vd->E1(i) = do_ssrlnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
@@ -1334,13 +1309,12 @@ SSRANU(H, uint32_t, uint16_t, int32_t)
 SSRANU(W, uint64_t, uint32_t, int64_t)
 
 #define VSSRANU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(CPULoongArchState *env,                                 \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)            \
 {                                                                         \
     int i;                                                                \
-    VReg *Vd = &(env->fpr[vd].vreg);                                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                                      \
-    VReg *Vk = &(env->fpr[vk].vreg);                                      \
+    VReg *Vd = (VReg *)vd;                                                \
+    VReg *Vj = (VReg *)vj;                                                \
+    VReg *Vk = (VReg *)vk;                                                \
                                                                           \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                   \
         Vd->E1(i) = do_ssranu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
@@ -1353,13 +1327,12 @@ VSSRANU(vssran_hu_w, 32, uint32_t, H, W)
 VSSRANU(vssran_wu_d, 64, uint64_t, W, D)
 
 #define VSSRLNI(NAME, BIT, E1, E2)                                            \
-void HELPER(NAME)(CPULoongArchState *env,                                     \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                     \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)            \
 {                                                                             \
     int i;                                                                    \
     VReg temp;                                                                \
-    VReg *Vd = &(env->fpr[vd].vreg);                                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                                          \
+    VReg *Vd = (VReg *)vd;                                                    \
+    VReg *Vj = (VReg *)vj;                                                    \
                                                                               \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
         temp.E1(i) = do_ssrlns_ ## E1(Vj->E2(i), imm, BIT/2 -1);              \
@@ -1368,12 +1341,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                     \
     *Vd = temp;                                                               \
 }
 
-void HELPER(vssrlni_d_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrlni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1402,13 +1374,12 @@ VSSRLNI(vssrlni_h_w, 32, H, W)
 VSSRLNI(vssrlni_w_d, 64, W, D)
 
 #define VSSRANI(NAME, BIT, E1, E2)                                             \
-void HELPER(NAME)(CPULoongArchState *env,                                      \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                      \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)             \
 {                                                                              \
     int i;                                                                     \
     VReg temp;                                                                 \
-    VReg *Vd = &(env->fpr[vd].vreg);                                           \
-    VReg *Vj = &(env->fpr[vj].vreg);                                           \
+    VReg *Vd = (VReg *)vd;                                                     \
+    VReg *Vj = (VReg *)vj;                                                     \
                                                                                \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                        \
         temp.E1(i) = do_ssrans_ ## E1(Vj->E2(i), imm, BIT/2 -1);               \
@@ -1417,12 +1388,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                      \
     *Vd = temp;                                                                \
 }
 
-void HELPER(vssrani_d_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrani_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask, min;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd; 
+    VReg *Vj = (VReg *)vj; 
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1456,13 +1426,12 @@ VSSRANI(vssrani_h_w, 32, H, W)
 VSSRANI(vssrani_w_d, 64, W, D)
 
 #define VSSRLNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                   \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)          \
 {                                                                           \
     int i;                                                                  \
     VReg temp;                                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                                        \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
                                                                             \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
         temp.E1(i) = do_ssrlnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
@@ -1471,12 +1440,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                   \
     *Vd = temp;                                                             \
 }
 
-void HELPER(vssrlni_du_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrlni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1505,13 +1473,12 @@ VSSRLNUI(vssrlni_hu_w, 32, H, W)
 VSSRLNUI(vssrlni_wu_d, 64, W, D)
 
 #define VSSRANUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                   \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                   \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)          \
 {                                                                           \
     int i;                                                                  \
     VReg temp;                                                              \
-    VReg *Vd = &(env->fpr[vd].vreg);                                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                                        \
+    VReg *Vd = (VReg *)vd;                                                  \
+    VReg *Vj = (VReg *)vj;                                                  \
                                                                             \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
         temp.E1(i) = do_ssranu_ ## E1(Vj->E2(i), imm, BIT/2);               \
@@ -1520,12 +1487,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                   \
     *Vd = temp;                                                             \
 }
 
-void HELPER(vssrani_du_q)(CPULoongArchState *env,
-                         uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrani_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1582,13 +1548,12 @@ SSRLRNS(H, W, uint32_t, int32_t, uint16_t)
 SSRLRNS(W, D, uint64_t, int64_t, uint32_t)
 
 #define VSSRLRN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                     \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
 {                                                                             \
     int i;                                                                    \
-    VReg *Vd = &(env->fpr[vd].vreg);                                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                                          \
-    VReg *Vk = &(env->fpr[vk].vreg);                                          \
+    VReg *Vd = (VReg *)vd;                                                    \
+    VReg *Vj = (VReg *)vj;                                                    \
+    VReg *Vk = (VReg *)vk;                                                    \
                                                                               \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
         Vd->E1(i) = do_ssrlrns_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
@@ -1622,13 +1587,12 @@ SSRARNS(H, W, int32_t, int16_t)
 SSRARNS(W, D, int64_t, int32_t)
 
 #define VSSRARN(NAME, BIT, T, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                     \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                      \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)                \
 {                                                                             \
     int i;                                                                    \
-    VReg *Vd = &(env->fpr[vd].vreg);                                          \
-    VReg *Vj = &(env->fpr[vj].vreg);                                          \
-    VReg *Vk = &(env->fpr[vk].vreg);                                          \
+    VReg *Vd = (VReg *)vd;                                                    \
+    VReg *Vj = (VReg *)vj;                                                    \
+    VReg *Vk = (VReg *)vk;                                                    \
                                                                               \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                       \
         Vd->E1(i) = do_ssrarns_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2 -1); \
@@ -1661,13 +1625,12 @@ SSRLRNU(H, W, uint32_t, uint16_t, int32_t)
 SSRLRNU(W, D, uint64_t, uint32_t, int64_t)
 
 #define VSSRLRNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(CPULoongArchState *env,                                  \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                   \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)             \
 {                                                                          \
     int i;                                                                 \
-    VReg *Vd = &(env->fpr[vd].vreg);                                       \
-    VReg *Vj = &(env->fpr[vj].vreg);                                       \
-    VReg *Vk = &(env->fpr[vk].vreg);                                       \
+    VReg *Vd = (VReg *)vd;                                                 \
+    VReg *Vj = (VReg *)vj;                                                 \
+    VReg *Vk = (VReg *)vk;                                                 \
                                                                            \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                    \
         Vd->E1(i) = do_ssrlrnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
@@ -1703,13 +1666,12 @@ SSRARNU(H, W, uint32_t, uint16_t, int32_t)
 SSRARNU(W, D, uint64_t, uint32_t, int64_t)
 
 #define VSSRARNU(NAME, BIT, T, E1, E2)                                     \
-void HELPER(NAME)(CPULoongArchState *env,                                  \
-                  uint32_t vd, uint32_t vj, uint32_t vk)                   \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)             \
 {                                                                          \
     int i;                                                                 \
-    VReg *Vd = &(env->fpr[vd].vreg);                                       \
-    VReg *Vj = &(env->fpr[vj].vreg);                                       \
-    VReg *Vk = &(env->fpr[vk].vreg);                                       \
+    VReg *Vd = (VReg *)vd;                                                 \
+    VReg *Vj = (VReg *)vj;                                                 \
+    VReg *Vk = (VReg *)vk;                                                 \
                                                                            \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                    \
         Vd->E1(i) = do_ssrarnu_ ## E1(Vj->E2(i), (T)Vk->E2(i)%BIT, BIT/2); \
@@ -1722,13 +1684,12 @@ VSSRARNU(vssrarn_hu_w, 32, uint32_t, H, W)
 VSSRARNU(vssrarn_wu_d, 64, uint64_t, W, D)
 
 #define VSSRLRNI(NAME, BIT, E1, E2)                                            \
-void HELPER(NAME)(CPULoongArchState *env,                                      \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                      \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)             \
 {                                                                              \
     int i;                                                                     \
     VReg temp;                                                                 \
-    VReg *Vd = &(env->fpr[vd].vreg);                                           \
-    VReg *Vj = &(env->fpr[vj].vreg);                                           \
+    VReg *Vd = (VReg *)vd;                                                     \
+    VReg *Vj = (VReg *)vj;                                                     \
                                                                                \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                        \
         temp.E1(i) = do_ssrlrns_ ## E1(Vj->E2(i), imm, BIT/2 -1);              \
@@ -1738,12 +1699,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                      \
 }
 
 #define VSSRLRNI_Q(NAME, sh)                                               \
-void HELPER(NAME)(CPULoongArchState *env,                                  \
-                          uint32_t vd, uint32_t vj, uint32_t imm)          \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)         \
 {                                                                          \
     Int128 shft_res1, shft_res2, mask, r1, r2;                             \
-    VReg *Vd = &(env->fpr[vd].vreg);                                       \
-    VReg *Vj = &(env->fpr[vj].vreg);                                       \
+    VReg *Vd = (VReg *)vd;                                                 \
+    VReg *Vj = (VReg *)vj;                                                 \
                                                                            \
     if (imm == 0) {                                                        \
         shft_res1 = Vj->Q(0);                                              \
@@ -1777,13 +1737,12 @@ VSSRLRNI(vssrlrni_w_d, 64, W, D)
 VSSRLRNI_Q(vssrlrni_d_q, 63)
 
 #define VSSRARNI(NAME, BIT, E1, E2)                                             \
-void HELPER(NAME)(CPULoongArchState *env,                                       \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)              \
 {                                                                               \
     int i;                                                                      \
     VReg temp;                                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                                            \
-    VReg *Vj = &(env->fpr[vj].vreg);                                            \
+    VReg *Vd = (VReg *)vd;                                                      \
+    VReg *Vj = (VReg *)vj;                                                      \
                                                                                 \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                         \
         temp.E1(i) = do_ssrarns_ ## E1(Vj->E2(i), imm, BIT/2 -1);               \
@@ -1792,12 +1751,11 @@ void HELPER(NAME)(CPULoongArchState *env,
     *Vd = temp;                                                                 \
 }
 
-void HELPER(vssrarni_d_q)(CPULoongArchState *env,
-                          uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrarni_d_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask1, mask2, r1, r2;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1835,13 +1793,12 @@ VSSRARNI(vssrarni_h_w, 32, H, W)
 VSSRARNI(vssrarni_w_d, 64, W, D)
 
 #define VSSRLRNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                    \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)           \
 {                                                                            \
     int i;                                                                   \
     VReg temp;                                                               \
-    VReg *Vd = &(env->fpr[vd].vreg);                                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                                         \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
                                                                              \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
         temp.E1(i) = do_ssrlrnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
@@ -1856,13 +1813,12 @@ VSSRLRNUI(vssrlrni_wu_d, 64, W, D)
 VSSRLRNI_Q(vssrlrni_du_q, 64)
 
 #define VSSRARNUI(NAME, BIT, E1, E2)                                         \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
-                  uint32_t vd, uint32_t vj, uint32_t imm)                    \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)           \
 {                                                                            \
     int i;                                                                   \
     VReg temp;                                                               \
-    VReg *Vd = &(env->fpr[vd].vreg);                                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                                         \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
                                                                              \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
         temp.E1(i) = do_ssrarnu_ ## E1(Vj->E2(i), imm, BIT/2);               \
@@ -1871,12 +1827,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                    \
     *Vd = temp;                                                              \
 }
 
-void HELPER(vssrarni_du_q)(CPULoongArchState *env,
-                           uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vssrarni_du_q)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     Int128 shft_res1, shft_res2, mask1, mask2, r1, r2;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     if (imm == 0) {
         shft_res1 = Vj->Q(0);
@@ -1920,17 +1875,17 @@ VSSRARNUI(vssrarni_bu_h, 16, B, H)
 VSSRARNUI(vssrarni_hu_w, 32, H, W)
 VSSRARNUI(vssrarni_wu_d, 64, W, D)
 
-#define DO_2OP(NAME, BIT, E, DO_OP)                                 \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++)                               \
-    {                                                               \
-        Vd->E(i) = DO_OP(Vj->E(i));                                 \
-    }                                                               \
+#define DO_2OP(NAME, BIT, E, DO_OP)                  \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++)                \
+    {                                                \
+        Vd->E(i) = DO_OP(Vj->E(i));                  \
+    }                                                \
 }
 
 #define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
@@ -1951,17 +1906,17 @@ DO_2OP(vclz_h, 16, UH, DO_CLZ_H)
 DO_2OP(vclz_w, 32, UW, DO_CLZ_W)
 DO_2OP(vclz_d, 64, UD, DO_CLZ_D)
 
-#define VPCNT(NAME, BIT, E, FN)                                     \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++)                               \
-    {                                                               \
-        Vd->E(i) = FN(Vj->E(i));                                    \
-    }                                                               \
+#define VPCNT(NAME, BIT, E, FN)                      \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+                                                     \
+    for (i = 0; i < LSX_LEN/BIT; i++)                \
+    {                                                \
+        Vd->E(i) = FN(Vj->E(i));                     \
+    }                                                \
 }
 
 VPCNT(vpcnt_b, 8, UB, ctpop8)
@@ -2024,42 +1979,40 @@ DO_BITI(vbitrevi_h, 16, UH, DO_BITREV)
 DO_BITI(vbitrevi_w, 32, UW, DO_BITREV)
 DO_BITI(vbitrevi_d, 64, UD, DO_BITREV)
 
-#define VFRSTP(NAME, BIT, MASK, E)                       \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i, m;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        if (Vj->E(i) < 0) {                              \
-            break;                                       \
-        }                                                \
-    }                                                    \
-    m = Vk->E(0) & MASK;                                 \
-    Vd->E(m) = i;                                        \
+#define VFRSTP(NAME, BIT, MASK, E)                             \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i, m;                                                  \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        if (Vj->E(i) < 0) {                                    \
+            break;                                             \
+        }                                                      \
+    }                                                          \
+    m = Vk->E(0) & MASK;                                       \
+    Vd->E(m) = i;                                              \
 }
 
 VFRSTP(vfrstp_b, 8, 0xf, B)
 VFRSTP(vfrstp_h, 16, 0x7, H)
 
-#define VFRSTPI(NAME, BIT, E)                             \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i, m;                                             \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-        if (Vj->E(i) < 0) {                               \
-            break;                                        \
-        }                                                 \
-    }                                                     \
-    m = imm % (LSX_LEN/BIT);                              \
-    Vd->E(m) = i;                                         \
+#define VFRSTPI(NAME, BIT, E)                                     \
+void HELPER(NAME)(void *vd, void vj, uint64_t imm, uint32_t desc) \
+{                                                                 \
+    int i, m;                                                     \
+    VReg *Vd = (VReg *)vd;                                        \
+    VReg *Vj = (VReg *)vj;                                        \
+                                                                  \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                           \
+        if (Vj->E(i) < 0) {                                       \
+            break;                                                \
+        }                                                         \
+    }                                                             \
+    m = imm % (LSX_LEN/BIT);                                      \
+    Vd->E(m) = i;                                                 \
 }
 
 VFRSTPI(vfrstpi_b, 8,  B)
@@ -2097,13 +2050,13 @@ static inline void vec_clear_cause(CPULoongArchState *env)
 }
 
 #define DO_3OP_F(NAME, BIT, E, FN)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
-                  uint32_t vd, uint32_t vj, uint32_t vk)    \
+void HELPER(NAME)(void *vd, void *vj, void *vk,             \
+                  CPULoongArchState *env, uint32_t desc)    \
 {                                                           \
     int i;                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                        \
-    VReg *Vk = &(env->fpr[vk].vreg);                        \
+    VReg *Vd = (VReg *)vd;                                  \
+    VReg *Vj = (VReg *)vj;                                  \
+    VReg *Vk = (VReg *)vk;                                  \
                                                             \
     vec_clear_cause(env);                                   \
     for (i = 0; i < LSX_LEN/BIT; i++) {                     \
@@ -2130,14 +2083,14 @@ DO_3OP_F(vfmina_s, 32, UW, float32_minnummag)
 DO_3OP_F(vfmina_d, 64, UD, float64_minnummag)
 
 #define DO_4OP_F(NAME, BIT, E, FN, flags)                                    \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
-                  uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)        \
+void HELPER(NAME)(void *vd, void *vj, void *vk, void *va,                    \
+                  CPULoongArchState *env, uint32_t desc)                     \
 {                                                                            \
     int i;                                                                   \
-    VReg *Vd = &(env->fpr[vd].vreg);                                         \
-    VReg *Vj = &(env->fpr[vj].vreg);                                         \
-    VReg *Vk = &(env->fpr[vk].vreg);                                         \
-    VReg *Va = &(env->fpr[va].vreg);                                         \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+    VReg *Vk = (VReg *)vk;                                                   \
+    VReg *Va = (VReg *)va;                                                   \
                                                                              \
     vec_clear_cause(env);                                                    \
     for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
@@ -2157,17 +2110,17 @@ DO_4OP_F(vfnmsub_s, 32, UW, float32_muladd,
 DO_4OP_F(vfnmsub_d, 64, UD, float64_muladd,
          float_muladd_negate_c | float_muladd_negate_result)
 
-#define DO_2OP_F(NAME, BIT, E, FN)                                  \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define DO_2OP_F(NAME, BIT, E, FN)                                           \
+void HELPER(NAME)(void *vd, void *vj, CPULoongArchState *env, uint32_t desc) \
+{                                                                            \
+    int i;                                                                   \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+                                                                             \
+    vec_clear_cause(env);                                                    \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
+        Vd->E(i) = FN(env, Vj->E(i));                                        \
+    }                                                                        \
 }
 
 #define FLOGB(BIT, T)                                            \
@@ -2188,16 +2141,16 @@ static T do_flogb_## BIT(CPULoongArchState *env, T fj)           \
 FLOGB(32, uint32_t)
 FLOGB(64, uint64_t)
 
-#define FCLASS(NAME, BIT, E, FN)                                    \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define FCLASS(NAME, BIT, E, FN)                                             \
+void HELPER(NAME)(void *vd, void *vj, CPULoongArchState *env, uint32_t desc) \
+{                                                                            \
+    int i;                                                                   \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+                                                                             \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
+        Vd->E(i) = FN(env, Vj->E(i));                                        \
+    }                                                                        \
 }
 
 FCLASS(vfclass_s, 32, UW, helper_fclass_s)
@@ -2267,12 +2220,13 @@ static uint32_t float64_cvt_float32(uint64_t d, float_status *status)
     return float64_to_float32(d, status);
 }
 
-void HELPER(vfcvtl_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_s_h)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/32; i++) {
@@ -2282,12 +2236,13 @@ void HELPER(vfcvtl_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvtl_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_d_s)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
-    VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg temp
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/64; i++) {
@@ -2297,12 +2252,13 @@ void HELPER(vfcvtl_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvth_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_s_h)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/32; i++) {
@@ -2312,12 +2268,13 @@ void HELPER(vfcvth_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvth_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_d_s)(void *vd, void *vj,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < LSX_LEN/64; i++) {
@@ -2327,14 +2284,14 @@ void HELPER(vfcvth_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vfcvt_h_s)(CPULoongArchState *env,
-                       uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vfcvt_h_s)(void *vd, void *vj, void *vk,
+                       CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for(i = 0; i < LSX_LEN/32; i++) {
@@ -2345,14 +2302,14 @@ void HELPER(vfcvt_h_s)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-void HELPER(vfcvt_s_d)(CPULoongArchState *env,
-                       uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vfcvt_s_d)(void *vd, void *vj, void *vk,
+                       CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for(i = 0; i < LSX_LEN/64; i++) {
@@ -2363,24 +2320,26 @@ void HELPER(vfcvt_s_d)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-void HELPER(vfrint_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfrint_s)(void *vd, void *vj,
+                      CPULoongArchState *env, uint32_t desc)
 {
     int i;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 4; i++) {
         Vd->W(i) = float32_round_to_int(Vj->UW(i), &env->fp_status);
         vec_update_fcsr0(env, GETPC());
     }
-}
 
-void HELPER(vfrint_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+
+void HELPER(vfrint_d)(void *vd, void *vj,
+                      CPULoongArchState *env, uint32_t desc)
 {
     int i;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2389,21 +2348,21 @@ void HELPER(vfrint_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     }
 }
 
-#define FCVT_2OP(NAME, BIT, E, MODE)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj)         \
-{                                                                           \
-    int i;                                                                  \
-    VReg *Vd = &(env->fpr[vd].vreg);                                        \
-    VReg *Vj = &(env->fpr[vj].vreg);                                        \
-                                                                            \
-    vec_clear_cause(env);                                                   \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
-        FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status); \
-        set_float_rounding_mode(MODE, &env->fp_status);                     \
-        Vd->E(i) = float## BIT ## _round_to_int(Vj->E(i), &env->fp_status); \
-        set_float_rounding_mode(old_mode, &env->fp_status);                 \
-        vec_update_fcsr0(env, GETPC());                                     \
-    }                                                                       \
+#define FCVT_2OP(NAME, BIT, E, MODE)                                         \
+void HELPER(NAME)(void *vd, void *vj, CPULoongArchState *env, uint32_t desc) \
+{                                                                            \
+    int i;                                                                   \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+                                                                             \
+    vec_clear_cause(env);                                                    \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
+        FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status);  \
+        set_float_rounding_mode(MODE, &env->fp_status);                      \
+        Vd->E(i) = float## BIT ## _round_to_int(Vj->E(i), &env->fp_status);  \
+        set_float_rounding_mode(old_mode, &env->fp_status);                  \
+        vec_update_fcsr0(env, GETPC());                                      \
+    }                                                                        \
 }
 
 FCVT_2OP(vfrintrne_s, 32, UW, float_round_nearest_even)
@@ -2482,22 +2441,22 @@ FTINT(rp_w_d, float64, int32, uint64_t, uint32_t, float_round_up)
 FTINT(rz_w_d, float64, int32, uint64_t, uint32_t, float_round_to_zero)
 FTINT(rne_w_d, float64, int32, uint64_t, uint32_t, float_round_nearest_even)
 
-#define FTINT_W_D(NAME, FN)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    vec_clear_cause(env);                                \
-    for (i = 0; i < 2; i++) {                            \
-        temp.W(i + 2) = FN(env, Vj->UD(i));              \
-        temp.W(i) = FN(env, Vk->UD(i));                  \
-    }                                                    \
-    *Vd = temp;                                          \
+#define FTINT_W_D(NAME, FN)                             \
+void HELPER(NAME)(void *vd, void *vj, void *vk,         \
+                  CPULoongArchState *env,uint32_t desc) \
+{                                                       \
+    int i;                                              \
+    VReg temp;                                          \
+    VReg *Vd = (VReg *)vd;                              \
+    VReg *Vj = (VReg *)vj;                              \
+    VReg *Vk = (VReg *)vk;                              \
+                                                        \
+    vec_clear_cause(env);                               \
+    for (i = 0; i < 2; i++) {                           \
+        temp.W(i + 2) = FN(env, Vj->UD(i));             \
+        temp.W(i) = FN(env, Vk->UD(i));                 \
+    }                                                   \
+    *Vd = temp;                                         \
 }
 
 FTINT_W_D(vftint_w_d, do_float64_to_int32)
@@ -2515,19 +2474,19 @@ FTINT(rph_l_s, float32, int64, uint32_t, uint64_t, float_round_up)
 FTINT(rzh_l_s, float32, int64, uint32_t, uint64_t, float_round_to_zero)
 FTINT(rneh_l_s, float32, int64, uint32_t, uint64_t, float_round_nearest_even)
 
-#define FTINTL_L_S(NAME, FN)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg temp;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < 2; i++) {                                       \
-        temp.D(i) = FN(env, Vj->UW(i));                             \
-    }                                                               \
-    *Vd = temp;                                                     \
+#define FTINTL_L_S(NAME, FN)                                                 \
+void HELPER(NAME)(void *vd, void *vj, CPULoongArchState *env, uint32_t desc) \
+{                                                                            \
+    int i;                                                                   \
+    VReg temp;                                                               \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+                                                                             \
+    vec_clear_cause(env);                                                    \
+    for (i = 0; i < 2; i++) {                                                \
+        temp.D(i) = FN(env, Vj->UW(i));                                      \
+    }                                                                        \
+    *Vd = temp;                                                              \
 }
 
 FTINTL_L_S(vftintl_l_s, do_float32_to_int64)
@@ -2536,19 +2495,19 @@ FTINTL_L_S(vftintrpl_l_s, do_ftintrpl_l_s)
 FTINTL_L_S(vftintrzl_l_s, do_ftintrzl_l_s)
 FTINTL_L_S(vftintrnel_l_s, do_ftintrnel_l_s)
 
-#define FTINTH_L_S(NAME, FN)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg temp;                                                      \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < 2; i++) {                                       \
-        temp.D(i) = FN(env, Vj->UW(i + 2));                         \
-    }                                                               \
-    *Vd = temp;                                                     \
+#define FTINTH_L_S(NAME, FN)                                                 \
+void HELPER(NAME)(void *vd, void *vj, CPULoongArchState *env, uint32_t desc) \
+{                                                                            \
+    int i;                                                                   \
+    VReg temp;                                                               \
+    VReg *Vd = (VReg *)vd;                                                   \
+    VReg *Vj = (VReg *)vj;                                                   \
+                                                                             \
+    vec_clear_cause(env);                                                    \
+    for (i = 0; i < 2; i++) {                                                \
+        temp.D(i) = FN(env, Vj->UW(i + 2));                                  \
+    }                                                                        \
+    *Vd = temp;                                                              \
 }
 
 FTINTH_L_S(vftinth_l_s, do_float32_to_int64)
@@ -2577,12 +2536,13 @@ DO_2OP_F(vffint_d_l, 64, D, do_ffint_d_l)
 DO_2OP_F(vffint_s_wu, 32, UW, do_ffint_s_wu)
 DO_2OP_F(vffint_d_lu, 64, UD, do_ffint_d_lu)
 
-void HELPER(vffintl_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffintl_d_w)(void *vd, void *vj,
+                         CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2592,12 +2552,13 @@ void HELPER(vffintl_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vffinth_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffinth_d_w)(void *vd, void *vj,
+                         CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2607,14 +2568,14 @@ void HELPER(vffinth_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
     *Vd = temp;
 }
 
-void HELPER(vffint_s_l)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t vk)
+void HELPER(vffint_s_l)(void *vd, void *vj, void *vk,
+                        CPULoongArchState *env, uint32_t desc)
 {
     int i;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
 
     vec_clear_cause(env);
     for (i = 0; i < 2; i++) {
@@ -2768,21 +2729,20 @@ SETALLNEZ(vsetallnez_h, MO_16)
 SETALLNEZ(vsetallnez_w, MO_32)
 SETALLNEZ(vsetallnez_d, MO_64)
 
-#define VPACKEV(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(2 * i);                \
-        temp.E(2 *i) = Vk->E(2 * i);                     \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPACKEV(NAME, BIT, E)                                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(2 * i + 1) = Vj->E(2 * i);                      \
+        temp.E(2 *i) = Vk->E(2 * i);                           \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VPACKEV(vpackev_b, 16, B)
@@ -2790,21 +2750,20 @@ VPACKEV(vpackev_h, 32, H)
 VPACKEV(vpackev_w, 64, W)
 VPACKEV(vpackev_d, 128, D)
 
-#define VPACKOD(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(2 * i + 1);            \
-        temp.E(2 * i) = Vk->E(2 * i + 1);                \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPACKOD(NAME, BIT, E)                                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(2 * i + 1) = Vj->E(2 * i + 1);                  \
+        temp.E(2 * i) = Vk->E(2 * i + 1);                      \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VPACKOD(vpackod_b, 16, B)
@@ -2812,21 +2771,20 @@ VPACKOD(vpackod_h, 32, H)
 VPACKOD(vpackod_w, 64, W)
 VPACKOD(vpackod_d, 128, D)
 
-#define VPICKEV(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i);          \
-        temp.E(i) = Vk->E(2 * i);                        \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPICKEV(NAME, BIT, E)                                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i);                \
+        temp.E(i) = Vk->E(2 * i);                              \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VPICKEV(vpickev_b, 16, B)
@@ -2834,21 +2792,20 @@ VPICKEV(vpickev_h, 32, H)
 VPICKEV(vpickev_w, 64, W)
 VPICKEV(vpickev_d, 128, D)
 
-#define VPICKOD(NAME, BIT, E)                            \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i + 1);      \
-        temp.E(i) = Vk->E(2 * i + 1);                    \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VPICKOD(NAME, BIT, E)                                  \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(i + LSX_LEN/BIT) = Vj->E(2 * i + 1);            \
+        temp.E(i) = Vk->E(2 * i + 1);                          \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VPICKOD(vpickod_b, 16, B)
@@ -2856,21 +2813,20 @@ VPICKOD(vpickod_h, 32, H)
 VPICKOD(vpickod_w, 64, W)
 VPICKOD(vpickod_d, 128, D)
 
-#define VILVL(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(i);                    \
-        temp.E(2 * i) = Vk->E(i);                        \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VILVL(NAME, BIT, E)                                    \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(2 * i + 1) = Vj->E(i);                          \
+        temp.E(2 * i) = Vk->E(i);                              \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VILVL(vilvl_b, 16, B)
@@ -2878,21 +2834,20 @@ VILVL(vilvl_h, 32, H)
 VILVL(vilvl_w, 64, W)
 VILVL(vilvl_d, 128, D)
 
-#define VILVH(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i;                                               \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                  \
-        temp.E(2 * i + 1) = Vj->E(i + LSX_LEN/BIT);      \
-        temp.E(2 * i) = Vk->E(i + LSX_LEN/BIT);          \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VILVH(NAME, BIT, E)                                    \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        temp.E(2 * i + 1) = Vj->E(i + LSX_LEN/BIT);            \
+        temp.E(2 * i) = Vk->E(i + LSX_LEN/BIT);                \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VILVH(vilvh_b, 16, B)
@@ -2900,15 +2855,14 @@ VILVH(vilvh_h, 32, H)
 VILVH(vilvh_w, 64, W)
 VILVH(vilvh_d, 128, D)
 
-void HELPER(vshuf_b)(CPULoongArchState *env,
-                     uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)
+void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
 {
     int i, m;
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
-    VReg *Vk = &(env->fpr[vk].vreg);
-    VReg *Va = &(env->fpr[va].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
+    VReg *Vk = (VReg *)vk;
+    VReg *Va = (VReg *)va;
 
     m = LSX_LEN/8;
     for (i = 0; i < m ; i++) {
@@ -2918,53 +2872,50 @@ void HELPER(vshuf_b)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-#define VSHUF(NAME, BIT, E)                              \
-void HELPER(NAME)(CPULoongArchState *env,                \
-                  uint32_t vd, uint32_t vj, uint32_t vk) \
-{                                                        \
-    int i, m;                                            \
-    VReg temp;                                           \
-    VReg *Vd = &(env->fpr[vd].vreg);                     \
-    VReg *Vj = &(env->fpr[vj].vreg);                     \
-    VReg *Vk = &(env->fpr[vk].vreg);                     \
-                                                         \
-    m = LSX_LEN/BIT;                                     \
-    for (i = 0; i < m; i++) {                            \
-        uint64_t k  = ((uint8_t) Vd->E(i)) % (2 * m);    \
-        temp.E(i) = k < m ? Vk->E(k) : Vj->E(k - m);     \
-    }                                                    \
-    *Vd = temp;                                          \
+#define VSHUF(NAME, BIT, E)                                    \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i, m;                                                  \
+    VReg temp;                                                 \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+                                                               \
+    m = LSX_LEN/BIT;                                           \
+    for (i = 0; i < m; i++) {                                  \
+        uint64_t k  = ((uint8_t) Vd->E(i)) % (2 * m);          \
+        temp.E(i) = k < m ? Vk->E(k) : Vj->E(k - m);           \
+    }                                                          \
+    *Vd = temp;                                                \
 }
 
 VSHUF(vshuf_h, 16, H)
 VSHUF(vshuf_w, 32, W)
 VSHUF(vshuf_d, 64, D)
 
-#define VSHUF4I(NAME, BIT, E)                             \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int i;                                                \
-    VReg temp;                                            \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                   \
-         temp.E(i) = Vj->E(((i) & 0xfc) + (((imm) >>      \
-                           (2 * ((i) & 0x03))) & 0x03));  \
-    }                                                     \
-    *Vd = temp;                                           \
+#define VSHUF4I(NAME, BIT, E)                                      \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg temp;                                                     \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+         temp.E(i) = Vj->E(((i) & 0xfc) + (((imm) >>               \
+                           (2 * ((i) & 0x03))) & 0x03));           \
+    }                                                              \
+    *Vd = temp;                                                    \
 }
 
 VSHUF4I(vshuf4i_b, 8, B)
 VSHUF4I(vshuf4i_h, 16, H)
 VSHUF4I(vshuf4i_w, 32, W)
 
-void HELPER(vshuf4i_d)(CPULoongArchState *env,
-                       uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vshuf4i_d)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     VReg temp;
     temp.D(0) = (imm & 2 ? Vj : Vd)->D(imm & 1);
@@ -2972,12 +2923,11 @@ void HELPER(vshuf4i_d)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-void HELPER(vpermi_w)(CPULoongArchState *env,
-                      uint32_t vd, uint32_t vj, uint32_t imm)
+void HELPER(vpermi_w)(void *vd, void *vj, uint64_t imm, uint32_t desc)
 {
     VReg temp;
-    VReg *Vd = &(env->fpr[vd].vreg);
-    VReg *Vj = &(env->fpr[vj].vreg);
+    VReg *Vd = (VReg *)vd;
+    VReg *Vj = (VReg *)vj;
 
     temp.W(0) = Vj->W(imm & 0x3);
     temp.W(1) = Vj->W((imm >> 2) & 0x3);
@@ -2986,17 +2936,16 @@ void HELPER(vpermi_w)(CPULoongArchState *env,
     *Vd = temp;
 }
 
-#define VEXTRINS(NAME, BIT, E, MASK)                      \
-void HELPER(NAME)(CPULoongArchState *env,                 \
-                  uint32_t vd, uint32_t vj, uint32_t imm) \
-{                                                         \
-    int ins, extr;                                        \
-    VReg *Vd = &(env->fpr[vd].vreg);                      \
-    VReg *Vj = &(env->fpr[vj].vreg);                      \
-                                                          \
-    ins = (imm >> 4) & MASK;                              \
-    extr = imm & MASK;                                    \
-    Vd->E(ins) = Vj->E(extr);                             \
+#define VEXTRINS(NAME, BIT, E, MASK)                               \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int ins, extr;                                                 \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    ins = (imm >> 4) & MASK;                                       \
+    extr = imm & MASK;                                             \
+    Vd->E(ins) = Vj->E(extr);                                      \
 }
 
 VEXTRINS(vextrins_b, 8, B, 0xf)
-- 
2.39.1


