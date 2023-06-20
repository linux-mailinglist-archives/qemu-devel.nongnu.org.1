Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD17736814
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpU-0007NR-G3; Tue, 20 Jun 2023 05:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp8-0007Cp-2g
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp5-0006PA-J8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:53 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx8Oifc5Fk3yUHAA--.12762S3;
 Tue, 20 Jun 2023 17:38:39 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S43; 
 Tue, 20 Jun 2023 17:38:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 41/46] target/loongarch: Implement xvinsgr2vr xvpickve2gr
Date: Tue, 20 Jun 2023 17:38:09 +0800
Message-Id: <20230620093814.123650-42-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S43
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
 target/loongarch/disas.c                     | 17 ++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 54 ++++++++++++++++++++
 target/loongarch/insns.decode                | 13 +++++
 3 files changed, 84 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5c2a81ee80..fd7d459921 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1738,6 +1738,16 @@ static void output_xr(DisasContext *ctx, arg_xr *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, r%d", a->xd, a->rj);
 }
 
+static void output_xr_i(DisasContext *ctx, arg_xr_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, r%d, 0x%x", a->xd, a->rj, a->imm);
+}
+
+static void output_rx_i(DisasContext *ctx, arg_rx_i *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->xj, a->imm);
+}
+
 INSN_LASX(xvadd_b,           xxx)
 INSN_LASX(xvadd_h,           xxx)
 INSN_LASX(xvadd_w,           xxx)
@@ -2497,6 +2507,13 @@ INSN_LASX(xvsetallnez_h,     cx)
 INSN_LASX(xvsetallnez_w,     cx)
 INSN_LASX(xvsetallnez_d,     cx)
 
+INSN_LASX(xvinsgr2vr_w,      xr_i)
+INSN_LASX(xvinsgr2vr_d,      xr_i)
+INSN_LASX(xvpickve2gr_w,     rx_i)
+INSN_LASX(xvpickve2gr_d,     rx_i)
+INSN_LASX(xvpickve2gr_wu,    rx_i)
+INSN_LASX(xvpickve2gr_du,    rx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index cefb6a4973..0fc26023d1 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2782,6 +2782,60 @@ TRANS(xvsetallnez_h, gen_cx, gen_helper_xvsetallnez_h)
 TRANS(xvsetallnez_w, gen_cx, gen_helper_xvsetallnez_w)
 TRANS(xvsetallnez_d, gen_cx, gen_helper_xvsetallnez_d)
 
+static bool trans_xvinsgr2vr_w(DisasContext *ctx, arg_xr_i *a)
+{
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_st32_i64(src, cpu_env,
+                     offsetof(CPULoongArchState, fpr[a->xd].xreg.XW(a->imm)));
+    return true;
+}
+
+static bool trans_xvinsgr2vr_d(DisasContext *ctx, arg_xr_i *a)
+{
+    TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_st_i64(src, cpu_env,
+                   offsetof(CPULoongArchState, fpr[a->xd].xreg.XD(a->imm)));
+    return true;
+}
+
+static bool trans_xvpickve2gr_w(DisasContext *ctx, arg_rx_i *a)
+{
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_ld32s_i64(dst, cpu_env,
+                      offsetof(CPULoongArchState, fpr[a->xj].xreg.XW(a->imm)));
+    return true;
+}
+
+static bool trans_xvpickve2gr_d(DisasContext *ctx, arg_rx_i *a)
+{
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_ld_i64(dst, cpu_env,
+                   offsetof(CPULoongArchState, fpr[a->xj].xreg.XD(a->imm)));
+    return true;
+}
+
+static bool trans_xvpickve2gr_wu(DisasContext *ctx, arg_rx_i *a)
+{
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_ld32u_i64(dst, cpu_env,
+                      offsetof(CPULoongArchState, fpr[a->xj].xreg.XW(a->imm)));
+    return true;
+}
+
+static bool trans_xvpickve2gr_du(DisasContext *ctx, arg_rx_i *a)
+{
+    TCGv dst = gpr_dst(ctx, a->rd, EXT_NONE);
+    CHECK_ASXE;
+    tcg_gen_ld_i64(dst, cpu_env,
+                   offsetof(CPULoongArchState, fpr[a->xj].xreg.XD(a->imm)));
+    return true;
+}
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index b696d99577..8c87b3f840 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1309,6 +1309,8 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &xxxx         xd xj xk xa
 &xxx_fcond    xd xj xk fcond
 &cx           cd xj
+&xr_i         xd rj imm
+&rx_i         rd xj imm
 
 #
 # LASX Formats
@@ -1328,6 +1330,10 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xxxx                .... ........ xa:5 xk:5 xj:5 xd:5    &xxxx
 @xxx_fcond        .... ........ fcond:5 xk:5 xj:5 xd:5    &xxx_fcond
 @cx             .... ........ ..... ..... xj:5 .. cd:3    &cx
+@xr_ui3         .... ........ ..... .. imm:3 rj:5 xd:5    &xr_i
+@xr_ui2        .... ........ ..... ... imm:2 rj:5 xd:5    &xr_i
+@rx_ui3         .... ........ ..... .. imm:3 xj:5 rd:5    &rx_i
+@rx_ui2        .... ........ ..... ... imm:2 xj:5 rd:5    &rx_i
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -2005,6 +2011,13 @@ xvsetallnez_h    0111 01101001 11001 01101 ..... 00 ...   @cx
 xvsetallnez_w    0111 01101001 11001 01110 ..... 00 ...   @cx
 xvsetallnez_d    0111 01101001 11001 01111 ..... 00 ...   @cx
 
+xvinsgr2vr_w     0111 01101110 10111 10 ... ..... .....   @xr_ui3
+xvinsgr2vr_d     0111 01101110 10111 110 .. ..... .....   @xr_ui2
+xvpickve2gr_w    0111 01101110 11111 10 ... ..... .....   @rx_ui3
+xvpickve2gr_d    0111 01101110 11111 110 .. ..... .....   @rx_ui2
+xvpickve2gr_wu   0111 01101111 00111 10 ... ..... .....   @rx_ui3
+xvpickve2gr_du   0111 01101111 00111 110 .. ..... .....   @rx_ui2
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
-- 
2.39.1


