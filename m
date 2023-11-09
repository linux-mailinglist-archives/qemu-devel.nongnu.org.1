Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C99B7E6BEB
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:02:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15b0-0005jv-Kf; Thu, 09 Nov 2023 09:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZR-00058o-Bd; Thu, 09 Nov 2023 08:59:45 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZM-0005Ny-BL; Thu, 09 Nov 2023 08:59:43 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 51ED431BB9;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 4F4EC344F2;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462763 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 03/62] hw/ppc: Round up the decrementer interval when
 converting to ns
Date: Thu,  9 Nov 2023 16:58:31 +0300
Message-Id: <20231109135933.1462615-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
(cherry picked from commit eab0888418ab44344864965193cf6cd194ab6858)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 7392870e0e..1996a03b57 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -490,14 +490,26 @@ void ppce500_set_mpic_proxy(bool enabled)
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
@@ -855,7 +867,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + tb_to_ns(tb_env->decr_freq, value);
+    next = now + tb_to_ns_round_up(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1144,9 +1156,7 @@ static void cpu_4xx_fit_cb (void *opaque)
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
@@ -1172,11 +1182,10 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
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
@@ -1231,9 +1240,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
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
2.39.2


