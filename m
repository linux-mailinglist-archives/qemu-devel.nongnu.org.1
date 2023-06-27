Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2073FC69
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:07:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MC-0000Db-95; Tue, 27 Jun 2023 09:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M8-0000C7-JS
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M6-0007FI-JK
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=scQHscB/PCF8hJyhi8mmk933j9uIrSnESQbTSbI6TmM=;
 b=Pacqw/lF2yK+b8na52rOQFj/b15IUHZ7CCpc6wrNVdilNs1AWcbZcNMk6pNTSBqPu+47r2
 y57/WkM+78/MN8LpURFcii6nOqq5C9McuMqVo653/OxnpM5rmBEBxk2eIYWSEqcYtMEe9x
 pLmOG2WhBGiosPIEQQVwm3PIoQyDm8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-675-HW93Z6L3OY6jxKmlxnyfIg-1; Tue, 27 Jun 2023 09:03:35 -0400
X-MC-Unique: HW93Z6L3OY6jxKmlxnyfIg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C4E3185A7A7;
 Tue, 27 Jun 2023 13:03:28 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B9CF7111F3B6;
 Tue, 27 Jun 2023 13:03:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 27/33] ui/dbus: add GL support on win32
Date: Tue, 27 Jun 2023 15:02:24 +0200
Message-ID: <20230627130231.1614896-28-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Enable usage of dbus,gl= on win32. At this point, the scanout texture is
read on the DisplaySurface memory, and the client is then updated with
the "2D" API (with shared memory if possible).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-16-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 98 ++++++++++++++++++++++++++++++++--------------
 ui/dbus.c          |  4 --
 2 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index f6b1cd11be..e92eff66e3 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -36,6 +36,9 @@
 #endif
 #include "trace.h"
 
+static void dbus_gfx_switch(DisplayChangeListener *dcl,
+                            struct DisplaySurface *new_surface);
+
 struct _DBusDisplayListener {
     GObject parent;
 
@@ -55,12 +58,28 @@ struct _DBusDisplayListener {
 #ifdef WIN32
     QemuDBusDisplay1ListenerWin32Map *map_proxy;
     HANDLE peer_process;
+#ifdef CONFIG_OPENGL
+    egl_fb fb;
+#endif
 #endif
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
 
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+static void dbus_gfx_update(DisplayChangeListener *dcl,
+                            int x, int y, int w, int h);
+
+#ifdef CONFIG_OPENGL
+static void dbus_scanout_disable(DisplayChangeListener *dcl)
+{
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
+    ddl->ds = NULL;
+    qemu_dbus_display1_listener_call_disable(
+        ddl->proxy, G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+}
+
+#ifdef CONFIG_GBM
 static void dbus_update_gl_cb(GObject *source_object,
                            GAsyncResult *res,
                            gpointer user_data)
@@ -76,29 +95,31 @@ static void dbus_update_gl_cb(GObject *source_object,
     graphic_hw_gl_block(ddl->dcl.con, false);
     g_object_unref(ddl);
 }
+#endif
 
-static void dbus_call_update_gl(DBusDisplayListener *ddl,
+static void dbus_call_update_gl(DisplayChangeListener *dcl,
                                 int x, int y, int w, int h)
 {
-    graphic_hw_gl_block(ddl->dcl.con, true);
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
     glFlush();
+#ifdef CONFIG_GBM
+    graphic_hw_gl_block(ddl->dcl.con, true);
     qemu_dbus_display1_listener_call_update_dmabuf(ddl->proxy,
         x, y, w, h,
         G_DBUS_CALL_FLAGS_NONE,
         DBUS_DEFAULT_TIMEOUT, NULL,
         dbus_update_gl_cb,
         g_object_ref(ddl));
-}
-
-static void dbus_scanout_disable(DisplayChangeListener *dcl)
-{
-    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+#endif
 
-    ddl->ds = NULL;
-    qemu_dbus_display1_listener_call_disable(
-        ddl->proxy, G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
+#ifdef WIN32
+    egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
+    dbus_gfx_update(dcl, x, y, w, h);
+#endif
 }
 
+#ifdef CONFIG_GBM
 static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
                                 QemuDmaBuf *dmabuf)
 {
@@ -127,7 +148,8 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         fd_list,
         NULL, NULL, NULL);
 }
-#endif /* OPENGL & GBM */
+#endif /* GBM */
+#endif /* OPENGL */
 
 #ifdef WIN32
 static bool dbus_scanout_map(DBusDisplayListener *ddl)
@@ -181,7 +203,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
 }
 #endif
 
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+#ifdef CONFIG_OPENGL
 static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t tex_id,
                                  bool backing_y_0_top,
@@ -190,6 +212,7 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t x, uint32_t y,
                                  uint32_t w, uint32_t h)
 {
+#ifdef CONFIG_GBM
     QemuDmaBuf dmabuf = {
         .width = backing_width,
         .height = backing_height,
@@ -212,8 +235,19 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
 
     dbus_scanout_dmabuf(dcl, &dmabuf);
     close(dmabuf.fd);
+#endif
+
+#ifdef WIN32
+    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
+
+    /* there must be a matching gfx_switch before */
+    assert(surface_width(ddl->ds) == w);
+    assert(surface_height(ddl->ds) == h);
+    egl_fb_setup_for_tex(&ddl->fb, backing_width, backing_height, tex_id, false);
+#endif
 }
 
+#ifdef CONFIG_GBM
 static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf, bool have_hot,
                                uint32_t hot_x, uint32_t hot_y)
@@ -260,7 +294,14 @@ static void dbus_cursor_dmabuf(DisplayChangeListener *dcl,
         NULL);
 }
 
-static void dbus_cursor_position(DisplayChangeListener *dcl,
+static void dbus_release_dmabuf(DisplayChangeListener *dcl,
+                                QemuDmaBuf *dmabuf)
+{
+    dbus_scanout_disable(dcl);
+}
+#endif /* GBM */
+
+static void dbus_gl_cursor_position(DisplayChangeListener *dcl,
                                  uint32_t pos_x, uint32_t pos_y)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
@@ -270,19 +311,11 @@ static void dbus_cursor_position(DisplayChangeListener *dcl,
         G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
 }
 
-static void dbus_release_dmabuf(DisplayChangeListener *dcl,
-                                QemuDmaBuf *dmabuf)
-{
-    dbus_scanout_disable(dcl);
-}
-
 static void dbus_scanout_update(DisplayChangeListener *dcl,
                                 uint32_t x, uint32_t y,
                                 uint32_t w, uint32_t h)
 {
-    DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
-
-    dbus_call_update_gl(ddl, x, y, w, h);
+    dbus_call_update_gl(dcl, x, y, w, h);
 }
 
 static void dbus_gl_refresh(DisplayChangeListener *dcl)
@@ -296,19 +329,19 @@ static void dbus_gl_refresh(DisplayChangeListener *dcl)
     }
 
     if (ddl->gl_updates) {
-        dbus_call_update_gl(ddl, 0, 0,
+        dbus_call_update_gl(dcl, 0, 0,
                             surface_width(ddl->ds), surface_height(ddl->ds));
         ddl->gl_updates = 0;
     }
 }
-#endif /* OPENGL & GBM */
+#endif /* OPENGL */
 
 static void dbus_refresh(DisplayChangeListener *dcl)
 {
     graphic_hw_update(dcl->con);
 }
 
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+#ifdef CONFIG_OPENGL
 static void dbus_gl_gfx_update(DisplayChangeListener *dcl,
                                int x, int y, int w, int h)
 {
@@ -382,7 +415,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
         DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
 }
 
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+#ifdef CONFIG_OPENGL
 static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
                                struct DisplaySurface *new_surface)
 {
@@ -452,7 +485,7 @@ static void dbus_cursor_define(DisplayChangeListener *dcl,
         NULL);
 }
 
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+#ifdef CONFIG_OPENGL
 const DisplayChangeListenerOps dbus_gl_dcl_ops = {
     .dpy_name                = "dbus-gl",
     .dpy_gfx_update          = dbus_gl_gfx_update,
@@ -464,10 +497,12 @@ const DisplayChangeListenerOps dbus_gl_dcl_ops = {
 
     .dpy_gl_scanout_disable  = dbus_scanout_disable,
     .dpy_gl_scanout_texture  = dbus_scanout_texture,
+#ifdef CONFIG_GBM
     .dpy_gl_scanout_dmabuf   = dbus_scanout_dmabuf,
     .dpy_gl_cursor_dmabuf    = dbus_cursor_dmabuf,
-    .dpy_gl_cursor_position  = dbus_cursor_position,
     .dpy_gl_release_dmabuf   = dbus_release_dmabuf,
+#endif
+    .dpy_gl_cursor_position  = dbus_gl_cursor_position,
     .dpy_gl_update           = dbus_scanout_update,
 };
 #endif
@@ -493,6 +528,9 @@ dbus_display_listener_dispose(GObject *object)
 #ifdef WIN32
     g_clear_object(&ddl->map_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
+#ifdef CONFIG_OPENGL
+    egl_fb_destroy(&ddl->fb);
+#endif
 #endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
@@ -504,7 +542,7 @@ dbus_display_listener_constructed(GObject *object)
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(object);
 
     ddl->dcl.ops = &dbus_dcl_ops;
-#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
+#ifdef CONFIG_OPENGL
     if (display_opengl) {
         ddl->dcl.ops = &dbus_gl_dcl_ops;
     }
diff --git a/ui/dbus.c b/ui/dbus.c
index b9e9698503..32f1bbe81a 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -47,10 +47,8 @@ static DBusDisplay *dbus_display;
 static QEMUGLContext dbus_create_context(DisplayGLCtx *dgc,
                                          QEMUGLParams *params)
 {
-#ifdef CONFIG_GBM
     eglMakeCurrent(qemu_egl_display, EGL_NO_SURFACE, EGL_NO_SURFACE,
                    qemu_egl_rn_ctx);
-#endif
     return qemu_egl_create_context(dgc, params);
 }
 
@@ -59,9 +57,7 @@ dbus_is_compatible_dcl(DisplayGLCtx *dgc,
                        DisplayChangeListener *dcl)
 {
     return
-#ifdef CONFIG_GBM
         dcl->ops == &dbus_gl_dcl_ops ||
-#endif
         dcl->ops == &dbus_console_dcl_ops;
 }
 
-- 
2.41.0


