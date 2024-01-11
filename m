Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D782AD65
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:30:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtFn-0007uZ-6e; Thu, 11 Jan 2024 06:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtFS-0007nU-5Q
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:22 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtFO-0006rL-K8
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:21 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxnrsA0Z9lnT8EAA--.4276S3;
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S11; 
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL  09/14] target/loongarch: Implement set vcpu intr for kvm
Date: Thu, 11 Jan 2024 19:16:04 +0800
Message-Id: <20240111111609.899183-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S11
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

From: Tianrui Zhao <zhaotianrui@loongson.cn>

Implement loongarch kvm set vcpu interrupt interface,
when a irq is set in vcpu, we use the KVM_INTERRUPT
ioctl to set intr into kvm.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
[PMD: Split from bigger patch, part 2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240110094152.52138-2-philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c               |  9 ++++++++-
 target/loongarch/kvm/kvm.c           | 15 +++++++++++++++
 target/loongarch/kvm/kvm_loongarch.h | 16 ++++++++++++++++
 target/loongarch/trace-events        |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)
 create mode 100644 target/loongarch/kvm/kvm_loongarch.h

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 70dd4622aa..7b94bab540 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -12,6 +12,8 @@
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
 #include "sysemu/tcg.h"
+#include "sysemu/kvm.h"
+#include "kvm/kvm_loongarch.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -21,6 +23,9 @@
 #include "sysemu/reset.h"
 #endif
 #include "vec.h"
+#ifdef CONFIG_KVM
+#include <linux/kvm.h>
+#endif
 #ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
 #include "tcg/tcg.h"
@@ -113,7 +118,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    if (tcg_enabled()) {
+    if (kvm_enabled()) {
+        kvm_loongarch_set_interrupt(cpu, irq, level);
+    } else if (tcg_enabled()) {
         env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
         if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
             cpu_interrupt(cs, CPU_INTERRUPT_HARD);
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
2.25.1


