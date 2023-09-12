Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F79179C274
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstO-0001K1-8R; Mon, 11 Sep 2023 22:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfstE-0001GY-UY
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfstC-0005VD-7W
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:32 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxXev0yP9kIDIlAA--.1744S3;
 Tue, 12 Sep 2023 10:12:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S12; 
 Tue, 12 Sep 2023 10:12:04 +0800 (CST)
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
Subject: [PATCH v2 10/10] Update the ACPI table for the Loongarch CPU
Date: Tue, 12 Sep 2023 10:11:47 +0800
Message-Id: <6d2e11b559f544c98f4ef1fed99dfb8c1aad4b83.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694433326.git.lixianglai@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S12
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

Add new types of GED devices for Loongarch machines,
add CPU hot-(un)plug event response and address spaces,
and update the ACPI table.

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
 hw/acpi/acpi-cpu-hotplug-stub.c |  9 +++++++++
 hw/loongarch/acpi-build.c       | 16 +++++++++++++++-
 hw/loongarch/virt.c             |  5 +++--
 include/hw/loongarch/virt.h     |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

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
index 66fad295cc..312908fb2f 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -138,15 +138,18 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
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
         build_append_int_noprefix(table_data, i, 4);     /* ACPI Processor ID */
         build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
-        build_append_int_noprefix(table_data, 1, 4);     /* Flags */
+        build_append_int_noprefix(table_data, flags, 4);   /* Flags */
     }
 
     /* Extend I/O Interrupt Controller Structure */
@@ -309,6 +312,17 @@ build_la_ged_aml(Aml *dsdt, MachineState *machine)
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
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index aabe8aa814..c4ec9dd6a7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -449,12 +449,12 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
 {
     DeviceState *dev;
     MachineState *ms = MACHINE(lams);
-    uint32_t event = ACPI_GED_PWR_DOWN_EVT;
+    uint32_t event = ACPI_GED_PWR_DOWN_EVT | ACPI_GED_CPU_HOTPLUG_EVT;
 
     if (ms->ram_slots) {
         event |= ACPI_GED_MEM_HOTPLUG_EVT;
     }
-    dev = qdev_new(TYPE_ACPI_GED);
+    dev = qdev_new(TYPE_ACPI_GED_LOONGARCH);
     qdev_prop_set_uint32(dev, "ged-event", event);
 
     /* ged event */
@@ -463,6 +463,7 @@ static DeviceState *create_acpi_ged(DeviceState *pch_pic, LoongArchMachineState
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, VIRT_GED_MEM_ADDR);
     /* ged regs used for reset and power down */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, VIRT_GED_REG_ADDR);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 3, VIRT_GED_CPUHP_ADDR);
 
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
                        qdev_get_gpio_in(pch_pic, VIRT_SCI_IRQ - VIRT_GSI_BASE));
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index f6c9495af2..82ac238f4f 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -31,6 +31,7 @@
 #define VIRT_GED_EVT_ADDR       0x100e0000
 #define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
 #define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
+#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_CPU_HOTPLUG_REG_LEN)
 
 struct LoongArchMachineState {
     /*< private >*/
-- 
2.39.1


