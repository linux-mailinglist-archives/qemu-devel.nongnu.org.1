Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAA07241B6
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 14:09:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6VLn-0002s8-Be; Tue, 06 Jun 2023 07:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKp-0002AT-OC
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1q6VKn-00066m-Pg
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 07:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686052725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1OF6AEMh1f7El4f9uozuS1VUiwrPcrvTuL5DG6TZxCg=;
 b=DaxxICJ5UFa+bUfJ4XPdcX17PWTmkgG6eguGJajp/8AZOi6ZPgYY/4Ij409PkWes8R+bM7
 2io962cyUi6J5sVo4ynC4ufD64ADRpshcrO2gKVap2l7XXnNKXimh6j04pc6B0QkJp6IIN
 4+iAslCTL4hzZ1okUwaAg1+PnUfkrmo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-EbkKljz6NFCJYLAID6bVxw-1; Tue, 06 Jun 2023 07:58:43 -0400
X-MC-Unique: EbkKljz6NFCJYLAID6bVxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5549B3C025A2
 for <qemu-devel@nongnu.org>; Tue,  6 Jun 2023 11:58:43 +0000 (UTC)
Received: from localhost (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFE9240336F;
 Tue,  6 Jun 2023 11:58:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 19/21] ui: add optional d3d texture pointer to scanout texture
Date: Tue,  6 Jun 2023 15:56:56 +0400
Message-Id: <20230606115658.677673-20-marcandre.lureau@redhat.com>
In-Reply-To: <20230606115658.677673-1-marcandre.lureau@redhat.com>
References: <20230606115658.677673-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following patch will get the underlying D3D11 Texture2D from the
virgl renderer scanout. Pass it along to the texture scanout callbacks
as a priliminary step, to simplify review.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h          |  7 +++++--
 include/ui/gtk.h              |  6 ++++--
 include/ui/sdl2.h             |  3 ++-
 hw/display/virtio-gpu-virgl.c |  4 +++-
 ui/console.c                  | 11 +++++++----
 ui/dbus-console.c             |  3 ++-
 ui/dbus-listener.c            |  5 +++--
 ui/egl-headless.c             |  5 +++--
 ui/gtk-egl.c                  |  5 +++--
 ui/gtk-gl-area.c              |  5 +++--
 ui/sdl2-gl.c                  |  3 ++-
 ui/spice-display.c            |  3 ++-
 12 files changed, 39 insertions(+), 21 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0fd2692110..a54742fc25 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -117,6 +117,7 @@ typedef struct ScanoutTexture {
     uint32_t y;
     uint32_t width;
     uint32_t height;
+    void *d3d_tex2d;
 } ScanoutTexture;
 
 typedef struct DisplaySurface {
@@ -255,7 +256,8 @@ typedef struct DisplayChangeListenerOps {
                                    uint32_t backing_width,
                                    uint32_t backing_height,
                                    uint32_t x, uint32_t y,
-                                   uint32_t w, uint32_t h);
+                                   uint32_t w, uint32_t h,
+                                   void *d3d_tex2d);
     /* optional (default to true if has dpy_gl_scanout_dmabuf) */
     bool (*dpy_has_dmabuf)(DisplayChangeListener *dcl);
     /* optional */
@@ -363,7 +365,8 @@ void dpy_gl_scanout_disable(QemuConsole *con);
 void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
-                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
+                            uint32_t x, uint32_t y, uint32_t w, uint32_t h,
+                            void *d3d_tex2d);
 void dpy_gl_scanout_dmabuf(QemuConsole *con,
                            QemuDmaBuf *dmabuf);
 void dpy_gl_cursor_dmabuf(QemuConsole *con, QemuDmaBuf *dmabuf,
diff --git a/include/ui/gtk.h b/include/ui/gtk.h
index ae0f53740d..aa3d637029 100644
--- a/include/ui/gtk.h
+++ b/include/ui/gtk.h
@@ -175,7 +175,8 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_width,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
-                            uint32_t w, uint32_t h);
+                            uint32_t w, uint32_t h,
+                            void *d3d_tex2d);
 void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
                            QemuDmaBuf *dmabuf);
 void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
@@ -211,7 +212,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_width,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
-                                uint32_t w, uint32_t h);
+                                uint32_t w, uint32_t h,
+                                void *d3d_tex2d);
 void gd_gl_area_scanout_disable(DisplayChangeListener *dcl);
 void gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
                               uint32_t x, uint32_t y, uint32_t w, uint32_t h);
diff --git a/include/ui/sdl2.h b/include/ui/sdl2.h
index 8fb7e08262..e3acc7c82a 100644
--- a/include/ui/sdl2.h
+++ b/include/ui/sdl2.h
@@ -90,7 +90,8 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_width,
                              uint32_t backing_height,
                              uint32_t x, uint32_t y,
-                             uint32_t w, uint32_t h);
+                             uint32_t w, uint32_t h,
+                             void *d3d_tex2d);
 void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
                            uint32_t x, uint32_t y, uint32_t w, uint32_t h);
 
diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
index 9831c482e5..8fa9809371 100644
--- a/hw/display/virtio-gpu-virgl.c
+++ b/hw/display/virtio-gpu-virgl.c
@@ -154,6 +154,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
 {
     struct virtio_gpu_set_scanout ss;
     struct virgl_renderer_resource_info info;
+    void *d3d_tex2d = NULL;
     int ret;
 
     VIRTIO_GPU_FILL_CMD(ss);
@@ -186,7 +187,8 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
             g->parent_obj.scanout[ss.scanout_id].con, info.tex_id,
             info.flags & VIRTIO_GPU_RESOURCE_FLAG_Y_0_TOP,
             info.width, info.height,
-            ss.r.x, ss.r.y, ss.r.width, ss.r.height);
+            ss.r.x, ss.r.y, ss.r.width, ss.r.height,
+            d3d_tex2d);
     } else {
         dpy_gfx_replace_surface(
             g->parent_obj.scanout[ss.scanout_id].con, NULL);
diff --git a/ui/console.c b/ui/console.c
index 2b53c64ef0..c1c03845e7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1223,7 +1223,8 @@ static void displaychangelistener_display_console(DisplayChangeListener *dcl,
                                          con->scanout.texture.x,
                                          con->scanout.texture.y,
                                          con->scanout.texture.width,
-                                         con->scanout.texture.height);
+                                         con->scanout.texture.height,
+                                         con->scanout.texture.d3d_tex2d);
     }
 }
 
@@ -2050,7 +2051,8 @@ void dpy_gl_scanout_texture(QemuConsole *con,
                             uint32_t backing_width,
                             uint32_t backing_height,
                             uint32_t x, uint32_t y,
-                            uint32_t width, uint32_t height)
+                            uint32_t width, uint32_t height,
+                            void *d3d_tex2d)
 {
     DisplayState *s = con->ds;
     DisplayChangeListener *dcl;
@@ -2058,7 +2060,7 @@ void dpy_gl_scanout_texture(QemuConsole *con,
     con->scanout.kind = SCANOUT_TEXTURE;
     con->scanout.texture = (ScanoutTexture) {
         backing_id, backing_y_0_top, backing_width, backing_height,
-        x, y, width, height
+        x, y, width, height, d3d_tex2d,
     };
     QLIST_FOREACH(dcl, &s->listeners, next) {
         if (con != (dcl->con ? dcl->con : active_console)) {
@@ -2068,7 +2070,8 @@ void dpy_gl_scanout_texture(QemuConsole *con,
             dcl->ops->dpy_gl_scanout_texture(dcl, backing_id,
                                              backing_y_0_top,
                                              backing_width, backing_height,
-                                             x, y, width, height);
+                                             x, y, width, height,
+                                             d3d_tex2d);
         }
     }
 }
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 2f4d3439d1..98599073e8 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -95,7 +95,8 @@ dbus_gl_scanout_texture(DisplayChangeListener *dcl,
                         uint32_t backing_width,
                         uint32_t backing_height,
                         uint32_t x, uint32_t y,
-                        uint32_t w, uint32_t h)
+                        uint32_t w, uint32_t h,
+                        void *d3d_tex2d)
 {
     DBusDisplayConsole *ddc = container_of(dcl, DBusDisplayConsole, dcl);
 
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 8605dffd8a..80c0fca9df 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -212,7 +212,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t backing_width,
                                  uint32_t backing_height,
                                  uint32_t x, uint32_t y,
-                                 uint32_t w, uint32_t h)
+                                 uint32_t w, uint32_t h,
+                                 void *d3d_tex2d)
 {
     trace_dbus_scanout_texture(tex_id, backing_y_0_top,
                                backing_width, backing_height, x, y, w, h);
@@ -434,7 +435,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
 
         /* TODO: lazy send dmabuf (there are unnecessary sent otherwise) */
         dbus_scanout_texture(&ddl->dcl, ddl->ds->texture, false,
-                             width, height, 0, 0, width, height);
+                             width, height, 0, 0, width, height, NULL);
     }
 }
 #endif
diff --git a/ui/egl-headless.c b/ui/egl-headless.c
index e4177206f2..d5637dadb2 100644
--- a/ui/egl-headless.c
+++ b/ui/egl-headless.c
@@ -61,7 +61,8 @@ static void egl_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_width,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
-                                uint32_t w, uint32_t h)
+                                uint32_t w, uint32_t h,
+                                void *d3d_tex2d)
 {
     egl_dpy *edpy = container_of(dcl, egl_dpy, dcl);
 
@@ -91,7 +92,7 @@ static void egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     egl_scanout_texture(dcl, dmabuf->texture,
                         false, dmabuf->width, dmabuf->height,
-                        0, 0, dmabuf->width, dmabuf->height);
+                        0, 0, dmabuf->width, dmabuf->height, NULL);
 }
 
 static void egl_cursor_dmabuf(DisplayChangeListener *dcl,
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index f8b5901ce9..add99e9059 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -223,7 +223,8 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
                             uint32_t backing_id, bool backing_y_0_top,
                             uint32_t backing_width, uint32_t backing_height,
                             uint32_t x, uint32_t y,
-                            uint32_t w, uint32_t h)
+                            uint32_t w, uint32_t h,
+                            void *d3d_tex2d)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
@@ -257,7 +258,7 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
                            dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           0, 0, dmabuf->width, dmabuf->height);
+                           0, 0, dmabuf->width, dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index c384a1516b..5beab028e2 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -244,7 +244,8 @@ void gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
                                 uint32_t backing_width,
                                 uint32_t backing_height,
                                 uint32_t x, uint32_t y,
-                                uint32_t w, uint32_t h)
+                                uint32_t w, uint32_t h,
+                                void *d3d_tex2d)
 {
     VirtualConsole *vc = container_of(dcl, VirtualConsole, gfx.dcl);
 
@@ -299,7 +300,7 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
                                dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               0, 0, dmabuf->width, dmabuf->height);
+                               0, 0, dmabuf->width, dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
index bbfa70eac3..28d796607c 100644
--- a/ui/sdl2-gl.c
+++ b/ui/sdl2-gl.c
@@ -205,7 +205,8 @@ void sdl2_gl_scanout_texture(DisplayChangeListener *dcl,
                              uint32_t backing_width,
                              uint32_t backing_height,
                              uint32_t x, uint32_t y,
-                             uint32_t w, uint32_t h)
+                             uint32_t w, uint32_t h,
+                             void *d3d_tex2d)
 {
     struct sdl2_console *scon = container_of(dcl, struct sdl2_console, dcl);
 
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 5bee19a7f9..3f3f8013d8 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -935,7 +935,8 @@ static void qemu_spice_gl_scanout_texture(DisplayChangeListener *dcl,
                                           uint32_t backing_width,
                                           uint32_t backing_height,
                                           uint32_t x, uint32_t y,
-                                          uint32_t w, uint32_t h)
+                                          uint32_t w, uint32_t h,
+                                          void *d3d_tex2d)
 {
     SimpleSpiceDisplay *ssd = container_of(dcl, SimpleSpiceDisplay, dcl);
     EGLint stride = 0, fourcc = 0;
-- 
2.40.1


