Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0701773FC70
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8MW-0000QA-RV; Tue, 27 Jun 2023 09:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8MQ-0000IE-QM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8MO-0007KR-BO
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t6ZWvOQL9+SfG2hxnmzn3E+yKO80RbsyNW6nXgIiTPE=;
 b=PE7d4n+c6BQ2NTNO0Mtsp+LdiauHWn3273E8wcrPT6d++nbSdeHlw9JoG9FvQMozkFHUZQ
 IubAtLsj8d/8B9BjkCyiGzNEvTSIn/+lhDuWCkVblLpUVslR5muhvWyMZ8G0WWNBdGhyqx
 bLApjmQEzcSCoTHgjkqVi8ZCNuX2uUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-GvvD1P1JOj6nbhocdCkZKQ-1; Tue, 27 Jun 2023 09:03:52 -0400
X-MC-Unique: GvvD1P1JOj6nbhocdCkZKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB10B8C7C25;
 Tue, 27 Jun 2023 13:03:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B22D540C6CCD;
 Tue, 27 Jun 2023 13:03:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 33/33] ui/dbus: use shared D3D11 Texture2D when possible
Date: Tue, 27 Jun 2023 15:02:30 +0200
Message-ID: <20230627130231.1614896-34-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

When the client implements "org.qemu.Display1.Listener.Win32.D3d11" and
we are running on ANGLE/win32, share the scanout texture with the peer
process, and draw with ScanoutTexture2d/UpdateTexture2d methods.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-22-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c   | 299 ++++++++++++++++++++++++++++++++++++++-----
 ui/dbus-display1.xml |  56 +++++++-
 2 files changed, 324 insertions(+), 31 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 80c0fca9df..e10162b279 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -23,11 +23,16 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
 #endif
+#ifdef WIN32
+#include <d3d11.h>
+#include <dxgi1_2.h>
+#endif
 
 #ifdef CONFIG_OPENGL
 #include "ui/shader.h"
@@ -39,6 +44,12 @@
 static void dbus_gfx_switch(DisplayChangeListener *dcl,
                             struct DisplaySurface *new_surface);
 
+enum share_kind {
+    SHARE_KIND_NONE,
+    SHARE_KIND_MAPPED,
+    SHARE_KIND_D3DTEX,
+};
+
 struct _DBusDisplayListener {
     GObject parent;
 
@@ -50,6 +61,8 @@ struct _DBusDisplayListener {
 
     DisplayChangeListener dcl;
     DisplaySurface *ds;
+    enum share_kind ds_share;
+
     int gl_updates;
 
     bool ds_mapped;
@@ -57,7 +70,9 @@ struct _DBusDisplayListener {
 
 #ifdef WIN32
     QemuDBusDisplay1ListenerWin32Map *map_proxy;
+    QemuDBusDisplay1ListenerWin32D3d11 *d3d11_proxy;
     HANDLE peer_process;
+    ID3D11Texture2D *d3d_texture;
 #ifdef CONFIG_OPENGL
     egl_fb fb;
 #endif
@@ -74,28 +89,120 @@ static void dbus_scanout_disable(DisplayChangeListener *dcl)
 {
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
-    ddl->ds = NULL;
     qemu_dbus_display1_listener_call_disable(
         ddl->proxy, G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
 }
 
-#ifdef CONFIG_GBM
+#ifdef WIN32
+static bool d3d_texture2d_share(ID3D11Texture2D *d3d_texture,
+                                HANDLE *handle, Error **errp)
+{
+    IDXGIResource1 *dxgiResource = NULL;
+    HRESULT hr;
+
+    hr = d3d_texture->lpVtbl->QueryInterface(d3d_texture,
+                                             &IID_IDXGIResource1,
+                                             (void **)&dxgiResource);
+    if (FAILED(hr)) {
+        goto fail;
+    }
+
+    hr = dxgiResource->lpVtbl->CreateSharedHandle(
+        dxgiResource,
+        NULL,
+        DXGI_SHARED_RESOURCE_READ | DXGI_SHARED_RESOURCE_WRITE,
+        NULL,
+        handle
+        );
+
+    dxgiResource->lpVtbl->Release(dxgiResource);
+
+    if (SUCCEEDED(hr)) {
+        return true;
+    }
+
+fail:
+    error_setg_win32(errp, GetLastError(), "failed to create shared handle");
+    return false;
+}
+
+static bool d3d_texture2d_acquire0(ID3D11Texture2D *d3d_texture, Error **errp)
+{
+    IDXGIKeyedMutex *dxgiMutex = NULL;
+    HRESULT hr;
+
+    hr = d3d_texture->lpVtbl->QueryInterface(d3d_texture,
+                                             &IID_IDXGIKeyedMutex,
+                                             (void **)&dxgiMutex);
+    if (FAILED(hr)) {
+        goto fail;
+    }
+
+    hr = dxgiMutex->lpVtbl->AcquireSync(dxgiMutex, 0, INFINITE);
+
+    dxgiMutex->lpVtbl->Release(dxgiMutex);
+
+    if (SUCCEEDED(hr)) {
+        return true;
+    }
+
+fail:
+    error_setg_win32(errp, GetLastError(), "failed to acquire texture mutex");
+    return false;
+}
+
+static bool d3d_texture2d_release0(ID3D11Texture2D *d3d_texture, Error **errp)
+{
+    IDXGIKeyedMutex *dxgiMutex = NULL;
+    HRESULT hr;
+
+    hr = d3d_texture->lpVtbl->QueryInterface(d3d_texture,
+                                             &IID_IDXGIKeyedMutex,
+                                             (void **)&dxgiMutex);
+    if (FAILED(hr)) {
+        goto fail;
+    }
+
+    hr = dxgiMutex->lpVtbl->ReleaseSync(dxgiMutex, 0);
+
+    dxgiMutex->lpVtbl->Release(dxgiMutex);
+
+    if (SUCCEEDED(hr)) {
+        return true;
+    }
+
+fail:
+    error_setg_win32(errp, GetLastError(), "failed to release texture mutex");
+    return false;
+}
+#endif /* WIN32 */
+
 static void dbus_update_gl_cb(GObject *source_object,
-                           GAsyncResult *res,
-                           gpointer user_data)
+                              GAsyncResult *res,
+                              gpointer user_data)
 {
     g_autoptr(GError) err = NULL;
     DBusDisplayListener *ddl = user_data;
+    bool success;
+
+#ifdef CONFIG_GBM
+    success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
+        ddl->proxy, res, &err);
+#endif
+
+#ifdef WIN32
+    success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
+        ddl->d3d11_proxy, res, &err);
+    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
+#endif
 
-    if (!qemu_dbus_display1_listener_call_update_dmabuf_finish(ddl->proxy,
-                                                               res, &err)) {
+    if (!success) {
         error_report("Failed to call update: %s", err->message);
     }
 
     graphic_hw_gl_block(ddl->dcl.con, false);
     g_object_unref(ddl);
 }
-#endif
 
 static void dbus_call_update_gl(DisplayChangeListener *dcl,
                                 int x, int y, int w, int h)
@@ -116,8 +223,31 @@ static void dbus_call_update_gl(DisplayChangeListener *dcl,
 #endif
 
 #ifdef WIN32
-    egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
-    dbus_gfx_update(dcl, x, y, w, h);
+    switch (ddl->ds_share) {
+    case SHARE_KIND_MAPPED:
+        egl_fb_read_rect(ddl->ds, &ddl->fb, x, y, w, h);
+        dbus_gfx_update(dcl, x, y, w, h);
+        break;
+    case SHARE_KIND_D3DTEX:
+        Error *err = NULL;
+        assert(ddl->d3d_texture);
+
+        graphic_hw_gl_block(ddl->dcl.con, true);
+        if (!d3d_texture2d_release0(ddl->d3d_texture, &err)) {
+            error_report_err(err);
+            return;
+        }
+        qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d(
+            ddl->d3d11_proxy,
+            x, y, w, h,
+            G_DBUS_CALL_FLAGS_NONE,
+            DBUS_DEFAULT_TIMEOUT, NULL,
+            dbus_update_gl_cb,
+            g_object_ref(ddl));
+        break;
+    default:
+        g_warn_if_reached();
+    }
 #endif
 }
 
@@ -160,7 +290,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
     BOOL success;
     HANDLE target_handle;
 
-    if (ddl->ds_mapped) {
+    if (ddl->ds_share == SHARE_KIND_MAPPED) {
         return true;
     }
 
@@ -199,7 +329,69 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return false;
     }
 
-    ddl->ds_mapped = true;
+    ddl->ds_share = SHARE_KIND_MAPPED;
+
+    return true;
+}
+
+static bool
+dbus_scanout_share_d3d_texture(
+    DBusDisplayListener *ddl,
+    ID3D11Texture2D *tex,
+    bool backing_y_0_top,
+    uint32_t backing_width,
+    uint32_t backing_height,
+    uint32_t x, uint32_t y,
+    uint32_t w, uint32_t h)
+{
+    Error *err = NULL;
+    BOOL success;
+    HANDLE share_handle, target_handle;
+
+    if (!d3d_texture2d_release0(tex, &err)) {
+        error_report_err(err);
+        return false;
+    }
+
+    if (!d3d_texture2d_share(tex, &share_handle, &err)) {
+        error_report_err(err);
+        return false;
+    }
+
+    success = DuplicateHandle(
+        GetCurrentProcess(),
+        share_handle,
+        ddl->peer_process,
+        &target_handle,
+        0,
+        FALSE, DUPLICATE_SAME_ACCESS);
+    if (!success) {
+        g_autofree char *msg = g_win32_error_message(GetLastError());
+        g_debug("Failed to DuplicateHandle: %s", msg);
+        CloseHandle(share_handle);
+        return false;
+    }
+
+    qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
+        ddl->d3d11_proxy,
+        GPOINTER_TO_INT(target_handle),
+        backing_width,
+        backing_height,
+        backing_y_0_top,
+        x, y, w, h,
+        G_DBUS_CALL_FLAGS_NONE,
+        -1,
+        NULL, NULL, NULL);
+
+    CloseHandle(share_handle);
+
+    if (!d3d_texture2d_acquire0(tex, &err)) {
+        error_report_err(err);
+        return false;
+    }
+
+    ddl->d3d_texture = tex;
+    ddl->ds_share = SHARE_KIND_D3DTEX;
 
     return true;
 }
@@ -248,7 +440,14 @@ static void dbus_scanout_texture(DisplayChangeListener *dcl,
     /* there must be a matching gfx_switch before */
     assert(surface_width(ddl->ds) == w);
     assert(surface_height(ddl->ds) == h);
-    egl_fb_setup_for_tex(&ddl->fb, backing_width, backing_height, tex_id, false);
+
+    if (d3d_tex2d) {
+        dbus_scanout_share_d3d_texture(ddl, d3d_tex2d, backing_y_0_top,
+                                       backing_width, backing_height, x, y, w, h);
+    } else {
+        dbus_scanout_map(ddl);
+        egl_fb_setup_for_tex(&ddl->fb, backing_width, backing_height, tex_id, false);
+    }
 #endif
 }
 
@@ -429,6 +628,7 @@ static void dbus_gl_gfx_switch(DisplayChangeListener *dcl,
     trace_dbus_gl_gfx_switch(new_surface);
 
     ddl->ds = new_surface;
+    ddl->ds_share = SHARE_KIND_NONE;
     if (ddl->ds) {
         int width = surface_width(ddl->ds);
         int height = surface_height(ddl->ds);
@@ -446,13 +646,7 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
     ddl->ds = new_surface;
-#ifdef WIN32
-    ddl->ds_mapped = false;
-#endif
-    if (!ddl->ds) {
-        /* why not call disable instead? */
-        return;
-    }
+    ddl->ds_share = SHARE_KIND_NONE;
 }
 
 static void dbus_mouse_set(DisplayChangeListener *dcl,
@@ -534,6 +728,7 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->proxy);
 #ifdef WIN32
     g_clear_object(&ddl->map_proxy);
+    g_clear_object(&ddl->d3d11_proxy);
     g_clear_pointer(&ddl->peer_process, CloseHandle);
 #ifdef CONFIG_OPENGL
     egl_fb_destroy(&ddl->fb);
@@ -598,12 +793,10 @@ dbus_display_listener_implements(DBusDisplayListener *ddl, const char *iface)
 
     return implements;
 }
-#endif
 
-static void
-dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
+static bool
+dbus_display_listener_setup_peer_process(DBusDisplayListener *ddl)
 {
-#ifdef WIN32
     g_autoptr(GError) err = NULL;
     GDBusConnection *conn;
     GIOStream *stream;
@@ -611,15 +804,15 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
     g_autoptr(GCredentials) creds = NULL;
     DWORD *pid;
 
-    if (!dbus_display_listener_implements(ddl, "org.qemu.Display1.Listener.Win32.Map")) {
-        return;
+    if (ddl->peer_process) {
+        return true;
     }
 
     conn = g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy));
     stream = g_dbus_connection_get_stream(conn);
 
     if (!G_IS_UNIX_CONNECTION(stream)) {
-        return;
+        return false;
     }
 
     sock = g_socket_connection_get_socket(G_SOCKET_CONNECTION(stream));
@@ -627,14 +820,14 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
 
     if (!creds) {
         g_debug("Failed to get peer credentials: %s", err->message);
-        return;
+        return false;
     }
 
     pid = g_credentials_get_native(creds, G_CREDENTIALS_TYPE_WIN32_PID);
 
     if (pid == NULL) {
         g_debug("Failed to get peer PID");
-        return;
+        return false;
     }
 
     ddl->peer_process = OpenProcess(
@@ -644,11 +837,58 @@ dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
     if (!ddl->peer_process) {
         g_autofree char *msg = g_win32_error_message(GetLastError());
         g_debug("Failed to OpenProcess: %s", msg);
+        return false;
+    }
+
+    return true;
+}
+#endif
+
+static void
+dbus_display_listener_setup_d3d11(DBusDisplayListener *ddl)
+{
+#ifdef WIN32
+    g_autoptr(GError) err = NULL;
+
+    if (!dbus_display_listener_implements(ddl,
+            "org.qemu.Display1.Listener.Win32.D3d11")) {
+        return;
+    }
+
+    if (!dbus_display_listener_setup_peer_process(ddl)) {
+        return;
+    }
+
+    ddl->d3d11_proxy =
+        qemu_dbus_display1_listener_win32_d3d11_proxy_new_sync(ddl->conn,
+            G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START,
+            NULL,
+            "/org/qemu/Display1/Listener",
+            NULL,
+            &err);
+    if (!ddl->d3d11_proxy) {
+        g_debug("Failed to setup win32 d3d11 proxy: %s", err->message);
+        return;
+    }
+#endif
+}
+
+static void
+dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
+{
+#ifdef WIN32
+    g_autoptr(GError) err = NULL;
+
+    if (!dbus_display_listener_implements(ddl, "org.qemu.Display1.Listener.Win32.Map")) {
+        return;
+    }
+
+    if (!dbus_display_listener_setup_peer_process(ddl)) {
         return;
     }
 
     ddl->map_proxy =
-        qemu_dbus_display1_listener_win32_map_proxy_new_sync(conn,
+        qemu_dbus_display1_listener_win32_map_proxy_new_sync(ddl->conn,
             G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START,
             NULL,
             "/org/qemu/Display1/Listener",
@@ -692,6 +932,7 @@ dbus_display_listener_new(const char *bus_name,
     ddl->console = console;
 
     dbus_display_listener_setup_shared_map(ddl);
+    dbus_display_listener_setup_d3d11(ddl);
 
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 7233286b28..f0e2fac212 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -472,8 +472,9 @@
   <!--
       org.qemu.Display1.Listener.Win32.Map:
 
-      This client-side interface can complement org.qemu.Display1.Listener on
-      ``/org/qemu/Display1/Listener`` for Windows specific methods.
+      This optional client-side interface can complement
+      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for Windows
+      specific shared memory scanouts.
   -->
   <interface name="org.qemu.Display1.Listener.Win32.Map">
     <!--
@@ -513,6 +514,57 @@
     </method>
   </interface>
 
+  <!--
+      org.qemu.Display1.Listener.Win32.D3d11:
+
+      This optional client-side interface can complement
+      org.qemu.Display1.Listener on ``/org/qemu/Display1/Listener`` for Windows
+      specific Direct3D texture sharing of the scanouts.
+  -->
+  <interface name="org.qemu.Display1.Listener.Win32.D3d11">
+    <!--
+        ScanoutTexture2d:
+        @handle: the NT handle for the shared texture (to be opened back with ID3D11Device1::OpenSharedResource1).
+        @texture_width: texture width, in pixels.
+        @texture_height: texture height, in pixels.
+        @y0_top: whether Y position 0 is the top or not.
+        @x: the X scanout position, in pixels.
+        @y: the Y scanout position, in pixels.
+        @width: the scanout width, in pixels.
+        @height: the scanout height, in pixels.
+
+        Resize and update the display content with a Direct3D 11 2D texture.
+        You must acquire and release the associated KeyedMutex 0 during rendering.
+    -->
+    <method name="ScanoutTexture2d">
+      <arg type="t" name="handle" direction="in"/>
+      <arg type="u" name="texture_width" direction="in"/>
+      <arg type="u" name="texture_height" direction="in"/>
+      <arg type="b" name="y0_top" direction="in"/>
+      <arg type="u" name="x" direction="in"/>
+      <arg type="u" name="y" direction="in"/>
+      <arg type="u" name="width" direction="in"/>
+      <arg type="u" name="height" direction="in"/>
+    </method>
+
+    <!--
+        UpdateTexture2d:
+        @x: the X update position, in pixels.
+        @y: the Y update position, in pixels.
+        @width: the update width, in pixels.
+        @height: the update height, in pixels.
+
+        Update the display content with the current Direct3D 2D texture and the given region.
+        You must acquire and release the associated KeyedMutex 0 during rendering.
+    -->
+    <method name="UpdateTexture2d">
+      <arg type="i" name="x" direction="in"/>
+      <arg type="i" name="y" direction="in"/>
+      <arg type="i" name="width" direction="in"/>
+      <arg type="i" name="height" direction="in"/>
+    </method>
+  </interface>
+
   <!--
       org.qemu.Display1.Clipboard:
 
-- 
2.41.0


