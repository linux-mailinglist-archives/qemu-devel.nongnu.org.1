Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D9994C46
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Oct 2024 14:52:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy9gw-0007um-Ca; Tue, 08 Oct 2024 08:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gb-0007eF-BA
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1sy9gZ-0002UR-Uy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 08:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728391891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gd9LY4ufrKnT0R27KEAdgV8A5m6TeqPnj0s8obdbeOQ=;
 b=InFdFwevszYprFJwUOEJoBkaAOTo9Umta6jgook8bMaiKnT63sStWg9bixvQCPTzOUV0dG
 27Jp/gHQ3Cz3n+UcwA2o4nxJ88pQcLuVCLMS8nXrAa7vvrsMbvPmddWnQj31/5ZwiKaeTC
 4QI9+1ppBF/0bbs0EiXfZBVZ9G5hx40=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-V8Fto7DiM-2GrWISBvq0fQ-1; Tue,
 08 Oct 2024 08:51:27 -0400
X-MC-Unique: V8Fto7DiM-2GrWISBvq0fQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 122D11955DD6; Tue,  8 Oct 2024 12:51:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99A2230001B5; Tue,  8 Oct 2024 12:51:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, belmouss@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v2 10/19] ui/dbus: do not limit to one listener per connection
 / bus name
Date: Tue,  8 Oct 2024 16:50:19 +0400
Message-ID: <20241008125028.1177932-11-marcandre.lureau@redhat.com>
In-Reply-To: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
References: <20241008125028.1177932-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is an arbitrary limitation that doesn't concern QEMU directly and
may make some use cases unnecessarily more complicated.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-console.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index 578b67f62b..5eb1d40d16 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -41,7 +41,7 @@ struct _DBusDisplayConsole {
     DisplayChangeListener dcl;
 
     DBusDisplay *display;
-    GHashTable *listeners;
+    GPtrArray *listeners;
     QemuDBusDisplay1Console *iface;
 
     QemuDBusDisplay1Keyboard *iface_kbd;
@@ -142,8 +142,7 @@ dbus_display_console_init(DBusDisplayConsole *object)
 {
     DBusDisplayConsole *ddc = DBUS_DISPLAY_CONSOLE(object);
 
-    ddc->listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
-                                            NULL, g_object_unref);
+    ddc->listeners = g_ptr_array_new_with_free_func(g_object_unref);
     ddc->dcl.ops = &dbus_console_dcl_ops;
 }
 
@@ -157,7 +156,7 @@ dbus_display_console_dispose(GObject *object)
     g_clear_object(&ddc->iface_mouse);
     g_clear_object(&ddc->iface_kbd);
     g_clear_object(&ddc->iface);
-    g_clear_pointer(&ddc->listeners, g_hash_table_unref);
+    g_clear_pointer(&ddc->listeners, g_ptr_array_unref);
     g_clear_pointer(&ddc->kbd, qkbd_state_free);
 
     G_OBJECT_CLASS(dbus_display_console_parent_class)->dispose(object);
@@ -179,7 +178,7 @@ listener_vanished_cb(DBusDisplayListener *listener)
 
     trace_dbus_listener_vanished(name);
 
-    g_hash_table_remove(ddc->listeners, name);
+    g_ptr_array_remove_fast(ddc->listeners, listener);
     qkbd_state_lift_all_keys(ddc->kbd);
 }
 
@@ -267,16 +266,6 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
     DBusDisplayListener *listener;
     int fd;
 
-    if (sender && g_hash_table_contains(ddc->listeners, sender)) {
-        g_dbus_method_invocation_return_error(
-            invocation,
-            DBUS_DISPLAY_ERROR,
-            DBUS_DISPLAY_ERROR_INVALID,
-            "`%s` is already registered!",
-            sender);
-        return DBUS_METHOD_INVOCATION_HANDLED;
-    }
-
 #ifdef G_OS_WIN32
     if (!dbus_win32_import_socket(invocation, arg_listener, &fd)) {
         return DBUS_METHOD_INVOCATION_HANDLED;
@@ -331,9 +320,7 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
         return DBUS_METHOD_INVOCATION_HANDLED;
     }
 
-    g_hash_table_insert(ddc->listeners,
-                        (gpointer)dbus_display_listener_get_bus_name(listener),
-                        listener);
+    g_ptr_array_add(ddc->listeners, listener);
     g_object_connect(listener_conn,
                      "swapped-signal::closed", listener_vanished_cb, listener,
                      NULL);
-- 
2.47.0


