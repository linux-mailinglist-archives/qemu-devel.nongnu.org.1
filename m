Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4372F1C5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:27:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFS-0005jQ-QN; Tue, 13 Jun 2023 21:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEo-000422-K5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:55 -0400
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEm-0004x4-OL
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:23:54 -0400
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-3f9cf20da51so14410601cf.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705831; x=1689297831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ecXlBxU/i1OX1EXq4Qh5Sk8+jXXTvHOqsZLkT/Cqcrw=;
 b=WjaOoh29LE3NWlRqBlpS69gqiLi2/AmffFaaWYjgvKbR41X6wRU5AFJhdAFGnZN8v2
 +1HDrBHDtQwMuHt+24Y1dUqanW9Xx7FDnKJi0hIQBeBX6/KZouDe3ptSs3z47o0Ux65p
 ylFV/3QnMmVt0AHGNnDkqfeqsMy/XSK4WolGrZzeosiogxLJ+8DGTGAyeuRrMjb5h6WK
 mJHznSGhVknf0fqaWQRcpdYcF58NLxK6u2rnXG+I3nOLGQxGZn67MAilNxdqISaaw6XZ
 bLTQeFAeagIZCZNrQ5PEb3NkEkO/HYEaORJ+A0PvGXPS7aPANLZlCryHJqjy4CU2GNbD
 nXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705831; x=1689297831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ecXlBxU/i1OX1EXq4Qh5Sk8+jXXTvHOqsZLkT/Cqcrw=;
 b=SI3Lg/VsuSaI5iEqGwUOBz5aZTP2/8pht+fHksMf8zpC2d5B17a6YAB3vKmjtU+pqu
 9k51THWQU47dlht+NvE46HVYk97q3tx4lW6QkolTmhHIeJ86IJL0x2EPGovt0JJYxuBc
 DwasxmEcNuI46b7UFQyht/R6/yZCqbTNa5B2+6wrCC2/gV7CUwkceufYJRtwAVAemq6O
 DRVwd3N+tZxAbBamJBkoajS4s2LEpYpASpz6ONOOyCPMsRfKJcbs9jtUGVi/QKv0aeS+
 j7jJKiqOHlE/3Cy5yBLO+QSjwdW6fe/bPGbVIFihWGJuwx+5DQl1YjArwnI08kNXwXCC
 TcwQ==
X-Gm-Message-State: AC+VfDy+agYQy1t5w1Pe/ywyxUHKE/1tFc8Rn1msY12C5qmuDxjP8Vho
 IoCZ808Z5LrnrzrV2jsihog90qIFnX4azQ==
X-Google-Smtp-Source: ACHHUZ4WcfR5nUghKcDQLYX3MvTE5b9QOlbbO+fKX0ycwcSAsI0v+OE1ZTidFHoGNIlPFc6/PbT0pw==
X-Received: by 2002:a05:622a:1d0:b0:3b9:e0b2:9a49 with SMTP id
 t16-20020a05622a01d000b003b9e0b29a49mr362364qtw.60.1686705831620; 
 Tue, 13 Jun 2023 18:23:51 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:51 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 49/60] target/riscv: Use true diff for gen_pc_plus_diff
Date: Wed, 14 Jun 2023 11:20:06 +1000
Message-Id: <20230614012017.3100663-50-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x82a.google.com
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

Reduce reliance on absolute values by using true pc difference for
gen_pc_plus_diff() to prepare for PC-relative translation.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-6-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c                  | 13 ++++++-------
 target/riscv/insn_trans/trans_rvi.c.inc   |  6 ++----
 target/riscv/insn_trans/trans_rvzce.c.inc |  2 +-
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index eda022d10b..7fb4cbe84c 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -226,8 +226,10 @@ static void decode_save_opc(DisasContext *ctx)
 }
 
 static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
-                             target_ulong dest)
+                             target_long diff)
 {
+    target_ulong dest = ctx->base.pc_next + diff;
+
     if (get_xl(ctx) == MXL_RV32) {
         dest = (int32_t)dest;
     }
@@ -236,7 +238,7 @@ static void gen_pc_plus_diff(TCGv target, DisasContext *ctx,
 
 static void gen_update_pc(DisasContext *ctx, target_long diff)
 {
-    gen_pc_plus_diff(cpu_pc, ctx, ctx->base.pc_next + diff);
+    gen_pc_plus_diff(cpu_pc, ctx, diff);
 }
 
 static void generate_exception(DisasContext *ctx, int excp)
@@ -547,14 +549,11 @@ static void gen_set_fpr_d(DisasContext *ctx, int reg_num, TCGv_i64 t)
 
 static void gen_jal(DisasContext *ctx, int rd, target_ulong imm)
 {
-    target_ulong next_pc;
-
     /* check misaligned: */
-    next_pc = ctx->base.pc_next + imm;
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca) {
-        if ((next_pc & 0x3) != 0) {
+        if ((imm & 0x3) != 0) {
             TCGv target_pc = tcg_temp_new();
-            gen_pc_plus_diff(target_pc, ctx, next_pc);
+            gen_pc_plus_diff(target_pc, ctx, imm);
             gen_exception_inst_addr_mis(ctx, target_pc);
             return;
         }
diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 4837e133cc..2d350cfbd7 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -158,7 +158,6 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
     TCGLabel *l = gen_new_label();
     TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
     TCGv src2 = get_gpr(ctx, a->rs2, EXT_SIGN);
-    target_ulong next_pc;
 
     if (get_xl(ctx) == MXL_RV128) {
         TCGv src1h = get_gprh(ctx, a->rs1);
@@ -175,12 +174,11 @@ static bool gen_branch(DisasContext *ctx, arg_b *a, TCGCond cond)
 
     gen_set_label(l); /* branch taken */
 
-    next_pc = ctx->base.pc_next + a->imm;
     if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
-        (next_pc & 0x3)) {
+        (a->imm & 0x3)) {
         /* misaligned */
         TCGv target_pc = tcg_temp_new();
-        gen_pc_plus_diff(target_pc, ctx, next_pc);
+        gen_pc_plus_diff(target_pc, ctx, a->imm);
         gen_exception_inst_addr_mis(ctx, target_pc);
     } else {
         gen_goto_tb(ctx, 0, a->imm);
diff --git a/target/riscv/insn_trans/trans_rvzce.c.inc b/target/riscv/insn_trans/trans_rvzce.c.inc
index 5732d782f7..450b79dcbc 100644
--- a/target/riscv/insn_trans/trans_rvzce.c.inc
+++ b/target/riscv/insn_trans/trans_rvzce.c.inc
@@ -297,7 +297,7 @@ static bool trans_cm_jalt(DisasContext *ctx, arg_cm_jalt *a)
      * Update pc to current for the non-unwinding exception
      * that might come from cpu_ld*_code() in the helper.
      */
-    tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next);
+    gen_update_pc(ctx, 0);
     gen_helper_cm_jalt(cpu_pc, cpu_env, tcg_constant_i32(a->index));
 
     /* c.jt vs c.jalt depends on the index. */
-- 
2.40.1


