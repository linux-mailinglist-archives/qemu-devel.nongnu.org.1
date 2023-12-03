Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F176F8027EE
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 22:36:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9u2S-0002Ve-K9; Sun, 03 Dec 2023 16:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1t-0001SU-SH; Sun, 03 Dec 2023 16:29:40 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9u1q-0005SY-SP; Sun, 03 Dec 2023 16:29:33 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-db8892a5f96so844416276.2; 
 Sun, 03 Dec 2023 13:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701638968; x=1702243768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcKM0zsaUF6OxJgIAQHfOevQ93BKCzxRx4ONFnlRnhk=;
 b=A/qlYS2c8TdYXS4twjeGUkBg87C1m8pa2VmP9vtEnCml9WCWRlV/YTr9a6qwCF+iga
 iHAF/vwkSeqck9Zk1VbQSRybfyPPtCF7Zl5H9AWasnk7wIRqgUhC7Y0Yd/IX30XAmAR1
 KbN6m1/35CvAjYE637bXYc2uz41Ve1uBklI+QrudrIK2XldRGgrNwUYR3pKp6UwMa9uR
 8TXqbG3BAf8xOxEr21seJ2dNRe9iEzWQ9tutDyIE8hRG1bus5f+jCw6Rw+ORWYbLCKvz
 k2V7dX5Rt/kXq3sonwW9Jyf4djCLFCL72kzPekq4z6JnMXe3Oq1+wbvebN3CZfh9CRdA
 5kDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701638968; x=1702243768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcKM0zsaUF6OxJgIAQHfOevQ93BKCzxRx4ONFnlRnhk=;
 b=IS5xoY3YT07BwwNo3++sDHh0mqJP9O5xoBbtqPAgoMbdKpl8drg6+Pyk+hQrcMb8w7
 T9ChjFWGknsFhR1HdVYoKsWVbrvxPDFB9RdsQZxGHfS5yGgwNWn4q37wOXfQdbUkemPs
 Yj4WC+thYQQJ+4E+AndcYw2/D6uLvAlafi0M3pbKbn+r7Em9fGBWlPiooNQwsJwYRHKH
 zbtCPrC2ZBlZ8UUctR+m1hLW/q3dxb6J/k4Iy0KYdNATOkDD44KA4W35sMY/3K9phC9c
 04rc+pcN4SuAwoT3VpY1AEXQNdAlaqTKJBIF5jD2FaNTE8ak2rO8/RHDxkArd/i1b5li
 incA==
X-Gm-Message-State: AOJu0YyA/HXIgB+I2ncxKWICQFBVcYz6j1b7kVxvJEOsKYiTzguTdzkl
 EyYKfWnTt+hfjb1CQhZbt3forAiqfYRaPg==
X-Google-Smtp-Source: AGHT+IEA3yizIZ19/3Eenqlq9PoUsv1tjk2uDJ2nTN5r+IgSuwKOnFDoH6Jp4TLVma9yJhO+HHZ0Iw==
X-Received: by 2002:a5b:f52:0:b0:db3:fd6b:758b with SMTP id
 y18-20020a5b0f52000000b00db3fd6b758bmr2038434ybr.48.1701638968691; 
 Sun, 03 Dec 2023 13:29:28 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 c17-20020a25a291000000b00d9cc606c78csm1807318ybi.41.2023.12.03.13.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 13:29:28 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 19/45] Get rid of RNG200 timer
Date: Sun,  3 Dec 2023 15:28:39 -0600
Message-Id: <20231203212905.1364036-20-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231203212905.1364036-19-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-1-sergey.kambalin@auriga.com>
 <20231203212905.1364036-2-sergey.kambalin@auriga.com>
 <20231203212905.1364036-3-sergey.kambalin@auriga.com>
 <20231203212905.1364036-4-sergey.kambalin@auriga.com>
 <20231203212905.1364036-5-sergey.kambalin@auriga.com>
 <20231203212905.1364036-6-sergey.kambalin@auriga.com>
 <20231203212905.1364036-7-sergey.kambalin@auriga.com>
 <20231203212905.1364036-8-sergey.kambalin@auriga.com>
 <20231203212905.1364036-9-sergey.kambalin@auriga.com>
 <20231203212905.1364036-10-sergey.kambalin@auriga.com>
 <20231203212905.1364036-11-sergey.kambalin@auriga.com>
 <20231203212905.1364036-12-sergey.kambalin@auriga.com>
 <20231203212905.1364036-13-sergey.kambalin@auriga.com>
 <20231203212905.1364036-14-sergey.kambalin@auriga.com>
 <20231203212905.1364036-15-sergey.kambalin@auriga.com>
 <20231203212905.1364036-16-sergey.kambalin@auriga.com>
 <20231203212905.1364036-17-sergey.kambalin@auriga.com>
 <20231203212905.1364036-18-sergey.kambalin@auriga.com>
 <20231203212905.1364036-19-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=serg.oker@gmail.com; helo=mail-yb1-xb2f.google.com
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
 hw/arm/bcm2838_peripherals.c         | 14 +++++
 hw/arm/raspi4b.c                     |  1 -
 hw/misc/bcm2838_rng200.c             | 78 ++++++++++++++++------------
 include/hw/arm/bcm2838_peripherals.h |  2 +
 include/hw/misc/bcm2838_rng200.h     |  4 +-
 5 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index ee06214715..7c489c8e8a 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -34,6 +34,9 @@ static void bcm2838_peripherals_init(Object *obj)
                        bc->peri_low_size);
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->peri_low_mr);
 
+    /* Random Number Generator */
+    object_initialize_child(obj, "rng200", &s->rng200, TYPE_BCM2838_RNG200);
+
     /* PCIe Host Bridge */
     object_initialize_child(obj, "pcie-host", &s->pcie_host,
                             TYPE_BCM2838_PCIE_HOST);
@@ -85,6 +88,17 @@ static void bcm2838_peripherals_realize(DeviceState *dev, Error **errp)
                                         BCM2838_VC_PERI_LOW_BASE,
                                         &s->peri_low_mr_alias, 1);
 
+    /* Random Number Generator */
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->rng200), errp)) {
+        return;
+    }
+    memory_region_add_subregion(
+        &s_base->peri_mr, RNG_OFFSET,
+        sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->rng200), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->rng200), 0,
+        qdev_get_gpio_in_named(DEVICE(&s_base->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_RNG));
+
     /* Extended Mass Media Controller 2 */
     object_property_set_uint(OBJECT(&s->emmc2), "sd-spec-version", 3,
                              &error_abort);
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 2e8474e1c5..7b5385b8dd 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -67,7 +67,6 @@ static void raspi4_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
     /* Temporarily disable following devices until they are implemented*/
     const char *to_be_removed_from_dt_as_wa[] = {
-        "brcm,bcm2711-rng200",
         "brcm,bcm2711-thermal",
         "brcm,bcm2711-genet-v5",
     };
diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
index f91ea0754c..1b334b94d5 100644
--- a/hw/misc/bcm2838_rng200.c
+++ b/hw/misc/bcm2838_rng200.c
@@ -9,6 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qom/object_interfaces.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
 #include "hw/misc/bcm2838_rng200.h"
@@ -64,10 +65,7 @@ static const VMStateDescription vmstate_bcm2838_rng200 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(rbg_period, BCM2838Rng200State),
         VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
-        VMSTATE_BOOL(use_timer, BCM2838Rng200State),
-
         VMSTATE_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS, 0,
                       vmstate_info_uint32, uint32_t),
 
@@ -90,6 +88,15 @@ static void bcm2838_rng200_update_irq(BCM2838Rng200State *s)
                 !!(s->regs[R_RNG_INT_ENABLE] & s->regs[R_RNG_INT_STATUS]));
 }
 
+static void bcm2838_rng200_update_rbg_period(void *opaque, ClockEvent event)
+{
+    BCM2838Rng200State *s = (BCM2838Rng200State *)opaque;
+
+    ptimer_transaction_begin(s->ptimer);
+    ptimer_set_period_from_clock(s->ptimer, s->clock, s->rng_fifo_cap * 8);
+    ptimer_transaction_commit(s->ptimer);
+}
+
 static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
                                        size_t size)
 {
@@ -121,18 +128,17 @@ static void bcm2838_rng200_update_fifo(void *opaque, const void *buf,
     if ((num == 0) && (num_bits > 0)) {
         num = 1;
     }
-    if (num > 0) {
-        fifo8_push_all(fifo, buf, num);
 
+    fifo8_push_all(fifo, buf, num);
 
-        fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
-                               RNG_FIFO_COUNT, THRESHOLD);
 
-        if (fifo8_num_used(fifo) > fifo_thld) {
-            s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
-                                                   RNG_INT_STATUS,
-                                                   TOTAL_BITS_COUNT_IRQ, 1);
-        }
+    fifo_thld = FIELD_EX32(s->regs[R_RNG_FIFO_COUNT],
+                            RNG_FIFO_COUNT, THRESHOLD);
+
+    if (fifo8_num_used(fifo) > fifo_thld) {
+        s->regs[R_RNG_INT_STATUS] = FIELD_DP32(s->regs[R_RNG_INT_STATUS],
+                                                RNG_INT_STATUS,
+                                                TOTAL_BITS_COUNT_IRQ, 1);
     }
 
     s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
@@ -149,9 +155,7 @@ static void bcm2838_rng200_fill_fifo(BCM2838Rng200State *s)
                                 bcm2838_rng200_update_fifo, s);
 }
 
-/* This function will be implemnented in upcoming commits */
-static void bcm2838_rng200_disable_rbg(BCM2838Rng200State *s
-                                       __attribute__((unused)))
+static void bcm2838_rng200_disable_rbg(void)
 {
     trace_bcm2838_rng200_disable_rbg();
 }
@@ -184,23 +188,21 @@ static void bcm2838_rng200_rbg_reset(BCM2838Rng200State *s)
 
 static uint32_t bcm2838_rng200_read_fifo_data(BCM2838Rng200State *s)
 {
-    Fifo8 *fifo = &s->fifo;
     const uint8_t *buf;
+    Fifo8 *fifo = &s->fifo;
+    uint32_t to_read = MIN(fifo8_num_used(fifo), 4);
+    uint8_t byte_buf[4] = {};
+    uint8_t *p = byte_buf;
     uint32_t ret = 0;
     uint32_t num = 0;
-    uint32_t max = MIN(fifo8_num_used(fifo), sizeof(ret));
 
-    if (max > 0) {
-        buf = fifo8_pop_buf(fifo, max, &num);
-        if ((buf != NULL) && (num > 0)) {
-            memcpy(&ret, buf, num);
-        }
-    } else {
-        qemu_log_mask(
-            LOG_GUEST_ERROR,
-            "bcm2838_rng200_read_fifo_data: FIFO is empty\n"
-        );
+    while (to_read) {
+        buf = fifo8_pop_buf(fifo, to_read, &num);
+        memcpy(p, buf, num);
+        p += num;
+        to_read -= num;
     }
+    ret = ldl_le_p(byte_buf);
 
     s->regs[R_RNG_FIFO_COUNT] = FIELD_DP32(s->regs[R_RNG_FIFO_COUNT],
                                            RNG_FIFO_COUNT,
@@ -222,7 +224,7 @@ static void bcm2838_rng200_ctrl_write(BCM2838Rng200State *s, uint32_t value)
     if (!currently_enabled && enable_requested) {
         bcm2838_rng200_enable_rbg(s);
     } else if (currently_enabled && !enable_requested) {
-        bcm2838_rng200_disable_rbg(s);
+        bcm2838_rng200_disable_rbg();
     }
 }
 
@@ -321,6 +323,14 @@ static const MemoryRegionOps bcm2838_rng200_ops = {
     .read = bcm2838_rng200_read,
     .write = bcm2838_rng200_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .impl = {
+        .max_access_size = 4,
+        .min_access_size = 4,
+    },
+    .valid = {
+        .max_access_size = 4,
+        .min_access_size = 4
+    },
 };
 
 static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
@@ -330,6 +340,13 @@ static void bcm2838_rng200_realize(DeviceState *dev, Error **errp)
     if (s->rng == NULL) {
         Object *default_backend = object_new(TYPE_RNG_BUILTIN);
 
+        if (!user_creatable_complete(USER_CREATABLE(default_backend),
+                                     errp)) {
+            object_unref(default_backend);
+            error_setg(errp, "Failed to create user creatable RNG backend");
+            return;
+        }
+
         object_property_add_child(OBJECT(dev), "default-backend",
                                   default_backend);
         object_unref(default_backend);
@@ -347,13 +364,10 @@ static void bcm2838_rng200_init(Object *obj)
     BCM2838Rng200State *s = BCM2838_RNG200(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    s->rbg_period = 250;
-    s->use_timer = true;
-
     s->rng_fifo_cap = 128;
 
     s->clock = qdev_init_clock_in(DEVICE(s), "rbg-clock",
-                                  NULL, s,
+                                  bcm2838_rng200_update_rbg_period, s,
                                   ClockPreUpdate);
     if (s->clock == NULL) {
         error_setg(&error_fatal, "Failed to init RBG clock");
diff --git a/include/hw/arm/bcm2838_peripherals.h b/include/hw/arm/bcm2838_peripherals.h
index 2af96df1c6..317df005bf 100644
--- a/include/hw/arm/bcm2838_peripherals.h
+++ b/include/hw/arm/bcm2838_peripherals.h
@@ -10,6 +10,7 @@
 #define BCM2838_PERIPHERALS_H
 
 #include "hw/arm/bcm2835_peripherals.h"
+#include "hw/misc/bcm2838_rng200.h"
 #include "hw/arm/bcm2838_pcie.h"
 #include "hw/sd/sdhci.h"
 #include "hw/gpio/bcm2838_gpio.h"
@@ -65,6 +66,7 @@ struct BCM2838PeripheralState {
     MemoryRegion mphi_mr_alias;
     MemoryRegion pcie_mmio_alias;
 
+    BCM2838Rng200State rng200;
     SDHCIState emmc2;
     BCM2838PcieHostState pcie_host;
     BCM2838GpioState gpio;
diff --git a/include/hw/misc/bcm2838_rng200.h b/include/hw/misc/bcm2838_rng200.h
index 46fdba48da..8e084b7254 100644
--- a/include/hw/misc/bcm2838_rng200.h
+++ b/include/hw/misc/bcm2838_rng200.h
@@ -32,11 +32,9 @@ struct BCM2838Rng200State {
     RngBackend *rng;
     Clock *clock;
 
-    uint32_t rbg_period;
     uint32_t rng_fifo_cap;
-    bool use_timer;
-
     Fifo8    fifo;
+
     qemu_irq irq;
 
     uint32_t regs[N_BCM2838_RNG200_REGS];
-- 
2.34.1


