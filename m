Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B836A250CE
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 00:27:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tejMe-0002cp-KW; Sun, 02 Feb 2025 18:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejMd-0002cf-3C
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:26:55 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1tejMb-0003Uh-9n
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 18:26:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1738538800; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PQCn2wLqdow1X7Q7DDP/9krNbEAeu41Hz3lZai8a62/HQ+d73fAPq6b4PohitUiOOZs/NWnR2A1rvZb2Ba6NmGa7R2MAI+61S5AJcXpurvYaVI2dSk52RIBlzBRJvlFbwlYXb0FvbqL1QXvU7QDYcynA28X2ic6Z008q2622Oj8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1738538800;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1NZDSwhq21XaXynGqtkU4T2OCkT8KctMjwLACTsQcaA=; 
 b=N0CR8NV7L0OEuMr59LOtoWfrJUI2spFFWDx0BfTIGYMbkKUmzBzK1SJECgITHfdQvsJXPIbBaKu8ZfRKCsv089dOQIHmYabB7HflFK2vH5TwgClAKW9gErIEx8k5/DfQLjfVBn4DihPnWIjvUhLrVRk9jJ+RoU7OTOWU8ZjbxiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738538800; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1NZDSwhq21XaXynGqtkU4T2OCkT8KctMjwLACTsQcaA=;
 b=LEeHxTKFHxTomwyBcogEg6tFkXPfeR1hwAyn8hul9eVFYRRYouh2oxlNysLIxMm6
 M2S4vYI+seZsuvHnvjuPwxXMUYbnPkQc2KDyv11scEl+IJ6yRniPOIGeesS5Z58bMIT
 hrExYIdccpjPr35QYU3T8nbFyQYmXAzaADYMeldg=
Received: by mx.zohomail.com with SMTPS id 1738538796106959.9064949324907;
 Sun, 2 Feb 2025 15:26:36 -0800 (PST)
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
Subject: [PATCH v7 02/10] ui/sdl2: Implement dpy dmabuf functions
Date: Mon,  3 Feb 2025 02:21:28 +0300
Message-ID: <20250202232136.919342-3-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
References: <20250202232136.919342-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

If EGL is used, we can rely on dmabuf to import textures without
doing copies.

To get this working on X11, we use the existing SDL hint:
SDL_HINT_VIDEO_X11_FORCE_EGL (because dmabuf can't be used with GLX).

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/ui/sdl2.h |  7 ++++++
 meson.build       |  6 ++---
 ui/sdl2-gl.c      | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 ui/sdl2.c         | 42 +++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 4 deletions(-)

diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index dbe6e3d9739b..9daf5ecffae7 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -45,6 +45,7 @@ struct sdl2_console {
     bool gui_keysym;
     SDL_GLContext winctx;
     QKbdState *kbd;
+    bool has_dmabuf;
 #ifdef CONFIG_OPENGL
     QemuGLShader *gls;
     egl_fb guest_fb;
@@ -96,5 +97,11 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              void *d3d_tex2d);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf);
+bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl);
+void sdl2_gl_console_init(struct sdl2_console *scon);
 
 #endif /* SDL2_H */
diff --git a/meson.build b/meson.build
index 2c9ac9cfe1e9..dce01783ccf3 100644
--- a/meson.build
+++ b/meson.build
@@ -1964,10 +1964,8 @@ if get_option('gtk') \
   endif
 endif
 
-x11 = not_found
-if gtkx11.found()
-  x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
-endif
+x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
+
 png = not_found
 if get_option('png').allowed() and have_system
    png = dependency('libpng', version: '>=1.6.34', required: get_option('png'),
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index b1fe96d6af22..8d53e340d40d 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -26,6 +26,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/input.h"
 #include "ui/sdl2.h"
@@ -249,3 +251,65 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
 
     SDL_GL_SwapWindow(scon->real_window);
 }
+
+void sdl2_gl_scanout_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf)
+{
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    assert(scon->opengl);
+    SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
+
+    egl_dmabuf_import_texture(dmabuf);
+    if (!qemu_dmabuf_get_texture(dmabuf)) {
+        error_report("%s: failed fd=%d", __func__, qemu_dmabuf_get_fd(dmabuf));
+        return;
+    }
+
+    sdl2_gl_scanout_texture(dcl, qemu_dmabuf_get_texture(dmabuf), false,
+                            qemu_dmabuf_get_width(dmabuf),
+                            qemu_dmabuf_get_height(dmabuf),
+                            0, 0,
+                            qemu_dmabuf_get_width(dmabuf),
+                            qemu_dmabuf_get_height(dmabuf),
+                            NULL);
+
+    if (qemu_dmabuf_get_allow_fences(dmabuf)) {
+        scon->guest_fb.dmabuf = dmabuf;
+    }
+}
+
+void sdl2_gl_release_dmabuf(DisplayChangeListener *dcl,
+                            QemuDmaBuf *dmabuf)
+{
+    egl_dmabuf_release_texture(dmabuf);
+}
+
+bool sdl2_gl_has_dmabuf(DisplayChangeListener *dcl)
+{
+    struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
+
+    return scon->has_dmabuf;
+}
+
+void sdl2_gl_console_init(struct sdl2_console *scon)
+{
+    bool hidden = scon->hidden;
+
+    scon->hidden = true;
+    scon->surface = qemu_create_displaysurface(1, 1);
+    sdl2_window_create(scon);
+
+    /*
+     * QEMU checks whether console supports dma-buf before switching
+     * to the console.  To break this chicken-egg problem we pre-check
+     * dma-buf availability beforehand using a dummy SDL window.
+     */
+    scon->has_dmabuf = qemu_egl_has_dmabuf();
+
+    sdl2_window_destroy(scon);
+    qemu_free_displaysurface(scon->surface);
+
+    scon->surface = NULL;
+    scon->hidden = hidden;
+}
diff --git a/ui/sdl2.c b/ui/sdl2.c
index 445eb1dd9f9a..3e262b994231 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -36,6 +36,10 @@
 #include "qemu/log.h"
 #include "qemu-main.h"
 
+#ifdef CONFIG_X11
+#include <X11/Xlib.h>
+#endif
+
 static int sdl2_num_outputs;
 static struct sdl2_console *sdl2_console;
 
@@ -121,6 +125,9 @@ void sdl2_window_create(struct sdl2_console *scon)
         /* The SDL renderer is only used by sdl2-2D, when OpenGL is disabled */
         scon->real_renderer = SDL_CreateRenderer(scon->real_window, -1, 0);
     }
+
+    qemu_egl_display = eglGetCurrentDisplay();
+
     sdl_update_caption(scon);
 }
 
@@ -821,6 +828,10 @@ static const DisplayChangeListenerOps dcl_gl_ops = {
     .dpy_gl_scanout_disable  = sdl2_gl_scanout_disable,
     .dpy_gl_scanout_texture  = sdl2_gl_scanout_texture,
     .dpy_gl_update           = sdl2_gl_scanout_flush,
+
+    .dpy_gl_scanout_dmabuf   = sdl2_gl_scanout_dmabuf,
+    .dpy_gl_release_dmabuf   = sdl2_gl_release_dmabuf,
+    .dpy_has_dmabuf          = sdl2_gl_has_dmabuf,
 };
 
 static bool
@@ -848,6 +859,35 @@ static void sdl2_display_early_init(DisplayOptions *o)
     }
 }
 
+static void sdl2_set_hint_x11_force_egl(void)
+{
+#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL) && \
+    defined(CONFIG_X11)
+    Display *x_disp = XOpenDisplay(NULL);
+    EGLDisplay egl_display;
+
+    if (!x_disp) {
+        return;
+    }
+
+    /* Prefer EGL over GLX to get dma-buf support. */
+    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
+
+    if (egl_display != EGL_NO_DISPLAY) {
+        /*
+         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer X11 over
+         * Wayland. SDL will use Wayland driver even if XWayland presents.
+         * It's always safe to set the hint even if X11 is not used by SDL.
+         * SDL will work regardless of the hint.
+         */
+        SDL_SetHint(SDL_HINT_VIDEO_X11_FORCE_EGL, "1");
+        eglTerminate(egl_display);
+    }
+
+    XCloseDisplay(x_disp);
+#endif
+}
+
 static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
     uint8_t data = 0;
@@ -878,6 +918,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
     SDL_SetHint(SDL_HINT_ALLOW_ALT_TAB_WHILE_GRABBED, "0");
 #endif
     SDL_SetHint(SDL_HINT_WINDOWS_NO_CLOSE_ON_ALT_F4, "1");
+    sdl2_set_hint_x11_force_egl();
     SDL_EnableScreenSaver();
     memset(&info, 0, sizeof(info));
     SDL_VERSION(&info.version);
@@ -924,6 +965,7 @@ static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
         sdl2_console[i].kbd = qkbd_state_init(con);
         if (display_opengl) {
             qemu_console_set_display_gl_ctx(con, &sdl2_console[i].dgc);
+            sdl2_gl_console_init(&sdl2_console[i]);
         }
         register_displaychangelistener(&sdl2_console[i].dcl);
 
-- 
2.47.1


