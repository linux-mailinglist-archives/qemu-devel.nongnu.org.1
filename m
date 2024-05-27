Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678028CF96C
	for <lists+qemu-devel@lfdr.de>; Mon, 27 May 2024 08:42:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBU34-0003Cd-IK; Mon, 27 May 2024 02:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU30-0003By-DS; Mon, 27 May 2024 02:41:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sBU2m-0007Ip-Ec; Mon, 27 May 2024 02:41:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D3426A3F2;
 Mon, 27 May 2024 09:41:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id E6D6BD83EA;
 Mon, 27 May 2024 09:40:56 +0300 (MSK)
Received: (nullmailer pid 50270 invoked by uid 1000);
 Mon, 27 May 2024 06:40:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.12 04/19] nbd/server: do not poll within a coroutine
 context
Date: Mon, 27 May 2024 09:40:35 +0300
Message-Id: <20240527064056.50205-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
References: <qemu-stable-7.2.12-20240527072010@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhu Yangyang <zhuyangyang14@huawei.com>

Coroutines are not supposed to block. Instead, they should yield.

The client performs TLS upgrade outside of an AIOContext, during
synchronous handshake; this still requires g_main_loop.  But the
server responds to TLS upgrade inside a coroutine, so a nested
g_main_loop is wrong.  Since the two callbacks no longer share more
than the setting of data.complete and data.error, it's just as easy to
use static helpers instead of trying to share a common code path.  It
is also possible to add assertions that no other code is interfering
with the eventual path to qio reaching the callback, whether or not it
required a yield or main loop.

Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
[eblake: move callbacks to their use point, add assertions]
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240408160214.1200629-5-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
(cherry picked from commit ae6d91a7e9b77abb029ed3fa9fad461422286942)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/nbd/client.c b/nbd/client.c
index 30d5383cb1..15503d0928 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -596,13 +596,31 @@ static int nbd_request_simple_option(QIOChannel *ioc, int opt, bool strict,
     return 1;
 }
 
+/* Callback to learn when QIO TLS upgrade is complete */
+struct NBDTLSClientHandshakeData {
+    bool complete;
+    Error *error;
+    GMainLoop *loop;
+};
+
+static void nbd_client_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSClientHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (data->loop) {
+        g_main_loop_quit(data->loop);
+    }
+}
+
 static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
                                         QCryptoTLSCreds *tlscreds,
                                         const char *hostname, Error **errp)
 {
     int ret;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+    struct NBDTLSClientHandshakeData data = { 0 };
 
     ret = nbd_request_simple_option(ioc, NBD_OPT_STARTTLS, true, errp);
     if (ret <= 0) {
@@ -619,18 +637,20 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
         return NULL;
     }
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-client-tls");
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
     trace_nbd_receive_starttls_tls_handshake();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_client_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
     if (!data.complete) {
+        data.loop = g_main_loop_new(g_main_context_default(), FALSE);
         g_main_loop_run(data.loop);
+        assert(data.complete);
+        g_main_loop_unref(data.loop);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         error_propagate(errp, data.error);
         object_unref(OBJECT(tioc));
diff --git a/nbd/common.c b/nbd/common.c
index ddfe7d1183..c201b58a83 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -47,17 +47,6 @@ int nbd_drop(QIOChannel *ioc, size_t size, Error **errp)
 }
 
 
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque)
-{
-    struct NBDTLSHandshakeData *data = opaque;
-
-    qio_task_propagate_error(task, &data->error);
-    data->complete = true;
-    g_main_loop_quit(data->loop);
-}
-
-
 const char *nbd_opt_lookup(uint32_t opt)
 {
     switch (opt) {
diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index 1b2141ab4b..c18554cb87 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -71,16 +71,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
     return qio_channel_write_all(ioc, buffer, size, errp) < 0 ? -EIO : 0;
 }
 
-struct NBDTLSHandshakeData {
-    GMainLoop *loop;
-    bool complete;
-    Error *error;
-};
-
-
-void nbd_tls_handshake(QIOTask *task,
-                       void *opaque);
-
 int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);
 
 #endif
diff --git a/nbd/server.c b/nbd/server.c
index ada16089f3..4d2061f55c 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -729,6 +729,23 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
     return rc;
 }
 
+/* Callback to learn when QIO TLS upgrade is complete */
+struct NBDTLSServerHandshakeData {
+    bool complete;
+    Error *error;
+    Coroutine *co;
+};
+
+static void nbd_server_tls_handshake(QIOTask *task, void *opaque)
+{
+    struct NBDTLSServerHandshakeData *data = opaque;
+
+    qio_task_propagate_error(task, &data->error);
+    data->complete = true;
+    if (!qemu_coroutine_entered(data->co)) {
+        aio_co_wake(data->co);
+    }
+}
 
 /* Handle NBD_OPT_STARTTLS. Return NULL to drop connection, or else the
  * new channel for all further (now-encrypted) communication. */
@@ -737,7 +754,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+    struct NBDTLSServerHandshakeData data = { 0 };
 
     assert(client->opt == NBD_OPT_STARTTLS);
 
@@ -758,17 +775,18 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 
     qio_channel_set_name(QIO_CHANNEL(tioc), "nbd-server-tls");
     trace_nbd_negotiate_handle_starttls_handshake();
-    data.loop = g_main_loop_new(g_main_context_default(), FALSE);
+    data.co = qemu_coroutine_self();
     qio_channel_tls_handshake(tioc,
-                              nbd_tls_handshake,
+                              nbd_server_tls_handshake,
                               &data,
                               NULL,
                               NULL);
 
     if (!data.complete) {
-        g_main_loop_run(data.loop);
+        qemu_coroutine_yield();
+        assert(data.complete);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         object_unref(OBJECT(tioc));
         error_propagate(errp, data.error);
-- 
2.39.2


