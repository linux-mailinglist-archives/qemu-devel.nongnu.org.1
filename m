Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F07A753596
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES6-0003OJ-22; Fri, 14 Jul 2023 04:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERn-0001jg-UC
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:45 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERi-0004o5-PR
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:43 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxyepiC7Fkac4EAA--.3865S3;
 Fri, 14 Jul 2023 16:46:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S16; 
 Fri, 14 Jul 2023 16:46:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 14/47] target/loongarch: Implement xvadda
Date: Fri, 14 Jul 2023 16:45:42 +0800
Message-Id: <20230714084615.2448038-15-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S16
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
- XVADDA.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  5 ++++
 target/loongarch/insn_trans/trans_lasx.c.inc |  5 ++++
 target/loongarch/insns.decode                |  5 ++++
 target/loongarch/vec.h                       |  2 ++
 target/loongarch/vec_helper.c                | 24 ++++++++++----------
 5 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index d0b1de39b8..b48822e431 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1851,6 +1851,11 @@ INSN_LASX(xvabsd_hu,         vvv)
 INSN_LASX(xvabsd_wu,         vvv)
 INSN_LASX(xvabsd_du,         vvv)
 
+INSN_LASX(xvadda_b,          vvv)
+INSN_LASX(xvadda_h,          vvv)
+INSN_LASX(xvadda_w,          vvv)
+INSN_LASX(xvadda_d,          vvv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index bd8ba6c7b6..30cb286cb9 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -166,6 +166,11 @@ TRANS(xvabsd_hu, gvec_vvv, 32, MO_16, do_vabsd_u)
 TRANS(xvabsd_wu, gvec_vvv, 32, MO_32, do_vabsd_u)
 TRANS(xvabsd_du, gvec_vvv, 32, MO_64, do_vabsd_u)
 
+TRANS(xvadda_b, gvec_vvv, 32, MO_8, do_vadda)
+TRANS(xvadda_h, gvec_vvv, 32, MO_16, do_vadda)
+TRANS(xvadda_w, gvec_vvv, 32, MO_32, do_vadda)
+TRANS(xvadda_d, gvec_vvv, 32, MO_64, do_vadda)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index c086ee9b22..f3722e3aa7 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1432,6 +1432,11 @@ xvabsd_hu        0111 01000110 00101 ..... ..... .....    @vvv
 xvabsd_wu        0111 01000110 00110 ..... ..... .....    @vvv
 xvabsd_du        0111 01000110 00111 ..... ..... .....    @vvv
 
+xvadda_b         0111 01000101 11000 ..... ..... .....    @vvv
+xvadda_h         0111 01000101 11001 ..... ..... .....    @vvv
+xvadda_w         0111 01000101 11010 ..... ..... .....    @vvv
+xvadda_d         0111 01000101 11011 ..... ..... .....    @vvv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 6767073635..7ccc89c10f 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -55,4 +55,6 @@
 
 #define DO_VABSD(a, b)  ((a > b) ? (a - b) : (b - a))
 
+#define DO_VABS(a)      ((a < 0) ? (-a) : (a))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 22d08f36ac..ff77f714e8 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -384,18 +384,18 @@ DO_3OP(vabsd_hu, 16, UH, DO_VABSD)
 DO_3OP(vabsd_wu, 32, UW, DO_VABSD)
 DO_3OP(vabsd_du, 64, UD, DO_VABSD)
 
-#define DO_VABS(a)  ((a < 0) ? (-a) : (a))
-
-#define DO_VADDA(NAME, BIT, E, DO_OP)                       \
-void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t v) \
-{                                                           \
-    int i;                                                  \
-    VReg *Vd = (VReg *)vd;                                  \
-    VReg *Vj = (VReg *)vj;                                  \
-    VReg *Vk = (VReg *)vk;                                  \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
-        Vd->E(i) = DO_OP(Vj->E(i)) + DO_OP(Vk->E(i));       \
-    }                                                       \
+#define DO_VADDA(NAME, BIT, E, DO_OP)                          \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E(i) = DO_OP(Vj->E(i)) + DO_OP(Vk->E(i));          \
+    }                                                          \
 }
 
 DO_VADDA(vadda_b, 8, B, DO_VABS)
-- 
2.39.1


