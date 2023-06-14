Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B65F072F1F5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFD-00055m-Vy; Tue, 13 Jun 2023 21:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEv-0004Lw-2a
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:04 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEr-0004xh-CF
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-665a18f5643so1803927b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705836; x=1689297836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEMYe0wpc8vnaDDJTrFw7ioLATq1ueO1s/SCprqzlmA=;
 b=NjeD96LJTrP98lAZX0qsG6wpQd9zFGBfFE4YSCpE4EOBME+DetlUPxeIFwnJ1mC3IB
 rVsOa1VcAqanQnO+Vciu1DEhRH4zDB1BYywNSFbgCUJ4h2bAOCfKw7owBvzjyJIXG1GZ
 4nxbkqyODcaf6GuhSHtc1ACNzr47UMdjOK0Vszu7XFh75R3u1E5iZqBe2o36M7cxH7sZ
 185P1XFU4Ef0LoTMqO3opiz1qZR5WKhwPJLn5od9L1fGEqw3zgvGHtlCnV+imgXmzrRI
 NIfQEM3lqiJQERE1fg5hJVIcwdVnc1UmRPtfSVeXzj2oszbVPkyXitcVqU1bT5KI1+7n
 6W8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705836; x=1689297836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEMYe0wpc8vnaDDJTrFw7ioLATq1ueO1s/SCprqzlmA=;
 b=Maz0HdK3fKIXsp4zla/pSD9Mk55P0X+I5VWUItcWxh/AdwAfLt1yuo/WY7/PSphNlt
 bXdhM7GF/1t84XZ38Kes0Tn7fOcATAi2nGoNSgN/ttHiTbLsAVvEyHd2zSLWctcXmFcE
 jhd7CjGSkYfsTvksgG2ZN1309JFGo1Q/lcNV341rQihRD/hu9aTSGIbLwj+A+zolrOP3
 3GE/tcxirkHemK/i7TQXafgpo9Sox6VKizrFfbYzGTO+TQsvrAvczzpcpix0jZPmOz2k
 3fPBI5tEmI+Tlz2rI56v0zykoOMIVmq4gFdzTGH26Ad9obbA43gGXqi2yNlzvAZ3/MM4
 NsFA==
X-Gm-Message-State: AC+VfDyqMF9MQaytgoLtqB2/6M2NSTMHImDAP2lUEtEVmrjBx6MEn9n9
 kzfKCbhL7rbZfoR8Q90sEYHy0Di8tm+nfg==
X-Google-Smtp-Source: ACHHUZ4xt3neRTbLkMfoyQTB94xUVsEmqxJQZPuaO3+zJ/f4nUS5HyaZgEsR3nbX4nRosoppqMSS5A==
X-Received: by 2002:a05:6a20:a128:b0:117:19d1:8385 with SMTP id
 q40-20020a056a20a12800b0011719d18385mr250405pzk.20.1686705835756; 
 Tue, 13 Jun 2023 18:23:55 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:55 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 50/60] target/riscv: Enable PC-relative translation
Date: Wed, 14 Jun 2023 11:20:07 +1000
Message-Id: <20230614012017.3100663-51-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

Add a base pc_save for PC-relative translation(CF_PCREL).
Diable the directly sync pc from tb by riscv_cpu_synchronize_from_tb.
Use gen_pc_plus_diff to get the pc-relative address.
Enable CF_PCREL in System mode.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-7-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                        | 31 ++++++++++-----
 target/riscv/translate.c                  | 47 +++++++++++++++++++----
 target/riscv/insn_trans/trans_rvi.c.inc   | 12 +++++-
 target/riscv/insn_trans/trans_rvzce.c.inc |  4 +-
 4 files changed, 74 insertions(+), 20 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 938c7bd87b..881bddf393 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -721,16 +721,18 @@ static vaddr riscv_cpu_get_pc(CPUState *cs)
 static void riscv_cpu_synchronize_from_tb(CPUState *cs,
                                           const TranslationBlock *tb)
 {
-    RISCVCPU *cpu = RISCV_CPU(cs);
-    CPURISCVState *env = &cpu->env;
-    RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
+    if (!(tb_cflags(tb) & CF_PCREL)) {
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        CPURISCVState *env = &cpu->env;
+        RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
 
-    tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
+        tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
 
-    if (xl == MXL_RV32) {
-        env->pc = (int32_t) tb->pc;
-    } else {
-        env->pc = tb->pc;
+        if (xl == MXL_RV32) {
+            env->pc = (int32_t) tb->pc;
+        } else {
+            env->pc = tb->pc;
+        }
     }
 }
 
@@ -756,11 +758,18 @@ static void riscv_restore_state_to_opc(CPUState *cs,
     RISCVCPU *cpu = RISCV_CPU(cs);
     CPURISCVState *env = &cpu->env;
     RISCVMXL xl = FIELD_EX32(tb->flags, TB_FLAGS, XL);
+    target_ulong pc;
+
+    if (tb_cflags(tb) & CF_PCREL) {
+        pc = (env->pc & TARGET_PAGE_MASK) | data[0];
+    } else {
+        pc = data[0];
+    }
 
     if (xl == MXL_RV32) {
-        env->pc = (int32_t)data[0];
+        env->pc = (int32_t)pc;
     } else {
-        env->pc = data[0];
+        env->pc = pc;
     }
     env->bins = data[1];
 }
@@ -1343,6 +1352,8 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
 #ifndef CONFIG_USER_ONLY
+    cs->tcg_cflags |= CF_PCREL;
+
     if (cpu->cfg.ext_sstc) {
         riscv_timer_init(cpu);
     }
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 7fb4cbe84c..bd2da9b079 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -62,6 +62,7 @@ typedef struct DisasContext {
     /* pc_succ_insn points to the instruction following base.pc_next */
     target_ulong pc_succ_insn;
     target_ulong cur_insn_len;
+    target_ulong pc_save;
     target_ulong priv_ver;
     RISCVMXL misa_mxl_max;
     RISCVMXL xl;
@@ -230,15 +231,24 @@ static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
 {
     target_ulong dest = ctx->base.pc_next + diff;
 
-    if (get_xl(ctx) == MXL_RV32) {
-        dest = (int32_t)dest;
+    assert(ctx->pc_save != -1);
+    if (tb_cflags(ctx->base.tb) & CF_PCREL) {
+        tcg_gen_addi_tl(target, cpu_pc, dest - ctx->pc_save);
+        if (get_xl(ctx) == MXL_RV32) {
+            tcg_gen_ext32s_tl(target, target);
+        }
+    } else {
+        if (get_xl(ctx) == MXL_RV32) {
+            dest = (int32_t)dest;
+        }
+        tcg_gen_movi_tl(target, dest);
     }
-    tcg_gen_movi_tl(target, dest);
 }
 
 static void gen_update_pc(DisasContext *ctx, target_long diff)
 {
     gen_pc_plus_diff(cpu_pc, ctx, diff);
+    ctx->pc_save = ctx->base.pc_next + diff;
 }
 
 static void generate_exception(DisasContext *ctx, int excp)
@@ -294,8 +304,21 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_long diff)
       * direct block chain benefits will be small.
       */
     if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
-        tcg_gen_goto_tb(n);
-        gen_update_pc(ctx, diff);
+        /*
+         * For pcrel, the pc must always be up-to-date on entry to
+         * the linked TB, so that it can use simple additions for all
+         * further adjustments.  For !pcrel, the linked TB is compiled
+         * to know its full virtual address, so we can delay the
+         * update to pc to the unlinked path.  A long chain of links
+         * can thus avoid many updates to the PC.
+         */
+        if (tb_cflags(ctx->base.tb) & CF_PCREL) {
+            gen_update_pc(ctx, diff);
+            tcg_gen_goto_tb(n);
+        } else {
+            tcg_gen_goto_tb(n);
+            gen_update_pc(ctx, diff);
+        }
         tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
         gen_update_pc(ctx, diff);
@@ -549,6 +572,8 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg_num, TCGv_i64 t)
 
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
+    TCGv succ_pc = dest_gpr(ctx, rd);
+
     /* check misaligned: */
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
         if ((imm & 0x3) != 0) {
@@ -559,7 +584,9 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
         }
     }
 
-    gen_set_gpri(ctx, rd, ctx->pc_succ_insn);
+    gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
+    gen_set_gpr(ctx, rd, succ_pc);
+
     gen_goto_tb(ctx, 0, imm); /* must use this for safety */
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -1157,6 +1184,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
+    ctx->pc_save = ctx->base.pc_first;
     ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
     ctx->mem_idx = FIELD_EX32(tb_flags, TB_FLAGS, MEM_IDX);
@@ -1192,8 +1220,13 @@ static void riscv_tr_tb_start(DisasContextBase *db, CPUState *cpu)
 static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    target_ulong pc_next = ctx->base.pc_next;
+
+    if (tb_cflags(dcbase->tb) & CF_PCREL) {
+        pc_next &= ~TARGET_PAGE_MASK;
+    }
 
-    tcg_gen_insn_start(ctx->base.pc_next, 0);
+    tcg_gen_insn_start(pc_next, 0);
     ctx->insn_start = tcg_last_op();
 }
 
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2d350cfbd7..297142208e 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -38,7 +38,9 @@ static bool trans_lui(DisasContext *ctx, arg_lui *a)
 
 static bool trans_auipc(DisasContext *ctx, arg_auipc *a)
 {
-    gen_set_gpri(ctx, a->rd, a->imm + ctx->base.pc_next);
+    TCGv target_pc = dest_gpr(ctx, a->rd);
+    gen_pc_plus_diff(target_pc, ctx, a->imm);
+    gen_set_gpr(ctx, a->rd, target_pc);
     return true;
 }
 
@@ -52,6 +54,7 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
 {
     TCGLabel *misaligned = NULL;
     TCGv target_pc = tcg_temp_new();
+    TCGv succ_pc = dest_gpr(ctx, a->rd);
 
     tcg_gen_addi_tl(target_pc, get_gpr(ctx, a->rs1, EXT_NONE), a->imm);
     tcg_gen_andi_tl(target_pc, target_pc, (target_ulong)-2);
@@ -68,7 +71,9 @@ static bool trans_jalr(DisasContext *ctx, arg_jalr *a)
         tcg_gen_brcondi_tl(TCG_COND_NE, t0, 0x0, misaligned);
     }
 
-    gen_set_gpri(ctx, a->rd, ctx->pc_succ_insn);
+    gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
+    gen_set_gpr(ctx, a->rd, succ_pc);
+
     tcg_gen_mov_tl(cpu_pc, target_pc);
     lookup_and_goto_ptr(ctx);
 
@@ -158,6 +163,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     TCGLabel *l = gen_new_label();
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
+    target_ulong orig_pc_save = ctx->pc_save;
 
     if (get_xl(ctx) == MXL_RV128) {
         TCGv src1h = get_gprh(ctx, a->rs1);
@@ -171,6 +177,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
         tcg_gen_brcond_tl(cond, src1, src2, l);
     }
     gen_goto_tb(ctx, 1, ctx->cur_insn_len);
+    ctx->pc_save = orig_pc_save;
 
     gen_set_label(l); /* branch taken */
 
@@ -183,6 +190,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     } else {
         gen_goto_tb(ctx, 0, a->imm);
     }
+    ctx->pc_save = -1;
     ctx->base.is_jmp = DISAS_NORETURN;
 
     return true;
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 450b79dcbc..8d8a64f493 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -302,7 +302,9 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
 
     /* c.jt vs c.jalt depends on the index. */
     if (a->index >= 32) {
-        gen_set_gpri(ctx, xRA, ctx->pc_succ_insn);
+        TCGv succ_pc = dest_gpr(ctx, xRA);
+        gen_pc_plus_diff(succ_pc, ctx, ctx->cur_insn_len);
+        gen_set_gpr(ctx, xRA, succ_pc);
     }
 
     tcg_gen_lookup_and_goto_ptr();
-- 
2.40.1


