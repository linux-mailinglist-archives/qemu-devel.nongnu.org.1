Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6649D9C2CD5
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 13:18:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kIK-0003IK-5s; Sat, 09 Nov 2024 07:10:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHg-000223-8x; Sat, 09 Nov 2024 07:09:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kHe-0003yA-Du; Sat, 09 Nov 2024 07:09:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D5A85A15FC;
 Sat,  9 Nov 2024 15:07:07 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 91AC3167F8A;
 Sat,  9 Nov 2024 15:08:02 +0300 (MSK)
Received: (nullmailer pid 3295312 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 20/57] ui/dbus: fix filtering all update messages
Date: Sat,  9 Nov 2024 15:07:22 +0300
Message-Id: <20241109120801.3295120-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Filtering pending messages when a new scanout is given shouldn't discard
pending cursor changes, for example.

Since filtering happens in a different thread, use atomic set/get.

Fixes: fa88b85dea ("ui/dbus: filter out pending messages when scanout")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <20241008125028.1177932-6-marcandre.lureau@redhat.com>
(cherry picked from commit cf59889781297a5618f1735a5f31402caa806b42)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 83140f602d..b4b7e2666b 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
+#include "glib.h"
 #ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
 #endif
@@ -85,7 +86,7 @@ struct _DBusDisplayListener {
 #endif
 
     guint dbus_filter;
-    guint32 out_serial_to_discard;
+    guint32 display_serial_to_discard;
 };
 
 G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
@@ -93,10 +94,12 @@ G_DEFINE_TYPE(DBusDisplayListener, dbus_display_listener, G_TYPE_OBJECT)
 static void dbus_gfx_update(DisplayChangeListener *dcl,
                             int x, int y, int w, int h);
 
-static void ddl_discard_pending_messages(DBusDisplayListener *ddl)
+static void ddl_discard_display_messages(DBusDisplayListener *ddl)
 {
-    ddl->out_serial_to_discard = g_dbus_connection_get_last_serial(
+    guint32 serial = g_dbus_connection_get_last_serial(
         g_dbus_proxy_get_connection(G_DBUS_PROXY(ddl->proxy)));
+
+    g_atomic_int_set(&ddl->display_serial_to_discard, serial);
 }
 
 #ifdef CONFIG_OPENGL
@@ -285,7 +288,7 @@ static void dbus_scanout_dmabuf(DisplayChangeListener *dcl,
         return;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     /* FIXME: add missing x/y/w/h support */
     qemu_dbus_display1_listener_call_scanout_dmabuf(
@@ -334,7 +337,7 @@ static bool dbus_scanout_map(DBusDisplayListener *ddl)
         return false;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     if (!qemu_dbus_display1_listener_win32_map_call_scanout_map_sync(
             ddl->map_proxy,
@@ -397,7 +400,7 @@ dbus_scanout_share_d3d_texture(
         return false;
     }
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     qemu_dbus_display1_listener_win32_d3d11_call_scanout_texture2d(
         ddl->d3d11_proxy,
@@ -654,7 +657,7 @@ static void ddl_scanout(DBusDisplayListener *ddl)
         surface_stride(ddl->ds) * surface_height(ddl->ds), TRUE,
         (GDestroyNotify)pixman_image_unref, pixman_image_ref(ddl->ds->image));
 
-    ddl_discard_pending_messages(ddl);
+    ddl_discard_display_messages(ddl);
 
     qemu_dbus_display1_listener_call_scanout(
         ddl->proxy, surface_width(ddl->ds), surface_height(ddl->ds),
@@ -987,17 +990,35 @@ dbus_filter(GDBusConnection *connection,
             gpointer         user_data)
 {
     DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
-    guint32 serial;
+    guint32 serial, discard_serial;
 
     if (incoming) {
         return message;
     }
 
     serial = g_dbus_message_get_serial(message);
-    if (serial <= ddl->out_serial_to_discard) {
-        trace_dbus_filter(serial, ddl->out_serial_to_discard);
-        g_object_unref(message);
-        return NULL;
+
+    discard_serial = g_atomic_int_get(&ddl->display_serial_to_discard);
+    if (serial <= discard_serial) {
+        const char *member = g_dbus_message_get_member(message);
+        static const char *const display_messages[] = {
+            "Scanout",
+            "Update",
+#ifdef CONFIG_GBM
+            "ScanoutDMABUF",
+            "UpdateDMABUF",
+#endif
+            "ScanoutMap",
+            "UpdateMap",
+            "Disable",
+            NULL,
+        };
+
+        if (g_strv_contains(display_messages, member)) {
+            trace_dbus_filter(serial, discard_serial);
+            g_object_unref(message);
+            return NULL;
+        }
     }
 
     return message;
-- 
2.39.5


