Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B6974AFDC
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:33:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgo-00023I-RZ; Fri, 07 Jul 2023 07:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgj-0001wQ-9I; Fri, 07 Jul 2023 07:31:49 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgh-0006Yf-Ku; Fri, 07 Jul 2023 07:31:49 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b7474b0501so1631699a34.1; 
 Fri, 07 Jul 2023 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729506; x=1691321506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvXJfsy0GDAm+0lTPBdH7zcNhZpuDrel0hSNinyy5lg=;
 b=dKHISOkqrR0faB3lJvSLnhwh/0TIDEClpdiVKZjKGN5KK7szod9l0As0if09c5b6eT
 m/Qr/X9s/ntW+dDrZwZRq1XrLhSNCJkFX9FRNiBWgT0VKEUVaZZ6Ufzc+1HRmVMDwSbs
 Bz4O3QRYG37gBJkyAVXzSN9t9pzD4nl6JIEF2Bq/qfxCIDsP2pgi1DWtGmPDukWBDVFs
 LVdexEMgbWiS2+Uy9qYso4tdq6NcjZOk/9XKLQkSAwB59jfq9lnojCEVObTR27DUmwiT
 rTqmBc2a/CLq8RNIiNLMVEFG73olqlpSpp3ZdB4ReSZf7eA13CCdpJOIc4h25OcZcGnv
 gb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729506; x=1691321506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvXJfsy0GDAm+0lTPBdH7zcNhZpuDrel0hSNinyy5lg=;
 b=gGrJxi7/QacmUduCPKOYjqfRFHt03MxC/S0sWHhnty3Ed7m0c57TC85zAhTcTUmc2y
 ofM7uCRx1j0waFVHGQQBCuOsTf7cFzl4Uyg2i1hrbrdzBuntLD3M4fprrAkA09O89dAB
 k07lJSfp8t/PcWpmLlkL5pINuPqpcrfhkrQDsQCAbB2zJ2OU0OeIJb02uoZexzF7BfTG
 sEfBtwoa1NR0URee9r8VeGg+5gh3oNhHJNpDfPQH/yPFFu9/ysY2sd6ebidbE5ngfmos
 HpuO1Vk9TQxdQXxdQ634lrXchLB+W5GbOS/wHLVAr3EdwKo/MHjutSzOpTrWh2juekVw
 2SBA==
X-Gm-Message-State: ABy/qLYbl1Y/vABiLHDXxCAyCiSpMicOEMD9mL8gir7G4TGEFLh9pud+
 DP9f2t+Vu5G5Xk2SpQNIBjft9YlXvSU=
X-Google-Smtp-Source: APBJJlEp+FpZZxSlstP/PXyNgAE36UZit7a+Ab7NbG/LxU9jJZxYAJ70QYSIuJMpJHh/c7liE/zLsg==
X-Received: by 2002:a05:6830:1314:b0:6b7:3dab:dbd6 with SMTP id
 p20-20020a056830131400b006b73dabdbd6mr1301490otq.15.1688729505993; 
 Fri, 07 Jul 2023 04:31:45 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:45 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 09/60] target/ppc: Fix icount access for some hypervisor
 instructions
Date: Fri,  7 Jul 2023 08:30:17 -0300
Message-ID: <20230707113108.7145-10-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

Several instructions and register access require icount reads and are
missing translator_io_start().

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230625103700.8992-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 599bd4b4f9..4766240927 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1187,6 +1187,7 @@ void spr_write_tfmr(DisasContext *ctx, int sprn, int gprn)
 
 void spr_write_lpcr(DisasContext *ctx, int sprn, int gprn)
 {
+    translator_io_start(&ctx->base);
     gen_helper_store_lpcr(cpu_env, cpu_gpr[gprn]);
 }
 #endif /* !defined(CONFIG_USER_ONLY) */
@@ -4012,6 +4013,7 @@ static void gen_doze(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_DOZE);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4027,6 +4029,7 @@ static void gen_nap(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_NAP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4042,6 +4045,7 @@ static void gen_stop(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_STOP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4057,6 +4061,7 @@ static void gen_sleep(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_SLEEP);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4072,6 +4077,7 @@ static void gen_rvwinkle(DisasContext *ctx)
     TCGv_i32 t;
 
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     t = tcg_constant_i32(PPC_PM_RVWINKLE);
     gen_helper_pminsn(cpu_env, t);
     /* Stop translation, as the CPU is supposed to sleep from now */
@@ -4468,6 +4474,7 @@ static void gen_hrfid(DisasContext *ctx)
 #else
     /* Restore CPU state */
     CHK_HV(ctx);
+    translator_io_start(&ctx->base);
     gen_helper_hrfid(cpu_env);
     ctx->base.is_jmp = DISAS_EXIT;
 #endif
-- 
2.41.0


