Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 999B47FF3FA
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 16:52:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jKH-0000ng-Hi; Thu, 30 Nov 2023 10:51:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8jKA-0000k9-BF; Thu, 30 Nov 2023 10:51:34 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8jK8-00006P-BY; Thu, 30 Nov 2023 10:51:34 -0500
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b3f55e1bbbso618406b6e.2; 
 Thu, 30 Nov 2023 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701359490; x=1701964290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8QPMCGWSLvNCXd16iwPw5w68XKPy3BHx7h35WYzno0=;
 b=kHdUv6xBysxQrFrIZUZjJ1RmF81viAhUIbMhTKF25l1QjXIyUatDMhORGqE6mFmYes
 pUFfHH7cXu81hhUwDuuEniV9ZAApMh3zY19VeVZqYds3njJUiPC2+X5Zcbc0Wtbzdgtf
 IX584e5RnN08MeKrcLmEK7KJc5X/l/IyoBvT54hm1EuZFNovHNOyhRFhC1hxOv1ZRbeX
 CtuDQ9ed+uNlMrl9OC+CvMrH8n+KvqQECsAX55qxgajFwWpnGk6SHZLZx85gzkUIbQDP
 9sa614xNyOf25vOmtBYHitrpm2olnLx+J5c5m6xEj5EXbXo3rmEx21l1Tzl8ETyXyllF
 tlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701359490; x=1701964290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8QPMCGWSLvNCXd16iwPw5w68XKPy3BHx7h35WYzno0=;
 b=CtL0TphU5cSklhkQ70GQ08vuYRX/vOcS7oe9DVo7zGqHhzuKO+ajznNTt2ftozlPqF
 tonDwK5C62/AL0puVGyxXBL/NcrtNsfeuW1bXXdYdO8K66kXfL8nYmYuv5CM3jTb9mWq
 eHm2kiCoI1B5I+Zh0Bm3LZEJS/DePc98dRZwIhd7GuKlXmUtr5tQ2cqu6/KLIlnu5zN+
 2pH8H2pH7hMgq/wl0Z7ab6lILvxxzABLk30LMDRq9PZtYXibH6P289MBbyBOLalD2+hK
 4lAHFZHV4oF7hf9VQPQY2VU6P3HvSbvA0tBZmTHMRTnbXUXylXbWdao+zTpS41qEm5/c
 AAEw==
X-Gm-Message-State: AOJu0YyZYhXkH8StZBHdB0l3hJMOIVKDRzwkNi3H9WNsRrSdQWtNhDwf
 SQF/3IqU/mGVduOyV0JKkz/bQKihDSnH8g==
X-Google-Smtp-Source: AGHT+IEWZBfikaimZuRoZTcdOMhEtlW4ZY1iUTiFynjRBmL2JzTKsODsEa6oGQod0PDmtH4Zc53RFw==
X-Received: by 2002:a05:6808:2111:b0:3b8:3826:6dcd with SMTP id
 r17-20020a056808211100b003b838266dcdmr23678904oiw.25.1701359489651; 
 Thu, 30 Nov 2023 07:51:29 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:599c:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 4-20020a630804000000b005b856fab5e9sm1403433pgi.18.2023.11.30.07.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 07:51:29 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH v3] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Thu, 30 Nov 2023 21:20:58 +0530
Message-Id: <20231130155058.237850-1-arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <5fd22680f77a7ec5c02e6508da6daaffc1202050>
References: <5fd22680f77a7ec5c02e6508da6daaffc1202050>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=arorajai2798@gmail.com; helo=mail-oi1-x236.google.com
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827

Signed-off-by: Jai Arora <arorajai2798@gmail.com>
---

Notes:
    v3: Addresses review comments by Alex Bennée
    
    Removes trace events kvm_run_exit_reason, kvm_exit_system_event
    and their usage.
    
    Adds trace event kvm_run_exit_system_event to trace run->system_event.type

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


