Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F7770E1E
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 08:33:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSAqS-00017c-2z; Sat, 05 Aug 2023 02:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qSAqK-00016d-2k
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 02:32:55 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qSAqI-0008GY-8U
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 02:32:51 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso24860095ad.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691217168; x=1691821968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nxlYOKJwPZArkiO+AHtzowF4dcv4iHSQyRpwVK9rjiQ=;
 b=Xeh2ncXqhkoauSbIJvBYAs1Yfg8FnwpqT5QbgTGA2TNd63abbq5zD//WqzmUTViWtI
 RUJH47kDWc+85sbb/8PtV+HtA+5Jzn6xrFgrJhFEoC2BEIJPeVmVsBIHtRaZK4x1u2tl
 AtkyPJ/XPKdyQmsVb2/Rkbscn11pnwDmaDSLmG4rPdK3Wno7vMbayVeDL0dJOyBOryBl
 oeYt8O8RcUZDdX6+NbjMybF3JfANNHXI1t3MRlp4Nc6VCBf6FCOJyIbsebQPuar5Tv3Z
 4Y4Blcak84fUrz37bPukcz5hTYJvddnRH59UXYkU6XXRf+L87GO66pDxoBDNqimdfFjU
 /tiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691217168; x=1691821968;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxlYOKJwPZArkiO+AHtzowF4dcv4iHSQyRpwVK9rjiQ=;
 b=NDGAfj7EpB5Wn9zXdpPRvFBaFT/HfHIfo66CeSKbaG6XYmA9YK6lME5y8+GyH/0+5B
 15v4ru4rB+Zh4lGcnYbf2U1cRGDFT+fCTEijpcyxskPhcmFeKCQZtXcX+TiI5EiS6MJs
 x2PgXR8NVARtQpMeI+GadJaN4Rto1ttrnnsef4WWGXNhIofcuO9I8GAVzCyKEiWbFBW9
 JcGSOllFJ3AF9t12sSVbRB5hO8eR6L1TvysQQMOisbk8qGtu8ZoTjK021IJGydYbyWJR
 j9RiFxnjkIlHk67BPZUTI5DHh2G/iLqPXHIiqVYCPYMTir4PWguZmtX5OYW6iInWiyub
 uz/A==
X-Gm-Message-State: AOJu0YwFBSl9OQhhzW/OTvh0aJzMO5H2ndix64PnlrZxs0UawwIz5MSn
 +LembVSR0nj6t/T+WXIVGjo=
X-Google-Smtp-Source: AGHT+IHOv38AK2hVuxDhh2wG4ifBpIYlEFSL8A5XolGIf8z0rBRoxh0rakZjhjbDi8ZHFpwGCRgZyg==
X-Received: by 2002:a17:902:b70e:b0:1bc:16bc:9f66 with SMTP id
 d14-20020a170902b70e00b001bc16bc9f66mr4195522pls.12.1691217167549; 
 Fri, 04 Aug 2023 23:32:47 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 jc19-20020a17090325d300b001b66e3a77easm2754805plb.50.2023.08.04.23.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 23:32:47 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH] record-replay: support SMP target machine
Date: Sat,  5 Aug 2023 16:32:38 +1000
Message-Id: <20230805063238.241780-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi, I have a use for RR in SMP machine. It seems conceptually simple to
add, RR scheduler is driven in a deterministic way like everything else.
In practice, I'm not entirely sure if I have all the locking and corner
cases covered. The code is also a bit ugly at the moment in terms of
CPU switching and recording, possibly an initial tidy patch to wrap up
the CPU scheduling in a nice way would make that better.

In any case, this series works enough on a ppc smp 2 guest including
step and reverse step of both threads when booting Linux (with some
other ppc rr fix patches that have already been posted).

Any thoughts on the approach, or details?

Thanks
Nick

---
RR CPU switching is driven by timers and events so it is deterministic
like everything else. Record a CPU switch event and use that to drive
the CPU switch on replay.

Some of the RR CPU scheduling variables have to be reset to get an
exact replay.

---
 accel/tcg/tcg-accel-ops-icount.c |  9 +++-
 accel/tcg/tcg-accel-ops-rr.c     | 73 ++++++++++++++++++++++++--------
 hw/ppc/spapr.c                   |  1 +
 include/exec/replay-core.h       |  3 ++
 replay/replay-internal.h         |  1 +
 replay/replay.c                  | 34 ++++++++++++++-
 scripts/replay-dump.py           |  5 +++
 softmmu/vl.c                     |  2 +-
 8 files changed, 107 insertions(+), 21 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 3d2cfbbc97..c26782a56a 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -93,10 +93,15 @@ void icount_handle_deadline(void)
 int64_t icount_percpu_budget(int cpu_count)
 {
     int64_t limit = icount_get_limit();
-    int64_t timeslice = limit / cpu_count;
+    int64_t timeslice;
 
-    if (timeslice == 0) {
+    if (replay_mode == REPLAY_MODE_PLAY) {
         timeslice = limit;
+    } else {
+        timeslice = limit / cpu_count;
+        if (timeslice == 0) {
+            timeslice = limit;
+        }
     }
 
     return timeslice;
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 2d523289a8..672432db87 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -27,6 +27,7 @@
 #include "qemu/lockable.h"
 #include "sysemu/tcg.h"
 #include "sysemu/replay.h"
+#include "sysemu/reset.h"
 #include "sysemu/cpu-timers.h"
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
@@ -61,6 +67,19 @@ void rr_kick_vcpu_thread(CPUState *unused)
 
 static QEMUTimer *rr_kick_vcpu_timer;
 static CPUState *rr_current_cpu;
+static CPUState *rr_next_cpu;
+static CPUState *rr_last_cpu;
+
+static void record_replay_reset(void *param)
+{
+    if (rr_kick_vcpu_timer) {
+        timer_del(rr_kick_vcpu_timer);
+    }
+    rr_current_cpu = NULL;
+    rr_next_cpu = NULL;
+    rr_last_cpu = NULL;
+    current_cpu = NULL;
+}
 
 static inline int64_t rr_next_kick_time(void)
 {
@@ -114,8 +133,6 @@ static void rr_wait_io_event(void)
         qemu_cond_wait_iothread(first_cpu->halt_cond);
     }
 
-    rr_start_kick_timer();
-
     CPU_FOREACH(cpu) {
         qemu_wait_io_event_common(cpu);
     }
@@ -182,6 +199,8 @@ static void *rr_cpu_thread_fn(void *arg)
     Notifier force_rcu;
     CPUState *cpu = arg;
 
+    qemu_register_reset(record_replay_reset, NULL);
+
     assert(tcg_enabled());
     rcu_register_thread();
     force_rcu.notify = rr_force_rcu;
@@ -207,8 +226,6 @@ static void *rr_cpu_thread_fn(void *arg)
         }
     }
 
-    rr_start_kick_timer();
-
     cpu = first_cpu;
 
     /* process any pending work */
@@ -222,9 +239,19 @@ static void *rr_cpu_thread_fn(void *arg)
         replay_mutex_lock();
         qemu_mutex_lock_iothread();
 
-        if (icount_enabled()) {
-            int cpu_count = rr_cpu_count();
+        rr_start_kick_timer();
 
+        if (!rr_next_cpu) {
+            qatomic_set_mb(&rr_next_cpu, first_cpu);
+        }
+        cpu = rr_next_cpu;
+
+        if (cpu != rr_last_cpu) {
+            replay_switch_cpu();
+            qatomic_set_mb(&rr_last_cpu, cpu);
+        }
+
+        if (icount_enabled()) {
             /* Account partial waits to QEMU_CLOCK_VIRTUAL.  */
             icount_account_warp_timer();
             /*
@@ -233,15 +260,11 @@ static void *rr_cpu_thread_fn(void *arg)
              */
             icount_handle_deadline();
 
-            cpu_budget = icount_percpu_budget(cpu_count);
+            cpu_budget = icount_percpu_budget(rr_cpu_count());
         }
 
         replay_mutex_unlock();
 
-        if (!cpu) {
-            cpu = first_cpu;
-        }
-
         while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
             /* Store rr_current_cpu before evaluating cpu_can_run().  */
             qatomic_set_mb(&rr_current_cpu, cpu);
@@ -280,7 +303,21 @@ static void *rr_cpu_thread_fn(void *arg)
                 break;
             }
 
-            cpu = CPU_NEXT(cpu);
+            if (replay_mode == REPLAY_MODE_NONE) {
+                cpu = CPU_NEXT(cpu);
+	    } else if (replay_mode == REPLAY_MODE_RECORD) {
+                cpu = CPU_NEXT(cpu);
+                break;
+            } else if (replay_mode == REPLAY_MODE_PLAY) {
+                qemu_mutex_unlock_iothread();
+                replay_mutex_lock();
+                qemu_mutex_lock_iothread();
+                if (replay_has_switch_cpu()) {
+                    cpu = CPU_NEXT(cpu);
+                }
+                replay_mutex_unlock();
+                break;
+            }
         } /* while (cpu && !cpu->exit_request).. */
 
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
@@ -290,6 +327,8 @@ static void *rr_cpu_thread_fn(void *arg)
             qatomic_set_mb(&cpu->exit_request, 0);
         }
 
+        qatomic_set(&rr_next_cpu, cpu);
+
         if (icount_enabled() && all_cpu_threads_idle()) {
             /*
              * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
diff --git a/include/exec/replay-core.h b/include/exec/replay-core.h
index 244c77acce..543c129a1d 100644
--- a/include/exec/replay-core.h
+++ b/include/exec/replay-core.h
@@ -52,6 +52,9 @@ void replay_gdb_attached(void);
 
 /* Interrupts and exceptions */
 
+bool replay_switch_cpu(void);
+bool replay_has_switch_cpu(void);
+
 /* Called by exception handler to write or read exception processing events */
 bool replay_exception(void);
 /*
diff --git a/replay/replay-internal.h b/replay/replay-internal.h
index b6836354ac..95849e7461 100644
--- a/replay/replay-internal.h
+++ b/replay/replay-internal.h
@@ -58,6 +58,7 @@ enum ReplayEvents {
     /* some of greater codes are reserved for checkpoints */
     EVENT_CHECKPOINT,
     EVENT_CHECKPOINT_LAST = EVENT_CHECKPOINT + CHECKPOINT_COUNT - 1,
+    EVENT_SWITCH_CPU,
     /* end of log event */
     EVENT_END,
     EVENT_COUNT
diff --git a/replay/replay.c b/replay/replay.c
index 0f7d766efe..ed0f020903 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -98,9 +98,41 @@ void replay_account_executed_instructions(void)
     }
 }
 
-bool replay_exception(void)
+bool replay_switch_cpu(void)
+{
+    if (replay_mode == REPLAY_MODE_RECORD) {
+        g_assert(replay_mutex_locked());
+        replay_save_instructions();
+        replay_put_event(EVENT_SWITCH_CPU);
+        return true;
+    } else if (replay_mode == REPLAY_MODE_PLAY) {
+        bool res = replay_has_switch_cpu();
+        if (res) {
+            replay_finish_event();
+        } else {
+            assert(0);
+        }
+        return res;
+    }
+
+    return true;
+}
+
+bool replay_has_switch_cpu(void)
 {
+    bool res = false;
+    if (replay_mode == REPLAY_MODE_PLAY) {
+        g_assert(replay_mutex_locked());
+        replay_account_executed_instructions();
+        res = replay_next_event_is(EVENT_SWITCH_CPU);
+    }
+
+    return res;
+}
 
+
+bool replay_exception(void)
+{
     if (replay_mode == REPLAY_MODE_RECORD) {
         g_assert(replay_mutex_locked());
         replay_save_instructions();
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0f39996640..fe57170ed7 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1883,7 +1883,7 @@ static void qemu_apply_machine_options(QDict *qdict)
         semihosting_arg_fallback(current_machine->kernel_filename, current_machine->kernel_cmdline);
     }
 
-    if (current_machine->smp.cpus > 1) {
+    if (0 && current_machine->smp.cpus > 1) {
         replay_add_blocker("smp");
     }
 }
-- 
2.40.1


