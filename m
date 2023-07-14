Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75D753582
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES3-00038k-Hz; Fri, 14 Jul 2023 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERq-0001yz-SK
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERn-0004p9-0W
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:46 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnutlC7Fkec4EAA--.10843S3;
 Fri, 14 Jul 2023 16:46:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S21; 
 Fri, 14 Jul 2023 16:46:28 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 19/47] target/loongarch: Implement xvsat
Date: Fri, 14 Jul 2023 16:45:47 +0800
Message-Id: <20230714084615.2448038-20-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S21
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
- XVSAT.{B/H/W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  9 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  9 ++++
 target/loongarch/insns.decode                |  9 ++++
 target/loongarch/vec_helper.c                | 48 ++++++++++----------
 4 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 72df9f0b08..09e5981fc3 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1979,6 +1979,15 @@ INSN_LASX(xvmod_hu,          vvv)
 INSN_LASX(xvmod_wu,          vvv)
 INSN_LASX(xvmod_du,          vvv)
 
+INSN_LASX(xvsat_b,           vv_i)
+INSN_LASX(xvsat_h,           vv_i)
+INSN_LASX(xvsat_w,           vv_i)
+INSN_LASX(xvsat_d,           vv_i)
+INSN_LASX(xvsat_bu,          vv_i)
+INSN_LASX(xvsat_hu,          vv_i)
+INSN_LASX(xvsat_wu,          vv_i)
+INSN_LASX(xvsat_du,          vv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 118635dc1a..cda617413e 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -304,6 +304,15 @@ TRANS(xvmod_hu, gen_vvv, 32, gen_helper_vmod_hu)
 TRANS(xvmod_wu, gen_vvv, 32, gen_helper_vmod_wu)
 TRANS(xvmod_du, gen_vvv, 32, gen_helper_vmod_du)
 
+TRANS(xvsat_b, gvec_vv_i, 32, MO_8, do_vsat_s)
+TRANS(xvsat_h, gvec_vv_i, 32, MO_16, do_vsat_s)
+TRANS(xvsat_w, gvec_vv_i, 32, MO_32, do_vsat_s)
+TRANS(xvsat_d, gvec_vv_i, 32, MO_64, do_vsat_s)
+TRANS(xvsat_bu, gvec_vv_i, 32, MO_8, do_vsat_u)
+TRANS(xvsat_hu, gvec_vv_i, 32, MO_16, do_vsat_u)
+TRANS(xvsat_wu, gvec_vv_i, 32, MO_32, do_vsat_u)
+TRANS(xvsat_du, gvec_vv_i, 32, MO_64, do_vsat_u)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index fa25c876b4..e366cf7615 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1562,6 +1562,15 @@ xvmod_hu         0111 01001110 01101 ..... ..... .....    @vvv
 xvmod_wu         0111 01001110 01110 ..... ..... .....    @vvv
 xvmod_du         0111 01001110 01111 ..... ..... .....    @vvv
 
+xvsat_b          0111 01110010 01000 01 ... ..... .....   @vv_ui3
+xvsat_h          0111 01110010 01000 1 .... ..... .....   @vv_ui4
+xvsat_w          0111 01110010 01001 ..... ..... .....    @vv_ui5
+xvsat_d          0111 01110010 0101 ...... ..... .....    @vv_ui6
+xvsat_bu         0111 01110010 10000 01 ... ..... .....   @vv_ui3
+xvsat_hu         0111 01110010 10000 1 .... ..... .....   @vv_ui4
+xvsat_wu         0111 01110010 10001 ..... ..... .....    @vv_ui5
+xvsat_du         0111 01110010 1001 ...... ..... .....    @vv_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 998e561e0f..4df39c007e 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -652,18 +652,19 @@ VDIV(vmod_hu, 16, UH, DO_REMU)
 VDIV(vmod_wu, 32, UW, DO_REMU)
 VDIV(vmod_du, 64, UD, DO_REMU)
 
-#define VSAT_S(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max :               \
-                   Vj->E(i) < (TD)~max ? (TD)~max: Vj->E(i);    \
-    }                                                           \
+#define VSAT_S(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max :                  \
+                   Vj->E(i) < (TD)~max ? (TD)~max: Vj->E(i);       \
+    }                                                              \
 }
 
 VSAT_S(vsat_b, 8, B)
@@ -671,17 +672,18 @@ VSAT_S(vsat_h, 16, H)
 VSAT_S(vsat_w, 32, W)
 VSAT_S(vsat_d, 64, D)
 
-#define VSAT_U(NAME, BIT, E)                                    \
-void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t v) \
-{                                                               \
-    int i;                                                      \
-    VReg *Vd = (VReg *)vd;                                      \
-    VReg *Vj = (VReg *)vj;                                      \
-    typedef __typeof(Vd->E(0)) TD;                              \
-                                                                \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                         \
-        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max : Vj->E(i);     \
-    }                                                           \
+#define VSAT_U(NAME, BIT, E)                                       \
+void HELPER(NAME)(void *vd, void *vj, uint64_t max, uint32_t desc) \
+{                                                                  \
+    int i;                                                         \
+    VReg *Vd = (VReg *)vd;                                         \
+    VReg *Vj = (VReg *)vj;                                         \
+    typedef __typeof(Vd->E(0)) TD;                                 \
+    int oprsz = simd_oprsz(desc);                                  \
+                                                                   \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                      \
+        Vd->E(i) = Vj->E(i) > (TD)max ? (TD)max : Vj->E(i);        \
+    }                                                              \
 }
 
 VSAT_U(vsat_bu, 8, UB)
-- 
2.39.1


