Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D070E78D454
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:53:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGvM-00023t-Hy; Wed, 30 Aug 2023 04:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGvJ-0001nI-V5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:51:37 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGvH-00087B-4J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:51:37 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPCWAu9kqQgdAA--.59294S3;
 Wed, 30 Aug 2023 16:49:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S30; 
 Wed, 30 Aug 2023 16:49:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 28/48] target/loongarch: Implement xvsllwil xvextl
Date: Wed, 30 Aug 2023 16:48:42 +0800
Message-Id: <20230830084902.2113960-29-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S30
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
- XVSLLWIL.{H.B/W.H/D.W};
- XVSLLWIL.{HU.BU/WU.HU/DU.WU};
- XVEXTL.Q.D, VEXTL.QU.DU.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/insns.decode                |  9 ++++
 target/loongarch/disas.c                     |  9 ++++
 target/loongarch/vec_helper.c                | 44 ++++++++++++--------
 target/loongarch/insn_trans/trans_lasx.c.inc |  9 ++++
 4 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fb7bd9fb34..8a7933eccc 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1652,6 +1652,15 @@ xvrotri_h        0111 01101010 00000 1 .... ..... .....   @vv_ui4
 xvrotri_w        0111 01101010 00001 ..... ..... .....    @vv_ui5
 xvrotri_d        0111 01101010 0001 ...... ..... .....    @vv_ui6
 
+xvsllwil_h_b     0111 01110000 10000 01 ... ..... .....   @vv_ui3
+xvsllwil_w_h     0111 01110000 10000 1 .... ..... .....   @vv_ui4
+xvsllwil_d_w     0111 01110000 10001 ..... ..... .....    @vv_ui5
+xvextl_q_d       0111 01110000 10010 00000 ..... .....    @vv
+xvsllwil_hu_bu   0111 01110000 11000 01 ... ..... .....   @vv_ui3
+xvsllwil_wu_hu   0111 01110000 11000 1 .... ..... .....   @vv_ui4
+xvsllwil_du_wu   0111 01110000 11001 ..... ..... .....    @vv_ui5
+xvextl_qu_du     0111 01110000 11010 00000 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index e081a11aba..93c205fa32 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2077,6 +2077,15 @@ INSN_LASX(xvrotri_h,         vv_i)
 INSN_LASX(xvrotri_w,         vv_i)
 INSN_LASX(xvrotri_d,         vv_i)
 
+INSN_LASX(xvsllwil_h_b,      vv_i)
+INSN_LASX(xvsllwil_w_h,      vv_i)
+INSN_LASX(xvsllwil_d_w,      vv_i)
+INSN_LASX(xvextl_q_d,        vv)
+INSN_LASX(xvsllwil_hu_bu,    vv_i)
+INSN_LASX(xvsllwil_wu_hu,    vv_i)
+INSN_LASX(xvsllwil_du_wu,    vv_i)
+INSN_LASX(xvextl_qu_du,      vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index e33969339f..7fe9f9f34e 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -925,37 +925,47 @@ void HELPER(vnori_b)(void *vd, void *vj, uint64_t imm, uint32_t desc)
     }
 }
 
-#define VSLLWIL(NAME, BIT, E1, E2)                                 \
-void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc) \
-{                                                                  \
-    int i;                                                         \
-    VReg temp;                                                     \
-    VReg *Vd = (VReg *)vd;                                         \
-    VReg *Vj = (VReg *)vj;                                         \
-    typedef __typeof(temp.E1(0)) TD;                               \
-                                                                   \
-    temp.D(0) = 0;                                                 \
-    temp.D(1) = 0;                                                 \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                            \
-        temp.E1(i) = (TD)Vj->E2(i) << (imm % BIT);                 \
-    }                                                              \
-    *Vd = temp;                                                    \
+#define VSLLWIL(NAME, BIT, E1, E2)                                             \
+void HELPER(NAME)(void *vd, void *vj, uint64_t imm, uint32_t desc)             \
+{                                                                              \
+    int i, j, ofs;                                                             \
+    VReg temp = {};                                                            \
+    VReg *Vd = (VReg *)vd;                                                     \
+    VReg *Vj = (VReg *)vj;                                                     \
+    int oprsz = simd_oprsz(desc);                                              \
+    typedef __typeof(temp.E1(0)) TD;                                           \
+                                                                               \
+    ofs = LSX_LEN / BIT;                                                       \
+    for (i = 0; i < oprsz / 16; i++) {                                         \
+        for (j = 0; j < ofs; j++) {                                            \
+            temp.E1(j + ofs * i) = (TD)Vj->E2(j + ofs * 2 * i) << (imm % BIT); \
+        }                                                                      \
+    }                                                                          \
+    *Vd = temp;                                                                \
 }
 
 void HELPER(vextl_q_d)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_makes64(Vj->D(0));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_makes64(Vj->D(2 * i));
+    }
 }
 
 void HELPER(vextl_qu_du)(void *vd, void *vj, uint32_t desc)
 {
+    int i;
     VReg *Vd = (VReg *)vd;
     VReg *Vj = (VReg *)vj;
+    int oprsz = simd_oprsz(desc);
 
-    Vd->Q(0) = int128_make64(Vj->D(0));
+    for (i = 0; i < oprsz / 16; i++) {
+        Vd->Q(i) = int128_make64(Vj->UD(2 * i));
+    }
 }
 
 VSLLWIL(vsllwil_h_b, 16, H, B)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index d13dfacebf..eef6f28338 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -400,6 +400,15 @@ TRANS(xvrotri_h, LASX, gvec_vv_i, 32, MO_16, tcg_gen_gvec_rotri)
 TRANS(xvrotri_w, LASX, gvec_vv_i, 32, MO_32, tcg_gen_gvec_rotri)
 TRANS(xvrotri_d, LASX, gvec_vv_i, 32, MO_64, tcg_gen_gvec_rotri)
 
+TRANS(xvsllwil_h_b, LASX, gen_vv_i, 32, gen_helper_vsllwil_h_b)
+TRANS(xvsllwil_w_h, LASX, gen_vv_i, 32, gen_helper_vsllwil_w_h)
+TRANS(xvsllwil_d_w, LASX, gen_vv_i, 32, gen_helper_vsllwil_d_w)
+TRANS(xvextl_q_d, LASX, gen_vv, 32, gen_helper_vextl_q_d)
+TRANS(xvsllwil_hu_bu, LASX, gen_vv_i, 32, gen_helper_vsllwil_hu_bu)
+TRANS(xvsllwil_wu_hu, LASX, gen_vv_i, 32, gen_helper_vsllwil_wu_hu)
+TRANS(xvsllwil_du_wu, LASX, gen_vv_i, 32, gen_helper_vsllwil_du_wu)
+TRANS(xvextl_qu_du, LASX, gen_vv, 32, gen_helper_vextl_qu_du)
+
 TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
-- 
2.39.1


