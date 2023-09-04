Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7152C79145E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:09:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YT-0002kj-W9; Mon, 04 Sep 2023 05:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YQ-0002cn-QX; Mon, 04 Sep 2023 05:07:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YN-0003oK-VG; Mon, 04 Sep 2023 05:07:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7f5Lc2z4wy8;
 Mon,  4 Sep 2023 19:07:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7b21MYz4wy1;
 Mon,  4 Sep 2023 19:07:23 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 19/35] hw/ppc: Reset timebase facilities on machine reset
Date: Mon,  4 Sep 2023 11:06:14 +0200
Message-ID: <20230904090630.725952-20-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Lower interrupts, delete timers, and set time facility registers
back to initial state on machine reset.

This is not so important for record-replay since timebase and
decrementer are migrated, but it gives a cleaner reset state.

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/ppc.h    |  3 ++-
 hw/ppc/mac_oldworld.c   |  1 +
 hw/ppc/pegasos2.c       |  1 +
 hw/ppc/pnv_core.c       |  2 ++
 hw/ppc/ppc.c            | 46 +++++++++++++++++++++++------------------
 hw/ppc/prep.c           |  1 +
 hw/ppc/spapr_cpu_core.c |  2 ++
 7 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index e095c002dc24..17a8dfc10715 100644
--- a/include/hw/ppc/ppc.h
+++ b/include/hw/ppc/ppc.h
@@ -54,7 +54,8 @@ struct ppc_tb_t {
                                                */
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset);
-clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq);
+void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq);
+void cpu_ppc_tb_reset(CPUPPCState *env);
 void cpu_ppc_tb_free(CPUPPCState *env);
 void cpu_ppc_hdecr_init(CPUPPCState *env);
 void cpu_ppc_hdecr_exit(CPUPPCState *env);
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 510ff0eaaf93..9acc7adfc925 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -81,6 +81,7 @@ static void ppc_heathrow_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
 
+    cpu_ppc_tb_reset(&cpu->env);
     cpu_reset(CPU(cpu));
 }
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 075367d94d00..bd397cf2b5c5 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -99,6 +99,7 @@ static void pegasos2_cpu_reset(void *opaque)
         cpu->env.gpr[1] = 2 * VOF_STACK_SIZE - 0x20;
         cpu->env.nip = 0x100;
     }
+    cpu_ppc_tb_reset(&cpu->env);
 }
 
 static void pegasos2_pci_irq(void *opaque, int n, int level)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9b39d527de96..8c7afe037f00 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -61,6 +61,8 @@ static void pnv_core_cpu_reset(PnvCore *pc, PowerPCCPU *cpu)
     hreg_compute_hflags(env);
     ppc_maybe_interrupt(env);
 
+    cpu_ppc_tb_reset(env);
+
     pcc->intc_reset(pc->chip, cpu);
 }
 
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d9a1cfbf91fe..f391acc39e11 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -944,23 +944,6 @@ void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
                      &tb_env->purr_offset, value);
 }
 
-static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
-{
-    CPUPPCState *env = opaque;
-    PowerPCCPU *cpu = env_archcpu(env);
-    ppc_tb_t *tb_env = env->tb_env;
-
-    tb_env->tb_freq = freq;
-    tb_env->decr_freq = freq;
-    /* There is a bug in Linux 2.4 kernels:
-     * if a decrementer exception is pending when it enables msr_ee at startup,
-     * it's not ready to handle it...
-     */
-    _cpu_ppc_store_decr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    _cpu_ppc_store_hdecr(cpu, 0xFFFFFFFF, 0xFFFFFFFF, 32);
-    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
-}
-
 static void timebase_save(PPCTimebase *tb)
 {
     uint64_t ticks = cpu_get_host_ticks();
@@ -1062,7 +1045,7 @@ const VMStateDescription vmstate_ppc_timebase = {
 };
 
 /* Set up (once) timebase frequency (in Hz) */
-clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
+void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     ppc_tb_t *tb_env;
@@ -1083,9 +1066,32 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
     } else {
         tb_env->hdecr_timer = NULL;
     }
-    cpu_ppc_set_tb_clk(env, freq);
 
-    return &cpu_ppc_set_tb_clk;
+    tb_env->tb_freq = freq;
+    tb_env->decr_freq = freq;
+}
+
+void cpu_ppc_tb_reset(CPUPPCState *env)
+{
+    PowerPCCPU *cpu = env_archcpu(env);
+    ppc_tb_t *tb_env = env->tb_env;
+
+    timer_del(tb_env->decr_timer);
+    ppc_set_irq(cpu, PPC_INTERRUPT_DECR, 0);
+    tb_env->decr_next = 0;
+    if (tb_env->hdecr_timer != NULL) {
+        timer_del(tb_env->hdecr_timer);
+        ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
+        tb_env->hdecr_next = 0;
+    }
+
+    /* There is a bug in Linux 2.4 kernels:
+     * if a decrementer exception is pending when it enables msr_ee at startup,
+     * it's not ready to handle it...
+     */
+    cpu_ppc_store_decr(env, -1);
+    cpu_ppc_store_hdecr(env, -1);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d9231c731775..f6fd35fcb9e3 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -67,6 +67,7 @@ static void ppc_prep_reset(void *opaque)
     PowerPCCPU *cpu = opaque;
 
     cpu_reset(CPU(cpu));
+    cpu_ppc_tb_reset(&cpu->env);
 }
 
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b482d9754a1f..91fae56573ee 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -74,6 +74,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     kvm_check_mmu(cpu, &error_fatal);
 
+    cpu_ppc_tb_reset(env);
+
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
 
-- 
2.41.0


