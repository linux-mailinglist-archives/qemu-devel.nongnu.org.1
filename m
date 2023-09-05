Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0DD792FBF
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRl-0004uu-Jr; Tue, 05 Sep 2023 16:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRj-0004u5-Lt; Tue, 05 Sep 2023 16:14:47 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRg-00037q-BL; Tue, 05 Sep 2023 16:14:47 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-500a398cda5so5083330e87.0; 
 Tue, 05 Sep 2023 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944882; x=1694549682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijoIYgSSx9pGR8q+BMlkWx4itHcBAMoynk9IpUxxSWM=;
 b=m4if5gEm8dZWhckuj5VJqTVhv9tbT52pCBwd6KNg9nRb32xZoLuB6+TPUo4iTfj51L
 550xspiJ3gI5rSNbmS2i9rvi83ODDyIcDRoeoKN0e06NcT1KUrBscFyGlnuNbLMaGkXK
 4ECXc86R10zyWWkRebgXvlFmRRApAXUEoO2i7ZR9uzCskkREwpqx3dH6Isr93ooZrBgT
 LM3N1WHdgolu0+fvSHI81vN2ITYHIBox2ru15xh8GmBpFX0rnMLV5nY68z1CT3TZgQI7
 Vd54HeXunn5VnELvrodyWPGpSaZ4KCD8VsO3A364vsSojDl/xKDTBU6UkVgr+zocvSWv
 J4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944882; x=1694549682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ijoIYgSSx9pGR8q+BMlkWx4itHcBAMoynk9IpUxxSWM=;
 b=ka7CXfFf4nhyWJUOV5Ko9OdMNAC8IR8MS0eL104ZYnhavDRn4Bld/SG0+KudhH7Vys
 gZgNcGx0QsXY+4UtW542aP4vOizSnzwl5BxJzQL3UItQ8i3p5uyv0x0+G5I9S5PDCQHH
 BXkpeafpZW8bTkl0W5Cx0f9TosIawaKXkvHOkscMCnC2hRaU2K+f6TuvxkueYLvo+i63
 n3N8N3+JGiiaKCL883SY3/IXvy8bUrB2hijkYr348iIrd/YdGWih9h5SGm4XOdKf0jJi
 8pIqkrFBNDuhujflgnNspmBfofAnfQ3GzqY09FI48RwyOpwXGFYm6Konqmudgn3bE1hV
 QW+g==
X-Gm-Message-State: AOJu0YwY5aEzgVzgrWVRER5QinYhTXlU1v7uvabi8EJlyX8PsF3RjRS/
 hRgBSyzDWMUNEMRlAlIGMfbtVhyAG6UDog==
X-Google-Smtp-Source: AGHT+IG3m70JhPs0KKyNuJE0VQcmiUDtjb6klWZGsPi4WDPxK/eAFxYLYTSgcfH0+zA7EWdLM6orCA==
X-Received: by 2002:a19:4f52:0:b0:500:9d4a:89ff with SMTP id
 a18-20020a194f52000000b005009d4a89ffmr662827lfk.62.1693944881804; 
 Tue, 05 Sep 2023 13:14:41 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:41 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 3/5] hw/display: Allwinner A10 Display Engine Backend
 emulation
Date: Tue,  5 Sep 2023 22:14:23 +0200
Message-Id: <20230905201425.118918-4-strahinja.p.jankovic@gmail.com>
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

This patch adds Display Engine Backend 0 (DEBE0) support.
This peripheral will hold runtime configuration for the display size and
framebuffer offset which will be used by other components.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/arm/allwinner-a10.c                  |   9 +
 hw/display/allwinner-a10-debe.c         | 229 ++++++++++++++++++++++++
 hw/display/meson.build                  |   3 +-
 hw/display/trace-events                 |   4 +
 include/hw/arm/allwinner-a10.h          |   2 +
 include/hw/display/allwinner-a10-debe.h |  71 ++++++++
 6 files changed, 317 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/allwinner-a10-debe.c
 create mode 100644 include/hw/display/allwinner-a10-debe.h

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 75cd879d24..624e95af46 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -43,6 +43,7 @@
 #define AW_A10_I2C0_BASE        0x01c2ac00
 #define AW_A10_HDMI_BASE        0x01c16000
 #define AW_A10_GPU_BASE         0x01c40000
+#define AW_A10_DE_BE0_BASE      0x01e60000
 
 void allwinner_a10_bootrom_setup(AwA10State *s, BlockBackend *blk)
 {
@@ -100,6 +101,8 @@ static void aw_a10_init(Object *obj)
 
     object_initialize_child(obj, "hdmi", &s->hdmi, TYPE_AW_A10_HDMI);
 
+    object_initialize_child(obj, "de_be0", &s->de_be0, TYPE_AW_A10_DEBE);
+
     object_initialize_child(obj, "mali400", &s->gpu, TYPE_AW_GPU);
 }
 
@@ -221,6 +224,12 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->hdmi), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->hdmi), 0, AW_A10_HDMI_BASE);
 
+    /* Display Engine Backend */
+    object_property_set_uint(OBJECT(&s->de_be0), "ram-base",
+                             AW_A10_SDRAM_BASE, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->de_be0), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->de_be0), 0, AW_A10_DE_BE0_BASE);
+
     /* MALI GPU */
     sysbus_realize(SYS_BUS_DEVICE(&s->gpu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpu), 0, AW_A10_GPU_BASE);
diff --git a/hw/display/allwinner-a10-debe.c b/hw/display/allwinner-a10-debe.c
new file mode 100644
index 0000000000..3760728eab
--- /dev/null
+++ b/hw/display/allwinner-a10-debe.c
@@ -0,0 +1,229 @@
+/*
+ * Allwinner A10 Display Engine Backend emulation
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
+#include "hw/qdev-properties.h"
+#include "hw/display/allwinner-a10-debe.h"
+#include "trace.h"
+
+/* DEBE register offsets - only important ones */
+enum {
+    REG_DEBE_MODCTL         = 0x0800, /* DE mode control */
+    REG_DEBE_DISSIZE        = 0x0808, /* DE display size */
+    REG_DEBE_LAY0FB_L32ADD  = 0x0850, /* DE Layer 0 lower 32-bit address */
+    REG_DEBE_REGBUFFCTL     = 0x0870, /* DE buffer control register */
+    REG_DEBE_ATTCTL_REG1_L0 = 0x08A0, /* DE Layer 0 attribute ctrl reg 1 */
+};
+
+/* DEBE_DISSIZE fields */
+#define FIELD_DEBE_DISSIZE_DIS_HEIGHT       (16)
+#define FIELD_DEBE_DISSIZE_DIS_WIDTH        (0)
+#define DEBE_DISSIZE_DIS_MASK               (0xFFFFu)
+
+/* DEBE_REGBUFFCTL fields */
+#define FIELD_DEBE_REGBUFFCTL_REGLOADCTL        (1)
+#define FIELD_DEBE_REGBUFFCTL_REGAUTOLOAD_DIS   (2)
+
+/* DEBE_ATTCTL_REG1_L0 fields */
+#define FIELD_DEBE_ATTCTL_REG1_L0_LAY_FBFMT     (8)
+#define DEBE_ATTCTL_REG1_L0_LAY_FBFMT_MASK      (0xFu)
+enum {
+    ATTCTL_REG1_LAY_FBFMT_MONO_1BPP = 0,
+    ATTCTL_REG1_LAY_FBFMT_MONO_2BPP,
+    ATTCTL_REG1_LAY_FBFMT_MONO_4BPP,
+    ATTCTL_REG1_LAY_FBFMT_MONO_8BPP,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_655,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_565,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_556,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_1555,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_5551,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_32BPP_P888,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_32BPP_8888,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_24BPP_888,
+    ATTCTL_REG1_LAY_FBFMT_COLOR_16BPP_4444,
+};
+
+static uint8_t debe_lay_fbfmt_bpp[] = {
+    1,
+    2,
+    4,
+    8,
+    16,
+    16,
+    16,
+    16,
+    16,
+    32,
+    32,
+    24,
+    16
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+static uint64_t allwinner_a10_debe_read(void *opaque, hwaddr offset,
+                                        unsigned size)
+{
+    const AwA10DEBEState *s = AW_A10_DEBE(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+    uint32_t val = 0;
+
+    switch (offset) {
+    case REG_DEBE_DISSIZE:
+    case REG_DEBE_LAY0FB_L32ADD:
+    case REG_DEBE_REGBUFFCTL:
+        break;
+    case 0x5800 ... AW_A10_DEBE_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        return 0;
+    default:
+        break;
+    }
+
+    val = s->regs[idx];
+
+    trace_allwinner_a10_debe_read(offset, val);
+
+    return val;
+}
+
+static void allwinner_a10_debe_write(void *opaque, hwaddr offset,
+                                     uint64_t val, unsigned size)
+{
+    AwA10DEBEState *s = AW_A10_DEBE(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_a10_debe_write(offset, (uint32_t)val);
+
+    switch (offset) {
+    case REG_DEBE_DISSIZE:
+        /* Store display width and height */
+        s->height = 1 +
+            ((val >> FIELD_DEBE_DISSIZE_DIS_HEIGHT) & DEBE_DISSIZE_DIS_MASK);
+        s->width = 1 +
+            ((val >> FIELD_DEBE_DISSIZE_DIS_WIDTH) & DEBE_DISSIZE_DIS_MASK);
+        s->invalidate = true;
+        break;
+    case REG_DEBE_LAY0FB_L32ADD:
+        /* Store framebuffer offset */
+        s->framebuffer_offset = s->ram_base + (val >> 3);
+        if (val != 0) {
+            s->ready = true;
+        }
+        break;
+    case REG_DEBE_REGBUFFCTL:
+        if (val ==
+            (FIELD_DEBE_REGBUFFCTL_REGLOADCTL |
+             FIELD_DEBE_REGBUFFCTL_REGAUTOLOAD_DIS)) {
+            /* Clear to indicate that register loading is done. */
+            val &= ~FIELD_DEBE_REGBUFFCTL_REGLOADCTL;
+        }
+        break;
+    case REG_DEBE_ATTCTL_REG1_L0:
+        {
+            uint8_t bpp = (val >> FIELD_DEBE_ATTCTL_REG1_L0_LAY_FBFMT) &
+                DEBE_ATTCTL_REG1_L0_LAY_FBFMT_MASK;
+            s->bpp = debe_lay_fbfmt_bpp[bpp];
+        }
+        break;
+    case 0x5800 ... AW_A10_DEBE_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                      __func__, (uint32_t)offset);
+        break;
+    default:
+        break;
+    }
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_a10_debe_ops = {
+    .read = allwinner_a10_debe_read,
+    .write = allwinner_a10_debe_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_a10_debe_reset_enter(Object *obj, ResetType type)
+{
+    AwA10DEBEState *s = AW_A10_DEBE(obj);
+
+    memset(&s->regs[0], 0, AW_A10_DEBE_IOSIZE);
+}
+
+static void allwinner_a10_debe_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwA10DEBEState *s = AW_A10_DEBE(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_a10_debe_ops, s,
+                          TYPE_AW_A10_DEBE, AW_A10_DEBE_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_a10_debe_vmstate = {
+    .name = "allwinner-a10-debe",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwA10DEBEState, AW_A10_DEBE_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property allwinner_a10_debe_properties[] = {
+    DEFINE_PROP_UINT64("ram-base", AwA10DEBEState, ram_base, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void allwinner_a10_debe_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = allwinner_a10_debe_reset_enter;
+    dc->vmsd = &allwinner_a10_debe_vmstate;
+    device_class_set_props(dc, allwinner_a10_debe_properties);
+}
+
+static const TypeInfo allwinner_a10_debe_info = {
+    .name          = TYPE_AW_A10_DEBE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_a10_debe_init,
+    .instance_size = sizeof(AwA10DEBEState),
+    .class_init    = allwinner_a10_debe_class_init,
+};
+
+static void allwinner_a10_debe_register(void)
+{
+    type_register_static(&allwinner_a10_debe_info);
+}
+
+type_init(allwinner_a10_debe_register)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index a5eb01fe2b..a3ef580b1c 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -38,7 +38,8 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 
-system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-hdmi.c',
+system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-debe.c',
+                                                           'allwinner-a10-hdmi.c',
                                                            'allwinner-gpu.c'))
 
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index d1c0f05e52..132b66fc81 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -178,6 +178,10 @@ macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setting mode to width %"PRId32 " height %"PRId32 " size %d"
 
+# allwinner-a10-debe.c
+allwinner_a10_debe_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_a10_debe_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
 # allwinner-a10-hdmi.c
 allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 8109656421..2de7e402b2 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,6 +12,7 @@
 #include "hw/rtc/allwinner-rtc.h"
 #include "hw/misc/allwinner-a10-ccm.h"
 #include "hw/misc/allwinner-a10-dramc.h"
+#include "hw/display/allwinner-a10-debe.h"
 #include "hw/display/allwinner-a10-hdmi.h"
 #include "hw/display/allwinner-gpu.h"
 #include "hw/i2c/allwinner-i2c.h"
@@ -45,6 +46,7 @@ struct AwA10State {
     AWI2CState i2c0;
     AwRtcState rtc;
     AwWdtState wdt;
+    AwA10DEBEState de_be0;
     AwGpuState gpu;
     AwA10HdmiState hdmi;
     MemoryRegion sram_a;
diff --git a/include/hw/display/allwinner-a10-debe.h b/include/hw/display/allwinner-a10-debe.h
new file mode 100644
index 0000000000..30727516bc
--- /dev/null
+++ b/include/hw/display/allwinner-a10-debe.h
@@ -0,0 +1,71 @@
+/*
+ * Allwinner A10 Display engine Backend emulation
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
+#ifndef HW_DISPLAY_ALLWINNER_A10_DEBE_H
+#define HW_DISPLAY_ALLWINNER_A10_DEBE_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by DEBE device */
+#define AW_A10_DEBE_IOSIZE      (0x20000)
+
+/** Total number of known registers for DEBE */
+#define AW_A10_DEBE_REGS_NUM    (AW_A10_DEBE_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_A10_DEBE    "allwinner-a10-debe"
+OBJECT_DECLARE_SIMPLE_TYPE(AwA10DEBEState, AW_A10_DEBE)
+
+/** @} */
+
+/**
+ * Allwinner A10 DEBE object instance state.
+ */
+struct AwA10DEBEState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    uint32_t width;
+    uint32_t height;
+    hwaddr framebuffer_offset;
+    hwaddr ram_base;
+    uint8_t bpp;
+    bool ready;
+    bool invalidate;
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_A10_DEBE_REGS_NUM];
+};
+
+#endif /* HW_DISPLAY_ALLWINNER_A10_DEBE_H */
-- 
2.34.1


