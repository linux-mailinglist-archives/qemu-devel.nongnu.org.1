Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED6CA2A536
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Feb 2025 10:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfyZU-00020D-0r; Thu, 06 Feb 2025 04:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfyZJ-0001yC-38; Thu, 06 Feb 2025 04:53:13 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tfyZH-00051a-8C; Thu, 06 Feb 2025 04:53:08 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 6 Feb
 2025 17:52:53 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 6 Feb 2025 17:52:53 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 2/6] hw/intc/aspeed: Introduce helper functions for enable
 and status registers
Date: Thu, 6 Feb 2025 17:52:48 +0800
Message-ID: <20250206095253.928308-3-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
References: <20250206095253.928308-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The behavior of the enable and status registers is almost identical between
INTC(CPU Die) and INTC_IO(IO Die). To reduce duplicated code, adds
"aspeed_intc_enable_handler" functions to handle enable register write
behavior and "aspeed_intc_status_handler" functions to handle status
register write behavior.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/intc/aspeed_intc.c | 185 +++++++++++++++++++++++-------------------
 1 file changed, 103 insertions(+), 82 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 316885a27a..8b1f83c878 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -114,6 +114,107 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     }
 }
 
+static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
+                                       uint64_t data)
+{
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    uint32_t addr = offset >> 2;
+    uint32_t old_enable;
+    uint32_t change;
+    uint32_t irq;
+
+    irq = (offset & 0x0f00) >> 8;
+
+    if (irq >= aic->num_ints) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+                      __func__, irq);
+        return;
+    }
+
+    /*
+     * The enable registers are used to enable source interrupts.
+     * They also handle masking and unmasking of source interrupts
+     * during the execution of the source ISR.
+     */
+
+    /* disable all source interrupt */
+    if (!data && !s->enable[irq]) {
+        s->regs[addr] = data;
+        return;
+    }
+
+    old_enable = s->enable[irq];
+    s->enable[irq] |= data;
+
+    /* enable new source interrupt */
+    if (old_enable != s->enable[irq]) {
+        trace_aspeed_intc_enable(s->enable[irq]);
+        s->regs[addr] = data;
+        return;
+    }
+
+    /* mask and unmask source interrupt */
+    change = s->regs[addr] ^ data;
+    if (change & data) {
+        s->mask[irq] &= ~change;
+        trace_aspeed_intc_unmask(change, s->mask[irq]);
+    } else {
+        s->mask[irq] |= change;
+        trace_aspeed_intc_mask(change, s->mask[irq]);
+    }
+
+    s->regs[addr] = data;
+}
+
+static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
+                                       uint64_t data)
+{
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    uint32_t addr = offset >> 2;
+    uint32_t irq;
+
+    irq = (offset & 0x0f00) >> 8;
+
+    if (irq >= aic->num_ints) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
+                      __func__, irq);
+        return;
+    }
+
+    /* clear status */
+    s->regs[addr] &= ~data;
+
+    /*
+     * These status registers are used for notify sources ISR are executed.
+     * If one source ISR is executed, it will clear one bit.
+     * If it clear all bits, it means to initialize this register status
+     * rather than sources ISR are executed.
+     */
+    if (data == 0xffffffff) {
+        return;
+    }
+
+    /* All source ISR execution are done */
+    if (!s->regs[addr]) {
+        trace_aspeed_intc_all_isr_done(irq);
+        if (s->pending[irq]) {
+            /*
+             * handle pending source interrupt
+             * notify firmware which source interrupt are pending
+             * by setting status register
+             */
+            s->regs[addr] = s->pending[irq];
+            s->pending[irq] = 0;
+            trace_aspeed_intc_trigger_irq(irq, s->regs[addr]);
+            aspeed_intc_update(s, irq, 1);
+        } else {
+            /* clear irq */
+            trace_aspeed_intc_clear_irq(irq, 0);
+            aspeed_intc_update(s, irq, 0);
+        }
+    }
+}
+
 static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
@@ -140,9 +241,6 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     AspeedINTCState *s = ASPEED_INTC(opaque);
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     uint32_t addr = offset >> 2;
-    uint32_t old_enable;
-    uint32_t change;
-    uint32_t irq;
 
     if (offset >= aic->reg_size) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -163,45 +261,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     case R_GICINT134_EN:
     case R_GICINT135_EN:
     case R_GICINT136_EN:
-        irq = (offset & 0x0f00) >> 8;
-
-        if (irq >= aic->num_ints) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
-                          __func__, irq);
-            return;
-        }
-
-        /*
-         * These registers are used for enable sources interrupt and
-         * mask and unmask source interrupt while executing source ISR.
-         */
-
-        /* disable all source interrupt */
-        if (!data && !s->enable[irq]) {
-            s->regs[addr] = data;
-            return;
-        }
-
-        old_enable = s->enable[irq];
-        s->enable[irq] |= data;
-
-        /* enable new source interrupt */
-        if (old_enable != s->enable[irq]) {
-            trace_aspeed_intc_enable(s->enable[irq]);
-            s->regs[addr] = data;
-            return;
-        }
-
-        /* mask and unmask source interrupt */
-        change = s->regs[addr] ^ data;
-        if (change & data) {
-            s->mask[irq] &= ~change;
-            trace_aspeed_intc_unmask(change, s->mask[irq]);
-        } else {
-            s->mask[irq] |= change;
-            trace_aspeed_intc_mask(change, s->mask[irq]);
-        }
-        s->regs[addr] = data;
+        aspeed_intc_enable_handler(s, offset, data);
         break;
     case R_GICINT128_STATUS:
     case R_GICINT129_STATUS:
@@ -212,46 +272,7 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     case R_GICINT134_STATUS:
     case R_GICINT135_STATUS:
     case R_GICINT136_STATUS:
-        irq = (offset & 0x0f00) >> 8;
-
-        if (irq >= aic->num_ints) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
-                          __func__, irq);
-            return;
-        }
-
-        /* clear status */
-        s->regs[addr] &= ~data;
-
-        /*
-         * These status registers are used for notify sources ISR are executed.
-         * If one source ISR is executed, it will clear one bit.
-         * If it clear all bits, it means to initialize this register status
-         * rather than sources ISR are executed.
-         */
-        if (data == 0xffffffff) {
-            return;
-        }
-
-        /* All source ISR execution are done */
-        if (!s->regs[addr]) {
-            trace_aspeed_intc_all_isr_done(irq);
-            if (s->pending[irq]) {
-                /*
-                 * handle pending source interrupt
-                 * notify firmware which source interrupt are pending
-                 * by setting status register
-                 */
-                s->regs[addr] = s->pending[irq];
-                s->pending[irq] = 0;
-                trace_aspeed_intc_trigger_irq(irq, s->regs[addr]);
-                aspeed_intc_update(s, irq, 1);
-            } else {
-                /* clear irq */
-                trace_aspeed_intc_clear_irq(irq, 0);
-                aspeed_intc_update(s, irq, 0);
-            }
-        }
+        aspeed_intc_status_handler(s, offset, data);
         break;
     default:
         s->regs[addr] = data;
-- 
2.34.1


