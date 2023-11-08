Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D817E4EB0
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 02:43:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0XZy-0008DK-1w; Tue, 07 Nov 2023 20:42:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1r0XZv-0008CH-MB
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1r0XZt-0005py-DV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 20:41:59 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxHOtj50plaOM3AA--.39875S3;
 Wed, 08 Nov 2023 09:41:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxS9xR50pl9qo7AA--.63823S10; 
 Wed, 08 Nov 2023 09:41:54 +0800 (CST)
From: xianglai li <lixianglai@loongson.cn>
To: qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
Subject: [PATCH v1 8/9] target/loongarch: Implement set vcpu intr for kvm
Date: Wed,  8 Nov 2023 09:41:40 +0800
Message-Id: <20231108014141.2590657-9-lixianglai@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231108014141.2590657-1-lixianglai@loongson.cn>
References: <20231108014141.2590657-1-lixianglai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxS9xR50pl9qo7AA--.63823S10
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Implement loongarch kvm set vcpu interrupt interface,
when a irq is set in vcpu, we use the KVM_INTERRUPT
ioctl to set intr into kvm.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
---
 target/loongarch/cpu.c           | 18 +++++++++++++-----
 target/loongarch/kvm-stub.c      | 13 +++++++++++++
 target/loongarch/kvm.c           | 15 +++++++++++++++
 target/loongarch/kvm_loongarch.h | 13 +++++++++++++
 target/loongarch/trace-events    |  1 +
 5 files changed, 55 insertions(+), 5 deletions(-)
 create mode 100644 target/loongarch/kvm-stub.c
 create mode 100644 target/loongarch/kvm_loongarch.h

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 0a4d1a9778..3073f1548d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -20,6 +20,11 @@
 #include "sysemu/reset.h"
 #include "tcg/tcg.h"
 #include "vec.h"
+#include "sysemu/kvm.h"
+#include "kvm_loongarch.h"
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -108,12 +113,15 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
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
 
diff --git a/target/loongarch/kvm-stub.c b/target/loongarch/kvm-stub.c
new file mode 100644
index 0000000000..d38c30ec78
--- /dev/null
+++ b/target/loongarch/kvm-stub.c
@@ -0,0 +1,13 @@
+/*
+ * QEMU KVM LoongArch specific function stubs
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "kvm_loongarch.h"
+
+int kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level)
+{
+   g_assert_not_reached();
+}
diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
index d2dab3fef4..bd33ec2114 100644
--- a/target/loongarch/kvm.c
+++ b/target/loongarch/kvm.c
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
diff --git a/target/loongarch/kvm_loongarch.h b/target/loongarch/kvm_loongarch.h
new file mode 100644
index 0000000000..cdef980eec
--- /dev/null
+++ b/target/loongarch/kvm_loongarch.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU LoongArch kvm interface
+ *
+ * Copyright (c) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef QEMU_KVM_LOONGARCH_H
+#define QEMU_KVM_LOONGARCH_H
+
+int  kvm_loongarch_set_interrupt(LoongArchCPU *cpu, int irq, int level);
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


