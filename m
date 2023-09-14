Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2751379F857
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcLr-0000iJ-79; Wed, 13 Sep 2023 22:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLo-0000hZ-Tp
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLb-0000i1-Tc
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso3580205ad.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659490; x=1695264290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfIoZ9oSQnl/4o/PnGZQeYb7irRxzp/BGWlADSKRGzI=;
 b=ctvWVp0xeVATZXnoRBz5jh00g5ReBnGvVyl4gaEkvhQeN4OoG7+JiwZD+bD+hYL7az
 B61XfxBwoumTNIaW51Fw0cBbNOIBigoPM7wgEoDsCtJX2m1TUk1TXcOuqyrDj7BZUu+Q
 ypDFwa7ZArd0MPnezGmnq88RBcAsel2uKPNzLph/UMNe9KVLvKlbTYiizcqXc/zwj1n3
 52rjwMlJOIThUl4936vaYsQ4luW56YduxRsoGbG1dGo/qcnCJ2JnBayxpb4cfClxfRLF
 t8vwSgUJrhJCqlQlSy9JGxUUwcVn0SUpPlg1uzLGtGbwTXgVJMYkTsvROgP+IjGgYY10
 5aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659490; x=1695264290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfIoZ9oSQnl/4o/PnGZQeYb7irRxzp/BGWlADSKRGzI=;
 b=vTYUisSb2S4+VJLMCri8vwQi+B5OBHxIKOYyRB+UCWHzEwfDlLHerwvCWVWnEte6JS
 Vjg9RkrNDeoPTTOTUnXg6ZUtmftxHF9MNh1Cl7D1wZ+03JGIQ5+K/SCARGHdj2QuWrMN
 Pp26Q6bNIf8ctrsloUpYSEg/E6xFa+G6MRQOIkCwyd9kjzC7gx9S4iNK/hEsOC8HenVw
 5/eMbqLdo6QFwy17LD7cR9kFR/6gqQdEvCVoP3IgYs5ByF/eoP3ljRYIPIz3RSNts5Jm
 u/91oWzHCz7qyNjcRT0ZN/ezKHMcKvnI/V7/fRNiFInZ7HCTHzjZPBxz/FNFN6+jb5/M
 V72w==
X-Gm-Message-State: AOJu0YwGPKUeY+XKEyHlKhhg3Nvs4qXo6seIAyz4B7K77HAsjSx/NnPl
 UhCv18bUBEZXUgqze5x6QMGI4q40EzARBKNIMqc=
X-Google-Smtp-Source: AGHT+IHTCj1MAHrcqZeTJx7PGbuUSv7XVF5pycNrJunFoT0yPTG07mgn6x4perrprHVBFM0EBl4RTA==
X-Received: by 2002:a17:902:7446:b0:1bc:9794:22ef with SMTP id
 e6-20020a170902744600b001bc979422efmr4086324plt.1.1694659490342; 
 Wed, 13 Sep 2023 19:44:50 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 14/24] accel/tcg: Remove cpu_set_cpustate_pointers
Date: Wed, 13 Sep 2023 19:44:25 -0700
Message-Id: <20230914024435.1381329-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This function is now empty, so remove it.  In the case of
m68k and tricore, this empties the class instance initfn,
so remove those as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h  | 10 ----------
 target/alpha/cpu.c      |  2 --
 target/arm/cpu.c        |  1 -
 target/avr/cpu.c        |  2 --
 target/cris/cpu.c       |  2 --
 target/hexagon/cpu.c    |  3 ---
 target/hppa/cpu.c       |  1 -
 target/i386/cpu.c       |  1 -
 target/loongarch/cpu.c  |  8 +++-----
 target/m68k/cpu.c       |  8 --------
 target/microblaze/cpu.c |  1 -
 target/mips/cpu.c       |  1 -
 target/nios2/cpu.c      |  4 +---
 target/openrisc/cpu.c   |  6 +-----
 target/ppc/cpu_init.c   |  1 -
 target/riscv/cpu.c      |  6 +-----
 target/rx/cpu.c         |  1 -
 target/s390x/cpu.c      |  2 --
 target/sh4/cpu.c        |  2 --
 target/sparc/cpu.c      |  2 --
 target/tricore/cpu.c    |  9 ---------
 target/xtensa/cpu.c     |  1 -
 22 files changed, 6 insertions(+), 68 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 40831122ce..9db8544125 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -425,16 +425,6 @@ int cpu_exec(CPUState *cpu);
 void tcg_exec_realizefn(CPUState *cpu, Error **errp);
 void tcg_exec_unrealizefn(CPUState *cpu);
 
-/**
- * cpu_set_cpustate_pointers(cpu)
- * @cpu: The cpu object
- *
- * Set the generic pointers in CPUState into the outer object.
- */
-static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
-{
-}
-
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e2156fcb41..51b7d8d1bf 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -209,8 +209,6 @@ static void alpha_cpu_initfn(Object *obj)
     AlphaCPU *cpu = ALPHA_CPU(obj);
     CPUAlphaState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
-
     env->lock_addr = -1;
 #if defined(CONFIG_USER_ONLY)
     env->flags = ENV_FLAG_PS_USER | ENV_FLAG_FEN;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b76025485d..78e42d6dcc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1215,7 +1215,6 @@ static void arm_cpu_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
 
-    cpu_set_cpustate_pointers(cpu);
     cpu->cp_regs = g_hash_table_new_full(g_direct_hash, g_direct_equal,
                                          NULL, g_free);
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index c5a6436336..14d8b9d1f0 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -147,8 +147,6 @@ static void avr_cpu_initfn(Object *obj)
 {
     AVRCPU *cpu = AVR_CPU(obj);
 
-    cpu_set_cpustate_pointers(cpu);
-
     /* Set the number of interrupts supported by the CPU. */
     qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int,
                       sizeof(cpu->env.intsrc) * 8);
diff --git a/target/cris/cpu.c b/target/cris/cpu.c
index 8ab8a30b8d..be4a44c218 100644
--- a/target/cris/cpu.c
+++ b/target/cris/cpu.c
@@ -201,8 +201,6 @@ static void cris_cpu_initfn(Object *obj)
     CRISCPUClass *ccc = CRIS_CPU_GET_CLASS(obj);
     CPUCRISState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
-
     env->pregs[PR_VR] = ccc->vr;
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 65f198b956..1adc11b713 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -353,9 +353,6 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
 
 static void hexagon_cpu_init(Object *obj)
 {
-    HexagonCPU *cpu = HEXAGON_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
     qdev_property_add_static(DEVICE(obj), &hexagon_lldb_compat_property);
     qdev_property_add_static(DEVICE(obj), &hexagon_lldb_stack_adjust_property);
     qdev_property_add_static(DEVICE(obj), &hexagon_short_circuit_property);
diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 17fa901f6a..1644297bf8 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -149,7 +149,6 @@ static void hppa_cpu_initfn(Object *obj)
     HPPACPU *cpu = HPPA_CPU(obj);
     CPUHPPAState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
     cs->exception_index = -1;
     cpu_hppa_loaded_fr0(env);
     cpu_hppa_put_psw(env, PSW_W);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9565e3d160..b72affdbe3 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7590,7 +7590,6 @@ static void x86_cpu_initfn(Object *obj)
     CPUX86State *env = &cpu->env;
 
     env->nr_dies = 1;
-    cpu_set_cpustate_pointers(cpu);
 
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 56e67cea8d..e70773c22e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -614,17 +614,15 @@ static const MemoryRegionOps loongarch_qemu_ops = {
 
 static void loongarch_cpu_init(Object *obj)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
-
 #ifndef CONFIG_USER_ONLY
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
     CPULoongArchState *env = &cpu->env;
+
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
     memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
-                      env, "iocsr", UINT64_MAX);
+                          env, "iocsr", UINT64_MAX);
     address_space_init(&env->address_space_iocsr, &env->system_iocsr, "IOCSR");
     memory_region_init_io(&env->iocsr_mem, OBJECT(cpu), &loongarch_qemu_ops,
                           NULL, "iocsr_misc", 0x428);
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index d34d1b57d0..538d9473c2 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -327,13 +327,6 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
-static void m68k_cpu_initfn(Object *obj)
-{
-    M68kCPU *cpu = M68K_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 static bool fpu_needed(void *opaque)
 {
@@ -612,7 +605,6 @@ static const TypeInfo m68k_cpus_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(M68kCPU),
         .instance_align = __alignof(M68kCPU),
-        .instance_init = m68k_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(M68kCPUClass),
         .class_init = m68k_cpu_class_init,
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index c53711da52..bbb3335cad 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -296,7 +296,6 @@ static void mb_cpu_initfn(Object *obj)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(obj);
     CPUMBState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
     gdb_register_coprocessor(CPU(cpu), mb_cpu_gdb_read_stack_protect,
                              mb_cpu_gdb_write_stack_protect, 2,
                              "microblaze-stack-protect.xml", 0);
diff --git a/target/mips/cpu.c b/target/mips/cpu.c
index fee791aa44..a0023edd43 100644
--- a/target/mips/cpu.c
+++ b/target/mips/cpu.c
@@ -504,7 +504,6 @@ static void mips_cpu_initfn(Object *obj)
     CPUMIPSState *env = &cpu->env;
     MIPSCPUClass *mcc = MIPS_CPU_GET_CLASS(obj);
 
-    cpu_set_cpustate_pointers(cpu);
     cpu->clock = qdev_init_clock_in(DEVICE(obj), "clk-in", NULL, cpu, 0);
     cpu->count_div = clock_new(OBJECT(obj), "clk-div-count");
     env->count_clock = clock_new(OBJECT(obj), "clk-count");
diff --git a/target/nios2/cpu.c b/target/nios2/cpu.c
index 598976305f..15e499f828 100644
--- a/target/nios2/cpu.c
+++ b/target/nios2/cpu.c
@@ -113,11 +113,9 @@ static void iic_set_irq(void *opaque, int irq, int level)
 
 static void nios2_cpu_initfn(Object *obj)
 {
+#if !defined(CONFIG_USER_ONLY)
     Nios2CPU *cpu = NIOS2_CPU(obj);
 
-    cpu_set_cpustate_pointers(cpu);
-
-#if !defined(CONFIG_USER_ONLY)
     mmu_init(&cpu->env);
 #endif
 }
diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
index be067709b8..f5a3d5273b 100644
--- a/target/openrisc/cpu.c
+++ b/target/openrisc/cpu.c
@@ -149,12 +149,8 @@ static void openrisc_cpu_realizefn(DeviceState *dev, Error **errp)
 
 static void openrisc_cpu_initfn(Object *obj)
 {
-    OpenRISCCPU *cpu = OPENRISC_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
-
 #ifndef CONFIG_USER_ONLY
-    qdev_init_gpio_in_named(DEVICE(cpu), openrisc_cpu_set_irq, "IRQ", NR_IRQS);
+    qdev_init_gpio_in_named(DEVICE(obj), openrisc_cpu_set_irq, "IRQ", NR_IRQS);
 #endif
 }
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 7830640f01..62571b0f16 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7246,7 +7246,6 @@ static void ppc_cpu_instance_init(Object *obj)
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     CPUPPCState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
     cpu->vcpu_id = UNASSIGNED_CPU_INDEX;
 
     env->msr_mask = pcc->msr_mask;
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8a765d5117..6fca8ce0d2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1649,12 +1649,8 @@ static void riscv_cpu_set_irq(void *opaque, int irq, int level)
 
 static void riscv_cpu_init(Object *obj)
 {
-    RISCVCPU *cpu = RISCV_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
-
 #ifndef CONFIG_USER_ONLY
-    qdev_init_gpio_in(DEVICE(cpu), riscv_cpu_set_irq,
+    qdev_init_gpio_in(DEVICE(obj), riscv_cpu_set_irq,
                       IRQ_LOCAL_MAX + IRQ_LOCAL_GUEST_MAX);
 #endif /* CONFIG_USER_ONLY */
 }
diff --git a/target/rx/cpu.c b/target/rx/cpu.c
index 2e7a736590..4d0d3a0c8c 100644
--- a/target/rx/cpu.c
+++ b/target/rx/cpu.c
@@ -185,7 +185,6 @@ static void rx_cpu_init(Object *obj)
 {
     RXCPU *cpu = RX_CPU(obj);
 
-    cpu_set_cpustate_pointers(cpu);
     qdev_init_gpio_in(DEVICE(cpu), rx_cpu_set_irq, 2);
 }
 
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d9625bc266..c69ed4b291 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -274,9 +274,7 @@ out:
 static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
-    S390CPU *cpu = S390_CPU(obj);
 
-    cpu_set_cpustate_pointers(cpu);
     cs->exception_index = EXCP_HLT;
 
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index a90e41c4ec..788e41fea6 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -239,8 +239,6 @@ static void superh_cpu_initfn(Object *obj)
     SuperHCPU *cpu = SUPERH_CPU(obj);
     CPUSH4State *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
-
     env->movcal_backup_tail = &(env->movcal_backup);
 }
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index d6d3c4b031..8ba96ae225 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -793,8 +793,6 @@ static void sparc_cpu_initfn(Object *obj)
     SPARCCPUClass *scc = SPARC_CPU_GET_CLASS(obj);
     CPUSPARCState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
-
     if (scc->cpu_def) {
         env->def = *scc->cpu_def;
     }
diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
index 50aec6cf10..d1477622e6 100644
--- a/target/tricore/cpu.c
+++ b/target/tricore/cpu.c
@@ -124,14 +124,6 @@ static void tricore_cpu_realizefn(DeviceState *dev, Error **errp)
     tcc->parent_realize(dev, errp);
 }
 
-
-static void tricore_cpu_initfn(Object *obj)
-{
-    TriCoreCPU *cpu = TRICORE_CPU(obj);
-
-    cpu_set_cpustate_pointers(cpu);
-}
-
 static ObjectClass *tricore_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -231,7 +223,6 @@ static const TypeInfo tricore_cpu_type_infos[] = {
         .parent = TYPE_CPU,
         .instance_size = sizeof(TriCoreCPU),
         .instance_align = __alignof(TriCoreCPU),
-        .instance_init = tricore_cpu_initfn,
         .abstract = true,
         .class_size = sizeof(TriCoreCPUClass),
         .class_init = tricore_cpu_class_init,
diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index 281872d7ca..ea1dae7390 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -185,7 +185,6 @@ static void xtensa_cpu_initfn(Object *obj)
     XtensaCPUClass *xcc = XTENSA_CPU_GET_CLASS(obj);
     CPUXtensaState *env = &cpu->env;
 
-    cpu_set_cpustate_pointers(cpu);
     env->config = xcc->config;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


