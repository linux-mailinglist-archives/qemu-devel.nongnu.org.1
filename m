Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B099D7D2234
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:26:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhw-0005hw-FL; Sun, 22 Oct 2023 05:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhr-0005PH-JD
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhp-0000og-M3
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foQRLMQjVYT5y42wZUNoNj1yclA5wnMQdFvFQOR/qu8=;
 b=QE9bWTUgaUcnDdOP8aJdFzP54Af3x/196AZtDatDyAbRGAzTE0uucrmAPiF+VIYr1WIMZp
 6f8zPF/h/yZcdeaR591cvsyG9OQzzDl+D0K5Pr347egtwb2CqaiR0ctRa8KZK03cxuVPAD
 LzdUezZv//X45SmnJaDLLzfZf3Bo6Sw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-_l4Ciii2PleiATotwFQTtQ-1; Sun, 22 Oct 2023 05:25:07 -0400
X-MC-Unique: _l4Ciii2PleiATotwFQTtQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507d4583c4cso2175004e87.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966705; x=1698571505;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foQRLMQjVYT5y42wZUNoNj1yclA5wnMQdFvFQOR/qu8=;
 b=ZR75QbB1S3dzrjO8144d3KwvTc4FiUsIi1K5noHfakkfMsF/omVua3dv99yrgZEOdH
 3+3p2cfqNmmCnRgQTQpdaLsL0foJMBO+E44IMzGIBRicziMQ5giPQnw6N56ULbt6DtoC
 Ok5AFwDuvfjjkNHbOHVJVZIl2cQIzLD/zN10TAkpSR9tiw/Gg2nwARNNO/pBbnWh/6RH
 XAMPMf0e+GZtPpNOyYxjxdfE1Hc4B6TNW/IVbXAtKxOr+CZcOLlvTu/toGKp+RMpMYJe
 seoI5au0lD3hTsHVrY02W+VM7dr5leXWsN/iMnqqN/S69IsdJrqQIf+d1aQwe6xxY6WM
 5yhg==
X-Gm-Message-State: AOJu0YzKx0mZLtMBz2LsC/zIQTwiOL+puNRqwUObmqmJV+uzZShLYin6
 OpbaMHak18z1nsrS4Fs3i7dajQMtb4kGwMzs8f1Kpnv+eOSfQMM3iasGkqxQI1X/Jy9Raj1la5/
 IqN5no+14VmaKOG9fUzf6+AIT7n8v6R0o2vfYpU5c0byyiykl1Hd5gcoyaB+0/ZHN0v2l
X-Received: by 2002:a05:6512:2150:b0:507:a70e:c619 with SMTP id
 s16-20020a056512215000b00507a70ec619mr569530lfr.67.1697966705702; 
 Sun, 22 Oct 2023 02:25:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6w+/T05iYr95ZSadUj+7KyKVAnAjPUdEVEQpzUauUrCDj+RaC6QHEa3QE0pMAyKKQJTZ4ww==
X-Received: by 2002:a05:6512:2150:b0:507:a70e:c619 with SMTP id
 s16-20020a056512215000b00507a70ec619mr569509lfr.67.1697966705181; 
 Sun, 22 Oct 2023 02:25:05 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c35c900b0040839fcb217sm6590898wmq.8.2023.10.22.02.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:25:04 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:25:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v3 45/62] hw/isa/piix: Reuse PIIX3 base class' realize method
 in PIIX4
Message-ID: <2922dbc28c74a4b3976cb4bc020980030ccfef67.1697966402.git.mst@redhat.com>
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

Resolves duplicate code. Also makes PIIX4 respect the PIIX3 properties which get
added, too. This allows for using PIIX4 in the PC machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20231007123843.127151-25-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/isa/piix.c   | 80 ++++++-------------------------------------------
 hw/mips/malta.c |  5 ++--
 2 files changed, 12 insertions(+), 73 deletions(-)

diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index 8f7d6c56a8..2ab799b95e 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -315,7 +315,8 @@ static const MemoryRegionOps rcr_ops = {
     },
 };
 
-static void pci_piix3_realize(PCIDevice *dev, Error **errp)
+static void pci_piix_realize(PCIDevice *dev, const char *uhci_type,
+                             Error **errp)
 {
     PIIXState *d = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
@@ -374,8 +375,7 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 
     /* USB */
     if (d->has_usb) {
-        object_initialize_child(OBJECT(dev), "uhci", &d->uhci,
-                                TYPE_PIIX3_USB_UHCI);
+        object_initialize_child(OBJECT(dev), "uhci", &d->uhci, uhci_type);
         qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
         if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
             return;
@@ -426,7 +426,7 @@ static void pci_piix_init(Object *obj)
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-static Property pci_piix3_props[] = {
+static Property pci_piix_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
@@ -452,6 +452,7 @@ static void pci_piix_class_init(ObjectClass *klass, void *data)
      * pc_piix.c's pc_init1()
      */
     dc->user_creatable = false;
+    device_class_set_props(dc, pci_piix_props);
     adevc->build_dev_aml = build_pci_isa_aml;
 }
 
@@ -475,7 +476,7 @@ static void piix3_realize(PCIDevice *dev, Error **errp)
     PIIXState *piix3 = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
 
-    pci_piix3_realize(dev, errp);
+    pci_piix_realize(dev, TYPE_PIIX3_USB_UHCI, errp);
     if (*errp) {
         return;
     }
@@ -501,7 +502,6 @@ static void piix3_class_init(ObjectClass *klass, void *data)
     /* 82371SB PIIX3 PCI-to-ISA bridge (Step A1) */
     k->device_id = PCI_DEVICE_ID_INTEL_82371SB_0;
     dc->vmsd = &vmstate_piix3;
-    device_class_set_props(dc, pci_piix3_props);
 }
 
 static const TypeInfo piix3_info = {
@@ -513,72 +513,15 @@ static const TypeInfo piix3_info = {
 
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_GUARD();
     PIIXState *s = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
-    ISABus *isa_bus;
-    qemu_irq *i8259_out_irq;
-    qemu_irq *i8259;
-    size_t i;
 
-    isa_bus = isa_bus_new(DEVICE(dev), pci_address_space(dev),
-                          pci_address_space_io(dev), errp);
-    if (!isa_bus) {
+    pci_piix_realize(dev, TYPE_PIIX4_USB_UHCI, errp);
+    if (*errp) {
         return;
     }
 
-    qdev_init_gpio_out_named(DEVICE(dev), &s->cpu_intr,
-                             "intr", 1);
-
-    memory_region_init_io(&s->rcr_mem, OBJECT(dev), &rcr_ops, s,
-                          "piix-reset-control", 1);
-    memory_region_add_subregion_overlap(pci_address_space_io(dev),
-                                        PIIX_RCR_IOPORT, &s->rcr_mem, 1);
-
-    /* initialize i8259 pic */
-    i8259_out_irq = qemu_allocate_irqs(piix_request_i8259_irq, s, 1);
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
     pci_bus_irqs(pci_bus, piix4_set_irq, s, PIIX_NUM_PIRQS);
 }
 
@@ -587,11 +530,6 @@ static void piix4_init(Object *obj)
     PIIXState *s = PIIX_PCI_DEVICE(obj);
 
     object_initialize_child(obj, "ide", &s->ide, TYPE_PIIX4_IDE);
-    object_initialize_child(obj, "uhci", &s->uhci, TYPE_PIIX4_USB_UHCI);
-
-    object_initialize_child(obj, "pm", &s->pm, TYPE_PIIX4_PM);
-    qdev_prop_set_uint32(DEVICE(&s->pm), "smb_io_base", 0x1100);
-    qdev_prop_set_bit(DEVICE(&s->pm), "smm-enabled", 0);
 }
 
 static void piix4_class_init(ObjectClass *klass, void *data)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index dac27fad9d..155f3c1cc8 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -1238,8 +1238,9 @@ void mips_malta_init(MachineState *machine)
     pci_bus_map_irqs(pci_bus, malta_pci_slot_get_pirq);
 
     /* Southbridge */
-    piix4 = pci_create_simple_multifunction(pci_bus, PIIX4_PCI_DEVFN,
-                                            TYPE_PIIX4_PCI_DEVICE);
+    piix4 = pci_new_multifunction(PIIX4_PCI_DEVFN, TYPE_PIIX4_PCI_DEVICE);
+    qdev_prop_set_uint32(DEVICE(piix4), "smb_io_base", 0x1100);
+    pci_realize_and_unref(piix4, pci_bus, &error_fatal);
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix4), "isa.0"));
 
     dev = DEVICE(object_resolve_path_component(OBJECT(piix4), "ide"));
-- 
MST


