Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4B79C277
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstN-0001J9-8B; Mon, 11 Sep 2023 22:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfst9-0001Fi-Q1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:29 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfst3-0005TR-A6
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxTevzyP9kBzIlAA--.1522S3;
 Tue, 12 Sep 2023 10:12:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S8; 
 Tue, 12 Sep 2023 10:12:00 +0800 (CST)
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
Subject: [PATCH v2 06/10] Optimize loongarch_irq_init function implementation
Date: Tue, 12 Sep 2023 10:11:43 +0800
Message-Id: <ea3be85cc1b3f76ddb3b97238a2275a138959290.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694433326.git.lixianglai@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S8
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

Optimize loongarch_irq_init function implementation
and abstract the function loongarch_cpu_irq_init from it.

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
 hw/loongarch/virt.c         | 105 ++++++++++++++++++++----------------
 include/hw/loongarch/virt.h |   5 +-
 2 files changed, 62 insertions(+), 48 deletions(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index b8474e7b94..fb06b4ab4e 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -46,6 +46,8 @@
 #include "hw/block/flash.h"
 #include "qemu/error-report.h"
 
+static LoongArchCPU *loongarch_cpu_irq_init(MachineState *machine,
+                                LoongArchCPU *cpu, Error **errp);
 
 static void virt_flash_create(LoongArchMachineState *lams)
 {
@@ -573,16 +575,16 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
 static void loongarch_irq_init(LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
-    DeviceState *pch_pic, *pch_msi, *cpudev;
-    DeviceState *ipi, *extioi;
+    DeviceState *pch_pic, *pch_msi;
+    DeviceState *extioi;
     SysBusDevice *d;
     LoongArchCPU *lacpu;
-    CPULoongArchState *env;
     CPUState *cpu_state;
-    int cpu, pin, i, start, num;
+    int cpu, i, start, num;
 
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+    lams->extioi = extioi;
 
     /*
      * The connection of interrupts:
@@ -607,44 +609,8 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      */
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
-        cpudev = DEVICE(cpu_state);
         lacpu = LOONGARCH_CPU(cpu_state);
-        env = &(lacpu->env);
-
-        ipi = qdev_new(TYPE_LOONGARCH_IPI);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
-
-        /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, 0, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        /* IPI iocsr memory region */
-        memory_region_add_subregion(&env->system_iocsr, SMP_IPI_MAILBOX,
-                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
-                                    0));
-        memory_region_add_subregion(&env->system_iocsr, MAIL_SEND_ADDR,
-                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
-                                    1));
-        /*
-         * extioi iocsr memory region
-         * only one extioi is added on loongarch virt machine
-         * external device interrupt can only be routed to cpu 0-3
-         */
-        if (cpu < EXTIOI_CPUS)
-            memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
-                                cpu));
-        env->ipistate = ipi;
-    }
-
-    /*
-     * connect ext irq to the cpu irq
-     * cpu_pin[9:2] <= intc_pin[7:0]
-     */
-    for (cpu = 0; cpu < MIN(ms->smp.cpus, EXTIOI_CPUS); cpu++) {
-        cpudev = DEVICE(qemu_get_cpu(cpu));
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
-                                  qdev_get_gpio_in(cpudev, pin + 2));
-        }
+        loongarch_cpu_irq_init(ms, lacpu, &error_fatal);
     }
 
     pch_pic = qdev_new(TYPE_LOONGARCH_PCH_PIC);
@@ -927,11 +893,7 @@ static void loongarch_init(MachineState *machine)
         }
     }
     fdt_add_flash_node(lams);
-    /* register reset function */
-    for (i = 0; i < machine->smp.cpus; i++) {
-        lacpu = LOONGARCH_CPU(qemu_get_cpu(i));
-        qemu_register_reset(reset_load_elf, lacpu);
-    }
+
     /* Initialize the IO interrupt subsystem */
     loongarch_irq_init(lams);
     fdt_add_irqchip_node(lams);
@@ -1091,6 +1053,57 @@ static void virt_mem_plug(HotplugHandler *hotplug_dev,
                          dev, &error_abort);
 }
 
+static LoongArchCPU *loongarch_cpu_irq_init(MachineState *machine,
+                                LoongArchCPU *cpu, Error **errp)
+{
+    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
+    CPUState *cs = CPU(cpu);
+    unsigned int cpu_index = cs->cpu_index;
+    DeviceState *cpudev = DEVICE(cpu);
+    DeviceState *extioi = lsms->extioi;
+    CPULoongArchState *env = &cpu->env;
+    DeviceState *ipi;
+    int pin;
+
+    qemu_register_reset(reset_load_elf, cpu);
+
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), errp);
+
+    /* connect ipi irq to cpu irq */
+    qdev_connect_gpio_out(ipi, 0, qdev_get_gpio_in(cpudev, IRQ_IPI));
+    /* IPI iocsr memory region */
+    memory_region_add_subregion(&env->system_iocsr, SMP_IPI_MAILBOX,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
+                                0));
+    memory_region_add_subregion(&env->system_iocsr, MAIL_SEND_ADDR,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
+                                1));
+    /*
+     * extioi iocsr memory region
+     * only one extioi is added on loongarch virt machine
+     * external device interrupt can only be routed to cpu 0-3
+     */
+    if (cpu_index < EXTIOI_CPUS)
+        memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
+                            cpu_index));
+    env->ipistate = ipi;
+
+    /*
+     * connect ext irq to the cpu irq
+     * cpu_pin[9:2] <= intc_pin[7:0]
+     */
+    if (cpu_index < EXTIOI_CPUS) {
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_connect_gpio_out(extioi, (cpu_index * 8 + pin),
+                                  qdev_get_gpio_in(cpudev, pin + 2));
+        }
+    }
+
+    return cpu;
+}
+
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index f1659655c6..176dc43a93 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -42,7 +42,7 @@ struct LoongArchMachineState {
     MemoryRegion bios;
     bool         bios_loaded;
     /* State for other subsystems/APIs: */
-    FWCfgState  *fw_cfg;
+    FWCfgState   *fw_cfg;
     Notifier     machine_done;
     Notifier     powerdown_notifier;
     OnOffAuto    acpi;
@@ -50,9 +50,10 @@ struct LoongArchMachineState {
     char         *oem_table_id;
     DeviceState  *acpi_ged;
     int          fdt_size;
-    DeviceState *platform_bus_dev;
+    DeviceState  *platform_bus_dev;
     PCIBus       *pci_bus;
     PFlashCFI01  *flash;
+    DeviceState  *extioi;
 };
 
 #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
-- 
2.39.1


