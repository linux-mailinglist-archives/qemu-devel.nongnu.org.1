Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66FA73FC6D
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:08:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M3-000082-8h; Tue, 27 Jun 2023 09:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8M0-000070-LO
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ly-0007Bd-6f
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MfhAPe97n24USXYXdYJ8TzyLGZ9sb1ip/nyJzfrxxUE=;
 b=KTFtv5ciTP43NdO1t1KRvSZ1Drn8b3Fd3WyCk66iYCRjQXHrhKKVp/0RfQ5CcmDRaGEtar
 n2EwC4SE53c4P1s8vy2AOfyLwSlvpubRngdAsUzM7wqRdDmWfAykOejZGQXRSixQ7gNphl
 BExwyqj5I6ozWsAaOyfX06CxWMyIwKI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-YWEFyl0COviwdpR7W2A4PA-1; Tue, 27 Jun 2023 09:03:17 -0400
X-MC-Unique: YWEFyl0COviwdpR7W2A4PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1102B3811F4B;
 Tue, 27 Jun 2023 13:03:08 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C4CCF5CC6;
 Tue, 27 Jun 2023 13:03:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/33] ui/dbus: win32 support
Date: Tue, 27 Jun 2023 15:02:14 +0200
Message-ID: <20230627130231.1614896-18-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
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

D-Bus doesn't support fd-passing on Windows (AF_UNIX doesn't have
SCM_RIGHTS yet, but there are other means to share objects. I have
proposed various solutions upstream, but none seem fitting enough atm).

To make the "-display dbus" work on Windows, implement an alternative
D-Bus interface where all the 'h' (FDs) arguments are replaced with
'ay' (WSASocketW data), and sockets are passed to the other end via
WSADuplicateSocket().

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-6-marcandre.lureau@redhat.com>
---
 meson.build          |  4 +--
 ui/dbus.h            |  6 +++++
 audio/dbusaudio.c    | 44 +++++++++++++++++++++++++++------
 ui/dbus-chardev.c    | 22 +++++++++++++----
 ui/dbus-console.c    | 59 ++++++++++++++++++++++++++++++++++++++------
 ui/dbus-display1.xml | 28 +++++++++++++++++++++
 ui/meson.build       |  9 ++++++-
 7 files changed, 149 insertions(+), 23 deletions(-)

diff --git a/meson.build b/meson.build
index b409788832..9a1ce43471 100644
--- a/meson.build
+++ b/meson.build
@@ -838,6 +838,8 @@ if gdbus_codegen.found() and get_option('cfi')
   gdbus_codegen_error = '@0@ uses gdbus-codegen, which does not support control flow integrity'
 endif
 
+xml_pp = find_program('scripts/xml-preprocess.py')
+
 lttng = not_found
 if 'ust' in get_option('trace_backends')
   lttng = dependency('lttng-ust', required: true, version: '>= 2.1',
@@ -1985,8 +1987,6 @@ dbus_display = get_option('dbus_display') \
            error_message: '-display dbus requires glib>=2.64') \
   .require(gdbus_codegen.found(),
            error_message: gdbus_codegen_error.format('-display dbus')) \
-  .require(targetos != 'windows',
-           error_message: '-display dbus is not available on Windows') \
   .allowed()
 
 have_virtfs = get_option('virtfs') \
diff --git a/ui/dbus.h b/ui/dbus.h
index 9c149e7b41..1e8c24a48e 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -62,6 +62,12 @@ struct DBusDisplay {
     Notifier notifier;
 };
 
+#ifdef WIN32
+bool
+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
+                         GVariant *arg_listener, int *socket);
+#endif
+
 #define TYPE_DBUS_DISPLAY "dbus-display"
 OBJECT_DECLARE_SIMPLE_TYPE(DBusDisplay, DBUS_DISPLAY)
 
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index de59467d9e..7a11fbfb42 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -33,6 +33,7 @@
 #include <gio/gunixfdlist.h>
 #endif
 
+#include "ui/dbus.h"
 #include "ui/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
@@ -422,7 +423,6 @@ dbus_audio_fini(void *opaque)
     g_free(da);
 }
 
-#ifdef G_OS_UNIX
 static void
 listener_out_vanished_cb(GDBusConnection *connection,
                          gboolean remote_peer_vanished,
@@ -448,7 +448,9 @@ listener_in_vanished_cb(GDBusConnection *connection,
 static gboolean
 dbus_audio_register_listener(AudioState *s,
                              GDBusMethodInvocation *invocation,
+#ifdef G_OS_UNIX
                              GUnixFDList *fd_list,
+#endif
                              GVariant *arg_listener,
                              bool out)
 {
@@ -475,6 +477,11 @@ dbus_audio_register_listener(AudioState *s,
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
+#ifdef G_OS_WIN32
+    if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+#else
     fd = g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_listener), &err);
     if (err) {
         g_dbus_method_invocation_return_error(invocation,
@@ -484,6 +491,7 @@ dbus_audio_register_listener(AudioState *s,
                                               err->message);
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
+#endif
 
     socket = g_socket_new_from_fd(fd, &err);
     if (err) {
@@ -492,15 +500,28 @@ dbus_audio_register_listener(AudioState *s,
                                               DBUS_DISPLAY_ERROR_FAILED,
                                               "Couldn't make a socket: %s",
                                               err->message);
+#ifdef G_OS_WIN32
+        closesocket(fd);
+#else
+        close(fd);
+#endif
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
     socket_conn = g_socket_connection_factory_create_connection(socket);
     if (out) {
         qemu_dbus_display1_audio_complete_register_out_listener(
-            da->iface, invocation, NULL);
+            da->iface, invocation
+#ifdef G_OS_UNIX
+            , NULL
+#endif
+            );
     } else {
         qemu_dbus_display1_audio_complete_register_in_listener(
-            da->iface, invocation, NULL);
+            da->iface, invocation
+#ifdef G_OS_UNIX
+            , NULL
+#endif
+            );
     }
 
     listener_conn =
@@ -578,24 +599,33 @@ dbus_audio_register_listener(AudioState *s,
 static gboolean
 dbus_audio_register_out_listener(AudioState *s,
                                  GDBusMethodInvocation *invocation,
+#ifdef G_OS_UNIX
                                  GUnixFDList *fd_list,
+#endif
                                  GVariant *arg_listener)
 {
     return dbus_audio_register_listener(s, invocation,
-                                        fd_list, arg_listener, true);
+#ifdef G_OS_UNIX
+                                        fd_list,
+#endif
+                                        arg_listener, true);
 
 }
 
 static gboolean
 dbus_audio_register_in_listener(AudioState *s,
                                 GDBusMethodInvocation *invocation,
+#ifdef G_OS_UNIX
                                 GUnixFDList *fd_list,
+#endif
                                 GVariant *arg_listener)
 {
     return dbus_audio_register_listener(s, invocation,
-                                        fd_list, arg_listener, false);
-}
+#ifdef G_OS_UNIX
+                                        fd_list,
 #endif
+                                        arg_listener, false);
+}
 
 static void
 dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
@@ -610,14 +640,12 @@ dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
 
     da->audio = g_dbus_object_skeleton_new(DBUS_DISPLAY1_AUDIO_PATH);
     da->iface = qemu_dbus_display1_audio_skeleton_new();
-#ifdef G_OS_UNIX
     g_object_connect(da->iface,
                      "swapped-signal::handle-register-in-listener",
                      dbus_audio_register_in_listener, s,
                      "swapped-signal::handle-register-out-listener",
                      dbus_audio_register_out_listener, s,
                      NULL);
-#endif
 
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audio),
                                          G_DBUS_INTERFACE_SKELETON(da->iface));
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index 7154d81a9a..1d3a7122a1 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -110,18 +110,24 @@ dbus_chardev_init(DBusDisplay *dpy)
                          dbus_display_chardev_foreach, dpy);
 }
 
-#ifdef G_OS_UNIX
 static gboolean
 dbus_chr_register(
     DBusChardev *dc,
     GDBusMethodInvocation *invocation,
+#ifdef G_OS_UNIX
     GUnixFDList *fd_list,
+#endif
     GVariant *arg_stream,
     QemuDBusDisplay1Chardev *object)
 {
     g_autoptr(GError) err = NULL;
     int fd;
 
+#ifdef G_OS_WIN32
+    if (!dbus_win32_import_socket(invocation, arg_stream, &fd)) {
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+#else
     fd = g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_stream), &err);
     if (err) {
         g_dbus_method_invocation_return_error(
@@ -131,13 +137,18 @@ dbus_chr_register(
             "Couldn't get peer FD: %s", err->message);
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
+#endif
 
     if (qemu_chr_add_client(CHARDEV(dc), fd) < 0) {
         g_dbus_method_invocation_return_error(invocation,
                                               DBUS_DISPLAY_ERROR,
                                               DBUS_DISPLAY_ERROR_FAILED,
                                               "Couldn't register FD!");
+#ifdef G_OS_WIN32
+        closesocket(fd);
+#else
         close(fd);
+#endif
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
@@ -145,10 +156,13 @@ dbus_chr_register(
                  "owner", g_dbus_method_invocation_get_sender(invocation),
                  NULL);
 
-    qemu_dbus_display1_chardev_complete_register(object, invocation, NULL);
+    qemu_dbus_display1_chardev_complete_register(object, invocation
+#ifndef G_OS_WIN32
+                                                 , NULL
+#endif
+        );
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
-#endif
 
 static gboolean
 dbus_chr_send_break(
@@ -179,10 +193,8 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
     dc->iface = qemu_dbus_display1_chardev_skeleton_new();
     g_object_set(dc->iface, "name", backend->u.dbus.data->name, NULL);
     g_object_connect(dc->iface,
-#ifdef G_OS_UNIX
                      "swapped-signal::handle-register",
                      dbus_chr_register, dc,
-#endif
                      "swapped-signal::handle-send-break",
                      dbus_chr_send_break, dc,
                      NULL);
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index d5f6c93637..4a1c1fb55e 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -165,7 +165,6 @@ dbus_display_console_class_init(DBusDisplayConsoleClass *klass)
     gobject_class->dispose = dbus_display_console_dispose;
 }
 
-#ifdef G_OS_UNIX
 static void
 listener_vanished_cb(DBusDisplayListener *listener)
 {
@@ -177,7 +176,6 @@ listener_vanished_cb(DBusDisplayListener *listener)
     g_hash_table_remove(ddc->listeners, name);
     qkbd_state_lift_all_keys(ddc->kbd);
 }
-#endif
 
 static gboolean
 dbus_console_set_ui_info(DBusDisplayConsole *ddc,
@@ -211,11 +209,47 @@ dbus_console_set_ui_info(DBusDisplayConsole *ddc,
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
-#ifdef G_OS_UNIX
+#ifdef G_OS_WIN32
+bool
+dbus_win32_import_socket(GDBusMethodInvocation *invocation,
+                         GVariant *arg_listener, int *socket)
+{
+    gsize n;
+    WSAPROTOCOL_INFOW *info = (void *)g_variant_get_fixed_array(arg_listener, &n, 1);
+
+    if (!info || n != sizeof(*info)) {
+        g_dbus_method_invocation_return_error(
+            invocation,
+            DBUS_DISPLAY_ERROR,
+            DBUS_DISPLAY_ERROR_FAILED,
+            "Failed to get socket infos");
+        return false;
+    }
+
+    *socket = WSASocketW(FROM_PROTOCOL_INFO,
+                         FROM_PROTOCOL_INFO,
+                         FROM_PROTOCOL_INFO,
+                         info, 0, 0);
+    if (*socket == INVALID_SOCKET) {
+        g_autofree gchar *emsg = g_win32_error_message(WSAGetLastError());
+        g_dbus_method_invocation_return_error(
+            invocation,
+            DBUS_DISPLAY_ERROR,
+            DBUS_DISPLAY_ERROR_FAILED,
+            "Couldn't create socket: %s", emsg);
+        return false;
+    }
+
+    return true;
+}
+#endif
+
 static gboolean
 dbus_console_register_listener(DBusDisplayConsole *ddc,
                                GDBusMethodInvocation *invocation,
+#ifdef G_OS_UNIX
                                GUnixFDList *fd_list,
+#endif
                                GVariant *arg_listener)
 {
     const char *sender = g_dbus_method_invocation_get_sender(invocation);
@@ -237,6 +271,11 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
+#ifdef G_OS_WIN32
+    if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
+        return DBUS_METHOD_INVOCATION_HANDLED;
+    }
+#else
     fd = g_unix_fd_list_get(fd_list, g_variant_get_handle(arg_listener), &err);
     if (err) {
         g_dbus_method_invocation_return_error(
@@ -246,6 +285,7 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
             "Couldn't get peer fd: %s", err->message);
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
+#endif
 
     socket = g_socket_new_from_fd(fd, &err);
     if (err) {
@@ -254,13 +294,21 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
             DBUS_DISPLAY_ERROR,
             DBUS_DISPLAY_ERROR_FAILED,
             "Couldn't make a socket: %s", err->message);
+#ifdef G_OS_WIN32
+        closesocket(fd);
+#else
         close(fd);
+#endif
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
     socket_conn = g_socket_connection_factory_create_connection(socket);
 
     qemu_dbus_display1_console_complete_register_listener(
-        ddc->iface, invocation, NULL);
+        ddc->iface, invocation
+#ifdef G_OS_UNIX
+        , NULL
+#endif
+    );
 
     listener_conn = g_dbus_connection_new_sync(
         G_IO_STREAM(socket_conn),
@@ -287,7 +335,6 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
     trace_dbus_registered_listener(sender);
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
-#endif
 
 static gboolean
 dbus_kbd_press(DBusDisplayConsole *ddc,
@@ -516,10 +563,8 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "device-address", device_addr,
         NULL);
     g_object_connect(ddc->iface,
-#ifdef G_OS_UNIX
         "swapped-signal::handle-register-listener",
         dbus_console_register_listener, ddc,
-#endif
         "swapped-signal::handle-set-uiinfo",
         dbus_console_set_ui_info, ddc,
         NULL);
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index cc0c9b68bf..cd596f774e 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -57,7 +57,13 @@
         :dbus:iface:`org.qemu.Display1.Listener` interface.
     -->
     <method name="RegisterListener">
+      <?if $(env.TARGETOS) == windows?>
+      <arg type="ay" name="listener" direction="in">
+        <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
+      </arg>
+      <?else?>
       <arg type="h" name="listener" direction="in"/>
+      <?endif?>
     </method>
 
     <!--
@@ -334,6 +340,9 @@
       </arg>
     </method>
 
+    <?if $(env.TARGETOS) == windows?>
+    <!-- Add shared memory/texture support -->
+    <?else?>
     <!--
         ScanoutDMABUF:
         @dmabuf: the DMABUF file descriptor.
@@ -372,6 +381,7 @@
       <arg type="i" name="width" direction="in"/>
       <arg type="i" name="height" direction="in"/>
     </method>
+    <?endif?>
 
     <!--
         Disable:
@@ -532,7 +542,13 @@
         :dbus:iface:`org.qemu.Display1.AudioOutListener` interface.
     -->
     <method name="RegisterOutListener">
+      <?if $(env.TARGETOS) == windows?>
+      <arg type="ay" name="listener" direction="in">
+        <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
+      </arg>
+      <?else?>
       <arg type="h" name="listener" direction="in"/>
+      <?endif?>
     </method>
 
     <!--
@@ -547,7 +563,13 @@
         :dbus:iface:`org.qemu.Display1.AudioInListener` interface.
     -->
     <method name="RegisterInListener">
+      <?if $(env.TARGETOS) == windows?>
+      <arg type="ay" name="listener" direction="in">
+        <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
+      </arg>
+      <?else?>
       <arg type="h" name="listener" direction="in"/>
+      <?endif?>
     </method>
   </interface>
 
@@ -760,7 +782,13 @@
         The current handler, if any, will be replaced.
     -->
     <method name="Register">
+      <?if $(env.TARGETOS) == windows?>
+      <arg type="ay" name="listener" direction="in">
+        <annotation name="org.gtk.GDBus.C.ForceGVariant" value="true"/>
+      </arg>
+      <?else?>
       <arg type="h" name="stream" direction="in"/>
+      <?endif?>
     </method>
 
     <!--
diff --git a/ui/meson.build b/ui/meson.build
index a5506ac8ad..d84650676d 100644
--- a/ui/meson.build
+++ b/ui/meson.build
@@ -74,9 +74,16 @@ endif
 
 if dbus_display
   dbus_ss = ss.source_set()
+  env = environment()
+  env.set('TARGETOS', targetos)
+  xml = custom_target('dbus-display preprocess',
+                      input: 'dbus-display1.xml',
+                      output: 'dbus-display1.xml',
+                      env: env,
+                      command: [xml_pp, '@INPUT@', '@OUTPUT@'])
   dbus_display1 = custom_target('dbus-display gdbus-codegen',
                                 output: ['dbus-display1.h', 'dbus-display1.c'],
-                                input: files('dbus-display1.xml'),
+                                input: xml,
                                 command: [gdbus_codegen, '@INPUT@',
                                           '--glib-min-required', '2.64',
                                           '--output-directory', meson.current_build_dir(),
-- 
2.41.0


