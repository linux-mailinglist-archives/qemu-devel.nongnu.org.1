Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1FE792FC2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRo-0004wC-0M; Tue, 05 Sep 2023 16:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRm-0004vL-8P; Tue, 05 Sep 2023 16:14:50 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRh-000381-GI; Tue, 05 Sep 2023 16:14:49 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50079d148aeso4929304e87.3; 
 Tue, 05 Sep 2023 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944883; x=1694549683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=foOqzdGL/WyOe8+wQYwqhAt/YwvOYCJgK4mxkX6LADc=;
 b=K1G3T/NhIYc6yLCS/lGzjapygPTIf3u/bwqc/51XGEJhh6zw5RxX4UNhB7mn9o7Uog
 Yls1bmn2B2gE2euw0xJ5V/nLYlB380cwZsZxaSuvrbPL83ZTgdON9dWQuWxWYCJ5NZ5U
 jQSsBLMClfOMU1xVCG90Z1tjkld0N4Bl6X9291l6wb67D91jM5jbqynvFgOOGnN7mY27
 AjAlFOk993CL3V0cXDvvjrv7mxhFchVcZpUngnHrOhcNvE4KHYTH0LX0SpRUERH3x7uc
 bsAUdaZ3EwygRnhHtCeA9wDF4DwIHdEOpa8/W6fYNjJVnLPLnjHLBOyxZSaVnZPhZkLF
 BA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944883; x=1694549683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=foOqzdGL/WyOe8+wQYwqhAt/YwvOYCJgK4mxkX6LADc=;
 b=BMA0kIlXWsKCGJNNegriipP2rGDyZuYXzn1pHh9F6GBCFony6OYwtVLc89TgbktkIN
 yuzVGcYB7AID7AkBfTM/vkDjcxCfan+qSCovN6IecWsBvT1U2scFgq5fjhkUVDxPvDKd
 0j+sl0qlcbtJq4i2W/tZaxYMUvk0SbYwVVAHM1E4mWstzRbCnfy7x1ITgnWizfkVIgqJ
 jtf6pRcy49pgP5krEYaWlSVh1o2/Ar/JHln5xRFbZ8oLCjrOvQw+jIRYoDD+uKZZ/kgX
 VOaJpV9MeN10iLYiVAQnOK94Za/0xgGqizrh7eB+fh7T4IHL06h4LhTNraHcyW6ab019
 cgxQ==
X-Gm-Message-State: AOJu0YxGqABaTjqw/fq5VX/KhAQzVP3gTUrqRK5qiW5ztwPy/QRzpQnB
 2JEWxuPswuMvflbk5owXJ7CpUYF3yTdCRw==
X-Google-Smtp-Source: AGHT+IGB+5P+M83dB+6lYLoXYxvmnH8+bszhskQa6PEBala70BsCh98fDkcV7NmfuMSEpUBcHFuvZQ==
X-Received: by 2002:a19:6441:0:b0:4ff:9a75:211e with SMTP id
 b1-20020a196441000000b004ff9a75211emr504479lfj.42.1693944883068; 
 Tue, 05 Sep 2023 13:14:43 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:42 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 4/5] hw/display: Allwinner A10 LCDC emulation
Date: Tue,  5 Sep 2023 22:14:24 +0200
Message-Id: <20230905201425.118918-5-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x12d.google.com
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

This patch adds support for Allwinner A10 LCD controller.
Current emulation supports only RGB32 colorspace and interacts with
DEBE0 to obtain framebuffer address and screen size.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/arm/allwinner-a10.c                  |  10 +
 hw/display/allwinner-a10-lcdc.c         | 275 ++++++++++++++++++++++++
 hw/display/meson.build                  |   1 +
 hw/display/trace-events                 |   5 +
 include/hw/arm/allwinner-a10.h          |   2 +
 include/hw/display/allwinner-a10-lcdc.h |  77 +++++++
 6 files changed, 370 insertions(+)
 create mode 100644 hw/display/allwinner-a10-lcdc.c
 create mode 100644 include/hw/display/allwinner-a10-lcdc.h

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 624e95af46..f93bc5266d 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -41,6 +41,7 @@
 #define AW_A10_WDT_BASE         0x01c20c90
 #define AW_A10_RTC_BASE         0x01c20d00
 #define AW_A10_I2C0_BASE        0x01c2ac00
+#define AW_A10_LCDC0_BASE       0x01c0c000
 #define AW_A10_HDMI_BASE        0x01c16000
 #define AW_A10_GPU_BASE         0x01c40000
 #define AW_A10_DE_BE0_BASE      0x01e60000
@@ -101,6 +102,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "hdmi", &s->hdmi, TYPE_AW_A10_HDMI);
 
+    object_initialize_child(obj, "lcd0", &s->lcd0, TYPE_AW_A10_LCDC);
+
     object_initialize_child(obj, "de_be0", &s->de_be0, TYPE_AW_A10_DEBE);
 
     object_initialize_child(obj, "mali400", &s->gpu, TYPE_AW_GPU);
@@ -230,6 +233,13 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->de_be0), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->de_be0), 0, AW_A10_DE_BE0_BASE);
 
+    /* LCD Controller */
+    object_property_set_link(OBJECT(&s->lcd0), "debe",
+                             OBJECT(&s->de_be0), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->lcd0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->lcd0), 0, AW_A10_LCDC0_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->lcd0), 0, qdev_get_gpio_in(dev, 44));
+
     /* MALI GPU */
     sysbus_realize(SYS_BUS_DEVICE(&s->gpu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpu), 0, AW_A10_GPU_BASE);
diff --git a/hw/display/allwinner-a10-lcdc.c b/hw/display/allwinner-a10-lcdc.c
new file mode 100644
index 0000000000..8367ac32be
--- /dev/null
+++ b/hw/display/allwinner-a10-lcdc.c
@@ -0,0 +1,275 @@
+/*
+ * Allwinner A10 LCD Control Module emulation
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
+#include "hw/qdev-properties.h"
+#include "qemu/module.h"
+#include "hw/display/allwinner-a10-lcdc.h"
+#include "hw/irq.h"
+#include "ui/pixel_ops.h"
+#include "trace.h"
+#include "sysemu/dma.h"
+#include "framebuffer.h"
+
+/* LCDC register offsets */
+enum {
+    REG_TCON_GCTL       = 0x0000, /* TCON Global control register */
+    REG_TCON_GINT0      = 0x0004, /* TCON Global interrupt register 0 */
+};
+
+/* TCON_GCTL register fields */
+#define REG_TCON_GCTL_EN        (1 << 31)
+
+/* TCON_GINT0 register fields */
+#define REG_TCON_GINT0_VB_INT_EN    (1 << 31)
+#define REG_TCON_GINT0_VB_INT_FLAG  (1 << 14)
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+static void allwinner_a10_lcdc_tick(void *opaque)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(opaque);
+
+    if (s->regs[REG_INDEX(REG_TCON_GINT0)] & REG_TCON_GINT0_VB_INT_EN) {
+        s->regs[REG_INDEX(REG_TCON_GINT0)] |= REG_TCON_GINT0_VB_INT_FLAG;
+        qemu_irq_raise(s->irq);
+    }
+}
+
+static uint64_t allwinner_a10_lcdc_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+    uint32_t val = s->regs[idx];
+
+    switch (offset) {
+    case 0x800 ... AW_A10_LCDC_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        return 0;
+    default:
+        break;
+    }
+
+    trace_allwinner_a10_lcdc_read(offset, val);
+
+    return val;
+}
+
+static void allwinner_a10_lcdc_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case REG_TCON_GCTL:
+        s->is_enabled = !!REG_TCON_GCTL_EN;
+        break;
+    case REG_TCON_GINT0:
+        if (0 == (val & REG_TCON_GINT0_VB_INT_FLAG)) {
+            qemu_irq_lower(s->irq);
+        }
+        break;
+    case 0x800 ... AW_A10_LCDC_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        break;
+    default:
+        break;
+    }
+
+    trace_allwinner_a10_lcdc_write(offset, (uint32_t)val);
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_a10_lcdc_ops = {
+    .read = allwinner_a10_lcdc_read,
+    .write = allwinner_a10_lcdc_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 1,
+};
+
+#define COPY_PIXEL(to, from) do { *(uint32_t *)to = from; to += 4; } while (0)
+
+static void draw_line(void *opaque, uint8_t *d, const uint8_t *src,
+                      int width, int deststep)
+{
+    uint32_t data;
+    unsigned int r, g, b;
+    while (width > 0) {
+        data = *(uint32_t *)src;
+        b = data & 0xff;
+        g = (data >> 8) & 0xff;
+        r = (data >> 16) & 0xff;
+        COPY_PIXEL(d, rgb_to_pixel32(r, g, b));
+        width--;
+        src += 4;
+    }
+}
+
+static void allwinner_a10_lcdc_invalidate_display(void *opaque)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(opaque);
+    qemu_console_resize(s->con, s->debe->width, s->debe->height);
+    s->invalidate = 1;
+}
+
+static void allwinner_a10_lcdc_update_display(void *opaque)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(opaque);
+    DisplaySurface *surface;
+    int step, width, height, linesize, first = 0, last;
+
+    if (!s->is_enabled || !s->debe->ready) {
+        return;
+    }
+
+    width = s->debe->width;
+    height = s->debe->height;
+    step = width * (s->debe->bpp >> 3);
+
+    if (s->debe->invalidate) {
+        allwinner_a10_lcdc_invalidate_display(opaque);
+        s->debe->invalidate = false;
+    }
+
+    surface = qemu_console_surface(s->con);
+    linesize = surface_stride(surface);
+
+    if (s->invalidate) {
+        framebuffer_update_memory_section(&s->fbsection,
+                                    sysbus_address_space(SYS_BUS_DEVICE(s)),
+                                    s->debe->framebuffer_offset,
+                                    height, step);
+    }
+
+    framebuffer_update_display(surface, &s->fbsection,
+                               width, height,
+                               step, linesize, 0,
+                               s->invalidate,
+                               draw_line, NULL,
+                               &first, &last);
+
+    trace_allwinner_a10_draw(first, last, s->invalidate);
+
+    if (first >= 0) {
+        dpy_gfx_update(s->con, 0, first, width, last - first + 1);
+    }
+    s->invalidate = 0;
+
+}
+
+static const GraphicHwOps allwinner_a10_lcdc_gfx_ops = {
+    .invalidate  = allwinner_a10_lcdc_invalidate_display,
+    .gfx_update  = allwinner_a10_lcdc_update_display,
+};
+
+static void allwinner_a10_lcdc_reset_enter(Object *obj, ResetType type)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(obj);
+    s->invalidate = 1;
+}
+
+static void allwinner_a10_lcdc_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwA10LcdcState *s = AW_A10_LCDC(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_a10_lcdc_ops, s,
+                          TYPE_AW_A10_LCDC, AW_A10_LCDC_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+    sysbus_init_irq(sbd, &s->irq);
+    s->invalidate = 1;
+    s->is_enabled = 0;
+}
+
+static void allwinner_a10_lcdc_realize(DeviceState *dev, Error **errp)
+{
+    AwA10LcdcState *s = AW_A10_LCDC(dev);
+
+    s->timer = ptimer_init(allwinner_a10_lcdc_tick, s,
+                           PTIMER_POLICY_NO_IMMEDIATE_TRIGGER |
+                           PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
+                           PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
+
+    ptimer_transaction_begin(s->timer);
+    /* Set to 60Hz */
+    ptimer_set_freq(s->timer, 60);
+    ptimer_set_limit(s->timer, 0x1, 1);
+    ptimer_run(s->timer, 0);
+    ptimer_transaction_commit(s->timer);
+
+    s->invalidate = 1;
+    s->con = graphic_console_init(NULL, 0, &allwinner_a10_lcdc_gfx_ops, s);
+    qemu_console_resize(s->con, s->debe->width, s->debe->height);
+}
+
+static const VMStateDescription allwinner_a10_lcdc_vmstate = {
+    .name = "allwinner-a10_lcdc",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwA10LcdcState, AW_A10_LCDC_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property allwinner_a10_lcdc_properties[] = {
+    DEFINE_PROP_LINK("debe", AwA10LcdcState, debe,
+                     TYPE_AW_A10_DEBE, AwA10DEBEState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void allwinner_a10_lcdc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = allwinner_a10_lcdc_reset_enter;
+    dc->vmsd = &allwinner_a10_lcdc_vmstate;
+    dc->realize = allwinner_a10_lcdc_realize;
+    device_class_set_props(dc, allwinner_a10_lcdc_properties);
+}
+
+static const TypeInfo allwinner_a10_lcdc_info = {
+    .name          = TYPE_AW_A10_LCDC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_a10_lcdc_init,
+    .instance_size = sizeof(AwA10LcdcState),
+    .class_init    = allwinner_a10_lcdc_class_init,
+};
+
+static void allwinner_a10_lcdc_register(void)
+{
+    type_register_static(&allwinner_a10_lcdc_info);
+}
+
+type_init(allwinner_a10_lcdc_register)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index a3ef580b1c..e233026fdd 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -40,6 +40,7 @@ system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-debe.c',
                                                            'allwinner-a10-hdmi.c',
+                                                           'allwinner-a10-lcdc.c',
                                                            'allwinner-gpu.c'))
 
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 132b66fc81..4b962d6eda 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -186,6 +186,11 @@ allwinner_a10_debe_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRI
 allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
 
+# allwinner-a10-lcdc.c
+allwinner_a10_lcdc_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_a10_lcdc_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_a10_draw(uint32_t first, uint32_t last, uint32_t invalidate) "Draw: 0x%x, 0x%x, 0x%x"
+
 # allwinner-gpu.c
 allwinner_gpu_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_gpu_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 2de7e402b2..c99ca6c1c4 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -14,6 +14,7 @@
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/display/allwinner-a10-debe.h"
 #include "hw/display/allwinner-a10-hdmi.h"
+#include "hw/display/allwinner-a10-lcdc.h"
 #include "hw/display/allwinner-gpu.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/watchdog/allwinner-wdt.h"
@@ -49,6 +50,7 @@ struct AwA10State {
     AwA10DEBEState de_be0;
     AwGpuState gpu;
     AwA10HdmiState hdmi;
+    AwA10LcdcState lcd0;
     MemoryRegion sram_a;
     EHCISysBusState ehci[AW_A10_NUM_USB];
     OHCISysBusState ohci[AW_A10_NUM_USB];
diff --git a/include/hw/display/allwinner-a10-lcdc.h b/include/hw/display/allwinner-a10-lcdc.h
new file mode 100644
index 0000000000..82f6d397fb
--- /dev/null
+++ b/include/hw/display/allwinner-a10-lcdc.h
@@ -0,0 +1,77 @@
+/*
+ * Allwinner A10 LCD Control Module emulation
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
+#ifndef HW_DISPLAY_ALLWINNER_A10_LCDC_H
+#define HW_DISPLAY_ALLWINNER_A10_LCDC_H
+
+#include "qom/object.h"
+#include "hw/ptimer.h"
+#include "hw/sysbus.h"
+#include "ui/console.h"
+#include "hw/display/allwinner-a10-debe.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by LCDC device */
+#define AW_A10_LCDC_IOSIZE        (0x1000)
+
+/** Total number of known registers */
+#define AW_A10_LCDC_REGS_NUM      (AW_A10_LCDC_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_A10_LCDC    "allwinner-a10-lcdc"
+OBJECT_DECLARE_SIMPLE_TYPE(AwA10LcdcState, AW_A10_LCDC)
+
+/** @} */
+
+/**
+ * Allwinner A10 LCDC object instance state.
+ */
+struct AwA10LcdcState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    qemu_irq irq;
+    struct ptimer_state *timer;
+    QemuConsole *con;
+
+    MemoryRegionSection fbsection;
+
+    int invalidate;
+    bool is_enabled;
+
+    AwA10DEBEState *debe;
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_A10_LCDC_REGS_NUM];
+};
+
+#endif /* HW_DISPLAY_ALLWINNER_A10_LCDC_H */
-- 
2.34.1


