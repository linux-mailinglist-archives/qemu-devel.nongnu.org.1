Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D849E72F1DF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:30:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFF-0005Cl-6H; Tue, 13 Jun 2023 21:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEg-0003sP-A6
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:48 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEe-0004wN-Fi
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:45 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3942c6584f0so2840074b6e.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705823; x=1689297823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRN4AA3uh2bHKfo0LJWuWHEI1ii88H90QVsBEJL8Y3A=;
 b=ipfQUPFXYp4AMPHdGbM7GrDuLMGMNoBA3wtqfFD2gKZeANeSHFvqybfxdTzdWxoWby
 V9LAEMABDd9dLZ8FCQJ0Rss6x5p+KsLCgN1o8fF2sM46je69ep97w4lK1YcWFUTp8Lif
 Lr8lM1NOjogN5J+cbSVGVeA0NTPEaFqSn755D5v/fVgUGHxU++YD+1xf+o94PKJz2s3z
 g8iqv1i2tkpg+v9+vfdaTJwjTOuKIewK5F0q+GOE6BYDLoi9i5qscYyZHJdND4oR8v72
 UwDhE0+3zZmtkGa3w3vDKqbhCKjt2cekYPE7EK+VRTm4hUPGpm02cUEqRsrz+Jw8uaTg
 2MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705823; x=1689297823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WRN4AA3uh2bHKfo0LJWuWHEI1ii88H90QVsBEJL8Y3A=;
 b=dAE6644DiEYYdQveKCUBPojJ1rxZA9DW1hpQnurAYFrdYvdUlZiRDl/qBwL/xMyM1D
 bFOoMqs/YtKY0h41atWunOF25eSoMyiE1wYo0QWaIOh+KbEFd/CJJsxt7nIu6VBOFXkk
 02lZbnyR6rKtswPP/UUUSt/W1OIMOWTiOac8nj+Of5F5iz3Qbwo+dPJVp5i0RO3vmK45
 9WE0bWXEkXtDe4jjjmOAhm05K4TV34cY7mgB+Yt6z8RZD8j8bYjHecuSg3NT+qKfyaXV
 85peUuyN0CeQtAtUkgGJwSXAwpGfsanq5JNYC8dwrOpJ1aI0WogaY30njfyU/fb3/jCN
 bXWw==
X-Gm-Message-State: AC+VfDxtqroAEAiJCIcaitZIkkEP+P/iPCAZEDuZBlm/KmCrWbo3n7/l
 1lSY3A/X0mjq7UhUQNsvxvjgfZD1bPGgRQ==
X-Google-Smtp-Source: ACHHUZ58isj63JfpsNIO2hnTVavp+kMM0Qpm3KUrlGDkTNOiiBwoKgK4mxPCLYhDX1rgKGVjBwRw1w==
X-Received: by 2002:a54:400a:0:b0:39c:4553:964b with SMTP id
 x10-20020a54400a000000b0039c4553964bmr8740344oie.50.1686705823070; 
 Tue, 13 Jun 2023 18:23:43 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:42 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 47/60] target/riscv: Change gen_goto_tb to work on displacements
Date: Wed, 14 Jun 2023 11:20:04 +1000
Message-Id: <20230614012017.3100663-48-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22b.google.com
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

Reduce reliance on absolute value to prepare for PC-relative translation.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-4-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                | 8 +++++---
 target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index ea63d20eef..33c666d74e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -283,8 +283,10 @@ static void exit_tb(DisasContext *ctx)
     tcg_gen_exit_tb(NULL, 0);
 }
 
-static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, int n, target_long diff)
 {
+    target_ulong dest = ctx->base.pc_next + diff;
+
      /*
       * Under itrigger, instruction executes one by one like singlestep,
       * direct block chain benefits will be small.
@@ -559,7 +561,7 @@ static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
     }
 
     gen_set_gpri(ctx, rd, ctx->pc_succ_insn);
-    gen_goto_tb(ctx, 0, ctx->base.pc_next + imm); /* must use this for safety */
+    gen_goto_tb(ctx, 0, imm); /* must use this for safety */
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
@@ -1231,7 +1233,7 @@ static void riscv_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
     switch (ctx->base.is_jmp) {
     case DISAS_TOO_MANY:
-        gen_goto_tb(ctx, 0, ctx->base.pc_next);
+        gen_goto_tb(ctx, 0, 0);
         break;
     case DISAS_NORETURN:
         break;
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 009dc96dbd..321885f951 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -171,7 +171,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     } else {
         tcg_gen_brcond_tl(cond, src1, src2, l);
     }
-    gen_goto_tb(ctx, 1, ctx->pc_succ_insn);
+    gen_goto_tb(ctx, 1, ctx->cur_insn_len);
 
     gen_set_label(l); /* branch taken */
 
@@ -183,7 +183,7 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
         gen_pc_plus_diff(target_pc, ctx, next_pc);
         gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
-        gen_goto_tb(ctx, 0, ctx->base.pc_next + a->imm);
+        gen_goto_tb(ctx, 0, a->imm);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
 
-- 
2.40.1


