Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 183B17970A0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:10:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeA5K-00040V-Dq; Thu, 07 Sep 2023 04:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeA50-0003wB-4b
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeA4p-0003LH-NJ
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxZ+gwhflkTzQhAA--.30289S3;
 Thu, 07 Sep 2023 16:09:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviMthflkXE1wAA--.31585S8; 
 Thu, 07 Sep 2023 16:09:20 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v5 06/57] target/loongarch: Use gen_helper_gvec_3 for 3OP
 vector instructions
Date: Thu,  7 Sep 2023 16:08:25 +0800
Message-Id: <20230907080916.3974502-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907080916.3974502-1-gaosong@loongson.cn>
References: <20230907080916.3974502-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviMthflkXE1wAA--.31585S8
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
 target/loongarch/helper.h                   | 214 +++++-----
 target/loongarch/vec_helper.c               | 444 +++++++++-----------
 target/loongarch/insn_trans/trans_vec.c.inc |  19 +-
 3 files changed, 326 insertions(+), 351 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index bcf82597aa..4b681e948f 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -133,22 +133,22 @@ DEF_HELPER_1(idle, void, env)
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
@@ -305,22 +305,22 @@ DEF_HELPER_FLAGS_4(vmaddwod_h_bu_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
@@ -363,30 +363,30 @@ DEF_HELPER_4(vsllwil_wu_hu, void, env, i32, i32, i32)
 DEF_HELPER_4(vsllwil_du_wu, void, env, i32, i32, i32)
 DEF_HELPER_3(vextl_qu_du, void, env, i32, i32)
 
-DEF_HELPER_4(vsrlr_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlr_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrlr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_4(vsrlri_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlri_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlri_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlri_d, void, env, i32, i32, i32)
 
-DEF_HELPER_4(vsrar_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrar_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrar_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_4(vsrari_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrari_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrari_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrari_d, void, env, i32, i32, i32)
 
-DEF_HELPER_4(vsrln_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrln_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsran_w_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrln_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrln_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrln_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsran_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_4(vsrlni_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlni_h_w, void, env, i32, i32, i32)
@@ -397,12 +397,12 @@ DEF_HELPER_4(vsrani_h_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrani_w_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrani_d_q, void, env, i32, i32, i32)
 
-DEF_HELPER_4(vsrlrn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrn_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarn_w_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrlrn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlrn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrlrn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vsrarn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_4(vsrlrni_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrlrni_h_w, void, env, i32, i32, i32)
@@ -413,18 +413,18 @@ DEF_HELPER_4(vsrarni_h_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrarni_w_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vsrarni_d_q, void, env, i32, i32, i32)
 
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
 
 DEF_HELPER_4(vssrlni_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrlni_h_w, void, env, i32, i32, i32)
@@ -443,18 +443,18 @@ DEF_HELPER_4(vssrani_hu_w, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrani_wu_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrani_du_q, void, env, i32, i32, i32)
 
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
 
 DEF_HELPER_4(vssrlrni_b_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vssrlrni_h_w, void, env, i32, i32, i32)
@@ -514,8 +514,8 @@ DEF_HELPER_FLAGS_4(vbitrevi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vfrstp_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstp_h, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vfrstp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vfrstp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_4(vfrstpi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vfrstpi_h, void, env, i32, i32, i32)
 
@@ -655,37 +655,37 @@ DEF_HELPER_3(vsetallnez_h, void, env, i32, i32)
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
 
 DEF_HELPER_FLAGS_5(vshuf_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
-DEF_HELPER_4(vshuf_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vshuf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(vshuf_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_4(vshuf4i_b, void, env, i32, i32, i32)
 DEF_HELPER_4(vshuf4i_h, void, env, i32, i32, i32)
 DEF_HELPER_4(vshuf4i_w, void, env, i32, i32, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index eab94a8b76..15b361c6b3 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -17,13 +17,12 @@
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
@@ -35,12 +34,11 @@ DO_ODD_EVEN(vhaddw_h_b, 16, H, B, DO_ADD)
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
@@ -49,12 +47,11 @@ DO_ODD_EVEN(vhsubw_h_b, 16, H, B, DO_SUB)
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
@@ -63,12 +60,11 @@ DO_ODD_EVEN(vhaddw_hu_bu, 16, UH, UB, DO_ADD)
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
@@ -78,12 +74,11 @@ DO_ODD_EVEN(vhsubw_hu_bu, 16, UH, UB, DO_SUB)
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
@@ -564,17 +559,16 @@ VMADDWOD_U_S(vmaddwod_d_wu_w, 64, D, UD, W, UW, DO_MUL)
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
+    for (i = 0; i < LSX_LEN/BIT; i++) {                        \
+        Vd->E(i) = DO_OP(Vj->E(i), Vk->E(i));                  \
+    }                                                          \
 }
 
 VDIV(vdiv_b, 8, B, DO_DIV)
@@ -854,13 +848,12 @@ do_vsrlr(W, uint32_t)
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
@@ -906,13 +899,12 @@ do_vsrar(W, int32_t)
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
@@ -945,13 +937,12 @@ VSRARI(vsrari_d, 64, D)
 #define R_SHIFT(a, b) (a >> b)
 
 #define VSRLN(NAME, BIT, T, E1, E2)                             \
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
         Vd->E1(i) = R_SHIFT((T)Vj->E2(i),((T)Vk->E2(i)) % BIT); \
@@ -963,19 +954,18 @@ VSRLN(vsrln_b_h, 16, uint16_t, B, H)
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
@@ -1057,13 +1047,12 @@ VSRANI(vsrani_h_w, 32, H, W)
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
@@ -1076,13 +1065,12 @@ VSRLRN(vsrlrn_h_w, 32, uint32_t, H, W)
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
@@ -1205,13 +1193,12 @@ SSRLNS(H, uint32_t, int32_t, uint16_t)
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
@@ -1248,13 +1235,12 @@ SSRANS(H, int32_t, int16_t)
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
@@ -1289,13 +1275,12 @@ SSRLNU(H, uint32_t, uint16_t, int32_t)
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
@@ -1333,13 +1318,12 @@ SSRANU(H, uint32_t, uint16_t, int32_t)
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
@@ -1581,13 +1565,12 @@ SSRLRNS(H, W, uint32_t, int32_t, uint16_t)
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
@@ -1621,13 +1604,12 @@ SSRARNS(H, W, int32_t, int16_t)
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
@@ -1660,13 +1642,12 @@ SSRLRNU(H, W, uint32_t, uint16_t, int32_t)
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
@@ -1702,13 +1683,12 @@ SSRARNU(H, W, uint32_t, uint16_t, int32_t)
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
@@ -2023,22 +2003,21 @@ DO_BITI(vbitrevi_h, 16, UH, DO_BITREV)
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
@@ -2767,21 +2746,20 @@ SETALLNEZ(vsetallnez_h, MO_16)
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
@@ -2789,21 +2767,20 @@ VPACKEV(vpackev_h, 32, H)
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
@@ -2811,21 +2788,20 @@ VPACKOD(vpackod_h, 32, H)
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
@@ -2833,21 +2809,20 @@ VPICKEV(vpickev_h, 32, H)
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
@@ -2855,21 +2830,20 @@ VPICKOD(vpickod_h, 32, H)
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
@@ -2877,21 +2851,20 @@ VILVL(vilvl_h, 32, H)
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
@@ -2916,22 +2889,21 @@ void HELPER(vshuf_b)(void *vd, void *vj, void *vk, void *va, uint32_t desc)
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
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index eae1929f44..6ead8fb4c5 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -70,17 +70,20 @@ static bool gen_vvv_ptr(DisasContext *ctx, arg_vvv *a,
     return gen_vvv_ptr_vl(ctx, a, 16, fn);
 }
 
-static bool gen_vvv(DisasContext *ctx, arg_vvv *a,
-                    void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vvv_vl(DisasContext *ctx, arg_vvv *a, uint32_t oprsz,
+                       gen_helper_gvec_3 *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 vk = tcg_constant_i32(a->vk);
+    tcg_gen_gvec_3_ool(vec_full_offset(a->vd),
+                       vec_full_offset(a->vj),
+                       vec_full_offset(a->vk),
+                       oprsz, ctx->vl / 8, oprsz, fn);
+    return true;
+}
 
+static bool gen_vvv(DisasContext *ctx, arg_vvv *a, gen_helper_gvec_3 *fn)
+{
     CHECK_SXE;
-
-    func(cpu_env, vd, vj, vk);
-    return true;
+    return gen_vvv_vl(ctx, a, 16, fn);
 }
 
 static bool gen_vv(DisasContext *ctx, arg_vv *a,
-- 
2.39.1


