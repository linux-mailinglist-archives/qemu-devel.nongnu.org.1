Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554AAB1014
	for <lists+qemu-devel@lfdr.de>; Fri,  9 May 2025 12:13:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKiq-0002Kx-Io; Fri, 09 May 2025 06:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKio-0002Iv-HM
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:50 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKim-0001g8-4S
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:12:50 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxG6wd1R1oG2XbAA--.65268S3;
 Fri, 09 May 2025 18:12:45 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMBxXsUd1R1oACrAAA--.30666S2;
 Fri, 09 May 2025 18:12:45 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 11/15] hw/intc/loongarch_pch: Add irqchip-in-kernel realize
 function
Date: Fri,  9 May 2025 18:12:41 +0800
Message-Id: <20250509101245.1070255-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509100747.1070094-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxXsUd1R1oACrAAA--.30666S2
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

Function kvm_loongarch_pic_realize() is added if irqchip-in-kernel
property is enabled. It is to notify KVM kernel to create PCH PCI device
in kernel mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c         |  4 +++
 hw/intc/loongarch_pic_kvm.c         | 38 +++++++++++++++++++++++++++++
 hw/intc/meson.build                 |  2 ++
 include/hw/intc/loongarch_pch_pic.h |  3 +++
 4 files changed, 47 insertions(+)
 create mode 100644 hw/intc/loongarch_pic_kvm.c

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 3729ab9700..481a303cc1 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -287,6 +287,10 @@ static void loongarch_pic_realize(DeviceState *dev, Error **errp)
                           &loongarch_pch_pic_ops,
                           s, TYPE_LOONGARCH_PIC, VIRT_PCH_REG_SIZE);
     sysbus_init_mmio(sbd, &s->iomem);
+
+    if (kvm_enabled() && lps->irqchip_in_kernel) {
+        kvm_loongarch_pic_realize(dev, errp);
+    }
 }
 
 static const Property loongarch_pic_properties[] = {
diff --git a/hw/intc/loongarch_pic_kvm.c b/hw/intc/loongarch_pic_kvm.c
new file mode 100644
index 0000000000..696dabb0b2
--- /dev/null
+++ b/hw/intc/loongarch_pic_kvm.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * LoongArch kvm pch pic interrupt support
+ *
+ * Copyright (C) 2024 Loongson Technology Corporation Limited
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
+#include "hw/intc/loongarch_pch_pic.h"
+#include "hw/loongarch/virt.h"
+#include "hw/pci-host/ls7a.h"
+#include "system/kvm.h"
+
+void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp)
+{
+    LoongarchPICState *lps = LOONGARCH_PIC(dev);
+    uint64_t pch_pic_base = VIRT_PCH_REG_BASE;
+    int ret;
+
+    ret = kvm_create_device(kvm_state, KVM_DEV_TYPE_LOONGARCH_PCHPIC, false);
+    if (ret < 0) {
+        fprintf(stderr, "Create KVM_LOONGARCH_PCHPIC failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+
+    lps->dev_fd = ret;
+    ret = kvm_device_access(lps->dev_fd, KVM_DEV_LOONGARCH_PCH_PIC_GRP_CTRL,
+                            KVM_DEV_LOONGARCH_PCH_PIC_CTRL_INIT,
+                            &pch_pic_base, true, NULL);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_LOONGARCH_PCH_PIC_INIT failed: %s\n",
+                strerror(-ret));
+        abort();
+    }
+}
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 1cc999771d..3137521a4a 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -74,6 +74,8 @@ specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_IPI'],
                 if_true: files('loongarch_ipi_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_PIC', if_true: files('loongarch_pch_pic.c', 'loongarch_pic_common.c'))
+specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_PCH_PIC'],
+                if_true: files('loongarch_pic_kvm.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_PCH_MSI', if_true: files('loongarch_pch_msi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_EXTIOI', if_true: files('loongarch_extioi.c', 'loongarch_extioi_common.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_LOONGARCH_EXTIOI'],
diff --git a/include/hw/intc/loongarch_pch_pic.h b/include/hw/intc/loongarch_pch_pic.h
index 40fe550c0b..91a20dd624 100644
--- a/include/hw/intc/loongarch_pch_pic.h
+++ b/include/hw/intc/loongarch_pch_pic.h
@@ -17,6 +17,7 @@ OBJECT_DECLARE_TYPE(LoongarchPICState, LoongarchPICClass, LOONGARCH_PIC)
 struct LoongarchPICState {
     LoongArchPICCommonState parent_obj;
     bool irqchip_in_kernel;
+    int dev_fd;
 };
 
 struct LoongarchPICClass {
@@ -26,4 +27,6 @@ struct LoongarchPICClass {
     ResettablePhases parent_phases;
 };
 
+void kvm_loongarch_pic_realize(DeviceState *dev, Error **errp);
+
 #endif /* HW_LOONGARCH_PCH_PIC_H */
-- 
2.39.3


