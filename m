Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15DA2E7F7
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Feb 2025 10:38:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQDh-0003wJ-Rn; Mon, 10 Feb 2025 04:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1thQDe-0003vl-5Z
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:36:46 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1thQDa-0001xA-D4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 04:36:45 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxHHKjyKlnmhtxAA--.194S3;
 Mon, 10 Feb 2025 17:36:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxn8WgyKlnqwUKAA--.39266S6;
 Mon, 10 Feb 2025 17:36:34 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/7] hw/intc/loongarch_extioi: Move gpio irq initial to
 common code
Date: Mon, 10 Feb 2025 17:36:29 +0800
Message-Id: <20250210093632.3274012-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250210093632.3274012-1-maobibo@loongson.cn>
References: <20250210093632.3274012-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8WgyKlnqwUKAA--.39266S6
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

When cpu is added, it will connect gpio irq line to cpu irq.
And cpu hot-add is put in common code, move gpio irq initial
part into common code.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c        | 8 +-------
 hw/intc/loongarch_extioi_common.c | 6 +++++-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index f3055ec4d2..a51a215e6e 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -343,7 +343,7 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
-    int i, pin;
+    int i;
 
     lec->parent_realize(dev, &local_err);
     if (local_err) {
@@ -368,12 +368,6 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     } else {
         s->status |= BIT(EXTIOI_ENABLE);
     }
-
-    for (i = 0; i < s->num_cpu; i++) {
-        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
-            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[pin], 1);
-        }
-    }
 }
 
 static void loongarch_extioi_unrealize(DeviceState *dev)
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index fd56253d10..e3a38b318a 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -16,7 +16,7 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     MachineState *machine = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     const CPUArchIdList *id_list;
-    int i;
+    int i, pin;
 
     assert(mc->possible_cpu_arch_ids);
     id_list = mc->possible_cpu_arch_ids(machine);
@@ -30,6 +30,10 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < s->num_cpu; i++) {
         s->cpu[i].arch_id = id_list->cpus[i].arch_id;
         s->cpu[i].cpu = CPU(id_list->cpus[i].cpu);
+
+        for (pin = 0; pin < LS3A_INTC_IP; pin++) {
+            qdev_init_gpio_out(dev, &s->cpu[i].parent_irq[pin], 1);
+        }
     }
 }
 
-- 
2.39.3


