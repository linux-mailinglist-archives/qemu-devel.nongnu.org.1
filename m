Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A35756375
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNcU-0005zo-EN; Mon, 17 Jul 2023 08:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcI-0005js-N8
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qLNcF-0008G3-Tc
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:46:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689597975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIytHURs/QEdgu0hfWQD43vbrrPmr96KHEM9sueWxJ0=;
 b=f/QUtZMUXG/FB/mEeKUqzHDB3HFCc65U9s8tR1s8QrsBrFsEavESKYcxTKudpoJtT6meDF
 1jLwj8jfj9QkqQHiFW0KWPzxi5tThhnoc1TW88NOR3Ler0H4yjcoe2b4Md9LpRZQxyfRQZ
 0ZobQ6BRc4Sq5U3Uu7XY/dQKYRBBt+E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-1EJYVD4wPXig_5rtBmcEOA-1; Mon, 17 Jul 2023 08:46:12 -0400
X-MC-Unique: 1EJYVD4wPXig_5rtBmcEOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 935D1805951;
 Mon, 17 Jul 2023 12:46:11 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DB7140C2063;
 Mon, 17 Jul 2023 12:46:09 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PULL 05/19] virtio-gpu-udmabuf: correct naming of QemuDmaBuf size
 properties
Date: Mon, 17 Jul 2023 16:45:30 +0400
Message-ID: <20230717124545.177236-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230717124545.177236-1-marcandre.lureau@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Dongwon Kim <dongwon.kim@intel.com>

Replace 'width' and 'height' in QemuDmaBuf with 'backing_widht'
and 'backing_height' as these commonly indicate the size of the
whole surface (e.g. guest's Xorg extended display). Then use
'width' and 'height' for sub region in there (e.g. guest's
scanouts).

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20230713040444.32267-1-dongwon.kim@intel.com>
---
 include/ui/console.h            |  4 ++--
 hw/display/virtio-gpu-udmabuf.c | 12 ++++++------
 ui/dbus-listener.c              |  8 ++++----
 ui/egl-helpers.c                |  8 ++++----
 ui/gtk-egl.c                    | 10 ++++++----
 ui/gtk-gl-area.c                |  7 ++++---
 6 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f27b2aad4f..3e8b22d6c6 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -201,8 +201,8 @@ typedef struct QemuDmaBuf {
     uint32_t  texture;
     uint32_t  x;
     uint32_t  y;
-    uint32_t  scanout_width;
-    uint32_t  scanout_height;
+    uint32_t  backing_width;
+    uint32_t  backing_height;
     bool      y0_top;
     void      *sync;
     int       fence_fd;
diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index ef1a740de5..d51184d658 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -181,13 +181,13 @@ static VGPUDMABuf
     }
 
     dmabuf = g_new0(VGPUDMABuf, 1);
-    dmabuf->buf.width = fb->width;
-    dmabuf->buf.height = fb->height;
+    dmabuf->buf.width = r->width;
+    dmabuf->buf.height = r->height;
     dmabuf->buf.stride = fb->stride;
     dmabuf->buf.x = r->x;
     dmabuf->buf.y = r->y;
-    dmabuf->buf.scanout_width = r->width;
-    dmabuf->buf.scanout_height = r->height;
+    dmabuf->buf.backing_width = fb->width;
+    dmabuf->buf.backing_height = fb->height;
     dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
     dmabuf->buf.fd = res->dmabuf_fd;
     dmabuf->buf.allow_fences = true;
@@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 
     g->dmabuf.primary[scanout_id] = new_primary;
     qemu_console_resize(scanout->con,
-                        new_primary->buf.scanout_width,
-                        new_primary->buf.scanout_height);
+                        new_primary->buf.width,
+                        new_primary->buf.height);
     dpy_gl_scanout_dmabuf(scanout->con, &new_primary->buf);
 
     if (old_primary) {
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 0240c39510..68ff343799 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -415,13 +415,13 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                backing_width, backing_height, x, y, w, h);
 #ifdef CONFIG_GBM
     QemuDmaBuf dmabuf = {
-        .width = backing_width,
-        .height = backing_height,
+        .width = w,
+        .height = h,
         .y0_top = backing_y_0_top,
         .x = x,
         .y = y,
-        .scanout_width = w,
-        .scanout_height = h,
+        .backing_width = backing_width,
+        .backing_height = backing_height,
     };
 
     assert(tex_id);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 8f9fbf583e..3d19dbe382 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     if (src->dmabuf) {
         x1 = src->dmabuf->x;
         y1 = src->dmabuf->y;
-        w = src->dmabuf->scanout_width;
-        h = src->dmabuf->scanout_height;
+        w = src->dmabuf->width;
+        h = src->dmabuf->height;
     }
 
     w = (x1 + w) > src->width ? src->width - x1 : w;
@@ -314,9 +314,9 @@ void egl_dmabuf_import_texture(QemuDmaBuf *dmabuf)
     }
 
     attrs[i++] = EGL_WIDTH;
-    attrs[i++] = dmabuf->width;
+    attrs[i++] = dmabuf->backing_width;
     attrs[i++] = EGL_HEIGHT;
-    attrs[i++] = dmabuf->height;
+    attrs[i++] = dmabuf->backing_height;
     attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
     attrs[i++] = dmabuf->fourcc;
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index 42db1bb6cf..eee821d73a 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -262,9 +262,10 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
-                           dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                           dmabuf->scanout_height, NULL);
+                           dmabuf->y0_top,
+                           dmabuf->backing_width, dmabuf->backing_height,
+                           dmabuf->x, dmabuf->y, dmabuf->width,
+                           dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
@@ -284,7 +285,8 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
         if (!dmabuf->texture) {
             return;
         }
-        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->height,
+        egl_fb_setup_for_tex(&vc->gfx.cursor_fb,
+                             dmabuf->backing_width, dmabuf->backing_height,
                              dmabuf->texture, false);
     } else {
         egl_fb_destroy(&vc->gfx.cursor_fb);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index a9a7fdf50c..4513d3d059 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -301,9 +301,10 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
-                               dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                               dmabuf->scanout_height, NULL);
+                               dmabuf->y0_top,
+                               dmabuf->backing_width, dmabuf->backing_height,
+                               dmabuf->x, dmabuf->y, dmabuf->width,
+                               dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.41.0


