Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC529AE007B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 10:53:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSAzV-0004Qx-2Y; Thu, 19 Jun 2025 04:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uSAzQ-0004PQ-1H
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:20 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uSAzM-0002we-IZ
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 04:51:19 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxYa99z1NofLUZAQ--.18724S3;
 Thu, 19 Jun 2025 16:51:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMAxDcVtz1NohtwgAQ--.30176S5;
 Thu, 19 Jun 2025 16:51:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 03/14] hw/intc/loongarch_ipi: Add kernel irqchip realize
 function
Date: Thu, 19 Jun 2025 16:28:06 +0800
Message-Id: <20250619082817.1517996-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619082817.1517996-1-gaosong@loongson.cn>
References: <20250619082817.1517996-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxDcVtz1NohtwgAQ--.30176S5
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

From: Bibo Mao <maobibo@loongson.cn>

Function kvm_ipi_realize() is added if kvm_irqchip_in_kernel() return true.
It is to create and initialize IPI device in kernel mode.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20250606063033.2557365-4-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c         |  5 +++++
 hw/intc/loongarch_ipi_kvm.c     | 27 +++++++++++++++++++++++++++
 hw/intc/loongson_ipi_common.c   |  5 +++++
 hw/intc/meson.build             |  2 ++
 include/hw/intc/loongarch_ipi.h |  3 +++
 5 files changed, 42 insertions(+)
 create mode 100644 hw/intc/loongarch_ipi_kvm.c

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 74372a2039..159ba91fb6 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -11,6 +11,7 @@
 #include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "hw/qdev-properties.h"
+#include "system/kvm.h"
 #include "target/loongarch/cpu.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
@@ -91,6 +92,10 @@ static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
         lics->cpu[i].ipi = lics;
         qdev_init_gpio_out(dev, &lics->cpu[i].irq, 1);
     }
+
+    if (kvm_irqchip_in_kernel()) {
+        kvm_ipi_realize(dev, errp);
+    }
 }
 
 static void loongarch_ipi_reset_hold(Object *obj, ResetType type)
diff --git a/hw/intc/loongarch_ipi_kvm.c b/hw/intc/loongarch_ipi_kvm.c
new file mode 100644
index 0000000000..51e9c7ed1e
--- /dev/null
+++ b/hw/intc/loongarch_ipi_kvm.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch IPI interrupt KVM support
+ *
+ * Copyright (C) 2025 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/intc/loongarch_ipi.h"
+#include "system/kvm.h"
+#include "target/loongarch/cpu.h"
+
+void kvm_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongarchIPIState *lis = LOONGARCH_IPI(dev);
+    int ret;
+
+    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_IPI, false);
+    if (ret < 0) {
+        fprintf(stderr, "IPI KVM_CREATE_DEVICE failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+
+    lis->dev_fd = ret;
+}
diff --git a/hw/intc/loongson_ipi_common.c b/hw/intc/loongson_ipi_common.c
index f32661c40f..ff2cc8bc91 100644
--- a/hw/intc/loongson_ipi_common.c
+++ b/hw/intc/loongson_ipi_common.c
@@ -11,6 +11,7 @@
 #include "hw/irq.h"
 #include "qemu/log.h"
 #include "migration/vmstate.h"
+#include "system/kvm.h"
 #include "trace.h"
 
 MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
@@ -255,6 +256,10 @@ static void loongson_ipi_common_realize(DeviceState *dev, Error **errp)
     LoongsonIPICommonState *s = LOONGSON_IPI_COMMON(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
+    if (kvm_irqchip_in_kernel()) {
+        return;
+    }
+
     memory_region_init_io(&s->ipi_iocsr_mem, OBJECT(dev),
                           &loongson_ipi_iocsr_ops,
                           s, "loongson_ipi_iocsr", 0x48);
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 70e7548c52..1cc999771d 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -71,6 +71,8 @@ specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
+specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_IPI'],
+                if_true: files('loongarch_ipi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index a7c6bf85d3..608cd09a78 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -16,6 +16,7 @@ OBJECT_DECLARE_TYPE(LoongarchIPIState, LoongarchIPIClass, LOONGARCH_IPI)
 
 struct LoongarchIPIState {
     LoongsonIPICommonState parent_obj;
+    int  dev_fd;
 };
 
 struct LoongarchIPIClass {
@@ -24,4 +25,6 @@ struct LoongarchIPIClass {
     ResettablePhases parent_phases;
 };
 
+void kvm_ipi_realize(DeviceState *dev, Error **errp);
+
 #endif
-- 
2.47.0


