Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D569F76C2
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 09:09:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBZn-0007KV-Py; Thu, 19 Dec 2024 03:08:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tOBZk-0007JF-Ca
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:08:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tOBZh-0007uq-Ma
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 03:08:04 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxGeBc1GNnBXpYAA--.41799S3;
 Thu, 19 Dec 2024 16:07:56 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBx38da1GNnCCwCAA--.13753S2;
 Thu, 19 Dec 2024 16:07:54 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 15/18] hw/intc/loongarch_extioi: Add common file
 loongarch_extioi_common
Date: Thu, 19 Dec 2024 16:07:50 +0800
Message-Id: <20241219080753.3164733-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219075502.3164644-1-maobibo@loongson.cn>
References: <20241219075502.3164644-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBx38da1GNnCCwCAA--.13753S2
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

Add new common file loongarch_extioi_common.c, and move vmstate
and property structure to common file.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c        | 59 +----------------------------
 hw/intc/loongarch_extioi_common.c | 63 +++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 57 deletions(-)
 create mode 100644 hw/intc/loongarch_extioi_common.c

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index d759b7f57d..d7471ff165 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -318,15 +318,8 @@ static const MemoryRegionOps extioi_virt_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)dev;
-
-    if (s->num_cpu == 0) {
-        error_setg(errp, "num-cpu must be at least 1");
-        return;
-    }
-}
+static int vmstate_extioi_post_load(void *opaque, int version_id);
+#include "loongarch_extioi_common.c"
 
 static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
@@ -403,54 +396,6 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static int loongarch_extioi_common_post_load(void *opaque, int version_id)
-{
-    return vmstate_extioi_post_load(opaque, version_id);
-}
-
-static const VMStateDescription vmstate_extioi_core = {
-    .name = "extioi-core",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(coreisr, ExtIOICore, EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const VMStateDescription vmstate_loongarch_extioi = {
-    .name = "loongarch.extioi",
-    .version_id = 3,
-    .minimum_version_id = 3,
-    .post_load = loongarch_extioi_common_post_load,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_GROUP_COUNT),
-        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_NODETYPE_COUNT / 2),
-        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 32),
-        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS_IPMAP_SIZE / 4),
-        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOICommonState,
-                             EXTIOI_IRQS / 4),
-        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOICommonState,
-                             num_cpu, vmstate_extioi_core, ExtIOICore),
-        VMSTATE_UINT32(features, LoongArchExtIOICommonState),
-        VMSTATE_UINT32(status, LoongArchExtIOICommonState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
-static const Property extioi_properties[] = {
-    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
-    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
-                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
new file mode 100644
index 0000000000..6c8366a5e5
--- /dev/null
+++ b/hw/intc/loongarch_extioi_common.c
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Loongson extioi interrupt controller emulation
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)dev;
+
+    if (s->num_cpu == 0) {
+        error_setg(errp, "num-cpu must be at least 1");
+        return;
+    }
+}
+
+static int loongarch_extioi_common_post_load(void *opaque, int version_id)
+{
+    return vmstate_extioi_post_load(opaque, version_id);
+}
+
+static const VMStateDescription vmstate_extioi_core = {
+    .name = "extioi-core",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(coreisr, ExtIOICore, EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_loongarch_extioi = {
+    .name = "loongarch.extioi",
+    .version_id = 3,
+    .minimum_version_id = 3,
+    .post_load = loongarch_extioi_common_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(bounce, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_GROUP_COUNT),
+        VMSTATE_UINT32_ARRAY(nodetype, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_NODETYPE_COUNT / 2),
+        VMSTATE_UINT32_ARRAY(enable, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(isr, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 32),
+        VMSTATE_UINT32_ARRAY(ipmap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS_IPMAP_SIZE / 4),
+        VMSTATE_UINT32_ARRAY(coremap, LoongArchExtIOICommonState,
+                             EXTIOI_IRQS / 4),
+        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, LoongArchExtIOICommonState,
+                             num_cpu, vmstate_extioi_core, ExtIOICore),
+        VMSTATE_UINT32(features, LoongArchExtIOICommonState),
+        VMSTATE_UINT32(status, LoongArchExtIOICommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const Property extioi_properties[] = {
+    DEFINE_PROP_UINT32("num-cpu", LoongArchExtIOICommonState, num_cpu, 1),
+    DEFINE_PROP_BIT("has-virtualization-extension", LoongArchExtIOICommonState,
+                    features, EXTIOI_HAS_VIRT_EXTENSION, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
-- 
2.43.5


