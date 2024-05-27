Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F0D8CFBAE
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 10:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBVsE-0007yX-QO; Mon, 27 May 2024 04:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sBVp3-0008Iq-R8
 for qemu-devel@nongnu.org; Mon, 27 May 2024 04:35:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sBVp0-0002ur-Kx
 for qemu-devel@nongnu.org; Mon, 27 May 2024 04:35:13 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxzOq2RVRmbSUAAA--.524S3;
 Mon, 27 May 2024 16:35:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxDMe1RVRmf+8KAA--.28764S3; 
 Mon, 27 May 2024 16:35:02 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [RFC v2 1/2] target/loongarch: Add loongson binary translation feature
Date: Mon, 27 May 2024 16:35:00 +0800
Message-Id: <20240527083501.844854-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240527083501.844854-1-maobibo@loongson.cn>
References: <20240527083501.844854-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxDMe1RVRmf+8KAA--.28764S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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

Loongson Binary Translation (LBT) is used to accelerate binary
translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
eflags (eflags) and x87 fpu stack pointer (ftop).

Now LBT feature is added in kvm mode, not supported in TCG mode since
it is not emulated. There are two feature flags such as forced_features
and default_features for each vcpu, the real feature is still in cpucfg.
Flag forced_features is parsed from command line, default_features is
parsed from cpu type.

Flag forced_features has higher priority than flag default_features,
default_features will be used if there is no command line option for LBT
feature. If the feature is not supported with KVM host, it reports error
and exits if forced_features is set, else it disables feature and continues
if default_features is set.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                | 69 +++++++++++++++++++++++++++
 target/loongarch/cpu.h                | 12 +++++
 target/loongarch/kvm/kvm.c            | 26 ++++++++++
 target/loongarch/kvm/kvm_loongarch.h  | 16 +++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 5 files changed, 124 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b5c1ec94af..d9d601da07 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -380,6 +380,8 @@ static void loongarch_la464_initfn(Object *obj)
     CPULoongArchState *env = &cpu->env;
     int i;
 
+    env->default_features = 0;
+    env->forced_features  = 0;
     for (i = 0; i < 21; i++) {
         env->cpucfg[i] = 0x0;
     }
@@ -413,6 +415,7 @@ static void loongarch_la464_initfn(Object *obj)
     data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
     data = FIELD_DP32(data, CPUCFG2, LAM, 1);
     env->cpucfg[2] = data;
+    env->default_features |= BIT_ULL(LOONGARCH_FEATURE_LBT);
 
     env->cpucfg[4] = 100 * 1000 * 1000; /* Crystal frequency */
 
@@ -571,6 +574,35 @@ static void loongarch_cpu_disas_set_info(CPUState *s, disassemble_info *info)
     info->print_insn = print_insn_loongarch;
 }
 
+static void loongarch_cpu_check_lbt(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    enum loongarch_features feature;
+    bool kvm_supported;
+
+    feature = LOONGARCH_FEATURE_LBT;
+    kvm_supported = kvm_feature_supported(cs, feature);
+    if (env->forced_features & BIT_ULL(feature)) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+        } else {
+            error_setg(errp, "'lbt' feature not supported by KVM on this host");
+            return;
+        }
+    } else if (env->default_features & BIT_ULL(feature)) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+        }
+    }
+}
+
+static void loongarch_cpu_feature_realize(CPUState *cs, Error **errp)
+{
+    if (kvm_enabled()) {
+        loongarch_cpu_check_lbt(cs, errp);
+    }
+}
+
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
@@ -584,6 +616,11 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     loongarch_cpu_register_gdb_regs_for_features(cs);
+    loongarch_cpu_feature_realize(cs, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
 
     cpu_reset(cs);
     qemu_init_vcpu(cs);
@@ -643,12 +680,44 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_lbt(Object *obj, Error **errp)
+ {
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    bool ret;
+
+    ret = false;
+    /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (cpu->env.forced_features & BIT_ULL(LOONGARCH_FEATURE_LBT)) {
+        ret = true;
+     }
+    return ret;
+}
+
+static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    if (!kvm_enabled()) {
+        return;
+    }
+
+    if (value) {
+        /* Enable binary translation for all architectures */
+        cpu->env.forced_features |= BIT_ULL(LOONGARCH_FEATURE_LBT);
+    } else {
+        /* Disable default features also */
+        cpu->env.default_features &= ~BIT_ULL(LOONGARCH_FEATURE_LBT);
+    }
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
+    object_property_add_bool(obj, "lbt", loongarch_get_lbt,
+                             loongarch_set_lbt);
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 41b8e6d96d..36fb160a8c 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -152,6 +152,7 @@ FIELD(CPUCFG2, LLFTP_VER, 15, 3)
 FIELD(CPUCFG2, LBT_X86, 18, 1)
 FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
+FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 
@@ -280,6 +281,10 @@ struct LoongArchTLB {
 typedef struct LoongArchTLB LoongArchTLB;
 #endif
 
+enum loongarch_features {
+    LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
+};
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -289,6 +294,13 @@ typedef struct CPUArchState {
     uint32_t fcsr0;
 
     uint32_t cpucfg[21];
+    /*
+     * Features not specified from command line
+     * Comes from cpu type and kvm host capability
+     */
+    uint64_t default_features;
+    /* features parsed from command line, such as lbt=on */
+    uint64_t forced_features;
 
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 8e6e27c8bf..55e85eff15 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -780,6 +780,32 @@ int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
     return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
 }
 
+bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
+{
+    int ret;
+    struct kvm_device_attr attr;
+
+    switch (feature) {
+    case LOONGARCH_FEATURE_LBT:
+        /*
+         * Return all if all the LBT features are supported such as:
+         *  KVM_LOONGARCH_VM_FEAT_X86BT
+         *  KVM_LOONGARCH_VM_FEAT_ARMBT
+         *  KVM_LOONGARCH_VM_FEAT_MIPSBT
+         */
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_X86BT;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        attr.attr = KVM_LOONGARCH_VM_FEAT_ARMBT;
+        ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        attr.attr = KVM_LOONGARCH_VM_FEAT_MIPSBT;
+        ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+    default:
+        return false;
+    }
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
index d945b6bb82..bdb4f180eb 100644
--- a/target/loongarch/kvm/kvm_loongarch.h
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -13,4 +13,20 @@
 int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
 void kvm_arch_reset_vcpu(CPULoongArchState *env);
 
+#ifdef CONFIG_KVM
+/*
+ * kvm_feature_supported:
+ *
+ * Returns: true if KVM supports specified feature
+ * and false otherwise.
+ */
+bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature);
+#else
+static inline bool kvm_feature_supported(CPUState *cs,
+                                         enum loongarch_features feature)
+{
+    return false;
+}
+#endif
+
 #endif
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index 8721a5eb13..c6f6e1ef85 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", NULL
+    "lsx", "lasx", "lbt", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.39.3


