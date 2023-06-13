Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF272E1DA
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:42:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q91YA-0003CU-J6; Tue, 13 Jun 2023 06:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1q91Y5-0003BC-Jh
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 06:46:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1q91Y3-0008DT-Qk
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 06:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686653210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qVUirsNBAfLfxcsWr9eisd8J1vdPufDfdHCRtcbg7h0=;
 b=f1cWG5dK93OZ/NacZ0rRDJVyG9y7+Cija7bmzewDWj8U3Bc0syOdGI4dLw5g/iGL6QavLZ
 Vg0+nJkQ8UsaNCpsjzHe02XRm5C31pNAxu/Vtpj7cPykfVfIirQNk7U3dorDOmBVWz/VJ0
 OxaT+DxGDFUUal0A0DWrY24wxxsYl+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-_Ny9t9YDMISFJR5mbQMvcg-1; Tue, 13 Jun 2023 06:46:49 -0400
X-MC-Unique: _Ny9t9YDMISFJR5mbQMvcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 025B885A5B5
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 10:46:49 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.226.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 794A340B4CD6;
 Tue, 13 Jun 2023 10:46:48 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bilal Elmoussaoui <belmouss@redhat.com>
Subject: [PATCH 1/2] ui/touch: Move event handling to a common helper
Date: Tue, 13 Jun 2023 12:46:42 +0200
Message-Id: <20230613104643.357022-1-belmouss@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=belmouss@redhat.com;
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

To share code between the GTK and DBus UI bakcends
see the next commit for details

Signed-off-by: Bilal Elmoussaoui <belmouss@redhat.com>
---
 include/ui/console.h | 14 ++++++++++
 ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 ui/gtk.c             | 62 ++++--------------------------------------
 3 files changed, 84 insertions(+), 57 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index ae5ec46..04d4317 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -5,6 +5,7 @@
 #include "qom/object.h"
 #include "qemu/notify.h"
 #include "qapi/qapi-types-ui.h"
+#include "ui/input.h"
 
 #ifdef CONFIG_OPENGL
 # include <epoxy/gl.h>
@@ -95,6 +96,19 @@ bool kbd_put_qcode_console(QemuConsole *s, int qcode, bool ctrl);
 void kbd_put_string_console(QemuConsole *s, const char *str, int len);
 void kbd_put_keysym(int keysym);
 
+/* Touch devices */
+typedef struct touch_slot {
+    int x;
+    int y;
+    int tracking_id;
+} touch_slot;
+
+bool console_handle_touch_event(QemuConsole *con,
+                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                                uint64_t num_slot,
+                                int width, int height,
+                                double x, double y,
+                                InputMultiTouchType type);
 /* consoles */
 
 #define TYPE_QEMU_CONSOLE "qemu-console"
diff --git a/ui/console.c b/ui/console.c
index e173731..8bc6adb 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1635,6 +1635,71 @@ static bool console_compatible_with(QemuConsole *con,
     return true;
 }
 
+bool console_handle_touch_event(QemuConsole *con,
+                                struct touch_slot touch_slots[INPUT_EVENT_SLOTS_MAX],
+                                uint64_t num_slot,
+                                int width, int height,
+                                double x, double y,
+                                InputMultiTouchType type)
+{
+    struct touch_slot *slot;
+    bool needs_sync = false;
+    int update;
+    int i;
+
+    if (num_slot >= INPUT_EVENT_SLOTS_MAX) {
+        warn_report("unexpected touch slot number: % " PRId64" >= %d\n",
+                    num_slot, INPUT_EVENT_SLOTS_MAX);
+        return FALSE;
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
+
+    return TRUE;
+}
+
 void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
 {
     /* display has opengl support */
diff --git a/ui/gtk.c b/ui/gtk.c
index e50f950..ebbd304 100644
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
@@ -1099,45 +1079,13 @@ static gboolean gd_touch_event(GtkWidget *widget, GdkEventTouch *touch,
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
-    return TRUE;
+    return console_handle_touch_event(vc->gfx.dcl.con, touch_slots,
+                                      num_slot, surface_width(vc->gfx.ds),
+                                      surface_height(vc->gfx.ds), touch->x,
+                                      touch->y, type);
 }
 
 static const guint16 *gd_get_keymap(size_t *maplen)
-- 
2.40.1


