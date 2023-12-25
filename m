Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D3F81DF0E
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 09:12:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHg38-00081X-8n; Mon, 25 Dec 2023 03:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2d-0007iu-J0; Mon, 25 Dec 2023 03:10:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2W-0008Kl-6y; Mon, 25 Dec 2023 03:10:27 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 853CB3E969;
 Mon, 25 Dec 2023 11:10:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 42BD953010;
 Mon, 25 Dec 2023 11:10:08 +0300 (MSK)
Received: (nullmailer pid 78186 invoked by uid 1000);
 Mon, 25 Dec 2023 08:10:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Jai Arora <arorajai2798@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 5/7] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Mon, 25 Dec 2023 11:10:05 +0300
Message-Id: <20231225081007.78141-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225081007.78141-1-mjt@tls.msk.ru>
References: <20231225081007.78141-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Jai Arora <arorajai2798@gmail.com>

Patch removes DPRINTF macro and adds multiple tracepoints
to capture different kvm events.

We also drop the DPRINTFs that don't add any additional
information than trace_kvm_run_exit already does.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827

Signed-off-by: Jai Arora <arorajai2798@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 accel/kvm/kvm-all.c    | 28 ++++++----------------------
 accel/kvm/trace-events |  7 ++++++-
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f138e7fefe..eb17773f0b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -69,16 +69,6 @@
 #define KVM_GUESTDBG_BLOCKIRQ 0
 #endif
 
-//#define DEBUG_KVM
-
-#ifdef DEBUG_KVM
-#define DPRINTF(fmt, ...) \
-    do { fprintf(stderr, fmt, ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) \
-    do { } while (0)
-#endif
-
 struct KVMParkedVcpu {
     unsigned long vcpu_id;
     int kvm_fd;
@@ -331,7 +321,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
     struct KVMParkedVcpu *vcpu = NULL;
     int ret = 0;
 
-    DPRINTF("kvm_destroy_vcpu\n");
+    trace_kvm_destroy_vcpu();
 
     ret = kvm_arch_destroy_vcpu(cpu);
     if (ret < 0) {
@@ -341,7 +331,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
+        trace_kvm_failed_get_vcpu_mmap_size();
         goto err;
     }
 
@@ -443,7 +433,6 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
                                    PAGE_SIZE * KVM_DIRTY_LOG_PAGE_OFFSET);
         if (cpu->kvm_dirty_gfns == MAP_FAILED) {
             ret = -errno;
-            DPRINTF("mmap'ing vcpu dirty gfns failed: %d\n", ret);
             goto err;
         }
     }
@@ -2821,7 +2810,7 @@ int kvm_cpu_exec(CPUState *cpu)
     struct kvm_run *run = cpu->kvm_run;
     int ret, run_ret;
 
-    DPRINTF("kvm_cpu_exec()\n");
+    trace_kvm_cpu_exec();
 
     if (kvm_arch_process_async_events(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
@@ -2848,7 +2837,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         kvm_arch_pre_run(cpu, run);
         if (qatomic_read(&cpu->exit_request)) {
-            DPRINTF("interrupt exit requested\n");
+	    trace_kvm_interrupt_exit_request();
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
              * instruction emulation. This self-signal will ensure that we
@@ -2878,7 +2867,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         if (run_ret < 0) {
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
-                DPRINTF("io window exit\n");
+                trace_kvm_io_window_exit();
                 kvm_eat_signals(cpu);
                 ret = EXCP_INTERRUPT;
                 break;
@@ -2900,7 +2889,6 @@ int kvm_cpu_exec(CPUState *cpu)
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
         switch (run->exit_reason) {
         case KVM_EXIT_IO:
-            DPRINTF("handle_io\n");
             /* Called outside BQL */
             kvm_handle_io(run->io.port, attrs,
                           (uint8_t *)run + run->io.data_offset,
@@ -2910,7 +2898,6 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_MMIO:
-            DPRINTF("handle_mmio\n");
             /* Called outside BQL */
             address_space_rw(&address_space_memory,
                              run->mmio.phys_addr, attrs,
@@ -2920,11 +2907,9 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_IRQ_WINDOW_OPEN:
-            DPRINTF("irq_window_open\n");
             ret = EXCP_INTERRUPT;
             break;
         case KVM_EXIT_SHUTDOWN:
-            DPRINTF("shutdown\n");
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             ret = EXCP_INTERRUPT;
             break;
@@ -2959,6 +2944,7 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_SYSTEM_EVENT:
+            trace_kvm_run_exit_system_event(cpu->cpu_index, run->system_event.type);
             switch (run->system_event.type) {
             case KVM_SYSTEM_EVENT_SHUTDOWN:
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
@@ -2976,13 +2962,11 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = 0;
                 break;
             default:
-                DPRINTF("kvm_arch_handle_exit\n");
                 ret = kvm_arch_handle_exit(cpu, run);
                 break;
             }
             break;
         default:
-            DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
             break;
         }
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 399aaeb0ec..a25902597b 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -25,4 +25,9 @@ kvm_dirty_ring_reaper(const char *s) "%s"
 kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
 kvm_dirty_ring_reaper_kick(const char *reason) "%s"
 kvm_dirty_ring_flush(int finished) "%d"
-
+kvm_destroy_vcpu(void) ""
+kvm_failed_get_vcpu_mmap_size(void) ""
+kvm_cpu_exec(void) ""
+kvm_interrupt_exit_request(void) ""
+kvm_io_window_exit(void) ""
+kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %"PRIu32
-- 
2.39.2


