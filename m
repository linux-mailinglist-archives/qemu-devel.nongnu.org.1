Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2203D767082
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:28:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOhJ-0001QK-LN; Fri, 28 Jul 2023 10:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qPOhH-0001QB-Cw
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:44:03 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1qPOhE-0007m7-J0
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:44:03 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686d8c8fc65so1665003b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690555438; x=1691160238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDOj4pVzxuD/LhbqOYvAoMwoXe85jrwzzP+BK2MmpvA=;
 b=jUod/kDw31GfR6/BaEkjibWFgONSxRRIYmlKgxhQ0vg2P7SVjzxkd998cYONykvAmd
 RNSKf4jcwa1081tYlCvcUAJPfyHiT0CGFwkwK0V15SGV777tDkgPOlxZysR3wFWhu5P0
 96MbVjhwAykRJNmgQtK3YIueRGhyYIJfNpUTIs03nRQMPPMvtAVIJKjx2G4/CEkq8E1x
 J8A6AtFBFTnDaygZNBdodh/KgG/SPUFtjQs2axH+aLpFl2zUzjjHh8Ax2RhIcLVuJVkD
 0JjTgbW/fsPowKJzs0u7Y8YwtBay6yly/tl0isz5/5x/rho8hJ6vNAzjSgPAa09Z5TD9
 3QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690555438; x=1691160238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDOj4pVzxuD/LhbqOYvAoMwoXe85jrwzzP+BK2MmpvA=;
 b=C3gpy/ipU1HN2U0RyLAXETzZLqxI49k3FaThwAqBZUmPyd6XYI6pinF/5BOUMO8lSL
 Y+eOCDGKN1fBzBG4C+b0NmsEzinjKUnSaWKKfkLKhskcZdhJF0AQqAUmDr/C5vEqKSGQ
 xYdXoUSrTroRzvSpa1FjITWOHsWjxfdkdbPI9G8p/jJvf63O0cDFCIpLc91BWR7hIqk7
 eb1SAcpUYk49tEilRFx+ehjmB44T8YbtHVeEDEzMnBNvj1sP0G4ZfQntkb1MmKg/Q6I9
 HUomWd8LGI5x5xPyVoW9Q03BFSjz4zOKiUq2wntbA1XyFHnuuXcqRNCZ3jG9OEjOSOTl
 ny0Q==
X-Gm-Message-State: ABy/qLYym3G+P7JcVpv/rm/kgDq4rlga2fRUU2I/Mt7iMmHu2b3cB3oB
 A5QJTf87AyrKWPC23MTsjqWRPAbKihCygA==
X-Google-Smtp-Source: APBJJlG+zHwDx0tjf6P2UfXtC/vaoBxCgnhRqrWrQlGUwv04eYe0QxT9CIeJTvALBY4giK5NVltOlw==
X-Received: by 2002:a05:6a20:320f:b0:133:901:fe55 with SMTP id
 hl15-20020a056a20320f00b001330901fe55mr1613770pzc.38.1690555438495; 
 Fri, 28 Jul 2023 07:43:58 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:4fb3:b780:7648:9253:33f7:7434])
 by smtp.googlemail.com with ESMTPSA id
 m26-20020a63711a000000b0052c22778e64sm3533372pgc.66.2023.07.28.07.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 07:43:58 -0700 (PDT)
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
 Jason Wang <jasowang@redhat.com>, Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v7 5/5] amd_iommu: report x2APIC support to the operating
 system
Date: Fri, 28 Jul 2023 21:42:29 +0700
Message-Id: <20230728144229.49860-6-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728144229.49860-1-minhquangbui99@gmail.com>
References: <20230728144229.49860-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=minhquangbui99@gmail.com; helo=mail-pf1-x42e.google.com
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

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 hw/i386/acpi-build.c | 129 +++++++++++++++++++++++++++----------------
 hw/i386/amd_iommu.c  |  29 +++++++++-
 hw/i386/amd_iommu.h  |  16 ++++--
 3 files changed, 117 insertions(+), 57 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9c74fa17ad..4231b80f25 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2336,30 +2336,23 @@ static void
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
@@ -2379,56 +2372,94 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
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
 
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 9c77304438..4655cd801f 100644
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
@@ -1506,8 +1522,9 @@ static void amdvi_init(AMDVIState *s)
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
-    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES, AMDVI_EXT_FEATURES,
-            0xffffffffffffffef, 0);
+    amdvi_set_quad(s, AMDVI_MMIO_EXT_FEATURES,
+                   amdvi_extended_feature_register(s),
+                   0xffffffffffffffef, 0);
     amdvi_set_quad(s, AMDVI_MMIO_STATUS, 0, 0x98, 0x67);
 }
 
@@ -1591,6 +1608,11 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
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
@@ -1617,6 +1639,7 @@ static void amdvi_sysbus_class_init(ObjectClass *klass, void *data)
     dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "AMD IOMMU (AMD-Vi) DMA Remapping device";
+    device_class_set_props(dc, amdvi_properties);
 }
 
 static const TypeInfo amdvi_sysbus = {
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 6da893ee57..3d430434fe 100644
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
 
@@ -278,8 +280,8 @@ union irte_ga_lo {
                 dm:1,
                 /* ------ */
                 guest_mode:1,
-                destination:8,
-                rsvd_1:48;
+                destination:24,
+                rsvd_1:32;
   } fields_remap;
 };
 
@@ -287,7 +289,8 @@ union irte_ga_hi {
   uint64_t val;
   struct {
       uint64_t  vector:8,
-                rsvd_2:56;
+                rsvd_2:48,
+                destination_hi:8;
   } fields;
 };
 
@@ -366,6 +369,9 @@ struct AMDVIState {
 
     /* Interrupt remapping */
     bool ga_enabled;
+    bool xtsup;
 };
 
+uint64_t amdvi_extended_feature_register(AMDVIState *s);
+
 #endif
-- 
2.25.1


