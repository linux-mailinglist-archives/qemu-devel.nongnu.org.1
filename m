Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D180994D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:35:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQfu-0004cF-NL; Thu, 07 Dec 2023 21:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfe-0004MF-Ry; Thu, 07 Dec 2023 21:32:55 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQfc-0002WZ-1P; Thu, 07 Dec 2023 21:32:54 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c9ea37ac87so21349071fa.3; 
 Thu, 07 Dec 2023 18:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002770; x=1702607570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3q6AiL1mbxBiKidAQHbdRXxykNtox5744GvYZOpg/0=;
 b=d2hPdb41iWESWGo/Rxtm2rvuVZEOl6uAlSFCVw9CCQ0YPGxqKXgqbC3HRHi4fGabPY
 0FslzBGYB1ysoTfHRrT33wVa55RXyFR02KAdVkF/m1/nrgP7hbCe2aedus4YXcOb/RPt
 LaBdFbPBvugh01t8xhFdvU/CJpWQXcoeCUvFHtV7Y7uTu0ngF+DQf9L5BlU2FhG7XMNZ
 cNt62tdr2Epc2okcWSEV3289mod7AgKxmdGdAz6POt1Qoh+RNC0nbfqsCNGlRoRR29Gk
 quCQp9WKeoIwlqoHvMj2C0l+02JqjOZy9++vx1QgYa8SSDtz1sxl79xYPcVt3j9ucWYR
 OV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002770; x=1702607570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3q6AiL1mbxBiKidAQHbdRXxykNtox5744GvYZOpg/0=;
 b=Q8qPu1XEaxsxNbX0quOzX8OvaFwBpxIFe5LYPbf6+xi8ER5Pv6u3dLnv3pq0dYlIsv
 UHcTgJas4pU8OvejVENqKaqAzjfZ04+1WNrcnvZV2E4zjIMiip+XnqQ3/elAfQ9j7Lts
 Ty5gR0wUsW3LWb74Qxp/Jh0LMJ7X+buH7a9VLtAm3LzWd7NawSJAFsZIc68kD/EkRJAz
 oQEnVKEzqnkjp9du5BFSxAfm2TRZ0Wc+TUGsaDy8z1ZNf2bZ6lU1kFCvKshpRSi/DQtH
 amHcBdMWjjFtNok4yAdDvayzlvsP0CnJroJVG1XT2fwOcmCR3jNtT3FwcU4hTgZ2Yldl
 XhOQ==
X-Gm-Message-State: AOJu0YxWOmwSYAt/T4KUalkvUeKgxDUeI5y+locc2KUOEi/YREQjaTEq
 sdZZtij2YrlvkPF9lE7XGDmrKXs0hklJPQ==
X-Google-Smtp-Source: AGHT+IGyNYFH6RtJBa0e2ljJGnDjKOR0B6EiPRRjVnLMgzJYZLrjH4nFLMxyjFIhl3R0agERMIEZlw==
X-Received: by 2002:a2e:b781:0:b0:2ca:2bd:3cf1 with SMTP id
 n1-20020a2eb781000000b002ca02bd3cf1mr1892212ljo.8.1702002769810; 
 Thu, 07 Dec 2023 18:32:49 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:32:49 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 17/45] Add RNG200 skeleton
Date: Thu,  7 Dec 2023 20:31:17 -0600
Message-Id: <20231208023145.1385775-18-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x22b.google.com
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
 hw/misc/bcm2838_rng200.c         | 152 +++++++++++++++++++++++++++++++
 hw/misc/meson.build              |   1 +
 hw/misc/trace-events             |   9 ++
 include/hw/misc/bcm2838_rng200.h |  51 +++++++++++
 4 files changed, 213 insertions(+)
 create mode 100644 hw/misc/bcm2838_rng200.c
 create mode 100644 include/hw/misc/bcm2838_rng200.h

diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
new file mode 100644
index 0000000000..8f64e6a20f
--- /dev/null
+++ b/hw/misc/bcm2838_rng200.c
@@ -0,0 +1,152 @@
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
+#include "migration/vmstate.h"
+#include "trace.h"
+
+static const VMStateDescription vmstate_bcm2838_rng200_regs = {
+    .name = "bcm2838_rng200_regs",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctrl, BCM2838_rng_regs_t),
+        VMSTATE_UINT32(int_status, BCM2838_rng_regs_t),
+        VMSTATE_UINT32(fifo_count, BCM2838_rng_regs_t),
+        VMSTATE_UINT32(fifo_count_threshold, BCM2838_rng_regs_t),
+        VMSTATE_UINT32(total_bit_count_threshold, BCM2838_rng_regs_t),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static const VMStateDescription vmstate_bcm2838_rng200 = {
+    .name = "bcm2838_rng200",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(rbg_period, BCM2838Rng200State),
+        VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
+        VMSTATE_BOOL(use_timer, BCM2838Rng200State),
+
+        VMSTATE_STRUCT(regs, BCM2838Rng200State, 0, vmstate_bcm2838_rng200_regs,
+                       BCM2838_rng_regs_t),
+
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void bcm2838_rng200_rng_reset(BCM2838Rng200State *state)
+{
+    state->regs.ctrl = 0;
+
+    trace_bcm2838_rng200_rng_soft_reset();
+}
+
+static uint64_t bcm2838_rng200_read(void *opaque, hwaddr offset,
+                                    unsigned size)
+{
+    uint32_t res = 0;
+
+    /* will be implemented in upcoming commits */
+    return res;
+}
+
+static void bcm2838_rng200_write(void *opaque, hwaddr offset,
+                                 uint64_t value, unsigned size)
+{
+    /* will be implemented in upcoming commits */
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
+    s->rbg_period = 250;
+    s->use_timer = true;
+
+    s->rng_fifo_cap = 128;
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
+    DEFINE_PROP_LINK("rng", BCM2838Rng200State, rng,
+                     TYPE_RNG_BACKEND, RngBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void bcm2838_rng200_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = bcm2838_rng200_realize;
+    dc->reset = bcm2838_rng200_reset;
+    dc->vmsd = &vmstate_bcm2838_rng200;
+
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
index 36c20d5637..b899e6b596 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -91,6 +91,7 @@ system_ss.add(when: 'CONFIG_RASPI', if_true: files(
   'bcm2835_thermal.c',
   'bcm2835_cprman.c',
   'bcm2835_powermgt.c',
+  'bcm2838_rng200.c'
 ))
 system_ss.add(when: 'CONFIG_SLAVIO', if_true: files('slavio_misc.c'))
 system_ss.add(when: 'CONFIG_ZYNQ', if_true: files('zynq_slcr.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 05ff692441..5e5d3fe61a 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -330,3 +330,12 @@ djmemc_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRI
 # iosb.c
 iosb_read(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
 iosb_write(int reg, uint64_t value, unsigned int size) "reg=0x%x value=0x%"PRIx64" size=%u"
+# bcm2838_rng200.c
+bcm2838_rng200_rng_soft_reset(void) "RNumG soft reset"
+bcm2838_rng200_rbg_soft_reset(void) "RBitG soft reset"
+bcm2838_rng200_enable_rbg(void)     "RBitG enabled"
+bcm2838_rng200_disable_rbg(void)    "RBitG disabled"
+bcm2838_rng200_update_fifo(uint32_t len, uint32_t fifo_len)    "len %u, fifo_len %u"
+bcm2838_rng200_fifo_full(void) "RNumG FIFO full"
+bcm2838_rng200_write(uint64_t addr, uint64_t value, unsigned size) "addr: 0x%"PRIx64" value: 0x%016" PRIx64 " size: %u"
+bcm2838_rng200_read(uint64_t addr, unsigned size, uint64_t value) "addr: 0x%"PRIx64" size: %u value: 0x%016" PRIx64
diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
new file mode 100644
index 0000000000..c9c52f84be
--- /dev/null
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -0,0 +1,51 @@
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
+typedef struct {
+    uint32_t ctrl;
+    uint32_t int_status;
+    uint32_t fifo_count;
+    uint32_t fifo_count_threshold;
+    uint32_t total_bit_count_threshold;
+} BCM2838_rng_regs_t;
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
+
+    BCM2838_rng_regs_t regs;
+};
+
+#endif /* BCM2838_RNG200_H */
-- 
2.34.1


