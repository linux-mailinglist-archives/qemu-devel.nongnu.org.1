Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5373F72E27B
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 14:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q92mp-0001Va-1U; Tue, 13 Jun 2023 08:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1q92mk-0001Ut-VT
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:06:06 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1q92mh-0000RT-UF
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 08:06:06 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxDeukW4hkcKIEAA--.9915S3;
 Tue, 13 Jun 2023 20:05:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxZuSgW4hkkh0ZAA--.6290S4; 
 Tue, 13 Jun 2023 20:05:55 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, philmd@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 alex.bennee@linaro.org, maobibo@loongson.cn, yangxiaojuan@loongson.cn,
 zhaotianrui@loongson.cn, gaosong@loongson.cn
Subject: [PATCH v2 2/2] hw/intc: Set physical cpuid route for LoongArch ipi
 device
Date: Tue, 13 Jun 2023 20:05:52 +0800
Message-Id: <20230613120552.2471420-3-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230613120552.2471420-1-zhaotianrui@loongson.cn>
References: <20230613120552.2471420-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxZuSgW4hkkh0ZAA--.6290S4
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
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

LoongArch ipi device uses physical cpuid to route to different
vcpus rather logical cpuid, and the physical cpuid is the same
with cpuid in acpi dsdt and srat table.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 44 ++++++++++++++++++++++++++++++++++-------
 hw/loongarch/virt.c     |  1 +
 target/loongarch/cpu.h  |  2 ++
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 3e45381652..67858b521c 100644
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
index ced5a862f8..17bc37bccd 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -617,6 +617,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
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


