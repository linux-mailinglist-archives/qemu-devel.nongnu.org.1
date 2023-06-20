Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 784527367F6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpS-0007KU-LK; Tue, 20 Jun 2023 05:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXpD-0007DX-W2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:39:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXpB-0006Pf-Gb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:59 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIuihc5Fk4SUHAA--.623S3;
 Tue, 20 Jun 2023 17:38:41 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S44; 
 Tue, 20 Jun 2023 17:38:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 42/46] target/loongarch: Implement xvreplve xvinsve0
 xvpickve xvb{sll/srl}v
Date: Tue, 20 Jun 2023 17:38:10 +0800
Message-Id: <20230620093814.123650-43-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S44
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
- XVREPLVE.{B/H/W/D};
- XVREPL128VEI.{B/H/W/D};
- XVREPLVE0.{B/H/W/D/Q};
- XVINSVE0.{W/D};
- XVPICKVE.{W/D};
- XVBSLL.V, XVBSRL.V.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     |  29 +++
 target/loongarch/helper.h                    |   5 +
 target/loongarch/insn_trans/trans_lasx.c.inc | 205 +++++++++++++++++++
 target/loongarch/insns.decode                |  29 +++
 target/loongarch/lasx_helper.c               |  29 +++
 5 files changed, 297 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index fd7d459921..3b89a5df87 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1748,6 +1748,11 @@ static void output_rx_i(DisasContext *ctx, arg_rx_i *a, const char *mnemonic)
     output(ctx, mnemonic, "r%d, x%d, 0x%x", a->rd, a->xj, a->imm);
 }
 
+static void output_xxr(DisasContext *ctx, arg_xxr *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, r%d", a->xd, a->xj, a->rk);
+}
+
 INSN_LASX(xvadd_b,           xxx)
 INSN_LASX(xvadd_h,           xxx)
 INSN_LASX(xvadd_w,           xxx)
@@ -2518,3 +2523,27 @@ INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
 INSN_LASX(xvreplgr2vr_d,     xr)
+
+INSN_LASX(xvreplve_b,        xxr)
+INSN_LASX(xvreplve_h,        xxr)
+INSN_LASX(xvreplve_w,        xxr)
+INSN_LASX(xvreplve_d,        xxr)
+INSN_LASX(xvrepl128vei_b,    xx_i)
+INSN_LASX(xvrepl128vei_h,    xx_i)
+INSN_LASX(xvrepl128vei_w,    xx_i)
+INSN_LASX(xvrepl128vei_d,    xx_i)
+
+INSN_LASX(xvreplve0_b,       xx)
+INSN_LASX(xvreplve0_h,       xx)
+INSN_LASX(xvreplve0_w,       xx)
+INSN_LASX(xvreplve0_d,       xx)
+INSN_LASX(xvreplve0_q,       xx)
+
+INSN_LASX(xvinsve0_w,        xx_i)
+INSN_LASX(xvinsve0_d,        xx_i)
+
+INSN_LASX(xvpickve_w,        xx_i)
+INSN_LASX(xvpickve_d,        xx_i)
+
+INSN_LASX(xvbsll_v,          xx_i)
+INSN_LASX(xvbsrl_v,          xx_i)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index f6d64bfde5..6c4525a413 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1232,3 +1232,8 @@ DEF_HELPER_3(xvsetallnez_b, void, env, i32, i32)
 DEF_HELPER_3(xvsetallnez_h, void, env, i32, i32)
 DEF_HELPER_3(xvsetallnez_w, void, env, i32, i32)
 DEF_HELPER_3(xvsetallnez_d, void, env, i32, i32)
+
+DEF_HELPER_4(xvinsve0_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvinsve0_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickve_w, void, env, i32, i32, i32)
+DEF_HELPER_4(xvpickve_d, void, env, i32, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 0fc26023d1..e63b1c67c9 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -2851,3 +2851,208 @@ TRANS(xvreplgr2vr_b, gvec_dupx, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dupx, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dupx, MO_32)
 TRANS(xvreplgr2vr_d, gvec_dupx, MO_64)
+
+static bool gen_xvreplve(DisasContext *ctx, arg_xxr *a, int vece, int bit,
+                         void (*func)(TCGv_i64, TCGv_ptr, tcg_target_long))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_ptr t1 = tcg_temp_new_ptr();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+
+    CHECK_ASXE;
+
+    tcg_gen_andi_i64(t0, gpr_src(ctx, a->rk, EXT_NONE), (LSX_LEN / bit) - 1);
+    tcg_gen_shli_i64(t0, t0, vece);
+    if (HOST_BIG_ENDIAN) {
+        tcg_gen_xori_i64(t0, t0, vece << ((LSX_LEN / bit) - 1));
+    }
+
+    tcg_gen_trunc_i64_ptr(t1, t0);
+    tcg_gen_add_ptr(t1, t1, cpu_env);
+    func(t2, t1, vec_full_offset(a->xj));
+    tcg_gen_gvec_dup_i64(vece, vec_full_offset(a->xd), 16, 16, t2);
+    func(t2, t1,  offsetof(CPULoongArchState, fpr[a->xj].xreg.XQ(1)));
+    tcg_gen_gvec_dup_i64(vece,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XQ(1)),
+                         16, 16, t2);
+    return true;
+}
+
+TRANS(xvreplve_b, gen_xvreplve, MO_8,  8, tcg_gen_ld8u_i64)
+TRANS(xvreplve_h, gen_xvreplve, MO_16, 16, tcg_gen_ld16u_i64)
+TRANS(xvreplve_w, gen_xvreplve, MO_32, 32, tcg_gen_ld32u_i64)
+TRANS(xvreplve_d, gen_xvreplve, MO_64, 64, tcg_gen_ld_i64)
+
+static bool trans_xvrepl128vei_b(DisasContext *ctx, arg_xx_i * a)
+{
+    CHECK_ASXE;
+
+    tcg_gen_gvec_dup_mem(MO_8,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XB(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XB((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_8,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XB(16)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XB((a->imm + 16))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_h(DisasContext *ctx, arg_xx_i *a)
+{
+    CHECK_ASXE;
+
+    tcg_gen_gvec_dup_mem(MO_16,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XH(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XH((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_16,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XH(8)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XH((a->imm + 8))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_w(DisasContext *ctx, arg_xx_i *a)
+{
+    CHECK_ASXE;
+
+    tcg_gen_gvec_dup_mem(MO_32,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XW(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XW((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_32,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XW(4)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XW((a->imm + 4))),
+                         16, 16);
+    return true;
+}
+
+static bool trans_xvrepl128vei_d(DisasContext *ctx, arg_xx_i *a)
+{
+    CHECK_ASXE;
+
+    tcg_gen_gvec_dup_mem(MO_64,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XD(0)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XD((a->imm))),
+                         16, 16);
+    tcg_gen_gvec_dup_mem(MO_64,
+                         offsetof(CPULoongArchState, fpr[a->xd].xreg.XD(2)),
+                         offsetof(CPULoongArchState,
+                                  fpr[a->xj].xreg.XD((a->imm + 2))),
+                         16, 16);
+    return true;
+}
+
+#define XVREPLVE0(NAME, MOP)                                                  \
+static bool trans_## NAME(DisasContext *ctx, arg_xx * a)                      \
+{                                                                             \
+    CHECK_ASXE;                                                               \
+                                                                              \
+    tcg_gen_gvec_dup_mem(MOP, vec_full_offset(a->xd), vec_full_offset(a->xj), \
+                         32, 32);                                             \
+    return true;                                                              \
+}
+
+XVREPLVE0(xvreplve0_b, MO_8)
+XVREPLVE0(xvreplve0_h, MO_16)
+XVREPLVE0(xvreplve0_w, MO_32)
+XVREPLVE0(xvreplve0_d, MO_64)
+XVREPLVE0(xvreplve0_q, MO_128)
+
+TRANS(xvinsve0_w, gen_xx_i, gen_helper_xvinsve0_w)
+TRANS(xvinsve0_d, gen_xx_i, gen_helper_xvinsve0_d)
+
+TRANS(xvpickve_w, gen_xx_i, gen_helper_xvpickve_w)
+TRANS(xvpickve_d, gen_xx_i, gen_helper_xvpickve_d)
+
+static bool trans_xvbsll_v(DisasContext *ctx, arg_xx_i *a)
+{
+    int ofs;
+    TCGv_i64 desthigh[2], destlow[2], high[2], low[2];
+
+    CHECK_ASXE;
+
+    desthigh[0] = tcg_temp_new_i64();
+    desthigh[1] = tcg_temp_new_i64();
+    destlow[0] = tcg_temp_new_i64();
+    destlow[1] = tcg_temp_new_i64();
+    high[0] = tcg_temp_new_i64();
+    high[1] = tcg_temp_new_i64();
+    low[0] = tcg_temp_new_i64();
+    low[1] = tcg_temp_new_i64();
+
+    get_xreg64(low[0], a->xj, 0);
+    get_xreg64(low[1], a->xj, 2);
+
+    ofs = ((a->imm) & 0xf) * 8;
+    if (ofs < 64) {
+        get_xreg64(high[0], a->xj, 1);
+        get_xreg64(high[1], a->xj, 3);
+        tcg_gen_extract2_i64(desthigh[0], low[0], high[0], 64 - ofs);
+        tcg_gen_extract2_i64(desthigh[1], low[1], high[1], 64 - ofs);
+        tcg_gen_shli_i64(destlow[0], low[0], ofs);
+        tcg_gen_shli_i64(destlow[1], low[1], ofs);
+    } else {
+        tcg_gen_shli_i64(desthigh[0], low[0], ofs - 64);
+        tcg_gen_shli_i64(desthigh[1], low[1], ofs - 64);
+        destlow[0] = tcg_constant_i64(0);
+        destlow[1] = tcg_constant_i64(0);
+    }
+
+    set_xreg64(desthigh[0], a->xd, 1);
+    set_xreg64(destlow[0], a->xd, 0);
+    set_xreg64(desthigh[1], a->xd, 3);
+    set_xreg64(destlow[1], a->xd, 2);
+
+    return true;
+}
+
+static bool trans_xvbsrl_v(DisasContext *ctx, arg_xx_i *a)
+{
+    TCGv_i64 desthigh[2], destlow[2], high[2], low[2];
+    int ofs;
+
+    CHECK_ASXE;
+
+    desthigh[0] = tcg_temp_new_i64();
+    desthigh[1] = tcg_temp_new_i64();
+    destlow[0] = tcg_temp_new_i64();
+    destlow[1] = tcg_temp_new_i64();
+    high[0] = tcg_temp_new_i64();
+    high[1] = tcg_temp_new_i64();
+    low[0] = tcg_temp_new_i64();
+    low[1] = tcg_temp_new_i64();
+
+    get_xreg64(high[0], a->xj, 1);
+    get_xreg64(high[1], a->xj, 3);
+
+    ofs = ((a->imm) & 0xf) * 8;
+    if (ofs < 64) {
+        get_xreg64(low[0], a->xj, 0);
+        get_xreg64(low[1], a->xj, 2);
+        tcg_gen_extract2_i64(destlow[0], low[0], high[0], ofs);
+        tcg_gen_extract2_i64(destlow[1], low[1], high[1], ofs);
+        tcg_gen_shri_i64(desthigh[0], high[0], ofs);
+        tcg_gen_shri_i64(desthigh[1], high[1], ofs);
+    } else {
+        tcg_gen_shri_i64(destlow[0], high[0], ofs - 64);
+        tcg_gen_shri_i64(destlow[1], high[1], ofs - 64);
+        desthigh[0] = tcg_constant_i64(0);
+        desthigh[1] = tcg_constant_i64(0);
+    }
+
+    set_xreg64(desthigh[0], a->xd, 1);
+    set_xreg64(destlow[0], a->xd, 0);
+    set_xreg64(desthigh[1], a->xd, 3);
+    set_xreg64(destlow[1], a->xd, 2);
+
+    return true;
+}
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 8c87b3f840..697087e6ef 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1311,6 +1311,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &cx           cd xj
 &xr_i         xd rj imm
 &rx_i         rd xj imm
+&xxr          xd xj rk
 
 #
 # LASX Formats
@@ -1321,6 +1322,8 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
 @xr                .... ........ ..... ..... rj:5 xd:5    &xr
 @xx_i5            .... ........ ..... imm:s5 xj:5 xd:5    &xx_i
+@xx_ui1       .... ........ ..... .... imm:1 xj:5 xd:5    &xx_i
+@xx_ui2        .... ........ ..... ... imm:2 xj:5 xd:5    &xx_i
 @xx_ui3         .... ........ ..... .. imm:3 xj:5 xd:5    &xx_i
 @xx_ui4          .... ........ ..... . imm:4 xj:5 xd:5    &xx_i
 @xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
@@ -1334,6 +1337,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xr_ui2        .... ........ ..... ... imm:2 rj:5 xd:5    &xr_i
 @rx_ui3         .... ........ ..... .. imm:3 xj:5 rd:5    &rx_i
 @rx_ui2        .... ........ ..... ... imm:2 xj:5 rd:5    &rx_i
+@xxr                .... ........ ..... rk:5 xj:5 xd:5    &xxr
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -2022,3 +2026,28 @@ xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
 xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @xr
+
+xvreplve_b       0111 01010010 00100 ..... ..... .....    @xxr
+xvreplve_h       0111 01010010 00101 ..... ..... .....    @xxr
+xvreplve_w       0111 01010010 00110 ..... ..... .....    @xxr
+xvreplve_d       0111 01010010 00111 ..... ..... .....    @xxr
+
+xvrepl128vei_b   0111 01101111 01111 0 .... ..... .....   @xx_ui4
+xvrepl128vei_h   0111 01101111 01111 10 ... ..... .....   @xx_ui3
+xvrepl128vei_w   0111 01101111 01111 110 .. ..... .....   @xx_ui2
+xvrepl128vei_d   0111 01101111 01111 1110 . ..... .....   @xx_ui1
+
+xvreplve0_b      0111 01110000 01110 00000 ..... .....    @xx
+xvreplve0_h      0111 01110000 01111 00000 ..... .....    @xx
+xvreplve0_w      0111 01110000 01111 10000 ..... .....    @xx
+xvreplve0_d      0111 01110000 01111 11000 ..... .....    @xx
+xvreplve0_q      0111 01110000 01111 11100 ..... .....    @xx
+
+xvinsve0_w       0111 01101111 11111 10 ... ..... .....   @xx_ui3
+xvinsve0_d       0111 01101111 11111 110 .. ..... .....   @xx_ui2
+
+xvpickve_w       0111 01110000 00111 10 ... ..... .....   @xx_ui3
+xvpickve_d       0111 01110000 00111 110 .. ..... .....   @xx_ui2
+
+xvbsll_v         0111 01101000 11100 ..... ..... .....    @xx_ui5
+xvbsrl_v         0111 01101000 11101 ..... ..... .....    @xx_ui5
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 56dfe10a0d..4422c1292e 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -2819,3 +2819,32 @@ XSETALLNEZ(xvsetallnez_b, MO_8)
 XSETALLNEZ(xvsetallnez_h, MO_16)
 XSETALLNEZ(xvsetallnez_w, MO_32)
 XSETALLNEZ(xvsetallnez_d, MO_64)
+
+#define XVINSVE0(NAME, E, MASK)                           \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+    Xd->E(imm & MASK) = Xj->E(0);                         \
+}
+
+XVINSVE0(xvinsve0_w, XW, 0x7)
+XVINSVE0(xvinsve0_d, XD, 0x3)
+
+#define XVPICKVE(NAME, E, BIT, MASK)                      \
+void HELPER(NAME)(CPULoongArchState *env,                 \
+                  uint32_t xd, uint32_t xj, uint32_t imm) \
+{                                                         \
+    int i;                                                \
+    XReg *Xd = &(env->fpr[xd].xreg);                      \
+    XReg *Xj = &(env->fpr[xj].xreg);                      \
+                                                          \
+    Xd->E(0) = Xj->E(imm & MASK);                         \
+    for (i = 1; i < LASX_LEN / BIT; i++) {                \
+        Xd->E(i) = 0;                                     \
+    }                                                     \
+}
+
+XVPICKVE(xvpickve_w, XW, 32, 0x7)
+XVPICKVE(xvpickve_d, XD, 64, 0x3)
-- 
2.39.1


