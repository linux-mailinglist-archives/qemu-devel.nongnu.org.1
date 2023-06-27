Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A70E873FC5B
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Lr-0008V0-Sg; Tue, 27 Jun 2023 09:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lh-0008UE-RM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Le-000749-Vm
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TJ/y/2ZYdkiikxVR+2QxS0YHBWZuSz8vWopSq/Tcy+Q=;
 b=U3mZboE59LKdru4eVLFcOk9Dc+OSq5OCfQmwGgxC1NygMCDgxC1MgklwtJfRMNhNHBdV3A
 IhTEAS7+bhxA/aElm6dRSQ3nAZvsOX6py5qEzbiID2xgPHweOkDrMprnTw0v1f6om7AN+c
 8sxE2BPJsqkurghi/DfmuSJrVPF/jo8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-TTVnnDVmMx-HcSknMmxyug-1; Tue, 27 Jun 2023 09:03:03 -0400
X-MC-Unique: TTVnnDVmMx-HcSknMmxyug-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AE15280AA36;
 Tue, 27 Jun 2023 13:03:03 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E72D940C206F;
 Tue, 27 Jun 2023 13:03:02 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 15/33] ui/dbus: compile without gio/gunixfdlist.h
Date: Tue, 27 Jun 2023 15:02:12 +0200
Message-ID: <20230627130231.1614896-16-marcandre.lureau@redhat.com>
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

D-Bus on windows doesn't support fd-passing. Let's isolate the
fdlist-related code as a first step, before adding Windows support,
using another mechanism.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230606115658.677673-4-marcandre.lureau@redhat.com>
---
 audio/dbusaudio.c  | 7 +++++++
 ui/dbus-chardev.c  | 6 ++++++
 ui/dbus-console.c  | 8 ++++++++
 ui/dbus-listener.c | 2 ++
 4 files changed, 23 insertions(+)

diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index fece74f78c..de59467d9e 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -29,7 +29,10 @@
 #include "qemu/timer.h"
 #include "qemu/dbus.h"
 
+#ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
+#endif
+
 #include "ui/dbus-display1.h"
 
 #define AUDIO_CAP "dbus"
@@ -419,6 +422,7 @@ dbus_audio_fini(void *opaque)
     g_free(da);
 }
 
+#ifdef G_OS_UNIX
 static void
 listener_out_vanished_cb(GDBusConnection *connection,
                          gboolean remote_peer_vanished,
@@ -591,6 +595,7 @@ dbus_audio_register_in_listener(AudioState *s,
     return dbus_audio_register_listener(s, invocation,
                                         fd_list, arg_listener, false);
 }
+#endif
 
 static void
 dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
@@ -605,12 +610,14 @@ dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
 
     da->audio = g_dbus_object_skeleton_new(DBUS_DISPLAY1_AUDIO_PATH);
     da->iface = qemu_dbus_display1_audio_skeleton_new();
+#ifdef G_OS_UNIX
     g_object_connect(da->iface,
                      "swapped-signal::handle-register-in-listener",
                      dbus_audio_register_in_listener, s,
                      "swapped-signal::handle-register-out-listener",
                      dbus_audio_register_out_listener, s,
                      NULL);
+#endif
 
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audio),
                                          G_DBUS_INTERFACE_SKELETON(da->iface));
diff --git a/ui/dbus-chardev.c b/ui/dbus-chardev.c
index 940ef937cd..7154d81a9a 100644
--- a/ui/dbus-chardev.c
+++ b/ui/dbus-chardev.c
@@ -27,7 +27,9 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 
+#ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
+#endif
 
 #include "dbus.h"
 
@@ -108,6 +110,7 @@ dbus_chardev_init(DBusDisplay *dpy)
                          dbus_display_chardev_foreach, dpy);
 }
 
+#ifdef G_OS_UNIX
 static gboolean
 dbus_chr_register(
     DBusChardev *dc,
@@ -145,6 +148,7 @@ dbus_chr_register(
     qemu_dbus_display1_chardev_complete_register(object, invocation, NULL);
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
+#endif
 
 static gboolean
 dbus_chr_send_break(
@@ -175,8 +179,10 @@ dbus_chr_open(Chardev *chr, ChardevBackend *backend,
     dc->iface = qemu_dbus_display1_chardev_skeleton_new();
     g_object_set(dc->iface, "name", backend->u.dbus.data->name, NULL);
     g_object_connect(dc->iface,
+#ifdef G_OS_UNIX
                      "swapped-signal::handle-register",
                      dbus_chr_register, dc,
+#endif
                      "swapped-signal::handle-send-break",
                      dbus_chr_send_break, dc,
                      NULL);
diff --git a/ui/dbus-console.c b/ui/dbus-console.c
index bc97614fec..d5f6c93637 100644
--- a/ui/dbus-console.c
+++ b/ui/dbus-console.c
@@ -28,7 +28,9 @@
 #include "ui/kbd-state.h"
 #include "trace.h"
 
+#ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
+#endif
 
 #include "dbus.h"
 
@@ -163,6 +165,7 @@ dbus_display_console_class_init(DBusDisplayConsoleClass *klass)
     gobject_class->dispose = dbus_display_console_dispose;
 }
 
+#ifdef G_OS_UNIX
 static void
 listener_vanished_cb(DBusDisplayListener *listener)
 {
@@ -174,6 +177,7 @@ listener_vanished_cb(DBusDisplayListener *listener)
     g_hash_table_remove(ddc->listeners, name);
     qkbd_state_lift_all_keys(ddc->kbd);
 }
+#endif
 
 static gboolean
 dbus_console_set_ui_info(DBusDisplayConsole *ddc,
@@ -207,6 +211,7 @@ dbus_console_set_ui_info(DBusDisplayConsole *ddc,
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+#ifdef G_OS_UNIX
 static gboolean
 dbus_console_register_listener(DBusDisplayConsole *ddc,
                                GDBusMethodInvocation *invocation,
@@ -282,6 +287,7 @@ dbus_console_register_listener(DBusDisplayConsole *ddc,
     trace_dbus_registered_listener(sender);
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
+#endif
 
 static gboolean
 dbus_kbd_press(DBusDisplayConsole *ddc,
@@ -510,8 +516,10 @@ dbus_display_console_new(DBusDisplay *display, QemuConsole *con)
         "device-address", device_addr,
         NULL);
     g_object_connect(ddc->iface,
+#ifdef G_OS_UNIX
         "swapped-signal::handle-register-listener",
         dbus_console_register_listener, ddc,
+#endif
         "swapped-signal::handle-set-uiinfo",
         dbus_console_set_ui_info, ddc,
         NULL);
diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 23034eebf9..41597a0078 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -25,7 +25,9 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "dbus.h"
+#ifdef G_OS_UNIX
 #include <gio/gunixfdlist.h>
+#endif
 
 #ifdef CONFIG_OPENGL
 #include "ui/shader.h"
-- 
2.41.0


