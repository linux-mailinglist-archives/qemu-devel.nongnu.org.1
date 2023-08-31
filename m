Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7004778EE98
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:27:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhgW-0004pV-Jq; Thu, 31 Aug 2023 09:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgN-0004bf-Mc
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:25:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qbhgJ-0007KW-1O
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693488352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6v14ZSStXkdDjMaevSWEfLeuGs8oIU/1ND+Elarnrg=;
 b=G8TnNNa6KOZ9yxkjyvf57HA/DncTBtwXe5e2uPNm4Hi2qmpK9q8Un7Uy/O7grffYJsZ0ET
 DGFDqFVvxIfZvTzgSdzjH0RgdiyizYVCqbvm0gAn3yFxIJh8ilSIKVOhijBZk5Wc5sL66H
 otBE5T6IuqMypwAzL1U3dK/CVndrcE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-AMkiEJVzP9q12H4PY919rg-1; Thu, 31 Aug 2023 09:25:49 -0400
X-MC-Unique: AMkiEJVzP9q12H4PY919rg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B086D80CC5E;
 Thu, 31 Aug 2023 13:25:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC58240C2072;
 Thu, 31 Aug 2023 13:25:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBE4421E6930; Thu, 31 Aug 2023 15:25:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH 3/7] ui: Clean up local variable shadowing
Date: Thu, 31 Aug 2023 15:25:42 +0200
Message-ID: <20230831132546.3525721-4-armbru@redhat.com>
In-Reply-To: <20230831132546.3525721-1-armbru@redhat.com>
References: <20230831132546.3525721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Tracked down with -Wshadow=local.
Clean up: delete inner declarations when they are actually redundant,
else rename variables.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/gtk.c              | 14 +++++++-------
 ui/spice-display.c    |  9 +++++----
 ui/vnc-palette.c      |  2 --
 ui/vnc.c              | 12 ++++++------
 ui/vnc-enc-zrle.c.inc |  9 ++++-----
 5 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/ui/gtk.c b/ui/gtk.c
index 8ba41c8f13..24c78df79e 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -930,8 +930,8 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
         GdkMonitor *monitor = gdk_display_get_monitor_at_window(dpy, win);
         GdkRectangle geometry;
 
-        int x = (int)motion->x_root;
-        int y = (int)motion->y_root;
+        int xr = (int)motion->x_root;
+        int yr = (int)motion->y_root;
 
         gdk_monitor_get_geometry(monitor, &geometry);
 
@@ -942,13 +942,13 @@ static gboolean gd_motion_event(GtkWidget *widget, GdkEventMotion *motion,
          * may still be only half way across the screen. Without
          * this warp, the server pointer would thus appear to hit
          * an invisible wall */
-        if (x <= geometry.x || x - geometry.x >= geometry.width - 1 ||
-            y <= geometry.y || y - geometry.y >= geometry.height - 1) {
+        if (xr <= geometry.x || xr - geometry.x >= geometry.width - 1 ||
+            yr <= geometry.y || yr - geometry.y >= geometry.height - 1) {
             GdkDevice *dev = gdk_event_get_device((GdkEvent *)motion);
-            x = geometry.x + geometry.width / 2;
-            y = geometry.y + geometry.height / 2;
+            xr = geometry.x + geometry.width / 2;
+            yr = geometry.y + geometry.height / 2;
 
-            gdk_device_warp(dev, screen, x, y);
+            gdk_device_warp(dev, screen, xr, yr);
             s->last_set = FALSE;
             return FALSE;
         }
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 3f3f8013d8..cbaba3bbad 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -1080,15 +1080,16 @@ static void qemu_spice_gl_update(DisplayChangeListener *dcl,
     }
 
     if (render_cursor) {
-        int x, y;
+        int ptr_x, ptr_y;
+
         qemu_mutex_lock(&ssd->lock);
-        x = ssd->ptr_x;
-        y = ssd->ptr_y;
+        ptr_x = ssd->ptr_x;
+        ptr_y = ssd->ptr_y;
         qemu_mutex_unlock(&ssd->lock);
         egl_texture_blit(ssd->gls, &ssd->blit_fb, &ssd->guest_fb,
                          !y_0_top);
         egl_texture_blend(ssd->gls, &ssd->blit_fb, &ssd->cursor_fb,
-                          !y_0_top, x, y, 1.0, 1.0);
+                          !y_0_top, ptr_x, ptr_y, 1.0, 1.0);
         glFlush();
     }
 
diff --git a/ui/vnc-palette.c b/ui/vnc-palette.c
index dc7c0ba997..4e88c412f0 100644
--- a/ui/vnc-palette.c
+++ b/ui/vnc-palette.c
@@ -86,8 +86,6 @@ int palette_put(VncPalette *palette, uint32_t color)
         return 0;
     }
     if (!entry) {
-        VncPaletteEntry *entry;
-
         entry = &palette->pool[palette->size];
         entry->color = color;
         entry->idx = idx;
diff --git a/ui/vnc.c b/ui/vnc.c
index 92964dcc0c..3e1fccffa3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1584,15 +1584,15 @@ static void vnc_jobs_bh(void *opaque)
  */
 static int vnc_client_read(VncState *vs)
 {
-    size_t ret;
+    size_t sz;
 
 #ifdef CONFIG_VNC_SASL
     if (vs->sasl.conn && vs->sasl.runSSF)
-        ret = vnc_client_read_sasl(vs);
+        sz = vnc_client_read_sasl(vs);
     else
 #endif /* CONFIG_VNC_SASL */
-        ret = vnc_client_read_plain(vs);
-    if (!ret) {
+        sz = vnc_client_read_plain(vs);
+    if (!sz) {
         if (vs->disconnecting) {
             vnc_disconnect_finish(vs);
             return -1;
@@ -3118,8 +3118,8 @@ static int vnc_refresh_server_surface(VncDisplay *vd)
     cmp_bytes = MIN(VNC_DIRTY_PIXELS_PER_BIT * VNC_SERVER_FB_BYTES,
                     server_stride);
     if (vd->guest.format != VNC_SERVER_FB_FORMAT) {
-        int width = pixman_image_get_width(vd->server);
-        tmpbuf = qemu_pixman_linebuf_create(VNC_SERVER_FB_FORMAT, width);
+        int w = pixman_image_get_width(vd->server);
+        tmpbuf = qemu_pixman_linebuf_create(VNC_SERVER_FB_FORMAT, w);
     } else {
         int guest_bpp =
             PIXMAN_FORMAT_BPP(pixman_image_get_format(vd->guest.fb));
diff --git a/ui/vnc-enc-zrle.c.inc b/ui/vnc-enc-zrle.c.inc
index c107d8affc..edf42d4a6a 100644
--- a/ui/vnc-enc-zrle.c.inc
+++ b/ui/vnc-enc-zrle.c.inc
@@ -153,11 +153,12 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
     }
 
     if (use_rle) {
-        ZRLE_PIXEL *ptr = data;
-        ZRLE_PIXEL *end = ptr + w * h;
         ZRLE_PIXEL *run_start;
         ZRLE_PIXEL pix;
 
+	ptr = data;
+        end = ptr + w * h;
+
         while (ptr < end) {
             int len;
             int index = 0;
@@ -198,7 +199,7 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
         }
     } else if (use_palette) { /* no RLE */
         int bppp;
-        ZRLE_PIXEL *ptr = data;
+        ptr = data;
 
         /* packed pixels */
 
@@ -241,8 +242,6 @@ static void ZRLE_ENCODE_TILE(VncState *vs, ZRLE_PIXEL *data, int w, int h,
 #endif
         {
 #ifdef ZRLE_COMPACT_PIXEL
-            ZRLE_PIXEL *ptr;
-
             for (ptr = data; ptr < data + w * h; ptr++) {
                 ZRLE_WRITE_PIXEL(vs, *ptr);
             }
-- 
2.41.0


