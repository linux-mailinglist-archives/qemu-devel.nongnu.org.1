Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93F7CC318
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsj6Q-0006Zi-EN; Tue, 17 Oct 2023 08:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6N-0006Xx-Pc
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsj6J-0003ux-KW
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:23:11 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-323168869daso5218985f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 05:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697545386; x=1698150186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rmBaCpSuRrDiGRxAI74uVjYQUdlqV4XGWEbKnwTHtmk=;
 b=NfcytsncPReH7EnG7ZG/Do8owe4ZVVLdYCIuLB5CP9YDeJ4Bs9d38Z8Euf/S92fWIe
 mVW9vr7lxpppRhzh6xlLEsb3QVStFUEFLxsoULMNf/haf2oDD9b73rFGBuOD1hgLTYXR
 gLny28aL38L5B/XT+tJPCF1TgU7xenVVlzyNFce1Fg7IX0B3F/0XjLJ7C3BS3en7xmDO
 ejtgi6DA1LKlxL46YwDXcaN0k9fEJ/9BnIVzDFmMh6oXsIUa/bH/Ri8y4VYQDJivhcIM
 eLlp4EuPGtxMK/nZ0aWhzcstJZnnOuNhfMMTnkepAiN1AZGho03eE/dEeoAa85tNAWca
 CnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697545386; x=1698150186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rmBaCpSuRrDiGRxAI74uVjYQUdlqV4XGWEbKnwTHtmk=;
 b=FkxMQQ/aWR4w8ZADF0da5Zy5mzNw5r2PEIviGB/q/s/04iBltEPblsCX/98j4vaJZ4
 n6UvVl3BMX2ARDQf7rPp+MfAPwTPqRRtn163vOJ4eQjqQWE65GjpG9+EIQU1CUfieHYi
 KxH07AFSkzbsPTSsQWBoPnjHDjKS1QkrJzPMFXGSNw6Ch+axboL83wMpWccF8X4ryacg
 y+PQ3iVruRXc8XA/LAdmd1KMFJmKbF5NDRzb/xe9rugJb1BSCwECBnEqwLLxOqoeRu71
 br3hn0QCk50dW2i36iv5VYK/x6R60EAzR+8uzGxomjonihzUXo2PeBYVZ35noCu7Y2rK
 xAjg==
X-Gm-Message-State: AOJu0Yzcx/9d3HjjkUjkk9PpRQBmQXEDuCnPLYDw3RzI3iYgdyvkWye5
 X106Id3CE9ZI3/THpVO/qEzkcVDIKto3AW3osow=
X-Google-Smtp-Source: AGHT+IHEthwyxzolTvLPHBY1mbmGSOH5zq3naidKqXVo8yc+QPr92iLNWJ+S4RDnMo6bMIdI6qtM2Q==
X-Received: by 2002:a5d:4245:0:b0:32d:aa56:c0c7 with SMTP id
 s5-20020a5d4245000000b0032daa56c0c7mr1781058wrr.54.1697545386281; 
 Tue, 17 Oct 2023 05:23:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a5d4b51000000b0032da4c98ab2sm1590905wrs.35.2023.10.17.05.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 05:23:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] hw/input/stellaris_gamepad: Remove StellarisGamepadButton
 struct
Date: Tue, 17 Oct 2023 13:23:00 +0100
Message-Id: <20231017122302.1692902-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017122302.1692902-1-peter.maydell@linaro.org>
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/input/stellaris_gamepad.c | 43 ++++++++++++------------------------
 1 file changed, 14 insertions(+), 29 deletions(-)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 377101a4035..da974400b59 100644
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
     .version_id = 2,
     .minimum_version_id = 2,
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


