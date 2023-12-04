Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3580298D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:36:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wnr-0004qv-5l; Sun, 03 Dec 2023 19:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnR-0004YC-G7; Sun, 03 Dec 2023 19:26:56 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnL-00009U-8W; Sun, 03 Dec 2023 19:26:49 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5d4f71f7e9fso24240317b3.0; 
 Sun, 03 Dec 2023 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649601; x=1702254401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFeuloyQQG/pWB1qNvNMADuHoBFz7/WggqgaHUnwlWg=;
 b=e/ZBryg1JikJ+RSrg+aymvJeaoRhP282WxYxGSZgd+tQ+/eteOeYYBz7MtsMgPx0Pr
 KPbthe4gRayTIW23ZWNLvHxULRhYNzjTcsfJNHu9lHCtyfgOP40AGY7brs1e7alYYDgu
 AzM3d7Ea/hqsJJsDblzJiCr3wNv4oSwOnYKtdcWQkcuJfN/HsOX7RyadUYcTw0kQRs5N
 W6KSvR3Wn+4Simy3fXWRGY+azmGZl5bbtySPz9cRrRty0JXCvXJGyalT5Qzm+1bv6I/T
 bOQY5MQmjzPsyMlkvhFdEFk/Z8knDcrNk6imIu0wTNL6SvJ5lWzDCUtIIQ6Yf94rR02e
 hUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649601; x=1702254401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFeuloyQQG/pWB1qNvNMADuHoBFz7/WggqgaHUnwlWg=;
 b=CFVDjSf9Y4GqLdfY6utUw3+TgnSgl9nB9WMH49FIW38ZOKIj44NcY4od4aZvhTpCm1
 2APsFsK+9kKNDv/VZQnXjX5/5Cg5KbFgh1A3cNnJ0tqwl/JiahI6clalaLmL3GNdR0+V
 NNVHZAgF7sY2Ren5eEbaj1ubBgChH9Fbm8sFIyVkrAp8PxEWzjxQn9MKtt/YcCc0sQBc
 d2DQ5qrgxyJjHFVSGWz/c0KPuSgarPmQ8RxznptEjhLdFsPg2Vn5ecV+WamGoGoORPoN
 8TUvNFTi4A14QAFt+f9i5+RY0IwRf0LrKam4linOCcmUT/VUojGCp898iM8qp7Rns8gX
 zkmw==
X-Gm-Message-State: AOJu0YwO2ISQgitd93LOl2zzHLya5PHusNCsagB+o6KT2/CR4vgIibFC
 xjwkJ5UnECkwZLcWFyIRjDof/Q/jf87mJg==
X-Google-Smtp-Source: AGHT+IH+OSTHKOQJTSP1ZjkE+mKmmuK2qv74M1a7knl/V3dMe4RowoEtRQE1VePkY9iSeo65t/pfuw==
X-Received: by 2002:a0d:df8c:0:b0:5d7:1940:dd89 with SMTP id
 i134-20020a0ddf8c000000b005d71940dd89mr1999765ywe.95.1701649601507; 
 Sun, 03 Dec 2023 16:26:41 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:41 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 14/45] Add BCM2838 PCIE Root Complex
Date: Sun,  3 Dec 2023 18:25:48 -0600
Message-Id: <20231204002619.1367044-15-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_pcie.c         | 74 +++++++++++++++++++++++++++++++++++
 hw/arm/meson.build            |  5 ++-
 hw/arm/trace-events           |  4 ++
 include/hw/arm/bcm2838_pcie.h | 53 +++++++++++++++++++++++++
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/bcm2838_pcie.c
 create mode 100644 include/hw/arm/bcm2838_pcie.h

diff --git a/hw/arm/bcm2838_pcie.c b/hw/arm/bcm2838_pcie.c
new file mode 100644
index 0000000000..3b4373c6a6
--- /dev/null
+++ b/hw/arm/bcm2838_pcie.c
@@ -0,0 +1,74 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "hw/irq.h"
+#include "hw/pci-host/gpex.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "qemu/module.h"
+#include "hw/arm/bcm2838_pcie.h"
+#include "trace.h"
+
+/*
+ * RC root part (D0:F0)
+ */
+
+static void bcm2838_pcie_root_reg_reset(PCIDevice *dev)
+{
+    BCM2838PcieRootState *s = BCM2838_PCIE_ROOT(dev);
+    memset(s->regs, 0xFF, sizeof(s->regs));
+}
+
+static void bcm2838_pcie_root_realize(PCIDevice *dev, Error **errp) {
+    bcm2838_pcie_root_reg_reset(dev);
+}
+
+static void bcm2838_pcie_root_init(Object *obj)
+{
+    PCIBridge *br = PCI_BRIDGE(obj);
+    br->bus_name = "pcie.1";
+}
+
+static void bcm2838_pcie_root_class_init(ObjectClass *class, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(class);
+    BCM2838PcieRootClass *brpc = BCM2838_PCIE_ROOT_CLASS(class);
+
+    dc->desc = "BCM2711 PCIe Bridge";
+    /*
+     * PCI-facing part of the host bridge, not usable without the host-facing
+     * part, which can't be device_add'ed.
+     */
+    dc->user_creatable = false;
+    k->vendor_id = BCM2838_PCIE_VENDOR_ID;
+    k->device_id = BCM2838_PCIE_DEVICE_ID;
+    k->revision = BCM2838_PCIE_REVISION;
+    brpc->parent_obj.exp_offset = BCM2838_PCIE_EXP_CAP_OFFSET;
+    brpc->parent_obj.aer_offset = BCM2838_PCIE_AER_CAP_OFFSET;
+    brpc->parent_realize = k->realize;
+    k->realize = bcm2838_pcie_root_realize;
+}
+
+static const TypeInfo bcm2838_pcie_root_info = {
+    .name = TYPE_BCM2838_PCIE_ROOT,
+    .parent = TYPE_PCIE_ROOT_PORT,
+    .instance_size = sizeof(BCM2838PcieRootState),
+    .instance_init = bcm2838_pcie_root_init,
+    .class_init = bcm2838_pcie_root_class_init,
+};
+
+static void bcm2838_pcie_register(void)
+{
+    type_register_static(&bcm2838_pcie_root_info);
+}
+
+type_init(bcm2838_pcie_register)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 27e6797de2..b26ed13c6f 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,7 +39,10 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
-arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c', 'raspi4b.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files(
+  'bcm2838.c',
+  'bcm2838_pcie.c',
+  'raspi4b.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 4f0167e638..6cfab31539 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,5 +55,9 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# bcm2838_pcie.c
+bcm2838_pcie_host_read(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+bcm2838_pcie_host_write(unsigned int size, uint64_t offset, uint64_t value) "%u bytes @ 0x%04"PRIx64": 0x%016"PRIx64
+
 # bcm2838.c
 bcm2838_gic_set_irq(int irq, int level) "gic irq:%d lvl:%d"
diff --git a/include/hw/arm/bcm2838_pcie.h b/include/hw/arm/bcm2838_pcie.h
new file mode 100644
index 0000000000..39828f817f
--- /dev/null
+++ b/include/hw/arm/bcm2838_pcie.h
@@ -0,0 +1,53 @@
+/*
+ * BCM2838 PCIe Root Complex emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_PCIE_H
+#define BCM2838_PCIE_H
+
+#include "exec/hwaddr.h"
+#include "hw/sysbus.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "qom/object.h"
+
+#define TYPE_BCM2838_PCIE_ROOT "bcm2838-pcie-root"
+OBJECT_DECLARE_TYPE(BCM2838PcieRootState, BCM2838PcieRootClass,
+                    BCM2838_PCIE_ROOT)
+
+#define BCM2838_PCIE_VENDOR_ID      0x14E4
+#define BCM2838_PCIE_DEVICE_ID      0x2711
+#define BCM2838_PCIE_REVISION       20
+
+#define BCM2838_PCIE_REGS_SIZE      0x9310
+#define BCM2838_PCIE_NUM_IRQS       4
+
+#define BCM2838_PCIE_EXP_CAP_OFFSET 0xAC
+#define BCM2838_PCIE_AER_CAP_OFFSET 0x100
+
+#define BCM2838_PCIE_EXT_CFG_DATA   0x8000
+#define BCM2838_PCIE_EXT_CFG_INDEX  0x9000
+
+struct BCM2838PcieRootState {
+    /*< private >*/
+    PCIESlot parent_obj;
+
+    /*< public >*/
+    uint8_t regs[BCM2838_PCIE_REGS_SIZE - PCIE_CONFIG_SPACE_SIZE];
+};
+
+struct BCM2838PcieRootClass {
+    /*< private >*/
+    PCIERootPortClass parent_obj;
+
+    /*< public >*/
+    void (*parent_realize)(PCIDevice *dev, Error **errp);
+};
+
+
+#endif /* BCM2838_PCIE_H */
-- 
2.34.1


