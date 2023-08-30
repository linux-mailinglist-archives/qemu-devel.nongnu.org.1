Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CD78D4C4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHgt-00066q-6Z; Wed, 30 Aug 2023 05:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgr-0005yx-8k
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHgo-0001Qr-Nj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bTIAERmf90t9c38wK8ugcx/KLvMKafmcJfQQG87nHDw=;
 b=OPq6VvpnXqcmaa+tl27W33CgsWm7hB46iDYnPk4SSaLoJfINjfkG6tyJrn+KmmUuKhB9jF
 +kTD68KSZL5TuFOXJ6dHiN4PCO5sJWuTkyKtR6Dd5S4BMLLKz1NIlbGfO8bScRLs3ZSdii
 X9V9CxQFPyMvK6ZZ42j//dwFLFs0zPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-upsoCY2GMiCIbyU3sSit2Q-1; Wed, 30 Aug 2023 05:40:40 -0400
X-MC-Unique: upsoCY2GMiCIbyU3sSit2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E1828028B2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:40:40 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53DC02166B25;
 Wed, 30 Aug 2023 09:40:38 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 29/67] ui/console: move graphic fields to QemuGraphicConsole
Date: Wed, 30 Aug 2023 13:38:03 +0400
Message-ID: <20230830093843.3531473-30-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move fields specific to graphic console to the console subclass.

qemu_console_get_head() is adapated to accomodate QemuTextConsole, and
always returns 0.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console.c | 110 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 64 insertions(+), 46 deletions(-)

diff --git a/ui/console.c b/ui/console.c
index 335d7ba841..9d884ba02f 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -83,17 +83,10 @@ struct QemuConsole {
     int gl_block;
     QEMUTimer *gl_unblock_timer;
     int window_id;
-
-    /* Graphic console state.  */
-    Object *device;
-    uint32_t head;
     QemuUIInfo ui_info;
     QEMUTimer *ui_timer;
-    QEMUCursor *cursor;
-    int cursor_x, cursor_y, cursor_on;
     const GraphicHwOps *hw_ops;
     void *hw;
-
     CoQueue dump_queue;
 
     QTAILQ_ENTRY(QemuConsole) next;
@@ -103,6 +96,12 @@ OBJECT_DEFINE_ABSTRACT_TYPE(QemuConsole, qemu_console, QEMU_CONSOLE, OBJECT)
 
 typedef struct QemuGraphicConsole {
     QemuConsole parent;
+
+    Object *device;
+    uint32_t head;
+
+    QEMUCursor *cursor;
+    int cursor_x, cursor_y, cursor_on;
 } QemuGraphicConsole;
 
 typedef QemuConsoleClass QemuGraphicConsoleClass;
@@ -1343,31 +1342,14 @@ qemu_console_finalize(Object *obj)
     QemuConsole *c = QEMU_CONSOLE(obj);
 
     /* TODO: check this code path, and unregister from consoles */
-    g_clear_pointer(&c->device, object_unref);
     g_clear_pointer(&c->surface, qemu_free_displaysurface);
     g_clear_pointer(&c->gl_unblock_timer, timer_free);
     g_clear_pointer(&c->ui_timer, timer_free);
 }
 
-static void
-qemu_console_prop_get_head(Object *obj, Visitor *v, const char *name,
-                           void *opaque, Error **errp)
-{
-    QemuConsole *c = QEMU_CONSOLE(obj);
-
-    visit_type_uint32(v, name, &c->head, errp);
-}
-
 static void
 qemu_console_class_init(ObjectClass *oc, void *data)
 {
-    object_class_property_add_link(oc, "device", TYPE_DEVICE,
-                                   offsetof(QemuConsole, device),
-                                   object_property_allow_set_link,
-                                   OBJ_PROP_LINK_STRONG);
-    object_class_property_add(oc, "head", "uint32",
-                              qemu_console_prop_get_head,
-                              NULL, NULL, NULL);
 }
 
 static void
@@ -1387,11 +1369,30 @@ qemu_console_init(Object *obj)
 static void
 qemu_graphic_console_finalize(Object *obj)
 {
+    QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(obj);
+
+    g_clear_pointer(&c->device, object_unref);
+}
+
+static void
+qemu_graphic_console_prop_get_head(Object *obj, Visitor *v, const char *name,
+                                   void *opaque, Error **errp)
+{
+    QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(obj);
+
+    visit_type_uint32(v, name, &c->head, errp);
 }
 
 static void
 qemu_graphic_console_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_link(oc, "device", TYPE_DEVICE,
+                                   offsetof(QemuGraphicConsole, device),
+                                   object_property_allow_set_link,
+                                   OBJ_PROP_LINK_STRONG);
+    object_class_property_add(oc, "head", "uint32",
+                              qemu_graphic_console_prop_get_head,
+                              NULL, NULL, NULL);
 }
 
 static void
@@ -1676,6 +1677,16 @@ void qemu_console_set_display_gl_ctx(QemuConsole *con, DisplayGLCtx *gl)
     con->gl = gl;
 }
 
+static void
+dcl_set_graphic_cursor(DisplayChangeListener *dcl, QemuGraphicConsole *con)
+{
+    if (con && con->cursor && dcl->ops->dpy_cursor_define) {
+        dcl->ops->dpy_cursor_define(dcl, con->cursor);
+    }
+    if (con && dcl->ops->dpy_mouse_set) {
+        dcl->ops->dpy_mouse_set(dcl, con->cursor_x, con->cursor_y, con->cursor_on);
+    }
+}
 void register_displaychangelistener(DisplayChangeListener *dcl)
 {
     QemuConsole *con;
@@ -1693,11 +1704,8 @@ void register_displaychangelistener(DisplayChangeListener *dcl)
         con = active_console;
     }
     displaychangelistener_display_console(dcl, con, dcl->con ? &error_fatal : NULL);
-    if (con && con->cursor && dcl->ops->dpy_cursor_define) {
-        dcl->ops->dpy_cursor_define(dcl, con->cursor);
-    }
-    if (con && dcl->ops->dpy_mouse_set) {
-        dcl->ops->dpy_mouse_set(dcl, con->cursor_x, con->cursor_y, con->cursor_on);
+    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
+        dcl_set_graphic_cursor(dcl, QEMU_GRAPHIC_CONSOLE(con));
     }
     text_console_update_cursor(NULL);
 }
@@ -1728,8 +1736,9 @@ void unregister_displaychangelistener(DisplayChangeListener *dcl)
 static void dpy_set_ui_info_timer(void *opaque)
 {
     QemuConsole *con = opaque;
+    uint32_t head = qemu_console_get_head(con);
 
-    con->hw_ops->ui_info(con->hw, con->head, &con->ui_info);
+    con->hw_ops->ui_info(con->hw, head, &con->ui_info);
 }
 
 bool dpy_ui_info_supported(QemuConsole *con)
@@ -1939,19 +1948,20 @@ void dpy_text_resize(QemuConsole *con, int w, int h)
     }
 }
 
-void dpy_mouse_set(QemuConsole *con, int x, int y, int on)
+void dpy_mouse_set(QemuConsole *c, int x, int y, int on)
 {
-    DisplayState *s = con->ds;
+    QemuGraphicConsole *con = QEMU_GRAPHIC_CONSOLE(c);
+    DisplayState *s = c->ds;
     DisplayChangeListener *dcl;
 
     con->cursor_x = x;
     con->cursor_y = y;
     con->cursor_on = on;
-    if (!qemu_console_is_visible(con)) {
+    if (!qemu_console_is_visible(c)) {
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (c != (dcl->con ? dcl->con : active_console)) {
             continue;
         }
         if (dcl->ops->dpy_mouse_set) {
@@ -1960,18 +1970,19 @@ void dpy_mouse_set(QemuConsole *con, int x, int y, int on)
     }
 }
 
-void dpy_cursor_define(QemuConsole *con, QEMUCursor *cursor)
+void dpy_cursor_define(QemuConsole *c, QEMUCursor *cursor)
 {
-    DisplayState *s = con->ds;
+    QemuGraphicConsole *con = QEMU_GRAPHIC_CONSOLE(c);
+    DisplayState *s = c->ds;
     DisplayChangeListener *dcl;
 
     cursor_unref(con->cursor);
     con->cursor = cursor_ref(cursor);
-    if (!qemu_console_is_visible(con)) {
+    if (!qemu_console_is_visible(c)) {
         return;
     }
     QLIST_FOREACH(dcl, &s->listeners, next) {
-        if (con != (dcl->con ? dcl->con : active_console)) {
+        if (c != (dcl->con ? dcl->con : active_console)) {
             continue;
         }
         if (dcl->ops->dpy_cursor_define) {
@@ -2210,7 +2221,7 @@ QemuConsole *graphic_console_init(DeviceState *dev, uint32_t head,
         trace_console_gfx_new();
         s = (QemuConsole *)object_new(TYPE_QEMU_GRAPHIC_CONSOLE);
     }
-    s->head = head;
+    QEMU_GRAPHIC_CONSOLE(s)->head = head;
     graphic_console_set_hwops(s, hw_ops, opaque);
     if (dev) {
         object_property_set_link(OBJECT(s), "device", OBJECT(dev),
@@ -2328,7 +2339,7 @@ QEMUCursor *qemu_console_get_cursor(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
-    return con ? con->cursor : NULL;
+    return QEMU_IS_GRAPHIC_CONSOLE(con) ? QEMU_GRAPHIC_CONSOLE(con)->cursor : NULL;
 }
 
 bool qemu_console_is_visible(QemuConsole *con)
@@ -2386,21 +2397,22 @@ bool qemu_console_is_multihead(DeviceState *dev)
 char *qemu_console_get_label(QemuConsole *con)
 {
     if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
-        if (con->device) {
+        QemuGraphicConsole *c = QEMU_GRAPHIC_CONSOLE(con);
+        if (c->device) {
             DeviceState *dev;
             bool multihead;
 
-            dev = DEVICE(con->device);
+            dev = DEVICE(c->device);
             multihead = qemu_console_is_multihead(dev);
             if (multihead) {
                 return g_strdup_printf("%s.%d", dev->id ?
                                        dev->id :
-                                       object_get_typename(con->device),
-                                       con->head);
+                                       object_get_typename(c->device),
+                                       c->head);
             } else {
                 return g_strdup_printf("%s", dev->id ?
                                        dev->id :
-                                       object_get_typename(con->device));
+                                       object_get_typename(c->device));
             }
         }
         return g_strdup("VGA");
@@ -2427,7 +2439,13 @@ uint32_t qemu_console_get_head(QemuConsole *con)
     if (con == NULL) {
         con = active_console;
     }
-    return con ? con->head : -1;
+    if (con == NULL) {
+        return -1;
+    }
+    if (QEMU_IS_GRAPHIC_CONSOLE(con)) {
+        return QEMU_GRAPHIC_CONSOLE(con)->head;
+    }
+    return 0;
 }
 
 int qemu_console_get_width(QemuConsole *con, int fallback)
-- 
2.41.0


