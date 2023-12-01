Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE0800A57
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 13:04:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r92E5-0003CE-P8; Fri, 01 Dec 2023 07:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r92Dx-0003Aw-BS; Fri, 01 Dec 2023 07:02:31 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r92Du-00022L-JX; Fri, 01 Dec 2023 07:02:25 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6cde14ff73bso1676947b3a.0; 
 Fri, 01 Dec 2023 04:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701432138; x=1702036938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wnoDGhP9G+NHTWo9Lu1gi4yoipKdVxcn/KXCttPxlvE=;
 b=cbXwryehjDe+rca8E2SX4i7B+5WqSExpSM0AEDXP8Gd8hfZ5CybkZFnZF5wDcHjO06
 5Vls8w8RythU3TVoysWsVQ3QO8hfqpnw9RJPMsl3FGS2BrochRojNVT155G7thn+xaFf
 Yncxz39HYx78XKEIf0vOesn3fmURQ7EcV+UT/bnLVoTNsWlJ/5OGBtaKAca5Emo73wnt
 hBng2EsQVenKir+nPrhrOMoYVIfRn0I4V5sAaPbFmoOFqTERaZ0rL6ywxvznXJ1/vY+y
 677kVmUxPviKm4v6E3zN3hKHPwMJTJuvpvglsaXW6IJGM0lyTkEDNeGxFbxa5gKLte81
 CA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701432138; x=1702036938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnoDGhP9G+NHTWo9Lu1gi4yoipKdVxcn/KXCttPxlvE=;
 b=w6p4zdlg6ckPFU2Tv55beDyTlFzjqwZ5Kf58w362ciLp0/lRz7ntusgauRzBEIKLEe
 K7VFOh20W1IoIj70E1a1oJDebI/+GIUc/NqJYcNaetk6ES4tz1tYiHzXn5chNsumY1Fk
 FlEvcIkVUlZP0GPtkq+l9OxZQO9hXpXrmeXQOun4AnlIcZ63dLdCUzzXIJ9jXTYa18cT
 birW375+uy8sFOeUlX1YbCz0d0GDe0pHuC1UeyEcba1AUD2RTgBAX2nbIw2gqXQjX+rP
 KpVgwQtcqB0eBwS5guej37UA+gQTGWjoShAGaOz6gk0YhjSk4ZjM90yk7CFCcvs9T9EB
 DLsw==
X-Gm-Message-State: AOJu0Yxlxw1GI9caXULABYCBh42Nz5P+5fZDX4rXgPaCcQAKzNMNIRio
 owIfXBRvDSu0vuDs/RPzSwh0AA3d95S6wQ==
X-Google-Smtp-Source: AGHT+IHvbIlWTJTURXTf83gZalpLRUgde98OM4weX7kXj1jCnrjFQsorIX8bzlCrJuwpfxbyxZ5SlA==
X-Received: by 2002:a05:6a00:2190:b0:6cd:fda4:b57c with SMTP id
 h16-20020a056a00219000b006cdfda4b57cmr2310150pfi.15.1701432138436; 
 Fri, 01 Dec 2023 04:02:18 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:ba2b:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a632a08000000b0056606274e54sm2940215pgq.31.2023.12.01.04.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 04:02:18 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org,
 Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH v5] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Fri,  1 Dec 2023 17:32:02 +0530
Message-Id: <473931c9cd6191faa87533dc496fbfad7a0b9e17.1701431600.git.arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=arorajai2798@gmail.com; helo=mail-pf1-x432.google.com
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

Patch removes DPRINTF macro and adds multiple tracepoints
to capture different kvm events.

We also drop the DPRINTFs that don't add any additional
information than trace_kvm_run_exit already does.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827

Signed-off-by: Jai Arora <arorajai2798@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v4: Addressed review comments by Philippe Mathieu-Daudé
Corrects typo DRPINTF in commit message
Changed %d to PRIu32 in kvm_run_exit_system_event

I am not sure what you meant by keeping previous tag.
I think you meant to keep version tag same,
so I will keep patch tag as v5 again this time.
 
 accel/kvm/kvm-all.c    | 28 ++++++----------------------
 accel/kvm/trace-events |  7 ++++++-
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..80ac7b35b7 100644
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
2.25.1


