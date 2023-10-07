Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D97BC7AF
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ae-00035w-35; Sat, 07 Oct 2023 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aQ-0002rz-IC
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aL-0002lk-Ko
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:13 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so506527966b.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682347; x=1697287147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHhCznu32X7eUOZC5foU2/KBStNeJAiZO96+pey2FmU=;
 b=NfUsEkvdV4jfzhnt0SEpdDARpXN+ZVnkKnc86gCDhNJoJIqv2oOcDwU4jhU70uWzjp
 68NDHAg0cK0ddYnH44t6FgwodN93amiUezLmws726iTJxqU2KTF2cS4374qOgRT5lfuc
 9kFN43SkHcJ9pUtsjSjdkft25UK5QLeTR/dQoDhikV6MnZdC9LEccG+j3WeOTj/Sg/VC
 0o92qUylYo3ErnAgzvQ9RqDXgjSzv/emmqbDjRNiaBiFOUqBqdMzOhn3sVsg43wuj51B
 DkGa92LssMLjRzYmQ34ZRNdrjVkAqCy/R8mHsz45f5I5FeU+8xCgdP8+qek3V4ngmVZc
 vdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682347; x=1697287147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHhCznu32X7eUOZC5foU2/KBStNeJAiZO96+pey2FmU=;
 b=lTwANACkpluVwTkIKfj8r23XwLeEbUtUcNHQme8mQA+0txqCGLFCft50V3pTg774Es
 gaWPSeCZdUdWmgoYGOuo7dxzHpLnl5SoAIHCNEKgFh1kNXezy6DKWp+gZU4SzjpGMK1I
 PFuLSuNFS7Q1+hhB8iaXgoI70YxBW9vcDqQomoTqgctj5CgCm2hkrQpNBg3cvG5L/bWo
 HIA7pGQWoGhGDnZ3Qz2+AquDgHAvY9mVI3+gJE8vE7lvMX13XC2ogYPNQoBhTO9FPyhS
 h+RElPpWeB+T2MIn2mJgfoD0IRJ4A1y93f6Ii7JHHCkobeb+DGml6dT8CbR+p7mpJgue
 Kr9g==
X-Gm-Message-State: AOJu0Yy2bhUMvzzI2N4n6ezNQgHOa7HXkLEzHWCHRCUoZDFMF3efGZF4
 wqbsj6J2fBDaxkt9TU0+BOWHVh9WJZQ=
X-Google-Smtp-Source: AGHT+IF0Um9d69nqpfKMjLoMohtipJyW4J7zlT16KRcgYsZMJX4Q8HEx4l02M5Lzvim65M7KKxSqbQ==
X-Received: by 2002:a17:907:7631:b0:9a2:256a:65cd with SMTP id
 jy17-20020a170907763100b009a2256a65cdmr8075396ejc.4.1696682346969; 
 Sat, 07 Oct 2023 05:39:06 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:06 -0700 (PDT)
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
Subject: [PATCH v8 13/29] hw/isa/piix3: Create power management controller in
 host device
Date: Sat,  7 Oct 2023 14:38:21 +0200
Message-ID: <20231007123843.127151-14-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62b.google.com
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

The power management controller is an integral part of PIIX3 (function 3). So
create it as part of the south bridge.

Note that the ACPI function is optional in QEMU. This is why it gets
object_initialize_child()'ed in realize rather than in instance_init.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
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
2.42.0


