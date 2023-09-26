Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D97AEA90
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:39:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Sf-0005Or-4v; Tue, 26 Sep 2023 06:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5SO-00059d-Lj; Tue, 26 Sep 2023 06:38:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5SI-0001rJ-LS; Tue, 26 Sep 2023 06:38:20 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvx3X2FTkz6D9Fk;
 Tue, 26 Sep 2023 18:35:52 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:37:54 +0100
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
Subject: [PATCH RFC V2 34/37] target/arm/kvm,
 tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu
Date: Tue, 26 Sep 2023 11:36:51 +0100
Message-ID: <20230926103654.34424-3-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926103654.34424-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

From: Author Salil Mehta <salil.mehta@huawei.com>

Add registration and Handling of HVC/SMC hypercall exits to VMM

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/arm-powerctl.c   | 51 +++++++++++++++++++++++++++++-------
 target/arm/helper.c         |  2 +-
 target/arm/internals.h      | 11 --------
 target/arm/kvm.c            | 52 +++++++++++++++++++++++++++++++++++++
 target/arm/kvm64.c          | 46 +++++++++++++++++++++++++++++---
 target/arm/kvm_arm.h        | 13 ++++++++++
 target/arm/meson.build      |  1 +
 target/arm/{tcg => }/psci.c |  8 ++++++
 target/arm/tcg/meson.build  |  4 ---
 9 files changed, 160 insertions(+), 28 deletions(-)
 rename target/arm/{tcg => }/psci.c (97%)

diff --git a/target/arm/arm-powerctl.c b/target/arm/arm-powerctl.c
index 326a03153d..0184c7fb09 100644
--- a/target/arm/arm-powerctl.c
+++ b/target/arm/arm-powerctl.c
@@ -16,6 +16,7 @@
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "sysemu/tcg.h"
+#include "hw/boards.h"
 
 #ifndef DEBUG_ARM_POWERCTL
 #define DEBUG_ARM_POWERCTL 0
@@ -28,18 +29,37 @@
         } \
     } while (0)
 
+static CPUArchId *arm_get_archid_by_id(uint64_t id)
+{
+    int n;
+    CPUArchId *arch_id;
+    MachineState *ms = MACHINE(qdev_get_machine());
+
+    /*
+     * At this point disabled CPUs don't have a CPUState, but their CPUArchId
+     * exists.
+     *
+     * TODO: Is arch_id == mp_affinity? This needs work.
+     */
+    for (n = 0; n < ms->possible_cpus->len; n++) {
+        arch_id = &ms->possible_cpus->cpus[n];
+
+        if (arch_id->arch_id == id) {
+            return arch_id;
+        }
+    }
+    return NULL;
+}
+
 CPUState *arm_get_cpu_by_id(uint64_t id)
 {
-    CPUState *cpu;
+    CPUArchId *arch_id;
 
     DPRINTF("cpu %" PRId64 "\n", id);
 
-    CPU_FOREACH(cpu) {
-        ARMCPU *armcpu = ARM_CPU(cpu);
-
-        if (armcpu->mp_affinity == id) {
-            return cpu;
-        }
+    arch_id = arm_get_archid_by_id(id);
+    if (arch_id && arch_id->cpu) {
+        return CPU(arch_id->cpu);
     }
 
     qemu_log_mask(LOG_GUEST_ERROR,
@@ -148,6 +168,7 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
 {
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
+    CPUArchId *arch_id;
     struct CpuOnInfo *info;
 
     assert(qemu_mutex_iothread_locked());
@@ -168,12 +189,24 @@ int arm_set_cpu_on(uint64_t cpuid, uint64_t entry, uint64_t context_id,
     }
 
     /* Retrieve the cpu we are powering up */
-    target_cpu_state = arm_get_cpu_by_id(cpuid);
-    if (!target_cpu_state) {
+    arch_id = arm_get_archid_by_id(cpuid);
+    if (!arch_id) {
         /* The cpu was not found */
         return QEMU_ARM_POWERCTL_INVALID_PARAM;
     }
 
+    target_cpu_state = CPU(arch_id->cpu);
+    if (!qemu_enabled_cpu(target_cpu_state)) {
+        /*
+         * The cpu is not plugged in or disabled. We should return appropriate
+         * value as introduced in DEN0022E PSCI 1.2 issue E
+         */
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "[ARM]%s: Denying attempt to online removed/disabled "
+                      "CPU%" PRId64"\n", __func__, cpuid);
+        return QEMU_ARM_POWERCTL_IS_OFF;
+    }
+
     target_cpu = ARM_CPU(target_cpu_state);
     if (target_cpu->power_state == PSCI_ON) {
         qemu_log_mask(LOG_GUEST_ERROR,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 272d6ba139..4d396426f2 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11187,7 +11187,7 @@ void arm_cpu_do_interrupt(CPUState *cs)
                       env->exception.syndrome);
     }
 
-    if (tcg_enabled() && arm_is_psci_call(cpu, cs->exception_index)) {
+    if (arm_is_psci_call(cpu, cs->exception_index)) {
         arm_handle_psci_call(cpu);
         qemu_log_mask(CPU_LOG_INT, "...handled as PSCI call\n");
         return;
diff --git a/target/arm/internals.h b/target/arm/internals.h
index fe330e89e7..7ffefc2d58 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -305,21 +305,10 @@ vaddr arm_adjust_watchpoint_address(CPUState *cs, vaddr addr, int len);
 /* Callback function for when a watchpoint or breakpoint triggers. */
 void arm_debug_excp_handler(CPUState *cs);
 
-#if defined(CONFIG_USER_ONLY) || !defined(CONFIG_TCG)
-static inline bool arm_is_psci_call(ARMCPU *cpu, int excp_type)
-{
-    return false;
-}
-static inline void arm_handle_psci_call(ARMCPU *cpu)
-{
-    g_assert_not_reached();
-}
-#else
 /* Return true if the r0/x0 value indicates that this SMC/HVC is a PSCI call. */
 bool arm_is_psci_call(ARMCPU *cpu, int excp_type);
 /* Actually handle a PSCI call */
 void arm_handle_psci_call(ARMCPU *cpu);
-#endif
 
 /**
  * arm_clear_exclusive: clear the exclusive monitor
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 8e7c68af6a..6f3fd5aecd 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -250,6 +250,7 @@ int kvm_arm_get_max_vm_ipa_size(MachineState *ms, bool *fixed_ipa)
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
     int ret = 0;
+
     /* For ARM interrupt delivery is always asynchronous,
      * whether we are using an in-kernel VGIC or not.
      */
@@ -280,6 +281,22 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    /*
+     * To be able to handle PSCI CPU ON calls in QEMU, we need to install SMCCC
+     * filter in the Host KVM. This is required to support features like
+     * virtual CPU Hotplug on ARM platforms.
+     */
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN64_CPU_ON,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU On PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+    if (kvm_arm_set_smccc_filter(PSCI_0_2_FN_CPU_OFF,
+                                 KVM_SMCCC_FILTER_FWD_TO_USER)) {
+        error_report("CPU Off PSCI-to-user-space fwd filter install failed");
+        abort();
+    }
+
     kvm_arm_init_debug(s);
 
     return ret;
@@ -952,6 +969,38 @@ static int kvm_arm_handle_dabt_nisv(CPUState *cs, uint64_t esr_iss,
     return -1;
 }
 
+static int kvm_arm_handle_hypercall(CPUState *cs, struct kvm_run *run)
+{
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
+    kvm_cpu_synchronize_state(cs);
+
+    /*
+     * hard coding immediate to 0 as we dont expect non-zero value as of now
+     * This might change in future versions. Hence, KVM_GET_ONE_REG  could be
+     * used in such cases but it must be enhanced then only synchronize will
+     * also fetch ESR_EL2 value.
+     */
+    if (run->hypercall.flags == KVM_HYPERCALL_EXIT_SMC) {
+        cs->exception_index = EXCP_SMC;
+        env->exception.syndrome = syn_aa64_smc(0);
+    } else {
+        cs->exception_index = EXCP_HVC;
+        env->exception.syndrome = syn_aa64_hvc(0);
+    }
+    env->exception.target_el = 1;
+    qemu_mutex_lock_iothread();
+    arm_cpu_do_interrupt(cs);
+    qemu_mutex_unlock_iothread();
+
+    /*
+     * For PSCI, exit the kvm_run loop and process the work. Especially
+     * important if this was a CPU_OFF command and we can't return to the guest.
+     */
+    return EXCP_INTERRUPT;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     int ret = 0;
@@ -967,6 +1016,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_arm_handle_dabt_nisv(cs, run->arm_nisv.esr_iss,
                                        run->arm_nisv.fault_ipa);
         break;
+    case KVM_EXIT_HYPERCALL:
+          ret = kvm_arm_handle_hypercall(cs, run);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
                       __func__, run->exit_reason);
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 38de0b4148..efe24e3f90 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -113,6 +113,25 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
     return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
 }
 
+static bool kvm_arm_set_vm_attr(struct kvm_device_attr *attr, const char *name)
+{
+    int err;
+
+    err = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_HAS_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    err = kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, attr);
+    if (err != 0) {
+        error_report("%s: KVM_SET_DEVICE_ATTR: %s", name, strerror(-err));
+        return false;
+    }
+
+    return true;
+}
+
 static bool kvm_arm_set_device_attr(CPUState *cs, struct kvm_device_attr *attr,
                                     const char *name)
 {
@@ -183,6 +202,28 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa)
     }
 }
 
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    struct kvm_smccc_filter filter = {
+        .base = func,
+        .nr_functions = 1,
+        .action = faction,
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_ARM_VM_SMCCC_CTRL,
+        .attr = KVM_ARM_VM_SMCCC_FILTER,
+        .flags = 0,
+        .addr = (uintptr_t)&filter,
+    };
+
+    if (!kvm_arm_set_vm_attr(&attr, "SMCCC Filter")) {
+        error_report("failed to set SMCCC filter in KVM Host");
+        return -1;
+    }
+
+    return 0;
+}
+
 static int read_sys_reg32(int fd, uint32_t *pret, uint64_t id)
 {
     uint64_t ret;
@@ -633,9 +674,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     }
 
     /*
-     * When KVM is in use, PSCI is emulated in-kernel and not by qemu.
-     * Currently KVM has its own idea about MPIDR assignment, so we
-     * override our defaults with what we get from KVM.
+     * KVM may emulate PSCI in-kernel. Currently KVM has its own idea about
+     * MPIDR assignment, so we override our defaults with what we get from KVM.
      */
     ret = kvm_get_one_reg(cs, ARM64_SYS_REG(ARM_CPU_ID_MPIDR), &mpidr);
     if (ret) {
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 31408499b3..bf4df54c96 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -388,6 +388,15 @@ void kvm_arm_pvtime_init(CPUState *cs, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+/**
+ * kvm_arm_set_smccc_filter
+ * @func: funcion
+ * @faction: SMCCC filter action(handle, deny, fwd-to-user) to be deployed
+ *
+ * Sets the ARMs SMC-CC filter in KVM Host for selective hypercall exits
+ */
+int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction);
+
 #else
 
 /*
@@ -462,6 +471,10 @@ static inline uint32_t kvm_arm_sve_get_vls(CPUState *cs)
     g_assert_not_reached();
 }
 
+static inline int kvm_arm_set_smccc_filter(uint64_t func, uint8_t faction)
+{
+    g_assert_not_reached();
+}
 #endif
 
 /**
diff --git a/target/arm/meson.build b/target/arm/meson.build
index e645e456da..fdfc8b958f 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -23,6 +23,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
+  'psci.c',
   'ptw.c',
 ))
 
diff --git a/target/arm/tcg/psci.c b/target/arm/psci.c
similarity index 97%
rename from target/arm/tcg/psci.c
rename to target/arm/psci.c
index 6c1239bb96..a8690a16af 100644
--- a/target/arm/tcg/psci.c
+++ b/target/arm/psci.c
@@ -21,7 +21,9 @@
 #include "exec/helper-proto.h"
 #include "kvm-consts.h"
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "sysemu/runstate.h"
+#include "sysemu/tcg.h"
 #include "internals.h"
 #include "arm-powerctl.h"
 
@@ -157,6 +159,11 @@ void arm_handle_psci_call(ARMCPU *cpu)
     case QEMU_PSCI_0_1_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN_CPU_SUSPEND:
     case QEMU_PSCI_0_2_FN64_CPU_SUSPEND:
+       if (!tcg_enabled()) {
+            warn_report("CPU suspend not supported in non-tcg mode");
+            break;
+       }
+#ifdef CONFIG_TCG
         /* Affinity levels are not supported in QEMU */
         if (param[1] & 0xfffe0000) {
             ret = QEMU_PSCI_RET_INVALID_PARAMS;
@@ -169,6 +176,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
             env->regs[0] = 0;
         }
         helper_wfi(env, 4);
+#endif
         break;
     case QEMU_PSCI_1_0_FN_PSCI_FEATURES:
         switch (param[1]) {
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 6fca38f2cc..ad3cfcb3bd 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -51,7 +51,3 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'sme_helper.c',
   'sve_helper.c',
 ))
-
-arm_system_ss.add(files(
-  'psci.c',
-))
-- 
2.34.1


