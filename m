Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C097DB941
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:50:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQkf-0007tK-5z; Mon, 30 Oct 2023 07:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkb-0007os-Fa
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQkY-0007Hq-AT
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:48:09 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2503472f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698666485; x=1699271285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HM5kf1X1PshRtDfKLySq1ZWkBYTJpS76AaPWoI9OvsM=;
 b=OsxxYqejjxHeMWeXkRwLv8vm3vIFqDXmxMK9KZKmeM2iKb/xJR23QR/jj0rDTxzyRG
 9tzdOZWQQJh5lsIzwVOq32tCs5KTMoGEgQAGcVKv67w1ga1x8/UQL8YUBth0G8kw9Qtr
 hsYy00ktXxDPzKkbhjA7OHJJXij0HBfOkcBO0jUPem30kaZN3iXWRUe0bX2c2RjKrq8j
 HoJsWOI3De1emoG8egdwnFnZFQf/a6TigD1p0v16S+PHt0L9YiDRSk1oqA+Xa4HWHHL5
 qKAbcdHMVVc9fR7UomjcVqYQFpSSqawAr7Qp4Di8u59tbPrgnInbsHHfB5PyWXD6FnqO
 TSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698666485; x=1699271285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HM5kf1X1PshRtDfKLySq1ZWkBYTJpS76AaPWoI9OvsM=;
 b=ZXVnZFiemzAte9fi86teopQqdgUcfSdZU0KkCErK6IgP/oXHzvSNiD9+Bl1Og11ca1
 +RNasz2U5J3PRP607/UKUCCSeZPGYZ4ZyOMDkNTnjgo4MZGi6y6Z4wmYGPbGJxOvD0Ex
 yNkCZWqR+Wt1zXkhHIRiZISdnLg/bk7Xx+I1letAOGExmUCZmd4isYze8p5Boh484lON
 SijH5fwyr/asFpJvAC6ikAA29qdxnn8HzuagmXsUfFbO3LikMPWeCmlbfRAvXlBGoX5x
 d0vpkdoawhQVC+cke2FeSNl3dlEBi4Y0e3w8Y5C0MQAkXl1wgBCFLyInAV4vvjKzg+X+
 ScTw==
X-Gm-Message-State: AOJu0Yxtxn2vPvFtJCGOuwpl2eqonrWsSReKh6ggzr/OWSou8cRZ5Vwz
 HV58VPaDNWTw66BfBOX5QyqpsSEL3KWHhUjZ7ck=
X-Google-Smtp-Source: AGHT+IHQ5oJ98s/l8PwAoY+Vypdif0D8+Z82u0Pvwk0+Xz45TlYKOJA1e+Qb3z8rYcLdIeRL4wsJpw==
X-Received: by 2002:a05:6000:1544:b0:32f:803e:3a06 with SMTP id
 4-20020a056000154400b0032f803e3a06mr5273549wry.7.1698666484943; 
 Mon, 30 Oct 2023 04:48:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 az30-20020adfe19e000000b0032f7d7ec4adsm5262268wrb.92.2023.10.30.04.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 04:48:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 2/6] hw/input/stellaris_gamepad: Rename structs to our
 usual convention
Date: Mon, 30 Oct 2023 11:47:58 +0000
Message-Id: <20231030114802.3671871-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030114802.3671871-1-peter.maydell@linaro.org>
References: <20231030114802.3671871-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Rename the structs in stellaris_gamepad.c to our now-standard
CamelCase convention.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


