Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436757436A5
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:11:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF943-0003U7-GB; Fri, 30 Jun 2023 04:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qF93y-0003MX-Im
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qF93u-00006g-W9
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:01:06 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxQ8Rhi55kojQEAA--.6813S3;
 Fri, 30 Jun 2023 15:59:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjiNIi55kExQTAA--.24469S38; 
 Fri, 30 Jun 2023 15:59:29 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 36/46] target/loongarch: Implement LASX fpu arith
 instructions
Date: Fri, 30 Jun 2023 15:58:54 +0800
Message-Id: <20230630075904.45940-37-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230630075904.45940-1-gaosong@loongson.cn>
References: <20230630075904.45940-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxjiNIi55kExQTAA--.24469S38
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
 target/loongarch/disas.c                     | 46 +++++++++++
 target/loongarch/helper.h                    | 80 +++++++++---------
 target/loongarch/insn_trans/trans_lasx.c.inc | 41 ++++++++++
 target/loongarch/insn_trans/trans_lsx.c.inc  | 26 +++---
 target/loongarch/insns.decode                | 41 ++++++++++
 target/loongarch/vec_helper.c                | 86 +++++++++++---------
 6 files changed, 228 insertions(+), 92 deletions(-)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 27d6252686..4af74f1ae9 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -1708,6 +1708,11 @@ static void output_v_i_x(DisasContext *ctx, arg_v_i *a, const char *mnemonic)
     output(ctx, mnemonic, "x%d, 0x%x", a->vd, a->imm);
 }
 
+static void output_vvvv_x(DisasContext *ctx, arg_vvvv *a, const char *mnemonic)
+{
+    output(ctx, mnemonic, "x%d, x%d, x%d, x%d", a->vd, a->vj, a->vk, a->va);
+}
+
 static void output_vvv_x(DisasContext *ctx, arg_vvv * a, const char *mnemonic)
 {
     output(ctx, mnemonic, "x%d, x%d, x%d", a->vd, a->vj, a->vk);
@@ -2240,6 +2245,47 @@ INSN_LASX(xvfrstp_h,         vvv)
 INSN_LASX(xvfrstpi_b,        vv_i)
 INSN_LASX(xvfrstpi_h,        vv_i)
 
+INSN_LASX(xvfadd_s,          vvv)
+INSN_LASX(xvfadd_d,          vvv)
+INSN_LASX(xvfsub_s,          vvv)
+INSN_LASX(xvfsub_d,          vvv)
+INSN_LASX(xvfmul_s,          vvv)
+INSN_LASX(xvfmul_d,          vvv)
+INSN_LASX(xvfdiv_s,          vvv)
+INSN_LASX(xvfdiv_d,          vvv)
+
+INSN_LASX(xvfmadd_s,         vvvv)
+INSN_LASX(xvfmadd_d,         vvvv)
+INSN_LASX(xvfmsub_s,         vvvv)
+INSN_LASX(xvfmsub_d,         vvvv)
+INSN_LASX(xvfnmadd_s,        vvvv)
+INSN_LASX(xvfnmadd_d,        vvvv)
+INSN_LASX(xvfnmsub_s,        vvvv)
+INSN_LASX(xvfnmsub_d,        vvvv)
+
+INSN_LASX(xvfmax_s,          vvv)
+INSN_LASX(xvfmax_d,          vvv)
+INSN_LASX(xvfmin_s,          vvv)
+INSN_LASX(xvfmin_d,          vvv)
+
+INSN_LASX(xvfmaxa_s,         vvv)
+INSN_LASX(xvfmaxa_d,         vvv)
+INSN_LASX(xvfmina_s,         vvv)
+INSN_LASX(xvfmina_d,         vvv)
+
+INSN_LASX(xvflogb_s,         vv)
+INSN_LASX(xvflogb_d,         vv)
+
+INSN_LASX(xvfclass_s,        vv)
+INSN_LASX(xvfclass_d,        vv)
+
+INSN_LASX(xvfsqrt_s,         vv)
+INSN_LASX(xvfsqrt_d,         vv)
+INSN_LASX(xvfrecip_s,        vv)
+INSN_LASX(xvfrecip_d,        vv)
+INSN_LASX(xvfrsqrt_s,        vv)
+INSN_LASX(xvfrsqrt_d,        vv)
+
 INSN_LASX(xvreplgr2vr_b,     vr)
 INSN_LASX(xvreplgr2vr_h,     vr)
 INSN_LASX(xvreplgr2vr_w,     vr)
diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
index fa8e946ddd..9c9462c886 100644
--- a/target/loongarch/helper.h
+++ b/target/loongarch/helper.h
@@ -531,46 +531,46 @@ DEF_HELPER_5(vfrstp_h, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vfrstpi_b, void, env, i32, i32, i32, i32)
 DEF_HELPER_5(vfrstpi_h, void, env, i32, i32, i32, i32)
 
-DEF_HELPER_4(vfadd_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfadd_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfsub_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmul_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfdiv_d, void, env, i32, i32, i32)
-
-DEF_HELPER_5(vfmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfmsub_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmadd_d, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_s, void, env, i32, i32, i32, i32)
-DEF_HELPER_5(vfnmsub_d, void, env, i32, i32, i32, i32)
-
-DEF_HELPER_4(vfmax_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmax_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmin_d, void, env, i32, i32, i32)
-
-DEF_HELPER_4(vfmaxa_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmaxa_d, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_s, void, env, i32, i32, i32)
-DEF_HELPER_4(vfmina_d, void, env, i32, i32, i32)
-
-DEF_HELPER_3(vflogb_s, void, env, i32, i32)
-DEF_HELPER_3(vflogb_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfclass_s, void, env, i32, i32)
-DEF_HELPER_3(vfclass_d, void, env, i32, i32)
-
-DEF_HELPER_3(vfsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfsqrt_d, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_s, void, env, i32, i32)
-DEF_HELPER_3(vfrecip_d, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_s, void, env, i32, i32)
-DEF_HELPER_3(vfrsqrt_d, void, env, i32, i32)
+DEF_HELPER_5(vfadd_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfadd_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfsub_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfsub_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmul_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmul_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfdiv_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfdiv_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_6(vfmadd_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfmadd_d, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfmsub_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfmsub_d, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfnmadd_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfnmadd_d, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfnmsub_s, void, env, i32, i32, i32, i32, i32)
+DEF_HELPER_6(vfnmsub_d, void, env, i32, i32, i32, i32, i32)
+
+DEF_HELPER_5(vfmax_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmax_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmin_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmin_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_5(vfmaxa_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmaxa_d, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmina_s, void, env, i32, i32, i32, i32)
+DEF_HELPER_5(vfmina_d, void, env, i32, i32, i32, i32)
+
+DEF_HELPER_4(vflogb_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vflogb_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(vfclass_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfclass_d, void, env, i32, i32, i32)
+
+DEF_HELPER_4(vfsqrt_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfsqrt_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrecip_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrecip_d, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrsqrt_s, void, env, i32, i32, i32)
+DEF_HELPER_4(vfrsqrt_d, void, env, i32, i32, i32)
 
 DEF_HELPER_3(vfcvtl_s_h, void, env, i32, i32)
 DEF_HELPER_3(vfcvth_s_h, void, env, i32, i32)
diff --git a/target/loongarch/insn_trans/trans_lasx.c.inc b/target/loongarch/insn_trans/trans_lasx.c.inc
index 4da02cdf08..f05092572d 100644
--- a/target/loongarch/insn_trans/trans_lasx.c.inc
+++ b/target/loongarch/insn_trans/trans_lasx.c.inc
@@ -618,6 +618,47 @@ TRANS(xvfrstp_h, gen_vvv, 32, gen_helper_vfrstp_h)
 TRANS(xvfrstpi_b, gen_vv_i, 32, gen_helper_vfrstpi_b)
 TRANS(xvfrstpi_h, gen_vv_i, 32, gen_helper_vfrstpi_h)
 
+TRANS(xvfadd_s, gen_vvv, 32, gen_helper_vfadd_s)
+TRANS(xvfadd_d, gen_vvv, 32, gen_helper_vfadd_d)
+TRANS(xvfsub_s, gen_vvv, 32, gen_helper_vfsub_s)
+TRANS(xvfsub_d, gen_vvv, 32, gen_helper_vfsub_d)
+TRANS(xvfmul_s, gen_vvv, 32, gen_helper_vfmul_s)
+TRANS(xvfmul_d, gen_vvv, 32, gen_helper_vfmul_d)
+TRANS(xvfdiv_s, gen_vvv, 32, gen_helper_vfdiv_s)
+TRANS(xvfdiv_d, gen_vvv, 32, gen_helper_vfdiv_d)
+
+TRANS(xvfmadd_s, gen_vvvv, 32, gen_helper_vfmadd_s)
+TRANS(xvfmadd_d, gen_vvvv, 32, gen_helper_vfmadd_d)
+TRANS(xvfmsub_s, gen_vvvv, 32, gen_helper_vfmsub_s)
+TRANS(xvfmsub_d, gen_vvvv, 32, gen_helper_vfmsub_d)
+TRANS(xvfnmadd_s, gen_vvvv, 32, gen_helper_vfnmadd_s)
+TRANS(xvfnmadd_d, gen_vvvv, 32, gen_helper_vfnmadd_d)
+TRANS(xvfnmsub_s, gen_vvvv, 32, gen_helper_vfnmsub_s)
+TRANS(xvfnmsub_d, gen_vvvv, 32, gen_helper_vfnmsub_d)
+
+TRANS(xvfmax_s, gen_vvv, 32, gen_helper_vfmax_s)
+TRANS(xvfmax_d, gen_vvv, 32, gen_helper_vfmax_d)
+TRANS(xvfmin_s, gen_vvv, 32, gen_helper_vfmin_s)
+TRANS(xvfmin_d, gen_vvv, 32, gen_helper_vfmin_d)
+
+TRANS(xvfmaxa_s, gen_vvv, 32, gen_helper_vfmaxa_s)
+TRANS(xvfmaxa_d, gen_vvv, 32, gen_helper_vfmaxa_d)
+TRANS(xvfmina_s, gen_vvv, 32, gen_helper_vfmina_s)
+TRANS(xvfmina_d, gen_vvv, 32, gen_helper_vfmina_d)
+
+TRANS(xvflogb_s, gen_vv, 32, gen_helper_vflogb_s)
+TRANS(xvflogb_d, gen_vv, 32, gen_helper_vflogb_d)
+
+TRANS(xvfclass_s, gen_vv, 32, gen_helper_vfclass_s)
+TRANS(xvfclass_d, gen_vv, 32, gen_helper_vfclass_d)
+
+TRANS(xvfsqrt_s, gen_vv, 32, gen_helper_vfsqrt_s)
+TRANS(xvfsqrt_d, gen_vv, 32, gen_helper_vfsqrt_d)
+TRANS(xvfrecip_s, gen_vv, 32, gen_helper_vfrecip_s)
+TRANS(xvfrecip_d, gen_vv, 32, gen_helper_vfrecip_d)
+TRANS(xvfrsqrt_s, gen_vv, 32, gen_helper_vfrsqrt_s)
+TRANS(xvfrsqrt_d, gen_vv, 32, gen_helper_vfrsqrt_d)
+
 TRANS(xvreplgr2vr_b, gvec_dup, 32, MO_8)
 TRANS(xvreplgr2vr_h, gvec_dup, 32, MO_16)
 TRANS(xvreplgr2vr_w, gvec_dup, 32, MO_32)
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 27fcadd1d4..98a50f2839 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4,17 +4,19 @@
  * Copyright (c) 2022-2023 Loongson Technology Corporation Limited
  */
 
-static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a,
+static bool gen_vvvv(DisasContext *ctx, arg_vvvv *a, uint32_t sz,
                      void (*func)(TCGv_ptr, TCGv_i32, TCGv_i32,
-                                  TCGv_i32, TCGv_i32))
+                                  TCGv_i32, TCGv_i32, TCGv_i32))
 {
     TCGv_i32 vd = tcg_constant_i32(a->vd);
     TCGv_i32 vj = tcg_constant_i32(a->vj);
     TCGv_i32 vk = tcg_constant_i32(a->vk);
     TCGv_i32 va = tcg_constant_i32(a->va);
+    TCGv_i32 oprsz = tcg_constant_i32(sz);
 
     CHECK_VEC;
-    func(cpu_env, vd, vj, vk, va);
+
+    func(cpu_env, oprsz, vd, vj, vk, va);
     return true;
 }
 
@@ -3596,14 +3598,14 @@ TRANS(vfmul_d, gen_vvv, 16, gen_helper_vfmul_d)
 TRANS(vfdiv_s, gen_vvv, 16, gen_helper_vfdiv_s)
 TRANS(vfdiv_d, gen_vvv, 16, gen_helper_vfdiv_d)
 
-TRANS(vfmadd_s, gen_vvvv, gen_helper_vfmadd_s)
-TRANS(vfmadd_d, gen_vvvv, gen_helper_vfmadd_d)
-TRANS(vfmsub_s, gen_vvvv, gen_helper_vfmsub_s)
-TRANS(vfmsub_d, gen_vvvv, gen_helper_vfmsub_d)
-TRANS(vfnmadd_s, gen_vvvv, gen_helper_vfnmadd_s)
-TRANS(vfnmadd_d, gen_vvvv, gen_helper_vfnmadd_d)
-TRANS(vfnmsub_s, gen_vvvv, gen_helper_vfnmsub_s)
-TRANS(vfnmsub_d, gen_vvvv, gen_helper_vfnmsub_d)
+TRANS(vfmadd_s, gen_vvvv, 16, gen_helper_vfmadd_s)
+TRANS(vfmadd_d, gen_vvvv, 16, gen_helper_vfmadd_d)
+TRANS(vfmsub_s, gen_vvvv, 16, gen_helper_vfmsub_s)
+TRANS(vfmsub_d, gen_vvvv, 16, gen_helper_vfmsub_d)
+TRANS(vfnmadd_s, gen_vvvv, 16, gen_helper_vfnmadd_s)
+TRANS(vfnmadd_d, gen_vvvv, 16, gen_helper_vfnmadd_d)
+TRANS(vfnmsub_s, gen_vvvv, 16, gen_helper_vfnmsub_s)
+TRANS(vfnmsub_d, gen_vvvv, 16, gen_helper_vfnmsub_d)
 
 TRANS(vfmax_s, gen_vvv, 16, gen_helper_vfmax_s)
 TRANS(vfmax_d, gen_vvv, 16, gen_helper_vfmax_d)
@@ -4241,7 +4243,7 @@ TRANS(vilvh_h, gen_vvv, 16, gen_helper_vilvh_h)
 TRANS(vilvh_w, gen_vvv, 16, gen_helper_vilvh_w)
 TRANS(vilvh_d, gen_vvv, 16, gen_helper_vilvh_d)
 
-TRANS(vshuf_b, gen_vvvv, gen_helper_vshuf_b)
+TRANS(vshuf_b, gen_vvvv, 16, gen_helper_vshuf_b)
 TRANS(vshuf_h, gen_vvv, 16, gen_helper_vshuf_h)
 TRANS(vshuf_w, gen_vvv, 16, gen_helper_vshuf_w)
 TRANS(vshuf_d, gen_vvv, 16, gen_helper_vshuf_d)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 6035fe139c..4224b0a4b1 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -1816,6 +1816,47 @@ xvfrstp_h        0111 01010010 10111 ..... ..... .....    @vvv
 xvfrstpi_b       0111 01101001 10100 ..... ..... .....    @vv_ui5
 xvfrstpi_h       0111 01101001 10101 ..... ..... .....    @vv_ui5
 
+xvfadd_s         0111 01010011 00001 ..... ..... .....    @vvv
+xvfadd_d         0111 01010011 00010 ..... ..... .....    @vvv
+xvfsub_s         0111 01010011 00101 ..... ..... .....    @vvv
+xvfsub_d         0111 01010011 00110 ..... ..... .....    @vvv
+xvfmul_s         0111 01010011 10001 ..... ..... .....    @vvv
+xvfmul_d         0111 01010011 10010 ..... ..... .....    @vvv
+xvfdiv_s         0111 01010011 10101 ..... ..... .....    @vvv
+xvfdiv_d         0111 01010011 10110 ..... ..... .....    @vvv
+
+xvfmadd_s        0000 10100001 ..... ..... ..... .....    @vvvv
+xvfmadd_d        0000 10100010 ..... ..... ..... .....    @vvvv
+xvfmsub_s        0000 10100101 ..... ..... ..... .....    @vvvv
+xvfmsub_d        0000 10100110 ..... ..... ..... .....    @vvvv
+xvfnmadd_s       0000 10101001 ..... ..... ..... .....    @vvvv
+xvfnmadd_d       0000 10101010 ..... ..... ..... .....    @vvvv
+xvfnmsub_s       0000 10101101 ..... ..... ..... .....    @vvvv
+xvfnmsub_d       0000 10101110 ..... ..... ..... .....    @vvvv
+
+xvfmax_s         0111 01010011 11001 ..... ..... .....    @vvv
+xvfmax_d         0111 01010011 11010 ..... ..... .....    @vvv
+xvfmin_s         0111 01010011 11101 ..... ..... .....    @vvv
+xvfmin_d         0111 01010011 11110 ..... ..... .....    @vvv
+
+xvfmaxa_s        0111 01010100 00001 ..... ..... .....    @vvv
+xvfmaxa_d        0111 01010100 00010 ..... ..... .....    @vvv
+xvfmina_s        0111 01010100 00101 ..... ..... .....    @vvv
+xvfmina_d        0111 01010100 00110 ..... ..... .....    @vvv
+
+xvflogb_s        0111 01101001 11001 10001 ..... .....    @vv
+xvflogb_d        0111 01101001 11001 10010 ..... .....    @vv
+
+xvfclass_s       0111 01101001 11001 10101 ..... .....    @vv
+xvfclass_d       0111 01101001 11001 10110 ..... .....    @vv
+
+xvfsqrt_s        0111 01101001 11001 11001 ..... .....    @vv
+xvfsqrt_d        0111 01101001 11001 11010 ..... .....    @vv
+xvfrecip_s       0111 01101001 11001 11101 ..... .....    @vv
+xvfrecip_d       0111 01101001 11001 11110 ..... .....    @vv
+xvfrsqrt_s       0111 01101001 11010 00001 ..... .....    @vv
+xvfrsqrt_d       0111 01101001 11010 00010 ..... .....    @vv
+
 xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
 xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
 xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
diff --git a/target/loongarch/vec_helper.c b/target/loongarch/vec_helper.c
index 0c7938d7cf..1ab864480c 100644
--- a/target/loongarch/vec_helper.c
+++ b/target/loongarch/vec_helper.c
@@ -2479,16 +2479,17 @@ static inline void vec_clear_cause(CPULoongArchState *env)
 }
 
 #define DO_3OP_F(NAME, BIT, E, FN)                          \
-void HELPER(NAME)(CPULoongArchState *env,                   \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,   \
                   uint32_t vd, uint32_t vj, uint32_t vk)    \
 {                                                           \
-    int i;                                                  \
+    int i, len;                                             \
     VReg *Vd = &(env->fpr[vd].vreg);                        \
     VReg *Vj = &(env->fpr[vj].vreg);                        \
     VReg *Vk = &(env->fpr[vk].vreg);                        \
                                                             \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;               \
     vec_clear_cause(env);                                   \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                     \
+    for (i = 0; i < len / BIT; i++) {                       \
         Vd->E(i) = FN(Vj->E(i), Vk->E(i), &env->fp_status); \
         vec_update_fcsr0(env, GETPC());                     \
     }                                                       \
@@ -2512,17 +2513,18 @@ DO_3OP_F(vfmina_s, 32, UW, float32_minnummag)
 DO_3OP_F(vfmina_d, 64, UD, float64_minnummag)
 
 #define DO_4OP_F(NAME, BIT, E, FN, flags)                                    \
-void HELPER(NAME)(CPULoongArchState *env,                                    \
+void HELPER(NAME)(CPULoongArchState *env, uint32_t oprsz,                    \
                   uint32_t vd, uint32_t vj, uint32_t vk, uint32_t va)        \
 {                                                                            \
-    int i;                                                                   \
+    int i, len;                                                              \
     VReg *Vd = &(env->fpr[vd].vreg);                                         \
     VReg *Vj = &(env->fpr[vj].vreg);                                         \
     VReg *Vk = &(env->fpr[vk].vreg);                                         \
     VReg *Va = &(env->fpr[va].vreg);                                         \
                                                                              \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;                                \
     vec_clear_cause(env);                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                                      \
+    for (i = 0; i < len / BIT; i++) {                                        \
         Vd->E(i) = FN(Vj->E(i), Vk->E(i), Va->E(i), flags, &env->fp_status); \
         vec_update_fcsr0(env, GETPC());                                      \
     }                                                                        \
@@ -2539,47 +2541,51 @@ DO_4OP_F(vfnmsub_s, 32, UW, float32_muladd,
 DO_4OP_F(vfnmsub_d, 64, UD, float64_muladd,
          float_muladd_negate_c | float_muladd_negate_result)
 
-#define DO_2OP_F(NAME, BIT, E, FN)                                  \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    vec_clear_cause(env);                                           \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define DO_2OP_F(NAME, BIT, E, FN)                          \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
+{                                                           \
+    int i, len;                                             \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;               \
+    vec_clear_cause(env);                                   \
+    for (i = 0; i < len / BIT; i++) {                       \
+        Vd->E(i) = FN(env, Vj->E(i));                       \
+    }                                                       \
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
+static T do_flogb_## BIT(CPULoongArchState *env, T fj)         \
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
 FLOGB(64, uint64_t)
 
-#define FCLASS(NAME, BIT, E, FN)                                    \
-void HELPER(NAME)(CPULoongArchState *env, uint32_t vd, uint32_t vj) \
-{                                                                   \
-    int i;                                                          \
-    VReg *Vd = &(env->fpr[vd].vreg);                                \
-    VReg *Vj = &(env->fpr[vj].vreg);                                \
-                                                                    \
-    for (i = 0; i < LSX_LEN/BIT; i++) {                             \
-        Vd->E(i) = FN(env, Vj->E(i));                               \
-    }                                                               \
+#define FCLASS(NAME, BIT, E, FN)                            \
+void HELPER(NAME)(CPULoongArchState *env,                   \
+                  uint32_t oprsz, uint32_t vd, uint32_t vj) \
+{                                                           \
+    int i, len;                                             \
+    VReg *Vd = &(env->fpr[vd].vreg);                        \
+    VReg *Vj = &(env->fpr[vj].vreg);                        \
+                                                            \
+    len = (oprsz == 16) ? LSX_LEN : LASX_LEN;               \
+    for (i = 0; i < len / BIT; i++) {                       \
+        Vd->E(i) = FN(env, Vj->E(i));                       \
+    }                                                       \
 }
 
 FCLASS(vfclass_s, 32, UW, helper_fclass_s)
-- 
2.39.1


