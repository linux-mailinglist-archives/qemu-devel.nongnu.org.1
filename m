Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B469F083F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Dec 2024 10:42:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM2AC-0001ZH-D0; Fri, 13 Dec 2024 04:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tM2A8-0001Yd-Ct
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:40:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tM2A5-0006cf-AQ
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 04:40:44 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxIK8SAVxnsolWAA--.13530S3;
 Fri, 13 Dec 2024 17:40:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxDuELAVxnQ8aBAA--.54481S7;
 Fri, 13 Dec 2024 17:40:33 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PULL 05/18] hw/intc/loongarch_pch: Move some functions to file
 loongarch_pic_common
Date: Fri, 13 Dec 2024 17:40:14 +0800
Message-Id: <20241213094027.1732484-6-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241213094027.1732484-1-maobibo@loongson.cn>
References: <20241213094027.1732484-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxDuELAVxnQ8aBAA--.54481S7
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

Move some common functions to file loongarch_pic_common.c, the common
functions include loongarch_pic_common_realize(), property structure
loongarch_pic_common_properties and vmstate structure
vmstate_loongarch_pic_common.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c    | 37 +-----------------------------
 hw/intc/loongarch_pic_common.c | 41 ++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 36 deletions(-)
 create mode 100644 hw/intc/loongarch_pic_common.c

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 64f30d8916..25c612b366 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -379,16 +379,7 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     s->int_polarity = 0x0;
 }
 
-static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
-{
-    LoongArchPICCommonState *s = LOONGARCH_PCH_PIC(dev);
-
-    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
-        error_setg(errp, "Invalid 'pic_irq_num'");
-        return;
-    }
-}
-
+#include "loongarch_pic_common.c"
 static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(dev);
@@ -417,32 +408,6 @@ static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 
 }
 
-static Property loongarch_pic_common_properties[] = {
-    DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static const VMStateDescription vmstate_loongarch_pic_common = {
-    .name = "loongarch_pch_pic",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(int_mask, LoongArchPICCommonState),
-        VMSTATE_UINT64(htmsi_en, LoongArchPICCommonState),
-        VMSTATE_UINT64(intedge, LoongArchPICCommonState),
-        VMSTATE_UINT64(intclr, LoongArchPICCommonState),
-        VMSTATE_UINT64(auto_crtl0, LoongArchPICCommonState),
-        VMSTATE_UINT64(auto_crtl1, LoongArchPICCommonState),
-        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPICCommonState, 64),
-        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPICCommonState, 64),
-        VMSTATE_UINT64(last_intirr, LoongArchPICCommonState),
-        VMSTATE_UINT64(intirr, LoongArchPICCommonState),
-        VMSTATE_UINT64(intisr, LoongArchPICCommonState),
-        VMSTATE_UINT64(int_polarity, LoongArchPICCommonState),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static void loongarch_pch_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
diff --git a/hw/intc/loongarch_pic_common.c b/hw/intc/loongarch_pic_common.c
new file mode 100644
index 0000000000..c8e0490d40
--- /dev/null
+++ b/hw/intc/loongarch_pic_common.c
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Loongson 7A1000 I/O interrupt controller.
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PCH_PIC(dev);
+
+    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
+        error_setg(errp, "Invalid 'pic_irq_num'");
+        return;
+    }
+}
+
+static Property loongarch_pic_common_properties[] = {
+    DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static const VMStateDescription vmstate_loongarch_pic_common = {
+    .name = "loongarch_pch_pic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64(int_mask, LoongArchPICCommonState),
+        VMSTATE_UINT64(htmsi_en, LoongArchPICCommonState),
+        VMSTATE_UINT64(intedge, LoongArchPICCommonState),
+        VMSTATE_UINT64(intclr, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl0, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl1, LoongArchPICCommonState),
+        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPICCommonState, 64),
+        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPICCommonState, 64),
+        VMSTATE_UINT64(last_intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intisr, LoongArchPICCommonState),
+        VMSTATE_UINT64(int_polarity, LoongArchPICCommonState),
+        VMSTATE_END_OF_LIST()
+    }
+};
-- 
2.43.5


