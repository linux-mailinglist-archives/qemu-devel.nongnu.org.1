Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94302753562
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 10:47:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKESB-0003jl-Qa; Fri, 14 Jul 2023 04:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qKES2-0003AZ-Is
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qKES0-0004vW-3c
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 04:46:58 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHOtzC7Fktc4EAA--.8193S3;
 Fri, 14 Jul 2023 16:46:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyNYC7FkFOotAA--.22026S44; 
 Fri, 14 Jul 2023 16:46:43 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v3 42/47] target/loongarch: Implement xvinsgr2vr xvpickve2gr
Date: Fri, 14 Jul 2023 16:46:10 +0800
Message-Id: <20230714084615.2448038-43-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
References: <20230714084615.2448038-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxzyNYC7FkFOotAA--.22026S44
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
- XVINSGR2VR.{W/D};
- XVPICKVE2GR.{W/D}[U].

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 18 ++++++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 30 ++++++++++++++++++++
 target/loongarch/insns.decode                |  7 +++++
 3 files changed, 55 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 3a06b5cb80..0995d9b794 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1738,6 +1738,17 @@ static void output_vr_x(DisasContext *ctx, arg_vr *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, r%d", a->vd, a->rj);
 }
 
+static void output_vr_i_x(DisasContext *ctx, arg_vr_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, 0x%x", a->vd, a->rj, a->imm);
+}
+
+static void output_rv_i_x(DisasContext *ctx, arg_rv_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->vj, a->imm);
+}
+
+
 INSN_LASX(xvadd_b,           vvv)
 INSN_LASX(xvadd_h,           vvv)
 INSN_LASX(xvadd_w,           vvv)
@@ -2498,6 +2509,13 @@ INSN_LASX(xvsetallnez_h,     cv)
 INSN_LASX(xvsetallnez_w,     cv)
 INSN_LASX(xvsetallnez_d,     cv)
 
+INSN_LASX(xvinsgr2vr_w,      vr_i)
+INSN_LASX(xvinsgr2vr_d,      vr_i)
+INSN_LASX(xvpickve2gr_w,     rv_i)
+INSN_LASX(xvpickve2gr_d,     rv_i)
+INSN_LASX(xvpickve2gr_wu,    rv_i)
+INSN_LASX(xvpickve2gr_du,    rv_i)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 700cbdc622..a79f34d280 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -746,6 +746,36 @@ TRANS(xvsetallnez_h, gen_cv, 32, gen_helper_vsetallnez_h)
 TRANS(xvsetallnez_w, gen_cv, 32, gen_helper_vsetallnez_w)
 TRANS(xvsetallnez_d, gen_cv, 32, gen_helper_vsetallnez_d)
 
+static bool trans_xvinsgr2vr_w(DisasContext *ctx, arg_vr_i *a)
+{
+    return trans_vinsgr2vr_w(ctx, a);
+}
+
+static bool trans_xvinsgr2vr_d(DisasContext *ctx, arg_vr_i *a)
+{
+    return trans_vinsgr2vr_d(ctx, a);
+}
+
+static bool trans_xvpickve2gr_w(DisasContext *ctx, arg_rv_i *a)
+{
+    return trans_vpickve2gr_w(ctx, a);
+}
+
+static bool trans_xvpickve2gr_d(DisasContext *ctx, arg_rv_i *a)
+{
+    return trans_vpickve2gr_d(ctx, a);
+}
+
+static bool trans_xvpickve2gr_wu(DisasContext *ctx, arg_rv_i *a)
+{
+    return trans_vpickve2gr_wu(ctx, a);
+}
+
+static bool trans_xvpickve2gr_du(DisasContext *ctx, arg_rv_i *a)
+{
+    return trans_vpickve2gr_du(ctx, a);
+}
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index ad6751fdfb..bb3bb447ae 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1976,6 +1976,13 @@ xvsetallnez_h    0111 01101001 11001 01101 ..... 00 ...   @cv
 xvsetallnez_w    0111 01101001 11001 01110 ..... 00 ...   @cv
 xvsetallnez_d    0111 01101001 11001 01111 ..... 00 ...   @cv
 
+xvinsgr2vr_w     0111 01101110 10111 10 ... ..... .....   @vr_ui3
+xvinsgr2vr_d     0111 01101110 10111 110 .. ..... .....   @vr_ui2
+xvpickve2gr_w    0111 01101110 11111 10 ... ..... .....   @rv_ui3
+xvpickve2gr_d    0111 01101110 11111 110 .. ..... .....   @rv_ui2
+xvpickve2gr_wu   0111 01101111 00111 10 ... ..... .....   @rv_ui3
+xvpickve2gr_du   0111 01101111 00111 110 .. ..... .....   @rv_ui2
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
-- 
2.39.1


