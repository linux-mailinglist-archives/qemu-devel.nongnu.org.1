Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F195D9FD09A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Dec 2024 07:23:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR3jx-0003DS-QN; Fri, 27 Dec 2024 01:22:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tR3jn-0003Ai-Mm
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:20 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tR3jl-0000LU-FC
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 01:22:19 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxTOKXR25nqtlaAA--.46751S3;
 Fri, 27 Dec 2024 14:22:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDx_8eQR25nZ54KAA--.56394S8;
 Fri, 27 Dec 2024 14:22:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL v2 6/6] target/loongarch: Use auto method with LASX feature
Date: Fri, 27 Dec 2024 14:22:08 +0800
Message-Id: <20241227062208.1232281-7-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241227062208.1232281-1-maobibo@loongson.cn>
References: <20241227062208.1232281-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDx_8eQR25nZ54KAA--.56394S8
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Like LSX feature, add type OnOffAuto for LASX feature setting.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c     | 50 +++++++++++++++++++++++------------
 target/loongarch/cpu.h     |  2 ++
 target/loongarch/kvm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 16 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 8e52338350..d611a60470 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -623,6 +623,14 @@ static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
     uint32_t val;
 
     cpu->lsx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    if (cpu->lsx == ON_OFF_AUTO_OFF) {
+        cpu->lasx = ON_OFF_AUTO_OFF;
+        if (cpu->lasx == ON_OFF_AUTO_ON) {
+            error_setg(errp, "Failed to disable LSX since LASX is enabled");
+            return;
+        }
+    }
+
     if (kvm_enabled()) {
         /* kvm feature detection in function kvm_arch_init_vcpu */
         return;
@@ -635,6 +643,9 @@ static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
             error_setg(errp, "Failed to enable LSX in TCG mode");
             return;
         }
+    } else {
+        cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, 0);
+        val = cpu->env.cpucfg[2];
     }
 
     cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LSX, value);
@@ -642,29 +653,35 @@ static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
 
 static bool loongarch_get_lasx(Object *obj, Error **errp)
 {
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    bool ret;
-
-    if (FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LASX)) {
-        ret = true;
-    } else {
-        ret = false;
-    }
-    return ret;
+    return LOONGARCH_CPU(obj)->lasx != ON_OFF_AUTO_OFF;
 }
 
 static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t val;
 
-    if (value) {
-	if (!FIELD_EX32(cpu->env.cpucfg[2], CPUCFG2, LSX)) {
-            cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LSX, 1);
-	}
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 1);
-    } else {
-        cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LASX, 0);
+    cpu->lasx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    if ((cpu->lsx == ON_OFF_AUTO_OFF) && (cpu->lasx == ON_OFF_AUTO_ON)) {
+        error_setg(errp, "Failed to enable LASX since lSX is disabled");
+        return;
+    }
+
+    if (kvm_enabled()) {
+        /* kvm feature detection in function kvm_arch_init_vcpu */
+        return;
     }
+
+    /* LASX feature detection in TCG mode */
+    val = cpu->env.cpucfg[2];
+    if (cpu->lasx == ON_OFF_AUTO_ON) {
+        if (FIELD_EX32(val, CPUCFG2, LASX) == 0) {
+            error_setg(errp, "Failed to enable LASX in TCG mode");
+            return;
+        }
+    }
+
+    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
 }
 
 static bool loongarch_get_lbt(Object *obj, Error **errp)
@@ -696,6 +713,7 @@ void loongarch_cpu_post_init(Object *obj)
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
 
     cpu->lsx = ON_OFF_AUTO_AUTO;
+    cpu->lasx = ON_OFF_AUTO_AUTO;
     object_property_add_bool(obj, "lsx", loongarch_get_lsx,
                              loongarch_set_lsx);
     object_property_add_bool(obj, "lasx", loongarch_get_lasx,
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 5bddf72c22..8eee49a984 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -284,6 +284,7 @@ typedef struct LoongArchTLB LoongArchTLB;
 
 enum loongarch_features {
     LOONGARCH_FEATURE_LSX,
+    LOONGARCH_FEATURE_LASX,
     LOONGARCH_FEATURE_LBT, /* loongson binary translation extension */
     LOONGARCH_FEATURE_PMU,
 };
@@ -406,6 +407,7 @@ struct ArchCPU {
     OnOffAuto lbt;
     OnOffAuto pmu;
     OnOffAuto lsx;
+    OnOffAuto lasx;
 
     /* 'compatible' string for this CPU for Linux device trees */
     const char *dtb_compatible;
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index eeedf3175e..a3f55155b0 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -827,6 +827,32 @@ static bool kvm_feature_supported(CPUState *cs, enum loongarch_features feature)
         }
         return false;
 
+    case LOONGARCH_FEATURE_LASX:
+        attr.group = KVM_LOONGARCH_VM_FEAT_CTRL;
+        attr.attr = KVM_LOONGARCH_VM_FEAT_LASX;
+        ret = kvm_vm_ioctl(kvm_state, KVM_HAS_DEVICE_ATTR, &attr);
+        if (ret == 0) {
+            return true;
+        }
+
+        /* Fallback to old kernel detect interface */
+        val = 0;
+        attr.group = KVM_LOONGARCH_VCPU_CPUCFG;
+        /* Cpucfg2 */
+        attr.attr  = 2;
+        attr.addr = (uint64_t)&val;
+        ret = kvm_vcpu_ioctl(cs, KVM_HAS_DEVICE_ATTR, &attr);
+        if (!ret) {
+            ret = kvm_vcpu_ioctl(cs, KVM_GET_DEVICE_ATTR, &attr);
+            if (ret) {
+                return false;
+            }
+
+            ret = FIELD_EX32((uint32_t)val, CPUCFG2, LASX);
+            return (ret != 0);
+        }
+        return false;
+
     case LOONGARCH_FEATURE_LBT:
         /*
          * Return all if all the LBT features are supported such as:
@@ -878,6 +904,28 @@ static int kvm_cpu_check_lsx(CPUState *cs, Error **errp)
     return 0;
 }
 
+static int kvm_cpu_check_lasx(CPUState *cs, Error **errp)
+{
+    CPULoongArchState *env = cpu_env(cs);
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    bool kvm_supported;
+
+    kvm_supported = kvm_feature_supported(cs, LOONGARCH_FEATURE_LASX);
+    env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LASX, 0);
+    if (cpu->lasx == ON_OFF_AUTO_ON) {
+        if (kvm_supported) {
+            env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LASX, 1);
+        } else {
+            error_setg(errp, "'lasx' feature not supported by KVM on host");
+            return -ENOTSUP;
+        }
+    } else if ((cpu->lasx == ON_OFF_AUTO_AUTO) && kvm_supported) {
+        env->cpucfg[2] = FIELD_DP32(env->cpucfg[2], CPUCFG2, LASX, 1);
+    }
+
+    return 0;
+}
+
 static int kvm_cpu_check_lbt(CPUState *cs, Error **errp)
 {
     CPULoongArchState *env = cpu_env(cs);
@@ -943,6 +991,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
         error_report_err(local_err);
     }
 
+    ret = kvm_cpu_check_lasx(cs, &local_err);
+    if (ret < 0) {
+        error_report_err(local_err);
+    }
+
     ret = kvm_cpu_check_lbt(cs, &local_err);
     if (ret < 0) {
         error_report_err(local_err);
-- 
2.43.5


