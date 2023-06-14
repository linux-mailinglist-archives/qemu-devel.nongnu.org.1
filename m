Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC08872F1D6
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFO-0005gD-OJ; Tue, 13 Jun 2023 21:24:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEm-00040V-Nm
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:54 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEj-0004wr-7Y
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:50 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b29b9f5a94so4146631a34.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705828; x=1689297828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9naFzlrMh9t404X6Q+L8kQ/c6gOwrYPhm1tNHIgYIFA=;
 b=mDU322V4J9MWwPKz3JS6qZLka8xkKMqJpgDsWwx4fIuSVlgLIEGhPcevQPgFqQB3in
 GVVjWM0Cs4iv8wKhCuHzYiCC4d7pwvAHeXXFF4ocV3t1hTKvgM23NO4ewutL8yAud+b2
 69yZZJTOEIgxHh7R865C/DFMuNCy4ZZ4gdtWTnxFjS7zl91pYGR3O83P5ieV9K0NqKwa
 y3c5CkL3H4u+cYWyTRrAC/MYqTbTXIK+82asYb5N3Zvi+jcj6l4oqq1ptOSrjDoXoxlu
 Z1fSSBL5Ws/2DnJTIOFztIIeUTabJxBPXAxoJCFl5EqYzaC4vy/gaVmEujN4pjhZwNOx
 rFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705828; x=1689297828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9naFzlrMh9t404X6Q+L8kQ/c6gOwrYPhm1tNHIgYIFA=;
 b=MaQ9k0h7WE+pbTil4OzGQ+yvG+poBCN3DzeCfQ4G2F7tpZghk2nudIGqdeJKR9xCmP
 gGMxRrNoz95priNYX1Gic9272OSpMkvFDwJWORZUjYgADs1ZjHwlQtbTFWhJlt8hWTCl
 qOJzqPRlnUmdOh7X96DKpissX7sJp/qJEcYXQVs0es8sLwh0GT57VHm+cj6/o1efDub5
 n5SGG/u3paLQ6jy8wayVop8QzNER8sCoXgj14aS196d7sClEWb2gT0sBFNivNFpPJaQm
 7tpyF+9hVlEne4yVQ0rlQSbm/aAPS6CbP4t0YC7cIlAce8NgCR3owuZ3cknAqxK394nN
 LJGg==
X-Gm-Message-State: AC+VfDw0rG5f3/gE5qt1Fzsi6zl2/NhHBopQyvCvwtG3OoC3M3XFDRU8
 yfdTCLuDUSl+nPyjmC7plcnf5Za4yLd6KA==
X-Google-Smtp-Source: ACHHUZ7H7Q+XpkkfSSjqIxESQUUSKn9EbgdTpvWXArsJbkSUcOw5slc3SQoCSs6bteFqo8oPQzUTCQ==
X-Received: by 2002:a05:6358:c112:b0:12b:cdd6:9661 with SMTP id
 fh18-20020a056358c11200b0012bcdd69661mr6360979rwb.13.1686705827770; 
 Tue, 13 Jun 2023 18:23:47 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:47 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 48/60] target/riscv: Change gen_set_pc_imm to gen_update_pc
Date: Wed, 14 Jun 2023 11:20:05 +1000
Message-Id: <20230614012017.3100663-49-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32a.google.com
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

Reduce reliance on absolute values(by passing pc difference) to
prepare for PC-relative translation.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-5-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                       | 10 +++++-----
 target/riscv/insn_trans/trans_privileged.c.inc |  2 +-
 target/riscv/insn_trans/trans_rvi.c.inc        |  6 +++---
 target/riscv/insn_trans/trans_rvv.c.inc        |  4 ++--
 target/riscv/insn_trans/trans_rvzawrs.c.inc    |  2 +-
 target/riscv/insn_trans/trans_xthead.c.inc     |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 33c666d74e..eda022d10b 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -234,14 +234,14 @@ static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
     tcg_gen_movi_tl(target, dest);
 }
 
-static void gen_set_pc_imm(DisasContext *ctx, target_ulong dest)
+static void gen_update_pc(DisasContext *ctx, target_long diff)
 {
-    gen_pc_plus_diff(cpu_pc, ctx, dest);
+    gen_pc_plus_diff(cpu_pc, ctx, ctx->base.pc_next + diff);
 }
 
 static void generate_exception(DisasContext *ctx, int excp)
 {
-    gen_set_pc_imm(ctx, ctx->base.pc_next);
+    gen_update_pc(ctx, 0);
     gen_helper_raise_exception(cpu_env, tcg_constant_i32(excp));
     ctx->base.is_jmp = DISAS_NORETURN;
 }
@@ -293,10 +293,10 @@ static void gen_goto_tb(DisasContext *ctx, int n, target_long diff)
       */
     if (translator_use_goto_tb(&ctx->base, dest) && !ctx->itrigger) {
         tcg_gen_goto_tb(n);
-        gen_set_pc_imm(ctx, dest);
+        gen_update_pc(ctx, diff);
         tcg_gen_exit_tb(ctx->base.tb, n);
     } else {
-        gen_set_pc_imm(ctx, dest);
+        gen_update_pc(ctx, diff);
         lookup_and_goto_ptr(ctx);
     }
 }
diff --git a/target/riscv/insn_trans/trans_privileged.c.inc b/target/riscv/insn_trans/trans_privileged.c.inc
index 528baa1652..dc14d7fc7a 100644
--- a/target/riscv/insn_trans/trans_privileged.c.inc
+++ b/target/riscv/insn_trans/trans_privileged.c.inc
@@ -108,7 +108,7 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
 {
 #ifndef CONFIG_USER_ONLY
     decode_save_opc(ctx);
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     gen_helper_wfi(cpu_env);
     return true;
 #else
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 321885f951..4837e133cc 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -777,7 +777,7 @@ static bool trans_pause(DisasContext *ctx, arg_pause *a)
      * PAUSE is a no-op in QEMU,
      * end the TB and return to main loop
      */
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     exit_tb(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
 
@@ -801,7 +801,7 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
      * FENCE_I is a no-op in QEMU,
      * however we need to end the translation block
      */
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     exit_tb(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -812,7 +812,7 @@ static bool do_csr_post(DisasContext *ctx)
     /* The helper may raise ILLEGAL_INSN -- record binv for unwind. */
     decode_save_opc(ctx);
     /* We may have changed important cpu state -- exit to main loop. */
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     exit_tb(ctx);
     ctx->base.is_jmp = DISAS_NORETURN;
     return true;
diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index 6c07eebc52..c2f7527f53 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -169,7 +169,7 @@ static bool do_vsetvl(DisasContext *s, int rd, int rs1, TCGv s2)
     gen_set_gpr(s, rd, dst);
     mark_vs_dirty(s);
 
-    gen_set_pc_imm(s, s->pc_succ_insn);
+    gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
     s->base.is_jmp = DISAS_NORETURN;
     return true;
@@ -188,7 +188,7 @@ static bool do_vsetivli(DisasContext *s, int rd, TCGv s1, TCGv s2)
     gen_helper_vsetvl(dst, cpu_env, s1, s2);
     gen_set_gpr(s, rd, dst);
     mark_vs_dirty(s);
-    gen_set_pc_imm(s, s->pc_succ_insn);
+    gen_update_pc(s, s->cur_insn_len);
     lookup_and_goto_ptr(s);
     s->base.is_jmp = DISAS_NORETURN;
 
diff --git a/target/riscv/insn_trans/trans_rvzawrs.c.inc b/target/riscv/insn_trans/trans_rvzawrs.c.inc
index 8254e7dfe2..32efbff4d5 100644
--- a/target/riscv/insn_trans/trans_rvzawrs.c.inc
+++ b/target/riscv/insn_trans/trans_rvzawrs.c.inc
@@ -33,7 +33,7 @@ static bool trans_wrs(DisasContext *ctx)
     /* Clear the load reservation  (if any).  */
     tcg_gen_movi_tl(load_res, -1);
 
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     tcg_gen_exit_tb(NULL, 0);
     ctx->base.is_jmp = DISAS_NORETURN;
 
diff --git a/target/riscv/insn_trans/trans_xthead.c.inc b/target/riscv/insn_trans/trans_xthead.c.inc
index 3e13b1d74d..da093a4cec 100644
--- a/target/riscv/insn_trans/trans_xthead.c.inc
+++ b/target/riscv/insn_trans/trans_xthead.c.inc
@@ -999,7 +999,7 @@ static void gen_th_sync_local(DisasContext *ctx)
      * Emulate out-of-order barriers with pipeline flush
      * by exiting the translation block.
      */
-    gen_set_pc_imm(ctx, ctx->pc_succ_insn);
+    gen_update_pc(ctx, ctx->cur_insn_len);
     tcg_gen_exit_tb(NULL, 0);
     ctx->base.is_jmp = DISAS_NORETURN;
 }
-- 
2.40.1


