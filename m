Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C04E5792FC1
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRh-0004tG-OE; Tue, 05 Sep 2023 16:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRf-0004t3-VQ; Tue, 05 Sep 2023 16:14:44 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRc-00037U-RL; Tue, 05 Sep 2023 16:14:43 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-501bd6f7d11so1943745e87.1; 
 Tue, 05 Sep 2023 13:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944879; x=1694549679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kjHTvwkRQLgWn6AbYXrQiHckpQTTlZrVyb3u0idfryg=;
 b=a4CY0rZBFebMWHtNzFqNr2XuQ2sAEJsxk4cjCBSgv2OnZrEYeWDj6kvCbRD4xbE5/l
 zQAJ8iK62HDOx3dH95gLTunKPGiQNPSz2Wi9zSNq0v2P5197kZpQWFRskMxeskGk/QeM
 DzKJdemBdS0uSlT5cDBo0mRGpSGdi/SANC5+6Z8GsuHNokwsiTTjibs6sN2fiJYiCx+h
 3EB/nAk3TqRJ6StaLtqP3psBpUvHMwxddb3Zsrc6tkcfi0Yudvq3tujhvjkCxYw1Nj1e
 eoForC8WnEgYr7YNRnKteNs2SlOTEdU7FWXIVe8LrUFO5DmzqKVRsHRlB2vS0hppQ0+9
 1HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944879; x=1694549679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kjHTvwkRQLgWn6AbYXrQiHckpQTTlZrVyb3u0idfryg=;
 b=GRl840mThDFLseOC197J+ayisBNk8vj9jnehkj3TtEp1WVHl8dvz6NZ9r6LcxklgaM
 uzy81Wp3Fo8EcXgXHSE/InqnnxyB8wA7m0XhCTPQ7bi8jIIpOnC7/s5rOq7vTv4F4l8d
 PuSMnm95AGwRSSSaagFCGgd5gpGwTOZxQ73nD9QKAzLaajCVRZEqPbcfJbYCj+SkvNvt
 ulPC8wZpkhQCEZ1QztF2RzBI95fmcnVVvWteo38m/axLyC2yvDAmZDPTOQsTS/io7/35
 gtf82upXVcWqrxnIZ6M+IxxuKvijNnAhMunNqxOjTVtSKzNc+nJGj3QY9BErT5l8j7wo
 sUng==
X-Gm-Message-State: AOJu0YzW7dtoZxnnuxwx6FL5QG2JJxHRhYGljmpOeEyck84voJaZAFVL
 hfoIm5zr0X2lqL4tXEDKB8Qkymz/IjplQQ==
X-Google-Smtp-Source: AGHT+IFPYc4CXUQPWdkQmdY31rGCFPo1Pln9CgskK0PPxlH/hBaV6GYop6qWloPYcv6Nl4bKRLBefQ==
X-Received: by 2002:ac2:4e8b:0:b0:500:77c4:108 with SMTP id
 o11-20020ac24e8b000000b0050077c40108mr580460lfr.9.1693944878513; 
 Tue, 05 Sep 2023 13:14:38 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:38 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 1/5] hw/display: Allwinner A10 HDMI controller emulation
Date: Tue,  5 Sep 2023 22:14:21 +0200
Message-Id: <20230905201425.118918-2-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x134.google.com
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

This patch adds basic Allwinner A10 HDMI controller support.
Emulated HDMI component will always show that a display is connected and
provide default EDID info.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/arm/allwinner-a10.c                  |   7 +
 hw/display/allwinner-a10-hdmi.c         | 214 ++++++++++++++++++++++++
 hw/display/meson.build                  |   2 +
 hw/display/trace-events                 |   4 +
 include/hw/arm/allwinner-a10.h          |   2 +
 include/hw/display/allwinner-a10-hdmi.h |  69 ++++++++
 6 files changed, 298 insertions(+)
 create mode 100644 hw/display/allwinner-a10-hdmi.c
 create mode 100644 include/hw/display/allwinner-a10-hdmi.h

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index b0ea3f7f66..2351d1a69b 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -41,6 +41,7 @@
 #define AW_A10_WDT_BASE         0x01c20c90
 #define AW_A10_RTC_BASE         0x01c20d00
 #define AW_A10_I2C0_BASE        0x01c2ac00
+#define AW_A10_HDMI_BASE        0x01c16000
 
 void allwinner_a10_bootrom_setup(AwA10State *s, BlockBackend *blk)
 {
@@ -95,6 +96,8 @@ static void aw_a10_init(Object *obj)
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_AW_RTC_SUN4I);
 
     object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
+
+    object_initialize_child(obj, "hdmi", &s->hdmi, TYPE_AW_A10_HDMI);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -210,6 +213,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     /* WDT */
     sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0, AW_A10_WDT_BASE, 1);
+
+    /* HDMI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->hdmi), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->hdmi), 0, AW_A10_HDMI_BASE);
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/display/allwinner-a10-hdmi.c b/hw/display/allwinner-a10-hdmi.c
new file mode 100644
index 0000000000..0f046e3cc7
--- /dev/null
+++ b/hw/display/allwinner-a10-hdmi.c
@@ -0,0 +1,214 @@
+/*
+ * Allwinner A10 HDMI Module emulation
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
+#include "hw/display/allwinner-a10-hdmi.h"
+#include "trace.h"
+
+/* HDMI register offsets */
+enum {
+    REG_HPD                 = 0x000C, /* HDMI Hotplug detect */
+    REG_DDC_CTRL            = 0x0500, /* DDC Control */
+    REG_DDC_SLAVE_ADDRESS   = 0x0504, /* DDC Slave address */
+    REG_DDC_INT_STATUS      = 0x050C, /* DDC Interrupt status */
+    REG_DDC_FIFO_CTRL       = 0x0510, /* DDC FIFO Control */
+    REG_DDC_FIFO_ACCESS     = 0x0518, /* DDC FIFO access */
+    REG_DDC_COMMAND         = 0x0520, /* DDC Command */
+};
+
+/* HPD register fields */
+#define FIELD_HPD_HOTPLUG_DET_HIGH      (1 << 0)
+
+/* DDC_CTRL register fields */
+#define FIELD_DDC_CTRL_SW_RST           (1 << 0)
+#define FIELD_DDC_CTRL_ACCESS_CMD_START (1 << 30)
+
+/* FIFO_CTRL register fields */
+#define FIELD_FIFO_CTRL_ADDRESS_CLEAR   (1 << 31)
+
+/* DDC_SLAVE_ADDRESS register fields */
+#define FIELD_DDC_SLAVE_ADDRESS_SEGMENT_SHIFT   (24)
+#define FIELD_DDC_SLAVE_ADDRESS_OFFSET_SHIFT    (8)
+
+/* DDC_INT_STATUS register fields */
+#define FIELD_DDC_INT_STATUS_TRANSFER_COMPLETE  (1 << 0)
+
+/* DDC access command */
+enum {
+    DDC_COMMAND_E_DDC_READ = 6,
+};
+
+
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+static uint64_t allwinner_a10_hdmi_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    AwA10HdmiState *s = AW_A10_HDMI(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+    uint32_t val = s->regs[idx];
+
+    switch (offset) {
+    case REG_HPD:
+        val = FIELD_HPD_HOTPLUG_DET_HIGH;
+        break;
+    case REG_DDC_FIFO_ACCESS:
+        val = s->edid_blob[s->edid_reg % sizeof(s->edid_blob)];
+        s->edid_reg++;
+        break;
+    case 0x544 ... AW_A10_HDMI_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        return 0;
+    default:
+        break;
+    }
+
+    trace_allwinner_a10_hdmi_read(offset, val);
+
+    return val;
+}
+
+static void allwinner_a10_hdmi_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwA10HdmiState *s = AW_A10_HDMI(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    switch (offset) {
+    case REG_DDC_CTRL:
+        if (val & FIELD_DDC_CTRL_SW_RST) {
+            val &= ~FIELD_DDC_CTRL_SW_RST;
+        }
+        if (val & FIELD_DDC_CTRL_ACCESS_CMD_START) {
+            val &= ~FIELD_DDC_CTRL_ACCESS_CMD_START;
+            if (s->regs[REG_INDEX(REG_DDC_COMMAND)] == DDC_COMMAND_E_DDC_READ) {
+                uint32_t regval = s->regs[REG_INDEX(REG_DDC_SLAVE_ADDRESS)];
+                uint8_t segment = 0xFFu &
+                    (regval >> FIELD_DDC_SLAVE_ADDRESS_SEGMENT_SHIFT);
+                uint8_t offset = 0xFFu &
+                    (regval >> FIELD_DDC_SLAVE_ADDRESS_OFFSET_SHIFT);
+                if (segment == 0) {
+                    s->edid_reg = offset;
+                }
+            }
+        }
+        break;
+    case REG_DDC_INT_STATUS:
+        /* Clear interrupts */
+        val = s->regs[REG_INDEX(REG_DDC_INT_STATUS)] & ~(val & 0xFFu);
+        /* Set transfer complete */
+        val |= FIELD_DDC_INT_STATUS_TRANSFER_COMPLETE;
+        break;
+    case REG_DDC_FIFO_CTRL:
+        if (val & FIELD_FIFO_CTRL_ADDRESS_CLEAR) {
+            val &= ~FIELD_FIFO_CTRL_ADDRESS_CLEAR;
+        }
+        break;
+    case 0x544 ... AW_A10_HDMI_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        break;
+    default:
+        break;
+    }
+
+    trace_allwinner_a10_hdmi_write(offset, (uint32_t)val);
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_a10_hdmi_ops = {
+    .read = allwinner_a10_hdmi_read,
+    .write = allwinner_a10_hdmi_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 1,
+};
+
+static void allwinner_a10_hdmi_reset_enter(Object *obj, ResetType type)
+{
+    AwA10HdmiState *s = AW_A10_HDMI(obj);
+
+    s->edid_reg = 0;
+}
+
+static void allwinner_a10_hdmi_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwA10HdmiState *s = AW_A10_HDMI(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_a10_hdmi_ops, s,
+                          TYPE_AW_A10_HDMI, AW_A10_HDMI_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+
+    qemu_edid_generate(s->edid_blob, sizeof(s->edid_blob), &s->edid_info);
+}
+
+static const VMStateDescription allwinner_a10_hdmi_vmstate = {
+    .name = "allwinner-a10-hdmi",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwA10HdmiState, AW_A10_HDMI_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property allwinner_a10_hdmi_properties[] = {
+    DEFINE_EDID_PROPERTIES(AwA10HdmiState, edid_info),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void allwinner_a10_hdmi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    device_class_set_props(dc, allwinner_a10_hdmi_properties);
+
+    rc->phases.enter = allwinner_a10_hdmi_reset_enter;
+    dc->vmsd = &allwinner_a10_hdmi_vmstate;
+}
+
+static const TypeInfo allwinner_a10_hdmi_info = {
+    .name          = TYPE_AW_A10_HDMI,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_a10_hdmi_init,
+    .instance_size = sizeof(AwA10HdmiState),
+    .class_init    = allwinner_a10_hdmi_class_init,
+};
+
+static void allwinner_a10_hdmi_register(void)
+{
+    type_register_static(&allwinner_a10_hdmi_info);
+}
+
+type_init(allwinner_a10_hdmi_register)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 413ba4ab24..0a36c3ed85 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -38,6 +38,8 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 
+system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-hdmi.c')
+
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
     config_all_devices.has_key('CONFIG_VMWARE_VGA') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 2336a0ca15..8d0d33ce4d 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -177,3 +177,7 @@ macfb_ctrl_write(uint64_t addr, uint64_t value, unsigned int size) "addr 0x%"PRI
 macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setting mode to width %"PRId32 " height %"PRId32 " size %d"
+
+# allwinner-a10-hdmi.c
+allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index cd1465c613..db8cbeecfa 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -12,6 +12,7 @@
 #include "hw/rtc/allwinner-rtc.h"
 #include "hw/misc/allwinner-a10-ccm.h"
 #include "hw/misc/allwinner-a10-dramc.h"
+#include "hw/display/allwinner-a10-hdmi.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "sysemu/block-backend.h"
@@ -43,6 +44,7 @@ struct AwA10State {
     AWI2CState i2c0;
     AwRtcState rtc;
     AwWdtState wdt;
+    AwA10HdmiState hdmi;
     MemoryRegion sram_a;
     EHCISysBusState ehci[AW_A10_NUM_USB];
     OHCISysBusState ohci[AW_A10_NUM_USB];
diff --git a/include/hw/display/allwinner-a10-hdmi.h b/include/hw/display/allwinner-a10-hdmi.h
new file mode 100644
index 0000000000..1065dca2f7
--- /dev/null
+++ b/include/hw/display/allwinner-a10-hdmi.h
@@ -0,0 +1,69 @@
+/*
+ * Allwinner A10 HDMI Module emulation
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
+#ifndef HW_DISPLAY_ALLWINNER_A10_HDMI_H
+#define HW_DISPLAY_ALLWINNER_A10_HDMI_H
+
+#include "hw/display/edid.h"
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by HDMI device */
+#define AW_A10_HDMI_IOSIZE        (0x1000)
+
+/** Total number of known registers */
+#define AW_A10_HDMI_REGS_NUM      (AW_A10_HDMI_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_A10_HDMI    "allwinner-a10-hdmi"
+OBJECT_DECLARE_SIMPLE_TYPE(AwA10HdmiState, AW_A10_HDMI)
+
+/** @} */
+
+/**
+ * Allwinner A10 HDMI object instance state.
+ */
+struct AwA10HdmiState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    uint8_t edid_reg;
+    qemu_edid_info edid_info;
+    uint8_t edid_blob[128];
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_A10_HDMI_REGS_NUM];
+};
+
+#endif /* HW_DISPLAY_ALLWINNER_A10_HDMI_H */
-- 
2.34.1


