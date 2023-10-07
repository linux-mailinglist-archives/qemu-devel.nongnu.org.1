Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5869C7BC7AD
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 14:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp6ae-00035V-2t; Sat, 07 Oct 2023 08:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aO-0002rW-6O
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:13 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qp6aL-0002lT-H2
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 08:39:11 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so8919640a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696682344; x=1697287144; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AI/vQxqgiKDopwuOm8efc8SEE6YBhEDYMZnTXHD+Zt4=;
 b=EB37Gxq2yLHdyoNAzaDqojoodToE5WqCMdMpOgxerOGQ5/iPRR8AwS3IPf6NP4u5yP
 JakqTp8SDV/NyOd3cfeOFAg3u1QWNXaNW/hLYo/uukBiAPyWJC7AA3aVRXc++27aq/aA
 fiJ4yAywFJQ9L3ycefdCXO6n9iYHeANNmlL5oG5VG8/lquytdRzP0cUodm0blAe/hx6X
 8EtilVec/s6kGwYO/7LDVOR+BsC+mIWgf1ipxxlSNVi1ga40L4NqyNg9hSRk38qYZI7k
 H95swphtYV2FHYnw09AYmmKMWwWgBOVzmpd0k797jpkKUL+tEbVfst54r0VZeNh7dv+3
 5JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696682344; x=1697287144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AI/vQxqgiKDopwuOm8efc8SEE6YBhEDYMZnTXHD+Zt4=;
 b=KEBKkD+lTnrSgTIlVYT8On/WCnVJaXK3oTtvYhFhqvTvkDPaVKDqwHQc/gDXCkz7DS
 Ja1YgzAM+QpDF/2ndUeA0efTQiqdquJoZiFSLK4gTiBXRp1pqTzpV1viG6nO5//NpQqQ
 aYpXi7Imr6X8KK3ERJdNFts4VTxm9+doh6FjB8uamrYW2+sUQ8COli+kgSVyVkMtkVvn
 0NC1d7HC7rh58OjxtBOTqfQhiO1UibP2o7dtnkiae1OMBEWHV1165xtLE0eg8z5eIpwe
 HYv6in3qRaKuHzch0NZN2OtiQG8Pp0Sr5rTdsNRXfEq9lDopR8NeAOjgq7nzyLqkRKrd
 F0+Q==
X-Gm-Message-State: AOJu0YyiUalOzyqDbS+oFa5bSVPjVCZ/P6itj+jCYyVUJwn7rPEpBkLC
 OxVwFUTgJxt7IUkqkv3DqOjJlCErixE=
X-Google-Smtp-Source: AGHT+IEdjyXGyWY45N1only04KT6KY2T7L8aD+oKa++j3yloAwmsCPbzS9LAtJKVkxI//Hbql/PXJQ==
X-Received: by 2002:a17:906:c106:b0:9b8:df8e:cbd0 with SMTP id
 do6-20020a170906c10600b009b8df8ecbd0mr5036667ejc.37.1696682344628; 
 Sat, 07 Oct 2023 05:39:04 -0700 (PDT)
Received: from archlinux.. (pd95eda61.dip0.t-ipconnect.de. [217.94.218.97])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a170906045b00b009b655c43710sm4241401eja.24.2023.10.07.05.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 05:39:03 -0700 (PDT)
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
Subject: [PATCH v8 11/29] hw/isa/piix3: Create IDE controller in host device
Date: Sat,  7 Oct 2023 14:38:19 +0200
Message-ID: <20231007123843.127151-12-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231007123843.127151-1-shentey@gmail.com>
References: <20231007123843.127151-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x534.google.com
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

The IDE controller is an integral part of PIIX3 (function 1). So create it as
part of the south bridge.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/southbridge/piix.h |  2 ++
 hw/i386/pc_piix.c             | 13 ++++++-------
 hw/isa/piix3.c                |  9 +++++++++
 hw/i386/Kconfig               |  1 -
 hw/isa/Kconfig                |  1 +
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index b07ff6bb26..1daeff397c 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -13,6 +13,7 @@
 #define HW_SOUTHBRIDGE_PIIX_H
 
 #include "hw/pci/pci_device.h"
+#include "hw/ide/pci.h"
 #include "hw/rtc/mc146818rtc.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
@@ -52,6 +53,7 @@ struct PIIXState {
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
 
     MC146818RtcState rtc;
+    PCIIDEState ide;
 
     /* Reset Control Register contents */
     uint8_t rcr;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 5988656279..c98a997482 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -43,7 +43,6 @@
 #include "net/net.h"
 #include "hw/ide/isa.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/piix.h"
 #include "hw/irq.h"
 #include "sysemu/kvm.h"
 #include "hw/i386/kvm/clock.h"
@@ -290,6 +289,10 @@ static void pc_init1(MachineState *machine,
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
         rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
                                                              "rtc"));
+        dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
+        pci_ide_create_devs(PCI_DEVICE(dev));
+        idebus[0] = qdev_get_child_bus(dev, "ide.0");
+        idebus[1] = qdev_get_child_bus(dev, "ide.1");
     } else {
         isa_bus = isa_bus_new(NULL, system_memory, system_io,
                               &error_abort);
@@ -301,6 +304,8 @@ static void pc_init1(MachineState *machine,
 
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
+        idebus[0] = NULL;
+        idebus[1] = NULL;
     }
 
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
@@ -329,12 +334,6 @@ static void pc_init1(MachineState *machine,
     pc_nic_init(pcmc, isa_bus, pci_bus);
 
     if (pcmc->pci_enabled) {
-        PCIDevice *dev;
-
-        dev = pci_create_simple(pci_bus, piix3_devfn + 1, TYPE_PIIX3_IDE);
-        pci_ide_create_devs(dev);
-        idebus[0] = qdev_get_child_bus(&dev->qdev, "ide.0");
-        idebus[1] = qdev_get_child_bus(&dev->qdev, "ide.1");
         pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
     }
 #ifdef CONFIG_IDE_ISA
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 11d72ca2bb..3f1dabade0 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -29,6 +29,7 @@
 #include "hw/southbridge/piix.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
+#include "hw/ide/piix.h"
 #include "hw/isa/isa.h"
 #include "sysemu/runstate.h"
 #include "migration/vmstate.h"
@@ -265,6 +266,7 @@ static const MemoryRegionOps rcr_ops = {
 static void pci_piix3_realize(PCIDevice *dev, Error **errp)
 {
     PIIX3State *d = PIIX3_PCI_DEVICE(dev);
+    PCIBus *pci_bus = pci_get_bus(dev);
     ISABus *isa_bus;
     uint32_t irq;
 
@@ -290,6 +292,12 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
     }
     irq = object_property_get_uint(OBJECT(&d->rtc), "irq", &error_fatal);
     isa_connect_gpio_out(ISA_DEVICE(&d->rtc), 0, irq);
+
+    /* IDE */
+    qdev_prop_set_int32(DEVICE(&d->ide), "addr", dev->devfn + 1);
+    if (!qdev_realize(DEVICE(&d->ide), BUS(pci_bus), errp)) {
+        return;
+    }
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -321,6 +329,7 @@ static void pci_piix3_init(Object *obj)
                              ISA_NUM_IRQS);
 
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
+    object_initialize_child(obj, "ide", &d->ide, TYPE_PIIX3_IDE);
 }
 
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 9051083c1e..ade817f1b6 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -73,7 +73,6 @@ config I440FX
     select PC_ACPI
     select PCI_I440FX
     select PIIX3
-    select IDE_PIIX
     select DIMM
     select SMBIOS
     select FW_CFG_DMA
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index c10cbc5fc1..28345edbb3 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -34,6 +34,7 @@ config PC87312
 config PIIX3
     bool
     select I8257
+    select IDE_PIIX
     select ISA_BUS
     select MC146818RTC
 
-- 
2.42.0


