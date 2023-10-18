Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACE97CE27C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:14:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wv-0001JZ-U2; Wed, 18 Oct 2023 11:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wS-0000v4-5X
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wP-0007Qw-9a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pkIPSukbn4TdWmXR29nNf5zPEIsdHpMleShz6bahFgE=;
 b=SQz0KrkPXySTFHJ6nCuDXkN5JQjHJgjnv07l1rZbBI1GU9h0qx0hQSKLfdiKmHwLH4M8Qe
 GGv/ruGhmklJDE5LQk50Ol2V9pcroz8v47CtndjUt0gcoOSEFcheB6PDPu5F5Eq9+XrXDa
 L5JP7QSH/gDiHUx3oNqsBbFoenX7FhM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-UqEsPSGsM1iQNFd-3nD8eg-1; Wed, 18 Oct 2023 11:58:35 -0400
X-MC-Unique: UqEsPSGsM1iQNFd-3nD8eg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2c520e0a9a7so34453721fa.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644713; x=1698249513;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pkIPSukbn4TdWmXR29nNf5zPEIsdHpMleShz6bahFgE=;
 b=pEkzS9TtrF631rDg7tYESApcKq6v/jFxS9l6sLFfsJTIMLJroILIvvs582dzZo9+C/
 rhErR4NFMEnQJKaNR6oJH3TKwKRCP/BilzEO1ZMxLN+KqEf1ARr8Q5RTizww06VF1hDg
 Hv9KpUOVqHxUOqjeCn8TzXILBrRKp2U2UPtNQuW86FTA9fGe1Uro2Derb4VKRy6aNCjR
 qab7mDD6S/IZMKhq8iQM8c44yc2XAZ8nV/9zsUihAzFjo9ldwOG+NLF0xTKsphalCVwS
 +xei4kazfjr2+w9x7/UTbqoZAdRZhnNvR73SJ1pnZKiM9Ake5C0hDOtzhpbLIQNoDBqp
 mf+A==
X-Gm-Message-State: AOJu0YxCBljEwrx3HFDc0tIEo2zsxEhPcvkYlhqFWSLMQGld/LYAzYtN
 vhCz6p3KUbPk4UO4IVmzE/0r7ZxDZC+2JywUxP0cvViI3CZ1Dn+y9jOQ4HE64ynBqapaXiAVtrG
 1gCnRgh1NCW0fz23Nac1yb+KghK7WTS0jM24tKFicpabrlSxDomy0a8uCYqpFA8rK1nFfYK4=
X-Received: by 2002:a2e:b947:0:b0:2c5:1d9a:4dc1 with SMTP id
 7-20020a2eb947000000b002c51d9a4dc1mr3661412ljs.5.1697644712855; 
 Wed, 18 Oct 2023 08:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDk/cbvZR/KH4ofghBr4bnrN+oC9nqeHHs97qv5WsIlYUFeEDnau5RjnUwLc6WfIv4Ekp1aQ==
X-Received: by 2002:a2e:b947:0:b0:2c5:1d9a:4dc1 with SMTP id
 7-20020a2eb947000000b002c51d9a4dc1mr3661394ljs.5.1697644712509; 
 Wed, 18 Oct 2023 08:58:32 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b004076f522058sm2001741wme.0.2023.10.18.08.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:32 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 67/83] hw/isa/piix: Rename functions to be shared for PCI
 interrupt triggering
Message-ID: <698f428a3c024c4e2352d0efb2e96e3129b817c7.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

PIIX4 will get the same optimizations which are already implemented for
PIIX3.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-26-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


