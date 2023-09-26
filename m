Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B267AE9F3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4yp-00078s-TP; Tue, 26 Sep 2023 06:07:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4yl-00070r-Mg; Tue, 26 Sep 2023 06:07:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4yj-00048D-Cz; Tue, 26 Sep 2023 06:07:43 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwPX4zQdz6K5xs;
 Tue, 26 Sep 2023 18:06:24 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:07:19 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 07/37] arm/virt,
 gicv3: Changes to pre-size GIC with possible vcpus @machine init
Date: Tue, 26 Sep 2023 11:04:06 +0100
Message-ID: <20230926100436.28284-8-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926100436.28284-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

GIC needs to be pre-sized with possible vcpus at the initialization time. This
is necessary because Memory regions and resources associated with GICC/GICR
etc cannot be changed (add/del/modified) after VM has inited. Also, GIC_TYPER
needs to be initialized with mp_affinity and cpu interface number association.
This cannot be changed after GIC has initialized.

Once all the cpu interfaces of the GIC has been inited it needs to be ensured
that any updates to the GICC during reset only takes place for the present
vcpus and not the disabled ones. Therefore, proper checks are required at
various places.

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
[changed the comment in arm_gicv3_icc_reset]
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c              | 15 ++++++++-------
 hw/intc/arm_gicv3_common.c |  7 +++++--
 hw/intc/arm_gicv3_cpuif.c  |  8 ++++++++
 hw/intc/arm_gicv3_kvm.c    | 34 +++++++++++++++++++++++++++++++---
 include/hw/arm/virt.h      |  2 +-
 5 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6ba131b799..a208b4e517 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -718,6 +718,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     const char *gictype;
     int i;
     unsigned int smp_cpus = ms->smp.cpus;
+    unsigned int max_cpus = ms->smp.max_cpus;
     uint32_t nb_redist_regions = 0;
     int revision;
 
@@ -742,7 +743,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     }
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
-    qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
+    qdev_prop_set_uint32(vms->gic, "num-cpu", max_cpus);
     /* Note that the num-irq property counts both internal and external
      * interrupts; there are always 32 of the former (mandated by GIC spec).
      */
@@ -753,7 +754,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     if (vms->gic_version != VIRT_GIC_VERSION_2) {
         uint32_t redist0_capacity = virt_redist_capacity(vms, VIRT_GIC_REDIST);
-        uint32_t redist0_count = MIN(smp_cpus, redist0_capacity);
+        uint32_t redist0_count = MIN(max_cpus, redist0_capacity);
 
         nb_redist_regions = virt_gicv3_redist_region_count(vms);
 
@@ -774,7 +775,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                 virt_redist_capacity(vms, VIRT_HIGH_GIC_REDIST2);
 
             qdev_prop_set_uint32(vms->gic, "redist-region-count[1]",
-                MIN(smp_cpus - redist0_count, redist1_capacity));
+                MIN(max_cpus - redist0_count, redist1_capacity));
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
@@ -831,7 +832,7 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
         } else if (vms->virt) {
             qemu_irq irq = qdev_get_gpio_in(vms->gic,
                                             ppibase + ARCH_GIC_MAINT_IRQ);
-            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus, irq);
+            sysbus_connect_irq(gicbusdev, i + 4 * max_cpus, irq);
         }
 
         qdev_connect_gpio_out_named(cpudev, "pmu-interrupt", 0,
@@ -839,11 +840,11 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                                      + VIRTUAL_PMU_IRQ));
 
         sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
-        sysbus_connect_irq(gicbusdev, i + smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
-        sysbus_connect_irq(gicbusdev, i + 2 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 2 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
-        sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
+        sysbus_connect_irq(gicbusdev, i + 3 * max_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
     }
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 2ebf880ead..ebd99af610 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -392,10 +392,13 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_possible_cpu(i);
         uint64_t cpu_affid;
 
-        s->cpu[i].cpu = cpu;
+        if (qemu_enabled_cpu(cpu)) {
+            s->cpu[i].cpu = cpu;
+        }
+
         s->cpu[i].gic = s;
         /* Store GICv3CPUState in CPUARMState gicv3state pointer */
         gicv3_set_gicv3state(cpu, &s->cpu[i]);
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index d07b13eb27..7b7a0fdb9c 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -934,6 +934,10 @@ void gicv3_cpuif_update(GICv3CPUState *cs)
     ARMCPU *cpu = ARM_CPU(cs->cpu);
     CPUARMState *env = &cpu->env;
 
+    if (!qemu_enabled_cpu(cs->cpu)) {
+        return;
+    }
+
     g_assert(qemu_mutex_iothread_locked());
 
     trace_gicv3_cpuif_update(gicv3_redist_affid(cs), cs->hppi.irq,
@@ -1826,6 +1830,10 @@ static void icc_generate_sgi(CPUARMState *env, GICv3CPUState *cs,
     for (i = 0; i < s->num_cpu; i++) {
         GICv3CPUState *ocs = &s->cpu[i];
 
+        if (!qemu_enabled_cpu(ocs->cpu)) {
+            continue;
+        }
+
         if (irm) {
             /* IRM == 1 : route to all CPUs except self */
             if (cs == ocs) {
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 72ad916d3d..b6f50caf84 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -24,6 +24,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
+#include "sysemu/cpus.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "kvm_arm.h"
@@ -458,6 +459,18 @@ static void kvm_arm_gicv3_put(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /*
+         * To support hotplug of vcpus we need to make sure all gic cpuif/GICC
+         * are initialized at machvirt init time. Once the init is done we
+         * release the ARMCPU object for disabled vcpus but this leg could hit
+         * during reset of GICC later as well i.e. after init has happened and
+         * all of the cases we want to make sure we dont acess the GICC for
+         * the disabled VCPUs.
+         */
+        if (!qemu_enabled_cpu(c->cpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, true);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], true);
@@ -616,6 +629,11 @@ static void kvm_arm_gicv3_get(GICv3State *s)
         GICv3CPUState *c = &s->cpu[ncpu];
         int num_pri_bits;
 
+        /* don't access GICC for the disabled vCPUs. */
+        if (!qemu_enabled_cpu(c->cpu)) {
+            continue;
+        }
+
         kvm_gicc_access(s, ICC_SRE_EL1, ncpu, &c->icc_sre_el1, false);
         kvm_gicc_access(s, ICC_CTLR_EL1, ncpu,
                         &c->icc_ctlr_el1[GICV3_NS], false);
@@ -695,10 +713,19 @@ static void arm_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
         return;
     }
 
+    /*
+     * This shall be called even when vcpu is being hotplugged or onlined and
+     * other vcpus might be running. Host kernel KVM code to handle device
+     * access of IOCTLs KVM_{GET|SET}_DEVICE_ATTR might fail due to inability to
+     * grab vcpu locks for all the vcpus. Hence, we need to pause all vcpus to
+     * facilitate locking within host.
+     */
+    pause_all_vcpus();
     /* Initialize to actual HW supported configuration */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS,
                       KVM_VGIC_ATTR(ICC_CTLR_EL1, c->gicr_typer),
                       &c->icc_ctlr_el1[GICV3_NS], false, &error_abort);
+    resume_all_vcpus();
 
     c->icc_ctlr_el1[GICV3_S] = c->icc_ctlr_el1[GICV3_NS];
 }
@@ -808,9 +835,10 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+        CPUState *cs = qemu_get_cpu(i);
+        if (qemu_enabled_cpu(cs)) {
+            define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+        }
     }
 
     /* Try to create the device via the device control API */
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 13163adb07..098c7917a4 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -217,7 +217,7 @@ static inline int virt_gicv3_redist_region_count(VirtMachineState *vms)
 
     assert(vms->gic_version != VIRT_GIC_VERSION_2);
 
-    return (MACHINE(vms)->smp.cpus > redist0_capacity &&
+    return (MACHINE(vms)->smp.max_cpus > redist0_capacity &&
             vms->highmem_redists) ? 2 : 1;
 }
 
-- 
2.34.1


