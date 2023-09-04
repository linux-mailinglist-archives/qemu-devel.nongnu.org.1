Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF281791453
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:07:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YE-0001tZ-2m; Mon, 04 Sep 2023 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Y9-0001pE-7t; Mon, 04 Sep 2023 05:07:13 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5Y6-0003gg-Hl; Mon, 04 Sep 2023 05:07:12 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7J1PQkz4x2Z;
 Mon,  4 Sep 2023 19:07:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7G2XhFz4wy8;
 Mon,  4 Sep 2023 19:07:06 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 12/35] hw/ppc: Introduce functions for conversion between
 timebase and nanoseconds
Date: Mon,  4 Sep 2023 11:06:07 +0200
Message-ID: <20230904090630.725952-13-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904090630.725952-1-clg@kaod.org>
References: <20230904090630.725952-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=kZzc=EU=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These calculations are repeated several times, and they will become
a little more complicated with subsequent changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 09b82f68a84e..423a3a117ae2 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -482,10 +482,20 @@ void ppce500_set_mpic_proxy(bool enabled)
 /*****************************************************************************/
 /* PowerPC time base and decrementer emulation */
 
+static uint64_t ns_to_tb(uint32_t freq, int64_t clock)
+{
+    return muldiv64(clock, freq, NANOSECONDS_PER_SECOND);
+}
+
+static int64_t tb_to_ns(uint32_t freq, uint64_t tb)
+{
+    return muldiv64(tb, NANOSECONDS_PER_SECOND, freq);
+}
+
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
 {
     /* TB time in tb periods */
-    return muldiv64(vmclk, tb_env->tb_freq, NANOSECONDS_PER_SECOND) + tb_offset;
+    return ns_to_tb(tb_env->tb_freq, vmclk) + tb_offset;
 }
 
 uint64_t cpu_ppc_load_tbl (CPUPPCState *env)
@@ -528,8 +538,7 @@ uint32_t cpu_ppc_load_tbu (CPUPPCState *env)
 static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
                                     int64_t *tb_offsetp, uint64_t value)
 {
-    *tb_offsetp = value -
-        muldiv64(vmclk, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    *tb_offsetp = value - ns_to_tb(tb_env->tb_freq, vmclk);
 
     trace_ppc_tb_store(value, *tb_offsetp);
 }
@@ -694,11 +703,11 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 
     diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     if (diff >= 0) {
-        decr = muldiv64(diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+        decr = ns_to_tb(tb_env->decr_freq, diff);
     } else if (tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
     }  else {
-        decr = -muldiv64(-diff, tb_env->decr_freq, NANOSECONDS_PER_SECOND);
+        decr = -ns_to_tb(tb_env->decr_freq, -diff);
     }
     trace_ppc_decr_load(decr);
 
@@ -838,7 +847,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1130,7 +1139,7 @@ static void cpu_4xx_fit_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->tb_freq);
+    next = now + tb_to_ns(tb_env->tb_freq, next);
     if (next == now)
         next++;
     timer_mod(ppc40x_timer->fit_timer, next);
@@ -1158,8 +1167,7 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + muldiv64(ppc40x_timer->pit_reload,
-                              NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+        next = now + tb_to_ns(tb_env->decr_freq, ppc40x_timer->pit_reload);
         if (is_excp)
             next += tb_env->decr_next - now;
         if (next == now)
@@ -1218,7 +1226,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, next);
     if (next == now)
         next++;
     trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
-- 
2.41.0


