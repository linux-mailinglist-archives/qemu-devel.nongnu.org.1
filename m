Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D15F7A32AD
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3B-0005Dt-J3; Sat, 16 Sep 2023 17:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2u-00058L-TJ
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2p-0000SJ-T9
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68fbd31d9ddso2677410b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900498; x=1695505298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFGmgkYpze/g+aUtKDaE2eelpraGtfeLwUNRveVwI9k=;
 b=m+/pCEy60IZERaNXj7hRqaGcfp3gAdkjhVy50Rs0w/q49SddviMzrZ2WqC+mkk2QDH
 eI7hpPTlq8AJouKahVEkmoJKxPofZ1iQ3dWKeMZHc18jQdSFzXXjAnEzueb1zsB4Zpa1
 TyKFu+1A0hupWnnv/TbnoE1UGtK1YzYDuAUhjamGVAgtsEF0H+cf/udWKFxh8/ZKvAZH
 L3KL5fPGjLpSBqEkJt2eLmiihDPxJXBix3SlOrCvhMfnW8dlA/M1QMccwUFXMymsCL+D
 uPTK1kg6OLXzpQADCw7c1gTDnHi/iVtpc5/RIw2qycrAwxZLewMsqAntrgJSyXrVB+2I
 wl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900498; x=1695505298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFGmgkYpze/g+aUtKDaE2eelpraGtfeLwUNRveVwI9k=;
 b=EmFo4wYLfRF3JKC1sVaaT9gUxvbZxPKhsqyIPHOg3vos/JCiqjpmcsYm8rf4Egx9aF
 QoPEoHUnx9PF/6C9VmwmBlJVBVkczDHk4cK+myd4w/LawGYml0DbRttFPhzqjR6D9ebx
 hSLh6/sK7eZUUXIlFzfTfggd483GaFzsV5hdhzgMMbnYF/6sianOEV1BF22AAZQuNYAo
 olu5b0zkrjIJaq0qEFpnbrsiQO88nwbGG6ZgHddi6YdqwmEi9VTpyc38SsN0Ixd+Ea5V
 cT6reVlXYI6sf8AgEB0bYIq6hjdy9a2MOuBff1r465HuKIj+WEz/CN3OZOzTnXHZZ5iE
 /HQA==
X-Gm-Message-State: AOJu0YwkM+QgeO2Zcntcc25q9ZJtR67gEB39MrlbOPRUwA2AYWlWkpYa
 a2O+mKqL+lUbkhJeH9h1WQfOsuY4wzCoyj/oFKs=
X-Google-Smtp-Source: AGHT+IEh8LykT5Zdb2+oJnug+p+XoNx4Q/Pb3GOKKEKzUfWLC5+3k3zl6/Ofv8FAqBqR6aHeqer1sA==
X-Received: by 2002:a05:6a00:22c6:b0:68e:4587:3da9 with SMTP id
 f6-20020a056a0022c600b0068e45873da9mr5265153pfj.17.1694900498287; 
 Sat, 16 Sep 2023 14:41:38 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 12/39] accel/tcg: Replace CPUState.env_ptr with cpu_env()
Date: Sat, 16 Sep 2023 14:40:56 -0700
Message-Id: <20230916214123.525796-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h               |  1 -
 include/hw/core/cpu.h                |  9 ++++++---
 target/arm/common-semi-target.h      |  2 +-
 accel/tcg/cpu-exec.c                 |  8 ++++----
 accel/tcg/cputlb.c                   | 20 ++++++++++----------
 accel/tcg/plugin-gen.c               |  2 +-
 accel/tcg/translate-all.c            |  4 ++--
 bsd-user/main.c                      |  2 +-
 bsd-user/signal.c                    | 10 +++++-----
 gdbstub/gdbstub.c                    |  4 ++--
 gdbstub/user-target.c                |  2 +-
 hw/i386/kvm/clock.c                  |  2 +-
 hw/intc/mips_gic.c                   |  2 +-
 hw/intc/riscv_aclint.c               | 12 ++++++------
 hw/intc/riscv_imsic.c                |  2 +-
 hw/ppc/e500.c                        |  4 ++--
 hw/ppc/spapr.c                       |  2 +-
 linux-user/elfload.c                 |  4 ++--
 linux-user/i386/cpu_loop.c           |  2 +-
 linux-user/main.c                    |  4 ++--
 linux-user/signal.c                  | 15 +++++++--------
 monitor/hmp-cmds-target.c            |  2 +-
 semihosting/arm-compat-semi.c        |  6 +++---
 semihosting/syscalls.c               | 28 ++++++++++++++--------------
 target/alpha/translate.c             |  4 ++--
 target/arm/cpu.c                     |  8 ++++----
 target/arm/helper.c                  |  2 +-
 target/arm/tcg/translate-a64.c       |  4 ++--
 target/arm/tcg/translate.c           |  6 +++---
 target/avr/translate.c               |  2 +-
 target/cris/translate.c              |  4 ++--
 target/hexagon/translate.c           |  4 ++--
 target/hppa/mem_helper.c             |  2 +-
 target/hppa/translate.c              |  4 ++--
 target/i386/nvmm/nvmm-all.c          | 14 +++++++-------
 target/i386/tcg/sysemu/excp_helper.c |  2 +-
 target/i386/tcg/tcg-cpu.c            |  2 +-
 target/i386/tcg/translate.c          |  4 ++--
 target/i386/whpx/whpx-all.c          | 26 +++++++++++++-------------
 target/loongarch/translate.c         |  4 ++--
 target/m68k/translate.c              |  4 ++--
 target/microblaze/translate.c        |  2 +-
 target/mips/tcg/sysemu/mips-semi.c   |  4 ++--
 target/mips/tcg/translate.c          |  4 ++--
 target/nios2/translate.c             |  4 ++--
 target/openrisc/translate.c          |  2 +-
 target/ppc/excp_helper.c             | 10 +++++-----
 target/ppc/translate.c               |  4 ++--
 target/riscv/translate.c             |  6 +++---
 target/rx/cpu.c                      |  3 ---
 target/rx/translate.c                |  2 +-
 target/s390x/tcg/translate.c         |  2 +-
 target/sh4/op_helper.c               |  2 +-
 target/sh4/translate.c               |  4 ++--
 target/sparc/translate.c             |  4 ++--
 target/tricore/translate.c           |  4 ++--
 target/xtensa/translate.c            |  4 ++--
 target/i386/tcg/decode-new.c.inc     |  2 +-
 58 files changed, 153 insertions(+), 155 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index fcd6ddac6a..bff3867c1e 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -433,7 +433,6 @@ void tcg_exec_unrealizefn(CPUState *cpu);
  */
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
-    cpu->parent_obj.env_ptr = &cpu->env;
 }
 
 /* Validate correct placement of CPUArchState. */
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 819ff1ef2e..f25d53ee90 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -429,7 +429,6 @@ struct qemu_work_item;
  * @num_ases: number of CPUAddressSpaces in @cpu_ases
  * @as: Pointer to the first AddressSpace, for the convenience of targets which
  *      only have a single AddressSpace
- * @env_ptr: Pointer to subclass-specific CPUArchState field.
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
@@ -503,8 +502,6 @@ struct CPUState {
     AddressSpace *as;
     MemoryRegion *memory;
 
-    CPUArchState *env_ptr;
-
     CPUJumpCache *tb_jmp_cache;
 
     struct GDBRegisterState *gdb_regs;
@@ -584,6 +581,12 @@ struct CPUState {
 QEMU_BUILD_BUG_ON(sizeof(CPUState) != 
                   offsetof(CPUState, neg) + sizeof(CPUNegativeOffsetState));
 
+static inline CPUArchState *cpu_env(CPUState *cpu)
+{
+    /* We validate that CPUArchState follows CPUState in cpu-all.h. */
+    return (CPUArchState *)(cpu + 1);
+}
+
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus;
 
diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 629d75ca5a..19438ed8cd 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -38,7 +38,7 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
 
 static inline bool common_semi_sys_exit_extended(CPUState *cs, int nr)
 {
-    return (nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cs->env_ptr));
+    return nr == TARGET_SYS_EXIT_EXTENDED || is_a64(cpu_env(cs));
 }
 
 static inline bool is_64bit_semihosting(CPUArchState *env)
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4abbd037f3..0e7eeef001 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -222,7 +222,7 @@ static TranslationBlock *tb_htable_lookup(CPUState *cpu, vaddr pc,
     struct tb_desc desc;
     uint32_t h;
 
-    desc.env = cpu->env_ptr;
+    desc.env = cpu_env(cpu);
     desc.cs_base = cs_base;
     desc.flags = flags;
     desc.cflags = cflags;
@@ -444,7 +444,7 @@ const void *HELPER(lookup_tb_ptr)(CPUArchState *env)
 static inline TranslationBlock * QEMU_DISABLE_CFI
 cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     uintptr_t ret;
     TranslationBlock *last_tb;
     const void *tb_ptr = itb->tc.ptr;
@@ -565,7 +565,7 @@ static void cpu_exec_longjmp_cleanup(CPUState *cpu)
 
 void cpu_exec_step_atomic(CPUState *cpu)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     TranslationBlock *tb;
     vaddr pc;
     uint64_t cs_base;
@@ -976,7 +976,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
             uint64_t cs_base;
             uint32_t flags, cflags;
 
-            cpu_get_tb_cpu_state(cpu->env_ptr, &pc, &cs_base, &flags);
+            cpu_get_tb_cpu_state(cpu_env(cpu), &pc, &cs_base, &flags);
 
             /*
              * When requested, use an exact setting for cflags for the next
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d69e046b80..f790be5b6e 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -274,7 +274,7 @@ static inline void tlb_n_used_entries_dec(CPUArchState *env, uintptr_t mmu_idx)
 
 void tlb_init(CPUState *cpu)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     int64_t now = get_clock_realtime();
     int i;
 
@@ -290,7 +290,7 @@ void tlb_init(CPUState *cpu)
 
 void tlb_destroy(CPUState *cpu)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     int i;
 
     qemu_spin_destroy(&env_tlb(env)->c.lock);
@@ -328,7 +328,7 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     size_t full = 0, part = 0, elide = 0;
 
     CPU_FOREACH(cpu) {
-        CPUArchState *env = cpu->env_ptr;
+        CPUArchState *env = cpu_env(cpu);
 
         full += qatomic_read(&env_tlb(env)->c.full_flush_count);
         part += qatomic_read(&env_tlb(env)->c.part_flush_count);
@@ -341,7 +341,7 @@ void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
 
 static void tlb_flush_by_mmuidx_async_work(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     uint16_t asked = data.host_int;
     uint16_t all_dirty, work, to_clean;
     int64_t now = get_clock_realtime();
@@ -523,7 +523,7 @@ static void tlb_flush_page_by_mmuidx_async_0(CPUState *cpu,
                                              vaddr addr,
                                              uint16_t idxmap)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -769,7 +769,7 @@ typedef struct {
 static void tlb_flush_range_by_mmuidx_async_0(CPUState *cpu,
                                               TLBFlushRangeData d)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -1032,7 +1032,7 @@ void tlb_reset_dirty(CPUState *cpu, ram_addr_t start1, ram_addr_t length)
 
     int mmu_idx;
 
-    env = cpu->env_ptr;
+    env = cpu_env(cpu);
     qemu_spin_lock(&env_tlb(env)->c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
         unsigned int i;
@@ -1064,7 +1064,7 @@ static inline void tlb_set_dirty1_locked(CPUTLBEntry *tlb_entry,
    so that it is no longer dirty */
 void tlb_set_dirty(CPUState *cpu, vaddr addr)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     int mmu_idx;
 
     assert_cpu_is_self(cpu);
@@ -1137,7 +1137,7 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, CPUTLBEntry *ent,
 void tlb_set_page_full(CPUState *cpu, int mmu_idx,
                        vaddr addr, CPUTLBEntryFull *full)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     CPUTLB *tlb = env_tlb(env);
     CPUTLBDesc *desc = &tlb->d[mmu_idx];
     MemoryRegionSection *section;
@@ -1662,7 +1662,7 @@ tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
 bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int mmu_idx,
                        bool is_store, struct qemu_plugin_hwaddr *data)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     CPUTLBEntry *tlbe = tlb_entry(env, mmu_idx, addr);
     uintptr_t index = tlb_index(env, mmu_idx, addr);
     MMUAccessType access_type = is_store ? MMU_DATA_STORE : MMU_DATA_LOAD;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 985c980c92..d31c9993ea 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -849,7 +849,7 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
     } else {
         if (ptb->vaddr2 == -1) {
             ptb->vaddr2 = TARGET_PAGE_ALIGN(db->pc_first);
-            get_page_addr_code_hostp(cpu->env_ptr, ptb->vaddr2, &ptb->haddr2);
+            get_page_addr_code_hostp(cpu_env(cpu), ptb->vaddr2, &ptb->haddr2);
         }
         pinsn->haddr = ptb->haddr2 + pinsn->vaddr - ptb->vaddr2;
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed0c7ef7ce..6fac5b7e29 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -288,7 +288,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                               vaddr pc, uint64_t cs_base,
                               uint32_t flags, int cflags)
 {
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     TranslationBlock *tb, *existing_tb;
     tb_page_addr_t phys_pc, phys_p2;
     tcg_insn_unit *gen_code_buf;
@@ -580,7 +580,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
     } else {
         /* The exception probably happened in a helper.  The CPU state should
            have been saved before calling it. Fetch the PC from there.  */
-        CPUArchState *env = cpu->env_ptr;
+        CPUArchState *env = cpu_env(cpu);
         vaddr pc;
         uint64_t cs_base;
         tb_page_addr_t addr;
diff --git a/bsd-user/main.c b/bsd-user/main.c
index f913cb55a7..6c9addb75a 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -462,7 +462,7 @@ int main(int argc, char **argv)
         ac->init_machine(NULL);
     }
     cpu = cpu_create(cpu_type);
-    env = cpu->env_ptr;
+    env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
 
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index 4db85a3485..b86eeec795 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -351,8 +351,8 @@ static int core_dump_signal(int sig)
 static G_NORETURN
 void dump_core_and_abort(int target_sig)
 {
-    CPUArchState *env = thread_cpu->env_ptr;
-    CPUState *cpu = env_cpu(env);
+    CPUState *cpu = thread_cpu;
+    CPUArchState *env = cpu_env(cpu);
     TaskState *ts = cpu->opaque;
     int core_dumped = 0;
     int host_sig;
@@ -457,7 +457,7 @@ static int fatal_signal(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
@@ -469,8 +469,8 @@ void force_sig_fault(int sig, int code, abi_ulong addr)
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
-    CPUArchState *env = thread_cpu->env_ptr;
-    CPUState *cpu = env_cpu(env);
+    CPUState *cpu = thread_cpu;
+    CPUArchState *env = cpu_env(cpu);
     TaskState *ts = cpu->opaque;
     target_siginfo_t tinfo;
     ucontext_t *uc = puc;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 349d348c7b..8eea21450c 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -423,7 +423,7 @@ static const char *get_feature_xml(const char *p, const char **newp,
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
@@ -441,7 +441,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
index 6e21c3161c..c4bba4c72c 100644
--- a/gdbstub/user-target.c
+++ b/gdbstub/user-target.c
@@ -310,7 +310,7 @@ void gdb_handle_v_file_open(GArray *params, void *user_ctx)
     uint64_t mode = get_param(params, 2)->val_ull;
 
 #ifdef CONFIG_LINUX
-    int fd = do_guest_openat(gdbserver_state.g_cpu->env_ptr, 0, filename,
+    int fd = do_guest_openat(cpu_env(gdbserver_state.g_cpu), 0, filename,
                              flags, mode, false);
 #else
     int fd = open(filename, flags, mode);
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 34348a3324..f25977d3f6 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -66,7 +66,7 @@ struct pvclock_vcpu_time_info {
 static uint64_t kvmclock_current_nsec(KVMClockState *s)
 {
     CPUState *cpu = first_cpu;
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     hwaddr kvmclock_struct_pa;
     uint64_t migration_tsc = env->tsc;
     struct pvclock_vcpu_time_info time;
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 4bdc3b1bd1..77ba7348a3 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -423,7 +423,7 @@ static void mips_gic_realize(DeviceState *dev, Error **errp)
     /* Register the env for all VPs with the GIC */
     for (i = 0; i < s->num_vps; i++) {
         if (cs != NULL) {
-            s->vps[i].env = cs->env_ptr;
+            s->vps[i].env = cpu_env(cs);
             cs = CPU_NEXT(cs);
         } else {
             error_setg(errp,
diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index 25cf7a5d9d..ab1a0b4b3a 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -131,7 +131,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque, hwaddr addr,
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu = cpu_by_arch_id(hartid);
-        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-mtimer: invalid hartid: %zu", hartid);
@@ -174,7 +174,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         size_t hartid = mtimer->hartid_base +
                         ((addr - mtimer->timecmp_base) >> 3);
         CPUState *cpu = cpu_by_arch_id(hartid);
-        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-mtimer: invalid hartid: %zu", hartid);
@@ -233,7 +233,7 @@ static void riscv_aclint_mtimer_write(void *opaque, hwaddr addr,
         /* Check if timer interrupt is triggered for each hart. */
         for (i = 0; i < mtimer->num_harts; i++) {
             CPUState *cpu = cpu_by_arch_id(mtimer->hartid_base + i);
-            CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+            CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
             if (!env) {
                 continue;
             }
@@ -375,7 +375,7 @@ DeviceState *riscv_aclint_mtimer_create(hwaddr addr, hwaddr size,
     for (i = 0; i < num_harts; i++) {
         CPUState *cpu = cpu_by_arch_id(hartid_base + i);
         RISCVCPU *rvcpu = RISCV_CPU(cpu);
-        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         riscv_aclint_mtimer_callback *cb =
             g_new0(riscv_aclint_mtimer_callback, 1);
 
@@ -409,7 +409,7 @@ static uint64_t riscv_aclint_swi_read(void *opaque, hwaddr addr,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid = swi->hartid_base + (addr >> 2);
         CPUState *cpu = cpu_by_arch_id(hartid);
-        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-swi: invalid hartid: %zu", hartid);
@@ -432,7 +432,7 @@ static void riscv_aclint_swi_write(void *opaque, hwaddr addr, uint64_t value,
     if (addr < (swi->num_harts << 2)) {
         size_t hartid = swi->hartid_base + (addr >> 2);
         CPUState *cpu = cpu_by_arch_id(hartid);
-        CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+        CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
         if (!env) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "aclint-swi: invalid hartid: %zu", hartid);
diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
index 760dbddcf7..b31d07980c 100644
--- a/hw/intc/riscv_imsic.c
+++ b/hw/intc/riscv_imsic.c
@@ -333,7 +333,7 @@ static void riscv_imsic_realize(DeviceState *dev, Error **errp)
     RISCVIMSICState *imsic = RISCV_IMSIC(dev);
     RISCVCPU *rcpu = RISCV_CPU(cpu_by_arch_id(imsic->hartid));
     CPUState *cpu = cpu_by_arch_id(imsic->hartid);
-    CPURISCVState *env = cpu ? cpu->env_ptr : NULL;
+    CPURISCVState *env = cpu ? cpu_env(cpu) : NULL;
 
     if (!kvm_irqchip_in_kernel()) {
         imsic->num_eistate = imsic->num_pages * imsic->num_irqs;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index d5b6820d1d..e04114fb3c 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -373,7 +373,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
     MachineState *machine = MACHINE(pms);
     unsigned int smp_cpus = machine->smp.cpus;
     const PPCE500MachineClass *pmc = PPCE500_MACHINE_GET_CLASS(pms);
-    CPUPPCState *env = first_cpu->env_ptr;
+    CPUPPCState *env = cpu_env(first_cpu);
     int ret = -1;
     uint64_t mem_reg_property[] = { 0, cpu_to_be64(machine->ram_size) };
     int fdt_size;
@@ -499,7 +499,7 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
         if (cpu == NULL) {
             continue;
         }
-        env = cpu->env_ptr;
+        env = cpu_env(cpu);
 
         cpu_name = g_strdup_printf("/cpus/PowerPC,8544@%x", i);
         qemu_fdt_add_subnode(fdt, cpu_name);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7cc6a890f..f919ecd8a3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1119,7 +1119,7 @@ static void spapr_dt_hypervisor(SpaprMachineState *spapr, void *fdt)
          * Older KVM versions with older guest kernels were broken
          * with the magic page, don't allow the guest to map it.
          */
-        if (!kvmppc_get_hypercall(first_cpu->env_ptr, hypercall,
+        if (!kvmppc_get_hypercall(cpu_env(first_cpu), hypercall,
                                   sizeof(hypercall))) {
             _FDT(fdt_setprop(fdt, hypervisor, "hcall-instructions",
                              hypercall, sizeof(hypercall)));
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index a5b28fa3e7..85cff102d1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -565,7 +565,7 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 static const char *get_elf_platform(void)
 {
-    CPUARMState *env = thread_cpu->env_ptr;
+    CPUARMState *env = cpu_env(thread_cpu);
 
 #if TARGET_BIG_ENDIAN
 # define END  "b"
@@ -4372,7 +4372,7 @@ static int fill_note_info(struct elf_note_info *info,
             if (cpu == thread_cpu) {
                 continue;
             }
-            fill_thread_info(info, cpu->env_ptr);
+            fill_thread_info(info, cpu_env(cpu));
         }
     }
 
diff --git a/linux-user/i386/cpu_loop.c b/linux-user/i386/cpu_loop.c
index ef2dcb3d76..42ecb4bf0a 100644
--- a/linux-user/i386/cpu_loop.c
+++ b/linux-user/i386/cpu_loop.c
@@ -323,7 +323,7 @@ void cpu_loop(CPUX86State *env)
 
 static void target_cpu_free(void *obj)
 {
-    CPUArchState *env = ((CPUState *)obj)->env_ptr;
+    CPUArchState *env = cpu_env(obj);
     target_munmap(env->gdt.base, sizeof(uint64_t) * TARGET_GDT_ENTRIES);
     g_free(obj);
 }
diff --git a/linux-user/main.c b/linux-user/main.c
index 96be354897..0a62e2be47 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -229,7 +229,7 @@ CPUArchState *cpu_copy(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
     CPUState *new_cpu = cpu_create(cpu_type);
-    CPUArchState *new_env = new_cpu->env_ptr;
+    CPUArchState *new_env = cpu_env(new_cpu);
     CPUBreakpoint *bp;
 
     /* Reset non arch specific state */
@@ -794,7 +794,7 @@ int main(int argc, char **argv, char **envp)
         ac->init_machine(NULL);
     }
     cpu = cpu_create(cpu_type);
-    env = cpu->env_ptr;
+    env = cpu_env(cpu);
     cpu_reset(cpu);
     thread_cpu = cpu;
 
diff --git a/linux-user/signal.c b/linux-user/signal.c
index 748a98f3e5..a7ba2ccaf4 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -618,7 +618,7 @@ void signal_init(void)
 void force_sig(int sig)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
@@ -636,7 +636,7 @@ void force_sig(int sig)
 void force_sig_fault(int sig, int code, abi_ulong addr)
 {
     CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu->env_ptr;
+    CPUArchState *env = cpu_env(cpu);
     target_siginfo_t info = {};
 
     info.si_signo = sig;
@@ -695,10 +695,9 @@ void cpu_loop_exit_sigbus(CPUState *cpu, target_ulong addr,
 
 /* abort execution with signal */
 static G_NORETURN
-void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
+void dump_core_and_abort(CPUArchState *env, int target_sig)
 {
-    CPUState *cpu = thread_cpu;
-    CPUArchState *env = cpu->env_ptr;
+    CPUState *cpu = env_cpu(env);
     TaskState *ts = (TaskState *)cpu->opaque;
     int host_sig, core_dumped = 0;
     struct sigaction act;
@@ -724,7 +723,7 @@ void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
             target_sig, strsignal(host_sig), "core dumped" );
     }
 
-    preexit_cleanup(cpu_env, 128 + target_sig);
+    preexit_cleanup(env, 128 + target_sig);
 
     /* The proper exit code for dying from an uncaught signal is
      * -<signal>.  The kernel doesn't allow exit() or _exit() to pass
@@ -783,8 +782,8 @@ static inline void rewind_if_in_safe_syscall(void *puc)
 
 static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 {
-    CPUArchState *env = thread_cpu->env_ptr;
-    CPUState *cpu = env_cpu(env);
+    CPUState *cpu = thread_cpu;
+    CPUArchState *env = cpu_env(cpu);
     TaskState *ts = cpu->opaque;
     target_siginfo_t tinfo;
     host_sigcontext *uc = puc;
diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 0d3e84d960..d9fbcac08d 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -81,7 +81,7 @@ CPUArchState *mon_get_cpu_env(Monitor *mon)
 {
     CPUState *cs = mon_get_cpu(mon);
 
-    return cs ? cs->env_ptr : NULL;
+    return cs ? cpu_env(cs) : NULL;
 }
 
 int monitor_get_cpu_index(Monitor *mon)
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 564fe17f75..29c5670fdf 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -251,7 +251,7 @@ static void common_semi_dead_cb(CPUState *cs, uint64_t ret, int err)
 static void common_semi_rw_cb(CPUState *cs, uint64_t ret, int err)
 {
     /* Recover the original length from the third argument. */
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     target_ulong args = common_semi_arg(cs, 1);
     target_ulong arg2;
     GET_ARG(2);
@@ -322,7 +322,7 @@ static void
 common_semi_readc_cb(CPUState *cs, uint64_t ret, int err)
 {
     if (!err) {
-        CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+        CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
         uint8_t ch;
 
         if (get_user_u8(ch, common_semi_stack_bottom(cs) - 1)) {
@@ -361,7 +361,7 @@ static const uint8_t featurefile_data[] = {
  */
 void do_common_semihosting(CPUState *cs)
 {
-    CPUArchState *env = cs->env_ptr;
+    CPUArchState *env = cpu_env(cs);
     target_ulong args;
     target_ulong arg0, arg1, arg2, arg3;
     target_ulong ul_ret;
diff --git a/semihosting/syscalls.c b/semihosting/syscalls.c
index d27574a1e2..1ab4809567 100644
--- a/semihosting/syscalls.c
+++ b/semihosting/syscalls.c
@@ -24,7 +24,7 @@
  */
 static int validate_strlen(CPUState *cs, target_ulong str, target_ulong tlen)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char c;
 
     if (tlen == 0) {
@@ -54,7 +54,7 @@ static int validate_lock_user_string(char **pstr, CPUState *cs,
                                      target_ulong tstr, target_ulong tlen)
 {
     int ret = validate_strlen(cs, tstr, tlen);
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *str = NULL;
 
     if (ret > 0) {
@@ -74,7 +74,7 @@ static int validate_lock_user_string(char **pstr, CPUState *cs,
 static int copy_stat_to_user(CPUState *cs, target_ulong addr,
                              const struct stat *s)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct gdb_stat *p;
 
     if (s->st_dev != (uint32_t)s->st_dev ||
@@ -258,7 +258,7 @@ static void host_open(CPUState *cs, gdb_syscall_complete_cb complete,
                       target_ulong fname, target_ulong fname_len,
                       int gdb_flags, int mode)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
     int ret, host_flags = O_BINARY;
 
@@ -316,7 +316,7 @@ static void host_close(CPUState *cs, gdb_syscall_complete_cb complete,
 static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
                       GuestFD *gf, target_ulong buf, target_ulong len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_WRITE, buf, len, 0);
     ssize_t ret;
 
@@ -337,7 +337,7 @@ static void host_read(CPUState *cs, gdb_syscall_complete_cb complete,
 static void host_write(CPUState *cs, gdb_syscall_complete_cb complete,
                        GuestFD *gf, target_ulong buf, target_ulong len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     void *ptr = lock_user(VERIFY_READ, buf, len, 1);
     ssize_t ret;
 
@@ -411,7 +411,7 @@ static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
                       target_ulong fname, target_ulong fname_len,
                       target_ulong addr)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct stat buf;
     char *name;
     int ret, err;
@@ -440,7 +440,7 @@ static void host_stat(CPUState *cs, gdb_syscall_complete_cb complete,
 static void host_remove(CPUState *cs, gdb_syscall_complete_cb complete,
                         target_ulong fname, target_ulong fname_len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
     int ret;
 
@@ -459,7 +459,7 @@ static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
                         target_ulong oname, target_ulong oname_len,
                         target_ulong nname, target_ulong nname_len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ostr, *nstr;
     int ret;
 
@@ -484,7 +484,7 @@ static void host_rename(CPUState *cs, gdb_syscall_complete_cb complete,
 static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
                         target_ulong cmd, target_ulong cmd_len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *p;
     int ret;
 
@@ -502,7 +502,7 @@ static void host_system(CPUState *cs, gdb_syscall_complete_cb complete,
 static void host_gettimeofday(CPUState *cs, gdb_syscall_complete_cb complete,
                               target_ulong tv_addr, target_ulong tz_addr)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     struct gdb_timeval *p;
     int64_t rt;
 
@@ -547,7 +547,7 @@ static void host_poll_one(CPUState *cs, gdb_syscall_complete_cb complete,
 static void staticfile_read(CPUState *cs, gdb_syscall_complete_cb complete,
                             GuestFD *gf, target_ulong buf, target_ulong len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     target_ulong rest = gf->staticfile.len - gf->staticfile.off;
     void *ptr;
 
@@ -605,7 +605,7 @@ static void staticfile_flen(CPUState *cs, gdb_syscall_complete_cb complete,
 static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
                          GuestFD *gf, target_ulong buf, target_ulong len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr;
     int ret;
 
@@ -622,7 +622,7 @@ static void console_read(CPUState *cs, gdb_syscall_complete_cb complete,
 static void console_write(CPUState *cs, gdb_syscall_complete_cb complete,
                           GuestFD *gf, target_ulong buf, target_ulong len)
 {
-    CPUArchState *env G_GNUC_UNUSED = cs->env_ptr;
+    CPUArchState *env G_GNUC_UNUSED = cpu_env(cs);
     char *ptr = lock_user(VERIFY_READ, buf, len, 1);
     int ret;
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 46af6574bf..32333081d8 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -2871,7 +2871,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
 static void alpha_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUAlphaState *env = cpu->env_ptr;
+    CPUAlphaState *env = cpu_env(cpu);
     int64_t bound;
 
     ctx->tbflags = ctx->base.tb->flags;
@@ -2917,7 +2917,7 @@ static void alpha_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void alpha_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUAlphaState *env = cpu->env_ptr;
+    CPUAlphaState *env = cpu_env(cpu);
     uint32_t insn = translator_ldl(env, &ctx->base, ctx->base.pc_next);
 
     ctx->base.pc_next += 4;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index d48a70c039..36797c2dd3 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -80,7 +80,7 @@ void arm_cpu_synchronize_from_tb(CPUState *cs,
 {
     /* The program counter is always up to date with CF_PCREL. */
     if (!(tb_cflags(tb) & CF_PCREL)) {
-        CPUARMState *env = cs->env_ptr;
+        CPUARMState *env = cpu_env(cs);
         /*
          * It's OK to look at env for the current mode here, because it's
          * never possible for an AArch64 TB to chain to an AArch32 TB.
@@ -97,7 +97,7 @@ void arm_restore_state_to_opc(CPUState *cs,
                               const TranslationBlock *tb,
                               const uint64_t *data)
 {
-    CPUARMState *env = cs->env_ptr;
+    CPUARMState *env = cpu_env(cs);
 
     if (is_a64(env)) {
         if (tb_cflags(tb) & CF_PCREL) {
@@ -560,7 +560,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
                                      unsigned int cur_el, bool secure,
                                      uint64_t hcr_el2)
 {
-    CPUARMState *env = cs->env_ptr;
+    CPUARMState *env = cpu_env(cs);
     bool pstate_unmasked;
     bool unmasked = false;
 
@@ -690,7 +690,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 static bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUClass *cc = CPU_GET_CLASS(cs);
-    CPUARMState *env = cs->env_ptr;
+    CPUARMState *env = cpu_env(cs);
     uint32_t cur_el = arm_current_el(env);
     bool secure = arm_is_secure(env);
     uint64_t hcr_el2 = arm_hcr_el2_eff(env);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 3b22596eab..096f1bbe6d 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10274,7 +10274,7 @@ static const int8_t target_el_table[2][2][2][2][2][4] = {
 uint32_t arm_phys_excp_target_el(CPUState *cs, uint32_t excp_idx,
                                  uint32_t cur_el, bool secure)
 {
-    CPUARMState *env = cs->env_ptr;
+    CPUARMState *env = cpu_env(cs);
     bool rw;
     bool scr;
     bool hcr;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index cb520efcd0..f9aff44dac 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -13853,7 +13853,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
+    CPUARMState *env = cpu_env(cpu);
     ARMCPU *arm_cpu = env_archcpu(env);
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(dc->base.tb);
     int bound, core_mmu_idx;
@@ -13959,7 +13959,7 @@ static void aarch64_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *s = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
+    CPUARMState *env = cpu_env(cpu);
     uint64_t pc = s->base.pc_next;
     uint32_t insn;
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 2524d8f3fb..48927fbb8c 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -9089,7 +9089,7 @@ static bool insn_crosses_page(CPUARMState *env, DisasContext *s)
 static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cs->env_ptr;
+    CPUARMState *env = cpu_env(cs);
     ARMCPU *cpu = env_archcpu(env);
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(dc->base.tb);
     uint32_t condexec, core_mmu_idx;
@@ -9317,7 +9317,7 @@ static void arm_post_translate_insn(DisasContext *dc)
 static void arm_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
+    CPUARMState *env = cpu_env(cpu);
     uint32_t pc = dc->base.pc_next;
     unsigned int insn;
 
@@ -9407,7 +9407,7 @@ static bool thumb_insn_is_unconditional(DisasContext *s, uint32_t insn)
 static void thumb_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUARMState *env = cpu->env_ptr;
+    CPUARMState *env = cpu_env(cpu);
     uint32_t pc = dc->base.pc_next;
     uint32_t insn;
     bool is_16bit;
diff --git a/target/avr/translate.c b/target/avr/translate.c
index 8d67570d17..cdffa04519 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2657,7 +2657,7 @@ static bool canonicalize_skip(DisasContext *ctx)
 static void avr_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUAVRState *env = cs->env_ptr;
+    CPUAVRState *env = cpu_env(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->cs = cs;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 395ba12bea..b3974ba0bb 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -2948,7 +2948,7 @@ static unsigned int crisv32_decoder(CPUCRISState *env, DisasContext *dc)
 static void cris_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUCRISState *env = cs->env_ptr;
+    CPUCRISState *env = cpu_env(cs);
     uint32_t tb_flags = dc->base.tb->flags;
     uint32_t pc_start;
 
@@ -3006,7 +3006,7 @@ static void cris_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUCRISState *env = cs->env_ptr;
+    CPUCRISState *env = cpu_env(cs);
     unsigned int insn_len;
 
     /* Pretty disas.  */
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 012c3c68ec..663b7bbc3a 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -1053,7 +1053,7 @@ static void hexagon_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    HexagonCPU *hex_cpu = env_archcpu(cs->env_ptr);
+    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs));
     uint32_t hex_flags = dcbase->tb->flags;
 
     ctx->mem_idx = MMU_USER_IDX;
@@ -1094,7 +1094,7 @@ static bool pkt_crosses_page(CPUHexagonState *env, DisasContext *ctx)
 static void hexagon_tr_translate_packet(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUHexagonState *env = cpu->env_ptr;
+    CPUHexagonState *env = cpu_env(cpu);
 
     decode_and_translate_packet(env, ctx);
 
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 46c3dcaf15..f28888ccca 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -305,7 +305,7 @@ void HELPER(itlbp)(CPUHPPAState *env, target_ulong addr, target_ureg reg)
    synchronous across all processors.  */
 static void ptlb_work(CPUState *cpu, run_on_cpu_data data)
 {
-    CPUHPPAState *env = cpu->env_ptr;
+    CPUHPPAState *env = cpu_env(cpu);
     target_ulong addr = (target_ulong) data.target_ptr;
     hppa_tlb_entry *ent = hppa_find_tlb(env, addr);
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index a1046e4672..902cd642ae 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3450,7 +3450,7 @@ static bool trans_b_gate(DisasContext *ctx, arg_b_gate *a)
 
 #ifndef CONFIG_USER_ONLY
     if (ctx->tb_flags & PSW_C) {
-        CPUHPPAState *env = ctx->cs->env_ptr;
+        CPUHPPAState *env = cpu_env(ctx->cs);
         int type = hppa_artype_for_page(env, ctx->base.pc_next);
         /* If we could not find a TLB entry, then we need to generate an
            ITLB miss exception so the kernel will provide it.
@@ -4111,7 +4111,7 @@ static void hppa_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void hppa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUHPPAState *env = cs->env_ptr;
+    CPUHPPAState *env = cpu_env(cs);
     DisasJumpType ret;
     int i, n;
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 066a173d26..fb769868f2 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -78,7 +78,7 @@ nvmm_set_segment(struct nvmm_x64_state_seg *nseg, const SegmentCache *qseg)
 static void
 nvmm_set_registers(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     struct nvmm_machine *mach = get_nvmm_mach();
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
@@ -215,7 +215,7 @@ nvmm_get_segment(SegmentCache *qseg, const struct nvmm_x64_state_seg *nseg)
 static void
 nvmm_get_registers(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     struct nvmm_machine *mach = get_nvmm_mach();
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
@@ -340,7 +340,7 @@ nvmm_get_registers(CPUState *cpu)
 static bool
 nvmm_can_take_int(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     struct nvmm_machine *mach = get_nvmm_mach();
@@ -387,7 +387,7 @@ nvmm_can_take_nmi(CPUState *cpu)
 static void
 nvmm_vcpu_pre_run(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     struct nvmm_machine *mach = get_nvmm_mach();
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
@@ -473,8 +473,8 @@ static void
 nvmm_vcpu_post_run(CPUState *cpu, struct nvmm_vcpu_exit *exit)
 {
     AccelCPUState *qcpu = cpu->accel;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     uint64_t tpr;
 
     env->eflags = exit->exitstate.rflags;
@@ -645,7 +645,7 @@ static int
 nvmm_handle_halted(struct nvmm_machine *mach, CPUState *cpu,
     struct nvmm_vcpu_exit *exit)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     int ret = 0;
 
     qemu_mutex_lock_iothread();
@@ -678,11 +678,11 @@ nvmm_inject_ud(struct nvmm_machine *mach, struct nvmm_vcpu *vcpu)
 static int
 nvmm_vcpu_loop(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
     struct nvmm_machine *mach = get_nvmm_mach();
     AccelCPUState *qcpu = cpu->accel;
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     struct nvmm_vcpu_exit *exit = vcpu->exit;
     int ret;
 
diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
index 226689a4f2..5b86f439ad 100644
--- a/target/i386/tcg/sysemu/excp_helper.c
+++ b/target/i386/tcg/sysemu/excp_helper.c
@@ -597,7 +597,7 @@ bool x86_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
                       MMUAccessType access_type, int mmu_idx,
                       bool probe, uintptr_t retaddr)
 {
-    CPUX86State *env = cs->env_ptr;
+    CPUX86State *env = cpu_env(cs);
     TranslateResult out;
     TranslateFault err;
 
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index b942c306d6..cbde3abe97 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -51,7 +51,7 @@ static void x86_cpu_synchronize_from_tb(CPUState *cs,
 {
     /* The instruction pointer is always up to date with CF_PCREL. */
     if (!(tb_cflags(tb) & CF_PCREL)) {
-        CPUX86State *env = cs->env_ptr;
+        CPUX86State *env = cpu_env(cs);
         env->eip = tb->pc - tb->cs_base;
     }
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8a4687227..c6894d66b1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3079,7 +3079,7 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     int b, prefixes;
     int shift;
     MemOp ot, aflag, dflag;
@@ -6920,7 +6920,7 @@ void tcg_x86_init(void)
 static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     uint32_t flags = dc->base.tb->flags;
     uint32_t cflags = tb_cflags(dc->base.tb);
     int cpl = (flags >> HF_CPL_SHIFT) & 3;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3de0dc1d46..df3aba2642 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -300,7 +300,7 @@ static SegmentCache whpx_seg_h2q(const WHV_X64_SEGMENT_REGISTER *hs)
 /* X64 Extended Control Registers */
 static void whpx_set_xcrs(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
@@ -321,7 +321,7 @@ static void whpx_set_xcrs(CPUState *cpu)
 
 static int whpx_set_tsc(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
     WHV_REGISTER_VALUE tsc_val;
     HRESULT hr;
@@ -382,8 +382,8 @@ static void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     struct whpx_register_set vcxt;
     HRESULT hr;
     int idx;
@@ -556,7 +556,7 @@ static void whpx_set_registers(CPUState *cpu, int level)
 
 static int whpx_get_tsc(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     WHV_REGISTER_NAME tsc_reg = WHvX64RegisterTsc;
     WHV_REGISTER_VALUE tsc_val;
     HRESULT hr;
@@ -576,7 +576,7 @@ static int whpx_get_tsc(CPUState *cpu)
 /* X64 Extended Control Registers */
 static void whpx_get_xcrs(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
     WHV_REGISTER_VALUE xcr0;
@@ -601,8 +601,8 @@ static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     struct whpx_register_set vcxt;
     uint64_t tpr, apic_base;
     HRESULT hr;
@@ -1400,7 +1400,7 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
     if (cpu->vcpu_dirty) {
         /* The CPU registers have been modified by other parts of QEMU. */
-        CPUArchState *env = (CPUArchState *)(cpu->env_ptr);
+        CPUArchState *env = cpu_env(cpu);
         return env->eip;
     } else if (exit_context_valid) {
         /*
@@ -1439,7 +1439,7 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 
 static int whpx_handle_halt(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     int ret = 0;
 
     qemu_mutex_lock_iothread();
@@ -1460,8 +1460,8 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     int irq;
     uint8_t tpr;
     WHV_X64_PENDING_INTERRUPTION_REGISTER new_int;
@@ -1582,8 +1582,8 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 static void whpx_vcpu_post_run(CPUState *cpu)
 {
     AccelCPUState *vcpu = cpu->accel;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
 
     env->eflags = vcpu->exit_ctx.VpContext.Rflags;
 
@@ -1606,8 +1606,8 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
 static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     AccelCPUState *vcpu = cpu->accel;
 
     if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
@@ -2147,8 +2147,8 @@ int whpx_init_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = NULL;
     Error *local_error = NULL;
-    CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
     UINT64 freq = 0;
     int ret;
 
@@ -2245,7 +2245,7 @@ int whpx_init_vcpu(CPUState *cpu)
     cpu->vcpu_dirty = true;
     cpu->accel = vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
-    qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
+    qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
 
     return 0;
 
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 4a4c022f51..a75fed1d98 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -104,7 +104,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
                                             CPUState *cs)
 {
     int64_t bound;
-    CPULoongArchState *env = cs->env_ptr;
+    CPULoongArchState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
@@ -265,7 +265,7 @@ static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
 
 static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPULoongArchState *env = cs->env_ptr;
+    CPULoongArchState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     ctx->opcode = translator_ldl(env, &ctx->base, ctx->base.pc_next);
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 0989a5b6bd..d22df2a8dc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5990,7 +5990,7 @@ void register_m68k_insns (CPUM68KState *env)
 static void m68k_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUM68KState *env = cpu->env_ptr;
+    CPUM68KState *env = cpu_env(cpu);
 
     dc->env = env;
     dc->pc = dc->base.pc_first;
@@ -6021,7 +6021,7 @@ static void m68k_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void m68k_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUM68KState *env = cpu->env_ptr;
+    CPUM68KState *env = cpu_env(cpu);
     uint16_t insn = read_im16(env, dc);
 
     opcode_table[insn](env, dc, insn);
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index bb178219f1..49bfb4a0ea 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1630,7 +1630,7 @@ static void mb_tr_insn_start(DisasContextBase *dcb, CPUState *cs)
 static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
-    CPUMBState *env = cs->env_ptr;
+    CPUMBState *env = cpu_env(cs);
     uint32_t ir;
 
     /* TODO: This should raise an exception, not terminate qemu. */
diff --git a/target/mips/tcg/sysemu/mips-semi.c b/target/mips/tcg/sysemu/mips-semi.c
index f3735df7b9..b3e4e49ff7 100644
--- a/target/mips/tcg/sysemu/mips-semi.c
+++ b/target/mips/tcg/sysemu/mips-semi.c
@@ -126,7 +126,7 @@ static void report_fault(CPUMIPSState *env)
 
 static void uhi_cb(CPUState *cs, uint64_t ret, int err)
 {
-    CPUMIPSState *env = cs->env_ptr;
+    CPUMIPSState *env = cpu_env(cs);
 
 #define E(N) case E##N: err = UHI_E##N; break
 
@@ -167,7 +167,7 @@ static void uhi_fstat_cb(CPUState *cs, uint64_t ret, int err)
     QEMU_BUILD_BUG_ON(sizeof(UHIStat) < sizeof(struct gdb_stat));
 
     if (!err) {
-        CPUMIPSState *env = cs->env_ptr;
+        CPUMIPSState *env = cpu_env(cs);
         target_ulong addr = env->active_tc.gpr[5];
         UHIStat *dst = lock_user(VERIFY_WRITE, addr, sizeof(UHIStat), 1);
         struct gdb_stat s;
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index c8183710e5..adbdcb1472 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -15377,7 +15377,7 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
 static void mips_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUMIPSState *env = cs->env_ptr;
+    CPUMIPSState *env = cpu_env(cs);
 
     ctx->page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
     ctx->saved_pc = -1;
@@ -15448,7 +15448,7 @@ static void mips_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 
 static void mips_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPUMIPSState *env = cs->env_ptr;
+    CPUMIPSState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     int insn_bytes;
     int is_slot;
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 93ded65f9a..e806623594 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -944,7 +944,7 @@ static const char * const cr_regnames[NUM_CR_REGS] = {
 static void nios2_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUNios2State *env = cs->env_ptr;
+    CPUNios2State *env = cpu_env(cs);
     Nios2CPU *cpu = env_archcpu(env);
     int page_insns;
 
@@ -970,7 +970,7 @@ static void nios2_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void nios2_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUNios2State *env = cs->env_ptr;
+    CPUNios2State *env = cpu_env(cs);
     const Nios2Instruction *instr;
     uint32_t code, pc;
     uint8_t op;
diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 1b4df1c214..ecff4412b7 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -1525,7 +1525,7 @@ static bool trans_lf_sfun_d(DisasContext *dc, arg_ab_pair *a)
 static void openrisc_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 {
     DisasContext *dc = container_of(dcb, DisasContext, base);
-    CPUOpenRISCState *env = cs->env_ptr;
+    CPUOpenRISCState *env = cpu_env(cs);
     int bound;
 
     dc->mem_idx = cpu_mmu_index(env, false);
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 72ec2be92e..437527a47c 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3189,7 +3189,7 @@ void ppc_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
                                  MMUAccessType access_type,
                                  int mmu_idx, uintptr_t retaddr)
 {
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
     uint32_t insn;
 
     /* Restore state and reload the insn we executed, for filling in DSISR.  */
@@ -3220,7 +3220,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
                                    int mmu_idx, MemTxAttrs attrs,
                                    MemTxResult response, uintptr_t retaddr)
 {
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
 
     switch (env->excp_model) {
 #if defined(TARGET_PPC64)
@@ -3264,7 +3264,7 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
 void ppc_cpu_debug_excp_handler(CPUState *cs)
 {
 #if defined(TARGET_PPC64)
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
 
     if (env->insns_flags2 & PPC2_ISA207S) {
         if (cs->watchpoint_hit) {
@@ -3286,7 +3286,7 @@ void ppc_cpu_debug_excp_handler(CPUState *cs)
 bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
 {
 #if defined(TARGET_PPC64)
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
 
     if (env->insns_flags2 & PPC2_ISA207S) {
         target_ulong priv;
@@ -3313,7 +3313,7 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs)
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp)
 {
 #if defined(TARGET_PPC64)
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
 
     if (env->insns_flags2 & PPC2_ISA207S) {
         if (wp == env->dawr0_watchpoint) {
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e20a1bea62..329da4d518 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7320,7 +7320,7 @@ static bool decode_legacy(PowerPCCPU *cpu, DisasContext *ctx, uint32_t insn)
 static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
     uint32_t hflags = ctx->base.tb->flags;
 
     ctx->spr_cb = env->spr_cb;
@@ -7384,7 +7384,7 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-    CPUPPCState *env = cs->env_ptr;
+    CPUPPCState *env = cpu_env(cs);
     target_ulong pc;
     uint32_t insn;
     bool ok;
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2ad5192866..f0be79bb16 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1074,7 +1074,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUState *cpu = ctx->cs;
-    CPURISCVState *env = cpu->env_ptr;
+    CPURISCVState *env = cpu_env(cpu);
 
     return cpu_ldl_code(env, pc);
 }
@@ -1166,7 +1166,7 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
 static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPURISCVState *env = cs->env_ptr;
+    CPURISCVState *env = cpu_env(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
 
@@ -1219,7 +1219,7 @@ static void riscv_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPURISCVState *env = cpu->env_ptr;
+    CPURISCVState *env = cpu_env(cpu);
     uint16_t opcode16 = translator_lduw(env, &ctx->base, ctx->base.pc_next);
 
     ctx->ol = ctx->xl;
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 51559943fb..2e7a736590 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -183,12 +183,9 @@ static bool rx_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,
 
 static void rx_cpu_init(Object *obj)
 {
-    CPUState *cs = CPU(obj);
     RXCPU *cpu = RX_CPU(obj);
-    CPURXState *env = &cpu->env;
 
     cpu_set_cpustate_pointers(cpu);
-    cs->env_ptr = env;
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 9fd4d36b08..f8860830ae 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -2200,7 +2200,7 @@ static bool trans_WAIT(DisasContext *ctx, arg_WAIT *a)
 
 static void rx_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPURXState *env = cs->env_ptr;
+    CPURXState *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     ctx->env = env;
     ctx->tb_flags = ctx->base.tb->flags;
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 22f43974dd..4bae1509f5 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -6463,7 +6463,7 @@ static target_ulong get_next_pc(CPUS390XState *env, DisasContext *s,
 
 static void s390x_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPUS390XState *env = cs->env_ptr;
+    CPUS390XState *env = cpu_env(cs);
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     dc->base.is_jmp = translate_one(env, dc);
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index a663335c39..ada41ba0a2 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -29,7 +29,7 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
                                     MMUAccessType access_type,
                                     int mmu_idx, uintptr_t retaddr)
 {
-    CPUSH4State *env = cs->env_ptr;
+    CPUSH4State *env = cpu_env(cs);
 
     env->tea = addr;
     switch (access_type) {
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 30e3ea509b..cbd8dfc02f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2179,7 +2179,7 @@ static void decode_gusa(DisasContext *ctx, CPUSH4State *env)
 static void sh4_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUSH4State *env = cs->env_ptr;
+    CPUSH4State *env = cpu_env(cs);
     uint32_t tbflags;
     int bound;
 
@@ -2236,7 +2236,7 @@ static void sh4_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 
 static void sh4_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
-    CPUSH4State *env = cs->env_ptr;
+    CPUSH4State *env = cpu_env(cs);
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 71b48cb3b7..f92ff80ac8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5568,7 +5568,7 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cs->env_ptr;
+    CPUSPARCState *env = cpu_env(cs);
     int bound;
 
     dc->pc = dc->base.pc_first;
@@ -5625,7 +5625,7 @@ static void sparc_tr_insn_start(DisasContextBase *dcbase, CPUState *cs)
 static void sparc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUSPARCState *env = cs->env_ptr;
+    CPUSPARCState *env = cpu_env(cs);
     unsigned int insn;
 
     insn = translator_ldl(env, &dc->base, dc->pc);
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 4206728afd..1b625629bb 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8331,7 +8331,7 @@ static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
                                           CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUTriCoreState *env = cs->env_ptr;
+    CPUTriCoreState *env = cpu_env(cs);
     ctx->mem_idx = cpu_mmu_index(env, false);
 
     uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;
@@ -8376,7 +8376,7 @@ static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
 static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-    CPUTriCoreState *env = cpu->env_ptr;
+    CPUTriCoreState *env = cpu_env(cpu);
     uint16_t insn_lo;
     bool is_16bit;
 
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index fca1b9aba4..54bee7ddba 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -1140,7 +1140,7 @@ static void xtensa_tr_init_disas_context(DisasContextBase *dcbase,
                                          CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUXtensaState *env = cpu->env_ptr;
+    CPUXtensaState *env = cpu_env(cpu);
     uint32_t tb_flags = dc->base.tb->flags;
 
     dc->config = env->config;
@@ -1180,7 +1180,7 @@ static void xtensa_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static void xtensa_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
-    CPUXtensaState *env = cpu->env_ptr;
+    CPUXtensaState *env = cpu_env(cpu);
     target_ulong page_start;
 
     /* These two conditions only apply to the first insn in the TB,
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index af1878c38a..7d76f15275 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1595,7 +1595,7 @@ illegal:
  */
 static void disas_insn_new(DisasContext *s, CPUState *cpu, int b)
 {
-    CPUX86State *env = cpu->env_ptr;
+    CPUX86State *env = cpu_env(cpu);
     bool first = true;
     X86DecodedInsn decode;
     X86DecodeFunc decode_func = decode_root;
-- 
2.34.1


