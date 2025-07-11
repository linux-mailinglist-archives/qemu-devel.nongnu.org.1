Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7942B017A2
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 11:27:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9zc-0002Dm-HC; Fri, 11 Jul 2025 05:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1ua9xi-0000D7-6i
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:22:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1ua9xb-0003s5-IW
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 05:22:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxLOLF13BotB8nAQ--.41723S3;
 Fri, 11 Jul 2025 17:22:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJCxdOS813Bo5owSAA--.39837S13;
 Fri, 11 Jul 2025 17:22:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v5 11/11] hw/loongarch: Implement AVEC plug/unplug interfaces
Date: Fri, 11 Jul 2025 16:59:15 +0800
Message-Id: <20250711085915.3042395-12-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250711085915.3042395-1-gaosong@loongson.cn>
References: <20250711085915.3042395-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxdOS813Bo5owSAA--.39837S13
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

when cpu added, connect avec irq to cpu INT_AVEC irq pin.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_avec.c | 71 ++++++++++++++++++++++++++++++++++++++++
 hw/loongarch/virt.c      | 11 +++++++
 2 files changed, 82 insertions(+)

diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
index af6c75c4a9..820d6655ef 100644
--- a/hw/intc/loongarch_avec.c
+++ b/hw/intc/loongarch_avec.c
@@ -116,14 +116,81 @@ static void loongarch_avec_init(Object *obj)
     return;
 }
 
+static AVECCore *loongarch_avec_get_cpu(LoongArchAVECState *s,
+                                        DeviceState *dev)
+{
+    CPUClass *k = CPU_GET_CLASS(dev);
+    uint64_t arch_id = k->get_arch_id(CPU(dev));
+    int i;
+
+    for (i = 0; i < s->num_cpu; i++) {
+        if (s->cpu[i].arch_id == arch_id) {
+            return &s->cpu[i];
+        }
+    }
+
+    return NULL;
+}
+
+static void loongarch_avec_cpu_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    AVECCore *core;
+    int index;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch AVEC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+    core = loongarch_avec_get_cpu(s, dev);
+    if (!core) {
+        return;
+    }
+
+    core->cpu = CPU(dev);
+    index = core - s->cpu;
+
+    /* connect avec msg irq to cpu irq */
+    qdev_connect_gpio_out(DEVICE(s), index, qdev_get_gpio_in(dev, INT_AVEC));
+    return;
+}
+
+static void loongarch_avec_cpu_unplug(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    LoongArchAVECState *s = LOONGARCH_AVEC(hotplug_dev);
+    Object *obj = OBJECT(dev);
+    AVECCore *core;
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch AVEC: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+
+    core = loongarch_avec_get_cpu(s, dev);
+
+    if (!core) {
+        return;
+    }
+
+    core->cpu = NULL;
+}
+
 static void loongarch_avec_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongArchAVECClass *lac = LOONGARCH_AVEC_CLASS(klass);
 
     dc->unrealize = loongarch_avec_unrealize;
     device_class_set_parent_realize(dc, loongarch_avec_realize,
                                     &lac->parent_realize);
+    hc->plug = loongarch_avec_cpu_plug;
+    hc->unplug = loongarch_avec_cpu_unplug;
 }
 
 static const TypeInfo loongarch_avec_info = {
@@ -132,6 +199,10 @@ static const TypeInfo loongarch_avec_info = {
     .instance_size = sizeof(LoongArchAVECState),
     .instance_init = loongarch_avec_init,
     .class_init    = loongarch_avec_class_init,
+    .interfaces    = (const InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
 };
 
 static void loongarch_avec_register_types(void)
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index e3ab165cc5..7ea9b58f15 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -377,6 +377,10 @@ static void virt_cpu_irq_init(LoongArchVirtMachineState *lvms)
                              &error_abort);
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), DEVICE(cs),
                              &error_abort);
+        if (lvms->avec) {
+            hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), DEVICE(cs),
+                                 &error_abort);
+        }
     }
 }
 
@@ -1088,6 +1092,9 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
     /* Notify ipi and extioi irqchip to remove interrupt routing to CPU */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->ipi), dev, &error_abort);
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
+    if (lvms->avec) {
+        hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
+    }
 
     /* Notify acpi ged CPU removed */
     hotplug_handler_unplug(HOTPLUG_HANDLER(lvms->acpi_ged), dev, &error_abort);
@@ -1111,6 +1118,10 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->extioi), dev, &error_abort);
     }
 
+    if (lvms->avec) {
+        hotplug_handler_plug(HOTPLUG_HANDLER(lvms->avec), dev, &error_abort);
+    }
+
     if (lvms->acpi_ged) {
         hotplug_handler_plug(HOTPLUG_HANDLER(lvms->acpi_ged), dev,
                              &error_abort);
-- 
2.34.1


