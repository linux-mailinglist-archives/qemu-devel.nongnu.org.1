Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F39A736810
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpS-0007IZ-BS; Tue, 20 Jun 2023 05:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp8-0007Cs-3e
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp3-0006Od-5U
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cxd+mcc5Fk1yUHAA--.12763S3;
 Tue, 20 Jun 2023 17:38:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S39; 
 Tue, 20 Jun 2023 17:38:36 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 37/46] target/loongarch: Implement LASX fpu fcvt
 instructions
Date: Tue, 20 Jun 2023 17:38:05 +0800
Message-Id: <20230620093814.123650-38-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S39
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
 target/loongarch/disas.c                     |  56 +++
 target/loongarch/helper.h                    |  56 +++
 target/loongarch/insn_trans/trans_lasx.c.inc |  56 +++
 target/loongarch/insns.decode                |  58 +++
 target/loongarch/lasx_helper.c               | 398 +++++++++++++++++++
 5 files changed, 624 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0e4ec2bd03..65eccc8598 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2285,6 +2285,62 @@ INSN_LASX(xvfrecip_d,        xx)
 INSN_LASX(xvfrsqrt_s,        xx)
 INSN_LASX(xvfrsqrt_d,        xx)
 
+INSN_LASX(xvfcvtl_s_h,       xx)
+INSN_LASX(xvfcvth_s_h,       xx)
+INSN_LASX(xvfcvtl_d_s,       xx)
+INSN_LASX(xvfcvth_d_s,       xx)
+INSN_LASX(xvfcvt_h_s,        xxx)
+INSN_LASX(xvfcvt_s_d,        xxx)
+
+INSN_LASX(xvfrint_s,         xx)
+INSN_LASX(xvfrint_d,         xx)
+INSN_LASX(xvfrintrm_s,       xx)
+INSN_LASX(xvfrintrm_d,       xx)
+INSN_LASX(xvfrintrp_s,       xx)
+INSN_LASX(xvfrintrp_d,       xx)
+INSN_LASX(xvfrintrz_s,       xx)
+INSN_LASX(xvfrintrz_d,       xx)
+INSN_LASX(xvfrintrne_s,      xx)
+INSN_LASX(xvfrintrne_d,      xx)
+
+INSN_LASX(xvftint_w_s,       xx)
+INSN_LASX(xvftint_l_d,       xx)
+INSN_LASX(xvftintrm_w_s,     xx)
+INSN_LASX(xvftintrm_l_d,     xx)
+INSN_LASX(xvftintrp_w_s,     xx)
+INSN_LASX(xvftintrp_l_d,     xx)
+INSN_LASX(xvftintrz_w_s,     xx)
+INSN_LASX(xvftintrz_l_d,     xx)
+INSN_LASX(xvftintrne_w_s,    xx)
+INSN_LASX(xvftintrne_l_d,    xx)
+INSN_LASX(xvftint_wu_s,      xx)
+INSN_LASX(xvftint_lu_d,      xx)
+INSN_LASX(xvftintrz_wu_s,    xx)
+INSN_LASX(xvftintrz_lu_d,    xx)
+INSN_LASX(xvftint_w_d,       xxx)
+INSN_LASX(xvftintrm_w_d,     xxx)
+INSN_LASX(xvftintrp_w_d,     xxx)
+INSN_LASX(xvftintrz_w_d,     xxx)
+INSN_LASX(xvftintrne_w_d,    xxx)
+INSN_LASX(xvftintl_l_s,      xx)
+INSN_LASX(xvftinth_l_s,      xx)
+INSN_LASX(xvftintrml_l_s,    xx)
+INSN_LASX(xvftintrmh_l_s,    xx)
+INSN_LASX(xvftintrpl_l_s,    xx)
+INSN_LASX(xvftintrph_l_s,    xx)
+INSN_LASX(xvftintrzl_l_s,    xx)
+INSN_LASX(xvftintrzh_l_s,    xx)
+INSN_LASX(xvftintrnel_l_s,   xx)
+INSN_LASX(xvftintrneh_l_s,   xx)
+
+INSN_LASX(xvffint_s_w,       xx)
+INSN_LASX(xvffint_s_wu,      xx)
+INSN_LASX(xvffint_d_l,       xx)
+INSN_LASX(xvffint_d_lu,      xx)
+INSN_LASX(xvffintl_d_w,      xx)
+INSN_LASX(xvffinth_d_w,      xx)
+INSN_LASX(xvffint_s_l,       xxx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 2e6e3f2fd3..d30ea7f6a4 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1137,3 +1137,59 @@ DEF_HELPER_3(xvfrecip_s, void, env, i32, i32)
 DEF_HELPER_3(xvfrecip_d, void, env, i32, i32)
 DEF_HELPER_3(xvfrsqrt_s, void, env, i32, i32)
 DEF_HELPER_3(xvfrsqrt_d, void, env, i32, i32)
+
+DEF_HELPER_3(xvfcvtl_s_h, void, env, i32, i32)
+DEF_HELPER_3(xvfcvth_s_h, void, env, i32, i32)
+DEF_HELPER_3(xvfcvtl_d_s, void, env, i32, i32)
+DEF_HELPER_3(xvfcvth_d_s, void, env, i32, i32)
+DEF_HELPER_4(xvfcvt_h_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfcvt_s_d, void, env, i32, i32, i32)
+
+DEF_HELPER_3(xvfrintrne_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrne_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrz_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrz_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrp_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrp_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrm_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrintrm_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrint_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrint_d, void, env, i32, i32)
+
+DEF_HELPER_3(xvftintrne_w_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrne_l_d, void, env, i32, i32)
+DEF_HELPER_3(xvftintrz_w_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrz_l_d, void, env, i32, i32)
+DEF_HELPER_3(xvftintrp_w_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrp_l_d, void, env, i32, i32)
+DEF_HELPER_3(xvftintrm_w_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrm_l_d, void, env, i32, i32)
+DEF_HELPER_3(xvftint_w_s, void, env, i32, i32)
+DEF_HELPER_3(xvftint_l_d, void, env, i32, i32)
+DEF_HELPER_3(xvftintrz_wu_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrz_lu_d, void, env, i32, i32)
+DEF_HELPER_3(xvftint_wu_s, void, env, i32, i32)
+DEF_HELPER_3(xvftint_lu_d, void, env, i32, i32)
+DEF_HELPER_4(xvftintrne_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvftintrz_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvftintrp_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvftintrm_w_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvftint_w_d, void, env, i32, i32, i32)
+DEF_HELPER_3(xvftintrnel_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrneh_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrzl_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrzh_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrpl_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrph_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrml_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintrmh_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftintl_l_s, void, env, i32, i32)
+DEF_HELPER_3(xvftinth_l_s, void, env, i32, i32)
+
+DEF_HELPER_3(xvffint_s_w, void, env, i32, i32)
+DEF_HELPER_3(xvffint_d_l, void, env, i32, i32)
+DEF_HELPER_3(xvffint_s_wu, void, env, i32, i32)
+DEF_HELPER_3(xvffint_d_lu, void, env, i32, i32)
+DEF_HELPER_3(xvffintl_d_w, void, env, i32, i32)
+DEF_HELPER_3(xvffinth_d_w, void, env, i32, i32)
+DEF_HELPER_4(xvffint_s_l, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index b9785be6c5..998c07b358 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2464,6 +2464,62 @@ TRANS(xvfrecip_d, gen_xx, gen_helper_xvfrecip_d)
 TRANS(xvfrsqrt_s, gen_xx, gen_helper_xvfrsqrt_s)
 TRANS(xvfrsqrt_d, gen_xx, gen_helper_xvfrsqrt_d)
 
+TRANS(xvfcvtl_s_h, gen_xx, gen_helper_xvfcvtl_s_h)
+TRANS(xvfcvth_s_h, gen_xx, gen_helper_xvfcvth_s_h)
+TRANS(xvfcvtl_d_s, gen_xx, gen_helper_xvfcvtl_d_s)
+TRANS(xvfcvth_d_s, gen_xx, gen_helper_xvfcvth_d_s)
+TRANS(xvfcvt_h_s, gen_xxx, gen_helper_xvfcvt_h_s)
+TRANS(xvfcvt_s_d, gen_xxx, gen_helper_xvfcvt_s_d)
+
+TRANS(xvfrintrne_s, gen_xx, gen_helper_xvfrintrne_s)
+TRANS(xvfrintrne_d, gen_xx, gen_helper_xvfrintrne_d)
+TRANS(xvfrintrz_s, gen_xx, gen_helper_xvfrintrz_s)
+TRANS(xvfrintrz_d, gen_xx, gen_helper_xvfrintrz_d)
+TRANS(xvfrintrp_s, gen_xx, gen_helper_xvfrintrp_s)
+TRANS(xvfrintrp_d, gen_xx, gen_helper_xvfrintrp_d)
+TRANS(xvfrintrm_s, gen_xx, gen_helper_xvfrintrm_s)
+TRANS(xvfrintrm_d, gen_xx, gen_helper_xvfrintrm_d)
+TRANS(xvfrint_s, gen_xx, gen_helper_xvfrint_s)
+TRANS(xvfrint_d, gen_xx, gen_helper_xvfrint_d)
+
+TRANS(xvftintrne_w_s, gen_xx, gen_helper_xvftintrne_w_s)
+TRANS(xvftintrne_l_d, gen_xx, gen_helper_xvftintrne_l_d)
+TRANS(xvftintrz_w_s, gen_xx, gen_helper_xvftintrz_w_s)
+TRANS(xvftintrz_l_d, gen_xx, gen_helper_xvftintrz_l_d)
+TRANS(xvftintrp_w_s, gen_xx, gen_helper_xvftintrp_w_s)
+TRANS(xvftintrp_l_d, gen_xx, gen_helper_xvftintrp_l_d)
+TRANS(xvftintrm_w_s, gen_xx, gen_helper_xvftintrm_w_s)
+TRANS(xvftintrm_l_d, gen_xx, gen_helper_xvftintrm_l_d)
+TRANS(xvftint_w_s, gen_xx, gen_helper_xvftint_w_s)
+TRANS(xvftint_l_d, gen_xx, gen_helper_xvftint_l_d)
+TRANS(xvftintrz_wu_s, gen_xx, gen_helper_xvftintrz_wu_s)
+TRANS(xvftintrz_lu_d, gen_xx, gen_helper_xvftintrz_lu_d)
+TRANS(xvftint_wu_s, gen_xx, gen_helper_xvftint_wu_s)
+TRANS(xvftint_lu_d, gen_xx, gen_helper_xvftint_lu_d)
+TRANS(xvftintrne_w_d, gen_xxx, gen_helper_xvftintrne_w_d)
+TRANS(xvftintrz_w_d, gen_xxx, gen_helper_xvftintrz_w_d)
+TRANS(xvftintrp_w_d, gen_xxx, gen_helper_xvftintrp_w_d)
+TRANS(xvftintrm_w_d, gen_xxx, gen_helper_xvftintrm_w_d)
+TRANS(xvftint_w_d, gen_xxx, gen_helper_xvftint_w_d)
+TRANS(xvftintrnel_l_s, gen_xx, gen_helper_xvftintrnel_l_s)
+TRANS(xvftintrneh_l_s, gen_xx, gen_helper_xvftintrneh_l_s)
+TRANS(xvftintrzl_l_s, gen_xx, gen_helper_xvftintrzl_l_s)
+TRANS(xvftintrzh_l_s, gen_xx, gen_helper_xvftintrzh_l_s)
+TRANS(xvftintrpl_l_s, gen_xx, gen_helper_xvftintrpl_l_s)
+TRANS(xvftintrph_l_s, gen_xx, gen_helper_xvftintrph_l_s)
+TRANS(xvftintrml_l_s, gen_xx, gen_helper_xvftintrml_l_s)
+TRANS(xvftintrmh_l_s, gen_xx, gen_helper_xvftintrmh_l_s)
+TRANS(xvftintl_l_s, gen_xx, gen_helper_xvftintl_l_s)
+TRANS(xvftinth_l_s, gen_xx, gen_helper_xvftinth_l_s)
+
+TRANS(xvffint_s_w, gen_xx, gen_helper_xvffint_s_w)
+TRANS(xvffint_d_l, gen_xx, gen_helper_xvffint_d_l)
+TRANS(xvffint_s_wu, gen_xx, gen_helper_xvffint_s_wu)
+TRANS(xvffint_d_lu, gen_xx, gen_helper_xvffint_d_lu)
+TRANS(xvffintl_d_w, gen_xx, gen_helper_xvffintl_d_w)
+TRANS(xvffinth_d_w, gen_xx, gen_helper_xvffinth_d_w)
+TRANS(xvffint_s_l, gen_xxx, gen_helper_xvffint_s_l)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 8a5d6a8d45..59b79573e5 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1882,6 +1882,64 @@ xvfrecip_d       0111 01101001 11001 11110 ..... .....    @xx
 xvfrsqrt_s       0111 01101001 11010 00001 ..... .....    @xx
 xvfrsqrt_d       0111 01101001 11010 00010 ..... .....    @xx
 
+xvfcvtl_s_h      0111 01101001 11011 11010 ..... .....    @xx
+xvfcvth_s_h      0111 01101001 11011 11011 ..... .....    @xx
+xvfcvtl_d_s      0111 01101001 11011 11100 ..... .....    @xx
+xvfcvth_d_s      0111 01101001 11011 11101 ..... .....    @xx
+xvfcvt_h_s       0111 01010100 01100 ..... ..... .....    @xxx
+xvfcvt_s_d       0111 01010100 01101 ..... ..... .....    @xxx
+
+xvfrintrne_s     0111 01101001 11010 11101 ..... .....    @xx
+xvfrintrne_d     0111 01101001 11010 11110 ..... .....    @xx
+xvfrintrz_s      0111 01101001 11010 11001 ..... .....    @xx
+xvfrintrz_d      0111 01101001 11010 11010 ..... .....    @xx
+xvfrintrp_s      0111 01101001 11010 10101 ..... .....    @xx
+xvfrintrp_d      0111 01101001 11010 10110 ..... .....    @xx
+xvfrintrm_s      0111 01101001 11010 10001 ..... .....    @xx
+xvfrintrm_d      0111 01101001 11010 10010 ..... .....    @xx
+xvfrint_s        0111 01101001 11010 01101 ..... .....    @xx
+xvfrint_d        0111 01101001 11010 01110 ..... .....    @xx
+
+xvftintrne_w_s   0111 01101001 11100 10100 ..... .....    @xx
+xvftintrne_l_d   0111 01101001 11100 10101 ..... .....    @xx
+xvftintrz_w_s    0111 01101001 11100 10010 ..... .....    @xx
+xvftintrz_l_d    0111 01101001 11100 10011 ..... .....    @xx
+xvftintrp_w_s    0111 01101001 11100 10000 ..... .....    @xx
+xvftintrp_l_d    0111 01101001 11100 10001 ..... .....    @xx
+xvftintrm_w_s    0111 01101001 11100 01110 ..... .....    @xx
+xvftintrm_l_d    0111 01101001 11100 01111 ..... .....    @xx
+xvftint_w_s      0111 01101001 11100 01100 ..... .....    @xx
+xvftint_l_d      0111 01101001 11100 01101 ..... .....    @xx
+xvftintrz_wu_s   0111 01101001 11100 11100 ..... .....    @xx
+xvftintrz_lu_d   0111 01101001 11100 11101 ..... .....    @xx
+xvftint_wu_s     0111 01101001 11100 10110 ..... .....    @xx
+xvftint_lu_d     0111 01101001 11100 10111 ..... .....    @xx
+
+xvftintrne_w_d   0111 01010100 10111 ..... ..... .....    @xxx
+xvftintrz_w_d    0111 01010100 10110 ..... ..... .....    @xxx
+xvftintrp_w_d    0111 01010100 10101 ..... ..... .....    @xxx
+xvftintrm_w_d    0111 01010100 10100 ..... ..... .....    @xxx
+xvftint_w_d      0111 01010100 10011 ..... ..... .....    @xxx
+
+xvftintrnel_l_s  0111 01101001 11101 01000 ..... .....    @xx
+xvftintrneh_l_s  0111 01101001 11101 01001 ..... .....    @xx
+xvftintrzl_l_s   0111 01101001 11101 00110 ..... .....    @xx
+xvftintrzh_l_s   0111 01101001 11101 00111 ..... .....    @xx
+xvftintrpl_l_s   0111 01101001 11101 00100 ..... .....    @xx
+xvftintrph_l_s   0111 01101001 11101 00101 ..... .....    @xx
+xvftintrml_l_s   0111 01101001 11101 00010 ..... .....    @xx
+xvftintrmh_l_s   0111 01101001 11101 00011 ..... .....    @xx
+xvftintl_l_s     0111 01101001 11101 00000 ..... .....    @xx
+xvftinth_l_s     0111 01101001 11101 00001 ..... .....    @xx
+
+xvffint_s_w      0111 01101001 11100 00000 ..... .....    @xx
+xvffint_d_l      0111 01101001 11100 00010 ..... .....    @xx
+xvffint_s_wu     0111 01101001 11100 00001 ..... .....    @xx
+xvffint_d_lu     0111 01101001 11100 00011 ..... .....    @xx
+xvffintl_d_w     0111 01101001 11100 00100 ..... .....    @xx
+xvffinth_d_w     0111 01101001 11100 00101 ..... .....    @xx
+xvffint_s_l      0111 01010100 10000 ..... ..... .....    @xxx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 316ebd3463..5cc917fdc3 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2325,3 +2325,401 @@ XDO_2OP_F(xvfrecip_s, 32, UXW, do_frecip_32)
 XDO_2OP_F(xvfrecip_d, 64, UXD, do_frecip_64)
 XDO_2OP_F(xvfrsqrt_s, 32, UXW, do_frsqrt_32)
 XDO_2OP_F(xvfrsqrt_d, 64, UXD, do_frsqrt_64)
+
+void HELPER(xvfcvtl_s_h)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (32 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXW(i) = float16_to_float32(Xj->UXH(i), true,  &env->fp_status);
+        temp.UXW(i + max) = float16_to_float32(Xj->UXH(i + max * 2),
+                                               true, &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfcvtl_d_s)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXD(i) = float32_to_float64(Xj->UXW(i), &env->fp_status);
+        temp.UXD(i + max) = float32_to_float64(Xj->UXW(i + max * 2),
+                                               &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfcvth_s_h)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (32 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXW(i) = float16_to_float32(Xj->UXH(i + max),
+                                         true,  &env->fp_status);
+        temp.UXW(i + max) = float16_to_float32(Xj->UXH(i + max * 3),
+                                               true,  &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfcvth_d_s)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXD(i) = float32_to_float64(Xj->UXW(i + max), &env->fp_status);
+        temp.UXD(i + max) = float32_to_float64(Xj->UXW(i + max * 3),
+                                               &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfcvt_h_s)(CPULoongArchState *env,
+                        uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    max = LASX_LEN / (32 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXH(i + max) = float32_to_float16(Xj->UXW(i),
+                                               true,  &env->fp_status);
+        temp.UXH(i)  = float32_to_float16(Xk->UXW(i), true,  &env->fp_status);
+        temp.UXH(i + max * 3) = float32_to_float16(Xj->UXW(i + max),
+                                                   true, &env->fp_status);
+        temp.UXH(i + max * 2) = float32_to_float16(Xk->UXW(i + max),
+                                                   true, &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfcvt_s_d)(CPULoongArchState *env,
+                        uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.UXW(i + max) = float64_to_float32(Xj->UXD(i), &env->fp_status);
+        temp.UXW(i)  = float64_to_float32(Xk->UXD(i), &env->fp_status);
+        temp.UXW(i + max * 3) = float64_to_float32(Xj->UXD(i + max),
+                                                   &env->fp_status);
+        temp.UXW(i + max * 2) = float64_to_float32(Xk->UXD(i + max),
+                                                   &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvfrint_s)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    vec_clear_cause(env);
+    for (i = 0; i < LASX_LEN / 32; i++) {
+        Xd->XW(i) = float32_round_to_int(Xj->UXW(i), &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+}
+
+void HELPER(xvfrint_d)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    vec_clear_cause(env);
+    for (i = 0; i < LASX_LEN / 64; i++) {
+        Xd->XD(i) = float64_round_to_int(Xj->UXD(i), &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+}
+
+#define XFCVT_2OP(NAME, BIT, E, MODE)                                       \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj)         \
+{                                                                           \
+    int i;                                                                  \
+    XReg *Xd = &(env->fpr[xd].xreg);                                        \
+    XReg *Xj = &(env->fpr[xj].xreg);                                        \
+                                                                            \
+    vec_clear_cause(env);                                                   \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                                  \
+        FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status); \
+        set_float_rounding_mode(MODE, &env->fp_status);                     \
+        Xd->E(i) = float## BIT ## _round_to_int(Xj->E(i), &env->fp_status); \
+        set_float_rounding_mode(old_mode, &env->fp_status);                 \
+        vec_update_fcsr0(env, GETPC());                                     \
+    }                                                                       \
+}
+
+XFCVT_2OP(xvfrintrne_s, 32, UXW, float_round_nearest_even)
+XFCVT_2OP(xvfrintrne_d, 64, UXD, float_round_nearest_even)
+XFCVT_2OP(xvfrintrz_s, 32, UXW, float_round_to_zero)
+XFCVT_2OP(xvfrintrz_d, 64, UXD, float_round_to_zero)
+XFCVT_2OP(xvfrintrp_s, 32, UXW, float_round_up)
+XFCVT_2OP(xvfrintrp_d, 64, UXD, float_round_up)
+XFCVT_2OP(xvfrintrm_s, 32, UXW, float_round_down)
+XFCVT_2OP(xvfrintrm_d, 64, UXD, float_round_down)
+
+#define XFTINT(NAME, FMT1, FMT2, T1, T2,  MODE)                         \
+static T2 do_xftint ## NAME(CPULoongArchState *env, T1 fj)              \
+{                                                                       \
+    T2 fd;                                                              \
+    FloatRoundMode old_mode = get_float_rounding_mode(&env->fp_status); \
+                                                                        \
+    set_float_rounding_mode(MODE, &env->fp_status);                     \
+    fd = do_## FMT1 ##_to_## FMT2(env, fj);                             \
+    set_float_rounding_mode(old_mode, &env->fp_status);                 \
+    return fd;                                                          \
+}
+
+#define XDO_FTINT(FMT1, FMT2, T1, T2)                                        \
+static T2 do_## FMT1 ##_to_## FMT2(CPULoongArchState *env, T1 fj)            \
+{                                                                            \
+    T2 fd;                                                                   \
+                                                                             \
+    fd = FMT1 ##_to_## FMT2(fj, &env->fp_status);                            \
+    if (get_float_exception_flags(&env->fp_status) & (float_flag_invalid)) { \
+        if (FMT1 ##_is_any_nan(fj)) {                                        \
+            fd = 0;                                                          \
+        }                                                                    \
+    }                                                                        \
+    vec_update_fcsr0(env, GETPC());                                          \
+    return fd;                                                               \
+}
+
+XDO_FTINT(float32, int32, uint32_t, uint32_t)
+XDO_FTINT(float64, int64, uint64_t, uint64_t)
+XDO_FTINT(float32, uint32, uint32_t, uint32_t)
+XDO_FTINT(float64, uint64, uint64_t, uint64_t)
+XDO_FTINT(float64, int32, uint64_t, uint32_t)
+XDO_FTINT(float32, int64, uint32_t, uint64_t)
+
+XFTINT(rne_w_s, float32, int32, uint32_t, uint32_t, float_round_nearest_even)
+XFTINT(rne_l_d, float64, int64, uint64_t, uint64_t, float_round_nearest_even)
+XFTINT(rp_w_s, float32, int32, uint32_t, uint32_t, float_round_up)
+XFTINT(rp_l_d, float64, int64, uint64_t, uint64_t, float_round_up)
+XFTINT(rz_w_s, float32, int32, uint32_t, uint32_t, float_round_to_zero)
+XFTINT(rz_l_d, float64, int64, uint64_t, uint64_t, float_round_to_zero)
+XFTINT(rm_w_s, float32, int32, uint32_t, uint32_t, float_round_down)
+XFTINT(rm_l_d, float64, int64, uint64_t, uint64_t, float_round_down)
+
+XDO_2OP_F(xvftintrne_w_s, 32, UXW, do_xftintrne_w_s)
+XDO_2OP_F(xvftintrne_l_d, 64, UXD, do_xftintrne_l_d)
+XDO_2OP_F(xvftintrp_w_s, 32, UXW, do_xftintrp_w_s)
+XDO_2OP_F(xvftintrp_l_d, 64, UXD, do_xftintrp_l_d)
+XDO_2OP_F(xvftintrz_w_s, 32, UXW, do_xftintrz_w_s)
+XDO_2OP_F(xvftintrz_l_d, 64, UXD, do_xftintrz_l_d)
+XDO_2OP_F(xvftintrm_w_s, 32, UXW, do_xftintrm_w_s)
+XDO_2OP_F(xvftintrm_l_d, 64, UXD, do_xftintrm_l_d)
+XDO_2OP_F(xvftint_w_s, 32, UXW, do_float32_to_int32)
+XDO_2OP_F(xvftint_l_d, 64, UXD, do_float64_to_int64)
+
+XFTINT(rz_wu_s, float32, uint32, uint32_t, uint32_t, float_round_to_zero)
+XFTINT(rz_lu_d, float64, uint64, uint64_t, uint64_t, float_round_to_zero)
+
+XDO_2OP_F(xvftintrz_wu_s, 32, UXW, do_xftintrz_wu_s)
+XDO_2OP_F(xvftintrz_lu_d, 64, UXD, do_xftintrz_lu_d)
+XDO_2OP_F(xvftint_wu_s, 32, UXW, do_float32_to_uint32)
+XDO_2OP_F(xvftint_lu_d, 64, UXD, do_float64_to_uint64)
+
+XFTINT(rm_w_d, float64, int32, uint64_t, uint32_t, float_round_down)
+XFTINT(rp_w_d, float64, int32, uint64_t, uint32_t, float_round_up)
+XFTINT(rz_w_d, float64, int32, uint64_t, uint32_t, float_round_to_zero)
+XFTINT(rne_w_d, float64, int32, uint64_t, uint32_t, float_round_nearest_even)
+
+#define XFTINT_W_D(NAME, FN)                              \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t xk)  \
+{                                                         \
+    int i, max;                                           \
+    XReg temp;                                            \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+    XReg *Xk = &(env->fpr[xk].xreg);                      \
+                                                          \
+    max = LASX_LEN / (64 * 2);                            \
+    vec_clear_cause(env);                                 \
+    for (i = 0; i < max; i++) {                           \
+        temp.XW(i + max) = FN(env, Xj->UXD(i));           \
+        temp.XW(i) = FN(env, Xk->UXD(i));                 \
+        temp.XW(i + max * 3) = FN(env, Xj->UXD(i + max)); \
+        temp.XW(i + max * 2) = FN(env, Xk->UXD(i + max)); \
+    }                                                     \
+    *Xd = temp;                                           \
+}
+
+XFTINT_W_D(xvftint_w_d, do_float64_to_int32)
+XFTINT_W_D(xvftintrm_w_d, do_xftintrm_w_d)
+XFTINT_W_D(xvftintrp_w_d, do_xftintrp_w_d)
+XFTINT_W_D(xvftintrz_w_d, do_xftintrz_w_d)
+XFTINT_W_D(xvftintrne_w_d, do_xftintrne_w_d)
+
+XFTINT(rml_l_s, float32, int64, uint32_t, uint64_t, float_round_down)
+XFTINT(rpl_l_s, float32, int64, uint32_t, uint64_t, float_round_up)
+XFTINT(rzl_l_s, float32, int64, uint32_t, uint64_t, float_round_to_zero)
+XFTINT(rnel_l_s, float32, int64, uint32_t, uint64_t, float_round_nearest_even)
+XFTINT(rmh_l_s, float32, int64, uint32_t, uint64_t, float_round_down)
+XFTINT(rph_l_s, float32, int64, uint32_t, uint64_t, float_round_up)
+XFTINT(rzh_l_s, float32, int64, uint32_t, uint64_t, float_round_to_zero)
+XFTINT(rneh_l_s, float32, int64, uint32_t, uint64_t, float_round_nearest_even)
+
+#define XFTINTL_L_S(NAME, FN)                                       \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i, max;                                                     \
+    XReg temp;                                                      \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    max = LASX_LEN / (64 * 2);                                      \
+    vec_clear_cause(env);                                           \
+    for (i = 0; i < max; i++) {                                     \
+        temp.XD(i) = FN(env, Xj->UXW(i));                           \
+        temp.XD(i + max) = FN(env, Xj->UXW(i + max * 2));           \
+    }                                                               \
+    *Xd = temp;                                                     \
+}
+
+XFTINTL_L_S(xvftintl_l_s, do_float32_to_int64)
+XFTINTL_L_S(xvftintrml_l_s, do_xftintrml_l_s)
+XFTINTL_L_S(xvftintrpl_l_s, do_xftintrpl_l_s)
+XFTINTL_L_S(xvftintrzl_l_s, do_xftintrzl_l_s)
+XFTINTL_L_S(xvftintrnel_l_s, do_xftintrnel_l_s)
+
+#define XFTINTH_L_S(NAME, FN)                                       \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i, max;                                                     \
+    XReg temp;                                                      \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    max = LASX_LEN / (64 * 2);                                      \
+    vec_clear_cause(env);                                           \
+    for (i = 0; i < max; i++) {                                     \
+        temp.XD(i) = FN(env, Xj->UXW(i + max));                     \
+        temp.XD(i + max) = FN(env, Xj->UXW(i + max * 3));           \
+    }                                                               \
+    *Xd = temp;                                                     \
+}
+
+XFTINTH_L_S(xvftinth_l_s, do_float32_to_int64)
+XFTINTH_L_S(xvftintrmh_l_s, do_xftintrmh_l_s)
+XFTINTH_L_S(xvftintrph_l_s, do_xftintrph_l_s)
+XFTINTH_L_S(xvftintrzh_l_s, do_xftintrzh_l_s)
+XFTINTH_L_S(xvftintrneh_l_s, do_xftintrneh_l_s)
+
+#define XFFINT(NAME, FMT1, FMT2, T1, T2)                    \
+static T2 do_xffint_ ## NAME(CPULoongArchState *env, T1 fj) \
+{                                                           \
+    T2 fd;                                                  \
+                                                            \
+    fd = FMT1 ##_to_## FMT2(fj, &env->fp_status);           \
+    vec_update_fcsr0(env, GETPC());                         \
+    return fd;                                              \
+}
+
+XFFINT(s_w, int32, float32, int32_t, uint32_t)
+XFFINT(d_l, int64, float64, int64_t, uint64_t)
+XFFINT(s_wu, uint32, float32, uint32_t, uint32_t)
+XFFINT(d_lu, uint64, float64, uint64_t, uint64_t)
+
+XDO_2OP_F(xvffint_s_w, 32, XW, do_xffint_s_w)
+XDO_2OP_F(xvffint_d_l, 64, XD, do_xffint_d_l)
+XDO_2OP_F(xvffint_s_wu, 32, UXW, do_xffint_s_wu)
+XDO_2OP_F(xvffint_d_lu, 64, UXD, do_xffint_d_lu)
+
+void HELPER(xvffintl_d_w)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.XD(i) = int32_to_float64(Xj->XW(i), &env->fp_status);
+        temp.XD(i + max) = int32_to_float64(Xj->XW(i + max * 2),
+                                            &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvffinth_d_w)(CPULoongArchState *env, uint32_t xd, uint32_t xj)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.XD(i) = int32_to_float64(Xj->XW(i + max), &env->fp_status);
+        temp.XD(i + max) = int32_to_float64(Xj->XW(i + max * 3),
+                                            &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
+
+void HELPER(xvffint_s_l)(CPULoongArchState *env,
+                         uint32_t xd, uint32_t xj, uint32_t xk)
+{
+    int i, max;
+    XReg temp;
+    XReg *Xd = &(env->fpr[xd].xreg);
+    XReg *Xj = &(env->fpr[xj].xreg);
+    XReg *Xk = &(env->fpr[xk].xreg);
+
+    max = LASX_LEN / (64 * 2);
+    vec_clear_cause(env);
+    for (i = 0; i < max; i++) {
+        temp.XW(i + max) = int64_to_float32(Xj->XD(i), &env->fp_status);
+        temp.XW(i) = int64_to_float32(Xk->XD(i), &env->fp_status);
+        temp.XW(i + max * 3) = int64_to_float32(Xj->XD(i + max), &env->fp_status);
+        temp.XW(i + max * 2) = int64_to_float32(Xk->XD(i + max), &env->fp_status);
+        vec_update_fcsr0(env, GETPC());
+    }
+    *Xd = temp;
+}
-- 
2.39.1


