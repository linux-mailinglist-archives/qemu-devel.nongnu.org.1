Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EF3826615
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 22:27:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMaeZ-0003K0-Ak; Sun, 07 Jan 2024 16:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeX-0003Iu-Cn
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:53 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMaeV-0004CZ-JB
 for qemu-devel@nongnu.org; Sun, 07 Jan 2024 16:25:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dr06ePIVgTeo8NJyEhCmNprRIYjT235U71iyeZuVs0E=; b=V9bsKtfm6Lk6B6rto1/z8mj4zj
 DmiuRmebxZRDiMfZPC8jmiqBLIYwHu8T0GPNXx3eLMCZXOKSghOQI3rNkC0Z/PYO1ffLAH1/ttePu
 BMV534TS3lhL5twel2D3WLOpkzih7bCXQhaXAs7A9yVPqi+zoNVQ9onlBP9moz1ipOesZdEW1gWad
 kzab+lwCcl+vXMfHci7DQ4qOYaEQ4fK+YxxeUR3wx7KjMcPlXINo2RhIbGf+gLkSSVIp0UPcZRk4V
 CM44ePS0HYKJe9Lfbx38e7SkUfXhCGGWlQ0Z/CPKwFGa4LD33xwCvAtNTQ8gVuaK+QaIoq89x0BI8
 lAOLM9gMLo8r0m9N3POKtL/bjCY85F1MJZau5SnlqKJGcT7dSHa2r0NWmKl75Nw20L6n1VPBxEjC4
 9DcpL63pVqKdSOkB2kKAYWT+qtpHFxjDzNK63HTDqD9BZaFlzbljF+y6U351lrUq6hVXV7az0YuMl
 cUKbWR0YwEzxU0TZhMJjbWT7T5zPZHrahEw2qLHcX1ilC0B+Zd/ltzi4xrDS5o0Nmr3lvRT6wrBZu
 R9cBi4DlYofLvtYQT6BAYuOyWR5BvYGQOe69KN6wmGwRKjJ81ogdE3LhQfdEoAu/HAy0YbqOQEy/r
 uHydcR4S7M7E7ZnxVAhQUPWtGG3/2jyKrpuSaRuQs=;
Received: from [2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rMadx-0006OD-Bx; Sun, 07 Jan 2024 21:25:21 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org,
	elliotnunn@fastmail.com
Date: Sun,  7 Jan 2024 21:25:38 +0000
Message-Id: <20240107212538.227627-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
References: <20240107212538.227627-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb1:9800:cf84:25bc:70ee:fc26
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 2/2] nubus: add nubus-virtio-mmio device
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


