Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F664707785
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 03:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzSe3-0000is-K3; Wed, 17 May 2023 21:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1pzSe1-0000i6-CM
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:41:29 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1pzSdz-0003Y4-4e
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:41:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxPus9gmVkH7IJAA--.16778S3;
 Thu, 18 May 2023 09:41:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLb87gmVkGwJnAA--.45501S3; 
 Thu, 18 May 2023 09:41:16 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v1 1/2] hw/loongarch/virt: Add cpu arch_id support
Date: Thu, 18 May 2023 09:41:14 +0800
Message-Id: <20230518014115.117869-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230518014115.117869-1-gaosong@loongson.cn>
References: <20230518014115.117869-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLb87gmVkGwJnAA--.45501S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxtFWDGw1ktrWrurykZrWDArb_yoW7uryDpw
 4jv3yFqwnrXw1fZws3G3sIgF1rJr1kCw12qan7KrsYk3WDK348JFW0k3sIyFZrKw1kXF1D
 Xr4kt3W7WF47ArUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bnxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
 AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
 7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
 kF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020E
 x4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26rWlOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
 1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7xRE6wZ7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

With acpi madt table, there is cpu physical coreid, which may
be different with logical id in qemu. This patch adds cpu arch_id
support, and fill madt table with arch_id. For the present cpu
arch_id is still equal to logical id.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/loongarch/acpi-build.c | 20 ++++++++++++++------
 hw/loongarch/virt.c       | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
index 8e3ce07367..232344e1c7 100644
--- a/hw/loongarch/acpi-build.c
+++ b/hw/loongarch/acpi-build.c
@@ -107,7 +107,9 @@ static void
 build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
 {
     MachineState *ms = MACHINE(lams);
-    int i;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
+    int i, arch_id;
     AcpiTable table = { .sig = "APIC", .rev = 1, .oem_id = lams->oem_id,
                         .oem_table_id = lams->oem_table_id };
 
@@ -117,13 +119,15 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
     build_append_int_noprefix(table_data, 0, 4);
     build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
 
-    for (i = 0; i < ms->smp.cpus; i++) {
+    for (i = 0; i < arch_ids->len; i++) {
         /* Processor Core Interrupt Controller Structure */
+        arch_id = arch_ids->cpus[i].arch_id;
+
         build_append_int_noprefix(table_data, 17, 1);    /* Type */
         build_append_int_noprefix(table_data, 15, 1);    /* Length */
         build_append_int_noprefix(table_data, 1, 1);     /* Version */
         build_append_int_noprefix(table_data, i + 1, 4); /* ACPI Processor ID */
-        build_append_int_noprefix(table_data, i, 4);     /* Core ID */
+        build_append_int_noprefix(table_data, arch_id, 4); /* Core ID */
         build_append_int_noprefix(table_data, 1, 4);     /* Flags */
     }
 
@@ -159,9 +163,11 @@ build_madt(GArray *table_data, BIOSLinker *linker, LoongArchMachineState *lams)
 static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
-    uint64_t i;
+    int i, arch_id;
     LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
     MachineState *ms = MACHINE(lams);
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
+    const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
     AcpiTable table = { .sig = "SRAT", .rev = 1, .oem_id = lams->oem_id,
                         .oem_table_id = lams->oem_table_id };
 
@@ -169,13 +175,15 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
     build_append_int_noprefix(table_data, 1, 4); /* Reserved */
     build_append_int_noprefix(table_data, 0, 8); /* Reserved */
 
-    for (i = 0; i < ms->smp.cpus; ++i) {
+    for (i = 0; i < arch_ids->len; ++i) {
+        arch_id = arch_ids->cpus[i].arch_id;
+
         /* Processor Local APIC/SAPIC Affinity Structure */
         build_append_int_noprefix(table_data, 0, 1);  /* Type  */
         build_append_int_noprefix(table_data, 16, 1); /* Length */
         /* Proximity Domain [7:0] */
         build_append_int_noprefix(table_data, 0, 1);
-        build_append_int_noprefix(table_data, i, 1); /* APIC ID */
+        build_append_int_noprefix(table_data, arch_id, 1); /* APIC ID */
         /* Flags, Table 5-36 */
         build_append_int_noprefix(table_data, 1, 4);
         build_append_int_noprefix(table_data, 0, 1); /* Local SAPIC EID */
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 2b7588e32a..83c1e43ff5 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -770,6 +770,9 @@ static void loongarch_init(MachineState *machine)
     LoongArchMachineState *lams = LOONGARCH_MACHINE(machine);
     int i;
     hwaddr fdt_base;
+    const CPUArchIdList *possible_cpus;
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    CPUState *cpu;
 
     if (!cpu_model) {
         cpu_model = LOONGARCH_CPU_TYPE_NAME("la464");
@@ -786,8 +789,12 @@ static void loongarch_init(MachineState *machine)
     }
     create_fdt(lams);
     /* Init CPUs */
-    for (i = 0; i < machine->smp.cpus; i++) {
-        cpu_create(machine->cpu_type);
+
+    possible_cpus = mc->possible_cpu_arch_ids(machine);
+    for (i = 0; i < possible_cpus->len; i++) {
+        cpu = cpu_create(machine->cpu_type);
+        cpu->cpu_index = i;
+        machine->possible_cpus->cpus[i].cpu = OBJECT(cpu);
     }
     fdt_add_cpu_nodes(lams);
     /* Add memory region */
@@ -1021,6 +1028,28 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
     return NULL;
 }
 
+static const CPUArchIdList *virt_possible_cpu_arch_ids(MachineState *ms)
+{
+    int n;
+    unsigned int max_cpus = ms->smp.max_cpus;
+
+    if (ms->possible_cpus) {
+        assert(ms->possible_cpus->len == max_cpus);
+        return ms->possible_cpus;
+    }
+
+    ms->possible_cpus = g_malloc0(sizeof(CPUArchIdList) +
+                                  sizeof(CPUArchId) * max_cpus);
+    ms->possible_cpus->len = max_cpus;
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        ms->possible_cpus->cpus[n].type = ms->cpu_type;
+        ms->possible_cpus->cpus[n].arch_id = n;
+        ms->possible_cpus->cpus[n].props.has_core_id = true;
+        ms->possible_cpus->cpus[n].props.core_id = n;
+    }
+    return ms->possible_cpus;
+}
+
 static void loongarch_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1037,6 +1066,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_VIRTIO;
     mc->default_boot_order = "c";
     mc->no_cdrom = 1;
+    mc->possible_cpu_arch_ids = virt_possible_cpu_arch_ids;
     mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
     hc->plug = loongarch_machine_device_plug_cb;
     hc->pre_plug = virt_machine_device_pre_plug;
-- 
2.39.1


