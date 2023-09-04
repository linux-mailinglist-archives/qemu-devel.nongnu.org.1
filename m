Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CF1791458
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd5YI-00025k-Au; Mon, 04 Sep 2023 05:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YG-00023W-K2; Mon, 04 Sep 2023 05:07:20 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=kZzc=EU=kaod.org=clg@ozlabs.org>)
 id 1qd5YD-0003ku-WE; Mon, 04 Sep 2023 05:07:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RfN7R53lHz4wy8;
 Mon,  4 Sep 2023 19:07:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RfN7P6GdKz4wy1;
 Mon,  4 Sep 2023 19:07:13 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 15/35] hw/ppc: Avoid decrementer rounding errors
Date: Mon,  4 Sep 2023 11:06:10 +0200
Message-ID: <20230904090630.725952-16-clg@kaod.org>
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

The decrementer register contains a relative time in timebase units.
When writing to DECR this is converted and stored as an absolute value
in nanosecond units, reading DECR converts back to relative timebase.

The tb<->ns conversion of the relative part can cause rounding such that
a value writen to the decrementer can read back a different, with time
held constant. This is a particular problem for a deterministic icount
and record-replay trace.

Fix this by storing the absolute value in timebase units rather than
nanoseconds. The math before:
  store:  decr_next = now_ns + decr * ns_per_sec / tb_per_sec
  load:        decr = (decr_next - now_ns) * tb_per_sec / ns_per_sec
  load(store): decr = decr * ns_per_sec / tb_per_sec * tb_per_sec /
                      ns_per_sec

After:
  store:  decr_next = now_ns * tb_per_sec / ns_per_sec + decr
  load:        decr = decr_next - now_ns * tb_per_sec / ns_per_sec
  load(store): decr = decr

Fixes: 9fddaa0c0cab ("PowerPC merge: real time TB and decrementer - faster and simpler exception handling (Jocelyn Mayer)")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/ppc.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 13eb45f4b77e..a397820d9c34 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -711,16 +711,17 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
 static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 {
     ppc_tb_t *tb_env = env->tb_env;
-    int64_t decr, diff;
+    uint64_t now, n;
+    int64_t decr;
 
-    diff = next - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    if (diff >= 0) {
-        decr = ns_to_tb(tb_env->decr_freq, diff);
-    } else if (tb_env->flags & PPC_TIMER_BOOKE) {
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    n = ns_to_tb(tb_env->decr_freq, now);
+    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
         decr = 0;
-    }  else {
-        decr = -ns_to_tb(tb_env->decr_freq, -diff);
+    } else {
+        decr = next - n;
     }
+
     trace_ppc_decr_load(decr);
 
     return decr;
@@ -857,13 +858,18 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         (*lower_excp)(cpu);
     }
 
-    /* Calculate the next timer event */
+    /*
+     * Calculate the next decrementer event and set a timer.
+     * decr_next is in timebase units to keep rounding simple. Note it is
+     * not adjusted by tb_offset because if TB changes via tb_offset changing,
+     * decrementer does not change, so not directly comparable with TB.
+     */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + tb_to_ns_round_up(tb_env->decr_freq, value);
+    next = ns_to_tb(tb_env->decr_freq, now) + value;
     *nextp = next;
 
     /* Adjust timer */
-    timer_mod(timer, next);
+    timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
 
 static inline void _cpu_ppc_store_decr(PowerPCCPU *cpu, target_ulong decr,
@@ -1177,12 +1183,15 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + tb_to_ns_round_up(tb_env->decr_freq,
-                                       ppc40x_timer->pit_reload);
-        if (is_excp)
-            next += tb_env->decr_next - now;
+
+        if (is_excp) {
+            tb_env->decr_next += ppc40x_timer->pit_reload;
+        } else {
+            tb_env->decr_next = ns_to_tb(tb_env->decr_freq, now)
+                                + ppc40x_timer->pit_reload;
+        }
+        next = tb_to_ns_round_up(tb_env->decr_freq, tb_env->decr_next);
         timer_mod(tb_env->decr_timer, next);
-        tb_env->decr_next = next;
     }
 }
 
-- 
2.41.0


