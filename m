Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8D874915E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 01:11:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHBcp-00014x-GJ; Wed, 05 Jul 2023 19:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHBcn-00014g-Bt
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 19:09:29 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHBck-0000El-Sf
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 19:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688598566; x=1720134566;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mdlKynR3paj9GtmxhIO5gvGWtib3nlpg/aRVRpbiADo=;
 b=N2c8JB8mrMlpsaxTGzyzUXfvuXXBNFhtHc+/b18H28OVXnqrqn7JgtjX
 FANCn8Z7qBFmu0QkwWaH2RJ8D1WDg6x21sThINkWa7effobInMWTUlI1I
 E2ZaYMKseZt/lGRAcFNj8MfT+ayDoo2rfN6OdkYYQar8+qpTKv0J9t/GC
 AaYJpF4s4/sSL72na5U346vj7QHvEUodL73oHSYMsrE5p8uAV1B6NXF5c
 e5f6Ie3P+pk18r77AaIR3zh630tjaSZtP74h/xAkEf/y7LCLoBG7iFmrO
 zi3IbDhI+Zdn1v8mSLZIhTWP6b/yJ10IBgIaNvKwe6JsswjG4eYMzfJG6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429503236"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="429503236"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 16:09:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="748914980"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="748914980"
Received: from dongwonk-z390-aorus-ultra-intel-gfx.fm.intel.com
 ([10.105.129.122])
 by orsmga008.jf.intel.com with ESMTP; 05 Jul 2023 16:09:18 -0700
From: Dongwon Kim <dongwon.kim@intel.com>
To: qemu-devel@nongnu.org
Cc: Dongwon Kim <dongwon.kim@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: [PATCH] virtio-gpu-udmabuf: replacing scanout_width/height with
 backing_width/height
Date: Wed,  5 Jul 2023 15:46:35 -0700
Message-Id: <20230705224635.25343-1-dongwon.kim@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dongwon.kim@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

'backing_width' and 'backing_height' are commonly used to indicate the size
of the whole backing region so it makes sense to use those terms for
VGAUDMABuf as well in place of 'scanout_width' and 'scanout_height'.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
---
 hw/display/virtio-gpu-udmabuf.c | 8 ++++----
 include/ui/console.h            | 4 ++--
 ui/dbus-listener.c              | 4 ++--
 ui/egl-helpers.c                | 4 ++--
 ui/gtk-egl.c                    | 4 ++--
 ui/gtk-gl-area.c                | 4 ++--
 6 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/display/virtio-gpu-udmabuf.c b/hw/display/virtio-gpu-udmabuf.c
index ef1a740de5..920d457d4a 100644
--- a/hw/display/virtio-gpu-udmabuf.c
+++ b/hw/display/virtio-gpu-udmabuf.c
@@ -186,8 +186,8 @@ static VGPUDMABuf
     dmabuf->buf.stride = fb->stride;
     dmabuf->buf.x = r->x;
     dmabuf->buf.y = r->y;
-    dmabuf->buf.scanout_width = r->width;
-    dmabuf->buf.scanout_height = r->height;
+    dmabuf->buf.backing_width = r->width;
+    dmabuf->buf.backing_height = r->height;
     dmabuf->buf.fourcc = qemu_pixman_to_drm_format(fb->format);
     dmabuf->buf.fd = res->dmabuf_fd;
     dmabuf->buf.allow_fences = true;
@@ -218,8 +218,8 @@ int virtio_gpu_update_dmabuf(VirtIOGPU *g,
 
     g->dmabuf.primary[scanout_id] = new_primary;
     qemu_console_resize(scanout->con,
-                        new_primary->buf.scanout_width,
-                        new_primary->buf.scanout_height);
+                        new_primary->buf.backing_width,
+                        new_primary->buf.backing_height);
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
index 0240c39510..7d73681cbc 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -420,8 +420,8 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
         .y0_top = backing_y_0_top,
         .x = x,
         .y = y,
-        .scanout_width = w,
-        .scanout_height = h,
+        .backing_width = w,
+        .backing_height = h,
     };
 
     assert(tex_id);
diff --git a/ui/egl-helpers.c b/ui/egl-helpers.c
index 8f9fbf583e..6b7be5753d 100644
--- a/ui/egl-helpers.c
+++ b/ui/egl-helpers.c
@@ -148,8 +148,8 @@ void egl_fb_blit(egl_fb *dst, egl_fb *src, bool flip)
     if (src->dmabuf) {
         x1 = src->dmabuf->x;
         y1 = src->dmabuf->y;
-        w = src->dmabuf->scanout_width;
-        h = src->dmabuf->scanout_height;
+        w = src->dmabuf->backing_width;
+        h = src->dmabuf->backing_height;
     }
 
     w = (x1 + w) > src->width ? src->width - x1 : w;
diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
index d59b8cd7d7..7604696d4a 100644
--- a/ui/gtk-egl.c
+++ b/ui/gtk-egl.c
@@ -259,8 +259,8 @@ void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_egl_scanout_texture(dcl, dmabuf->texture,
                            dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                           dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                           dmabuf->scanout_height, NULL);
+                           dmabuf->x, dmabuf->y, dmabuf->backing_width,
+                           dmabuf->backing_height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
index 7367dfd793..3337a4baa3 100644
--- a/ui/gtk-gl-area.c
+++ b/ui/gtk-gl-area.c
@@ -300,8 +300,8 @@ void gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
 
     gd_gl_area_scanout_texture(dcl, dmabuf->texture,
                                dmabuf->y0_top, dmabuf->width, dmabuf->height,
-                               dmabuf->x, dmabuf->y, dmabuf->scanout_width,
-                               dmabuf->scanout_height, NULL);
+                               dmabuf->x, dmabuf->y, dmabuf->backing_width,
+                               dmabuf->backing_height, NULL);
 
     if (dmabuf->allow_fences) {
         vc->gfx.guest_fb.dmabuf = dmabuf;
-- 
2.34.1


