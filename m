Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A279F830
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:35:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc4c-00039D-RP; Wed, 13 Sep 2023 22:27:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4R-000388-QB
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4M-0004qg-Ur
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:07 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxXOpwbwJlXvgmAA--.48373S3;
 Thu, 14 Sep 2023 10:26:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S11; 
 Thu, 14 Sep 2023 10:26:55 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 09/57] target/loongarch: Use gen_helper_gvec_2i for 2OP +
 imm vector instructions
Date: Thu, 14 Sep 2023 10:25:57 +0800
Message-Id: <20230914022645.1151356-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S11
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/helper.h                   | 146 +++----
 target/loongarch/vec_helper.c               | 445 +++++++++-----------
 target/loongarch/insn_trans/trans_vec.c.inc |  18 +-
 3 files changed, 291 insertions(+), 318 deletions(-)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 523591035d..1abd9e1410 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -354,32 +354,32 @@ DEF_HELPER_FLAGS_3(vmsknz_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vnori_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vsllwil_h_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_w_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_d_w, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsllwil_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_3(vextl_q_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
-DEF_HELPER_4(vsllwil_hu_bu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_wu_hu, void, env, i32, i32, i32)
-DEF_HELPER_4(vsllwil_du_wu, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsllwil_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsllwil_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_3(vextl_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(vsrlr_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrlr_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrlr_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrlr_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_4(vsrlri_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlri_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrlri_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlri_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_4(vsrar_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrar_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrar_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrar_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_4(vsrari_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrari_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrari_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrari_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_4(vsrln_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrln_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -388,14 +388,14 @@ DEF_HELPER_FLAGS_4(vsran_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsran_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsran_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_4(vsrlni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrani_d_q, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrlni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrani_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_4(vsrlrn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrlrn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -404,14 +404,14 @@ DEF_HELPER_FLAGS_4(vsrarn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrarn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsrarn_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
-DEF_HELPER_4(vsrlrni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrlrni_d_q, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_b_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_h_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_w_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vsrarni_d_q, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrlrni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_w_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vsrarni_d_q, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_4(vssrln_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssrln_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -426,22 +426,22 @@ DEF_HELPER_FLAGS_4(vssran_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssran_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssran_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
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
 
 DEF_HELPER_FLAGS_4(vssrlrn_b_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssrlrn_h_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
@@ -456,22 +456,22 @@ DEF_HELPER_FLAGS_4(vssrarn_bu_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssrarn_hu_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vssrarn_wu_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
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
 
 DEF_HELPER_FLAGS_3(vclo_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(vclo_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
@@ -516,8 +516,8 @@ DEF_HELPER_FLAGS_4(vbitrevi_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_4(vfrstp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vfrstp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_4(vfrstpi_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vfrstpi_h, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vfrstpi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vfrstpi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
 DEF_HELPER_FLAGS_5(vfadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_5(vfadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, env, i32)
@@ -686,14 +686,14 @@ DEF_HELPER_FLAGS_5(vshuf_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vshuf_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vshuf_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vshuf_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_4(vshuf4i_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vshuf4i_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vshuf4i_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vpermi_w, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vpermi_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 
-DEF_HELPER_4(vextrins_b, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_h, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_w, void, env, i32, i32, i32)
-DEF_HELPER_4(vextrins_d, void, env, i32, i32, i32)
+DEF_HELPER_FLAGS_4(vextrins_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(vextrins_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index fd38b47c28..4e10957b90 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -791,22 +791,21 @@ void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t v)
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
 
 void HELPER(vextl_q_d)(void *vd, void *vj, uint32_t desc)
@@ -865,17 +864,16 @@ VSRLR(vsrlr_h, 16, uint16_t, H)
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
@@ -916,17 +914,16 @@ VSRAR(vsrar_h, 16, uint16_t, H)
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
@@ -972,31 +969,29 @@ VSRAN(vsran_b_h, 16, uint16_t, B, H)
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
@@ -1009,31 +1004,29 @@ VSRLNI(vsrlni_b_h, 16, uint16_t, B, H)
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
@@ -1082,31 +1075,29 @@ VSRARN(vsrarn_b_h, 16, uint8_t,  B, H)
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
@@ -1126,31 +1117,29 @@ VSRLRNI(vsrlrni_b_h, 16, B, H)
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
@@ -1336,13 +1325,12 @@ VSSRANU(vssran_hu_w, 32, uint32_t, H, W)
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
@@ -1351,12 +1339,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                     \
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
@@ -1385,13 +1372,12 @@ VSSRLNI(vssrlni_h_w, 32, H, W)
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
@@ -1400,12 +1386,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                      \
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
@@ -1439,13 +1424,12 @@ VSSRANI(vssrani_h_w, 32, H, W)
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
@@ -1454,12 +1438,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                   \
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
@@ -1488,13 +1471,12 @@ VSSRLNUI(vssrlni_hu_w, 32, H, W)
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
@@ -1503,12 +1485,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                   \
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
@@ -1701,13 +1682,12 @@ VSSRARNU(vssrarn_hu_w, 32, uint32_t, H, W)
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
@@ -1717,12 +1697,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                      \
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
@@ -1756,13 +1735,12 @@ VSSRLRNI(vssrlrni_w_d, 64, W, D)
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
@@ -1771,12 +1749,11 @@ void HELPER(NAME)(CPULoongArchState *env,
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
@@ -1814,13 +1791,12 @@ VSSRARNI(vssrarni_h_w, 32, H, W)
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
@@ -1835,13 +1811,12 @@ VSSRLRNUI(vssrlrni_wu_d, 64, W, D)
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
@@ -1850,12 +1825,11 @@ void HELPER(NAME)(CPULoongArchState *env,                                    \
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
@@ -2023,21 +1997,20 @@ void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
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
+#define VFRSTPI(NAME, BIT, E)                                      \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
+{                                                                  \
+    int i, m;                                                      \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+                                                                   \
+    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
+        if (Vj->E(i) < 0) {                                        \
+            break;                                                 \
+        }                                                          \
+    }                                                              \
+    m = imm % (LSX_LEN/BIT);                                       \
+    Vd->E(m) = i;                                                  \
 }
 
 VFRSTPI(vfrstpi_b, 8,  B)
@@ -2923,31 +2896,29 @@ VSHUF(vshuf_h, 16, H)
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
@@ -2955,12 +2926,11 @@ void HELPER(vshuf4i_d)(CPULoongArchState *env,
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
@@ -2969,17 +2939,16 @@ void HELPER(vpermi_w)(CPULoongArchState *env,
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
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index e78c6bba0a..7504e3a62d 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -118,16 +118,20 @@ static bool gen_vv(DisasContext *ctx, arg_vv *a, gen_helper_gvec_2 *fn)
     return gen_vv_vl(ctx, a, 16, fn);
 }
 
-static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a,
-                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
+static bool gen_vv_i_vl(DisasContext *ctx, arg_vv_i *a, uint32_t oprsz,
+                        gen_helper_gvec_2i *fn)
 {
-    TCGv_i32 vd = tcg_constant_i32(a->vd);
-    TCGv_i32 vj = tcg_constant_i32(a->vj);
-    TCGv_i32 imm = tcg_constant_i32(a->imm);
+    tcg_gen_gvec_2i_ool(vec_full_offset(a->vd),
+                        vec_full_offset(a->vj),
+                        tcg_constant_i64(a->imm),
+                        oprsz, ctx->vl / 8, 0, fn);
+    return true;
+}
 
+static bool gen_vv_i(DisasContext *ctx, arg_vv_i *a, gen_helper_gvec_2i *fn)
+{
     CHECK_SXE;
-    func(cpu_env, vd, vj, imm);
-    return true;
+    return gen_vv_i_vl(ctx, a, 16, fn);
 }
 
 static bool gen_cv(DisasContext *ctx, arg_cv *a,
-- 
2.39.1


