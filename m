Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA87FAA8B
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 20:45:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7hWB-0001CK-3Q; Mon, 27 Nov 2023 14:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r7hW7-0001Bz-C9; Mon, 27 Nov 2023 14:43:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arorajai2798@gmail.com>)
 id 1r7hW4-0002Fj-LN; Mon, 27 Nov 2023 14:43:39 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cfbce92362so14198485ad.1; 
 Mon, 27 Nov 2023 11:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701114214; x=1701719014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2ahiKFyzFbwEzdE7xhZcSTyQXSleyIgdmWJnU3ce4oM=;
 b=llvprczyl0jNo7lgeFIqKy84NA6GXu5Pdc4POpy1zMpBvv57QVgy6zwOkkk+QaOvoe
 DfMtrt2905XKfd+rE0SMaSz6c6mxF+hGSaNGx+BiWeiGMVo2B2o/9RhKVcMMoQfm5jGW
 UKTkPY1Nel4iOxeOB9kKfERJCbazWUEUtmhlVhyALj9eznp+S7yihSuyHJh2llluxgMm
 DKeJc+WcqZyGAb/XbFJsAcejhGPkURvFeKurFENdwiyWcXl8saNIfjs5JPe4takgSLLR
 tWUdeT+EX70/y5Y+gVqw92HgrU+72rX5pVAq0v43a/EncqxfCNZ70Ak9y0HFkEC2q7dk
 Rs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701114214; x=1701719014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ahiKFyzFbwEzdE7xhZcSTyQXSleyIgdmWJnU3ce4oM=;
 b=s1COy04EQ6tPE6B6vfUD5V545bv+nG0LOsYTj1XHlFf50loaGVF7JOQznpkUQPhspb
 MsPfdDk5wOUsv3fC0HAh4ye6X72ujhkYh6QDfg9TogQHjqMxu4NW6va/LN2mB50fQCXT
 a7cXRMEUFL8JMYQhipZS43RiTLh+NZ6Carb3lP5TiLlKrNNlodj48IXQuNa6WE2hbP6o
 6ADL61HNt5rgjdCnjPDomc0xGEosdDyZSlHxCiPMp82UUzUmViaXmXQskjVeMeagblIp
 tTb8wfF/i3BFh4hPGFAxw/tFCg0FY+DB7tEHnyNEhRMmU1yaoSTIlNFjYfExzXHP5Ohq
 xTxw==
X-Gm-Message-State: AOJu0YyReUg5oQVQiSA5eJPiES+S0Hjobgi1GP1awfy6HcVr4+GIV2Lx
 zTOGLuBMBAiY8wqbkrjY3/mh989zeu6BeA==
X-Google-Smtp-Source: AGHT+IGrimGWHLNtvgKdOoMjA9Xv7dX7JfCLE5f+L74IiewpQikVkFRApbWEMq9+g04xFKXpHw7thg==
X-Received: by 2002:a17:902:ea03:b0:1cf:59df:23e with SMTP id
 s3-20020a170902ea0300b001cf59df023emr14323624plg.12.1701114214215; 
 Mon, 27 Nov 2023 11:43:34 -0800 (PST)
Received: from localhost.localdomain ([2406:7400:56:d1b7:dcc3:8696:be12:127c])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a170902c28100b001cf658f20ecsm8732647pld.96.2023.11.27.11.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 11:43:33 -0800 (PST)
From: Jai Arora <arorajai2798@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org,
	Jai Arora <arorajai2798@gmail.com>
Subject: [PATCH] accel/kvm: Turn DPRINTF macro use into tracepoints
Date: Tue, 28 Nov 2023 01:12:58 +0530
Message-Id: <20231127194258.138603-1-arorajai2798@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=arorajai2798@gmail.com; helo=mail-pl1-x62b.google.com
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

To remove DPRINTF macros and use tracepoints
for logging.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1827

Signed-off-by: Jai Arora <arorajai2798@gmail.com>
---
 accel/kvm/kvm-all.c    | 32 ++++++++++----------------------
 accel/kvm/trace-events |  2 +-
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e39a810a4e..d0dd7e54c3 100644
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
+    trace_kvm_dprintf("kvm_destroy_vcpu\n");
 
     ret = kvm_arch_destroy_vcpu(cpu);
     if (ret < 0) {
@@ -341,7 +331,7 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
     mmap_size = kvm_ioctl(s, KVM_GET_VCPU_MMAP_SIZE, 0);
     if (mmap_size < 0) {
         ret = mmap_size;
-        DPRINTF("KVM_GET_VCPU_MMAP_SIZE failed\n");
+        trace_kvm_dprintf("KVM_GET_VCPU_MMAP_SIZE failed\n");
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
+    trace_kvm_dprintf("kvm_cpu_exec()\n");
 
     if (kvm_arch_process_async_events(cpu)) {
         qatomic_set(&cpu->exit_request, 0);
@@ -2848,7 +2837,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         kvm_arch_pre_run(cpu, run);
         if (qatomic_read(&cpu->exit_request)) {
-            DPRINTF("interrupt exit requested\n");
+	    trace_kvm_dprintf("interrupt exit requested\n");
             /*
              * KVM requires us to reenter the kernel after IO exits to complete
              * instruction emulation. This self-signal will ensure that we
@@ -2878,7 +2867,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
         if (run_ret < 0) {
             if (run_ret == -EINTR || run_ret == -EAGAIN) {
-                DPRINTF("io window exit\n");
+		trace_kvm_dprintf("io window exit\n");
                 kvm_eat_signals(cpu);
                 ret = EXCP_INTERRUPT;
                 break;
@@ -2900,7 +2889,7 @@ int kvm_cpu_exec(CPUState *cpu)
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
         switch (run->exit_reason) {
         case KVM_EXIT_IO:
-            DPRINTF("handle_io\n");
+            trace_kvm_dprintf("handle_io\n");
             /* Called outside BQL */
             kvm_handle_io(run->io.port, attrs,
                           (uint8_t *)run + run->io.data_offset,
@@ -2910,7 +2899,7 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_MMIO:
-            DPRINTF("handle_mmio\n");
+            trace_kvm_dprintf("handle_mmio\n");
             /* Called outside BQL */
             address_space_rw(&address_space_memory,
                              run->mmio.phys_addr, attrs,
@@ -2920,11 +2909,11 @@ int kvm_cpu_exec(CPUState *cpu)
             ret = 0;
             break;
         case KVM_EXIT_IRQ_WINDOW_OPEN:
-            DPRINTF("irq_window_open\n");
+            trace_kvm_dprintf("irq_window_open\n");
             ret = EXCP_INTERRUPT;
             break;
         case KVM_EXIT_SHUTDOWN:
-            DPRINTF("shutdown\n");
+            trace_kvm_dprintf("shutdown\n");
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             ret = EXCP_INTERRUPT;
             break;
@@ -2976,13 +2965,12 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = 0;
                 break;
             default:
-                DPRINTF("kvm_arch_handle_exit\n");
+                trace_kvm_dprintf("kvm_arch_handle_exit\n");
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
index 399aaeb0ec..1754909efe 100644
--- a/accel/kvm/trace-events
+++ b/accel/kvm/trace-events
@@ -25,4 +25,4 @@ kvm_dirty_ring_reaper(const char *s) "%s"
 kvm_dirty_ring_reap(uint64_t count, int64_t t) "reaped %"PRIu64" pages (took %"PRIi64" us)"
 kvm_dirty_ring_reaper_kick(const char *reason) "%s"
 kvm_dirty_ring_flush(int finished) "%d"
-
+kvm_dprintf(const char *s) "from KVM: %s"
-- 
2.25.1


