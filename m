Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D570B512A5
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 11:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHFF-0003jz-9T; Wed, 10 Sep 2025 05:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwHEt-0003es-Ch
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwHEe-0007eG-2K
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:42 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxaNFbRsFoe8EIAA--.18810S3;
 Wed, 10 Sep 2025 17:35:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxE+RWRsFoj8+LAA--.52579S9;
 Wed, 10 Sep 2025 17:35:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v7 07/11] hw/loongarch: Implement avec controller imput and
 output pins
Date: Wed, 10 Sep 2025 17:11:46 +0800
Message-Id: <20250910091150.2424979-8-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250910091150.2424979-1-gaosong@loongson.cn>
References: <20250910091150.2424979-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+RWRsFoj8+LAA--.52579S9
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

the AVEC controller supports 256*256 irqs input, all the irqs connect CPU INT_AVEC irq

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 20 ++++++++++++++++++++
 target/loongarch/cpu.h   |  3 ++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index 253bab5461..1f9f376898 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -38,7 +38,12 @@ static const MemoryRegionOps loongarch_avec_ops = {
 
 static void loongarch_avec_realize(DeviceState *dev, Error **errp)
 {
+    LoongArchAVECState *s = LOONGARCH_AVEC(dev);
     LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList  *id_list;
+    int i;
 
     Error *local_err = NULL;
     lac->parent_realize(dev, &local_err);
@@ -47,6 +52,21 @@ static void loongarch_avec_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    assert(mc->possible_cpu_arch_ids);
+    id_list = mc->possible_cpu_arch_ids(machine);
+    s->num_cpu = id_list->len;
+    s->cpu = g_new(AVECCore, s->num_cpu);
+    if (s->cpu == NULL) {
+        error_setg(errp, "Memory allocation for AVECCore fail");
+        return;
+    }
+
+    for (i = 0; i < s->num_cpu; i++) {
+        s->cpu[i].arch_id = id_list->cpus[i].arch_id;
+        s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
+        qdev_init_gpio_out(dev, &s->cpu[i].parent_irq, 1);
+    }
+
     return;
 }
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 807a710810..91261bab98 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -217,9 +217,10 @@ FIELD(CSR_CRMD, WE, 9, 1)
 extern const char * const regnames[32];
 extern const char * const fregnames[32];
 
-#define N_IRQS      13
+#define N_IRQS      15
 #define IRQ_TIMER   11
 #define IRQ_IPI     12
+#define INT_AVEC    14
 
 #define LOONGARCH_STLB         2048 /* 2048 STLB */
 #define LOONGARCH_MTLB         64   /* 64 MTLB */
-- 
2.41.0


