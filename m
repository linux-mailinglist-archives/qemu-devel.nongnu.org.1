Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C584A1312F
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 03:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS6-0004cy-Qk; Wed, 15 Jan 2025 21:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFRz-0004bB-Um
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRx-0006Cx-Gh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:39 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeA+bIhndzJkAA--.44723S3;
 Thu, 16 Jan 2025 10:17:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S7;
 Thu, 16 Jan 2025 10:17:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 5/8] hw/intc/loongarch_ipi: Get cpu number from
 possible_cpu_arch_ids
Date: Thu, 16 Jan 2025 10:17:07 +0800
Message-Id: <20250116021710.251648-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S7
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

Supported CPU number can be acquired from function
possible_cpu_arch_ids(), cpu-num property is not necessary and can
be removed.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c               | 13 ++++++++-----
 include/hw/intc/loongson_ipi_common.h |  2 ++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 9c7636c4d6..49b4595d90 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -55,6 +55,9 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
 {
     LoongsonIPICommonState *lics = LOONGSON_IPI_COMMON(dev);
     LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const CPUArchIdList *id_list;
     Error *local_err = NULL;
     int i;
 
@@ -64,13 +67,13 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (lics->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-
+    assert(mc->possible_cpu_arch_ids);
+    id_list = mc->possible_cpu_arch_ids(machine);
+    lics->num_cpu = id_list->len;
     lics->cpu = g_new0(IPICore, lics->num_cpu);
     for (i = 0; i < lics->num_cpu; i++) {
+        lics->cpu[i].arch_id = id_list->cpus[i].arch_id;
+        lics->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
         lics->cpu[i].ipi = lics;
         qdev_init_gpio_out(dev, &lics->cpu[i].irq, 1);
     }
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index df9d9c5168..4192f3d548 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -27,6 +27,8 @@ typedef struct IPICore {
     /* 64bit buf divide into 2 32-bit buf */
     uint32_t buf[IPI_MBX_NUM * 2];
     qemu_irq irq;
+    uint64_t arch_id;
+    CPUState *cpu;
 } IPICore;
 
 struct LoongsonIPICommonState {
-- 
2.43.5


