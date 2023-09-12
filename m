Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FBB79C27D
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 04:14:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfstH-0001GW-3s; Mon, 11 Sep 2023 22:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qfst5-0001Ex-Gd
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qfssy-0005T0-UE
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 22:12:21 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbevxyP9k_TElAA--.4824S3;
 Tue, 12 Sep 2023 10:12:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxfSPqyP9kCnh4AA--.42014S7; 
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
Subject: [PATCH v2 05/10] Added CPU topology support for Loongarch
Date: Tue, 12 Sep 2023 10:11:42 +0800
Message-Id: <a750d85ef2d47d93e7837eff01661fd8cfc0890c.1694433326.git.lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1694433326.git.lixianglai@loongson.cn>
References: <cover.1694433326.git.lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxfSPqyP9kCnh4AA--.42014S7
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

1.Add topological relationships for Loongarch VCPU
and initialize topology member variables.
2.Add a description of the calculation method of
the arch_id and the topological relationship of the CPU.

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
 docs/system/loongarch/virt.rst |  31 ++++++++++
 hw/loongarch/virt.c            | 101 ++++++++++++++++++++++++++-------
 target/loongarch/cpu.c         |  13 ++++-
 target/loongarch/cpu.h         |  12 +++-
 4 files changed, 134 insertions(+), 23 deletions(-)

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index c37268b404..eaba9e2fd7 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -28,6 +28,37 @@ The ``qemu-system-loongarch64`` provides emulation for virt
 machine. You can specify the machine type ``virt`` and
 cpu type ``la464``.
 
+CPU Topology
+--------------------
+
+The ``LA464`` type CPUs have the concept of Socket Core and Thread.
+
+For example:
+
+``-smp 1,maxcpus=M,sockets=S,cores=C,threads=T``
+
+The above parameters indicate that the machine has a maximum of ``M`` vCPUs and
+``S`` sockets, each socket has ``C`` cores, each core has ``T`` threads,
+and each thread corresponds to a vCPU.
+
+Then ``M`` ``S`` ``C`` ``T`` has the following relationship:
+
+``M = S * C * T``
+
+In the CPU topology relationship, When we know the ``socket_id`` ``core_id``
+and ``thread_id`` of the CPU, we can calculate its ``arch_id``:
+
+``arch_id = (socket_id * S) + (core_id * C) + (thread_id * T)``
+
+Similarly, when we know the ``arch_id`` of the CPU,
+we can also get its ``socket_id`` ``core_id`` and ``thread_id``:
+
+``socket_id = arch_id / (C * T)``
+
+``core_id = (arch_id / T) % C``
+
+``thread_id = arch_id % T``
+
 Boot options
 ------------
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2629128aed..b8474e7b94 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -624,11 +624,11 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
                                     sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
                                     1));
         /*
-	 * extioi iocsr memory region
-	 * only one extioi is added on loongarch virt machine
-	 * external device interrupt can only be routed to cpu 0-3
-	 */
-	if (cpu < EXTIOI_CPUS)
+         * extioi iocsr memory region
+         * only one extioi is added on loongarch virt machine
+         * external device interrupt can only be routed to cpu 0-3
+         */
+        if (cpu < EXTIOI_CPUS)
             memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
                                 cpu));
@@ -789,9 +789,7 @@ static void loongarch_init(MachineState *machine)
     NodeInfo *numa_info = machine->numa_state->nodes;
     int i;
     hwaddr fdt_base;
-    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUState *cpu;
     char *ramName = NULL;
 
     if (!cpu_model) {
@@ -803,16 +801,41 @@ static void loongarch_init(MachineState *machine)
         exit(1);
     }
     create_fdt(lams);
-    /* Init CPUs */
 
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
-    for (i = 0; i < possible_cpus->len; i++) {
-        cpu = cpu_create(machine->cpu_type);
-        cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
-        lacpu = LOONGARCH_CPU(cpu);
-        lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
+    /* Init CPUs */
+    mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        Object *cpuobj;
+        cpuobj = object_new(machine->cpu_type);
+        lacpu = LOONGARCH_CPU(cpuobj);
+
+        lacpu->arch_id = machine->possible_cpus->cpus[i].arch_id;
+        object_property_set_int(cpuobj, "socket-id",
+                                machine->possible_cpus->cpus[i].props.socket_id,
+                                NULL);
+        object_property_set_int(cpuobj, "core-id",
+                                machine->possible_cpus->cpus[i].props.core_id,
+                                NULL);
+        object_property_set_int(cpuobj, "thread-id",
+                                machine->possible_cpus->cpus[i].props.thread_id,
+                                NULL);
+        /*
+         * The CPU in place at the time of machine startup will also enter
+         * the CPU hot-plug process when it is created, but at this time,
+         * the GED device has not been created, resulting in exit in the CPU
+         * hot-plug process, which can avoid the incumbent CPU repeatedly
+         * applying for resources.
+         *
+         * The interrupt resource of the in-place CPU will be requested at
+         * the current function call loongarch_irq_init().
+         *
+         * The interrupt resource of the subsequently inserted CPU will be
+         * requested in the CPU hot-plug process.
+         */
+        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+        object_unref(cpuobj);
     }
+
     fdt_add_cpu_nodes(lams);
 
     /* Node0 memory */
@@ -983,6 +1006,37 @@ static void virt_mem_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     pc_dimm_pre_plug(PC_DIMM(dev), MACHINE(hotplug_dev), NULL, errp);
 }
 
+static int virt_get_arch_id_from_cpu_topo(const MachineState *ms,
+                                          LoongArchCPUTopo *cpu_topo)
+{
+    int arch_id, sock_vcpu_num, core_vcpu_num;
+
+    /*
+     * calculate total logical cpus across socket/core/thread.
+     * For more information on how to calculate the arch_id,
+     * you can refer to the CPU Topology chapter of the
+     * docs/system/loongarch/virt.rst document.
+     */
+    sock_vcpu_num = cpu_topo->socket_id * (ms->smp.threads * ms->smp.cores);
+    core_vcpu_num = cpu_topo->core_id * ms->smp.threads;
+
+    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
+    arch_id = (sock_vcpu_num + core_vcpu_num) + cpu_topo->thread_id;
+
+    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
+
+    return arch_id;
+}
+
+static void virt_get_cpu_topo_by_cpu_index(const MachineState *ms,
+                                           LoongArchCPUTopo *cpu_topo,
+                                           int cpu_index)
+{
+    cpu_topo->socket_id  = cpu_index / (ms->smp.cores * ms->smp.threads);
+    cpu_topo->core_id = cpu_index / ms->smp.threads % ms->smp.cores;
+    cpu_topo->thread_id = cpu_index % ms->smp.threads;
+}
+
 static void virt_machine_device_pre_plug(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
@@ -1069,6 +1123,8 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
     unsigned int max_cpus = ms->smp.max_cpus;
+    unsigned int smp_threads = ms->smp.threads;
+    LoongArchCPUTopo cpu_topo;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
@@ -1079,17 +1135,20 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
-        ms->possible_cpus->cpus[n].arch_id = n;
+
+        virt_get_cpu_topo_by_cpu_index(ms, &cpu_topo, n);
 
         ms->possible_cpus->cpus[n].props.has_socket_id = true;
-        ms->possible_cpus->cpus[n].props.socket_id  =
-                                   n / (ms->smp.cores * ms->smp.threads);
+        ms->possible_cpus->cpus[n].props.socket_id  = cpu_topo.socket_id;
         ms->possible_cpus->cpus[n].props.has_core_id = true;
-        ms->possible_cpus->cpus[n].props.core_id =
-                                   n / ms->smp.threads % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.core_id = cpu_topo.core_id;
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
-        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
+        ms->possible_cpus->cpus[n].props.thread_id = cpu_topo.thread_id;
+
+        ms->possible_cpus->cpus[n].arch_id =
+                                virt_get_arch_id_from_cpu_topo(ms, &cpu_topo);
     }
     return ms->possible_cpus;
 }
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 65f9320e34..a5153cb3bc 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -19,6 +19,7 @@
 #include "cpu-csr.h"
 #include "sysemu/reset.h"
 #include "tcg/tcg.h"
+#include "hw/qdev-properties.h"
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -728,10 +729,19 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
 
-    return cpu->phy_id;
+    return cpu->arch_id;
 }
 #endif
 
+static Property loongarch_cpu_properties[] = {
+    DEFINE_PROP_INT32("socket-id", LoongArchCPU, socket_id, 0),
+    DEFINE_PROP_INT32("core-id", LoongArchCPU, core_id, 0),
+    DEFINE_PROP_INT32("thread-id", LoongArchCPU, thread_id, 0),
+    DEFINE_PROP_INT32("node-id", LoongArchCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
+
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 {
     LoongArchCPUClass *lacc = LOONGARCH_CPU_CLASS(c);
@@ -739,6 +749,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 4d7201995a..058bc53bde 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -362,6 +362,12 @@ typedef struct CPUArchState {
 #endif
 } CPULoongArchState;
 
+typedef struct LoongArchCPUTopo {
+    int32_t socket_id;  /* socket-id of this VCPU */
+    int32_t core_id;    /* core-id of this VCPU */
+    int32_t thread_id;  /* thread-id of this VCPU */
+} LoongArchCPUTopo;
+
 /**
  * LoongArchCPU:
  * @env: #CPULoongArchState
@@ -373,10 +379,14 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    int32_t socket_id;  /* socket-id of this VCPU */
+    int32_t core_id;    /* core-id of this VCPU */
+    int32_t thread_id;  /* thread-id of this VCPU */
+    int32_t node_id;    /* NUMA node this CPU belongs to */
     CPUNegativeOffsetState neg;
     CPULoongArchState env;
     QEMUTimer timer;
-    uint32_t  phy_id;
+    uint32_t  arch_id;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
-- 
2.39.1


