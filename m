Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2627DF908
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:43:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybex-0003ND-Ea; Thu, 02 Nov 2023 13:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0003Cw-2K
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:50 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeS-0002hG-ME
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:48 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c6ef6c1ec2so14478001fa.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946719; x=1699551519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lDR8Uzh/MINtLhDHndq6EFbiMHNldQPogkDbsU2X7bw=;
 b=t8+w+4BtC660xs+Cc23jTbVzFWMqmKNMA4Q2CWsJbS+u7/Zx485C753mvwnM1Igv4R
 Nj5fNlV1bgsdtpaQ9ChTMEK9UwJqGNBEIQ7yRizL2X7JF3e+xZ6aDEWA+HGyVuK2i8+b
 Dl418FHtsdPbD7foJdva6kk/tOGXg2m/u39/P6xESQ74X8FXYNcNfScxY8TVSWSRej/Z
 pnpCveDgi0mGWh5JbLCieW4QDVTEdxXlUuTID7pe3w4JAKKTEh8bblJdr2eNC6qu7LGw
 Ikjjr9l7mHwlzRgQ6PkTePh4OrPL6h0c5PaJBwR3ESg1zGAkhRARwL+xC2+pqxXNL1mq
 0JcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946719; x=1699551519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lDR8Uzh/MINtLhDHndq6EFbiMHNldQPogkDbsU2X7bw=;
 b=Y43Jk3YrruvSLInsJ9aNd3e/0Xo+DL/U+3Uvb70HFL2AJjbWoyPdBCa2aUVg2X59O9
 okEWy9rPhbXmzLWV5PgERpAiM/h3E1kES9j0iAG/KDRNZr460eFfLY6ZuTBaUhkenPOi
 SMCFBuTlbSFvjSMY3LEa+2VJxapFzL2YBrCq8g/ZwowMmJ5PBuBDkRTm4KFNMqk3tkEG
 4dE33hg2WgdeMMEvEgZyvwx6Ke6jvrS23qTI1V4GyViXxdCYfbmQOiOE0Bl4FYcXlmUR
 OaspbRXp8Hs+DMYWTwIMyWwcoK46LLbKl0lCvLsQxHTI7WJEZNRYZdYYrmXKeitPogui
 kGKg==
X-Gm-Message-State: AOJu0YyCWiZElBY/nFYh0QP/UmLWw5YoqezyZDi4p4w+l3hbUrRE6bQz
 /6OhBw0WM3uNszdfZmvu5hfWPIZo0Y6ndFx06dU=
X-Google-Smtp-Source: AGHT+IEvKu6qqzicBWlzNUcre2Jp6WVNk1WVWDe9zHvtpzaaSV2yCg+FhrZyi61eIHfD1HnaX7zShA==
X-Received: by 2002:a2e:991a:0:b0:2c5:9e2:ed14 with SMTP id
 v26-20020a2e991a000000b002c509e2ed14mr15360921lji.39.1698946718846; 
 Thu, 02 Nov 2023 10:38:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/33] hw/input/stellaris_gamepad: Rename structs to our usual
 convention
Date: Thu,  2 Nov 2023 17:38:05 +0000
Message-Id: <20231102173835.609985-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

Rename the structs in stellaris_gamepad.c to our now-standard
CamelCase convention.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231030114802.3671871-3-peter.maydell@linaro.org
---
 hw/input/stellaris_gamepad.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/input/stellaris_gamepad.c b/hw/input/stellaris_gamepad.c
index 3bab557cab3..377101a4035 100644
--- a/hw/input/stellaris_gamepad.c
+++ b/hw/input/stellaris_gamepad.c
@@ -17,17 +17,17 @@ typedef struct {
     qemu_irq irq;
     int keycode;
     uint8_t pressed;
-} gamepad_button;
+} StellarisGamepadButton;
 
 typedef struct {
-    gamepad_button *buttons;
+    StellarisGamepadButton *buttons;
     int num_buttons;
     int extension;
-} gamepad_state;
+} StellarisGamepad;
 
 static void stellaris_gamepad_put_key(void * opaque, int keycode)
 {
-    gamepad_state *s = (gamepad_state *)opaque;
+    StellarisGamepad *s = (StellarisGamepad *)opaque;
     int i;
     int down;
 
@@ -55,7 +55,7 @@ static const VMStateDescription vmstate_stellaris_button = {
     .version_id = 0,
     .minimum_version_id = 0,
     .fields = (VMStateField[]) {
-        VMSTATE_UINT8(pressed, gamepad_button),
+        VMSTATE_UINT8(pressed, StellarisGamepadButton),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -65,11 +65,11 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
     .version_id = 2,
     .minimum_version_id = 2,
     .fields = (VMStateField[]) {
-        VMSTATE_INT32(extension, gamepad_state),
-        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, gamepad_state,
+        VMSTATE_INT32(extension, StellarisGamepad),
+        VMSTATE_STRUCT_VARRAY_POINTER_INT32(buttons, StellarisGamepad,
                                             num_buttons,
                                             vmstate_stellaris_button,
-                                            gamepad_button),
+                                            StellarisGamepadButton),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -77,11 +77,11 @@ static const VMStateDescription vmstate_stellaris_gamepad = {
 /* Returns an array of 5 output slots.  */
 void stellaris_gamepad_init(int n, qemu_irq *irq, const int *keycode)
 {
-    gamepad_state *s;
+    StellarisGamepad *s;
     int i;
 
-    s = g_new0(gamepad_state, 1);
-    s->buttons = g_new0(gamepad_button, n);
+    s = g_new0(StellarisGamepad, 1);
+    s->buttons = g_new0(StellarisGamepadButton, n);
     for (i = 0; i < n; i++) {
         s->buttons[i].irq = irq[i];
         s->buttons[i].keycode = keycode[i];
-- 
2.34.1


