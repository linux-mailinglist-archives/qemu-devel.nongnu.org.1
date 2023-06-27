Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3656D73FC88
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8M2-00007t-M8; Tue, 27 Jun 2023 09:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Ly-00005s-7A
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Lu-00077W-QT
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687871004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E2I87G2v8H723uGWkAnAPdM92zLKP2WkUN6HDpeAYak=;
 b=OtkiHUc0M+qpLp9WVGDjART1vYkYfgN83jfNYSLB7SkJmCZmoZ5AUqWkZqBjlS9qGXf89I
 x5Y+VjnSJsYxzfpuHI2VpC0S4GLdgnzBHdjVohcE6Bzfj7cwhoKQVUVXunvIM35BWy9RkI
 av32tQ/TR0iCbsx9V0ssXoIZnqL0rJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-1vc4BpI_Ozu1GEKtCPQG5g-1; Tue, 27 Jun 2023 09:03:20 -0400
X-MC-Unique: 1vc4BpI_Ozu1GEKtCPQG5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EAC510504C4;
 Tue, 27 Jun 2023 13:03:12 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2A4040C2063;
 Tue, 27 Jun 2023 13:03:11 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 19/33] tests: make dbus-display-test work on win32
Date: Tue, 27 Jun 2023 15:02:16 +0200
Message-ID: <20230627130231.1614896-20-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230606115658.677673-8-marcandre.lureau@redhat.com>
---
 tests/qtest/dbus-display-test.c | 43 ++++++++++++++++++++++++++++++---
 tests/qtest/meson.build         |  2 +-
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-test.c
index fef025ac6f..21edaa1e32 100644
--- a/tests/qtest/dbus-display-test.c
+++ b/tests/qtest/dbus-display-test.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/sockets.h"
 #include "qemu/dbus.h"
 #include "qemu/sockets.h"
 #include <gio/gio.h>
@@ -14,7 +15,11 @@ test_dbus_p2p_from_fd(int fd)
     g_autoptr(GSocketConnection) socketc = NULL;
     GDBusConnection *conn;
 
+#ifdef WIN32
+    socket = g_socket_new_from_fd(_get_osfhandle(fd), &err);
+#else
     socket = g_socket_new_from_fd(fd, &err);
+#endif
     g_assert_no_error(err);
 
     socketc = g_socket_connection_factory_create_connection(socket);
@@ -126,7 +131,10 @@ test_dbus_console_registered(GObject *source_object,
 
     qemu_dbus_display1_console_call_register_listener_finish(
         QEMU_DBUS_DISPLAY1_CONSOLE(source_object),
-        NULL, res, &err);
+#ifndef WIN32
+        NULL,
+#endif
+        res, &err);
     g_assert_no_error(err);
 
     test->listener_conn = g_thread_join(test->thread);
@@ -145,17 +153,25 @@ test_dbus_display_console(void)
     g_autoptr(GError) err = NULL;
     g_autoptr(GDBusConnection) conn = NULL;
     g_autoptr(QemuDBusDisplay1ConsoleProxy) console = NULL;
-    g_autoptr(GUnixFDList) fd_list = NULL;
     g_autoptr(GMainLoop) loop = NULL;
     QTestState *qts = NULL;
-    int pair[2], idx;
+    int pair[2];
     TestDBusConsoleRegister test;
+#ifdef WIN32
+    WSAPROTOCOL_INFOW info;
+    g_autoptr(GVariant) listener = NULL;
+#else
+    g_autoptr(GUnixFDList) fd_list = NULL;
+    int idx;
+#endif
 
     test_setup(&qts, &conn);
 
     g_assert_cmpint(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair), ==, 0);
+#ifndef WIN32
     fd_list = g_unix_fd_list_new();
     idx = g_unix_fd_list_append(fd_list, pair[1], NULL);
+#endif
 
     console = QEMU_DBUS_DISPLAY1_CONSOLE_PROXY(
         qemu_dbus_display1_console_proxy_new_sync(
@@ -171,12 +187,33 @@ test_dbus_display_console(void)
     test.thread = g_thread_new(NULL, test_dbus_p2p_server_setup_thread,
                                GINT_TO_POINTER(pair[0]));
 
+#ifdef WIN32
+    if (WSADuplicateSocketW(_get_osfhandle(pair[1]),
+                            GetProcessId((HANDLE) qtest_pid(qts)),
+                            &info) == SOCKET_ERROR)
+    {
+        g_autofree char *emsg = g_win32_error_message(WSAGetLastError());
+        g_error("WSADuplicateSocket failed: %s", emsg);
+    }
+    close(pair[1]);
+    listener = g_variant_new_fixed_array(G_VARIANT_TYPE_BYTE,
+                                         &info,
+                                         sizeof(info),
+                                         1);
+#endif
+
     qemu_dbus_display1_console_call_register_listener(
         QEMU_DBUS_DISPLAY1_CONSOLE(console),
+#ifdef WIN32
+        listener,
+#else
         g_variant_new_handle(idx),
+#endif
         G_DBUS_CALL_FLAGS_NONE,
         -1,
+#ifndef WIN32
         fd_list,
+#endif
         NULL,
         test_dbus_console_registered,
         &test);
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 5fa6833ad7..74630f6672 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -104,7 +104,7 @@ qtests_i386 = \
    'numa-test'
   ]
 
-if dbus_display and targetos != 'windows'
+if dbus_display
   qtests_i386 += ['dbus-display-test']
 endif
 
-- 
2.41.0


