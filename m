Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 829EC7120D0
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 09:23:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Rls-000696-R9; Fri, 26 May 2023 03:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q2Rlk-00062Z-Kd; Fri, 26 May 2023 03:21:48 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <liweiwei@iscas.ac.cn>)
 id 1q2Rlg-0002Hc-PA; Fri, 26 May 2023 03:21:48 -0400
Received: from localhost.localdomain (unknown [61.165.37.98])
 by APP-05 (Coremail) with SMTP id zQCowACnrYn3XXBkJSddBQ--.47689S3;
 Fri, 26 May 2023 15:21:29 +0800 (CST)
From: Weiwei Li <liweiwei@iscas.ac.cn>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 wangjunqiang@iscas.ac.cn, lazyparser@gmail.com,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 1/7] target/riscv: Fix target address to update badaddr
Date: Fri, 26 May 2023 15:21:18 +0800
Message-Id: <20230526072124.298466-2-liweiwei@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230526072124.298466-1-liweiwei@iscas.ac.cn>
References: <20230526072124.298466-1-liweiwei@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowACnrYn3XXBkJSddBQ--.47689S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4DJryxZrWUArWxuw1Dtrb_yoW7CFyUpF
 1fCw17WrWDJFZavaySgF4jyF15tF4S9rWjkwsaywn5Ka13trW5GFnrtrWakFyUuFZ5Xr1Y
 9FWDAF1jvw4jqa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUPC14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
 ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
 kIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4U
 MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67
 AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0
 cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
 80aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI
 43ZEXa7VUjWv35UUUUU==
X-Originating-IP: [61.165.37.98]
X-CM-SenderInfo: 5olzvxxzhlqxpvfd2hldfou0/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=liweiwei@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Compute the target address before storing it into badaddr
when mis-aligned exception is triggered.
Use a target_pc temp to store the target address to avoid
the confusing operation that udpate target address into
cpu_pc before misalign check, then update it into badaddr
and restore cpu_pc to current pc if exception is triggered.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc   | 23 ++++++++++++++++-------
 target/riscv/insn_trans/trans_rvzce.c.inc |  4 ++--
 target/riscv/translate.c                  | 21 ++++++++++-----------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index e33f63bea1..b092b8c536 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -51,25 +51,30 @@ static bool trans_jal(DisasContext *ctx, arg_jal *a)
 static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     TCGLabel *misaligned = NULL;
+    TCGv target_pc = tcg_temp_new();
 
-    tcg_gen_addi_tl(cpu_pc, get_gpr(ctx, a->rs1, EXT_NONE), a->imm);
-    tcg_gen_andi_tl(cpu_pc, cpu_pc, (target_ulong)-2);
+    tcg_gen_addi_tl(target_pc, get_gpr(ctx, a->rs1, EXT_NONE), a->imm);
+    tcg_gen_andi_tl(target_pc, target_pc, (target_ulong)-2);
+
+    if (get_xl(ctx) == MXL_RV32) {
+        tcg_gen_ext32s_tl(target_pc, target_pc);
+    }
 
-    gen_set_pc(ctx, cpu_pc);
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
         TCGv t0 = tcg_temp_new();
 
         misaligned = gen_new_label();
-        tcg_gen_andi_tl(t0, cpu_pc, 0x2);
+        tcg_gen_andi_tl(t0, target_pc, 0x2);
         tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
     }
 
     gen_set_gpri(ctx, a->rd, ctx->pc_succ_insn);
+    tcg_gen_mov_tl(cpu_pc, target_pc);
     lookup_and_goto_ptr(ctx);
 
     if (misaligned) {
         gen_set_label(misaligned);
-        gen_exception_inst_addr_mis(ctx);
+        gen_exception_inst_addr_mis(ctx, target_pc);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 
@@ -153,6 +158,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     TCGLabel *l = gen_new_label();
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
+    target_ulong next_pc;
 
     if (get_xl(ctx) == MXL_RV128) {
         TCGv src1h = get_gprh(ctx, a->rs1);
@@ -169,10 +175,13 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 
     gen_set_label(l); /* branch taken */
 
+    next_pc = ctx->base.pc_next + a->imm;
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
-        ((ctx->base.pc_next + a->imm) & 0x3)) {
+        (next_pc & 0x3)) {
         /* misaligned */
-        gen_exception_inst_addr_mis(ctx);
+        TCGv target_pc = tcg_temp_new();
+        gen_pc_plus_diff(target_pc, ctx, next_pc);
+        gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
         gen_goto_tb(ctx, 0, ctx->base.pc_next + a->imm);
     }
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index a727169a4b..5732d782f7 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -202,8 +202,8 @@ static bool gen_pop(DisasContext *ctx, arg_cmpp *a, bool ret, bool ret_val)
     }
 
     if (ret) {
-        TCGv ret_addr = get_gpr(ctx, xRA, EXT_NONE);
-        gen_set_pc(ctx, ret_addr);
+        TCGv ret_addr = get_gpr(ctx, xRA, EXT_SIGN);
+        tcg_gen_mov_tl(cpu_pc, ret_addr);
         tcg_gen_lookup_and_goto_ptr();
         ctx->base.is_jmp = DISAS_NORETURN;
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index a889454137..1b93de66ab 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -222,21 +222,18 @@ static void decode_save_opc(DisasContext *ctx)
     ctx->insn_start = NULL;
 }
 
-static void gen_set_pc_imm(DisasContext *ctx, target_ulong dest)
+static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
+                             target_ulong dest)
 {
     if (get_xl(ctx) == MXL_RV32) {
         dest = (int32_t)dest;
     }
-    tcg_gen_movi_tl(cpu_pc, dest);
+    tcg_gen_movi_tl(target, dest);
 }
 
-static void gen_set_pc(DisasContext *ctx, TCGv dest)
+static void gen_set_pc_imm(DisasContext *ctx, target_ulong dest)
 {
-    if (get_xl(ctx) == MXL_RV32) {
-        tcg_gen_ext32s_tl(cpu_pc, dest);
-    } else {
-        tcg_gen_mov_tl(cpu_pc, dest);
-    }
+    gen_pc_plus_diff(cpu_pc, ctx, dest);
 }
 
 static void generate_exception(DisasContext *ctx, int excp)
@@ -257,9 +254,9 @@ static void gen_exception_illegal(DisasContext *ctx)
     }
 }
 
-static void gen_exception_inst_addr_mis(DisasContext *ctx)
+static void gen_exception_inst_addr_mis(DisasContext *ctx, TCGv target)
 {
-    tcg_gen_st_tl(cpu_pc, cpu_env, offsetof(CPURISCVState, badaddr));
+    tcg_gen_st_tl(target, cpu_env, offsetof(CPURISCVState, badaddr));
     generate_exception(ctx, RISCV_EXCP_INST_ADDR_MIS);
 }
 
@@ -551,7 +548,9 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     next_pc = ctx->base.pc_next + imm;
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
         if ((next_pc & 0x3) != 0) {
-            gen_exception_inst_addr_mis(ctx);
+            TCGv target_pc = tcg_temp_new();
+            gen_pc_plus_diff(target_pc, ctx, next_pc);
+            gen_exception_inst_addr_mis(ctx, target_pc);
             return;
         }
     }
-- 
2.25.1


