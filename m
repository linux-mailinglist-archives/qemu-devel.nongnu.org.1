Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E910F73FC65
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:06:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MB-0000DN-H5; Tue, 27 Jun 2023 09:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M0-00006U-AG
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lx-0007Ae-B2
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qsxc/cKsiTZ/ZZMV1rebGFc/B2lZvncDKvClLyAnOuk=;
 b=IgQxZ3tMoubBX16VCMH2sO1T2fMB0io6Ud9rtBIxdh1cpf/8QML84DayRbk0dlDArbrPZv
 OwjieJV0P+Gm2Oloo3PvvCbD9ddUJtLps3YKcOTSfLzE8Y6gHwBDQPf8FpRR0NhlAqkS8w
 TdkRkKFGW9c1+IOmDtRDDa01QUAE/H8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-msiSUr85O1mc1s-Ej00wmg-1; Tue, 27 Jun 2023 09:03:20 -0400
X-MC-Unique: msiSUr85O1mc1s-Ej00wmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E663C1CB0B;
 Tue, 27 Jun 2023 13:03:16 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9204A2166B25;
 Tue, 27 Jun 2023 13:03:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 21/33] console/win32: allocate shareable display surface
Date: Tue, 27 Jun 2023 15:02:18 +0200
Message-ID: <20230627130231.1614896-22-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Introduce qemu_win32_map_alloc() and qemu_win32_map_free() to allocate
shared memory mapping. The handle can be used to share the mapping with
another process.

Teach qemu_create_displaysurface() to allocate shared memory. Following
patches will introduce other places for shared memory allocation.

Other patches for -display dbus will share the memory when possible with
the client, to avoid expensive memory copy between the processes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-10-marcandre.lureau@redhat.com>
---
 include/sysemu/os-win32.h |  3 ++
 include/ui/console.h      |  8 ++++++
 ui/console.c              | 59 ++++++++++++++++++++++++++++++++++-----
 ui/qemu-pixman.c          |  1 +
 util/oslib-win32.c        | 33 ++++++++++++++++++++++
 ui/trace-events           |  2 +-
 util/trace-events         |  4 +++
 7 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 65f6c9ea57..91aa0d7ec0 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -263,6 +263,9 @@ EXCEPTION_DISPOSITION
 win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,
                               struct _CONTEXT*, void*);
 
+void *qemu_win32_map_alloc(size_t size, HANDLE *h, Error **errp);
+void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/include/ui/console.h b/include/ui/console.h
index 2093e2a3ba..2ab0c7112a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -143,6 +143,10 @@ typedef struct DisplaySurface {
     GLenum gltype;
     GLuint texture;
 #endif
+#ifdef WIN32
+    HANDLE handle;
+    uint32_t handle_offset;
+#endif
 } DisplaySurface;
 
 typedef struct QemuUIInfo {
@@ -329,6 +333,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
 DisplaySurface *qemu_create_displaysurface_pixman(pixman_image_t *image);
 DisplaySurface *qemu_create_placeholder_surface(int w, int h,
                                                 const char *msg);
+#ifdef WIN32
+void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
+                                          HANDLE h, uint32_t offset);
+#endif
 PixelFormat qemu_default_pixelformat(int bpp);
 
 DisplaySurface *qemu_create_displaysurface(int width, int height);
diff --git a/ui/console.c b/ui/console.c
index cfaa43e970..4957110723 100644
--- a/ui/console.c
+++ b/ui/console.c
@@ -1513,18 +1513,59 @@ static QemuConsole *new_console(DisplayState *ds, console_type_t console_type,
     return s;
 }
 
+#ifdef WIN32
+void qemu_displaysurface_win32_set_handle(DisplaySurface *surface,
+                                          HANDLE h, uint32_t offset)
+{
+    assert(!surface->handle);
+
+    surface->handle = h;
+    surface->handle_offset = offset;
+}
+
+static void
+win32_pixman_image_destroy(pixman_image_t *image, void *data)
+{
+    DisplaySurface *surface = data;
+
+    if (!surface->handle) {
+        return;
+    }
+
+    assert(surface->handle_offset == 0);
+
+    qemu_win32_map_free(
+        pixman_image_get_data(surface->image),
+        surface->handle,
+        &error_warn
+    );
+}
+#endif
+
 DisplaySurface *qemu_create_displaysurface(int width, int height)
 {
-    DisplaySurface *surface = g_new0(DisplaySurface, 1);
+    DisplaySurface *surface;
+    void *bits = NULL;
+#ifdef WIN32
+    HANDLE handle = NULL;
+#endif
 
-    trace_displaysurface_create(surface, width, height);
-    surface->format = PIXMAN_x8r8g8b8;
-    surface->image = pixman_image_create_bits(surface->format,
-                                              width, height,
-                                              NULL, width * 4);
-    assert(surface->image != NULL);
+    trace_displaysurface_create(width, height);
+
+#ifdef WIN32
+    bits = qemu_win32_map_alloc(width * height * 4, &handle, &error_abort);
+#endif
+
+    surface = qemu_create_displaysurface_from(
+        width, height,
+        PIXMAN_x8r8g8b8,
+        width * 4, bits
+    );
     surface->flags = QEMU_ALLOCATED_FLAG;
 
+#ifdef WIN32
+    qemu_displaysurface_win32_set_handle(surface, handle, 0);
+#endif
     return surface;
 }
 
@@ -1540,6 +1581,10 @@ DisplaySurface *qemu_create_displaysurface_from(int width, int height,
                                               width, height,
                                               (void *)data, linesize);
     assert(surface->image != NULL);
+#ifdef WIN32
+    pixman_image_set_destroy_function(surface->image,
+                                      win32_pixman_image_destroy, surface);
+#endif
 
     return surface;
 }
diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 3ab7e2e958..e4f024a85e 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -6,6 +6,7 @@
 #include "qemu/osdep.h"
 #include "ui/console.h"
 #include "standard-headers/drm/drm_fourcc.h"
+#include "trace.h"
 
 PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
 {
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index fafbab80b4..429542face 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -835,3 +835,36 @@ int qemu_msync(void *addr, size_t length, int fd)
      */
     return qemu_fdatasync(fd);
 }
+
+void *qemu_win32_map_alloc(size_t size, HANDLE *h, Error **errp)
+{
+    void *bits;
+
+    trace_win32_map_alloc(size);
+
+    *h = CreateFileMapping(INVALID_HANDLE_VALUE, NULL, PAGE_READWRITE, 0,
+                          size, NULL);
+    if (*h == NULL) {
+        error_setg_win32(errp, GetLastError(), "Failed to CreateFileMapping");
+        return NULL;
+    }
+
+    bits = MapViewOfFile(*h, FILE_MAP_ALL_ACCESS, 0, 0, size);
+    if (bits == NULL) {
+        error_setg_win32(errp, GetLastError(), "Failed to MapViewOfFile");
+        CloseHandle(*h);
+        return NULL;
+    }
+
+    return bits;
+}
+
+void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
+{
+    trace_win32_map_free(ptr, h);
+
+    if (UnmapViewOfFile(ptr) == 0) {
+        error_setg_win32(errp, GetLastError(), "Failed to UnmapViewOfFile");
+    }
+    CloseHandle(h);
+}
diff --git a/ui/trace-events b/ui/trace-events
index 138a09cc03..a71895c479 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -9,7 +9,7 @@ console_putchar_unhandled(int ch) "unhandled escape character '%c'"
 console_txt_new(int w, int h) "%dx%d"
 console_select(int nr) "%d"
 console_refresh(int interval) "interval %d ms"
-displaysurface_create(void *display_surface, int w, int h) "surface=%p, %dx%d"
+displaysurface_create(int w, int h) "%dx%d"
 displaysurface_create_from(void *display_surface, int w, int h, uint32_t format) "surface=%p, %dx%d, format 0x%x"
 displaysurface_create_pixman(void *display_surface) "surface=%p"
 displaysurface_free(void *display_surface) "surface=%p"
diff --git a/util/trace-events b/util/trace-events
index 3f7e766683..49a4962e18 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -52,6 +52,10 @@ qemu_anon_ram_alloc(size_t size, void *ptr) "size %zu ptr %p"
 qemu_vfree(void *ptr) "ptr %p"
 qemu_anon_ram_free(void *ptr, size_t size) "ptr %p size %zu"
 
+# oslib-win32.c
+win32_map_alloc(size_t size) "size:%zd"
+win32_map_free(void *ptr, void *h) "ptr:%p handle:%p"
+
 # hbitmap.c
 hbitmap_iter_skip_words(const void *hb, void *hbi, uint64_t pos, unsigned long cur) "hb %p hbi %p pos %"PRId64" cur 0x%lx"
 hbitmap_reset(void *hb, uint64_t start, uint64_t count, uint64_t sbit, uint64_t ebit) "hb %p items %"PRIu64",%"PRIu64" bits %"PRIu64"..%"PRIu64
-- 
2.41.0


