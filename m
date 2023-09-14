Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287A279F863
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLb-0000di-GD; Wed, 13 Sep 2023 22:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLZ-0000cq-8E
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:49 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLX-0000gs-8Y
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:44:49 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c1ff5b741cso4100105ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659486; x=1695264286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOvQCzIzxLMDJ87kcYEQtFPhAbQROHYo+So2k/YjGYo=;
 b=MNo6Km1Kz47htZcVvtTrjdLqBpW9GLMZmU0iD4lOqUIyMCfV0+uchONLoZXE+9oyZ0
 cUjxS4GHdoSNmpsWBpNsh2RVC3MLQVqt2QR0+QkfIrgp5E45AUxtuyAclfrPw/kekHl1
 oK3+zqsKOymhvKDIlnqR8ZQJ6MYR4dDg+z8Um7dbaaZ6WFb9TioVOQVK31Jf2nashI4H
 mYbo8f4eJZo4kMh+kUgbsB5KccTkpo5csHTWJlwCaAQvDa00NF2CnSexR5hLQbrWLmuy
 w8fb23+SgQsgjMrqSD2duXLygyfBl7/fay3RdxFDVMSducqC+7rkru9AMyjivU0rPMGU
 T3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659486; x=1695264286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOvQCzIzxLMDJ87kcYEQtFPhAbQROHYo+So2k/YjGYo=;
 b=p2xQuDnYVAMJ7NiPuezbd3yv3BNTlnPEHvgvEwuE/xn2jhalcMO0VdxoQtDuFXdzsE
 xEiAadW0UWmZ5PHvkmLNErKrjyZtgG/m30zsRmZRn328svPQ80jgQMfJeWLLDmrhrHu0
 DjK42x/w/uSP2BSwE2T0lQBdyCQ38O91Er1C69gDIKtEb/CrNNd56dDFwVZ6FcTq9cOY
 wjDz+1iCF8OYDwLpxvPJ4K9LGftLRcqlqIJd8K2GXkCCgumgRG+w6XLJGzQb1+DZClf0
 GP6z0aXYHeHTV2KWZoamYxH/LDmknq146+PiD4R1CiNOW8yJ//I2+SqlW0zzMBRLNRK8
 ToxQ==
X-Gm-Message-State: AOJu0YwpEQiVCR7oshRuAHrwMEUjyk2e6nFoN5yNlOF+oKBpG6JhQOoD
 zIfBSH/nS0pw1G0HquFauZ542vyjCkauFihbKro=
X-Google-Smtp-Source: AGHT+IEKjvwhgZSGc2RaSj6E56O74ZYDoYDdteR7Fj+bh8wqz10jZ0iPe7N7rm9x47tQuyQeYuiwMg==
X-Received: by 2002:a17:902:850b:b0:1bd:d6b5:a54f with SMTP id
 bj11-20020a170902850b00b001bdd6b5a54fmr3908599plb.55.1694659485698; 
 Wed, 13 Sep 2023 19:44:45 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 10/24] accel/tcg: Move can_do_io to CPUNegativeOffsetState
Date: Wed, 13 Sep 2023 19:44:21 -0700
Message-Id: <20230914024435.1381329-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h            | 2 +-
 accel/dummy-cpus.c               | 2 +-
 accel/kvm/kvm-accel-ops.c        | 2 +-
 accel/tcg/cpu-exec-common.c      | 2 +-
 accel/tcg/cpu-exec.c             | 2 +-
 accel/tcg/cputlb.c               | 4 ++--
 accel/tcg/tcg-accel-ops-icount.c | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c  | 2 +-
 accel/tcg/tcg-accel-ops-rr.c     | 4 ++--
 accel/tcg/translator.c           | 4 ++--
 hw/core/cpu-common.c             | 2 +-
 softmmu/icount.c                 | 2 +-
 softmmu/watchpoint.c             | 2 +-
 13 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 44955af3bc..99066da2f3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -350,6 +350,7 @@ typedef union IcountDecr {
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
+    uint32_t can_do_io;
     IcountDecr icount_decr;
 } CPUNegativeOffsetState;
 
@@ -557,7 +558,6 @@ struct CPUState {
     int cluster_index;
     uint32_t tcg_cflags;
     uint32_t halted;
-    uint32_t can_do_io;
     int32_t exception_index;
 
     AccelCPUState *accel;
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index d6a1b8d0a2..af7f90a4da 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -27,7 +27,7 @@ static void *dummy_cpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
     current_cpu = cpu;
 
 #ifndef _WIN32
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 457eafa380..b610c0d378 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -36,7 +36,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
     qemu_mutex_lock_iothread();
     qemu_thread_get_self(cpu->thread);
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
     current_cpu = cpu;
 
     r = kvm_init_vcpu(cpu, &error_fatal);
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index 7e35d7f4b5..8ac2af4d0c 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -36,7 +36,7 @@ void cpu_loop_exit_noexc(CPUState *cpu)
 void cpu_loop_exit(CPUState *cpu)
 {
     /* Undo the setting in cpu_tb_exec.  */
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
     /* Undo any setting in generated code.  */
     qemu_plugin_disable_mem_helpers(cpu);
     siglongjmp(cpu->jmp_env, 1);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index e2c494e75e..b01e3e5dc8 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -455,7 +455,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 
     qemu_thread_jit_execute();
     ret = tcg_qemu_tb_exec(env, tb_ptr);
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
     qemu_plugin_disable_mem_helpers(cpu);
     /*
      * TODO: Delay swapping back to the read-write region of the TB
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index c643d66190..21c035497f 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1394,7 +1394,7 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
     mr = section->mr;
     mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc = retaddr;
-    if (!cpu->can_do_io) {
+    if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
 
@@ -1433,7 +1433,7 @@ static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
     section = iotlb_to_section(cpu, full->xlat_section, full->attrs);
     mr = section->mr;
     mr_offset = (full->xlat_section & TARGET_PAGE_MASK) + addr;
-    if (!cpu->can_do_io) {
+    if (!cpu->neg.can_do_io) {
         cpu_io_recompile(cpu, retaddr);
     }
     cpu->mem_io_pc = retaddr;
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
index b276262007..a8e375b3e6 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -80,7 +80,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
     current_cpu = cpu;
     cpu_thread_signal_created(cpu);
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 2d523289a8..c0aceb0a04 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -192,7 +192,7 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_thread_get_self(cpu->thread);
 
     cpu->thread_id = qemu_get_thread_id();
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
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
index 54190c785b..888302160c 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -19,7 +19,7 @@
 static void gen_io_start(void)
 {
     tcg_gen_st_i32(tcg_constant_i32(1), cpu_env,
-                   offsetof(ArchCPU, parent_obj.can_do_io) -
+                   offsetof(ArchCPU, parent_obj.neg.can_do_io) -
                    offsetof(ArchCPU, env));
 }
 
@@ -92,7 +92,7 @@ static TCGOp *gen_tb_start(uint32_t cflags)
          * go with gen_io_start().
          */
         tcg_gen_st_i32(tcg_constant_i32(0), cpu_env,
-                       offsetof(ArchCPU, parent_obj.can_do_io) -
+                       offsetof(ArchCPU, parent_obj.neg.can_do_io) -
                        offsetof(ArchCPU, env));
     }
 
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 08d5bbc873..f0e07f3ae7 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -131,7 +131,7 @@ static void cpu_common_reset_hold(Object *obj)
     cpu->mem_io_pc = 0;
     cpu->icount_extra = 0;
     qatomic_set(&cpu->neg.icount_decr.u32, 0);
-    cpu->can_do_io = 1;
+    cpu->neg.can_do_io = 1;
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


