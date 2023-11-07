Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E27E3508
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 07:08:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0FEq-0008Pd-Oe; Tue, 07 Nov 2023 01:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deniz.eren314@gmail.com>)
 id 1r0EcP-0004X8-2x
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 00:27:17 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deniz.eren314@gmail.com>)
 id 1r0EcM-0000W0-PV
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 00:27:16 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6c39ad730aaso1958471b3a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 21:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699334832; x=1699939632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kAsskmMb3JElJ8MhKKOUL7ITgrp+X/mQc+9xyrZWjDk=;
 b=Svg7Gn5UX1RwtUyvotOHvivnskb+Om8RurPPkVqinIeRXU3Ga77CJ/jpKLIZeaNoEC
 6VKz/trQkC+3KhQKv6iVaK2G399u3S00DgktmwVSPEFrpqRfM7iR6Q2v1OUCoDiMndCA
 0bQbSh5wXHcjTJEa1cJj+tKxGKE4hSUdyH6HiIfFy24hiqDYwmT5MVJn4QpbiEV6a09W
 SwXSxvmtCXZLgtgLgpm+pn7PpI75318DUXFBmwTowufX/7L2qYoSp16icnJee4JQmLWV
 crJSPzcFR2+zkn5sQRBucz8u0MqhIBx/Uu2osYYAREkptMsPevO4I6Skej7Zb6vmI15P
 K6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699334832; x=1699939632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kAsskmMb3JElJ8MhKKOUL7ITgrp+X/mQc+9xyrZWjDk=;
 b=ZAEVbhJUSPwEvc/bWlJk6gJAreUxZllTAtoBDXZYe/7kwUCDJYZBfrFPgs/QkKudrh
 N6V0DpqL6ZwpF43YqwtEfLqEqIx3pM2HHOBjcy8OF2wcTMXppedg1Qs+raQzwdavwWC+
 TOQZmdXzZ48R0GCOM6wFw1r2VdaRjPm9vnhpqBJyAyFdQOeJVa9gxXpkl4YG+ydWP1q8
 8dtQ97F4Ckd7qT+77PaP4LgeyEDhLFhCBoSs6N3QOcNbyg+vX6low7qRJh38Mu8WyCpV
 uZsuptosSqzt5cZy2TpBPsWlsoH8KmaQCtb1bLmQxz9qW01utyv/xECbT4an4nM9/Ae/
 tj5Q==
X-Gm-Message-State: AOJu0YyPLIIr6XARBRI9pi4eBwllkaJh9A728OfIW4Wk90OeAliKDCPf
 niVL3RxiLtoAy9mGjuAwnjprMwasPig=
X-Google-Smtp-Source: AGHT+IH/QRGj6hh2v8L8mqacq2+GtT/4i3vbAGuNkvJFraJdFg9SuI8dO+moEivG5jfZU3s80fpNqA==
X-Received: by 2002:a05:6a00:2282:b0:6c3:464d:c173 with SMTP id
 f2-20020a056a00228200b006c3464dc173mr13139004pfe.13.1699334831826; 
 Mon, 06 Nov 2023 21:27:11 -0800 (PST)
Received: from erende-p53.. ([61.68.109.19]) by smtp.gmail.com with ESMTPSA id
 q17-20020a62e111000000b006c34f19c459sm6363145pfh.139.2023.11.06.21.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 21:27:11 -0800 (PST)
From: Deniz Eren <deniz.eren314@gmail.com>
X-Google-Original-From: Deniz Eren <deniz.eren@outlook.com>
To: qemu-devel@nongnu.org
Cc: deniz.eren314@gmail.com,
	Deniz Eren <deniz.eren@outlook.com>
Subject: [PATCH] Implementation of SJA1000 CAN-bus devices that support MSI
 (PCI capability 0x05). - Implementation of multiple MSI vector support for
 SJA1000 devices. - Added can_pcm26d2ca_pci.c;
 support for Advantech iDoor Module (PCM-26D2CA): 2-Ports Isolated CANBus
 mPCIe, DB9 (SJA1000 based with MSI).
Date: Tue,  7 Nov 2023 16:26:57 +1100
Message-Id: <20231107052657.64207-1-deniz.eren@outlook.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=deniz.eren314@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, FREEMAIL_REPLY=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 07 Nov 2023 01:06:58 -0500
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

Signed-off-by: Deniz Eren <deniz.eren@outlook.com>
---
 hw/net/can/can_pcm26d2ca_pci.c | 281 +++++++++++++++++++++++++++++++++
 hw/net/can/can_sja1000.c       |  91 +++++++++++
 hw/net/can/can_sja1000.h       |  12 ++
 hw/net/can/meson.build         |   1 +
 4 files changed, 385 insertions(+)
 create mode 100644 hw/net/can/can_pcm26d2ca_pci.c

diff --git a/hw/net/can/can_pcm26d2ca_pci.c b/hw/net/can/can_pcm26d2ca_pci.c
new file mode 100644
index 0000000000..af1dd4c7bb
--- /dev/null
+++ b/hw/net/can/can_pcm26d2ca_pci.c
@@ -0,0 +1,281 @@
+/*
+ * PCM-26D2CA PCIe CAN device (SJA1000 based) emulation
+ *
+ * Advantech iDoor Module: 2-Ports Isolated CANBus mPCIe, DB9
+ *
+ * Copyright (c) 2023 Deniz Eren (deniz.eren@icloud.com)
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/units.h"
+#include "qemu/osdep.h"
+#include "qemu/event_notifier.h"
+#include "qemu/module.h"
+#include "qemu/thread.h"
+#include "qemu/sockets.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "hw/irq.h"
+#include "hw/pci/pci_device.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/msi.h"
+#include "migration/vmstate.h"
+#include "net/can_emu.h"
+
+#include "can_sja1000.h"
+#include "qom/object.h"
+
+#define TYPE_CAN_PCI_DEV "pcm26d2ca_pci"
+
+typedef struct Pcm26D2CAPCIeState Pcm26D2CAPCIeState;
+DECLARE_INSTANCE_CHECKER(Pcm26D2CAPCIeState, PCM26D2CA_PCI_DEV,
+                         TYPE_CAN_PCI_DEV)
+
+/* the PCI device and vendor IDs */
+#ifndef PCM26D2CA_PCI_VENDOR_ID1
+#define PCM26D2CA_PCI_VENDOR_ID1    0x13fe
+#endif
+
+#ifndef PCM26D2CA_PCI_DEVICE_ID1
+#define PCM26D2CA_PCI_DEVICE_ID1    0x00d7
+#endif
+
+#define PCM26D2CA_PCI_SJA_COUNT     2
+#define PCM26D2CA_PCI_SJA_RANGE     0x400
+
+#define PCM26D2CA_PCI_BYTES_PER_SJA 0x80
+
+#define PCM26D2CA_IO_IDX            0
+
+#define PCM26D2CA_MSI_VEC_NUM       (8)
+#define PCM26D2CA_MSI_RI_ENTRY      (0) /* Receive interrupt */
+#define PCM26D2CA_MSI_TI_ENTRY      (1) /* Transmit interrupt */
+#define PCM26D2CA_MSI_EI_ENTRY      (2) /* Error warning interrupt */
+#define PCM26D2CA_MSI_DOI_ENTRY     (3) /* Data overrun interrupt */
+#define PCM26D2CA_MSI_WUI_ENTRY     (4) /* Wakeup interrupt */
+#define PCM26D2CA_MSI_EPI_ENTRY     (5) /* Error passive */
+#define PCM26D2CA_MSI_ALI_ENTRY     (6) /* Arbitration lost */
+#define PCM26D2CA_MSI_BEI_ENTRY     (7) /* Bus error interrupt */
+
+struct Pcm26D2CAPCIeState {
+    /*< private >*/
+    PCIDevice       dev;
+    /*< public >*/
+    MemoryRegion    io;
+
+    CanSJA1000State sja_state[PCM26D2CA_PCI_SJA_COUNT];
+    qemu_irq        irq;
+
+    char            *model; /* The model that support, only SJA1000 now. */
+    CanBusState     *canbus[PCM26D2CA_PCI_SJA_COUNT];
+};
+
+static void pcm26d2ca_pci_reset(DeviceState *dev)
+{
+    Pcm26D2CAPCIeState *d = PCM26D2CA_PCI_DEV(dev);
+    int i;
+
+    for (i = 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_hardware_reset(&d->sja_state[i]);
+    }
+}
+
+static uint64_t pcm26d2ca_pci_io_read(void *opaque, hwaddr addr, unsigned size)
+{
+    Pcm26D2CAPCIeState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[0];
+    hwaddr _addr = addr;
+
+    if (addr >= PCM26D2CA_PCI_SJA_RANGE) {
+        s = &d->sja_state[1];
+        _addr -= PCM26D2CA_PCI_SJA_RANGE;
+    }
+
+    if (_addr >= PCM26D2CA_PCI_BYTES_PER_SJA) {
+        return 0;
+    }
+
+    return can_sja_mem_read(s, _addr >> 2, size);
+}
+
+static void pcm26d2ca_pci_io_write(void *opaque, hwaddr addr, uint64_t data,
+                                  unsigned size)
+{
+    Pcm26D2CAPCIeState *d = opaque;
+    CanSJA1000State *s = &d->sja_state[0];
+    hwaddr _addr = addr;
+
+    if (addr >= PCM26D2CA_PCI_SJA_RANGE) {
+        s = &d->sja_state[1];
+        _addr -= PCM26D2CA_PCI_SJA_RANGE;
+    }
+
+    if (_addr >= PCM26D2CA_PCI_BYTES_PER_SJA) {
+        return;
+    }
+
+    can_sja_mem_write(s, _addr >> 2, data, size);
+}
+
+static const MemoryRegionOps pcm26d2ca_pci_io_ops = {
+    .read = pcm26d2ca_pci_io_read,
+    .write = pcm26d2ca_pci_io_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .max_access_size = 1,
+    },
+};
+
+static void pcm26d2ca_pci_realize(PCIDevice *pci_dev, Error **errp)
+{
+    static const uint16_t pcie_offset = 0x0E0;
+    Pcm26D2CAPCIeState *d = PCM26D2CA_PCI_DEV(pci_dev);
+    uint8_t *pci_conf;
+    Error *err = NULL;
+    int i;
+    int ret;
+
+    /* Map MSI and MSI-X vector entries one-to-one for each interrupt */
+    uint8_t msi_map[PCM26D2CA_MSI_VEC_NUM] = {
+        PCM26D2CA_MSI_RI_ENTRY,  /* Receive interrupt */
+        PCM26D2CA_MSI_TI_ENTRY,  /* Transmit interrupt */
+        PCM26D2CA_MSI_EI_ENTRY,  /* Error warning interrupt */
+        PCM26D2CA_MSI_DOI_ENTRY, /* Data overrun interrupt */
+        PCM26D2CA_MSI_WUI_ENTRY, /* Wakeup interrupt */
+        PCM26D2CA_MSI_EPI_ENTRY, /* Error passive */
+        PCM26D2CA_MSI_ALI_ENTRY, /* Arbitration lost */
+        PCM26D2CA_MSI_BEI_ENTRY  /* Bus error interrupt */
+    };
+
+    pci_conf = pci_dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 0x01; /* interrupt pin A */
+
+    d->irq = pci_allocate_irq(&d->dev);
+
+    for (i = 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_cap_init(&d->sja_state[i], d->irq, pci_dev, msi_map, msi_map);
+    }
+
+    for (i = 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        if (can_sja_connect_to_bus(&d->sja_state[i], d->canbus[i]) < 0) {
+            error_setg(errp, "can_sja_connect_to_bus failed");
+            return;
+        }
+    }
+
+    memory_region_init_io(&d->io, OBJECT(d), &pcm26d2ca_pci_io_ops,
+                          d, "pcm26d2ca_pci-io", 2*PCM26D2CA_PCI_SJA_RANGE);
+    pci_register_bar(&d->dev, PCM26D2CA_IO_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &d->io);
+
+    if (pcie_endpoint_cap_v1_init(pci_dev, pcie_offset) < 0) {
+        error_setg(errp, "Failed to initialize PCIe capability");
+        return;
+    }
+
+    ret = msi_init( PCI_DEVICE(d), 0xD0, PCM26D2CA_MSI_VEC_NUM,
+            true, false, NULL );
+
+    if (ret) {
+        error_setg(errp, "msi_init failed (%d)", ret);
+        return;
+    }
+
+    error_free(err);
+}
+
+static void pcm26d2ca_pci_exit(PCIDevice *pci_dev)
+{
+    Pcm26D2CAPCIeState *d = PCM26D2CA_PCI_DEV(pci_dev);
+    int i;
+
+    for (i = 0 ; i < PCM26D2CA_PCI_SJA_COUNT; i++) {
+        can_sja_disconnect(&d->sja_state[i]);
+    }
+
+    qemu_free_irq(d->irq);
+    msi_uninit(pci_dev);
+}
+
+static const VMStateDescription vmstate_pcm26d2ca_pci = {
+    .name = TYPE_CAN_PCI_DEV,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(dev, Pcm26D2CAPCIeState),
+        VMSTATE_STRUCT(sja_state[0], Pcm26D2CAPCIeState, 0, vmstate_can_sja,
+                       CanSJA1000State),
+        VMSTATE_STRUCT(sja_state[1], Pcm26D2CAPCIeState, 0, vmstate_can_sja,
+                       CanSJA1000State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void pcm26d2ca_pci_instance_init(Object *obj)
+{
+    Pcm26D2CAPCIeState *d = PCM26D2CA_PCI_DEV(obj);
+
+    object_property_add_link(obj, "canbus0", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[0],
+                             qdev_prop_allow_set_link_before_realize,
+                             0);
+    object_property_add_link(obj, "canbus1", TYPE_CAN_BUS,
+                             (Object **)&d->canbus[1],
+                             qdev_prop_allow_set_link_before_realize,
+                             0);
+}
+
+static void pcm26d2ca_pci_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->realize = pcm26d2ca_pci_realize;
+    k->exit = pcm26d2ca_pci_exit;
+    k->vendor_id = PCM26D2CA_PCI_VENDOR_ID1;
+    k->device_id = PCM26D2CA_PCI_DEVICE_ID1;
+    k->revision = 0x00;
+    k->class_id = 0x000c09;
+    k->subsystem_vendor_id = PCM26D2CA_PCI_VENDOR_ID1;
+    k->subsystem_id = PCM26D2CA_PCI_DEVICE_ID1;
+    dc->desc = "PCM-26 series Advantech iDoor";
+    dc->vmsd = &vmstate_pcm26d2ca_pci;
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+    dc->reset = pcm26d2ca_pci_reset;
+}
+
+static const TypeInfo pcm26d2ca_pci_info = {
+    .name          = TYPE_CAN_PCI_DEV,
+    .parent        = TYPE_PCI_DEVICE,
+    .instance_size = sizeof(Pcm26D2CAPCIeState),
+    .class_init    = pcm26d2ca_pci_class_init,
+    .instance_init = pcm26d2ca_pci_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void pcm26d2ca_pci_register_types(void)
+{
+    type_register_static(&pcm26d2ca_pci_info);
+}
+
+type_init(pcm26d2ca_pci_register_types)
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..ba75e6f35b 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -29,6 +29,8 @@
 #include "qemu/log.h"
 #include "chardev/char.h"
 #include "hw/irq.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
 
@@ -401,10 +403,58 @@ static int frame2buff_bas(const qemu_can_frame *frame, uint8_t *buff)
     return dlen + 2;
 }
 
+static void can_sja_update_pcie_msi(CanSJA1000State *s, uint8_t interrupt_reg)
+{
+    int i;
+
+    if (s->pci_dev == NULL) {
+        return;
+    }
+
+    if (!msi_enabled(s->pci_dev)) {
+        return;
+    }
+
+    /* Trigger MSI vectors associated to interrupts */
+    for (i = 0; i < NUM_MSI_IRQ; ++i) {
+        if (interrupt_reg & (1 << i)) {
+            msi_notify(s->pci_dev, s->msi_map[i]);
+        }
+    }
+}
+
+static void can_sja_update_pcie_msix(CanSJA1000State *s, uint8_t interrupt_reg)
+{
+    int i;
+
+    if (s->pci_dev == NULL) {
+        return;
+    }
+
+    if (!msix_enabled(s->pci_dev)) {
+        return;
+    }
+
+    /* Trigger MSI-X vectors associated to interrupts */
+    for (i = 0; i < NUM_MSIX_IRQ; ++i) {
+        if (interrupt_reg & (1 << i)) {
+            msix_notify(s->pci_dev, s->msix_map[i]);
+        }
+    }
+}
+
 static void can_sja_update_pel_irq(CanSJA1000State *s)
 {
     if (s->interrupt_en & s->interrupt_pel) {
         qemu_irq_raise(s->irq);
+
+        if (s->pci_dev && msi_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msi(s, s->interrupt_pel);
+        }
+
+        if (s->pci_dev && msix_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msix(s, s->interrupt_pel);
+        }
     } else {
         qemu_irq_lower(s->irq);
     }
@@ -414,6 +464,14 @@ static void can_sja_update_bas_irq(CanSJA1000State *s)
 {
     if ((s->control >> 1) & s->interrupt_bas) {
         qemu_irq_raise(s->irq);
+
+        if (msi_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msi(s, s->interrupt_pel);
+        }
+
+        if (msix_enabled(s->pci_dev)) {
+            can_sja_update_pcie_msix(s, s->interrupt_pel);
+        }
     } else {
         qemu_irq_lower(s->irq);
     }
@@ -916,8 +974,18 @@ void can_sja_disconnect(CanSJA1000State *s)
 
 int can_sja_init(CanSJA1000State *s, qemu_irq irq)
 {
+    int i;
     s->irq = irq;
 
+    s->pci_dev = NULL;
+    for (i = 0; i < NUM_MSI_IRQ; i++) {
+        s->msi_map[i] = 0;
+    }
+
+    for (i = 0; i < NUM_MSIX_IRQ; i++) {
+        s->msix_map[i] = 0;
+    }
+
     qemu_irq_lower(s->irq);
 
     can_sja_hardware_reset(s);
@@ -925,6 +993,29 @@ int can_sja_init(CanSJA1000State *s, qemu_irq irq)
     return 0;
 }
 
+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,
+                     uint8_t *msi_map, uint8_t *msix_map)
+{
+    int i;
+    can_sja_init(s, irq); /* Perform base init */
+
+    s->pci_dev = pci_dev;
+
+    if (msi_map) {
+        for (i = 0; i < NUM_MSI_IRQ; i++) {
+            s->msi_map[i] = msi_map[i];
+        }
+    }
+
+    if (msix_map) {
+        for (i = 0; i < NUM_MSIX_IRQ; i++) {
+            s->msix_map[i] = msix_map[i];
+        }
+    }
+
+    return 0;
+}
+
 const VMStateDescription vmstate_qemu_can_filter = {
     .name = "qemu_can_filter",
     .version_id = 1,
diff --git a/hw/net/can/can_sja1000.h b/hw/net/can/can_sja1000.h
index 7ca9cd681e..f016c37fd8 100644
--- a/hw/net/can/can_sja1000.h
+++ b/hw/net/can/can_sja1000.h
@@ -37,6 +37,10 @@
 /* The receive buffer size. */
 #define SJA_RCV_BUF_LEN       64
 
+/* Number of MSI/MSI-X interrupt vectors */
+#define NUM_MSI_IRQ           8
+#define NUM_MSIX_IRQ          NUM_MSI_IRQ
+
 typedef struct CanSJA1000State {
     /* PeliCAN state and registers sorted by address */
     uint8_t         mode;          /* 0  .. Mode register, DS-p26 */
@@ -68,6 +72,11 @@ typedef struct CanSJA1000State {
 
     qemu_irq          irq;
     CanBusClientState bus_client;
+
+    /* PCIe MSI */
+    PCIDevice       *pci_dev;
+    uint8_t         msi_map[NUM_MSI_IRQ];   /* MSI map entry to interrupt */
+    uint8_t         msix_map[NUM_MSIX_IRQ]; /* MSI-X map entry to interrupt */
 } CanSJA1000State;
 
 /* PeliCAN mode */
@@ -137,6 +146,9 @@ void can_sja_disconnect(CanSJA1000State *s);
 
 int can_sja_init(CanSJA1000State *s, qemu_irq irq);
 
+int can_sja_cap_init(CanSJA1000State *s, qemu_irq irq, PCIDevice *pci_dev,
+                     uint8_t *msi_map, uint8_t *msix_map);
+
 bool can_sja_can_receive(CanBusClientState *client);
 
 ssize_t can_sja_receive(CanBusClientState *client,
diff --git a/hw/net/can/meson.build b/hw/net/can/meson.build
index 7382344628..ee9cd692ff 100644
--- a/hw/net/can/meson.build
+++ b/hw/net/can/meson.build
@@ -2,6 +2,7 @@ system_ss.add(when: 'CONFIG_CAN_SJA1000', if_true: files('can_sja1000.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_kvaser_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm3680_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_mioe3680_pci.c'))
+system_ss.add(when: 'CONFIG_CAN_PCI', if_true: files('can_pcm26d2ca_pci.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD', if_true: files('ctucan_core.c'))
 system_ss.add(when: 'CONFIG_CAN_CTUCANFD_PCI', if_true: files('ctucan_pci.c'))
 system_ss.add(when: 'CONFIG_XLNX_ZYNQMP', if_true: files('xlnx-zynqmp-can.c'))
-- 
2.34.1


