Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9494D7D0167
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:26:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXhS-0000js-4R; Thu, 19 Oct 2023 14:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgV-0007xt-Jq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXgS-0001UH-St
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zp8ck988MeO0ieV9CiSN4OR7iyEaCu9xYo7GkmkUxAU=;
 b=LPZCf/NHQefSaCIfPWKImKRTCHoj101aFBPbhGiauJTCZprK61kemfH69B3+R9I7q2nrch
 z4GYKEyC2AZUHfAdaHDzjHGQ0JQEA/i76E5jKmV7ayFs4fG1Q531ak9jL+2uKdD9lfp0KH
 jA8dIck0xqz77Bny8HelA7KfdzVGdGw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-c4R-A3dXNZuNCyFcUMAd3g-1; Thu, 19 Oct 2023 14:23:45 -0400
X-MC-Unique: c4R-A3dXNZuNCyFcUMAd3g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40845fe2d1cso5671355e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:23:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739824; x=1698344624;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zp8ck988MeO0ieV9CiSN4OR7iyEaCu9xYo7GkmkUxAU=;
 b=FwNIWTvbBTSWL5y1NfLspfaWAmwrnwvbfJ+4abXlzxL6b8MPOxzIYkXDylTv7ygP+9
 LruSlJpNEaNjFFcCehfH7V5rgb9PBJUr0QZ08ytjubGaADeLNh2zJQr4ZsL7uzXEt97y
 p9Zi5LPWNJlAih1UwHx18Ej6o1LC+FpjrnZ3gtMWqmCbKHvdQwFjmTXwzvoWAkep0EOf
 UvOyM9/7qrk8gusOJbHtz8BqbmoXUoN+OVrm6BQKAVXcPqPJ8QmAXkbMZmw/SQmcIXRO
 vbhiWkP3sbwzyjHIko8KWoUcYCMDxxx8fzR1WdHGI3JsAfZ64hjp49xkxcT0nGxhTalR
 9u6A==
X-Gm-Message-State: AOJu0YwOxKVkivD5J7YWgOlDLc+w+Tcu33J2z8eHGLYmrAsu2/rKA4go
 p8M2b+7ufj2Z/TG3+FlGslx1igcGVVPxqW4WetrKLn3gZ/a0sR/mlBQA0D137FtVp2X6vsagXA2
 w/PlxS6tK4AWawxkxjxj3sfSO8MzV9d7fMVJmccJG0C+RUYfUVTdEmyDUz+vB5W9zf0I8
X-Received: by 2002:a05:6000:bce:b0:32d:a4cf:99b3 with SMTP id
 dm14-20020a0560000bce00b0032da4cf99b3mr2228339wrb.67.1697739823801; 
 Thu, 19 Oct 2023 11:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAEjoauDPE96DtSuoCPSqR9hf41wlbitglAy4SgXS7mIYreTRcENU6hCIgLFBMUaLT3nwU8Q==
X-Received: by 2002:a05:6000:bce:b0:32d:a4cf:99b3 with SMTP id
 dm14-20020a0560000bce00b0032da4cf99b3mr2228311wrb.67.1697739823315; 
 Thu, 19 Oct 2023 11:23:43 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 o2-20020adfeac2000000b0032cc35c2ef7sm5013534wrn.29.2023.10.19.11.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:23:42 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:23:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v2 56/78] hw/isa/piix3: Merge hw/isa/piix4.c
Message-ID: <975bd3009c67d97dad8d8be81492915cdeee6255.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

Now that the PIIX3 and PIIX4 device models are sufficiently prepared, their
implementations can be merged into one file for further consolidation.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-20-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/{piix3.c => piix.c} | 190 +++++++++++++++++++++++-
 hw/isa/piix4.c             | 290 -------------------------------------
 MAINTAINERS                |   6 +-
 hw/i386/Kconfig            |   2 +-
 hw/isa/Kconfig             |  11 +-
 hw/isa/meson.build         |   3 +-
 hw/mips/Kconfig            |   2 +-
 7 files changed, 195 insertions(+), 309 deletions(-)
 rename hw/isa/{piix3.c => piix.c} (71%)
 delete mode 100644 hw/isa/piix4.c

diff --git a/hw/isa/piix3.c b/hw/isa/piix.c
similarity index 71%
rename from hw/isa/piix3.c
rename to hw/isa/piix.c
index c7e59249b6..f6da334c6f 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix.c
@@ -2,6 +2,7 @@
  * QEMU PIIX PCI ISA Bridge Emulation
  *
  * Copyright (c) 2006 Fabrice Bellard
+ * Copyright (c) 2018 Hervé Poussineau
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
@@ -27,14 +28,20 @@
 #include "qapi/error.h"
 #include "hw/dma/i8257.h"
 #include "hw/southbridge/piix.h"
+#include "hw/timer/i8254.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/ide/piix.h"
+#include "hw/intc/i8259.h"
 #include "hw/isa/isa.h"
 #include "sysemu/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
 
+typedef struct PIIXState PIIX4State;
+
+DECLARE_INSTANCE_CHECKER(PIIX4State, PIIX4_PCI_DEVICE, TYPE_PIIX4_PCI_DEVICE)
+
 static void piix3_set_irq_pic(PIIXState *piix3, int pic_irq)
 {
     qemu_set_irq(piix3->isa_irqs_in[pic_irq],
@@ -78,6 +85,33 @@ static void piix3_set_irq(void *opaque, int pirq, int level)
     piix3_set_irq_level(piix3, pirq, level);
 }
 
+static void piix4_set_irq(void *opaque, int irq_num, int level)
+{
+    int i, pic_irq, pic_level;
+    PIIX4State *s = opaque;
+    PCIBus *bus = pci_get_bus(&s->dev);
+
+    /* now we change the pic irq level according to the piix irq mappings */
+    /* XXX: optimize */
+    pic_irq = s->dev.config[PIIX_PIRQCA + irq_num];
+    if (pic_irq < ISA_NUM_IRQS) {
+        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
+        pic_level = 0;
+        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
+            if (pic_irq == s->dev.config[PIIX_PIRQCA + i]) {
+                pic_level |= pci_bus_get_irq_level(bus, i);
+            }
+        }
+        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
+    }
+}
+
+static void piix4_request_i8259_irq(void *opaque, int irq, int level)
+{
+    PIIX4State *s = opaque;
+    qemu_set_irq(s->cpu_intr, level);
+}
+
 static PCIINTxRoute piix3_route_intx_pin_to_irq(void *opaque, int pin)
 {
     PIIXState *piix3 = opaque;
@@ -122,9 +156,8 @@ static void piix3_write_config(PCIDevice *dev,
     }
 }
 
-static void piix3_reset(DeviceState *dev)
+static void piix_reset(PIIXState *d)
 {
-    PIIXState *d = PIIX_PCI_DEVICE(dev);
     uint8_t *pci_conf = d->dev.config;
 
     pci_conf[0x04] = 0x07; /* master, memory and I/O */
@@ -163,6 +196,13 @@ static void piix3_reset(DeviceState *dev)
     d->rcr = 0;
 }
 
+static void piix3_reset(DeviceState *dev)
+{
+    PIIXState *d = PIIX_PCI_DEVICE(dev);
+
+    piix_reset(d);
+}
+
 static int piix3_post_load(void *opaque, int version_id)
 {
     PIIXState *piix3 = opaque;
@@ -185,6 +225,17 @@ static int piix3_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static int piix4_post_load(void *opaque, int version_id)
+{
+    PIIX4State *s = opaque;
+
+    if (version_id == 2) {
+        s->rcr = 0;
+    }
+
+    return 0;
+}
+
 static int piix3_pre_save(void *opaque)
 {
     int i;
@@ -234,6 +285,17 @@ static const VMStateDescription vmstate_piix3 = {
     }
 };
 
+static const VMStateDescription vmstate_piix4 = {
+    .name = "PIIX4",
+    .version_id = 3,
+    .minimum_version_id = 2,
+    .post_load = piix4_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, PIIX4State),
+        VMSTATE_UINT8_V(rcr, PIIX4State, 3),
+        VMSTATE_END_OF_LIST()
+    }
+};
 
 static void rcr_write(void *opaque, hwaddr addr, uint64_t val, unsigned len)
 {
@@ -428,10 +490,134 @@ static const TypeInfo piix3_info = {
     .class_init    = piix3_class_init,
 };
 
+static void piix4_realize(PCIDevice *dev, Error **errp)
+{
+    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
+    PCIBus *pci_bus = pci_get_bus(dev);
+    ISABus *isa_bus;
+    qemu_irq *i8259_out_irq;
+    qemu_irq *i8259;
+    size_t i;
+
+    isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
+                          pci_address_space_io(dev), errp);
+    if (!isa_bus) {
+        return;
+    }
+
+    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
+                             "intr", 1);
+
+    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
+                          "reset-control", 1);
+    memory_region_add_subregion_overlap(pci_address_space_io(dev),
+                                        PIIX_RCR_IOPORT, &s->rcr_mem, 1);
+
+    /* initialize i8259 pic */
+    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
+    i8259 = i8259_init(isa_bus, *i8259_out_irq);
+
+    for (i = 0; i < ISA_NUM_IRQS; i++) {
+        s->isa_irqs_in[i] = i8259[i];
+    }
+
+    g_free(i8259);
+
+    /* initialize ISA irqs */
+    isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
+
+    /* initialize pit */
+    i8254_pit_init(isa_bus, 0x40, 0, NULL);
+
+    /* DMA */
+    i8257_dma_init(isa_bus, 0);
+
+    /* RTC */
+    qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
+    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
+        return;
+    }
+    s->rtc.irq = isa_get_irq(ISA_DEVICE(&s->rtc), s->rtc.isairq);
+
+    /* IDE */
+    qdev_prop_set_int32(DEVICE(&s->ide), "addr", dev->devfn + 1);
+    if (!qdev_realize(DEVICE(&s->ide), BUS(pci_bus), errp)) {
+        return;
+    }
+
+    /* USB */
+    qdev_prop_set_int32(DEVICE(&s->uhci), "addr", dev->devfn + 2);
+    if (!qdev_realize(DEVICE(&s->uhci), BUS(pci_bus), errp)) {
+        return;
+    }
+
+    /* ACPI controller */
+    qdev_prop_set_int32(DEVICE(&s->pm), "addr", dev->devfn + 3);
+    if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
+        return;
+    }
+    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa_irqs_in[9]);
+
+    pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
+}
+
+static void piix4_isa_reset(DeviceState *dev)
+{
+    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
+
+    piix_reset(s);
+}
+
+static void piix4_init(Object *obj)
+{
+    PIIX4State *s = PIIX4_PCI_DEVICE(obj);
+
+    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
+    object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
+    object_initialize_child(obj, "uhci", &s->uhci, TYPE_PIIX4_USB_UHCI);
+
+    object_initialize_child(obj, "pm", &s->pm, TYPE_PIIX4_PM);
+    qdev_prop_set_uint32(DEVICE(&s->pm), "smb_io_base", 0x1100);
+    qdev_prop_set_bit(DEVICE(&s->pm), "smm-enabled", 0);
+}
+
+static void piix4_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = piix4_realize;
+    k->vendor_id = PCI_VENDOR_ID_INTEL;
+    k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
+    k->class_id = PCI_CLASS_BRIDGE_ISA;
+    dc->reset = piix4_isa_reset;
+    dc->desc = "ISA bridge";
+    dc->vmsd = &vmstate_piix4;
+    /*
+     * Reason: part of PIIX4 southbridge, needs to be wired up,
+     * e.g. by mips_malta_init()
+     */
+    dc->user_creatable = false;
+    dc->hotpluggable = false;
+}
+
+static const TypeInfo piix4_info = {
+    .name          = TYPE_PIIX4_PCI_DEVICE,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(PIIX4State),
+    .instance_init = piix4_init,
+    .class_init    = piix4_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
 static void piix3_register_types(void)
 {
     type_register_static(&piix_pci_type_info);
     type_register_static(&piix3_info);
+    type_register_static(&piix4_info);
 }
 
 type_init(piix3_register_types)
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
deleted file mode 100644
index 71899aaa69..0000000000
--- a/hw/isa/piix4.c
+++ /dev/null
@@ -1,290 +0,0 @@
-/*
- * QEMU PIIX4 PCI Bridge Emulation
- *
- * Copyright (c) 2006 Fabrice Bellard
- * Copyright (c) 2018 Hervé Poussineau
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "hw/irq.h"
-#include "hw/southbridge/piix.h"
-#include "hw/pci/pci.h"
-#include "hw/ide/piix.h"
-#include "hw/isa/isa.h"
-#include "hw/intc/i8259.h"
-#include "hw/dma/i8257.h"
-#include "hw/timer/i8254.h"
-#include "hw/rtc/mc146818rtc.h"
-#include "hw/ide/pci.h"
-#include "hw/acpi/piix4.h"
-#include "hw/usb/hcd-uhci.h"
-#include "migration/vmstate.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "qom/object.h"
-
-typedef struct PIIXState PIIX4State;
-
-DECLARE_INSTANCE_CHECKER(PIIX4State, PIIX4_PCI_DEVICE, TYPE_PIIX4_PCI_DEVICE)
-
-static void piix4_set_irq(void *opaque, int irq_num, int level)
-{
-    int i, pic_irq, pic_level;
-    PIIX4State *s = opaque;
-    PCIBus *bus = pci_get_bus(&s->dev);
-
-    /* now we change the pic irq level according to the piix irq mappings */
-    /* XXX: optimize */
-    pic_irq = s->dev.config[PIIX_PIRQCA + irq_num];
-    if (pic_irq < ISA_NUM_IRQS) {
-        /* The pic level is the logical OR of all the PCI irqs mapped to it. */
-        pic_level = 0;
-        for (i = 0; i < PIIX_NUM_PIRQS; i++) {
-            if (pic_irq == s->dev.config[PIIX_PIRQCA + i]) {
-                pic_level |= pci_bus_get_irq_level(bus, i);
-            }
-        }
-        qemu_set_irq(s->isa_irqs_in[pic_irq], pic_level);
-    }
-}
-
-static void piix4_isa_reset(DeviceState *dev)
-{
-    PIIX4State *d = PIIX4_PCI_DEVICE(dev);
-    uint8_t *pci_conf = d->dev.config;
-
-    pci_conf[0x04] = 0x07; // master, memory and I/O
-    pci_conf[0x05] = 0x00;
-    pci_conf[0x06] = 0x00;
-    pci_conf[0x07] = 0x02; // PCI_status_devsel_medium
-    pci_conf[0x4c] = 0x4d;
-    pci_conf[0x4e] = 0x03;
-    pci_conf[0x4f] = 0x00;
-    pci_conf[0x60] = 0x80;
-    pci_conf[0x61] = 0x80;
-    pci_conf[0x62] = 0x80;
-    pci_conf[0x63] = 0x80;
-    pci_conf[0x69] = 0x02;
-    pci_conf[0x70] = 0x80;
-    pci_conf[0x76] = 0x0c;
-    pci_conf[0x77] = 0x0c;
-    pci_conf[0x78] = 0x02;
-    pci_conf[0x79] = 0x00;
-    pci_conf[0x80] = 0x00;
-    pci_conf[0x82] = 0x00;
-    pci_conf[0xa0] = 0x08;
-    pci_conf[0xa2] = 0x00;
-    pci_conf[0xa3] = 0x00;
-    pci_conf[0xa4] = 0x00;
-    pci_conf[0xa5] = 0x00;
-    pci_conf[0xa6] = 0x00;
-    pci_conf[0xa7] = 0x00;
-    pci_conf[0xa8] = 0x0f;
-    pci_conf[0xaa] = 0x00;
-    pci_conf[0xab] = 0x00;
-    pci_conf[0xac] = 0x00;
-    pci_conf[0xae] = 0x00;
-
-    d->rcr = 0;
-}
-
-static int piix4_post_load(void *opaque, int version_id)
-{
-    PIIX4State *s = opaque;
-
-    if (version_id == 2) {
-        s->rcr = 0;
-    }
-
-    return 0;
-}
-
-static const VMStateDescription vmstate_piix4 = {
-    .name = "PIIX4",
-    .version_id = 3,
-    .minimum_version_id = 2,
-    .post_load = piix4_post_load,
-    .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(dev, PIIX4State),
-        VMSTATE_UINT8_V(rcr, PIIX4State, 3),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static void piix4_request_i8259_irq(void *opaque, int irq, int level)
-{
-    PIIX4State *s = opaque;
-    qemu_set_irq(s->cpu_intr, level);
-}
-
-static void rcr_write(void *opaque, hwaddr addr, uint64_t val,
-                      unsigned int len)
-{
-    PIIX4State *s = opaque;
-
-    if (val & 4) {
-        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
-        return;
-    }
-
-    s->rcr = val & 2; /* keep System Reset type only */
-}
-
-static uint64_t rcr_read(void *opaque, hwaddr addr, unsigned int len)
-{
-    PIIX4State *s = opaque;
-
-    return s->rcr;
-}
-
-static const MemoryRegionOps rcr_ops = {
-    .read = rcr_read,
-    .write = rcr_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .impl = {
-        .min_access_size = 1,
-        .max_access_size = 1,
-    },
-};
-
-static void piix4_realize(PCIDevice *dev, Error **errp)
-{
-    PIIX4State *s = PIIX4_PCI_DEVICE(dev);
-    PCIBus *pci_bus = pci_get_bus(dev);
-    ISABus *isa_bus;
-    qemu_irq *i8259_out_irq;
-    qemu_irq *i8259;
-    size_t i;
-
-    isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
-                          pci_address_space_io(dev), errp);
-    if (!isa_bus) {
-        return;
-    }
-
-    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
-                             "intr", 1);
-
-    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
-                          "reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev),
-                                        PIIX_RCR_IOPORT, &s->rcr_mem, 1);
-
-    /* initialize i8259 pic */
-    i8259_out_irq = qemu_allocate_irqs(piix4_request_i8259_irq, s, 1);
-    i8259 = i8259_init(isa_bus, *i8259_out_irq);
-
-    for (i = 0; i < ISA_NUM_IRQS; i++) {
-        s->isa_irqs_in[i] = i8259[i];
-    }
-
-    g_free(i8259);
-
-    /* initialize ISA irqs */
-    isa_bus_register_input_irqs(isa_bus, s->isa_irqs_in);
-
-    /* initialize pit */
-    i8254_pit_init(isa_bus, 0x40, 0, NULL);
-
-    /* DMA */
-    i8257_dma_init(isa_bus, 0);
-
-    /* RTC */
-    qdev_prop_set_int32(DEVICE(&s->rtc), "base_year", 2000);
-    if (!qdev_realize(DEVICE(&s->rtc), BUS(isa_bus), errp)) {
-        return;
-    }
-    s->rtc.irq = isa_get_irq(ISA_DEVICE(&s->rtc), s->rtc.isairq);
-
-    /* IDE */
-    qdev_prop_set_int32(DEVICE(&s->ide), "addr", dev->devfn + 1);
-    if (!qdev_realize(DEVICE(&s->ide), BUS(pci_bus), errp)) {
-        return;
-    }
-
-    /* USB */
-    qdev_prop_set_int32(DEVICE(&s->uhci), "addr", dev->devfn + 2);
-    if (!qdev_realize(DEVICE(&s->uhci), BUS(pci_bus), errp)) {
-        return;
-    }
-
-    /* ACPI controller */
-    qdev_prop_set_int32(DEVICE(&s->pm), "addr", dev->devfn + 3);
-    if (!qdev_realize(DEVICE(&s->pm), BUS(pci_bus), errp)) {
-        return;
-    }
-    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa_irqs_in[9]);
-
-    pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
-}
-
-static void piix4_init(Object *obj)
-{
-    PIIX4State *s = PIIX4_PCI_DEVICE(obj);
-
-    object_initialize_child(obj, "rtc", &s->rtc, TYPE_MC146818_RTC);
-    object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
-    object_initialize_child(obj, "uhci", &s->uhci, TYPE_PIIX4_USB_UHCI);
-
-    object_initialize_child(obj, "pm", &s->pm, TYPE_PIIX4_PM);
-    qdev_prop_set_uint32(DEVICE(&s->pm), "smb_io_base", 0x1100);
-    qdev_prop_set_bit(DEVICE(&s->pm), "smm-enabled", 0);
-}
-
-static void piix4_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = piix4_realize;
-    k->vendor_id = PCI_VENDOR_ID_INTEL;
-    k->device_id = PCI_DEVICE_ID_INTEL_82371AB_0;
-    k->class_id = PCI_CLASS_BRIDGE_ISA;
-    dc->reset = piix4_isa_reset;
-    dc->desc = "ISA bridge";
-    dc->vmsd = &vmstate_piix4;
-    /*
-     * Reason: part of PIIX4 southbridge, needs to be wired up,
-     * e.g. by mips_malta_init()
-     */
-    dc->user_creatable = false;
-    dc->hotpluggable = false;
-}
-
-static const TypeInfo piix4_info = {
-    .name          = TYPE_PIIX4_PCI_DEVICE,
-    .parent        = TYPE_PCI_DEVICE,
-    .instance_size = sizeof(PIIX4State),
-    .instance_init = piix4_init,
-    .class_init    = piix4_class_init,
-    .interfaces = (InterfaceInfo[]) {
-        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
-        { },
-    },
-};
-
-static void piix4_register_types(void)
-{
-    type_register_static(&piix4_info);
-}
-
-type_init(piix4_register_types)
diff --git a/MAINTAINERS b/MAINTAINERS
index 9bd4fe378d..d9fe5aa367 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1302,7 +1302,7 @@ Malta
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Aurelien Jarno <aurelien@aurel32.net>
 S: Odd Fixes
-F: hw/isa/piix4.c
+F: hw/isa/piix.c
 F: hw/acpi/piix4.c
 F: hw/mips/malta.c
 F: hw/pci-host/gt64120.c
@@ -1724,7 +1724,7 @@ F: hw/pci-host/pam.c
 F: include/hw/pci-host/i440fx.h
 F: include/hw/pci-host/q35.h
 F: include/hw/pci-host/pam.h
-F: hw/isa/piix3.c
+F: hw/isa/piix.c
 F: hw/isa/lpc_ich9.c
 F: hw/i2c/smbus_ich9.c
 F: hw/acpi/piix4.c
@@ -2478,7 +2478,7 @@ PIIX4 South Bridge (i82371AB)
 M: Hervé Poussineau <hpoussin@reactos.org>
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
-F: hw/isa/piix4.c
+F: hw/isa/piix.c
 F: include/hw/southbridge/piix.h
 
 Firmware configuration (fw_cfg)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index ade817f1b6..94772c726b 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -72,7 +72,7 @@ config I440FX
     select PC_PCI
     select PC_ACPI
     select PCI_I440FX
-    select PIIX3
+    select PIIX
     select DIMM
     select SMBIOS
     select FW_CFG_DMA
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 17ddb25afc..040a18c070 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -31,16 +31,7 @@ config PC87312
     select FDC_ISA
     select IDE_ISA
 
-config PIIX3
-    bool
-    select ACPI_PIIX4
-    select I8257
-    select IDE_PIIX
-    select ISA_BUS
-    select MC146818RTC
-    select USB_UHCI
-
-config PIIX4
+config PIIX
     bool
     # For historical reasons, SuperIO devices are created in the board
     # for PIIX4.
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index b855e81276..2ab99ce0c6 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -3,8 +3,7 @@ system_ss.add(when: 'CONFIG_I82378', if_true: files('i82378.c'))
 system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
-system_ss.add(when: 'CONFIG_PIIX3', if_true: files('piix3.c'))
-system_ss.add(when: 'CONFIG_PIIX4', if_true: files('piix4.c'))
+system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index da3a37e215..ac1eb06a51 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -2,7 +2,7 @@ config MALTA
     bool
     select GT64120
     select ISA_SUPERIO
-    select PIIX4
+    select PIIX
 
 config MIPSSIM
     bool
-- 
MST


