Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29AA707786
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 03:43:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzSe4-0000jH-2b; Wed, 17 May 2023 21:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1pzSe0-0000h7-Ir
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:41:28 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1pzSdy-0003Y8-2n
 for qemu-devel@nongnu.org; Wed, 17 May 2023 21:41:28 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxFuk9gmVkJLIJAA--.16988S3;
 Thu, 18 May 2023 09:41:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLb87gmVkGwJnAA--.45501S4; 
 Thu, 18 May 2023 09:41:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn
Subject: [PATCH v1 2/2] hw/intc: Set physical cpuid route for LoongArch ipi
 device
Date: Thu, 18 May 2023 09:41:15 +0800
Message-Id: <20230518014115.117869-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230518014115.117869-1-gaosong@loongson.cn>
References: <20230518014115.117869-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxLb87gmVkGwJnAA--.45501S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF48Jw4kGFy3uFWfuw17Wrg_yoWrJF1rpF
 y7ur1a9r40qFZxXas3G34DXrn8Jrn7Wa429a1Ska9YkF4DWry8WF1kt34qqFyDA34rXF4Y
 vFs7Jw42gF42qrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bnkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4
 AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF
 7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
 kF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020E
 x4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26rWlOx8S6xCaFV
 Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v
 1sIEY20_WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0zRVWlkUUUUU=
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

LoongArch ipi device uses physical cpuid to route to different
vcpus rather logical cpuid, and the physical cpuid is the same
with cpuid in acpi dsdt and srat table.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 44 ++++++++++++++++++++++++++++++++++-------
 hw/loongarch/virt.c     |  1 +
 target/loongarch/cpu.h  |  2 ++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index d6ab91721e..e5f396ca75 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -17,6 +17,8 @@
 #include "target/loongarch/internals.h"
 #include "trace.h"
 
+static void loongarch_ipi_writel(void *, hwaddr, uint64_t, unsigned);
+
 static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
 {
     IPICore *s = opaque;
@@ -75,13 +77,42 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
                       data, MEMTXATTRS_UNSPECIFIED, NULL);
 }
 
+static int archid_cmp(const void *a, const void *b)
+{
+   CPUArchId *archid_a = (CPUArchId *)a;
+   CPUArchId *archid_b = (CPUArchId *)b;
+
+   return archid_a->arch_id - archid_b->arch_id;
+}
+
+static CPUArchId *find_cpu_by_archid(MachineState *ms, uint32_t id)
+{
+    CPUArchId apic_id, *found_cpu;
+
+    apic_id.arch_id = id;
+    found_cpu = bsearch(&apic_id, ms->possible_cpus->cpus,
+        ms->possible_cpus->len, sizeof(*ms->possible_cpus->cpus),
+        archid_cmp);
+
+    return found_cpu;
+}
+
+static CPUState *ipi_getcpu(int arch_id)
+{
+    MachineState *machine = MACHINE(qdev_get_machine());
+    CPUArchId *archid;
+
+    archid = find_cpu_by_archid(machine, arch_id);
+    return CPU(archid->cpu);
+}
+
 static void ipi_send(uint64_t val)
 {
     uint32_t cpuid;
     uint8_t vector;
-    CPULoongArchState *env;
     CPUState *cs;
     LoongArchCPU *cpu;
+    LoongArchIPI *s;
 
     cpuid = extract32(val, 16, 10);
     if (cpuid >= LOONGARCH_MAX_CPUS) {
@@ -92,11 +123,10 @@ static void ipi_send(uint64_t val)
     /* IPI status vector */
     vector = extract8(val, 0, 5);
 
-    cs = qemu_get_cpu(cpuid);
+    cs = ipi_getcpu(cpuid);
     cpu = LOONGARCH_CPU(cs);
-    env = &cpu->env;
-    address_space_stl(&env->address_space_iocsr, 0x1008,
-                      BIT(vector), MEMTXATTRS_UNSPECIFIED, NULL);
+    s = LOONGARCH_IPI(cpu->env.ipistate);
+    loongarch_ipi_writel(&s->ipi_core, CORE_SET_OFF, BIT(vector), 4);
 }
 
 static void mail_send(uint64_t val)
@@ -114,7 +144,7 @@ static void mail_send(uint64_t val)
     }
 
     addr = 0x1020 + (val & 0x1c);
-    cs = qemu_get_cpu(cpuid);
+    cs = ipi_getcpu(cpuid);
     cpu = LOONGARCH_CPU(cs);
     env = &cpu->env;
     send_ipi_data(env, val, addr);
@@ -135,7 +165,7 @@ static void any_send(uint64_t val)
     }
 
     addr = val & 0xffff;
-    cs = qemu_get_cpu(cpuid);
+    cs = ipi_getcpu(cpuid);
     cpu = LOONGARCH_CPU(cs);
     env = &cpu->env;
     send_ipi_data(env, val, addr);
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 83c1e43ff5..6e1c42fb2b 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -616,6 +616,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
             memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
                                 cpu));
+        env->ipistate = ipi;
     }
 
     /*
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 1f37e36b7c..b23f38c3d5 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -351,6 +351,8 @@ typedef struct CPUArchState {
     MemoryRegion iocsr_mem;
     bool load_elf;
     uint64_t elf_address;
+    /* Store ipistate to access from this struct */
+    DeviceState *ipistate;
 #endif
 } CPULoongArchState;
 
-- 
2.39.1


