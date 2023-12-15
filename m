Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BF81451B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 11:04:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE52u-0003QW-DZ; Fri, 15 Dec 2023 05:03:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rE52n-0003PI-Td
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:45 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rE52k-0004td-OX
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 05:03:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxK+l3JHxlQVABAA--.7417S3;
 Fri, 15 Dec 2023 18:03:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxrnN1JHxldl0FAA--.26862S5; 
 Fri, 15 Dec 2023 18:03:35 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PATCH v2 3/4] hw/intc/loongarch_extioi: Add dynamic cpu number
 support
Date: Fri, 15 Dec 2023 18:03:32 +0800
Message-Id: <20231215100333.3933632-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231215100333.3933632-1-maobibo@loongson.cn>
References: <20231215100333.3933632-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxrnN1JHxldl0FAA--.26862S5
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GFy3Kw18ur1xKr18XFWfXrc_yoWDGrWUpr
 WUuFy5Kr48WFZ7W39rKasrur95Gr4fur129Fyaka4fuF4DCry0934vyr9rZFWrC3ykZ34j
 qa95C3W7WF1DC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1WlkUUUUU=
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

On LoongArch physical machine, one extioi interrupt controller only
supports 4 cpus. With processor more than 4 cpus, there are multiple
extioi interrupt controllers; if interrupts need to be routed to
other cpus, they are forwarded from extioi node0 to other extioi nodes.

On virt machine model, there is simple extioi interrupt device model.
All cpus can access register of extioi interrupt controller, however
interrupt can only be route to 4 vcpu for compatible with old kernel.

This patch adds dynamic cpu number support about extioi interrupt.
With old kernel legacy extioi model is used, however kernel can detect
and choose new route method in future, so that interrupt can be routed to
all vcpus.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c         | 107 +++++++++++++++++++----------
 hw/loongarch/virt.c                |   3 +-
 include/hw/intc/loongarch_extioi.h |  11 ++-
 3 files changed, 81 insertions(+), 40 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 77b4776958..d9d5066c3f 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -8,6 +8,7 @@
 #include "qemu/osdep.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/loongarch/virt.h"
@@ -32,23 +33,23 @@ static void extioi_update_irq(LoongArchExtIOI *s, int irq, int level)
         if (((s->enable[irq_index]) & irq_mask) == 0) {
             return;
         }
-        s->coreisr[cpu][irq_index] |= irq_mask;
-        found = find_first_bit(s->sw_isr[cpu][ipnum], EXTIOI_IRQS);
-        set_bit(irq, s->sw_isr[cpu][ipnum]);
+        s->cpu[cpu].coreisr[irq_index] |= irq_mask;
+        found = find_first_bit(s->cpu[cpu].sw_isr[ipnum], EXTIOI_IRQS);
+        set_bit(irq, s->cpu[cpu].sw_isr[ipnum]);
         if (found < EXTIOI_IRQS) {
             /* other irq is handling, need not update parent irq level */
             return;
         }
     } else {
-        s->coreisr[cpu][irq_index] &= ~irq_mask;
-        clear_bit(irq, s->sw_isr[cpu][ipnum]);
-        found = find_first_bit(s->sw_isr[cpu][ipnum], EXTIOI_IRQS);
+        s->cpu[cpu].coreisr[irq_index] &= ~irq_mask;
+        clear_bit(irq, s->cpu[cpu].sw_isr[ipnum]);
+        found = find_first_bit(s->cpu[cpu].sw_isr[ipnum], EXTIOI_IRQS);
         if (found < EXTIOI_IRQS) {
             /* other irq is handling, need not update parent irq level */
             return;
         }
     }
-    qemu_set_irq(s->parent_irq[cpu][ipnum], level);
+    qemu_set_irq(s->cpu[cpu].parent_irq[ipnum], level);
 }
 
 static void extioi_setirq(void *opaque, int irq, int level)
@@ -96,7 +97,7 @@ static MemTxResult extioi_readw(void *opaque, hwaddr addr, uint64_t *data,
         index = (offset - EXTIOI_COREISR_START) >> 2;
         /* using attrs to get current cpu index */
         cpu = attrs.requester_id;
-        *data = s->coreisr[cpu][index];
+        *data = s->cpu[cpu].coreisr[index];
         break;
     case EXTIOI_COREMAP_START ... EXTIOI_COREMAP_END - 1:
         index = (offset - EXTIOI_COREMAP_START) >> 2;
@@ -189,8 +190,8 @@ static MemTxResult extioi_writew(void *opaque, hwaddr addr,
         index = (offset - EXTIOI_COREISR_START) >> 2;
         /* using attrs to get current cpu index */
         cpu = attrs.requester_id;
-        old_data = s->coreisr[cpu][index];
-        s->coreisr[cpu][index] = old_data & ~val;
+        old_data = s->cpu[cpu].coreisr[index];
+        s->cpu[cpu].coreisr[index] = old_data & ~val;
         /* write 1 to clear interrupt */
         old_data &= val;
         irq = ctz32(old_data);
@@ -248,14 +249,61 @@ static const MemoryRegionOps extioi_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static const VMStateDescription vmstate_loongarch_extioi = {
-    .name = TYPE_LOONGARCH_EXTIOI,
+static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    int i, pin;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+
+    for (i = 0; i < EXTIOI_IRQS; i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
+
+    qdev_init_gpio_in(dev, extioi_setirq, EXTIOI_IRQS);
+    memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
+                          s, "extioi_system_mem", 0x900);
+    sysbus_init_mmio(sbd, &s->extioi_system_mem);
+    s->cpu = g_new0(ExtIOICore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for ExtIOICore faile");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[pin], 1);
+        }
+    }
+}
+
+static void loongarch_extioi_finalize(Object *obj)
+{
+    LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
+
+    g_free(s->cpu);
+}
+
+static const VMStateDescription vmstate_extioi_core = {
+    .name = "extioi-core",
     .version_id = 1,
     .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(coreisr, ExtIOICore, EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongarch_extioi = {
+    .name = TYPE_LOONGARCH_EXTIOI,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOI, EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_UINT32_2DARRAY(coreisr, LoongArchExtIOI, EXTIOI_CPUS,
-                               EXTIOI_IRQS_GROUP_COUNT),
         VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOI,
                              EXTIOI_IRQS_NODETYPE_COUNT / 2),
         VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOI, EXTIOI_IRQS / 32),
@@ -265,45 +313,32 @@ static const VMStateDescription vmstate_loongarch_extioi = {
         VMSTATE_UINT8_ARRAY(sw_ipmap, LoongArchExtIOI, EXTIOI_IRQS_IPMAP_SIZE),
         VMSTATE_UINT8_ARRAY(sw_coremap, LoongArchExtIOI, EXTIOI_IRQS),
 
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOI, num_cpu,
+                         vmstate_extioi_core, ExtIOICore),
         VMSTATE_END_OF_LIST()
     }
 };
 
-static void loongarch_extioi_instance_init(Object *obj)
-{
-    SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
-    int i, cpu, pin;
-
-    for (i = 0; i < EXTIOI_IRQS; i++) {
-        sysbus_init_irq(dev, &s->irq[i]);
-    }
-
-    qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);
-
-    for (cpu = 0; cpu < EXTIOI_CPUS; cpu++) {
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_init_gpio_out(DEVICE(obj), &s->parent_irq[cpu][pin], 1);
-        }
-    }
-    memory_region_init_io(&s->extioi_system_mem, OBJECT(s), &extioi_ops,
-                          s, "extioi_system_mem", 0x900);
-    sysbus_init_mmio(dev, &s->extioi_system_mem);
-}
+static Property extioi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOI, num_cpu, 1),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->realize = loongarch_extioi_realize;
+    device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
 }
 
 static const TypeInfo loongarch_extioi_info = {
     .name          = TYPE_LOONGARCH_EXTIOI,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_init = loongarch_extioi_instance_init,
     .instance_size = sizeof(struct LoongArchExtIOI),
     .class_init    = loongarch_extioi_class_init,
+    .instance_finalize = loongarch_extioi_finalize,
 };
 
 static void loongarch_extioi_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 13d19b6da3..c9a680e61a 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -582,6 +582,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
 
     /* Create EXTIOI device */
     extioi = qdev_new(TYPE_LOONGARCH_EXTIOI);
+    qdev_prop_set_uint32(extioi, "num-cpu", ms->smp.cpus);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(extioi), &error_fatal);
     memory_region_add_subregion(&lams->system_iocsr, APIC_BASE,
                    sysbus_mmio_get_region(SYS_BUS_DEVICE(extioi), 0));
@@ -590,7 +591,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
      * connect ext irq to the cpu irq
      * cpu_pin[9:2] <= intc_pin[7:0]
      */
-    for (cpu = 0; cpu < MIN(ms->smp.cpus, EXTIOI_CPUS); cpu++) {
+    for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
         cpudev = DEVICE(qemu_get_cpu(cpu));
         for (pin = 0; pin < LS3A_INTC_IP; pin++) {
             qdev_connect_gpio_out(extioi, (cpu * 8 + pin),
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 110e5e8873..a0a46b888c 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -40,24 +40,29 @@
 #define EXTIOI_COREMAP_START         (0xC00 - APIC_OFFSET)
 #define EXTIOI_COREMAP_END           (0xD00 - APIC_OFFSET)
 
+typedef struct ExtIOICore {
+    uint32_t coreisr[EXTIOI_IRQS_GROUP_COUNT];
+    DECLARE_BITMAP(sw_isr[LS3A_INTC_IP], EXTIOI_IRQS);
+    qemu_irq parent_irq[LS3A_INTC_IP];
+} ExtIOICore;
+
 #define TYPE_LOONGARCH_EXTIOI "loongarch.extioi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchExtIOI, LOONGARCH_EXTIOI)
 struct LoongArchExtIOI {
     SysBusDevice parent_obj;
+    uint32_t num_cpu;
     /* hardware state */
     uint32_t nodetype[EXTIOI_IRQS_NODETYPE_COUNT / 2];
     uint32_t bounce[EXTIOI_IRQS_GROUP_COUNT];
     uint32_t isr[EXTIOI_IRQS / 32];
-    uint32_t coreisr[EXTIOI_CPUS][EXTIOI_IRQS_GROUP_COUNT];
     uint32_t enable[EXTIOI_IRQS / 32];
     uint32_t ipmap[EXTIOI_IRQS_IPMAP_SIZE / 4];
     uint32_t coremap[EXTIOI_IRQS / 4];
     uint32_t sw_pending[EXTIOI_IRQS / 32];
-    DECLARE_BITMAP(sw_isr[EXTIOI_CPUS][LS3A_INTC_IP], EXTIOI_IRQS);
     uint8_t  sw_ipmap[EXTIOI_IRQS_IPMAP_SIZE];
     uint8_t  sw_coremap[EXTIOI_IRQS];
-    qemu_irq parent_irq[EXTIOI_CPUS][LS3A_INTC_IP];
     qemu_irq irq[EXTIOI_IRQS];
+    ExtIOICore *cpu;
     MemoryRegion extioi_system_mem;
 };
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.39.3


