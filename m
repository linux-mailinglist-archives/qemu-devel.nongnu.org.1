Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 273807B7971
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwqu-0004ZH-UI; Wed, 04 Oct 2023 04:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqD-000496-71; Wed, 04 Oct 2023 04:02:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqA-00087O-Fl; Wed, 04 Oct 2023 04:02:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35F4B27592;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 862672CBCE;
 Wed,  4 Oct 2023 11:02:23 +0300 (MSK)
Received: (nullmailer pid 2702774 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 08/45] hw/ppc: Read time only once to perform
 decrementer write
Date: Wed,  4 Oct 2023 11:01:29 +0300
Message-Id: <20231004080221.2702636-8-mjt@tls.msk.ru>
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

Reading the time more than once to perform an operation always increases
complexity and fragility due to introduced deltas. Simplify the
decrementer write by reading the clock once for the operation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit ea62f8a5172cf5fcd97df143b758730f6865a625)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8d66b8618a..28a661cba9 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -704,13 +704,13 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
     return ((tb_env->flags & flags) == PPC_DECR_UNDERFLOW_TRIGGERED);
 }
 
-static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
+static inline int64_t __cpu_ppc_load_decr(CPUPPCState *env, int64_t now,
+                                          uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t now, n;
+    uint64_t n;
     int64_t decr;
 
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     n = ns_to_tb(tb_env->decr_freq, now);
     if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
@@ -723,16 +723,12 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
     return decr;
 }
 
-target_ulong cpu_ppc_load_decr(CPUPPCState *env)
+static target_ulong _cpu_ppc_load_decr(CPUPPCState *env, int64_t now)
 {
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t decr;
 
-    if (kvm_enabled()) {
-        return env->spr[SPR_DECR];
-    }
-
-    decr = _cpu_ppc_load_decr(env, tb_env->decr_next);
+    decr = __cpu_ppc_load_decr(env, now, tb_env->decr_next);
 
     /*
      * If large decrementer is enabled then the decrementer is signed extened
@@ -746,14 +742,23 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
     return (uint32_t) decr;
 }
 
-target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
+target_ulong cpu_ppc_load_decr(CPUPPCState *env)
+{
+    if (kvm_enabled()) {
+        return env->spr[SPR_DECR];
+    } else {
+        return _cpu_ppc_load_decr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+    }
+}
+
+static target_ulong _cpu_ppc_load_hdecr(CPUPPCState *env, int64_t now)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     ppc_tb_t *tb_env = env->tb_env;
     uint64_t hdecr;
 
-    hdecr =  _cpu_ppc_load_decr(env, tb_env->hdecr_next);
+    hdecr =  __cpu_ppc_load_decr(env, now, tb_env->hdecr_next);
 
     /*
      * If we have a large decrementer (POWER9 or later) then hdecr is sign
@@ -765,6 +770,11 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
     return (uint32_t) hdecr;
 }
 
+target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
+{
+    return _cpu_ppc_load_hdecr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL));
+}
+
 uint64_t cpu_ppc_load_purr (CPUPPCState *env)
 {
     ppc_tb_t *tb_env = env->tb_env;
@@ -809,7 +819,7 @@ static inline void cpu_ppc_hdecr_lower(PowerPCCPU *cpu)
     ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
 }
 
-static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
+static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
@@ -818,7 +828,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t now, next;
+    uint64_t next;
     int64_t signed_value;
     int64_t signed_decr;
 
@@ -830,18 +840,12 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     trace_ppc_decr_store(nr_bits, decr, value);
 
-    if (kvm_enabled()) {
-        /* KVM handles decrementer exceptions, we don't need our own timer */
-        return;
-    }
-
     /*
      * Calculate the next decrementer event and set a timer.
      * decr_next is in timebase units to keep rounding simple. Note it is
      * not adjusted by tb_offset because if TB changes via tb_offset changing,
      * decrementer does not change, so not directly comparable with TB.
      */
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     next = ns_to_tb(tb_env->decr_freq, now) + value;
     *nextp = next; /* nextp is in timebase units */
 
@@ -870,12 +874,13 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
 
-static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
-                                       target_ulong value, int nr_bits)
+static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now,
+                                       target_ulong decr, target_ulong value,
+                                       int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
-    __cpu_ppc_store_decr(cpu, &tb_env->decr_next, tb_env->decr_timer,
+    __cpu_ppc_store_decr(cpu, now, &tb_env->decr_next, tb_env->decr_timer,
                          tb_env->decr_timer->cb, &cpu_ppc_decr_lower,
                          tb_env->flags, decr, value, nr_bits);
 }
@@ -884,13 +889,22 @@ void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int64_t now;
+    target_ulong decr;
     int nr_bits = 32;
 
+    if (kvm_enabled()) {
+        /* KVM handles decrementer exceptions, we don't need our own timer */
+        return;
+    }
+
     if (env->spr[SPR_LPCR] & LPCR_LD) {
         nr_bits = pcc->lrg_decr_bits;
     }
 
-    _cpu_ppc_store_decr(cpu, cpu_ppc_load_decr(env), value, nr_bits);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    decr = _cpu_ppc_load_decr(env, now);
+    _cpu_ppc_store_decr(cpu, now, decr, value, nr_bits);
 }
 
 static void cpu_ppc_decr_cb(void *opaque)
@@ -900,14 +914,15 @@ static void cpu_ppc_decr_cb(void *opaque)
     cpu_ppc_decr_excp(cpu);
 }
 
-static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, target_ulong hdecr,
-                                        target_ulong value, int nr_bits)
+static inline void _cpu_ppc_store_hdecr(PowerPCCPU *cpu, int64_t now,
+                                        target_ulong hdecr, target_ulong value,
+                                        int nr_bits)
 {
     ppc_tb_t *tb_env = cpu->env.tb_env;
 
     if (tb_env->hdecr_timer != NULL) {
         /* HDECR (Book3S 64bit) is edge-based, not level like DECR */
-        __cpu_ppc_store_decr(cpu, &tb_env->hdecr_next, tb_env->hdecr_timer,
+        __cpu_ppc_store_decr(cpu, now, &tb_env->hdecr_next, tb_env->hdecr_timer,
                              tb_env->hdecr_timer->cb, &cpu_ppc_hdecr_lower,
                              PPC_DECR_UNDERFLOW_TRIGGERED,
                              hdecr, value, nr_bits);
@@ -918,9 +933,12 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value)
 {
     PowerPCCPU *cpu = env_archcpu(env);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+    int64_t now;
+    target_ulong hdecr;
 
-    _cpu_ppc_store_hdecr(cpu, cpu_ppc_load_hdecr(env), value,
-                         pcc->lrg_decr_bits);
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    hdecr = _cpu_ppc_load_hdecr(env, now);
+    _cpu_ppc_store_hdecr(cpu, now, hdecr, value, pcc->lrg_decr_bits);
 }
 
 static void cpu_ppc_hdecr_cb(void *opaque)
@@ -930,12 +948,16 @@ static void cpu_ppc_hdecr_cb(void *opaque)
     cpu_ppc_hdecr_excp(cpu);
 }
 
-void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
+static void _cpu_ppc_store_purr(CPUPPCState *env, int64_t now, uint64_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
 
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->purr_offset, value);
+    cpu_ppc_store_tb(tb_env, now, &tb_env->purr_offset, value);
+}
+
+void cpu_ppc_store_purr(CPUPPCState *env, uint64_t value)
+{
+    _cpu_ppc_store_purr(env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), value);
 }
 
 static void timebase_save(PPCTimebase *tb)
-- 
2.39.2


