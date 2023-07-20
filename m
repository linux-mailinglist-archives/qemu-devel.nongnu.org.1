Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B975A791
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 09:17:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMNtB-0000bm-Ci; Thu, 20 Jul 2023 03:15:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qMNsz-0000Yv-DC
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:15:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qMNsu-0007RG-Hg
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 03:15:39 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbesV37hkm5EHAA--.16763S3;
 Thu, 20 Jul 2023 15:15:33 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx3yMB37hkIlg1AA--.41433S9; 
 Thu, 20 Jul 2023 15:15:32 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH 7/8] Update the ACPI table for the Loongarch CPU
Date: Thu, 20 Jul 2023 15:15:12 +0800
Message-Id: <c5caccd85916783d4682b34d6c4011aaa342d73a.1689837093.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1689837093.git.lixianglai@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx3yMB37hkIlg1AA--.41433S9
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

1.Create a new GED device type for Loongarch,
mount cpu_madt function to update the ACPI table
2.Update the APIC table for loongarch based on
CPU information to support CPU hot-(un)plug

Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Eduardo Habkost <eduardo@habkost.net>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
Cc: Yanan Wang <wangyanan55@huawei.com>
Cc: "Daniel P. Berrangé" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 hw/acpi/acpi-cpu-hotplug-stub.c               |  9 +++++
 hw/loongarch/acpi-build.c                     | 35 ++++++++++++++++--
 hw/loongarch/generic_event_device_loongarch.c | 36 +++++++++++++++++++
 hw/loongarch/meson.build                      |  2 +-
 4 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 hw/loongarch/generic_event_device_loongarch.c

diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index 2aec90d968..af9fda2cf4 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -19,6 +19,15 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
     return;
 }
 
+void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
+                    hwaddr mmap_io_base,
+                    const char *res_root,
+                    const char *event_handler_method,
+                    AmlRegionSpace rs)
+{
+    return;
+}
+
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
     return;
diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 0b62c3a2f7..312908fb2f 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -46,6 +46,23 @@
 #define ACPI_BUILD_DPRINTF(fmt, ...)
 #endif
 
+void virt_madt_cpu_entry(int uid,
+                         const CPUArchIdList *apic_ids,
+                         GArray *entry, bool force_enabled)
+{
+    uint32_t apic_id = apic_ids->cpus[uid].arch_id;
+    /* Flags – Local APIC Flags */
+    uint32_t flags = apic_ids->cpus[uid].cpu != NULL || force_enabled ?
+                     1 /* Enabled */ : 0;
+
+    /* Rev 1.0b, Table 5-13 Processor Local APIC Structure */
+    build_append_int_noprefix(entry, 0, 1);       /* Type */
+    build_append_int_noprefix(entry, 8, 1);       /* Length */
+    build_append_int_noprefix(entry, uid, 1);     /* ACPI Processor ID */
+    build_append_int_noprefix(entry, apic_id, 1); /* APIC ID */
+    build_append_int_noprefix(entry, flags, 4); /* Flags */
+}
+
 /* build FADT */
 static void init_common_fadt_data(AcpiFadtData *data)
 {
@@ -121,15 +138,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
     build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
 
     for (i = 0; i < arch_ids->len; i++) {
+        uint32_t flags;
+
         /* Processor Core Interrupt Controller Structure */
         arch_id = arch_ids->cpus[i].arch_id;
+        flags = arch_ids->cpus[i].cpu ? 1 : 0;
 
         build_append_int_noprefix(table_data, 17, 1);    /* Type */
         build_append_int_noprefix(table_data, 15, 1);    /* Length */
         build_append_int_noprefix(table_data, 1, 1);     /* Version */
-        build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
+        build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
         build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
-        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
+        build_append_int_noprefix(table_data, flags, 4);   /* Flags */
     }
 
     /* Extend I/O Interrupt Controller Structure */
@@ -292,6 +312,17 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
                                  AML_SYSTEM_MEMORY,
                                  VIRT_GED_MEM_ADDR);
     }
+
+    if (event & ACPI_GED_CPU_HOTPLUG_EVT) {
+        CPUHotplugFeatures opts = {
+            .acpi_1_compatible = false,
+            .has_legacy_cphp = false
+        };
+
+        build_cpus_aml(dsdt, machine, opts, VIRT_GED_CPUHP_ADDR,
+                       "\\_SB", "\\_GPE._E01", AML_SYSTEM_MEMORY);
+
+    }
     acpi_dsdt_add_power_button(dsdt);
 }
 
diff --git a/hw/loongarch/generic_event_device_loongarch.c b/hw/loongarch/generic_event_device_loongarch.c
new file mode 100644
index 0000000000..1fe550239b
--- /dev/null
+++ b/hw/loongarch/generic_event_device_loongarch.c
@@ -0,0 +1,36 @@
+/*
+ * loongarch variant of the generic event device for hw reduced acpi
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/loongarch/virt.h"
+
+static void acpi_ged_loongarch_class_init(ObjectClass *class, void *data)
+{
+    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
+
+    adevc->madt_cpu = virt_madt_cpu_entry;
+}
+
+static const TypeInfo acpi_ged_loongarch_info = {
+    .name          = TYPE_ACPI_GED_LOONGARCH,
+    .parent        = TYPE_ACPI_GED,
+    .class_init    = acpi_ged_loongarch_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { TYPE_ACPI_DEVICE_IF },
+        { }
+    }
+};
+
+static void acpi_ged_loongarch_register_types(void)
+{
+    type_register_static(&acpi_ged_loongarch_info);
+}
+
+type_init(acpi_ged_loongarch_register_types)
diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index c0421502ab..8d21addee3 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -3,6 +3,6 @@ loongarch_ss.add(files(
     'fw_cfg.c',
 ))
 loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: [files('virt.c'), fdt])
-loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
+loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c', 'generic_event_device_loongarch.c'))
 
 hw_arch += {'loongarch': loongarch_ss}
-- 
2.39.1


