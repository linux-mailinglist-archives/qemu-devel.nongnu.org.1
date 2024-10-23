Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C19ABFE7
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Oct 2024 09:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VYm-0004wM-2Y; Wed, 23 Oct 2024 03:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3VYZ-0004tW-L0
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:25 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1t3VYW-0005GJ-Il
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:13:23 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxDeMNohhnX2QHAA--.17082S3;
 Wed, 23 Oct 2024 15:13:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxP+EIohhnpeYKAA--.63247S3;
 Wed, 23 Oct 2024 15:13:16 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 1/3] hw/loongarch/virt: Add CPU topology support
Date: Wed, 23 Oct 2024 15:13:10 +0800
Message-Id: <20241023071312.881866-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241023071312.881866-1-maobibo@loongson.cn>
References: <20241023071312.881866-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxP+EIohhnpeYKAA--.63247S3
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

Add topological relationships for Loongarch VCPU and initialize
topology member variables. Also physical cpu id calculation
method comes from its topo information.

Co-developed-by: Xianglai Li <lixianglai@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 docs/system/loongarch/virt.rst | 31 +++++++++++++
 hw/loongarch/virt.c            | 82 ++++++++++++++++++++++++++++------
 target/loongarch/cpu.c         | 12 +++++
 target/loongarch/cpu.h         | 11 +++++
 4 files changed, 122 insertions(+), 14 deletions(-)

diff --git a/docs/system/loongarch/virt.rst b/docs/system/loongarch/virt.rst
index 172fba079e..9d00989950 100644
--- a/docs/system/loongarch/virt.rst
+++ b/docs/system/loongarch/virt.rst
@@ -28,6 +28,37 @@ The ``qemu-system-loongarch64`` provides emulation for virt
 machine. You can specify the machine type ``virt`` and
 cpu type ``la464``.
 
+CPU Topology
+------------
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
index 9a635d1d3d..757bf6b6dc 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -1143,9 +1143,7 @@ static void virt_init(MachineState *machine)
     LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
     int i;
     hwaddr base, size, ram_size = machine->ram_size;
-    const CPUArchIdList *possible_cpus;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
-    CPUState *cpu;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -1163,14 +1161,39 @@ static void virt_init(MachineState *machine)
     memory_region_add_subregion(&lvms->system_iocsr, 0, &lvms->iocsr_mem);
 
     /* Init CPUs */
-    possible_cpus = mc->possible_cpu_arch_ids(machine);
-    for (i = 0; i < possible_cpus->len; i++) {
-        cpu = cpu_create(machine->cpu_type);
-        cpu->cpu_index = i;
-        machine->possible_cpus->cpus[i].cpu = cpu;
-        lacpu = LOONGARCH_CPU(cpu);
+    mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < machine->smp.cpus; i++) {
+        Object *cpuobj;
+        cpuobj = object_new(machine->cpu_type);
+        lacpu = LOONGARCH_CPU(cpuobj);
+
         lacpu->phy_id = machine->possible_cpus->cpus[i].arch_id;
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
     fdt_add_cpu_nodes(lvms);
     fdt_add_memory_nodes(machine);
     fw_cfg_add_memory(machine);
@@ -1286,6 +1309,27 @@ static void virt_initfn(Object *obj)
     virt_flash_create(lvms);
 }
 
+static int virt_get_arch_id_from_topo(MachineState *ms, LoongArchCPUTopo *topo)
+{
+    int arch_id, sock_vcpu_num, core_vcpu_num;
+
+    /*
+     * calculate total logical cpus across socket/core/thread.
+     * For more information on how to calculate the arch_id,
+     * you can refer to the CPU Topology chapter of the
+     * docs/system/loongarch/virt.rst document.
+     */
+    sock_vcpu_num = topo->socket_id * (ms->smp.threads * ms->smp.cores);
+    core_vcpu_num = topo->core_id * ms->smp.threads;
+
+    /* get vcpu-id(logical cpu index) for this vcpu from this topology */
+    arch_id = (sock_vcpu_num + core_vcpu_num) + topo->thread_id;
+
+    assert(arch_id >= 0 && arch_id < ms->possible_cpus->len);
+
+    return arch_id;
+}
+
 static bool memhp_type_supported(DeviceState *dev)
 {
     /* we only support pc dimm now */
@@ -1383,10 +1427,19 @@ static HotplugHandler *virt_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static void virt_get_cpu_topo_from_index(MachineState *ms,
+                                         LoongArchCPUTopo *topo, int index)
+{
+    topo->socket_id  = index / (ms->smp.cores * ms->smp.threads);
+    topo->core_id = index / ms->smp.threads % ms->smp.cores;
+    topo->thread_id = index % ms->smp.threads;
+}
+
 static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
 {
     int n;
     unsigned int max_cpus = ms->smp.max_cpus;
+    LoongArchCPUTopo topo;
 
     if (ms->possible_cpus) {
         assert(ms->possible_cpus->len == max_cpus);
@@ -1397,17 +1450,18 @@ static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
                                   sizeof(CPUArchId) * max_cpus);
     ms->possible_cpus->len = max_cpus;
     for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].vcpus_count = ms->smp.threads;
         ms->possible_cpus->cpus[n].type = ms->cpu_type;
-        ms->possible_cpus->cpus[n].arch_id = n;
+        virt_get_cpu_topo_from_index(ms, &topo, n);
 
         ms->possible_cpus->cpus[n].props.has_socket_id = true;
-        ms->possible_cpus->cpus[n].props.socket_id  =
-                                   n / (ms->smp.cores * ms->smp.threads);
+        ms->possible_cpus->cpus[n].props.socket_id  = topo.socket_id;
         ms->possible_cpus->cpus[n].props.has_core_id = true;
-        ms->possible_cpus->cpus[n].props.core_id =
-                                   n / ms->smp.threads % ms->smp.cores;
+        ms->possible_cpus->cpus[n].props.core_id = topo.core_id;
         ms->possible_cpus->cpus[n].props.has_thread_id = true;
-        ms->possible_cpus->cpus[n].props.thread_id = n % ms->smp.threads;
+        ms->possible_cpus->cpus[n].props.thread_id = topo.thread_id;
+        ms->possible_cpus->cpus[n].arch_id =
+                                virt_get_arch_id_from_topo(ms, &topo);
     }
     return ms->possible_cpus;
 }
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7212fb5f8f..f4023e25ef 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -16,6 +16,7 @@
 #include "kvm/kvm_loongarch.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
+#include "hw/qdev-properties.h"
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
 #include "cpu-csr.h"
@@ -780,6 +781,15 @@ static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
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
@@ -787,6 +797,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
     DeviceClass *dc = DEVICE_CLASS(c);
     ResettableClass *rc = RESETTABLE_CLASS(c);
 
+    device_class_set_props(dc, loongarch_cpu_properties);
     device_class_set_parent_realize(dc, loongarch_cpu_realizefn,
                                     &lacc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_cpu_reset_hold, NULL,
@@ -811,6 +822,7 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
 #ifdef CONFIG_TCG
     cc->tcg_ops = &loongarch_tcg_ops;
 #endif
+    dc->user_creatable = true;
 }
 
 static const gchar *loongarch32_gdb_arch_name(CPUState *cs)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 6c41fafb70..f564ebf1c0 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -369,6 +369,12 @@ typedef struct CPUArchState {
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
@@ -381,6 +387,10 @@ struct ArchCPU {
     CPULoongArchState env;
     QEMUTimer timer;
     uint32_t  phy_id;
+    int32_t socket_id;  /* socket-id of this VCPU */
+    int32_t core_id;    /* core-id of this VCPU */
+    int32_t thread_id;  /* thread-id of this VCPU */
+    int32_t node_id;    /* NUMA node this CPU belongs to */
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
@@ -399,6 +409,7 @@ struct LoongArchCPUClass {
     CPUClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
-- 
2.39.3


