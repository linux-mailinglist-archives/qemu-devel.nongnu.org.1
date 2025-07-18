Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E1B09CE1
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Jul 2025 09:43:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucfjc-0002sF-1f; Fri, 18 Jul 2025 03:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ucfW6-0002gk-5n
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ucfVz-0002ig-2L
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 03:28:25 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxYa+K93lowMksAQ--.52692S3;
 Fri, 18 Jul 2025 15:28:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxocKI93lo0QwcAA--.17387S4;
 Fri, 18 Jul 2025 15:28:10 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 2/9] target/loongarch: Define function
 loongarch_cpu_post_init as static
Date: Fri, 18 Jul 2025 15:28:00 +0800
Message-Id: <20250718072807.3585466-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250718072807.3585466-1-maobibo@loongson.cn>
References: <20250718072807.3585466-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxocKI93lo0QwcAA--.17387S4
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

Function loongarch_cpu_post_init() is implemented and used in the
same file target/loongarch/cpu.c, it can be defined as static function.

This patch moves implementation about function loongarch_cpu_post_init()
before it is referenced. And it is only code movement, no function
change.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c | 180 ++++++++++++++++++++---------------------
 target/loongarch/cpu.h |   2 -
 2 files changed, 90 insertions(+), 92 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index abad84c054..b96429ffb1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -422,6 +422,96 @@ static void loongarch_la464_init_csr(Object *obj)
 #endif
 }
 
+static bool loongarch_get_lsx(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lsx != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t val;
+
+    cpu->lsx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    if (cpu->lsx == ON_OFF_AUTO_OFF) {
+        cpu->lasx = ON_OFF_AUTO_OFF;
+        if (cpu->lasx == ON_OFF_AUTO_ON) {
+            error_setg(errp, "Failed to disable LSX since LASX is enabled");
+            return;
+        }
+    }
+
+    if (kvm_enabled()) {
+        /* kvm feature detection in function kvm_arch_init_vcpu */
+        return;
+    }
+
+    /* LSX feature detection in TCG mode */
+    val = cpu->env.cpucfg[2];
+    if (cpu->lsx == ON_OFF_AUTO_ON) {
+        if (FIELD_EX32(val, CPUCFG2, LSX) == 0) {
+            error_setg(errp, "Failed to enable LSX in TCG mode");
+            return;
+        }
+    } else {
+        cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, 0);
+        val = cpu->env.cpucfg[2];
+    }
+
+    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LSX, value);
+}
+
+static bool loongarch_get_lasx(Object *obj, Error **errp)
+{
+    return LOONGARCH_CPU(obj)->lasx != ON_OFF_AUTO_OFF;
+}
+
+static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+    uint32_t val;
+
+    cpu->lasx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
+    if ((cpu->lsx == ON_OFF_AUTO_OFF) && (cpu->lasx == ON_OFF_AUTO_ON)) {
+        error_setg(errp, "Failed to enable LASX since lSX is disabled");
+        return;
+    }
+
+    if (kvm_enabled()) {
+        /* kvm feature detection in function kvm_arch_init_vcpu */
+        return;
+    }
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
+}
+
+static void loongarch_cpu_post_init(Object *obj)
+{
+    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
+
+    cpu->lbt = ON_OFF_AUTO_OFF;
+    cpu->pmu = ON_OFF_AUTO_OFF;
+    cpu->lsx = ON_OFF_AUTO_AUTO;
+    cpu->lasx = ON_OFF_AUTO_AUTO;
+    object_property_add_bool(obj, "lsx", loongarch_get_lsx,
+                             loongarch_set_lsx);
+    object_property_add_bool(obj, "lasx", loongarch_get_lasx,
+                             loongarch_set_lasx);
+    /* lbt is enabled only in kvm mode, not supported in tcg mode */
+    if (kvm_enabled()) {
+        kvm_loongarch_cpu_post_init(cpu);
+    }
+}
+
 static void loongarch_la464_initfn(Object *obj)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(obj);
@@ -683,96 +773,6 @@ static void loongarch_cpu_unrealizefn(DeviceState *dev)
     lacc->parent_unrealize(dev);
 }
 
-static bool loongarch_get_lsx(Object *obj, Error **errp)
-{
-    return LOONGARCH_CPU(obj)->lsx != ON_OFF_AUTO_OFF;
-}
-
-static void loongarch_set_lsx(Object *obj, bool value, Error **errp)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    uint32_t val;
-
-    cpu->lsx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
-    if (cpu->lsx == ON_OFF_AUTO_OFF) {
-        cpu->lasx = ON_OFF_AUTO_OFF;
-        if (cpu->lasx == ON_OFF_AUTO_ON) {
-            error_setg(errp, "Failed to disable LSX since LASX is enabled");
-            return;
-        }
-    }
-
-    if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
-        return;
-    }
-
-    /* LSX feature detection in TCG mode */
-    val = cpu->env.cpucfg[2];
-    if (cpu->lsx == ON_OFF_AUTO_ON) {
-        if (FIELD_EX32(val, CPUCFG2, LSX) == 0) {
-            error_setg(errp, "Failed to enable LSX in TCG mode");
-            return;
-        }
-    } else {
-        cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, 0);
-        val = cpu->env.cpucfg[2];
-    }
-
-    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LSX, value);
-}
-
-static bool loongarch_get_lasx(Object *obj, Error **errp)
-{
-    return LOONGARCH_CPU(obj)->lasx != ON_OFF_AUTO_OFF;
-}
-
-static void loongarch_set_lasx(Object *obj, bool value, Error **errp)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-    uint32_t val;
-
-    cpu->lasx = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
-    if ((cpu->lsx == ON_OFF_AUTO_OFF) && (cpu->lasx == ON_OFF_AUTO_ON)) {
-        error_setg(errp, "Failed to enable LASX since lSX is disabled");
-        return;
-    }
-
-    if (kvm_enabled()) {
-        /* kvm feature detection in function kvm_arch_init_vcpu */
-        return;
-    }
-
-    /* LASX feature detection in TCG mode */
-    val = cpu->env.cpucfg[2];
-    if (cpu->lasx == ON_OFF_AUTO_ON) {
-        if (FIELD_EX32(val, CPUCFG2, LASX) == 0) {
-            error_setg(errp, "Failed to enable LASX in TCG mode");
-            return;
-        }
-    }
-
-    cpu->env.cpucfg[2] = FIELD_DP32(val, CPUCFG2, LASX, value);
-}
-
-void loongarch_cpu_post_init(Object *obj)
-{
-    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
-
-    cpu->lbt = ON_OFF_AUTO_OFF;
-    cpu->pmu = ON_OFF_AUTO_OFF;
-    cpu->lsx = ON_OFF_AUTO_AUTO;
-    cpu->lasx = ON_OFF_AUTO_AUTO;
-    object_property_add_bool(obj, "lsx", loongarch_get_lsx,
-                             loongarch_set_lsx);
-    object_property_add_bool(obj, "lasx", loongarch_get_lasx,
-                             loongarch_set_lasx);
-    /* lbt is enabled only in kvm mode, not supported in tcg mode */
-    if (kvm_enabled()) {
-        kvm_loongarch_cpu_post_init(cpu);
-    }
-}
-
 static void loongarch_cpu_init(Object *obj)
 {
 #ifndef CONFIG_USER_ONLY
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index bbe6db33f1..7731f6acdc 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -494,6 +494,4 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
 
 #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
 
-void loongarch_cpu_post_init(Object *obj);
-
 #endif /* LOONGARCH_CPU_H */
-- 
2.39.3


