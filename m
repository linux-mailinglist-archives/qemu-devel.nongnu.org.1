Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E367E6BE1
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:01:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15ZR-00057z-Ol; Thu, 09 Nov 2023 08:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZK-00056v-BM; Thu, 09 Nov 2023 08:59:38 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZH-0005N2-CS; Thu, 09 Nov 2023 08:59:38 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 216C631BB7;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2ACB4344F0;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462757 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 01/62] hw/ppc: Introduce functions for conversion
 between timebase and nanoseconds
Date: Thu,  9 Nov 2023 16:58:29 +0300
Message-Id: <20231109135933.1462615-1-mjt@tls.msk.ru>
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

These calculations are repeated several times, and they will become
a little more complicated with subsequent changes.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 7798f5c576d898e7e10c4a2518f3f16411dedeb9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index fbdc48911e..7392870e0e 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -490,10 +490,20 @@ void ppce500_set_mpic_proxy(bool enabled)
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
@@ -534,8 +544,7 @@ uint32_t cpu_ppc_load_tbu (CPUPPCState *env)
 static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
                                     int64_t *tb_offsetp, uint64_t value)
 {
-    *tb_offsetp = value -
-        muldiv64(vmclk, tb_env->tb_freq, NANOSECONDS_PER_SECOND);
+    *tb_offsetp = value - ns_to_tb(tb_env->tb_freq, vmclk);
 
     trace_ppc_tb_store(value, *tb_offsetp);
 }
@@ -697,11 +706,11 @@ static inline int64_t _cpu_ppc_load_decr(CPUPPCState *env, uint64_t next)
 
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
 
@@ -846,7 +855,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
 
     /* Calculate the next timer event */
     now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, value);
     *nextp = next;
 
     /* Adjust timer */
@@ -1135,7 +1144,7 @@ static void cpu_4xx_fit_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->tb_freq);
+    next = now + tb_to_ns(tb_env->tb_freq, next);
     if (next == now)
         next++;
     timer_mod(ppc40x_timer->fit_timer, next);
@@ -1163,8 +1172,7 @@ static void start_stop_pit (CPUPPCState *env, ppc_tb_t *tb_env, int is_excp)
     } else {
         trace_ppc4xx_pit_start(ppc40x_timer->pit_reload);
         now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-        next = now + muldiv64(ppc40x_timer->pit_reload,
-                              NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+        next = now + tb_to_ns(tb_env->decr_freq, ppc40x_timer->pit_reload);
         if (is_excp)
             next += tb_env->decr_next - now;
         if (next == now)
@@ -1223,7 +1231,7 @@ static void cpu_4xx_wdt_cb (void *opaque)
         /* Cannot occur, but makes gcc happy */
         return;
     }
-    next = now + muldiv64(next, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
+    next = now + tb_to_ns(tb_env->decr_freq, next);
     if (next == now)
         next++;
     trace_ppc4xx_wdt(env->spr[SPR_40x_TCR], env->spr[SPR_40x_TSR]);
-- 
2.39.2


