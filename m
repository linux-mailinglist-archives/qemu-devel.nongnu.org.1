Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2967CE22D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:07:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8wy-0001Pt-0F; Wed, 18 Oct 2023 11:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wM-0000o3-D8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8wK-0007Qf-Gq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foQRLMQjVYT5y42wZUNoNj1yclA5wnMQdFvFQOR/qu8=;
 b=ivt5t3XsBIVhFBKan/i4E98sGVjFz2IzeqH238Lwbta1URa1STSYmBv9K2JZGbH8QicZdK
 J6CpBp8trTwH7SSIgVdUmrgfJgiZMZ0jFK/r7a966zez/qm87n6rAL2LCTNsbrTCTMpMPA
 utzxw+Cd2A3DaoQ8Ps7yfpk+/jzRmCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-c6UZlwilOC23NB-r8291rQ-1; Wed, 18 Oct 2023 11:58:30 -0400
X-MC-Unique: c6UZlwilOC23NB-r8291rQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4065d52a83aso44825115e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644708; x=1698249508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foQRLMQjVYT5y42wZUNoNj1yclA5wnMQdFvFQOR/qu8=;
 b=cbGHqulOaZOl+VVJ+sihPNpgllmhqP1tQGUdUvU5Wjv4B1On8gc+Nb6xNFErPu9Sai
 /5fC77YeNG87Ga6YIKq71Cd6WPhjwnL29kitbxMSH/lVwpJyZXWqxddqb2MCmDtcM8jB
 j46nuyK7EE6Xkdk7VWhyDNuxMUypQBHMSORCuRJAtwhZjdoVesheHj1ZnQQwMuXeujce
 2m+SJwLL97B2PL1Q7DvTu6EKalEnbltpIWG/+T2jNwHHeROVK548FHPZ5WYkC0OZ+JIz
 nDM+3bfSIZB5uMiq6w3sWp6jzYdih5mQLRbQB4SvBuMg69pFV3Dj5aKScoysZDuQMeLb
 Fmcg==
X-Gm-Message-State: AOJu0YzYvyU1ZNFEKYfzChPYGAWjL7TnVXg5q21wXICRr2CdWu7BeX7o
 ECG9v0JfdMzhYKImB674vQqm16cOlIRVf1M8pU1w0VdhsDXEcrdy8+JePllUkT9JSt7v1Syqke9
 1lb3znj+KSiUX4QKSDqddmDbO1CNyeiH5jd3B64zWU7oXuo7POQduzh8lajzgNWj1TubPMdc=
X-Received: by 2002:a05:600c:4754:b0:407:8f23:cf3 with SMTP id
 w20-20020a05600c475400b004078f230cf3mr4248593wmo.26.1697644708410; 
 Wed, 18 Oct 2023 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGCj2rvgStBpwuXdOYWyauJqGrAkiOsM63EY27kPIpvU8jseJR/84lqVcDYtzRTb164E1PQ==
X-Received: by 2002:a05:600c:4754:b0:407:8f23:cf3 with SMTP id
 w20-20020a05600c475400b004078f230cf3mr4248574wmo.26.1697644708078; 
 Wed, 18 Oct 2023 08:58:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004060f0a0fd5sm1996363wmq.13.2023.10.18.08.58.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:58:27 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:58:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 66/83] hw/isa/piix: Reuse PIIX3 base class' realize method in
 PIIX4
Message-ID: <f5d2d39a8c9d3294d71cb2ba12c5d796afe48723.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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


