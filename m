Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4B8792FC4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRo-0004wf-6v; Tue, 05 Sep 2023 16:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRm-0004vN-Cu; Tue, 05 Sep 2023 16:14:50 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRi-00038D-R3; Tue, 05 Sep 2023 16:14:50 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-500760b296aso290655e87.0; 
 Tue, 05 Sep 2023 13:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944884; x=1694549684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8sff0kDi7ewJlSnvd0fkQyO+2KmaSFxSHdiLSeMee0=;
 b=ifdIAPqpyH5rQF/4sTOhDd3GkA2jKHVhf9t6IxrUvtN2iy44bRq1woB4/t3q6uHTSy
 CMGhMyqcc1TQx62puiuqBpOIOxIC2vJwsge2gbJrKkeYVQNtliOGqAyxG08s06bjkrzp
 m9nHKo0CBM73YNuMcuOgZtk4GejH/1nPsk+BL+4+OP+sN8bhjDCKoQqA2VI7P1+wo9Uo
 h/bcnZbIJzuxb73fhVVvoI1rAl2CvtU5zA2x9Q+nY2VZy1bvTyeSD14+bfx1t0HURvCu
 nMkeod/YUCgKGRTcsMR2C5WQr+j5E5FXFi8vYVwqh9Hfw9pn4uALuzb0wDLTHGJumhKu
 puHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944884; x=1694549684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E8sff0kDi7ewJlSnvd0fkQyO+2KmaSFxSHdiLSeMee0=;
 b=gIoiqiwSSXINas1Wk/tzvt3dx2GQh2QP9m8pG/icPVeUWjYnYcB1WP0TZKpgX7tO5W
 FenwWsfBNd32XdO+EF/fXiyhTi5SszCiMF1Bvb0iHeNC07+L01SIayWG2zKsYpRpa85b
 EPMJTvj2/cEADPbq0R5icwVWLtxt3X9hu40tpRX9NatVguOg65iD64HqZF3mxgbSuW4N
 hftF9zr5/xTpIk5gWnrleU9gOWNpk61jdsBQyHHPuqEoaqHAEvISV6XcBuLaQAmCuw7D
 aHX8LQsQvjWIVddGLIM+n9IX9H1QMbKP15R1AqUALt0UewyfMe1M7Hd36dxU3Y5hEYO8
 p3Dg==
X-Gm-Message-State: AOJu0Ywjp1xFf6/UslPUTc6wjJpQBBdHzYrB4RPkc2DgGwTYG4tRNc27
 u3nyYniVK/uNEJ0H3+UJ0LxsyeU288tGOQ==
X-Google-Smtp-Source: AGHT+IEtdsNkr2HK9pWKXsOeD0LZaxYJmFBi4jMuVX6jXWa2FaxZxA/TMMU3AWw6Pcg63HhKWqV0qA==
X-Received: by 2002:a05:6512:308d:b0:500:b890:fb3c with SMTP id
 z13-20020a056512308d00b00500b890fb3cmr426120lfd.27.1693944884535; 
 Tue, 05 Sep 2023 13:14:44 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:44 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 5/5] hw/input: Add Allwinner-A10 PS2 emulation
Date: Tue,  5 Sep 2023 22:14:25 +0200
Message-Id: <20230905201425.118918-6-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add emulation for PS2-0 and PS2-1 for keyboard/mouse.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/arm/allwinner-a10.c               |  18 ++
 hw/input/allwinner-a10-ps2.c         | 345 +++++++++++++++++++++++++++
 hw/input/meson.build                 |   2 +
 include/hw/arm/allwinner-a10.h       |   3 +
 include/hw/input/allwinner-a10-ps2.h |  96 ++++++++
 5 files changed, 464 insertions(+)
 create mode 100644 hw/input/allwinner-a10-ps2.c
 create mode 100644 include/hw/input/allwinner-a10-ps2.h

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index f93bc5266d..3d25dbb4e3 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -40,6 +40,8 @@
 #define AW_A10_SATA_BASE        0x01c18000
 #define AW_A10_WDT_BASE         0x01c20c90
 #define AW_A10_RTC_BASE         0x01c20d00
+#define AW_A10_PS2_0_BASE       0x01c2a000
+#define AW_A10_PS2_1_BASE       0x01c2a400
 #define AW_A10_I2C0_BASE        0x01c2ac00
 #define AW_A10_LCDC0_BASE       0x01c0c000
 #define AW_A10_HDMI_BASE        0x01c16000
@@ -107,6 +109,12 @@ static void aw_a10_init(Object *obj)
     object_initialize_child(obj, "de_be0", &s->de_be0, TYPE_AW_A10_DEBE);
 
     object_initialize_child(obj, "mali400", &s->gpu, TYPE_AW_GPU);
+
+    object_initialize_child(obj, "keyboard", &s->kbd,
+                            TYPE_AW_A10_PS2_KBD_DEVICE);
+
+    object_initialize_child(obj, "mouse", &s->mouse,
+                            TYPE_AW_A10_PS2_MOUSE_DEVICE);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -243,6 +251,16 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     /* MALI GPU */
     sysbus_realize(SYS_BUS_DEVICE(&s->gpu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpu), 0, AW_A10_GPU_BASE);
+
+    /* PS2-0 - keyboard */
+    sysbus_realize(SYS_BUS_DEVICE(&s->kbd), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->kbd), 0, AW_A10_PS2_0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->kbd), 0, qdev_get_gpio_in(dev, 62));
+
+    /* PS2-1 - mouse */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mouse), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mouse), 0, AW_A10_PS2_1_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mouse), 0, qdev_get_gpio_in(dev, 63));
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/input/allwinner-a10-ps2.c b/hw/input/allwinner-a10-ps2.c
new file mode 100644
index 0000000000..c4b09c0ea3
--- /dev/null
+++ b/hw/input/allwinner-a10-ps2.c
@@ -0,0 +1,345 @@
+/*
+ * Allwinner A10 PS2 Module emulation
+ *
+ * Copyright (C) 2023 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "hw/input/allwinner-a10-ps2.h"
+#include "hw/input/ps2.h"
+#include "hw/irq.h"
+
+/* PS2 register offsets */
+enum {
+    REG_GCTL    = 0x0000, /* Global Control Reg */
+    REG_DATA    = 0x0004, /* Data Reg */
+    REG_LCTL    = 0x0008, /* Line Control Reg */
+    REG_LSTS    = 0x000C, /* Line Status Reg */
+    REG_FCTL    = 0x0010, /* FIFO Control Reg */
+    REG_FSTS    = 0x0014, /* FIFO Status Reg */
+    REG_CLKDR   = 0x0018, /* Clock Divider Reg */
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+/* PS2 register reset values */
+enum {
+    REG_GCTL_RST    = 0x00000002,
+    REG_DATA_RST    = 0x00000000,
+    REG_LCTL_RST    = 0x00000000,
+    REG_LSTS_RST    = 0x00030000,
+    REG_FCTL_RST    = 0x00000000,
+    REG_FSTS_RST    = 0x00000100,
+    REG_CLKDR_RST   = 0x00002F4F,
+};
+
+/* REG_GCTL Fields */
+#define FIELD_REG_GCTL_SOFT_RST     (1 << 2)
+#define FIELD_REG_GCTL_INT_EN       (1 << 3)
+#define FIELD_REG_GCTL_INT_FLAG     (1 << 4)
+
+/* REG_FCTL Fields */
+#define FIELD_REG_FCTL_RXRDY_IEN    (1 << 0)
+#define FIELD_REG_FCTL_TXRDY_IEN    (1 << 8)
+
+/* REG_FSTS Fields */
+#define FIELD_REG_FSTS_RX_RDY       (1 << 0)
+#define FIELD_REG_FSTS_TX_RDY       (1 << 8)
+#define FIELD_REG_FSTS_RX_LEVEL1    (1 << 16)
+
+static int allwinner_a10_ps2_fctl_is_irq(AwA10PS2State *s)
+{
+    return (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_TXRDY_IEN) ||
+        (s->pending &&
+         (s->regs[REG_INDEX(REG_FCTL)] & FIELD_REG_FCTL_RXRDY_IEN));
+}
+
+static void allwinner_a10_ps2_update_irq(AwA10PS2State *s)
+{
+    int level = (s->regs[REG_INDEX(REG_GCTL)] & FIELD_REG_GCTL_INT_EN) &&
+        allwinner_a10_ps2_fctl_is_irq(s);
+
+    qemu_set_irq(s->irq, level);
+}
+
+static void allwinner_a10_ps2_set_irq(void *opaque, int n, int level)
+{
+    AwA10PS2State *s = (AwA10PS2State *)opaque;
+
+    s->pending = level;
+    allwinner_a10_ps2_update_irq(s);
+}
+
+static uint64_t allwinner_a10_ps2_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    AwA10PS2State *s = AW_A10_PS2(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case REG_FSTS:
+        {
+            uint32_t stat = FIELD_REG_FSTS_TX_RDY;
+            if (s->pending) {
+                stat |= FIELD_REG_FSTS_RX_LEVEL1 | FIELD_REG_FSTS_RX_RDY;
+            }
+            return stat;
+        }
+        break;
+    case REG_DATA:
+        if (s->pending) {
+            s->last = ps2_read_data(s->ps2dev);
+        }
+        return s->last;
+    case REG_GCTL:
+        {
+            if (allwinner_a10_ps2_fctl_is_irq(s)) {
+                s->regs[idx] |= FIELD_REG_GCTL_INT_FLAG;
+            } else {
+                s->regs[idx] &= FIELD_REG_GCTL_INT_FLAG;
+            }
+        }
+        break;
+    case REG_LCTL:
+    case REG_LSTS:
+    case REG_FCTL:
+    case REG_CLKDR:
+        break;
+    case 0x1C ... AW_A10_PS2_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented read offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        return 0;
+    }
+
+    return s->regs[idx];
+}
+
+static void allwinner_a10_ps2_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwA10PS2State *s = AW_A10_PS2(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    s->regs[idx] = (uint32_t) val;
+
+    switch (offset) {
+    case REG_GCTL:
+        allwinner_a10_ps2_update_irq(s);
+        s->regs[idx] &= ~FIELD_REG_GCTL_SOFT_RST;
+        break;
+    case REG_DATA:
+        /* ??? This should toggle the TX interrupt line.  */
+        /* ??? This means kbd/mouse can block each other.  */
+        if (s->is_mouse) {
+            ps2_write_mouse(PS2_MOUSE_DEVICE(s->ps2dev), val);
+        } else {
+            ps2_write_keyboard(PS2_KBD_DEVICE(s->ps2dev), val);
+        }
+        break;
+    case REG_LCTL:
+    case REG_LSTS:
+    case REG_FCTL:
+    case REG_FSTS:
+    case REG_CLKDR:
+        break;
+    case 0x1C ... AW_A10_PS2_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimplemented write offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    }
+}
+
+static const MemoryRegionOps allwinner_a10_ps2_ops = {
+    .read = allwinner_a10_ps2_read,
+    .write = allwinner_a10_ps2_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static const VMStateDescription allwinner_a10_ps2_vmstate = {
+    .name = "allwinner-a10-ps2",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwA10PS2State, AW_A10_PS2_REGS_NUM),
+        VMSTATE_INT32(pending, AwA10PS2State),
+        VMSTATE_UINT32(last, AwA10PS2State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_a10_ps2_realize(DeviceState *dev, Error **errp)
+{
+    AwA10PS2State *s = AW_A10_PS2(dev);
+
+    qdev_connect_gpio_out(DEVICE(s->ps2dev), PS2_DEVICE_IRQ,
+                          qdev_get_gpio_in_named(dev, "ps2-input-irq", 0));
+}
+
+static void allwinner_a10_ps2_kbd_realize(DeviceState *dev, Error **errp)
+{
+    AwA10PS2DeviceClass *pdc = AW_A10_PS2_GET_CLASS(dev);
+    AwA10PS2KbdState *s = AW_A10_PS2_KBD_DEVICE(dev);
+    AwA10PS2State *ps = AW_A10_PS2(dev);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->kbd), errp)) {
+        return;
+    }
+
+    ps->ps2dev = PS2_DEVICE(&s->kbd);
+    pdc->parent_realize(dev, errp);
+}
+
+static void allwinner_a10_ps2_kbd_init(Object *obj)
+{
+    AwA10PS2KbdState *s = AW_A10_PS2_KBD_DEVICE(obj);
+    AwA10PS2State *ps = AW_A10_PS2(obj);
+
+    ps->is_mouse = false;
+    object_initialize_child(obj, "kbd", &s->kbd, TYPE_PS2_KBD_DEVICE);
+}
+
+static void allwinner_a10_ps2_mouse_realize(DeviceState *dev, Error **errp)
+{
+    AwA10PS2DeviceClass *pdc = AW_A10_PS2_GET_CLASS(dev);
+    AwA10PS2MouseState *s = AW_A10_PS2_MOUSE_DEVICE(dev);
+    AwA10PS2State *ps = AW_A10_PS2(dev);
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->mouse), errp)) {
+        return;
+    }
+
+    ps->ps2dev = PS2_DEVICE(&s->mouse);
+    pdc->parent_realize(dev, errp);
+}
+
+static void allwinner_a10_ps2_mouse_init(Object *obj)
+{
+    AwA10PS2MouseState *s = AW_A10_PS2_MOUSE_DEVICE(obj);
+    AwA10PS2State *ps = AW_A10_PS2(obj);
+
+    ps->is_mouse = true;
+    object_initialize_child(obj, "mouse", &s->mouse, TYPE_PS2_MOUSE_DEVICE);
+}
+
+static void allwinner_a10_ps2_kbd_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AwA10PS2DeviceClass *pdc = AW_A10_PS2_CLASS(oc);
+
+    device_class_set_parent_realize(dc, allwinner_a10_ps2_kbd_realize,
+                                    &pdc->parent_realize);
+}
+
+static const TypeInfo allwinner_a10_ps2_kbd_info = {
+    .name          = TYPE_AW_A10_PS2_KBD_DEVICE,
+    .parent        = TYPE_AW_A10_PS2,
+    .instance_init = allwinner_a10_ps2_kbd_init,
+    .instance_size = sizeof(AwA10PS2KbdState),
+    .class_init    = allwinner_a10_ps2_kbd_class_init,
+};
+
+static void allwinner_a10_ps2_mouse_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    AwA10PS2DeviceClass *pdc = AW_A10_PS2_CLASS(oc);
+
+    device_class_set_parent_realize(dc, allwinner_a10_ps2_mouse_realize,
+                                    &pdc->parent_realize);
+}
+
+static const TypeInfo allwinner_a10_ps2_mouse_info = {
+    .name          = TYPE_AW_A10_PS2_MOUSE_DEVICE,
+    .parent        = TYPE_AW_A10_PS2,
+    .instance_init = allwinner_a10_ps2_mouse_init,
+    .instance_size = sizeof(AwA10PS2MouseState),
+    .class_init    = allwinner_a10_ps2_mouse_class_init,
+};
+
+static void allwinner_a10_ps2_reset_enter(Object *obj, ResetType type)
+{
+    AwA10PS2State *s = AW_A10_PS2(obj);
+
+    /* Set default values for registers */
+    s->regs[REG_INDEX(REG_GCTL)] = REG_GCTL_RST;
+    s->regs[REG_INDEX(REG_DATA)] = REG_DATA_RST;
+    s->regs[REG_INDEX(REG_LCTL)] = REG_LCTL_RST;
+    s->regs[REG_INDEX(REG_LSTS)] = REG_LSTS_RST;
+    s->regs[REG_INDEX(REG_FCTL)] = REG_FCTL_RST;
+    s->regs[REG_INDEX(REG_FSTS)] = REG_FSTS_RST;
+    s->regs[REG_INDEX(REG_CLKDR)] = REG_CLKDR_RST;
+}
+
+static void allwinner_a10_ps2_init(Object *obj)
+{
+    AwA10PS2State *s = AW_A10_PS2(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    memory_region_init_io(&s->iomem, obj, &allwinner_a10_ps2_ops, s,
+                          "allwinner-a10-ps2", AW_A10_PS2_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+
+    qdev_init_gpio_in_named(DEVICE(obj), allwinner_a10_ps2_set_irq,
+                            "ps2-input-irq", 1);
+}
+
+static void allwinner_a10_ps2_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    ResettableClass *rc = RESETTABLE_CLASS(oc);
+
+    rc->phases.enter = allwinner_a10_ps2_reset_enter;
+    dc->realize = allwinner_a10_ps2_realize;
+    dc->vmsd = &allwinner_a10_ps2_vmstate;
+}
+
+static const TypeInfo allwinner_a10_ps2_type_info = {
+    .name          = TYPE_AW_A10_PS2,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_a10_ps2_init,
+    .instance_size = sizeof(AwA10PS2State),
+    .class_init    = allwinner_a10_ps2_class_init,
+    .class_size    = sizeof(AwA10PS2DeviceClass),
+    .abstract      = true,
+    .class_init    = allwinner_a10_ps2_class_init,
+};
+
+static void allwinner_a10_ps2_register_types(void)
+{
+    type_register_static(&allwinner_a10_ps2_type_info);
+    type_register_static(&allwinner_a10_ps2_kbd_info);
+    type_register_static(&allwinner_a10_ps2_mouse_info);
+}
+
+type_init(allwinner_a10_ps2_register_types)
diff --git a/hw/input/meson.build b/hw/input/meson.build
index c0d4482180..b7bf4d9c9a 100644
--- a/hw/input/meson.build
+++ b/hw/input/meson.build
@@ -16,3 +16,5 @@ system_ss.add(when: 'CONFIG_VHOST_USER_INPUT', if_true: files('vhost-user-input.
 system_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx_keypad.c'))
 system_ss.add(when: 'CONFIG_TSC210X', if_true: files('tsc210x.c'))
 system_ss.add(when: 'CONFIG_LASIPS2', if_true: files('lasips2.c'))
+
+system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-ps2.c'))
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index c99ca6c1c4..163cc3af2b 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -17,6 +17,7 @@
 #include "hw/display/allwinner-a10-lcdc.h"
 #include "hw/display/allwinner-gpu.h"
 #include "hw/i2c/allwinner-i2c.h"
+#include "hw/input/allwinner-a10-ps2.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "sysemu/block-backend.h"
 
@@ -51,6 +52,8 @@ struct AwA10State {
     AwGpuState gpu;
     AwA10HdmiState hdmi;
     AwA10LcdcState lcd0;
+    AwA10PS2KbdState kbd;
+    AwA10PS2MouseState mouse;
     MemoryRegion sram_a;
     EHCISysBusState ehci[AW_A10_NUM_USB];
     OHCISysBusState ohci[AW_A10_NUM_USB];
diff --git a/include/hw/input/allwinner-a10-ps2.h b/include/hw/input/allwinner-a10-ps2.h
new file mode 100644
index 0000000000..230026bf28
--- /dev/null
+++ b/include/hw/input/allwinner-a10-ps2.h
@@ -0,0 +1,96 @@
+/*
+ * Allwinner A10 PS2 Module emulation
+ *
+ * Copyright (C) 2023 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_INPUT_ALLWINNER_A10_PS2_H
+#define HW_INPUT_ALLWINNER_A10_PS2_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/input/ps2.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by CCM device */
+#define AW_A10_PS2_IOSIZE        (0x400)
+
+/** Total number of known registers */
+#define AW_A10_PS2_REGS_NUM      (AW_A10_PS2_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+struct AwA10PS2DeviceClass {
+    SysBusDeviceClass parent_class;
+
+    DeviceRealize parent_realize;
+};
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_A10_PS2    "allwinner-a10-ps2"
+OBJECT_DECLARE_TYPE(AwA10PS2State, AwA10PS2DeviceClass, AW_A10_PS2)
+
+/** @} */
+
+/**
+ * Allwinner A10 PS2 object instance state.
+ */
+struct AwA10PS2State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    PS2State *ps2dev;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_A10_PS2_REGS_NUM];
+    int pending;
+    uint32_t last;
+    qemu_irq irq;
+    bool is_mouse;
+};
+
+#define TYPE_AW_A10_PS2_KBD_DEVICE "allwinner-a10-ps2-keyboard"
+OBJECT_DECLARE_SIMPLE_TYPE(AwA10PS2KbdState, AW_A10_PS2_KBD_DEVICE)
+
+struct AwA10PS2KbdState {
+    AwA10PS2State parent_obj;
+
+    PS2KbdState kbd;
+};
+
+#define TYPE_AW_A10_PS2_MOUSE_DEVICE "allwinner-a10-ps2-mouse"
+OBJECT_DECLARE_SIMPLE_TYPE(AwA10PS2MouseState, AW_A10_PS2_MOUSE_DEVICE)
+
+struct AwA10PS2MouseState {
+    AwA10PS2State parent_obj;
+
+    PS2MouseState mouse;
+};
+
+
+#endif /* HW_INPUT_ALLWINNER_A10_PS2_H */
-- 
2.34.1


