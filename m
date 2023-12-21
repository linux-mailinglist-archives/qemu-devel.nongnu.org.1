Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A9381AC5B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 02:51:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG8Bt-0008A9-Sq; Wed, 20 Dec 2023 20:49:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Bj-00088C-4U
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Bh-0002i5-5G
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703123364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rGfjh/YlozNNkXclMsnlpr3zJG/93/87HIvPn823zgw=;
 b=NbdUktOlqUDRYhvjvUmpSbIfz0bVJ9pC0SaDhR6u3YnWi1/aHId07ZEoVqrSgEzKbVwmSw
 ifgqi+3HKnchQ1j8E2ziQZbsyYikcMM/WfPsoCLMx+vPHes5lEUt8xgSLWJiL3Oawr4rXb
 EpOVzAmahaOt/+FTcrYFY/SCAIafSfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-Cl6mdu6cNPyxat6YUURKDQ-1; Wed, 20 Dec 2023 20:49:21 -0500
X-MC-Unique: Cl6mdu6cNPyxat6YUURKDQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 809638370E2;
 Thu, 21 Dec 2023 01:49:20 +0000 (UTC)
Received: from localhost (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED78A3C25;
 Thu, 21 Dec 2023 01:49:19 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 6/6] nbd/server: introduce NBDClient->lock to protect fields
Date: Wed, 20 Dec 2023 20:49:03 -0500
Message-ID: <20231221014903.1537962-7-stefanha@redhat.com>
In-Reply-To: <20231221014903.1537962-1-stefanha@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

NBDClient has a number of fields that are accessed by both the export
AioContext and the main loop thread. When the AioContext lock is removed
these fields will need another form of protection.

Add NBDClient->lock and protect fields that are accessed by both
threads. Also add assertions where possible and otherwise add doc
comments stating assumptions about which thread and lock holding.

Note this patch moves the client->recv_coroutine assertion from
nbd_co_receive_request() to nbd_trip() where client->lock is held.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 nbd/server.c | 128 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 94 insertions(+), 34 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 527fbdab4a..4008ec7df9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -125,23 +125,25 @@ struct NBDClient {
     int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
 
+    QemuMutex lock;
+
     NBDExport *exp;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthz;
     QIOChannelSocket *sioc; /* The underlying data channel */
     QIOChannel *ioc; /* The current I/O channel which may differ (eg TLS) */
 
-    Coroutine *recv_coroutine;
+    Coroutine *recv_coroutine; /* protected by lock */
 
     CoMutex send_lock;
     Coroutine *send_coroutine;
 
-    bool read_yielding;
-    bool quiescing;
+    bool read_yielding; /* protected by lock */
+    bool quiescing; /* protected by lock */
 
     QTAILQ_ENTRY(NBDClient) next;
-    int nb_requests;
-    bool closing;
+    int nb_requests; /* protected by lock */
+    bool closing; /* protected by lock */
 
     uint32_t check_align; /* If non-zero, check for aligned client requests */
 
@@ -1415,11 +1417,18 @@ nbd_read_eof(NBDClient *client, void *buffer, size_t size, Error **errp)
 
         len = qio_channel_readv(client->ioc, &iov, 1, errp);
         if (len == QIO_CHANNEL_ERR_BLOCK) {
-            client->read_yielding = true;
+            WITH_QEMU_LOCK_GUARD(&client->lock) {
+                if (client->quiescing) {
+                    return -EAGAIN;
+                }
+                client->read_yielding = true;
+            }
             qio_channel_yield(client->ioc, G_IO_IN);
-            client->read_yielding = false;
-            if (client->quiescing) {
-                return -EAGAIN;
+            WITH_QEMU_LOCK_GUARD(&client->lock) {
+                client->read_yielding = false;
+                if (client->quiescing) {
+                    return -EAGAIN;
+                }
             }
             continue;
         } else if (len < 0) {
@@ -1528,6 +1537,7 @@ void nbd_client_put(NBDClient *client)
             blk_exp_unref(&client->exp->common);
         }
         g_free(client->contexts.bitmaps);
+        qemu_mutex_destroy(&client->lock);
         g_free(client);
     }
 }
@@ -1536,11 +1546,13 @@ static void client_close(NBDClient *client, bool negotiated)
 {
     assert(qemu_in_main_thread());
 
-    if (client->closing) {
-        return;
-    }
+    WITH_QEMU_LOCK_GUARD(&client->lock) {
+        if (client->closing) {
+            return;
+        }
 
-    client->closing = true;
+        client->closing = true;
+    }
 
     /* Force requests to finish.  They will drop their own references,
      * then we'll close the socket and free the NBDClient.
@@ -1554,6 +1566,7 @@ static void client_close(NBDClient *client, bool negotiated)
     }
 }
 
+/* Runs in export AioContext with client->lock held */
 static NBDRequestData *nbd_request_get(NBDClient *client)
 {
     NBDRequestData *req;
@@ -1566,6 +1579,7 @@ static NBDRequestData *nbd_request_get(NBDClient *client)
     return req;
 }
 
+/* Runs in export AioContext with client->lock held */
 static void nbd_request_put(NBDRequestData *req)
 {
     NBDClient *client = req->client;
@@ -1589,14 +1603,18 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     trace_nbd_blk_aio_attached(exp->name, ctx);
 
     exp->common.ctx = ctx;
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        assert(client->nb_requests == 0);
-        assert(client->recv_coroutine == NULL);
-        assert(client->send_coroutine == NULL);
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            assert(client->nb_requests == 0);
+            assert(client->recv_coroutine == NULL);
+            assert(client->send_coroutine == NULL);
+        }
     }
 }
 
@@ -1604,6 +1622,8 @@ static void blk_aio_detach(void *opaque)
 {
     NBDExport *exp = opaque;
 
+    assert(qemu_in_main_thread());
+
     trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
 
     exp->common.ctx = NULL;
@@ -1614,8 +1634,12 @@ static void nbd_drained_begin(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        client->quiescing = true;
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            client->quiescing = true;
+        }
     }
 }
 
@@ -1624,9 +1648,13 @@ static void nbd_drained_end(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        client->quiescing = false;
-        nbd_client_receive_next_request(client);
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            client->quiescing = false;
+            nbd_client_receive_next_request(client);
+        }
     }
 }
 
@@ -1635,17 +1663,21 @@ static bool nbd_drained_poll(void *opaque)
     NBDExport *exp = opaque;
     NBDClient *client;
 
+    assert(qemu_in_main_thread());
+
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        if (client->nb_requests != 0) {
-            /*
-             * If there's a coroutine waiting for a request on nbd_read_eof()
-             * enter it here so we don't depend on the client to wake it up.
-             */
-            if (client->recv_coroutine != NULL && client->read_yielding) {
-                qio_channel_wake_read(client->ioc);
+        WITH_QEMU_LOCK_GUARD(&client->lock) {
+            if (client->nb_requests != 0) {
+                /*
+                 * If there's a coroutine waiting for a request on nbd_read_eof()
+                 * enter it here so we don't depend on the client to wake it up.
+                 */
+                if (client->recv_coroutine != NULL && client->read_yielding) {
+                    qio_channel_wake_read(client->ioc);
+                }
+
+                return true;
             }
-
-            return true;
         }
     }
 
@@ -1656,6 +1688,8 @@ static void nbd_eject_notifier(Notifier *n, void *data)
 {
     NBDExport *exp = container_of(n, NBDExport, eject_notifier);
 
+    assert(qemu_in_main_thread());
+
     blk_exp_request_shutdown(&exp->common);
 }
 
@@ -2541,7 +2575,6 @@ static int coroutine_fn nbd_co_receive_request(NBDRequestData *req,
     int ret;
 
     g_assert(qemu_in_coroutine());
-    assert(client->recv_coroutine == qemu_coroutine_self());
     ret = nbd_receive_request(client, request, errp);
     if (ret < 0) {
         return ret;
@@ -2950,7 +2983,11 @@ static coroutine_fn void nbd_trip(void *opaque)
      */
 
     trace_nbd_trip();
+
+    qemu_mutex_lock(&client->lock);
+
     if (client->closing) {
+        qemu_mutex_unlock(&client->lock);
         aio_co_reschedule_self(qemu_get_aio_context());
         nbd_client_put(client);
         return;
@@ -2961,15 +2998,24 @@ static coroutine_fn void nbd_trip(void *opaque)
          * We're switching between AIO contexts. Don't attempt to receive a new
          * request and kick the main context which may be waiting for us.
          */
-        aio_co_reschedule_self(qemu_get_aio_context());
-        nbd_client_put(client);
         client->recv_coroutine = NULL;
+        qemu_mutex_unlock(&client->lock);
         aio_wait_kick();
+
+        aio_co_reschedule_self(qemu_get_aio_context());
+        nbd_client_put(client);
         return;
     }
 
     req = nbd_request_get(client);
-    ret = nbd_co_receive_request(req, &request, &local_err);
+
+    do {
+        assert(client->recv_coroutine == qemu_coroutine_self());
+        qemu_mutex_unlock(&client->lock);
+        ret = nbd_co_receive_request(req, &request, &local_err);
+        qemu_mutex_lock(&client->lock);
+    } while (ret == -EAGAIN && !client->quiescing);
+
     client->recv_coroutine = NULL;
 
     if (client->closing) {
@@ -2981,11 +3027,13 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     if (ret == -EAGAIN) {
-        assert(client->quiescing);
         goto done;
     }
 
     nbd_client_receive_next_request(client);
+
+    qemu_mutex_unlock(&client->lock);
+
     if (ret == -EIO) {
         goto disconnect;
     }
@@ -3024,8 +3072,10 @@ static coroutine_fn void nbd_trip(void *opaque)
     }
 
     qio_channel_set_cork(client->ioc, false);
+    qemu_mutex_lock(&client->lock);
 done:
     nbd_request_put(req);
+    qemu_mutex_unlock(&client->lock);
 
     aio_co_reschedule_self(qemu_get_aio_context());
     nbd_client_put(client);
@@ -3035,13 +3085,20 @@ disconnect:
     if (local_err) {
         error_reportf_err(local_err, "Disconnect client, due to: ");
     }
+
+    qemu_mutex_lock(&client->lock);
     nbd_request_put(req);
+    qemu_mutex_unlock(&client->lock);
 
     aio_co_reschedule_self(qemu_get_aio_context());
     client_close(client, true);
     nbd_client_put(client);
 }
 
+/*
+ * Runs in export AioContext and main loop thread. Caller must hold
+ * client->lock.
+ */
 static void nbd_client_receive_next_request(NBDClient *client)
 {
     if (!client->recv_coroutine && client->nb_requests < MAX_NBD_REQUESTS &&
@@ -3067,7 +3124,9 @@ static coroutine_fn void nbd_co_client_start(void *opaque)
         return;
     }
 
-    nbd_client_receive_next_request(client);
+    WITH_QEMU_LOCK_GUARD(&client->lock) {
+        nbd_client_receive_next_request(client);
+    }
 }
 
 /*
@@ -3084,6 +3143,7 @@ void nbd_client_new(QIOChannelSocket *sioc,
     Coroutine *co;
 
     client = g_new0(NBDClient, 1);
+    qemu_mutex_init(&client->lock);
     client->refcount = 1;
     client->tlscreds = tlscreds;
     if (tlscreds) {
-- 
2.43.0


