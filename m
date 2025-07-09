Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD1AFDC83
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Jul 2025 02:47:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZIx0-0003qm-Oo; Tue, 08 Jul 2025 20:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZIwe-0003iU-IK
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZIwb-0004Lv-D7
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 20:45:56 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxSWq8u21oH+gkAQ--.43846S3;
 Wed, 09 Jul 2025 08:45:48 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+S6u21o0TEPAA--.22142S6;
 Wed, 09 Jul 2025 08:45:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/loongarch: Add header file cpu-mmu.h
Date: Wed,  9 Jul 2025 08:45:44 +0800
Message-Id: <20250709004546.3005275-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250709004546.3005275-1-maobibo@loongson.cn>
References: <20250709004546.3005275-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+S6u21o0TEPAA--.22142S6
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

New header file cpu-mmu.h is added and move mmu relative function
declaration to this file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu-mmu.h        | 30 ++++++++++++++++++++++++++++++
 target/loongarch/cpu.c            |  1 +
 target/loongarch/cpu_helper.c     |  1 +
 target/loongarch/internals.h      | 20 --------------------
 target/loongarch/tcg/csr_helper.c |  1 +
 target/loongarch/tcg/tlb_helper.c |  1 +
 6 files changed, 34 insertions(+), 20 deletions(-)
 create mode 100644 target/loongarch/cpu-mmu.h

diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
new file mode 100644
index 0000000000..4c5cbd7425
--- /dev/null
+++ b/target/loongarch/cpu-mmu.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch CPU parameters for QEMU.
+ *
+ * Copyright (c) 2025 Loongson Technology Corporation Limited
+ */
+
+#ifndef LOONGARCH_CPU_MMU_H
+#define LOONGARCH_CPU_MMU_H
+
+enum {
+    TLBRET_MATCH = 0,
+    TLBRET_BADADDR = 1,
+    TLBRET_NOMATCH = 2,
+    TLBRET_INVALID = 3,
+    TLBRET_DIRTY = 4,
+    TLBRET_RI = 5,
+    TLBRET_XI = 6,
+    TLBRET_PE = 7,
+};
+
+bool check_ps(CPULoongArchState *ent, uint8_t ps);
+int get_physical_address(CPULoongArchState *env, hwaddr *physical,
+                         int *prot, target_ulong address,
+                         MMUAccessType access_type, int mmu_idx, int is_debug);
+void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
+                               uint64_t *dir_width, target_ulong level);
+hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
+
+#endif  /* LOONGARCH_CPU_MMU_H */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index b96429ffb1..990985708e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 #include "exec/translation-block.h"
 #include "cpu.h"
+#include "cpu-mmu.h"
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
 #include "csr.h"
diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
index e172b11ce1..2e8d3d7cfb 100644
--- a/target/loongarch/cpu_helper.c
+++ b/target/loongarch/cpu_helper.c
@@ -13,6 +13,7 @@
 #include "exec/target_page.h"
 #include "internals.h"
 #include "cpu-csr.h"
+#include "cpu-mmu.h"
 #include "tcg/tcg_loongarch.h"
 
 void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index a7384b0d31..e50d109767 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -32,19 +32,6 @@ void restore_fp_status(CPULoongArchState *env);
 #endif
 
 #ifndef CONFIG_USER_ONLY
-enum {
-    TLBRET_MATCH = 0,
-    TLBRET_BADADDR = 1,
-    TLBRET_NOMATCH = 2,
-    TLBRET_INVALID = 3,
-    TLBRET_DIRTY = 4,
-    TLBRET_RI = 5,
-    TLBRET_XI = 6,
-    TLBRET_PE = 7,
-};
-
-bool check_ps(CPULoongArchState *ent, uint8_t ps);
-
 extern const VMStateDescription vmstate_loongarch_cpu;
 
 void loongarch_cpu_set_irq(void *opaque, int irq, int level);
@@ -54,13 +41,6 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
 uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
 void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
                                                uint64_t value);
-int get_physical_address(CPULoongArchState *env, hwaddr *physical,
-                         int *prot, target_ulong address,
-                         MMUAccessType access_type, int mmu_idx, int is_debug);
-void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
-                               uint64_t *dir_width, target_ulong level);
-hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
-
 #endif /* !CONFIG_USER_ONLY */
 
 uint64_t read_fcc(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
index 2942d7feb8..49000b2418 100644
--- a/target/loongarch/tcg/csr_helper.c
+++ b/target/loongarch/tcg/csr_helper.c
@@ -16,6 +16,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "hw/irq.h"
 #include "cpu-csr.h"
+#include "cpu-mmu.h"
 
 target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
 {
diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
index 871a8f3e76..a2855209e2 100644
--- a/target/loongarch/tcg/tlb_helper.c
+++ b/target/loongarch/tcg/tlb_helper.c
@@ -10,6 +10,7 @@
 #include "qemu/guest-random.h"
 
 #include "cpu.h"
+#include "cpu-mmu.h"
 #include "internals.h"
 #include "exec/helper-proto.h"
 #include "exec/cputlb.h"
-- 
2.39.3


