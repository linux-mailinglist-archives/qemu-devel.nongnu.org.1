Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76507D222A
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:24:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUhH-0002ng-1p; Sun, 22 Oct 2023 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhE-0002de-72
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUhC-0000ZM-BW
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZy/qcc3rYAioh5DSCyMc5Ebvruw/qgaRKdAdK5HreA=;
 b=Xd3yCPVWKBQOo6OixAc4UWo+ypoMSKWlo7D55MwRrRDrxfY1Ks+A0ltKtesqQ4IEGAztUe
 /qMjVyUrnSeB7DTOHrzbcVsT45JMZqAxKAO4EI8or4P3NBH4Oqtpoj42+CdPnfqvbnfwUE
 2D6bjLv/nfHYeKddVghBToSGveKi76Y=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-tKHEbfVRMES7lZpVgZbS1w-1; Sun, 22 Oct 2023 05:24:28 -0400
X-MC-Unique: tKHEbfVRMES7lZpVgZbS1w-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079f6c127cso2175660e87.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966666; x=1698571466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZy/qcc3rYAioh5DSCyMc5Ebvruw/qgaRKdAdK5HreA=;
 b=OAsUdW0JscX/kPNlWx4OuUfVM0IIdHn2kUPstOLmdYDj8ZiUMUXikZlmti17Lt10pj
 wwGlPzHBIf8HnXPHlB0zCAexi3S2Sc5IWs0NUM+rcgSXVArpGCFD1HQhbBNczZ0IZiTw
 xFEq20YDrbRGo9zWf420Cu3yYUw6d6sTFcTDZbcyxfvzaXcZy/9TgoFmbOb2q4y0hvFp
 K4H+sWlpTIzdTYkbNkto9cn4i+lhHhyFEWcEyQfodEEMNOrugrTfY6JYl5LkrbVBWFOD
 rEPskEWDdFLnn2pwOsSU+VtuxukGELC/kFUq9nPj2WwQrSM69AQt9Qyw1okuJIjDOdsI
 TfQQ==
X-Gm-Message-State: AOJu0YxPlFLvWoW7HOJNzjEATWCDSZBX45HS6oJIKg8x8YyUIFYDSlx/
 Rs0nu5doXdE9C541VDfmUXbahHlrlfu/z2QJYCZIdKQ632A+d7vpzZIbrLe92fzri2Pcb/LsNw/
 bbIPCFE3e9YmbJK6y8sUYXx+w8UXYL9pEEfv9PaVUL1k8fahiMFUvZUwXnQkV6FolVk96
X-Received: by 2002:ac2:4105:0:b0:503:446:c7b0 with SMTP id
 b5-20020ac24105000000b005030446c7b0mr3618032lfi.32.1697966665875; 
 Sun, 22 Oct 2023 02:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtInPHllQlW3slKa5O9nQmGnzly1Ls4Xnw7K3AjEFrX49cnMGXWbYMKBjF/oJbV87cL71Sxw==
X-Received: by 2002:ac2:4105:0:b0:503:446:c7b0 with SMTP id
 b5-20020ac24105000000b005030446c7b0mr3618010lfi.32.1697966665365; 
 Sun, 22 Oct 2023 02:24:25 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 k17-20020a5d6291000000b003217cbab88bsm5288849wru.16.2023.10.22.02.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:24 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>
Subject: [PULL v3 34/62] hw/isa/piix3: Create power management controller in
 host device
Message-ID: <0a15cf0801815a359af211361fba309a2cc5c1e8.1697966402.git.mst@redhat.com>
References: <cover.1697966402.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697966402.git.mst@redhat.com>
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

The power management controller is an integral part of PIIX3 (function 3). So
create it as part of the south bridge.

Note that the ACPI function is optional in QEMU. This is why it gets
object_initialize_child()'ed in realize rather than in instance_init.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-14-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  6 ++++++
 hw/i386/pc_piix.c             | 24 +++++++++++-------------
 hw/isa/piix3.c                | 15 +++++++++++++++
 hw/isa/Kconfig                |  1 +
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 5cd866f1f2..c56ce49fd3 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -13,6 +13,7 @@
 #define HW_SOUTHBRIDGE_PIIX_H
 
 #include "hw/pci/pci_device.h"
+#include "hw/acpi/piix4.h"
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "hw/usb/hcd-uhci.h"
@@ -56,6 +57,9 @@ struct PIIXState {
     MC146818RtcState rtc;
     PCIIDEState ide;
     UHCIState uhci;
+    PIIX4PMState pm;
+
+    uint32_t smb_io_base;
 
     /* Reset Control Register contents */
     uint8_t rcr;
@@ -63,7 +67,9 @@ struct PIIXState {
     /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
     MemoryRegion rcr_mem;
 
+    bool has_acpi;
     bool has_usb;
+    bool smm_enabled;
 };
 typedef struct PIIXState PIIX3State;
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8dcd6851d0..70cffcfe4f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -50,7 +50,6 @@
 #include "hw/i2c/smbus_eeprom.h"
 #include "exec/memory.h"
 #include "hw/acpi/acpi.h"
-#include "hw/acpi/piix4.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/xen.h"
@@ -115,7 +114,7 @@ static void pc_init1(MachineState *machine,
     MemoryRegion *system_io = get_system_io();
     PCIBus *pci_bus = NULL;
     ISABus *isa_bus;
-    int piix3_devfn = -1;
+    Object *piix4_pm = NULL;
     qemu_irq smi_irq;
     GSIState *gsi_state;
     BusState *idebus[MAX_IDE_BUS];
@@ -266,6 +265,13 @@ static void pc_init1(MachineState *machine,
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
         object_property_set_bool(OBJECT(pci_dev), "has-usb",
                                  machine_usb(machine), &error_abort);
+        object_property_set_bool(OBJECT(pci_dev), "has-acpi",
+                                 x86_machine_is_acpi_enabled(x86ms),
+                                 &error_abort);
+        qdev_prop_set_uint32(DEVICE(pci_dev), "smb_io_base", 0xb100);
+        object_property_set_bool(OBJECT(pci_dev), "smm-enabled",
+                                 x86_machine_is_smm_enabled(x86ms),
+                                 &error_abort);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -286,10 +292,10 @@ static void pc_init1(MachineState *machine,
                          XEN_IOAPIC_NUM_PIRQS);
         }
 
-        piix3_devfn = pci_dev->devfn;
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
+        piix4_pm = object_resolve_path_component(OBJECT(pci_dev), "pm");
         dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
         pci_ide_create_devs(PCI_DEVICE(dev));
         idebus[0] = qdev_get_child_bus(dev, "ide.0");
@@ -360,17 +366,9 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    if (pcmc->pci_enabled && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
-        PCIDevice *piix4_pm;
-
+    if (piix4_pm) {
         smi_irq = qemu_allocate_irq(pc_acpi_smi_interrupt, first_cpu, 0);
-        piix4_pm = pci_new(piix3_devfn + 3, TYPE_PIIX4_PM);
-        qdev_prop_set_uint32(DEVICE(piix4_pm), "smb_io_base", 0xb100);
-        qdev_prop_set_bit(DEVICE(piix4_pm), "smm-enabled",
-                          x86_machine_is_smm_enabled(x86ms));
-        pci_realize_and_unref(piix4_pm, pci_bus, &error_fatal);
 
-        qdev_connect_gpio_out(DEVICE(piix4_pm), 0, x86ms->gsi[9]);
         qdev_connect_gpio_out_named(DEVICE(piix4_pm), "smi-irq", 0, smi_irq);
         pcms->smbus = I2C_BUS(qdev_get_child_bus(DEVICE(piix4_pm), "i2c"));
         /* TODO: Populate SPD eeprom data.  */
@@ -382,7 +380,7 @@ static void pc_init1(MachineState *machine,
                                  object_property_allow_set_link,
                                  OBJ_PROP_LINK_STRONG);
         object_property_set_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
-                                 OBJECT(piix4_pm), &error_abort);
+                                 piix4_pm, &error_abort);
     }
 
     if (machine->nvdimms_state->is_enabled) {
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index aebc0da23b..5b867df299 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -308,6 +308,18 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
             return;
         }
     }
+
+    /* Power Management */
+    if (d->has_acpi) {
+        object_initialize_child(OBJECT(d), "pm", &d->pm, TYPE_PIIX4_PM);
+        qdev_prop_set_int32(DEVICE(&d->pm), "addr", dev->devfn + 3);
+        qdev_prop_set_uint32(DEVICE(&d->pm), "smb_io_base", d->smb_io_base);
+        qdev_prop_set_bit(DEVICE(&d->pm), "smm-enabled", d->smm_enabled);
+        if (!qdev_realize(DEVICE(&d->pm), BUS(pci_bus), errp)) {
+            return;
+        }
+        qdev_connect_gpio_out(DEVICE(&d->pm), 0, d->isa_irqs_in[9]);
+    }
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -343,7 +355,10 @@ static void pci_piix3_init(Object *obj)
 }
 
 static Property pci_piix3_props[] = {
+    DEFINE_PROP_UINT32("smb_io_base", PIIX3State, smb_io_base, 0),
+    DEFINE_PROP_BOOL("has-acpi", PIIX3State, has_acpi, true),
     DEFINE_PROP_BOOL("has-usb", PIIX3State, has_usb, true),
+    DEFINE_PROP_BOOL("smm-enabled", PIIX3State, smm_enabled, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 1076df69ca..17ddb25afc 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -33,6 +33,7 @@ config PC87312
 
 config PIIX3
     bool
+    select ACPI_PIIX4
     select I8257
     select IDE_PIIX
     select ISA_BUS
-- 
MST


