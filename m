Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C14AA83B839
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Jan 2024 04:34:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqTG-00087u-V7; Wed, 24 Jan 2024 22:32:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqTE-0007yc-H5
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:32:04 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqTB-0001Dr-BW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153521; x=1737689521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4QlmHYOCpaUkhYHScvJ5cqeRVVb3OwqCd805KgUhquw=;
 b=A4UsyzwnbxE+5lhWKRqpgqxmRlRdDHLo7COe5cv+h2gaQSIdAL+Ez2Nc
 URd1MH1sth7iy7SIbsiA1JOEw3bPlNET2MvB2ObgQMM85RczjFnoGTXzT
 lar3wk4fcTPHcG1dr82iGR7rofIJV1/3MLy3HQaM1czcQckIXTUnjxF2Z
 gX0zhHEaZEsz/TRweRSETvNKLCIPUpmdqyVX+qcqVZDCAsp+Zdd7OX8IW
 yszxmYg7pRM2DfcGrlVos74or4+9jMYh1UBXnJuBwvdI8G+o+4jqTjQb4
 HdSdPxcMFK5Mh3Pj3GY/J18GC35Ta844sWJcJ/Imo9ANTtX/EhLw5Ud2p Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9430469"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9430469"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:29:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2086561"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:29:05 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 61/66] hw/i386: add option to forcibly report edge trigger
 in acpi tables
Date: Wed, 24 Jan 2024 22:23:23 -0500
Message-Id: <20240125032328.2522472-62-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

When level trigger isn't supported on x86 platform,
forcibly report edge trigger in acpi tables.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/acpi-build.c  | 99 ++++++++++++++++++++++++++++---------------
 hw/i386/acpi-common.c | 50 ++++++++++++++++------
 2 files changed, 104 insertions(+), 45 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index edc979379c03..3d1e4457ff30 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -975,7 +975,8 @@ static void build_dbg_aml(Aml *table)
     aml_append(table, scope);
 }
 
-static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
+static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg,
+                           bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -987,7 +988,10 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
     aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
 
     crs = aml_resource_template();
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
+                                  AML_ACTIVE_HIGH,
                                   AML_SHARED, irqs, ARRAY_SIZE(irqs)));
     aml_append(dev, aml_name_decl("_PRS", crs));
 
@@ -1011,7 +1015,8 @@ static Aml *build_link_dev(const char *name, uint8_t uid, Aml *reg)
     return dev;
  }
 
-static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
+static Aml *build_gsi_link_dev(const char *name, uint8_t uid,
+                               uint8_t gsi, bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -1024,7 +1029,10 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
 
     crs = aml_resource_template();
     irqs = gsi;
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
+                                  AML_ACTIVE_HIGH,
                                   AML_SHARED, &irqs, 1));
     aml_append(dev, aml_name_decl("_PRS", crs));
 
@@ -1043,7 +1051,7 @@ static Aml *build_gsi_link_dev(const char *name, uint8_t uid, uint8_t gsi)
 }
 
 /* _CRS method - get current settings */
-static Aml *build_iqcr_method(bool is_piix4)
+static Aml *build_iqcr_method(bool is_piix4, bool level_trigger_unsupported)
 {
     Aml *if_ctx;
     uint32_t irqs;
@@ -1051,7 +1059,9 @@ static Aml *build_iqcr_method(bool is_piix4)
     Aml *crs = aml_resource_template();
 
     irqs = 0;
-    aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
+    aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                  level_trigger_unsupported ?
+                                  AML_EDGE : AML_LEVEL,
                                   AML_ACTIVE_HIGH, AML_SHARED, &irqs, 1));
     aml_append(method, aml_name_decl("PRR0", crs));
 
@@ -1085,7 +1095,7 @@ static Aml *build_irq_status_method(void)
     return method;
 }
 
-static void build_piix4_pci0_int(Aml *table)
+static void build_piix4_pci0_int(Aml *table, bool level_trigger_unsupported)
 {
     Aml *dev;
     Aml *crs;
@@ -1098,12 +1108,16 @@ static void build_piix4_pci0_int(Aml *table)
     aml_append(sb_scope, pci0_scope);
 
     aml_append(sb_scope, build_irq_status_method());
-    aml_append(sb_scope, build_iqcr_method(true));
+    aml_append(sb_scope, build_iqcr_method(true, level_trigger_unsupported));
 
-    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0")));
-    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1")));
-    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2")));
-    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3")));
+    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQ0"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQ1"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQ2"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQ3"),
+                                        level_trigger_unsupported));
 
     dev = aml_device("LNKS");
     {
@@ -1112,7 +1126,9 @@ static void build_piix4_pci0_int(Aml *table)
 
         crs = aml_resource_template();
         irqs = 9;
-        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL,
+        aml_append(crs, aml_interrupt(AML_CONSUMER,
+                                      level_trigger_unsupported ?
+                                      AML_EDGE : AML_LEVEL,
                                       AML_ACTIVE_HIGH, AML_SHARED,
                                       &irqs, 1));
         aml_append(dev, aml_name_decl("_PRS", crs));
@@ -1198,7 +1214,7 @@ static Aml *build_q35_routing_table(const char *str)
     return pkg;
 }
 
-static void build_q35_pci0_int(Aml *table)
+static void build_q35_pci0_int(Aml *table, bool level_trigger_unsupported)
 {
     Aml *method;
     Aml *sb_scope = aml_scope("_SB");
@@ -1237,25 +1253,41 @@ static void build_q35_pci0_int(Aml *table)
     aml_append(sb_scope, pci0_scope);
 
     aml_append(sb_scope, build_irq_status_method());
-    aml_append(sb_scope, build_iqcr_method(false));
+    aml_append(sb_scope, build_iqcr_method(false, level_trigger_unsupported));
 
-    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA")));
-    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB")));
-    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC")));
-    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD")));
-    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE")));
-    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF")));
-    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG")));
-    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH")));
+    aml_append(sb_scope, build_link_dev("LNKA", 0, aml_name("PRQA"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKB", 1, aml_name("PRQB"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKC", 2, aml_name("PRQC"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKD", 3, aml_name("PRQD"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKE", 4, aml_name("PRQE"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKF", 5, aml_name("PRQF"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKG", 6, aml_name("PRQG"),
+                                        level_trigger_unsupported));
+    aml_append(sb_scope, build_link_dev("LNKH", 7, aml_name("PRQH"),
+                                        level_trigger_unsupported));
 
-    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10));
-    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11));
-    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12));
-    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13));
-    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14));
-    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15));
-    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16));
-    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17));
+    aml_append(sb_scope, build_gsi_link_dev("GSIA", 0x10, 0x10,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIB", 0x11, 0x11,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIC", 0x12, 0x12,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSID", 0x13, 0x13,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIE", 0x14, 0x14,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIF", 0x15, 0x15,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIG", 0x16, 0x16,
+                                            level_trigger_unsupported));
+    aml_append(sb_scope, build_gsi_link_dev("GSIH", 0x17, 0x17,
+                                            level_trigger_unsupported));
 
     aml_append(table, sb_scope);
 }
@@ -1436,6 +1468,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
     X86MachineState *x86ms = X86_MACHINE(machine);
+    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
     AcpiMcfgInfo mcfg;
     bool mcfg_valid = !!acpi_get_mcfg(&mcfg);
     uint32_t nr_mem = machine->ram_slots;
@@ -1468,7 +1501,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
             build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
-        build_piix4_pci0_int(dsdt);
+        build_piix4_pci0_int(dsdt, level_trigger_unsupported);
     } else if (q35) {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
@@ -1512,7 +1545,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         if (pm->pcihp_bridge_en) {
             build_x86_acpi_pci_hotplug(dsdt, pm->pcihp_io_base);
         }
-        build_q35_pci0_int(dsdt);
+        build_q35_pci0_int(dsdt, level_trigger_unsupported);
     }
 
     if (misc->has_hpet) {
diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
index 43dc23f7e06f..26ff3c738e78 100644
--- a/hw/i386/acpi-common.c
+++ b/hw/i386/acpi-common.c
@@ -103,6 +103,7 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
     const CPUArchIdList *apic_ids = mc->possible_cpu_arch_ids(MACHINE(x86ms));
     AcpiTable table = { .sig = "APIC", .rev = 3, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
+    bool level_trigger_unsupported = x86ms->eoi_intercept_unsupported;
 
     acpi_table_begin(&table, table_data);
     /* Local APIC Address */
@@ -122,18 +123,43 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
                      IO_APIC_SECONDARY_ADDRESS, IO_APIC_SECONDARY_IRQBASE);
     }
 
-    if (x86ms->apic_xrupt_override) {
-        build_xrupt_override(table_data, 0, 2,
-            0 /* Flags: Conforms to the specifications of the bus */);
-    }
-
-    for (i = 1; i < 16; i++) {
-        if (!(x86ms->pci_irq_mask & (1 << i))) {
-            /* No need for a INT source override structure. */
-            continue;
-        }
-        build_xrupt_override(table_data, i, i,
-            0xd /* Flags: Active high, Level Triggered */);
+    if (level_trigger_unsupported) {
+        /* Force edge trigger */
+        if (x86ms->apic_xrupt_override) {
+            build_xrupt_override(table_data, 0, 2,
+                                 /* Flags: active high, edge triggered */
+                                 1 | (1 << 2));
+        }
+
+        for (i = x86ms->apic_xrupt_override ? 1 : 0; i < 16; i++) {
+            build_xrupt_override(table_data, i, i,
+                                 /* Flags: active high, edge triggered */
+                                 1 | (1 << 2));
+        }
+
+        if (x86ms->ioapic2) {
+            for (i = 0; i < 16; i++) {
+                build_xrupt_override(table_data, IO_APIC_SECONDARY_IRQBASE + i,
+                                     IO_APIC_SECONDARY_IRQBASE + i,
+                                     /* Flags: active high, edge triggered */
+                                     1 | (1 << 2));
+            }
+        }
+    } else {
+        if (x86ms->apic_xrupt_override) {
+            build_xrupt_override(table_data, 0, 2,
+                                 0 /* Flags: Conforms to the specifications of the bus */);
+        }
+
+        for (i = 1; i < 16; i++) {
+            if (!(x86ms->pci_irq_mask & (1 << i))) {
+                /* No need for a INT source override structure. */
+                continue;
+            }
+            build_xrupt_override(table_data, i, i,
+                                 0xd /* Flags: Active high, Level Triggered */);
+
+        }
     }
 
     if (x2apic_mode) {
-- 
2.34.1


