Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9DC7E081F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 19:29:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyyto-0001kC-0I; Fri, 03 Nov 2023 14:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyytm-0001jd-AR
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:28:02 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyyte-0007AU-Kq
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 14:28:02 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so1594336f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699036073; x=1699640873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+EVTungCfjDjTacji5Eqs9/sv58Ra/hS/gF67unlV+M=;
 b=J7blYejozMCugUYX3MSVHHG2j926sHxqcOVq/N1Zuyp0BXwqou7qNo9JIzNXG7JQ8r
 9c2Ok/1ePEhCOS75JBO6uBmVm92FRn8vOySPBgj3X6zn++pj0F07b4AHjhdkbqK5Ele2
 3mz/T0ZrRA/BTlC580TjfXhZC6Ps10krTpyDEL10Lz6Hi6VT/mY0sHX5GLRMSmXvlAxf
 EqGTw6LPFzc022sVgMhl1mFyIqNgJ3bPUvRiWK1F6XWLrFdfhMq9bmnNP6PaCqSNQTd/
 f4QLbc1ctWmIu5td3wB+oKAtk/eGbT3F+T5J0D5i8AgDIhIYYR7QDU/S9Zy4Z3pzm6Kz
 g1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699036073; x=1699640873;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+EVTungCfjDjTacji5Eqs9/sv58Ra/hS/gF67unlV+M=;
 b=CL8iNkP4pmqBtnVkJVi8Erq0IaX3wmgpAZBn5gqw6b2pKMO7T9sdQ61Mro2nlnjMRZ
 5WdJzHVCWVEVFGqyZz/Nddv3VLIjabvVyGK4HYA46me1bA12WV6eYq7VxhL9JRM0gew3
 Yiv14PvaR17xhl3zEjI6ale6HB7zYaFewk4tnva45ZKKHdOMAiJzm1krf4dvudJ7aMFD
 DxuVndkgBNKSW8urhuC7ywvClFBPVHjPd52IuYYgOp0tXv4c7nfxTrzRthT4Fp1iuIf5
 +bnp7Pfjg2Nb8u9bkU2coPZbdJKLXN1wutB6BBB2nX/Au5y8FUoUkgfUfQnzhtg9DLfN
 p5sA==
X-Gm-Message-State: AOJu0YxR4nnCDrp+a7kErkvm6N2Ec/PrxuO6T1h8bvD8i5KQtxgCGhD+
 lqWKxy4+lPdy9WME0i7FYsQ58w==
X-Google-Smtp-Source: AGHT+IF7EveEAMs6BsQht2VPo5CV3E0cgZk8MYNwSK188zEc21SGjDtTXPIRhMPSm2S+bqAPVtOToQ==
X-Received: by 2002:a5d:4e06:0:b0:32d:7efc:7e1f with SMTP id
 p6-20020a5d4e06000000b0032d7efc7e1fmr14761777wrt.71.1699036072728; 
 Fri, 03 Nov 2023 11:27:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adfe487000000b0032de6f95fb3sm2423224wrm.40.2023.11.03.11.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 11:27:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH] hw/arm/musicpal: Convert to qemu_add_kbd_event_handler()
Date: Fri,  3 Nov 2023 18:27:50 +0000
Message-Id: <20231103182750.855577-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Convert the musicpal key input device to use
qemu_add_kbd_event_handler().  This lets us simplify it because we no
longer need to track whether we're in the middle of a PS/2 multibyte
key sequence.

In the conversion we move the keyboard handler registration from init
to realize, because devices shouldn't disturb the state of the
simulation by doing things like registering input handlers until
they're realized, so that device objects can be introspected
safely.

The behaviour where key-repeat is permitted for the arrow-keys only
is intentional (added in commit 7c6ce4baedfcd0c), so we retain it,
and add a comment to that effect.

This is a migration compatibility break for musicpal.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/musicpal.c | 131 +++++++++++++++++++++-------------------------
 1 file changed, 61 insertions(+), 70 deletions(-)

diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9703bfb97fb..e8c1250ab04 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1043,20 +1043,6 @@ static const TypeInfo musicpal_gpio_info = {
 };
 
 /* Keyboard codes & masks */
-#define KEY_RELEASED            0x80
-#define KEY_CODE                0x7f
-
-#define KEYCODE_TAB             0x0f
-#define KEYCODE_ENTER           0x1c
-#define KEYCODE_F               0x21
-#define KEYCODE_M               0x32
-
-#define KEYCODE_EXTENDED        0xe0
-#define KEYCODE_UP              0x48
-#define KEYCODE_DOWN            0x50
-#define KEYCODE_LEFT            0x4b
-#define KEYCODE_RIGHT           0x4d
-
 #define MP_KEY_WHEEL_VOL       (1 << 0)
 #define MP_KEY_WHEEL_VOL_INV   (1 << 1)
 #define MP_KEY_WHEEL_NAV       (1 << 2)
@@ -1074,67 +1060,66 @@ struct musicpal_key_state {
     SysBusDevice parent_obj;
     /*< public >*/
 
-    uint32_t kbd_extended;
     uint32_t pressed_keys;
     qemu_irq out[8];
 };
 
-static void musicpal_key_event(void *opaque, int keycode)
+static void musicpal_key_event(DeviceState *dev, QemuConsole *src,
+                               InputEvent *evt)
 {
-    musicpal_key_state *s = opaque;
+    musicpal_key_state *s = MUSICPAL_KEY(dev);
+    InputKeyEvent *key = evt->u.key.data;
+    int qcode = qemu_input_key_value_to_qcode(key->key);
     uint32_t event = 0;
     int i;
 
-    if (keycode == KEYCODE_EXTENDED) {
-        s->kbd_extended = 1;
-        return;
+    switch (qcode) {
+    case Q_KEY_CODE_UP:
+        event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
+        break;
+
+    case Q_KEY_CODE_DOWN:
+        event = MP_KEY_WHEEL_NAV;
+        break;
+
+    case Q_KEY_CODE_LEFT:
+        event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
+        break;
+
+    case Q_KEY_CODE_RIGHT:
+        event = MP_KEY_WHEEL_VOL;
+        break;
+
+    case Q_KEY_CODE_F:
+        event = MP_KEY_BTN_FAVORITS;
+        break;
+
+    case Q_KEY_CODE_TAB:
+        event = MP_KEY_BTN_VOLUME;
+        break;
+
+    case Q_KEY_CODE_RET:
+        event = MP_KEY_BTN_NAVIGATION;
+        break;
+
+    case Q_KEY_CODE_M:
+        event = MP_KEY_BTN_MENU;
+        break;
     }
 
-    if (s->kbd_extended) {
-        switch (keycode & KEY_CODE) {
-        case KEYCODE_UP:
-            event = MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_NAV_INV;
-            break;
-
-        case KEYCODE_DOWN:
-            event = MP_KEY_WHEEL_NAV;
-            break;
-
-        case KEYCODE_LEFT:
-            event = MP_KEY_WHEEL_VOL | MP_KEY_WHEEL_VOL_INV;
-            break;
-
-        case KEYCODE_RIGHT:
-            event = MP_KEY_WHEEL_VOL;
-            break;
-        }
-    } else {
-        switch (keycode & KEY_CODE) {
-        case KEYCODE_F:
-            event = MP_KEY_BTN_FAVORITS;
-            break;
-
-        case KEYCODE_TAB:
-            event = MP_KEY_BTN_VOLUME;
-            break;
-
-        case KEYCODE_ENTER:
-            event = MP_KEY_BTN_NAVIGATION;
-            break;
-
-        case KEYCODE_M:
-            event = MP_KEY_BTN_MENU;
-            break;
-        }
-        /* Do not repeat already pressed buttons */
-        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
+    /*
+     * We allow repeated wheel-events when the arrow keys are held down,
+     * but do not repeat already-pressed buttons for the other key inputs.
+     */
+    if (!(event & (MP_KEY_WHEEL_NAV | MP_KEY_WHEEL_VOL))) {
+        if (key->down && (s->pressed_keys & event)) {
             event = 0;
         }
     }
 
     if (event) {
         /* Raise GPIO pin first if repeating a key */
-        if (!(keycode & KEY_RELEASED) && (s->pressed_keys & event)) {
+        if (key->down && (s->pressed_keys & event)) {
             for (i = 0; i <= 7; i++) {
                 if (event & (1 << i)) {
                     qemu_set_irq(s->out[i], 1);
@@ -1143,17 +1128,15 @@ static void musicpal_key_event(void *opaque, int keycode)
         }
         for (i = 0; i <= 7; i++) {
             if (event & (1 << i)) {
-                qemu_set_irq(s->out[i], !!(keycode & KEY_RELEASED));
+                qemu_set_irq(s->out[i], !key->down);
             }
         }
-        if (keycode & KEY_RELEASED) {
-            s->pressed_keys &= ~event;
-        } else {
+        if (key->down) {
             s->pressed_keys |= event;
+        } else {
+            s->pressed_keys &= ~event;
         }
     }
-
-    s->kbd_extended = 0;
 }
 
 static void musicpal_key_init(Object *obj)
@@ -1162,20 +1145,27 @@ static void musicpal_key_init(Object *obj)
     DeviceState *dev = DEVICE(sbd);
     musicpal_key_state *s = MUSICPAL_KEY(dev);
 
-    s->kbd_extended = 0;
     s->pressed_keys = 0;
 
     qdev_init_gpio_out(dev, s->out, ARRAY_SIZE(s->out));
+}
 
-    qemu_add_kbd_event_handler(musicpal_key_event, s);
+static const QemuInputHandler musicpal_key_handler = {
+    .name = "musicpal_key",
+    .mask = INPUT_EVENT_MASK_KEY,
+    .event = musicpal_key_event,
+};
+
+static void musicpal_key_realize(DeviceState *dev, Error **errp)
+{
+    qemu_input_handler_register(dev, &musicpal_key_handler);
 }
 
 static const VMStateDescription musicpal_key_vmsd = {
     .name = "musicpal_key",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT32(kbd_extended, musicpal_key_state),
         VMSTATE_UINT32(pressed_keys, musicpal_key_state),
         VMSTATE_END_OF_LIST()
     }
@@ -1186,6 +1176,7 @@ static void musicpal_key_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &musicpal_key_vmsd;
+    dc->realize = musicpal_key_realize;
 }
 
 static const TypeInfo musicpal_key_info = {
-- 
2.34.1


