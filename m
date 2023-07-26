Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4DE763820
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 15:54:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWq-00031P-36; Wed, 26 Jul 2023 09:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWP-0002kx-Fo; Wed, 26 Jul 2023 09:25:47 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWL-0003GJ-8o; Wed, 26 Jul 2023 09:25:44 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so10549290e87.1; 
 Wed, 26 Jul 2023 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377939; x=1690982739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtEyV7wOINE6Zg5B38mjjGV4yNJDpnvf6RkCUjEM2Ek=;
 b=sAGTXZ0rTKHQOj5ZAwUTLtO1M9jA5NOs45QUVsRjoSAOT6eQzc8L7l/MPFSOczM/jk
 ZgKn+VGd0BIYK6eofJ+KXevUm1sv/a/iJH3DckYEwU7LXsoAStQLbVpStyoQr7lhI/cd
 66JgrDZ0bak9Ly3Z5Sfgf92y20Zo9hVdibrDwScoctEVzxZbhIQX2tbX7lbV1MX2/4aQ
 GM1GBVE1rmKU742KsEEdTVRZ5EXdJik28lEk4r0WLy+NQteIWiTso/mSt6HH5pkO6+bU
 xPNpwAATXLndDw0bP39GlS0AOxPVvhgf8Wh9Al0TPPkqOglQv8QhMnYKRjsVnp3QY46F
 K2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377939; x=1690982739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtEyV7wOINE6Zg5B38mjjGV4yNJDpnvf6RkCUjEM2Ek=;
 b=Qes06k148R7k3DIj6laXl3jwIhJUkEGuxdSGYveR9Fy7QrQBlkmjT4vIr1QHf5zXHc
 cr+/VuEfsursJ35jKq8mG2FEdKruBE8I02u6T/x2HlDykzwFo0R9rSJOH/JdHtyEzOdG
 O3IyxKvtxHrYrnf7aWj5cMKN8tjXBqANzvCyMqTr4UWhs04gMts89EzGdS90hVVlRmbp
 OyxfldoQTh1NM8NloZZLuWtPrX8Lo188vPMZ9g1ppr6J/RP0GzHwP9hBNd3nNYhjtD4v
 1Ta7AKDwTWh+i+ydTW5kWgyjBSiJv9nAPgrB4xOns0Is0eUkrsVhZJrvcucWPRddV40p
 8gEA==
X-Gm-Message-State: ABy/qLZTKRCWI5t9S6BsIk4TaW5E17tE7bJXr8Pu0ePldf5CyX5oX/1x
 qzdGeFq3TLvPBLZ1DQd8mEtGYmRw3Ds=
X-Google-Smtp-Source: APBJJlHl04WzsS0JbO8+AcXMMv0OpoGhs8pOjiRYo+7Ax6/2glNJWnOqHKS9sCcMH6TStXNL3sOI1Q==
X-Received: by 2002:ac2:5f48:0:b0:4f8:49a7:2deb with SMTP id
 8-20020ac25f48000000b004f849a72debmr1408529lfz.8.1690377938975; 
 Wed, 26 Jul 2023 06:25:38 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:38 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 17/44] Add RNG200 skeleton
Date: Wed, 26 Jul 2023 16:24:45 +0300
Message-Id: <20230726132512.149618-18-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x136.google.com
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
 hw/misc/bcm2838_rng200.c         | 118 +++++++++++++++++++++++++++++++
 hw/misc/meson.build              |   1 +
 hw/misc/trace-events             |  10 +++
 include/hw/misc/bcm2838_rng200.h |  77 ++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h

diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
new file mode 100644
index 0000000000..a17e8f2cda
--- /dev/null
+++ b/hw/misc/bcm2838_rng200.c
@@ -0,0 +1,118 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
+#include "hw/misc/bcm2838_rng200.h"
+#include "trace.h"
+
+static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
+{
+    state->rng_ctrl.value = 0;
+
+    trace_bcm2838_rng200_rng_soft_reset();
+}
+
+static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    uint32_t res = 0;
+
+    trace_bcm2838_rng200_read((void *)offset, size, res);
+    return res;
+}
+
+static void bcm2838_rng200_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+
+    trace_bcm2838_rng200_write((void *)offset, value, size);
+}
+
+static const MemoryRegionOps bcm2838_rng200_ops = {
+    .read = bcm2838_rng200_read,
+    .write = bcm2838_rng200_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+
+    if (s->rng == NULL) {
+        Object *default_backend = object_new(TYPE_RNG_BUILTIN);
+
+        object_property_add_child(OBJECT(dev), "default-backend",
+                                  default_backend);
+        object_unref(default_backend);
+
+        object_property_set_link(OBJECT(dev), "rng", default_backend,
+                                 errp);
+    }
+
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
+}
+
+static void bcm2838_rng200_init(Object *obj)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+    s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
+                                  NULL, s,
+                                  ClockPreUpdate);
+    if (s->clock == NULL) {
+        error_setg(&error_fatal, "Failed to init RBG clock");
+        return;
+    }
+
+    memory_region_init_io(&s->iomem, obj, &bcm2838_rng200_ops, s,
+                          TYPE_BCM2838_RNG200, 0x28);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void bcm2838_rng200_reset(DeviceState *dev)
+{
+    BCM2838Rng200State *s = BCM2838_RNG200(dev);
+    bcm2838_rng200_rng_reset(s);
+}
+
+static Property bcm2838_rng200_properties[] = {
+    DEFINE_PROP_UINT32("rbg-period", BCM2838Rng200State, rbg_period, 250),
+    DEFINE_PROP_UINT32("rng-fifo-cap", BCM2838Rng200State, rng_fifo_cap, 128),
+    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
+                     TYPE_RNG_BACKEND, RngBackend *),
+    DEFINE_PROP_BOOL("use-timer", BCM2838Rng200State, use_timer, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2838_rng200_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_rng200_realize;
+    dc->reset = bcm2838_rng200_reset;
+    device_class_set_props(dc, bcm2838_rng200_properties);
+}
+
+static const TypeInfo bcm2838_rng200_info = {
+    .name          = TYPE_BCM2838_RNG200,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2838Rng200State),
+    .class_init    = bcm2838_rng200_class_init,
+    .instance_init = bcm2838_rng200_init,
+};
+
+static void bcm2838_rng200_register_types(void)
+{
+    type_register_static(&bcm2838_rng200_info);
+}
+
+type_init(bcm2838_rng200_register_types)
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 892f8b91c5..a6230ced43 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -88,6 +88,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
+  'bcm2838_rng200.c'
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 4d1a0e17af..d26cd2d22d 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -297,3 +297,13 @@ virt_ctrl_instance_init(void *dev) "ctrl: %p"
 lasi_chip_mem_valid(uint64_t addr, uint32_t val) "access to addr 0x%"PRIx64" is %d"
 lasi_chip_read(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
 lasi_chip_write(uint64_t addr, uint32_t val) "addr 0x%"PRIx64" val 0x%08x"
+
+# bcm2838_rng200.c
+bcm2838_rng200_rng_soft_reset(void) "========= RNumG SOFT RESET ========="
+bcm2838_rng200_rbg_soft_reset(void) "========= RBitG SOFT RESET ========="
+bcm2838_rng200_enable_rbg(void)     "========= RBitG ENABLED ========="
+bcm2838_rng200_disable_rbg(void)    "========= RBitG DISABLED ========="
+bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
+bcm2838_rng200_fifo_full(void) "========= RNumG FIFO FULL ========="
+bcm2838_rng200_write(void *addr, uint64_t value, unsigned size) "addr %p, value 0x%016" PRIx64 ", size %u"
+bcm2838_rng200_read(void *addr, unsigned size, uint64_t value) "addr %p, size %u, value 0x%016" PRIx64
diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
new file mode 100644
index 0000000000..77f6cd8df4
--- /dev/null
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -0,0 +1,77 @@
+/*
+ * BCM2838 Random Number Generator emulation
+ *
+ * Copyright (C) 2022 Sergey Pushkarev <sergey.pushkarev@auriga.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef BCM2838_RNG200_H
+#define BCM2838_RNG200_H
+
+#include <stdbool.h>
+#include "qom/object.h"
+#include "qemu/fifo8.h"
+#include "sysemu/rng.h"
+#include "hw/sysbus.h"
+#include "hw/ptimer.h"
+#include "hw/qdev-clock.h"
+#include "hw/irq.h"
+
+#define TYPE_BCM2838_RNG200 "bcm2838-rng200"
+OBJECT_DECLARE_SIMPLE_TYPE(BCM2838Rng200State, BCM2838_RNG200)
+
+typedef union BCM2838Rng200Ctrl {
+    uint32_t value;
+    struct {
+        uint32_t rbg_enable:1;
+        uint32_t __r0:12;
+        uint32_t div:8;
+    };
+} BCM2838Rng200Ctrl;
+
+typedef union BCM2838Rng200Int {
+    uint32_t value;
+    struct {
+        uint32_t total_bits_count_irq:1;
+        uint32_t __r0:4;
+        uint32_t nist_fail_irq:1;
+        uint32_t __r1:11;
+        uint32_t startup_transition_met_irq:1;
+        uint32_t __r2:13;
+        uint32_t master_fail_lockout_irq:1;
+    };
+} BCM2838Rng200Int;
+
+typedef union BCM2838Rng200FifoCount {
+    uint32_t value;
+    struct {
+        uint32_t count:8;
+        uint32_t thld:8;
+    };
+} BCM2838Rng200FifoCount;
+
+struct BCM2838Rng200State {
+    SysBusDevice busdev;
+    MemoryRegion iomem;
+
+    ptimer_state *ptimer;
+    RngBackend *rng;
+    Clock *clock;
+
+    uint32_t rbg_period;
+    uint32_t rng_fifo_cap;
+    bool use_timer;
+
+    Fifo8    fifo;
+    qemu_irq irq;
+    BCM2838Rng200Ctrl rng_ctrl;
+    BCM2838Rng200Int rng_int_status;
+    BCM2838Rng200Int rng_int_enable;
+    uint32_t rng_total_bit_count;
+    BCM2838Rng200FifoCount rng_fifo_count;
+    uint32_t rng_bit_count_threshold;
+};
+
+#endif /* BCM2838_RNG200_H */
-- 
2.34.1


