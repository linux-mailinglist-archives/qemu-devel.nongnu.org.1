Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ABC802987
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:35:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wnN-0004WF-UI; Sun, 03 Dec 2023 19:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnD-0004Rc-LM; Sun, 03 Dec 2023 19:26:35 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wn9-00006H-So; Sun, 03 Dec 2023 19:26:33 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5d7692542beso11567237b3.3; 
 Sun, 03 Dec 2023 16:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649589; x=1702254389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0abax01Jn7TA0fY2P1fUcZE3FFcwoH4EKqmrD+AUDY=;
 b=Eq8954KWBe0phh2nTaao12x7U5+8sGRxd+I5lSaQh0ZsUQmDL5foVQQvrZWNvL4vrj
 m5M1XQoal6M6QjdSxvm8GWnswRfknld3NG3xHQ/troSs4CdOgSf5uVJTYdN8AmRrIZ7/
 2r6okUbjPYAO+vohA2FkkSGV9JKFImKTxFY/Or0W+Qf/QGP9W4S1GzsH5aflcjjEi2yi
 1A5kdGs6xKpHaSsmrj2ue/8eXDSLzoVIJDke8P8w5FZOZKX0ITEbnto3rT1LfTyW8fJ0
 opkYqb7xGy65EkuQTAxObvO0JhIvGZcAuVS1/p4WS+q9Tt7iEi9p/vqPoTpr3LL+3K8r
 qo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649589; x=1702254389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I0abax01Jn7TA0fY2P1fUcZE3FFcwoH4EKqmrD+AUDY=;
 b=pNaQRWHJTZPbLa0VKXRkoo4rM2Ea3DUr6VgohCm3Xb15Tal+6GUWEnkR5PlVcx73Vt
 v1ITGr0ynYkPWiWY3NEhgLdhcPNZSqPkKaX511T52DWYc+qosXI0i2hm91zT6L/N/DQA
 It3CbOh0c3ee3yvNsb2l0jAgapJmfZmKAnVJUCiFrJ4vb5L5NuhLeUsZmbrF6Aaw+3xy
 freo3Skd6FuskwEK5LfH15I1//8a5JRlkTTXYZD9CSF9lj/ewhSZJjb+gk7vjhZrcSyY
 XvxwE+uW2Q+X8qyF/WWsMykTtGf7YUjZR0A8+2vAszGEM5dsS28Rov6q8iFB6i3siBR/
 VcWg==
X-Gm-Message-State: AOJu0YwHUYw4w93kzPr0GNU+PdrxR8ia4TrT9LGoo9kGvcJvsx9URZBW
 ygAGV8sSQUv+4nfTGTf9ojv58Uu0CafxYA==
X-Google-Smtp-Source: AGHT+IELNcIiPmKuyktTY/XjXrwhocPmfl2pI2oeuqG2lPOKwoywgk2C8L1BOFP4aOLBwK+wFXkP+w==
X-Received: by 2002:a81:b04a:0:b0:5d7:1940:53ee with SMTP id
 x10-20020a81b04a000000b005d7194053eemr1884601ywk.102.1701649589423; 
 Sun, 03 Dec 2023 16:26:29 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:29 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 04/45] Introduce BCM2838 SoC
Date: Sun,  3 Dec 2023 18:25:38 -0600
Message-Id: <20231204002619.1367044-5-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112a.google.com
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
 hw/arm/bcm2838.c                     | 100 +++++++++++++++++++++++++++
 hw/arm/bcm2838_peripherals.c         |  72 +++++++++++++++++++
 hw/arm/meson.build                   |   2 +
 include/hw/arm/bcm2838.h             |  29 ++++++++
 include/hw/arm/bcm2838_peripherals.h |  36 ++++++++++
 5 files changed, 239 insertions(+)
 create mode 100644 hw/arm/bcm2838.c
 create mode 100644 hw/arm/bcm2838_peripherals.c
 create mode 100644 include/hw/arm/bcm2838.h
 create mode 100644 include/hw/arm/bcm2838_peripherals.h

diff --git a/hw/arm/bcm2838.c b/hw/arm/bcm2838.c
new file mode 100644
index 0000000000..c61c59661b
--- /dev/null
+++ b/hw/arm/bcm2838.c
@@ -0,0 +1,100 @@
+/*
+ * BCM2838 SoC emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/sysbus.h"
+#include "hw/arm/bcm2838.h"
+#include "trace.h"
+
+#define VIRTUAL_PMU_IRQ 7
+
+static void bcm2838_init(Object *obj)
+{
+    BCM2838State *s = BCM2838(obj);
+
+    object_initialize_child(obj, "peripherals", &s->peripherals,
+                            TYPE_BCM2838_PERIPHERALS);
+    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
+                              "board-rev");
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
+                              "vcram-size");
+    object_property_add_alias(obj, "command-line", OBJECT(&s->peripherals),
+                              "command-line");
+}
+
+static void bcm2838_realize(DeviceState *dev, Error **errp)
+{
+    int n;
+    BCM2838State *s = BCM2838(dev);
+    BCM283XBaseState *s_base = BCM283X_BASE(dev);
+    BCM283XBaseClass *bc_base = BCM283X_BASE_GET_CLASS(dev);
+    BCM2838PeripheralState *ps = BCM2838_PERIPHERALS(&s->peripherals);
+    BCMSocPeripheralBaseState *ps_base =
+        BCM_SOC_PERIPHERALS_BASE(&s->peripherals);
+
+    if (!bcm283x_common_realize(dev, ps_base, errp)) {
+        return;
+    }
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(ps), 1, BCM2838_PERI_LOW_BASE, 1);
+
+    /* bcm2836 interrupt controller (and mailboxes, etc.) */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s_base->control), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s_base->control), 0, bc_base->ctrl_base);
+
+    /* Create cores */
+    for (n = 0; n < bc_base->core_count; n++) {
+        /* TODO: this should be converted to a property of ARM_CPU */
+        s_base->cpu[n].core.mp_affinity = (bc_base->clusterid << 8) | n;
+
+        /* start powered off if not enabled */
+        if (!object_property_set_bool(OBJECT(&s_base->cpu[n].core),
+                                      "start-powered-off",
+                                      n >= s_base->enabled_cpus,
+                                      errp)) {
+            return;
+        }
+
+        if (!qdev_realize(DEVICE(&s_base->cpu[n].core), NULL, errp)) {
+            return;
+        }
+    }
+}
+
+static void bcm2838_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM283XBaseClass *bc_base = BCM283X_BASE_CLASS(oc);
+
+    bc_base->cpu_type = ARM_CPU_TYPE_NAME("cortex-a72");
+    bc_base->core_count = BCM283X_NCPUS;
+    bc_base->peri_base = 0xfe000000;
+    bc_base->ctrl_base = 0xff800000;
+    bc_base->clusterid = 0x0;
+    dc->realize = bcm2838_realize;
+}
+
+static const TypeInfo bcm2838_type = {
+    .name           = TYPE_BCM2838,
+    .parent         = TYPE_BCM283X_BASE,
+    .instance_size  = sizeof(BCM2838State),
+    .instance_init  = bcm2838_init,
+    .class_size     = sizeof(BCM283XBaseClass),
+    .class_init     = bcm2838_class_init,
+};
+
+static void bcm2838_register_types(void)
+{
+    type_register_static(&bcm2838_type);
+}
+
+type_init(bcm2838_register_types);
diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
new file mode 100644
index 0000000000..06110c724f
--- /dev/null
+++ b/hw/arm/bcm2838_peripherals.c
@@ -0,0 +1,72 @@
+/*
+ * BCM2838 peripherals emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/arm/bcm2838_peripherals.h"
+
+/* Lower peripheral base address on the VC (GPU) system bus */
+#define BCM2838_VC_PERI_LOW_BASE 0x7c000000
+
+static void bcm2838_peripherals_init(Object *obj)
+{
+    BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
+    BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
+
+    /* Lower memory region for peripheral devices (exported to the Soc) */
+    memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
+                       bc->peri_low_size);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
+
+}
+
+static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838PeripheralState *s = BCM2838_PERIPHERALS(dev);
+    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(dev);
+
+    bcm_soc_peripherals_common_realize(dev, errp);
+
+    /* Map lower peripherals into the GPU address space */
+    memory_region_init_alias(&s->peri_low_mr_alias, OBJECT(s),
+                             "bcm2838-peripherals", &s->peri_low_mr, 0,
+                             memory_region_size(&s->peri_low_mr));
+    memory_region_add_subregion_overlap(&s_base->gpu_bus_mr,
+                                        BCM2838_VC_PERI_LOW_BASE,
+                                        &s->peri_low_mr_alias, 1);
+
+}
+
+static void bcm2838_peripherals_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_CLASS(oc);
+    BCMSocPeripheralBaseClass *bc_base = BCM_SOC_PERIPHERALS_BASE_CLASS(oc);
+
+    bc->peri_low_size = 0x2000000;
+    bc_base->peri_size = 0x1800000;
+    dc->realize = bcm2838_peripherals_realize;
+}
+
+static const TypeInfo bcm2838_peripherals_type_info = {
+    .name = TYPE_BCM2838_PERIPHERALS,
+    .parent = TYPE_BCM_SOC_PERIPHERALS_BASE,
+    .instance_size = sizeof(BCM2838PeripheralState),
+    .instance_init = bcm2838_peripherals_init,
+    .class_size = sizeof(BCM2838PeripheralClass),
+    .class_init = bcm2838_peripherals_class_init,
+};
+
+static void bcm2838_peripherals_register_types(void)
+{
+    type_register_static(&bcm2838_peripherals_type_info);
+}
+
+type_init(bcm2838_peripherals_register_types)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 68245d3ad1..551ab6abf5 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -39,6 +39,7 @@ arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubi
 arm_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-h3.c', 'orangepi.c'))
 arm_ss.add(when: 'CONFIG_ALLWINNER_R40', if_true: files('allwinner-r40.c', 'bananapi_m2u.c'))
 arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2836.c', 'raspi.c'))
+arm_ss.add(when: ['CONFIG_RASPI', 'TARGET_AARCH64'], if_true: files('bcm2838.c'))
 arm_ss.add(when: 'CONFIG_STM32F100_SOC', if_true: files('stm32f100_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
 arm_ss.add(when: 'CONFIG_STM32F405_SOC', if_true: files('stm32f405_soc.c'))
@@ -69,6 +70,7 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
 system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c'))
+system_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2838_peripherals.c'))
 system_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
 
 hw_arch += {'arm': arm_ss}
diff --git a/include/hw/arm/bcm2838.h b/include/hw/arm/bcm2838.h
new file mode 100644
index 0000000000..bddc25ca9a
--- /dev/null
+++ b/include/hw/arm/bcm2838.h
@@ -0,0 +1,29 @@
+/*
+ * BCM2838 SoC emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_H
+#define BCM2838_H
+
+#include "hw/arm/bcm2836.h"
+#include "hw/arm/bcm2838_peripherals.h"
+
+#define BCM2838_PERI_LOW_BASE 0xfc000000
+#define BCM2838_GIC_BASE 0x40000
+
+#define TYPE_BCM2838 "bcm2838"
+
+OBJECT_DECLARE_TYPE(BCM2838State, BCM2838Class, BCM2838)
+
+struct BCM2838State {
+    /*< private >*/
+    BCM283XBaseState parent_obj;
+    /*< public >*/
+    BCM2838PeripheralState peripherals;
+};
+
+#endif /* BCM2838_H */
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
new file mode 100644
index 0000000000..7039b67cc9
--- /dev/null
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -0,0 +1,36 @@
+/*
+ * BCM2838 peripherals emulation
+ *
+ * Copyright (C) 2022 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef BCM2838_PERIPHERALS_H
+#define BCM2838_PERIPHERALS_H
+
+#include "hw/arm/bcm2835_peripherals.h"
+
+
+#define TYPE_BCM2838_PERIPHERALS "bcm2838-peripherals"
+OBJECT_DECLARE_TYPE(BCM2838PeripheralState, BCM2838PeripheralClass,
+                    BCM2838_PERIPHERALS)
+
+struct BCM2838PeripheralState {
+    /*< private >*/
+    BCMSocPeripheralBaseState parent_obj;
+
+    /*< public >*/
+    MemoryRegion peri_low_mr;
+    MemoryRegion peri_low_mr_alias;
+    MemoryRegion mphi_mr_alias;
+};
+
+struct BCM2838PeripheralClass {
+    /*< private >*/
+    BCMSocPeripheralBaseClass parent_class;
+    /*< public >*/
+    uint64_t peri_low_size; /* Peripheral lower range size */
+};
+
+#endif /* BCM2838_PERIPHERALS_H */
-- 
2.34.1


