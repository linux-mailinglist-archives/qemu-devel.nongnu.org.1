Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED377B6FE1
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:35:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF7-0008UD-Ug; Tue, 03 Oct 2023 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEu-0008Ju-65
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:21 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEq-0007UD-Dv
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:19 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57bb6a2481fso650176eaf.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354272; x=1696959072; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Mbut2ODg1Fv2ap6i66YnCAsMEvW6+IBkqTGctiKXdk=;
 b=oI4QWfhvAvbFHIwcmRVZtb7aUnQpq9PLkce9AVM2NkJ+BVqYfwK56mI3l4CBdfebBo
 Hfg3FIhOhILkeLweXPdqkjpBiE+1PRZ4gQZNJY+ODXHbCKDSJoun0VQhyG3tAE5cYgnO
 ArzcKXapUfswfH8O7XE9++xJLRa73OTj5OxvjPuu45YG60y23bl4/GKllBbM7ORsr4J0
 8nA1wGEukSXcKNwHWIcslRjsTuRfvcgiP79EpNRRTg6TVrphsWmyQnTMWoqTqvPTeaW6
 ZrWWhOk7oda6prdBVyZ7jpQ6h4ZKpHyygalJMFla5A9/pJa2H0LuoGi/y/slubgChRiJ
 1Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354272; x=1696959072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Mbut2ODg1Fv2ap6i66YnCAsMEvW6+IBkqTGctiKXdk=;
 b=gnGGZ8gTdCWflkMiySvxd1IknHV+SpSpq/L7Dahduidq+eiBXLtMr2bwKq6X0S+pe1
 QmRlIAkA9FdrkwDwJSPydAR+GUPpXbtdYmNJUJJyILTS4YwDqf2doFUMxH8owip/Q2gn
 Qdsq/DzI6zr47teOHQjeH/q7VoEAVlv0m7W3c1JgUcuBp8e8MQHE/vgfF6tGGEWO6jsD
 OY2YXqa6wbh1IRhWd9xiBcPUcHR9fqy99IAdQrvH1srap+634Ky2TKxUP9cZOBcSdDe+
 VHBtt7BB4lVry5/bbRPe4/jzv96txmX/RcrasaFWGJ3nk9A+/zKTonVRuBGlliGEczVo
 v1/g==
X-Gm-Message-State: AOJu0Yyif96qaqSNUv7lugiABHw1/q3ZuC8Vx6FpeYk/UoXHJgXfdpyL
 9D0MuWxYeS+cccIdXWQghoTatIUYLLgS5o3ITCU=
X-Google-Smtp-Source: AGHT+IFWvP2bpPr5jWHmqavZPlbLm6c0qFHy6kliSOPiYo+JTGeCJ8ubRpZsEZGHJ15CmdyotAJCZQ==
X-Received: by 2002:a05:6358:1ca:b0:143:e3a:de5f with SMTP id
 e10-20020a05635801ca00b001430e3ade5fmr63758rwa.26.1696354271834; 
 Tue, 03 Oct 2023 10:31:11 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/47] accel/tcg: Move can_do_io to CPUNegativeOffsetState
Date: Tue,  3 Oct 2023 10:30:21 -0700
Message-Id: <20231003173052.1601813-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Minimize the displacement to can_do_io, since it may
be touched at the start of each TranslationBlock.
It fits into other padding within the substructure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h            |  6 ++----
 accel/dummy-cpus.c               |  2 +-
 accel/hvf/hvf-accel-ops.c        |  2 +-
 accel/kvm/kvm-accel-ops.c        |  2 +-
 accel/tcg/cpu-exec-common.c      |  2 +-
 accel/tcg/cpu-exec.c             |  2 +-
 accel/tcg/cputlb.c               |  2 +-
 accel/tcg/tcg-accel-ops-icount.c |  2 +-
 accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
 accel/tcg/tcg-accel-ops-rr.c     |  4 ++--
 accel/tcg/translator.c           | 10 ++++++----
 hw/core/cpu-common.c             |  2 +-
 softmmu/icount.c                 |  2 +-
 softmmu/watchpoint.c             |  2 +-
 14 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 973ff9d106..293cedd9b5 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -351,6 +351,7 @@ typedef union IcountDecr {
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
     IcountDecr icount_decr;
+    bool can_do_io;
 } CPUNegativeOffsetState;
 
 typedef struct CPUBreakpoint {
@@ -420,9 +421,7 @@ struct qemu_work_item;
  * @crash_occurred: Indicates the OS reported a crash (panic) for this CPU
  * @singlestep_enabled: Flags for single-stepping.
  * @icount_extra: Instructions until next timer event.
- * @can_do_io: Nonzero if memory-mapped IO is safe. Deterministic execution
- * requires that IO only be performed on the last instruction of a TB
- * so that interrupts take effect immediately.
+ * @neg.can_do_io: True if memory-mapped IO is allowed.
  * @cpu_ases: Pointer to array of CPUAddressSpaces (which define the
  *            AddressSpaces this CPU has)
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
@@ -547,7 +546,6 @@ struct CPUState {
     int cluster_index;
     uint32_t tcg_cflags;
     uint32_t halted;
-    uint32_t can_do_io;
     int32_t exception_index;
 
     AccelCPUState *accel;
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index d6a1b8d0a2..b75c919ac3 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -27,7 +27,7 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
 #ifndef _WIN32
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 3c94c79747..abe7adf7ee 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -428,7 +428,7 @@ static void *hvf_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     hvf_init_vcpu(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 457eafa380..6195150a0b 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -36,7 +36,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     current_cpu = cpu;
 
     r = kvm_init_vcpu(cpu, &error_fatal);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 7e35d7f4b5..82ae837e39 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -36,7 +36,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
 void cpu_loop_exit(CPUState *cpu)
 {
     /* Undo the setting in cpu_tb_exec.  */
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     /* Undo any setting in generated code.  */
     qemu_plugin_disable_mem_helpers(cpu);
     siglongjmp(cpu->jmp_env, 1);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 60f1986b85..de60fdb612 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -455,7 +455,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 
     qemu_thread_jit_execute();
     ret = tcg_qemu_tb_exec(env, tb_ptr);
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     qemu_plugin_disable_mem_helpers(cpu);
     /*
      * TODO: Delay swapping back to the read-write region of the TB
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 3270f65c20..d69e046b80 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1361,7 +1361,7 @@ io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
     section = iotlb_to_section(cpu, xlat, attrs);
     mr_offset = (xlat & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (!cpu->can_do_io) {
+    if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
index 3d2cfbbc97..0af643b217 100644
--- a/accel/tcg/tcg-accel-ops-icount.c
+++ b/accel/tcg/tcg-accel-ops-icount.c
@@ -153,7 +153,7 @@ void icount_handle_interrupt(CPUState *cpu, int mask)
 
     tcg_handle_interrupt(cpu, mask);
     if (qemu_cpu_is_self(cpu) &&
-        !cpu->can_do_io
+        !cpu->neg.can_do_io
         && (mask & ~old_mask) != 0) {
         cpu_abort(cpu, "Raised interrupt while not in I/O function");
     }
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 4b0dfb4be7..ae95ba419e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -80,7 +80,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     current_cpu = cpu;
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 2d523289a8..671a3c4ca0 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -192,7 +192,7 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
@@ -334,7 +334,7 @@ void rr_start_vcpu_thread(CPUState *cpu)
         cpu->thread = single_tcg_cpu_thread;
         cpu->halt_cond = single_tcg_halt_cond;
         cpu->thread_id = first_cpu->thread_id;
-        cpu->can_do_io = 1;
+        cpu->neg.can_do_io = 1;
         cpu->created = true;
     }
 }
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index b3e12d61e9..460bfc4c74 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -20,9 +20,11 @@ static void set_can_do_io(DisasContextBase *db, bool val)
 {
     if (db->saved_can_do_io != val) {
         db->saved_can_do_io = val;
-        tcg_gen_st_i32(tcg_constant_i32(val), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
-                       offsetof(ArchCPU, env));
+
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUState, neg.can_do_io) != 1);
+        tcg_gen_st8_i32(tcg_constant_i32(val), cpu_env,
+                        offsetof(ArchCPU, parent_obj.neg.can_do_io) -
+                        offsetof(ArchCPU, env));
     }
 }
 
@@ -83,7 +85,7 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
     }
 
     /*
-     * cpu->can_do_io is set automatically here at the beginning of
+     * cpu->neg.can_do_io is set automatically here at the beginning of
      * each translation block.  The cost is minimal, plus it would be
      * very easy to forget doing it in the translator.
      */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 08d5bbc873..4d406995ab 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -131,7 +131,7 @@ static void cpu_common_reset_hold(Object *obj)
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = true;
     cpu->exception_index = -1;
     cpu->crash_occurred = false;
     cpu->cflags_next_tb = -1;
diff --git a/softmmu/icount.c b/softmmu/icount.c
index 144e24829c..956d15e343 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -111,7 +111,7 @@ static int64_t icount_get_raw_locked(void)
     CPUState *cpu = current_cpu;
 
     if (cpu && cpu->running) {
-        if (!cpu->can_do_io) {
+        if (!cpu->neg.can_do_io) {
             error_report("Bad icount read");
             exit(1);
         }
diff --git a/softmmu/watchpoint.c b/softmmu/watchpoint.c
index 5350163385..45d1f12faf 100644
--- a/softmmu/watchpoint.c
+++ b/softmmu/watchpoint.c
@@ -177,7 +177,7 @@ void cpu_check_watchpoint(CPUState *cpu, vaddr addr, vaddr len,
                  * Force recompile to succeed, because icount may
                  * be read only at the end of the block.
                  */
-                if (!cpu->can_do_io) {
+                if (!cpu->neg.can_do_io) {
                     /* Force execution of one insn next time.  */
                     cpu->cflags_next_tb = 1 | CF_LAST_IO | CF_NOIRQ
                                           | curr_cflags(cpu);
-- 
2.34.1


