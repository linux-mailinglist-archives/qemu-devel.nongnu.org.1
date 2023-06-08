Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 474DF7288FA
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 21:49:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7LcK-0004Kq-1D; Thu, 08 Jun 2023 15:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.chollet@free.fr>)
 id 1q7LFW-0008Vx-T9
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:24:46 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucas.chollet@free.fr>)
 id 1q7LFH-0000jK-Nd
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 15:24:46 -0400
Received: from asub.. (unknown [198.16.189.195])
 (Authenticated sender: lucas.chollet@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 6D2352003DD;
 Thu,  8 Jun 2023 21:24:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1686252266;
 bh=VwcTTzd+GV6VqDurnqh9taJkBvEXA7dVYb4Bq6YLB9w=;
 h=From:To:Cc:Subject:Date:From;
 b=VGc7EdSKngD88ljrccaUSthpa8juDFGkB44U45FnQM1GX8LQw1T8Bk3ERs02F9lHK
 tm+apcDxDM4FkSVAJXwBNdmhow+mAW3b04WtnMpST0QdMRXIVpZ/QSr09zO6lLkfl9
 zk4ny+IKbTFrQVy2e7BK/yLtAaR32s8ss1M1MUE9XWszKM+4T5L63z8HjSj+gfO5Ot
 wovzktNeO93aMQK3SfRwbSa188E8R3EAik4pEkncIwqremqfnT1jXD2lUBoQNBTEaF
 x+mToVedmUu1wt8KC2CPVi6GPZQszQ8+A7mC5e5udBS7HWBh+XT7BV+1RwxtRZT8Mq
 ibEeRCHR5EumA==
From: Lucas Chollet <lucas.chollet@free.fr>
To: qemu-devel@nongnu.org
Cc: Lucas Chollet <lucas.chollet@free.fr>
Subject: [PATCH] hw/i386/vmmouse: use the new input api
Date: Thu,  8 Jun 2023 15:23:45 -0400
Message-Id: <20230608192345.708062-1-lucas.chollet@free.fr>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=lucas.chollet@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 08 Jun 2023 15:48:17 -0400
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

No functional changes intended.

Signed-off-by: Lucas Chollet <lucas.chollet@free.fr>
---
 hw/i386/vmmouse.c | 95 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 24 deletions(-)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index a56c185f15..bdddbb64ac 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "ui/console.h"
+#include "ui/input.h"
 #include "hw/i386/vmport.h"
 #include "hw/input/i8042.h"
 #include "hw/qdev-properties.h"
@@ -61,7 +61,10 @@ struct VMMouseState {
     uint16_t nb_queue;
     uint16_t status;
     uint8_t absolute;
-    QEMUPutMouseEntry *entry;
+    int32_t last_x;
+    int32_t last_y;
+    int32_t last_buttons;
+    QemuInputHandlerState *entry;
     ISAKBDState *i8042;
 };
 
@@ -91,33 +94,72 @@ static uint32_t vmmouse_get_status(VMMouseState *s)
     return (s->status << 16) | s->nb_queue;
 }
 
-static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_state)
+static void vmmouse_mouse_event(DeviceState *dev, QemuConsole *src,
+                                InputEvent *evt)
 {
-    VMMouseState *s = opaque;
-    int buttons = 0;
+    static const int bmap[INPUT_BUTTON__MAX] = {
+        [INPUT_BUTTON_LEFT]   = 0x20,
+        [INPUT_BUTTON_MIDDLE] = 0x08,
+        [INPUT_BUTTON_RIGHT]  = 0x10,
+    };
+
+    VMMouseState *s = VMMOUSE(dev);
+    InputMoveEvent *move;
+    InputBtnEvent *btn;
+
+    int32_t dz = 0;
 
     if (s->nb_queue > (VMMOUSE_QUEUE_SIZE - 4))
         return;
 
-    DPRINTF("vmmouse_mouse_event(%d, %d, %d, %d)\n",
-            x, y, dz, buttons_state);
+    switch (evt->type) {
+    case INPUT_EVENT_KIND_REL:
+        move = evt->u.rel.data;
+        if (move->axis == INPUT_AXIS_X) {
+            s->last_x += move->value;
+        } else if (move->axis == INPUT_AXIS_Y) {
+            s->last_y -= move->value;
+        }
+        break;
 
-    if ((buttons_state & MOUSE_EVENT_LBUTTON))
-        buttons |= 0x20;
-    if ((buttons_state & MOUSE_EVENT_RBUTTON))
-        buttons |= 0x10;
-    if ((buttons_state & MOUSE_EVENT_MBUTTON))
-        buttons |= 0x08;
+    case INPUT_EVENT_KIND_ABS:
+        move = evt->u.rel.data;
+        if (move->axis == INPUT_AXIS_X) {
+            s->last_x = move->value;
+        } else if (move->axis == INPUT_AXIS_Y) {
+            s->last_y = move->value;
+        }
+        break;
 
-    if (s->absolute) {
-        x <<= 1;
-        y <<= 1;
+    case INPUT_EVENT_KIND_BTN:
+        btn = evt->u.btn.data;
+        if (btn->down) {
+            s->last_buttons |= bmap[btn->button];
+            if (btn->button == INPUT_BUTTON_WHEEL_UP) {
+                dz--;
+            } else if (btn->button == INPUT_BUTTON_WHEEL_DOWN) {
+                dz++;
+            }
+
+        } else {
+          s->last_buttons &= ~bmap[btn->button];
+        }
+        break;
+
+    default:
+        /* keep gcc happy */
+        break;
     }
 
-    s->queue[s->nb_queue++] = buttons;
-    s->queue[s->nb_queue++] = x;
-    s->queue[s->nb_queue++] = y;
+    s->queue[s->nb_queue++] = s->last_buttons;
+    s->queue[s->nb_queue++] = s->absolute ? s->last_x << 1 : s->last_x;
+    s->queue[s->nb_queue++] = s->absolute ? s->last_y << 1 : s->last_y;
     s->queue[s->nb_queue++] = dz;
+}
+
+static void vmmouse_mouse_sync(DeviceState *dev)
+{
+    VMMouseState *s = VMMOUSE(dev);
 
     /* need to still generate PS2 events to notify driver to
        read from queue */
@@ -127,11 +169,18 @@ static void vmmouse_mouse_event(void *opaque, int x, int y, int dz, int buttons_
 static void vmmouse_remove_handler(VMMouseState *s)
 {
     if (s->entry) {
-        qemu_remove_mouse_event_handler(s->entry);
+        qemu_input_handler_unregister(s->entry);
         s->entry = NULL;
     }
 }
 
+static QemuInputHandler vm_mouse_handler = {
+    .name  = "vmmouse",
+    .mask  = INPUT_EVENT_MASK_BTN | INPUT_EVENT_MASK_ABS,
+    .event = vmmouse_mouse_event,
+    .sync  = vmmouse_mouse_sync,
+};
+
 static void vmmouse_update_handler(VMMouseState *s, int absolute)
 {
     if (s->status != 0) {
@@ -142,10 +191,8 @@ static void vmmouse_update_handler(VMMouseState *s, int absolute)
         vmmouse_remove_handler(s);
     }
     if (s->entry == NULL) {
-        s->entry = qemu_add_mouse_event_handler(vmmouse_mouse_event,
-                                                s, s->absolute,
-                                                "vmmouse");
-        qemu_activate_mouse_event_handler(s->entry);
+        s->entry = qemu_input_handler_register(DEVICE(s), &vm_mouse_handler);
+        qemu_input_handler_activate(s->entry);
     }
 }
 
-- 
2.39.2


