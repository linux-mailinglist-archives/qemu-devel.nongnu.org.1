Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C281AC5C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 02:51:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG8Br-00088k-Lo; Wed, 20 Dec 2023 20:49:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Be-00086z-Nu
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rG8Bd-0002h0-4q
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 20:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703123360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UzJmAR6RzllYvvvzKA6qWdFzydxG0i59/3dV2bf+uM=;
 b=CBqFcrstFPjDZWGxeraDKCYUCif9W38Wzep8OUaI2nBUaqoU5pWbA149DwoU+5YWpLlAR1
 2ZK+se0f7HydIHZvbM/lratka7QeQAfZEy3eEOo/dEYLNqW3M2fw+cTvC8N48e9Yj5AUs7
 W+y46Oi1UhxP9ROaiV81B7xTgbmE1cI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-VzXZR_5PPLGvU_a7R4dx6Q-1; Wed, 20 Dec 2023 20:49:18 -0500
X-MC-Unique: VzXZR_5PPLGvU_a7R4dx6Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C4FE879840;
 Thu, 21 Dec 2023 01:49:18 +0000 (UTC)
Received: from localhost (unknown [10.39.192.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 824A040C6EB9;
 Thu, 21 Dec 2023 01:49:17 +0000 (UTC)
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
Subject: [PATCH 5/6] nbd/server: only traverse NBDExport->clients from main
 loop thread
Date: Wed, 20 Dec 2023 20:49:02 -0500
Message-ID: <20231221014903.1537962-6-stefanha@redhat.com>
In-Reply-To: <20231221014903.1537962-1-stefanha@redhat.com>
References: <20231221014903.1537962-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

The NBD clients list is currently accessed from both the export
AioContext and the main loop thread. When the AioContext lock is removed
there will be nothing protecting the clients list.

Adding a lock around the clients list is tricky because NBDClient
structs are refcounted and may be freed from the export AioContext or
the main loop thread. nbd_export_request_shutdown() -> client_close() ->
nbd_client_put() is also tricky because the list lock would be held
while indirectly dropping references to NDBClients.

A simpler approach is to only allow nbd_client_put() and client_close()
calls from the main loop thread. Then the NBD clients list is only
accessed from the main loop thread and no fancy locking is needed.

nbd_trip() just needs to reschedule itself in the main loop AioContext
before calling nbd_client_put() and client_close(). This costs more CPU
cycles per NBD request but is needed for thread-safety when the
AioContext lock is removed.

Note that nbd_client_get() can still be called from either thread, so
make NBDClient->refcount atomic.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 nbd/server.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0b09ccc8dc..527fbdab4a 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -122,7 +122,7 @@ struct NBDMetaContexts {
 };
 
 struct NBDClient {
-    int refcount;
+    int refcount; /* atomic */
     void (*close_fn)(NBDClient *client, bool negotiated);
 
     NBDExport *exp;
@@ -1501,14 +1501,17 @@ static int coroutine_fn nbd_receive_request(NBDClient *client, NBDRequest *reque
 
 #define MAX_NBD_REQUESTS 16
 
+/* Runs in export AioContext and main loop thread */
 void nbd_client_get(NBDClient *client)
 {
-    client->refcount++;
+    qatomic_inc(&client->refcount);
 }
 
 void nbd_client_put(NBDClient *client)
 {
-    if (--client->refcount == 0) {
+    assert(qemu_in_main_thread());
+
+    if (qatomic_fetch_dec(&client->refcount) == 1) {
         /* The last reference should be dropped by client->close,
          * which is called by client_close.
          */
@@ -1531,6 +1534,8 @@ void nbd_client_put(NBDClient *client)
 
 static void client_close(NBDClient *client, bool negotiated)
 {
+    assert(qemu_in_main_thread());
+
     if (client->closing) {
         return;
     }
@@ -2938,8 +2943,15 @@ static coroutine_fn void nbd_trip(void *opaque)
     int ret;
     Error *local_err = NULL;
 
+    /*
+     * Note that nbd_client_put() and client_close() must be called from the
+     * main loop thread. Use aio_co_reschedule_self() to switch AioContext
+     * before calling these functions.
+     */
+
     trace_nbd_trip();
     if (client->closing) {
+        aio_co_reschedule_self(qemu_get_aio_context());
         nbd_client_put(client);
         return;
     }
@@ -2949,6 +2961,7 @@ static coroutine_fn void nbd_trip(void *opaque)
          * We're switching between AIO contexts. Don't attempt to receive a new
          * request and kick the main context which may be waiting for us.
          */
+        aio_co_reschedule_self(qemu_get_aio_context());
         nbd_client_put(client);
         client->recv_coroutine = NULL;
         aio_wait_kick();
@@ -3013,6 +3026,8 @@ static coroutine_fn void nbd_trip(void *opaque)
     qio_channel_set_cork(client->ioc, false);
 done:
     nbd_request_put(req);
+
+    aio_co_reschedule_self(qemu_get_aio_context());
     nbd_client_put(client);
     return;
 
@@ -3021,6 +3036,8 @@ disconnect:
         error_reportf_err(local_err, "Disconnect client, due to: ");
     }
     nbd_request_put(req);
+
+    aio_co_reschedule_self(qemu_get_aio_context());
     client_close(client, true);
     nbd_client_put(client);
 }
-- 
2.43.0


