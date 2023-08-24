Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB38786BCC
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6bp-000450-U0; Thu, 24 Aug 2023 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6bg-0003dR-MV
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6bZ-0004Dk-TU
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:26:23 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxlPDCIedkXXkbAA--.56195S3;
 Thu, 24 Aug 2023 17:24:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S15; 
 Thu, 24 Aug 2023 17:24:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/31] target/loongarch: Extract make_address_x() helper
Date: Thu, 24 Aug 2023 17:23:51 +0800
Message-Id: <20230824092409.1492470-14-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S15
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230822071405.35386-6-philmd@linaro.org>
---
 .../loongarch/insn_trans/trans_fmemory.c.inc   | 18 ++++++------------
 target/loongarch/insn_trans/trans_lsx.c.inc    |  6 ++----
 target/loongarch/insn_trans/trans_memory.c.inc |  6 ++----
 target/loongarch/translate.c                   | 12 ++++++++++++
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_fmemory.c.inc b/target/loongarch/insn_trans/trans_fmemory.c.inc
index 91c09fb6d9..88ad209338 100644
--- a/target/loongarch/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/insn_trans/trans_fmemory.c.inc
@@ -57,8 +57,7 @@ static bool gen_floadx(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -75,8 +74,7 @@ static bool gen_fstorex(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -91,9 +89,8 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -110,9 +107,8 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtgt_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -127,9 +123,8 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -146,9 +141,8 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
 
     CHECK_FPE;
 
-    addr = tcg_temp_new();
     gen_helper_asrtle_d(cpu_env, src1, src2);
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
diff --git a/target/loongarch/insn_trans/trans_lsx.c.inc b/target/loongarch/insn_trans/trans_lsx.c.inc
index 68779daff6..875cb7d51d 100644
--- a/target/loongarch/insn_trans/trans_lsx.c.inc
+++ b/target/loongarch/insn_trans/trans_lsx.c.inc
@@ -4315,14 +4315,13 @@ static bool trans_vldx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     rl = tcg_temp_new_i64();
     rh = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     tcg_gen_qemu_ld_i128(val, addr, ctx->mem_idx, MO_128 | MO_TE);
     tcg_gen_extr_i128_i64(rl, rh, val);
     set_vreg64(rh, a->vd, 1);
@@ -4339,14 +4338,13 @@ static bool trans_vstx(DisasContext *ctx, arg_vrr *a)
 
     CHECK_SXE;
 
-    addr = tcg_temp_new();
     src1 = gpr_src(ctx, a->rj, EXT_NONE);
     src2 = gpr_src(ctx, a->rk, EXT_NONE);
     val = tcg_temp_new_i128();
     ah = tcg_temp_new_i64();
     al = tcg_temp_new_i64();
 
-    tcg_gen_add_tl(addr, src1, src2);
+    addr = make_address_x(ctx, src1, src2);
     get_vreg64(ah, a->vd, 1);
     get_vreg64(al, a->vd, 0);
     tcg_gen_concat_i64_i128(val, al, ah);
diff --git a/target/loongarch/insn_trans/trans_memory.c.inc b/target/loongarch/insn_trans/trans_memory.c.inc
index 75cfdf59ad..ccebd0a4e0 100644
--- a/target/loongarch/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/insn_trans/trans_memory.c.inc
@@ -39,9 +39,8 @@ static bool gen_loadx(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv dest = gpr_dst(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     gen_set_gpr(a->rd, dest, EXT_NONE);
 
@@ -53,9 +52,8 @@ static bool gen_storex(DisasContext *ctx, arg_rrr *a, MemOp mop)
     TCGv data = gpr_src(ctx, a->rd, EXT_NONE);
     TCGv src1 = gpr_src(ctx, a->rj, EXT_NONE);
     TCGv src2 = gpr_src(ctx, a->rk, EXT_NONE);
-    TCGv addr = tcg_temp_new();
+    TCGv addr = make_address_x(ctx, src1, src2);
 
-    tcg_gen_add_tl(addr, src1, src2);
     tcg_gen_qemu_st_tl(data, addr, ctx->mem_idx, mop);
 
     return true;
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index ac847745df..a68a979a55 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -208,6 +208,18 @@ static void set_fpr(int reg_num, TCGv val)
                    offsetof(CPULoongArchState, fpr[reg_num].vreg.D(0)));
 }
 
+static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
+{
+    TCGv temp = NULL;
+
+    if (addend) {
+        temp = tcg_temp_new();
+        tcg_gen_add_tl(temp, base, addend);
+        base = temp;
+    }
+    return base;
+}
+
 #include "decode-insns.c.inc"
 #include "insn_trans/trans_arith.c.inc"
 #include "insn_trans/trans_shift.c.inc"
-- 
2.39.1


