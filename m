Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922E7EA892
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 03:10:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2isF-0001OI-P8; Mon, 13 Nov 2023 21:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isE-0001NZ-2k; Mon, 13 Nov 2023 21:09:54 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1r2isB-0007bI-4q; Mon, 13 Nov 2023 21:09:53 -0500
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2809a824bbbso4036562a91.3; 
 Mon, 13 Nov 2023 18:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699927789; x=1700532589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=er+wGHhNJaRHONgLNEvt2ueAmajPNkBV9dZrECb5Yzw=;
 b=m7g9nrV9LOaEky8JvEkr8TRix45TvSHaGlqBpnljNmfzQnQgfo2tVfZDtWPYtJtcTJ
 b2tHwP94t7f997qV6Util4lrCCceHLvSaUfprV6AYi0aCaZEwV6n/phdro8KDQJb+FpL
 kCG5Ea49vZhjw5o7P8GzxDjAn+Lwv0qVE62yvNdu95C1GllUMD8gr9NhgcXg1OMIohyV
 J8OxoCKX+cUUUB/GWTEbw7VfwJHovJ1XQf2qBamCURDfv8Wn2VnmS/TWm+h/1rIPVw24
 y6wa/VyyWSQX62TmqBIl9fo3hzedLqg/KG4EbdQHAkGIQdEXH7u6POG02Tav3VMYRKSy
 dRbw==
X-Gm-Message-State: AOJu0YxXrtbdCfGAVxyIU9dtzMGj/8qdN4EbWf/qBjG/5yGMOf92/vpK
 +btP281ikUBeXY05vq4v/qqWSJBIROCeTw==
X-Google-Smtp-Source: AGHT+IEHEXmbyxCYng6ZGfKgnnRe6PUewCu3xSLxObG0XaACO3bYIOvzCWaaKF13x+RFytgeM+kDow==
X-Received: by 2002:a17:90b:4d06:b0:283:23d9:2bcf with SMTP id
 mw6-20020a17090b4d0600b0028323d92bcfmr5517185pjb.0.1699927789220; 
 Mon, 13 Nov 2023 18:09:49 -0800 (PST)
Received: from localhost.localdomain ([2601:642:4c01:2f7:5d09:c219:9099:a639])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a17090ae58d00b0027d12b1e29dsm6175362pjz.25.2023.11.13.18.09.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Nov 2023 18:09:48 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, Stefan Berger <stefanb@linux.ibm.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 qemu-arm@nongnu.org (open list:ARM ACPI Subsystem)
Subject: [PATCH v5 09/14] tpm_tis_sysbus: move DSDT AML generation to device
Date: Mon, 13 Nov 2023 18:09:19 -0800
Message-ID: <20231114020927.62315-10-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
References: <20231114020927.62315-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.216.47; envelope-from=osy86dev@gmail.com;
 helo=mail-pj1-f47.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

This reduces redundant code in different machine types with ACPI table
generation. Additionally, this will allow us to support different TPM
interfaces with the same AML logic. Finally, this matches up with the
TPM TIS ISA implementation.

Ideally, we would be able to call `qbus_build_aml` and avoid any TPM
specific code in the ACPI table generation. However, currently we
still have to call `build_tpm2` anyways and it does not look like
most other ACPI devices support the `ACPI_DEV_AML_IF` interface.

Signed-off-by: Joelle van Dyne <j@getutm.app>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/arm/virt-acpi-build.c  | 38 ++------------------------------------
 hw/loongarch/acpi-build.c | 38 ++------------------------------------
 hw/tpm/tpm_tis_sysbus.c   | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 72 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bc35a483c..499d30eb5d 100644
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
index ae292fc543..1969bfc8f9 100644
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
index 2fc550f119..462b0e1571 100644
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
@@ -93,6 +96,10 @@ static void tpm_tis_sysbus_reset(DeviceState *dev)
 static Property tpm_tis_sysbus_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateSysBus, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateSysBus, state.be_driver),
+    DEFINE_PROP_UINT64("x-baseaddr", TPMStateSysBus, baseaddr,
+                       TPM_TIS_ADDR_BASE),
+    DEFINE_PROP_UINT64("x-size", TPMStateSysBus, size,
+                       TPM_TIS_ADDR_SIZE),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -125,10 +132,38 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
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
@@ -139,6 +174,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)
     tc->request_completed = tpm_tis_sysbus_request_completed;
     tc->get_version = tpm_tis_sysbus_get_tpm_version;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    adevc->build_dev_aml = build_tpm_tis_sysbus_aml;
 }
 
 static const TypeInfo tpm_tis_sysbus_info = {
@@ -149,6 +185,7 @@ static const TypeInfo tpm_tis_sysbus_info = {
     .class_init  = tpm_tis_sysbus_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_TPM_IF },
+        { TYPE_ACPI_DEV_AML_IF },
         { }
     }
 };
-- 
2.41.0


