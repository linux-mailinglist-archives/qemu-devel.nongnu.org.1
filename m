Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B83A79CECD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 12:49:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg0vo-00043k-Ge; Tue, 12 Sep 2023 06:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vm-000410-5w
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qg0vj-0003JI-Mv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 06:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694515657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3zyCaLXLSn7aURJ1i9gJSyv2fWZHcsTULvmprb5B6I=;
 b=B2QuVZ29hceEQfklb52d0myq+2L5UwnbN4CjCZo+TXvcmedWYgeHsbSg5t79Oy/jf8Iz80
 9sG6rl6PKnC3TVOYz32ZWa8ze12bIyFjDxmK5JmH1+jtbJXWuFVPFHly3zxx0R4v2a/K1F
 AhUp0QV3awU9MuWRR5z2SSQAxGWEShQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-D7Gv-W2GORWrNFMPB6M64Q-1; Tue, 12 Sep 2023 06:47:35 -0400
X-MC-Unique: D7Gv-W2GORWrNFMPB6M64Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8ED3229DD9B2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:47:35 +0000 (UTC)
Received: from localhost (unknown [10.39.208.8])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A30440C2064;
 Tue, 12 Sep 2023 10:47:34 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 11/14] ui/console: move DisplaySurface to its own header
Date: Tue, 12 Sep 2023 14:46:45 +0400
Message-ID: <20230912104649.1638640-12-marcandre.lureau@redhat.com>
In-Reply-To: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
References: <20230912104649.1638640-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/console.h | 84 +--------------------------------------
 include/ui/surface.h | 95 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 83 deletions(-)
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
index 0000000000..4244e0ca4a
--- /dev/null
+++ b/include/ui/surface.h
@@ -0,0 +1,95 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * QEMU UI Console
+ */
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


