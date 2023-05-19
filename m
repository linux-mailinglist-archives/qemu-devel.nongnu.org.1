Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112F7091FC
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 10:48:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzvmO-0005Mj-Pn; Fri, 19 May 2023 04:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmI-0005Lv-Iy
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:58 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1pzvmB-0006n7-2y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 04:47:58 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-965ddb2093bso479822366b.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 01:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684486069; x=1687078069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+NwVQ3ejxlH7YR8dkOSH78rrdMKWon16MrLOLnJRVU=;
 b=B+0HcU4LpGaIoX7r8QpTzFOPQlDpD04guY75xan+0weGtZ0bHYmFdKDltXsSTo6AW2
 SBZKWqLuM5mLHiHy/QswKLUraNvRp4/xEbHS/YoM7bwRu4YZBiIgubDNlCtkujHUNkOA
 g92uhOH1QXWy21A0p1Y5QhAbiYI0ZIhUzbwD/WDR28+sLP4szPf0317YdpSwSq+0ECkN
 /kme3eXi/QmLXKOXIagJExIWp8v/CorEXRZYfPRDoSmScN74ALidAjdOnRckXS+Pulv7
 b8qjvLpmLXAVVwc7ViyubHe9W9yLqVHO8W/XVM3Qzcmyz1I2AZi16OUQr31d/C5ba9xy
 zRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684486069; x=1687078069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O+NwVQ3ejxlH7YR8dkOSH78rrdMKWon16MrLOLnJRVU=;
 b=HYZ/D2NyBvghcn0tHrADrZab/CWlTWC3shNSGMpir5HuNCLxg9AF7lPRbDDlZCVqqS
 WxxSBZWAsyfJq2V9tQy0kURLhxIWd00bsCUgiXzvU2nyA8R0HPmi+T2HfHz0SiOMtcF0
 CL2UD/A63BoQBk1PFSUkHov9oTtSdAbxThBNcjivBPYobtAlqVY+O6Z3fBVxDU87Lf53
 Wo4B5tMeFoj48xSxvzAmb+fHhq3lYLro7bOm1mkOICqUxtAQy++jIJn/tf+pFQeaKL+U
 a1KQiXeqo7Rq4qFe5TKur3BhLRhoUPtiugA8JzAHFblsdpLInjO9WV423/3D+AaNUnTs
 q6CQ==
X-Gm-Message-State: AC+VfDyufhGE1opXXVCLVGCnSl1ou47SbuGzE1SeEMocM9RgpuBnZkQY
 s8f5ULW6yZquaqCz3gsiHKLMbwqKzik=
X-Google-Smtp-Source: ACHHUZ65fZKNlFJ5LvZgo8Lrb0SI0UoHhWxHoEu1pyC0JR01TnQJhCyGX9d5ME7/gBn5vOyL6Vo3nA==
X-Received: by 2002:a17:907:2bcc:b0:969:e304:7a1d with SMTP id
 gv12-20020a1709072bcc00b00969e3047a1dmr891083ejc.50.1684486068534; 
 Fri, 19 May 2023 01:47:48 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-014-126-098.89.14.pool.telefonica.de. [89.14.126.98])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170906078900b0096621340285sm2000893ejc.198.2023.05.19.01.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 01:47:48 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/2] hw/i386/pc: Create RTC controllers in south bridges
Date: Fri, 19 May 2023 10:47:33 +0200
Message-Id: <20230519084734.220480-2-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519084734.220480-1-shentey@gmail.com>
References: <20230519084734.220480-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Just like in the real hardware (and in PIIX4), create the RTC
controllers in the south bridges.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20221022150508.26830-11-shentey@gmail.com>
---
 include/hw/southbridge/ich9.h |  2 ++
 include/hw/southbridge/piix.h |  3 +++
 hw/i386/pc.c                  | 12 +++++++++++-
 hw/i386/pc_piix.c             |  8 ++++++++
 hw/i386/pc_q35.c              |  2 ++
 hw/isa/lpc_ich9.c             |  8 ++++++++
 hw/isa/piix3.c                | 15 +++++++++++++++
 hw/isa/Kconfig                |  2 ++
 8 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 7004eecbf9..fd01649d04 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -6,6 +6,7 @@
 #include "hw/intc/ioapic.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_device.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "exec/memory.h"
 #include "qemu/notify.h"
 #include "qom/object.h"
@@ -30,6 +31,7 @@ struct ICH9LPCState {
     */
     uint8_t irr[PCI_SLOT_MAX][PCI_NUM_PINS];
 
+    MC146818RtcState rtc;
     APMState apm;
     ICH9LPCPMRegs pm;
     uint32_t sci_level; /* track sci level */
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index 0bf48e936d..a840340308 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -13,6 +13,7 @@
 #define HW_SOUTHBRIDGE_PIIX_H
 
 #include "hw/pci/pci_device.h"
+#include "hw/rtc/mc146818rtc.h"
 
 /* PIRQRC[A:D]: PIRQx Route Control Registers */
 #define PIIX_PIRQCA 0x60
@@ -51,6 +52,8 @@ struct PIIXState {
     /* This member isn't used. Just for save/load compatibility */
     int32_t pci_irq_levels_vmstate[PIIX_NUM_PIRQS];
 
+    MC146818RtcState rtc;
+
     /* Reset Control Register contents */
     uint8_t rcr;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d761c8c775..2bf7de694e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1318,7 +1318,17 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         pit_alt_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_PIT_INT);
         rtc_irq = qdev_get_gpio_in(hpet, HPET_LEGACY_RTC_INT);
     }
-    *rtc_state = ISA_DEVICE(mc146818_rtc_init(isa_bus, 2000, rtc_irq));
+
+    if (rtc_irq) {
+        qdev_connect_gpio_out(DEVICE(*rtc_state), 0, rtc_irq);
+    } else {
+        uint32_t irq = object_property_get_uint(OBJECT(*rtc_state),
+                                                "irq",
+                                                &error_fatal);
+        isa_connect_gpio_out(*rtc_state, 0, irq);
+    }
+    object_property_add_alias(OBJECT(pcms), "rtc-time", OBJECT(*rtc_state),
+                              "date");
 
 #ifdef CONFIG_XEN_EMU
     if (xen_mode == XEN_EMULATE) {
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 66a849d279..682f51577c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -32,6 +32,7 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/apic.h"
 #include "hw/pci-host/i440fx.h"
+#include "hw/rtc/mc146818rtc.h"
 #include "hw/southbridge/piix.h"
 #include "hw/display/ramfb.h"
 #include "hw/firmware/smbios.h"
@@ -240,10 +241,17 @@ static void pc_init1(MachineState *machine,
         piix3->pic = x86ms->gsi;
         piix3_devfn = piix3->dev.devfn;
         isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(piix3), "isa.0"));
+        rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(pci_dev),
+                                                             "rtc"));
     } else {
         pci_bus = NULL;
         isa_bus = isa_bus_new(NULL, get_system_memory(), system_io,
                               &error_abort);
+
+        rtc_state = isa_new(TYPE_MC146818_RTC);
+        qdev_prop_set_int32(DEVICE(rtc_state), "base_year", 2000);
+        isa_realize_and_unref(rtc_state, isa_bus, &error_fatal);
+
         i8257_dma_init(isa_bus, 0);
         pcms->hpet_enabled = false;
     }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f02919d92c..2bbd0d02df 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -242,6 +242,8 @@ static void pc_q35_init(MachineState *machine)
                       x86_machine_is_smm_enabled(x86ms));
     pci_realize_and_unref(lpc, host_bus, &error_fatal);
 
+    rtc_state = ISA_DEVICE(object_resolve_path_component(OBJECT(lpc), "rtc"));
+
     object_property_add_link(OBJECT(machine), PC_MACHINE_ACPI_DEVICE_PROP,
                              TYPE_HOTPLUG_HANDLER,
                              (Object **)&x86ms->acpi_dev,
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 9714b0001e..9c47a2f6c7 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -658,6 +658,8 @@ static void ich9_lpc_initfn(Object *obj)
     static const uint8_t acpi_enable_cmd = ICH9_APM_ACPI_ENABLE;
     static const uint8_t acpi_disable_cmd = ICH9_APM_ACPI_DISABLE;
 
+    object_initialize_child(obj, "rtc", &lpc->rtc, TYPE_MC146818_RTC);
+
     object_property_add_uint8_ptr(obj, ACPI_PM_PROP_SCI_INT,
                                   &lpc->sci_gsi, OBJ_PROP_FLAG_READ);
     object_property_add_uint8_ptr(OBJECT(lpc), ACPI_PM_PROP_ACPI_ENABLE_CMD,
@@ -723,6 +725,12 @@ static void ich9_lpc_realize(PCIDevice *d, Error **errp)
 
     i8257_dma_init(isa_bus, 0);
 
+    /* RTC */
+    qdev_prop_set_int32(DEVICE(&lpc->rtc), "base_year", 2000);
+    if (!qdev_realize(DEVICE(&lpc->rtc), BUS(isa_bus), errp)) {
+        return;
+    }
+
     pci_bus_irqs(pci_bus, ich9_lpc_set_irq, d, ICH9_LPC_NB_PIRQS);
     pci_bus_map_irqs(pci_bus, ich9_lpc_map_irq);
     pci_bus_set_route_irq_fn(pci_bus, ich9_route_intx_pin_to_irq);
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index a9cb39bf21..f9103ea45a 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -28,6 +28,7 @@
 #include "hw/dma/i8257.h"
 #include "hw/southbridge/piix.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
 #include "hw/xen/xen.h"
 #include "sysemu/runstate.h"
@@ -301,6 +302,12 @@ static void pci_piix3_realize(PCIDevice *dev, Error **errp)
                                         PIIX_RCR_IOPORT, &d->rcr_mem, 1);
 
     i8257_dma_init(isa_bus, 0);
+
+    /* RTC */
+    qdev_prop_set_int32(DEVICE(&d->rtc), "base_year", 2000);
+    if (!qdev_realize(DEVICE(&d->rtc), BUS(isa_bus), errp)) {
+        return;
+    }
 }
 
 static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
@@ -324,6 +331,13 @@ static void build_pci_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
     qbus_build_aml(bus, scope);
 }
 
+static void pci_piix3_init(Object *obj)
+{
+    PIIX3State *d = PIIX3_PCI_DEVICE(obj);
+
+    object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
+}
+
 static void pci_piix3_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -350,6 +364,7 @@ static const TypeInfo piix3_pci_type_info = {
     .name = TYPE_PIIX3_PCI_DEVICE,
     .parent = TYPE_PCI_DEVICE,
     .instance_size = sizeof(PIIX3State),
+    .instance_init = pci_piix3_init,
     .abstract = true,
     .class_init = pci_piix3_class_init,
     .interfaces = (InterfaceInfo[]) {
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 0156a66889..c10cbc5fc1 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -35,6 +35,7 @@ config PIIX3
     bool
     select I8257
     select ISA_BUS
+    select MC146818RTC
 
 config PIIX4
     bool
@@ -79,3 +80,4 @@ config LPC_ICH9
     select I8257
     select ISA_BUS
     select ACPI_ICH9
+    select MC146818RTC
-- 
2.40.1


