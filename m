Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB91B9C4C77
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Nov 2024 03:19:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAgTl-0007BW-D9; Mon, 11 Nov 2024 21:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tAgTc-0007AO-Sw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tAgTa-00046M-3f
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 21:17:56 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa_NujJnLLg7AA--.52859S3;
 Tue, 12 Nov 2024 10:17:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCx98DCujJniixSAA--.12416S4;
 Tue, 12 Nov 2024 10:17:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: [PATCH v4 2/6] hw/loongarch/virt: Implement cpu plug interface
Date: Tue, 12 Nov 2024 10:17:34 +0800
Message-Id: <20241112021738.1952851-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241112021738.1952851-1-maobibo@loongson.cn>
References: <20241112021738.1952851-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx98DCujJniixSAA--.12416S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add cpu hotplug interface, however cpu hotplug feature is still
disabled for the machine. When machine is on, all created vCPUs
go through hotplug interface, and there is no remaining vCPU which
can be hot-added after power on.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/loongarch/virt.c    | 127 ++++++++++++++++++++++++++++++++++++++++-
 target/loongarch/cpu.c |  13 +++++
 target/loongarch/cpu.h |   1 +
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 1ed5130edf..b6b616d278 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1174,7 +1174,6 @@ static void virt_init(MachineState *machine)
 
         cpu = CPU(cpuobj);
         cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = cpu;
         lacpu = LOONGARCH_CPU(cpuobj);
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
         object_property_set_int(cpuobj, "socket-id",
@@ -1332,6 +1331,123 @@ static void virt_get_topo_from_index(MachineState *ms,
     topo->thread_id = index % ms->smp.threads;
 }
 
+/* Find cpu slot in machine->possible_cpus by arch_id */
+static CPUArchId *virt_find_cpu_slot(MachineState *ms, int arch_id)
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
+static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev,
+                              DeviceState *dev, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    MachineState *ms = MACHINE(OBJECT(hotplug_dev));
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    int arch_id;
+
+    /* sanity check the cpu */
+    if (!object_dynamic_cast(OBJECT(cpu), ms->cpu_type)) {
+        error_setg(&local_err, "Invalid CPU type, expected cpu type: '%s'",
+                   ms->cpu_type);
+        goto out;
+    }
+
+    if (lvms->acpi_ged) {
+        hotplug_handler_pre_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
+                                 &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+           return;
+        }
+     }
+
+    if (cpu->phy_id == UNSET_PHY_ID) {
+        error_setg(&local_err, "CPU hotplug not supported");
+        goto out;
+    } else {
+        /* For cold-add cpu, find cpu slot from arch_id */
+        arch_id = cpu->phy_id;
+        cpu_slot = virt_find_cpu_slot(ms, arch_id);
+    }
+
+    numa_cpu_pre_plug(cpu_slot, dev, &local_err);
+    return;
+
+out:
+    error_propagate(errp, local_err);
+}
+
+static void virt_cpu_unplug_request(HotplugHandler *hotplug_dev,
+                                       DeviceState *dev, Error **errp)
+{
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    CPUState *cs = CPU(dev);
+
+    if (!lvms->acpi_ged) {
+        error_setg(&local_err, "CPU hot unplug not supported without ACPI");
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (cs->cpu_index == 0) {
+        error_setg(&local_err,
+                   "hot-unplug of boot cpu(id%d=%d:%d:%d) not supported",
+                   cs->cpu_index, cpu->socket_id,
+                   cpu->core_id, cpu->thread_id);
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    hotplug_handler_unplug_request(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *cpu_slot;
+    Error *local_err = NULL;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = NULL;
+    return;
+}
+
+static void virt_cpu_plug(HotplugHandler *hotplug_dev,
+                                DeviceState *dev, Error **errp)
+{
+    CPUArchId *cpu_slot;
+    LoongArchCPU *cpu = LOONGARCH_CPU(dev);
+    LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(hotplug_dev);
+
+    cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
+    cpu_slot->cpu = CPU(dev);
+    return;
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -1350,6 +1466,8 @@ static void virt_device_pre_plug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_pre_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1368,6 +1486,8 @@ static void virt_device_unplug_request(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug_request(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug_request(hotplug_dev, dev, errp);
     }
 }
 
@@ -1386,6 +1506,8 @@ static void virt_device_unplug(HotplugHandler *hotplug_dev,
 {
     if (memhp_type_supported(dev)) {
         virt_mem_unplug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_unplug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1413,6 +1535,8 @@ static void virt_device_plug_cb(HotplugHandler *hotplug_dev,
         }
     } else if (memhp_type_supported(dev)) {
         virt_mem_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU)) {
+        virt_cpu_plug(hotplug_dev, dev, errp);
     }
 }
 
@@ -1422,6 +1546,7 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     MachineClass *mc = MACHINE_GET_CLASS(machine);
 
     if (device_is_dynamic_sysbus(mc, dev) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_LOONGARCH_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
         memhp_type_supported(dev)) {
         return HOTPLUG_HANDLER(machine);
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index a99e22094e..a5467811ab 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -613,6 +613,17 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     lacc->parent_realize(dev, errp);
 }
 
+static void loongarch_cpu_unrealizefn(DeviceState *dev)
+{
+    LoongArchCPUClass *mcc = LOONGARCH_CPU_GET_CLASS(dev);
+
+#ifndef CONFIG_USER_ONLY
+    cpu_remove_sync(CPU(dev));
+#endif
+
+    mcc->parent_unrealize(dev);
+}
+
 static bool loongarch_get_lsx(Object *obj, Error **errp)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -843,6 +854,8 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_cpu_unrealizefn,
+                                      &lacc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
                                        &lacc->parent_phases);
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 7472df0521..22e6d9baf5 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -438,6 +438,7 @@ struct LoongArchCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
-- 
2.39.3


