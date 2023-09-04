Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE5791474
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YH-00023K-89; Mon, 04 Sep 2023 05:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YC-0001tx-Vd; Mon, 04 Sep 2023 05:07:17 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YA-0003gg-BV; Mon, 04 Sep 2023 05:07:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7P2Z4Tz4wy9;
 Mon,  4 Sep 2023 19:07:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7M3lsQz4wy1;
 Mon,  4 Sep 2023 19:07:11 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 14/35] hw/ppc: Round up the decrementer interval when
 converting to ns
Date: Mon,  4 Sep 2023 11:06:09 +0200
Message-ID: <20230904090630.725952-15-clg@kaod.org>
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

The rule of timers is typically that they should never expire before the
timeout, but some time afterward. Rounding timer intervals up when doing
conversion is the right thing to do.

Under most circumstances it is impossible observe the decrementer
interrupt before the dec register has triggered. However with icount
timing, problems can arise. For example setting DEC to 0 can schedule
the timer for now, causing it to fire before any more instructions
have been executed and DEC is still 0.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 423a3a117ae2..13eb45f4b77e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -482,14 +482,26 @@ void ppce500_set_mpic_proxy(bool enabled)
 /*****************************************************************************/
 /* PowerPC time base and decrementer emulation */
 
+/*
+ * Conversion between QEMU_CLOCK_VIRTUAL ns and timebase (TB) ticks:
+ * TB ticks are arrived at by multiplying tb_freq then dividing by
+ * ns per second, and rounding down. TB ticks drive all clocks and
+ * timers in the target machine.
+ *
+ * Converting TB intervals to ns for the purpose of setting a
+ * QEMU_CLOCK_VIRTUAL timer should go the other way, but rounding
+ * up. Rounding down could cause the timer to fire before the TB
+ * value has been reached.
+ */
 static uint64_t ns_to_tb(uint32_t freq, int64_t clock)
 {
     return muldiv64(clock, freq, NANOSECONDS_PER_SECOND);
 }
 
-static int64_t tb_to_ns(uint32_t freq, uint64_t tb)
+/* virtual clock in TB ticks, not adjusted by TB offset */
+static int64_t tb_to_ns_round_up(uint32_t freq, uint64_t tb)
 {
-    return muldiv64(tb, NANOSECONDS_PER_SECOND, freq);
+    return muldiv64_round_up(tb, NANOSECONDS_PER_SECOND, freq);
 }
 
 uint64_t cpu_ppc_get_tb(ppc_tb_t *tb_env, uint64_t vmclk, int64_t tb_offset)
@@ -847,7 +859,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + tb_to_ns(tb_env->decr_freq, value);
+    next = now + tb_to_ns_round_up(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1139,9 +1151,7 @@ static void cpu_4xx_fit_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + tb_to_ns(tb_env->tb_freq, next);
-    if (next == now)
-        next++;
+    next = now + tb_to_ns_round_up(tb_env->tb_freq, next);
     timer_mod(ppc40x_timer->fit_timer, next);
     env->spr[SPR_40x_TSR] |= 1 << 26;
     if ((env->spr[SPR_40x_TCR] >> 23) & 0x1) {
@@ -1167,11 +1177,10 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + tb_to_ns(tb_env->decr_freq, ppc40x_timer->pit_reload);
+        next = now + tb_to_ns_round_up(tb_env->decr_freq,
+                                       ppc40x_timer->pit_reload);
         if (is_excp)
             next += tb_env->decr_next - now;
-        if (next == now)
-            next++;
         timer_mod(tb_env->decr_timer, next);
         tb_env->decr_next = next;
     }
@@ -1226,9 +1235,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + tb_to_ns(tb_env->decr_freq, next);
-    if (next == now)
-        next++;
+    next = now + tb_to_ns_round_up(tb_env->decr_freq, next);
     trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
     switch ((env->spr[SPR_40x_TSR] >> 30) & 0x3) {
     case 0x0:
-- 
2.41.0


