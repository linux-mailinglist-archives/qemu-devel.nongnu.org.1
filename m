Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C11679146A
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YY-0002zZ-V7; Mon, 04 Sep 2023 05:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YW-0002tR-Db; Mon, 04 Sep 2023 05:07:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YS-0003qU-DE; Mon, 04 Sep 2023 05:07:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7j0j10z4wxW;
 Mon,  4 Sep 2023 19:07:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7g1w1Tz4x2D;
 Mon,  4 Sep 2023 19:07:27 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 20/35] hw/ppc: Read time only once to perform decrementer write
Date: Mon,  4 Sep 2023 11:06:15 +0200
Message-ID: <20230904090630.725952-21-clg@kaod.org>
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

Reading the time more than once to perform an operation always increases
complexity and fragility due to introduced deltas. Simplify the
decrementer write by reading the clock once for the operation.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 84 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index f391acc39e11..a0ee064b1dba 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -708,13 +708,13 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
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
@@ -727,16 +727,12 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
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
@@ -750,14 +746,23 @@ target_ulong cpu_ppc_load_decr(CPUPPCState *env)
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
@@ -771,6 +776,11 @@ target_ulong cpu_ppc_load_hdecr(CPUPPCState *env)
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
@@ -815,7 +825,7 @@ static inline void cpu_ppc_hdecr_lower(PowerPCCPU *cpu)
     ppc_set_irq(cpu, PPC_INTERRUPT_HDECR, 0);
 }
 
-static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
+static void __cpu_ppc_store_decr(PowerPCCPU *cpu, int64_t now, uint64_t *nextp,
                                  QEMUTimer *timer,
                                  void (*raise_excp)(void *),
                                  void (*lower_excp)(PowerPCCPU *),
@@ -824,7 +834,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 {
     CPUPPCState *env = &cpu->env;
     ppc_tb_t *tb_env = env->tb_env;
-    uint64_t now, next;
+    uint64_t next;
     int64_t signed_value;
     int64_t signed_decr;
 
@@ -836,18 +846,12 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
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
 
@@ -876,12 +880,13 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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
@@ -890,13 +895,22 @@ void cpu_ppc_store_decr(CPUPPCState *env, target_ulong value)
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
@@ -906,14 +920,15 @@ static void cpu_ppc_decr_cb(void *opaque)
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
@@ -924,9 +939,12 @@ void cpu_ppc_store_hdecr(CPUPPCState *env, target_ulong value)
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
@@ -936,12 +954,16 @@ static void cpu_ppc_hdecr_cb(void *opaque)
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
2.41.0


