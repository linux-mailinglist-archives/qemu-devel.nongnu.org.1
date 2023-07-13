Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1451F751775
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 06:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJnvS-0001Mh-Ix; Thu, 13 Jul 2023 00:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJnvP-0001MR-3y
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 00:27:31 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qJnvJ-0000Yt-1g
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 00:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689222445; x=1720758445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=76t+NRma7/AM6uSkX3rnqWpfyMAhQ0AAZrgosHjTV4s=;
 b=A59BztH+zUaI24fSbEr5yJA//fnxLp9XJG7GvanbaUbnw5xySa8h49lY
 RkBB0j49vcqUgHtmCwRdGAYgbFDfth1o0Mi926vKscHViwXfiuCqXBjGy
 pRds0nYfNvZzeWpDcwVALZ0H62Cfn12tZeytbZPlxF6fx/5qP9PDIxePX
 AW0fURCVt7YhEogeQ4WpKHceWaIa29VYDKzBFMS6ibGs6N4ayWpojxk9n
 cXP8+kYTDUq7JJcTfFveiH5OKQ1eI/5e4SQN73UuYQ7PkfuKN5LH0CyHW
 WY6+7Hl59kCBB2xzklRN/s92GSNCk0U+EjYMMx2hbhIdPQbbrgqlmZJdk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="428831248"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="428831248"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 21:27:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725150602"
X-IronPort-AV: E=Sophos;i="6.01,201,1684825200"; d="scan'208";a="725150602"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 21:27:21 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu-udmabuf: correct naming of QemuDmaBuf size
 properties
Date: Wed, 12 Jul 2023 21:04:44 -0700
Message-Id: <20230713040444.32267-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
References: <CAJ+F1CKOQxQQh0qNJteP9EPfrCM3JaLZx5PkgsHJpQ4y_hWtnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=dongwon.kim@intel.com; helo=mga06.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Replace 'width' and 'height' in QemuDmaBuf with 'backing_widht'
and 'backing_height' as these commonly indicate the size of the
whole surface (e.g. guest's Xorg extended display). Then use
'width' and 'height' for sub region in there (e.g. guest's
scanouts).

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 12 ++++++------
 include/ui/console.h            |  4 ++--
 ui/dbus-listener.c              |  8 ++++----
 ui/egl-helpers.c                |  8 ++++----
 ui/gtk-egl.c                    |  8 ++++----
 ui/gtk-gl-area.c                |  6 +++---
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index ef1a740de5..047758582c 100644
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
+    dmabuf->buf.backing_height = fb->height;;
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
index 8f9fbf583e..bc0960a9ec 100644
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
+    attrs[i++] = dmabuf->backing_height;;
     attrs[i++] = EGL_LINUX_DRM_FOURCC_EXT;
     attrs[i++] = dmabuf->fourcc;
 
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d59b8cd7d7..a37ad6c9db 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -258,9 +258,9 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
-                           dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                           dmabuf->scanout_height, NULL);
+                           dmabuf->y0_top, dmabuf->backing_width, dmabuf->backing_height,
+                           dmabuf->x, dmabuf->y, dmabuf->width,
+                           dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
@@ -280,7 +280,7 @@ void gd_egl_cursor_dmabuf(DisplayChangeListener *dcl,
         if (!dmabuf->texture) {
             return;
         }
-        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->width, dmabuf->height,
+        egl_fb_setup_for_tex(&vc->gfx.cursor_fb, dmabuf->backing_width, dmabuf->backing_height,
                              dmabuf->texture, false);
     } else {
         egl_fb_destroy(&vc->gfx.cursor_fb);
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7367dfd793..ea3d50598e 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -299,9 +299,9 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
     }
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
-                               dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                               dmabuf->scanout_height, NULL);
+                               dmabuf->y0_top, dmabuf->backing_width, dmabuf->backing_height,
+                               dmabuf->x, dmabuf->y, dmabuf->width,
+                               dmabuf->height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.20.1


