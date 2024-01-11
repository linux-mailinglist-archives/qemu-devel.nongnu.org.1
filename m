Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A3E82AD88
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:32:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtFd-0007sq-RR; Thu, 11 Jan 2024 06:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtFK-0007lg-Ft
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:14 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtFE-0006rO-Ar
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:29:13 -0500
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxvusA0Z9lmj8EAA--.12684S3;
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx34f80J9l6+4PAA--.41647S10; 
 Thu, 11 Jan 2024 19:29:04 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: 
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Tianrui Zhao <zhaotianrui@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL  08/14] target/loongarch: Restrict TCG-specific code
Date: Thu, 11 Jan 2024 19:16:03 +0800
Message-Id: <20240111111609.899183-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240111111609.899183-1-gaosong@loongson.cn>
References: <20240111111609.899183-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bx34f80J9l6+4PAA--.41647S10
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

In preparation of supporting KVM in the next commit.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: xianglai li <lixianglai@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240105075804.1228596-9-zhaotianrui@loongson.cn>
[PMD: Split from bigger patch, part 1]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240110094152.52138-1-philmd@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 0c157bbd51..70dd4622aa 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -11,7 +11,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "sysemu/qtest.h"
-#include "exec/cpu_ldst.h"
+#include "sysemu/tcg.h"
 #include "exec/exec-all.h"
 #include "cpu.h"
 #include "internals.h"
@@ -20,8 +20,11 @@
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
 #endif
-#include "tcg/tcg.h"
 #include "vec.h"
+#ifdef CONFIG_TCG
+#include "exec/cpu_ldst.h"
+#include "tcg/tcg.h"
+#endif
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -110,12 +113,13 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
-
-    if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
-        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
-    } else {
-        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+    if (tcg_enabled()) {
+        env->CSR_ESTAT = deposit64(env->CSR_ESTAT, irq, 1, level != 0);
+        if (FIELD_EX64(env->CSR_ESTAT, CSR_ESTAT, IS)) {
+            cpu_interrupt(cs, CPU_INTERRUPT_HARD);
+        } else {
+            cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
+        }
     }
 }
 
@@ -140,7 +144,10 @@ static inline bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
 
     return (pending & status) != 0;
 }
+#endif
 
+#ifdef CONFIG_TCG
+#ifndef CONFIG_USER_ONLY
 static void loongarch_cpu_do_interrupt(CPUState *cs)
 {
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
@@ -322,7 +329,6 @@ static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 }
 #endif
 
-#ifdef CONFIG_TCG
 static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
                                               const TranslationBlock *tb)
 {
@@ -545,7 +551,9 @@ static void loongarch_cpu_reset_hold(Object *obj)
     }
 #endif
 
+#ifdef CONFIG_TCG
     restore_fp_status(env);
+#endif
     cs->exception_index = -1;
 }
 
@@ -688,8 +696,10 @@ static void loongarch_cpu_init(Object *obj)
     CPULoongArchState *env = &cpu->env;
 
     qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
+#ifdef CONFIG_TCG
     timer_init_ns(&cpu->timer, QEMU_CLOCK_VIRTUAL,
                   &loongarch_constant_timer_cb, cpu);
+#endif
     memory_region_init_io(&env->system_iocsr, OBJECT(cpu), NULL,
                           env, "iocsr", UINT64_MAX);
     address_space_init(&env->address_space_iocsr, &env->system_iocsr, "IOCSR");
@@ -783,7 +793,9 @@ static struct TCGCPUOps loongarch_tcg_ops = {
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
+#ifdef CONFIG_TCG
     .get_phys_page_debug = loongarch_cpu_get_phys_page_debug,
+#endif
 };
 
 static int64_t loongarch_cpu_get_arch_id(CPUState *cs)
-- 
2.25.1


