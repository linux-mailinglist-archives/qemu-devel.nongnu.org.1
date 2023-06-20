Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0908D73683E
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:46:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXox-00077l-Vn; Tue, 20 Jun 2023 05:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXov-00077G-Ov
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:41 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXos-0006Lx-Ae
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:41 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Ax0OiRc5FkryUHAA--.12768S3;
 Tue, 20 Jun 2023 17:38:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S20; 
 Tue, 20 Jun 2023 17:38:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 18/46] target/loongarch: Implement xvsat
Date: Tue, 20 Jun 2023 17:37:46 +0800
Message-Id: <20230620093814.123650-19-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S20
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
 target/loongarch/disas.c                     |  9 ++
 target/loongarch/helper.h                    |  9 ++
 target/loongarch/insn_trans/trans_lasx.c.inc | 86 ++++++++++++++++++++
 target/loongarch/insns.decode                | 13 +++
 target/loongarch/lasx_helper.c               | 37 +++++++++
 5 files changed, 154 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 83efde440f..18fa454be8 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1978,6 +1978,15 @@ INSN_LASX(xvmod_hu,          xxx)
 INSN_LASX(xvmod_wu,          xxx)
 INSN_LASX(xvmod_du,          xxx)
 
+INSN_LASX(xvsat_b,           xx_i)
+INSN_LASX(xvsat_h,           xx_i)
+INSN_LASX(xvsat_w,           xx_i)
+INSN_LASX(xvsat_d,           xx_i)
+INSN_LASX(xvsat_bu,          xx_i)
+INSN_LASX(xvsat_hu,          xx_i)
+INSN_LASX(xvsat_wu,          xx_i)
+INSN_LASX(xvsat_du,          xx_i)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 95c7ecba3b..741872a24d 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -886,3 +886,12 @@ DEF_HELPER_4(xvmod_bu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvmod_hu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvmod_wu, void, env, i32, i32, i32)
 DEF_HELPER_4(xvmod_du, void, env, i32, i32, i32)
+
+DEF_HELPER_FLAGS_4(xvsat_b, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_h, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_w, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_d, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_bu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_hu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_wu, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
+DEF_HELPER_FLAGS_4(xvsat_du, TCG_CALL_NO_RWG, void, ptr, ptr, i64, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 930872c939..350d575a6a 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -1747,6 +1747,92 @@ TRANS(xvmod_hu, gen_xxx, gen_helper_xvmod_hu)
 TRANS(xvmod_wu, gen_xxx, gen_helper_xvmod_wu)
 TRANS(xvmod_du, gen_xxx, gen_helper_xvmod_du)
 
+static void do_xvsat_s(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_smax_vec, INDEX_op_smin_vec, 0
+        };
+    static const GVecGen2s op[4] = {
+        {
+            .fniv = gen_vsat_s,
+            .fno = gen_helper_xvsat_b,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vsat_s,
+            .fno = gen_helper_xvsat_h,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vsat_s,
+            .fno = gen_helper_xvsat_w,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vsat_s,
+            .fno = gen_helper_xvsat_d,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    tcg_gen_gvec_2s(xd_ofs, xj_ofs, oprsz, maxsz,
+                    tcg_constant_i64((1ll << imm) - 1), &op[vece]);
+}
+
+TRANS(xvsat_b, gvec_xx_i, MO_8, do_xvsat_s)
+TRANS(xvsat_h, gvec_xx_i, MO_16, do_xvsat_s)
+TRANS(xvsat_w, gvec_xx_i, MO_32, do_xvsat_s)
+TRANS(xvsat_d, gvec_xx_i, MO_64, do_xvsat_s)
+
+static void do_xvsat_u(unsigned vece, uint32_t xd_ofs, uint32_t xj_ofs,
+                       int64_t imm, uint32_t oprsz, uint32_t maxsz)
+{
+    uint64_t max;
+    static const TCGOpcode vecop_list[] = {
+        INDEX_op_umin_vec, 0
+        };
+    static const GVecGen2s op[4] = {
+        {
+            .fniv = gen_vsat_u,
+            .fno = gen_helper_xvsat_bu,
+            .opt_opc = vecop_list,
+            .vece = MO_8
+        },
+        {
+            .fniv = gen_vsat_u,
+            .fno = gen_helper_xvsat_hu,
+            .opt_opc = vecop_list,
+            .vece = MO_16
+        },
+        {
+            .fniv = gen_vsat_u,
+            .fno = gen_helper_xvsat_wu,
+            .opt_opc = vecop_list,
+            .vece = MO_32
+        },
+        {
+            .fniv = gen_vsat_u,
+            .fno = gen_helper_xvsat_du,
+            .opt_opc = vecop_list,
+            .vece = MO_64
+        },
+    };
+
+    max = (imm == 0x3f) ? UINT64_MAX : (1ull << (imm + 1)) - 1;
+    tcg_gen_gvec_2s(xd_ofs, xj_ofs, oprsz, maxsz,
+                    tcg_constant_i64(max), &op[vece]);
+}
+
+TRANS(xvsat_bu, gvec_xx_i, MO_8, do_xvsat_u)
+TRANS(xvsat_hu, gvec_xx_i, MO_16, do_xvsat_u)
+TRANS(xvsat_wu, gvec_xx_i, MO_32, do_xvsat_u)
+TRANS(xvsat_du, gvec_xx_i, MO_64, do_xvsat_u)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 0bd4e7709a..9efb5f2032 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1314,7 +1314,11 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xxx                .... ........ ..... xk:5 xj:5 xd:5    &xxx
 @xr                .... ........ ..... ..... rj:5 xd:5    &xr
 @xx_i5            .... ........ ..... imm:s5 xj:5 xd:5    &xx_i
+@xx_ui3         .... ........ ..... .. imm:3 xj:5 xd:5    &xx_i
+@xx_ui4          .... ........ ..... . imm:4 xj:5 xd:5    &xx_i
 @xx_ui5            .... ........ ..... imm:5 xj:5 xd:5    &xx_i
+@xx_ui6             .... ........ .... imm:6 xj:5 xd:5    &xx_i
+
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1578,6 +1582,15 @@ xvmod_hu         0111 01001110 01101 ..... ..... .....    @xxx
 xvmod_wu         0111 01001110 01110 ..... ..... .....    @xxx
 xvmod_du         0111 01001110 01111 ..... ..... .....    @xxx
 
+xvsat_b          0111 01110010 01000 01 ... ..... .....   @xx_ui3
+xvsat_h          0111 01110010 01000 1 .... ..... .....   @xx_ui4
+xvsat_w          0111 01110010 01001 ..... ..... .....    @xx_ui5
+xvsat_d          0111 01110010 0101 ...... ..... .....    @xx_ui6
+xvsat_bu         0111 01110010 10000 01 ... ..... .....   @xx_ui3
+xvsat_hu         0111 01110010 10000 1 .... ..... .....   @xx_ui4
+xvsat_wu         0111 01110010 10001 ..... ..... .....    @xx_ui5
+xvsat_du         0111 01110010 1001 ...... ..... .....    @xx_ui6
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index d4a4a7659a..33da60f2d8 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -601,3 +601,40 @@ XVDIV(xvmod_bu, 8, UXB, DO_REMU)
 XVDIV(xvmod_hu, 16, UXH, DO_REMU)
 XVDIV(xvmod_wu, 32, UXW, DO_REMU)
 XVDIV(xvmod_du, 64, UXD, DO_REMU)
+
+#define XVSAT_S(NAME, BIT, E)                                   \
+void HELPER(NAME)(void *xd, void *xj, uint64_t max, uint32_t v) \
+{                                                               \
+    int i;                                                      \
+    XReg *Xd = (XReg *)xd;                                      \
+    XReg *Xj = (XReg *)xj;                                      \
+    typedef __typeof(Xd->E(0)) TD;                              \
+                                                                \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                      \
+        Xd->E(i) = Xj->E(i) > (TD)max ? (TD)max :               \
+                   Xj->E(i) < (TD)~max ? (TD)~max : Xj->E(i);   \
+    }                                                           \
+}
+
+XVSAT_S(xvsat_b, 8, XB)
+XVSAT_S(xvsat_h, 16, XH)
+XVSAT_S(xvsat_w, 32, XW)
+XVSAT_S(xvsat_d, 64, XD)
+
+#define XVSAT_U(NAME, BIT, E)                                   \
+void HELPER(NAME)(void *xd, void *xj, uint64_t max, uint32_t v) \
+{                                                               \
+    int i;                                                      \
+    XReg *Xd = (XReg *)xd;                                      \
+    XReg *Xj = (XReg *)xj;                                      \
+    typedef __typeof(Xd->E(0)) TD;                              \
+                                                                \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                      \
+        Xd->E(i) = Xj->E(i) > (TD)max ? (TD)max : Xj->E(i);     \
+    }                                                           \
+}
+
+XVSAT_U(xvsat_bu, 8, UXB)
+XVSAT_U(xvsat_hu, 16, UXH)
+XVSAT_U(xvsat_wu, 32, UXW)
+XVSAT_U(xvsat_du, 64, UXD)
-- 
2.39.1


