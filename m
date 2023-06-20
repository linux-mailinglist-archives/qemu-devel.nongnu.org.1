Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F50B73681B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXpS-0007IY-9i; Tue, 20 Jun 2023 05:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qBXp7-0007CO-1b
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qBXp3-0006OZ-Di
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 05:38:52 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Cx8Oicc5Fk1SUHAA--.12760S3;
 Tue, 20 Jun 2023 17:38:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxduSGc5FkzIQhAA--.28394S38; 
 Tue, 20 Jun 2023 17:38:35 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v1 36/46] target/loongarch: Implement LASX fpu arith
 instructions
Date: Tue, 20 Jun 2023 17:38:04 +0800
Message-Id: <20230620093814.123650-37-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230620093814.123650-1-gaosong@loongson.cn>
References: <20230620093814.123650-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxduSGc5FkzIQhAA--.28394S38
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
- XVF{ADD/SUB/MUL/DIV}.{S/D};
- XVF{MADD/MSUB/NMADD/NMSUB}.{S/D};
- XVF{MAX/MIN}.{S/D};
- XVF{MAXA/MINA}.{S/D};
- XVFLOGB.{S/D};
- XVFCLASS.{S/D};
- XVF{SQRT/RECIP/RSQRT}.{S/D}.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/disas.c                     | 46 +++++++++
 target/loongarch/helper.h                    | 41 ++++++++
 target/loongarch/insn_trans/trans_lasx.c.inc | 55 +++++++++++
 target/loongarch/insns.decode                | 43 +++++++++
 target/loongarch/lasx_helper.c               | 99 ++++++++++++++++++++
 target/loongarch/lsx_helper.c                | 51 +++++-----
 target/loongarch/vec.h                       | 13 +++
 7 files changed, 322 insertions(+), 26 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 5340609e6f..0e4ec2bd03 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_x_i(DisasContext *ctx, arg_x_i *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, 0x%x", a->xd, a->imm);
 }
 
+static void output_xxxx(DisasContext *ctx, arg_xxxx *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, x%d, x%d", a->xd, a->xj, a->xk, a->xa);
+}
+
 static void output_xxx(DisasContext *ctx, arg_xxx * a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, x%d, x%d", a->xd, a->xj, a->xk);
@@ -2239,6 +2244,47 @@ INSN_LASX(xvfrstp_h,         xxx)
 INSN_LASX(xvfrstpi_b,        xx_i)
 INSN_LASX(xvfrstpi_h,        xx_i)
 
+INSN_LASX(xvfadd_s,          xxx)
+INSN_LASX(xvfadd_d,          xxx)
+INSN_LASX(xvfsub_s,          xxx)
+INSN_LASX(xvfsub_d,          xxx)
+INSN_LASX(xvfmul_s,          xxx)
+INSN_LASX(xvfmul_d,          xxx)
+INSN_LASX(xvfdiv_s,          xxx)
+INSN_LASX(xvfdiv_d,          xxx)
+
+INSN_LASX(xvfmadd_s,         xxxx)
+INSN_LASX(xvfmadd_d,         xxxx)
+INSN_LASX(xvfmsub_s,         xxxx)
+INSN_LASX(xvfmsub_d,         xxxx)
+INSN_LASX(xvfnmadd_s,        xxxx)
+INSN_LASX(xvfnmadd_d,        xxxx)
+INSN_LASX(xvfnmsub_s,        xxxx)
+INSN_LASX(xvfnmsub_d,        xxxx)
+
+INSN_LASX(xvfmax_s,          xxx)
+INSN_LASX(xvfmax_d,          xxx)
+INSN_LASX(xvfmin_s,          xxx)
+INSN_LASX(xvfmin_d,          xxx)
+
+INSN_LASX(xvfmaxa_s,         xxx)
+INSN_LASX(xvfmaxa_d,         xxx)
+INSN_LASX(xvfmina_s,         xxx)
+INSN_LASX(xvfmina_d,         xxx)
+
+INSN_LASX(xvflogb_s,         xx)
+INSN_LASX(xvflogb_d,         xx)
+
+INSN_LASX(xvfclass_s,        xx)
+INSN_LASX(xvfclass_d,        xx)
+
+INSN_LASX(xvfsqrt_s,         xx)
+INSN_LASX(xvfsqrt_d,         xx)
+INSN_LASX(xvfrecip_s,        xx)
+INSN_LASX(xvfrecip_d,        xx)
+INSN_LASX(xvfrsqrt_s,        xx)
+INSN_LASX(xvfrsqrt_d,        xx)
+
 INSN_LASX(xvreplgr2vr_b,     xr)
 INSN_LASX(xvreplgr2vr_h,     xr)
 INSN_LASX(xvreplgr2vr_w,     xr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index 4db0cd25d3..2e6e3f2fd3 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -1096,3 +1096,44 @@ DEF_HELPER_4(xvfrstp_b, void, env, i32, i32, i32)
 DEF_HELPER_4(xvfrstp_h, void, env, i32, i32, i32)
 DEF_HELPER_4(xvfrstpi_b, void, env, i32, i32, i32)
 DEF_HELPER_4(xvfrstpi_h, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvfadd_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfadd_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfsub_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfsub_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmul_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmul_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfdiv_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfdiv_d, void, env, i32, i32, i32)
+
+DEF_HELPER_5(xvfmadd_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfmadd_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfmsub_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfmsub_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfnmadd_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfnmadd_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfnmsub_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(xvfnmsub_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_4(xvfmax_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmax_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmin_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmin_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(xvfmaxa_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmaxa_d, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmina_s, void, env, i32, i32, i32)
+DEF_HELPER_4(xvfmina_d, void, env, i32, i32, i32)
+
+DEF_HELPER_3(xvflogb_s, void, env, i32, i32)
+DEF_HELPER_3(xvflogb_d, void, env, i32, i32)
+
+DEF_HELPER_3(xvfclass_s, void, env, i32, i32)
+DEF_HELPER_3(xvfclass_d, void, env, i32, i32)
+
+DEF_HELPER_3(xvfsqrt_s, void, env, i32, i32)
+DEF_HELPER_3(xvfsqrt_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrecip_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrecip_d, void, env, i32, i32)
+DEF_HELPER_3(xvfrsqrt_s, void, env, i32, i32)
+DEF_HELPER_3(xvfrsqrt_d, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index beeb9b3ff8..b9785be6c5 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -15,6 +15,20 @@
 #define CHECK_ASXE
 #endif
 
+static bool gen_xxxx(DisasContext *ctx, arg_xxxx *a,
+                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
+                                  TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 xd = tcg_constant_i32(a->xd);
+    TCGv_i32 xj = tcg_constant_i32(a->xj);
+    TCGv_i32 xk = tcg_constant_i32(a->xk);
+    TCGv_i32 xa = tcg_constant_i32(a->xa);
+
+    CHECK_ASXE;
+    func(cpu_env, xd, xj, xk, xa);
+    return true;
+}
+
 static bool gen_xxx(DisasContext *ctx, arg_xxx *a,
                     void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32, TCGv_i32))
 {
@@ -2409,6 +2423,47 @@ TRANS(xvfrstp_h, gen_xxx, gen_helper_xvfrstp_h)
 TRANS(xvfrstpi_b, gen_xx_i, gen_helper_xvfrstpi_b)
 TRANS(xvfrstpi_h, gen_xx_i, gen_helper_xvfrstpi_h)
 
+TRANS(xvfadd_s, gen_xxx, gen_helper_xvfadd_s)
+TRANS(xvfadd_d, gen_xxx, gen_helper_xvfadd_d)
+TRANS(xvfsub_s, gen_xxx, gen_helper_xvfsub_s)
+TRANS(xvfsub_d, gen_xxx, gen_helper_xvfsub_d)
+TRANS(xvfmul_s, gen_xxx, gen_helper_xvfmul_s)
+TRANS(xvfmul_d, gen_xxx, gen_helper_xvfmul_d)
+TRANS(xvfdiv_s, gen_xxx, gen_helper_xvfdiv_s)
+TRANS(xvfdiv_d, gen_xxx, gen_helper_xvfdiv_d)
+
+TRANS(xvfmadd_s, gen_xxxx, gen_helper_xvfmadd_s)
+TRANS(xvfmadd_d, gen_xxxx, gen_helper_xvfmadd_d)
+TRANS(xvfmsub_s, gen_xxxx, gen_helper_xvfmsub_s)
+TRANS(xvfmsub_d, gen_xxxx, gen_helper_xvfmsub_d)
+TRANS(xvfnmadd_s, gen_xxxx, gen_helper_xvfnmadd_s)
+TRANS(xvfnmadd_d, gen_xxxx, gen_helper_xvfnmadd_d)
+TRANS(xvfnmsub_s, gen_xxxx, gen_helper_xvfnmsub_s)
+TRANS(xvfnmsub_d, gen_xxxx, gen_helper_xvfnmsub_d)
+
+TRANS(xvfmax_s, gen_xxx, gen_helper_xvfmax_s)
+TRANS(xvfmax_d, gen_xxx, gen_helper_xvfmax_d)
+TRANS(xvfmin_s, gen_xxx, gen_helper_xvfmin_s)
+TRANS(xvfmin_d, gen_xxx, gen_helper_xvfmin_d)
+
+TRANS(xvfmaxa_s, gen_xxx, gen_helper_xvfmaxa_s)
+TRANS(xvfmaxa_d, gen_xxx, gen_helper_xvfmaxa_d)
+TRANS(xvfmina_s, gen_xxx, gen_helper_xvfmina_s)
+TRANS(xvfmina_d, gen_xxx, gen_helper_xvfmina_d)
+
+TRANS(xvflogb_s, gen_xx, gen_helper_xvflogb_s)
+TRANS(xvflogb_d, gen_xx, gen_helper_xvflogb_d)
+
+TRANS(xvfclass_s, gen_xx, gen_helper_xvfclass_s)
+TRANS(xvfclass_d, gen_xx, gen_helper_xvfclass_d)
+
+TRANS(xvfsqrt_s, gen_xx, gen_helper_xvfsqrt_s)
+TRANS(xvfsqrt_d, gen_xx, gen_helper_xvfsqrt_d)
+TRANS(xvfrecip_s, gen_xx, gen_helper_xvfrecip_s)
+TRANS(xvfrecip_d, gen_xx, gen_helper_xvfrecip_d)
+TRANS(xvfrsqrt_s, gen_xx, gen_helper_xvfrsqrt_s)
+TRANS(xvfrsqrt_d, gen_xx, gen_helper_xvfrsqrt_d)
+
 static bool gvec_dupx(DisasContext *ctx, arg_xr *a, MemOp mop)
 {
     TCGv src = gpr_src(ctx, a->rj, EXT_NONE);
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 387c1e5776..8a5d6a8d45 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1306,6 +1306,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 &xr           xd rj
 &xx_i         xd xj imm
 &x_i          xd imm
+&xxxx         xd xj xk xa
 
 #
 # LASX Formats
@@ -1322,6 +1323,7 @@ vstelm_b         0011 000110 .... ........ ..... .....    @vr_i8i4
 @xx_ui6             .... ........ .... imm:6 xj:5 xd:5    &xx_i
 @xx_ui7              .... ........ ... imm:7 xj:5 xd:5    &xx_i
 @xx_ui8               .... ........ .. imm:8 xj:5 xd:5    &xx_i
+@xxxx                .... ........ xa:5 xk:5 xj:5 xd:5    &xxxx
 
 xvadd_b          0111 01000000 10100 ..... ..... .....    @xxx
 xvadd_h          0111 01000000 10101 ..... ..... .....    @xxx
@@ -1839,6 +1841,47 @@ xvfrstp_h        0111 01010010 10111 ..... ..... .....    @xxx
 xvfrstpi_b       0111 01101001 10100 ..... ..... .....    @xx_ui5
 xvfrstpi_h       0111 01101001 10101 ..... ..... .....    @xx_ui5
 
+xvfadd_s         0111 01010011 00001 ..... ..... .....    @xxx
+xvfadd_d         0111 01010011 00010 ..... ..... .....    @xxx
+xvfsub_s         0111 01010011 00101 ..... ..... .....    @xxx
+xvfsub_d         0111 01010011 00110 ..... ..... .....    @xxx
+xvfmul_s         0111 01010011 10001 ..... ..... .....    @xxx
+xvfmul_d         0111 01010011 10010 ..... ..... .....    @xxx
+xvfdiv_s         0111 01010011 10101 ..... ..... .....    @xxx
+xvfdiv_d         0111 01010011 10110 ..... ..... .....    @xxx
+
+xvfmadd_s        0000 10100001 ..... ..... ..... .....    @xxxx
+xvfmadd_d        0000 10100010 ..... ..... ..... .....    @xxxx
+xvfmsub_s        0000 10100101 ..... ..... ..... .....    @xxxx
+xvfmsub_d        0000 10100110 ..... ..... ..... .....    @xxxx
+xvfnmadd_s       0000 10101001 ..... ..... ..... .....    @xxxx
+xvfnmadd_d       0000 10101010 ..... ..... ..... .....    @xxxx
+xvfnmsub_s       0000 10101101 ..... ..... ..... .....    @xxxx
+xvfnmsub_d       0000 10101110 ..... ..... ..... .....    @xxxx
+
+xvfmax_s         0111 01010011 11001 ..... ..... .....    @xxx
+xvfmax_d         0111 01010011 11010 ..... ..... .....    @xxx
+xvfmin_s         0111 01010011 11101 ..... ..... .....    @xxx
+xvfmin_d         0111 01010011 11110 ..... ..... .....    @xxx
+
+xvfmaxa_s        0111 01010100 00001 ..... ..... .....    @xxx
+xvfmaxa_d        0111 01010100 00010 ..... ..... .....    @xxx
+xvfmina_s        0111 01010100 00101 ..... ..... .....    @xxx
+xvfmina_d        0111 01010100 00110 ..... ..... .....    @xxx
+
+xvflogb_s        0111 01101001 11001 10001 ..... .....    @xx
+xvflogb_d        0111 01101001 11001 10010 ..... .....    @xx
+
+xvfclass_s       0111 01101001 11001 10101 ..... .....    @xx
+xvfclass_d       0111 01101001 11001 10110 ..... .....    @xx
+
+xvfsqrt_s        0111 01101001 11001 11001 ..... .....    @xx
+xvfsqrt_d        0111 01101001 11001 11010 ..... .....    @xx
+xvfrecip_s       0111 01101001 11001 11101 ..... .....    @xx
+xvfrecip_d       0111 01101001 11001 11110 ..... .....    @xx
+xvfrsqrt_s       0111 01101001 11010 00001 ..... .....    @xx
+xvfrsqrt_d       0111 01101001 11010 00010 ..... .....    @xx
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @xr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @xr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @xr
diff --git a/target/loongarch/lasx_helper.c b/target/loongarch/lasx_helper.c
index 011eab46fb..316ebd3463 100644
--- a/target/loongarch/lasx_helper.c
+++ b/target/loongarch/lasx_helper.c
@@ -9,6 +9,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 #include "internals.h"
 #include "vec.h"
 
@@ -2226,3 +2227,101 @@ void HELPER(NAME)(CPULoongArchState *env,                 \
 
 XVFRSTPI(xvfrstpi_b, 8, XB)
 XVFRSTPI(xvfrstpi_h, 16, XH)
+
+#define XDO_3OP_F(NAME, BIT, E, FN)                         \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t xd, uint32_t xj, uint32_t xk)    \
+{                                                           \
+    int i;                                                  \
+    XReg *Xd = &(env->fpr[xd].xreg);                        \
+    XReg *Xj = &(env->fpr[xj].xreg);                        \
+    XReg *Xk = &(env->fpr[xk].xreg);                        \
+                                                            \
+    vec_clear_cause(env);                                   \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                  \
+        Xd->E(i) = FN(Xj->E(i), Xk->E(i), &env->fp_status); \
+        vec_update_fcsr0(env, GETPC());                     \
+    }                                                       \
+}
+
+XDO_3OP_F(xvfadd_s, 32, UXW, float32_add)
+XDO_3OP_F(xvfadd_d, 64, UXD, float64_add)
+XDO_3OP_F(xvfsub_s, 32, UXW, float32_sub)
+XDO_3OP_F(xvfsub_d, 64, UXD, float64_sub)
+XDO_3OP_F(xvfmul_s, 32, UXW, float32_mul)
+XDO_3OP_F(xvfmul_d, 64, UXD, float64_mul)
+XDO_3OP_F(xvfdiv_s, 32, UXW, float32_div)
+XDO_3OP_F(xvfdiv_d, 64, UXD, float64_div)
+XDO_3OP_F(xvfmax_s, 32, UXW, float32_maxnum)
+XDO_3OP_F(xvfmax_d, 64, UXD, float64_maxnum)
+XDO_3OP_F(xvfmin_s, 32, UXW, float32_minnum)
+XDO_3OP_F(xvfmin_d, 64, UXD, float64_minnum)
+XDO_3OP_F(xvfmaxa_s, 32, UXW, float32_maxnummag)
+XDO_3OP_F(xvfmaxa_d, 64, UXD, float64_maxnummag)
+XDO_3OP_F(xvfmina_s, 32, UXW, float32_minnummag)
+XDO_3OP_F(xvfmina_d, 64, UXD, float64_minnummag)
+
+#define XDO_4OP_F(NAME, BIT, E, FN, flags)                                   \
+void HELPER(NAME)(CPULoongArchState *env,                                    \
+                  uint32_t xd, uint32_t xj, uint32_t xk, uint32_t xa)        \
+{                                                                            \
+    int i;                                                                   \
+    XReg *Xd = &(env->fpr[xd].xreg);                                         \
+    XReg *Xj = &(env->fpr[xj].xreg);                                         \
+    XReg *Xk = &(env->fpr[xk].xreg);                                         \
+    XReg *Xa = &(env->fpr[xa].xreg);                                         \
+                                                                             \
+    vec_clear_cause(env);                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                                   \
+        Xd->E(i) = FN(Xj->E(i), Xk->E(i), Xa->E(i), flags, &env->fp_status); \
+        vec_update_fcsr0(env, GETPC());                                      \
+    }                                                                        \
+}
+
+XDO_4OP_F(xvfmadd_s, 32, UXW, float32_muladd, 0)
+XDO_4OP_F(xvfmadd_d, 64, UXD, float64_muladd, 0)
+XDO_4OP_F(xvfmsub_s, 32, UXW, float32_muladd, float_muladd_negate_c)
+XDO_4OP_F(xvfmsub_d, 64, UXD, float64_muladd, float_muladd_negate_c)
+XDO_4OP_F(xvfnmadd_s, 32, UXW, float32_muladd, float_muladd_negate_result)
+XDO_4OP_F(xvfnmadd_d, 64, UXD, float64_muladd, float_muladd_negate_result)
+XDO_4OP_F(xvfnmsub_s, 32, UXW, float32_muladd,
+         float_muladd_negate_c | float_muladd_negate_result)
+XDO_4OP_F(xvfnmsub_d, 64, UXD, float64_muladd,
+         float_muladd_negate_c | float_muladd_negate_result)
+
+#define XDO_2OP_F(NAME, BIT, E, FN)                                 \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    vec_clear_cause(env);                                           \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E(i) = FN(env, Xj->E(i));                               \
+    }                                                               \
+}
+
+#define XFCLASS(NAME, BIT, E, FN)                                   \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t xd, uint32_t xj) \
+{                                                                   \
+    int i;                                                          \
+    XReg *Xd = &(env->fpr[xd].xreg);                                \
+    XReg *Xj = &(env->fpr[xj].xreg);                                \
+                                                                    \
+    for (i = 0; i < LASX_LEN / BIT; i++) {                          \
+        Xd->E(i) = FN(env, Xj->E(i));                               \
+    }                                                               \
+}
+
+XFCLASS(xvfclass_s, 32, UXW, helper_fclass_s)
+XFCLASS(xvfclass_d, 64, UXD, helper_fclass_d)
+
+XDO_2OP_F(xvflogb_s, 32, UXW, do_flogb_32)
+XDO_2OP_F(xvflogb_d, 64, UXD, do_flogb_64)
+XDO_2OP_F(xvfsqrt_s, 32, UXW, do_fsqrt_32)
+XDO_2OP_F(xvfsqrt_d, 64, UXD, do_fsqrt_64)
+XDO_2OP_F(xvfrecip_s, 32, UXW, do_frecip_32)
+XDO_2OP_F(xvfrecip_d, 64, UXD, do_frecip_64)
+XDO_2OP_F(xvfrsqrt_s, 32, UXW, do_frsqrt_32)
+XDO_2OP_F(xvfrsqrt_d, 64, UXD, do_frsqrt_64)
diff --git a/target/loongarch/lsx_helper.c b/target/loongarch/lsx_helper.c
index b9fdcd3ed7..446a1bdfe3 100644
--- a/target/loongarch/lsx_helper.c
+++ b/target/loongarch/lsx_helper.c
@@ -2029,8 +2029,7 @@ void HELPER(NAME)(CPULoongArchState *env,                 \
 VFRSTPI(vfrstpi_b, 8,  B)
 VFRSTPI(vfrstpi_h, 16, H)
 
-static void vec_update_fcsr0_mask(CPULoongArchState *env,
-                                  uintptr_t pc, int mask)
+void vec_update_fcsr0_mask(CPULoongArchState *env, uintptr_t pc, int mask)
 {
     int flags = get_float_exception_flags(&env->fp_status);
 
@@ -2050,12 +2049,12 @@ static void vec_update_fcsr0_mask(CPULoongArchState *env,
     }
 }
 
-static void vec_update_fcsr0(CPULoongArchState *env, uintptr_t pc)
+void vec_update_fcsr0(CPULoongArchState *env, uintptr_t pc)
 {
     vec_update_fcsr0_mask(env, pc, 0);
 }
 
-static inline void vec_clear_cause(CPULoongArchState *env)
+inline void vec_clear_cause(CPULoongArchState *env)
 {
     SET_FP_CAUSE(env->fcsr0, 0);
 }
@@ -2134,19 +2133,19 @@ void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
     }                                                               \
 }
 
-#define FLOGB(BIT, T)                                            \
-static T do_flogb_## BIT(CPULoongArchState *env, T fj)           \
-{                                                                \
-    T fp, fd;                                                    \
-    float_status *status = &env->fp_status;                      \
-    FloatRoundMode old_mode = get_float_rounding_mode(status);   \
-                                                                 \
-    set_float_rounding_mode(float_round_down, status);           \
-    fp = float ## BIT ##_log2(fj, status);                       \
-    fd = float ## BIT ##_round_to_int(fp, status);               \
-    set_float_rounding_mode(old_mode, status);                   \
-    vec_update_fcsr0_mask(env, GETPC(), float_flag_inexact);     \
-    return fd;                                                   \
+#define FLOGB(BIT, T)                                          \
+T do_flogb_## BIT(CPULoongArchState *env, T fj)                \
+{                                                              \
+    T fp, fd;                                                  \
+    float_status *status = &env->fp_status;                    \
+    FloatRoundMode old_mode = get_float_rounding_mode(status); \
+                                                               \
+    set_float_rounding_mode(float_round_down, status);         \
+    fp = float ## BIT ##_log2(fj, status);                     \
+    fd = float ## BIT ##_round_to_int(fp, status);             \
+    set_float_rounding_mode(old_mode, status);                 \
+    vec_update_fcsr0_mask(env, GETPC(), float_flag_inexact);   \
+    return fd;                                                 \
 }
 
 FLOGB(32, uint32_t)
@@ -2167,20 +2166,20 @@ void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
 FCLASS(vfclass_s, 32, UW, helper_fclass_s)
 FCLASS(vfclass_d, 64, UD, helper_fclass_d)
 
-#define FSQRT(BIT, T)                                  \
-static T do_fsqrt_## BIT(CPULoongArchState *env, T fj) \
-{                                                      \
-    T fd;                                              \
-    fd = float ## BIT ##_sqrt(fj, &env->fp_status);    \
-    vec_update_fcsr0(env, GETPC());                    \
-    return fd;                                         \
+#define FSQRT(BIT, T)                               \
+T do_fsqrt_## BIT(CPULoongArchState *env, T fj)     \
+{                                                   \
+    T fd;                                           \
+    fd = float ## BIT ##_sqrt(fj, &env->fp_status); \
+    vec_update_fcsr0(env, GETPC());                 \
+    return fd;                                      \
 }
 
 FSQRT(32, uint32_t)
 FSQRT(64, uint64_t)
 
 #define FRECIP(BIT, T)                                                  \
-static T do_frecip_## BIT(CPULoongArchState *env, T fj)                 \
+T do_frecip_## BIT(CPULoongArchState *env, T fj)                        \
 {                                                                       \
     T fd;                                                               \
     fd = float ## BIT ##_div(float ## BIT ##_one, fj, &env->fp_status); \
@@ -2192,7 +2191,7 @@ FRECIP(32, uint32_t)
 FRECIP(64, uint64_t)
 
 #define FRSQRT(BIT, T)                                                  \
-static T do_frsqrt_## BIT(CPULoongArchState *env, T fj)                 \
+T do_frsqrt_## BIT(CPULoongArchState *env, T fj)                        \
 {                                                                       \
     T fd, fp;                                                           \
     fp = float ## BIT ##_sqrt(fj, &env->fp_status);                     \
diff --git a/target/loongarch/vec.h b/target/loongarch/vec.h
index 4d9c4eb85f..583997d576 100644
--- a/target/loongarch/vec.h
+++ b/target/loongarch/vec.h
@@ -96,4 +96,17 @@ uint64_t do_vmskltz_w(int64_t val);
 uint64_t do_vmskltz_d(int64_t val);
 uint64_t do_vmskez_b(uint64_t val);
 
+void vec_update_fcsr0_mask(CPULoongArchState *env, uintptr_t pc, int mask);
+void vec_update_fcsr0(CPULoongArchState *env, uintptr_t pc);
+void vec_clear_cause(CPULoongArchState *env);
+
+uint32_t do_flogb_32(CPULoongArchState *env, uint32_t fj);
+uint64_t do_flogb_64(CPULoongArchState *env, uint64_t fj);
+uint32_t do_fsqrt_32(CPULoongArchState *env, uint32_t fj);
+uint64_t do_fsqrt_64(CPULoongArchState *env, uint64_t fj);
+uint32_t do_frecip_32(CPULoongArchState *env, uint32_t fj);
+uint64_t do_frecip_64(CPULoongArchState *env, uint64_t fj);
+uint32_t do_frsqrt_32(CPULoongArchState *env, uint32_t fj);
+uint64_t do_frsqrt_64(CPULoongArchState *env, uint64_t fj);
+
 #endif /* LOONGARCH_VEC_H */
-- 
2.39.1


