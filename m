Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D32A479CED0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0va-0003Oo-R2; Tue, 12 Sep 2023 06:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vZ-0003HN-8O
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vU-0003Go-Io
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RHFQhWj/qbws01dq1YGH+JPZkqgaBC2OarH6ZVWsAQ=;
 b=fe/HJyWmxfDT6nqR8cLHhXqhBhopyKAmECb1JJ//bLSQv2QVYOcGm3Fz4BR556EDjhGYMW
 KJPLvOV51Oq3CQTiDDoee7pxMFUiJPDdMyjZNUmNnWbil7/PoYdsTvU6m7Q12wqOi8JuWH
 5LDwGvLcjiZpzR1pNNApVZDfxDucz/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-K-dv5w-dOuC558DoHWZOYQ-1; Tue, 12 Sep 2023 06:47:22 -0400
X-MC-Unique: K-dv5w-dOuC558DoHWZOYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E16B8019DC
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 215D721B2413;
 Tue, 12 Sep 2023 10:47:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 08/14] ui/console: remove redundant format field
Date: Tue, 12 Sep 2023 14:46:42 +0400
Message-ID: <20230912104649.1638640-9-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
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

It's already part of PIXMAN image.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/console.h | 15 +++++++--------
 ui/console-gl.c      |  2 +-
 ui/console.c         |  4 +---
 ui/gtk.c             |  2 +-
 ui/spice-display.c   |  2 +-
 ui/vnc.c             |  2 +-
 6 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 26d63d17a2..93bb03a9e2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -152,7 +152,6 @@ typedef struct ScanoutTexture {
 } ScanoutTexture;
 
 typedef struct DisplaySurface {
-    pixman_format_code_t format;
     pixman_image_t *image;
     uint8_t flags;
 #ifdef CONFIG_OPENGL
@@ -436,23 +435,23 @@ static inline int surface_height(DisplaySurface *s)
     return pixman_image_get_height(s->image);
 }
 
+static inline pixman_format_code_t surface_format(DisplaySurface *s)
+{
+    return pixman_image_get_format(s->image);
+}
+
 static inline int surface_bits_per_pixel(DisplaySurface *s)
 {
-    int bits = PIXMAN_FORMAT_BPP(s->format);
+    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
     return bits;
 }
 
 static inline int surface_bytes_per_pixel(DisplaySurface *s)
 {
-    int bits = PIXMAN_FORMAT_BPP(s->format);
+    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
     return DIV_ROUND_UP(bits, 8);
 }
 
-static inline pixman_format_code_t surface_format(DisplaySurface *s)
-{
-    return s->format;
-}
-
 typedef uint32_t console_ch_t;
 
 static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
diff --git a/ui/console-gl.c b/ui/console-gl.c
index 8e3c9a3c8c..103b954017 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -53,7 +53,7 @@ void surface_gl_create_texture(QemuGLShader *gls,
         return;
     }
 
-    switch (surface->format) {
+    switch (surface_format(surface)) {
     case PIXMAN_BE_b8g8r8x8:
     case PIXMAN_BE_b8g8r8a8:
         surface->glformat = GL_BGRA_EXT;
diff --git a/ui/console.c b/ui/console.c
index 7c60fc7d18..4ff9f8b6e7 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1493,8 +1493,7 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_from(surface, width, height, format);
-    surface->format = format;
-    surface->image = pixman_image_create_bits(surface->format,
+    surface->image = pixman_image_create_bits(format,
                                               width, height,
                                               (void *)data, linesize);
     assert(surface->image != NULL);
@@ -1511,7 +1510,6 @@ DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image)
     DisplaySurface *surface = g_new0(DisplaySurface, 1);
 
     trace_displaysurface_create_pixman(surface);
-    surface->format = pixman_image_get_format(image);
     surface->image = pixman_image_ref(image);
 
     return surface;
diff --git a/ui/gtk.c b/ui/gtk.c
index c05f9a3f83..e09f97a86b 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -514,7 +514,7 @@ static void gd_switch(DisplayChangeListener *dcl,
     }
     vc->gfx.ds = surface;
 
-    if (surface->format == PIXMAN_x8r8g8b8) {
+    if (surface_format(surface) == PIXMAN_x8r8g8b8) {
         /*
          * PIXMAN_x8r8g8b8 == CAIRO_FORMAT_RGB24
          *
diff --git a/ui/spice-display.c b/ui/spice-display.c
index 0e2fbfb17c..5cc47bd668 100644
--- a/ui/spice-display.c
+++ b/ui/spice-display.c
@@ -437,7 +437,7 @@ void qemu_spice_display_switch(SimpleSpiceDisplay *ssd,
     }
     if (ssd->ds) {
         ssd->surface = pixman_image_ref(ssd->ds->image);
-        ssd->mirror  = qemu_pixman_mirror_create(ssd->ds->format,
+        ssd->mirror  = qemu_pixman_mirror_create(surface_format(ssd->ds),
                                                  ssd->ds->image);
         qemu_spice_create_host_primary(ssd);
     }
diff --git a/ui/vnc.c b/ui/vnc.c
index 22894b7b1f..6fd86996a5 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -833,7 +833,7 @@ static void vnc_dpy_switch(DisplayChangeListener *dcl,
     /* guest surface */
     qemu_pixman_image_unref(vd->guest.fb);
     vd->guest.fb = pixman_image_ref(surface->image);
-    vd->guest.format = surface->format;
+    vd->guest.format = surface_format(surface);
 
 
     if (pageflip) {
-- 
2.41.0


