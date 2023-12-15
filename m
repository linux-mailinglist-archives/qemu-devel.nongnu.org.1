Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9FD81451A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE52u-0003Qa-Dm; Fri, 15 Dec 2023 05:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rE52o-0003PQ-Nf
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:47 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rE52k-0004tX-LS
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:46 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxJPB3JHxlQFABAA--.7362S3;
 Fri, 15 Dec 2023 18:03:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrnN1JHxldl0FAA--.26862S4; 
 Fri, 15 Dec 2023 18:03:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] hw/loongarch/virt: Set iocsr address space per-board
 rather than percpu
Date: Fri, 15 Dec 2023 18:03:31 +0800
Message-Id: <20231215100333.3933632-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231215100333.3933632-1-maobibo@loongson.cn>
References: <20231215100333.3933632-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrnN1JHxldl0FAA--.26862S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9fXoW3ury5Gw1rtw18KF18tw1rKrX_yoW8ArWkJo
 W5AFyFva1rGr4IvryqyrZ0vrW7tFZFkrZxAayfZan8Way8JFW5XayUK3Z0q343J3Z5Kr1D
 J34UKFn5Jry7Jrykl-sFpf9Il3svdjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8wcxFpf
 9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
 UjIYCTnIWjp_UUUY17kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
 8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
 Y2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280
 aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28Icx
 kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
 xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42
 IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY
 6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aV
 CY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

LoongArch system has iocsr address space, most iocsr registers are
per-board, however some iocsr register spaces banked for percpu such
as ipi mailbox and extioi interrupt status. For banked iocsr space,
each cpu has the same iocsr space, but separate data.

This patch changes iocsr address space per-board rather percpu,
for iocsr registers specified for cpu, MemTxAttrs.requester_id
can be parsed for the cpu. With this patches, the total address space
on board will be simple, only iocsr address space and system memory,
rather than the number of cpu and system memory.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c         |  3 -
 hw/intc/loongarch_ipi.c            | 61 +++++++++++++++-----
 hw/loongarch/virt.c                | 91 ++++++++++++++++++++++--------
 include/hw/intc/loongarch_extioi.h |  1 -
 include/hw/intc/loongarch_ipi.h    |  3 +-
 include/hw/loongarch/virt.h        |  3 +
 target/loongarch/cpu.c             | 48 ----------------
 target/loongarch/cpu.h             |  4 +-
 target/loongarch/iocsr_helper.c    | 16 +++---
 9 files changed, 127 insertions(+), 103 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 24fb3af8cc..77b4776958 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -282,9 +282,6 @@ static void loongarch_extioi_instance_init(Object *obj)
     qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);
 
     for (cpu = 0; cpu < EXTIOI_CPUS; cpu++) {
-        memory_region_init_io(&s->extioi_iocsr_mem[cpu], OBJECT(s), &extioi_ops,
-                              s, "extioi_iocsr", 0x900);
-        sysbus_init_mmio(dev, &s->extioi_iocsr_mem[cpu]);
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_init_gpio_out(DEVICE(obj), &s->parent_irq[cpu][pin], 1);
         }
diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 1d3449e77d..bca01c88f6 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -9,6 +9,7 @@
 #include "hw/sysbus.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
@@ -26,7 +27,7 @@ static MemTxResult loongarch_ipi_readl(void *opaque, hwaddr addr,
     uint64_t ret = 0;
     int index = 0;
 
-    s = &ipi->ipi_core;
+    s = &ipi->cpu[attrs.requester_id];
     addr &= 0xff;
     switch (addr) {
     case CORE_STATUS_OFF:
@@ -65,7 +66,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(&env->address_space_iocsr, addr,
+        data = address_space_ldl(env->address_space_iocsr, addr,
                                  attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
@@ -77,7 +78,7 @@ static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr,
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(&env->address_space_iocsr, addr,
+    address_space_stl(env->address_space_iocsr, addr,
                       data, attrs, NULL);
 }
 
@@ -172,7 +173,7 @@ static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
     uint8_t vector;
     CPUState *cs;
 
-    s = &ipi->ipi_core;
+    s = &ipi->cpu[attrs.requester_id];
     addr &= 0xff;
     trace_loongarch_ipi_write(size, (uint64_t)addr, val);
     switch (addr) {
@@ -214,7 +215,6 @@ static MemTxResult loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
 
         /* override requester_id */
         attrs.requester_id = cs->cpu_index;
-        ipi = LOONGARCH_IPI(LOONGARCH_CPU(cs)->env.ipistate);
         loongarch_ipi_writel(ipi, CORE_SET_OFF, BIT(vector), 4, attrs);
         break;
     default:
@@ -265,12 +265,18 @@ static const MemoryRegionOps loongarch_ipi64_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongarch_ipi_init(Object *obj)
+static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
-    LoongArchIPI *s = LOONGARCH_IPI(obj);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    LoongArchIPI *s = LOONGARCH_IPI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
 
-    memory_region_init_io(&s->ipi_iocsr_mem, obj, &loongarch_ipi_ops,
+    memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev), &loongarch_ipi_ops,
                           s, "loongarch_ipi_iocsr", 0x48);
 
     /* loongarch_ipi_iocsr performs re-entrant IO through ipi_send */
@@ -278,10 +284,20 @@ static void loongarch_ipi_init(Object *obj)
 
     sysbus_init_mmio(sbd, &s->ipi_iocsr_mem);
 
-    memory_region_init_io(&s->ipi64_iocsr_mem, obj, &loongarch_ipi64_ops,
+    memory_region_init_io(&s->ipi64_iocsr_mem, OBJECT(dev),
+                          &loongarch_ipi64_ops,
                           s, "loongarch_ipi64_iocsr", 0x118);
     sysbus_init_mmio(sbd, &s->ipi64_iocsr_mem);
-    qdev_init_gpio_out(DEVICE(obj), &s->ipi_core.irq, 1);
+
+    s->cpu = g_new0(IPICore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        qdev_init_gpio_out(dev, &s->cpu[i].irq, 1);
+    }
 }
 
 static const VMStateDescription vmstate_ipi_core = {
@@ -300,27 +316,42 @@ static const VMStateDescription vmstate_ipi_core = {
 
 static const VMStateDescription vmstate_loongarch_ipi = {
     .name = TYPE_LOONGARCH_IPI,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_STRUCT(ipi_core, LoongArchIPI, 0, vmstate_ipi_core, IPICore),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchIPI, num_cpu,
+                         vmstate_ipi_core, IPICore),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static Property ipi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongArchIPI, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = loongarch_ipi_realize;
+    device_class_set_props(dc, ipi_properties);
     dc->vmsd = &vmstate_loongarch_ipi;
 }
 
+static void loongarch_ipi_finalize(Object *obj)
+{
+    LoongArchIPI *s = LOONGARCH_IPI(obj);
+
+    g_free(s->cpu);
+}
+
 static const TypeInfo loongarch_ipi_info = {
     .name          = TYPE_LOONGARCH_IPI,
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(LoongArchIPI),
-    .instance_init = loongarch_ipi_init,
     .class_init    = loongarch_ipi_class_init,
+    .instance_finalize = loongarch_ipi_finalize,
 };
 
 static void loongarch_ipi_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 4b7dc67a2d..13d19b6da3 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -535,9 +535,6 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
     CPUState *cpu_state;
     int cpu, pin, i, start, num;
 
-    extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
-
     /*
      * The connection of interrupts:
      *   +-----+    +---------+     +-------+
@@ -559,36 +556,36 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      * | UARTs  | | Devices | | Devices |
      * +--------+ +---------+ +---------+
      */
+
+    /* Create IPI device */
+    ipi = qdev_new(TYPE_LOONGARCH_IPI);
+    qdev_prop_set_uint32(ipi, "num-cpu", ms->smp.cpus);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+
+    /* IPI iocsr memory region */
+    memory_region_add_subregion(&lams->system_iocsr, SMP_IPI_MAILBOX,
+                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 0));
+    memory_region_add_subregion(&lams->system_iocsr, MAIL_SEND_ADDR,
+                   sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi), 1));
+
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpu_state = qemu_get_cpu(cpu);
         cpudev = DEVICE(cpu_state);
         lacpu = LOONGARCH_CPU(cpu_state);
         env = &(lacpu->env);
-
-        ipi = qdev_new(TYPE_LOONGARCH_IPI);
-        sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+        env->address_space_iocsr = &lams->as_iocsr;
 
         /* connect ipi irq to cpu irq */
-        qdev_connect_gpio_out(ipi, 0, qdev_get_gpio_in(cpudev, IRQ_IPI));
-        /* IPI iocsr memory region */
-        memory_region_add_subregion(&env->system_iocsr, SMP_IPI_MAILBOX,
-                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
-                                    0));
-        memory_region_add_subregion(&env->system_iocsr, MAIL_SEND_ADDR,
-                                    sysbus_mmio_get_region(SYS_BUS_DEVICE(ipi),
-                                    1));
-        /*
-	 * extioi iocsr memory region
-	 * only one extioi is added on loongarch virt machine
-	 * external device interrupt can only be routed to cpu 0-3
-	 */
-	if (cpu < EXTIOI_CPUS)
-            memory_region_add_subregion(&env->system_iocsr, APIC_BASE,
-                                sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi),
-                                cpu));
+        qdev_connect_gpio_out(ipi, cpu, qdev_get_gpio_in(cpudev, IRQ_IPI));
         env->ipistate = ipi;
     }
 
+    /* Create EXTIOI device */
+    extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
+    memory_region_add_subregion(&lams->system_iocsr, APIC_BASE,
+                   sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
+
     /*
      * connect ext irq to the cpu irq
      * cpu_pin[9:2] <= intc_pin[7:0]
@@ -733,6 +730,43 @@ static void loongarch_direct_kernel_boot(LoongArchMachineState *lams,
     }
 }
 
+static void loongarch_qemu_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+}
+
+static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
+{
+    switch (addr) {
+    case VERSION_REG:
+        return 0x11ULL;
+    case FEATURE_REG:
+        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
+               1ULL << IOCSRF_CSRIPI;
+    case VENDOR_REG:
+        return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
+    case CPUNAME_REG:
+        return 0x303030354133ULL;     /* "3A5000" */
+    case MISC_FUNC_REG:
+        return 1ULL << IOCSRM_EXTIOI_EN;
+    }
+    return 0ULL;
+}
+
+static const MemoryRegionOps loongarch_qemu_ops = {
+    .read = loongarch_qemu_read,
+    .write = loongarch_qemu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 8,
+        .max_access_size = 8,
+    },
+};
+
 static void loongarch_init(MachineState *machine)
 {
     LoongArchCPU *lacpu;
@@ -761,8 +795,17 @@ static void loongarch_init(MachineState *machine)
         exit(1);
     }
     create_fdt(lams);
-    /* Init CPUs */
 
+    /* Create IOCSR space */
+    memory_region_init_io(&lams->system_iocsr, OBJECT(machine), NULL,
+                          machine, "iocsr", UINT64_MAX);
+    address_space_init(&lams->as_iocsr, &lams->system_iocsr, "IOCSR");
+    memory_region_init_io(&lams->iocsr_mem, OBJECT(machine),
+                          &loongarch_qemu_ops,
+                          machine, "iocsr_misc", 0x428);
+    memory_region_add_subregion(&lams->system_iocsr, 0, &lams->iocsr_mem);
+
+    /* Init CPUs */
     possible_cpus = mc->possible_cpu_arch_ids(machine);
     for (i = 0; i < possible_cpus->len; i++) {
         cpu = cpu_create(machine->cpu_type);
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index fbdef9a7b3..110e5e8873 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -58,7 +58,6 @@ struct LoongArchExtIOI {
     uint8_t  sw_coremap[EXTIOI_IRQS];
     qemu_irq parent_irq[EXTIOI_CPUS][LS3A_INTC_IP];
     qemu_irq irq[EXTIOI_IRQS];
-    MemoryRegion extioi_iocsr_mem[EXTIOI_CPUS];
     MemoryRegion extioi_system_mem;
 };
 #endif /* LOONGARCH_EXTIOI_H */
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 6c6194786e..1c1e834849 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -47,7 +47,8 @@ struct LoongArchIPI {
     SysBusDevice parent_obj;
     MemoryRegion ipi_iocsr_mem;
     MemoryRegion ipi64_iocsr_mem;
-    IPICore ipi_core;
+    uint32_t num_cpu;
+    IPICore *cpu;
 };
 
 #endif
diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
index 674f4655e0..373bf199f6 100644
--- a/include/hw/loongarch/virt.h
+++ b/include/hw/loongarch/virt.h
@@ -50,6 +50,9 @@ struct LoongArchMachineState {
     DeviceState *platform_bus_dev;
     PCIBus       *pci_bus;
     PFlashCFI01  *flash;
+    MemoryRegion system_iocsr;
+    MemoryRegion iocsr_mem;
+    AddressSpace as_iocsr;
 };
 
 #define TYPE_LOONGARCH_MACHINE  MACHINE_TYPE_NAME("virt")
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fc075952e6..c7ccf0cefd 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -582,47 +582,6 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     lacc->parent_realize(dev, errp);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void loongarch_qemu_write(void *opaque, hwaddr addr,
-                                 uint64_t val, unsigned size)
-{
-    qemu_log_mask(LOG_UNIMP, "[%s]: Unimplemented reg 0x%" HWADDR_PRIx "\n",
-                  __func__, addr);
-}
-
-static uint64_t loongarch_qemu_read(void *opaque, hwaddr addr, unsigned size)
-{
-    switch (addr) {
-    case VERSION_REG:
-        return 0x11ULL;
-    case FEATURE_REG:
-        return 1ULL << IOCSRF_MSI | 1ULL << IOCSRF_EXTIOI |
-               1ULL << IOCSRF_CSRIPI;
-    case VENDOR_REG:
-        return 0x6e6f73676e6f6f4cULL; /* "Loongson" */
-    case CPUNAME_REG:
-        return 0x303030354133ULL;     /* "3A5000" */
-    case MISC_FUNC_REG:
-        return 1ULL << IOCSRM_EXTIOI_EN;
-    }
-    return 0ULL;
-}
-
-static const MemoryRegionOps loongarch_qemu_ops = {
-    .read = loongarch_qemu_read,
-    .write = loongarch_qemu_write,
-    .endianness = DEVICE_LITTLE_ENDIAN,
-    .valid = {
-        .min_access_size = 4,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 8,
-        .max_access_size = 8,
-    },
-};
-#endif
-
 static bool loongarch_get_lsx(Object *obj, Error **errp)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -693,17 +652,10 @@ static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    CPULoongArchState *env = &cpu->env;
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
-    memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
-                          env, "iocsr", UINT64_MAX);
-    address_space_init(&env->address_space_iocsr, &env->system_iocsr, "IOCSR");
-    memory_region_init_io(&env->iocsr_mem, OBJECT(cpu), &loongarch_qemu_ops,
-                          NULL, "iocsr_misc", 0x428);
-    memory_region_add_subregion(&env->system_iocsr, 0, &env->iocsr_mem);
 #endif
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 00d1fba597..0075ebd549 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -355,9 +355,7 @@ typedef struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
 
-    AddressSpace address_space_iocsr;
-    MemoryRegion system_iocsr;
-    MemoryRegion iocsr_mem;
+    AddressSpace *address_space_iocsr;
     bool load_elf;
     uint64_t elf_address;
     /* Store ipistate to access from this struct */
diff --git a/target/loongarch/iocsr_helper.c b/target/loongarch/iocsr_helper.c
index 6cd01d5f09..b6916f53d2 100644
--- a/target/loongarch/iocsr_helper.c
+++ b/target/loongarch/iocsr_helper.c
@@ -17,52 +17,52 @@
 
 uint64_t helper_iocsrrd_b(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldub(&env->address_space_iocsr, r_addr,
+    return address_space_ldub(env->address_space_iocsr, r_addr,
                               GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_h(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_lduw(&env->address_space_iocsr, r_addr,
+    return address_space_lduw(env->address_space_iocsr, r_addr,
                               GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_w(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldl(&env->address_space_iocsr, r_addr,
+    return address_space_ldl(env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);
 }
 
 uint64_t helper_iocsrrd_d(CPULoongArchState *env, target_ulong r_addr)
 {
-    return address_space_ldq(&env->address_space_iocsr, r_addr,
+    return address_space_ldq(env->address_space_iocsr, r_addr,
                              GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_b(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stb(&env->address_space_iocsr, w_addr,
+    address_space_stb(env->address_space_iocsr, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_h(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stw(&env->address_space_iocsr, w_addr,
+    address_space_stw(env->address_space_iocsr, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_w(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stl(&env->address_space_iocsr, w_addr,
+    address_space_stl(env->address_space_iocsr, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
 
 void helper_iocsrwr_d(CPULoongArchState *env, target_ulong w_addr,
                       target_ulong val)
 {
-    address_space_stq(&env->address_space_iocsr, w_addr,
+    address_space_stq(env->address_space_iocsr, w_addr,
                       val, GET_MEMTXATTRS(env), NULL);
 }
-- 
2.39.3


