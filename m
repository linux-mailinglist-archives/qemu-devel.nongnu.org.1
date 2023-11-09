Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F507E6BEE
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:02:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15b9-0007K2-DT; Thu, 09 Nov 2023 09:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zc-0005DX-7B; Thu, 09 Nov 2023 08:59:57 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15ZY-0005Rd-2A; Thu, 09 Nov 2023 08:59:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A364C31BBD;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AE4F4344F6;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462775 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 07/62] hw/ppc: Always store the decrementer value
Date: Thu,  9 Nov 2023 16:58:35 +0300
Message-Id: <20231109135933.1462615-7-mjt@tls.msk.ru>
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

When writing a value to the decrementer that raises an exception, the
irq is raised, but the value is not stored so the store doesn't appear
to have changed the register when it is read again.

Always store the write value to the register.

Fixes: e81a982aa53 ("PPC: Clean up DECR implementation")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit febb71d543a8f747b2f8aaf0182d0a385c6a02c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index dfa3945454..b17804fc17 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -842,6 +842,16 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         return;
     }
 
+    /*
+     * Calculate the next decrementer event and set a timer.
+     * decr_next is in timebase units to keep rounding simple. Note it is
+     * not adjusted by tb_offset because if TB changes via tb_offset changing,
+     * decrementer does not change, so not directly comparable with TB.
+     */
+    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+    next = ns_to_tb(tb_env->decr_freq, now) + value;
+    *nextp = next; /* nextp is in timebase units */
+
     /*
      * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
      *
@@ -863,16 +873,6 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
         (*lower_excp)(cpu);
     }
 
-    /*
-     * Calculate the next decrementer event and set a timer.
-     * decr_next is in timebase units to keep rounding simple. Note it is
-     * not adjusted by tb_offset because if TB changes via tb_offset changing,
-     * decrementer does not change, so not directly comparable with TB.
-     */
-    now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
-    next = ns_to_tb(tb_env->decr_freq, now) + value;
-    *nextp = next;
-
     /* Adjust timer */
     timer_mod(timer, tb_to_ns_round_up(tb_env->decr_freq, next));
 }
-- 
2.39.2


