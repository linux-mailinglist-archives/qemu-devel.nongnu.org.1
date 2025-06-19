Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2ADFB94
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 05:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5YY-000767-3W; Wed, 18 Jun 2025 23:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5YW-00075E-Kf
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:12 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5YU-0006Bk-Iv
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:12 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxPOLofVNoyY4ZAQ--.17316S3;
 Thu, 19 Jun 2025 11:03:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S9;
 Thu, 19 Jun 2025 11:03:00 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 7/9] hw/loongarch: Implement avec set irq
Date: Thu, 19 Jun 2025 10:39:42 +0800
Message-Id: <20250619023944.1278716-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S9
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

Implement avec set irq and update CSR_MSIS and CSR_MSGIR.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 7dd8bac696..bbd1b48c7d 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -16,6 +16,12 @@
 #include "migration/vmstate.h"
 #include "trace.h"
 #include "hw/qdev-properties.h"
+#include "target/loongarch/cpu.h"
+
+/* msg addr field */
+FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
+FIELD(MSG_ADDR, CPU_NUM, 12, 8)
+FIELD(MSG_ADDR, FIX, 28, 12)
 
 static uint64_t loongarch_avec_mem_read(void *opaque,
                                         hwaddr addr, unsigned size)
@@ -23,12 +29,33 @@ static uint64_t loongarch_avec_mem_read(void *opaque,
     return 0;
 }
 
+static void avec_set_irq(LoongArchAVECState *s, int cpu_num, int irq_num, int level)
+{
+   MachineState *machine = MACHINE(qdev_get_machine());
+   MachineClass *mc = MACHINE_GET_CLASS(machine);
+   const CPUArchIdList *id_list = NULL;
+   assert(mc->possible_cpu_arch_ids(machine));
+   id_list = mc->possible_cpu_arch_ids(machine);
+   CPUState *cpu = id_list->cpus[cpu_num].cpu;
+   CPULoongArchState *env = &LOONGARCH_CPU(cpu)->env;
+
+   set_bit(irq_num, &env->CSR_MSGIS[irq_num / 64]);
+   qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
+   env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, INTNUM, irq_num);
+   env->CSR_MSGIR = FIELD_DP64(env->CSR_MSGIR, CSR_MSGIR, ACTIVE, 0);
+}
+
 static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
                                      uint64_t val, unsigned size)
 {
-    return;
-}
+    int irq_num, cpu_num = 0;
+    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
+    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
 
+    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
+    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
+    avec_set_irq(s, cpu_num, irq_num, 1);
+}
 
 static const MemoryRegionOps loongarch_avec_ops = {
     .read = loongarch_avec_mem_read,
-- 
2.34.1


