Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CBC7BC79E
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6am-0003SL-VZ; Sat, 07 Oct 2023 08:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6ac-00036j-C3
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aZ-0002pl-6G
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:26 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9ae7383b7ecso911938566b.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682360; x=1697287160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XtaCDwg2mGV3kd56ifXmbZYU3vHAg6SkLi3rmA4zjv8=;
 b=EpiFq390bS7vkyCYKHv0v29Au5y/bmt7NDk+ck5ivgJRdEdGXDdqY3U6F32DUmEkby
 omoDjyK1x8dQyIqzaOb3xpeul/hPHRMJRReNWAaeD1k+pUkjkJGfK5aTBzHaiM/iyQdz
 r7k0h9Zmvzh8j+p7nkK3/f7EmsK22qu5y7Y0h5BBfhSOi7V+RXPSBJg1m9kx3HNg9b8j
 KUtR9Tyuq/xMWfc2tOHqNeD9ZanE4lmfIbpXldCRc4nweXrbERrIYk+4E1BsyTdPvWRV
 g454hmFoAfPibPMX5Aya5JzjNmzG0xEdc210aUlHyJ94+eIRD2IJF4xZIgmLVB0JaOXu
 /vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682360; x=1697287160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XtaCDwg2mGV3kd56ifXmbZYU3vHAg6SkLi3rmA4zjv8=;
 b=wEWiN+63U4gW6uZwR2R92K6i76Cr/u7uTnVvXeRV3yHd8RAy4WqucEHHAjDAcrFAzE
 u7tBGmTo/bqouiY3sDBN0KXzQE9saNyojxlyjQyJetkrxUpuDaisP3Kv73iuuEf0Kjo6
 J1BGpdJ3t+1umrvKL/j18JuzP80nx/x0lKtL0uePSQRp5t20WfSIeoUvWQYO70iVgMM4
 GrQqX8/3dRE9jhqT02jHDIilMJ43sEe8fCrTuufc/zOen1xP4Z2cqddBaBSieRbw2AoP
 wxMHvHaXvqYngmuTIVnQ1Uxw8ftnIHg3Ru0dN820cSh4twvEbMQ7Jl25wgiwcezcM8Qr
 p1Ug==
X-Gm-Message-State: AOJu0YyctzlIgNhwBapZY40zC1wTTj5U735SDIarNt1HT3Vv+ZEgzzCm
 KK5Dlu+rjGNWBWNRGs2YlI4lI7rEkCE=
X-Google-Smtp-Source: AGHT+IGZEoVXrsWp/6b9r/3kUNJWaon6DsR3v1Qvbs42EsJS9zX2v7t+DE0lZlb9lkuq6NcBThxtgQ==
X-Received: by 2002:a17:906:99c5:b0:9ae:3768:f0ce with SMTP id
 s5-20020a17090699c500b009ae3768f0cemr6537592ejn.0.1696682360322; 
 Sat, 07 Oct 2023 05:39:20 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:19 -0700 (PDT)
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
Subject: [PATCH v8 24/29] hw/isa/piix: Reuse PIIX3 base class' realize method
 in PIIX4
Date: Sat,  7 Oct 2023 14:38:32 +0200
Message-ID: <20231007123843.127151-25-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Resolves duplicate code. Also makes PIIX4 respect the PIIX3 properties which get
added, too. This allows for using PIIX4 in the PC machine.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
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
@@ -513,71 +513,14 @@ static const TypeInfo piix3_info = {
 
 static void piix4_realize(PCIDevice *dev, Error **errp)
 {
+    ERRP_GUARD();
     PIIXState *s = PIIX_PCI_DEVICE(dev);
     PCIBus *pci_bus = pci_get_bus(dev);
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
+    pci_piix_realize(dev, TYPE_PIIX4_USB_UHCI, errp);
+    if (*errp) {
         return;
     }
-    qdev_connect_gpio_out(DEVICE(&s->pm), 0, s->isa_irqs_in[9]);
 
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
2.42.0


