Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A47F95E7
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 23:51:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Nwa-0002f7-82; Sun, 26 Nov 2023 17:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwX-0002er-6g
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:37 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r7NwV-0002PZ-00
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 17:49:36 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E35DC75A4BC;
 Sun, 26 Nov 2023 23:49:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D66F575A406; Sun, 26 Nov 2023 23:49:29 +0100 (CET)
Message-Id: <1c3902d4166234bef0a476026441eaac3dd6cda5.1701035944.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1701035944.git.balaton@eik.bme.hu>
References: <cover.1701035944.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 1/4] hw/isa/vt82c686: Bring back via_isa_set_irq()
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, vr_qemu@t-online.de
Date: Sun, 26 Nov 2023 23:49:29 +0100 (CET)
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

The VIA integrated south bridge chips combine several functions and
allow routing their interrupts to any of the ISA IRQs also allowing
multiple sources to share the same ISA IRQ. E.g. pegasos2 firmware
configures everything to use IRQ 9 but amigaone routes them to
separate ISA IRQs so the current simplified routing does not work.
Bring back via_isa_set_irq() and change it to take the component that
wants to change an IRQ and keep track of interrupt status of each
source separately and do the mapping to ISA IRQ within the ISA bridge.

This may not handle cases when an ISA IRQ is controlled by devices
directly, not going through via_isa_set_irq() such as serial, parallel
or keyboard but these IRQs being conventionally fixed are not likely
to be change by guests or share with other devices so this does not
cause a problem in practice.

This reverts commit 4e5a20b6da9b1f6d2e9621ed7eb8b239560104ae.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c         | 41 +++++++++++++++++++++++++++++++++++++++
 include/hw/isa/vt82c686.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..6fad8293e6 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -549,6 +549,7 @@ struct ViaISAState {
     PCIDevice dev;
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
+    uint16_t irq_state[ISA_NUM_IRQS];
     ViaSuperIOState via_sio;
     MC146818RtcState rtc;
     PCIIDEState ide;
@@ -592,6 +593,46 @@ static const TypeInfo via_isa_info = {
     },
 };
 
+void via_isa_set_irq(PCIDevice *d, int pin, int level)
+{
+    ViaISAState *s = VIA_ISA(pci_get_function_0(d));
+    uint8_t irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
+    int f = PCI_FUNC(d->devfn);
+    uint16_t mask = BIT(f);
+
+    switch (f) {
+    case 2: /* USB ports 0-1 */
+    case 3: /* USB ports 2-3 */
+        max_irq = 14;
+        break;
+    }
+
+    /* Keep track of the state of all sources */
+    if (level) {
+        s->irq_state[0] |= mask;
+    } else {
+        s->irq_state[0] &= ~mask;
+    }
+    if (irq == 0 || irq == 0xff) {
+        return; /* disabled */
+    }
+    if (unlikely(irq > max_irq || irq == 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid ISA IRQ routing %d for %d",
+                      irq, f);
+        return;
+    }
+    /* Record source state at mapped IRQ */
+    if (level) {
+        s->irq_state[irq] |= mask;
+    } else {
+        s->irq_state[irq] &= ~mask;
+    }
+    /* Make sure there are no stuck bits if mapping has changed */
+    s->irq_state[irq] &= s->irq_state[0];
+    /* ISA IRQ level is the OR of all sources routed to it */
+    qemu_set_irq(s->isa_irqs_in[irq], !!s->irq_state[irq]);
+}
+
 static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
diff --git a/include/hw/isa/vt82c686.h b/include/hw/isa/vt82c686.h
index b6e95b2851..da1722daf2 100644
--- a/include/hw/isa/vt82c686.h
+++ b/include/hw/isa/vt82c686.h
@@ -34,4 +34,6 @@ struct ViaAC97State {
     uint32_t ac97_cmd;
 };
 
+void via_isa_set_irq(PCIDevice *d, int n, int level);
+
 #endif
-- 
2.30.9


