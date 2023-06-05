Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C85FD72313A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GdC-0002ET-1g; Mon, 05 Jun 2023 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcs-0001xu-R8
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcp-0004Bs-0K
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:26 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-656923b7c81so1296045b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996182; x=1688588182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmXIVGUQrmsy9JspNI/wMQlDfznCiNBwDmQf4l2r7fY=;
 b=sP1p2aKw3ibVarb988aAQhJqXhTkAZ9bFfsSOxtBT+V6CQrXRnVUfNhE9aPNVzd8Nx
 WKz17LqArnRgWaUQIxyyAJDJFnRMsKrWZcSYLJeik+30gqR0LWP3jCcBLx2ku8m5sAQ3
 55taJ4CihSjUrMP9zh3FifbHaR6jojHL3QMdgIOB0dtk1KsRqQyaloTkTfM7zTMj5BOH
 M++z1F6Fct5RjSOxcLrTbuMu4d7DqoKsOWevYpbj1VpFmQvfxlqkXc2QHXdCqMsBMWTM
 QnFAqqd2w+jf2/L3fvAFb+wU04mZLNINO6rgH376U4kAkAFCYATS3J+CmtZmoZe8zvqa
 188g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996182; x=1688588182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmXIVGUQrmsy9JspNI/wMQlDfznCiNBwDmQf4l2r7fY=;
 b=RhFNiXrdgJzs3+F5Jpn944A6jlmdTA0/gI+DJfnxIiT4/S1zIP/sZfAuE8l3uiBYzX
 uMhgHvlYCqPkm0gFznT1SJK3wwWSZqkR/Ed46+WDAdp9yl4mGWdSCiqTPxrcguLzJtqZ
 HyFM0U/kvma9vMwtldXsTBxelpgtcihrLj+cU0lI/ZJ+/kl+ScJEg3poMOxp+Wfdf9jf
 BP9j44yOOl6xMVRHBAdSW6G52EozfrBEzu9Gtg7oSKroMVOEl7Lo9MttO+aUvUOZepO1
 oNIksif2JTG7keXTflNPRknWhMbjNCKaVGTiu67/riqB2UOY0wOAfPadiVjFw/0LCLXB
 4QfA==
X-Gm-Message-State: AC+VfDyKwkY0DyJ4h2yuAALet8k8Zv0Br4i513yn/SxZTzJwHhD6vIS2
 8YFCyHLgxvF6B2SV9jdbKpIyp3yNh7FUMJ7cGUA=
X-Google-Smtp-Source: ACHHUZ5QTvVVmkNJbdO8WzAYqzISGeZoK14j3cG6+xQ+Bxi2AbNeabcCc3Mi0f3NsFrxlsIBEHljDA==
X-Received: by 2002:a05:6a00:1a50:b0:651:7133:3f59 with SMTP id
 h16-20020a056a001a5000b0065171333f59mr865540pfv.3.1685996181722; 
 Mon, 05 Jun 2023 13:16:21 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/52] target/ppc: Inline gen_icount_io_start()
Date: Mon,  5 Jun 2023 13:15:33 -0700
Message-Id: <20230605201548.1596865-38-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Now that gen_icount_io_start() is a simple wrapper to
translator_io_start(), inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230602095439.48102-1-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c                 | 63 ++++++++++++--------------
 target/ppc/power8-pmu-regs.c.inc       | 10 ++--
 target/ppc/translate/branch-impl.c.inc |  2 +-
 3 files changed, 35 insertions(+), 40 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 519f66bb05..37fd431870 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -296,15 +296,10 @@ static void gen_exception_nip(DisasContext *ctx, uint32_t excp,
     ctx->base.is_jmp = DISAS_NORETURN;
 }
 
-static void gen_icount_io_start(DisasContext *ctx)
-{
-    translator_io_start(&ctx->base);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static void gen_ppc_maybe_interrupt(DisasContext *ctx)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_ppc_maybe_interrupt(cpu_env);
 }
 #endif
@@ -541,13 +536,13 @@ void spr_write_ureg(DisasContext *ctx, int sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
 }
 #endif
@@ -556,13 +551,13 @@ void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
 /* Time base */
 void spr_read_tbl(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_tbl(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_read_tbu(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_tbu(cpu_gpr[gprn], cpu_env);
 }
 
@@ -579,13 +574,13 @@ void spr_read_atbu(DisasContext *ctx, int gprn, int sprn)
 #if !defined(CONFIG_USER_ONLY)
 void spr_write_tbl(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_tbl(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_tbu(cpu_env, cpu_gpr[gprn]);
 }
 
@@ -602,44 +597,44 @@ void spr_write_atbu(DisasContext *ctx, int sprn, int gprn)
 #if defined(TARGET_PPC64)
 void spr_read_purr(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_purr(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_purr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_purr(cpu_env, cpu_gpr[gprn]);
 }
 
 /* HDECR */
 void spr_read_hdecr(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_hdecr(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_hdecr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_hdecr(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_read_vtb(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_vtb(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_vtb(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_vtb(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_tbu40(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_tbu40(cpu_env, cpu_gpr[gprn]);
 }
 
@@ -784,19 +779,19 @@ void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 #if !defined(CONFIG_USER_ONLY)
 void spr_read_40x_pit(DisasContext *ctx, int gprn, int sprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_load_40x_pit(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_40x_pit(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_40x_pit(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_store_spr(sprn, cpu_gpr[gprn]);
     gen_helper_store_40x_dbcr0(cpu_env, cpu_gpr[gprn]);
     /* We must stop translation as we may have rebooted */
@@ -805,19 +800,19 @@ void spr_write_40x_dbcr0(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_40x_sler(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_40x_sler(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_40x_tcr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_40x_tcr(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_40x_tsr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_40x_tsr(cpu_env, cpu_gpr[gprn]);
 }
 
@@ -830,13 +825,13 @@ void spr_write_40x_pid(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_booke_tcr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_booke_tcr(cpu_env, cpu_gpr[gprn]);
 }
 
 void spr_write_booke_tsr(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_booke_tsr(cpu_env, cpu_gpr[gprn]);
 }
 #endif
@@ -2462,7 +2457,7 @@ static void gen_darn(DisasContext *ctx)
     if (l > 2) {
         tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
     } else {
-        gen_icount_io_start(ctx);
+        translator_io_start(&ctx->base);
         if (l == 0) {
             gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
         } else {
@@ -4056,7 +4051,7 @@ static void pmu_count_insns(DisasContext *ctx)
      * running with icount and we do not handle it beforehand,
      * the helper can trigger a 'bad icount read'.
      */
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
 
     /* Avoid helper calls when only PMC5-6 are enabled. */
     if (!ctx->pmc_other) {
@@ -4369,7 +4364,7 @@ static void gen_rfi(DisasContext *ctx)
     }
     /* Restore CPU state */
     CHK_SV(ctx);
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_update_cfar(ctx, ctx->cia);
     gen_helper_rfi(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
@@ -4384,7 +4379,7 @@ static void gen_rfid(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_SV(ctx);
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_update_cfar(ctx, ctx->cia);
     gen_helper_rfid(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
@@ -4399,7 +4394,7 @@ static void gen_rfscv(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_SV(ctx);
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_update_cfar(ctx, ctx->cia);
     gen_helper_rfscv(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
@@ -4724,7 +4719,7 @@ static void gen_mtmsrd(DisasContext *ctx)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
 
     if (ctx->opcode & 0x00010000) {
         /* L=1 form only updates EE and RI */
@@ -4764,7 +4759,7 @@ static void gen_mtmsr(DisasContext *ctx)
     t0 = tcg_temp_new();
     t1 = tcg_temp_new();
 
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     if (ctx->opcode & 0x00010000) {
         /* L=1 form only updates EE and RI */
         mask &= (1ULL << MSR_RI) | (1ULL << MSR_EE);
diff --git a/target/ppc/power8-pmu-regs.c.inc b/target/ppc/power8-pmu-regs.c.inc
index d900e13cad..c82feedaff 100644
--- a/target/ppc/power8-pmu-regs.c.inc
+++ b/target/ppc/power8-pmu-regs.c.inc
@@ -103,9 +103,9 @@ static void write_MMCR0_common(DisasContext *ctx, TCGv val)
     /*
      * helper_store_mmcr0 will make clock based operations that
      * will cause 'bad icount read' errors if we do not execute
-     * gen_icount_io_start() beforehand.
+     * translator_io_start() beforehand.
      */
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_mmcr0(cpu_env, val);
 
     /*
@@ -179,7 +179,7 @@ void spr_read_PMC(DisasContext *ctx, int gprn, int sprn)
 {
     TCGv_i32 t_sprn = tcg_constant_i32(sprn);
 
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_read_pmc(cpu_gpr[gprn], cpu_env, t_sprn);
 }
 
@@ -212,7 +212,7 @@ void spr_write_PMC(DisasContext *ctx, int sprn, int gprn)
 {
     TCGv_i32 t_sprn = tcg_constant_i32(sprn);
 
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_pmc(cpu_env, t_sprn, cpu_gpr[gprn]);
 }
 
@@ -248,7 +248,7 @@ void spr_write_MMCR0(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_MMCR1(DisasContext *ctx, int sprn, int gprn)
 {
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_store_mmcr1(cpu_env, cpu_gpr[gprn]);
 }
 #else
diff --git a/target/ppc/translate/branch-impl.c.inc b/target/ppc/translate/branch-impl.c.inc
index 29cfa11854..f9931b9d73 100644
--- a/target/ppc/translate/branch-impl.c.inc
+++ b/target/ppc/translate/branch-impl.c.inc
@@ -16,7 +16,7 @@ static bool trans_RFEBB(DisasContext *ctx, arg_XL_s *arg)
 {
     REQUIRE_INSNS_FLAGS2(ctx, ISA207S);
 
-    gen_icount_io_start(ctx);
+    translator_io_start(&ctx->base);
     gen_update_cfar(ctx, ctx->cia);
     gen_helper_rfebb(cpu_env, cpu_gpr[arg->s]);
 
-- 
2.34.1


