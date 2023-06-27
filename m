Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA773FC7C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:10:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M4-00008A-5k; Tue, 27 Jun 2023 09:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ly-00005r-6w
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lu-00077p-QO
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6nlig19Z5+JstPkcp17EdrNHXbSMy8K08EOSWGRSh+I=;
 b=F4FQaLlXj4mTMIslYrCOhTQOb8/zWdADikJCr9PPmQfaiJUz13OOauDgOQyHy43GqvXwjQ
 kydy6raJw808/ZToGUz027NZQ2F+ywtqBKdH8DcBjLvC5GKG1P6HuMRQ3woHjyFZccgH/x
 k5ITOwgatHctZst94JrmbMNjgjkVqsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-DGRYbC2VPqCamHL-RWrFqA-1; Tue, 27 Jun 2023 09:03:21 -0400
X-MC-Unique: DGRYbC2VPqCamHL-RWrFqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2E8488D1B1;
 Tue, 27 Jun 2023 13:03:20 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 63CBC40C2063;
 Tue, 27 Jun 2023 13:03:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 23/33] ui/dbus: use shared memory when possible on win32
Date: Tue, 27 Jun 2023 15:02:20 +0200
Message-ID: <20230627130231.1614896-24-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

When the display surface has an associated HANDLE, we can duplicate it
to the client process and let it map the memory to avoid expensive copies.

Introduce two new win32-specific methods ScanoutMap and UpdateMap. The
first is used to inform the listener about the a shared map
availability, and the second for display updates.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-12-marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c   | 165 ++++++++++++++++++++++++++++++++++++++++++-
 ui/dbus-display1.xml |  48 ++++++++++++-
 2 files changed, 208 insertions(+), 5 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 41597a0078..f6b1cd11be 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -48,6 +48,14 @@ struct _DBusDisplayListener {
     DisplayChangeListener dcl;
     DisplaySurface *ds;
     int gl_updates;
+
+    bool ds_mapped;
+    bool can_share_map;
+
+#ifdef WIN32
+    QemuDBusDisplay1ListenerWin32Map *map_proxy;
+    HANDLE peer_process;
+#endif
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -119,7 +127,61 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         fd_list,
         NULL, NULL, NULL);
 }
+#endif /* OPENGL & GBM */
+
+#ifdef WIN32
+static bool dbus_scanout_map(DBusDisplayListener *ddl)
+{
+    g_autoptr(GError) err = NULL;
+    BOOL success;
+    HANDLE target_handle;
+
+    if (ddl->ds_mapped) {
+        return true;
+    }
+
+    if (!ddl->can_share_map || !ddl->ds->handle) {
+        return false;
+    }
+
+    success = DuplicateHandle(
+        GetCurrentProcess(),
+        ddl->ds->handle,
+        ddl->peer_process,
+        &target_handle,
+        FILE_MAP_READ | SECTION_QUERY,
+        FALSE, 0);
+    if (!success) {
+        g_autofree char *msg = g_win32_error_message(GetLastError());
+        g_debug("Failed to DuplicateHandle: %s", msg);
+        ddl->can_share_map = false;
+        return false;
+    }
+
+    if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
+            ddl->map_proxy,
+            GPOINTER_TO_UINT(target_handle),
+            ddl->ds->handle_offset,
+            surface_width(ddl->ds),
+            surface_height(ddl->ds),
+            surface_stride(ddl->ds),
+            surface_format(ddl->ds),
+            G_DBUS_CALL_FLAGS_NONE,
+            DBUS_DEFAULT_TIMEOUT,
+            NULL,
+            &err)) {
+        g_debug("Failed to call ScanoutMap: %s", err->message);
+        ddl->can_share_map = false;
+        return false;
+    }
+
+    ddl->ds_mapped = true;
+
+    return true;
+}
+#endif
 
+#if defined(CONFIG_OPENGL) && defined(CONFIG_GBM)
 static void dbus_scanout_texture(DisplayChangeListener *dcl,
                                  uint32_t tex_id,
                                  bool backing_y_0_top,
@@ -239,7 +301,7 @@ static void dbus_gl_refresh(DisplayChangeListener *dcl)
         ddl->gl_updates = 0;
     }
 }
-#endif
+#endif /* OPENGL & GBM */
 
 static void dbus_refresh(DisplayChangeListener *dcl)
 {
@@ -265,10 +327,20 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
     size_t stride;
 
     assert(ddl->ds);
-    stride = w * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(surface_format(ddl->ds)), 8);
 
     trace_dbus_update(x, y, w, h);
 
+#ifdef WIN32
+    if (dbus_scanout_map(ddl)) {
+        qemu_dbus_display1_listener_win32_map_call_update_map(
+            ddl->map_proxy,
+            x, y, w, h,
+            G_DBUS_CALL_FLAGS_NONE,
+            DBUS_DEFAULT_TIMEOUT, NULL, NULL, NULL);
+        return;
+    }
+#endif
+
     if (x == 0 && y == 0 && w == surface_width(ddl->ds) && h == surface_height(ddl->ds)) {
         v_data = g_variant_new_from_data(
             G_VARIANT_TYPE("ay"),
@@ -290,6 +362,7 @@ static void dbus_gfx_update(DisplayChangeListener *dcl,
     }
 
     /* make a copy, since gvariant only handles linear data */
+    stride = w * DIV_ROUND_UP(PIXMAN_FORMAT_BPP(surface_format(ddl->ds)), 8);
     img = pixman_image_create_bits(surface_format(ddl->ds),
                                    w, h, NULL, stride);
     pixman_image_composite(PIXMAN_OP_SRC, ddl->ds->image, NULL, img,
@@ -333,6 +406,9 @@ static void dbus_gfx_switch(DisplayChangeListener *dcl,
     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
 
     ddl->ds = new_surface;
+#ifdef WIN32
+    ddl->ds_mapped = false;
+#endif
     if (!ddl->ds) {
         /* why not call disable instead? */
         return;
@@ -414,6 +490,10 @@ dbus_display_listener_dispose(GObject *object)
     g_clear_object(&ddl->conn);
     g_clear_pointer(&ddl->bus_name, g_free);
     g_clear_object(&ddl->proxy);
+#ifdef WIN32
+    g_clear_object(&ddl->map_proxy);
+    g_clear_pointer(&ddl->peer_process, CloseHandle);
+#endif
 
     G_OBJECT_CLASS(dbus_display_listener_parent_class)->dispose(object);
 }
@@ -459,6 +539,85 @@ dbus_display_listener_get_console(DBusDisplayListener *ddl)
     return ddl->console;
 }
 
+#ifdef WIN32
+static bool
+dbus_display_listener_implements(DBusDisplayListener *ddl, const char *iface)
+{
+    QemuDBusDisplay1Listener *l = QEMU_DBUS_DISPLAY1_LISTENER(ddl->proxy);
+    bool implements;
+
+    implements = g_strv_contains(qemu_dbus_display1_listener_get_interfaces(l), iface);
+    if (!implements) {
+        g_debug("Display listener does not implement: `%s`", iface);
+    }
+
+    return implements;
+}
+#endif
+
+static void
+dbus_display_listener_setup_shared_map(DBusDisplayListener *ddl)
+{
+#ifdef WIN32
+    g_autoptr(GError) err = NULL;
+    GDBusConnection *conn;
+    GIOStream *stream;
+    GSocket *sock;
+    g_autoptr(GCredentials) creds = NULL;
+    DWORD *pid;
+
+    if (!dbus_display_listener_implements(ddl, "org.qemu.Display1.Listener.Win32.Map")) {
+        return;
+    }
+
+    conn = g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy));
+    stream = g_dbus_connection_get_stream(conn);
+
+    if (!G_IS_UNIX_CONNECTION(stream)) {
+        return;
+    }
+
+    sock = g_socket_connection_get_socket(G_SOCKET_CONNECTION(stream));
+    creds = g_socket_get_credentials(sock, &err);
+
+    if (!creds) {
+        g_debug("Failed to get peer credentials: %s", err->message);
+        return;
+    }
+
+    pid = g_credentials_get_native(creds, G_CREDENTIALS_TYPE_WIN32_PID);
+
+    if (pid == NULL) {
+        g_debug("Failed to get peer PID");
+        return;
+    }
+
+    ddl->peer_process = OpenProcess(
+        PROCESS_DUP_HANDLE | PROCESS_QUERY_INFORMATION,
+        false, *pid);
+
+    if (!ddl->peer_process) {
+        g_autofree char *msg = g_win32_error_message(GetLastError());
+        g_debug("Failed to OpenProcess: %s", msg);
+        return;
+    }
+
+    ddl->map_proxy =
+        qemu_dbus_display1_listener_win32_map_proxy_new_sync(conn,
+            G_DBUS_PROXY_FLAGS_DO_NOT_AUTO_START,
+            NULL,
+            "/org/qemu/Display1/Listener",
+            NULL,
+            &err);
+    if (!ddl->map_proxy) {
+        g_debug("Failed to setup win32 map proxy: %s", err->message);
+        return;
+    }
+
+    ddl->can_share_map = true;
+#endif
+}
+
 DBusDisplayListener *
 dbus_display_listener_new(const char *bus_name,
                           GDBusConnection *conn,
@@ -487,6 +646,8 @@ dbus_display_listener_new(const char *bus_name,
     ddl->conn = conn;
     ddl->console = console;
 
+    dbus_display_listener_setup_shared_map(ddl);
+
     con = qemu_console_lookup_by_index(dbus_display_console_get_index(console));
     assert(con);
     ddl->dcl.con = con;
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index 06e8779c04..7233286b28 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -370,9 +370,7 @@
       </arg>
     </method>
 
-    <?if $(env.TARGETOS) == windows?>
-    <!-- Add shared memory/texture support -->
-    <?else?>
+    <?if $(env.TARGETOS) != windows?>
     <!--
         ScanoutDMABUF:
         @dmabuf: the DMABUF file descriptor.
@@ -471,6 +469,50 @@
     <property name="Interfaces" type="as" access="read"/>
   </interface>
 
+  <!--
+      org.qemu.Display1.Listener.Win32.Map:
+
+      This client-side interface can complement org.qemu.Display1.Listener on
+      ``/org/qemu/Display1/Listener`` for Windows specific methods.
+  -->
+  <interface name="org.qemu.Display1.Listener.Win32.Map">
+    <!--
+        ScanoutMap:
+        @handle: the shared map handle value.
+        @offset: mapping offset.
+        @width: display width, in pixels.
+        @height: display height, in pixels.
+        @stride: stride, in bytes.
+        @pixman_format: image format (ex: ``PIXMAN_X8R8G8B8``).
+
+        Resize and update the display content with a shared map.
+    -->
+    <method name="ScanoutMap">
+      <arg type="t" name="handle" direction="in"/>
+      <arg type="u" name="offset" direction="in"/>
+      <arg type="u" name="width" direction="in"/>
+      <arg type="u" name="height" direction="in"/>
+      <arg type="u" name="stride" direction="in"/>
+      <arg type="u" name="pixman_format" direction="in"/>
+    </method>
+
+    <!--
+        UpdateMap:
+        @x: the X update position, in pixels.
+        @y: the Y update position, in pixels.
+        @width: the update width, in pixels.
+        @height: the update height, in pixels.
+
+        Update the display content with the current shared map and the given region.
+    -->
+    <method name="UpdateMap">
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


