Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B32807DAA39
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 01:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwtAJ-0007c3-Vs; Sat, 28 Oct 2023 19:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAH-0007aj-Bd
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qwtAE-0006JS-P7
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 19:56:25 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3C8BF756088;
 Sun, 29 Oct 2023 01:56:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 08C59756082; Sun, 29 Oct 2023 01:56:23 +0200 (CEST)
Message-Id: <4fac19bc5b9c1e9e98fefc0467ba1ef1d5baee16.1698536342.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698536342.git.balaton@eik.bme.hu>
References: <cover.1698536342.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/4] hw/isa/vt82c686: Bring back via_isa_set_irq()
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Date: Sun, 29 Oct 2023 01:56:23 +0200 (CEST)
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

The VIA intergrated south bridge chips combine several functions and
allow routing their interrupts to any of the ISA IRQs (also allowing
multiple components to share the same ISA IRQ, e.g. pegasos2 firmware
configures USB, sound and PCI to use IRQ 9). Bring back
via_isa_set_irq() that takes the component that wants to change an IRQ
and keeps track of interrupt status of each source separately and does
the mapping to ISA IRQ within the ISA bridge to allow different
sources to control the same ISA IRQ lines.

This may not handle cases when the ISA IRQ is also controlled by
devices directly, not going through via_isa_set_irq() such as serial,
parallel or keyboard but these IRQs being conventionally fixed are not
likely for guests to change or share with other devices so hopefully
this does not cause a problem in practice.

This reverts commit 4e5a20b6da9b1f6d2e9621ed7eb8b239560104ae.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c         | 31 +++++++++++++++++++++++++++++++
 include/hw/isa/vt82c686.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 57bdfb4e78..07ae8d73bc 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -549,6 +549,7 @@ struct ViaISAState {
     PCIDevice dev;
     qemu_irq cpu_intr;
     qemu_irq *isa_irqs_in;
+    uint16_t isa_irq_state[ISA_NUM_IRQS];
     ViaSuperIOState via_sio;
     MC146818RtcState rtc;
     PCIIDEState ide;
@@ -592,6 +593,36 @@ static const TypeInfo via_isa_info = {
     },
 };
 
+void via_isa_set_irq(PCIDevice *d, int pin, int level)
+{
+    ViaISAState *s = VIA_ISA(pci_get_function_0(d));
+    int n = PCI_FUNC(d->devfn);
+    uint8_t isa_irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
+
+    switch (n) {
+    case 2: /* USB ports 0-1 */
+    case 3: /* USB ports 2-3 */
+        max_irq = 14;
+        break;
+    }
+
+    if (unlikely(isa_irq > max_irq || isa_irq == 2)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid ISA IRQ routing %d for %d",
+                      isa_irq, n);
+        return;
+    }
+    if (!isa_irq) {
+        return;
+    }
+
+    if (level) {
+        s->isa_irq_state[isa_irq] |= BIT(n);
+    } else {
+        s->isa_irq_state[isa_irq] &= ~BIT(n);
+    }
+    qemu_set_irq(s->isa_irqs_in[isa_irq], !!s->isa_irq_state[isa_irq]);
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


