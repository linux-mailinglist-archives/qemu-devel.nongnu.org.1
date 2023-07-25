Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F20761A79
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 15:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOINO-000659-0p; Tue, 25 Jul 2023 09:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIMB-0005F6-4f; Tue, 25 Jul 2023 09:45:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qOIM7-0001Gi-MB; Tue, 25 Jul 2023 09:45:42 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 634AB160EB;
 Tue, 25 Jul 2023 16:45:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1E07E194AE;
 Tue, 25 Jul 2023 16:45:30 +0300 (MSK)
Received: (nullmailer pid 3370792 invoked by uid 1000);
 Tue, 25 Jul 2023 13:45:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 03/31] hw/ppc: Fix clock update drift
Date: Tue, 25 Jul 2023 16:44:48 +0300
Message-Id: <20230725134517.3370706-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230725164041@cover.tls.msk.ru>
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

The clock update logic reads the clock twice to compute the new clock
value, with a value derived from the later time subtracted from a value
derived from the earlier time. The delta causes time to be lost.

This can ultimately result in time becoming unsynchronized between CPUs
and that can cause OS lockups, timeouts, watchdogs, etc. This can be
seen running a KVM guest (that causes lots of TB updates) on a powernv
SMP machine.

Fix this by reading the clock once.

Cc: qemu-stable@nongnu.org
Fixes: dbdd25065e90 ("Implement time-base start/stop helpers.")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230629020713.327745-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
(cherry picked from commit 2ad2e113deb5663e69a05dd6922cbfc6d7ea34d3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d80b0adc6c..85d442fbce 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -535,23 +535,24 @@ static inline void cpu_ppc_store_tb(ppc_tb_t *tb_env, uint64_t vmclk,
 void cpu_ppc_store_tbl (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0xFFFFFFFF00000000ULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, tb | (uint64_t)value);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb | (uint64_t)value);
 }
 
 static inline void _cpu_ppc_store_tbu(CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0x00000000FFFFFFFFULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, ((uint64_t)value << 32) | tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset,
+                     ((uint64_t)value << 32) | tb);
 }
 
 void cpu_ppc_store_tbu (CPUPPCState *env, uint32_t value)
@@ -584,23 +585,24 @@ uint32_t cpu_ppc_load_atbu (CPUPPCState *env)
 void cpu_ppc_store_atbl (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
     tb &= 0xFFFFFFFF00000000ULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->atb_offset, tb | (uint64_t)value);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset, tb | (uint64_t)value);
 }
 
 void cpu_ppc_store_atbu (CPUPPCState *env, uint32_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL), tb_env->atb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->atb_offset);
     tb &= 0x00000000FFFFFFFFULL;
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->atb_offset, ((uint64_t)value << 32) | tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->atb_offset,
+                     ((uint64_t)value << 32) | tb);
 }
 
 uint64_t cpu_ppc_load_vtb(CPUPPCState *env)
@@ -622,14 +624,13 @@ void cpu_ppc_store_vtb(CPUPPCState *env, uint64_t value)
 void cpu_ppc_store_tbu40(CPUPPCState *env, uint64_t value)
 {
     ppc_tb_t *tb_env = env->tb_env;
+    int64_t clock = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     uint64_t tb;
 
-    tb = cpu_ppc_get_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                        tb_env->tb_offset);
+    tb = cpu_ppc_get_tb(tb_env, clock, tb_env->tb_offset);
     tb &= 0xFFFFFFUL;
     tb |= (value & ~0xFFFFFFUL);
-    cpu_ppc_store_tb(tb_env, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
-                     &tb_env->tb_offset, tb);
+    cpu_ppc_store_tb(tb_env, clock, &tb_env->tb_offset, tb);
 }
 
 static void cpu_ppc_tb_stop (CPUPPCState *env)
-- 
2.39.2


