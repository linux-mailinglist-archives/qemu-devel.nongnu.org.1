Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 760CE7BC7A7
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:41:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ao-0003XG-0n; Sat, 07 Oct 2023 08:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ac-000376-H7
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aZ-0002pz-Ag
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso529254966b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682361; x=1697287161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rSlWSEQUX29be5fzjZVPtmw+vniPsPYpAwzb3hQ5A2U=;
 b=V7jQB3tikwW5SXI3R0zzZ70XCI189B5wMVjnN3FsKG++8tzghGcmxF7puGc2acFMop
 gG4FCyCE7+TO/LHToYVtHJ/O+gAjRLL6omwCmJGw7bIt7O7d3XoHm0qi31YDavdDSz93
 1Q5rFSwLbz4KLGkL4z3CldNMj4vObjiXMDqiydsS4Djz7HtmsREEeBRTlsMD/v0OQoUI
 Q4sF0IB4D3V+ltmCYvZEFAhg2lSEzym9HrOPgDUxIDWuild9HqjJ1wYNZ7tW78+bCfFU
 ZjXYwRC2hUcFi8uNAJnKd3cjHybkinWCQE1Sc4jtgIhk6yGqjlEaHyQlRxTvM8ARSBte
 IBWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682361; x=1697287161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rSlWSEQUX29be5fzjZVPtmw+vniPsPYpAwzb3hQ5A2U=;
 b=H5cINB7SzH9IdhATRsTa0ZPV/tCnGfcf8vjIEGvXo56e02CjymzoHGaGOE+QWHZzAm
 PU09k6IsROnPc7dg0qEx7/bYE4pZ6VMUEtG23RscxK9NQt50YHQPEFbhplNCpAAiviCf
 2dVCCBKBcPy5lrciJsD7nIEyEyfFNnRfn6K/kMGn0cqXthXXL2faOZVmsFyJHt+6BozV
 JB8PQ2rZ6xwoe+VTDYNYvTRqJEenmRwyQJGELV65RJLuUcFqJooxLGgrY8tlRwWh4wIg
 O5PBqU+WCdhlXQb52Uw7VDO5ZOFHE3p2fvG7JU2QseEPu0swG7oRcbi05QtD12BOjl3p
 xBKg==
X-Gm-Message-State: AOJu0Yzgd3IQEumO3IhPdqw984UIwDxIsWv+XY5GoSKU2Kr3orLuaePw
 +R8DydgcZGjBuMKSmorwfl6kk5N2h2A=
X-Google-Smtp-Source: AGHT+IEzsYbCvnLx6mB4aVeRJ+XunhCSN8TULbP7cdO+5Ugiw5mNh5Z1PkT9XM7fp36gh+14+kQ0zA==
X-Received: by 2002:a17:906:5306:b0:9ae:51c8:ded1 with SMTP id
 h6-20020a170906530600b009ae51c8ded1mr8543962ejo.50.1696682361445; 
 Sat, 07 Oct 2023 05:39:21 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:20 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Chuck Zmudzinski <brchuckz@aol.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v8 25/29] hw/isa/piix: Rename functions to be shared for PCI
 interrupt triggering
Date: Sat,  7 Oct 2023 14:38:33 +0200
Message-ID: <20231007123843.127151-26-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PIIX4 will get the same optimizations which are already implemented for
PIIX3.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 72 +++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 2ab799b95e..449c1baaab 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -38,47 +38,47 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-static void piix3_set_irq_pic(PIIXState *piix3, int pic_irq)
+static void piix_set_irq_pic(PIIXState *s, int pic_irq)
 {
-    qemu_set_irq(piix3->isa_irqs_in[pic_irq],
-                 !!(piix3->pic_levels &
+    qemu_set_irq(s->isa_irqs_in[pic_irq],
+                 !!(s->pic_levels &
                     (((1ULL << PIIX_NUM_PIRQS) - 1) <<
                      (pic_irq * PIIX_NUM_PIRQS))));
 }
 
-static void piix3_set_irq_level_internal(PIIXState *piix3, int pirq, int level)
+static void piix_set_pci_irq_level_internal(PIIXState *s, int pirq, int level)
 {
     int pic_irq;
     uint64_t mask;
 
-    pic_irq = piix3->dev.config[PIIX_PIRQCA + pirq];
+    pic_irq = s->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >= ISA_NUM_IRQS) {
         return;
     }
 
     mask = 1ULL << ((pic_irq * PIIX_NUM_PIRQS) + pirq);
-    piix3->pic_levels &= ~mask;
-    piix3->pic_levels |= mask * !!level;
+    s->pic_levels &= ~mask;
+    s->pic_levels |= mask * !!level;
 }
 
-static void piix3_set_irq_level(PIIXState *piix3, int pirq, int level)
+static void piix_set_pci_irq_level(PIIXState *s, int pirq, int level)
 {
     int pic_irq;
 
-    pic_irq = piix3->dev.config[PIIX_PIRQCA + pirq];
+    pic_irq = s->dev.config[PIIX_PIRQCA + pirq];
     if (pic_irq >= ISA_NUM_IRQS) {
         return;
     }
 
-    piix3_set_irq_level_internal(piix3, pirq, level);
+    piix_set_pci_irq_level_internal(s, pirq, level);
 
-    piix3_set_irq_pic(piix3, pic_irq);
+    piix_set_irq_pic(s, pic_irq);
 }
 
-static void piix3_set_irq(void *opaque, int pirq, int level)
+static void piix_set_pci_irq(void *opaque, int pirq, int level)
 {
-    PIIXState *piix3 = opaque;
-    piix3_set_irq_level(piix3, pirq, level);
+    PIIXState *s = opaque;
+    piix_set_pci_irq_level(s, pirq, level);
 }
 
 static void piix4_set_irq(void *opaque, int irq_num, int level)
@@ -108,10 +108,10 @@ static void piix_request_i8259_irq(void *opaque, int irq, int level)
     qemu_set_irq(s->cpu_intr, level);
 }
 
-static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
+static PCIINTxRoute piix_route_intx_pin_to_irq(void *opaque, int pin)
 {
-    PIIXState *piix3 = opaque;
-    int irq = piix3->dev.config[PIIX_PIRQCA + pin];
+    PCIDevice *pci_dev = opaque;
+    int irq = pci_dev->config[PIIX_PIRQCA + pin];
     PCIINTxRoute route;
 
     if (irq < ISA_NUM_IRQS) {
@@ -125,29 +125,29 @@ static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 }
 
 /* irq routing is changed. so rebuild bitmap */
-static void piix3_update_irq_levels(PIIXState *piix3)
+static void piix_update_pci_irq_levels(PIIXState *s)
 {
-    PCIBus *bus = pci_get_bus(&piix3->dev);
+    PCIBus *bus = pci_get_bus(&s->dev);
     int pirq;
 
-    piix3->pic_levels = 0;
+    s->pic_levels = 0;
     for (pirq = 0; pirq < PIIX_NUM_PIRQS; pirq++) {
-        piix3_set_irq_level(piix3, pirq, pci_bus_get_irq_level(bus, pirq));
+        piix_set_pci_irq_level(s, pirq, pci_bus_get_irq_level(bus, pirq));
     }
 }
 
-static void piix3_write_config(PCIDevice *dev,
-                               uint32_t address, uint32_t val, int len)
+static void piix_write_config(PCIDevice *dev, uint32_t address, uint32_t val,
+                              int len)
 {
     pci_default_write_config(dev, address, val, len);
     if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
-        PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
+        PIIXState *s = PIIX_PCI_DEVICE(dev);
         int pic_irq;
 
-        pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
-        piix3_update_irq_levels(piix3);
+        pci_bus_fire_intx_routing_notifier(pci_get_bus(&s->dev));
+        piix_update_pci_irq_levels(s);
         for (pic_irq = 0; pic_irq < ISA_NUM_IRQS; pic_irq++) {
-            piix3_set_irq_pic(piix3, pic_irq);
+            piix_set_irq_pic(s, pic_irq);
         }
     }
 }
@@ -193,9 +193,9 @@ static void piix_reset(DeviceState *dev)
     d->rcr = 0;
 }
 
-static int piix3_post_load(void *opaque, int version_id)
+static int piix_post_load(void *opaque, int version_id)
 {
-    PIIXState *piix3 = opaque;
+    PIIXState *s = opaque;
     int pirq;
 
     /*
@@ -207,10 +207,10 @@ static int piix3_post_load(void *opaque, int version_id)
      * Here, we update irq levels without raising the interrupt.
      * Interrupt state will be deserialized separately through the i8259.
      */
-    piix3->pic_levels = 0;
+    s->pic_levels = 0;
     for (pirq = 0; pirq < PIIX_NUM_PIRQS; pirq++) {
-        piix3_set_irq_level_internal(piix3, pirq,
-            pci_bus_get_irq_level(pci_get_bus(&piix3->dev), pirq));
+        piix_set_pci_irq_level_internal(s, pirq,
+            pci_bus_get_irq_level(pci_get_bus(&s->dev), pirq));
     }
     return 0;
 }
@@ -261,7 +261,7 @@ static const VMStateDescription vmstate_piix3 = {
     .name = "PIIX3",
     .version_id = 3,
     .minimum_version_id = 2,
-    .post_load = piix3_post_load,
+    .post_load = piix_post_load,
     .pre_save = piix3_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, PIIXState),
@@ -481,8 +481,8 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
         return;
     }
 
-    pci_bus_irqs(pci_bus, piix3_set_irq, piix3, PIIX_NUM_PIRQS);
-    pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
+    pci_bus_irqs(pci_bus, piix_set_pci_irq, piix3, PIIX_NUM_PIRQS);
+    pci_bus_set_route_irq_fn(pci_bus, piix_route_intx_pin_to_irq);
 }
 
 static void piix3_init(Object *obj)
@@ -497,7 +497,7 @@ static void piix3_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->config_write = piix3_write_config;
+    k->config_write = piix_write_config;
     k->realize = piix3_realize;
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
-- 
2.42.0


