Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60A801AC9
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 05:50:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9HwF-0003cj-OE; Fri, 01 Dec 2023 23:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r9HwD-0003c9-Lh; Fri, 01 Dec 2023 23:49:09 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r9HwB-0004hk-Pb; Fri, 01 Dec 2023 23:49:09 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35c18e55633so11546855ab.2; 
 Fri, 01 Dec 2023 20:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701492545; x=1702097345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xvi4mRz2w/E5pz1gAepmyUvWL5xNH8ENXIxXh94Gg9Y=;
 b=P9BVABsrKZQbNJuge+r/q2bbpy0w9Rycd6AvZWXWhpv+vDBquN+PGiDfQykzR216+Z
 1W65FuT2EFiB9hskUpC6bb+gPHWlQzFRXzUZ4H4sMlFp/8WSpAJ5DsVYmv2YhQoEcsIo
 E46HFYe+s0M3FF4On6kLzhWSSQ/gvOhYnrLRz8wt88BzeYfJn7O8AEh7Rh8eOPsMP0Xn
 jgx5gaYoWqI01l2/q6PE/tgLWxX0JR2Xe1ZVL0og0/ypTu+yBamevLHIqkOCrM5vHR2C
 5aTqPT4MOUWB1i8ZwMbdCH+u4GVSO4LVjq6ssUFgmZRbzfjY8ln/67a7meqWNvErVx7V
 aWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701492545; x=1702097345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xvi4mRz2w/E5pz1gAepmyUvWL5xNH8ENXIxXh94Gg9Y=;
 b=pmsvXWppxoX6m1ub1VWwvmE+aAJ2f+vpyUo2pw8KyAzmwfn8S3wdt7RVtDzWdPwx20
 0iaIprubiW+5r5/x0GbmAbMWx7t9wVgCj7eeCCHfHBZpWBBxGeKhHAgcSGgLJVbklSP3
 04Kx/9bysJ6cyYZj5uwPKv1Uu+MglXTbPhUkA4S9wRXifQxwtu6v3nOvumsIU5lyeWKm
 7q2/V27XTHmaaYg1f2nfZ9ERdt2uTKRXynh5uxJ6sXsPwyK4Ckz04HdyF70P/YkLjOn/
 dloZdlmQUYs/0M4qTiBjwJuTu5FIN/uoC0h33c3jA5FgQqEvc125Kj0gxJ9NumHn1Poe
 WGgw==
X-Gm-Message-State: AOJu0YwxtWoOxIdlkXjLir4owjqkYApg1zkECU/0Dtqfv5xceRKAuelD
 wzb2gLo9ZRyn+0WjimbAx58nN5yjAO9pQg==
X-Google-Smtp-Source: AGHT+IHZ5O1iFckILdx3dWYnCSgSjxEgvXFf/xAWgPtFj0tK0gUkZHRVAZ4mRL35WgnZB4iQfx+iRA==
X-Received: by 2002:a05:6e02:1d12:b0:35d:5995:798d with SMTP id
 i18-20020a056e021d1200b0035d5995798dmr961284ila.39.1701492545307; 
 Fri, 01 Dec 2023 20:49:05 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:4f3d:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 t11-20020a170902e84b00b001d076c2e346sm149652plg.51.2023.12.01.20.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 20:49:04 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 alex.bennee@linaro.org, philmd@linaro.org,
 Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH v5] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Sat,  2 Dec 2023 10:18:46 +0530
Message-Id: <20231202044846.258855-1-arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=arorajai2798@gmail.com; helo=mail-il1-x12d.google.com
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
v5: Addressed review comments by Philippe Mathieu-Daudé
Corrects typo DRPINTF in commit message
Changed %d to PRIu32 in kvm_run_exit_system_event
 
I am not sure what you meant by keeping previous tag.
I think you meant to keep version tag same,
so I will keep patch tag as v5 again this time.

Thank you for the feedback.

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


