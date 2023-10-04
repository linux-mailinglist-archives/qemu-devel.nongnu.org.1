Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A97937B7975
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:04:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnwr0-0005Jl-2r; Wed, 04 Oct 2023 04:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwq6-0003ve-Ve; Wed, 04 Oct 2023 04:02:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwq5-00086P-Aq; Wed, 04 Oct 2023 04:02:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CCBD027590;
 Wed,  4 Oct 2023 11:02:23 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1BA492CBCC;
 Wed,  4 Oct 2023 11:02:23 +0300 (MSK)
Received: (nullmailer pid 2702768 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.2 06/45] hw/ppc: Always store the decrementer value
Date: Wed,  4 Oct 2023 11:01:27 +0300
Message-Id: <20231004080221.2702636-6-mjt@tls.msk.ru>
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
index befa9d95b3..06f3ad0719 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -835,6 +835,16 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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
@@ -856,16 +866,6 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
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


