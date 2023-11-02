Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AF87DF8E8
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:40:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybes-0003N1-0n; Thu, 02 Nov 2023 13:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeZ-0003B3-2O
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:47 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeT-0002hU-PA
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:45 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50ec238aeso17436551fa.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946720; x=1699551520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jPz9LWV8Rv5DH5etsrmvwliiqNBVJ3b6lP8HyjQY+Zo=;
 b=SR/3o9D3dN+r2E3/K19LL6tAZpX2LvUiYulRd0BvZBojC+B8RALojJE9LEuKBPEFFn
 0EvPXEAOFsqp7lAL+iH5c8vkB5xjZEGFv3iRK3wL/8Mj1PLzl0pQ6MjhIuVpKCM6eXS0
 9Hvjhqsjj6rFvhguf3jAQJcx/TYLg5P4MR6LINKta41KVXHLk46wldal/GbxqBocWIVj
 iwHkxv7heOHtm5Cty2z0H+r3Qz3vemylkD4xgkDE7JoO4oSbLwcudy07FpAIdonKGcEJ
 s4AVJ9KGFGQu7plaGBHSx/jJB7OgHFMPuseCQY4r+raUg2TukC9Y1/x0Q2Dx7jKRXxtB
 tiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946720; x=1699551520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jPz9LWV8Rv5DH5etsrmvwliiqNBVJ3b6lP8HyjQY+Zo=;
 b=o6hgaVqtxLtdLa6mc6s7JFVQbyHSSU1GddfS/KNskyIxwRJEdBqjTQgTJkb+C18pB7
 gZz7e61zoQdVHNzBoQdiCrvo1SfTnRklpk4ep+TBQNJSFSQ/T+PncmhAf+Ce9Q3K5Vfu
 ZLrJ9CgYy1Yqthv/SEAugsncimdgd4oZrTPg7RsxY2ZSZbnN61mF39tOzQE5k0Bfjsf0
 lUu1m8483SksTo1glEL/b6rAAIBTCbPrxyK8qZS2La3swZRyhiaGeWgbrBXEYv91SGIs
 yrVuFDpgs/jOUIfrj7hD01HIGousHyaQ1n7oS2sldq0IJqr/A6WwLNTMSH9L1ol9Q5mL
 DLPQ==
X-Gm-Message-State: AOJu0YwKFuFPDT0sh1Uh79Wx0uSv+ZvPUnAqahjSWMm+BQTN3SHcYbmD
 8QcFgBLy0zz30dJdUCALQjQr+WwcSVOrYrudI4Q=
X-Google-Smtp-Source: AGHT+IEuCurCa9ezchvcMMZUgDyB5WAU8SygqtFD6HWhweBtB9YRoe7xFU4+tNraX4PRLPU1EcSbBg==
X-Received: by 2002:a05:651c:70f:b0:2c5:a50b:2f08 with SMTP id
 z15-20020a05651c070f00b002c5a50b2f08mr12172213ljb.36.1698946719783; 
 Thu, 02 Nov 2023 10:38:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/33] hw/input/stellaris_gamepad: Remove
 StellarisGamepadButton struct
Date: Thu,  2 Nov 2023 17:38:07 +0000
Message-Id: <20231102173835.609985-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

Currently for each button on the device we have a
StellarisGamepadButton struct which has the irq, keycode and pressed
state for it.  When we convert to qdev, the qdev property and GPIO
APIs are going to require that we have separate arrays for the irqs
and keycodes.  Convert from array-of-structs to three separate arrays
in preparation.

This is a migration compatibility break for the stellaris boards
(lm3s6965evb, lm3s811evb).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030114802.3671871-5-peter.maydell@linaro.org
--
v1=>v2: mention migration compat break in commit message;
  bump version fields in vmstate
---
 hw/input/stellaris_gamepad.c | 47 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 377101a4035..82ddc47a26d 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -14,15 +14,11 @@
 #include "ui/console.h"
 
 typedef struct {
-    qemu_irq irq;
-    int keycode;
-    uint8_t pressed;
-} StellarisGamepadButton;
-
-typedef struct {
-    StellarisGamepadButton *buttons;
-    int num_buttons;
+    uint32_t num_buttons;
     int extension;
+    qemu_irq *irqs;
+    uint32_t *keycodes;
+    uint8_t *pressed;
 } StellarisGamepad;
 
 static void stellaris_gamepad_put_key(void * opaque, int keycode)
@@ -40,36 +36,23 @@ static void stellaris_gamepad_put_key(void * opaque, int keycode)
     keycode = (keycode & 0x7f) | s->extension;
 
     for (i = 0; i < s->num_buttons; i++) {
-        if (s->buttons[i].keycode == keycode
-                && s->buttons[i].pressed != down) {
-            s->buttons[i].pressed = down;
-            qemu_set_irq(s->buttons[i].irq, down);
+        if (s->keycodes[i] == keycode && s->pressed[i] != down) {
+            s->pressed[i] = down;
+            qemu_set_irq(s->irqs[i], down);
         }
     }
 
     s->extension = 0;
 }
 
-static const VMStateDescription vmstate_stellaris_button = {
-    .name = "stellaris_button",
-    .version_id = 0,
-    .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT8(pressed, StellarisGamepadButton),
-        VMSTATE_END_OF_LIST()
-    }
-};
-
 static const VMStateDescription vmstate_stellaris_gamepad = {
     .name = "stellaris_gamepad",
-    .version_id = 2,
-    .minimum_version_id = 2,
+    .version_id = 3,
+    .minimum_version_id = 3,
     .fields = (VMStateField[]) {
         VMSTATE_INT32(extension, StellarisGamepad),
-        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, StellarisGamepad,
-                                            num_buttons,
-                                            vmstate_stellaris_button,
-                                            StellarisGamepadButton),
+        VMSTATE_VARRAY_UINT32(pressed, StellarisGamepad, num_buttons,
+                              0, vmstate_info_uint8, uint8_t),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -81,10 +64,12 @@ void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
     int i;
 
     s = g_new0(StellarisGamepad, 1);
-    s->buttons = g_new0(StellarisGamepadButton, n);
+    s->irqs = g_new0(qemu_irq, n);
+    s->keycodes = g_new0(uint32_t, n);
+    s->pressed = g_new0(uint8_t, n);
     for (i = 0; i < n; i++) {
-        s->buttons[i].irq = irq[i];
-        s->buttons[i].keycode = keycode[i];
+        s->irqs[i] = irq[i];
+        s->keycodes[i] = keycode[i];
     }
     s->num_buttons = n;
     qemu_add_kbd_event_handler(stellaris_gamepad_put_key, s);
-- 
2.34.1


