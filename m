Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9E571731F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 03:24:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4AYv-0004gW-7s; Tue, 30 May 2023 21:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYt-0004bX-DE; Tue, 30 May 2023 21:23:39 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q4AYr-0005GW-Cs; Tue, 30 May 2023 21:23:39 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3980f2df1e7so3044737b6e.1; 
 Tue, 30 May 2023 18:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685496215; x=1688088215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNhHuSY/DQfWNHVO+TsUqgs7kbd9/63cyFch/lJ9/DY=;
 b=GjZ/XYIsV5I9OQcjkBsk8HgpM/P5pZa25N/yDKAjuPtFhqPacSuK4aBSsymypzbwrc
 dy//FhdmgJ474UUpGSuC0KO1K4+bTnG9YiJbNztkn6Mg8YJBsmN2bhr6/aI+Ef+D7hTa
 uHE1yYUawIlwriLcDSjB/pFQNq6B5TshtQp1jQia/gztZojXt7Gcra6nmQ1vimVvYD58
 MjsvG4m2u+pG14RJm9ON5NcrIrLvpMXUO0I2ExCETHAsP1gMo3nyMa0pvSLnfyEYiuRL
 E5rZzsgeURNUmUVr5nFM/1/C6mr0QlRG7jwNI66+nQEaglVWSXemBRdQzYGPN4Kv7gOy
 T9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685496215; x=1688088215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNhHuSY/DQfWNHVO+TsUqgs7kbd9/63cyFch/lJ9/DY=;
 b=jlaDKgecfWgrjPnQhdrxykiydbXTODE3+qWL1d8M/SKlA6nTNTJu+L/5a+RxCr9SzH
 8jaj06LCNE+fKlL/ZgvUajaKHnvrvrRYu9ooi+oKAyBKLc+ngOCYu6qQhIPe7ybf70qK
 ejKcOpSuB1ra/fiqfOn1EPIxjpYkQSsHwwGlBEEDI3hi5lGqnL7SH16J6jYCb21oCNW/
 mlgkipvNSVhWfJK4hz9HKLRsZ+GMNfapB0oJM2iYJpaxY/hVKMiWv1SITHTMMonkR9e1
 /JMJyUI/hf/bHWjdeMTeL/jYZ3DY1voq95kKQjvqakGYys5sToNb15hCAHGcL0FLw+nD
 RmKg==
X-Gm-Message-State: AC+VfDyeTu6qUJk9Cd3tDYUihkkcjZ9vEzFqyVjpu6F/uPp9MDRmg0+s
 RxY2HW1fuVfJyJg9//FnQSO7yZSwFto=
X-Google-Smtp-Source: ACHHUZ4WzLPy+r0Oj74F87vJ+F9B/lEuvTDsC0DlDG3AJBmbqpARjoV4NTEyNG5XrrFgB9BUBC2PPg==
X-Received: by 2002:a05:6808:118e:b0:398:2cfa:85e7 with SMTP id
 j14-20020a056808118e00b003982cfa85e7mr3125973oil.11.1685496215408; 
 Tue, 30 May 2023 18:23:35 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 9-20020a170902c10900b00186a2274382sm10928840pli.76.2023.05.30.18.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 18:23:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [RFC PATCH 4/5] target/ppc: Add msgsnd/p and DPDES SMT support
Date: Wed, 31 May 2023 11:23:12 +1000
Message-Id: <20230531012313.19891-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531012313.19891-1-npiggin@gmail.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Doorbells in SMT need to coordinate msgsnd/msgclr and DPDES access from
multiple threads that affect the same state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/ppc.c                                  |  6 ++
 include/hw/ppc/ppc.h                          |  1 +
 target/ppc/cpu.h                              |  7 +-
 target/ppc/excp_helper.c                      | 86 +++++++++++++------
 target/ppc/gdbstub.c                          |  2 +-
 target/ppc/helper.h                           |  2 +-
 target/ppc/misc_helper.c                      | 60 +++++++++++--
 target/ppc/translate.c                        |  8 ++
 .../ppc/translate/processor-ctrl-impl.c.inc   |  2 +-
 9 files changed, 140 insertions(+), 34 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 80b4706db2..e30853413b 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1434,6 +1434,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
     return env->spr_cb[SPR_PIR].default_value;
 }
 
+int ppc_cpu_tir(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    return env->spr_cb[SPR_PIR].default_value;
+}
+
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 {
     CPUState *cs;
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 02af03ada2..e095c002dc 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -6,6 +6,7 @@
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
 int ppc_cpu_pir(PowerPCCPU *cpu);
+int ppc_cpu_tir(PowerPCCPU *cpu);
 
 /* PowerPC hardware exceptions management helpers */
 typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index b594408a8d..b04b309c71 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1056,7 +1056,12 @@ FIELD(FPSCR, FI, FPSCR_FI, 1)
 
 #define DBELL_TYPE_DBELL_SERVER        (0x05 << DBELL_TYPE_SHIFT)
 
-#define DBELL_BRDCAST                  PPC_BIT(37)
+/* XXX: make sure this does not break BookE */
+#define DBELL_BRDCAST_MASK             PPC_BITMASK(37, 38)
+#define DBELL_BRDCAST_SHIFT            25
+#define DBELL_BRDCAST_SUBPROC          (0x1 << DBELL_BRDCAST_SHIFT)
+#define DBELL_BRDCAST_CORE             (0x2 << DBELL_BRDCAST_SHIFT)
+
 #define DBELL_LPIDTAG_SHIFT            14
 #define DBELL_LPIDTAG_MASK             (0xfff << DBELL_LPIDTAG_SHIFT)
 #define DBELL_PIRTAG_MASK              0x3fff
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 4925996cf3..5fc2e17269 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3085,7 +3085,7 @@ void helper_msgsnd(target_ulong rb)
         PowerPCCPU *cpu = POWERPC_CPU(cs);
         CPUPPCState *cenv = &cpu->env;
 
-        if ((rb & DBELL_BRDCAST) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
+        if ((rb & DBELL_BRDCAST_MASK) || (cenv->spr[SPR_BOOKE_PIR] == pir)) {
             ppc_set_irq(cpu, irq, 1);
         }
     }
@@ -3104,6 +3104,16 @@ static bool dbell_type_server(target_ulong rb)
     return (rb & DBELL_TYPE_MASK) == DBELL_TYPE_DBELL_SERVER;
 }
 
+static inline bool dbell_type_bcast_core(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_CORE;
+}
+
+static inline bool dbell_type_bcast_subproc(target_ulong rb)
+{
+    return (rb & DBELL_BRDCAST_MASK) == DBELL_BRDCAST_SUBPROC;
+}
+
 void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
 {
     if (!dbell_type_server(rb)) {
@@ -3113,32 +3123,40 @@ void helper_book3s_msgclr(CPUPPCState *env, target_ulong rb)
     ppc_set_irq(env_archcpu(env), PPC_INTERRUPT_HDOORBELL, 0);
 }
 
-static void book3s_msgsnd_common(int pir, int irq)
+void helper_book3s_msgsnd(CPUPPCState *env, target_ulong rb)
 {
-    CPUState *cs;
-
-    qemu_mutex_lock_iothread();
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-        CPUPPCState *cenv = &cpu->env;
+    int pir = rb & DBELL_PROCIDTAG_MASK;
+    int brdcast = rb & DBELL_BRDCAST_MASK;
+    CPUState *cs, *ccs;
+    PowerPCCPU *cpu;
 
-        /* TODO: broadcast message to all threads of the same  processor */
-        if (cenv->spr_cb[SPR_PIR].default_value == pir) {
-            ppc_set_irq(cpu, irq, 1);
-        }
+    if (!dbell_type_server(rb)) {
+        return;
     }
-    qemu_mutex_unlock_iothread();
-}
 
-void helper_book3s_msgsnd(target_ulong rb)
-{
-    int pir = rb & DBELL_PROCIDTAG_MASK;
+    cpu = ppc_get_vcpu_by_pir(pir);
+    if (!cpu) {
+        return;
+    }
+    cs = CPU(cpu);
 
-    if (!dbell_type_server(rb)) {
+    if (cs->nr_threads == 1 || !brdcast) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDOORBELL, 1);
         return;
     }
 
-    book3s_msgsnd_common(pir, PPC_INTERRUPT_HDOORBELL);
+    /* WHy does iothread need to be locked for walking CPU list? */
+    /* Answer seems to be because ppc irq handling needs it, but it now takes
+     * the lock itself if needed. Could remove this then.
+     */
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        if (cpu != ccpu) {
+            ppc_set_irq(ccpu, PPC_INTERRUPT_HDOORBELL, 1);
+        }
+    }
+    qemu_mutex_unlock_iothread();
 }
 
 #if defined(TARGET_PPC64)
@@ -3154,22 +3172,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
 }
 
 /*
- * sends a message to other threads that are on the same
+ * sends a message to another thread  on the same
  * multi-threaded processor
  */
 void helper_book3s_msgsndp(CPUPPCState *env, target_ulong rb)
 {
-    int pir = env->spr_cb[SPR_PIR].default_value;
+    CPUState *cs = env_cpu(env);
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    int ttir = rb & PPC_BITMASK(57, 63);
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "msgsndp", HFSCR_IC_MSGP);
 
-    if (!dbell_type_server(rb)) {
+    if (!dbell_type_server(rb) || ttir >= nr_threads) {
+        return;
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, 1);
         return;
     }
 
-    /* TODO: TCG supports only one thread */
+    /* WHy does iothread need to be locked for walking CPU list? */
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        if (ttir == thread_id) {
+            ppc_set_irq(ccpu, PPC_INTERRUPT_DOORBELL, 1);
+            qemu_mutex_unlock_iothread();
+            return;
+        }
+    }
 
-    book3s_msgsnd_common(pir, PPC_INTERRUPT_DOORBELL);
+    assert(0);
 }
 #endif /* TARGET_PPC64 */
 
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index ca39efdc35..f0304e5bb6 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -117,7 +117,7 @@ void ppc_maybe_bswap_register(CPUPPCState *env, uint8_t *mem_buf, int len)
  * regs and PC, MSR, CR, and so forth.  We hack round this by giving
  * the FP regs zero size when talking to a newer gdb.
  */
-
+/* XXX: read/write dpdes correctly */
 int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index fda40b8a60..5ce49c7ebc 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -690,7 +690,7 @@ DEF_HELPER_FLAGS_3(store_sr, TCG_CALL_NO_RWG, void, env, tl, tl)
 
 DEF_HELPER_1(msgsnd, void, tl)
 DEF_HELPER_2(msgclr, void, env, tl)
-DEF_HELPER_1(book3s_msgsnd, void, tl)
+DEF_HELPER_2(book3s_msgsnd, void, env, tl)
 DEF_HELPER_2(book3s_msgclr, void, env, tl)
 #endif
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index ffe54a4310..ca84f1b134 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -192,14 +192,38 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
  */
 target_ulong helper_load_dpdes(CPUPPCState *env)
 {
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
     target_ulong dpdes = 0;
 
+    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
+
     helper_hfscr_facility_check(env, HFSCR_MSGP, "load DPDES", HFSCR_IC_MSGP);
 
-    /* TODO: TCG supports only one thread */
-    if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
-        dpdes = 1;
+    if (nr_threads == 1) {
+        if (env->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+            dpdes = 1;
+        }
+        return dpdes;
+    }
+
+    qemu_mutex_lock_iothread();
+    CPU_FOREACH(ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        uint32_t ccore_id = cenv->spr[SPR_PIR] & ~(nr_threads - 1);
+        uint32_t thread_id = cenv->spr[SPR_TIR];
+
+        assert(ccore_id == cenv->spr[SPR_PIR] - cenv->spr[SPR_TIR]);
+
+        if (ccore_id == core_id) {
+            if (cenv->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+                dpdes |= (0x1 << thread_id);
+            }
+        }
     }
+    qemu_mutex_unlock_iothread();
 
     return dpdes;
 }
@@ -207,17 +231,41 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
 void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
+    uint32_t core_id = env->spr[SPR_PIR] & ~(nr_threads - 1);
+
+    assert(core_id == env->spr[SPR_PIR] - env->spr[SPR_TIR]);
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
 
-    /* TODO: TCG supports only one thread */
-    if (val & ~0x1) {
+    if (val & ~(nr_threads - 1)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
                       TARGET_FMT_lx"\n", val);
+        val &= ~(nr_threads - 1);
+        /* Ignore the invalid bits */
+    }
+
+    if (nr_threads == 1) {
+        /* XXX: don't need iothread lock? */
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
 
-    ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
+    qemu_mutex_lock_iothread();
+    CPU_FOREACH(ccs) {
+        CPUPPCState *cenv = &POWERPC_CPU(ccs)->env;
+        uint32_t ccore_id = cenv->spr[SPR_PIR] & ~(nr_threads - 1);
+        uint32_t thread_id = cenv->spr[SPR_TIR];
+
+        assert(ccore_id == cenv->spr[SPR_PIR] - cenv->spr[SPR_TIR]);
+
+        if (ccore_id == core_id) {
+            ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
+        }
+    }
+    qemu_mutex_unlock_iothread();
 }
 #endif /* defined(TARGET_PPC64) */
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 31821f92f5..0aa49323d3 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -820,11 +820,19 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
 /* DPDES */
 void spr_read_dpdes(DisasContext *ctx, int gprn, int sprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_load_dpdes(cpu_gpr[gprn], cpu_env);
 }
 
 void spr_write_dpdes(DisasContext *ctx, int sprn, int gprn)
 {
+    if (!gen_serialize_core(ctx)) {
+        return;
+    }
+
     gen_helper_store_dpdes(cpu_env, cpu_gpr[gprn]);
 }
 #endif
diff --git a/target/ppc/translate/processor-ctrl-impl.c.inc b/target/ppc/translate/processor-ctrl-impl.c.inc
index cc7a50d579..7dfbcd781f 100644
--- a/target/ppc/translate/processor-ctrl-impl.c.inc
+++ b/target/ppc/translate/processor-ctrl-impl.c.inc
@@ -59,7 +59,7 @@ static bool trans_MSGSND(DisasContext *ctx, arg_X_rb *a)
 
 #if !defined(CONFIG_USER_ONLY)
     if (is_book3s_arch2x(ctx)) {
-        gen_helper_book3s_msgsnd(cpu_gpr[a->rb]);
+        gen_helper_book3s_msgsnd(cpu_env, cpu_gpr[a->rb]);
     } else {
         gen_helper_msgsnd(cpu_gpr[a->rb]);
     }
-- 
2.40.1


