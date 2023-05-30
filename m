Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B17169D7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:38:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42In-0001Ru-I7; Tue, 30 May 2023 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hg-0006wX-RP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42He-0008TB-NB
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dWYtO63hzJuGikLX2mgXYxihjvj+ywyd+OvX6djxaX8=;
 b=Q+ncgLLbNnL3WdsHTXgJIgwUEbUXSIq07rtpJRfVe8kN/gGgOzWMtlfkZdmelxd2OTBYVo
 bW7+QzV53nL0WBVlnwO2iSs33juUcq7+u0MzyT2XkYGbamfXuNu1tqZQCVOWGXDByBDXUu
 2Y1Yz/KBTx7IvSzBtGvBA9wzulL5CZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-A1rzR6SNMGKIqmDQpzlpfw-1; Tue, 30 May 2023 12:33:04 -0400
X-MC-Unique: A1rzR6SNMGKIqmDQpzlpfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 351CC8032FA;
 Tue, 30 May 2023 16:33:04 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78363C154D2;
 Tue, 30 May 2023 16:33:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/32] block/export: wait for vhost-user-blk requests when
 draining
Date: Tue, 30 May 2023 18:32:25 +0200
Message-Id: <20230530163239.576632-19-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Each vhost-user-blk request runs in a coroutine. When the BlockBackend
enters a drained section we need to enter a quiescent state. Currently
any in-flight requests race with bdrv_drained_begin() because it is
unaware of vhost-user-blk requests.

When blk_co_preadv/pwritev()/etc returns it wakes the
bdrv_drained_begin() thread but vhost-user-blk request processing has
not yet finished. The request coroutine continues executing while the
main loop thread thinks it is in a drained section.

One example where this is unsafe is for blk_set_aio_context() where
bdrv_drained_begin() is called before .aio_context_detached() and
.aio_context_attach(). If request coroutines are still running after
bdrv_drained_begin(), then the AioContext could change underneath them
and they race with new requests processed in the new AioContext. This
could lead to virtqueue corruption, for example.

(This example is theoretical, I came across this while reading the
code and have not tried to reproduce it.)

It's easy to make bdrv_drained_begin() wait for in-flight requests: add
a .drained_poll() callback that checks the VuServer's in-flight counter.
VuServer just needs an API that returns true when there are requests in
flight. The in-flight counter needs to be atomic.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-7-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/vhost-user-server.h     |  4 +++-
 block/export/vhost-user-blk-server.c | 13 +++++++++++++
 util/vhost-user-server.c             | 18 ++++++++++++------
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/qemu/vhost-user-server.h b/include/qemu/vhost-user-server.h
index bc0ac9ddb6..b1c1cda886 100644
--- a/include/qemu/vhost-user-server.h
+++ b/include/qemu/vhost-user-server.h
@@ -40,8 +40,9 @@ typedef struct {
     int max_queues;
     const VuDevIface *vu_iface;
 
+    unsigned int in_flight; /* atomic */
+
     /* Protected by ctx lock */
-    unsigned int in_flight;
     bool wait_idle;
     VuDev vu_dev;
     QIOChannel *ioc; /* The I/O channel with the client */
@@ -62,6 +63,7 @@ void vhost_user_server_stop(VuServer *server);
 
 void vhost_user_server_inc_in_flight(VuServer *server);
 void vhost_user_server_dec_in_flight(VuServer *server);
+bool vhost_user_server_has_in_flight(VuServer *server);
 
 void vhost_user_server_attach_aio_context(VuServer *server, AioContext *ctx);
 void vhost_user_server_detach_aio_context(VuServer *server);
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index 841acb36e3..f51a36a14f 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -272,7 +272,20 @@ static void vu_blk_exp_resize(void *opaque)
     vu_config_change_msg(&vexp->vu_server.vu_dev);
 }
 
+/*
+ * Ensures that bdrv_drained_begin() waits until in-flight requests complete.
+ *
+ * Called with vexp->export.ctx acquired.
+ */
+static bool vu_blk_drained_poll(void *opaque)
+{
+    VuBlkExport *vexp = opaque;
+
+    return vhost_user_server_has_in_flight(&vexp->vu_server);
+}
+
 static const BlockDevOps vu_blk_dev_ops = {
+    .drained_poll  = vu_blk_drained_poll,
     .resize_cb = vu_blk_exp_resize,
 };
 
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 1622f8cfb3..68c3bf162f 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -78,17 +78,23 @@ static void panic_cb(VuDev *vu_dev, const char *buf)
 void vhost_user_server_inc_in_flight(VuServer *server)
 {
     assert(!server->wait_idle);
-    server->in_flight++;
+    qatomic_inc(&server->in_flight);
 }
 
 void vhost_user_server_dec_in_flight(VuServer *server)
 {
-    server->in_flight--;
-    if (server->wait_idle && !server->in_flight) {
-        aio_co_wake(server->co_trip);
+    if (qatomic_fetch_dec(&server->in_flight) == 1) {
+        if (server->wait_idle) {
+            aio_co_wake(server->co_trip);
+        }
     }
 }
 
+bool vhost_user_server_has_in_flight(VuServer *server)
+{
+    return qatomic_load_acquire(&server->in_flight) > 0;
+}
+
 static bool coroutine_fn
 vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
 {
@@ -192,13 +198,13 @@ static coroutine_fn void vu_client_trip(void *opaque)
         /* Keep running */
     }
 
-    if (server->in_flight) {
+    if (vhost_user_server_has_in_flight(server)) {
         /* Wait for requests to complete before we can unmap the memory */
         server->wait_idle = true;
         qemu_coroutine_yield();
         server->wait_idle = false;
     }
-    assert(server->in_flight == 0);
+    assert(!vhost_user_server_has_in_flight(server));
 
     vu_deinit(vu_dev);
 
-- 
2.40.1


