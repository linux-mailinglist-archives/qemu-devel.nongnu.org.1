Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934E72460E
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:32:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Xic-00052e-RG; Tue, 06 Jun 2023 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xia-000520-3p
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6XiY-0001Dj-3y
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jH0KcXHYqMwMAiwsZIxHsgDaYtU76N2Q6FR8CaYtlyQ=;
 b=K53HZ48T5VDWvfd3G5p46nHl2Hg9NqdffCROAXYRG/shNFbGoJlOEVHGNT4aUqPlqhAxXz
 sRdgvqrJnd74HCtAVWwxopT9vBwVN4xoF2WQ4Q+86/eE72988ueKhFOUG/9wgtlqyG8khr
 3bQctw+CuJtUi6zGGhPWG2nrKMXuU1g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-XCDRK_3XNRm1Uwb8ac4B0w-1; Tue, 06 Jun 2023 10:31:23 -0400
X-MC-Unique: XCDRK_3XNRm1Uwb8ac4B0w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-94a341efd9aso521883466b.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061881; x=1688653881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jH0KcXHYqMwMAiwsZIxHsgDaYtU76N2Q6FR8CaYtlyQ=;
 b=R2cOt5u0KKDPnyw47T1Ro9QgAf69C0SWoQIs+uGgLy/DOxzaZywkE/vtOrp57feL5D
 2cWl+gjlSVOnysS6AKtxf6guJPC9YTzcriKMj4OCi5ph8yq3Uci1bPkTvQTz5EF/SJUO
 FxC456PyeGHCMYrpNnLPj/7RC/xPLw3cdmNkaCssZOSR3GQNXKav/VNDKupH3MoPJ87l
 SWNIJhzguvzRk0g9VRPP0PaJ5uDTeuFaap6FYi+P/Qxtu19QIAM7c5pNwQ1mppnEawAI
 dFqf+rHzt0H75uVaQt9GHMWi3X2bRnGtBWOO0fWOAsVllAK7/RPSlxccvTU7fsA43r7h
 nK4w==
X-Gm-Message-State: AC+VfDy1II0I3gwBgAEB0wRbdXwmdQl3NyjFgMlhNzLhIIDM07A1wzkQ
 Qeqr+ZzX5clXYv6cTwEAvswgGXt+sQ+hlscR63vy+RvXUWMVy39Xz2Ig3swqpcNtbHKv2A/C/wj
 pM07sG7QYeV07KJiof5r54iiXxzY9eCdphB/GJDFaYZmIrbMGPg+CQWXbykcorx7sCLGtZ1Hd9y
 g=
X-Received: by 2002:a17:907:2ce5:b0:973:cb21:8479 with SMTP id
 hz5-20020a1709072ce500b00973cb218479mr2806953ejc.70.1686061881101; 
 Tue, 06 Jun 2023 07:31:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5paUGpeGlswCqVtb/7yCLIP/UWUXR+1n4k87WrzHGz90m9I+QvlR/xc2KWt61AsmIoVOhZWQ==
X-Received: by 2002:a17:907:2ce5:b0:973:cb21:8479 with SMTP id
 hz5-20020a1709072ce500b00973cb218479mr2806930ejc.70.1686061880721; 
 Tue, 06 Jun 2023 07:31:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a17090606cd00b00977da0f14ffsm2751583ejb.171.2023.06.06.07.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/21] atomics: eliminate mb_read/mb_set
Date: Tue,  6 Jun 2023 16:30:57 +0200
Message-Id: <20230606143116.685644-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

qatomic_mb_read and qatomic_mb_set were the very first atomic primitives
introduced for QEMU; their semantics are unclear and they provide a false
sense of safety.

The last use of qatomic_mb_read() has been removed, so delete it.
qatomic_mb_set() instead can survive as an optimized
qatomic_set()+smp_mb(), similar to Linux's smp_store_mb(), but
rename it to qatomic_set_mb() to match the order of the two
operations.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c              |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.c   |  2 +-
 accel/tcg/tcg-accel-ops-rr.c      |  4 ++--
 docs/devel/atomics.rst            | 27 ++++-----------------------
 include/qemu/atomic.h             | 17 +++++------------
 monitor/qmp.c                     |  2 +-
 softmmu/cpus.c                    |  2 +-
 softmmu/physmem.c                 |  2 +-
 target/arm/hvf/hvf.c              |  2 +-
 tests/unit/test-aio-multithread.c |  2 +-
 util/qemu-coroutine-lock.c        |  4 ++--
 11 files changed, 20 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 1cf4f1fa227..42086525d7a 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -774,7 +774,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * Ensure zeroing happens before reading cpu->exit_request or
      * cpu->interrupt_request (see also smp_wmb in cpu_exit())
      */
-    qatomic_mb_set(&cpu_neg(cpu)->icount_decr.u16.high, 0);
+    qatomic_set_mb(&cpu_neg(cpu)->icount_decr.u16.high, 0);
 
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 5d72c9b1bd3..b320ff00373 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -119,7 +119,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
             }
         }
 
-        qatomic_mb_set(&cpu->exit_request, 0);
+        qatomic_set_mb(&cpu->exit_request, 0);
         qemu_wait_io_event(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 70b9b89073c..23e4d0f4527 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -244,7 +244,7 @@ static void *rr_cpu_thread_fn(void *arg)
 
         while (cpu && cpu_work_list_empty(cpu) && !cpu->exit_request) {
             /* Store rr_current_cpu before evaluating cpu_can_run().  */
-            qatomic_mb_set(&rr_current_cpu, cpu);
+            qatomic_set_mb(&rr_current_cpu, cpu);
 
             current_cpu = cpu;
 
@@ -287,7 +287,7 @@ static void *rr_cpu_thread_fn(void *arg)
         qatomic_set(&rr_current_cpu, NULL);
 
         if (cpu && cpu->exit_request) {
-            qatomic_mb_set(&cpu->exit_request, 0);
+            qatomic_set_mb(&cpu->exit_request, 0);
         }
 
         if (icount_enabled() && all_cpu_threads_idle()) {
diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 248076375bf..ff9b5ee30c8 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -102,28 +102,10 @@ Similar operations return the new value of ``*ptr``::
     typeof(*ptr) qatomic_or_fetch(ptr, val)
     typeof(*ptr) qatomic_xor_fetch(ptr, val)
 
-``qemu/atomic.h`` also provides loads and stores that cannot be reordered
-with each other::
+``qemu/atomic.h`` also provides an optimized shortcut for
+``qatomic_set`` followed by ``smp_mb``::
 
-    typeof(*ptr) qatomic_mb_read(ptr)
-    void         qatomic_mb_set(ptr, val)
-
-However these do not provide sequential consistency and, in particular,
-they do not participate in the total ordering enforced by
-sequentially-consistent operations.  For this reason they are deprecated.
-They should instead be replaced with any of the following (ordered from
-easiest to hardest):
-
-- accesses inside a mutex or spinlock
-
-- lightweight synchronization primitives such as ``QemuEvent``
-
-- RCU operations (``qatomic_rcu_read``, ``qatomic_rcu_set``) when publishing
-  or accessing a new version of a data structure
-
-- other atomic accesses: ``qatomic_read`` and ``qatomic_load_acquire`` for
-  loads, ``qatomic_set`` and ``qatomic_store_release`` for stores, ``smp_mb``
-  to forbid reordering subsequent loads before a store.
+    void         qatomic_set_mb(ptr, val)
 
 
 Weak atomic access and manual memory barriers
@@ -523,8 +505,7 @@ and memory barriers, and the equivalents in QEMU:
       | ::                             |
       |                                |
       |   a = qatomic_read(&x);        |
-      |   qatomic_set(&x, a + 2);      |
-      |   smp_mb();                    |
+      |   qatomic_set_mb(&x, a + 2);   |
       |   b = qatomic_read(&y);        |
       +--------------------------------+
 
diff --git a/include/qemu/atomic.h b/include/qemu/atomic.h
index f85834ee8b2..d95612f7a08 100644
--- a/include/qemu/atomic.h
+++ b/include/qemu/atomic.h
@@ -259,24 +259,17 @@
 # define smp_mb__after_rmw() smp_mb()
 #endif
 
-/* qatomic_mb_read/set semantics map Java volatile variables. They are
- * less expensive on some platforms (notably POWER) than fully
- * sequentially consistent operations.
- *
- * As long as they are used as paired operations they are safe to
- * use. See docs/devel/atomics.rst for more discussion.
+/*
+ * On some architectures, qatomic_set_mb is more efficient than a store
+ * plus a fence.
  */
 
-#define qatomic_mb_read(ptr)                             \
-    qatomic_load_acquire(ptr)
-
 #if !defined(QEMU_SANITIZE_THREAD) && \
     (defined(__i386__) || defined(__x86_64__) || defined(__s390x__))
-/* This is more efficient than a store plus a fence.  */
-# define qatomic_mb_set(ptr, i) \
+# define qatomic_set_mb(ptr, i) \
     ({ (void)qatomic_xchg(ptr, i); smp_mb__after_rmw(); })
 #else
-# define qatomic_mb_set(ptr, i) \
+# define qatomic_set_mb(ptr, i) \
    ({ qatomic_store_release(ptr, i); smp_mb(); })
 #endif
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index c8e0156974d..6eee450fe40 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -246,7 +246,7 @@ static QMPRequest *monitor_qmp_dispatcher_pop_any(void)
          *
          * Clear qmp_dispatcher_co_busy before reading request.
          */
-        qatomic_mb_set(&qmp_dispatcher_co_busy, false);
+        qatomic_set_mb(&qmp_dispatcher_co_busy, false);
 
         WITH_QEMU_LOCK_GUARD(&monitor_lock) {
             QMPRequest *req_obj;
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index 9cbc8172b5f..fed20ffb5dd 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -405,7 +405,7 @@ static void qemu_cpu_stop(CPUState *cpu, bool exit)
 
 void qemu_wait_io_event_common(CPUState *cpu)
 {
-    qatomic_mb_set(&cpu->thread_kicked, false);
+    qatomic_set_mb(&cpu->thread_kicked, false);
     if (cpu->stop) {
         qemu_cpu_stop(cpu, false);
     }
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 9d7e172260f..588d0d166b9 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -3132,7 +3132,7 @@ void address_space_unmap(AddressSpace *as, void *buffer, hwaddr len,
     bounce.buffer = NULL;
     memory_region_unref(bounce.mr);
     /* Clear in_use before reading map_client_list.  */
-    qatomic_mb_set(&bounce.in_use, false);
+    qatomic_set_mb(&bounce.in_use, false);
     cpu_notify_map_clients();
 }
 
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ad65603445e..5900dc788f4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1229,7 +1229,7 @@ static void hvf_wait_for_ipi(CPUState *cpu, struct timespec *ts)
      * Use pselect to sleep so that other threads can IPI us while we're
      * sleeping.
      */
-    qatomic_mb_set(&cpu->thread_kicked, false);
+    qatomic_set_mb(&cpu->thread_kicked, false);
     qemu_mutex_unlock_iothread();
     pselect(0, 0, 0, 0, ts, &cpu->hvf->unblock_ipi_mask);
     qemu_mutex_lock_iothread();
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 80c5d4e2e6e..08d4570ccb1 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -154,7 +154,7 @@ static coroutine_fn void test_multi_co_schedule_entry(void *opaque)
         n = g_test_rand_int_range(0, NUM_CONTEXTS);
         schedule_next(n);
 
-        qatomic_mb_set(&to_schedule[id], qemu_coroutine_self());
+        qatomic_set_mb(&to_schedule[id], qemu_coroutine_self());
         /* finish_cb can run here.  */
         qemu_coroutine_yield();
         g_assert(to_schedule[id] == NULL);
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 84a50a9e911..2534435388f 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -202,7 +202,7 @@ static void coroutine_fn qemu_co_mutex_lock_slowpath(AioContext *ctx,
     push_waiter(mutex, &w);
 
     /*
-     * Add waiter before reading mutex->handoff.  Pairs with qatomic_mb_set
+     * Add waiter before reading mutex->handoff.  Pairs with qatomic_set_mb
      * in qemu_co_mutex_unlock.
      */
     smp_mb__after_rmw();
@@ -310,7 +310,7 @@ void coroutine_fn qemu_co_mutex_unlock(CoMutex *mutex)
 
         our_handoff = mutex->sequence;
         /* Set handoff before checking for waiters.  */
-        qatomic_mb_set(&mutex->handoff, our_handoff);
+        qatomic_set_mb(&mutex->handoff, our_handoff);
         if (!has_waiters(mutex)) {
             /* The concurrent lock has not added itself yet, so it
              * will be able to pick our handoff.
-- 
2.40.1


