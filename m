Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9B873FC76
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Lc-0008RD-3h; Tue, 27 Jun 2023 09:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LY-0008Qq-Eo
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8LW-00072P-9O
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2G2wPfzNhz9xszO3kbCqKLSy2qFP76mNRInukh5i1UQ=;
 b=ZlDvWo8YwZrIaRmOQjTLECm4dNEYPh+UlcWvm4o6GZdD5EyDqFtu9xXMSNJFMWMk+sxGdS
 0mcc32q4NYkj+4eatNchHmaqezHHwuKGrKQP/NgFbQmjskoLx4x1ZQWNoFt7Goy/YJjSPl
 9UNp+iGbfjDEHaqianjM0rPBwJ9AXBA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-_wRJkIkONu-5Q3NfgNZ8nw-1; Tue, 27 Jun 2023 09:02:58 -0400
X-MC-Unique: _wRJkIkONu-5Q3NfgNZ8nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA0F13C1C4EB;
 Tue, 27 Jun 2023 13:02:45 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 537BCF5CC5;
 Tue, 27 Jun 2023 13:02:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Bilal Elmoussaoui <belmouss@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 06/33] ui/touch: Move event handling to a common helper
Date: Tue, 27 Jun 2023 15:02:03 +0200
Message-ID: <20230627130231.1614896-7-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Bilal Elmoussaoui <belmouss@redhat.com>

To share code between the GTK and DBus UI bakcends
see the next commit for details

Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230619095337.9899-2-belmouss@redhat.com>
---
 include/ui/console.h | 15 ++++++++++
 ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 ui/gtk.c             | 61 ++++-------------------------------------
 3 files changed, 85 insertions(+), 56 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index ae5ec466c1..2093e2a3ba 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,6 +5,7 @@
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qapi/qapi-types-ui.h"
+#include "ui/input.h"
 
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
@@ -95,6 +96,20 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl);
 void kbd_put_string_console(QemuConsole *s, const char *str, int len);
 void kbd_put_keysym(int keysym);
 
+/* Touch devices */
+typedef struct touch_slot {
+    int x;
+    int y;
+    int tracking_id;
+} touch_slot;
+
+void console_handle_touch_event(QemuConsole *con,
+                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                                uint64_t num_slot,
+                                int width, int height,
+                                double x, double y,
+                                InputMultiTouchType type,
+                                Error **errp);
 /* consoles */
 
 #define TYPE_QEMU_CONSOLE "qemu-console"
diff --git a/ui/console.c b/ui/console.c
index 7461446e71..cfaa43e970 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1635,6 +1635,71 @@ static bool console_compatible_with(QemuConsole *con,
     return true;
 }
 
+void console_handle_touch_event(QemuConsole *con,
+                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                                uint64_t num_slot,
+                                int width, int height,
+                                double x, double y,
+                                InputMultiTouchType type,
+                                Error **errp)
+{
+    struct touch_slot *slot;
+    bool needs_sync = false;
+    int update;
+    int i;
+
+    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
+        error_setg(errp,
+                   "Unexpected touch slot number: % " PRId64" >= %d",
+                   num_slot, INPUT_EVENT_SLOTS_MAX);
+        return;
+    }
+
+    slot = &touch_slots[num_slot];
+    slot->x = x;
+    slot->y = y;
+
+    if (type == INPUT_MULTI_TOUCH_TYPE_BEGIN) {
+        slot->tracking_id = num_slot;
+    }
+
+    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
+        if (i == num_slot) {
+            update = type;
+        } else {
+            update = INPUT_MULTI_TOUCH_TYPE_UPDATE;
+        }
+
+        slot = &touch_slots[i];
+
+        if (slot->tracking_id == -1) {
+            continue;
+        }
+
+        if (update == INPUT_MULTI_TOUCH_TYPE_END) {
+            slot->tracking_id = -1;
+            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
+            needs_sync = true;
+        } else {
+            qemu_input_queue_mtt(con, update, i, slot->tracking_id);
+            qemu_input_queue_btn(con, INPUT_BUTTON_TOUCH, true);
+            qemu_input_queue_mtt_abs(con,
+                                    INPUT_AXIS_X, (int) slot->x,
+                                    0, width,
+                                    i, slot->tracking_id);
+            qemu_input_queue_mtt_abs(con,
+                                    INPUT_AXIS_Y, (int) slot->y,
+                                    0, height,
+                                    i, slot->tracking_id);
+            needs_sync = true;
+        }
+    }
+
+    if (needs_sync) {
+        qemu_input_event_sync();
+    }
+}
+
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
 {
     /* display has opengl support */
diff --git a/ui/gtk.c b/ui/gtk.c
index e50f950f2b..e09e164482 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -130,11 +130,6 @@ typedef struct VCChardev VCChardev;
 DECLARE_INSTANCE_CHECKER(VCChardev, VC_CHARDEV,
                          TYPE_CHARDEV_VC)
 
-struct touch_slot {
-    int x;
-    int y;
-    int tracking_id;
-};
 static struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX];
 
 bool gtk_use_gl_area;
@@ -1068,27 +1063,12 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
                                void *opaque)
 {
     VirtualConsole *vc = opaque;
-    struct touch_slot *slot;
     uint64_t num_slot = GPOINTER_TO_UINT(touch->sequence);
-    bool needs_sync = false;
-    int update;
     int type = -1;
-    int i;
-
-    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
-        warn_report("gtk: unexpected touch slot number: % " PRId64" >= %d\n",
-                    num_slot, INPUT_EVENT_SLOTS_MAX);
-        return FALSE;
-    }
-
-    slot = &touch_slots[num_slot];
-    slot->x = touch->x;
-    slot->y = touch->y;
 
     switch (touch->type) {
     case GDK_TOUCH_BEGIN:
         type = INPUT_MULTI_TOUCH_TYPE_BEGIN;
-        slot->tracking_id = num_slot;
         break;
     case GDK_TOUCH_UPDATE:
         type = INPUT_MULTI_TOUCH_TYPE_UPDATE;
@@ -1099,44 +1079,13 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
         break;
     default:
         warn_report("gtk: unexpected touch event type\n");
+        return FALSE;
     }
 
-    for (i = 0; i < INPUT_EVENT_SLOTS_MAX; ++i) {
-        if (i == num_slot) {
-            update = type;
-        } else {
-            update = INPUT_MULTI_TOUCH_TYPE_UPDATE;
-        }
-
-        slot = &touch_slots[i];
-
-        if (slot->tracking_id == -1) {
-            continue;
-        }
-
-        if (update == INPUT_MULTI_TOUCH_TYPE_END) {
-            slot->tracking_id = -1;
-            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i, slot->tracking_id);
-            needs_sync = true;
-        } else {
-            qemu_input_queue_mtt(vc->gfx.dcl.con, update, i, slot->tracking_id);
-            qemu_input_queue_btn(vc->gfx.dcl.con, INPUT_BUTTON_TOUCH, true);
-            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
-                                     INPUT_AXIS_X, (int) slot->x,
-                                     0, surface_width(vc->gfx.ds),
-                                     i, slot->tracking_id);
-            qemu_input_queue_mtt_abs(vc->gfx.dcl.con,
-                                     INPUT_AXIS_Y, (int) slot->y,
-                                     0, surface_height(vc->gfx.ds),
-                                     i, slot->tracking_id);
-            needs_sync = true;
-        }
-    }
-
-    if (needs_sync) {
-        qemu_input_event_sync();
-    }
-
+    console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
+                               num_slot, surface_width(vc->gfx.ds),
+                               surface_height(vc->gfx.ds), touch->x,
+                               touch->y, type, &error_warn);
     return TRUE;
 }
 
-- 
2.41.0


