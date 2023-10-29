Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE3A7DAC0E
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 12:08:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qx3ds-0007X7-G7; Sun, 29 Oct 2023 07:07:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx3do-0007Oc-Tn
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:07:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qx3dk-0000IL-UF
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 07:07:36 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4E8F1756072;
 Sun, 29 Oct 2023 12:07:35 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26C447456A7; Sun, 29 Oct 2023 12:07:35 +0100 (CET)
Message-Id: <418bad646fd2c7f667d580c5abc745b7cd0f717f.1698577151.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698577151.git.balaton@eik.bme.hu>
References: <cover.1698577151.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 3/4] hw/isa/vt82c686: Route PIRQ inputs using
 via_isa_set_irq()
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bernhard Beschow <shentey@gmail.com>, vr_qemu@t-online.de
Date: Sun, 29 Oct 2023 12:07:35 +0100 (CET)
X-Spam-Probability: 8%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

The chip has 4 pins (called PIRQA-D in VT82C686B and PINTA-D in
VT8231) that are meant to be connected to PCI IRQ lines and allow
routing PCI interrupts to the ISA PIC. Route these in
via_isa_set_irq() to make it possible to share them with internal
functions that can also be routed to the same ISA IRQs.

Fixes: 2fdadd02e675caca4aba4ae26317701fe2c4c901
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/isa/vt82c686.c | 65 +++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 41 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index c1826c77eb..c44bfeeab0 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -593,6 +593,21 @@ static const TypeInfo via_isa_info = {
     },
 };
 
+static int via_isa_get_pci_irq(const ViaISAState *s, int pin)
+{
+    switch (pin) {
+    case 0:
+        return s->dev.config[0x55] >> 4;
+    case 1:
+        return s->dev.config[0x56] & 0xf;
+    case 2:
+        return s->dev.config[0x56] >> 4;
+    case 3:
+        return s->dev.config[0x57] >> 4;
+    }
+    return 0;
+}
+
 void via_isa_set_irq(PCIDevice *d, int pin, int level)
 {
     ViaISAState *s = VIA_ISA(pci_get_function_0(d));
@@ -600,6 +615,10 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     uint8_t isa_irq = d->config[PCI_INTERRUPT_LINE], max_irq = 15;
 
     switch (n) {
+    case 0: /* PIRQ/PINT inputs */
+        isa_irq = via_isa_get_pci_irq(s, pin);
+        n = 12 + pin;
+        break;
     case 2: /* USB ports 0-1 */
     case 3: /* USB ports 2-3 */
         max_irq = 14;
@@ -631,50 +650,15 @@ void via_isa_set_irq(PCIDevice *d, int pin, int level)
     qemu_set_irq(s->isa_irqs_in[isa_irq], !!s->isa_irq_state[isa_irq]);
 }
 
-static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
-{
-    ViaISAState *s = opaque;
-    qemu_set_irq(s->cpu_intr, level);
-}
-
-static int via_isa_get_pci_irq(const ViaISAState *s, int irq_num)
+static void via_isa_pirq(void *opaque, int pin, int level)
 {
-    switch (irq_num) {
-    case 0:
-        return s->dev.config[0x55] >> 4;
-    case 1:
-        return s->dev.config[0x56] & 0xf;
-    case 2:
-        return s->dev.config[0x56] >> 4;
-    case 3:
-        return s->dev.config[0x57] >> 4;
-    }
-    return 0;
+    via_isa_set_irq(opaque, pin, level);
 }
 
-static void via_isa_set_pci_irq(void *opaque, int irq_num, int level)
+static void via_isa_request_i8259_irq(void *opaque, int irq, int level)
 {
     ViaISAState *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-    int i, pic_level, pic_irq = via_isa_get_pci_irq(s, irq_num);
-
-    /* IRQ 0: disabled, IRQ 2,8,13: reserved */
-    if (!pic_irq) {
-        return;
-    }
-    if (unlikely(pic_irq == 2 || pic_irq == 8 || pic_irq == 13)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "Invalid ISA IRQ routing");
-    }
-
-    /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-    pic_level = 0;
-    for (i = 0; i < PCI_NUM_PINS; i++) {
-        if (pic_irq == via_isa_get_pci_irq(s, i)) {
-            pic_level |= pci_bus_get_irq_level(bus, i);
-        }
-    }
-    /* Now we change the pic irq level according to the via irq mappings. */
-    qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
+    qemu_set_irq(s->cpu_intr, level);
 }
 
 static void via_isa_realize(PCIDevice *d, Error **errp)
@@ -687,6 +671,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     int i;
 
     qdev_init_gpio_out(dev, &s->cpu_intr, 1);
+    qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
                           errp);
@@ -700,8 +685,6 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     i8254_pit_init(isa_bus, 0x40, 0, NULL);
     i8257_dma_init(isa_bus, 0);
 
-    qdev_init_gpio_in_named(dev, via_isa_set_pci_irq, "pirq", PCI_NUM_PINS);
-
     /* RTC */
     qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
     if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
-- 
2.30.9


