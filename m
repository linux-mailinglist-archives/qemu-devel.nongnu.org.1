Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C23117B7983
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:05:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwrz-0007Or-JT; Wed, 04 Oct 2023 04:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqH-0004Cf-4p; Wed, 04 Oct 2023 04:02:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwq8-00087E-J5; Wed, 04 Oct 2023 04:02:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0ACFE27591;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 54A982CBCD;
 Wed,  4 Oct 2023 11:02:23 +0300 (MSK)
Received: (nullmailer pid 2702771 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 07/45] hw/ppc: Reset timebase facilities on machine
 reset
Date: Wed,  4 Oct 2023 11:01:28 +0300
Message-Id: <20231004080221.2702636-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
[ clg: checkpatch.pl fixes ]
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 30d0647bcfa99d4a141eaa843a9fb5b091ddbb76)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 510ff0eaaf..9acc7adfc9 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -81,6 +81,7 @@ static void ppc_heathrow_reset(void *opaque)
 {
     PowerPCCPU *cpu = opaque;
 
+    cpu_ppc_tb_reset(&cpu->env);
     cpu_reset(CPU(cpu));
 }
 
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 075367d94d..bd397cf2b5 100644
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
index 9b39d527de..8c7afe037f 100644
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
index 06f3ad0719..8d66b8618a 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -938,23 +938,6 @@ void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
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
@@ -1056,7 +1039,7 @@ const VMStateDescription vmstate_ppc_timebase = {
 };
 
 /* Set up (once) timebase frequency (in Hz) */
-clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
+void cpu_ppc_tb_init(CPUPPCState *env, uint32_t freq)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     ppc_tb_t *tb_env;
@@ -1076,9 +1059,33 @@ clk_setup_cb cpu_ppc_tb_init (CPUPPCState *env, uint32_t freq)
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
+    /*
+     * There is a bug in Linux 2.4 kernels:
+     * if a decrementer exception is pending when it enables msr_ee at startup,
+     * it's not ready to handle it...
+     */
+    cpu_ppc_store_decr(env, -1);
+    cpu_ppc_store_hdecr(env, -1);
+    cpu_ppc_store_purr(env, 0x0000000000000000ULL);
 }
 
 void cpu_ppc_tb_free(CPUPPCState *env)
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index d9231c7317..f6fd35fcb9 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -67,6 +67,7 @@ static void ppc_prep_reset(void *opaque)
     PowerPCCPU *cpu = opaque;
 
     cpu_reset(CPU(cpu));
+    cpu_ppc_tb_reset(&cpu->env);
 }
 
 
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index b482d9754a..91fae56573 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -74,6 +74,8 @@ static void spapr_reset_vcpu(PowerPCCPU *cpu)
 
     kvm_check_mmu(cpu, &error_fatal);
 
+    cpu_ppc_tb_reset(env);
+
     spapr_irq_cpu_intc_reset(spapr, cpu);
 }
 
diff --git a/include/hw/ppc/ppc.h b/include/hw/ppc/ppc.h
index e095c002dc..17a8dfc107 100644
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
-- 
2.39.2


