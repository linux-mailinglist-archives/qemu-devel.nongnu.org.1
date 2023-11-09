Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545467E6BE0
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:01:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15a9-0005Ut-Hx; Thu, 09 Nov 2023 09:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZU-00059X-Fc; Thu, 09 Nov 2023 08:59:49 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZR-0005Pn-EN; Thu, 09 Nov 2023 08:59:47 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6E20731BBA;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6DB40344F3;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462766 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 04/62] hw/ppc: Avoid decrementer rounding errors
Date: Thu,  9 Nov 2023 16:58:32 +0300
Message-Id: <20231109135933.1462615-4-mjt@tls.msk.ru>
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
(cherry picked from commit 8e0a5ac87800ccc6dd5013f89f27652f4480ab33)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 1996a03b57..9961abc505 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -714,16 +714,17 @@ bool ppc_decr_clear_on_delivery(CPUPPCState *env)
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
@@ -865,13 +866,18 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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
@@ -1182,12 +1188,15 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
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
2.39.2


