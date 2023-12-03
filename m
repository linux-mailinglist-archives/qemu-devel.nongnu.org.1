Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F41980281C
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:51:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9uLR-00039w-HW; Sun, 03 Dec 2023 16:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLM-0002zW-6D; Sun, 03 Dec 2023 16:49:40 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9uLK-0008M2-1M; Sun, 03 Dec 2023 16:49:39 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5cdc0b3526eso31812647b3.1; 
 Sun, 03 Dec 2023 13:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701640175; x=1702244975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U3q6AiL1mbxBiKidAQHbdRXxykNtox5744GvYZOpg/0=;
 b=jhCPfIRERvvqBAg1E4UVz2Mz498gsujjRIp8zVD/hsjBjO9TPNXelkdd5hFSJEHbVa
 0IbqzJHQc/CFyU1L3dXguFn9ek1EI0Mz2P6LZZsthrs6+9yMN15WpxJpxzT08dPmOJkF
 h0x8441PaTQSOzjt4LmtaKq1d5BEtcgH9mSsSZaM7qGBfdHTepaU91BS9evYNluTDQ+m
 51Y713KV7svYtvaZgUD1a7jzVA481J0Fe0amH19gaEgtOK7MdR6io0l32AQm3Ha24P1r
 1R2YQCD03UplRDjLH2sXa/i9kZkzEae456NGnPkdoiEPdpDY0wFznJ5Kxr20kMPmOIhk
 hCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701640175; x=1702244975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U3q6AiL1mbxBiKidAQHbdRXxykNtox5744GvYZOpg/0=;
 b=U8SnIg6Gkj5Dck0qNTyKoDLXIPmBZXzy/F9yEQiGVGiZK7DkVf4AmhkooycEpLXJqM
 vN7dsu7AGU+0b/x3AptAy5l1C7RGppj5/wQj/XkEXAzG7SBtydJjv/iucyBHjlW3rssh
 clLZBk5qpYqScZAjvJRb838aQ3vfN9STGJOlJ0zvMc5utKGq+BJMAGvWEUV9nUyanDu2
 E/rgaSXLZWub/1Tbp+bR7J7MA9it/J3ksVpjaViMZLFGDKaoWmuBWiGuk2uCrrVnTfOO
 2BNo6zj/I/vG3qQ5LGykZS2Cuo2eqgrL+MHwR0ulFtR30bQmsc1yZ+xJZNcQ94kdC4Dq
 oxmw==
X-Gm-Message-State: AOJu0Yz34CTWCsErVStX0juqgNYWw2B/+tJQorFA6l92mnOu4CwbLpNR
 GvxbWpWPwfGeFnrbOjV6VjU3cMg4Se5fJA==
X-Google-Smtp-Source: AGHT+IHmm1Z/+xonKzMGrcuxgw4PqJZ1GkIHSbblQoMSJiX7mgRPpkUE1ivBtJ/2jKX+siUSbeWVeg==
X-Received: by 2002:a81:af5b:0:b0:5d7:1940:3ef3 with SMTP id
 x27-20020a81af5b000000b005d719403ef3mr1565637ywj.36.1701640175566; 
 Sun, 03 Dec 2023 13:49:35 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a816502000000b00597e912e67esm2832788ywb.131.2023.12.03.13.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:49:35 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 17/45] Add RNG200 skeleton
Date: Sun,  3 Dec 2023 15:48:42 -0600
Message-Id: <20231203214910.1364468-18-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203214910.1364468-17-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-1-sergey.kambalin@auriga.com>
 <20231203214910.1364468-2-sergey.kambalin@auriga.com>
 <20231203214910.1364468-3-sergey.kambalin@auriga.com>
 <20231203214910.1364468-4-sergey.kambalin@auriga.com>
 <20231203214910.1364468-5-sergey.kambalin@auriga.com>
 <20231203214910.1364468-6-sergey.kambalin@auriga.com>
 <20231203214910.1364468-7-sergey.kambalin@auriga.com>
 <20231203214910.1364468-8-sergey.kambalin@auriga.com>
 <20231203214910.1364468-9-sergey.kambalin@auriga.com>
 <20231203214910.1364468-10-sergey.kambalin@auriga.com>
 <20231203214910.1364468-11-sergey.kambalin@auriga.com>
 <20231203214910.1364468-12-sergey.kambalin@auriga.com>
 <20231203214910.1364468-13-sergey.kambalin@auriga.com>
 <20231203214910.1364468-14-sergey.kambalin@auriga.com>
 <20231203214910.1364468-15-sergey.kambalin@auriga.com>
 <20231203214910.1364468-16-sergey.kambalin@auriga.com>
 <20231203214910.1364468-17-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
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


