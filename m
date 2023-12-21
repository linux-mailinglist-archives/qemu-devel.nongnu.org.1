Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF98C81BFFD
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWS-0006Ub-S7; Thu, 21 Dec 2023 16:24:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWO-0006QS-AE
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWM-0007xh-JD
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:24:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grPhJ5fyTmicnFhbIq+y4WaLwYXIBfAp86q0n9wJhGg=;
 b=NV+wFO3A+ICykMA1B2LpcbBKSIf3lxHIxaUeZY2Q3InwbqEnku14HO54LHWk/osqliUwrr
 AqcyBLHj+GERzA2LlBT91se9pcC3xGqqxJ62/Pd35ru8xGqO4Rm78nUlSCHWGJq8WkyoVW
 c4xTcZvv7j0EPdVO8252iiKKx/8Bwh0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-yo9COiQvOFiIvTCTeNDYBg-1; Thu,
 21 Dec 2023 16:23:53 -0500
X-MC-Unique: yo9COiQvOFiIvTCTeNDYBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C05F380606C;
 Thu, 21 Dec 2023 21:23:53 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28154C15A0C;
 Thu, 21 Dec 2023 21:23:50 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 02/33] nbd/server: only traverse NBDExport->clients from main
 loop thread
Date: Thu, 21 Dec 2023 22:23:07 +0100
Message-ID: <20231221212339.164439-3-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
cycles per NBD request so add nbd_client_put_nonzero() to optimize the
common case where more references to NBDClient remain.

Note that nbd_client_get() can still be called from either thread, so
make NBDClient->refcount atomic.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20231221192452.1785567-6-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 nbd/server.c | 61 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 10 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 0b09ccc8dc..e91e2e0903 100644
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
@@ -1529,8 +1532,35 @@ void nbd_client_put(NBDClient *client)
     }
 }
 
+/*
+ * Tries to release the reference to @client, but only if other references
+ * remain. This is an optimization for the common case where we want to avoid
+ * the expense of scheduling nbd_client_put() in the main loop thread.
+ *
+ * Returns true upon success or false if the reference was not released because
+ * it is the last reference.
+ */
+static bool nbd_client_put_nonzero(NBDClient *client)
+{
+    int old = qatomic_read(&client->refcount);
+    int expected;
+
+    do {
+        if (old == 1) {
+            return false;
+        }
+
+        expected = old;
+        old = qatomic_cmpxchg(&client->refcount, expected, expected - 1);
+    } while (old != expected);
+
+    return true;
+}
+
 static void client_close(NBDClient *client, bool negotiated)
 {
+    assert(qemu_in_main_thread());
+
     if (client->closing) {
         return;
     }
@@ -2933,15 +2963,20 @@ static coroutine_fn int nbd_handle_request(NBDClient *client,
 static coroutine_fn void nbd_trip(void *opaque)
 {
     NBDClient *client = opaque;
-    NBDRequestData *req;
+    NBDRequestData *req = NULL;
     NBDRequest request = { 0 };    /* GCC thinks it can be used uninitialized */
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
-        nbd_client_put(client);
-        return;
+        goto done;
     }
 
     if (client->quiescing) {
@@ -2949,10 +2984,9 @@ static coroutine_fn void nbd_trip(void *opaque)
          * We're switching between AIO contexts. Don't attempt to receive a new
          * request and kick the main context which may be waiting for us.
          */
-        nbd_client_put(client);
         client->recv_coroutine = NULL;
         aio_wait_kick();
-        return;
+        goto done;
     }
 
     req = nbd_request_get(client);
@@ -3012,8 +3046,13 @@ static coroutine_fn void nbd_trip(void *opaque)
 
     qio_channel_set_cork(client->ioc, false);
 done:
-    nbd_request_put(req);
-    nbd_client_put(client);
+    if (req) {
+        nbd_request_put(req);
+    }
+    if (!nbd_client_put_nonzero(client)) {
+        aio_co_reschedule_self(qemu_get_aio_context());
+        nbd_client_put(client);
+    }
     return;
 
 disconnect:
@@ -3021,6 +3060,8 @@ disconnect:
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


