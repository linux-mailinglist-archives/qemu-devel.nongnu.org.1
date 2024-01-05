Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03526824F84
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 09:12:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLfIT-0002oS-Tg; Fri, 05 Jan 2024 03:11:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaotianrui@loongson.cn>)
 id 1rLfIQ-0002nF-OY
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:14 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhaotianrui@loongson.cn>) id 1rLfIO-0007EB-92
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 03:11:14 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxWeqduZdlg0ECAA--.124S3;
 Fri, 05 Jan 2024 16:11:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxO9yQuZdl8xoDAA--.8153S10; 
 Fri, 05 Jan 2024 16:11:08 +0800 (CST)
From: Tianrui Zhao <zhaotianrui@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn, xianglai li <lixianglai@loongson.cn>
Subject: [PATCH v4 8/9] target/loongarch: Implement set vcpu intr for kvm
Date: Fri,  5 Jan 2024 15:58:03 +0800
Message-Id: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxO9yQuZdl8xoDAA--.8153S10
X-CM-SenderInfo: p2kd03xldq233l6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=zhaotianrui@loongson.cn; helo=mail.loongson.cn
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

Implement loongarch kvm set vcpu interrupt interface,
when a irq is set in vcpu, we use the KVM_INTERRUPT
ioctl to set intr into kvm.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c               | 34 +++++++++++++++++++++-------
 target/loongarch/kvm/kvm.c           | 15 ++++++++++++
 target/loongarch/kvm/kvm_loongarch.h | 16 +++++++++++++
 target/loongarch/trace-events        |  1 +
 4 files changed, 58 insertions(+), 8 deletions(-)
 create mode 100644 target/loongarch/kvm/kvm_loongarch.h

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 6614a094c8..dfbbe0ace1 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
-#include "exec/cpu_ldst.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -20,8 +19,16 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #endif
-#include "tcg/tcg.h"
 #include "vec.h"
+#include "sysemu/kvm.h"
+#include "kvm/kvm_loongarch.h"
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
+#ifdef CONFIG_TCG
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg.h"
+#endif
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -110,12 +117,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-
-    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+    if (kvm_enabled()) {
+        kvm_loongarch_set_interrupt(cpu, irq, level);
     } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
+        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
     }
 }
 
@@ -140,7 +150,10 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 
     return (pending & status) != 0;
 }
+#endif
 
+#ifdef CONFIG_TCG
+#ifndef CONFIG_USER_ONLY
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
@@ -322,7 +335,6 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-#ifdef CONFIG_TCG
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
@@ -560,7 +572,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
     }
 #endif
 
+#ifdef CONFIG_TCG
     restore_fp_status(env);
+#endif
     cs->exception_index = -1;
 }
 
@@ -703,8 +717,10 @@ static void loongarch_cpu_init(Object *obj)
     CPULoongArchState *env = &cpu->env;
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
+#ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
+#endif
     memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
                           env, "iocsr", UINT64_MAX);
     address_space_init(&env->address_space_iocsr, &env->system_iocsr, "IOCSR");
@@ -804,7 +820,9 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+#ifdef CONFIG_TCG
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
+#endif
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index d2dab3fef4..bd33ec2114 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -748,6 +748,21 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     return ret;
 }
 
+int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
+{
+    struct kvm_interrupt intr;
+    CPUState *cs = CPU(cpu);
+
+    if (level) {
+        intr.irq = irq;
+    } else {
+        intr.irq = -irq;
+    }
+
+    trace_kvm_set_intr(irq, level);
+    return kvm_vcpu_ioctl(cs, KVM_INTERRUPT, &intr);
+}
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
 }
diff --git a/target/loongarch/kvm/kvm_loongarch.h b/target/loongarch/kvm/kvm_loongarch.h
new file mode 100644
index 0000000000..d945b6bb82
--- /dev/null
+++ b/target/loongarch/kvm/kvm_loongarch.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch kvm interface
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#include "cpu.h"
+
+#ifndef QEMU_KVM_LOONGARCH_H
+#define QEMU_KVM_LOONGARCH_H
+
+int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
+void kvm_arch_reset_vcpu(CPULoongArchState *env);
+
+#endif
diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
index 021839880e..dea11edc0f 100644
--- a/target/loongarch/trace-events
+++ b/target/loongarch/trace-events
@@ -12,3 +12,4 @@ kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
 kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
 kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
 kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"
+kvm_set_intr(int irq, int level) "kvm set interrupt, irq num: %d, level: %d"
-- 
2.39.1


