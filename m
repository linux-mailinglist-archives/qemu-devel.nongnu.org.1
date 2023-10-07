Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2277BC7B4
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:43:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6al-0003Ji-MP; Sat, 07 Oct 2023 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aa-00032i-R9
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:25 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aX-0002pc-Vg
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:24 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9b2cee40de8so663306166b.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682359; x=1697287159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9yBSTpI9Xv1/cDWL+xp/VoNBOlMdUIrHNnE5N+mXXuM=;
 b=O8l21OrylieTXJmeoLb93JUFnosf1UhctJBlYzFYFCnDE/JVBLCDZzJpFtLRFQhGoL
 vJZ2qH5dG389TNw5+AUyhKRPeQ0tlghhkwDXqdAxP0vtYEtzvvarfiawCML5YU4NoSwc
 MLWaW7NwgMZOulXLtfqsOEXfh4+MoH9OdKCb8cOCvDSm7e04K5SgHEEUhDW5RB4JYgLh
 6yNti5ZgrAZXTLqQX5HhL/hqGYYtdBDX+ljU8H8mzJDk2qvqiwLP0hyJeySU1tPyBMJl
 bBTxegO1AqXm7MjkPaWyiYiMFiGmAP2RTq9IJSgbkPTAVrUei/7p2vcCmtQaE9g1Jizy
 hgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682359; x=1697287159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9yBSTpI9Xv1/cDWL+xp/VoNBOlMdUIrHNnE5N+mXXuM=;
 b=po6zb2arTJuPE04Y201LnhYJMYRNHz6Kq5K4ua8vzWg8EQrJktfnQh7xX3YOE9Lu+W
 jbY/yv522gaTsyPhEaKUS06kpB/F+8VqWRZMr1O/ipo6wDKDQv3+N1IHvaAPQBJmJuJj
 gqGdxEXPu3P1qvxg9JM91FjOJAFb7bgpUAzrXsjnjG6108hbETzb8P3XV4x45yanCl3f
 jLHfQ+DDBmA0w5+nYIWLlUW/aLQ1JlS2N/qcdwc4cnd/oSXlYjyiVKn3CNCwGrPSOXsx
 PV/mbApmEHL7f/6kIzAaq7vG33txQf1ik689QFxU89JBKzgUPylr8AeWDV/pqtWi+mhd
 X6bw==
X-Gm-Message-State: AOJu0YwHR6P00zNyjScTpVVyrxadFWmn3nli++abiIgm+VSBguF/kRBQ
 FkqkGxt/GKxYzAXlabzk4JV4UgB8k5k=
X-Google-Smtp-Source: AGHT+IHQxxUzNET4pLTQlkCPQ2SG15DFhSUsL+Uxnq18hd2M8s7Pm3himnqLM5jWU3Ihg7//Xrsb9g==
X-Received: by 2002:a17:906:c414:b0:9b8:9217:73f5 with SMTP id
 u20-20020a170906c41400b009b8921773f5mr7785117ejz.32.1696682359349; 
 Sat, 07 Oct 2023 05:39:19 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:18 -0700 (PDT)
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
Subject: [PATCH v8 23/29] hw/isa/piix: Share PIIX3's base class with PIIX4
Date: Sat,  7 Oct 2023 14:38:31 +0200
Message-ID: <20231007123843.127151-24-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

Having a common base class will allow for futher code sharing between PIIX3 and
PIIX4. Moreover, it makes PIIX4 implement the acpi-dev-aml-interface.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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
2.42.0


