Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A357DB93E
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:49:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQkj-0007yC-Al; Mon, 30 Oct 2023 07:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkf-0007ue-NM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQka-0007Il-UF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32ded3eb835so3295829f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666487; x=1699271287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m6c0EQlNr2g65vGjJ/P+58VUOTVyE8PAYRu0/EcOt8c=;
 b=I6m2kbS/IYypfIqt/ni5t94khWZMBhgNyY5TT0/qjH/0l6xnZ+CKW3x2uiAvgYi9EK
 wa/dVc8PtR1sRdIFMClxs6uPuZ24/mM71CzLa51wu/KE8EeZjC9uN+SvCNI/nWOKEc8Y
 acQmDN4VvPkK3Eu3caqGXMNFNNkMlQaUxB2OBTpCPsbWO22MBaS7XmTS74+q9mrJIq8Q
 flT57waeRa6LAhfmNQOgY4K/s5KyFyuVITORm1VwI2Dp7xTj6yEgKq3/EWfIuRzEKdwa
 spq7Zi+VSwQY8XBnnuaiTKbyaiC39ze0PngjigxILU5R2VJcQ5bn6TzL4yRkAvnz8Lxp
 23jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666487; x=1699271287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m6c0EQlNr2g65vGjJ/P+58VUOTVyE8PAYRu0/EcOt8c=;
 b=SXNqbYVfRpha0OHjz6YOAa0xZaS8fUZGp1VNuEBMhwg98LxqkAmipVWQpc221VpwX2
 NdiThO1kEmMZ5GLAscZz9uUo+fDj8GzpC8o4qJ0FjZA01zGKKbope7deq1AZLqyKYmkQ
 aHUqJmoi0od1O0K3sLpQ4mIW5RPEkVvxdxmLs7GZb15LeeO/27HMlD89EMwRH7cU0xlz
 n7L/87a1+KQxSh2vjDnkJTt/QzaLzuMyUbiD/vh3bcj9QlKsEwei5SbUeW0UZde87C+M
 qi6hgAxX0ANCrt1wAKYGGiy0AD2ZXQUWGO1Hc9GXoFeQn57oxbTB3eIhh+VyoKOV6+f5
 NrvQ==
X-Gm-Message-State: AOJu0YxZosEaxN1G+C3n3rhfC9ep/MzmpPUxF7yIMQWzQb/ewCxnwXhP
 7HWT+3CD+4VPe2kj7VV0Wqa1JsI/i9ScfC1nlyQ=
X-Google-Smtp-Source: AGHT+IE2//xMXZ7trVN9HveUpcOKyjwjqypaVt53SJP2wTYCuOAjCoX8qL8DJp4QGAb8mJq+1hlsrg==
X-Received: by 2002:a05:6000:186c:b0:32f:7b59:c3a4 with SMTP id
 d12-20020a056000186c00b0032f7b59c3a4mr6220607wri.32.1698666487143; 
 Mon, 30 Oct 2023 04:48:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 az30-20020adfe19e000000b0032f7d7ec4adsm5262268wrb.92.2023.10.30.04.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:48:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 6/6] hw/input/stellaris_gamepad: Convert to
 qemu_input_handler_register()
Date: Mon, 30 Oct 2023 11:48:02 +0000
Message-Id: <20231030114802.3671871-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114802.3671871-1-peter.maydell@linaro.org>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v1->v2: bump vmstate version number again
        mark QemuInputHandler struct as const
---
 include/hw/input/stellaris_gamepad.h |  2 +-
 hw/arm/stellaris.c                   |  6 ++++-
 hw/input/stellaris_gamepad.c         | 37 +++++++++++++---------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index 6140b889a28..b0c66a35531 100644
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
@@ -30,7 +31,6 @@ struct StellarisGamepad {
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
index 6ccf0e80adc..3533becff5d 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -15,42 +15,39 @@
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
     .name = "stellaris_gamepad",
-    .version_id = 3,
-    .minimum_version_id = 3,
+    .version_id = 4,
+    .minimum_version_id = 4,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32(extension, StellarisGamepad),
         VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
                               0, vmstate_info_uint8, uint8_t),
         VMSTATE_END_OF_LIST()
     }
 };
 
+static const QemuInputHandler stellaris_gamepad_handler = {
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


