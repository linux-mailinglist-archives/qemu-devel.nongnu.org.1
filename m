Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A47D2245
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUh8-0001o0-4L; Sun, 22 Oct 2023 05:24:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUh3-0001Zs-TC
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUh2-0000Xb-3w
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdW5p2c96Dn9Sqn4Mq3yZdrJbR8XrzKqICqhYWPrQfc=;
 b=Hnh46UDU2zwrce/Dx2b/v22aBYRS4fXM8TVCTFCJdzzQyfi/JfEcpNJiTs+vJRj618hsCz
 avIGVkd1jmhKalQINJGJHaVw53X+V7wYqyiCT9AgmIi0QadLf4xx8FcJmRdRQUWmQNpY6U
 mX1OwDvudhiYk/odDdQbboN4OK6XqBc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-8OHVsxOxOJOb0mPHelKI0g-1; Sun, 22 Oct 2023 05:24:17 -0400
X-MC-Unique: 8OHVsxOxOJOb0mPHelKI0g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40768556444so14528275e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966656; x=1698571456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wdW5p2c96Dn9Sqn4Mq3yZdrJbR8XrzKqICqhYWPrQfc=;
 b=TrOXge0ZlCAoYo+tWcW92KbiLcHTqvnM55hLwGmdM0bw0RvP/NKLiJDCWvwzi/LcPU
 32MOdqFMGqWumFpdZsQGib5Jx4EVshRc7pxI8oJTzJrCRv9Y+YXe6cF+HaKTM/RHkVg0
 eDObpJlW6+ChTlY4/zn9AuzWSFUi2Hp19Ead1MqENf1+x40IsX8iINKadCIwRRVPwwYh
 cLs0ZkpFyZuX4Q6JBZ95LSF+lJVBmaZZtwpL4dKhxtIpJMJaRqwZbYbo+r4rE7lg7rEt
 QMZrVVRXXxbHjXL+yKISCf2DtkgjbJ8Vb16v1pyxGHsY5kWoEX/qhXc9uCJnYA95r7+T
 72Yg==
X-Gm-Message-State: AOJu0YzbknDZKFQ1XA5lMr6Q/sCZrzw3nk9A7LOMOE24j4P2R/5dvSnB
 gdYg8hYJWfEX7I+wR6jfJ1RM7ruGZGfrIXbKmjYfLe8DEqJlxOcJOKuOyTSYMJs3alWyGyXIilp
 y2iKmD7UlzUUAmB2ey6B2pE+x0FTSGwV66yWsE8TXJhJei9cW5NZN4h9S45a2+Rw3Yu6U
X-Received: by 2002:a05:600c:1d9b:b0:408:3f61:cb4f with SMTP id
 p27-20020a05600c1d9b00b004083f61cb4fmr4539384wms.23.1697966656251; 
 Sun, 22 Oct 2023 02:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZdbcs1OE1IJUX7YaRzAA6Zjds8CcMOdkx5jlutG5DpKDjyxM+HciMulV110Km3kSc3zTFcw==
X-Received: by 2002:a05:600c:1d9b:b0:408:3f61:cb4f with SMTP id
 p27-20020a05600c1d9b00b004083f61cb4fmr4539364wms.23.1697966655915; 
 Sun, 22 Oct 2023 02:24:15 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 a3-20020adfe5c3000000b0032da40fd7bdsm5376739wrn.24.2023.10.22.02.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:24:15 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:24:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PULL v3 32/62] hw/isa/piix3: Create IDE controller in host device
Message-ID: <e47e5a5b79ffd6b3ca72ea383e3c756b68402735.1697966402.git.mst@redhat.com>
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

The IDE controller is an integral part of PIIX3 (function 1). So create it as
part of the south bridge.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231007123843.127151-12-shentey@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST


