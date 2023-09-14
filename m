Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B579F829
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc51-0003Ic-BQ; Wed, 13 Sep 2023 22:27:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4k-0003Em-N8
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4h-0004vc-SL
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRvF_bwJlk_gmAA--.9992S3;
 Thu, 14 Sep 2023 10:27:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S32; 
 Thu, 14 Sep 2023 10:27:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 30/57] target/loongarch: Implement vext2xv
Date: Thu, 14 Sep 2023 10:26:18 +0800
Message-Id: <20230914022645.1151356-31-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S32
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

This patch includes:
- VEXT2XV.{H/W/D}.B, VEXT2XV.{HU/WU/DU}.BU;
- VEXT2XV.{W/D}.B, VEXT2XV.{WU/DU}.HU;
- VEXT2XV.D.W, VEXT2XV.DU.WU.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/helper.h                   | 13 ++++++++++
 target/loongarch/insns.decode               | 13 ++++++++++
 target/loongarch/disas.c                    | 13 ++++++++++
 target/loongarch/vec_helper.c               | 28 +++++++++++++++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 13 ++++++++++
 5 files changed, 80 insertions(+)

diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 1abd9e1410..e9c5412267 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -340,6 +340,19 @@ DEF_HELPER_FLAGS_3(vexth_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(vexth_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(vexth_qu_du, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_3(vext2xv_h_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_w_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_d_b, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_w_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_d_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_d_w, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_hu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_wu_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_du_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_wu_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_du_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(vext2xv_du_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(vsigncov_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(vsigncov_w, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 7491f295a5..db1a6689f0 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1580,6 +1580,19 @@ xvexth_wu_hu     0111 01101001 11101 11101 ..... .....    @vv
 xvexth_du_wu     0111 01101001 11101 11110 ..... .....    @vv
 xvexth_qu_du     0111 01101001 11101 11111 ..... .....    @vv
 
+vext2xv_h_b      0111 01101001 11110 00100 ..... .....    @vv
+vext2xv_w_b      0111 01101001 11110 00101 ..... .....    @vv
+vext2xv_d_b      0111 01101001 11110 00110 ..... .....    @vv
+vext2xv_w_h      0111 01101001 11110 00111 ..... .....    @vv
+vext2xv_d_h      0111 01101001 11110 01000 ..... .....    @vv
+vext2xv_d_w      0111 01101001 11110 01001 ..... .....    @vv
+vext2xv_hu_bu    0111 01101001 11110 01010 ..... .....    @vv
+vext2xv_wu_bu    0111 01101001 11110 01011 ..... .....    @vv
+vext2xv_du_bu    0111 01101001 11110 01100 ..... .....    @vv
+vext2xv_wu_hu    0111 01101001 11110 01101 ..... .....    @vv
+vext2xv_du_hu    0111 01101001 11110 01110 ..... .....    @vv
+vext2xv_du_wu    0111 01101001 11110 01111 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d4bea69b61..714b97e238 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1997,6 +1997,19 @@ INSN_LASX(xvexth_wu_hu,      vv)
 INSN_LASX(xvexth_du_wu,      vv)
 INSN_LASX(xvexth_qu_du,      vv)
 
+INSN_LASX(vext2xv_h_b,       vv)
+INSN_LASX(vext2xv_w_b,       vv)
+INSN_LASX(vext2xv_d_b,       vv)
+INSN_LASX(vext2xv_w_h,       vv)
+INSN_LASX(vext2xv_d_h,       vv)
+INSN_LASX(vext2xv_d_w,       vv)
+INSN_LASX(vext2xv_hu_bu,     vv)
+INSN_LASX(vext2xv_wu_bu,     vv)
+INSN_LASX(vext2xv_du_bu,     vv)
+INSN_LASX(vext2xv_wu_hu,     vv)
+INSN_LASX(vext2xv_du_hu,     vv)
+INSN_LASX(vext2xv_du_wu,     vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 2eccbc81a7..3dc20243fd 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -763,6 +763,34 @@ VEXTH(vexth_hu_bu, 16, UH, UB)
 VEXTH(vexth_wu_hu, 32, UW, UH)
 VEXTH(vexth_du_wu, 64, UD, UW)
 
+#define VEXT2XV(NAME, BIT, E1, E2)                   \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
+{                                                    \
+    int i;                                           \
+    VReg temp = {};                                  \
+    VReg *Vd = (VReg *)vd;                           \
+    VReg *Vj = (VReg *)vj;                           \
+    int oprsz = simd_oprsz(desc);                    \
+                                                     \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {        \
+        temp.E1(i) = Vj->E2(i);                      \
+    }                                                \
+    *Vd = temp;                                      \
+}
+
+VEXT2XV(vext2xv_h_b, 16, H, B)
+VEXT2XV(vext2xv_w_b, 32, W, B)
+VEXT2XV(vext2xv_d_b, 64, D, B)
+VEXT2XV(vext2xv_w_h, 32, W, H)
+VEXT2XV(vext2xv_d_h, 64, D, H)
+VEXT2XV(vext2xv_d_w, 64, D, W)
+VEXT2XV(vext2xv_hu_bu, 16, UH, UB)
+VEXT2XV(vext2xv_wu_bu, 32, UW, UB)
+VEXT2XV(vext2xv_du_bu, 64, UD, UB)
+VEXT2XV(vext2xv_wu_hu, 32, UW, UH)
+VEXT2XV(vext2xv_du_hu, 64, UD, UH)
+VEXT2XV(vext2xv_du_wu, 64, UD, UW)
+
 #define DO_SIGNCOV(a, b)  (a == 0 ? 0 : a < 0 ? -b : b)
 
 DO_3OP(vsigncov_b, 8, B, DO_SIGNCOV)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index e002bb05d6..8f21f6b1c4 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -3347,6 +3347,19 @@ TRANS(xvexth_wu_hu, LASX, gen_xx, gen_helper_vexth_wu_hu)
 TRANS(xvexth_du_wu, LASX, gen_xx, gen_helper_vexth_du_wu)
 TRANS(xvexth_qu_du, LASX, gen_xx, gen_helper_vexth_qu_du)
 
+TRANS(vext2xv_h_b, LASX, gen_xx, gen_helper_vext2xv_h_b)
+TRANS(vext2xv_w_b, LASX, gen_xx, gen_helper_vext2xv_w_b)
+TRANS(vext2xv_d_b, LASX, gen_xx, gen_helper_vext2xv_d_b)
+TRANS(vext2xv_w_h, LASX, gen_xx, gen_helper_vext2xv_w_h)
+TRANS(vext2xv_d_h, LASX, gen_xx, gen_helper_vext2xv_d_h)
+TRANS(vext2xv_d_w, LASX, gen_xx, gen_helper_vext2xv_d_w)
+TRANS(vext2xv_hu_bu, LASX, gen_xx, gen_helper_vext2xv_hu_bu)
+TRANS(vext2xv_wu_bu, LASX, gen_xx, gen_helper_vext2xv_wu_bu)
+TRANS(vext2xv_du_bu, LASX, gen_xx, gen_helper_vext2xv_du_bu)
+TRANS(vext2xv_wu_hu, LASX, gen_xx, gen_helper_vext2xv_wu_hu)
+TRANS(vext2xv_du_hu, LASX, gen_xx, gen_helper_vext2xv_du_hu)
+TRANS(vext2xv_du_wu, LASX, gen_xx, gen_helper_vext2xv_du_wu)
+
 static void gen_vsigncov(unsigned vece, TCGv_vec t, TCGv_vec a, TCGv_vec b)
 {
     TCGv_vec t1, zero;
-- 
2.39.1


