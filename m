Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3296B854
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Sep 2024 12:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnAV-0006oL-Pl; Wed, 04 Sep 2024 06:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnAT-0006ns-MY
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:23:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnAR-00073F-Pw
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=+/aLZ1g+MrJUhLFI1P68PGklWQQ0SHiEICwYACgLPs4=; b=aBD79Hd+J2sLzoNXfLtsV9fTO7
 k5+DhflZWQGeeDCl31zg0N9lGlHFiwEr19hkxhpY2SXzVzWa0zSe2aNncBbOoZOpAkfUttFp1A7h7
 mgHqLwg7UlDiRI9wtFqn8pCZRoyT2CMK8lMvyY3M42971HcSQFHd/kG79eEsnbX7P7GNOHy3AVZ52
 fmEkxotaDXAcri1/2xZdd8ScUMITlsNhGrY7xB0G8ogeaxDNDvMWbcpA6RAZ5iMW7KFT2QUlVdO2Z
 /2DlzYAxbY33n8NObb98axzfczhAbTjO/TPAbKqKAbX6bkhBpj9K9VSqh+/qgCZeUfKH2dU3wltm7
 T/jDtYkPluJhZg+taj2f3LyWLNRJhfaH6OHuHOm3iJKHMxcRlal3Aff2ODJwTMF2e8toSIoJ2g9cT
 b9TDiO2jByIogqZ2PKLsuVvlwxZDrkmB/h1eK3EBYqOmII2/H9yJyGZEh3c+LnnZWpjFb7kloTfo5
 r9IGBZGAaIPUxeq3omc0ckpc8o8icp7NcrDrg/F3ipwvZAwdYCBLmrBNfkY1Q4nRGcn9KHaYv+I5U
 SlpYNL2Rrun+29Y0yVoIEKeuojg16WvsQ5j1k7suMC4hSYIv4jvDNuz5KqIX/SYgXc9IazCa+m5Km
 Cwh384QpiEkpZUgVfbwL41YWaQpXmyafo86IyjXh0=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1slnAH-0002H7-2m; Wed, 04 Sep 2024 11:23:09 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: chauser@pullman.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Date: Wed,  4 Sep 2024 11:23:01 +0100
Message-Id: <20240904102301.175706-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3] escc: convert Sun mouse to use QemuInputHandler
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Update the Sun mouse implementation to use QemuInputHandler instead of the
legacy qemu_add_mouse_event_handler() function.

Note that this conversion adds extra sunmouse_* members to ESCCChannelState
but they are not added to the migration stream (similar to the Sun keyboard
members). If this were desired in future, the Sun devices should be split
into separate devices and added to the migration stream there instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2518
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/char/escc.c         | 88 +++++++++++++++++++++++++++++++-----------
 include/hw/char/escc.h |  3 ++
 2 files changed, 69 insertions(+), 22 deletions(-)

v3:
- Subtract the deltas in sunmouse_sync() instead of resetting them to zero
  which provides better tracking if the mouse movement exceeds the 8-bit
  delta limit of the MSC protocol 

- Add R-B tag from Richard

v2:
- Only allow left, middle and right button events (use bit 7 which is always
  set in the first byte to indicate a valid event)

- Remove zero entries from the bmap table as static entries should be
  zero anyway


diff --git a/hw/char/escc.c b/hw/char/escc.c
index d450d70eda..245a7b19d3 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -287,6 +287,7 @@ static void escc_reset_chn(ESCCChannelState *s)
     s->rxint = s->txint = 0;
     s->rxint_under_svc = s->txint_under_svc = 0;
     s->e0_mode = s->led_mode = s->caps_lock_mode = s->num_lock_mode = 0;
+    s->sunmouse_dx = s->sunmouse_dy = s->sunmouse_buttons = 0;
     clear_queue(s);
 }
 
@@ -952,53 +953,96 @@ static void handle_kbd_command(ESCCChannelState *s, int val)
     }
 }
 
-static void sunmouse_event(void *opaque,
-                               int dx, int dy, int dz, int buttons_state)
+static void sunmouse_handle_event(DeviceState *dev, QemuConsole *src,
+                                  InputEvent *evt)
 {
-    ESCCChannelState *s = opaque;
-    int ch;
+    ESCCChannelState *s = (ESCCChannelState *)dev;
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+        [INPUT_BUTTON_LEFT]   = 0x4,
+        [INPUT_BUTTON_MIDDLE] = 0x2,
+        [INPUT_BUTTON_RIGHT]  = 0x1,
+    };
+
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_REL:
+        move = evt->u.rel.data;
+        if (move->axis == INPUT_AXIS_X) {
+            s->sunmouse_dx += move->value;
+        } else if (move->axis == INPUT_AXIS_Y) {
+            s->sunmouse_dy -= move->value;
+        }
+        break;
 
-    trace_escc_sunmouse_event(dx, dy, buttons_state);
-    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        if (bmap[btn->button]) {
+            if (btn->down) {
+                s->sunmouse_buttons |= bmap[btn->button];
+            } else {
+                s->sunmouse_buttons &= ~bmap[btn->button];
+            }
+            /* Indicate we have a supported button event */
+            s->sunmouse_buttons |= 0x80;
+        }
+        break;
 
-    if (buttons_state & MOUSE_EVENT_LBUTTON) {
-        ch ^= 0x4;
-    }
-    if (buttons_state & MOUSE_EVENT_MBUTTON) {
-        ch ^= 0x2;
+    default:
+        /* keep gcc happy */
+        break;
     }
-    if (buttons_state & MOUSE_EVENT_RBUTTON) {
-        ch ^= 0x1;
+}
+
+static void sunmouse_sync(DeviceState *dev)
+{
+    ESCCChannelState *s = (ESCCChannelState *)dev;
+    int ch;
+
+    if (s->sunmouse_dx == 0 && s->sunmouse_dy == 0 &&
+        (s->sunmouse_buttons & 0x80) == 0) {
+            /* Nothing to do after button event filter */
+            return;
     }
 
+    /* Clear our button event flag */
+    s->sunmouse_buttons &= ~0x80;
+    trace_escc_sunmouse_event(s->sunmouse_dx, s->sunmouse_dy,
+                              s->sunmouse_buttons);
+    ch = 0x80 | 0x7; /* protocol start byte, no buttons pressed */
+    ch ^= s->sunmouse_buttons;
     put_queue(s, ch);
 
-    ch = dx;
-
+    ch = s->sunmouse_dx;
     if (ch > 127) {
         ch = 127;
     } else if (ch < -127) {
         ch = -127;
     }
-
     put_queue(s, ch & 0xff);
+    s->sunmouse_dx -= ch;
 
-    ch = -dy;
-
+    ch = s->sunmouse_dy;
     if (ch > 127) {
         ch = 127;
     } else if (ch < -127) {
         ch = -127;
     }
-
     put_queue(s, ch & 0xff);
+    s->sunmouse_dy -= ch;
 
     /* MSC protocol specifies two extra motion bytes */
-
     put_queue(s, 0);
     put_queue(s, 0);
 }
 
+static const QemuInputHandler sunmouse_handler = {
+    .name  = "QEMU Sun Mouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
+    .event = sunmouse_handle_event,
+    .sync  = sunmouse_sync,
+};
+
 static void escc_init1(Object *obj)
 {
     ESCCState *s = ESCC(obj);
@@ -1036,8 +1080,8 @@ static void escc_realize(DeviceState *dev, Error **errp)
     }
 
     if (s->chn[0].type == escc_mouse) {
-        qemu_add_mouse_event_handler(sunmouse_event, &s->chn[0], 0,
-                                     "QEMU Sun Mouse");
+        s->chn[0].hs = qemu_input_handler_register((DeviceState *)(&s->chn[0]),
+                                                   &sunmouse_handler);
     }
     if (s->chn[1].type == escc_kbd) {
         s->chn[1].hs = qemu_input_handler_register((DeviceState *)(&s->chn[1]),
diff --git a/include/hw/char/escc.h b/include/hw/char/escc.h
index 5669a5b811..8c4c6a7730 100644
--- a/include/hw/char/escc.h
+++ b/include/hw/char/escc.h
@@ -46,6 +46,9 @@ typedef struct ESCCChannelState {
     uint8_t rx, tx;
     QemuInputHandlerState *hs;
     char *sunkbd_layout;
+    int sunmouse_dx;
+    int sunmouse_dy;
+    int sunmouse_buttons;
 } ESCCChannelState;
 
 struct ESCCState {
-- 
2.39.2


