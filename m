Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1D80011B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 02:39:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8sTZ-0006fc-Ie; Thu, 30 Nov 2023 20:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8sTY-0006fJ-24; Thu, 30 Nov 2023 20:37:52 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8sTW-0001nO-22; Thu, 30 Nov 2023 20:37:51 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28655c04da3so277393a91.0; 
 Thu, 30 Nov 2023 17:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701394666; x=1701999466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=z5PSB3d/61h/9JdMyR7kBDrS8wo0JBnVGqlDr4jgQ6c=;
 b=mKsLwhGKfSJKjtJsIn7TJN11VNKGPHjLqvbUMzWD64ooe7x2MDY+uftLfpmtLw9V84
 kbOZcOgg/JMbObYSuGOZ+n50j4ZJN799HK3Nj8k+yM3Kqv++uf35ThNVnOD7iblcr7yS
 3xaumGQjZxPzKQztjfJJYyVmXg9okEEJhZhFbVRIFrDZ3jvZfOWRaGP1oso2iXe+YfLV
 dPskkZdyy5WQhe/PGfB9fTUaj5U64kJxgVbpQQNl2ewW7aT+TT43ZtaaR7jlhv7aH6UZ
 e8cj7EMtxkg3i3mBUZJOo3Cjdu8s2HMJsn+PeYRuZ9vfr7ZqQDqewXov/tbpjLYKXwAr
 c41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701394666; x=1701999466;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z5PSB3d/61h/9JdMyR7kBDrS8wo0JBnVGqlDr4jgQ6c=;
 b=tYzJq4fR8jHRXT2mTDzKxKW3BpB+wYVfLe2sg/XY09DHtMyrEx3hXnBjpXVLviOVUf
 bmKipH+Co1OKBGF7MZVFzGGLX1I4g9XNXnxAuYoTJKJiHqiKk5GapoH0vo9i9IDu/6OT
 hL4QWw3u08CRn8hY7pWvD94ftCU36P0Ovd1ovtfLYitOcu22V+tJQ9h6wodL86AwBTEL
 I8i5W3e6Q37gy/mrBdYeHIh2v6GNIcgA1z9Ic+O20v773zuu3tB8GivYIPYmthwVdxYh
 vIXUAqKMV6GrypEynulQxp37mwdyvyHwKqKjfb47kGu03+9KlDBJbEQLvkPJnDbGeBF9
 DlBA==
X-Gm-Message-State: AOJu0YxxrOkrpIQx6wRuMNmzPaLM9vXvVm/ef69LgKzLNHT+1lOtnzAB
 pKusV+4XanWpq/iw5XCNRNhacGB4EEavQA==
X-Google-Smtp-Source: AGHT+IEh+OoeRfR3OToX3QphK5QZGVNFcQoNUiLbmPHqmHUJsc8fAOFCgDIzTotYOR0b5lDje3cx0w==
X-Received: by 2002:a17:90b:310d:b0:286:1809:1517 with SMTP id
 gc13-20020a17090b310d00b0028618091517mr11526346pjb.7.1701394666380; 
 Thu, 30 Nov 2023 17:37:46 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:3a45:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a17090ad70100b002802d9d4e96sm3867991pju.54.2023.11.30.17.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 17:37:45 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 alex.bennee@linaro.org, Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH v5] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Fri,  1 Dec 2023 07:06:51 +0530
Message-Id: <38e5b2bff5475185eeb528f6b73140c47ae00b82.1701394286.git.arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=arorajai2798@gmail.com; helo=mail-pj1-x102d.google.com
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

Patch removes DRPINTF macro and adds multiple tracepoints
to capture different kvm events.

We also drop the DPRINTFs that don't add any additional
information than trace_kvm_run_exit already does.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827

Signed-off-by: Jai Arora <arorajai2798@gmail.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v5: Adds Reviewed-by tag as requested by Alex Bennee

Added it now, thanks for the feedback. :)

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
index 399aaeb0ec..f61a21019a 100644
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
+kvm_run_exit_system_event(int cpu_index, uint32_t event_type) "cpu_index %d, system_even_type %d"
-- 
2.25.1


