Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7997D222D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhJ-00032v-Fq; Sun, 22 Oct 2023 05:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhH-0002vc-Fr
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhF-0000ao-In
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8ZNVaGsAOPPhl+5mNLWULAc38++TrKNMAMlYSymFqYg=;
 b=DaxhCWv7I+Tt/FW12NWNfB1YN1iWdseg8nvQJ/Mwzm5z2+IUUDQ0hcrTk7Puarx2Kj+IxI
 M510nIq8pH4G8PJJCCaz57dHGe/vOZKMfvzEbet/ueTWOYZ1cBrGLOMpechyBwYAiffJ1g
 JP8Nhza2CzeND2TF89NYeytkKxhvjEM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-v1FLpo-8MsCgxZmXfUMpmw-1; Sun, 22 Oct 2023 05:24:31 -0400
X-MC-Unique: v1FLpo-8MsCgxZmXfUMpmw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507a3426041so2412204e87.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966669; x=1698571469;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ZNVaGsAOPPhl+5mNLWULAc38++TrKNMAMlYSymFqYg=;
 b=LUy3WO3eYOkSAkW0goGoCBqyQ9ipCqkKcdVBPXh2M95H/aHtWNdmQZBLwSqq4iYHVf
 sOELyw6ZxYfkXuy9eXC7Uir/KzGt9IqQdX7vMKCv//t0pnZ4Ak74S05JdOn7ExBYKyhV
 Wz28YwA+s7aESasdnUEU60j0PLqvC4J8ebOJ9UEW3CtrKPCAeVdjTMbPdebg4k08SRrn
 3wsbcx/5OKNVcWuHSqYeE2zVsLN9uE97wfDOwBQNOlY0sA0NmkIzYbQ8VA/m76NVTRrH
 QFJG2Q8fVXLCjFrvFCa+/SRjQnlqQWJrpSFcqHY8dt1Xfws4g41xpB/qb9P7hTJQ6wdw
 +YCg==
X-Gm-Message-State: AOJu0YxktZXZ0Fv2otTVU4E+BBHBFmSm0wgL3EXXBCGGx9UHbK8igeEZ
 7YIyecLO+Yagj0HftXyjC1okrmazFO/r7BiAnWWpANL2QyT6Kg5T3ma/C9NAChn+WpWMm/Navbu
 +SLs+oRuD4q++pOzRSIkQq3qZB6uF6vdAzkR6UTNvQ6iiBY0R3zWKcXyMUIoc0y2j05me
X-Received: by 2002:a2e:a788:0:b0:2c5:996:9e28 with SMTP id
 c8-20020a2ea788000000b002c509969e28mr5189958ljf.19.1697966669463; 
 Sun, 22 Oct 2023 02:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0zoayRIA+PQeX7gi0lwyEyP4+80P6uFh6IJ4thbcY0m1jwtbs16qbzXGSi6sBugD6WD41tA==
X-Received: by 2002:a2e:a788:0:b0:2c5:996:9e28 with SMTP id
 c8-20020a2ea788000000b002c509969e28mr5189946ljf.19.1697966669116; 
 Sun, 22 Oct 2023 02:24:29 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 p17-20020a5d68d1000000b0032d687fd9d0sm5287489wrw.19.2023.10.22.02.24.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:28 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 35/62] hw/isa/piix3: Drop the "3" from PIIX base class name
Message-ID: <9769cfc3e419a704ff1d7feb4621da660903499a.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

TYPE_PIIX3_PCI_DEVICE was the former base class of the Xen and non-Xen variants
of the PIIX3 ISA device models. It will become the base class for the PIIX3 and
PIIX4 device models, so drop the "3" from the type names.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-15-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  6 ++--
 hw/isa/piix3.c                | 56 +++++++++++++++++------------------
 2 files changed, 30 insertions(+), 32 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index c56ce49fd3..0b257e1582 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -71,11 +71,9 @@ struct PIIXState {
     bool has_usb;
     bool smm_enabled;
 };
-typedef struct PIIXState PIIX3State;
 
-#define TYPE_PIIX3_PCI_DEVICE "pci-piix3"
-DECLARE_INSTANCE_CHECKER(PIIX3State, PIIX3_PCI_DEVICE,
-                         TYPE_PIIX3_PCI_DEVICE)
+#define TYPE_PIIX_PCI_DEVICE "pci-piix"
+OBJECT_DECLARE_SIMPLE_TYPE(PIIXState, PIIX_PCI_DEVICE)
 
 #define TYPE_PIIX3_DEVICE "PIIX3"
 #define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 5b867df299..c7e59249b6 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -35,7 +35,7 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
+static void piix3_set_irq_pic(PIIXState *piix3, int pic_irq)
 {
     qemu_set_irq(piix3->isa_irqs_in[pic_irq],
                  !!(piix3->pic_levels &
@@ -43,7 +43,7 @@ static void piix3_set_irq_pic(PIIX3State *piix3, int pic_irq)
                      (pic_irq * PIIX_NUM_PIRQS))));
 }
 
-static void piix3_set_irq_level_internal(PIIX3State *piix3, int pirq, int level)
+static void piix3_set_irq_level_internal(PIIXState *piix3, int pirq, int level)
 {
     int pic_irq;
     uint64_t mask;
@@ -58,7 +58,7 @@ static void piix3_set_irq_level_internal(PIIX3State *piix3, int pirq, int level)
     piix3->pic_levels |= mask * !!level;
 }
 
-static void piix3_set_irq_level(PIIX3State *piix3, int pirq, int level)
+static void piix3_set_irq_level(PIIXState *piix3, int pirq, int level)
 {
     int pic_irq;
 
@@ -74,13 +74,13 @@ static void piix3_set_irq_level(PIIX3State *piix3, int pirq, int level)
 
 static void piix3_set_irq(void *opaque, int pirq, int level)
 {
-    PIIX3State *piix3 = opaque;
+    PIIXState *piix3 = opaque;
     piix3_set_irq_level(piix3, pirq, level);
 }
 
 static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 {
-    PIIX3State *piix3 = opaque;
+    PIIXState *piix3 = opaque;
     int irq = piix3->dev.config[PIIX_PIRQCA + pin];
     PCIINTxRoute route;
 
@@ -95,7 +95,7 @@ static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 }
 
 /* irq routing is changed. so rebuild bitmap */
-static void piix3_update_irq_levels(PIIX3State *piix3)
+static void piix3_update_irq_levels(PIIXState *piix3)
 {
     PCIBus *bus = pci_get_bus(&piix3->dev);
     int pirq;
@@ -111,7 +111,7 @@ static void piix3_write_config(PCIDevice *dev,
 {
     pci_default_write_config(dev, address, val, len);
     if (ranges_overlap(address, len, PIIX_PIRQCA, 4)) {
-        PIIX3State *piix3 = PIIX3_PCI_DEVICE(dev);
+        PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
         int pic_irq;
 
         pci_bus_fire_intx_routing_notifier(pci_get_bus(&piix3->dev));
@@ -124,7 +124,7 @@ static void piix3_write_config(PCIDevice *dev,
 
 static void piix3_reset(DeviceState *dev)
 {
-    PIIX3State *d = PIIX3_PCI_DEVICE(dev);
+    PIIXState *d = PIIX_PCI_DEVICE(dev);
     uint8_t *pci_conf = d->dev.config;
 
     pci_conf[0x04] = 0x07; /* master, memory and I/O */
@@ -165,7 +165,7 @@ static void piix3_reset(DeviceState *dev)
 
 static int piix3_post_load(void *opaque, int version_id)
 {
-    PIIX3State *piix3 = opaque;
+    PIIXState *piix3 = opaque;
     int pirq;
 
     /*
@@ -188,7 +188,7 @@ static int piix3_post_load(void *opaque, int version_id)
 static int piix3_pre_save(void *opaque)
 {
     int i;
-    PIIX3State *piix3 = opaque;
+    PIIXState *piix3 = opaque;
 
     for (i = 0; i < ARRAY_SIZE(piix3->pci_irq_levels_vmstate); i++) {
         piix3->pci_irq_levels_vmstate[i] =
@@ -200,7 +200,7 @@ static int piix3_pre_save(void *opaque)
 
 static bool piix3_rcr_needed(void *opaque)
 {
-    PIIX3State *piix3 = opaque;
+    PIIXState *piix3 = opaque;
 
     return (piix3->rcr != 0);
 }
@@ -211,7 +211,7 @@ static const VMStateDescription vmstate_piix3_rcr = {
     .minimum_version_id = 1,
     .needed = piix3_rcr_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(rcr, PIIX3State),
+        VMSTATE_UINT8(rcr, PIIXState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -223,8 +223,8 @@ static const VMStateDescription vmstate_piix3 = {
     .post_load = piix3_post_load,
     .pre_save = piix3_pre_save,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PIIX3State),
-        VMSTATE_INT32_ARRAY_V(pci_irq_levels_vmstate, PIIX3State,
+        VMSTATE_PCI_DEVICE(dev, PIIXState),
+        VMSTATE_INT32_ARRAY_V(pci_irq_levels_vmstate, PIIXState,
                               PIIX_NUM_PIRQS, 3),
         VMSTATE_END_OF_LIST()
     },
@@ -237,7 +237,7 @@ static const VMStateDescription vmstate_piix3 = {
 
 static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned len)
 {
-    PIIX3State *d = opaque;
+    PIIXState *d = opaque;
 
     if (val & 4) {
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
@@ -248,7 +248,7 @@ static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned len)
 
 static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned len)
 {
-    PIIX3State *d = opaque;
+    PIIXState *d = opaque;
 
     return d->rcr;
 }
@@ -265,7 +265,7 @@ static const MemoryRegionOps rcr_ops = {
 
 static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 {
-    PIIX3State *d = PIIX3_PCI_DEVICE(dev);
+    PIIXState *d = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
     ISABus *isa_bus;
     uint32_t irq;
@@ -345,7 +345,7 @@ static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
 
 static void pci_piix3_init(Object *obj)
 {
-    PIIX3State *d = PIIX3_PCI_DEVICE(obj);
+    PIIXState *d = PIIX_PCI_DEVICE(obj);
 
     qdev_init_gpio_out_named(DEVICE(obj), d->isa_irqs_in, "isa-irqs",
                              ISA_NUM_IRQS);
@@ -355,10 +355,10 @@ static void pci_piix3_init(Object *obj)
 }
 
 static Property pci_piix3_props[] = {
-    DEFINE_PROP_UINT32("smb_io_base", PIIX3State, smb_io_base, 0),
-    DEFINE_PROP_BOOL("has-acpi", PIIX3State, has_acpi, true),
-    DEFINE_PROP_BOOL("has-usb", PIIX3State, has_usb, true),
-    DEFINE_PROP_BOOL("smm-enabled", PIIX3State, smm_enabled, false),
+    DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
+    DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
+    DEFINE_PROP_BOOL("has-usb", PIIXState, has_usb, true),
+    DEFINE_PROP_BOOL("smm-enabled", PIIXState, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -386,10 +386,10 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
     adevc->build_dev_aml = build_pci_isa_aml;
 }
 
-static const TypeInfo piix3_pci_type_info = {
-    .name = TYPE_PIIX3_PCI_DEVICE,
+static const TypeInfo piix_pci_type_info = {
+    .name = TYPE_PIIX_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PIIX3State),
+    .instance_size = sizeof(PIIXState),
     .instance_init = pci_piix3_init,
     .abstract = true,
     .class_init = pci_piix3_class_init,
@@ -403,7 +403,7 @@ static const TypeInfo piix3_pci_type_info = {
 static void piix3_realize(PCIDevice *dev, Error **errp)
 {
     ERRP_GUARD();
-    PIIX3State *piix3 = PIIX3_PCI_DEVICE(dev);
+    PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
 
     pci_piix3_realize(dev, errp);
@@ -424,13 +424,13 @@ static void piix3_class_init(ObjectClass *klass, void *data)
 
 static const TypeInfo piix3_info = {
     .name          = TYPE_PIIX3_DEVICE,
-    .parent        = TYPE_PIIX3_PCI_DEVICE,
+    .parent        = TYPE_PIIX_PCI_DEVICE,
     .class_init    = piix3_class_init,
 };
 
 static void piix3_register_types(void)
 {
-    type_register_static(&piix3_pci_type_info);
+    type_register_static(&piix_pci_type_info);
     type_register_static(&piix3_info);
 }
 
-- 
MST


