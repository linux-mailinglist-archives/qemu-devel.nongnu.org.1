Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 998257532A2
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 09:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKCwL-0006Pn-5J; Fri, 14 Jul 2023 03:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwI-0006PS-LH; Fri, 14 Jul 2023 03:10:06 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qKCwF-0005AW-Jg; Fri, 14 Jul 2023 03:10:06 -0400
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-1b8baa836a5so11996065ad.1; 
 Fri, 14 Jul 2023 00:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689318601; x=1691910601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MmN4AmYZCbrFYM+lZ6FHPAFLa3R6ETnHvzsiJAzY5YE=;
 b=Reaa7g1Zi6C4ZcWoXUSrtbOE76/qvxbwK2ngzXXB7LsZWgYrkxNeaJV0K9RQk12Zuj
 NtcCebLLVMLTaJa/RVa+gXesrU6Gj5Uj3U7i7d3ZCaQOgN3zb77clXgfW7SlqW4llM2o
 5qJmaQJQZt/UnhwBNY8/T4Zh3LOz9/dKms2eKwyLalPO8fcDZzTRINTQxoSQPKCyJaWN
 ge+MMIOg1YHDMoh4kdhgKE7fCCfLzg/f2fCncXxfX2bgYPxBot6AcOIbmAIGGNxpqkZd
 iShlTA1cKujdP+76IQ9KhmPjJqyUDmEvJrosCEYGctp3Xw35H6IIJTugQ/dorwYyK9+W
 l7xA==
X-Gm-Message-State: ABy/qLYpHHFcqwPjoBXkCBk80esOxGN2ODHfrQIWLYaX9W1k1kgieL6a
 g+TfHqQrp0BN/HB1oDb8efaebF+a8xiiNg==
X-Google-Smtp-Source: APBJJlHDNiV7RE2KTCw2nXUc1AkbBe2Hxf9SpjJziosrLqjd2dwSqd25nMY0bG21pxd9uwNWvY2G8A==
X-Received: by 2002:a17:902:eac5:b0:1b8:ae62:a239 with SMTP id
 p5-20020a170902eac500b001b8ae62a239mr3927048pld.34.1689318601417; 
 Fri, 14 Jul 2023 00:10:01 -0700 (PDT)
Received: from localhost.localdomain
 ([2607:fb90:dd17:8dad:e558:8948:1ff6:c8c1])
 by smtp.gmail.com with ESMTPSA id
 t8-20020a170902b20800b001b89466a5f4sm7041513plr.105.2023.07.14.00.09.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 14 Jul 2023 00:10:01 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-arm@nongnu.org (open list:ARM ACPI Subsystem)
Subject: [PATCH v2 09/11] tpm_tis_sysbus: move DSDT AML generation to device
Date: Fri, 14 Jul 2023 00:09:25 -0700
Message-ID: <20230714070931.23476-10-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714070931.23476-1-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.175; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f175.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This reduces redundent code in different machine types with ACPI table
generation. Additionally, this will allow us to support multiple TPM
interfaces. Finally, this matches up with the TPM TIS ISA
implementation.

Ideally, we would be able to call `qbus_build_aml` and avoid any TPM
specific code in the ACPI table generation. However, currently we
still have to call `build_tpm2` anyways and it does not look like
most other ACPI devices support the `ACPI_DEV_AML_IF` interface.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 hw/arm/virt-acpi-build.c  | 38 ++------------------------------------
 hw/loongarch/acpi-build.c | 38 ++------------------------------------
 hw/tpm/tpm_tis_sysbus.c   | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 72 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 6b674231c2..49b2f19440 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -35,6 +35,7 @@
 #include "target/arm/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/acpi_aml_interface.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/aml-build.h"
@@ -208,41 +209,6 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(scope, dev);
 }
 
-#ifdef CONFIG_TPM
-static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
-{
-    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
-    hwaddr pbus_base = vms->memmap[VIRT_PLATFORM_BUS].base;
-    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
-    MemoryRegion *sbdev_mr;
-    hwaddr tpm_base;
-
-    if (!sbdev) {
-        return;
-    }
-
-    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    assert(tpm_base != -1);
-
-    tpm_base += pbus_base;
-
-    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
-
-    Aml *dev = aml_device("TPM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
-    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-
-    Aml *crs = aml_resource_template();
-    aml_append(crs,
-               aml_memory32_fixed(tpm_base,
-                                  (uint32_t)memory_region_size(sbdev_mr),
-                                  AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-}
-#endif
-
 #define ID_MAPPING_ENTRY_SIZE 20
 #define SMMU_V3_ENTRY_SIZE 68
 #define ROOT_COMPLEX_ENTRY_SIZE 36
@@ -891,7 +857,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
 
     acpi_dsdt_add_power_button(scope);
 #ifdef CONFIG_TPM
-    acpi_dsdt_add_tpm(scope, vms);
+    call_dev_aml_func(DEVICE(tpm_find()), scope);
 #endif
 
     aml_append(dsdt, scope);
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 0b62c3a2f7..4291e670c8 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -14,6 +14,7 @@
 #include "target/loongarch/cpu.h"
 #include "hw/acpi/acpi-defs.h"
 #include "hw/acpi/acpi.h"
+#include "hw/acpi/acpi_aml_interface.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "migration/vmstate.h"
@@ -328,41 +329,6 @@ static void build_flash_aml(Aml *scope, LoongArchMachineState *lams)
     aml_append(scope, dev);
 }
 
-#ifdef CONFIG_TPM
-static void acpi_dsdt_add_tpm(Aml *scope, LoongArchMachineState *vms)
-{
-    PlatformBusDevice *pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
-    hwaddr pbus_base = VIRT_PLATFORM_BUS_BASEADDRESS;
-    SysBusDevice *sbdev = SYS_BUS_DEVICE(tpm_find());
-    MemoryRegion *sbdev_mr;
-    hwaddr tpm_base;
-
-    if (!sbdev) {
-        return;
-    }
-
-    tpm_base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
-    assert(tpm_base != -1);
-
-    tpm_base += pbus_base;
-
-    sbdev_mr = sysbus_mmio_get_region(sbdev, 0);
-
-    Aml *dev = aml_device("TPM0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
-    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-
-    Aml *crs = aml_resource_template();
-    aml_append(crs,
-               aml_memory32_fixed(tpm_base,
-                                  (uint32_t)memory_region_size(sbdev_mr),
-                                  AML_READ_WRITE));
-    aml_append(dev, aml_name_decl("_CRS", crs));
-    aml_append(scope, dev);
-}
-#endif
-
 /* build DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
@@ -379,7 +345,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     build_la_ged_aml(dsdt, machine);
     build_flash_aml(dsdt, lams);
 #ifdef CONFIG_TPM
-    acpi_dsdt_add_tpm(dsdt, lams);
+    call_dev_aml_func(DEVICE(tpm_find()), dsdt);
 #endif
     /* System State Package */
     scope = aml_scope("\\");
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 45e63efd63..b3ea2305b5 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -30,6 +30,7 @@
 #include "hw/sysbus.h"
 #include "tpm_tis.h"
 #include "qom/object.h"
+#include "hw/acpi/acpi_aml_interface.h"
 
 struct TPMStateSysBus {
     /*< private >*/
@@ -37,6 +38,8 @@ struct TPMStateSysBus {
 
     /*< public >*/
     TPMState state; /* not a QOM object */
+    uint64_t baseaddr;
+    uint64_t size;
 };
 
 OBJECT_DECLARE_SIMPLE_TYPE(TPMStateSysBus, TPM_TIS_SYSBUS)
@@ -94,6 +97,8 @@ static Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
     DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
+    DEFINE_PROP_UINT64("baseaddr", TPMStateSysBus, baseaddr, TPM_TIS_ADDR_BASE),
+    DEFINE_PROP_UINT64("size", TPMStateSysBus, size, TPM_TIS_ADDR_SIZE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -126,10 +131,38 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
     }
 }
 
+static void build_tpm_tis_sysbus_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *crs;
+    TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(adev);
+    TPMIf *ti = TPM_IF(sbdev);
+
+    dev = aml_device("TPM");
+    if (tpm_tis_sysbus_get_tpm_version(ti) == TPM_VERSION_2_0) {
+        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+        aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
+    } else {
+        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
+    }
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
+    crs = aml_resource_template();
+    aml_append(crs, aml_memory32_fixed(sbdev->baseaddr, sbdev->size,
+                                      AML_READ_WRITE));
+    /*
+     * FIXME: TPM_TIS_IRQ=5 conflicts with PNP0C0F irqs,
+     * fix default TPM_TIS_IRQ value there to use some unused IRQ
+     */
+    /* aml_append(crs, aml_irq_no_flags(sbdev->state.irq_num)); */
+    aml_append(dev, aml_name_decl("_CRS", crs));
+    aml_append(scope, dev);
+}
+
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     TPMIfClass *tc = TPM_IF_CLASS(klass);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
 
     device_class_set_props(dc, tpm_tis_sysbus_properties);
     dc->vmsd  = &vmstate_tpm_tis_sysbus;
@@ -140,6 +173,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    adevc->build_dev_aml = build_tpm_tis_sysbus_aml;
 }
 
 static const TypeInfo tpm_tis_sysbus_info = {
@@ -150,6 +184,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
     .class_init  = tpm_tis_sysbus_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
+        { TYPE_ACPI_DEV_AML_IF },
         { }
     }
 };
-- 
2.39.2 (Apple Git-143)


