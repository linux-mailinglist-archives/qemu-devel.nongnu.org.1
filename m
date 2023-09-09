Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3519F79974B
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:29:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevCk-0007Nl-4l; Sat, 09 Sep 2023 06:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevCg-0007Mb-US; Sat, 09 Sep 2023 06:28:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevCe-0004U1-5Z; Sat, 09 Sep 2023 06:28:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A8FE2049F;
 Sat,  9 Sep 2023 13:28:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6E77E26CFD;
 Sat,  9 Sep 2023 13:27:58 +0300 (MSK)
Received: (nullmailer pid 346658 invoked by uid 1000);
 Sat, 09 Sep 2023 10:27:57 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 12/34] softmmu: Use async_run_on_cpu in tcg_commit
Date: Sat,  9 Sep 2023 13:27:05 +0300
Message-Id: <20230909102747.346522-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

After system startup, run the update to memory_dispatch
and the tlb_flush on the cpu.  This eliminates a race,
wherein a running cpu sees the memory_dispatch change
but has not yet seen the tlb_flush.

Since the update now happens on the cpu, we need not use
qatomic_rcu_read to protect the read of memory_dispatch.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1826
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1834
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1846
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 0d58c660689f6da1e3feff8a997014003d928b3b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 9a5fabf625..7e35d7f4b5 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -33,36 +33,6 @@ void cpu_loop_exit_noexc(CPUState *cpu)
     cpu_loop_exit(cpu);
 }
 
-#if defined(CONFIG_SOFTMMU)
-void cpu_reloading_memory_map(void)
-{
-    if (qemu_in_vcpu_thread() && current_cpu->running) {
-        /* The guest can in theory prolong the RCU critical section as long
-         * as it feels like. The major problem with this is that because it
-         * can do multiple reconfigurations of the memory map within the
-         * critical section, we could potentially accumulate an unbounded
-         * collection of memory data structures awaiting reclamation.
-         *
-         * Because the only thing we're currently protecting with RCU is the
-         * memory data structures, it's sufficient to break the critical section
-         * in this callback, which we know will get called every time the
-         * memory map is rearranged.
-         *
-         * (If we add anything else in the system that uses RCU to protect
-         * its data structures, we will need to implement some other mechanism
-         * to force TCG CPUs to exit the critical section, at which point this
-         * part of this callback might become unnecessary.)
-         *
-         * This pair matches cpu_exec's rcu_read_lock()/rcu_read_unlock(), which
-         * only protects cpu->as->dispatch. Since we know our caller is about
-         * to reload it, it's safe to split the critical section.
-         */
-        rcu_read_unlock();
-        rcu_read_lock();
-    }
-}
-#endif
-
 void cpu_loop_exit(CPUState *cpu)
 {
     /* Undo the setting in cpu_tb_exec.  */
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 87dc9a752c..41788c0bdd 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -133,7 +133,6 @@ static inline void cpu_physical_memory_write(hwaddr addr,
 {
     cpu_physical_memory_rw(addr, (void *)buf, len, true);
 }
-void cpu_reloading_memory_map(void);
 void *cpu_physical_memory_map(hwaddr addr,
                               hwaddr *plen,
                               bool is_write);
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 7597dc1c39..18277ddd67 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -680,8 +680,7 @@ address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr = orig_addr;
-    AddressSpaceDispatch *d =
-        qatomic_rcu_read(&cpu->cpu_ases[asidx].memory_dispatch);
+    AddressSpaceDispatch *d = cpu->cpu_ases[asidx].memory_dispatch;
 
     for (;;) {
         section = address_space_translate_internal(d, addr, &addr, plen, false);
@@ -2412,7 +2411,7 @@ MemoryRegionSection *iotlb_to_section(CPUState *cpu,
 {
     int asidx = cpu_asidx_from_attrs(cpu, attrs);
     CPUAddressSpace *cpuas = &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d = qatomic_rcu_read(&cpuas->memory_dispatch);
+    AddressSpaceDispatch *d = cpuas->memory_dispatch;
     int section_index = index & ~TARGET_PAGE_MASK;
     MemoryRegionSection *ret;
 
@@ -2487,23 +2486,42 @@ static void tcg_log_global_after_sync(MemoryListener *listener)
     }
 }
 
+static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
+{
+    CPUAddressSpace *cpuas = data.host_ptr;
+
+    cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
+    tlb_flush(cpu);
+}
+
 static void tcg_commit(MemoryListener *listener)
 {
     CPUAddressSpace *cpuas;
-    AddressSpaceDispatch *d;
+    CPUState *cpu;
 
     assert(tcg_enabled());
     /* since each CPU stores ram addresses in its TLB cache, we must
        reset the modified entries */
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-    cpu_reloading_memory_map();
-    /* The CPU and TLB are protected by the iothread lock.
-     * We reload the dispatch pointer now because cpu_reloading_memory_map()
-     * may have split the RCU critical section.
+    cpu = cpuas->cpu;
+
+    /*
+     * Defer changes to as->memory_dispatch until the cpu is quiescent.
+     * Otherwise we race between (1) other cpu threads and (2) ongoing
+     * i/o for the current cpu thread, with data cached by mmu_lookup().
+     *
+     * In addition, queueing the work function will kick the cpu back to
+     * the main loop, which will end the RCU critical section and reclaim
+     * the memory data structures.
+     *
+     * That said, the listener is also called during realize, before
+     * all of the tcg machinery for run-on is initialized: thus halt_cond.
      */
-    d = address_space_to_dispatch(cpuas->as);
-    qatomic_rcu_set(&cpuas->memory_dispatch, d);
-    tlb_flush(cpuas->cpu);
+    if (cpu->halt_cond) {
+        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+    } else {
+        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+    }
 }
 
 static void memory_map_init(void)
-- 
2.39.2


