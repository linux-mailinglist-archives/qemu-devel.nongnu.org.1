Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A78DE7FDE3C
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 18:22:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8OG6-0005AD-E1; Wed, 29 Nov 2023 12:21:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8OG3-00059O-Hn; Wed, 29 Nov 2023 12:21:55 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r8OG1-0006LS-78; Wed, 29 Nov 2023 12:21:55 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6cbbfdf72ecso6710700b3a.2; 
 Wed, 29 Nov 2023 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701278510; x=1701883310; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CPup2Lz56b8vekq5Xhrf9CuVK3A8egjMIZB2EYYXxjo=;
 b=KRwOqwrB5H2hn44oBZw6pBYXnAMXAFg9I3gPkNA8+0gC7agW6KhpZtz5i16gy3fBIq
 swHgF2VcDrTVR6ZWPcXw7dAVOvhVxP50Vb2cEmzzCnTZagwLCvyvchian9Qc4iXg2kJT
 tF98JDYMBLeUSnvxsRZHcnZ3DxoabgBFcU2E3wNflysw6CepbdFRFX8gKUG5niFdBw5m
 /wcjPiGUW4y3bxx7wFSxnX5iAOyN3PAc4zAwP3yIFuur/K3Whoe5eJHE1EkF/wiYju9K
 SeaQ/ZXbTsf63JClYpXuqcvdzW3ukAqvmwc1xreNhxbP49n2r39pfND2CcdZKhtSltUL
 Mv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701278510; x=1701883310;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CPup2Lz56b8vekq5Xhrf9CuVK3A8egjMIZB2EYYXxjo=;
 b=d+ccEMzJo17BNCIFaUPXO4OkaFu4bF7doghxsfRt/eZGls+H1yhssCGvDofbLAcWKO
 fA4r03GUWOILgwNXU9QFWxD8KHpJS1Wsr8A95kv1KDCBzp2/u16IiicykZJtkv0fKwbG
 cQQ4bOkEhiPb+kYVBw08OGcLYjnLYsBhx9gFEoGs3xJ/diHr3aRfMwlNLK5fwbyL4adP
 fxbb5z/QtlI9yewEAFqZClB5iAEPpoWXGciRCo1+k02lXCT/rMQeGRMJe19ok+Fi1ykM
 pyFNXiZU9+xXEPl5fnTxx4xvqq/1u4kVp7uFKcf/EweijIC1ixc1fMazgqLkp7hhPVZ7
 6qAA==
X-Gm-Message-State: AOJu0Yz6C88fqBBcOdN9JTOMLpdEw2lkF9/YyZjVvsE4DXAUkpbAVdsI
 rWSyNGQ1OK8POHni9jrn3BOEQv0AiryPSw==
X-Google-Smtp-Source: AGHT+IEXa8fmxUmUt+9LjVr4G7QiE/bU6sxmLWeZI5u84fof1x0CGTzdo1t5zJvAJQLXzthG3EXFBw==
X-Received: by 2002:a05:6a20:2446:b0:18c:23b0:3b16 with SMTP id
 t6-20020a056a20244600b0018c23b03b16mr16677388pzc.60.1701278510313; 
 Wed, 29 Nov 2023 09:21:50 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:9b9:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 y2-20020aa78042000000b006cbbc07a1c0sm10989347pfm.156.2023.11.29.09.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 09:21:49 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH v2] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Wed, 29 Nov 2023 22:51:10 +0530
Message-Id: <20231129172109.207516-1-arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=arorajai2798@gmail.com; helo=mail-pf1-x435.google.com
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
 accel/kvm/kvm-all.c    | 33 +++++++++++----------------------
 accel/kvm/trace-events |  8 +++++++-
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..0801ca7933 100644
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
@@ -2900,7 +2889,7 @@ int kvm_cpu_exec(CPUState *cpu)
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
         switch (run->exit_reason) {
         case KVM_EXIT_IO:
-            DPRINTF("handle_io\n");
+            trace_kvm_run_exit_reason("handle_io\n");
             /* Called outside BQL */
             kvm_handle_io(run->io.port, attrs,
                           (uint8_t *)run + run->io.data_offset,
@@ -2910,7 +2899,7 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_MMIO:
-            DPRINTF("handle_mmio\n");
+            trace_kvm_run_exit_reason("handle_mmio\n");
             /* Called outside BQL */
             address_space_rw(&address_space_memory,
                              run->mmio.phys_addr, attrs,
@@ -2920,11 +2909,11 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_IRQ_WINDOW_OPEN:
-            DPRINTF("irq_window_open\n");
+            trace_kvm_run_exit_reason("irq_window_open\n");
             ret = EXCP_INTERRUPT;
             break;
         case KVM_EXIT_SHUTDOWN:
-            DPRINTF("shutdown\n");
+            trace_kvm_run_exit_reason("shutdown\n");
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             ret = EXCP_INTERRUPT;
             break;
@@ -2976,14 +2965,14 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = 0;
                 break;
             default:
-                DPRINTF("kvm_arch_handle_exit\n");
+                trace_kvm_exit_system_event("kvm_arch_handle_exit\n");
                 ret = kvm_arch_handle_exit(cpu, run);
                 break;
             }
             break;
         default:
-            DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
+            trace_kvm_run_exit_reason("kvm_arch_handle_exit\n");
             break;
         }
     } while (ret == 0);
diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
index 399aaeb0ec..e7b9e9bcc1 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -25,4 +25,10 @@ kvm_dirty_ring_reaper(const char *s) "%s"
 kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
 kvm_dirty_ring_reaper_kick(const char *reason) "%s"
 kvm_dirty_ring_flush(int finished) "%d"
-
+kvm_destroy_vcpu(void) ""
+kvm_failed_get_vcpu_mmap_size(void) ""
+kvm_cpu_exec(void) ""
+kvm_interrupt_exit_request(void) ""
+kvm_io_window_exit(void) ""
+kvm_run_exit_reason(const char *s) "%s"
+kvm_exit_system_event(const char *s) "%s"
-- 
2.25.1


