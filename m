Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F27BC7AE
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6al-0003Js-MJ; Sat, 07 Oct 2023 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aP-0002rt-Jg
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:14 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aL-0002lc-KQ
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:13 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53829312d12so8971410a12.0
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682346; x=1697287146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PJizhQqu6HDUIEcNrVHCasa7JFEI6nWhKiovE24k5xk=;
 b=ncLsxO14ikk7PhPvY22wD+TdNigUWndyoVGA33WrXgR4aucmFzr071PQiMpZ5d0XOA
 t8OVga+WORNc9s9WL78CYURCII2IGQDRjHlOpnmgeZrVAi2n8r64HGO4z5HFB4H4eGti
 ws/9tVhxq7uupVwfbePotrbIpurTqUJ74Z/Y3zDXfl5Sij+uJO1//8h/txMrPDydo73A
 r0OEwUmgMDyxFuy9HNY3sMtGxRBHUv/PTGHRgoMEWwoVPFv5NAtRHu+7RCZVMS8WbrTd
 EoY7lmr7WpisOB8NLKFPL76qobxOaoHUr5vGZ3d9+WwbGh4j86V+MeV9jO84XH31pGGM
 HaRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682346; x=1697287146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PJizhQqu6HDUIEcNrVHCasa7JFEI6nWhKiovE24k5xk=;
 b=H+1Gp7Q2jqV5mAza4tmyD1wAvuNbME0AFUiF/HuShb1mUgmSza6E0X7Qpgs9UVtJNe
 7/ovT6gdsKrkXzhmY3rGOiViimvkeJyLjWZYm4PqRSZABNkKIIblesdNbFyck/eeJa3b
 jHCGIgdXvnyf8qBzaTUoqm2nJzN4u83OPX3ayLqNUXZ/uw9yyUc3P152QZSXHv3wYHkg
 LKWjhbAj2+P//Y8iIAAn7TMZmqvhRxFqNeKvej9s+Q39DSnPedDwlqZUo84jAwlG/6Jj
 8GaoIOCCio/oPt/NN/9uzGvshiQllHGagoZcNxD+/NK+Yix8qzzRLyRQwgZDhC7QjNqE
 tZig==
X-Gm-Message-State: AOJu0Yxf/bYxESO8eIYngZE6JqiwvQn9eq8zgaHxk+GvetWZOvxZXScO
 5w5OGSsHuKJKLsAHzbPjUhhCfoJ83ns=
X-Google-Smtp-Source: AGHT+IHz4v4rzMB5+uvSG0rL01aGI3Qz2BY+gopk9dew7QmbFH886+4khm41vvtyfFz3MoxUBdYFEg==
X-Received: by 2002:a17:907:3e1a:b0:9ae:699d:8a31 with SMTP id
 hp26-20020a1709073e1a00b009ae699d8a31mr9262106ejc.33.1696682345797; 
 Sat, 07 Oct 2023 05:39:05 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:05 -0700 (PDT)
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
Subject: [PATCH v8 12/29] hw/isa/piix3: Create USB controller in host device
Date: Sat,  7 Oct 2023 14:38:20 +0200
Message-ID: <20231007123843.127151-13-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x536.google.com
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

The USB controller is an integral part of PIIX3 (function 2). So create
it as part of the south bridge.

Note that the USB function is optional in QEMU. This is why it gets
object_initialize_child()'ed in realize rather than in instance_init.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  4 ++++
 hw/i386/pc_piix.c             |  7 ++-----
 hw/isa/piix3.c                | 16 ++++++++++++++++
 hw/isa/Kconfig                |  1 +
 4 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 1daeff397c..5cd866f1f2 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -15,6 +15,7 @@
 #include "hw/pci/pci_device.h"
 #include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "hw/usb/hcd-uhci.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -54,12 +55,15 @@ struct PIIXState {
 
     MC146818RtcState rtc;
     PCIIDEState ide;
+    UHCIState uhci;
 
     /* Reset Control Register contents */
     uint8_t rcr;
 
     /* IO memory region for Reset Control Register (PIIX_RCR_IOPORT) */
     MemoryRegion rcr_mem;
+
+    bool has_usb;
 };
 typedef struct PIIXState PIIX3State;
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c98a997482..8dcd6851d0 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -51,7 +51,6 @@
 #include "exec/memory.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/piix4.h"
-#include "hw/usb/hcd-uhci.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/xen.h"
@@ -265,6 +264,8 @@ static void pc_init1(MachineState *machine,
         size_t i;
 
         pci_dev = pci_new_multifunction(-1, TYPE_PIIX3_DEVICE);
+        object_property_set_bool(OBJECT(pci_dev), "has-usb",
+                                 machine_usb(machine), &error_abort);
         dev = DEVICE(pci_dev);
         for (i = 0; i < ISA_NUM_IRQS; i++) {
             qdev_connect_gpio_out_named(dev, "isa-irqs", i, x86ms->gsi[i]);
@@ -359,10 +360,6 @@ static void pc_init1(MachineState *machine,
     }
 #endif
 
-    if (pcmc->pci_enabled && machine_usb(machine)) {
-        pci_create_simple(pci_bus, piix3_devfn + 2, TYPE_PIIX3_USB_UHCI);
-    }
-
     if (pcmc->pci_enabled && x86_machine_is_acpi_enabled(X86_MACHINE(pcms))) {
         PCIDevice *piix4_pm;
 
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 3f1dabade0..aebc0da23b 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -298,6 +298,16 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
         return;
     }
+
+    /* USB */
+    if (d->has_usb) {
+        object_initialize_child(OBJECT(dev), "uhci", &d->uhci,
+                                TYPE_PIIX3_USB_UHCI);
+        qdev_prop_set_int32(DEVICE(&d->uhci), "addr", dev->devfn + 2);
+        if (!qdev_realize(DEVICE(&d->uhci), BUS(pci_bus), errp)) {
+            return;
+        }
+    }
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -332,6 +342,11 @@ static void pci_piix3_init(Object *obj)
     object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
 }
 
+static Property pci_piix3_props[] = {
+    DEFINE_PROP_BOOL("has-usb", PIIX3State, has_usb, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -352,6 +367,7 @@ static void pci_piix3_class_init(ObjectClass *klass, void *data)
      * pc_piix.c's pc_init1()
      */
     dc->user_creatable = false;
+    device_class_set_props(dc, pci_piix3_props);
     adevc->build_dev_aml = build_pci_isa_aml;
 }
 
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 28345edbb3..1076df69ca 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -37,6 +37,7 @@ config PIIX3
     select IDE_PIIX
     select ISA_BUS
     select MC146818RTC
+    select USB_UHCI
 
 config PIIX4
     bool
-- 
2.42.0


