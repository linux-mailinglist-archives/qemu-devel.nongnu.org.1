Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C41809AE152
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Oct 2024 11:46:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3uOl-00045E-4s; Thu, 24 Oct 2024 05:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1t3uOi-000448-5y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1t3uOf-0002Yl-25
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 05:44:51 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxeeEGFxpnCW4KAA--.24142S3;
 Thu, 24 Oct 2024 17:44:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxPMICFxpnHi0PAA--.1186S3;
 Thu, 24 Oct 2024 17:44:38 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 1/6] target/loongarch: Add loongson binary translation feature
Date: Thu, 24 Oct 2024 17:26:20 +0800
Message-Id: <20241024092626.1328049-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20241024092626.1328049-1-gaosong@loongson.cn>
References: <20241024092626.1328049-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPMICFxpnHi0PAA--.1186S3
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

Loongson Binary Translation (LBT) is used to accelerate binary
translation, which contains 4 scratch registers (scr0 to scr3), x86/ARM
eflags (eflags) and x87 fpu stack pointer (ftop).

Now LBT feature is added in kvm mode, not supported in TCG mode since
it is not emulated. Feature variable lbt is added with OnOffAuto type,
If lbt feature is not supported with KVM host, it reports error if there
is lbt=on command line.

If there is no any command line about lbt parameter, it checks whether
KVM host supports lbt feature and set the corresponding value in cpucfg.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20240929070405.235200-2-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c                | 24 +++++++++++
 target/loongarch/cpu.h                |  6 +++
 target/loongarch/kvm/kvm.c            | 57 ++++++++++++++++++++++++++-
 target/loongarch/loongarch-qmp-cmds.c |  2 +-
 4 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 7212fb5f8f..29577e6b71 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -664,12 +664,36 @@ static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
     }
 }
 
+static bool loongarch_get_lbt(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lbt != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lbt(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->lbt = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+}
+
 void loongarch_cpu_post_init(Object *obj)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
                              loongarch_set_lasx);
+    /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (kvm_enabled()) {
+        cpu->lbt = ON_OFF_AUTO_AUTO;
+        object_property_add_bool(obj, "lbt", loongarch_get_lbt,
+                                 loongarch_set_lbt);
+        object_property_set_description(obj, "lbt",
+                                   "Set off to disable Binary Tranlation.");
+    } else {
+        cpu->lbt = ON_OFF_AUTO_OFF;
+    }
 }
 
 static void loongarch_cpu_init(Object *obj)
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 6c41fafb70..2b3f2758f6 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -153,6 +153,7 @@ FIELD(CPUCFG2, LLFTP_VER, 15, 3)
 FIELD(CPUCFG2, LBT_X86, 18, 1)
 FIELD(CPUCFG2, LBT_ARM, 19, 1)
 FIELD(CPUCFG2, LBT_MIPS, 20, 1)
+FIELD(CPUCFG2, LBT_ALL, 18, 3)
 FIELD(CPUCFG2, LSPW, 21, 1)
 FIELD(CPUCFG2, LAM, 22, 1)
 
@@ -281,6 +282,10 @@ struct LoongArchTLB {
 typedef struct LoongArchTLB LoongArchTLB;
 #endif
 
+enum loongarch_features {
+    LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
+};
+
 typedef struct CPUArchState {
     uint64_t gpr[32];
     uint64_t pc;
@@ -381,6 +386,7 @@ struct ArchCPU {
     CPULoongArchState env;
     QEMUTimer timer;
     uint32_t  phy_id;
+    OnOffAuto lbt;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index 30ec16025d..079f8ca5d7 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -9,6 +9,7 @@
 #include <sys/ioctl.h>
 #include <linux/kvm.h>
 
+#include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
@@ -666,17 +667,71 @@ static void kvm_loongarch_vm_stage_change(void *opaque, bool running,
     }
 }
 
+static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
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
+static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LBT);
+    if (cpu->lbt == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+        } else {
+            error_setg(errp, "'lbt' feature not supported by KVM on this host");
+            return -ENOTSUP;
+        }
+    } else if ((cpu->lbt == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LBT_ALL, 7);
+    }
+
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
+    int ret;
+    Error *local_err = NULL;
 
+    ret = 0;
     qemu_add_vm_change_state_handler(kvm_loongarch_vm_stage_change, cs);
 
     if (!kvm_get_one_reg(cs, KVM_REG_LOONGARCH_DEBUG_INST, &val)) {
         brk_insn = val;
     }
 
-    return 0;
+    ret = kvm_cpu_check_lbt(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+    return ret;
 }
 
 int kvm_arch_destroy_vcpu(CPUState *cs)
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
2.34.1


