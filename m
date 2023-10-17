Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1AF7CC311
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:24:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsj6S-0006bN-M4; Tue, 17 Oct 2023 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6P-0006ZJ-7T
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:13 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6K-0003vK-Jx
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so4791766f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545387; x=1698150187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X23rCmHj7vrKivIk0sTOGLiGuYEJTV79DlPVDDS4fB8=;
 b=OUYC+WgYYIQaht1FSlb2CSWgKNCHrdMThNvDbUloXdVaAXki7XVF+IgfXLMHLLWyy7
 u8ReWJpUBd7jBa+uiZSJfZaKUgqUoyUXGuqYDDpmZbJb2NojAS3e4jHAH0pwNNGGJMCr
 9vdS3FsdqxFLVlIhOysB9wxIqX558VHWRP3+yz6kx44mWH8xSvVcSv+Qt9EUfBqWZx9c
 oKOOPlscC+fSyvsyzFuFWtV3y2IRdLUsVctf/SOg/57yKf29RFCztrHVav1QU7ybF72p
 15wzJtl5/Yc894imlYTNJ9gLEChUr8JWUpt08sOhuv8P5hcJkpVLxIajHYW2jbD8kWCi
 W/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545387; x=1698150187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X23rCmHj7vrKivIk0sTOGLiGuYEJTV79DlPVDDS4fB8=;
 b=d/GND+/H4MlIhViPLjkezH1+KzMvaUDIIHrjT/AYgt++hsigbBev66f025FsS5s75S
 y5xkZQf9gwxEm6K5ScxcIwPqGDrU77Iw2RfCGrIn9/EOTuX9h2DU+3VtS0dSt6OGLXkm
 l7y1qFM6H9S3pWroD04xb6tCxfaWAhlHjAR8QpnzgoMpl2wkDTK3eOrMizF7tN+AtTfn
 hDdUnG0FjZKQSUPUj470+Jmi1N1ob8m1GQsT43pJqTsGDQoll/72n/o9yxGCAMPgkO6S
 HMjqZySwYQWexIXw3RY8qoprxq0OEBo7iVPQ0quQaKyUk97IftH0mKwW7cxq/KuqY0fQ
 QUWQ==
X-Gm-Message-State: AOJu0YzbMFrtMbY2icprBhfKq8kf4zy9fjT28rT3/kk4N+R6G0A1LsYj
 FXEzQWlahXLN/xWrKqaPiMHdUA==
X-Google-Smtp-Source: AGHT+IEkcJWKG81jTlTGa59jb9yntZEzSjpVDZ9F3Zo2X41Nao9OmNBA+5C3L5X3wSOhRAG2Nrcy7w==
X-Received: by 2002:a5d:4528:0:b0:31c:804b:5ec3 with SMTP id
 j8-20020a5d4528000000b0031c804b5ec3mr1922351wra.67.1697545387116; 
 Tue, 17 Oct 2023 05:23:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0032da4c98ab2sm1590905wrs.35.2023.10.17.05.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 6/6] hw/input/stellaris_gamepad: Convert to
 qemu_input_handler_register()
Date: Tue, 17 Oct 2023 13:23:02 +0100
Message-Id: <20231017122302.1692902-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

Now that we have converted to qdev, we can use the newer
qemu_input_handler_register() API rather than the legacy
qemu_add_kbd_event_handler().

Since we only have one user, take the opportunity to convert
from scancodes to QCodes, rather than using
qemu_input_key_value_to_scancode() (which adds an 0xe0
prefix and encodes up/down indication in the scancode,
which our old handler function then had to reverse). That
lets us drop the old state field which was tracking whether
we were halfway through a two-byte scancode.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/input/stellaris_gamepad.h |  2 +-
 hw/arm/stellaris.c                   |  6 ++++-
 hw/input/stellaris_gamepad.c         | 33 +++++++++++++---------------
 3 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index 50c17041121..979e7243fd8 100644
--- a/include/hw/input/stellaris_gamepad.h
+++ b/include/hw/input/stellaris_gamepad.h
@@ -17,6 +17,7 @@
 /*
  * QEMU interface:
  *  + QOM array property "keycodes": uint32_t QEMU keycodes to handle
+ *    (these are QCodes, ie the Q_KEY_* values)
  *  + unnamed GPIO outputs: one per keycode, in the same order as the
  *    "keycodes" array property entries; asserted when key is down
  */
@@ -33,7 +34,6 @@ struct StellarisGamepad {
     qemu_irq *irqs;
     uint32_t *keycodes;
     uint8_t *pressed;
-    int extension;
 };
 
 #endif
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 707b0dae375..dd90f686bfa 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -32,6 +32,7 @@
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
 #include "qapi/qmp/qlist.h"
+#include "ui/input.h"
 
 #define GPIO_A 0
 #define GPIO_B 1
@@ -1276,7 +1277,10 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     }
     if (board->peripherals & BP_GAMEPAD) {
         QList *gpad_keycode_list = qlist_new();
-        static const int gpad_keycode[5] = { 0xc8, 0xd0, 0xcb, 0xcd, 0x1d };
+        static const int gpad_keycode[5] = {
+            Q_KEY_CODE_UP, Q_KEY_CODE_DOWN, Q_KEY_CODE_LEFT,
+            Q_KEY_CODE_RIGHT, Q_KEY_CODE_CTRL,
+        };
         DeviceState *gpad;
 
         gpad = qdev_new(TYPE_STELLARIS_GAMEPAD);
diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 48d37bd6275..65247ecd782 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -15,28 +15,20 @@
 #include "migration/vmstate.h"
 #include "ui/console.h"
 
-static void stellaris_gamepad_put_key(void * opaque, int keycode)
+static void stellaris_gamepad_event(DeviceState *dev, QemuConsole *src,
+                                    InputEvent *evt)
 {
-    StellarisGamepad *s = (StellarisGamepad *)opaque;
+    StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
+    InputKeyEvent *key = evt->u.key.data;
+    int qcode = qemu_input_key_value_to_qcode(key->key);
     int i;
-    int down;
-
-    if (keycode == 0xe0 && !s->extension) {
-        s->extension = 0x80;
-        return;
-    }
-
-    down = (keycode & 0x80) == 0;
-    keycode = (keycode & 0x7f) | s->extension;
 
     for (i = 0; i < s->num_buttons; i++) {
-        if (s->keycodes[i] == keycode && s->pressed[i] != down) {
-            s->pressed[i] = down;
-            qemu_set_irq(s->irqs[i], down);
+        if (s->keycodes[i] == qcode && s->pressed[i] != key->down) {
+            s->pressed[i] = key->down;
+            qemu_set_irq(s->irqs[i], key->down);
         }
     }
-
-    s->extension = 0;
 }
 
 static const VMStateDescription vmstate_stellaris_gamepad = {
@@ -44,13 +36,18 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32(extension, StellarisGamepad),
         VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
                               0, vmstate_info_uint8, uint8_t),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static QemuInputHandler stellaris_gamepad_handler = {
+    .name = "Stellaris Gamepad",
+    .mask = INPUT_EVENT_MASK_KEY,
+    .event = stellaris_gamepad_event,
+};
+
 static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
 {
     StellarisGamepad *s = STELLARIS_GAMEPAD(dev);
@@ -63,7 +60,7 @@ static void stellaris_gamepad_realize(DeviceState *dev, Error **errp)
     s->irqs = g_new0(qemu_irq, s->num_buttons);
     s->pressed = g_new0(uint8_t, s->num_buttons);
     qdev_init_gpio_out(dev, s->irqs, s->num_buttons);
-    qemu_add_kbd_event_handler(stellaris_gamepad_put_key, dev);
+    qemu_input_handler_register(dev, &stellaris_gamepad_handler);
 }
 
 static void stellaris_gamepad_reset_enter(Object *obj, ResetType type)
-- 
2.34.1


