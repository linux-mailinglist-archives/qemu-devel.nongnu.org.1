Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BECC579C276
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstM-0001IE-MP; Mon, 11 Sep 2023 22:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfstA-0001Fj-3z
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfst3-0005Tc-9p
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:25 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxpPDzyP9kDzIlAA--.7109S3;
 Tue, 12 Sep 2023 10:12:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S9; 
 Tue, 12 Sep 2023 10:12:02 +0800 (CST)
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
Subject: [PATCH v2 07/10] Add basic CPU hot-(un)plug support for Loongarch
Date: Tue, 12 Sep 2023 10:11:44 +0800
Message-Id: <a61921d7c226eadd5a3a9cbb55097d29945dd169.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694433326.git.lixianglai@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S9
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

Add CPU hot-(un)plug related hook functions and
turn on the CPU hot-(un)plug custom switch.

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
 .../devices/loongarch64-softmmu/default.mak   |   1 +
 hw/loongarch/virt.c                           | 223 ++++++++++++++++++
 2 files changed, 224 insertions(+)

diff --git a/configs/devices/loongarch64-softmmu/default.mak b/configs/devices/loongarch64-softmmu/default.mak
index 928bc117ef..e596706fab 100644
--- a/configs/devices/loongarch64-softmmu/default.mak
+++ b/configs/devices/loongarch64-softmmu/default.mak
@@ -1,3 +1,4 @@
 # Default configuration for loongarch64-softmmu
 
 CONFIG_LOONGARCH_VIRT=y
+CONFIG_ACPI_CPU_HOTPLUG=y
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index fb06b4ab4e..aabe8aa814 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -999,11 +999,93 @@ static void virt_get_cpu_topo_by_cpu_index(const MachineState *ms,
     cpu_topo->thread_id = cpu_index % ms->smp.threads;
 }
 
+/* find cpu slot in machine->possible_cpus by arch_id */
+static CPUArchId *loongarch_find_cpu_slot(MachineState *ms, int arch_id)
+{
+    int n;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        if (ms->possible_cpus->cpus[n].arch_id == arch_id) {
+            return &ms->possible_cpus->cpus[n];
+        }
+    }
+
+    return NULL;
+}
+
+static void loongarch_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                            DeviceState *dev, Error **errp)
+{
+    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(hotplug_dev);
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    LoongArchCPUTopo cpu_topo;
+    int arch_id;
+
+    if (dev->hotplugged && !mc->has_hotpluggable_cpus) {
+        error_setg(&local_err, "CPU hotplug not supported for this machine");
+        goto out;
+    }
+
+    /* sanity check the cpu */
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        goto out;
+    }
+
+    if ((cpu->thread_id < 0) || (cpu->thread_id >= ms->smp.threads)) {
+        error_setg(&local_err,
+                   "Invalid thread-id %u specified, must be in range 1:%u",
+                   cpu->thread_id, ms->smp.threads - 1);
+        goto out;
+    }
+
+    if ((cpu->core_id < 0) || (cpu->core_id >= ms->smp.cores)) {
+        error_setg(&local_err,
+                   "Invalid core-id %u specified, must be in range 1:%u",
+                   cpu->core_id, ms->smp.cores);
+        goto out;
+    }
+
+    if ((cpu->socket_id < 0) || (cpu->socket_id >= ms->smp.sockets)) {
+        error_setg(&local_err,
+                   "Invalid socket-id %u specified, must be in range 1:%u",
+                   cpu->socket_id, ms->smp.sockets - 1);
+        goto out;
+    }
+
+    cpu_topo.socket_id = cpu->socket_id;
+    cpu_topo.core_id = cpu->core_id;
+    cpu_topo.thread_id = cpu->thread_id;
+    arch_id = virt_get_arch_id_from_cpu_topo(ms, &cpu_topo);
+
+    cpu_slot = loongarch_find_cpu_slot(ms, arch_id);
+    if (CPU(cpu_slot->cpu)) {
+        error_setg(&local_err,
+                   "cpu(id%d=%d:%d:%d) with arch-id %" PRIu64 " exists",
+                   cs->cpu_index, cpu->socket_id, cpu->core_id,
+                   cpu->thread_id, cpu_slot->arch_id);
+        goto out;
+    }
+    cpu->arch_id = arch_id;
+
+    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
+
+    return ;
+out:
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        loongarch_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1017,11 +1099,45 @@ static void virt_mem_unplug_request(HotplugHandler *hotplug_dev,
                                    errp);
 }
 
+static void loongarch_cpu_unplug_request(HotplugHandler *hotplug_dev,
+                                        DeviceState *dev, Error **errp)
+{
+    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
+    Error *local_err = NULL;
+    HotplugHandlerClass *hhc;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (!lsms->acpi_ged) {
+        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
+        goto out;
+    }
+
+    if (cs->cpu_index == 0) {
+        error_setg(&local_err,
+                   "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+                   cs->cpu_index, cpu->socket_id,
+                   cpu->core_id, cpu->thread_id);
+        goto out;
+    }
+
+
+    hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
+    hhc->unplug_request(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
+
+    return;
+ out:
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        loongarch_cpu_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -1035,11 +1151,87 @@ static void virt_mem_unplug(HotplugHandler *hotplug_dev,
     qdev_unrealize(dev);
 }
 
+static void loongarch_cpu_irq_uninit(MachineState *machine,
+                                     LoongArchCPU *cpu)
+{
+    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
+    CPULoongArchState *env = &cpu->env;
+    DeviceState *ipi = env->ipistate;
+    CPUState *cs = CPU(cpu);
+    unsigned int cpu_index = cs->cpu_index;
+    DeviceState *extioi = lsms->extioi;
+    int pin;
+
+    qemu_unregister_reset(reset_load_elf, DEVICE(cpu));
+
+    /* disconnect ipi irq to cpu irq */
+    qdev_disconnect_gpio_out_named(ipi, NULL, 0);
+    /* del IPI iocsr memory region */
+    memory_region_del_subregion(&env->system_iocsr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
+                                0));
+    memory_region_del_subregion(&env->system_iocsr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
+                                1));
+
+    env->ipistate = NULL;
+    object_unparent(OBJECT(ipi));
+
+    /*
+     * disconnect ext irq to the cpu irq
+     * cpu_pin[9:2] <= intc_pin[7:0]
+     */
+    if (cpu_index < EXTIOI_CPUS) {
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_disconnect_gpio_out_named(extioi, NULL, (cpu_index * 8 + pin));
+        }
+    }
+
+    /*
+     * del extioi iocsr memory region
+     * only one extioi is added on loongarch virt machine
+     * external device interrupt can only be routed to cpu 0-3
+     */
+    if (cpu_index < EXTIOI_CPUS)
+        memory_region_del_subregion(&env->system_iocsr,
+                            sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
+                            cpu_index));
+}
+
+static void loongarch_cpu_unplug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    HotplugHandlerClass *hhc;
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
+
+    hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
+    hhc->unplug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
+
+    if (local_err) {
+        goto out;
+    }
+
+    loongarch_cpu_irq_uninit(machine, cpu);
+
+    found_cpu = loongarch_find_cpu_slot(MACHINE(lsms), cpu->arch_id);
+    found_cpu->cpu = NULL;
+
+    return;
+out:
+    error_propagate(errp, local_err);
+}
+
 static void virt_machine_device_unplug(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        loongarch_cpu_unplug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1104,6 +1296,33 @@ static LoongArchCPU *loongarch_cpu_irq_init(MachineState *machine,
     return cpu;
 }
 
+static void loongarch_cpu_plug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *found_cpu;
+    HotplugHandlerClass *hhc;
+    Error *local_err = NULL;
+    MachineState *machine = MACHINE(OBJECT(hotplug_dev));
+    LoongArchMachineState *lsms = LOONGARCH_MACHINE(machine);
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+
+    if (lsms->acpi_ged) {
+        loongarch_cpu_irq_init(machine, cpu, errp);
+        hhc = HOTPLUG_HANDLER_GET_CLASS(lsms->acpi_ged);
+        hhc->plug(HOTPLUG_HANDLER(lsms->acpi_ged), dev, &local_err);
+        if (local_err) {
+            goto out;
+        }
+    }
+
+    found_cpu = loongarch_find_cpu_slot(MACHINE(lsms), cpu->arch_id);
+    found_cpu->cpu = OBJECT(dev);
+
+    return;
+out:
+    error_propagate(errp, local_err);
+}
+
 static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                                         DeviceState *dev, Error **errp)
 {
@@ -1117,6 +1336,8 @@ static void loongarch_machine_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        loongarch_cpu_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1126,6 +1347,7 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
     }
@@ -1194,6 +1416,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
+    mc->has_hotpluggable_cpus = true;
     mc->desc = "Loongson-3A5000 LS7A1000 machine";
     mc->init = loongarch_init;
     mc->default_ram_size = 1 * GiB;
-- 
2.39.1


