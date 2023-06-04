Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CB721613
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 12:30:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5kz6-00013i-9l; Sun, 04 Jun 2023 06:29:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kz4-00012Z-3b; Sun, 04 Jun 2023 06:29:14 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q5kz2-0005om-F2; Sun, 04 Jun 2023 06:29:13 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-19f30256921so4269830fac.1; 
 Sun, 04 Jun 2023 03:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685874550; x=1688466550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avJRQOEfyZphFrIbs4gVt8PexvbdiA9ScWJ0gKMJvKo=;
 b=WDy3Q+m3tnXtnM+MCacPfn2aSkJPqlVxkyWct4DwyEkPbbdBuTlZmA14g2Th3fRjKN
 y53OAhNRxtS/3PBjR6XeCs4NIfHkWFST2s5emtGnP6U89thG5gbfx/EVoVAElnNfDesO
 z0Skb/j2iEm17gd+ANl0O+VEK1fS5rJwUjYx3HllSBwpTyatkySsC1lWWFr4FxQfUjCe
 CqbVmzZl4AOaP5K1ivUGg1Y7zpD5CXmbftu9KRLMOUEiWOBvKJUqlknJCUYNDYjIHO8E
 Ds0qVyQE5I5QcE4pGtQim2TLny48u6V5u7E1QHLE9mLec2PTHbm45e9nyDHW20/cB6ja
 bU6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685874550; x=1688466550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avJRQOEfyZphFrIbs4gVt8PexvbdiA9ScWJ0gKMJvKo=;
 b=OInnHs8rooe/XV3tf1QaDg2d4D08G5mQ9eRG7ubAl0RacMYKAt7ZZLz58V2iGAe3mx
 uir65QO6AjOJOi+1i8/ZkHANQZAFnP6pyh2LgXSOhfEWEKUoUATB+srLptdGnVWfI8HU
 wXyXpSwrS7WA0BUmKj94wpaveXSQD5nD4Da7q5Wmb5ALzWNhW1Rne6qiWeTpyrfZuSTN
 PI8p9rI2m2/t+C+svRSfsdZyziu0uRQcipm1aUkSDgwO9ZjwIPEXoEaDsNnM313hWoiz
 1JRz843DxdOvMuSaJo44kxwBao9PNg1z30FabnN0fsqX6si9PF8p+CbzsAukgQzPWAH6
 G7gg==
X-Gm-Message-State: AC+VfDypAyqu8xRlOCzlMAXg45deSWKbj0OrNHeOEh7u1SvHONhRh9TS
 7wGPGVE9KrHime103hOxPfts0WKafSU=
X-Google-Smtp-Source: ACHHUZ5NZNxRhYQJ9MC+IOTXL3y2DAclo1gOsbjutuCmdO1Kl3fD2KLCPfNT1g4BTwkYko0B1g+VHg==
X-Received: by 2002:aca:d0b:0:b0:38b:c4e0:a23 with SMTP id
 11-20020aca0d0b000000b0038bc4e00a23mr4727930oin.57.1685874550123; 
 Sun, 04 Jun 2023 03:29:10 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 ik8-20020a170902ab0800b001ae0152d280sm4489241plb.193.2023.06.04.03.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 03:29:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 2/4] target/ppc: Ensure stcx size matches larx
Date: Sun,  4 Jun 2023 20:28:55 +1000
Message-Id: <20230604102858.148584-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230604102858.148584-1-npiggin@gmail.com>
References: <20230604102858.148584-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Differently-sized larx/stcx. pairs can succeed if the starting address
matches. Add a size check to require stcx. exactly match the larx that
established the reservation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h       | 1 +
 target/ppc/cpu_init.c  | 4 ++--
 target/ppc/translate.c | 8 ++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7959bfed0a..1d71f325d8 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1124,6 +1124,7 @@ struct CPUArchState {
     target_ulong ca32;
 
     target_ulong reserve_addr; /* Reservation address */
+    target_ulong reserve_size; /* Reservation size */
     target_ulong reserve_val;  /* Reservation value */
     target_ulong reserve_val2;
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 944a74befe..082981b148 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7421,8 +7421,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
         qemu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
     }
-    qemu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
-                 env->reserve_addr);
+    qemu_fprintf(f, " ]     RES %03x@" TARGET_FMT_lx "\n",
+                 (int)env->reserve_size, env->reserve_addr);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 32; i++) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e129cdcb8f..5195047146 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -71,6 +71,7 @@ static TCGv cpu_cfar;
 #endif
 static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
+static TCGv cpu_reserve_size;
 static TCGv cpu_reserve_val;
 static TCGv cpu_reserve_val2;
 static TCGv cpu_fpscr;
@@ -141,6 +142,9 @@ void ppc_translate_init(void)
     cpu_reserve = tcg_global_mem_new(cpu_env,
                                      offsetof(CPUPPCState, reserve_addr),
                                      "reserve_addr");
+    cpu_reserve_size = tcg_global_mem_new(cpu_env,
+                                          offsetof(CPUPPCState, reserve_size),
+                                          "reserve_size");
     cpu_reserve_val = tcg_global_mem_new(cpu_env,
                                          offsetof(CPUPPCState, reserve_val),
                                          "reserve_val");
@@ -3584,6 +3588,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
     tcg_gen_mov_tl(cpu_reserve, t0);
+    tcg_gen_movi_tl(cpu_reserve_size, memop_size(memop));
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
@@ -3816,6 +3821,7 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
     tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, memop_size(memop), l1);
 
     t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
@@ -3873,6 +3879,7 @@ static void gen_lqarx(DisasContext *ctx)
     EA = tcg_temp_new();
     gen_addr_reg_index(ctx, EA);
     tcg_gen_mov_tl(cpu_reserve, EA);
+    tcg_gen_movi_tl(cpu_reserve_size, 128);
 
     /* Note that the low part is always in RD+1, even in LE mode.  */
     lo = cpu_gpr[rd + 1];
@@ -3907,6 +3914,7 @@ static void gen_stqcx_(DisasContext *ctx)
     gen_addr_reg_index(ctx, EA);
 
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_size, 128, lab_fail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
-- 
2.40.1


