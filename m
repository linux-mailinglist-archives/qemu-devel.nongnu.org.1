Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7DB778519
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 03:48:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUHFO-0002xS-UT; Thu, 10 Aug 2023 21:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qUHFJ-0002xI-As; Thu, 10 Aug 2023 21:47:21 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qUHFD-0001nS-Fi; Thu, 10 Aug 2023 21:47:18 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-76595a7b111so113867485a.2; 
 Thu, 10 Aug 2023 18:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691718432; x=1692323232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lGHcSEBAoCYbQVccZc1FaiGLTVEIVTv4E6Nh1k0Xf+g=;
 b=Gn4LhuzfAGcankK3MJ1SUfHybJD3ujxjMKapMxH7bTCaUnE+1atoroM6hO2x8dXh0R
 +jWnHxxdkeey1VzdHoGGEv9+MJGcOFtB+p24RfhHeu3q+NaO5wk8FraZaWu8v0Uulimm
 ajOODd0EfwJDSjuo2ENf2RZonNw/gJPHeWBU66hrgDJGy0QVVb8oye6kst/BrrWQDTxp
 B5JKP1HZWW6Zqf3CH3AbOWBD3XCEez/608QOekkL2KgplgxLotar6+XTBzfg+p+awxhU
 0IYkP9NRqxi8ZXlJDG9OmRfP4ARqq8sz85wuybtjr7rKUZxHerf97bUZxY4wD2V3qtPt
 uaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691718432; x=1692323232;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lGHcSEBAoCYbQVccZc1FaiGLTVEIVTv4E6Nh1k0Xf+g=;
 b=WGp0qj57umG9eDkYHkvQ2c+T/xrAuhB+3bmHeo6wSfaYmyQNEwZFfTMwMsdpN8oRm/
 QjnNqFwnyv0nKTqmbMZ54LPLVYwt8KxM3ERqxdF6aNuVDalbGTEHJHTTUT0t/JJOZEAq
 rO5meXKOw6dBUiQ28LOeynU+FG8fudlm1dUdMrXWsM+eglBDfWKesAUKHUECihDLvEBr
 9rMFo7Nf+dnjF1baY35zhittoZNBjTXU2vhWn71DtQWu5sn3SGnNuWwNOp+TvOisn5RY
 tjWs/elfwwPaDNKzlsboanuAKTRBtVBfLTvWaWDrDMV4YnCtI+4fOGECJFbmJHv9nwkg
 MePw==
X-Gm-Message-State: AOJu0Yz+7426n+xvIKylFSBjszjOEoSeLuChIbTGW3RI6h8exoqzSi+c
 uki/16qV2U7/ugyOhTEaXK8=
X-Google-Smtp-Source: AGHT+IFAv9oJgIYcKJ6yUF7NRSszFZgSOjHGSBF07XECHLhV9XJu+4BwMfvY2rAhS+HzYhGaRQ3Lug==
X-Received: by 2002:a05:620a:2944:b0:75b:23a1:8336 with SMTP id
 n4-20020a05620a294400b0075b23a18336mr623775qkp.49.1691718432089; 
 Thu, 10 Aug 2023 18:47:12 -0700 (PDT)
Received: from wheely.local0.net ([61.68.161.249])
 by smtp.gmail.com with ESMTPSA id
 v8-20020aa78088000000b0068790c41ca2sm2160940pff.27.2023.08.10.18.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 18:47:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC v2 PATCH] record-replay: support SMP target machine
Date: Fri, 11 Aug 2023 11:47:00 +1000
Message-Id: <20230811014700.39172-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=npiggin@gmail.com; helo=mail-qk1-x72a.google.com
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

RR CPU switching is driven by timers and events so it is deterministic
like everything else. Record a CPU switch event and use that to drive
the CPU switch on replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This is still in RFC phase because so far I've only really testd ppc
pseries, and only with patches that are not yet upstream (but posted
to list).

It works with smp 2, can step, reverse-step, reverse-continue, etc.
throughout a Linux boot.

One issue is reverse-step on one gdb thread (vCPU) only steps back one
icount, so if another thread is currently running then it is that one
which goes back one instruction and the selected thread doesn't move. I
would call this a separate issue from the record-replay mechanism, which
is in the replay-debugging policy. I think we could record in each vCPU
an icount of the last instruction it executed before switching, then
reverse step for that vCPU could replay to there. I think that's not so
important yet until this mechanism is solid. But if you test and rsi is
not going backwards, then check your other threads.

Thanks,
Nick


 accel/tcg/tcg-accel-ops-icount.c |  9 +++-
 accel/tcg/tcg-accel-ops-rr.c     | 73 +++++++++++++++++++++++++++++---
 include/exec/replay-core.h       |  3 ++
 replay/replay-internal.h         |  1 +
 replay/replay.c                  | 34 ++++++++++++++-
 scripts/replay-dump.py           |  5 +++
 softmmu/vl.c                     |  4 --
 7 files changed, 115 insertions(+), 14 deletions(-)

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
index 212d6f8df4..ce040a687e 100644
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
@@ -61,6 +62,22 @@ void rr_kick_vcpu_thread(CPUState *unused)
 
 static QEMUTimer *rr_kick_vcpu_timer;
 static CPUState *rr_current_cpu;
+static CPUState *rr_next_cpu;
+static CPUState *rr_last_cpu;
+
+/*
+ * Reset the vCPU scheduler to the initial state.
+ */
+static void record_replay_reset(void *param)
+{
+    if (rr_kick_vcpu_timer) {
+        timer_del(rr_kick_vcpu_timer);
+    }
+    g_assert(!rr_current_cpu);
+    rr_next_cpu = NULL;
+    rr_last_cpu = first_cpu;
+    current_cpu = NULL;
+}
 
 static inline int64_t rr_next_kick_time(void)
 {
@@ -184,6 +201,8 @@ static void *rr_cpu_thread_fn(void *arg)
     Notifier force_rcu;
     CPUState *cpu = arg;
 
+    qemu_register_reset(record_replay_reset, NULL);
+
     assert(tcg_enabled());
     rcu_register_thread();
     force_rcu.notify = rr_force_rcu;
@@ -238,14 +257,20 @@ static void *rr_cpu_thread_fn(void *arg)
             cpu_budget = icount_percpu_budget(cpu_count);
         }
 
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
         rr_start_kick_timer();
 
         replay_mutex_unlock();
 
-        if (!cpu) {
-            cpu = first_cpu;
-        }
-
         while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
             /* Store rr_current_cpu before evaluating cpu_can_run().  */
             qatomic_set_mb(&rr_current_cpu, cpu);
@@ -284,7 +309,34 @@ static void *rr_cpu_thread_fn(void *arg)
                 break;
             }
 
-            cpu = CPU_NEXT(cpu);
+            if (replay_mode == REPLAY_MODE_NONE) {
+                cpu = CPU_NEXT(cpu);
+            } else if (replay_mode == REPLAY_MODE_RECORD) {
+                /*
+                 * Exit the loop immediately so CPU switch events can be
+                 * recorded. This may be able to be improved to record
+                 * switch events here.
+                 */
+                cpu = CPU_NEXT(cpu);
+                break;
+            } else if (replay_mode == REPLAY_MODE_PLAY) {
+                /*
+                 * Play can exit from tcg_cpus_exec at different times than
+                 * record, because icount budget is set to next non-insn
+                 * event which could be an exception or something that
+                 * tcg_cpus_exec can process internally if icount limit was
+                 * not reached. So we don't necessarily switch CPU here,
+		 * only if there is a switch in the trace.
+                 */
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
@@ -294,9 +346,9 @@ static void *rr_cpu_thread_fn(void *arg)
             qatomic_set_mb(&cpu->exit_request, 0);
         }
 
-        if (all_cpu_threads_idle()) {
-            rr_stop_kick_timer();
+        qatomic_set(&rr_next_cpu, cpu);
 
+        if (all_cpu_threads_idle()) {
             if (icount_enabled()) {
                 /*
 		 * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
@@ -304,6 +356,13 @@ static void *rr_cpu_thread_fn(void *arg)
                  * timer.
                  */
                 qemu_notify_event();
+            } else {
+                /*
+                 * icount timer won't expire when not executing instructions
+                 * so no need to stop it. Avoiding restarts is also important
+                 * for record-replay to avoid clock events.
+                 */
+                rr_stop_kick_timer();
             }
         }
 
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
index 0f7d766efe..e2d77ab644 100644
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
+            g_assert_not_reached();
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
index b0b96f67fa..946b22d1de 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -1869,10 +1869,6 @@ static void qemu_apply_machine_options(QDict *qdict)
         /* fall back to the -kernel/-append */
         semihosting_arg_fallback(current_machine->kernel_filename, current_machine->kernel_cmdline);
     }
-
-    if (current_machine->smp.cpus > 1) {
-        replay_add_blocker("smp");
-    }
 }
 
 static void qemu_create_early_backends(void)
-- 
2.40.1


