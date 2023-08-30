Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F398378D444
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 10:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbGu7-0001aq-2d; Wed, 30 Aug 2023 04:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qbGtc-0001Wj-Cp
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qbGtV-0007YN-TI
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 04:49:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx77uaAu9ktwgdAA--.269S3;
 Wed, 30 Aug 2023 16:49:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF81+Au9kHhxnAA--.49766S36; 
 Wed, 30 Aug 2023 16:49:30 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v4 34/48] target/loongarch: Implement xvclo xvclz
Date: Wed, 30 Aug 2023 16:48:48 +0800
Message-Id: <20230830084902.2113960-35-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230830084902.2113960-1-gaosong@loongson.cn>
References: <20230830084902.2113960-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF81+Au9kHhxnAA--.49766S36
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
- XVCLO.{B/H/W/D};
- XVCLZ.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/vec.h                       |  9 +++++++++
 target/loongarch/insns.decode                |  9 +++++++++
 target/loongarch/disas.c                     |  9 +++++++++
 target/loongarch/vec_helper.c                | 13 ++-----------
 target/loongarch/insn_trans/trans_lasx.c.inc |  9 +++++++++
 5 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 67d829f9da..4497cd4a6d 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -76,4 +76,13 @@
 
 #define R_SHIFT(a, b) (a >> b)
 
+#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
+#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
+#define DO_CLO_W(N)  (clz32(~N))
+#define DO_CLO_D(N)  (clz64(~N))
+#define DO_CLZ_B(N)  (clz32(N) - 24)
+#define DO_CLZ_H(N)  (clz32(N) - 16)
+#define DO_CLZ_W(N)  (clz32(N))
+#define DO_CLZ_D(N)  (clz64(N))
+
 #endif /* LOONGARCH_VEC_H */
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index dc74bae7a5..3175532045 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1770,6 +1770,15 @@ xvssrarni_hu_w   0111 01110110 11001 ..... ..... .....    @vv_ui5
 xvssrarni_wu_d   0111 01110110 1101 ...... ..... .....    @vv_ui6
 xvssrarni_du_q   0111 01110110 111 ....... ..... .....    @vv_ui7
 
+xvclo_b          0111 01101001 11000 00000 ..... .....    @vv
+xvclo_h          0111 01101001 11000 00001 ..... .....    @vv
+xvclo_w          0111 01101001 11000 00010 ..... .....    @vv
+xvclo_d          0111 01101001 11000 00011 ..... .....    @vv
+xvclz_b          0111 01101001 11000 00100 ..... .....    @vv
+xvclz_h          0111 01101001 11000 00101 ..... .....    @vv
+xvclz_w          0111 01101001 11000 00110 ..... .....    @vv
+xvclz_d          0111 01101001 11000 00111 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index f043a2f9b6..0fc58735b9 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2196,6 +2196,15 @@ INSN_LASX(xvssrarni_hu_w,    vv_i)
 INSN_LASX(xvssrarni_wu_d,    vv_i)
 INSN_LASX(xvssrarni_du_q,    vv_i)
 
+INSN_LASX(xvclo_b,           vv)
+INSN_LASX(xvclo_h,           vv)
+INSN_LASX(xvclo_w,           vv)
+INSN_LASX(xvclo_d,           vv)
+INSN_LASX(xvclz_b,           vv)
+INSN_LASX(xvclz_h,           vv)
+INSN_LASX(xvclz_w,           vv)
+INSN_LASX(xvclz_d,           vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 852c65716e..789f6b303e 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2161,22 +2161,13 @@ void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
     int i;                                           \
     VReg *Vd = (VReg *)vd;                           \
     VReg *Vj = (VReg *)vj;                           \
+    int oprsz = simd_oprsz(desc);                    \
                                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++)                \
-    {                                                \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {        \
         Vd->E(i) = DO_OP(Vj->E(i));                  \
     }                                                \
 }
 
-#define DO_CLO_B(N)  (clz32(~N & 0xff) - 24)
-#define DO_CLO_H(N)  (clz32(~N & 0xffff) - 16)
-#define DO_CLO_W(N)  (clz32(~N))
-#define DO_CLO_D(N)  (clz64(~N))
-#define DO_CLZ_B(N)  (clz32(N) - 24)
-#define DO_CLZ_H(N)  (clz32(N) - 16)
-#define DO_CLZ_W(N)  (clz32(N))
-#define DO_CLZ_D(N)  (clz64(N))
-
 DO_2OP(vclo_b, 8, UB, DO_CLO_B)
 DO_2OP(vclo_h, 16, UH, DO_CLO_H)
 DO_2OP(vclo_w, 32, UW, DO_CLO_W)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index dc658fc2cb..4227fbe629 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -519,6 +519,15 @@ TRANS(xvssrarni_hu_w, LASX, gen_vv_i, 32, gen_helper_vssrarni_hu_w)
 TRANS(xvssrarni_wu_d, LASX, gen_vv_i, 32, gen_helper_vssrarni_wu_d)
 TRANS(xvssrarni_du_q, LASX, gen_vv_i, 32, gen_helper_vssrarni_du_q)
 
+TRANS(xvclo_b, LASX, gen_vv, 32, gen_helper_vclo_b)
+TRANS(xvclo_h, LASX, gen_vv, 32, gen_helper_vclo_h)
+TRANS(xvclo_w, LASX, gen_vv, 32, gen_helper_vclo_w)
+TRANS(xvclo_d, LASX, gen_vv, 32, gen_helper_vclo_d)
+TRANS(xvclz_b, LASX, gen_vv, 32, gen_helper_vclz_b)
+TRANS(xvclz_h, LASX, gen_vv, 32, gen_helper_vclz_h)
+TRANS(xvclz_w, LASX, gen_vv, 32, gen_helper_vclz_w)
+TRANS(xvclz_d, LASX, gen_vv, 32, gen_helper_vclz_d)
+
 TRANS(xvreplgr2vr_b, LASX, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, LASX, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, LASX, gvec_dup, 32, MO_32)
-- 
2.39.1


