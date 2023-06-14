Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB6572F206
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:35:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FEs-0003nz-5u; Tue, 13 Jun 2023 21:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEZ-0003cN-AG
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:41 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEX-0004vR-73
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:38 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-652d76be8c2so6520235b3a.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705816; x=1689297816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+Zpqg3JdPP6r7Yf1Ea9q6dskerHuBsWZMBa3ElN80Y=;
 b=rU8klGG1v3GO7FlP8ECOcClWGSgKP7Zd/AhexLxhjG8UIwwnHMyMVz6//RFKf6UcA7
 jT4n5U0Xl5qs0UdC+qVJPgOVFjRtEqmpUPwk9IfZwFWIPQbdOXHk0Mq/Mn9wg8q8Y/nc
 eUiqXVYo2KMqn5JAw37GEwvBtYhmDMGkLWhA/T5IEG4pel677FxrcXwIjGR80HwvDuxM
 K4Uoo3K2iQekDGaZbP5hoh0cYJropx6v5bh1Fq/gsUer393VwDtxA/eRevI/ZrGIHHZW
 ZJwY1/W88jHOHVakN864TonQeiLQJVQnivRTxHe98FNViKbexg0jAlzCxU9VAiGWoHBJ
 WdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705816; x=1689297816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+Zpqg3JdPP6r7Yf1Ea9q6dskerHuBsWZMBa3ElN80Y=;
 b=cmOGmz1lOABP0usl3YSPwRGpgYXFVcn70HhDraRNXds3uOLkb361+Y8GQDXzHRH24R
 s6MyVe4lznZfdPIJeiNuXYiOKxwI/uyORlH1fezpcJhD9SkXIH6sRCH7pIIGwiaHHs84
 NBNKMzmUlpMk0cUng+in3+6PzxkjWEXqf5PYNsasJUMczFHmpIlk+U9PvfAz82Hn9G3v
 054Bsk2e0hFLhbte85XiTiwhlM9R6xNgvxBMIMtXUcjQ4h0DY4PkdRp+qD7A0PFrcdAw
 +oGcGYH46Q8Y27Mp8E9Cc9j9hqw5c5jY5BFi6WrPlFvxPDwTKjc89JUXbvgfBVcaKleK
 bG0Q==
X-Gm-Message-State: AC+VfDxnY3Ej8Y3fp4JxWmJiRzga69wVcjY6sNtxniHvCUGWtsYqMhbO
 wZzIETQW/Ji2HZDC5IETL2es2G82XMCMwg==
X-Google-Smtp-Source: ACHHUZ5rIV7tVWSj5mJsCIdVtXUERp8xBvkICzQ00iVZ7POLpLIseyxCYUGNQmcjkbUwCd6jJDElqQ==
X-Received: by 2002:a05:6a00:2190:b0:663:716e:e752 with SMTP id
 h16-20020a056a00219000b00663716ee752mr463910pfi.26.1686705815765; 
 Tue, 13 Jun 2023 18:23:35 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:35 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 45/60] target/riscv: Fix target address to update badaddr
Date: Wed, 14 Jun 2023 11:20:02 +1000
Message-Id: <20230614012017.3100663-46-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
Message-Id: <20230526072124.298466-2-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                  | 21 ++++++++++-----------
 target/riscv/insn_trans/trans_rvi.c.inc   | 23 ++++++++++++++++-------
 target/riscv/insn_trans/trans_rvzce.c.inc |  4 ++--
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 29f1fb3995..6fbdb50c5d 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -224,21 +224,18 @@ static void decode_save_opc(DisasContext *ctx)
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
@@ -259,9 +256,9 @@ static void gen_exception_illegal(DisasContext *ctx)
     }
 }
 
-static void gen_exception_inst_addr_mis(DisasContext *ctx)
+static void gen_exception_inst_addr_mis(DisasContext *ctx, TCGv target)
 {
-    tcg_gen_st_tl(cpu_pc, cpu_env, offsetof(CPURISCVState, badaddr));
+    tcg_gen_st_tl(target, cpu_env, offsetof(CPURISCVState, badaddr));
     generate_exception(ctx, RISCV_EXCP_INST_ADDR_MIS);
 }
 
@@ -553,7 +550,9 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
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
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index d794247f40..009dc96dbd 100644
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
-- 
2.40.1


