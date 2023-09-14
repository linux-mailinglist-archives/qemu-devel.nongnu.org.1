Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C6179F856
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLe-0000ey-5S; Wed, 13 Sep 2023 22:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLZ-0000d2-Sd
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLX-0000h0-T0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c39a4f14bcso4062205ad.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659486; x=1695264286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Elm/kDxrpUF32U3+zq0v2+l/HkbkLWlhfIcnxFZgfQc=;
 b=VEDICklWywbbjBlugPj+hcwYTZu+aMQtA+jvHamtaFcXucnNo6dz2MBfBFys0LLiGB
 dbsbRmTzSW134gmVdwxfyrD3ea9pIJnPxYdcZH9CtIX2jJlBzhC5kdVAyHbMSTTdvcU9
 oH7ZOxke9QOk+Fs9NqWcjjCISXxCb4aVP9W8lsCiIvbHjC7hdd+vpKnMUY3aMwWpJ1kb
 5d76iGKJclbZyGzuGMZV83GJFcvdaCPyOj3iJ/MkeEUdb59AOZaGPzV/yZ4xF78TlK2G
 fuCvSNv4nu7KSUOmtZSmyZYQdZGY9hRInNpViS2Icmx3CS0kUyDcRJkCW+mgcpbdoRCv
 BnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659486; x=1695264286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Elm/kDxrpUF32U3+zq0v2+l/HkbkLWlhfIcnxFZgfQc=;
 b=q95I4IJ9J3sZtD9RUF4kJ5wPOXC1WF6DvDnvAYGRLIwd1g5c+41o+exWLwJHCIuY1O
 JwTuZKaKIGrbWAaX8ShGflC19CaWFA4MFKYP5zAC+R8qzoQ1kOlffKX3RMqXhfqLRtBc
 P23OFW4GUoxosetpJKDfnkgQ8+k7dj0/n+fXupZw4UqPkuVeDvxUQlpEOMFdCBazLWya
 pQQowYZn7H+KKUCcILvSxyVKw7Yk85MeT/K82k5hBUj+nVGGcMQYFVtC+lYYtcLxu7tF
 /hZTZAr11b8Qg46GEUQsnkmXCuP8XfzIoucYfCuiIrb0KuFxF4fPS3kTJxyBUDTm+DbT
 RDwg==
X-Gm-Message-State: AOJu0YwUE8MfjSGmu/x3fJlktQHo7Vhc83xAbMqqlMqY4lOd/1uuYqR9
 Biuj56VadYHmc7z/W4X7ub9gVfRzLmYw1AjNEMQ=
X-Google-Smtp-Source: AGHT+IFUm99mwUcBBtwvpFgV6lt384b+3B8E4SrKVPsPSULS3xSWuwr6yxVZCaguvL5MTnlwHC3isQ==
X-Received: by 2002:a17:903:2687:b0:1c3:9b9b:8db0 with SMTP id
 jf7-20020a170903268700b001c39b9b8db0mr4352334plb.33.1694659486614; 
 Wed, 13 Sep 2023 19:44:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 11/24] accel/tcg: Remove cpu_neg()
Date: Wed, 13 Sep 2023 19:44:22 -0700
Message-Id: <20230914024435.1381329-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that CPUNegativeOffsetState is part of CPUState,
we can reference it directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h           | 11 -----------
 include/exec/exec-all.h          |  2 +-
 accel/tcg/cpu-exec.c             | 14 +++++++-------
 accel/tcg/tcg-accel-ops-icount.c |  6 +++---
 accel/tcg/tcg-accel-ops.c        |  2 +-
 accel/tcg/translate-all.c        |  6 +++---
 softmmu/icount.c                 |  2 +-
 7 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 3b01e4ee25..ae0cb2ce50 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -473,17 +473,6 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
     return (void *)env - sizeof(CPUNegativeOffsetState);
 }
 
-/**
- * cpu_neg(cpu)
- * @cpu: The generic CPUState
- *
- * Return the CPUNegativeOffsetState associated with the cpu.
- */
-static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
-{
-    return &cpu->neg;
-}
-
 /**
  * env_tlb(env)
  * @env: The architecture environment
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index b2f5cd4c2a..2e4d337805 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -71,7 +71,7 @@ G_NORETURN void cpu_loop_exit_atomic(CPUState *cpu, uintptr_t pc);
  */
 static inline bool cpu_loop_exit_requested(CPUState *cpu)
 {
-    return (int32_t)qatomic_read(&cpu_neg(cpu)->icount_decr.u32) < 0;
+    return (int32_t)qatomic_read(&cpu->neg.icount_decr.u32) < 0;
 }
 
 #if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index b01e3e5dc8..4abbd037f3 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -73,7 +73,7 @@ static void align_clocks(SyncClocks *sc, CPUState *cpu)
         return;
     }
 
-    cpu_icount = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
+    cpu_icount = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
     sc->diff_clk += icount_to_ns(sc->last_cpu_icount - cpu_icount);
     sc->last_cpu_icount = cpu_icount;
 
@@ -124,7 +124,7 @@ static void init_delay_params(SyncClocks *sc, CPUState *cpu)
     sc->realtime_clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT);
     sc->diff_clk = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - sc->realtime_clock;
     sc->last_cpu_icount
-        = cpu->icount_extra + cpu_neg(cpu)->icount_decr.u16.low;
+        = cpu->icount_extra + cpu->neg.icount_decr.u16.low;
     if (sc->diff_clk < max_delay) {
         max_delay = sc->diff_clk;
     }
@@ -717,7 +717,7 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     if (cpu->exception_index < 0) {
 #ifndef CONFIG_USER_ONLY
         if (replay_has_exception()
-            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0) {
+            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0) {
             /* Execute just one insn to trigger exception pending in the log */
             cpu->cflags_next_tb = (curr_cflags(cpu) & ~CF_USE_ICOUNT)
                 | CF_NOIRQ | 1;
@@ -807,7 +807,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    qatomic_set_mb(&cpu_neg(cpu)->icount_decr.u16.high, 0);
+    qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
@@ -898,7 +898,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(qatomic_read(&cpu->exit_request))
         || (icount_enabled()
             && (cpu->cflags_next_tb == -1 || cpu->cflags_next_tb & CF_USE_ICOUNT)
-            && cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra == 0)) {
+            && cpu->neg.icount_decr.u16.low + cpu->icount_extra == 0)) {
         qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
@@ -923,7 +923,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     }
 
     *last_tb = NULL;
-    insns_left = qatomic_read(&cpu_neg(cpu)->icount_decr.u32);
+    insns_left = qatomic_read(&cpu->neg.icount_decr.u32);
     if (insns_left < 0) {
         /* Something asked us to stop executing chained TBs; just
          * continue round the main loop. Whatever requested the exit
@@ -942,7 +942,7 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
     icount_update(cpu);
     /* Refill decrementer and continue execution.  */
     insns_left = MIN(0xffff, cpu->icount_budget);
-    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+    cpu->neg.icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
     /*
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 0af643b217..b25685fb71 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -111,14 +111,14 @@ void icount_prepare_for_run(CPUState *cpu, int64_t cpu_budget)
      * each vCPU execution. However u16.high can be raised
      * asynchronously by cpu_exit/cpu_interrupt/tcg_handle_interrupt
      */
-    g_assert(cpu_neg(cpu)->icount_decr.u16.low == 0);
+    g_assert(cpu->neg.icount_decr.u16.low == 0);
     g_assert(cpu->icount_extra == 0);
 
     replay_mutex_lock();
 
     cpu->icount_budget = MIN(icount_get_limit(), cpu_budget);
     insns_left = MIN(0xffff, cpu->icount_budget);
-    cpu_neg(cpu)->icount_decr.u16.low = insns_left;
+    cpu->neg.icount_decr.u16.low = insns_left;
     cpu->icount_extra = cpu->icount_budget - insns_left;
 
     if (cpu->icount_budget == 0) {
@@ -138,7 +138,7 @@ void icount_process_data(CPUState *cpu)
     icount_update(cpu);
 
     /* Reset the counters */
-    cpu_neg(cpu)->icount_decr.u16.low = 0;
+    cpu->neg.icount_decr.u16.low = 0;
     cpu->icount_extra = 0;
     cpu->icount_budget = 0;
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 3973591508..d885cc1d3c 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -91,7 +91,7 @@ void tcg_handle_interrupt(CPUState *cpu, int mask)
     if (!qemu_cpu_is_self(cpu)) {
         qemu_cpu_kick(cpu);
     } else {
-        qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
+        qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
     }
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 098d99b5d4..ed0c7ef7ce 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -214,7 +214,7 @@ void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
          * Reset the cycle counter to the start of the block and
          * shift if to the number of actually executed instructions.
          */
-        cpu_neg(cpu)->icount_decr.u16.low += insns_left;
+        cpu->neg.icount_decr.u16.low += insns_left;
     }
 
     cpu->cc->tcg_ops->restore_state_to_opc(cpu, tb, data);
@@ -623,7 +623,7 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
     cc = CPU_GET_CLASS(cpu);
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
-        cpu_neg(cpu)->icount_decr.u16.low++;
+        cpu->neg.icount_decr.u16.low++;
         n = 2;
     }
 
@@ -779,7 +779,7 @@ void cpu_interrupt(CPUState *cpu, int mask)
 {
     g_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
-    qatomic_set(&cpu_neg(cpu)->icount_decr.u16.high, -1);
+    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
 }
 
 #endif /* CONFIG_USER_ONLY */
diff --git a/softmmu/icount.c b/softmmu/icount.c
index 956d15e343..4527bfbd6e 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -75,7 +75,7 @@ static void icount_enable_adaptive(void)
 static int64_t icount_get_executed(CPUState *cpu)
 {
     return (cpu->icount_budget -
-            (cpu_neg(cpu)->icount_decr.u16.low + cpu->icount_extra));
+            (cpu->neg.icount_decr.u16.low + cpu->icount_extra));
 }
 
 /*
-- 
2.34.1


