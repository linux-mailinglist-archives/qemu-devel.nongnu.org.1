Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C577970E5
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeARN-00042n-OC; Thu, 07 Sep 2023 04:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeARH-0003s9-Uw
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeARB-0002Jb-E5
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:32:35 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjuuQivlk_DghAA--.63779S3;
 Thu, 07 Sep 2023 16:32:16 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxxsx+ivlk8FVwAA--.49124S19; 
 Thu, 07 Sep 2023 16:32:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH RESEND v5 17/57] target/loongarch: Implement xvneg
Date: Thu,  7 Sep 2023 16:31:18 +0800
Message-Id: <20230907083158.3975132-18-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230907083158.3975132-1-gaosong@loongson.cn>
References: <20230907083158.3975132-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxxsx+ivlk8FVwAA--.49124S19
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
- XVNEG.{B/H/W/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/insns.decode               |  5 +++++
 target/loongarch/disas.c                    | 10 ++++++++++
 target/loongarch/insn_trans/trans_vec.c.inc | 15 +++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index c48dca70b8..759172628f 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1320,6 +1320,11 @@ xvsubi_hu        0111 01101000 11001 ..... ..... .....    @vv_ui5
 xvsubi_wu        0111 01101000 11010 ..... ..... .....    @vv_ui5
 xvsubi_du        0111 01101000 11011 ..... ..... .....    @vv_ui5
 
+xvneg_b          0111 01101001 11000 01100 ..... .....    @vv
+xvneg_h          0111 01101001 11000 01101 ..... .....    @vv
+xvneg_w          0111 01101001 11000 01110 ..... .....    @vv
+xvneg_d          0111 01101001 11000 01111 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 20df9c7c99..a7455840a0 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1718,6 +1718,11 @@ static void output_vv_i_x(DisasContext *ctx, arg_vv_i *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, x%d, 0x%x", a->vd, a->vj, a->imm);
 }
 
+static void output_vv_x(DisasContext *ctx, arg_vv *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d", a->vd, a->vj);
+}
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -1738,6 +1743,11 @@ INSN_LASX(xvsubi_hu,         vv_i)
 INSN_LASX(xvsubi_wu,         vv_i)
 INSN_LASX(xvsubi_du,         vv_i)
 
+INSN_LASX(xvneg_b,           vv)
+INSN_LASX(xvneg_h,           vv)
+INSN_LASX(xvneg_w,           vv)
+INSN_LASX(xvneg_d,           vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 610a492d0c..7230181071 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -243,6 +243,17 @@ static bool gvec_vv(DisasContext *ctx, arg_vv *a, MemOp mop,
     return gvec_vv_vl(ctx, a, 16, mop, func);
 }
 
+static bool gvec_xx(DisasContext *ctx, arg_vv *a, MemOp mop,
+                    void (*func)(unsigned, uint32_t, uint32_t,
+                                 uint32_t, uint32_t))
+{
+    if (!check_vec(ctx, 32)) {
+        return true;
+    }
+
+    return gvec_vv_vl(ctx, a, 32, mop, func);
+}
+
 static bool gvec_vv_i_vl(DisasContext *ctx, arg_vv_i *a,
                          uint32_t oprsz, MemOp mop,
                          void (*func)(unsigned, uint32_t, uint32_t,
@@ -398,6 +409,10 @@ TRANS(vneg_b, LSX, gvec_vv, MO_8, tcg_gen_gvec_neg)
 TRANS(vneg_h, LSX, gvec_vv, MO_16, tcg_gen_gvec_neg)
 TRANS(vneg_w, LSX, gvec_vv, MO_32, tcg_gen_gvec_neg)
 TRANS(vneg_d, LSX, gvec_vv, MO_64, tcg_gen_gvec_neg)
+TRANS(xvneg_b, LASX, gvec_xx, MO_8, tcg_gen_gvec_neg)
+TRANS(xvneg_h, LASX, gvec_xx, MO_16, tcg_gen_gvec_neg)
+TRANS(xvneg_w, LASX, gvec_xx, MO_32, tcg_gen_gvec_neg)
+TRANS(xvneg_d, LASX, gvec_xx, MO_64, tcg_gen_gvec_neg)
 
 TRANS(vsadd_b, LSX, gvec_vvv, MO_8, tcg_gen_gvec_ssadd)
 TRANS(vsadd_h, LSX, gvec_vvv, MO_16, tcg_gen_gvec_ssadd)
-- 
2.39.1


