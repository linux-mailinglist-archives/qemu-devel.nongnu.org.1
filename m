Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579647DB93C
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:49:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQkg-0007v1-Tc; Mon, 30 Oct 2023 07:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQke-0007sq-4G
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:12 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkZ-0007IM-Sb
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:11 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32db8924201so2752843f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666486; x=1699271286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5al3BpLZU+19+hYcKcyMCCRCPorsvWdV9FoD05aiewE=;
 b=AlgzFS/W5TtSBNAon5kIkeaqvmEqJItyqR27VabsrTRUQeOmTpdsnIrU2oAnzfn/tK
 9kGkvfRVu8kLrhtDAcVHbKaaZoohPdYZB/jsGuN4x2v4I6PlkMOuYsOYb+MUqd5Padim
 OOtNAwAF0FA3pqwfHeqXUdkevVYVLdPPg447rgjOR73FppjB1npzb0yA8NBynUwGAutx
 +1KUR+rBp+jyhx2xba4OTLOGdwKBy3WpLu4xblxo+oxmw3TaLMhfxUi5OXwE52Lbj1it
 F5wjbKc/QN8UyRRC7dcQsafqPAhS5Y7n3IWtWVZYkXg6YK1g61DFFnPaWjipJjVaBxC9
 3Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666486; x=1699271286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5al3BpLZU+19+hYcKcyMCCRCPorsvWdV9FoD05aiewE=;
 b=mUh2mjO/48p05iGovmK1IjaU5xTEbgYvoGKPYNnxUhOFskrUhKGe775wkcSXlQ7zqn
 rT+cCAURhFzz8pv8k8PtSJ1Qs7HJF7Ir/QOVKvgM5GBw9XjWnI2kv65qEIKhLoGOcZRr
 OSaoOGRXviwQA8Fsyqf/50CS/Jco4k1Um3pcMB5m9ffwyjmRdEwu4yEc8ID2G/eF0x74
 rHnJD2+YAH+n/fy48oZ/NXrfWOOLnR0OLEzm9Uw2U1toQgCcwQCxLS3EcMzzY58Uz7lf
 tNj/SdKqyn/TFcQOZFIAzdQx1uI8M2OQbE//MrJGwlRd57rQLEvW/krnTotbHfzif2bc
 J89w==
X-Gm-Message-State: AOJu0YwjcgPSMeMNTHEJLnB2pSwKoK6MlFQw3INVZsiyM7wH9poxbKsr
 1OiYqfE/wF9bpkd44Mc7oNY02w==
X-Google-Smtp-Source: AGHT+IFIpzrjyVQNhAou7+kyCxzufOA5Aq0Ox26jXRzWVBNM/h5ifKNBGarJcRFPaVE9HwtNXC51mA==
X-Received: by 2002:adf:d1ca:0:b0:32f:7967:aa4d with SMTP id
 b10-20020adfd1ca000000b0032f7967aa4dmr5242068wrd.68.1698666486195; 
 Mon, 30 Oct 2023 04:48:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 az30-20020adfe19e000000b0032f7d7ec4adsm5262268wrb.92.2023.10.30.04.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:48:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 4/6] hw/input/stellaris_gamepad: Remove
 StellarisGamepadButton struct
Date: Mon, 30 Oct 2023 11:48:00 +0000
Message-Id: <20231030114802.3671871-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114802.3671871-1-peter.maydell@linaro.org>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


