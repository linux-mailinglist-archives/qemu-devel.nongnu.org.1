Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E12567970E3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:40:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARf-0004gk-K5; Thu, 07 Sep 2023 04:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARY-0004RS-MU
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARU-0002NY-P1
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bxd+ikivlkQzkhAA--.30237S3;
 Thu, 07 Sep 2023 16:32:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S44; 
 Thu, 07 Sep 2023 16:32:36 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 42/57] target/loongarch: Implement xvclo xvclz
Date: Thu,  7 Sep 2023 16:31:43 +0800
Message-Id: <20230907083158.3975132-43-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S44
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               | 9 +++++++++
 target/loongarch/disas.c                    | 9 +++++++++
 target/loongarch/vec_helper.c               | 3 ++-
 target/loongarch/insn_trans/trans_vec.c.inc | 8 ++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

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
index 421eecbb71..bbf530b349 100644
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
index 53dc53cb09..461aa12bf5 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2264,8 +2264,9 @@ void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
     int i;                                           \
     VReg *Vd = (VReg *)vd;                           \
     VReg *Vj = (VReg *)vj;                           \
+    int oprsz = simd_oprsz(desc);                    \
                                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++)                \
+    for (i = 0; i < oprsz / (BIT / 8); i++)          \
     {                                                \
         Vd->E(i) = DO_OP(Vj->E(i));                  \
     }                                                \
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index c9d0897acf..ea555e6ac1 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -4013,6 +4013,14 @@ TRANS(vclz_b, LSX, gen_vv, gen_helper_vclz_b)
 TRANS(vclz_h, LSX, gen_vv, gen_helper_vclz_h)
 TRANS(vclz_w, LSX, gen_vv, gen_helper_vclz_w)
 TRANS(vclz_d, LSX, gen_vv, gen_helper_vclz_d)
+TRANS(xvclo_b, LASX, gen_xx, gen_helper_vclo_b)
+TRANS(xvclo_h, LASX, gen_xx, gen_helper_vclo_h)
+TRANS(xvclo_w, LASX, gen_xx, gen_helper_vclo_w)
+TRANS(xvclo_d, LASX, gen_xx, gen_helper_vclo_d)
+TRANS(xvclz_b, LASX, gen_xx, gen_helper_vclz_b)
+TRANS(xvclz_h, LASX, gen_xx, gen_helper_vclz_h)
+TRANS(xvclz_w, LASX, gen_xx, gen_helper_vclz_w)
+TRANS(xvclz_d, LASX, gen_xx, gen_helper_vclz_d)
 
 TRANS(vpcnt_b, LSX, gen_vv, gen_helper_vpcnt_b)
 TRANS(vpcnt_h, LSX, gen_vv, gen_helper_vpcnt_h)
-- 
2.39.1


