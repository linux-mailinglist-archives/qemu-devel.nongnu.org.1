Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C599E366
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Oct 2024 12:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0eSk-0003m5-J8; Tue, 15 Oct 2024 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eSL-0003c7-S9; Tue, 15 Oct 2024 06:07:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1t0eSJ-0001nN-NY; Tue, 15 Oct 2024 06:07:09 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XSV9y30m5z6K5sy;
 Tue, 15 Oct 2024 18:06:30 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
 by mail.maildlp.com (Postfix) with ESMTPS id 8B527140451;
 Tue, 15 Oct 2024 18:07:04 +0800 (CST)
Received: from 00293818-MRGF.huawei.com (10.48.146.149) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 12:06:44 +0200
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <mst@redhat.com>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <peterx@redhat.com>, <eric.auger@redhat.com>,
 <will@kernel.org>, <ardb@kernel.org>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>, <npiggin@gmail.com>,
 <harshpb@linux.ibm.com>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <shahuang@redhat.com>, <zhao1.liu@intel.com>, <linuxarm@huawei.com>,
 <gustavo.romero@linaro.org>
Subject: [PATCH RFC V5 18/30] arm/virt: Changes to (un)wire GICC<->vCPU IRQs
 during hot-(un)plug
Date: Tue, 15 Oct 2024 11:00:00 +0100
Message-ID: <20241015100012.254223-19-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015100012.254223-1-salil.mehta@huawei.com>
References: <20241015100012.254223-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.146.149]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 frapeml500007.china.huawei.com (7.182.85.172)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Refactors the existing GIC create code to extract common code to wire the
vcpu<->gic interrupts. This function could be used with cold-plug case and also
used when vCPU is hot-plugged. It also introduces a new function to unwire the
vcpu<->gic interrupts for the vCPU hot-unplug cases.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[4/05/2024: Issue with total number of PPI available during create GIC]
Suggested-by: Miguel Luis <miguel.luis@oracle.com>
[5/05/2024: Fix the total number of PPIs available as per ARM BSA to avoid overflow]
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c          | 154 ++++++++++++++++++++++++++++-------------
 hw/core/gpio.c         |   2 +-
 include/hw/qdev-core.h |   2 +
 target/arm/cpu-qom.h   |  18 +++--
 4 files changed, 118 insertions(+), 58 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bcaedb8f..0a912919ec 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -765,6 +765,107 @@ static bool gicv3_nmi_present(VirtMachineState *vms)
            (vms->gic_version != VIRT_GIC_VERSION_2);
 }
 
+/*
+ * Mapping from the output timer irq lines from the CPU to the GIC PPI inputs
+ * we use for the virt board.
+ */
+const int timer_irq[] = {
+    [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
+    [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
+    [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
+    [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
+};
+
+static void unwire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
+{
+    MachineState *ms = MACHINE(vms);
+    unsigned int max_cpus = ms->smp.max_cpus;
+    DeviceState *cpudev = DEVICE(cs);
+    DeviceState *gicdev = vms->gic;
+    int cpu = CPU(cs)->cpu_index;
+    int type = vms->gic_version;
+    int irq, num_gpio_in;
+
+    for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
+        qdev_disconnect_gpio_out_named(cpudev, NULL, irq);
+    }
+
+    if (type != VIRT_GIC_VERSION_2) {
+        qdev_disconnect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                       0);
+    } else if (vms->virt) {
+        qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ,
+                                       cpu + 4 * max_cpus);
+    }
+
+    /*
+     * RFC: Question: This currently does not takes care of intimating the
+     * devices which might be sitting on system bus. Do we need a
+     * sysbus_disconnect_irq() which also does the job of notification beside
+     * disconnection?
+     */
+    qdev_disconnect_gpio_out_named(cpudev, "pmu-interrupt", 0);
+
+    /* Unwire GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to CPU */
+    num_gpio_in = (vms->gic_version != VIRT_GIC_VERSION_2) ?
+                                                NUM_GPIO_IN : NUM_GICV2_GPIO_IN;
+    for (irq = 0; irq < num_gpio_in; irq++) {
+        qdev_disconnect_gpio_out_named(gicdev, SYSBUS_DEVICE_GPIO_IRQ,
+                                        cpu + irq * max_cpus);
+    }
+}
+
+static void wire_gic_cpu_irqs(VirtMachineState *vms, CPUState *cs)
+{
+    MachineState *ms = MACHINE(vms);
+    unsigned int max_cpus = ms->smp.max_cpus;
+    DeviceState *cpudev = DEVICE(cs);
+    DeviceState *gicdev = vms->gic;
+    int cpu = CPU(cs)->cpu_index;
+    int type = vms->gic_version;
+    SysBusDevice *gicbusdev;
+    int intidbase;
+    int irqn;
+
+    intidbase = NUM_IRQS + cpu * GIC_INTERNAL;
+
+    for (irqn = 0; irqn < ARRAY_SIZE(timer_irq); irqn++) {
+        qdev_connect_gpio_out(cpudev, irqn,
+                              qdev_get_gpio_in(gicdev,
+                                               intidbase + timer_irq[irqn]));
+    }
+
+    gicbusdev = SYS_BUS_DEVICE(gicdev);
+    if (type != VIRT_GIC_VERSION_2) {
+        qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                        intidbase + ARCH_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                    0, irq);
+    } else if (vms->virt) {
+        qemu_irq irq = qdev_get_gpio_in(gicdev,
+                                        intidbase + ARCH_GIC_MAINT_IRQ);
+        sysbus_connect_irq(gicbusdev, cpu + 4 * max_cpus, irq);
+    }
+
+    qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
+                                qdev_get_gpio_in(gicdev,
+                                                 intidbase + VIRTUAL_PMU_IRQ));
+
+    sysbus_connect_irq(gicbusdev, cpu, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+    sysbus_connect_irq(gicbusdev, cpu + max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+    sysbus_connect_irq(gicbusdev, cpu + 2 * max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+    sysbus_connect_irq(gicbusdev, cpu + 3 * max_cpus,
+                       qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    if (vms->gic_version != VIRT_GIC_VERSION_2) {
+        sysbus_connect_irq(gicbusdev, cpu + 4 * max_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
+        sysbus_connect_irq(gicbusdev, cpu + 5 * max_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
+    }
+}
+
 static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 {
     MachineState *ms = MACHINE(vms);
@@ -868,54 +969,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
      * CPU's inputs.
      */
     for (i = 0; i < smp_cpus; i++) {
-        DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
-        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
-        /* Mapping from the output timer irq lines from the CPU to the
-         * GIC PPI inputs we use for the virt board.
-         */
-        const int timer_irq[] = {
-            [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-            [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
-            [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
-            [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
-            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
-        };
-
-        for (unsigned irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
-            qdev_connect_gpio_out(cpudev, irq,
-                                  qdev_get_gpio_in(vms->gic,
-                                                   intidbase + timer_irq[irq]));
-        }
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
-                                        0, irq);
-        } else if (vms->virt) {
-            qemu_irq irq = qdev_get_gpio_in(vms->gic,
-                                            intidbase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
-        }
-
-        qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
-                                    qdev_get_gpio_in(vms->gic, intidbase
-                                                     + VIRTUAL_PMU_IRQ));
-
-        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * max_cpus,
-                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
-
-        if (vms->gic_version != VIRT_GIC_VERSION_2) {
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
-            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
-                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
-        }
+        wire_gic_cpu_irqs(vms, qemu_get_cpu(i));
     }
 
     fdt_add_gic_node(vms);
@@ -3089,7 +3143,7 @@ static void virt_cpu_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
      */
     if (vms->acpi_dev) {
         /* TODO: update GIC about this hotplug change here */
-        /* TODO: wire the GIC<->CPU irqs */
+        wire_gic_cpu_irqs(vms, cs);
     }
 }
 
@@ -3172,7 +3226,7 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     /* TODO: update the acpi cpu hotplug state for cpu hot-unplug */
 
-    /* TODO: unwire the gic-cpu irqs here */
+    unwire_gic_cpu_irqs(vms, cs);
     /* TODO: update the GIC about this hot unplug change */
 
     /* TODO: unregister cpu for reset & update F/W info for the next boot */
diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 80d07a6ec9..abb164d5c0 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -143,7 +143,7 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n)
 
 /* disconnect a GPIO output, returning the disconnected input (if any) */
 
-static qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
+qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
                                                const char *name, int n)
 {
     char *propname = g_strdup_printf("%s[%d]",
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index aa97c34a4b..71f169718c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -739,6 +739,8 @@ qemu_irq qdev_get_gpio_out_connector(DeviceState *dev, const char *name, int n);
  */
 qemu_irq qdev_intercept_gpio_out(DeviceState *dev, qemu_irq icpt,
                                  const char *name, int n);
+qemu_irq qdev_disconnect_gpio_out_named(DeviceState *dev,
+                                               const char *name, int n);
 
 BusState *qdev_get_child_bus(DeviceState *dev, const char *name);
 
diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index b497667d61..e49fb096de 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -37,13 +37,17 @@ DECLARE_CLASS_CHECKERS(AArch64CPUClass, AARCH64_CPU,
 #define ARM_CPU_TYPE_NAME(name) (name ARM_CPU_TYPE_SUFFIX)
 
 /* Meanings of the ARMCPU object's seven inbound GPIO lines */
-#define ARM_CPU_IRQ 0
-#define ARM_CPU_FIQ 1
-#define ARM_CPU_VIRQ 2
-#define ARM_CPU_VFIQ 3
-#define ARM_CPU_NMI 4
-#define ARM_CPU_VINMI 5
-#define ARM_CPU_VFNMI 6
+enum {
+    ARM_CPU_IRQ = 0,
+    ARM_CPU_FIQ = 1,
+    ARM_CPU_VIRQ = 2,
+    ARM_CPU_VFIQ = 3,
+    NUM_GICV2_GPIO_IN = (ARM_CPU_VFIQ+1),
+    ARM_CPU_NMI = 4,
+    ARM_CPU_VINMI = 5,
+    /* ARM_CPU_VFNMI = 6, */ /* not used? */
+    NUM_GPIO_IN = (ARM_CPU_VINMI+1),
+};
 
 /* For M profile, some registers are banked secure vs non-secure;
  * these are represented as a 2-element array where the first element
-- 
2.34.1


