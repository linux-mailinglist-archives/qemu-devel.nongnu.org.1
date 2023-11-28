Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C5F7FBC47
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 15:10:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ymW-0002Mx-Dt; Tue, 28 Nov 2023 09:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymT-0002KG-3x
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r7ymR-0006Vs-4X
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 09:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701180578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6xgWI92mvm47z7cP+0hV3lVTV0KhBcC7oLnLh6NowY=;
 b=h6YlwiPwuaX0QDJzu78P3b9pbiP25eUMx48RJhulapxCsz4M8H2bnSkVgZ27kCh9ooGiwS
 zAFQqqLHV/e/wLKGBbhUF1rsvN6X9pkOaq5c11qgyclQm/iT41+0ykMywQPbB2j9Ws0Eu7
 8PHtiE93MVPvWWO6dddh+B9zb/m+ORQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-P6OJRBQSPhSEnFD6_btThA-1; Tue, 28 Nov 2023 09:09:33 -0500
X-MC-Unique: P6OJRBQSPhSEnFD6_btThA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7A48811E8D;
 Tue, 28 Nov 2023 14:09:33 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EE62910EA1;
 Tue, 28 Nov 2023 14:09:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 3/4] export/vhost-user-blk: Fix consecutive drains
Date: Tue, 28 Nov 2023 15:09:25 +0100
Message-ID: <20231128140926.106077-4-kwolf@redhat.com>
In-Reply-To: <20231128140926.106077-1-kwolf@redhat.com>
References: <20231128140926.106077-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The vhost-user-blk export implement AioContext switches in its drain
implementation. This means that on drain_begin, it detaches the server
from its AioContext and on drain_end, attaches it again and schedules
the server->co_trip coroutine in the updated AioContext.

However, nothing guarantees that server->co_trip is even safe to be
scheduled. Not only is it unclear that the coroutine is actually in a
state where it can be reentered externally without causing problems, but
with two consecutive drains, it is possible that the scheduled coroutine
didn't have a chance yet to run and trying to schedule an already
scheduled coroutine a second time crashes with an assertion failure.

Following the model of NBD, this commit makes the vhost-user-blk export
shut down server->co_trip during drain so that resuming the export means
creating and scheduling a new coroutine, which is always safe.

There is one exception: If the drain call didn't poll (for example, this
happens in the context of bdrv_graph_wrlock()), then the coroutine
didn't have a chance to shut down. However, in this case the AioContext
can't have changed; changing the AioContext always involves a polling
drain. So in this case we can simply assert that the AioContext is
unchanged and just leave the coroutine running or wake it up if it has
yielded to wait for the AioContext to be attached again.

Fixes: e1054cd4aad03a493a5d1cded7508f7c348205bf
Fixes: https://issues.redhat.com/browse/RHEL-1708
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231127115755.22846-1-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/vhost-user-server.h     |  1 +
 block/export/vhost-user-blk-server.c |  9 +++++--
 util/vhost-user-server.c             | 39 ++++++++++++++++++++++------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/qemu/vhost-user-server.h b/include/qemu/vhost-user-server.h
index 64ad701015..0417ec0533 100644
--- a/include/qemu/vhost-user-server.h
+++ b/include/qemu/vhost-user-server.h
@@ -45,6 +45,7 @@ typedef struct {
     /* Protected by ctx lock */
     bool in_qio_channel_yield;
     bool wait_idle;
+    bool quiescing;
     VuDev vu_dev;
     QIOChannel *ioc; /* The I/O channel with the client */
     QIOChannelSocket *sioc; /* The underlying data channel with the client */
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index fe2cee3a78..16f48388d3 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -283,6 +283,7 @@ static void vu_blk_drained_begin(void *opaque)
 {
     VuBlkExport *vexp = opaque;
 
+    vexp->vu_server.quiescing = true;
     vhost_user_server_detach_aio_context(&vexp->vu_server);
 }
 
@@ -291,19 +292,23 @@ static void vu_blk_drained_end(void *opaque)
 {
     VuBlkExport *vexp = opaque;
 
+    vexp->vu_server.quiescing = false;
     vhost_user_server_attach_aio_context(&vexp->vu_server, vexp->export.ctx);
 }
 
 /*
- * Ensures that bdrv_drained_begin() waits until in-flight requests complete.
+ * Ensures that bdrv_drained_begin() waits until in-flight requests complete
+ * and the server->co_trip coroutine has terminated. It will be restarted in
+ * vhost_user_server_attach_aio_context().
  *
  * Called with vexp->export.ctx acquired.
  */
 static bool vu_blk_drained_poll(void *opaque)
 {
     VuBlkExport *vexp = opaque;
+    VuServer *server = &vexp->vu_server;
 
-    return vhost_user_server_has_in_flight(&vexp->vu_server);
+    return server->co_trip || vhost_user_server_has_in_flight(server);
 }
 
 static const BlockDevOps vu_blk_dev_ops = {
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 5ccc6d24a0..a9a48fffb8 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -132,8 +132,7 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
                     qio_channel_yield(ioc, G_IO_IN);
                     server->in_qio_channel_yield = false;
                 } else {
-                    /* Wait until attached to an AioContext again */
-                    qemu_coroutine_yield();
+                    return false;
                 }
                 continue;
             } else {
@@ -201,8 +200,16 @@ static coroutine_fn void vu_client_trip(void *opaque)
     VuServer *server = opaque;
     VuDev *vu_dev = &server->vu_dev;
 
-    while (!vu_dev->broken && vu_dispatch(vu_dev)) {
-        /* Keep running */
+    while (!vu_dev->broken) {
+        if (server->quiescing) {
+            server->co_trip = NULL;
+            aio_wait_kick();
+            return;
+        }
+        /* vu_dispatch() returns false if server->ctx went away */
+        if (!vu_dispatch(vu_dev) && server->ctx) {
+            break;
+        }
     }
 
     if (vhost_user_server_has_in_flight(server)) {
@@ -353,8 +360,7 @@ static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
 
     qio_channel_set_follow_coroutine_ctx(server->ioc, true);
 
-    server->co_trip = qemu_coroutine_create(vu_client_trip, server);
-
+    /* Attaching the AioContext starts the vu_client_trip coroutine */
     aio_context_acquire(server->ctx);
     vhost_user_server_attach_aio_context(server, server->ctx);
     aio_context_release(server->ctx);
@@ -413,8 +419,25 @@ void vhost_user_server_attach_aio_context(VuServer *server, AioContext *ctx)
                            NULL, NULL, vu_fd_watch);
     }
 
-    assert(!server->in_qio_channel_yield);
-    aio_co_schedule(ctx, server->co_trip);
+    if (server->co_trip) {
+        /*
+         * The caller didn't fully shut down co_trip (this can happen on
+         * non-polling drains like in bdrv_graph_wrlock()). This is okay as long
+         * as it no longer tries to shut it down and we're guaranteed to still
+         * be in the same AioContext as before.
+         *
+         * co_ctx can still be NULL if we get multiple calls and only just
+         * scheduled a new coroutine in the else branch.
+         */
+        AioContext *co_ctx = qemu_coroutine_get_aio_context(server->co_trip);
+
+        assert(!server->quiescing);
+        assert(!co_ctx || co_ctx == ctx);
+    } else {
+        server->co_trip = qemu_coroutine_create(vu_client_trip, server);
+        assert(!server->in_qio_channel_yield);
+        aio_co_schedule(ctx, server->co_trip);
+    }
 }
 
 /* Called with server->ctx acquired */
-- 
2.43.0


