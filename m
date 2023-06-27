Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98F73FC67
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M4-00008E-4Y; Tue, 27 Jun 2023 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M0-00006S-8P
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lu-000784-Qp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSf+vPDsprnMcbXmLXdIhBJEkOI9m2QLEwt8b0AU6/w=;
 b=LHDrYW8+3bG6NSZnpWEDmXF3j/67QkuNmmAGfKyQ5ObQsJt6LrjbMYKb/mZKUegb4N5r8g
 pPuJr2Ftpui/UXgVWwgtX8Gi03/Q4D3jRC96MDvKKgqZ05wveybXRqybUQoqPag7jo2t8L
 QtOts3503cE4fhCeKmKNMPlJaWnldvM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-uzcaYi13NO6I8RAgdSun-Q-1; Tue, 27 Jun 2023 09:03:23 -0400
X-MC-Unique: uzcaYi13NO6I8RAgdSun-Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C13101C07241;
 Tue, 27 Jun 2023 13:03:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4CDFC400F5A;
 Tue, 27 Jun 2023 13:03:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 24/33] ui: add egl-headless support on win32
Date: Tue, 27 Jun 2023 15:02:21 +0200
Message-ID: <20230627130231.1614896-25-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
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

Make GBM optional for EGL code, and enable the build for win32.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-13-marcandre.lureau@redhat.com>
---
 qapi/ui.json             |  5 ++---
 include/ui/egl-helpers.h |  7 ++++++-
 ui/egl-headless.c        | 20 +++++++++++++-------
 ui/egl-helpers.c         | 38 +++++++++++++++++++++++++++++++-------
 ui/meson.build           |  6 +++---
 5 files changed, 55 insertions(+), 21 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 2755395483..bb06fb6039 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -1484,8 +1484,7 @@
     { 'name': 'none' },
     { 'name': 'gtk', 'if': 'CONFIG_GTK' },
     { 'name': 'sdl', 'if': 'CONFIG_SDL' },
-    { 'name': 'egl-headless',
-              'if': { 'all': ['CONFIG_OPENGL', 'CONFIG_GBM'] } },
+    { 'name': 'egl-headless', 'if': 'CONFIG_OPENGL' },
     { 'name': 'curses', 'if': 'CONFIG_CURSES' },
     { 'name': 'cocoa', 'if': 'CONFIG_COCOA' },
     { 'name': 'spice-app', 'if': 'CONFIG_SPICE' },
@@ -1525,7 +1524,7 @@
       'cocoa': { 'type': 'DisplayCocoa', 'if': 'CONFIG_COCOA' },
       'curses': { 'type': 'DisplayCurses', 'if': 'CONFIG_CURSES' },
       'egl-headless': { 'type': 'DisplayEGLHeadless',
-                        'if': { 'all': ['CONFIG_OPENGL', 'CONFIG_GBM'] } },
+                        'if': 'CONFIG_OPENGL' },
       'dbus': { 'type': 'DisplayDBus', 'if': 'CONFIG_DBUS_DISPLAY' },
       'sdl': { 'type': 'DisplaySDL', 'if': 'CONFIG_SDL' }
   }
diff --git a/include/ui/egl-helpers.h b/include/ui/egl-helpers.h
index 2cf6633ad2..6c4eb5dd70 100644
--- a/include/ui/egl-helpers.h
+++ b/include/ui/egl-helpers.h
@@ -36,11 +36,12 @@ void egl_texture_blit(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip);
 void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
                        int x, int y, double scale_x, double scale_y);
 
+extern EGLContext qemu_egl_rn_ctx;
+
 #ifdef CONFIG_GBM
 
 extern int qemu_egl_rn_fd;
 extern struct gbm_device *qemu_egl_rn_gbm_dev;
-extern EGLContext qemu_egl_rn_ctx;
 
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode);
 int egl_get_fd_for_texture(uint32_t tex_id, EGLint *stride, EGLint *fourcc,
@@ -62,6 +63,10 @@ int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode);
 
 #endif
 
+#ifdef WIN32
+int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode);
+#endif
+
 EGLContext qemu_egl_init_ctx(void);
 bool qemu_egl_has_dmabuf(void);
 
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index ef70e6a18e..e4177206f2 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -79,6 +79,8 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
     }
 }
 
+#ifdef CONFIG_GBM
+
 static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
                                QemuDmaBuf *dmabuf)
 {
@@ -110,6 +112,14 @@ static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
     }
 }
 
+static void egl_release_dmabuf(DisplayChangeListener *dcl,
+                               QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_release_texture(dmabuf);
+}
+
+#endif
+
 static void egl_cursor_position(DisplayChangeListener *dcl,
                                 uint32_t pos_x, uint32_t pos_y)
 {
@@ -119,12 +129,6 @@ static void egl_cursor_position(DisplayChangeListener *dcl,
     edpy->pos_y = pos_y;
 }
 
-static void egl_release_dmabuf(DisplayChangeListener *dcl,
-                               QemuDmaBuf *dmabuf)
-{
-    egl_dmabuf_release_texture(dmabuf);
-}
-
 static void egl_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y,
                               uint32_t w, uint32_t h)
@@ -160,10 +164,12 @@ static const DisplayChangeListenerOps egl_ops = {
 
     .dpy_gl_scanout_disable  = egl_scanout_disable,
     .dpy_gl_scanout_texture  = egl_scanout_texture,
+#ifdef CONFIG_GBM
     .dpy_gl_scanout_dmabuf   = egl_scanout_dmabuf,
     .dpy_gl_cursor_dmabuf    = egl_cursor_dmabuf,
-    .dpy_gl_cursor_position  = egl_cursor_position,
     .dpy_gl_release_dmabuf   = egl_release_dmabuf,
+#endif
+    .dpy_gl_cursor_position  = egl_cursor_position,
     .dpy_gl_update           = egl_scanout_flush,
 };
 
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 26d43e0213..d1ef3c07dd 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -199,11 +199,12 @@ void egl_texture_blend(QemuGLShader *gls, egl_fb *dst, egl_fb *src, bool flip,
 
 /* ---------------------------------------------------------------------- */
 
+EGLContext qemu_egl_rn_ctx;
+
 #ifdef CONFIG_GBM
 
 int qemu_egl_rn_fd;
 struct gbm_device *qemu_egl_rn_gbm_dev;
-EGLContext qemu_egl_rn_ctx;
 
 int egl_rendernode_init(const char *rendernode, DisplayGLMode mode)
 {
@@ -400,7 +401,7 @@ EGLSurface qemu_egl_init_surface_x11(EGLContext ectx, EGLNativeWindowType win)
 
 /* ---------------------------------------------------------------------- */
 
-#if defined(CONFIG_X11) || defined(CONFIG_GBM)
+#if defined(CONFIG_X11) || defined(CONFIG_GBM) || defined(WIN32)
 
 /*
  * Taken from glamor_egl.h from the Xorg xserver, which is MIT licensed
@@ -508,6 +509,9 @@ static int qemu_egl_init_dpy(EGLNativeDisplayType dpy,
     return 0;
 }
 
+#endif
+
+#if defined(CONFIG_X11) || defined(CONFIG_GBM)
 int qemu_egl_init_dpy_x11(EGLNativeDisplayType dpy, DisplayGLMode mode)
 {
 #ifdef EGL_KHR_platform_x11
@@ -525,7 +529,14 @@ int qemu_egl_init_dpy_mesa(EGLNativeDisplayType dpy, DisplayGLMode mode)
     return qemu_egl_init_dpy(dpy, 0, mode);
 #endif
 }
+#endif
+
 
+#ifdef WIN32
+int qemu_egl_init_dpy_win32(EGLNativeDisplayType dpy, DisplayGLMode mode)
+{
+    return qemu_egl_init_dpy(dpy, 0, mode);
+}
 #endif
 
 bool qemu_egl_has_dmabuf(void)
@@ -577,15 +588,28 @@ bool egl_init(const char *rendernode, DisplayGLMode mode, Error **errp)
         return false;
     }
 
-#ifdef CONFIG_GBM
+#ifdef WIN32
+    if (qemu_egl_init_dpy_win32(EGL_DEFAULT_DISPLAY, mode) < 0) {
+        error_setg(errp, "egl: init failed");
+        return false;
+    }
+    qemu_egl_rn_ctx = qemu_egl_init_ctx();
+    if (!qemu_egl_rn_ctx) {
+        error_setg(errp, "egl: egl_init_ctx failed");
+        return false;
+    }
+#elif defined(CONFIG_GBM)
     if (egl_rendernode_init(rendernode, mode) < 0) {
         error_setg(errp, "egl: render node init failed");
         return false;
     }
+#endif
+
+    if (!qemu_egl_rn_ctx) {
+        error_setg(errp, "egl: not available on this platform");
+        return false;
+    }
+
     display_opengl = 1;
     return true;
-#else
-    error_setg(errp, "egl: not available on this platform");
-    return false;
-#endif
 }
diff --git a/ui/meson.build b/ui/meson.build
index d84650676d..d81609fb0e 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -65,10 +65,10 @@ if opengl.found()
   ui_modules += {'opengl' : opengl_ss}
 endif
 
-if opengl.found() and gbm.found()
+if opengl.found()
   egl_headless_ss = ss.source_set()
-  egl_headless_ss.add(when: [opengl, gbm, pixman],
-                      if_true: files('egl-headless.c'))
+  egl_headless_ss.add(when: [opengl, pixman],
+                      if_true: [files('egl-headless.c'), gbm])
   ui_modules += {'egl-headless' : egl_headless_ss}
 endif
 
-- 
2.41.0


