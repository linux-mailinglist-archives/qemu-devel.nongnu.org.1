Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E989A3B1
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Apr 2024 19:46:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsndc-00013P-U0; Fri, 05 Apr 2024 13:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsndS-00010h-Lh
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:45:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rsndN-0005cD-L6
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 13:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712339147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wP8QwwtjVUlBP9tLGAX5MBpAv2s5IjeizLlNwmMNrUc=;
 b=bbvWaoMdCVpQjPGqC+qhElf67rOZOeFrA1CRw7GuyoJwLWK4QADJ7L3Q85Vj5LelFU2xHl
 +e0wxh6tV/94IKc3J38e9JeuJ1IjvTlDqjjb+1KLfwZWnPeD7JKZ4LLWgB37SGINFPxm0a
 wxnBpeDcbfb3exIxg5ung4pnd8AMZZo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504--KHFNKwfONOQgq2Rtoe_ow-1; Fri,
 05 Apr 2024 13:45:45 -0400
X-MC-Unique: -KHFNKwfONOQgq2Rtoe_ow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B7C13C1CC55;
 Fri,  5 Apr 2024 17:45:45 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB6443C21;
 Fri,  5 Apr 2024 17:45:44 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Zhu Yangyang <zhuyangyang14@huawei.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH v4] nbd/server: do not poll within a coroutine context
Date: Fri,  5 Apr 2024 12:44:13 -0500
Message-ID: <20240405174523.844181-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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

From: Zhu Yangyang <zhuyangyang14@huawei.com>

Coroutines are not supposed to block. Instead, they should yield.

The client performs TLS upgrade outside of an AIOContext, during
synchronous handshake; this still requires g_main_loop.  But the
server responds to TLS upgrade inside a coroutine, so a nested
g_main_loop is wrong.  Since the two callbacks no longer share more
than the setting of data.complete and data.error, it's just as easy to
use static helpers instead of trying to share a common code path.

Fixes: f95910f ("nbd: implement TLS support in the protocol negotiation")
Signed-off-by: Zhu Yangyang <zhuyangyang14@huawei.com>
[eblake: move callbacks to their use point]
Signed-off-by: Eric Blake <eblake@redhat.com>
---

v3: https://lists.gnu.org/archive/html/qemu-devel/2024-04/msg00375.html

in v4, factor even the struct to the .c files, avoiding a union [Vladimir]

 nbd/nbd-internal.h | 10 ----------
 nbd/client.c       | 27 +++++++++++++++++++++++----
 nbd/common.c       | 11 -----------
 nbd/server.c       | 29 +++++++++++++++++++++++------
 4 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/nbd/nbd-internal.h b/nbd/nbd-internal.h
index dfa02f77ee4..91895106a95 100644
--- a/nbd/nbd-internal.h
+++ b/nbd/nbd-internal.h
@@ -72,16 +72,6 @@ static inline int nbd_write(QIOChannel *ioc, const void *buffer, size_t size,
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
diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4b..c7141d7a098 100644
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
@@ -619,18 +637,19 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
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
+        g_main_loop_unref(data.loop);
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         error_propagate(errp, data.error);
         object_unref(OBJECT(tioc));
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618a..589a748cfe6 100644
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
diff --git a/nbd/server.c b/nbd/server.c
index c3484cc1ebc..ea13cf0e766 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -748,6 +748,23 @@ static int nbd_negotiate_handle_info(NBDClient *client, Error **errp)
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
@@ -756,7 +773,7 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,
 {
     QIOChannel *ioc;
     QIOChannelTLS *tioc;
-    struct NBDTLSHandshakeData data = { 0 };
+    struct NBDTLSServerHandshakeData data = { 0 };

     assert(client->opt == NBD_OPT_STARTTLS);

@@ -777,17 +794,17 @@ static QIOChannel *nbd_negotiate_handle_starttls(NBDClient *client,

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

-    if (!data.complete) {
-        g_main_loop_run(data.loop);
+    while (!data.complete) {
+        qemu_coroutine_yield();
     }
-    g_main_loop_unref(data.loop);
+
     if (data.error) {
         object_unref(OBJECT(tioc));
         error_propagate(errp, data.error);
-- 
2.44.0


