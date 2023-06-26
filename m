Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A38D973D776
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:02:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfFE-0004rc-Ll; Mon, 26 Jun 2023 01:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEl-0003wh-BA; Mon, 26 Jun 2023 01:58:10 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfEj-0007bq-36; Mon, 26 Jun 2023 01:58:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHFR6qqCz4wb3;
 Mon, 26 Jun 2023 15:58:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHFP503Vz4wb1;
 Mon, 26 Jun 2023 15:58:01 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 23/30] target/ppc: Add msgsnd/p and DPDES SMT support
Date: Mon, 26 Jun 2023 07:56:40 +0200
Message-ID: <20230626055647.1147743-24-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
References: <20230626055647.1147743-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Doorbells in SMT need to coordinate msgsnd/msgclr and DPDES access from
multiple threads that affect the same state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h     |  1 +
 hw/ppc/ppc.c             |  6 ++++++
 target/ppc/excp_helper.c | 30 ++++++++++++++++++++++-----
 target/ppc/misc_helper.c | 44 ++++++++++++++++++++++++++++++++++------
 target/ppc/translate.c   |  8 ++++++++
 5 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index 02af03ada285..e095c002dc24 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -6,6 +6,7 @@
 void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level);
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir);
 int ppc_cpu_pir(PowerPCCPU *cpu);
+int ppc_cpu_tir(PowerPCCPU *cpu);
 
 /* PowerPC hardware exceptions management helpers */
 typedef void (*clk_setup_cb)(void *opaque, uint32_t freq);
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 1b1220c42335..82e4408c5cc1 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -1436,6 +1436,12 @@ int ppc_cpu_pir(PowerPCCPU *cpu)
     return env->spr_cb[SPR_PIR].default_value;
 }
 
+int ppc_cpu_tir(PowerPCCPU *cpu)
+{
+    CPUPPCState *env = &cpu->env;
+    return env->spr_cb[SPR_TIR].default_value;
+}
+
 PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 {
     CPUState *cs;
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 8e2fec3551b9..2158390e2791 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -3186,22 +3186,42 @@ void helper_book3s_msgclrp(CPUPPCState *env, target_ulong rb)
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
+    /* Does iothread need to be locked for walking CPU list? */
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
+    g_assert_not_reached();
 }
 #endif /* TARGET_PPC64 */
 
diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index a058eb24cdc0..1f1af21f334d 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -184,14 +184,31 @@ void helper_store_pcr(CPUPPCState *env, target_ulong value)
  */
 target_ulong helper_load_dpdes(CPUPPCState *env)
 {
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
     target_ulong dpdes = 0;
 
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
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        CPUPPCState *cenv = &ccpu->env;
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        if (cenv->pending_interrupts & PPC_INTERRUPT_DOORBELL) {
+            dpdes |= (0x1 << thread_id);
+        }
     }
+    qemu_mutex_unlock_iothread();
 
     return dpdes;
 }
@@ -199,17 +216,32 @@ target_ulong helper_load_dpdes(CPUPPCState *env)
 void helper_store_dpdes(CPUPPCState *env, target_ulong val)
 {
     PowerPCCPU *cpu = env_archcpu(env);
+    CPUState *cs = env_cpu(env);
+    CPUState *ccs;
+    uint32_t nr_threads = cs->nr_threads;
 
     helper_hfscr_facility_check(env, HFSCR_MSGP, "store DPDES", HFSCR_IC_MSGP);
 
-    /* TODO: TCG supports only one thread */
-    if (val & ~0x1) {
+    if (val & ~(nr_threads - 1)) {
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid DPDES register value "
                       TARGET_FMT_lx"\n", val);
+        val &= (nr_threads - 1); /* Ignore the invalid bits */
+    }
+
+    if (nr_threads == 1) {
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
         return;
     }
 
-    ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & 0x1);
+    /* Does iothread need to be locked for walking CPU list? */
+    qemu_mutex_lock_iothread();
+    THREAD_SIBLING_FOREACH(cs, ccs) {
+        PowerPCCPU *ccpu = POWERPC_CPU(ccs);
+        uint32_t thread_id = ppc_cpu_tir(ccpu);
+
+        ppc_set_irq(cpu, PPC_INTERRUPT_DOORBELL, val & (0x1 << thread_id));
+    }
+    qemu_mutex_unlock_iothread();
 }
 #endif /* defined(TARGET_PPC64) */
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c321a39027a3..372ee600b218 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -815,11 +815,19 @@ void spr_write_pcr(DisasContext *ctx, int sprn, int gprn)
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
-- 
2.41.0


