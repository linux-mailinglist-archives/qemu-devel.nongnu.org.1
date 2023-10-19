Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71667D015C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhq-0001h6-Ah; Thu, 19 Oct 2023 14:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXhd-0001NS-Lf
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXha-0004U4-TS
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PPLQmXXxzBmAon2V0X2xj7Rza3f9PZpdzyLrBWWg/e4=;
 b=C4uk42G2x7s7XyvKs6WkLEap19YlovYl7cPF/UwA4XEUCU2BjNxRBYdLCLQeregnVqSz3x
 sMwyLEIknMgi85CVF5CpoQwGvmeJ5bEEC8HxZ1Zb2USpcJCX4oBhbPA2Lg8JD5eDFwDzEu
 6Y5Lbvj+n1TJmYuHOZYMxL4J7+OV1VM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-4n7Tvc4jO6KXWk_immWPeA-1; Thu, 19 Oct 2023 14:24:08 -0400
X-MC-Unique: 4n7Tvc4jO6KXWk_immWPeA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c512a53e82so54887561fa.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:24:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739834; x=1698344634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPLQmXXxzBmAon2V0X2xj7Rza3f9PZpdzyLrBWWg/e4=;
 b=r93CvSJg7oYRBas9sH+6FPQadGMCb5AxiR09u1ayBX9YPzaIUVQ+Jr3+mikkAThZsC
 dyrLA9+PVU5FUWG+0jpc3sxQ725v/8DJJ62QcSY6ZS+pPyiyXzxrtq+lvoP8zaq0cokN
 q+ZQIUwanWNQQjmYPCmlP4lfX422KV6HS9vfJWn0/63GBdwS+8NM8NZEceZEy4ca64Zn
 9+T+WBdlznwBcxr0gZ3wtf3W8uxylT8SbKGtPIuCdAalg6ZChK15G5M+Ch1M7EYQOas7
 xV16OFIMWnZawjS24d6Cw7iDBzXoFmKS1U0m4l1OXJbFRMIOjQwTCpVLpB1BnhQvQY/1
 EJTQ==
X-Gm-Message-State: AOJu0Yz+0zB2soASMmH3eM3De8thixyEQilmtRmHBUFm8YDw4XXuzvZY
 tVFnfKNsrnUa2rrl0ba0HgmqNBBxfrjFbZ+p4ZPfJwOO+MJbyLqFTZUGp/tvzK5qLtp6VmQlPGx
 BNgVjaKPQusiFKZpkWm2M6RFQ99tzfKJYP7Y8LH0ALKboLDJOe4RZ+Dz/HHN/2U7JMWNM
X-Received: by 2002:a05:651c:229:b0:2bf:ab17:d48b with SMTP id
 z9-20020a05651c022900b002bfab17d48bmr2022538ljn.34.1697739834678; 
 Thu, 19 Oct 2023 11:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpvmuCEX25gIjCTzrWQrrMq69ULKaqccDamS67lWnVBW+F3lRUu8uUL9gBVOKMMAVRtGlI5w==
X-Received: by 2002:a05:651c:229:b0:2bf:ab17:d48b with SMTP id
 z9-20020a05651c022900b002bfab17d48bmr2022519ljn.34.1697739834335; 
 Thu, 19 Oct 2023 11:23:54 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a05600c1c0f00b003fefb94ccc9sm221179wms.11.2023.10.19.11.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:53 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL v2 60/78] hw/isa/piix: Share PIIX3's base class with PIIX4
Message-ID: <3ee54f65f4bbcd566ff2e564cfa88080e0461cc2.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Having a common base class will allow for futher code sharing between PIIX3 and
PIIX4. Moreover, it makes PIIX4 implement the acpi-dev-aml-interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-24-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c | 85 ++++++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 55 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index bd66fb7475..8f7d6c56a8 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -38,10 +38,6 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
-typedef struct PIIXState PIIX4State;
-
-DECLARE_INSTANCE_CHECKER(PIIX4State, PIIX4_PCI_DEVICE, TYPE_PIIX4_PCI_DEVICE)
-
 static void piix3_set_irq_pic(PIIXState *piix3, int pic_irq)
 {
     qemu_set_irq(piix3->isa_irqs_in[pic_irq],
@@ -88,7 +84,7 @@ static void piix3_set_irq(void *opaque, int pirq, int level)
 static void piix4_set_irq(void *opaque, int irq_num, int level)
 {
     int i, pic_irq, pic_level;
-    PIIX4State *s = opaque;
+    PIIXState *s = opaque;
     PCIBus *bus = pci_get_bus(&s->dev);
 
     /* now we change the pic irq level according to the piix irq mappings */
@@ -108,7 +104,7 @@ static void piix4_set_irq(void *opaque, int irq_num, int level)
 
 static void piix_request_i8259_irq(void *opaque, int irq, int level)
 {
-    PIIX4State *s = opaque;
+    PIIXState *s = opaque;
     qemu_set_irq(s->cpu_intr, level);
 }
 
@@ -156,8 +152,9 @@ static void piix3_write_config(PCIDevice *dev,
     }
 }
 
-static void piix_reset(PIIXState *d)
+static void piix_reset(DeviceState *dev)
 {
+    PIIXState *d = PIIX_PCI_DEVICE(dev);
     uint8_t *pci_conf = d->dev.config;
 
     pci_conf[0x04] = 0x07; /* master, memory and I/O */
@@ -196,13 +193,6 @@ static void piix_reset(PIIXState *d)
     d->rcr = 0;
 }
 
-static void piix3_reset(DeviceState *dev)
-{
-    PIIXState *d = PIIX_PCI_DEVICE(dev);
-
-    piix_reset(d);
-}
-
 static int piix3_post_load(void *opaque, int version_id)
 {
     PIIXState *piix3 = opaque;
@@ -227,7 +217,7 @@ static int piix3_post_load(void *opaque, int version_id)
 
 static int piix4_post_load(void *opaque, int version_id)
 {
-    PIIX4State *s = opaque;
+    PIIXState *s = opaque;
 
     if (version_id == 2) {
         s->rcr = 0;
@@ -291,8 +281,8 @@ static const VMStateDescription vmstate_piix4 = {
     .minimum_version_id = 2,
     .post_load = piix4_post_load,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PIIX4State),
-        VMSTATE_UINT8_V(rcr, PIIX4State, 3),
+        VMSTATE_PCI_DEVICE(dev, PIIXState),
+        VMSTATE_UINT8_V(rcr, PIIXState, 3),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -426,7 +416,7 @@ static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
-static void pci_piix3_init(Object *obj)
+static void pci_piix_init(Object *obj)
 {
     PIIXState *d = PIIX_PCI_DEVICE(obj);
 
@@ -434,7 +424,6 @@ static void pci_piix3_init(Object *obj)
                              ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
-    object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
 }
 
 static Property pci_piix3_props[] = {
@@ -447,27 +436,22 @@ static Property pci_piix3_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void pci_piix3_class_init(ObjectClass *klass, void *data)
+static void pci_piix_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
-    k->config_write = piix3_write_config;
-    dc->reset       = piix3_reset;
+    dc->reset       = piix_reset;
     dc->desc        = "ISA bridge";
-    dc->vmsd        = &vmstate_piix3;
     dc->hotpluggable   = false;
     k->vendor_id    = PCI_VENDOR_ID_INTEL;
-    /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
-    k->device_id    = PCI_DEVICE_ID_INTEL_82371SB_0;
     k->class_id     = PCI_CLASS_BRIDGE_ISA;
     /*
-     * Reason: part of PIIX3 southbridge, needs to be wired up by
+     * Reason: part of PIIX southbridge, needs to be wired up by e.g.
      * pc_piix.c's pc_init1()
      */
     dc->user_creatable = false;
-    device_class_set_props(dc, pci_piix3_props);
     adevc->build_dev_aml = build_pci_isa_aml;
 }
 
@@ -475,9 +459,9 @@ static const TypeInfo piix_pci_type_info = {
     .name = TYPE_PIIX_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PIIXState),
-    .instance_init = pci_piix3_init,
+    .instance_init = pci_piix_init,
     .abstract = true,
-    .class_init = pci_piix3_class_init,
+    .class_init = pci_piix_class_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { TYPE_ACPI_DEV_AML_IF },
@@ -500,22 +484,36 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
     pci_bus_set_route_irq_fn(pci_bus, piix3_route_intx_pin_to_irq);
 }
 
+static void piix3_init(Object *obj)
+{
+    PIIXState *d = PIIX_PCI_DEVICE(obj);
+
+    object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
+}
+
 static void piix3_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
+    k->config_write = piix3_write_config;
     k->realize = piix3_realize;
+    /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
+    k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
+    dc->vmsd = &vmstate_piix3;
+    device_class_set_props(dc, pci_piix3_props);
 }
 
 static const TypeInfo piix3_info = {
     .name          = TYPE_PIIX3_DEVICE,
     .parent        = TYPE_PIIX_PCI_DEVICE,
+    .instance_init = piix3_init,
     .class_init    = piix3_class_init,
 };
 
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
-    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
+    PIIXState *s = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
     ISABus *isa_bus;
     qemu_irq *i8259_out_irq;
@@ -584,18 +582,10 @@ static void piix4_realize(PCIDevice *dev, Error **errp)
     pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
 }
 
-static void piix4_isa_reset(DeviceState *dev)
-{
-    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
-
-    piix_reset(s);
-}
-
 static void piix4_init(Object *obj)
 {
-    PIIX4State *s = PIIX4_PCI_DEVICE(obj);
+    PIIXState *s = PIIX_PCI_DEVICE(obj);
 
-    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
     object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
     object_initialize_child(obj, "uhci", &s->uhci, TYPE_PIIX4_USB_UHCI);
 
@@ -610,30 +600,15 @@ static void piix4_class_init(ObjectClass *klass, void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = piix4_realize;
-    k->vendor_id = PCI_VENDOR_ID_INTEL;
     k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
-    k->class_id = PCI_CLASS_BRIDGE_ISA;
-    dc->reset = piix4_isa_reset;
-    dc->desc = "ISA bridge";
     dc->vmsd = &vmstate_piix4;
-    /*
-     * Reason: part of PIIX4 southbridge, needs to be wired up,
-     * e.g. by mips_malta_init()
-     */
-    dc->user_creatable = false;
-    dc->hotpluggable = false;
 }
 
 static const TypeInfo piix4_info = {
     .name          = TYPE_PIIX4_PCI_DEVICE,
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PIIX4State),
+    .parent        = TYPE_PIIX_PCI_DEVICE,
     .instance_init = piix4_init,
     .class_init    = piix4_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
 };
 
 static void piix3_register_types(void)
-- 
MST


