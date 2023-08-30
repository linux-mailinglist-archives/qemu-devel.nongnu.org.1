Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D730F78D4A9
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:40:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHfG-0007Ha-M7; Wed, 30 Aug 2023 05:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfF-0007HB-46
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qbHfC-0000qW-Bl
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693388341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuVuMGJsiYmwbdBBI6wvk9ev6QPZ1q/xOR0O8MFCN0U=;
 b=YJG3uUX7rSJLdq9f14xlOJWUbVTEO0kz/yZVKVqC34CpahgH0xoBw0bjunbYiAgorQzUn/
 6YkCOF7E2bouilvh+TQJtKe/9R3dBu0P9/Qnp5CqQJcpkUXzKzvLuRo4gpK52eLSfAJp5h
 8gwG0vXoL6ULUQINriWiWhhSRLa/3eQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-sFhYuKj3Nxaec0av0lae-A-1; Wed, 30 Aug 2023 05:39:00 -0400
X-MC-Unique: sFhYuKj3Nxaec0av0lae-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A61CB185A793
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:38:59 +0000 (UTC)
Received: from localhost (unknown [10.39.208.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3807063F6C;
 Wed, 30 Aug 2023 09:38:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 03/67] ui/qmp: move screendump to ui-qmp-cmds.c
Date: Wed, 30 Aug 2023 13:37:37 +0400
Message-ID: <20230830093843.3531473-4-marcandre.lureau@redhat.com>
In-Reply-To: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
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

console.c unit is over-crowded. This code is specific to the handling of
the QMP screendump command, so move it in ui-qmp-cmds.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |   1 +
 ui/console.c         | 212 ++++---------------------------------------
 ui/ui-qmp-cmds.c     | 187 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 205 insertions(+), 195 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 3e8b22d6c6..1b08b0f8ad 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -504,6 +504,7 @@ void qemu_console_set_window_id(QemuConsole *con, int window_id);
 void console_select(unsigned int index);
 void qemu_console_resize(QemuConsole *con, int width, int height);
 DisplaySurface *qemu_console_surface(QemuConsole *con);
+void coroutine_fn qemu_console_co_wait_update(QemuConsole *con);
 
 /* console-gl.c */
 #ifdef CONFIG_OPENGL
diff --git a/ui/console.c b/ui/console.c
index 8da2170a7e..9c17024dbc 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -28,8 +28,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qemu/coroutine.h"
-#include "qemu/error-report.h"
 #include "qemu/fifo8.h"
+#include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -37,11 +37,7 @@
 #include "chardev/char.h"
 #include "trace.h"
 #include "exec/memory.h"
-#include "io/channel-file.h"
 #include "qom/object.h"
-#ifdef CONFIG_PNG
-#include <png.h>
-#endif
 
 #define DEFAULT_BACKSCROLL 512
 #define CONSOLE_CURSOR_PERIOD 500
@@ -239,6 +235,22 @@ void graphic_hw_update(QemuConsole *con)
     }
 }
 
+static void graphic_hw_update_bh(void *con)
+{
+    graphic_hw_update(con);
+}
+
+void qemu_console_co_wait_update(QemuConsole *con)
+{
+    if (qemu_co_queue_empty(&con->dump_queue)) {
+        /* Defer the update, it will restart the pending coroutines */
+        aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                                graphic_hw_update_bh, con);
+    }
+    qemu_co_queue_wait(&con->dump_queue, NULL);
+
+}
+
 static void graphic_hw_gl_unblock_timer(void *opaque)
 {
     warn_report("console: no gl-unblock within one second");
@@ -292,196 +304,6 @@ void graphic_hw_invalidate(QemuConsole *con)
     }
 }
 
-#ifdef CONFIG_PNG
-/**
- * png_save: Take a screenshot as PNG
- *
- * Saves screendump as a PNG file
- *
- * Returns true for success or false for error.
- *
- * @fd: File descriptor for PNG file.
- * @image: Image data in pixman format.
- * @errp: Pointer to an error.
- */
-static bool png_save(int fd, pixman_image_t *image, Error **errp)
-{
-    int width = pixman_image_get_width(image);
-    int height = pixman_image_get_height(image);
-    png_struct *png_ptr;
-    png_info *info_ptr;
-    g_autoptr(pixman_image_t) linebuf =
-        qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
-    uint8_t *buf = (uint8_t *)pixman_image_get_data(linebuf);
-    FILE *f = fdopen(fd, "wb");
-    int y;
-    if (!f) {
-        error_setg_errno(errp, errno,
-                         "Failed to create file from file descriptor");
-        return false;
-    }
-
-    png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL,
-                                      NULL, NULL);
-    if (!png_ptr) {
-        error_setg(errp, "PNG creation failed. Unable to write struct");
-        fclose(f);
-        return false;
-    }
-
-    info_ptr = png_create_info_struct(png_ptr);
-
-    if (!info_ptr) {
-        error_setg(errp, "PNG creation failed. Unable to write info");
-        fclose(f);
-        png_destroy_write_struct(&png_ptr, &info_ptr);
-        return false;
-    }
-
-    png_init_io(png_ptr, f);
-
-    png_set_IHDR(png_ptr, info_ptr, width, height, 8,
-                 PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
-                 PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);
-
-    png_write_info(png_ptr, info_ptr);
-
-    for (y = 0; y < height; ++y) {
-        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
-        png_write_row(png_ptr, buf);
-    }
-
-    png_write_end(png_ptr, NULL);
-
-    png_destroy_write_struct(&png_ptr, &info_ptr);
-
-    if (fclose(f) != 0) {
-        error_setg_errno(errp, errno,
-                         "PNG creation failed. Unable to close file");
-        return false;
-    }
-
-    return true;
-}
-
-#else /* no png support */
-
-static bool png_save(int fd, pixman_image_t *image, Error **errp)
-{
-    error_setg(errp, "Enable PNG support with libpng for screendump");
-    return false;
-}
-
-#endif /* CONFIG_PNG */
-
-static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
-{
-    int width = pixman_image_get_width(image);
-    int height = pixman_image_get_height(image);
-    g_autoptr(Object) ioc = OBJECT(qio_channel_file_new_fd(fd));
-    g_autofree char *header = NULL;
-    g_autoptr(pixman_image_t) linebuf = NULL;
-    int y;
-
-    trace_ppm_save(fd, image);
-
-    header = g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
-    if (qio_channel_write_all(QIO_CHANNEL(ioc),
-                              header, strlen(header), errp) < 0) {
-        return false;
-    }
-
-    linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
-    for (y = 0; y < height; y++) {
-        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
-        if (qio_channel_write_all(QIO_CHANNEL(ioc),
-                                  (char *)pixman_image_get_data(linebuf),
-                                  pixman_image_get_stride(linebuf), errp) < 0) {
-            return false;
-        }
-    }
-
-    return true;
-}
-
-static void graphic_hw_update_bh(void *con)
-{
-    graphic_hw_update(con);
-}
-
-/* Safety: coroutine-only, concurrent-coroutine safe, main thread only */
-void coroutine_fn
-qmp_screendump(const char *filename, const char *device,
-               bool has_head, int64_t head,
-               bool has_format, ImageFormat format, Error **errp)
-{
-    g_autoptr(pixman_image_t) image = NULL;
-    QemuConsole *con;
-    DisplaySurface *surface;
-    int fd;
-
-    if (device) {
-        con = qemu_console_lookup_by_device_name(device, has_head ? head : 0,
-                                                 errp);
-        if (!con) {
-            return;
-        }
-    } else {
-        if (has_head) {
-            error_setg(errp, "'head' must be specified together with 'device'");
-            return;
-        }
-        con = qemu_console_lookup_by_index(0);
-        if (!con) {
-            error_setg(errp, "There is no console to take a screendump from");
-            return;
-        }
-    }
-
-    if (qemu_co_queue_empty(&con->dump_queue)) {
-        /* Defer the update, it will restart the pending coroutines */
-        aio_bh_schedule_oneshot(qemu_get_aio_context(),
-                                graphic_hw_update_bh, con);
-    }
-    qemu_co_queue_wait(&con->dump_queue, NULL);
-
-    /*
-     * All pending coroutines are woken up, while the BQL is held.  No
-     * further graphic update are possible until it is released.  Take
-     * an image ref before that.
-     */
-    surface = qemu_console_surface(con);
-    if (!surface) {
-        error_setg(errp, "no surface");
-        return;
-    }
-    image = pixman_image_ref(surface->image);
-
-    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
-    if (fd == -1) {
-        error_setg(errp, "failed to open file '%s': %s", filename,
-                   strerror(errno));
-        return;
-    }
-
-    /*
-     * The image content could potentially be updated as the coroutine
-     * yields and releases the BQL. It could produce corrupted dump, but
-     * it should be otherwise safe.
-     */
-    if (has_format && format == IMAGE_FORMAT_PNG) {
-        /* PNG format specified for screendump */
-        if (!png_save(fd, image, errp)) {
-            qemu_unlink(filename);
-        }
-    } else {
-        /* PPM format specified/default for screendump */
-        if (!ppm_save(fd, image, errp)) {
-            qemu_unlink(filename);
-        }
-    }
-}
-
 void graphic_hw_text_update(QemuConsole *con, console_ch_t *chardata)
 {
     if (!con) {
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index a37a7024f3..debc07d678 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -14,13 +14,20 @@
  */
 
 #include "qemu/osdep.h"
+
+#include "io/channel-file.h"
 #include "monitor/qmp-helpers.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qerror.h"
+#include "qemu/coroutine.h"
 #include "qemu/cutils.h"
+#include "trace.h"
 #include "ui/console.h"
 #include "ui/dbus-display.h"
 #include "ui/qemu-spice.h"
+#ifdef CONFIG_PNG
+#include <png.h>
+#endif
 
 void qmp_set_password(SetPasswordOptions *opts, Error **errp)
 {
@@ -204,3 +211,183 @@ void qmp_client_migrate_info(const char *protocol, const char *hostname,
 
     error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "protocol", "'spice'");
 }
+
+#ifdef CONFIG_PNG
+/**
+ * png_save: Take a screenshot as PNG
+ *
+ * Saves screendump as a PNG file
+ *
+ * Returns true for success or false for error.
+ *
+ * @fd: File descriptor for PNG file.
+ * @image: Image data in pixman format.
+ * @errp: Pointer to an error.
+ */
+static bool png_save(int fd, pixman_image_t *image, Error **errp)
+{
+    int width = pixman_image_get_width(image);
+    int height = pixman_image_get_height(image);
+    png_struct *png_ptr;
+    png_info *info_ptr;
+    g_autoptr(pixman_image_t) linebuf =
+        qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
+    uint8_t *buf = (uint8_t *)pixman_image_get_data(linebuf);
+    FILE *f = fdopen(fd, "wb");
+    int y;
+    if (!f) {
+        error_setg_errno(errp, errno,
+                         "Failed to create file from file descriptor");
+        return false;
+    }
+
+    png_ptr = png_create_write_struct(PNG_LIBPNG_VER_STRING, NULL,
+                                      NULL, NULL);
+    if (!png_ptr) {
+        error_setg(errp, "PNG creation failed. Unable to write struct");
+        fclose(f);
+        return false;
+    }
+
+    info_ptr = png_create_info_struct(png_ptr);
+
+    if (!info_ptr) {
+        error_setg(errp, "PNG creation failed. Unable to write info");
+        fclose(f);
+        png_destroy_write_struct(&png_ptr, &info_ptr);
+        return false;
+    }
+
+    png_init_io(png_ptr, f);
+
+    png_set_IHDR(png_ptr, info_ptr, width, height, 8,
+                 PNG_COLOR_TYPE_RGB, PNG_INTERLACE_NONE,
+                 PNG_COMPRESSION_TYPE_BASE, PNG_FILTER_TYPE_BASE);
+
+    png_write_info(png_ptr, info_ptr);
+
+    for (y = 0; y < height; ++y) {
+        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
+        png_write_row(png_ptr, buf);
+    }
+
+    png_write_end(png_ptr, NULL);
+
+    png_destroy_write_struct(&png_ptr, &info_ptr);
+
+    if (fclose(f) != 0) {
+        error_setg_errno(errp, errno,
+                         "PNG creation failed. Unable to close file");
+        return false;
+    }
+
+    return true;
+}
+
+#else /* no png support */
+
+static bool png_save(int fd, pixman_image_t *image, Error **errp)
+{
+    error_setg(errp, "Enable PNG support with libpng for screendump");
+    return false;
+}
+
+#endif /* CONFIG_PNG */
+
+static bool ppm_save(int fd, pixman_image_t *image, Error **errp)
+{
+    int width = pixman_image_get_width(image);
+    int height = pixman_image_get_height(image);
+    g_autoptr(Object) ioc = OBJECT(qio_channel_file_new_fd(fd));
+    g_autofree char *header = NULL;
+    g_autoptr(pixman_image_t) linebuf = NULL;
+    int y;
+
+    trace_ppm_save(fd, image);
+
+    header = g_strdup_printf("P6\n%d %d\n%d\n", width, height, 255);
+    if (qio_channel_write_all(QIO_CHANNEL(ioc),
+                              header, strlen(header), errp) < 0) {
+        return false;
+    }
+
+    linebuf = qemu_pixman_linebuf_create(PIXMAN_BE_r8g8b8, width);
+    for (y = 0; y < height; y++) {
+        qemu_pixman_linebuf_fill(linebuf, image, width, 0, y);
+        if (qio_channel_write_all(QIO_CHANNEL(ioc),
+                                  (char *)pixman_image_get_data(linebuf),
+                                  pixman_image_get_stride(linebuf), errp) < 0) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
+/* Safety: coroutine-only, concurrent-coroutine safe, main thread only */
+void coroutine_fn
+qmp_screendump(const char *filename, const char *device,
+               bool has_head, int64_t head,
+               bool has_format, ImageFormat format, Error **errp)
+{
+    g_autoptr(pixman_image_t) image = NULL;
+    QemuConsole *con;
+    DisplaySurface *surface;
+    int fd;
+
+    if (device) {
+        con = qemu_console_lookup_by_device_name(device, has_head ? head : 0,
+                                                 errp);
+        if (!con) {
+            return;
+        }
+    } else {
+        if (has_head) {
+            error_setg(errp, "'head' must be specified together with 'device'");
+            return;
+        }
+        con = qemu_console_lookup_by_index(0);
+        if (!con) {
+            error_setg(errp, "There is no console to take a screendump from");
+            return;
+        }
+    }
+
+    qemu_console_co_wait_update(con);
+
+    /*
+     * All pending coroutines are woken up, while the BQL is held.  No
+     * further graphic update are possible until it is released.  Take
+     * an image ref before that.
+     */
+    surface = qemu_console_surface(con);
+    if (!surface) {
+        error_setg(errp, "no surface");
+        return;
+    }
+    image = pixman_image_ref(surface->image);
+
+    fd = qemu_open_old(filename, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, 0666);
+    if (fd == -1) {
+        error_setg(errp, "failed to open file '%s': %s", filename,
+                   strerror(errno));
+        return;
+    }
+
+    /*
+     * The image content could potentially be updated as the coroutine
+     * yields and releases the BQL. It could produce corrupted dump, but
+     * it should be otherwise safe.
+     */
+    if (has_format && format == IMAGE_FORMAT_PNG) {
+        /* PNG format specified for screendump */
+        if (!png_save(fd, image, errp)) {
+            qemu_unlink(filename);
+        }
+    } else {
+        /* PPM format specified/default for screendump */
+        if (!ppm_save(fd, image, errp)) {
+            qemu_unlink(filename);
+        }
+    }
+}
-- 
2.41.0


