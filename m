Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEB9B9DDD
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Nov 2024 09:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7999-0007Jj-Q8; Sat, 02 Nov 2024 04:06:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t7997-0007Ic-1L
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t7994-0001z6-3Q
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 04:06:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx2uFp3SVnZX0nAA--.16057S3;
 Sat, 02 Nov 2024 16:06:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAx7uBh3SVnzZA1AA--.18827S5;
 Sat, 02 Nov 2024 16:06:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL v2 3/8] target/loongarch/kvm: Implement LoongArch PMU extension
Date: Sat,  2 Nov 2024 15:47:32 +0800
Message-Id: <20241102074737.1394884-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241102074737.1394884-1-gaosong@loongson.cn>
References: <20241102074737.1394884-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBh3SVnzZA1AA--.18827S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bibo Mao <maobibo@loongson.cn>

Implement PMU extension for LoongArch kvm mode. Use OnOffAuto type
variable pmu to check the PMU feature. If the PMU Feature is not supported
with KVM host, it reports error if there is pmu=on command line.

If there is no any command line about pmu parameter, it checks whether
KVM host supports the PMU Feature and set the corresponding value in cpucfg.

This patch is based on lbt patch located at
  https://lore.kernel.org/qemu-devel/20240904061859.86615-1-maobibo@loongson.cn

Co-developed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240918082315.2345034-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c                | 19 +++++++++++++
 target/loongarch/cpu.h                |  2 ++
 target/loongarch/kvm/kvm.c            | 41 +++++++++++++++++++++++++++
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 29577e6b71..57cc4f314b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -676,6 +676,18 @@ static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
     cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static bool loongarch_get_pmu(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->pmu != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_pmu(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->pmu = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -691,6 +703,13 @@ void loongarch_cpu_post_init(Object *obj)
                                  loongarch_set_lbt);
         object_property_set_description(obj, "lbt",
                                    "Set off to disable Binary Tranlation.");
+
+        cpu->pmu = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "pmu", loongarch_get_pmu,
+                                 loongarch_set_pmu);
+        object_property_set_description(obj, "pmu",
+                                   "Set off to performance monitor unit.");
+
     } else {
         cpu->lbt = ON_OFF_AUTO_OFF;
     }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 136866b7b8..95be58dd66 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -284,6 +284,7 @@ typedef struct LoongArchTLB LoongArchTLB;
 
 enum loongarch_features {
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
+    LOONGARCH_FEATURE_PMU,
 };
 
 typedef struct  LoongArchBT {
@@ -399,6 +400,7 @@ struct ArchCPU {
     QEMUTimer timer;
     uint32_t  phy_id;
     OnOffAuto lbt;
+    OnOffAuto pmu;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 40115aff56..8bda8ae540 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -750,9 +750,18 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         attr.attr = KVM_LOONGARCH_VM_FEAT_MIPSBT;
         ret |= kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
         return (ret == 0);
+
+    case LOONGARCH_FEATURE_PMU:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_PMU;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        return (ret == 0);
+
     default:
         return false;
     }
+
+    return false;
 }
 
 static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
@@ -776,6 +785,32 @@ static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = cpu_env(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_PMU);
+    if (cpu->pmu == ON_OFF_AUTO_ON) {
+        if (!kvm_supported) {
+            error_setg(errp, "'pmu' feature not supported by KVM on the host");
+            return -ENOTSUP;
+        }
+    } else if (cpu->pmu != ON_OFF_AUTO_AUTO) {
+        /* disable pmu if ON_OFF_AUTO_OFF is set */
+        kvm_supported = false;
+    }
+
+    if (kvm_supported) {
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMP, 1);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMNUM, 3);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, PMBITS, 63);
+        env->cpucfg[6] = FIELD_DP32(env->cpucfg[6], CPUCFG6, UPM, 1);
+    }
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
@@ -793,6 +828,12 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (ret < 0) {
         error_report_err(local_err);
     }
+
+    ret = kvm_cpu_check_pmu(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     return ret;
 }
 
diff --git a/target/loongarch/loongarch-qmp-cmds.c b/target/loongarch/loongarch-qmp-cmds.c
index c6f6e1ef85..782fd511fd 100644
--- a/target/loongarch/loongarch-qmp-cmds.c
+++ b/target/loongarch/loongarch-qmp-cmds.c
@@ -40,7 +40,7 @@ CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp)
 }
 
 static const char *cpu_model_advertised_features[] = {
-    "lsx", "lasx", "lbt", NULL
+    "lsx", "lasx", "lbt", "pmu", NULL
 };
 
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
-- 
2.34.1


