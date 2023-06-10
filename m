Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 127C772ABD0
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:40:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhs-0004zD-Cq; Sat, 10 Jun 2023 09:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhm-0004w3-A6; Sat, 10 Jun 2023 09:32:35 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhk-0007hY-My; Sat, 10 Jun 2023 09:32:34 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-39bcba263efso1152711b6e.1; 
 Sat, 10 Jun 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403951; x=1688995951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJkX6ackgSL+oGcc23kedSTv0OUc9rAnbvA+HNS+Gao=;
 b=LUZH7z+obYl1CpQa9qs94KF1zTXgKHFQUjZF4yfXKlu3ThEnZTCizpI9+6+wtsaZM5
 AF5S+Vtqv1I+K/5GY5yJQ5dLjK3/vhZKdKY+FROFECR0h6rYhRMma4ossN2beZOPrgQI
 H1ULpCDOxXW09axEafvXibW7gxP4rlcPbMBqEUOvBt/TC9sNKV0EkOpl1WSDyLp7dTU2
 R/p9vNgEeoGoFpT/bgoWtQgHOssTEh9uZlPH6sfwNLj2lXMllV+7vwcRQ/My6vRAnYJH
 05OG5095jH153DCH70+LKP4qHH0LoGHLor6rXRVhDDv8PxwktCqGhC0CtOLVUStzbjO4
 CsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403951; x=1688995951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJkX6ackgSL+oGcc23kedSTv0OUc9rAnbvA+HNS+Gao=;
 b=aWe+I43edLlbuXRoCM3e4Otvh7gIaxtOM1DBe4XcLFK91y11gg5mRBU3XW7W4PSu6j
 XBvGMOiRXzuaKspVyxUQE/KvQ9/dOScuzKMQyy7ibySun5eIn06BR2JJnT+bmhqZDVnH
 frOxt4qD9/aV72Wnht5b3McJdjwhmxEikHh4FdJG96PUkTa8/Eg270yTfHhaIoRvnPdV
 OkkF7KUNet0VcBOHHDLzzTytxKJ6b/0fXTtcUELfFNypXxJQwrecuFZbVxLiTVfs/zjb
 8zwZXVxL77N6q00s4cRHzQAJMWRWI9LSlMyfzn8knD3vjZs0XQhUYMxex//2s4fdH5Sy
 LA8Q==
X-Gm-Message-State: AC+VfDz65SpOPTh7tO5Udxt3XxWewu6EKojf1fXy9TGCSi2SqRsRQngI
 n7/oHGx2y+6FgYklIwOSa8mxNGAiQvw=
X-Google-Smtp-Source: ACHHUZ6T4o73QF2tXASuH1LLGwpTkxRPvlzDv2HSblv74yX6qkXwAIJSVBxWZtE5oxoqxOK9HrJA3w==
X-Received: by 2002:aca:3387:0:b0:38e:a925:8f95 with SMTP id
 z129-20020aca3387000000b0038ea9258f95mr946039oiz.26.1686403951271; 
 Sat, 10 Jun 2023 06:32:31 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:31 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>
Subject: [PULL 21/29] target/ppc: Ensure stcx size matches larx
Date: Sat, 10 Jun 2023 10:31:24 -0300
Message-Id: <20230610133132.290703-22-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22a.google.com
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

Differently-sized larx/stcx. pairs can succeed if the starting address
matches. Add a check to require the size of stcx. exactly match the larx
that established the reservation. Use the term "reserve_length" for this
state, which matches the terminology used in the ISA.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20230605025445.161932-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu.h       | 5 +++--
 target/ppc/cpu_init.c  | 4 ++--
 target/ppc/translate.c | 9 +++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index c7c2a5534c..20508bac5e 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1114,8 +1114,9 @@ struct CPUArchState {
     target_ulong ov32;
     target_ulong ca32;
 
-    target_ulong reserve_addr; /* Reservation address */
-    target_ulong reserve_val;  /* Reservation value */
+    target_ulong reserve_addr;   /* Reservation address */
+    target_ulong reserve_length; /* Reservation larx op size (bytes) */
+    target_ulong reserve_val;    /* Reservation value */
     target_ulong reserve_val2;
 
     /* These are used in supervisor mode only */
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 398f2d9966..d4ef074afb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7392,8 +7392,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
         }
         qemu_fprintf(f, " %c%c", a, env->crf[i] & 0x01 ? 'O' : ' ');
     }
-    qemu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
-                 env->reserve_addr);
+    qemu_fprintf(f, " ]     RES %03x@" TARGET_FMT_lx "\n",
+                 (int)env->reserve_length, env->reserve_addr);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 32; i++) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 452439b729..cf0bd79b8c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -75,6 +75,7 @@ static TCGv cpu_cfar;
 #endif
 static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
+static TCGv cpu_reserve_length;
 static TCGv cpu_reserve_val;
 static TCGv cpu_reserve_val2;
 static TCGv cpu_fpscr;
@@ -143,6 +144,10 @@ void ppc_translate_init(void)
     cpu_reserve = tcg_global_mem_new(cpu_env,
                                      offsetof(CPUPPCState, reserve_addr),
                                      "reserve_addr");
+    cpu_reserve_length = tcg_global_mem_new(cpu_env,
+                                            offsetof(CPUPPCState,
+                                                     reserve_length),
+                                            "reserve_length");
     cpu_reserve_val = tcg_global_mem_new(cpu_env,
                                          offsetof(CPUPPCState, reserve_val),
                                          "reserve_val");
@@ -3469,6 +3474,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     gen_addr_reg_index(ctx, t0);
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
+    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
@@ -3700,6 +3706,7 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
     tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
 
     t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
@@ -3766,6 +3773,7 @@ static void gen_lqarx(DisasContext *ctx)
     tcg_gen_extr_i128_i64(lo, hi, t16);
 
     tcg_gen_mov_tl(cpu_reserve, EA);
+    tcg_gen_movi_tl(cpu_reserve_length, 16);
     tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
     tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
 }
@@ -3791,6 +3799,7 @@ static void gen_stqcx_(DisasContext *ctx)
     gen_addr_reg_index(ctx, EA);
 
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
-- 
2.40.1


