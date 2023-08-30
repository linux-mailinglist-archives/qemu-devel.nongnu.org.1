Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34AA78D4CC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:44:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHix-0004v2-80; Wed, 30 Aug 2023 05:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiO-0003Se-M0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHiE-0001cM-1u
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P67kcosaq4zcHr3lfyY3dcUWB8pT+SGgL20mBx0oT6o=;
 b=iUb6l+vri2xFuEoVuLx/YNiQtSBlWR8MGkdZypL2W8S/zdcYTMmXZEwCG/PEksCZcOWsOX
 CDIddN8EQphHVq53II0VaQmLLosSfOFaPvF2uNU0Bv8aV7irKcs3adZ6Z+vFFvCY9taKxX
 pEr0DBXA4fUClmGEVqTFvyEWjoGngps=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-vGOHtR7WOjmWQxW72scitw-1; Wed, 30 Aug 2023 05:42:08 -0400
X-MC-Unique: vGOHtR7WOjmWQxW72scitw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B304E2999B29
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:42:07 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2482166B25;
 Wed, 30 Aug 2023 09:42:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 50/67] ui/console: move DisplaySurface to its own header
Date: Wed, 30 Aug 2023 13:38:24 +0400
Message-ID: <20230830093843.3531473-51-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
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

Mostly for readability reasons.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h | 84 +---------------------------------------
 include/ui/surface.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 83 deletions(-)
 create mode 100644 include/ui/surface.h

diff --git a/include/ui/console.h b/include/ui/console.h
index 93bb03a9e2..79e4702912 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -6,11 +6,7 @@
 #include "qemu/notify.h"
 #include "qapi/qapi-types-ui.h"
 #include "ui/input.h"
-
-#ifdef CONFIG_OPENGL
-# include <epoxy/gl.h>
-# include "ui/shader.h"
-#endif
+#include "ui/surface.h"
 
 #define TYPE_QEMU_CONSOLE "qemu-console"
 OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
@@ -136,9 +132,6 @@ struct QemuConsoleClass {
     ObjectClass parent_class;
 };
 
-#define QEMU_ALLOCATED_FLAG     0x01
-#define QEMU_PLACEHOLDER_FLAG   0x02
-
 typedef struct ScanoutTexture {
     uint32_t backing_id;
     bool backing_y_0_top;
@@ -151,20 +144,6 @@ typedef struct ScanoutTexture {
     void *d3d_tex2d;
 } ScanoutTexture;
 
-typedef struct DisplaySurface {
-    pixman_image_t *image;
-    uint8_t flags;
-#ifdef CONFIG_OPENGL
-    GLenum glformat;
-    GLenum gltype;
-    GLuint texture;
-#endif
-#ifdef WIN32
-    HANDLE handle;
-    uint32_t handle_offset;
-#endif
-} DisplaySurface;
-
 typedef struct QemuUIInfo {
     /* physical dimension */
     uint16_t width_mm;
@@ -344,30 +323,6 @@ struct DisplayGLCtx {
 };
 
 DisplayState *init_displaystate(void);
-DisplaySurface *qemu_create_displaysurface_from(int width, int height,
-                                                pixman_format_code_t format,
-                                                int linesize, uint8_t *data);
-DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
-DisplaySurface *qemu_create_placeholder_surface(int w, int h,
-                                                const char *msg);
-#ifdef WIN32
-void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
-                                          HANDLE h, uint32_t offset);
-#endif
-PixelFormat qemu_default_pixelformat(int bpp);
-
-DisplaySurface *qemu_create_displaysurface(int width, int height);
-void qemu_free_displaysurface(DisplaySurface *surface);
-
-static inline int is_buffer_shared(DisplaySurface *surface)
-{
-    return !(surface->flags & QEMU_ALLOCATED_FLAG);
-}
-
-static inline int is_placeholder(DisplaySurface *surface)
-{
-    return surface->flags & QEMU_PLACEHOLDER_FLAG;
-}
 
 void register_displaychangelistener(DisplayChangeListener *dcl);
 void update_displaychangelistener(DisplayChangeListener *dcl,
@@ -415,43 +370,6 @@ int dpy_gl_ctx_make_current(QemuConsole *con, QEMUGLContext ctx);
 
 bool console_has_gl(QemuConsole *con);
 
-static inline int surface_stride(DisplaySurface *s)
-{
-    return pixman_image_get_stride(s->image);
-}
-
-static inline void *surface_data(DisplaySurface *s)
-{
-    return pixman_image_get_data(s->image);
-}
-
-static inline int surface_width(DisplaySurface *s)
-{
-    return pixman_image_get_width(s->image);
-}
-
-static inline int surface_height(DisplaySurface *s)
-{
-    return pixman_image_get_height(s->image);
-}
-
-static inline pixman_format_code_t surface_format(DisplaySurface *s)
-{
-    return pixman_image_get_format(s->image);
-}
-
-static inline int surface_bits_per_pixel(DisplaySurface *s)
-{
-    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
-    return bits;
-}
-
-static inline int surface_bytes_per_pixel(DisplaySurface *s)
-{
-    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
-    return DIV_ROUND_UP(bits, 8);
-}
-
 typedef uint32_t console_ch_t;
 
 static inline void console_write_ch(console_ch_t *dest, uint32_t ch)
diff --git a/include/ui/surface.h b/include/ui/surface.h
new file mode 100644
index 0000000000..37725a303e
--- /dev/null
+++ b/include/ui/surface.h
@@ -0,0 +1,91 @@
+#ifndef SURFACE_H
+#define SURFACE_H
+
+#include "ui/qemu-pixman.h"
+
+#ifdef CONFIG_OPENGL
+# include <epoxy/gl.h>
+# include "ui/shader.h"
+#endif
+
+#define QEMU_ALLOCATED_FLAG     0x01
+#define QEMU_PLACEHOLDER_FLAG   0x02
+
+typedef struct DisplaySurface {
+    pixman_image_t *image;
+    uint8_t flags;
+#ifdef CONFIG_OPENGL
+    GLenum glformat;
+    GLenum gltype;
+    GLuint texture;
+#endif
+#ifdef WIN32
+    HANDLE handle;
+    uint32_t handle_offset;
+#endif
+} DisplaySurface;
+
+PixelFormat qemu_default_pixelformat(int bpp);
+
+DisplaySurface *qemu_create_displaysurface_from(int width, int height,
+                                                pixman_format_code_t format,
+                                                int linesize, uint8_t *data);
+DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
+DisplaySurface *qemu_create_placeholder_surface(int w, int h,
+                                                const char *msg);
+#ifdef WIN32
+void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
+                                          HANDLE h, uint32_t offset);
+#endif
+
+DisplaySurface *qemu_create_displaysurface(int width, int height);
+void qemu_free_displaysurface(DisplaySurface *surface);
+
+static inline int is_buffer_shared(DisplaySurface *surface)
+{
+    return !(surface->flags & QEMU_ALLOCATED_FLAG);
+}
+
+static inline int is_placeholder(DisplaySurface *surface)
+{
+    return surface->flags & QEMU_PLACEHOLDER_FLAG;
+}
+
+static inline int surface_stride(DisplaySurface *s)
+{
+    return pixman_image_get_stride(s->image);
+}
+
+static inline void *surface_data(DisplaySurface *s)
+{
+    return pixman_image_get_data(s->image);
+}
+
+static inline int surface_width(DisplaySurface *s)
+{
+    return pixman_image_get_width(s->image);
+}
+
+static inline int surface_height(DisplaySurface *s)
+{
+    return pixman_image_get_height(s->image);
+}
+
+static inline pixman_format_code_t surface_format(DisplaySurface *s)
+{
+    return pixman_image_get_format(s->image);
+}
+
+static inline int surface_bits_per_pixel(DisplaySurface *s)
+{
+    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
+    return bits;
+}
+
+static inline int surface_bytes_per_pixel(DisplaySurface *s)
+{
+    int bits = PIXMAN_FORMAT_BPP(surface_format(s));
+    return DIV_ROUND_UP(bits, 8);
+}
+
+#endif
-- 
2.41.0


