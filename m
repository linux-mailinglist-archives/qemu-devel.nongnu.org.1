Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F8A831990
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:52:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRrc-0003pg-03; Thu, 18 Jan 2024 07:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrX-0003mv-KM; Thu, 18 Jan 2024 07:51:15 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rQRrW-0000Wd-1V; Thu, 18 Jan 2024 07:51:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A7B9452CC;
 Thu, 18 Jan 2024 15:51:27 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2AE59668C0;
 Thu, 18 Jan 2024 15:50:57 +0300 (MSK)
Received: (nullmailer pid 2502746 invoked by uid 1000);
 Thu, 18 Jan 2024 12:50:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miguel Luis <miguel.luis@oracle.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 07/11] hw/intc/arm_gicv3_cpuif: handle LPIs in in the
 list registers
Date: Thu, 18 Jan 2024 15:50:45 +0300
Message-Id: <20240118125056.2502687-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240118154659@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Peter Maydell <peter.maydell@linaro.org>

The hypervisor can deliver (virtual) LPIs to a guest by setting up a
list register to have an intid which is an LPI.  The GIC has to treat
these a little differently to standard interrupt IDs, because LPIs
have no Active state, and so the guest will only EOI them, it will
not also deactivate them.  So icv_eoir_write() must do two things:

 * if the LPI ID is not in any list register, we drop the
   priority but do not increment the EOI count
 * if the LPI ID is in a list register, we immediately deactivate
   it, regardless of the split-drop-and-deactivate control

This can be seen in the VirtualWriteEOIR0() and VirtualWriteEOIR1()
pseudocode in the GICv3 architecture specification.

Without this fix, potentially a hypervisor guest might stall because
LPIs get stuck in a bogus Active+Pending state.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
(cherry picked from commit 82a65e3188abebb509510b391726711606aca642)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d07b13eb27..05dcfc4bc3 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1434,16 +1434,25 @@ static void icv_eoir_write(CPUARMState *env, const ARMCPRegInfo *ri,
     idx = icv_find_active(cs, irq);
 
     if (idx < 0) {
-        /* No valid list register corresponding to EOI ID */
-        icv_increment_eoicount(cs);
+        /*
+         * No valid list register corresponding to EOI ID; if this is a vLPI
+         * not in the list regs then do nothing; otherwise increment EOI count
+         */
+        if (irq < GICV3_LPI_INTID_START) {
+            icv_increment_eoicount(cs);
+        }
     } else {
         uint64_t lr = cs->ich_lr_el2[idx];
         int thisgrp = (lr & ICH_LR_EL2_GROUP) ? GICV3_G1NS : GICV3_G0;
         int lr_gprio = ich_lr_prio(lr) & icv_gprio_mask(cs, grp);
 
         if (thisgrp == grp && lr_gprio == dropprio) {
-            if (!icv_eoi_split(env, cs)) {
-                /* Priority drop and deactivate not split: deactivate irq now */
+            if (!icv_eoi_split(env, cs) || irq >= GICV3_LPI_INTID_START) {
+                /*
+                 * Priority drop and deactivate not split: deactivate irq now.
+                 * LPIs always get their active state cleared immediately
+                 * because no separate deactivate is expected.
+                 */
                 icv_deactivate_irq(cs, idx);
             }
         }
-- 
2.39.2


