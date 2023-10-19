Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B2B7D0404
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:27:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaUM-0008Qg-4j; Thu, 19 Oct 2023 17:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaUI-0008CJ-WE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaUF-0001jg-Ff
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:23:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dbbf3c782so779488f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750601; x=1698355401; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9lJp+b2DIJ9xUd00S7g/tXGm5acpgAQSoiQZWG4ikE=;
 b=X6L+++nrtugMAVc6/0dwi4syZpnex7PBq68RLsEjilLZR+JFmglRA9SPhPuQVd/oYO
 Z95BOD/rK8c+CrncLprVZKecV+VARqV/weB+vtduITYAhQVb7t5db/0db/Uzo0hud/YY
 E0cSh86SPJHaemnAleOBEpVN8O+Z6MtZGKNemsj7DwemPvFeQQczWQnD1234xbfpTIS6
 iNxfb39xyRf2YdrBVAQyUZEJ1RKDO6EASIA+Zw4o1f7heqs1UD4Vf+A2Ke/4A6U/6hOq
 1P423MgHO+mx7Pqca6XtQ6B2/QP30PaNPX1JM4RHRGPfkI9ZQWY2Up179jAHwgFUiTqB
 BBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750601; x=1698355401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9lJp+b2DIJ9xUd00S7g/tXGm5acpgAQSoiQZWG4ikE=;
 b=nbtU7SZ5wQtEM6I9wfjdETrybHvQ4ZZjNAVoaTfy1RSA7A9UkyXElaVZ5DUmQymunx
 CE0XkCiSErSVI8JF7x+aWMa+OtWNGNozWA0n105agmSsDMIoDSzkX8pngzPcZc1PA3vo
 f0/qK0+LambhGB09DdWLSWX3BbNesfaaxGDhjFoOIIlTvAdmT1vq0PHGvMuOLqCtu0am
 NKxA+A7DzXSTh8zcJnOUN9o33AhI7R6lTJu9KexrBBY89H3AXg3zNkIFwuwyFUI9KSMJ
 vx/+C/5VaHkRuYOnuMx4Z2Fo8l1Ohj1PP4iLMATh7PHHvcIVPwD+Dk9cOvMaL9zEm+Pu
 zAqg==
X-Gm-Message-State: AOJu0YzOFpmURq3eYXJhSPp5oJu5ZMPAER9B66Sokam+Ku2ETwm7I0CZ
 zmlqImNsK1SZ6rFL0X5rYJMMno4u8eBLW1V5+Efd6A==
X-Google-Smtp-Source: AGHT+IGg/Dp9IEokSsTjvDXCE+MBx08UvC0HGe/gKXfTnujJedy2dxKexIj/wRudUxPmQHNUI84yOg==
X-Received: by 2002:a5d:5956:0:b0:32d:de4f:140b with SMTP id
 e22-20020a5d5956000000b0032dde4f140bmr2955479wri.6.1697750601701; 
 Thu, 19 Oct 2023 14:23:21 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a05600c420900b004065e235417sm5250795wmh.21.2023.10.19.14.23.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:23:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 xen-devel@lists.xenproject.org
Subject: [PULL 46/46] ui/input: Constify QemuInputHandler structure
Date: Thu, 19 Oct 2023 23:18:11 +0200
Message-ID: <20231019211814.30576-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20231017131251.43708-1-philmd@linaro.org>
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


