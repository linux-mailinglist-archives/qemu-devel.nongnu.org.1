Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B4879C27A
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstM-0001IS-NK; Mon, 11 Sep 2023 22:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfstB-0001Fk-VI
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfst5-0005U7-Gg
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:27 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxXOr0yP9kGTIlAA--.45555S3;
 Tue, 12 Sep 2023 10:12:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S11; 
 Tue, 12 Sep 2023 10:12:03 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: "Salil Mehta" <salil.mehta@opnsrc.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PATCH v2 09/10] Add generic event device for Loongarch
Date: Tue, 12 Sep 2023 10:11:46 +0800
Message-Id: <775b9d1abd52286fa3af945ac23ec3631b110fbe.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694433326.git.lixianglai@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S11
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

Create a new GED device type for Loongarch,
mount cpu_madt function to update the ACPI table.

Cc: "Salil Mehta" <salil.mehta@opnsrc.net>
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
Cc: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 hw/loongarch/acpi-build.c                     | 17 +++++++++
 hw/loongarch/generic_event_device_loongarch.c | 36 +++++++++++++++++++
 hw/loongarch/meson.build                      |  2 +-
 include/hw/acpi/generic_event_device.h        |  1 +
 include/hw/loongarch/virt.h                   |  4 +++
 5 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 hw/loongarch/generic_event_device_loongarch.c

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index ae292fc543..66fad295cc 100644
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
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d0a5a43abf..2923bd9d82 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -71,6 +71,7 @@
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 
 #define TYPE_ACPI_GED_X86 "acpi-ged-x86"
+#define TYPE_ACPI_GED_LOONGARCH "acpi-ged-loongarch"
 
 #define ACPI_GED_EVT_SEL_OFFSET    0x0
 #define ACPI_GED_EVT_SEL_LEN       0x4
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 176dc43a93..f6c9495af2 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -60,4 +60,8 @@ struct LoongArchMachineState {
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchMachineState, LOONGARCH_MACHINE)
 bool loongarch_is_acpi_enabled(LoongArchMachineState *lams);
 void loongarch_acpi_setup(LoongArchMachineState *lams);
+void virt_madt_cpu_entry(int uid,
+                         const CPUArchIdList *apic_ids, GArray *entry,
+                         bool force_enabled);
+
 #endif
-- 
2.39.1


