Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5A7AE9F2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql4ym-0006y0-5O; Tue, 26 Sep 2023 06:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4ya-0006RI-9z; Tue, 26 Sep 2023 06:07:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql4yX-00047I-VN; Tue, 26 Sep 2023 06:07:31 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvwMt5x6Rz6D9DZ;
 Tue, 26 Sep 2023 18:04:58 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:07:00 +0100
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
Subject: [PATCH RFC V2 06/37] arm/virt,
 kvm: Pre-create disabled possible vCPUs @machine init
Date: Tue, 26 Sep 2023 11:04:05 +0100
Message-ID: <20230926100436.28284-7-salil.mehta@huawei.com>
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

In ARMv8 architecture, GIC needs all the vCPUs to be created and present when
it is initialized. This is because:
1. GICC and MPIDR association must be fixed at the VM initialization time.
   This is represented by register GIC_TYPER(mp_afffinity, proc_num)
2. GICC(cpu interfaces), GICR(redistributors) etc all must be initialized
   at the boot time as well.
3. Memory regions associated with GICR etc. cannot be changed(add/del/mod)
   after VM has inited.

This patch adds the support to pre-create all such possible vCPUs within the
host using the KVM interface as part of the virt machine initialization. These
vCPUs could later be attached to QOM/ACPI while they are actually hot plugged
and made present.

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[VP: Identified CPU stall issue & suggested probable fix]
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt.c         | 53 +++++++++++++++++++++++++++++++++++++++++--
 include/hw/core/cpu.h |  1 +
 target/arm/cpu64.c    |  1 +
 target/arm/kvm.c      | 32 ++++++++++++++++++++++++++
 target/arm/kvm64.c    |  9 +++++++-
 target/arm/kvm_arm.h  | 11 +++++++++
 6 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3668ad27ec..6ba131b799 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2293,8 +2293,10 @@ static void machvirt_init(MachineState *machine)
     assert(possible_cpus->len == max_cpus);
     for (n = 0; n < possible_cpus->len; n++) {
         Object *cpuobj;
+        CPUState *cs;
 
         cpuobj = object_new(possible_cpus->cpus[n].type);
+        cs = CPU(cpuobj);
 
         aarch64 &= object_property_get_bool(cpuobj, "aarch64", NULL);
         object_property_set_int(cpuobj, "socket-id",
@@ -2306,8 +2308,55 @@ static void machvirt_init(MachineState *machine)
         object_property_set_int(cpuobj, "thread-id",
                                 virt_get_thread_id(machine, n), NULL);
 
-        qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
-        object_unref(cpuobj);
+        if (n < smp_cpus) {
+            qdev_realize(DEVICE(cpuobj), NULL, &error_fatal);
+            object_unref(cpuobj);
+        } else {
+            CPUArchId *cpu_slot;
+
+            /* handling for vcpus which are yet to be hot-plugged */
+            cs->cpu_index = n;
+            cpu_slot = virt_find_cpu_slot(machine, cs->cpu_index);
+
+            /*
+             * ARM host vCPU features need to be fixed at the boot time. But as
+             * per current approach this CPU object will be destroyed during
+             * cpu_post_init(). During hotplug of vCPUs these properties are
+             * initialized again.
+             */
+            virt_cpu_set_properties(cpuobj, cpu_slot, &error_fatal);
+
+            /*
+             * For KVM, we shall be pre-creating the now disabled/un-plugged
+             * possbile host vcpus and park them till the time they are
+             * actually hot plugged. This is required to pre-size the host
+             * GICC and GICR with the all possible vcpus for this VM.
+             */
+            if (kvm_enabled()) {
+                kvm_arm_create_host_vcpu(ARM_CPU(cs));
+            }
+            /*
+             * Add disabled vCPU to CPU slot during the init phase of the virt
+             * machine
+             * 1. We need this ARMCPU object during the GIC init. This object
+             *    will facilitate in pre-realizing the GIC. Any info like
+             *    mp-affinity(required to derive gicr_type) etc. could still be
+             *    fetched while preserving QOM abstraction akin to realized
+             *    vCPUs.
+             * 2. Now, after initialization of the virt machine is complete we
+             *    could use two approaches to deal with this ARMCPU object:
+             *    (i) re-use this ARMCPU object during hotplug of this vCPU.
+             *                             OR
+             *    (ii) defer release this ARMCPU object after gic has been
+             *         initialized or during pre-plug phase when a vCPU is
+             *         hotplugged.
+             *
+             *    We will use the (ii) approach and release the ARMCPU objects
+             *    after GIC and machine has been fully initialized during
+             *    machine_init_done() phase.
+             */
+             cpu_slot->cpu = OBJECT(cs);
+        }
     }
     fdt_add_timer_nodes(vms);
     fdt_add_cpu_nodes(vms);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e5af79950c..b2201a98ee 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -401,6 +401,7 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
+    VMChangeStateEntry *vmcse;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index a660e3f483..3a38e7ccaf 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -748,6 +748,7 @@ static void aarch64_cpu_initfn(Object *obj)
      * enabled explicitly
      */
     cs->disabled = true;
+    cs->thread_id = 0;
 }
 
 static void aarch64_cpu_finalizefn(Object *obj)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index b4c7654f49..0e1d0692b1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -637,6 +637,38 @@ void kvm_arm_reset_vcpu(ARMCPU *cpu)
     write_list_to_cpustate(cpu);
 }
 
+void kvm_arm_create_host_vcpu(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    unsigned long vcpu_id = cs->cpu_index;
+    int ret;
+
+    ret = kvm_create_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to create host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * Initialize the vCPU in the host. This will reset the sys regs
+     * for this vCPU and related registers like MPIDR_EL1 etc. also
+     * gets programmed during this call to host. These are referred
+     * later while setting device attributes of the GICR during GICv3
+     * reset
+     */
+    ret = kvm_arch_init_vcpu(cs);
+    if (ret < 0) {
+        error_report("Failed to initialize host vcpu %ld", vcpu_id);
+        abort();
+    }
+
+    /*
+     * park the created vCPU. shall be used during kvm_get_vcpu() when
+     * threads are created during realization of ARM vCPUs.
+     */
+    kvm_park_vcpu(cs);
+}
+
 /*
  * Update KVM's MP_STATE based on what QEMU thinks it is
  */
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 94bbd9661f..364cc21f81 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -566,7 +566,14 @@ int kvm_arch_init_vcpu(CPUState *cs)
         return -EINVAL;
     }
 
-    qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
+    /*
+     * Install VM change handler only when vCPU thread has been spawned
+     * i.e. vCPU is being realized
+     */
+    if (cs->thread_id) {
+        cs->vmcse = qemu_add_vm_change_state_handler(kvm_arm_vm_state_change,
+                                                     cs);
+    }
 
     /* Determine init features for this CPU */
     memset(cpu->kvm_init_features, 0, sizeof(cpu->kvm_init_features));
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 051a0da41c..31408499b3 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -163,6 +163,17 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
+/**
+ * kvm_arm_create_host_vcpu:
+ * @cpu: ARMCPU
+ *
+ * Called at to pre create all possible kvm vCPUs within the the host at the
+ * virt machine init time. This will also init this pre-created vCPU and
+ * hence result in vCPU reset at host. These pre created and inited vCPUs
+ * shall be parked for use when ARM vCPUs are actually realized.
+ */
+void kvm_arm_create_host_vcpu(ARMCPU *cpu);
+
 /**
  * kvm_arm_init_serror_injection:
  * @cs: CPUState
-- 
2.34.1


