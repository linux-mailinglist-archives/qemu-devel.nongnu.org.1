Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A999475357A
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKERs-00027O-Nn; Fri, 14 Jul 2023 04:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERp-0001lF-EG
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERm-0004p5-Eu
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:45 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxxPBmC7FkfM4EAA--.13503S3;
 Fri, 14 Jul 2023 16:46:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S22; 
 Fri, 14 Jul 2023 16:46:29 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 20/47] target/loongarch: Implement xvexth
Date: Fri, 14 Jul 2023 16:45:48 +0800
Message-Id: <20230714084615.2448038-21-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S22
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
 target/loongarch/disas.c                     |  9 +++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  9 +++++
 target/loongarch/insns.decode                |  9 +++++
 target/loongarch/vec_helper.c                | 36 +++++++++++++-------
 4 files changed, 51 insertions(+), 12 deletions(-)

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
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cda617413e..1744521a53 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -313,6 +313,15 @@ TRANS(xvsat_hu, gvec_vv_i, 32, MO_16, do_vsat_u)
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
index 4df39c007e..3b7fcc7283 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -691,32 +691,44 @@ VSAT_U(vsat_hu, 16, UH)
 VSAT_U(vsat_wu, 32, UW)
 VSAT_U(vsat_du, 64, UD)
 
-#define VEXTH(NAME, BIT, E1, E2)                     \
-void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
-{                                                    \
-    int i;                                           \
-    VReg *Vd = (VReg *)vd;                           \
-    VReg *Vj = (VReg *)vj;                           \
-                                                     \
-    for (i = 0; i < LSX_LEN/BIT; i++) {              \
-        Vd->E1(i) = Vj->E2(i + LSX_LEN/BIT);         \
-    }                                                \
+#define VEXTH(NAME, BIT, E1, E2)                                 \
+void HELPER(NAME)(void *vd, void *vj, uint32_t desc)             \
+{                                                                \
+    int i, j, ofs;                                               \
+    VReg *Vd = (VReg *)vd;                                       \
+    VReg *Vj = (VReg *)vj;                                       \
+    int oprsz = simd_oprsz(desc);                                \
+                                                                 \
+    ofs = LSX_LEN / BIT;                                         \
+    for (i = 0; i < oprsz / 16; i++) {                           \
+        for (j = 0; j < ofs; j++) {                              \
+            Vd->E1(j + i * ofs) = Vj->E2(j + ofs + ofs * 2 * i); \
+        }                                                        \
+    }                                                            \
 }
 
 void HELPER(vexth_q_d)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_makes64(Vj->D(1));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_makes64(Vj->D(2 * i + 1));
+    }
 }
 
 void HELPER(vexth_qu_du)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_make64((uint64_t)Vj->D(1));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_make64(Vj->UD(2 * i + 1));
+    }
 }
 
 VEXTH(vexth_h_b, 16, H, B)
-- 
2.39.1


