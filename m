Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F310D7B6920
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 14:37:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnedG-0006Xf-Op; Tue, 03 Oct 2023 08:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned4-0006Wr-PU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:35:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qned2-0000Df-I4
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 08:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696336555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NS60sToy85LPsWtm1q8njsiNd3dGtpjdVIbvaB/pId4=;
 b=TUwdHg11s5266ImKhANJdtJ2TexNuf7c7Uy4KM655tPozmSTUXTfYcrNfawzRyUmkqikyl
 hoI9QSNOV1FVSqoWDBrEzT/e1WdAAL98fn1eqU4AS2KhDWedNMZepE/8LkfM8L8OcT0tNW
 IOGRgvauRkFkZbepk5WyS9SydRo1TNk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-576-iVkkl7vdPdyvMhHGUKzs6w-1; Tue, 03 Oct 2023 08:35:52 -0400
X-MC-Unique: iVkkl7vdPdyvMhHGUKzs6w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96FA1299E742;
 Tue,  3 Oct 2023 12:35:51 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B0649400E89;
 Tue,  3 Oct 2023 12:35:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/13] input: Allow to choose console with
 qemu_input_is_absolute
Date: Tue,  3 Oct 2023 16:35:30 +0400
Message-ID: <20231003123543.1360795-2-marcandre.lureau@redhat.com>
In-Reply-To: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
References: <20231003123543.1360795-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Although an input is routed depending on the console,
qemu_input_is_absolute() had no mechanism to specify the console.

Accept QemuConsole as an argument for qemu_input_is_absolute, and let
the display know the absolute/relative state for a particular console.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230921082936.28100-1-akihiko.odaki@daynix.com>
---
 include/ui/input.h |  2 +-
 ui/dbus-console.c  |  6 +++---
 ui/gtk.c           | 12 ++++++------
 ui/input.c         | 29 +++++++----------------------
 ui/sdl2.c          | 26 +++++++++++++-------------
 ui/spice-input.c   |  2 +-
 ui/vnc.c           |  2 +-
 ui/cocoa.m         |  2 +-
 ui/trace-events    |  1 -
 9 files changed, 33 insertions(+), 49 deletions(-)

diff --git a/include/ui/input.h b/include/ui/input.h
index c29a730a71..24d8e4579e 100644
--- a/include/ui/input.h
+++ b/include/ui/input.h
@@ -57,7 +57,7 @@ void qemu_input_queue_btn(QemuConsole *src, InputButton btn, bool down);
 void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
                                uint32_t button_old, uint32_t button_new);
 
-bool qemu_input_is_absolute(void);
+bool qemu_input_is_absolute(QemuConsole *con);
 int qemu_input_scale_axis(int value,
                           int min_in, int max_in,
                           int min_out, int max_out);
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 36f7349585..49da9ccc83 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -386,7 +386,7 @@ dbus_mouse_rel_motion(DBusDisplayConsole *ddc,
 {
     trace_dbus_mouse_rel_motion(dx, dy);
 
-    if (qemu_input_is_absolute()) {
+    if (qemu_input_is_absolute(ddc->dcl.con)) {
         g_dbus_method_invocation_return_error(
             invocation, DBUS_DISPLAY_ERROR,
             DBUS_DISPLAY_ERROR_INVALID,
@@ -453,7 +453,7 @@ dbus_mouse_set_pos(DBusDisplayConsole *ddc,
 
     trace_dbus_mouse_set_pos(x, y);
 
-    if (!qemu_input_is_absolute()) {
+    if (!qemu_input_is_absolute(ddc->dcl.con)) {
         g_dbus_method_invocation_return_error(
             invocation, DBUS_DISPLAY_ERROR,
             DBUS_DISPLAY_ERROR_INVALID,
@@ -514,7 +514,7 @@ static void
 dbus_mouse_update_is_absolute(DBusDisplayConsole *ddc)
 {
     g_object_set(ddc->iface_mouse,
-                 "is-absolute", qemu_input_is_absolute(),
+                 "is-absolute", qemu_input_is_absolute(ddc->dcl.con),
                  NULL);
 }
 
diff --git a/ui/gtk.c b/ui/gtk.c
index 3373427c9b..cd3b8953cd 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -204,7 +204,7 @@ static void gd_update_cursor(VirtualConsole *vc)
     }
 
     window = gtk_widget_get_window(GTK_WIDGET(vc->gfx.drawing_area));
-    if (s->full_screen || qemu_input_is_absolute() || s->ptr_owner == vc) {
+    if (s->full_screen || qemu_input_is_absolute(vc->gfx.dcl.con) || s->ptr_owner == vc) {
         gdk_window_set_cursor(window, s->null_cursor);
     } else {
         gdk_window_set_cursor(window, NULL);
@@ -453,7 +453,7 @@ static void gd_mouse_set(DisplayChangeListener *dcl,
     gint x_root, y_root;
 
     if (!gtk_widget_get_realized(vc->gfx.drawing_area) ||
-        qemu_input_is_absolute()) {
+        qemu_input_is_absolute(dcl->con)) {
         return;
     }
 
@@ -689,7 +689,7 @@ static void gd_mouse_mode_change(Notifier *notify, void *data)
 
     s = container_of(notify, GtkDisplayState, mouse_mode_notifier);
     /* release the grab at switching to absolute mode */
-    if (qemu_input_is_absolute() && s->ptr_owner) {
+    if (s->ptr_owner && qemu_input_is_absolute(s->ptr_owner->gfx.dcl.con)) {
         if (!s->ptr_owner->window) {
             gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
                                            FALSE);
@@ -903,7 +903,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     x = (motion->x - mx) / vc->gfx.scale_x * ws;
     y = (motion->y - my) / vc->gfx.scale_y * ws;
 
-    if (qemu_input_is_absolute()) {
+    if (qemu_input_is_absolute(vc->gfx.dcl.con)) {
         if (x < 0 || y < 0 ||
             x >= surface_width(vc->gfx.ds) ||
             y >= surface_height(vc->gfx.ds)) {
@@ -923,7 +923,7 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
     s->last_y = y;
     s->last_set = TRUE;
 
-    if (!qemu_input_is_absolute() && s->ptr_owner == vc) {
+    if (!qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner == vc) {
         GdkScreen *screen = gtk_widget_get_screen(vc->gfx.drawing_area);
         GdkDisplay *dpy = gtk_widget_get_display(widget);
         GdkWindow *win = gtk_widget_get_window(widget);
@@ -965,7 +965,7 @@ static gboolean gd_button_event(GtkWidget *widget, GdkEventButton *button,
 
     /* implicitly grab the input at the first click in the relative mode */
     if (button->button == 1 && button->type == GDK_BUTTON_PRESS &&
-        !qemu_input_is_absolute() && s->ptr_owner != vc) {
+        !qemu_input_is_absolute(vc->gfx.dcl.con) && s->ptr_owner != vc) {
         if (!vc->window) {
             gtk_check_menu_item_set_active(GTK_CHECK_MENU_ITEM(s->grab_item),
                                            TRUE);
diff --git a/ui/input.c b/ui/input.c
index 1aad64b07c..cbe8573c5c 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -56,7 +56,7 @@ QemuInputHandlerState *qemu_input_handler_register(DeviceState *dev,
     s->id = id++;
     QTAILQ_INSERT_TAIL(&handlers, s, node);
 
-    qemu_input_check_mode_change();
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return s;
 }
 
@@ -64,21 +64,21 @@ void qemu_input_handler_activate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_HEAD(&handlers, s, node);
-    qemu_input_check_mode_change();
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
 }
 
 void qemu_input_handler_deactivate(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     QTAILQ_INSERT_TAIL(&handlers, s, node);
-    qemu_input_check_mode_change();
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
 }
 
 void qemu_input_handler_unregister(QemuInputHandlerState *s)
 {
     QTAILQ_REMOVE(&handlers, s, node);
     g_free(s);
-    qemu_input_check_mode_change();
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
 }
 
 void qemu_input_handler_bind(QemuInputHandlerState *s,
@@ -494,12 +494,12 @@ void qemu_input_update_buttons(QemuConsole *src, uint32_t *button_map,
     }
 }
 
-bool qemu_input_is_absolute(void)
+bool qemu_input_is_absolute(QemuConsole *con)
 {
     QemuInputHandlerState *s;
 
     s = qemu_input_find_handler(INPUT_EVENT_MASK_REL | INPUT_EVENT_MASK_ABS,
-                                NULL);
+                                con);
     return (s != NULL) && (s->handler->mask & INPUT_EVENT_MASK_ABS);
 }
 
@@ -583,21 +583,6 @@ void qemu_input_queue_mtt_abs(QemuConsole *src, InputAxis axis, int value,
     qemu_input_event_send(src, &evt);
 }
 
-void qemu_input_check_mode_change(void)
-{
-    static int current_is_absolute;
-    int is_absolute;
-
-    is_absolute = qemu_input_is_absolute();
-
-    if (is_absolute != current_is_absolute) {
-        trace_input_mouse_mode(is_absolute);
-        notifier_list_notify(&mouse_mode_notifiers, NULL);
-    }
-
-    current_is_absolute = is_absolute;
-}
-
 void qemu_add_mouse_mode_change_notifier(Notifier *notify)
 {
     notifier_list_add(&mouse_mode_notifiers, notify);
@@ -657,6 +642,6 @@ bool qemu_mouse_set(int index, Error **errp)
     }
 
     qemu_input_handler_activate(s);
-    qemu_input_check_mode_change();
+    notifier_list_notify(&mouse_mode_notifiers, NULL);
     return true;
 }
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 178cc054ab..fbfdb64e90 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -203,7 +203,7 @@ static void sdl_hide_cursor(struct sdl2_console *scon)
     SDL_ShowCursor(SDL_DISABLE);
     SDL_SetCursor(sdl_cursor_hidden);
 
-    if (!qemu_input_is_absolute()) {
+    if (!qemu_input_is_absolute(scon->dcl.con)) {
         SDL_SetRelativeMouseMode(SDL_TRUE);
     }
 }
@@ -214,12 +214,12 @@ static void sdl_show_cursor(struct sdl2_console *scon)
         return;
     }
 
-    if (!qemu_input_is_absolute()) {
+    if (!qemu_input_is_absolute(scon->dcl.con)) {
         SDL_SetRelativeMouseMode(SDL_FALSE);
     }
 
     if (guest_cursor &&
-        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
+        (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
         SDL_SetCursor(guest_sprite);
     } else {
         SDL_SetCursor(sdl_cursor_normal);
@@ -245,7 +245,7 @@ static void sdl_grab_start(struct sdl2_console *scon)
     }
     if (guest_cursor) {
         SDL_SetCursor(guest_sprite);
-        if (!qemu_input_is_absolute() && !absolute_enabled) {
+        if (!qemu_input_is_absolute(scon->dcl.con) && !absolute_enabled) {
             SDL_WarpMouseInWindow(scon->real_window, guest_x, guest_y);
         }
     } else {
@@ -280,7 +280,7 @@ static void absolute_mouse_grab(struct sdl2_console *scon)
 
 static void sdl_mouse_mode_change(Notifier *notify, void *data)
 {
-    if (qemu_input_is_absolute()) {
+    if (qemu_input_is_absolute(sdl2_console[0].dcl.con)) {
         if (!absolute_enabled) {
             absolute_enabled = 1;
             SDL_SetRelativeMouseMode(SDL_FALSE);
@@ -311,7 +311,7 @@ static void sdl_send_mouse_event(struct sdl2_console *scon, int dx, int dy,
         prev_state = state;
     }
 
-    if (qemu_input_is_absolute()) {
+    if (qemu_input_is_absolute(scon->dcl.con)) {
         qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_X,
                              x, 0, surface_width(scon->surface));
         qemu_input_queue_abs(scon->dcl.con, INPUT_AXIS_Y,
@@ -497,7 +497,7 @@ static void handle_mousemotion(SDL_Event *ev)
         return;
     }
 
-    if (qemu_input_is_absolute() || absolute_enabled) {
+    if (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
         int scr_w, scr_h;
         SDL_GetWindowSize(scon->real_window, &scr_w, &scr_h);
         max_x = scr_w - 1;
@@ -513,7 +513,7 @@ static void handle_mousemotion(SDL_Event *ev)
             sdl_grab_start(scon);
         }
     }
-    if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
+    if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
         sdl_send_mouse_event(scon, ev->motion.xrel, ev->motion.yrel,
                              ev->motion.x, ev->motion.y, ev->motion.state);
     }
@@ -530,7 +530,7 @@ static void handle_mousebutton(SDL_Event *ev)
     }
 
     bev = &ev->button;
-    if (!gui_grab && !qemu_input_is_absolute()) {
+    if (!gui_grab && !qemu_input_is_absolute(scon->dcl.con)) {
         if (ev->type == SDL_MOUSEBUTTONUP && bev->button == SDL_BUTTON_LEFT) {
             /* start grabbing all events */
             sdl_grab_start(scon);
@@ -603,7 +603,7 @@ static void handle_windowevent(SDL_Event *ev)
         }
         /* fall through */
     case SDL_WINDOWEVENT_ENTER:
-        if (!gui_grab && (qemu_input_is_absolute() || absolute_enabled)) {
+        if (!gui_grab && (qemu_input_is_absolute(scon->dcl.con) || absolute_enabled)) {
             absolute_mouse_grab(scon);
         }
         /* If a new console window opened using a hotkey receives the
@@ -733,9 +733,9 @@ static void sdl_mouse_warp(DisplayChangeListener *dcl,
         if (!guest_cursor) {
             sdl_show_cursor(scon);
         }
-        if (gui_grab || qemu_input_is_absolute() || absolute_enabled) {
+        if (gui_grab || qemu_input_is_absolute(scon->dcl.con) || absolute_enabled) {
             SDL_SetCursor(guest_sprite);
-            if (!qemu_input_is_absolute() && !absolute_enabled) {
+            if (!qemu_input_is_absolute(scon->dcl.con) && !absolute_enabled) {
                 SDL_WarpMouseInWindow(scon->real_window, x, y);
             }
         }
@@ -773,7 +773,7 @@ static void sdl_mouse_define(DisplayChangeListener *dcl,
         return;
     }
     if (guest_cursor &&
-        (gui_grab || qemu_input_is_absolute() || absolute_enabled)) {
+        (gui_grab || qemu_input_is_absolute(dcl->con) || absolute_enabled)) {
         SDL_SetCursor(guest_sprite);
     }
 }
diff --git a/ui/spice-input.c b/ui/spice-input.c
index bbd502564e..a5c5d78474 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -224,7 +224,7 @@ static const SpiceTabletInterface tablet_interface = {
 static void mouse_mode_notifier(Notifier *notifier, void *data)
 {
     QemuSpicePointer *pointer = container_of(notifier, QemuSpicePointer, mouse_mode);
-    bool is_absolute  = qemu_input_is_absolute();
+    bool is_absolute  = qemu_input_is_absolute(NULL);
 
     if (pointer->absolute == is_absolute) {
         return;
diff --git a/ui/vnc.c b/ui/vnc.c
index 523eb1f5b0..c66477a390 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1771,7 +1771,7 @@ uint32_t read_u32(uint8_t *data, size_t offset)
 static void check_pointer_type_change(Notifier *notifier, void *data)
 {
     VncState *vs = container_of(notifier, VncState, mouse_mode_notifier);
-    int absolute = qemu_input_is_absolute();
+    int absolute = qemu_input_is_absolute(vs->vd->dcl.con);
 
     if (vnc_has_feature(vs, VNC_FEATURE_POINTER_TYPE_CHANGE) && vs->absolute != absolute) {
         vnc_lock_output(vs);
diff --git a/ui/cocoa.m b/ui/cocoa.m
index df6d13be38..145f42d190 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -2001,7 +2001,7 @@ static void cocoa_refresh(DisplayChangeListener *dcl)
     COCOA_DEBUG("qemu_cocoa: cocoa_refresh\n");
     graphic_hw_update(NULL);
 
-    if (qemu_input_is_absolute()) {
+    if (qemu_input_is_absolute(dcl->con)) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (![cocoaView isAbsoluteEnabled]) {
                 if ([cocoaView isMouseGrabbed]) {
diff --git a/ui/trace-events b/ui/trace-events
index 76b19a2995..16c35c9fd6 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -92,7 +92,6 @@ input_event_rel(int conidx, const char *axis, int value) "con %d, axis %s, value
 input_event_abs(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
 input_event_mtt(int conidx, const char *axis, int value) "con %d, axis %s, value 0x%x"
 input_event_sync(void) ""
-input_mouse_mode(int absolute) "absolute %d"
 
 # sdl2-input.c
 sdl2_process_key(int sdl_scancode, int qcode, const char *action) "translated SDL scancode %d to QKeyCode %d (%s)"
-- 
2.41.0


