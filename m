Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CCD712579
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:30:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VcQ-0004gK-NX; Fri, 26 May 2023 07:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2VcK-0004eM-EZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2VcF-0003V9-Jy
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDsNHlioR2H4jjrLp3qswH/BlBa76rIX84DZvBPUH6Y=;
 b=FP6n1iGKXnB7MJAouLbJrAGvTbhO5YwlK1PwH6NVrU3gcucFmdWGFvSZn9u5r4zdZtF7k6
 nPfSotkS9679ZGSFcreY0GMY/Awn2UrJpm0CFUFgrwihgMYyiW6/Yrqwpy6xd7jmBEv54f
 baK2IGQwe396iaHzDWvp982nFbT/4WQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-QocyjRs6NfC4yU0NBZLMSQ-1; Fri, 26 May 2023 07:28:11 -0400
X-MC-Unique: QocyjRs6NfC4yU0NBZLMSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 681CF1C060C3;
 Fri, 26 May 2023 11:28:11 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6F04140E95D;
 Fri, 26 May 2023 11:28:09 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergio Lopez <slp@redhat.com>
Subject: [PATCH v5 3/6] virtio-input: add a virtio-mulitouch device
Date: Fri, 26 May 2023 13:29:22 +0200
Message-Id: <20230526112925.38794-4-slp@redhat.com>
In-Reply-To: <20230526112925.38794-1-slp@redhat.com>
References: <20230526112925.38794-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Add a virtio-multitouch device to the family of devices emulated by
virtio-input implementing the Multi-touch protocol as descripted here:

https://www.kernel.org/doc/html/latest/input/multi-touch-protocol.html?highlight=multi+touch

This patch just add the device itself, without connecting it to any
backends. The following patches will add a PCI-based multitouch device,
some helpers in "ui" and will enable the GTK3 backend to transpose
multi-touch events from the host to the guest.

Signed-off-by: Sergio Lopez <slp@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/input/virtio-input-hid.c      | 118 ++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-input.h |   9 +--
 2 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/hw/input/virtio-input-hid.c b/hw/input/virtio-input-hid.c
index d28dab69ba..7053ad72d4 100644
--- a/hw/input/virtio-input-hid.c
+++ b/hw/input/virtio-input-hid.c
@@ -16,9 +16,10 @@
 
 #include "standard-headers/linux/input.h"
 
-#define VIRTIO_ID_NAME_KEYBOARD "QEMU Virtio Keyboard"
-#define VIRTIO_ID_NAME_MOUSE    "QEMU Virtio Mouse"
-#define VIRTIO_ID_NAME_TABLET   "QEMU Virtio Tablet"
+#define VIRTIO_ID_NAME_KEYBOARD     "QEMU Virtio Keyboard"
+#define VIRTIO_ID_NAME_MOUSE        "QEMU Virtio Mouse"
+#define VIRTIO_ID_NAME_TABLET       "QEMU Virtio Tablet"
+#define VIRTIO_ID_NAME_MULTITOUCH   "QEMU Virtio MultiTouch"
 
 /* ----------------------------------------------------------------- */
 
@@ -30,6 +31,7 @@ static const unsigned short keymap_button[INPUT_BUTTON__MAX] = {
     [INPUT_BUTTON_WHEEL_DOWN]        = BTN_GEAR_DOWN,
     [INPUT_BUTTON_SIDE]              = BTN_SIDE,
     [INPUT_BUTTON_EXTRA]             = BTN_EXTRA,
+    [INPUT_BUTTON_TOUCH]             = BTN_TOUCH,
 };
 
 static const unsigned short axismap_rel[INPUT_AXIS__MAX] = {
@@ -42,6 +44,11 @@ static const unsigned short axismap_abs[INPUT_AXIS__MAX] = {
     [INPUT_AXIS_Y]                   = ABS_Y,
 };
 
+static const unsigned short axismap_tch[INPUT_AXIS__MAX] = {
+    [INPUT_AXIS_X]                   = ABS_MT_POSITION_X,
+    [INPUT_AXIS_Y]                   = ABS_MT_POSITION_Y,
+};
+
 /* ----------------------------------------------------------------- */
 
 static void virtio_input_extend_config(VirtIOInput *vinput,
@@ -81,6 +88,7 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
     InputKeyEvent *key;
     InputMoveEvent *move;
     InputBtnEvent *btn;
+    InputMultiTouchEvent *mtt;
 
     switch (evt->type) {
     case INPUT_EVENT_KIND_KEY:
@@ -137,6 +145,24 @@ static void virtio_input_handle_event(DeviceState *dev, QemuConsole *src,
         event.value = cpu_to_le32(move->value);
         virtio_input_send(vinput, &event);
         break;
+    case INPUT_EVENT_KIND_MTT:
+        mtt = evt->u.mtt.data;
+        if (mtt->type == INPUT_MULTI_TOUCH_TYPE_DATA) {
+            event.type  = cpu_to_le16(EV_ABS);
+            event.code  = cpu_to_le16(axismap_tch[mtt->axis]);
+            event.value = cpu_to_le32(mtt->value);
+            virtio_input_send(vinput, &event);
+        } else {
+            event.type  = cpu_to_le16(EV_ABS);
+            event.code  = cpu_to_le16(ABS_MT_SLOT);
+            event.value = cpu_to_le32(mtt->slot);
+            virtio_input_send(vinput, &event);
+            event.type  = cpu_to_le16(EV_ABS);
+            event.code  = cpu_to_le16(ABS_MT_TRACKING_ID);
+            event.value = cpu_to_le32(mtt->tracking_id);
+            virtio_input_send(vinput, &event);
+        }
+        break;
     default:
         /* keep gcc happy */
         break;
@@ -515,12 +541,98 @@ static const TypeInfo virtio_tablet_info = {
 
 /* ----------------------------------------------------------------- */
 
+static QemuInputHandler virtio_multitouch_handler = {
+    .name  = VIRTIO_ID_NAME_MULTITOUCH,
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_MTT,
+    .event = virtio_input_handle_event,
+    .sync  = virtio_input_handle_sync,
+};
+
+static struct virtio_input_config virtio_multitouch_config[] = {
+    {
+        .select    = VIRTIO_INPUT_CFG_ID_NAME,
+        .size      = sizeof(VIRTIO_ID_NAME_MULTITOUCH),
+        .u.string  = VIRTIO_ID_NAME_MULTITOUCH,
+    },{
+        .select    = VIRTIO_INPUT_CFG_ID_DEVIDS,
+        .size      = sizeof(struct virtio_input_devids),
+        .u.ids     = {
+            .bustype = const_le16(BUS_VIRTUAL),
+            .vendor  = const_le16(0x0627), /* same we use for usb hid devices */
+            .product = const_le16(0x0003),
+            .version = const_le16(0x0001),
+        },
+    },{
+        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    = ABS_MT_SLOT,
+        .size      = sizeof(virtio_input_absinfo),
+        .u.abs.min = const_le32(INPUT_EVENT_SLOTS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_SLOTS_MAX),
+    },{
+        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    = ABS_MT_TRACKING_ID,
+        .size      = sizeof(virtio_input_absinfo),
+        .u.abs.min = const_le32(INPUT_EVENT_SLOTS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_SLOTS_MAX),
+    },{
+        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    = ABS_MT_POSITION_X,
+        .size      = sizeof(virtio_input_absinfo),
+        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
+    },{
+        .select    = VIRTIO_INPUT_CFG_ABS_INFO,
+        .subsel    = ABS_MT_POSITION_Y,
+        .size      = sizeof(virtio_input_absinfo),
+        .u.abs.min = const_le32(INPUT_EVENT_ABS_MIN),
+        .u.abs.max = const_le32(INPUT_EVENT_ABS_MAX),
+    },
+    { /* end of list */ },
+};
+
+static void virtio_multitouch_init(Object *obj)
+{
+    VirtIOInputHID *vhid = VIRTIO_INPUT_HID(obj);
+    VirtIOInput *vinput = VIRTIO_INPUT(obj);
+    unsigned short abs_props[] = {
+        INPUT_PROP_DIRECT,
+    };
+    unsigned short abs_bits[] = {
+        ABS_MT_SLOT,
+        ABS_MT_TRACKING_ID,
+        ABS_MT_POSITION_X,
+        ABS_MT_POSITION_Y,
+    };
+
+    vhid->handler = &virtio_multitouch_handler;
+    virtio_input_init_config(vinput, virtio_multitouch_config);
+    virtio_input_extend_config(vinput, keymap_button,
+                               ARRAY_SIZE(keymap_button),
+                               VIRTIO_INPUT_CFG_EV_BITS, EV_KEY);
+    virtio_input_extend_config(vinput, abs_props,
+                               ARRAY_SIZE(abs_props),
+                               VIRTIO_INPUT_CFG_PROP_BITS, 0);
+    virtio_input_extend_config(vinput, abs_bits,
+                               ARRAY_SIZE(abs_bits),
+                               VIRTIO_INPUT_CFG_EV_BITS, EV_ABS);
+}
+
+static const TypeInfo virtio_multitouch_info = {
+    .name          = TYPE_VIRTIO_MULTITOUCH,
+    .parent        = TYPE_VIRTIO_INPUT_HID,
+    .instance_size = sizeof(VirtIOInputHID),
+    .instance_init = virtio_multitouch_init,
+};
+
+/* ----------------------------------------------------------------- */
+
 static void virtio_register_types(void)
 {
     type_register_static(&virtio_input_hid_info);
     type_register_static(&virtio_keyboard_info);
     type_register_static(&virtio_mouse_info);
     type_register_static(&virtio_tablet_info);
+    type_register_static(&virtio_multitouch_info);
 }
 
 type_init(virtio_register_types)
diff --git a/include/hw/virtio/virtio-input.h b/include/hw/virtio/virtio-input.h
index f2da63d309..08f1591424 100644
--- a/include/hw/virtio/virtio-input.h
+++ b/include/hw/virtio/virtio-input.h
@@ -24,10 +24,11 @@ OBJECT_DECLARE_TYPE(VirtIOInput, VirtIOInputClass,
 #define VIRTIO_INPUT_GET_PARENT_CLASS(obj) \
         OBJECT_GET_PARENT_CLASS(obj, TYPE_VIRTIO_INPUT)
 
-#define TYPE_VIRTIO_INPUT_HID "virtio-input-hid-device"
-#define TYPE_VIRTIO_KEYBOARD  "virtio-keyboard-device"
-#define TYPE_VIRTIO_MOUSE     "virtio-mouse-device"
-#define TYPE_VIRTIO_TABLET    "virtio-tablet-device"
+#define TYPE_VIRTIO_INPUT_HID  "virtio-input-hid-device"
+#define TYPE_VIRTIO_KEYBOARD   "virtio-keyboard-device"
+#define TYPE_VIRTIO_MOUSE      "virtio-mouse-device"
+#define TYPE_VIRTIO_TABLET     "virtio-tablet-device"
+#define TYPE_VIRTIO_MULTITOUCH "virtio-multitouch-device"
 
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIOInputHID, VIRTIO_INPUT_HID)
 #define VIRTIO_INPUT_HID_GET_PARENT_CLASS(obj) \
-- 
2.38.1


