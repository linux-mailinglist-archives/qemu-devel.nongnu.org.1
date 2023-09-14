Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA22879F814
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgc4r-0003Gy-0S; Wed, 13 Sep 2023 22:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qgc4f-0003Bk-U3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:22 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qgc4d-0004uy-ES
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:27:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxDOt6bwJlhfgmAA--.4552S3;
 Thu, 14 Sep 2023 10:27:06 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxvdxmbwJlJ+UDAA--.7298S25; 
 Thu, 14 Sep 2023 10:27:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v6 23/57] target/loongarch: Implement xvadda
Date: Thu, 14 Sep 2023 10:26:11 +0800
Message-Id: <20230914022645.1151356-24-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914022645.1151356-1-gaosong@loongson.cn>
References: <20230914022645.1151356-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxvdxmbwJlJ+UDAA--.7298S25
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
- XVADDA.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  5 ++++
 target/loongarch/disas.c                    |  5 ++++
 target/loongarch/vec_helper.c               | 30 +++++++++++----------
 target/loongarch/insn_trans/trans_vec.c.inc |  4 +++
 4 files changed, 30 insertions(+), 14 deletions(-)

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
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index bbe7ad8322..51fbd78279 100644
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
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 35b207aae1..ec6d86cc83 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -394,22 +394,24 @@ DO_3OP(vabsd_du, 64, UD, DO_VABSD)
 
 #define DO_VABS(a)  ((a < 0) ? (-a) : (a))
 
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
+#define DO_VADDA(NAME, BIT, E)                                 \
+void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc) \
+{                                                              \
+    int i;                                                     \
+    VReg *Vd = (VReg *)vd;                                     \
+    VReg *Vj = (VReg *)vj;                                     \
+    VReg *Vk = (VReg *)vk;                                     \
+    int oprsz = simd_oprsz(desc);                              \
+                                                               \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {                  \
+        Vd->E(i) = DO_VABS(Vj->E(i)) + DO_VABS(Vk->E(i));      \
+    }                                                          \
 }
 
-DO_VADDA(vadda_b, 8, B, DO_VABS)
-DO_VADDA(vadda_h, 16, H, DO_VABS)
-DO_VADDA(vadda_w, 32, W, DO_VABS)
-DO_VADDA(vadda_d, 64, D, DO_VABS)
+DO_VADDA(vadda_b, 8, B)
+DO_VADDA(vadda_h, 16, H)
+DO_VADDA(vadda_w, 32, W)
+DO_VADDA(vadda_d, 64, D)
 
 #define DO_MIN(a, b) (a < b ? a : b)
 #define DO_MAX(a, b) (a > b ? a : b)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 37b842075d..c8d356788e 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -1672,6 +1672,10 @@ TRANS(vadda_b, LSX, gvec_vvv, MO_8, do_vadda)
 TRANS(vadda_h, LSX, gvec_vvv, MO_16, do_vadda)
 TRANS(vadda_w, LSX, gvec_vvv, MO_32, do_vadda)
 TRANS(vadda_d, LSX, gvec_vvv, MO_64, do_vadda)
+TRANS(xvadda_b, LASX, gvec_xxx, MO_8, do_vadda)
+TRANS(xvadda_h, LASX, gvec_xxx, MO_16, do_vadda)
+TRANS(xvadda_w, LASX, gvec_xxx, MO_32, do_vadda)
+TRANS(xvadda_d, LASX, gvec_xxx, MO_64, do_vadda)
 
 TRANS(vmax_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_smax)
 TRANS(vmax_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_smax)
-- 
2.39.1


