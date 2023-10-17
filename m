Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D373A7CC421
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:13:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjse-0002DB-Jp; Tue, 17 Oct 2023 09:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjsb-0002AY-0V
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:13:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsjsX-0006fT-LX
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:13:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-406609df1a6so54157185e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697548376; x=1698153176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MJO7DWWRMp74wYPOl7vPeEwkKht+ldFkzgAjlIPhGCE=;
 b=buvzJzIH92KfcKwfYo1acsq6n78Pi16bekxyqVs96CW0Ylf4O2k7o0mRnEoEXYlWD2
 K7tzNhnIVDhhsUf1S0LhI3y+7xfED9xHEdG9lBYimf9jzuGJHA9csbe9zhaGvbc5+lvw
 G1EGKCSm8qazk5n652yN6O+bQdruGnhedFAahDsttTbADTt3ybzpfLkHaVdYHVpRVoZE
 4TYDMHpgmlreb+udxFG/POdRvmZkwm7VlhiHypGFHxzQc3cmCqI39CwT+vA+4ezSomBu
 UdOYwCm3x8wLbFys8SgqsV16rCwE5YsE7NozM6IMTCoIQSzAtxEaa6HHIL47b0f4zum+
 K/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548376; x=1698153176;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MJO7DWWRMp74wYPOl7vPeEwkKht+ldFkzgAjlIPhGCE=;
 b=IHjt9oGDU4xmUtIjo7THTr6mpwU3iC0mSpC4pTzqnc6+J7T9PWEF581UD7zjyeB2u4
 cZJH3FRccTcLOuKLgRHoTiBpGca5MEQ0DJdi2zuxlEEzbS/4uLEHwlYROLzRt1qrW+79
 hzeG1hyxQJYYYEV7taD1nUiR+yNlyHDPREnCJCKTN2TMhlyYljY5koh2hN9JjApAr18G
 zEJ3mpbnHByrfY3ihW5HiV483EJOW2ubJCmr79BVBAPSMmZlBFGvPV00WyuAT/J3F8S9
 kQvhjpDRTT77DNmr81OPkdquWd7NW8UUX9oJAT8rYM2MgKeGjtEYYwjdIKE6gy4Qzr13
 GY2Q==
X-Gm-Message-State: AOJu0Yzd8R+5YmWDxbq1ndzxZZVR+hdBQbfa7987oCChZK7T3oJVgUe9
 9XMwyhnHTVpOo93zs3AI6azSMMXMu8hin/hqrUryBg==
X-Google-Smtp-Source: AGHT+IGxy9d5wwgEu6D2b+uBg62HQt7DkljhO8VGs4e6HBhThmjfwChLZNZkDn086W1jhpisP8ep9A==
X-Received: by 2002:a05:600c:1c29:b0:406:5227:86f0 with SMTP id
 j41-20020a05600c1c2900b00406522786f0mr1787564wms.5.1697548374787; 
 Tue, 17 Oct 2023 06:12:54 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a1c7707000000b0040586360a36sm9759389wmi.17.2023.10.17.06.12.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Oct 2023 06:12:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>, qemu-ppc@nongnu.org,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Song Gao <gaosong@loongson.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] ui/input: Constify QemuInputHandler structure
Date: Tue, 17 Oct 2023 15:12:51 +0200
Message-ID: <20231017131251.43708-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Access to QemuInputHandlerState::handler are read-only.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-input.h | 2 +-
 include/ui/input.h               | 2 +-
 chardev/msmouse.c                | 2 +-
 chardev/wctablet.c               | 2 +-
 hw/char/escc.c                   | 2 +-
 hw/display/xenfb.c               | 6 +++---
 hw/input/adb-kbd.c               | 2 +-
 hw/input/hid.c                   | 6 +++---
 hw/input/ps2.c                   | 4 ++--
 hw/input/virtio-input-hid.c      | 8 ++++----
 ui/input-legacy.c                | 2 +-
 ui/input.c                       | 4 ++--
 ui/vdagent.c                     | 2 +-
 13 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index 08f1591424..a6c9703644 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -84,7 +84,7 @@ struct VirtIOInputHID {
     VirtIOInput                       parent_obj;
     char                              *display;
     uint32_t                          head;
-    QemuInputHandler                  *handler;
+    const QemuInputHandler            *handler;
     QemuInputHandlerState             *hs;
     int                               ledstate;
     bool                              wheel_axis;
diff --git a/include/ui/input.h b/include/ui/input.h
index 24d8e4579e..8f9aac562e 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -30,7 +30,7 @@ struct QemuInputHandler {
 };
 
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
-                                                   QemuInputHandler *handler);
+                                            const QemuInputHandler *handler);
 void qemu_input_handler_activate(QemuInputHandlerState *s);
 void qemu_input_handler_deactivate(QemuInputHandlerState *s);
 void qemu_input_handler_unregister(QemuInputHandlerState *s);
diff --git a/chardev/msmouse.c b/chardev/msmouse.c
index ab8fe981d6..a774c397b4 100644
--- a/chardev/msmouse.c
+++ b/chardev/msmouse.c
@@ -171,7 +171,7 @@ static int msmouse_chr_write(struct Chardev *s, const uint8_t *buf, int len)
     return len;
 }
 
-static QemuInputHandler msmouse_handler = {
+static const QemuInputHandler msmouse_handler = {
     .name  = "QEMU Microsoft Mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
     .event = msmouse_input_event,
diff --git a/chardev/wctablet.c b/chardev/wctablet.c
index 43bdf6b608..f4008bf35b 100644
--- a/chardev/wctablet.c
+++ b/chardev/wctablet.c
@@ -178,7 +178,7 @@ static void wctablet_input_sync(DeviceState *dev)
     }
 }
 
-static QemuInputHandler wctablet_handler = {
+static const QemuInputHandler wctablet_handler = {
     .name  = "QEMU Wacom Pen Tablet",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event = wctablet_input_event,
diff --git a/hw/char/escc.c b/hw/char/escc.c
index 4be66053c1..48b30ee760 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -845,7 +845,7 @@ static void sunkbd_handle_event(DeviceState *dev, QemuConsole *src,
     put_queue(s, keycode);
 }
 
-static QemuInputHandler sunkbd_handler = {
+static const QemuInputHandler sunkbd_handler = {
     .name  = "sun keyboard",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = sunkbd_handle_event,
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 0074a9b6f8..b2130a0d70 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -321,20 +321,20 @@ static void xenfb_mouse_sync(DeviceState *dev)
     xenfb->wheel = 0;
 }
 
-static QemuInputHandler xenfb_keyboard = {
+static const QemuInputHandler xenfb_keyboard = {
     .name  = "Xen PV Keyboard",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = xenfb_key_event,
 };
 
-static QemuInputHandler xenfb_abs_mouse = {
+static const QemuInputHandler xenfb_abs_mouse = {
     .name  = "Xen PV Mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event = xenfb_mouse_event,
     .sync  = xenfb_mouse_sync,
 };
 
-static QemuInputHandler xenfb_rel_mouse = {
+static const QemuInputHandler xenfb_rel_mouse = {
     .name  = "Xen PV Mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
     .event = xenfb_mouse_event,
diff --git a/hw/input/adb-kbd.c b/hw/input/adb-kbd.c
index a9088c910c..e21edf9acd 100644
--- a/hw/input/adb-kbd.c
+++ b/hw/input/adb-kbd.c
@@ -355,7 +355,7 @@ static void adb_kbd_reset(DeviceState *dev)
     s->count = 0;
 }
 
-static QemuInputHandler adb_keyboard_handler = {
+static const QemuInputHandler adb_keyboard_handler = {
     .name  = "QEMU ADB Keyboard",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = adb_keyboard_event,
diff --git a/hw/input/hid.c b/hw/input/hid.c
index a9c7dd1ce1..b8e85374ca 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -510,20 +510,20 @@ void hid_free(HIDState *hs)
     hid_del_idle_timer(hs);
 }
 
-static QemuInputHandler hid_keyboard_handler = {
+static const QemuInputHandler hid_keyboard_handler = {
     .name  = "QEMU HID Keyboard",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = hid_keyboard_event,
 };
 
-static QemuInputHandler hid_mouse_handler = {
+static const QemuInputHandler hid_mouse_handler = {
     .name  = "QEMU HID Mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
     .event = hid_pointer_event,
     .sync  = hid_pointer_sync,
 };
 
-static QemuInputHandler hid_tablet_handler = {
+static const QemuInputHandler hid_tablet_handler = {
     .name  = "QEMU HID Tablet",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event = hid_pointer_event,
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 45af76a837..c8fd23cf36 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -1231,7 +1231,7 @@ static const VMStateDescription vmstate_ps2_mouse = {
     }
 };
 
-static QemuInputHandler ps2_keyboard_handler = {
+static const QemuInputHandler ps2_keyboard_handler = {
     .name  = "QEMU PS/2 Keyboard",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = ps2_keyboard_event,
@@ -1242,7 +1242,7 @@ static void ps2_kbd_realize(DeviceState *dev, Error **errp)
     qemu_input_handler_register(dev, &ps2_keyboard_handler);
 }
 
-static QemuInputHandler ps2_mouse_handler = {
+static const QemuInputHandler ps2_mouse_handler = {
     .name  = "QEMU PS/2 Mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
     .event = ps2_mouse_event,
diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index 7053ad72d4..45e4d4c75d 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -265,7 +265,7 @@ static const TypeInfo virtio_input_hid_info = {
 
 /* ----------------------------------------------------------------- */
 
-static QemuInputHandler virtio_keyboard_handler = {
+static const QemuInputHandler virtio_keyboard_handler = {
     .name  = VIRTIO_ID_NAME_KEYBOARD,
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = virtio_input_handle_event,
@@ -322,7 +322,7 @@ static const TypeInfo virtio_keyboard_info = {
 
 /* ----------------------------------------------------------------- */
 
-static QemuInputHandler virtio_mouse_handler = {
+static const QemuInputHandler virtio_mouse_handler = {
     .name  = VIRTIO_ID_NAME_MOUSE,
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_REL,
     .event = virtio_input_handle_event,
@@ -416,7 +416,7 @@ static const TypeInfo virtio_mouse_info = {
 
 /* ----------------------------------------------------------------- */
 
-static QemuInputHandler virtio_tablet_handler = {
+static const QemuInputHandler virtio_tablet_handler = {
     .name  = VIRTIO_ID_NAME_TABLET,
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event = virtio_input_handle_event,
@@ -541,7 +541,7 @@ static const TypeInfo virtio_tablet_info = {
 
 /* ----------------------------------------------------------------- */
 
-static QemuInputHandler virtio_multitouch_handler = {
+static const QemuInputHandler virtio_multitouch_handler = {
     .name  = VIRTIO_ID_NAME_MULTITOUCH,
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_MTT,
     .event = virtio_input_handle_event,
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 46ea74e44d..210ae5eaca 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -127,7 +127,7 @@ static void legacy_kbd_event(DeviceState *dev, QemuConsole *src,
     }
 }
 
-static QemuInputHandler legacy_kbd_handler = {
+static const QemuInputHandler legacy_kbd_handler = {
     .name  = "legacy-kbd",
     .mask  = INPUT_EVENT_MASK_KEY,
     .event = legacy_kbd_event,
diff --git a/ui/input.c b/ui/input.c
index cbe8573c5c..dc745860f4 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -10,7 +10,7 @@
 
 struct QemuInputHandlerState {
     DeviceState       *dev;
-    QemuInputHandler  *handler;
+    const QemuInputHandler *handler;
     int               id;
     int               events;
     QemuConsole       *con;
@@ -46,7 +46,7 @@ static uint32_t queue_count;
 static uint32_t queue_limit = 1024;
 
 QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
-                                                   QemuInputHandler *handler)
+                                            const QemuInputHandler *handler)
 {
     QemuInputHandlerState *s = g_new0(QemuInputHandlerState, 1);
     static int id = 1;
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 00d36a8677..706d6d97bd 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -297,7 +297,7 @@ static void vdagent_pointer_sync(DeviceState *dev)
     }
 }
 
-static QemuInputHandler vdagent_mouse_handler = {
+static const QemuInputHandler vdagent_mouse_handler = {
     .name  = "vdagent mouse",
     .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
     .event = vdagent_pointer_event,
-- 
2.41.0


