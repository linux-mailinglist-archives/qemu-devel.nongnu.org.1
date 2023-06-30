Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6F743658
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF92p-0008NE-Kc; Fri, 30 Jun 2023 03:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF92h-0008H1-CQ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF92d-00082s-8N
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 03:59:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxkfFii55kpjQEAA--.6813S3;
 Fri, 30 Jun 2023 15:59:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S39; 
 Fri, 30 Jun 2023 15:59:29 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 37/46] target/loongarch: Implement LASX fpu fcvt
 instructions
Date: Fri, 30 Jun 2023 15:58:55 +0800
Message-Id: <20230630075904.45940-38-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S39
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
- XVFCVT{L/H}.{S.H/D.S};
- XVFCVT.{H.S/S.D};
- XVFRINT[{RNE/RZ/RP/RM}].{S/D};
- XVFTINT[{RNE/RZ/RP/RM}].{W.S/L.D};
- XVFTINT[RZ].{WU.S/LU.D};
- XVFTINT[{RNE/RZ/RP/RM}].W.D;
- XVFTINT[{RNE/RZ/RP/RM}]{L/H}.L.S;
- XVFFINT.{S.W/D.L}[U];
- X[CVFFINT.S.L, VFFINT{L/H}.D.W.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  56 +++++
 target/loongarch/helper.h                    | 110 ++++-----
 target/loongarch/insn_trans/trans_lasx.c.inc |  56 +++++
 target/loongarch/insns.decode                |  58 +++++
 target/loongarch/vec_helper.c                | 246 ++++++++++++-------
 5 files changed, 387 insertions(+), 139 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 4af74f1ae9..3fd3dc3591 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2286,6 +2286,62 @@ INSN_LASX(xvfrecip_d,        vv)
 INSN_LASX(xvfrsqrt_s,        vv)
 INSN_LASX(xvfrsqrt_d,        vv)
 
+INSN_LASX(xvfcvtl_s_h,       vv)
+INSN_LASX(xvfcvth_s_h,       vv)
+INSN_LASX(xvfcvtl_d_s,       vv)
+INSN_LASX(xvfcvth_d_s,       vv)
+INSN_LASX(xvfcvt_h_s,        vvv)
+INSN_LASX(xvfcvt_s_d,        vvv)
+
+INSN_LASX(xvfrint_s,         vv)
+INSN_LASX(xvfrint_d,         vv)
+INSN_LASX(xvfrintrm_s,       vv)
+INSN_LASX(xvfrintrm_d,       vv)
+INSN_LASX(xvfrintrp_s,       vv)
+INSN_LASX(xvfrintrp_d,       vv)
+INSN_LASX(xvfrintrz_s,       vv)
+INSN_LASX(xvfrintrz_d,       vv)
+INSN_LASX(xvfrintrne_s,      vv)
+INSN_LASX(xvfrintrne_d,      vv)
+
+INSN_LASX(xvftint_w_s,       vv)
+INSN_LASX(xvftint_l_d,       vv)
+INSN_LASX(xvftintrm_w_s,     vv)
+INSN_LASX(xvftintrm_l_d,     vv)
+INSN_LASX(xvftintrp_w_s,     vv)
+INSN_LASX(xvftintrp_l_d,     vv)
+INSN_LASX(xvftintrz_w_s,     vv)
+INSN_LASX(xvftintrz_l_d,     vv)
+INSN_LASX(xvftintrne_w_s,    vv)
+INSN_LASX(xvftintrne_l_d,    vv)
+INSN_LASX(xvftint_wu_s,      vv)
+INSN_LASX(xvftint_lu_d,      vv)
+INSN_LASX(xvftintrz_wu_s,    vv)
+INSN_LASX(xvftintrz_lu_d,    vv)
+INSN_LASX(xvftint_w_d,       vvv)
+INSN_LASX(xvftintrm_w_d,     vvv)
+INSN_LASX(xvftintrp_w_d,     vvv)
+INSN_LASX(xvftintrz_w_d,     vvv)
+INSN_LASX(xvftintrne_w_d,    vvv)
+INSN_LASX(xvftintl_l_s,      vv)
+INSN_LASX(xvftinth_l_s,      vv)
+INSN_LASX(xvftintrml_l_s,    vv)
+INSN_LASX(xvftintrmh_l_s,    vv)
+INSN_LASX(xvftintrpl_l_s,    vv)
+INSN_LASX(xvftintrph_l_s,    vv)
+INSN_LASX(xvftintrzl_l_s,    vv)
+INSN_LASX(xvftintrzh_l_s,    vv)
+INSN_LASX(xvftintrnel_l_s,   vv)
+INSN_LASX(xvftintrneh_l_s,   vv)
+
+INSN_LASX(xvffint_s_w,       vv)
+INSN_LASX(xvffint_s_wu,      vv)
+INSN_LASX(xvffint_d_l,       vv)
+INSN_LASX(xvffint_d_lu,      vv)
+INSN_LASX(xvffintl_d_w,      vv)
+INSN_LASX(xvffinth_d_w,      vv)
+INSN_LASX(xvffint_s_l,       vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 9c9462c886..d662b54233 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -572,61 +572,61 @@ DEF_HELPER_4(vfrecip_d, void, env, i32, i32, i32)
 DEF_HELPER_4(vfrsqrt_s, void, env, i32, i32, i32)
 DEF_HELPER_4(vfrsqrt_d, void, env, i32, i32, i32)
 
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
+DEF_HELPER_4(vfcvtl_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vfcvth_s_h, void, env, i32, i32, i32)
+DEF_HELPER_4(vfcvtl_d_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfcvth_d_s, void, env, i32, i32, i32)
+DEF_HELPER_5(vfcvt_h_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfcvt_s_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_4(vfrintrne_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrne_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrz_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrz_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrp_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrp_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrm_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrintrm_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrint_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrint_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(vftintrne_w_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrne_l_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrz_w_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrz_l_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrp_w_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrp_l_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrm_w_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrm_l_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftint_w_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftint_l_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrz_wu_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrz_lu_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vftint_wu_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftint_lu_d, void, env, i32, i32, i32)
+DEF_HELPER_5(vftintrne_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vftintrz_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vftintrp_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vftintrm_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vftint_w_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_4(vftintrnel_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrneh_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrzl_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrzh_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrpl_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrph_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrml_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintrmh_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftintl_l_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vftinth_l_s, void, env, i32, i32, i32)
+
+DEF_HELPER_4(vffint_s_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vffint_d_l, void, env, i32, i32, i32)
+DEF_HELPER_4(vffint_s_wu, void, env, i32, i32, i32)
+DEF_HELPER_4(vffint_d_lu, void, env, i32, i32, i32)
+DEF_HELPER_4(vffintl_d_w, void, env, i32, i32, i32)
+DEF_HELPER_4(vffinth_d_w, void, env, i32, i32, i32)
+DEF_HELPER_5(vffint_s_l, void, env, i32, i32, i32, i32)
 
 DEF_HELPER_FLAGS_4(vseqi_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
 DEF_HELPER_FLAGS_4(vseqi_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index f05092572d..9fe530eaf8 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -659,6 +659,62 @@ TRANS(xvfrecip_d, gen_vv, 32, gen_helper_vfrecip_d)
 TRANS(xvfrsqrt_s, gen_vv, 32, gen_helper_vfrsqrt_s)
 TRANS(xvfrsqrt_d, gen_vv, 32, gen_helper_vfrsqrt_d)
 
+TRANS(xvfcvtl_s_h, gen_vv, 32, gen_helper_vfcvtl_s_h)
+TRANS(xvfcvth_s_h, gen_vv, 32, gen_helper_vfcvth_s_h)
+TRANS(xvfcvtl_d_s, gen_vv, 32, gen_helper_vfcvtl_d_s)
+TRANS(xvfcvth_d_s, gen_vv, 32, gen_helper_vfcvth_d_s)
+TRANS(xvfcvt_h_s, gen_vvv, 32, gen_helper_vfcvt_h_s)
+TRANS(xvfcvt_s_d, gen_vvv, 32, gen_helper_vfcvt_s_d)
+
+TRANS(xvfrintrne_s, gen_vv, 32, gen_helper_vfrintrne_s)
+TRANS(xvfrintrne_d, gen_vv, 32, gen_helper_vfrintrne_d)
+TRANS(xvfrintrz_s, gen_vv, 32, gen_helper_vfrintrz_s)
+TRANS(xvfrintrz_d, gen_vv, 32, gen_helper_vfrintrz_d)
+TRANS(xvfrintrp_s, gen_vv, 32, gen_helper_vfrintrp_s)
+TRANS(xvfrintrp_d, gen_vv, 32, gen_helper_vfrintrp_d)
+TRANS(xvfrintrm_s, gen_vv, 32, gen_helper_vfrintrm_s)
+TRANS(xvfrintrm_d, gen_vv, 32, gen_helper_vfrintrm_d)
+TRANS(xvfrint_s, gen_vv, 32, gen_helper_vfrint_s)
+TRANS(xvfrint_d, gen_vv, 32, gen_helper_vfrint_d)
+
+TRANS(xvftintrne_w_s, gen_vv, 32, gen_helper_vftintrne_w_s)
+TRANS(xvftintrne_l_d, gen_vv, 32, gen_helper_vftintrne_l_d)
+TRANS(xvftintrz_w_s, gen_vv, 32, gen_helper_vftintrz_w_s)
+TRANS(xvftintrz_l_d, gen_vv, 32, gen_helper_vftintrz_l_d)
+TRANS(xvftintrp_w_s, gen_vv, 32, gen_helper_vftintrp_w_s)
+TRANS(xvftintrp_l_d, gen_vv, 32, gen_helper_vftintrp_l_d)
+TRANS(xvftintrm_w_s, gen_vv, 32, gen_helper_vftintrm_w_s)
+TRANS(xvftintrm_l_d, gen_vv, 32, gen_helper_vftintrm_l_d)
+TRANS(xvftint_w_s, gen_vv, 32, gen_helper_vftint_w_s)
+TRANS(xvftint_l_d, gen_vv, 32, gen_helper_vftint_l_d)
+TRANS(xvftintrz_wu_s, gen_vv, 32, gen_helper_vftintrz_wu_s)
+TRANS(xvftintrz_lu_d, gen_vv, 32, gen_helper_vftintrz_lu_d)
+TRANS(xvftint_wu_s, gen_vv, 32, gen_helper_vftint_wu_s)
+TRANS(xvftint_lu_d, gen_vv, 32, gen_helper_vftint_lu_d)
+TRANS(xvftintrne_w_d, gen_vvv, 32, gen_helper_vftintrne_w_d)
+TRANS(xvftintrz_w_d, gen_vvv, 32, gen_helper_vftintrz_w_d)
+TRANS(xvftintrp_w_d, gen_vvv, 32, gen_helper_vftintrp_w_d)
+TRANS(xvftintrm_w_d, gen_vvv, 32, gen_helper_vftintrm_w_d)
+TRANS(xvftint_w_d, gen_vvv, 32, gen_helper_vftint_w_d)
+TRANS(xvftintrnel_l_s, gen_vv, 32, gen_helper_vftintrnel_l_s)
+TRANS(xvftintrneh_l_s, gen_vv, 32, gen_helper_vftintrneh_l_s)
+TRANS(xvftintrzl_l_s, gen_vv, 32, gen_helper_vftintrzl_l_s)
+TRANS(xvftintrzh_l_s, gen_vv, 32, gen_helper_vftintrzh_l_s)
+TRANS(xvftintrpl_l_s, gen_vv, 32, gen_helper_vftintrpl_l_s)
+TRANS(xvftintrph_l_s, gen_vv, 32, gen_helper_vftintrph_l_s)
+TRANS(xvftintrml_l_s, gen_vv, 32, gen_helper_vftintrml_l_s)
+TRANS(xvftintrmh_l_s, gen_vv, 32, gen_helper_vftintrmh_l_s)
+TRANS(xvftintl_l_s, gen_vv, 32, gen_helper_vftintl_l_s)
+TRANS(xvftinth_l_s, gen_vv, 32, gen_helper_vftinth_l_s)
+
+TRANS(xvffint_s_w, gen_vv, 32, gen_helper_vffint_s_w)
+TRANS(xvffint_d_l, gen_vv, 32, gen_helper_vffint_d_l)
+TRANS(xvffint_s_wu, gen_vv, 32, gen_helper_vffint_s_wu)
+TRANS(xvffint_d_lu, gen_vv, 32, gen_helper_vffint_d_lu)
+TRANS(xvffintl_d_w, gen_vv, 32, gen_helper_vffintl_d_w)
+TRANS(xvffinth_d_w, gen_vv, 32, gen_helper_vffinth_d_w)
+TRANS(xvffint_s_l, gen_vvv, 32, gen_helper_vffint_s_l)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 4224b0a4b1..ed4f82e7fe 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1857,6 +1857,64 @@ xvfrecip_d       0111 01101001 11001 11110 ..... .....    @vv
 xvfrsqrt_s       0111 01101001 11010 00001 ..... .....    @vv
 xvfrsqrt_d       0111 01101001 11010 00010 ..... .....    @vv
 
+xvfcvtl_s_h      0111 01101001 11011 11010 ..... .....    @vv
+xvfcvth_s_h      0111 01101001 11011 11011 ..... .....    @vv
+xvfcvtl_d_s      0111 01101001 11011 11100 ..... .....    @vv
+xvfcvth_d_s      0111 01101001 11011 11101 ..... .....    @vv
+xvfcvt_h_s       0111 01010100 01100 ..... ..... .....    @vvv
+xvfcvt_s_d       0111 01010100 01101 ..... ..... .....    @vvv
+
+xvfrintrne_s     0111 01101001 11010 11101 ..... .....    @vv
+xvfrintrne_d     0111 01101001 11010 11110 ..... .....    @vv
+xvfrintrz_s      0111 01101001 11010 11001 ..... .....    @vv
+xvfrintrz_d      0111 01101001 11010 11010 ..... .....    @vv
+xvfrintrp_s      0111 01101001 11010 10101 ..... .....    @vv
+xvfrintrp_d      0111 01101001 11010 10110 ..... .....    @vv
+xvfrintrm_s      0111 01101001 11010 10001 ..... .....    @vv
+xvfrintrm_d      0111 01101001 11010 10010 ..... .....    @vv
+xvfrint_s        0111 01101001 11010 01101 ..... .....    @vv
+xvfrint_d        0111 01101001 11010 01110 ..... .....    @vv
+
+xvftintrne_w_s   0111 01101001 11100 10100 ..... .....    @vv
+xvftintrne_l_d   0111 01101001 11100 10101 ..... .....    @vv
+xvftintrz_w_s    0111 01101001 11100 10010 ..... .....    @vv
+xvftintrz_l_d    0111 01101001 11100 10011 ..... .....    @vv
+xvftintrp_w_s    0111 01101001 11100 10000 ..... .....    @vv
+xvftintrp_l_d    0111 01101001 11100 10001 ..... .....    @vv
+xvftintrm_w_s    0111 01101001 11100 01110 ..... .....    @vv
+xvftintrm_l_d    0111 01101001 11100 01111 ..... .....    @vv
+xvftint_w_s      0111 01101001 11100 01100 ..... .....    @vv
+xvftint_l_d      0111 01101001 11100 01101 ..... .....    @vv
+xvftintrz_wu_s   0111 01101001 11100 11100 ..... .....    @vv
+xvftintrz_lu_d   0111 01101001 11100 11101 ..... .....    @vv
+xvftint_wu_s     0111 01101001 11100 10110 ..... .....    @vv
+xvftint_lu_d     0111 01101001 11100 10111 ..... .....    @vv
+
+xvftintrne_w_d   0111 01010100 10111 ..... ..... .....    @vvv
+xvftintrz_w_d    0111 01010100 10110 ..... ..... .....    @vvv
+xvftintrp_w_d    0111 01010100 10101 ..... ..... .....    @vvv
+xvftintrm_w_d    0111 01010100 10100 ..... ..... .....    @vvv
+xvftint_w_d      0111 01010100 10011 ..... ..... .....    @vvv
+
+xvftintrnel_l_s  0111 01101001 11101 01000 ..... .....    @vv
+xvftintrneh_l_s  0111 01101001 11101 01001 ..... .....    @vv
+xvftintrzl_l_s   0111 01101001 11101 00110 ..... .....    @vv
+xvftintrzh_l_s   0111 01101001 11101 00111 ..... .....    @vv
+xvftintrpl_l_s   0111 01101001 11101 00100 ..... .....    @vv
+xvftintrph_l_s   0111 01101001 11101 00101 ..... .....    @vv
+xvftintrml_l_s   0111 01101001 11101 00010 ..... .....    @vv
+xvftintrmh_l_s   0111 01101001 11101 00011 ..... .....    @vv
+xvftintl_l_s     0111 01101001 11101 00000 ..... .....    @vv
+xvftinth_l_s     0111 01101001 11101 00001 ..... .....    @vv
+
+xvffint_s_w      0111 01101001 11100 00000 ..... .....    @vv
+xvffint_d_l      0111 01101001 11100 00010 ..... .....    @vv
+xvffint_s_wu     0111 01101001 11100 00001 ..... .....    @vv
+xvffint_d_lu     0111 01101001 11100 00011 ..... .....    @vv
+xvffintl_d_w     0111 01101001 11100 00100 ..... .....    @vv
+xvffinth_d_w     0111 01101001 11100 00101 ..... .....    @vv
+xvffint_s_l      0111 01010100 10000 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 1ab864480c..f07ef30b51 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2655,137 +2655,181 @@ static uint32_t float64_cvt_float32(uint64_t d, float_status *status)
     return float64_to_float32(d, status);
 }
 
-void HELPER(vfcvtl_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_s_h)(CPULoongArchState *env,
+                        uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 32;
     vec_clear_cause(env);
-    for (i = 0; i < LSX_LEN/32; i++) {
+    for (i = 0; i < max; i++) {
         temp.UW(i) = float16_cvt_float32(Vj->UH(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UW(i + max) =float16_cvt_float32(Vj->UH(i + max * 2),
+                                                   &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfcvtl_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvtl_d_s)(CPULoongArchState *env,
+                        uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for (i = 0; i < LSX_LEN/64; i++) {
+    for (i = 0; i < max; i++) {
         temp.UD(i) = float32_cvt_float64(Vj->UW(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UD(i + max) = float32_cvt_float64(Vj->UW(i + max * 2),
+                                                   &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfcvth_s_h)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_s_h)(CPULoongArchState *env,
+                        uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 32;
     vec_clear_cause(env);
-    for (i = 0; i < LSX_LEN/32; i++) {
-        temp.UW(i) = float16_cvt_float32(Vj->UH(i + 4), &env->fp_status);
+    for (i = 0; i < max; i++) {
+        temp.UW(i) = float16_cvt_float32(Vj->UH(i + max), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UW(i + max) = float16_cvt_float32(Vj->UH(i + max * 3),
+                                                   &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfcvth_d_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfcvth_d_s)(CPULoongArchState *env,
+                        uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for (i = 0; i < LSX_LEN/64; i++) {
-        temp.UD(i) = float32_cvt_float64(Vj->UW(i + 2), &env->fp_status);
+    for (i = 0; i < max; i++) {
+        temp.UD(i) = float32_cvt_float64(Vj->UW(i + max), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UD(i + max) = float32_cvt_float64(Vj->UW(i + max * 3),
+                                                   &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfcvt_h_s)(CPULoongArchState *env,
+void HELPER(vfcvt_h_s)(CPULoongArchState *env, uint32_t oprsz,
                        uint32_t vd, uint32_t vj, uint32_t vk)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
     VReg *Vk = &(env->fpr[vk].vreg);
 
+    max = LSX_LEN / 32;
     vec_clear_cause(env);
-    for(i = 0; i < LSX_LEN/32; i++) {
-        temp.UH(i + 4) = float32_cvt_float16(Vj->UW(i), &env->fp_status);
+    for(i = 0; i < max; i++) {
+        temp.UH(i + max) = float32_cvt_float16(Vj->UW(i), &env->fp_status);
         temp.UH(i)  = float32_cvt_float16(Vk->UW(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UH(i + max * 3) = float32_cvt_float16(Vj->UW(i + max),
+                                                       &env->fp_status);
+            temp.UH(i + max * 2) = float32_cvt_float16(Vk->UW(i + max),
+                                                       &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfcvt_s_d)(CPULoongArchState *env,
+void HELPER(vfcvt_s_d)(CPULoongArchState *env, uint32_t oprsz,
                        uint32_t vd, uint32_t vj, uint32_t vk)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
     VReg *Vk = &(env->fpr[vk].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for(i = 0; i < LSX_LEN/64; i++) {
-        temp.UW(i + 2) = float64_cvt_float32(Vj->UD(i), &env->fp_status);
+    for(i = 0; i < max; i++) {
+        temp.UW(i + max) = float64_cvt_float32(Vj->UD(i), &env->fp_status);
         temp.UW(i)  = float64_cvt_float32(Vk->UD(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.UW(i + max * 3) = float64_cvt_float32(Vj->UD(i + max),
+                                                       &env->fp_status);
+            temp.UW(i + max * 2) = float64_cvt_float32(Vk->UD(i + max),
+                                                       &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vfrint_s)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfrint_s)(CPULoongArchState *env,
+                      uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, len;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;
     vec_clear_cause(env);
-    for (i = 0; i < 4; i++) {
+    for (i = 0; i < len / 32; i++) {
         Vd->W(i) = float32_round_to_int(Vj->UW(i), &env->fp_status);
         vec_update_fcsr0(env, GETPC());
     }
 }
 
-void HELPER(vfrint_d)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vfrint_d)(CPULoongArchState *env,
+                      uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, len;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;
     vec_clear_cause(env);
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < len / 64; i++) {
         Vd->D(i) = float64_round_to_int(Vj->UD(i), &env->fp_status);
         vec_update_fcsr0(env, GETPC());
     }
 }
 
 #define FCVT_2OP(NAME, BIT, E, MODE)                                        \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj)         \
+void HELPER(NAME)(CPULoongArchState *env,                                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj)                 \
 {                                                                           \
-    int i;                                                                  \
+    int i, len;                                                             \
     VReg *Vd = &(env->fpr[vd].vreg);                                        \
     VReg *Vj = &(env->fpr[vj].vreg);                                        \
                                                                             \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                               \
     vec_clear_cause(env);                                                   \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                     \
+    for (i = 0; i < len / BIT; i++) {                                       \
         FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status); \
         set_float_rounding_mode(MODE, &env->fp_status);                     \
         Vd->E(i) = float## BIT ## _round_to_int(Vj->E(i), &env->fp_status); \
@@ -2870,22 +2914,27 @@ FTINT(rp_w_d, float64, int32, uint64_t, uint32_t, float_round_up)
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
+#define FTINT_W_D(NAME, FN)                                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,   \
+                  uint32_t vd, uint32_t vj, uint32_t vk)    \
+{                                                           \
+    int i, max;                                             \
+    VReg temp;                                              \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+    VReg *Vk = &(env->fpr[vk].vreg);                        \
+                                                            \
+    max = LSX_LEN / 64;                                     \
+    vec_clear_cause(env);                                   \
+    for (i = 0; i < max; i++) {                             \
+        temp.W(i + max) = FN(env, Vj->UD(i));               \
+        temp.W(i) = FN(env, Vk->UD(i));                     \
+        if (oprsz == 32) {                                  \
+            temp.W(i + max * 3) = FN(env, Vj->UD(i + max)); \
+            temp.W(i + max * 2) = FN(env, Vk->UD(i + max)); \
+        }                                                   \
+    }                                                       \
+    *Vd = temp;                                             \
 }
 
 FTINT_W_D(vftint_w_d, do_float64_to_int32)
@@ -2903,19 +2952,24 @@ FTINT(rph_l_s, float32, int64, uint32_t, uint64_t, float_round_up)
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
+#define FTINTL_L_S(NAME, FN)                                \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
+{                                                           \
+    int i, max;                                             \
+    VReg temp;                                              \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    max = LSX_LEN / 64;                                     \
+    vec_clear_cause(env);                                   \
+    for (i = 0; i < max; i++) {                             \
+        temp.D(i) = FN(env, Vj->UW(i));                     \
+        if (oprsz == 32) {                                  \
+            temp.D(i + max) = FN(env, Vj->UW(i + max * 2)); \
+        }                                                   \
+    }                                                       \
+    *Vd = temp;                                             \
 }
 
 FTINTL_L_S(vftintl_l_s, do_float32_to_int64)
@@ -2924,19 +2978,24 @@ FTINTL_L_S(vftintrpl_l_s, do_ftintrpl_l_s)
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
+#define FTINTH_L_S(NAME, FN)                                \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
+{                                                           \
+    int i, max;                                             \
+    VReg temp;                                              \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    max = LSX_LEN / 64;                                     \
+    vec_clear_cause(env);                                   \
+    for (i = 0; i < max; i++) {                             \
+        temp.D(i) = FN(env, Vj->UW(i + max));               \
+        if (oprsz == 32) {                                  \
+            temp.D(i + max) = FN(env, Vj->UW(i + max * 3)); \
+        }                                                   \
+    }                                                       \
+    *Vd = temp;                                             \
 }
 
 FTINTH_L_S(vftinth_l_s, do_float32_to_int64)
@@ -2965,49 +3024,68 @@ DO_2OP_F(vffint_d_l, 64, D, do_ffint_d_l)
 DO_2OP_F(vffint_s_wu, 32, UW, do_ffint_s_wu)
 DO_2OP_F(vffint_d_lu, 64, UD, do_ffint_d_lu)
 
-void HELPER(vffintl_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffintl_d_w)(CPULoongArchState *env,
+                         uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < max; i++) {
         temp.D(i) = int32_to_float64(Vj->W(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.D(i + max) = int32_to_float64(Vj->W(i + max * 2),
+                                               &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
-void HELPER(vffinth_d_w)(CPULoongArchState *env, uint32_t vd, uint32_t vj)
+void HELPER(vffinth_d_w)(CPULoongArchState *env,
+                         uint32_t oprsz, uint32_t vd, uint32_t vj)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for (i = 0; i < 2; i++) {
-        temp.D(i) = int32_to_float64(Vj->W(i + 2), &env->fp_status);
+    for (i = 0; i < max; i++) {
+        temp.D(i) = int32_to_float64(Vj->W(i + max), &env->fp_status);
+        if (oprsz == 32) {
+            temp.D(i + max) = int32_to_float64(Vj->W(i + max * 3),
+                                               &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
 }
 
 void HELPER(vffint_s_l)(CPULoongArchState *env,
-                        uint32_t vd, uint32_t vj, uint32_t vk)
+                        uint32_t oprsz, uint32_t vd, uint32_t vj, uint32_t vk)
 {
-    int i;
+    int i, max;
     VReg temp;
     VReg *Vd = &(env->fpr[vd].vreg);
     VReg *Vj = &(env->fpr[vj].vreg);
     VReg *Vk = &(env->fpr[vk].vreg);
 
+    max = LSX_LEN / 64;
     vec_clear_cause(env);
-    for (i = 0; i < 2; i++) {
-        temp.W(i + 2) = int64_to_float32(Vj->D(i), &env->fp_status);
+    for (i = 0; i < max; i++) {
+        temp.W(i + max) = int64_to_float32(Vj->D(i), &env->fp_status);
         temp.W(i) = int64_to_float32(Vk->D(i), &env->fp_status);
+        if (oprsz == 32) {
+            temp.W(i + max * 3) = int64_to_float32(Vj->D(i + max),
+                                                   &env->fp_status);
+            temp.W(i + max * 2) = int64_to_float32(Vk->D(i + max),
+                                                   &env->fp_status);
+        }
         vec_update_fcsr0(env, GETPC());
     }
     *Vd = temp;
-- 
2.39.1


