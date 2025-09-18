Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA1B512A4
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 11:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwHFK-0003nP-MR; Wed, 10 Sep 2025 05:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwHEs-0003ek-2F
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:47 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwHEg-0007e6-BY
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 05:35:41 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx379aRsFodcEIAA--.17339S3;
 Wed, 10 Sep 2025 17:35:22 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJAxE+RWRsFoj8+LAA--.52579S6;
 Wed, 10 Sep 2025 17:35:22 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v7 04/11] loongarch: add a advance interrupt controller device
Date: Wed, 10 Sep 2025 17:11:43 +0800
Message-Id: <20250910091150.2424979-5-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250910091150.2424979-1-gaosong@loongson.cn>
References: <20250910091150.2424979-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+RWRsFoj8+LAA--.52579S6
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

Add Loongarch advance interrupt controller device base Definition.

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/Kconfig                  |  3 ++
 hw/intc/loongarch_avec.c         | 68 ++++++++++++++++++++++++++++++++
 hw/intc/meson.build              |  1 +
 hw/loongarch/Kconfig             |  1 +
 include/hw/intc/loongarch_avec.h | 35 ++++++++++++++++
 5 files changed, 108 insertions(+)
 create mode 100644 hw/intc/loongarch_avec.c
 create mode 100644 include/hw/intc/loongarch_avec.h

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 7547528f2c..b9266dc269 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -109,3 +109,6 @@ config LOONGARCH_PCH_MSI
 
 config LOONGARCH_EXTIOI
     bool
+
+config LOONGARCH_AVEC
+    bool
diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
new file mode 100644
index 0000000000..5a3e7ecc03
--- /dev/null
+++ b/hw/intc/loongarch_avec.c
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Loongson  Advance interrupt controller.
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/irq.h"
+#include "hw/intc/loongarch_pch_msi.h"
+#include "hw/intc/loongarch_pch_pic.h"
+#include "hw/intc/loongarch_avec.h"
+#include "hw/pci/msi.h"
+#include "hw/misc/unimp.h"
+#include "migration/vmstate.h"
+#include "trace.h"
+#include "hw/qdev-properties.h"
+
+
+static void loongarch_avec_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchAVECClass *lac = LOONGARCH_AVEC_GET_CLASS(dev);
+
+    Error *local_err = NULL;
+    lac->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    return;
+}
+
+static void loongarch_avec_unrealize(DeviceState *dev)
+{
+    return;
+}
+
+static void loongarch_avec_init(Object *obj)
+{
+    return;
+}
+
+static void loongarch_avec_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    LoongArchAVECClass *lac = LOONGARCH_AVEC_CLASS(klass);
+
+    dc->unrealize = loongarch_avec_unrealize;
+    device_class_set_parent_realize(dc, loongarch_avec_realize,
+                                    &lac->parent_realize);
+}
+
+static const TypeInfo loongarch_avec_info = {
+    .name          = TYPE_LOONGARCH_AVEC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(LoongArchAVECState),
+    .instance_init = loongarch_avec_init,
+    .class_init    = loongarch_avec_class_init,
+};
+
+static void loongarch_avec_register_types(void)
+{
+    type_register_static(&loongarch_avec_info);
+}
+
+type_init(loongarch_avec_register_types)
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 3efb276b6e..6aae4bbe53 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -80,3 +80,4 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
                if_true: files('loongarch_extioi_kvm.c'))
+specific_ss.add(when: 'CONFIG_LOONGARCH_AVEC', if_true: files('loongarch_avec.c'))
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index bb2838b7b5..1bf240b1e2 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -15,6 +15,7 @@ config LOONGARCH_VIRT
     select LOONGARCH_PCH_PIC
     select LOONGARCH_PCH_MSI
     select LOONGARCH_EXTIOI
+    select LOONGARCH_AVEC
     select LS7A_RTC
     select SMBIOS
     select ACPI_CPU_HOTPLUG
diff --git a/include/hw/intc/loongarch_avec.h b/include/hw/intc/loongarch_avec.h
new file mode 100644
index 0000000000..92e2ca9590
--- /dev/null
+++ b/include/hw/intc/loongarch_avec.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch  Advance interrupt controller definitions
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/loongarch/virt.h"
+
+
+#define NR_VECTORS     256
+
+#define TYPE_LOONGARCH_AVEC "loongarch_avec"
+OBJECT_DECLARE_TYPE(LoongArchAVECState, LoongArchAVECClass, LOONGARCH_AVEC)
+
+typedef struct AVECCore {
+    CPUState *cpu;
+    qemu_irq parent_irq;
+    uint64_t arch_id;
+} AVECCore;
+
+struct LoongArchAVECState {
+    SysBusDevice parent_obj;
+    AVECCore *cpu;
+    uint32_t num_cpu;
+};
+
+struct LoongArchAVECClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
+};
-- 
2.41.0


