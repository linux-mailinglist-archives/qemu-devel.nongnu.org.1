Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCC726A54
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 22:02:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6zLa-0005EN-A3; Wed, 07 Jun 2023 16:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6zLX-0005EE-7p
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:01:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q6zLU-0007K5-WD
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 16:01:30 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DB8FF74638A;
 Wed,  7 Jun 2023 22:01:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A9988746377; Wed,  7 Jun 2023 22:01:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2] hw/acpi: Fix PM control register access
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20230607200125.A9988746377@zero.eik.bme.hu>
Date: Wed,  7 Jun 2023 22:01:25 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On pegasos2 which has ACPI as part of VT8231 south bridge the board
firmware writes PM control register by accessing the second byte so
addr will be 1. This wasn't handled correctly and the write went to
addr 0 instead. Remove the acpi_pm1_cnt_write() function which is used
only once and does not take addr into account and handle non-zero
address in acpi_pm_cnt_{read|write}. This fixes ACPI shutdown with
pegasos2 firmware.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/acpi/core.c | 52 +++++++++++++++++++++++++-------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 6da275c599..00b1e79a30 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -551,30 +551,6 @@ void acpi_pm_tmr_reset(ACPIREGS *ar)
 }
 
 /* ACPI PM1aCNT */
-static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
-{
-    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
-
-    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
-        /* change suspend type */
-        uint16_t sus_typ = (val >> 10) & 7;
-        switch (sus_typ) {
-        case 0: /* soft power off */
-            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-            break;
-        case 1:
-            qemu_system_suspend_request();
-            break;
-        default:
-            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
-                qapi_event_send_suspend_disk();
-                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
-            }
-            break;
-        }
-    }
-}
-
 void acpi_pm1_cnt_update(ACPIREGS *ar,
                          bool sci_enable, bool sci_disable)
 {
@@ -593,13 +569,37 @@ void acpi_pm1_cnt_update(ACPIREGS *ar,
 static uint64_t acpi_pm_cnt_read(void *opaque, hwaddr addr, unsigned width)
 {
     ACPIREGS *ar = opaque;
-    return ar->pm1.cnt.cnt;
+    return ar->pm1.cnt.cnt >> addr * 8;
 }
 
 static void acpi_pm_cnt_write(void *opaque, hwaddr addr, uint64_t val,
                               unsigned width)
 {
-    acpi_pm1_cnt_write(opaque, val);
+    ACPIREGS *ar = opaque;
+
+    if (addr == 1) {
+        val = val << 8 | (ar->pm1.cnt.cnt & 0xff);
+    }
+    ar->pm1.cnt.cnt = val & ~(ACPI_BITMASK_SLEEP_ENABLE);
+
+    if (val & ACPI_BITMASK_SLEEP_ENABLE) {
+        /* change suspend type */
+        uint16_t sus_typ = (val >> 10) & 7;
+        switch (sus_typ) {
+        case 0: /* soft power off */
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            break;
+        case 1:
+            qemu_system_suspend_request();
+            break;
+        default:
+            if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
+                qapi_event_send_suspend_disk();
+                qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+            }
+            break;
+        }
+    }
 }
 
 static const MemoryRegionOps acpi_pm_cnt_ops = {
-- 
2.30.9


