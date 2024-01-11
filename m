Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7465D82AC03
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 11:31:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNsKO-0005du-8p; Thu, 11 Jan 2024 05:30:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsKL-0005dV-8o
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:21 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsKI-000463-Kq
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 05:30:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dr06ePIVgTeo8NJyEhCmNprRIYjT235U71iyeZuVs0E=; b=uUbv5D+Q4Th4mCFS4FaNDYdWwN
 SAXNxqcLcZRGh3khgg/lPyj/ZLHkLCxBEe5B4hMrbgQ8hMWh6w+dLz+AZk0xtea65szm0iPvbDjFz
 /DRA/WdCpqDHiX50h0UA/ucdmUR5ET8sWS3CZKxwgHxM8Cp7TWaKtLp7ChUtuxwYNRwKNYtpj9qHU
 kfN19vAockzpqEGlnAQurfUmJEb3P335tiWYc/EvfbyxG520meJ05WK326ZdJko3MDQh5bN0wZyNk
 b6/Zy6/NKz/BDdUcfmGYTfq1vNnWcEGlVgjE+lo6DEHRTXIClGKiGNAiunp7zbwuzUyyUtMMm+XLy
 OPMCURKc+lHcPCAn4Mhx0Qka/uW48+1596dyTzeaOYX2cu27MEl0AZzEC1w/Kve2LI/7iQrmPzevn
 PTIB2nsG0JK6PsTfjuMyX/r4GctQtuJPdwffgEudb1kIeYb7aoH4pDc799ExdZKMtmwKSRgFsdknq
 TSnEXelrpZ4i8/kvn362uG1qtGO0jS7tNUEliYpzos3GQRqsgxux59IzQQ7ho6avuFUSadfxWwmu1
 Y1/qFYN6Ln31r9qIhoRvoVds2tknQPZwxX5XhCazfnPIr4H+sT9RpCljm8geGHk323e5vTohR9Jkf
 D2hLE16gCCXBiO+1DpOOSl0ajYOq0UGMLjkvu+ly0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rNsJj-000CMC-6p; Thu, 11 Jan 2024 10:29:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Thu, 11 Jan 2024 10:29:54 +0000
Message-Id: <20240111102954.449462-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
References: <20240111102954.449462-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 3/3] nubus: add nubus-virtio-mmio device
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The nubus-virtio-mmio device is a Nubus card that contains a set of 32 virtio-mmio
devices and a goldfish PIC similar to the m68k virt machine that can be plugged
into the m68k q800 machine.

There are currently a number of drivers under development that can be used in
conjunction with this device to provide accelerated and/or additional hypervisor
services to 68k Classic MacOS.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/nubus/meson.build                 |   1 +
 hw/nubus/nubus-virtio-mmio.c         | 102 +++++++++++++++++++++++++++
 include/hw/nubus/nubus-virtio-mmio.h |  36 ++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 hw/nubus/nubus-virtio-mmio.c
 create mode 100644 include/hw/nubus/nubus-virtio-mmio.h

diff --git a/hw/nubus/meson.build b/hw/nubus/meson.build
index e7ebda8993..9a7a12ea68 100644
--- a/hw/nubus/meson.build
+++ b/hw/nubus/meson.build
@@ -2,6 +2,7 @@ nubus_ss = ss.source_set()
 nubus_ss.add(files('nubus-device.c'))
 nubus_ss.add(files('nubus-bus.c'))
 nubus_ss.add(files('nubus-bridge.c'))
+nubus_ss.add(files('nubus-virtio-mmio.c'))
 nubus_ss.add(when: 'CONFIG_Q800', if_true: files('mac-nubus-bridge.c'))
 
 system_ss.add_all(when: 'CONFIG_NUBUS', if_true: nubus_ss)
diff --git a/hw/nubus/nubus-virtio-mmio.c b/hw/nubus/nubus-virtio-mmio.c
new file mode 100644
index 0000000000..58a63c84d0
--- /dev/null
+++ b/hw/nubus/nubus-virtio-mmio.c
@@ -0,0 +1,102 @@
+/*
+ * QEMU Macintosh Nubus Virtio MMIO card
+ *
+ * Copyright (c) 2024 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "hw/nubus/nubus-virtio-mmio.h"
+
+
+#define NUBUS_VIRTIO_MMIO_PIC_OFFSET   0
+#define NUBUS_VIRTIO_MMIO_DEV_OFFSET   0x200
+
+
+static void nubus_virtio_mmio_set_input_irq(void *opaque, int n, int level)
+{
+    NubusDevice *nd = NUBUS_DEVICE(opaque);
+
+    nubus_set_irq(nd, level);
+}
+
+static void nubus_virtio_mmio_realize(DeviceState *dev, Error **errp)
+{
+    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_GET_CLASS(dev);
+    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(dev);
+    NubusDevice *nd = NUBUS_DEVICE(dev);
+    SysBusDevice *sbd;
+    int i, offset;
+
+    nvmdc->parent_realize(dev, errp);
+    if (*errp) {
+        return;
+    }
+
+    /* Goldfish PIC */
+    sbd = SYS_BUS_DEVICE(&s->pic);
+    if (!sysbus_realize(sbd, errp)) {
+        return;
+    }
+    memory_region_add_subregion(&nd->slot_mem, NUBUS_VIRTIO_MMIO_PIC_OFFSET,
+                                sysbus_mmio_get_region(sbd, 0));
+    sysbus_connect_irq(sbd, 0,
+                       qdev_get_gpio_in_named(dev, "pic-input-irq", 0));
+
+    /* virtio-mmio devices */
+    offset = NUBUS_VIRTIO_MMIO_DEV_OFFSET;
+    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
+        sbd = SYS_BUS_DEVICE(&s->virtio_mmio[i]);
+        qdev_prop_set_bit(DEVICE(sbd), "force-legacy", false);
+        if (!sysbus_realize_and_unref(sbd, errp)) {
+            return;
+        }
+
+        memory_region_add_subregion(&nd->slot_mem, offset,
+                                    sysbus_mmio_get_region(sbd, 0));
+        offset += 0x200;
+
+        sysbus_connect_irq(sbd, 0, qdev_get_gpio_in(DEVICE(&s->pic), i));
+    }
+}
+
+static void nubus_virtio_mmio_init(Object *obj)
+{
+    NubusVirtioMMIO *s = NUBUS_VIRTIO_MMIO(obj);
+    int i;
+
+    object_initialize_child(obj, "pic", &s->pic, TYPE_GOLDFISH_PIC);
+    for (i = 0; i < NUBUS_VIRTIO_MMIO_NUM_DEVICES; i++) {
+        char *name = g_strdup_printf("virtio-mmio[%d]", i);
+        object_initialize_child(obj, name, &s->virtio_mmio[i],
+                                TYPE_VIRTIO_MMIO);
+        g_free(name);
+    }
+
+    /* Input from goldfish PIC */
+    qdev_init_gpio_in_named(DEVICE(obj), nubus_virtio_mmio_set_input_irq,
+                            "pic-input-irq", 1);
+}
+
+static void nubus_virtio_mmio_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    NubusVirtioMMIODeviceClass *nvmdc = NUBUS_VIRTIO_MMIO_CLASS(oc);
+
+    device_class_set_parent_realize(dc, nubus_virtio_mmio_realize,
+                                    &nvmdc->parent_realize);
+}
+
+static const TypeInfo nubus_virtio_mmio_types[] = {
+    {
+        .name = TYPE_NUBUS_VIRTIO_MMIO,
+        .parent = TYPE_NUBUS_DEVICE,
+        .instance_init = nubus_virtio_mmio_init,
+        .instance_size = sizeof(NubusVirtioMMIO),
+        .class_init = nubus_virtio_mmio_class_init,
+        .class_size = sizeof(NubusVirtioMMIODeviceClass),
+    },
+};
+
+DEFINE_TYPES(nubus_virtio_mmio_types)
diff --git a/include/hw/nubus/nubus-virtio-mmio.h b/include/hw/nubus/nubus-virtio-mmio.h
new file mode 100644
index 0000000000..de497b7f76
--- /dev/null
+++ b/include/hw/nubus/nubus-virtio-mmio.h
@@ -0,0 +1,36 @@
+/*
+ * QEMU Macintosh Nubus Virtio MMIO card
+ *
+ * Copyright (c) 2023 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NUBUS_VIRTIO_MMIO_H
+#define HW_NUBUS_VIRTIO_MMIO_H
+
+#include "hw/nubus/nubus.h"
+#include "qom/object.h"
+#include "hw/intc/goldfish_pic.h"
+#include "hw/virtio/virtio-mmio.h"
+
+#define TYPE_NUBUS_VIRTIO_MMIO "nubus-virtio-mmio"
+OBJECT_DECLARE_TYPE(NubusVirtioMMIO, NubusVirtioMMIODeviceClass,
+                    NUBUS_VIRTIO_MMIO)
+
+struct NubusVirtioMMIODeviceClass {
+    DeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+#define NUBUS_VIRTIO_MMIO_NUM_DEVICES 32
+
+struct NubusVirtioMMIO {
+    NubusDevice parent_obj;
+
+    GoldfishPICState pic;
+    VirtIOMMIOProxy virtio_mmio[NUBUS_VIRTIO_MMIO_NUM_DEVICES];
+};
+
+#endif
-- 
2.39.2


