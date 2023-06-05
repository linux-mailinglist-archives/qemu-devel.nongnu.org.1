Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB886721C49
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 04:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60N5-0008IF-Oh; Sun, 04 Jun 2023 22:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60N2-0008Ha-Qr; Sun, 04 Jun 2023 22:55:00 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60N0-0002a6-J2; Sun, 04 Jun 2023 22:55:00 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-19f8af9aa34so4583821fac.1; 
 Sun, 04 Jun 2023 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685933696; x=1688525696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJMgFP/4t6X0V2JqvUZgT0S5xdsXeZCo1ZEWw5QS3rE=;
 b=ZnUnNvlcFD5o4qSAFQ5wls4gj2fT+og7dV+8JVw+ATBVgyjql0oO61Kk+Ekgut7MT5
 hprMXCLnUg5+7vdWVZoGqGXLP/HYQVuhPjJ1K+XL2thYrJ5JNIUHV8F5o8180CTOdlQl
 2uM9hOhJDdTZ7bW/AnM3kG4+5/kjtzsvUA84KxKwOg4/bUcS0pvdJGTlTdquoBtqm8Dt
 IXiBER6Fp1lS1ZWcOEdAPxytll8JFZ4M/qQLkSSW8pDw6qZzK5YL5KE6qFv0lJGCxDm4
 4HYDaJt/BJLzuexlOpix20dKS+VCDk1rphrmzIfgbOs7wDH8Ygc2wGj9MoNALeZejVVo
 xqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685933696; x=1688525696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJMgFP/4t6X0V2JqvUZgT0S5xdsXeZCo1ZEWw5QS3rE=;
 b=jwxlKSa6TtWHp+ZwfYhcchgW2OmCIvvXPLT8es9xwgh0a4eLLHsezhMyXybyT+NuzO
 qIu5SPWsmwmSr8z4zglKVdhOXxWyKQKD1lZ9UBD54bClBDorY3y6S2hD5Naka5nQRmJZ
 mifxe7pVrq+U2xlFT15HwkEBYAQMAoDMfzPOA3J2aVwRC6NMAFOIbgRyT6jhiHGNAmAw
 XR4TPe8m+ssxwCZW1YohJNIVWPwkTLaiUYfIWqf1ZpLML6/DzjUShiuCh1WMdarEUgMF
 aGxIGHk/UBSY/Bn2SAY9p6qn3flEaPDER54VgF+zhg13c2qLPn6tPSmCR7obwxPtc4Go
 scFw==
X-Gm-Message-State: AC+VfDyTXUnRi0tz6TsNphnLYzzvFa2a+pDjtIo6ENWRvRfjyA1/UHfW
 so58QpbFS54BndYmDdFhme9hvqvNxKg=
X-Google-Smtp-Source: ACHHUZ7thRfUEbO5v14YHBvx6OgotYxc9dpSo3EvR6HF8UWkdLTjoLxeyLiEkMypB5k1wmb6UhT8zA==
X-Received: by 2002:a05:6870:4ec:b0:18e:2b7e:a844 with SMTP id
 u44-20020a05687004ec00b0018e2b7ea844mr8005680oam.21.1685933696611; 
 Sun, 04 Jun 2023 19:54:56 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902c74500b001ae59169f05sm5316778plq.182.2023.06.04.19.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 19:54:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 2/4] target/ppc: Ensure stcx size matches larx
Date: Mon,  5 Jun 2023 12:54:43 +1000
Message-Id: <20230605025445.161932-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605025445.161932-1-npiggin@gmail.com>
References: <20230605025445.161932-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2d.google.com
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
matches. Add a check to require the size of stcx. exactly match the larx
that established the reservation. Use the term "reserve_length" for this
state, which matches the terminology used in the ISA.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2:
- Changed lqarx/stqcx. reservation size to 16 [Richard]
- Changed name to reserve_length [Richard]

 target/ppc/cpu.h       | 5 +++--
 target/ppc/cpu_init.c  | 4 ++--
 target/ppc/translate.c | 9 +++++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 7959bfed0a..45d84ce06a 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1123,8 +1123,9 @@ struct CPUArchState {
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
index 944a74befe..c3dd7052a3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7421,8 +7421,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, int flags)
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
index 7a5bf1d820..538f757dec 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -71,6 +71,7 @@ static TCGv cpu_cfar;
 #endif
 static TCGv cpu_xer, cpu_so, cpu_ov, cpu_ca, cpu_ov32, cpu_ca32;
 static TCGv cpu_reserve;
+static TCGv cpu_reserve_length;
 static TCGv cpu_reserve_val;
 static TCGv cpu_reserve_val2;
 static TCGv cpu_fpscr;
@@ -141,6 +142,10 @@ void ppc_translate_init(void)
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
@@ -3585,6 +3590,7 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     gen_addr_reg_index(ctx, t0);
     tcg_gen_qemu_ld_tl(gpr, t0, ctx->mem_idx, memop | MO_ALIGN);
     tcg_gen_mov_tl(cpu_reserve, t0);
+    tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
     tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
@@ -3816,6 +3822,7 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     gen_set_access_type(ctx, ACCESS_RES);
     gen_addr_reg_index(ctx, t0);
     tcg_gen_brcond_tl(TCG_COND_NE, t0, cpu_reserve, l1);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), l1);
 
     t0 = tcg_temp_new();
     tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
@@ -3882,6 +3889,7 @@ static void gen_lqarx(DisasContext *ctx)
     tcg_gen_extr_i128_i64(lo, hi, t16);
 
     tcg_gen_mov_tl(cpu_reserve, EA);
+    tcg_gen_movi_tl(cpu_reserve_length, 16);
     tcg_gen_st_tl(hi, cpu_env, offsetof(CPUPPCState, reserve_val));
     tcg_gen_st_tl(lo, cpu_env, offsetof(CPUPPCState, reserve_val2));
 }
@@ -3907,6 +3915,7 @@ static void gen_stqcx_(DisasContext *ctx)
     gen_addr_reg_index(ctx, EA);
 
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lab_fail);
+    tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, 16, lab_fail);
 
     cmp = tcg_temp_new_i128();
     val = tcg_temp_new_i128();
-- 
2.40.1


