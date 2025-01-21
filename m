Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8E8A175FF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Jan 2025 03:39:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta491-000794-MX; Mon, 20 Jan 2025 21:37:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ta48y-00077l-4r
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:37:32 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ta48u-00051h-IH
 for qemu-devel@nongnu.org; Mon, 20 Jan 2025 21:37:31 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxCeFkCI9nRptmAA--.4262S3;
 Tue, 21 Jan 2025 10:37:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXcdjCI9nwZopAA--.24032S3;
 Tue, 21 Jan 2025 10:37:24 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/intc/loongarch_ipi: Add basic hotplug framework
Date: Tue, 21 Jan 2025 10:37:21 +0800
Message-Id: <20250121023723.153876-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250121023723.153876-1-maobibo@loongson.cn>
References: <20250121023723.153876-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXcdjCI9nwZopAA--.24032S3
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

LoongArch ipi can send interrupt to multiple CPUs, interrupt routing
to CPU comes from destination physical cpu id. Here hotplug interface
is added for IPI object, so that parent irq line can be connected, and
routing table can be added for new created cpu.

Here only basic hotplug framework is added, it is stub function.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 5376f1e084..90bbb7ac6e 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -6,6 +6,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
@@ -76,9 +77,34 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_ipi_cpu_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch extioi: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+}
+
+static void loongarch_ipi_cpu_unplug(HotplugHandler *hotplug_dev,
+                                     DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+
+    if (!object_dynamic_cast(obj, TYPE_LOONGARCH_CPU)) {
+        warn_report("LoongArch extioi: Invalid %s device type",
+                                       object_get_typename(obj));
+        return;
+    }
+}
+
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
     LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
@@ -86,6 +112,8 @@ static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
                                     &lic->parent_realize);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
+    hc->plug = loongarch_ipi_cpu_plug;
+    hc->unplug = loongarch_ipi_cpu_unplug;
 }
 
 static const TypeInfo loongarch_ipi_types[] = {
@@ -95,6 +123,10 @@ static const TypeInfo loongarch_ipi_types[] = {
         .instance_size      = sizeof(LoongarchIPIState),
         .class_size         = sizeof(LoongarchIPIClass),
         .class_init         = loongarch_ipi_class_init,
+        .interfaces         = (InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        },
     }
 };
 
-- 
2.39.3


