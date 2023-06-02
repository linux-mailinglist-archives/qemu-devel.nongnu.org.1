Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3279E71FE60
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51Ug-0000xQ-1M; Fri, 02 Jun 2023 05:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51Ud-0000wE-Rs
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:54:47 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51Ub-0006VI-LJ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:54:47 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so18923805e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685699683; x=1688291683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0R8n9l1An4oHkYxacOYdoliX3xQxde1GXBo5VdICKE0=;
 b=xm5N2zhsAHo9ha4Ztn841vhyal1i/oi4rB/I4MFoyJc17YuzPFP+cz69ejwI4Qhhsd
 tzc6ayE1oAqwvVHf+zKzbBrSZXjFLoi1+0Qli/dopc21vDnextqoTXKekaecORaQxAlC
 5hMHxr5aKECwEKTivLx0zhFa3vGtmKuAu6jzMb8jlx/5onRhoj73ilSqXzrkHnG1cIBe
 jpbl51cdqJ81KUgBEY3e7/R/7qB95Z4seKxsE4JxKZUWsV+rw6xGWSSEPLBOpZkVzNhZ
 JmIkVOyOv6Zq6+vS3RBjSIk4QMt6w7WqcjnanfozySv77EITL2G63Wx41pPBvvUHxEED
 xynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685699683; x=1688291683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0R8n9l1An4oHkYxacOYdoliX3xQxde1GXBo5VdICKE0=;
 b=DaWTId5AV/48XKMNa7vlEsqljJpjIDd40U6pr4a06QGc8ENoHqt++jEmz5WTcdBbLy
 AWxyjzMLsRalqExqBolobi6aJ/nPde9iICsuXH5c+47HTQrTKa2lCca3lmaSOBsgQ+IU
 w9QlJTRnr1410SsvPCSVfYjYS0nwId2SEMxb2KZOtfLGBFp34UXjpgRSQIw8Vdwefkqb
 A6fGyCaHaNBy121qsHbfEo1MraNgc9ozl5tMpRyRB10SqzPcuE1vG/i423Lvb+lWn6lY
 wVbVWIY2qTTWCSCUGQjVcJF1h+cQ8WMPefzKSik5x/RYPR839PE/cITd/GnPDd5HRLPI
 SxEQ==
X-Gm-Message-State: AC+VfDw6cl5ObG+ctv3wl9vfrfGhzITSwE/eBha7XrXkxI4mm3Yc6i9D
 Jst8vN1jBw5plPvFlfAU3bFC0bUVEA4XLg5EJR8=
X-Google-Smtp-Source: ACHHUZ42YZR157J7QqAiyTL2xLBFJUxWwXNVHSDY2mx8KhmMYT7tPxPWU/MMJ+rXeJ5YQzKEHdh/Dw==
X-Received: by 2002:a1c:f719:0:b0:3f6:766:f76f with SMTP id
 v25-20020a1cf719000000b003f60766f76fmr1468299wmh.36.1685699682811; 
 Fri, 02 Jun 2023 02:54:42 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f60482024fsm1408320wmc.30.2023.06.02.02.54.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 02:54:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 35.5] target/pcc: Inline gen_icount_io_start()
Date: Fri,  2 Jun 2023 11:54:39 +0200
Message-Id: <20230602095439.48102-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230531040330.8950-36-richard.henderson@linaro.org>
References: <20230531040330.8950-36-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Now that gen_icount_io_start() is a simple wrapper to
translator_io_start(), inline it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.38.1


