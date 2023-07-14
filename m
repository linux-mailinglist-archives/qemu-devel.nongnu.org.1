Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E04F37535B6
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:52:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKES3-00036c-GJ; Fri, 14 Jul 2023 04:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKERx-0002iF-JD
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKERv-0004sc-60
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJvFuC7Fkos4EAA--.13620S3;
 Fri, 14 Jul 2023 16:46:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S36; 
 Fri, 14 Jul 2023 16:46:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 34/47] target/loongarch: Implement xvpcnt
Date: Fri, 14 Jul 2023 16:46:02 +0800
Message-Id: <20230714084615.2448038-35-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S36
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
- VPCNT.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 5 +++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 5 +++++
 target/loongarch/insns.decode                | 5 +++++
 target/loongarch/vec_helper.c                | 4 ++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 0fc58735b9..9e31f9bbbc 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -2205,6 +2205,11 @@ INSN_LASX(xvclz_h,           vv)
 INSN_LASX(xvclz_w,           vv)
 INSN_LASX(xvclz_d,           vv)
 
+INSN_LASX(xvpcnt_b,          vv)
+INSN_LASX(xvpcnt_h,          vv)
+INSN_LASX(xvpcnt_w,          vv)
+INSN_LASX(xvpcnt_d,          vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 80a566b948..94824569a0 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -524,6 +524,11 @@ TRANS(xvclz_h, gen_vv, 32, gen_helper_vclz_h)
 TRANS(xvclz_w, gen_vv, 32, gen_helper_vclz_w)
 TRANS(xvclz_d, gen_vv, 32, gen_helper_vclz_d)
 
+TRANS(xvpcnt_b, gen_vv, 32, gen_helper_vpcnt_b)
+TRANS(xvpcnt_h, gen_vv, 32, gen_helper_vpcnt_h)
+TRANS(xvpcnt_w, gen_vv, 32, gen_helper_vpcnt_w)
+TRANS(xvpcnt_d, gen_vv, 32, gen_helper_vpcnt_d)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 3175532045..d683c6a6ab 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1779,6 +1779,11 @@ xvclz_h          0111 01101001 11000 00101 ..... .....    @vv
 xvclz_w          0111 01101001 11000 00110 ..... .....    @vv
 xvclz_d          0111 01101001 11000 00111 ..... .....    @vv
 
+xvpcnt_b         0111 01101001 11000 01000 ..... .....    @vv
+xvpcnt_h         0111 01101001 11000 01001 ..... .....    @vv
+xvpcnt_w         0111 01101001 11000 01010 ..... .....    @vv
+xvpcnt_d         0111 01101001 11000 01011 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 2706daa1e0..57e9a9ed65 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2183,9 +2183,9 @@ void HELPER(NAME)(void *vd, void *vj, uint32_t desc) \
     int i;                                           \
     VReg *Vd = (VReg *)vd;                           \
     VReg *Vj = (VReg *)vj;                           \
+    int oprsz = simd_oprsz(desc);                    \
                                                      \
-    for (i = 0; i < LSX_LEN/BIT; i++)                \
-    {                                                \
+    for (i = 0; i < oprsz / (BIT / 8); i++) {        \
         Vd->E(i) = FN(Vj->E(i));                     \
     }                                                \
 }
-- 
2.39.1


