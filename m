Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F57F7CC30B
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:24:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsj6S-0006bM-NI; Tue, 17 Oct 2023 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6N-0006YE-Uy
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6J-0003v7-Vz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32d569e73acso5018297f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545386; x=1698150186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sW2pyrUMoN7MAwOg+RbuKX+jV96qwsneZRNARMZQCGw=;
 b=pPb6PxFdBzUrBXAkz9ChmdzdHV3CeYtxPF7FQDjOU2NhYcxh/gDI5zSCNIeG7/4GIe
 LTOIM3Erm6ApDd/fSluvlMegbIt53xoRn4GH9h3RNmkiHQUerhl3C5hUJZygwUgFaRkK
 5eE2/YBzLdX/yRzw53AePRqPA4r6YmauncxJWSDHEf00bcDGdDCqbSeyiDu51GkZGZxJ
 XI52rNgqJ5jZohhl6N0Q9SuJ63IQLXLw1HWlBBI2eGkvfn77wEtHZHFy0EZdS3+keRjY
 npnwcO8JhWq+Ov2AdcT687gRtFfIS+9jqANiDqb0EOJydTQMKTNg498qxwCl8Ts3PZhw
 8Jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545386; x=1698150186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sW2pyrUMoN7MAwOg+RbuKX+jV96qwsneZRNARMZQCGw=;
 b=X+cY81Kx3PxxLo5wDGy1AYXo5ciIabo5Ri0qUoVaQ6chYz4/asmwlFVd1AEFQ8/z/T
 dnPShIH48KDZOUEYVI6Ytpq3VbiB9t5h7K9srcky+p77ZuIOsqqEQ+/WVL088Jr3k073
 yOut7LwzL+y0QN4csKIjUxz6JOR14/ATYxyZtNpw224rTq86nq4MaHmMew7XqL8ft0Ti
 TYTVySS8h+Zo3EY1+hCW0eJM6ImjKhOeRCU2EPgfrvMKDhiGnffvYTHbLaNq/oqRK9fJ
 8WK9syBO7C/+N/KdobNA2AcKFo5Ucya+lG9VwJa6MCr9cZQ2nxN6hjZ+sQ7NcbomR91o
 XBxA==
X-Gm-Message-State: AOJu0Yy8O1pNtcyh4MIFbLAEj+eBFrn3fXgu+vlV+1dcTPYFw+/fP4oJ
 L9/NYWcAN9pG1VbqamrjmHDkL6/7ZBMLtl1Culc=
X-Google-Smtp-Source: AGHT+IHMPvr8fh2igwNawkxxbeT0ipVNkI2IM5uc7d+FWnrArfsH+zY1Z48CHDTC+ZbYzSWUC45caA==
X-Received: by 2002:a05:6000:1282:b0:32d:84a3:f3fe with SMTP id
 f2-20020a056000128200b0032d84a3f3femr1940788wrx.41.1697545386722; 
 Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0032da4c98ab2sm1590905wrs.35.2023.10.17.05.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 5/6] hw/input/stellaris_input: Convert to qdev
Date: Tue, 17 Oct 2023 13:23:01 +0100
Message-Id: <20231017122302.1692902-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert the hw/input/stellaris_input device to qdev.

The interface uses an array property for the board to specify the
keycodes to use, so the s->keycodes memory is now allocated by the
array-property machinery.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/input/stellaris_gamepad.h | 25 +++++++++-
 hw/arm/stellaris.c                   | 26 +++++++---
 hw/input/stellaris_gamepad.c         | 73 +++++++++++++++++++---------
 3 files changed, 92 insertions(+), 32 deletions(-)

diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index 23cfd3c95f3..50c17041121 100644
--- a/include/hw/input/stellaris_gamepad.h
+++ b/include/hw/input/stellaris_gamepad.h
@@ -11,8 +11,29 @@
 #ifndef HW_INPUT_STELLARIS_GAMEPAD_H
 #define HW_INPUT_STELLARIS_GAMEPAD_H
 
+#include "hw/sysbus.h"
+#include "qom/object.h"
 
-/* stellaris_gamepad.c */
-void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode);
+/*
+ * QEMU interface:
+ *  + QOM array property "keycodes": uint32_t QEMU keycodes to handle
+ *  + unnamed GPIO outputs: one per keycode, in the same order as the
+ *    "keycodes" array property entries; asserted when key is down
+ */
+
+#define TYPE_STELLARIS_GAMEPAD "stellaris-gamepad"
+OBJECT_DECLARE_SIMPLE_TYPE(StellarisGamepad, STELLARIS_GAMEPAD)
+
+struct StellarisGamepad {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    uint32_t num_buttons;
+    qemu_irq *irqs;
+    uint32_t *keycodes;
+    uint8_t *pressed;
+    int extension;
+};
 
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 96585dd7106..707b0dae375 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -31,6 +31,7 @@
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
+#include "qapi/qmp/qlist.h"
 
 #define GPIO_A 0
 #define GPIO_B 1
@@ -1274,16 +1275,27 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
     }
     if (board->peripherals & BP_GAMEPAD) {
-        qemu_irq gpad_irq[5];
+        QList *gpad_keycode_list = qlist_new();
         static const int gpad_keycode[5] = { 0xc8, 0xd0, 0xcb, 0xcd, 0x1d };
+        DeviceState *gpad;
 
-        gpad_irq[0] = qemu_irq_invert(gpio_in[GPIO_E][0]); /* up */
-        gpad_irq[1] = qemu_irq_invert(gpio_in[GPIO_E][1]); /* down */
-        gpad_irq[2] = qemu_irq_invert(gpio_in[GPIO_E][2]); /* left */
-        gpad_irq[3] = qemu_irq_invert(gpio_in[GPIO_E][3]); /* right */
-        gpad_irq[4] = qemu_irq_invert(gpio_in[GPIO_F][1]); /* select */
+        gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
+        for (i = 0; i < ARRAY_SIZE(gpad_keycode); i++) {
+            qlist_append_int(gpad_keycode_list, gpad_keycode[i]);
+        }
+        qdev_prop_set_array(gpad, "keycodes", gpad_keycode_list);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(gpad), &error_fatal);
 
-        stellaris_gamepad_init(5, gpad_irq, gpad_keycode);
+        qdev_connect_gpio_out(gpad, 0,
+                              qemu_irq_invert(gpio_in[GPIO_E][0])); /* up */
+        qdev_connect_gpio_out(gpad, 1,
+                              qemu_irq_invert(gpio_in[GPIO_E][1])); /* down */
+        qdev_connect_gpio_out(gpad, 2,
+                              qemu_irq_invert(gpio_in[GPIO_E][2])); /* left */
+        qdev_connect_gpio_out(gpad, 3,
+                              qemu_irq_invert(gpio_in[GPIO_E][3])); /* right */
+        qdev_connect_gpio_out(gpad, 4,
+                              qemu_irq_invert(gpio_in[GPIO_F][1])); /* select */
     }
     for (i = 0; i < 7; i++) {
         if (board->dc4 & (1 << i)) {
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index da974400b59..48d37bd6275 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -8,19 +8,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "hw/input/stellaris_gamepad.h"
 #include "hw/irq.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 
-typedef struct {
-    uint32_t num_buttons;
-    int extension;
-    qemu_irq *irqs;
-    uint32_t *keycodes;
-    uint8_t *pressed;
-} StellarisGamepad;
-
 static void stellaris_gamepad_put_key(void * opaque, int keycode)
 {
     StellarisGamepad *s = (StellarisGamepad *)opaque;
@@ -57,22 +51,55 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
     }
 };
 
-/* Returns an array of 5 output slots.  */
-void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
+static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
 {
-    StellarisGamepad *s;
-    int i;
+    StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
 
-    s = g_new0(StellarisGamepad, 1);
-    s->irqs = g_new0(qemu_irq, n);
-    s->keycodes = g_new0(uint32_t, n);
-    s->pressed = g_new0(uint8_t, n);
-    for (i = 0; i < n; i++) {
-        s->irqs[i] = irq[i];
-        s->keycodes[i] = keycode[i];
+    if (s->num_buttons == 0) {
+        error_setg(errp, "keycodes property array must be set");
+        return;
     }
-    s->num_buttons = n;
-    qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
-    vmstate_register(NULL, VMSTATE_INSTANCE_ID_ANY,
-                     &vmstate_stellaris_gamepad, s);
+
+    s->irqs = g_new0(qemu_irq, s->num_buttons);
+    s->pressed = g_new0(uint8_t, s->num_buttons);
+    qdev_init_gpio_out(dev, s->irqs, s->num_buttons);
+    qemu_add_kbd_event_handler(stellaris_gamepad_put_key, dev);
 }
+
+static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
+{
+    StellarisGamepad *s = STELLARIS_GAMEPAD(obj);
+
+    memset(s->pressed, 0, s->num_buttons * sizeof(uint8_t));
+}
+
+static Property stellaris_gamepad_properties[] = {
+    DEFINE_PROP_ARRAY("keycodes", StellarisGamepad, num_buttons,
+                      keycodes, qdev_prop_uint32, uint32_t),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void stellaris_gamepad_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    rc->phases.enter = stellaris_gamepad_reset_enter;
+    dc->realize = stellaris_gamepad_realize;
+    dc->vmsd = &vmstate_stellaris_gamepad;
+    device_class_set_props(dc, stellaris_gamepad_properties);
+}
+
+static const TypeInfo stellaris_gamepad_info = {
+    .name = TYPE_STELLARIS_GAMEPAD,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(StellarisGamepad),
+    .class_init = stellaris_gamepad_class_init,
+};
+
+static void stellaris_gamepad_register_types(void)
+{
+    type_register_static(&stellaris_gamepad_info);
+}
+
+type_init(stellaris_gamepad_register_types);
-- 
2.34.1


