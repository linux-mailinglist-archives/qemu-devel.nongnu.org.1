Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136272ABC4
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhu-000510-Ve; Sat, 10 Jun 2023 09:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhs-0004zc-Fg; Sat, 10 Jun 2023 09:32:40 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhq-0007i4-Jh; Sat, 10 Jun 2023 09:32:40 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-392116b8f31so1084325b6e.2; 
 Sat, 10 Jun 2023 06:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403956; x=1688995956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+7oAorQ1Z1ak76G2OtdFjXYKO/F4M1/6MSXnn6fP7g=;
 b=r4l4a8aPOj2H6l3xfCOoxrsRrXpfrXIorRlFYPgNiFQwlkSr8U54Yzf3u9wJa1szEz
 +7/GBOzhWv+rX/8/ADWbC/9moBkC+SCZ4YWuyaByC6tFxsACG2HWXFONRaB/RGg7vfNw
 J6y6JGI2+kAgkkVXj5OyAC33sXwEho4bX3Wcwo25NqpDczh+fHPH1FY6FF7Ae6xngfv9
 B6x4AVhkgIo+PXQpL6gLP2TpHoE+5TnLsRbkl3gqdxDBwWAkzoQpWDSykWvEnMfRTvy5
 6CCLpzE6DqDXfpmNdYOMpPCCqpN1Pg907n9ATyW3kNrb2BIQ4SMtI3wnZuWcK/qqJ5yE
 cmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403956; x=1688995956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+7oAorQ1Z1ak76G2OtdFjXYKO/F4M1/6MSXnn6fP7g=;
 b=J5RP0NJFD+HYWfoQJwozF+R49jgQ73gy8XwPJbQQpRWf3FHyZnuxcrbzIUdG+PWEeb
 G8aYmfGsaD0M5gUmTse4gOnYw3fSlUxdRO9hnpcMfzxXLL33SWsO4Q0RIKpfOtWzJ6B2
 /DgxlaM5TJTmFQdesIxkXD4PTW15GeP10kgqp35JYIgoUKvqROfhkZ6O9W9Oo9g58Hms
 Sgw4hlSvvKV1AJX3xCLmynbHan3Rjre1lxMAtoy7xIbohGK/EuG/Z2DGjjqTzXmQhpiV
 v0Aj2CiF0zA9tiJaz3UV12NBQ8xKHRldVVGcD4a+EepmT0b4FTv9qsbHatW50pSubKHo
 +6Qg==
X-Gm-Message-State: AC+VfDxclBps8Yx2JNpOcpaesRdjs1yeYUoeobFKocavrllMW8jP2dZ/
 0KfgYQVoK7FDqqv6ZHjOAJiZ+2tiR9s=
X-Google-Smtp-Source: ACHHUZ696cKkOuB4/P8WoGhlpU44GBkszdPTuENl1wZiLLJ5a8V7qJTsbLHCIRO4uM92XeqmwsAXuw==
X-Received: by 2002:a05:6808:1b06:b0:39a:be57:964b with SMTP id
 bx6-20020a0568081b0600b0039abe57964bmr1142945oib.13.1686403955810; 
 Sat, 10 Jun 2023 06:32:35 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:35 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 23/29] target/ppc: Rework store conditional to avoid branch
Date: Sat, 10 Jun 2023 10:31:26 -0300
Message-Id: <20230610133132.290703-24-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x235.google.com
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

Rework store conditional to avoid a branch in the success case.
Change some of the variable names and layout while here so
gen_conditional_store more closely matches gen_stqcx_.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230605025445.161932-4-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/translate.c | 63 ++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index cb4764476d..b591f2e496 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3697,31 +3697,32 @@ static void gen_stdat(DisasContext *ctx)
 
 static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 {
-    TCGLabel *l1 = gen_new_label();
-    TCGLabel *l2 = gen_new_label();
-    TCGv t0 = tcg_temp_new();
-    int reg = rS(ctx->opcode);
+    TCGLabel *lfail;
+    TCGv EA;
+    TCGv cr0;
+    TCGv t0;
+    int rs = rS(ctx->opcode);
 
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
+    t0 = tcg_temp_new();
+
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    gen_addr_reg_index(ctx, t0);
-    tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
+    gen_addr_reg_index(ctx, EA);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
 
-    t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[reg], ctx->mem_idx,
+                              cpu_gpr[rs], ctx->mem_idx,
                               DEF_MEMOP(memop) | MO_ALIGN);
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-    tcg_gen_br(l2);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(l1);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
-
-    gen_set_label(l2);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 
@@ -3775,25 +3776,26 @@ static void gen_lqarx(DisasContext *ctx)
 /* stqcx. */
 static void gen_stqcx_(DisasContext *ctx)
 {
-    TCGLabel *lab_fail, *lab_over;
-    int rs = rS(ctx->opcode);
+    TCGLabel *lfail;
     TCGv EA, t0, t1;
+    TCGv cr0;
     TCGv_i128 cmp, val;
+    int rs = rS(ctx->opcode);
 
     if (unlikely(rs & 1)) {
         gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
         return;
     }
 
-    lab_fail = gen_new_label();
-    lab_over = gen_new_label();
+    lfail = gen_new_label();
+    EA = tcg_temp_new();
+    cr0 = tcg_temp_new();
 
+    tcg_gen_mov_tl(cr0, cpu_so);
     gen_set_access_type(ctx, ACCESS_RES);
-    EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
-
-    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
-    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
+    tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lfail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
@@ -3816,15 +3818,10 @@ static void gen_stqcx_(DisasContext *ctx)
 
     tcg_gen_setcondi_tl(TCG_COND_EQ, t0, t0, 0);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
-    tcg_gen_or_tl(t0, t0, cpu_so);
-    tcg_gen_trunc_tl_i32(cpu_crf[0], t0);
-
-    tcg_gen_br(lab_over);
-    gen_set_label(lab_fail);
-
-    tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
+    tcg_gen_or_tl(cr0, cr0, t0);
 
-    gen_set_label(lab_over);
+    gen_set_label(lfail);
+    tcg_gen_trunc_tl_i32(cpu_crf[0], cr0);
     tcg_gen_movi_tl(cpu_reserve, -1);
 }
 #endif /* defined(TARGET_PPC64) */
-- 
2.40.1


