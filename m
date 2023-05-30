Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 761F07169CB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42Ij-0000sR-KN; Tue, 30 May 2023 12:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hb-0006rK-6i
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HX-0008QJ-W8
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZqktWQrLFSHZ6LXJVB3T/QJl62qVA8nRvPYAXI9WKLY=;
 b=Nn1yCIMk3RLgn7MotqKu0h01ckLCeOobhzmrLjIrSVWCAqfngM/nFbYiA/QpWL3IfddFpa
 wigZTZgN5cKjwJfJi5gENDoYgPRLxaA9QheJjc1ZmN17F83p1lGoZQx37ANnY+9r+mf2Nm
 oahiYRLmP/FpFS5q1dFdWaLfhoyJ9c8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-bjT-RugYPmqzy3SCr3QjOA-1; Tue, 30 May 2023 12:33:05 -0400
X-MC-Unique: bjT-RugYPmqzy3SCr3QjOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3084F101A53A;
 Tue, 30 May 2023 16:33:05 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 745FEC154D2;
 Tue, 30 May 2023 16:33:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/32] block/export: stop using is_external in vhost-user-blk
 server
Date: Tue, 30 May 2023 18:32:26 +0200
Message-Id: <20230530163239.576632-20-kwolf@redhat.com>
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

vhost-user activity must be suspended during bdrv_drained_begin/end().
This prevents new requests from interfering with whatever is happening
in the drained section.

Previously this was done using aio_set_fd_handler()'s is_external
argument. In a multi-queue block layer world the aio_disable_external()
API cannot be used since multiple AioContext may be processing I/O, not
just one.

Switch to BlockDevOps->drained_begin/end() callbacks.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-8-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/export/vhost-user-blk-server.c | 28 ++++++++++++++++++++++++++--
 util/vhost-user-server.c             | 10 +++++-----
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index f51a36a14f..81b59761e3 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -212,15 +212,21 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
 {
     VuBlkExport *vexp = opaque;
 
+    /*
+     * The actual attach will happen in vu_blk_drained_end() and we just
+     * restore ctx here.
+     */
     vexp->export.ctx = ctx;
-    vhost_user_server_attach_aio_context(&vexp->vu_server, ctx);
 }
 
 static void blk_aio_detach(void *opaque)
 {
     VuBlkExport *vexp = opaque;
 
-    vhost_user_server_detach_aio_context(&vexp->vu_server);
+    /*
+     * The actual detach already happened in vu_blk_drained_begin() but from
+     * this point on we must not access ctx anymore.
+     */
     vexp->export.ctx = NULL;
 }
 
@@ -272,6 +278,22 @@ static void vu_blk_exp_resize(void *opaque)
     vu_config_change_msg(&vexp->vu_server.vu_dev);
 }
 
+/* Called with vexp->export.ctx acquired */
+static void vu_blk_drained_begin(void *opaque)
+{
+    VuBlkExport *vexp = opaque;
+
+    vhost_user_server_detach_aio_context(&vexp->vu_server);
+}
+
+/* Called with vexp->export.blk AioContext acquired */
+static void vu_blk_drained_end(void *opaque)
+{
+    VuBlkExport *vexp = opaque;
+
+    vhost_user_server_attach_aio_context(&vexp->vu_server, vexp->export.ctx);
+}
+
 /*
  * Ensures that bdrv_drained_begin() waits until in-flight requests complete.
  *
@@ -285,6 +307,8 @@ static bool vu_blk_drained_poll(void *opaque)
 }
 
 static const BlockDevOps vu_blk_dev_ops = {
+    .drained_begin = vu_blk_drained_begin,
+    .drained_end   = vu_blk_drained_end,
     .drained_poll  = vu_blk_drained_poll,
     .resize_cb = vu_blk_exp_resize,
 };
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index 68c3bf162f..a12b2d1bba 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -278,7 +278,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
         vu_fd_watch->fd = fd;
         vu_fd_watch->cb = cb;
         qemu_socket_set_nonblock(fd);
-        aio_set_fd_handler(server->ioc->ctx, fd, true, kick_handler,
+        aio_set_fd_handler(server->ioc->ctx, fd, false, kick_handler,
                            NULL, NULL, NULL, vu_fd_watch);
         vu_fd_watch->vu_dev = vu_dev;
         vu_fd_watch->pvt = pvt;
@@ -299,7 +299,7 @@ static void remove_watch(VuDev *vu_dev, int fd)
     if (!vu_fd_watch) {
         return;
     }
-    aio_set_fd_handler(server->ioc->ctx, fd, true,
+    aio_set_fd_handler(server->ioc->ctx, fd, false,
                        NULL, NULL, NULL, NULL, NULL);
 
     QTAILQ_REMOVE(&server->vu_fd_watches, vu_fd_watch, next);
@@ -362,7 +362,7 @@ void vhost_user_server_stop(VuServer *server)
         VuFdWatch *vu_fd_watch;
 
         QTAILQ_FOREACH(vu_fd_watch, &server->vu_fd_watches, next) {
-            aio_set_fd_handler(server->ctx, vu_fd_watch->fd, true,
+            aio_set_fd_handler(server->ctx, vu_fd_watch->fd, false,
                                NULL, NULL, NULL, NULL, vu_fd_watch);
         }
 
@@ -403,7 +403,7 @@ void vhost_user_server_attach_aio_context(VuServer *server, AioContext *ctx)
     qio_channel_attach_aio_context(server->ioc, ctx);
 
     QTAILQ_FOREACH(vu_fd_watch, &server->vu_fd_watches, next) {
-        aio_set_fd_handler(ctx, vu_fd_watch->fd, true, kick_handler, NULL,
+        aio_set_fd_handler(ctx, vu_fd_watch->fd, false, kick_handler, NULL,
                            NULL, NULL, vu_fd_watch);
     }
 
@@ -417,7 +417,7 @@ void vhost_user_server_detach_aio_context(VuServer *server)
         VuFdWatch *vu_fd_watch;
 
         QTAILQ_FOREACH(vu_fd_watch, &server->vu_fd_watches, next) {
-            aio_set_fd_handler(server->ctx, vu_fd_watch->fd, true,
+            aio_set_fd_handler(server->ctx, vu_fd_watch->fd, false,
                                NULL, NULL, NULL, NULL, vu_fd_watch);
         }
 
-- 
2.40.1


