Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846E82B207
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 16:45:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNxEz-0008HO-8e; Thu, 11 Jan 2024 10:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEw-0008Ge-On
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:45:06 -0500
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rNxEu-0007rn-5A
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 10:45:06 -0500
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-58e256505f7so2748099eaf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704987902; x=1705592702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jho80u3vfqbZKvi7kK9QahigxaDLX9acE1nhx5VTccA=;
 b=hdzK/t/T7IsoubOBuV406iVFSmZkITjEAvPOlYN55BnKfBhn30uCMYsCkysOE7yZIY
 NdUHBCUZ4T7cDult7ZtDBrL/MvXauSwSJgpmActUTXJseN20NFIkVfqSZ4/dynIit8Zh
 c+sgywVbFMvgZOCFPIrJoa/wLnvg68ocygWTaB8EuOceyLrt1uNha5ggrjTO6bjmHnYx
 Z4AYMxElVNVI8CzrJ1FfV3zwgOPIkjFArogWOEcBl6sKabpquTaIduBHPigL8ZEN/ATE
 eevRPHvvnikgVz+s7OaliJfhc4OL+fSVfNMJ9a3Fht1i1207YO4/+dattae44Qw0mpkR
 MVtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704987902; x=1705592702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jho80u3vfqbZKvi7kK9QahigxaDLX9acE1nhx5VTccA=;
 b=m6UGSehFJkuBgv6TvjmUxPBzmaLPlb/NBeb4A67jECQT/qp2+rpHtMvRqVPHlpsuMA
 /Ij7F/wk9KrZI5Rx1oOZSQqnfYSkZXhpdJP9y/b6MSSLnXHsDaq/fcIrZbDelOV1zj7U
 3/7Gm7nUYfYAq2UJL2T9fJ9w/t2ifo6LgIScNI8K/4zgveOGIzu4ul/q8ONC/wSwa+CP
 OH85hMbYkkypuZlWZ6phCRJu9c6jsGqLmeWTzT9QqDaSq+MkIalI8pR0yxoU5NeP8YuB
 R6utPTJY01Cs46wl/+WpYtdG25fH34lAuSejz02gMXq3tH6F8hkNHzX/XlI0PVTxlq9u
 KwNw==
X-Gm-Message-State: AOJu0YwHqKVcH57HL6dFrIe8wjyl14ma+XveiLKHzXS/WZ8GO7X8cJwn
 VKkb5Ss62xyddZlz+pW5noPQbzelt5xcjzuc
X-Google-Smtp-Source: AGHT+IHKMVVMCVVZpfyUU5woRhUrdQ/DV3XR10uIpCPlB06Uar9lwSDFETp8B7AAbcZIhNYgBq6XAA==
X-Received: by 2002:a05:6358:e48d:b0:175:2bc4:9474 with SMTP id
 by13-20020a056358e48d00b001752bc49474mr10735rwb.62.1704987901930; 
 Thu, 11 Jan 2024 07:45:01 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:e868:3e48:c113:4a7f])
 by smtp.googlemail.com with ESMTPSA id
 fb9-20020a056a002d8900b006da550512d8sm1317887pfb.126.2024.01.11.07.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 07:45:01 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v12 6/7] amd_iommu: report x2APIC support to the operating
 system
Date: Thu, 11 Jan 2024 22:44:03 +0700
Message-Id: <20240111154404.5333-7-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111154404.5333-1-minhquangbui99@gmail.com>
References: <20240111154404.5333-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit adds XTSup configuration to let user choose to whether enable
this feature or not. When XTSup is enabled, additional bytes in IRTE with
enabled guest virtual VAPIC are used to support 32-bit destination id.

Additionally, this commit exports IVHD type 0x11 besides the old IVHD type
0x10 in ACPI table. IVHD type 0x10 does not report full set of IOMMU
features only the legacy ones, so operating system (e.g. Linux) may only
detects x2APIC support if IVHD type 0x11 is available. The IVHD type 0x10
is kept so that old operating system that only parses type 0x10 can detect
the IOMMU device.

Besides, an amd_iommu-stub.c file is created to provide the definition for
amdvi_extended_feature_register when CONFIG_AMD_IOMMU=n. This function is
used by acpi-build.c to get the extended feature register value for
building the ACPI table. When CONFIG_AMD_IOMMU=y, this function is defined
in amd_iommu.c.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/acpi-build.c     | 129 ++++++++++++++++++++++++---------------
 hw/i386/amd_iommu-stub.c |  26 ++++++++
 hw/i386/amd_iommu.c      |  29 ++++++++-
 hw/i386/amd_iommu.h      |  16 +++--
 hw/i386/meson.build      |   3 +-
 5 files changed, 145 insertions(+), 58 deletions(-)
 create mode 100644 hw/i386/amd_iommu-stub.c

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c..8890a299ee 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2333,30 +2333,23 @@ static void
 build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
                 const char *oem_table_id)
 {
-    int ivhd_table_len = 24;
     AMDVIState *s = AMD_IOMMU_DEVICE(x86_iommu_get_default());
     GArray *ivhd_blob = g_array_new(false, true, 1);
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
+    uint64_t feature_report;
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
      * IOMMU units in a system
      */
-    build_append_int_noprefix(table_data, 40UL << 8/* PASize */, 4);
+    build_append_int_noprefix(table_data,
+                             (1UL << 0) | /* EFRSup */
+                             (40UL << 8), /* PASize */
+                             4);
     /* reserved */
     build_append_int_noprefix(table_data, 0, 8);
 
-    /* IVHD definition - type 10h */
-    build_append_int_noprefix(table_data, 0x10, 1);
-    /* virtualization flags */
-    build_append_int_noprefix(table_data,
-                             (1UL << 0) | /* HtTunEn      */
-                             (1UL << 4) | /* iotblSup     */
-                             (1UL << 6) | /* PrefSup      */
-                             (1UL << 7),  /* PPRSup       */
-                             1);
-
     /*
      * A PCI bus walk, for each PCI host bridge, is necessary to create a
      * complete set of IVHD entries.  Do this into a separate blob so that we
@@ -2376,56 +2369,94 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
         build_append_int_noprefix(ivhd_blob, 0x0000001, 4);
     }
 
-    ivhd_table_len += ivhd_blob->len;
-
     /*
      * When interrupt remapping is supported, we add a special IVHD device
-     * for type IO-APIC.
-     */
-    if (x86_iommu_ir_supported(x86_iommu_get_default())) {
-        ivhd_table_len += 8;
-    }
-
-    /* IVHD length */
-    build_append_int_noprefix(table_data, ivhd_table_len, 2);
-    /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(&s->pci), "addr",
-                                                      &error_abort), 2);
-    /* Capability offset */
-    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
-    /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
-    /* PCI Segment Group */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU info */
-    build_append_int_noprefix(table_data, 0, 2);
-    /* IOMMU Feature Reporting */
-    build_append_int_noprefix(table_data,
-                             (48UL << 30) | /* HATS   */
-                             (48UL << 28) | /* GATS   */
-                             (1UL << 2)   | /* GTSup  */
-                             (1UL << 6),    /* GASup  */
-                             4);
-
-    /* IVHD entries as found above */
-    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
-    g_array_free(ivhd_blob, TRUE);
-
-    /*
-     * Add a special IVHD device type.
+     * for type IO-APIC
      * Refer to spec - Table 95: IVHD device entry type codes
      *
      * Linux IOMMU driver checks for the special IVHD device (type IO-APIC).
      * See Linux kernel commit 'c2ff5cf5294bcbd7fa50f7d860e90a66db7e5059'
      */
     if (x86_iommu_ir_supported(x86_iommu_get_default())) {
-        build_append_int_noprefix(table_data,
+        build_append_int_noprefix(ivhd_blob,
                                  (0x1ull << 56) |           /* type IOAPIC */
                                  (IOAPIC_SB_DEVID << 40) |  /* IOAPIC devid */
                                  0x48,                      /* special device */
                                  8);
     }
+
+    /* IVHD definition - type 10h */
+    build_append_int_noprefix(table_data, 0x10, 1);
+    /* virtualization flags */
+    build_append_int_noprefix(table_data,
+                             (1UL << 0) | /* HtTunEn      */
+                             (1UL << 4) | /* iotblSup     */
+                             (1UL << 6) | /* PrefSup      */
+                             (1UL << 7),  /* PPRSup       */
+                             1);
+
+    /* IVHD length */
+    build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
+    /* DeviceID */
+    build_append_int_noprefix(table_data,
+                              object_property_get_int(OBJECT(&s->pci), "addr",
+                                                      &error_abort), 2);
+    /* Capability offset */
+    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    /* IOMMU base address */
+    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    /* PCI Segment Group */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* IOMMU info */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* IOMMU Feature Reporting */
+    feature_report = (48UL << 30) | /* HATS   */
+                     (48UL << 28) | /* GATS   */
+                     (1UL << 2)   | /* GTSup  */
+                     (1UL << 6);    /* GASup  */
+    if (s->xtsup) {
+        feature_report |= (1UL << 0); /* XTSup */
+    }
+    build_append_int_noprefix(table_data, feature_report, 4);
+
+    /* IVHD entries as found above */
+    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
+
+   /* IVHD definition - type 11h */
+    build_append_int_noprefix(table_data, 0x11, 1);
+    /* virtualization flags */
+    build_append_int_noprefix(table_data,
+                             (1UL << 0) | /* HtTunEn      */
+                             (1UL << 4),  /* iotblSup     */
+                             1);
+
+    /* IVHD length */
+    build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
+    /* DeviceID */
+    build_append_int_noprefix(table_data,
+                              object_property_get_int(OBJECT(&s->pci), "addr",
+                                                      &error_abort), 2);
+    /* Capability offset */
+    build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
+    /* IOMMU base address */
+    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    /* PCI Segment Group */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* IOMMU info */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* IOMMU Attributes */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* EFR Register Image */
+    build_append_int_noprefix(table_data,
+                              amdvi_extended_feature_register(s),
+                              8);
+    /* EFR Register Image 2 */
+    build_append_int_noprefix(table_data, 0, 8);
+
+    /* IVHD entries as found above */
+    g_array_append_vals(table_data, ivhd_blob->data, ivhd_blob->len);
+
+    g_array_free(ivhd_blob, TRUE);
     acpi_table_end(linker, &table);
 }
 
diff --git a/hw/i386/amd_iommu-stub.c b/hw/i386/amd_iommu-stub.c
new file mode 100644
index 0000000000..d62a3732e6
--- /dev/null
+++ b/hw/i386/amd_iommu-stub.c
@@ -0,0 +1,26 @@
+/*
+ * Stubs for AMD IOMMU emulation
+ *
+ * Copyright (C) 2023 Bui Quang Minh <minhquangbui99@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "amd_iommu.h"
+
+uint64_t amdvi_extended_feature_register(AMDVIState *s)
+{
+    return AMDVI_DEFAULT_EXT_FEATURES;
+}
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 4203144da9..7329553ad3 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -31,6 +31,7 @@
 #include "hw/i386/apic_internal.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
+#include "hw/qdev-properties.h"
 
 /* used AMD-Vi MMIO registers */
 const char *amdvi_mmio_low[] = {
@@ -74,6 +75,16 @@ typedef struct AMDVIIOTLBEntry {
     uint64_t page_mask;         /* physical page size  */
 } AMDVIIOTLBEntry;
 
+uint64_t amdvi_extended_feature_register(AMDVIState *s)
+{
+    uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
+    if (s->xtsup) {
+        feature |= AMDVI_FEATURE_XT;
+    }
+
+    return feature;
+}
+
 /* configure MMIO registers at startup/reset */
 static void amdvi_set_quad(AMDVIState *s, hwaddr addr, uint64_t val,
                            uint64_t romask, uint64_t w1cmask)
@@ -1155,7 +1166,12 @@ static int amdvi_int_remap_ga(AMDVIState *iommu,
     irq->vector = irte.hi.fields.vector;
     irq->dest_mode = irte.lo.fields_remap.dm;
     irq->redir_hint = irte.lo.fields_remap.rq_eoi;
-    irq->dest = irte.lo.fields_remap.destination;
+    if (iommu->xtsup) {
+        irq->dest = irte.lo.fields_remap.destination |
+                    (irte.hi.fields.destination_hi << 24);
+    } else {
+        irq->dest = irte.lo.fields_remap.destination & 0xff;
+    }
 
     return 0;
 }
@@ -1505,8 +1521,9 @@ static void amdvi_init(AMDVIState *s)
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
-    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, AMDVI_EXT_FEATURES,
-            0xffffffffffffffef, 0);
+    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
+                   amdvi_extended_feature_register(s),
+                   0xffffffffffffffef, 0);
     amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
 }
 
@@ -1589,6 +1606,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     amdvi_init(s);
 }
 
+static Property amdvi_properties[] = {
+    DEFINE_PROP_BOOL("xtsup", AMDVIState, xtsup, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static const VMStateDescription vmstate_amdvi_sysbus = {
     .name = "amd-iommu",
     .unmigratable = 1
@@ -1615,6 +1637,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
+    device_class_set_props(dc, amdvi_properties);
 }
 
 static const TypeInfo amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index c5065a3e27..73619fe9ea 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -154,6 +154,7 @@
 
 #define AMDVI_FEATURE_PREFETCH            (1ULL << 0) /* page prefetch       */
 #define AMDVI_FEATURE_PPR                 (1ULL << 1) /* PPR Support         */
+#define AMDVI_FEATURE_XT                  (1ULL << 2) /* x2APIC Support      */
 #define AMDVI_FEATURE_GT                  (1ULL << 4) /* Guest Translation   */
 #define AMDVI_FEATURE_IA                  (1ULL << 6) /* inval all support   */
 #define AMDVI_FEATURE_GA                  (1ULL << 7) /* guest VAPIC support */
@@ -173,8 +174,9 @@
 #define AMDVI_IOTLB_MAX_SIZE 1024
 #define AMDVI_DEVID_SHIFT    36
 
-/* extended feature support */
-#define AMDVI_EXT_FEATURES (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
+/* default extended feature */
+#define AMDVI_DEFAULT_EXT_FEATURES \
+        (AMDVI_FEATURE_PREFETCH | AMDVI_FEATURE_PPR | \
         AMDVI_FEATURE_IA | AMDVI_FEATURE_GT | AMDVI_FEATURE_HE | \
         AMDVI_GATS_MODE | AMDVI_HATS_MODE | AMDVI_FEATURE_GA)
 
@@ -276,8 +278,8 @@ union irte_ga_lo {
                 dm:1,
                 /* ------ */
                 guest_mode:1,
-                destination:8,
-                rsvd_1:48;
+                destination:24,
+                rsvd_1:32;
   } fields_remap;
 };
 
@@ -285,7 +287,8 @@ union irte_ga_hi {
   uint64_t val;
   struct {
       uint64_t  vector:8,
-                rsvd_2:56;
+                rsvd_2:48,
+                destination_hi:8;
   } fields;
 };
 
@@ -364,6 +367,9 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
+    bool xtsup;
 };
 
+uint64_t amdvi_extended_feature_register(AMDVIState *s);
+
 #endif
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 369c6bf823..b9c1ca39cb 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -9,7 +9,8 @@ i386_ss.add(files(
 
 i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
-i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
+i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
+                                      if_false: files('amd_iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
-- 
2.25.1


