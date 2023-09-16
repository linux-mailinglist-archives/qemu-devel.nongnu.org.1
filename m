Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBBB7A329F
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2w-00058G-2J; Sat, 16 Sep 2023 17:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2o-00056J-Ih
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:40 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2l-0000RY-Jz
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:38 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fe2470d81so3080162b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900494; x=1695505294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=En35xg7nXjvXLsrzg+GNnaGBjlT+fgROcZr2z/jSKT4=;
 b=cE0dfn3ApjeME4mhmJzcYa8+3kZMOUeLJXl/n5Su36/bNftWPqJYkN6nCVy71KCMfZ
 zbwqPFxl1CmVo8xLtH2s9e3LcluIfsD0smfvgC4DskzCjmtvQkGddTR3F2PQ/4YMnKpH
 VYU/kVs+GpOkH8zSYFE5Yhy3G0PFvSz8/tnKLy4EbVDHCukayE6QG7D/n2hSB0YsGJwf
 BxxmMxdwLhQbxPetEAd1OLAM/t28Y4UfH20JOXWnpJLIWtOAP+D0QXE+IxEU5um8hGNY
 +/A0GmvaIQGwylTp6sn5r/SRDT/0UDu7i5Cp1WDV9jB7c9eTcoCSIVmedOqaHD7LjRBV
 e5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900494; x=1695505294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=En35xg7nXjvXLsrzg+GNnaGBjlT+fgROcZr2z/jSKT4=;
 b=uwRDhguAahm322tUPN4ntTi/bCEHH3llH5FodqdaQWaGnYa737t6vXdu2ZMJuijnGN
 1493rKUEZ3+i4x2aREgCrF1XqacpDSysMUr2uQ62Sl3b/DLcChdM5k59PYpzcCkJUnY9
 vkDEG+fIVPr9PpRtFHmHwoZYhMjlBvDv3Ha41LIxIlmwuvsQ8vmXzuQugbG16Xqwq7v/
 qL5VgxFN3Y2eo5+O+waC8Nio2v15vFP7wGWwU0Yqi9SifeJGbIT3bFlnlbDP71sApN4s
 YTJppk1BfLxMts9af3Kct0oopHrqBprNw7LBtiudu5/7jhceGRAszWoPjg9fQ3hqEaXN
 mhag==
X-Gm-Message-State: AOJu0YzC8yz9vplUNSH/0BWiRC1B2WtRsExSYK5jDx59hQ37U9uECZ/R
 NUD6NB/Tb+09mjCFYYresHmBUAqkMyqpfI1QG/c=
X-Google-Smtp-Source: AGHT+IGXWRBpi7P4yFxqpf883hLaeWGA/3DyFOAk1K8jC6JinQ/Yq28OeaqSEM9ac1cdI2Dkh+WK1A==
X-Received: by 2002:aa7:88d4:0:b0:68e:3d83:e501 with SMTP id
 k20-20020aa788d4000000b0068e3d83e501mr6708724pff.13.1694900494283; 
 Sat, 16 Sep 2023 14:41:34 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 10/39] accel/tcg: Remove cpu_neg()
Date: Sat, 16 Sep 2023 14:40:54 -0700
Message-Id: <20230916214123.525796-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 94fe80c979..fcd6ddac6a 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -473,17 +473,6 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
     return &env_cpu(env)->neg;
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


