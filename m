Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B257DF8E4
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybeh-0003E2-Dw; Thu, 02 Nov 2023 13:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeZ-0003B5-2K
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:47 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeU-0002hl-1f
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:46 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso800834f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946720; x=1699551520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldh6u2bWD7MniqjxzXyQCd0Qu18ZZOjaa+NiKkpmJMc=;
 b=cBlwRk1Jy+D4+IBixNtu65/lD/F2onN46RsgX4CR17m6sTJHc9UA9KHYS26oU+TczM
 jDESvAb9p3C8Xvqhfu0SXiUzvYf8cxoRRCx7u1XAOaxB863OZv3S4kmZtv+QZChAXJ19
 2NB143plXon1LGnldQ7+8pk7lRghki3uxtn8Gei1qx1dr8yUj1tjHLTDtNIm8U21u657
 DDm6MIDyNagGJY+2jrLWjE8eQzoC1qce6wTo1dHAcdEs71VnNciHdJscXyH1JCI6pLPd
 NlAonITdCpqlfX3nL4dJc/4lAO/POeFoHg61tj8uSIsQqXC2tw7aW4D/41o6abtN3pxn
 I9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946720; x=1699551520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldh6u2bWD7MniqjxzXyQCd0Qu18ZZOjaa+NiKkpmJMc=;
 b=RruOOyN6pAJmIBgsHc1JQUBMeWd34aQU2U2CQbyJEPgX2GtD2rYDb/B7oMkLtl1UjA
 obq2hYnyiI4xOAxvSJi+DCC9FIYEIVIsisKZsTaRtcMcXcfBgLEvkTRI8QkGV464XnP2
 oUvOiJQartlW1JQudjCNCAgJ4fe0Ax18GD/m1JlmaW4n1RE8zNAeHExo0PL/ihu0mMli
 sS5E2nruMD//6VjbQj6eTQHQwGS5Asa4jMmjX1k1HFNsWMGXzax0FWQup/E5GU4SoL7r
 DxMVuUPhULFRO2QOpchv2rUu/oFfPchxdeB2YhsVRIb2PC4uxZSYWt9Oy5K4V38e7VoI
 3iCg==
X-Gm-Message-State: AOJu0YyfwbL4A/SFO9LovMw2/q1tKV2wSVvxrwVhlw3L2LF7znH6pjts
 e6DqKmMnLeUTRu3ks0/QdJxl7emwahkdgzgi4xc=
X-Google-Smtp-Source: AGHT+IGjX7tXlinQLLvDWP2av+d61SKxRnguWJqjKZT3cIcCWThWz7iMbWYreitNE5Yiwn6pWWCO8A==
X-Received: by 2002:a5d:5887:0:b0:32f:7a07:be03 with SMTP id
 n7-20020a5d5887000000b0032f7a07be03mr14178010wrf.13.1698946720650; 
 Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/33] hw/input/stellaris_gamepad: Convert to
 qemu_input_handler_register()
Date: Thu,  2 Nov 2023 17:38:09 +0000
Message-Id: <20231102173835.609985-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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
Message-id: 20231030114802.3671871-7-peter.maydell@linaro.org
---
 include/hw/input/stellaris_gamepad.h |  2 +-
 hw/arm/stellaris.c                   |  6 ++++-
 hw/input/stellaris_gamepad.c         | 37 +++++++++++++---------------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/hw/input/stellaris_gamepad.h b/include/hw/input/stellaris_gamepad.h
index d6a6aecb06d..51085e166ca 100644
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
@@ -31,7 +32,6 @@ struct StellarisGamepad {
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
index d42ba4f0582..06a0c0ce839 100644
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


