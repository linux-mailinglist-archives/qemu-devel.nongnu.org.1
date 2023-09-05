Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86532792FBE
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 22:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdcRk-0004uf-Ic; Tue, 05 Sep 2023 16:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRi-0004tt-9T; Tue, 05 Sep 2023 16:14:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <strahinjapjankovic@gmail.com>)
 id 1qdcRf-00037l-51; Tue, 05 Sep 2023 16:14:46 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-501bd6f7d11so1943792e87.1; 
 Tue, 05 Sep 2023 13:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693944881; x=1694549681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p+55zTL8qzmfnSZPGRsQ3XdBdwCldHenVE5r+lCRo7g=;
 b=IaFoo8w5PlV8ggaMt2HoZrkK8XLGziaAkkTRY1kQmAITzwmqgCiM5nojtNUHx3MZnZ
 RoiYg7uMIknqrUSd+RcZnSFLdSa4YMrKcOjCpMEzPOJjSzoEi13cMlztBCoC1Td6jAZw
 IF5HSk+FdYXAZq05v2aC0yn7SFgngZGo1/jDJRU5nkXXd6V2b7P+MF3TQyzkVip7jUH9
 1TJLaoNDAe4yM6UXEbdxIbXpcTJZdLpUSakUZ7D6K+wbBr2XYSyx7w41TkLXWkmLgHJu
 rmDWlyLxAhZJ4rIx3pzchsydwfjWYYhiHwGxuQ6wApEOd2/xMRpLxsqDRbAk7pIcVs3l
 uCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693944881; x=1694549681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p+55zTL8qzmfnSZPGRsQ3XdBdwCldHenVE5r+lCRo7g=;
 b=ihrwfekdpqExdPsuC4AmLwQ9AsWJ6hmFgdbzgCFTv6wDjng9H8riDiuzgQTzsEuRg6
 k4rrE3R6LCJAOIpTaIZ6/kQ5DlPZYMu725g5rtpCzhzsPhg4ig8Y7sD1Uzbd3pGTFJC/
 LiZztCN4XzuRQo14a54ehBaHYYMKsT5x02W6ta9fHm5dcvj7/ihy0ezUtqyHBL7M0AdX
 17GgxZokLHtTto1xsE7uvLqfr2nGZrdWXGnu96wQ1oOJ89XkBkqEAhosN0UuALOd6wm8
 +g9ZLoSviBXaRqbVJfMGX4+OZjBmIJdNq0HKnSnrlIORQGkjQYnx2NjBADn5Ye1kcSey
 XizQ==
X-Gm-Message-State: AOJu0YwZqEsBrcudWdOqR52aiez1b/IPFbcwdmvTpajum914eMyZ4kWQ
 F8KkLnsPvpSXyPjkyTcRK/06nqbLJknSFw==
X-Google-Smtp-Source: AGHT+IGsfnhF+2An7DeEX0tuRDL48WiFGufrq5El999eXOq3boZtzSLuyNmHbbi+LnEsup4O/9tYxA==
X-Received: by 2002:ac2:518d:0:b0:501:bc0b:6118 with SMTP id
 u13-20020ac2518d000000b00501bc0b6118mr672917lfi.50.1693944880641; 
 Tue, 05 Sep 2023 13:14:40 -0700 (PDT)
Received: from localhost.localdomain (81-233-187-21-no600.tbcn.telia.com.
 [81.233.187.21]) by smtp.gmail.com with ESMTPSA id
 b25-20020ac25e99000000b004ff725d1a27sm2489811lfq.234.2023.09.05.13.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 13:14:40 -0700 (PDT)
From: Strahinja Jankovic <strahinjapjankovic@gmail.com>
X-Google-Original-From: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Subject: [RFC Patch 2/5] hw/display: Allwinner basic MALI GPU emulation
Date: Tue,  5 Sep 2023 22:14:22 +0200
Message-Id: <20230905201425.118918-3-strahinja.p.jankovic@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
References: <20230905201425.118918-1-strahinja.p.jankovic@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=strahinjapjankovic@gmail.com; helo=mail-lf1-x129.google.com
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

This patch adds minimal MALI GPU emulation needed so emulated system
thinks GPU is working.

Signed-off-by: Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
---
 hw/arm/allwinner-a10.c             |   7 +
 hw/display/allwinner-gpu.c         | 212 +++++++++++++++++++++++++++++
 hw/display/meson.build             |   3 +-
 hw/display/trace-events            |   4 +
 include/hw/arm/allwinner-a10.h     |   2 +
 include/hw/display/allwinner-gpu.h |  64 +++++++++
 6 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 hw/display/allwinner-gpu.c
 create mode 100644 include/hw/display/allwinner-gpu.h

diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
index 2351d1a69b..75cd879d24 100644
--- a/hw/arm/allwinner-a10.c
+++ b/hw/arm/allwinner-a10.c
@@ -42,6 +42,7 @@
 #define AW_A10_RTC_BASE         0x01c20d00
 #define AW_A10_I2C0_BASE        0x01c2ac00
 #define AW_A10_HDMI_BASE        0x01c16000
+#define AW_A10_GPU_BASE         0x01c40000
 
 void allwinner_a10_bootrom_setup(AwA10State *s, BlockBackend *blk)
 {
@@ -98,6 +99,8 @@ static void aw_a10_init(Object *obj)
     object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
 
     object_initialize_child(obj, "hdmi", &s->hdmi, TYPE_AW_A10_HDMI);
+
+    object_initialize_child(obj, "mali400", &s->gpu, TYPE_AW_GPU);
 }
 
 static void aw_a10_realize(DeviceState *dev, Error **errp)
@@ -217,6 +220,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
     /* HDMI */
     sysbus_realize(SYS_BUS_DEVICE(&s->hdmi), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->hdmi), 0, AW_A10_HDMI_BASE);
+
+    /* MALI GPU */
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpu), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gpu), 0, AW_A10_GPU_BASE);
 }
 
 static void aw_a10_class_init(ObjectClass *oc, void *data)
diff --git a/hw/display/allwinner-gpu.c b/hw/display/allwinner-gpu.c
new file mode 100644
index 0000000000..735976d206
--- /dev/null
+++ b/hw/display/allwinner-gpu.c
@@ -0,0 +1,212 @@
+/*
+ * Allwinner GPU Module emulation
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
+#include "hw/display/allwinner-gpu.h"
+#include "trace.h"
+
+/* GPU register offsets - only the important ones. */
+enum {
+    REG_MALI_GP_CMD             = 0x0020,
+    REG_MALI_GP_INT_RAWSTAT     = 0x0024,
+    REG_MALI_GP_VERSION         = 0x006C,
+    REG_MALI_GP_MMU_DTE         = 0x3000,
+    REG_MALI_GP_MMU_STATUS      = 0x3004,
+    REG_MALI_GP_MMU_COMMAND     = 0x3008,
+    REG_MALI_PP0_MMU_DTE        = 0x4000,
+    REG_MALI_PP0_MMU_STATUS     = 0x4004,
+    REG_MALI_PP0_MMU_COMMAND    = 0x4008,
+    REG_MALI_PP0_VERSION        = 0x9000,
+    REG_MALI_PP0_CTRL           = 0x900C,
+    REG_MALI_PP0_INT_RAWSTAT    = 0x9020,
+};
+
+#define REG_INDEX(offset)    (offset / sizeof(uint32_t))
+
+#define MALI_GP_VERSION_READ_VAL    (0x0B07u << 16)
+#define MALI_PP0_VERSION_READ_VAL   (0xCD07u << 16)
+#define MALI_MMU_DTE_MASK           (0x0FFF)
+
+/* MALI_GP_CMD register fields */
+#define MALI_GP_CMD_SOFT_RESET    (1 << 10)
+
+/* MALI_GP_INT_RAWSTAT register fields */
+#define MALI_GP_INT_RAWSTAT_RESET_COMPLETED (1 << 19)
+
+/* MALI_MMU_COMMAND values */
+enum {
+    MALI_MMU_COMMAND_ENABLE_PAGING = 0,
+    MALI_MMU_COMMAND_HARD_RESET    = 6,
+};
+
+/* MALI_MMU_STATUS register fields */
+#define MALI_MMU_STATUS_PAGING_ENABLED  (1 << 0)
+
+/* MALI_PP_CTRL register fields */
+#define MALI_PP_CTRL_SOFT_RESET     (1 << 7)
+
+/* MALI_PP_INT_RAWSTAT register fields */
+#define MALI_PP_INT_RAWSTAT_RESET_COMPLETED (1 << 12)
+
+static uint64_t allwinner_gpu_read(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    const AwGpuState *s = AW_GPU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+    uint32_t val = s->regs[idx];
+
+    switch (offset) {
+    case REG_MALI_GP_VERSION:
+        val = MALI_GP_VERSION_READ_VAL;
+        break;
+    case REG_MALI_GP_MMU_DTE:
+    case REG_MALI_PP0_MMU_DTE:
+        val &= ~MALI_MMU_DTE_MASK;
+        break;
+    case REG_MALI_PP0_VERSION:
+        val = MALI_PP0_VERSION_READ_VAL;
+        break;
+    case 0xF0B8 ... AW_GPU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        return 0;
+    default:
+        break;
+    }
+
+    trace_allwinner_gpu_read(offset, val);
+
+    return val;
+}
+
+static void allwinner_gpu_write(void *opaque, hwaddr offset,
+                                   uint64_t val, unsigned size)
+{
+    AwGpuState *s = AW_GPU(opaque);
+    const uint32_t idx = REG_INDEX(offset);
+
+    trace_allwinner_gpu_write(offset, (uint32_t)val);
+
+    switch (offset) {
+    case REG_MALI_GP_CMD:
+        if (val == MALI_GP_CMD_SOFT_RESET) {
+            s->regs[REG_INDEX(REG_MALI_GP_INT_RAWSTAT)] |=
+                MALI_GP_INT_RAWSTAT_RESET_COMPLETED;
+        }
+        break;
+    case REG_MALI_GP_MMU_COMMAND:
+        if (val == MALI_MMU_COMMAND_ENABLE_PAGING) {
+            s->regs[REG_INDEX(REG_MALI_GP_MMU_STATUS)] |=
+                MALI_MMU_STATUS_PAGING_ENABLED;
+        } else if (val == MALI_MMU_COMMAND_HARD_RESET) {
+            s->regs[REG_INDEX(REG_MALI_GP_MMU_DTE)] = 0;
+        }
+        break;
+    case REG_MALI_PP0_MMU_COMMAND:
+        if (val == MALI_MMU_COMMAND_ENABLE_PAGING) {
+            s->regs[REG_INDEX(REG_MALI_PP0_MMU_STATUS)] |=
+                MALI_MMU_STATUS_PAGING_ENABLED;
+        } else if (val == MALI_MMU_COMMAND_HARD_RESET) {
+            s->regs[REG_INDEX(REG_MALI_PP0_MMU_DTE)] = 0;
+        }
+        break;
+    case REG_MALI_PP0_CTRL:
+        if (val == MALI_PP_CTRL_SOFT_RESET) {
+            s->regs[REG_INDEX(REG_MALI_PP0_INT_RAWSTAT)] =
+                MALI_PP_INT_RAWSTAT_RESET_COMPLETED;
+        }
+        break;
+    case 0xF0B8 ... AW_GPU_IOSIZE:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: out-of-bounds offset 0x%04x\n",
+                  __func__, (uint32_t)offset);
+        break;
+    default:
+        break;
+    }
+
+    s->regs[idx] = (uint32_t) val;
+}
+
+static const MemoryRegionOps allwinner_gpu_ops = {
+    .read = allwinner_gpu_read,
+    .write = allwinner_gpu_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+    .impl.min_access_size = 4,
+};
+
+static void allwinner_gpu_reset_enter(Object *obj, ResetType type)
+{
+    AwGpuState *s = AW_GPU(obj);
+
+    memset(&s->regs[0], 0, AW_GPU_IOSIZE);
+}
+
+static void allwinner_gpu_init(Object *obj)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+    AwGpuState *s = AW_GPU(obj);
+
+    /* Memory mapping */
+    memory_region_init_io(&s->iomem, OBJECT(s), &allwinner_gpu_ops, s,
+                          TYPE_AW_GPU, AW_GPU_IOSIZE);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static const VMStateDescription allwinner_gpu_vmstate = {
+    .name = "allwinner-gpu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, AwGpuState, AW_GPU_REGS_NUM),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void allwinner_gpu_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = allwinner_gpu_reset_enter;
+    dc->vmsd = &allwinner_gpu_vmstate;
+}
+
+static const TypeInfo allwinner_gpu_info = {
+    .name          = TYPE_AW_GPU,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_init = allwinner_gpu_init,
+    .instance_size = sizeof(AwGpuState),
+    .class_init    = allwinner_gpu_class_init,
+};
+
+static void allwinner_gpu_register(void)
+{
+    type_register_static(&allwinner_gpu_info);
+}
+
+type_init(allwinner_gpu_register)
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 0a36c3ed85..a5eb01fe2b 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -38,7 +38,8 @@ system_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-fb.c'))
 
 system_ss.add(when: 'CONFIG_VGA', if_true: files('vga.c'))
 
-system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-hdmi.c')
+system_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10-hdmi.c',
+                                                           'allwinner-gpu.c'))
 
 if (config_all_devices.has_key('CONFIG_VGA_CIRRUS') or
     config_all_devices.has_key('CONFIG_VGA_PCI') or
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 8d0d33ce4d..d1c0f05e52 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -181,3 +181,7 @@ macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setting mode
 # allwinner-a10-hdmi.c
 allwinner_a10_hdmi_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
 allwinner_a10_hdmi_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
+
+# allwinner-gpu.c
+allwinner_gpu_read(uint64_t offset, uint64_t data) "Read: offset 0x%" PRIx64 " data 0x%" PRIx64
+allwinner_gpu_write(uint64_t offset, uint64_t data) "Write: offset 0x%" PRIx64 " data 0x%" PRIx64
diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index db8cbeecfa..8109656421 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -13,6 +13,7 @@
 #include "hw/misc/allwinner-a10-ccm.h"
 #include "hw/misc/allwinner-a10-dramc.h"
 #include "hw/display/allwinner-a10-hdmi.h"
+#include "hw/display/allwinner-gpu.h"
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/watchdog/allwinner-wdt.h"
 #include "sysemu/block-backend.h"
@@ -44,6 +45,7 @@ struct AwA10State {
     AWI2CState i2c0;
     AwRtcState rtc;
     AwWdtState wdt;
+    AwGpuState gpu;
     AwA10HdmiState hdmi;
     MemoryRegion sram_a;
     EHCISysBusState ehci[AW_A10_NUM_USB];
diff --git a/include/hw/display/allwinner-gpu.h b/include/hw/display/allwinner-gpu.h
new file mode 100644
index 0000000000..6800a58dde
--- /dev/null
+++ b/include/hw/display/allwinner-gpu.h
@@ -0,0 +1,64 @@
+/*
+ * Allwinner A10 GPU Module emulation
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
+#ifndef HW_DISPLAY_ALLWINNER_GPU_H
+#define HW_DISPLAY_ALLWINNER_GPU_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+
+/**
+ * @name Constants
+ * @{
+ */
+
+/** Size of register I/O address space used by GPU device */
+#define AW_GPU_IOSIZE        (0x10000)
+
+/** Total number of known registers */
+#define AW_GPU_REGS_NUM      (AW_GPU_IOSIZE / sizeof(uint32_t))
+
+/** @} */
+
+/**
+ * @name Object model
+ * @{
+ */
+
+#define TYPE_AW_GPU    "allwinner-gpu"
+OBJECT_DECLARE_SIMPLE_TYPE(AwGpuState, AW_GPU)
+
+/** @} */
+
+/**
+ * Allwinner GPU object instance state.
+ */
+struct AwGpuState {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+
+    /** Maps I/O registers in physical memory */
+    MemoryRegion iomem;
+
+    /** Array of hardware registers */
+    uint32_t regs[AW_GPU_REGS_NUM];
+};
+
+#endif /* HW_DISPLAY_ALLWINNER_GPU_H */
-- 
2.34.1


