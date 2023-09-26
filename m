Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 801227AEA85
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Rt-0003kc-Fq; Tue, 26 Sep 2023 06:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Rm-00034l-Pg; Tue, 26 Sep 2023 06:37:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Rj-0001hh-NO; Tue, 26 Sep 2023 06:37:42 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvwzn104Qz6J7yr;
 Tue, 26 Sep 2023 18:32:37 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:37:17 +0100
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
Subject: [PATCH RFC V2 32/37] target/arm: Add support of *unrealize* ARMCPU
 during vCPU Hot-unplug
Date: Tue, 26 Sep 2023 11:36:49 +0100
Message-ID: <20230926103654.34424-1-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926100436.28284-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
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

vCPU Hot-unplug will result in QOM CPU object unrealization which will do away
with all the vCPU thread creations, allocations, registrations that happened
as part of the realization process. This change introduces the ARM CPU unrealize
function taking care of exactly that.

Note, initialized KVM vCPUs are not destroyed in host KVM but their Qemu context
is parked at the QEMU KVM layer.

Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Reported-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
[VP: Identified CPU stall issue & suggested probable fix]
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 target/arm/cpu-qom.h   |   3 ++
 target/arm/cpu.c       | 101 +++++++++++++++++++++++++++++++++++++++++
 target/arm/cpu.h       |  13 ++++++
 target/arm/gdbstub.c   |   6 +++
 target/arm/helper.c    |  25 ++++++++++
 target/arm/internals.h |   1 +
 target/arm/kvm64.c     |   4 ++
 7 files changed, 153 insertions(+)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index 514c22ced9..2503493710 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -54,6 +54,7 @@ struct ARMCPUClass {
 
     const ARMCPUInfo *info;
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
@@ -70,7 +71,9 @@ struct AArch64CPUClass {
 };
 
 void register_cp_regs_for_features(ARMCPU *cpu);
+void unregister_cp_regs_for_features(ARMCPU *cpu);
 void init_cpreg_list(ARMCPU *cpu);
+void destroy_cpreg_list(ARMCPU *cpu);
 
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 3a2e7e64ee..93b00835bf 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -141,6 +141,16 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->pre_el_change_hooks, entry, node);
 }
 
+void arm_unregister_pre_el_change_hooks(ARMCPU *cpu)
+{
+    ARMELChangeHook *entry, *next;
+
+    QLIST_FOREACH_SAFE(entry, &cpu->pre_el_change_hooks, node, next) {
+        QLIST_REMOVE(entry, node);
+        g_free(entry);
+    }
+}
+
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque)
 {
@@ -152,6 +162,16 @@ void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
     QLIST_INSERT_HEAD(&cpu->el_change_hooks, entry, node);
 }
 
+void arm_unregister_el_change_hooks(ARMCPU *cpu)
+{
+    ARMELChangeHook *entry, *next;
+
+    QLIST_FOREACH_SAFE(entry, &cpu->el_change_hooks, node, next) {
+        QLIST_REMOVE(entry, node);
+        g_free(entry);
+    }
+}
+
 static void cp_reg_reset(gpointer key, gpointer value, gpointer opaque)
 {
     /* Reset a single ARMCPRegInfo register */
@@ -2244,6 +2264,85 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     acc->parent_realize(dev, errp);
 }
 
+static void arm_cpu_unrealizefn(DeviceState *dev)
+{
+    ARMCPUClass *acc = ARM_CPU_GET_CLASS(dev);
+    ARMCPU *cpu = ARM_CPU(dev);
+    CPUARMState *env = &cpu->env;
+    CPUState *cs = CPU(dev);
+    bool has_secure;
+
+    has_secure = cpu->has_el3 || arm_feature(env, ARM_FEATURE_M_SECURITY);
+
+    /* rock 'n' un-roll, whatever happened in the arm_cpu_realizefn cleanly */
+    cpu_address_space_destroy(cs, ARMASIdx_NS);
+
+    if (cpu->tag_memory != NULL) {
+        cpu_address_space_destroy(cs, ARMASIdx_TagNS);
+        if (has_secure) {
+            cpu_address_space_destroy(cs, ARMASIdx_TagS);
+        }
+    }
+
+    if (has_secure) {
+        cpu_address_space_destroy(cs, ARMASIdx_S);
+    }
+
+    destroy_cpreg_list(cpu);
+    arm_cpu_unregister_gdb_regs(cpu);
+    unregister_cp_regs_for_features(cpu);
+
+    if (cpu->sau_sregion && arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+        g_free(env->sau.rbar);
+        g_free(env->sau.rlar);
+    }
+
+    if (arm_feature(env, ARM_FEATURE_PMSA) &&
+        arm_feature(env, ARM_FEATURE_V7) &&
+        cpu->pmsav7_dregion) {
+        if (arm_feature(env, ARM_FEATURE_V8)) {
+            g_free(env->pmsav8.rbar[M_REG_NS]);
+            g_free(env->pmsav8.rlar[M_REG_NS]);
+            if (arm_feature(env, ARM_FEATURE_M_SECURITY)) {
+                g_free(env->pmsav8.rbar[M_REG_S]);
+                g_free(env->pmsav8.rlar[M_REG_S]);
+            }
+        } else {
+            g_free(env->pmsav7.drbar);
+            g_free(env->pmsav7.drsr);
+            g_free(env->pmsav7.dracr);
+        }
+        if (cpu->pmsav8r_hdregion) {
+            g_free(env->pmsav8.hprbar);
+            g_free(env->pmsav8.hprlar);
+        }
+    }
+
+    if (arm_feature(env, ARM_FEATURE_PMU)) {
+        if (!kvm_enabled()) {
+            arm_unregister_pre_el_change_hooks(cpu);
+            arm_unregister_el_change_hooks(cpu);
+        }
+
+#ifndef CONFIG_USER_ONLY
+        if (cpu->pmu_timer) {
+            timer_del(cpu->pmu_timer);
+        }
+#endif
+    }
+
+    cpu_remove_sync(CPU(dev));
+    acc->parent_unrealize(dev);
+
+#ifndef CONFIG_USER_ONLY
+    timer_del(cpu->gt_timer[GTIMER_PHYS]);
+    timer_del(cpu->gt_timer[GTIMER_VIRT]);
+    timer_del(cpu->gt_timer[GTIMER_HYP]);
+    timer_del(cpu->gt_timer[GTIMER_SEC]);
+    timer_del(cpu->gt_timer[GTIMER_HYPVIRT]);
+#endif
+}
+
 static ObjectClass *arm_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -2347,6 +2446,8 @@ static void arm_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, arm_cpu_realizefn,
                                     &acc->parent_realize);
+    device_class_set_parent_unrealize(dc, arm_cpu_unrealizefn,
+                                      &acc->parent_unrealize);
 
     device_class_set_props(dc, arm_cpu_properties);
 
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d51d39f621..9fe89cf10a 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3264,6 +3264,13 @@ static inline AddressSpace *arm_addressspace(CPUState *cs, MemTxAttrs attrs)
  */
 void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
                                  void *opaque);
+/**
+ * arm_unregister_pre_el_change_hook:
+ * unregister all pre EL change hook functions. Generally called during
+ * unrealize'ing leg
+ */
+void arm_unregister_pre_el_change_hooks(ARMCPU *cpu);
+
 /**
  * arm_register_el_change_hook:
  * Register a hook function which will be called immediately after this
@@ -3276,6 +3283,12 @@ void arm_register_pre_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook,
  */
 void arm_register_el_change_hook(ARMCPU *cpu, ARMELChangeHookFn *hook, void
         *opaque);
+/**
+ * arm_unregister_el_change_hook:
+ * unregister all EL change hook functions.  Generally called during
+ * unrealize'ing leg
+ */
+void arm_unregister_el_change_hooks(ARMCPU *cpu);
 
 /**
  * arm_rebuild_hflags:
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f421c5d041..fecbd84ba6 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -580,3 +580,9 @@ void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu)
     }
 #endif /* CONFIG_TCG */
 }
+
+void arm_cpu_unregister_gdb_regs(ARMCPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+    gdb_unregister_coprocessor_all(cs);
+}
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 50f61e42ca..272d6ba139 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -262,6 +262,19 @@ void init_cpreg_list(ARMCPU *cpu)
     g_list_free(keys);
 }
 
+void destroy_cpreg_list(ARMCPU *cpu)
+{
+    assert(cpu->cpreg_indexes);
+    assert(cpu->cpreg_values);
+    assert(cpu->cpreg_vmstate_indexes);
+    assert(cpu->cpreg_vmstate_values);
+
+    g_free(cpu->cpreg_indexes);
+    g_free(cpu->cpreg_values);
+    g_free(cpu->cpreg_vmstate_indexes);
+    g_free(cpu->cpreg_vmstate_values);
+}
+
 /*
  * Some registers are not accessible from AArch32 EL3 if SCR.NS == 0.
  */
@@ -9279,6 +9292,18 @@ void register_cp_regs_for_features(ARMCPU *cpu)
 #endif
 }
 
+void unregister_cp_regs_for_features(ARMCPU *cpu)
+{
+    CPUARMState *env = &cpu->env;
+    if (arm_feature(env, ARM_FEATURE_M)) {
+        /* M profile has no coprocessor registers */
+        return;
+    }
+
+    /* empty it all. unregister all the coprocessor registers */
+    g_hash_table_remove_all(cpu->cp_regs);
+}
+
 /* Sort alphabetically by type name, except for "any". */
 static gint arm_cpu_list_compare(gconstpointer a, gconstpointer b)
 {
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0f01bc32a8..fe330e89e7 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -183,6 +183,7 @@ static inline int r14_bank_number(int mode)
 }
 
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
+void arm_cpu_unregister_gdb_regs(ARMCPU *cpu);
 void arm_translate_init(void);
 
 void arm_restore_state_to_opc(CPUState *cs,
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 364cc21f81..38de0b4148 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -651,6 +651,10 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
 {
+    if (cs->thread_id) {
+        qemu_del_vm_change_state_handler(cs->vmcse);
+    }
+
     return 0;
 }
 
-- 
2.34.1


