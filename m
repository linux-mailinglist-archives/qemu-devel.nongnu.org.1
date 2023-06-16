Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBB573332F
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:09:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAA8Z-00030D-B8; Fri, 16 Jun 2023 10:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qAA8W-0002zs-8p
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:09:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1qAA8Q-00070g-B6
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686924528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=nkC2klUiTyCXj1g0t7Vh9l5CQHkQb9WWiyJpHGXoZdk=;
 b=ZYW69Hcm62WtBgRtBjns8yJmCJ30S8LaWAMLFZ3vQuP+aKE0r5hJYcii5QT61ZqA3o4IF2
 O1ADRHiAv6FhrTZbH7MmDT5w8EOGR0Kf9362aZtumK9P5WL1JfFbeY3bDUOujD28oKxinP
 CYEfZGrUOYEKcThP/oYQMI7V4357lq4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-0f6vOSwrNkqV7LXmZ37OTw-1; Fri, 16 Jun 2023 10:08:46 -0400
X-MC-Unique: 0f6vOSwrNkqV7LXmZ37OTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3A341C0434E
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 14:08:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.208.3])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D93E71121315;
 Fri, 16 Jun 2023 14:08:44 +0000 (UTC)
From: Anthony Harivel <aharivel@redhat.com>
To: pbonzini@redhat.com,
	mtosatti@redhat.com
Cc: qemu-devel@nongnu.org
Subject: [PATCH] Add support for RAPL MSRs in KVM/Qemu
Date: Fri, 16 Jun 2023 16:08:30 +0200
Message-Id: <20230616140830.316655-1-aharivel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Starting with the "Sandy Bridge" generation, Intel CPUs provide a RAPL
interface (Running Average Power Limit) for advertising the accumulated
energy consumption of various power domains (e.g. CPU packages, DRAM,
etc.).

The consumption is reported via MSRs (model specific registers) like
MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are
64 bits registers that represent the accumulated energy consumption in
micro Joules. They are updated by microcode every ~1ms.

For now, KVM always returns 0 when the guest requests the value of
these MSRs. Use the KVM MSR filtering mechanism to allow QEMU handle
these MSRs dynamically in userspace.

To limit the amount of system calls for every MSR call, create a new
thread in QEMU that updates the "virtual" MSR values asynchronously.

Each vCPU has its own vMSR to reflect the independence of vCPUs. The
thread updates the vMSR values with the ratio of energy consumed of
the whole physical CPU package the vCPU thread runs on and the
thread's utime and stime values.

All other non-vCPU threads are also taken into account. Their energy
consumption is evenly distributed among all vCPUs threads running on
the same physical CPU package.

This feature is activated with -accel kvm,rapl=true.

Actual limitation:
- Works only on Intel host CPU because AMD CPUs are using different MSR
  adresses.

- Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at
  the moment.

- Since each vCPU has an independent vMSR value, the vCPU topology must
  be changed to match that reality. There must be a single vCPU per
  virtual socket (e.g.: -smp 4,sockets=4). Accessing pkg-0 energy will
  give vCPU 0 energy, pkg-1 will give vCPU 1 energy, etc.

Signed-off-by: Anthony Harivel <aharivel@redhat.com>
---

Notes:
    This is a follow-up of the RFC sent a month exactly ago [1].
    
    RFC -> v1
    ---------
    
    - Add vmsr_* in front of all vmsr specific function
    
    - Change malloc()/calloc()... with all glib equivalent
    
    - Pre-allocate all dynamic memories when possible
    
    - Add a Documentation of implementation, limitation and usage
    
    Regards,
    Anthony
    
    [1]: https://lore.kernel.org/qemu-devel/20230517130730.85469-1-aharivel@redhat.com/

 accel/kvm/kvm-all.c           |  13 ++
 docs/specs/index.rst          |   1 +
 docs/specs/rapl-msr.rst       | 128 +++++++++++++++
 include/sysemu/kvm_int.h      |  11 ++
 target/i386/cpu.h             |   8 +
 target/i386/kvm/kvm.c         | 301 ++++++++++++++++++++++++++++++++++
 target/i386/kvm/meson.build   |   1 +
 target/i386/kvm/vmsr_energy.c | 178 ++++++++++++++++++++
 target/i386/kvm/vmsr_energy.h |  81 +++++++++
 9 files changed, 722 insertions(+)
 create mode 100644 docs/specs/rapl-msr.rst
 create mode 100644 target/i386/kvm/vmsr_energy.c
 create mode 100644 target/i386/kvm/vmsr_energy.h

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7679f397aec0..33bbdb598533 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3746,6 +3746,12 @@ static void kvm_set_dirty_ring_size(Object *obj, Visitor *v,
     s->kvm_dirty_ring_size = value;
 }
 
+static void kvm_set_kvm_rapl(Object *obj, bool value, Error **errp)
+{
+    KVMState *s = KVM_STATE(obj);
+    s->msr_energy.enable = value;
+}
+
 static void kvm_accel_instance_init(Object *obj)
 {
     KVMState *s = KVM_STATE(obj);
@@ -3763,6 +3769,7 @@ static void kvm_accel_instance_init(Object *obj)
     s->xen_version = 0;
     s->xen_gnttab_max_frames = 64;
     s->xen_evtchn_max_pirq = 256;
+    s->msr_energy.enable = false;
 }
 
 /**
@@ -3803,6 +3810,12 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "dirty-ring-size",
         "Size of KVM dirty page ring buffer (default: 0, i.e. use bitmap)");
 
+    object_class_property_add_bool(oc, "rapl",
+                                   NULL,
+                                   kvm_set_kvm_rapl);
+    object_class_property_set_description(oc, "rapl",
+        "Allow energy related MSRs for RAPL interface in Guest");
+
     kvm_arch_accel_class_init(oc);
 }
 
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index e58be38c41c7..5c2fa3d65877 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -24,3 +24,4 @@ guest hardware that is specific to QEMU.
    acpi_erst
    sev-guest-firmware
    fw_cfg
+   rapl-msr
diff --git a/docs/specs/rapl-msr.rst b/docs/specs/rapl-msr.rst
new file mode 100644
index 000000000000..e497339aff4e
--- /dev/null
+++ b/docs/specs/rapl-msr.rst
@@ -0,0 +1,128 @@
+================
+RAPL MSR support
+================
+
+The RAPL interface (Running Average Power Limit) is advertising the accumulated
+energy consumption of various power domains (e.g. CPU packages, DRAM, etc.).
+
+The consumption is reported via MSRs (model specific registers) like
+MSR_PKG_ENERGY_STATUS for the CPU package power domain. These MSRs are 64 bits
+registers that represent the accumulated energy consumption in micro Joules.
+
+Thanks to the MSR Filtering patch [#a]_ not all MSRs are handled by KVM. Some
+of them can now be handled by the userspace (QEMU). It uses a mechanism called
+"MSR filtering" where a list of MSRs is given at init time of a VM to KVM so
+that a callback is put in place. The design of this patch uses only this
+mechanism for handling the MSRs between guest/host.
+
+At the moment the following MSRs are involved:
+
+.. code:: C
+
+    #define MSR_RAPL_POWER_UNIT             0x00000606
+    #define MSR_PKG_POWER_LIMIT             0x00000610
+    #define MSR_PKG_ENERGY_STATUS           0x00000611
+    #define MSR_PKG_POWER_INFO              0x00000614
+
+The ``*_POWER_UNIT``, ``*_POWER_LIMIT``, ``*_POWER INFO`` are part of the RAPL
+spec and specify the power limit of the package, provide range of parameter(min
+power, max power,..) and also the information of the multiplier for the energy
+counter to calculate the power. Those MSRs are populated once at the beginning
+by reading the host CPU MSRs and are given back to the guest 1:1 when
+requested.
+
+The MSR_PKG_ENERGY_STATUS is a counter; it represents the total amount of
+energy consumed since the last time the register was cleared. If you multiply
+it with the UNIT provided above you'll get the power in micro-joules. This
+counter is always increasing and it increases more or less faster depending on
+the consumption of the package. This counter is supposed to overflow at some
+point.
+
+Each core belonging to the same Package reading the MSR_PKG_ENERGY_STATUS (i.e
+"rdmsr 0x611") will retrieve the same value. The value represents the energy
+for the whole package. Whatever Core reading it will get the same value and a
+core that belongs to PKG-0 will not be able to get the value of PKG-1 and
+vice-versa.
+
+High level implementation
+-------------------------
+
+In order to update the value of the virtual MSR, a QEMU thread is created.
+The thread is basically just an infinity loop that does:
+
+1. Snapshot of the time metrics of all QEMU threads (Time spent scheduled in
+   Userspace and System)
+
+2. Snapshot of the actual MSR_PKG_ENERGY_STATUS counter of all packages where
+   the QEMU threads are running on.
+
+3. Sleep for 1 second - During this pause the vcpu and other non-vcpu threads
+   will do what they have to do and so the energy counter will increase.
+
+4. Repeat 2. and 3. and calculate the delta of every metrics representing the
+   time spent scheduled for each QEMU thread *and* the energy spent by the
+   packages during the pause.
+
+5. Filter the vcpu threads and the non-vcpu threads.
+
+6. The total energy spent by the non-vcpu threads is divided by the number
+   of vcpu threads so that each vcpu thread will get an equal part of the
+   energy spent by the QEMU workers.
+
+7. Calculate the ratio of energy spent per vcpu threads.
+
+8. The virtual MSRs are updated for each vcpu by adding for each vcpu the
+   energy spent + the quote part of the non-vcpu.
+
+9. loop back to 1.
+
+Ratio calculation
+-----------------
+
+In Linux, a process has an execution time associated with it. The scheduler is
+dividing the time in clock ticks. The number of clock ticks per second can be
+found by the sysconf system call. A typical value of clock ticks per second is
+100. So a core can run a process at the maximum of 100 ticks per second. If a
+package has 4 cores, 400 ticks maximum can be scheduled on all the cores
+of the package for a period of 1 second.
+
+The /proc/[pid]/stat [#b]_ is a sysfs file that can give the executed time of a
+process with the [pid] as the process ID. It gives the amount of ticks the
+process has been scheduled in userspace (utime) and kernel space (stime).
+
+By reading those metrics for a thread, one can calculate the ratio of time the
+package has spent executing the thread.
+
+Example:
+
+A 4 cores package can schedule a maximum of 400 ticks per second with 100 ticks
+per second per core. If a thread was scheduled for 100 ticks between a second
+on this package, that means my thread has been scheduled for 1/4 of the whole
+package. With that, the calculation of the energy spent by the thread on this
+package during this whole second is 1/4 of the total energy spent by the
+package.
+
+Usage
+-----
+
+This feature is activated with the parameter "-accel kvm,rapl=true"
+
+Current Limitations
+-------------------
+
+- Works only on Intel host CPUs because AMD CPUs are using different MSR
+  addresses.
+
+- Only the Package Power-Plane (MSR_PKG_ENERGY_STATUS) is reported at the
+  moment.
+
+- Since each vCPU has an independent vMSR value, the vCPU topology must be
+  changed to match that reality. There must be a single vCPU per virtual socket
+  (e.g.: -smp 4,sockets=4). Accessing pkg-0 energy will give vCPU 0 energy,
+  pkg-1 will give vCPU 1 energy, etc.
+
+References
+----------
+
+.. [#a] https://patchwork.kernel.org/project/kvm/patch/20200916202951.23760-7-graf@amazon.com/
+.. [#b] https://man7.org/linux/man-pages/man5/proc.5.html
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 511b42bde5c4..09e4d6809b05 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -47,6 +47,16 @@ typedef struct KVMMemoryListener {
 
 #define KVM_MSI_HASHTAB_SIZE    256
 
+struct KVMMsrEnergy {
+    bool enable;
+    QemuThread msr_thr;
+    int cpus;
+    uint64_t *msr_value;
+    uint64_t msr_unit;
+    uint64_t msr_limit;
+    uint64_t msr_info;
+};
+
 enum KVMDirtyRingReaperState {
     KVM_DIRTY_RING_REAPER_NONE = 0,
     /* The reaper is sleeping */
@@ -117,6 +127,7 @@ struct KVMState
     uint32_t kvm_dirty_ring_size;   /* Number of dirty GFNs per ring */
     bool kvm_dirty_ring_with_bitmap;
     struct KVMDirtyRingReaper reaper;
+    struct KVMMsrEnergy msr_energy;
     NotifyVmexitOption notify_vmexit;
     uint32_t notify_window;
     uint32_t xen_version;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cd047e04102f..506a96867b45 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -396,6 +396,10 @@ typedef enum X86Seg {
 #define MSR_IA32_TSX_CTRL		0x122
 #define MSR_IA32_TSCDEADLINE            0x6e0
 #define MSR_IA32_PKRS                   0x6e1
+#define MSR_RAPL_POWER_UNIT             0x00000606
+#define MSR_PKG_POWER_LIMIT             0x00000610
+#define MSR_PKG_ENERGY_STATUS           0x00000611
+#define MSR_PKG_POWER_INFO              0x00000614
 #define MSR_ARCH_LBR_CTL                0x000014ce
 #define MSR_ARCH_LBR_DEPTH              0x000014cf
 #define MSR_ARCH_LBR_FROM_0             0x00001500
@@ -1775,6 +1779,10 @@ typedef struct CPUArchState {
 
     uintptr_t retaddr;
 
+    /* RAPL MSR */
+    uint64_t msr_rapl_power_unit;
+    uint64_t msr_pkg_energy_status;
+
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6b1..3b41d6537ef1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -16,11 +16,16 @@
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
+#include <math.h>
+#include <stdint.h>
 #include <sys/ioctl.h>
 #include <sys/utsname.h>
 #include <sys/syscall.h>
+#include <sys/resource.h>
+#include <sys/time.h>
 
 #include <linux/kvm.h>
+#include <unistd.h>
 #include "standard-headers/asm-x86/kvm_para.h"
 #include "hw/xen/interface/arch-x86/cpuid.h"
 
@@ -35,6 +40,7 @@
 #include "xen-emu.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
+#include "vmsr_energy.h"
 
 #include "exec/gdbstub.h"
 #include "qemu/host-utils.h"
@@ -2518,6 +2524,49 @@ static bool kvm_rdmsr_core_thread_count(X86CPU *cpu, uint32_t msr,
     return true;
 }
 
+static bool kvm_rdmsr_rapl_power_unit(X86CPU *cpu, uint32_t msr,
+                                        uint64_t *val)
+{
+
+    CPUState *cs = CPU(cpu);
+
+    *val = cs->kvm_state->msr_energy.msr_unit;
+
+    return true;
+}
+
+static bool kvm_rdmsr_pkg_power_limit(X86CPU *cpu, uint32_t msr,
+                                        uint64_t *val)
+{
+
+    CPUState *cs = CPU(cpu);
+
+    *val = cs->kvm_state->msr_energy.msr_limit;
+
+    return true;
+}
+
+static bool kvm_rdmsr_pkg_power_info(X86CPU *cpu, uint32_t msr,
+                                        uint64_t *val)
+{
+
+    CPUState *cs = CPU(cpu);
+
+    *val = cs->kvm_state->msr_energy.msr_info;
+
+    return true;
+}
+
+static bool kvm_rdmsr_pkg_energy_status(X86CPU *cpu, uint32_t msr,
+    uint64_t *val)
+{
+
+    CPUState *cs = CPU(cpu);
+    *val = cs->kvm_state->msr_energy.msr_value[cs->cpu_index];
+
+    return true;
+}
+
 static Notifier smram_machine_done;
 static KVMMemoryListener smram_listener;
 static AddressSpace smram_address_space;
@@ -2552,6 +2601,218 @@ static void register_smram_listener(Notifier *n, void *unused)
                                  &smram_address_space, 1, "kvm-smram");
 }
 
+static void *kvm_msr_energy_thread(void *data)
+{
+    KVMState *s = data;
+    struct KVMMsrEnergy *vmsr = &s->msr_energy;
+    unsigned int maxpkgs, maxcpus, maxticks;
+    package_energy_stat *pkg_stat;
+    int num_threads, tmp_num_threads = 0;
+    thread_stat *thd_stat;
+    CPUState *cpu;
+    pid_t pid, *thread_ids;
+
+    rcu_register_thread();
+
+    /* Get QEMU PID*/
+    pid = getpid();
+
+    /* Assuming those values are the same accross physical system/packages */
+    /* Nb of CPUS per packages */
+    maxcpus = vmsr_get_maxcpus(0);
+    /* Nb of Physical Packages on the system */
+    maxpkgs = vmsr_get_max_physical_package(maxcpus);
+
+    if (maxpkgs == 0) {
+        return NULL;
+    }
+
+    /* Those MSR values should not change as well */
+    vmsr->msr_unit  = vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0);
+    vmsr->msr_limit = vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0);
+    vmsr->msr_info  = vmsr_read_msr(MSR_PKG_POWER_INFO, 0);
+
+    /* Allocate memory for each package energy status */
+    pkg_stat = (package_energy_stat *)
+        g_malloc0(maxpkgs * sizeof(package_energy_stat));
+
+    /* Pre-allocate memory for thread stats */
+    thd_stat = g_new0(thread_stat, 1);
+
+    /*
+     * Max numbers of ticks per package
+     * time in second * number of ticks/second * Number of cores / package
+     * ex: for 100 ticks/second/CPU, 12 CPUs per Package gives 1200 ticks max
+     */
+    maxticks = (MSR_ENERGY_THREAD_SLEEP_US / 1000000)
+                    * sysconf(_SC_CLK_TCK) * maxcpus;
+
+    while (true) {
+
+        /* Get all qemu threads id */
+        thread_ids = vmsr_get_thread_ids(pid, &num_threads);
+
+        if (thread_ids == NULL) {
+            goto clean;
+        }
+
+        if (tmp_num_threads < num_threads) {
+
+            void *tmp_ptr;
+
+            tmp_ptr = g_realloc(thd_stat, num_threads * sizeof(thread_stat));
+            thd_stat = (thread_stat *) tmp_ptr;
+        }
+
+        tmp_num_threads = num_threads;
+
+        /* Populate all the thread stats */
+        for (int i = 0; i < num_threads; i++) {
+            thd_stat[i].utime = calloc(2, sizeof(unsigned long long));
+            thd_stat[i].stime = calloc(2, sizeof(unsigned long long));
+            thd_stat[i].thread_id = thread_ids[i];
+            vmsr_read_thread_stat(&thd_stat[i], pid, 0);
+            thd_stat[i].numa_node_id = numa_node_of_cpu(thd_stat[i].cpu_id);
+        }
+
+        /* Retrieve all packages power plane energy counter */
+        for (int i = 0; i <= maxpkgs; i++) {
+            for (int j = 0; j < num_threads; j++) {
+                /*
+                 * Use the first thread we found that ran on the CPU
+                 * of the package to read the packages energy counter
+                 */
+                if (thd_stat[j].numa_node_id == i) {
+                    pkg_stat[i].e_start =
+                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS, i);
+                    break;
+                }
+            }
+        }
+
+        /* Sleep a short period while the other threads are working */
+        usleep(MSR_ENERGY_THREAD_SLEEP_US);
+
+        /*
+         * Retrieve all packages power plane energy counter
+         * Calculate the delta of all packages
+         */
+        for (int i = 0; i <= maxpkgs; i++) {
+            for (int j = 0; j < num_threads; j++) {
+                /*
+                 * Use the first thread we found that ran on the CPU
+                 * of the package to read the packages energy counter
+                 */
+                if (thd_stat[j].numa_node_id == i) {
+                    pkg_stat[i].e_end =
+                       vmsr_read_msr(MSR_PKG_ENERGY_STATUS, thd_stat[j].cpu_id);
+                    pkg_stat[i].e_delta =
+                        pkg_stat[i].e_end - pkg_stat[i].e_start;
+                    break;
+                }
+            }
+        }
+
+        /* Delta of ticks spend by each thread between the sample */
+        for (int i = 0; i < num_threads; i++) {
+            if (vmsr_read_thread_stat(&thd_stat[i], pid, 1) != 0) {
+                /*
+                 * We don't count the dead thread
+                 * i.e threads that existed before the sleep
+                 * and not anymore
+                 */
+                thd_stat[i].delta_ticks = 0;
+            } else {
+                vmsr_delta_ticks(thd_stat, i);
+            }
+        }
+
+        /*
+         * Identify the vCPU threads
+         * Calculate the Number of vCPU per package
+         */
+        CPU_FOREACH(cpu) {
+            for (int i = 0; i < num_threads; i++) {
+                if (cpu->thread_id == thd_stat[i].thread_id) {
+                    thd_stat[i].is_vcpu = true;
+                    thd_stat[i].vcpu_id = cpu->cpu_index;
+                    pkg_stat[thd_stat[i].numa_node_id].nb_vcpu++;
+                    break;
+                }
+            }
+        }
+
+        /* Calculate the total energy of all non-vCPU thread */
+        for (int i = 0; i < num_threads; i++) {
+            double temp;
+            if ((thd_stat[i].is_vcpu != true) &&
+                (thd_stat[i].delta_ticks > 0)) {
+                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
+                pkg_stat[thd_stat[i].numa_node_id].e_ratio
+                    += (uint64_t)lround(temp);
+            }
+        }
+
+        /* Calculate the ratio per non-vCPU thread of each package */
+        for (int i = 0; i <= maxpkgs; i++) {
+            if (pkg_stat[i].nb_vcpu > 0) {
+                pkg_stat[i].e_ratio = pkg_stat[i].e_ratio / pkg_stat[i].nb_vcpu;
+            }
+        }
+
+        /* Calculate the energy for each vCPU thread */
+        for (int i = 0; i < num_threads; i++) {
+            double temp;
+
+            if ((thd_stat[i].is_vcpu == true) &&
+                (thd_stat[i].delta_ticks > 0)) {
+                temp = vmsr_get_ratio(pkg_stat, thd_stat, maxticks, i);
+                vmsr->msr_value[thd_stat[i].vcpu_id] += (uint64_t)lround(temp);
+                vmsr->msr_value[thd_stat[i].vcpu_id] \
+                    += pkg_stat[thd_stat[i].numa_node_id].e_ratio;
+            }
+        }
+
+        /* free all memory */
+        for (int i = 0; i < num_threads; i++) {
+            memset(thd_stat[i].utime, 0, 2 * sizeof(unsigned long long));
+            memset(thd_stat[i].stime, 0, 2 * sizeof(unsigned long long));
+        }
+        /* Zero out the memory */
+        memset(thd_stat, 0, num_threads * sizeof(thread_stat));
+        memset(thread_ids, 0, sizeof(pid_t));
+    }
+
+clean:
+    /* free all memory */
+    for (int i = 0; i < num_threads; i++) {
+        g_free(thd_stat[i].utime);
+        g_free(thd_stat[i].stime);
+    }
+    g_free(thd_stat);
+    g_free(thread_ids);
+
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static int kvm_msr_energy_thread_init(KVMState *s, MachineState *ms)
+{
+    struct KVMMsrEnergy *r = &s->msr_energy;
+
+    /* Retrieve the number of vCPU */
+    r->cpus = ms->smp.cpus;
+
+    /* Allocate register memory (MSR_PKG_STATUS) for each vCPU */
+    r->msr_value = calloc(r->cpus, sizeof(r->msr_value));
+
+    qemu_thread_create(&r->msr_thr, "kvm-msr",
+                       kvm_msr_energy_thread,
+                       s, QEMU_THREAD_JOINABLE);
+
+    return 0;
+}
+
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     uint64_t identity_base = 0xfffbc000;
@@ -2765,6 +3026,46 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
                          strerror(-ret));
             exit(1);
         }
+
+        if (s->msr_energy.enable == true) {
+
+            r = kvm_filter_msr(s, MSR_RAPL_POWER_UNIT,
+                               kvm_rdmsr_rapl_power_unit, NULL);
+            if (!r) {
+                error_report("Could not install MSR_RAPL_POWER_UNIT \
+                                handler: %s",
+                             strerror(-ret));
+                exit(1);
+            }
+
+            r = kvm_filter_msr(s, MSR_PKG_POWER_LIMIT,
+                               kvm_rdmsr_pkg_power_limit, NULL);
+            if (!r) {
+                error_report("Could not install MSR_PKG_POWER_LIMIT \
+                                handler: %s",
+                             strerror(-ret));
+                exit(1);
+            }
+
+            r = kvm_filter_msr(s, MSR_PKG_POWER_INFO,
+                               kvm_rdmsr_pkg_power_info, NULL);
+            if (!r) {
+                error_report("Could not install MSR_PKG_POWER_INFO \
+                                handler: %s",
+                             strerror(-ret));
+                exit(1);
+            }
+            r = kvm_filter_msr(s, MSR_PKG_ENERGY_STATUS,
+                               kvm_rdmsr_pkg_energy_status, NULL);
+            if (!r) {
+                error_report("Could not install MSR_PKG_ENERGY_STATUS \
+                                handler: %s",
+                             strerror(-ret));
+                exit(1);
+            } else {
+                kvm_msr_energy_thread_init(s, ms);
+            }
+        }
     }
 
     return 0;
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 322272091bce..9cdc93c6c439 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -5,6 +5,7 @@ i386_softmmu_kvm_ss = ss.source_set()
 i386_softmmu_kvm_ss.add(files(
   'kvm.c',
   'kvm-cpu.c',
+  'vmsr_energy.c',
 ))
 
 i386_softmmu_kvm_ss.add(when: 'CONFIG_XEN_EMU', if_true: files('xen-emu.c'))
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
new file mode 100644
index 000000000000..0dac2e9c9e21
--- /dev/null
+++ b/target/i386/kvm/vmsr_energy.c
@@ -0,0 +1,178 @@
+/*
+ * QEMU KVM support -- x86 virtual energy-related MSR.
+ *
+ * Copyright 2023 Red Hat, Inc. 2023
+ *
+ *  Author:
+ *      Anthony Harivel <aharivel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "vmsr_energy.h"
+
+#define MAX_PATH_LEN 50
+#define MAX_LINE_LEN 500
+
+uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id)
+{
+    int fd;
+    uint64_t data;
+
+    char path[MAX_PATH_LEN];
+    snprintf(path, MAX_PATH_LEN, "/dev/cpu/%u/msr", cpu_id);
+
+    fd = open(path , O_RDONLY);
+    if (fd < 0) {
+        return 0;
+    }
+    if (pread(fd, &data, sizeof data, reg) != sizeof data) {
+        data = 0;
+    }
+
+    close(fd);
+    return data;
+}
+
+/* Retrieve the max number of physical CPU on the package */
+unsigned int vmsr_get_maxcpus(unsigned int package_num)
+{
+    int k, ncpus;
+    unsigned int maxcpus;
+    struct bitmask *cpus;
+
+    cpus = numa_allocate_cpumask();
+    ncpus = cpus->size;
+
+    if (numa_node_to_cpus(package_num, cpus) < 0) {
+        return 0;
+    }
+
+    maxcpus = 0;
+    for (k = 0; k < ncpus; k++) {
+        if (numa_bitmask_isbitset(cpus, k)) {
+            maxcpus++;
+        }
+    }
+
+    return maxcpus;
+}
+
+/* Retrieve the maximum number of physical package */
+unsigned int vmsr_get_max_physical_package(unsigned int max_cpus)
+{
+    unsigned int packageCount = 0;
+    int *uniquePackages;
+
+    char filePath[256];
+    FILE *file;
+
+    uniquePackages = g_malloc0(max_cpus * sizeof(int));
+
+    for (int i = 0; ; i++) {
+        snprintf(filePath, sizeof(filePath),
+            "/sys/devices/system/cpu/cpu%d/topology/physical_package_id", i);
+        file = fopen(filePath, "r");
+
+        if (file == NULL) {
+            break;
+        }
+
+        char packageId[10];
+        if (fgets(packageId, sizeof(packageId), file) == NULL) {
+            packageCount = 0;
+        }
+        fclose(file);
+
+        int currentPackageId = atoi(packageId);
+
+        bool isUnique = true;
+        for (int j = 0; j < packageCount; j++) {
+            if (uniquePackages[j] == currentPackageId) {
+                isUnique = false;
+                break;
+            }
+        }
+
+        if (isUnique) {
+            uniquePackages[packageCount] = currentPackageId;
+            packageCount++;
+        }
+    }
+
+    g_free(uniquePackages);
+    return packageCount;
+}
+
+int vmsr_read_thread_stat(struct thread_stat *thread, int pid, int index)
+{
+    char path[MAX_PATH_LEN];
+    snprintf(path, MAX_PATH_LEN, "/proc/%u/task/%d/stat", pid, \
+             thread->thread_id);
+
+    FILE *file = fopen(path, "r");
+    if (file == NULL) {
+        return -1;
+    }
+
+    if (fscanf(file, "%*d (%*[^)]) %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u"
+        " %llu %llu %*d %*d %*d %*d %*d %*d %*u %*u %*d %*u %*u"
+        " %*u %*u %*u %*u %*u %*u %*u %*u %*u %*d %*u %*u %u",
+           &thread->utime[index], &thread->stime[index], &thread->cpu_id) != 3)
+        return -1;
+
+    fclose(file);
+    return 0;
+}
+
+/* Read QEMU stat task folder to retrieve all QEMU threads ID */
+pid_t *vmsr_get_thread_ids(pid_t pid, int *num_threads)
+{
+    char path[100];
+    sprintf(path, "/proc/%d/task", pid);
+
+    DIR *dir = opendir(path);
+    if (dir == NULL) {
+        perror("opendir");
+        return NULL;
+    }
+
+    pid_t *thread_ids = NULL;
+    int thread_count = 0;
+
+    struct dirent *ent;
+    while ((ent = readdir(dir)) != NULL) {
+        if (ent->d_name[0] == '.') {
+            continue;
+        }
+        pid_t tid = atoi(ent->d_name);
+        if (pid != tid) {
+            thread_ids = g_realloc(thread_ids,
+                                 (thread_count + 1) * sizeof(pid_t));
+            thread_ids[thread_count] = tid;
+            thread_count++;
+        }
+    }
+
+    closedir(dir);
+
+    *num_threads = thread_count;
+    return thread_ids;
+}
+
+void vmsr_delta_ticks(thread_stat *thd_stat, int i)
+{
+    thd_stat[i].delta_ticks = (thd_stat[i].utime[1] + thd_stat[i].stime[1])
+                            - (thd_stat[i].utime[0] + thd_stat[i].stime[0]);
+}
+
+double vmsr_get_ratio(package_energy_stat *pkg_stat,
+                        thread_stat *thd_stat,
+                        int maxticks, int i) {
+
+    return (pkg_stat[thd_stat[i].numa_node_id].e_delta / 100.0)
+            * ((100.0 / maxticks) * thd_stat[i].delta_ticks);
+}
+
diff --git a/target/i386/kvm/vmsr_energy.h b/target/i386/kvm/vmsr_energy.h
new file mode 100644
index 000000000000..d59f2724ad76
--- /dev/null
+++ b/target/i386/kvm/vmsr_energy.h
@@ -0,0 +1,81 @@
+/*
+ * QEMU KVM support -- x86 virtual energy-related MSR.
+ *
+ * Copyright 2023 Red Hat, Inc. 2023
+ *
+ *  Author:
+ *      Anthony Harivel <aharivel@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef VMSR_ENERGY_H
+#define VMSR_ENERGY_H
+
+#include "qemu/osdep.h"
+
+#include <numa.h>
+
+/*
+ * Define the interval time in micro seconds between 2 samples of
+ * energy related MSRs
+ */
+#define MSR_ENERGY_THREAD_SLEEP_US 1000000.0
+
+/*
+ * Thread statistic
+ * @ thread_id: TID (thread ID)
+ * @ is_vcpu: true is thread is vCPU thread
+ * @ cpu_id: CPU number last executed on
+ * @ vcpu_id: vCPU ID
+ * @ numa_node_id:node number of the CPU
+ * @ utime: amount of clock ticks the thread
+ *          has been scheduled in User mode
+ * @ stime: amount of clock ticks the thread
+ *          has been scheduled in System mode
+ * @ delta_ticks: delta of utime+stime between
+ *          the two samples (before/after sleep)
+ */
+struct thread_stat {
+    unsigned int thread_id;
+    bool is_vcpu;
+    unsigned int cpu_id;
+    unsigned int vcpu_id;
+    unsigned int numa_node_id;
+    unsigned long long *utime;
+    unsigned long long *stime;
+    unsigned long long delta_ticks;
+};
+
+/*
+ * Package statistic
+ * @ e_start: package energy counter before the sleep
+ * @ e_end: package energy counter after the sleep
+ * @ e_delta: delta of package energy counter
+ * @ e_ratio: store the energy ratio of non-vCPU thread
+ * @ nb_vcpu: number of vCPU running on this package
+ */
+struct package_energy_stat {
+    uint64_t e_start;
+    uint64_t e_end;
+    uint64_t e_delta;
+    uint64_t e_ratio;
+    unsigned int nb_vcpu;
+};
+
+typedef struct thread_stat thread_stat;
+typedef struct package_energy_stat package_energy_stat;
+
+uint64_t vmsr_read_msr(uint32_t reg, unsigned int cpu_id);
+void vmsr_delta_ticks(thread_stat *thd_stat, int i);
+unsigned int vmsr_get_maxcpus(unsigned int package_num);
+unsigned int vmsr_get_max_physical_package(unsigned int max_cpus);
+int vmsr_read_thread_stat(struct thread_stat *thread, int pid, int index);
+pid_t *vmsr_get_thread_ids(pid_t pid, int *num_threads);
+double vmsr_get_ratio(package_energy_stat *pkg_stat,
+                        thread_stat *thd_stat,
+                        int maxticks, int i);
+
+#endif /* VMSR_ENERGY_H */
-- 
2.40.1


