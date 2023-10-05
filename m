Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA5A7BA8F0
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 20:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSwQ-0003Yx-Ar; Thu, 05 Oct 2023 14:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoSw6-00039e-9P
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:19:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qoSw4-0006s9-6C
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 14:18:58 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4F6B8757234;
 Thu,  5 Oct 2023 20:18:10 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 1867E757233; Thu,  5 Oct 2023 20:18:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
CC: Bernhard Beschow <shentey@gmail.com>, jiaxun.yang@flygoat.com,
 philmd@linaro.org
Subject: [PATCH v4] hw/isa/vt82c686: Respect SCI interrupt assignment
Message-Id: <20231005181810.1867E757233@zero.eik.bme.hu>
Date: Thu,  5 Oct 2023 20:18:10 +0200 (CEST)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the datasheet, SCI interrupts of the power management
function aren't routed through the PCI pins but rather directly to the
integrated PIC. The routing is configurable through the ACPI interrupt
select register at offset 0x42 in the PCI configuration space of the
power management function.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Alternative proposal to Bernhard's patch to remove FIXME about SCI.

Apply this on top of reverting commit 4e5a20b6da9 which could also be
squashed in this patch but I let you decide if you want that as
separete commit or part of this. I did not test this beyond compiling
but I think this is all there is to it. (Overusing QOM within a chip
model does not make sense as QOM is meant to allow users to introspect
and configure device models and combine different models into new
machines eventually without modifying QEMU but this is not applicable
here within a single device model that can be considered as friend
classes so don't go oveboard with it when not needed.)

 hw/isa/vt82c686.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8016c71315..2eb769c7fa 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -140,25 +140,21 @@ static const MemoryRegionOps pm_io_ops = {
 
 static void pm_update_sci(ViaPMState *s)
 {
-    int sci_level, pmsts;
+    int sci_irq, pmsts;
 
     pmsts = acpi_pm1_evt_get_sts(&s->ar);
-    sci_level = (((pmsts & s->ar.pm1.evt.en) &
-                  (ACPI_BITMASK_RT_CLOCK_ENABLE |
-                   ACPI_BITMASK_POWER_BUTTON_ENABLE |
-                   ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
-                   ACPI_BITMASK_TIMER_ENABLE)) != 0);
-    if (pci_get_byte(s->dev.config + PCI_INTERRUPT_PIN)) {
-        /*
-         * FIXME:
-         * Fix device model that realizes this PM device and remove
-         * this work around.
-         * The device model should wire SCI and setup
-         * PCI_INTERRUPT_PIN properly.
-         * If PIN# = 0(interrupt pin isn't used), don't raise SCI as
-         * work around.
-         */
-        pci_set_irq(&s->dev, sci_level);
+    sci_irq = pci_get_byte(s->dev.config + 0x42) & 0xf;
+    if (sci_irq) {
+        int sci_level = (((pmsts & s->ar.pm1.evt.en) &
+                          (ACPI_BITMASK_RT_CLOCK_ENABLE |
+                              ACPI_BITMASK_POWER_BUTTON_ENABLE |
+                              ACPI_BITMASK_GLOBAL_LOCK_ENABLE |
+                              ACPI_BITMASK_TIMER_ENABLE)) != 0);
+
+        if (sci_irq == 2) {
+            qemu_log_mask(LOG_GUEST_ERROR, "IRQ 2 for VIA PM SCI is reserved");
+        }
+        via_isa_set_irq(pci_get_function_0(&s->dev), sci_irq, sci_level);
     }
     /* schedule a timer interruption if needed */
     acpi_pm_tmr_update(&s->ar, (s->ar.pm1.evt.en & ACPI_BITMASK_TIMER_ENABLE) &&
-- 
2.30.9


