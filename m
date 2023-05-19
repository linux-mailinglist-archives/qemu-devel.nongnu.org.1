Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AB0709AB7
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:58:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01RN-0000Ch-GE; Fri, 19 May 2023 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liavalb@gmail.com>) id 1q01RG-0008O9-J7
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liavalb@gmail.com>) id 1q01RE-0003YW-Ay
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:38 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f41d087b3bso33868345e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684507834; x=1687099834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mOwlN1Q032pNnmA3nidmiPMfdvFGowAhsAf7+Df+MQ=;
 b=aSjPU6o+Fp4KYYI7TITq1bRJ9iY5ZcIlqarzfTocDdC87X3ihgMLzeQsOFxMpytlaA
 cRj7gz8ydDdF+F1l+v6rnZqtZKENKU9FEi0Mnh0XwZPhBUxLtZsToM6zjxQwCLBVMBCH
 vO3SU07ebFTGBxvCcl79vRI5MWzEvlLWGP1MyX8qrn0DPz1CzDPT80JCeWaAU5DEU9Va
 DLvQyk+qvIcjl8GLhT1SrNzKMPmao/uIgVyyMfyBk2FDYW6Zx6scy+TW+QXKgN3hIySd
 MnmNUgzho5EV/8kGp2ove6tp2xhY+aozpN+QFRU0HhMQuSnlmsS7EL6Bc07bjrCy3Nvo
 2htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507834; x=1687099834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mOwlN1Q032pNnmA3nidmiPMfdvFGowAhsAf7+Df+MQ=;
 b=gAoweYYpm6cIwUgTpKjdWEnw9gtVsWvCclMMDKPax1/XwbLBhFIT5tTkYNucdC5Wrr
 nE93Q4kYp1MphJ262B+gjk8lw1uTWTqlBNK3jt74P+GeaVWZTfmqviZ5scNOaFyWoshz
 CzLYLeuI/8Jk0A//KS7t+56Aw3i6NCrGcHe8IOFe0ImrjmxnDfAn1XtgMO6OTv34g5k6
 LbXzTch3PLz7/MD3rwxiuxiz29HP49AB12jnqdBmVu61zu1pakf/7mYe2z10H1cZwTcc
 6yYmYlLHubhrI5z2Rnp86N9xCCVf85ndYFOxTcaze2VGLdAxe/qGy+hoLfvoevZfDXIt
 xF3g==
X-Gm-Message-State: AC+VfDydM1c50ZPA6LSad/0oIxn1KO/fIu4de/pvIoHftK9P5BVCL8UL
 BfH9L/yKMp2Lo83Ipp8QRkEeuYwXcWg=
X-Google-Smtp-Source: ACHHUZ6G1kA+ek6IV15IQR9VKgPKVreUWCq2g546z44B9lxKdKBo1jgktIXjHlOeWDYRU8fuVOpv1g==
X-Received: by 2002:a05:600c:299:b0:3f1:952a:4bf0 with SMTP id
 25-20020a05600c029900b003f1952a4bf0mr1577387wmk.33.1684507833466; 
 Fri, 19 May 2023 07:50:33 -0700 (PDT)
Received: from liavpc.localdomain ([2a06:c701:433c:c01:70:9d02:6925:e2f7])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a05600c21c600b003f4fbd9cdb3sm2623534wmj.34.2023.05.19.07.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:33 -0700 (PDT)
From: Liav Albani <liavalb@gmail.com>
To: qemu-devel@nongnu.org
Cc: Liav Albani <liavalb@gmail.com>
Subject: [RFC 1/1] hw/input: add basic support for a PCI PS/2 controller
Date: Fri, 19 May 2023 17:50:26 +0300
Message-Id: <20230519145026.235592-2-liavalb@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519145026.235592-1-liavalb@gmail.com>
References: <20230519145026.235592-1-liavalb@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=liavalb@gmail.com; helo=mail-wm1-x335.google.com
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

The linux pcips2 driver is responsible for driving this device.

Signed-off-by: Liav Albani <liavalb@gmail.com>
---
 hw/i386/Kconfig           |   1 +
 hw/input/Kconfig          |   5 +
 hw/input/meson.build      |   2 +
 hw/input/ps2pci.c         | 282 ++++++++++++++++++++++++++++++++++++++
 include/hw/input/ps2pci.h |  52 +++++++
 5 files changed, 342 insertions(+)
 create mode 100644 hw/input/ps2pci.c
 create mode 100644 include/hw/input/ps2pci.h

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d40802d..dad6188 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -36,6 +36,7 @@ config PC
     select I8259
     select I8254
     select PCKBD
+    select PS2PCI
     select PCSPK
     select I8257
     select MC146818RTC
diff --git a/hw/input/Kconfig b/hw/input/Kconfig
index 55865bb..04c97e8 100644
--- a/hw/input/Kconfig
+++ b/hw/input/Kconfig
@@ -17,6 +17,11 @@ config PL050
     bool
     select PS2
 
+config PS2PCI
+    bool
+    depends on PCI
+    select PS2
+
 config PS2
     bool
 
diff --git a/hw/input/meson.build b/hw/input/meson.build
index 8deb011..4fa1462 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -16,3 +16,5 @@ softmmu_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input
 softmmu_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
 softmmu_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
 softmmu_ss.add(when: 'CONFIG_LASIPS2', if_true: files('lasips2.c'))
+
+softmmu_ss.add(when: 'CONFIG_PS2PCI', if_true: files('ps2pci.c'))
diff --git a/hw/input/ps2pci.c b/hw/input/ps2pci.c
new file mode 100644
index 0000000..4340af1
--- /dev/null
+++ b/hw/input/ps2pci.c
@@ -0,0 +1,282 @@
+/*
+ * QEMU PCI PS/2 adapter.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qemu/units.h"
+#include "hw/pci/pci_device.h"
+#include "hw/input/ps2pci.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/irq.h"
+#include "qapi/error.h"
+#include "qom/object.h"
+#include "qemu/log.h"
+
+static const VMStateDescription vmstate_ps2_pci = {
+    .name = "ps2-pci",
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_DEVICE(parent_obj, PS2PCIState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+#define PS2_CTRL		(0)
+#define PS2_STATUS		(1)
+#define PS2_DATA		(2)
+
+#define PS2_CTRL_CLK		(1<<0)
+#define PS2_CTRL_DAT		(1<<1)
+#define PS2_CTRL_TXIRQ		(1<<2)
+#define PS2_CTRL_ENABLE		(1<<3)
+#define PS2_CTRL_RXIRQ		(1<<4)
+
+#define PS2_STAT_CLK		(1<<0)
+#define PS2_STAT_DAT		(1<<1)
+#define PS2_STAT_PARITY		(1<<2)
+#define PS2_STAT_RXFULL		(1<<5)
+#define PS2_STAT_TXBUSY		(1<<6)
+#define PS2_STAT_TXEMPTY	(1<<7)
+
+static void ps2_pci_update_irq(PS2PCIState *s)
+{
+    int level = (s->pending && (s->cr & PS2_CTRL_RXIRQ) != 0)
+                 || (s->cr & PS2_CTRL_TXIRQ) != 0;
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void ps2_pci_set_irq(void *opaque, int n, int level)
+{
+    PS2PCIState *s = (PS2PCIState *)opaque;
+
+    s->pending = level;
+    ps2_pci_update_irq(s);
+}
+
+static uint64_t ps2_pci_io_read(void *opaque, hwaddr offset,
+                           unsigned size)
+{
+    PS2PCIState *s = (PS2PCIState*)opaque;
+    switch (offset) {
+    case PS2_CTRL: /* CTRL */
+        return s->cr;
+    case PS2_STATUS: /* STATUS */
+        {
+            uint32_t stat = 0;
+            if (s->pending)
+                stat = PS2_STAT_RXFULL;
+            else
+                stat = PS2_STAT_TXEMPTY;
+            uint8_t val = 0;
+            val = s->last;
+            val = val ^ (val >> 4);
+            val = val ^ (val >> 2);
+            val = (val ^ (val >> 1)) & 1;
+            if (val) {
+                stat |= PS2_STAT_PARITY;
+            }
+            return stat;
+        }
+    case PS2_DATA: /* DATA */
+        if (s->pending && s->cr & PS2_CTRL_ENABLE) {
+            s->last = ps2_read_data(s->ps2dev);
+            if (ps2_queue_empty(s->ps2dev))
+                s->pending = 0;
+        } else {
+            return 0;
+        }
+        return s->last;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ps2_pci_io_read: Bad offset %x\n", (int)offset);
+        return 0;
+    }
+}
+
+static void ps2_pci_io_write(void *opaque, hwaddr offset,
+                        uint64_t value, unsigned size)
+{
+    PS2PCIState *s = (PS2PCIState *)opaque;
+    switch (offset) {
+    case PS2_CTRL: /* CTRL */
+        s->cr = value;
+        break;
+    case PS2_STATUS: /* STATUS */
+        break;
+    case PS2_DATA: /* DATA */
+        if (s->cr & PS2_CTRL_ENABLE) {
+            if (s->is_mouse) {
+                ps2_write_mouse(PS2_MOUSE_DEVICE(s->ps2dev), value);
+            } else {
+                ps2_write_keyboard(PS2_KBD_DEVICE(s->ps2dev), value);
+            }
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "ps2_pci_io_write: Bad offset %x\n", (int)offset);
+    }
+}
+
+static const MemoryRegionOps ps2_pci_io_ops = {
+    .read = ps2_pci_io_read,
+    .write = ps2_pci_io_write,
+    .valid.min_access_size = 1,
+    .valid.max_access_size = 4,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+};
+
+static void ps2_pci_realize_common(PCIDevice *dev, Error **errp)
+{
+    PS2PCIState *s = PS2_PCI(dev);
+    Object *obj = OBJECT(dev);
+    int ret;
+
+    uint8_t *pci_conf = dev->config;
+    pci_conf[PCI_INTERRUPT_PIN] = 1; /* interrupt pin A */
+
+    s->irq = pci_allocate_irq(&s->parent_obj);
+    memory_region_init_io(&s->io, obj, &ps2_pci_io_ops, s,
+                          "ps2-pci-io", 16);
+    pci_set_byte(&s->parent_obj.config[PCI_REVISION_ID], 0);
+    pci_register_bar(&s->parent_obj, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io);
+
+    if (pci_bus_is_express(pci_get_bus(dev))) {
+        ret = pcie_endpoint_cap_init(dev, 0x80);
+        assert(ret > 0);
+    } else {
+        dev->cap_present &= ~QEMU_PCI_CAP_EXPRESS;
+    }
+    qdev_connect_gpio_out(DEVICE(s->ps2dev), PS2_DEVICE_IRQ,
+                       qdev_get_gpio_in_named((DeviceState*)dev, "ps2-input-irq", 0));
+}
+
+static void ps2_pci_keyboard_realize(PCIDevice *dev, Error **errp)
+{
+    PS2PCIKbdState *s = PS2_PCI_KBD_DEVICE(dev);
+    PS2PCIState *ps = PS2_PCI(dev);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
+        return;
+    }
+
+    ps->ps2dev = PS2_DEVICE(&s->kbd);
+    ps2_pci_realize_common(dev, errp);
+}
+
+static void ps2_pci_mouse_realize(PCIDevice *dev, Error **errp)
+{
+    PS2PCIMouseState *s = PS2_PCI_MOUSE_DEVICE(dev);
+    PS2PCIState *ps = PS2_PCI(dev);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mouse), errp)) {
+        return;
+    }
+
+    ps->ps2dev = PS2_DEVICE(&s->mouse);
+    ps2_pci_realize_common(dev, errp);
+}
+
+static void ps2_pci_kbd_init(Object *obj)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PS2PCIKbdState *s = PS2_PCI_KBD_DEVICE(obj);
+    PS2PCIState *ps = PS2_PCI(obj);
+
+    ps->is_mouse = false;
+    object_initialize_child(obj, "kbd", &s->kbd, TYPE_PS2_KBD_DEVICE);
+
+    dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+    
+    qdev_init_gpio_out(DEVICE(obj), &ps->irq, 1);
+    qdev_init_gpio_in_named(DEVICE(obj), ps2_pci_set_irq,
+                            "ps2-input-irq", 1);
+}
+
+static void ps2_pci_mouse_init(Object *obj)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    PS2PCIMouseState *s = PS2_PCI_MOUSE_DEVICE(obj);
+    PS2PCIState *ps = PS2_PCI(obj);
+
+    ps->is_mouse = true;
+    object_initialize_child(obj, "mouse", &s->mouse, TYPE_PS2_MOUSE_DEVICE);
+
+    dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
+    
+    qdev_init_gpio_out(DEVICE(obj), &ps->irq, 1);
+    qdev_init_gpio_in_named(DEVICE(obj), ps2_pci_set_irq,
+                            "ps2-input-irq", 1);
+}
+
+static void ps2_pci_keyboard_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->class_id  = PCI_CLASS_INPUT_KEYBOARD;
+    k->vendor_id = 0x14f2;
+    k->device_id = 0x0123;
+
+    k->realize   = ps2_pci_keyboard_realize;
+    k->exit      = NULL;
+    dc->vmsd     = &vmstate_ps2_pci;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static void ps2_pci_mouse_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->class_id  = PCI_CLASS_INPUT_MOUSE;
+    k->vendor_id = 0x14f2;
+    k->device_id = 0x0124;
+
+    k->realize   = ps2_pci_mouse_realize;
+    k->exit      = NULL;
+    dc->vmsd     = &vmstate_ps2_pci;
+    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
+}
+
+static const TypeInfo ps2_pci_keyboard_type_info = {
+    .name           = TYPE_PS2_PCI_KBD_DEVICE,
+    .parent         = TYPE_PS2_PCI,
+    .instance_size  = sizeof(PS2PCIKbdState),
+    .instance_init  = ps2_pci_kbd_init,
+    .class_init     = ps2_pci_keyboard_class_init,
+};
+
+static const TypeInfo ps2_pci_mouse_type_info = {
+    .name           = TYPE_PS2_PCI_MOUSE_DEVICE,
+    .parent         = TYPE_PS2_PCI,
+    .instance_size  = sizeof(PS2PCIMouseState),
+    .instance_init  = ps2_pci_mouse_init,
+    .class_init     = ps2_pci_mouse_class_init,
+};
+
+static const TypeInfo ps2_pci_type_info = {
+    .name           = TYPE_PS2_PCI,
+    .parent         = TYPE_PCI_DEVICE,
+    .instance_size  = sizeof(PS2PCIState),
+    .abstract       = true,
+    .interfaces     = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
+};
+
+static void ps2_pci_register_types(void)
+{
+    type_register_static(&ps2_pci_keyboard_type_info);
+    type_register_static(&ps2_pci_mouse_type_info);
+    type_register_static(&ps2_pci_type_info);
+}
+
+type_init(ps2_pci_register_types)
diff --git a/include/hw/input/ps2pci.h b/include/hw/input/ps2pci.h
new file mode 100644
index 0000000..68a8c40
--- /dev/null
+++ b/include/hw/input/ps2pci.h
@@ -0,0 +1,52 @@
+/*
+ * QEMU PCI PS/2 adapter.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_PS2_PCI_H
+#define HW_PS2_PCI_H
+
+#include "hw/input/ps2.h"
+
+#define TYPE_PS2_PCI "ps2-pci"
+
+OBJECT_DECLARE_SIMPLE_TYPE(PS2PCIState, PS2_PCI)
+
+struct PS2PCIState {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    MemoryRegion     io;
+
+    PS2State *ps2dev;
+    uint32_t cr;
+    uint32_t clk;
+    uint32_t last;
+    int pending;
+    qemu_irq irq;
+    bool is_mouse;
+};
+
+#define TYPE_PS2_PCI_KBD_DEVICE "ps2-pci-keyboard"
+OBJECT_DECLARE_SIMPLE_TYPE(PS2PCIKbdState, PS2_PCI_KBD_DEVICE)
+
+struct PS2PCIKbdState {
+    PS2PCIState parent_obj;
+
+    PS2KbdState kbd;
+};
+
+#define TYPE_PS2_PCI_MOUSE_DEVICE "ps2-pci-mouse"
+OBJECT_DECLARE_SIMPLE_TYPE(PS2PCIMouseState, PS2_PCI_MOUSE_DEVICE)
+
+struct PS2PCIMouseState {
+    PS2PCIState parent_obj;
+
+    PS2MouseState mouse;
+};
+
+
+#endif /* HW_PS2_PCI_H */
-- 
2.40.1


