Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D942786411
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 01:46:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxXR-0004KM-LY; Wed, 23 Aug 2023 19:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXO-0004J0-DL
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxXK-0002BN-UG
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692834318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ke4G5zv8rJbSVOi3r9K2CdR3Q4UC3PmVwecbmm/wgqE=;
 b=Fz3wr3aK4gB0lmcwHnEf7i/2ERHziqNqnDbUzwC9qxDGn06/6PniXu2qM5knVqQ/BX0xVY
 xVwoD3IMiF3o3xIO1SnMICMlqm9ULwWs0ukekts7h/PuHn3FHR53qnKAnjAcTEDrd3It7z
 8oSwlFl+DUrN8NqCVuCN5Bp+ywNP6G4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-izO_l_dTNZu6vdvCui5ueg-1; Wed, 23 Aug 2023 19:45:13 -0400
X-MC-Unique: izO_l_dTNZu6vdvCui5ueg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E9D5101A528;
 Wed, 23 Aug 2023 23:45:12 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A9FE31121314;
 Wed, 23 Aug 2023 23:45:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel Berrange <berrange@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Leonardo Bras <leobras@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/2] io: follow coroutine AioContext in qio_channel_yield()
Date: Wed, 23 Aug 2023 19:45:04 -0400
Message-ID: <20230823234504.1387239-3-stefanha@redhat.com>
In-Reply-To: <20230823234504.1387239-1-stefanha@redhat.com>
References: <20230823234504.1387239-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ongoing QEMU multi-queue block layer effort makes it possible for multiple
threads to process I/O in parallel. The nbd block driver is not compatible with
the multi-queue block layer yet because QIOChannel cannot be used easily from
coroutines running in multiple threads. This series changes the QIOChannel API
to make that possible.

In the current API, calling qio_channel_attach_aio_context() sets the
AioContext where qio_channel_yield() installs an fd handler prior to yielding:

  qio_channel_attach_aio_context(ioc, my_ctx);
  ...
  qio_channel_yield(ioc); // my_ctx is used here
  ...
  qio_channel_detach_aio_context(ioc);

This API design has limitations: reading and writing must be done in the same
AioContext and moving between AioContexts involves a cumbersome sequence of API
calls that is not suitable for doing on a per-request basis.

There is no fundamental reason why a QIOChannel needs to run within the
same AioContext every time qio_channel_yield() is called. QIOChannel
only uses the AioContext while inside qio_channel_yield(). The rest of
the time, QIOChannel is independent of any AioContext.

In the new API, qio_channel_yield() queries the AioContext from the current
coroutine using qemu_coroutine_get_aio_context(). There is no need to
explicitly attach/detach AioContexts anymore and
qio_channel_attach_aio_context() and qio_channel_detach_aio_context() are gone.
One coroutine can read from the QIOChannel while another coroutine writes from
a different AioContext.

This API change allows the nbd block driver to use QIOChannel from any thread.
It's important to keep in mind that the block driver already synchronizes
QIOChannel access and ensures that two coroutines never read simultaneously or
write simultaneously.

This patch updates all users of qio_channel_attach_aio_context() to the
new API. Most conversions are simple, but vhost-user-server requires a
new qemu_coroutine_yield() call to quiesce the vu_client_trip()
coroutine when not attached to any AioContext.

While the API is has become simpler, there is one wart: QIOChannel has a
special case for the iohandler AioContext (used for handlers that must not run
in nested event loops). I didn't find an elegant way preserve that behavior, so
I added a new API called qio_channel_set_follow_coroutine_ctx(ioc, true|false)
for opting in to the new AioContext model. By default QIOChannel uses the
iohandler AioHandler. Code that formerly called
qio_channel_attach_aio_context() now calls
qio_channel_set_follow_coroutine_ctx(ioc, true) once after the QIOChannel is
created.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/io/channel.h             |  34 +++++++--
 include/qemu/vhost-user-server.h |   1 +
 block/nbd.c                      |  11 +--
 io/channel-command.c             |  13 +++-
 io/channel-file.c                |  18 ++++-
 io/channel-null.c                |   3 +-
 io/channel-socket.c              |  18 ++++-
 io/channel-tls.c                 |   6 +-
 io/channel.c                     | 120 ++++++++++++++++++++++---------
 migration/channel-block.c        |   3 +-
 nbd/client.c                     |   2 +-
 nbd/server.c                     |  14 +---
 scsi/qemu-pr-helper.c            |   4 +-
 util/vhost-user-server.c         |  27 +++++--
 14 files changed, 191 insertions(+), 83 deletions(-)

diff --git a/include/io/channel.h b/include/io/channel.h
index 229bf36910..dfbe6f2931 100644
--- a/include/io/channel.h
+++ b/include/io/channel.h
@@ -81,9 +81,11 @@ struct QIOChannel {
     Object parent;
     unsigned int features; /* bitmask of QIOChannelFeatures */
     char *name;
-    AioContext *ctx;
+    AioContext *read_ctx;
     Coroutine *read_coroutine;
+    AioContext *write_ctx;
     Coroutine *write_coroutine;
+    bool follow_coroutine_ctx;
 #ifdef _WIN32
     HANDLE event; /* For use with GSource on Win32 */
 #endif
@@ -140,8 +142,9 @@ struct QIOChannelClass {
                      int whence,
                      Error **errp);
     void (*io_set_aio_fd_handler)(QIOChannel *ioc,
-                                  AioContext *ctx,
+                                  AioContext *read_ctx,
                                   IOHandler *io_read,
+                                  AioContext *write_ctx,
                                   IOHandler *io_write,
                                   void *opaque);
     int (*io_flush)(QIOChannel *ioc,
@@ -498,6 +501,21 @@ int qio_channel_set_blocking(QIOChannel *ioc,
                              bool enabled,
                              Error **errp);
 
+/**
+ * qio_channel_set_follow_coroutine_ctx:
+ * @ioc: the channel object
+ * @enabled: whether or not to follow the coroutine's AioContext
+ *
+ * If @enabled is true, calls to qio_channel_yield() use the current
+ * coroutine's AioContext. Usually this is desirable.
+ *
+ * If @enabled is false, calls to qio_channel_yield() use the global iohandler
+ * AioContext. This is may be used by coroutines that run in the main loop and
+ * do not wish to respond to I/O during nested event loops. This is the
+ * default for compatibility with code that is not aware of AioContexts.
+ */
+void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled);
+
 /**
  * qio_channel_close:
  * @ioc: the channel object
@@ -785,8 +803,9 @@ void qio_channel_wait(QIOChannel *ioc,
 /**
  * qio_channel_set_aio_fd_handler:
  * @ioc: the channel object
- * @ctx: the AioContext to set the handlers on
+ * @read_ctx: the AioContext to set the read handler on or NULL
  * @io_read: the read handler
+ * @write_ctx: the AioContext to set the write handler on or NULL
  * @io_write: the write handler
  * @opaque: the opaque value passed to the handler
  *
@@ -794,10 +813,17 @@ void qio_channel_wait(QIOChannel *ioc,
  * be used by channel implementations to forward the handlers
  * to another channel (e.g. from #QIOChannelTLS to the
  * underlying socket).
+ *
+ * When @read_ctx is NULL, don't touch the read handler. When @write_ctx is
+ * NULL, don't touch the write handler. Note that setting the read handler
+ * clears the write handler, and vice versa, if they share the same AioContext.
+ * Therefore the caller must pass both handlers together when sharing the same
+ * AioContext.
  */
 void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
-                                    AioContext *ctx,
+                                    AioContext *read_ctx,
                                     IOHandler *io_read,
+                                    AioContext *write_ctx,
                                     IOHandler *io_write,
                                     void *opaque);
 
diff --git a/include/qemu/vhost-user-server.h b/include/qemu/vhost-user-server.h
index b1c1cda886..64ad701015 100644
--- a/include/qemu/vhost-user-server.h
+++ b/include/qemu/vhost-user-server.h
@@ -43,6 +43,7 @@ typedef struct {
     unsigned int in_flight; /* atomic */
 
     /* Protected by ctx lock */
+    bool in_qio_channel_yield;
     bool wait_idle;
     VuDev vu_dev;
     QIOChannel *ioc; /* The I/O channel with the client */
diff --git a/block/nbd.c b/block/nbd.c
index 5322e66166..cc48580df7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -352,7 +352,7 @@ int coroutine_fn nbd_co_do_establish_connection(BlockDriverState *bs,
     }
 
     qio_channel_set_blocking(s->ioc, false, NULL);
-    qio_channel_attach_aio_context(s->ioc, bdrv_get_aio_context(bs));
+    qio_channel_set_follow_coroutine_ctx(s->ioc, true);
 
     /* successfully connected */
     WITH_QEMU_LOCK_GUARD(&s->requests_lock) {
@@ -397,7 +397,6 @@ static void coroutine_fn GRAPH_RDLOCK nbd_reconnect_attempt(BDRVNBDState *s)
 
     /* Finalize previous connection if any */
     if (s->ioc) {
-        qio_channel_detach_aio_context(s->ioc);
         yank_unregister_function(BLOCKDEV_YANK_INSTANCE(s->bs->node_name),
                                  nbd_yank, s->bs);
         object_unref(OBJECT(s->ioc));
@@ -2089,10 +2088,6 @@ static void nbd_attach_aio_context(BlockDriverState *bs,
      * the reconnect_delay_timer cannot be active here.
      */
     assert(!s->reconnect_delay_timer);
-
-    if (s->ioc) {
-        qio_channel_attach_aio_context(s->ioc, new_context);
-    }
 }
 
 static void nbd_detach_aio_context(BlockDriverState *bs)
@@ -2101,10 +2096,6 @@ static void nbd_detach_aio_context(BlockDriverState *bs)
 
     assert(!s->open_timer);
     assert(!s->reconnect_delay_timer);
-
-    if (s->ioc) {
-        qio_channel_detach_aio_context(s->ioc);
-    }
 }
 
 static BlockDriver bdrv_nbd = {
diff --git a/io/channel-command.c b/io/channel-command.c
index 7ed726c802..1f61026222 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -331,14 +331,21 @@ static int qio_channel_command_close(QIOChannel *ioc,
 
 
 static void qio_channel_command_set_aio_fd_handler(QIOChannel *ioc,
-                                                   AioContext *ctx,
+                                                   AioContext *read_ctx,
                                                    IOHandler *io_read,
+                                                   AioContext *write_ctx,
                                                    IOHandler *io_write,
                                                    void *opaque)
 {
     QIOChannelCommand *cioc = QIO_CHANNEL_COMMAND(ioc);
-    aio_set_fd_handler(ctx, cioc->readfd, io_read, NULL, NULL, NULL, opaque);
-    aio_set_fd_handler(ctx, cioc->writefd, NULL, io_write, NULL, NULL, opaque);
+    if (read_ctx) {
+        aio_set_fd_handler(read_ctx, cioc->readfd, io_read, NULL,
+                NULL, NULL, opaque);
+    }
+    if (write_ctx) {
+        aio_set_fd_handler(write_ctx, cioc->writefd, NULL, io_write,
+                NULL, NULL, opaque);
+    }
 }
 
 
diff --git a/io/channel-file.c b/io/channel-file.c
index 8b5821f452..e6c6329dbb 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -192,13 +192,27 @@ static int qio_channel_file_close(QIOChannel *ioc,
 
 
 static void qio_channel_file_set_aio_fd_handler(QIOChannel *ioc,
-                                                AioContext *ctx,
+                                                AioContext *read_ctx,
                                                 IOHandler *io_read,
+                                                AioContext *write_ctx,
                                                 IOHandler *io_write,
                                                 void *opaque)
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
-    aio_set_fd_handler(ctx, fioc->fd, io_read, io_write, NULL, NULL, opaque);
+
+    if (read_ctx == write_ctx) {
+        aio_set_fd_handler(read_ctx, fioc->fd, io_read, io_write,
+                NULL, NULL, opaque);
+    } else {
+        if (read_ctx) {
+            aio_set_fd_handler(read_ctx, fioc->fd, io_read, NULL,
+                    NULL, NULL, opaque);
+        }
+        if (write_ctx) {
+            aio_set_fd_handler(write_ctx, fioc->fd, NULL, io_write,
+                    NULL, NULL, opaque);
+        }
+    }
 }
 
 static GSource *qio_channel_file_create_watch(QIOChannel *ioc,
diff --git a/io/channel-null.c b/io/channel-null.c
index 4fafdb770d..ef99586348 100644
--- a/io/channel-null.c
+++ b/io/channel-null.c
@@ -128,8 +128,9 @@ qio_channel_null_close(QIOChannel *ioc,
 
 static void
 qio_channel_null_set_aio_fd_handler(QIOChannel *ioc G_GNUC_UNUSED,
-                                    AioContext *ctx G_GNUC_UNUSED,
+                                    AioContext *read_ctx G_GNUC_UNUSED,
                                     IOHandler *io_read G_GNUC_UNUSED,
+                                    AioContext *write_ctx G_GNUC_UNUSED,
                                     IOHandler *io_write G_GNUC_UNUSED,
                                     void *opaque G_GNUC_UNUSED)
 {
diff --git a/io/channel-socket.c b/io/channel-socket.c
index d99945ebec..daeb92bbe0 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -893,13 +893,27 @@ qio_channel_socket_shutdown(QIOChannel *ioc,
 }
 
 static void qio_channel_socket_set_aio_fd_handler(QIOChannel *ioc,
-                                                  AioContext *ctx,
+                                                  AioContext *read_ctx,
                                                   IOHandler *io_read,
+                                                  AioContext *write_ctx,
                                                   IOHandler *io_write,
                                                   void *opaque)
 {
     QIOChannelSocket *sioc = QIO_CHANNEL_SOCKET(ioc);
-    aio_set_fd_handler(ctx, sioc->fd, io_read, io_write, NULL, NULL, opaque);
+
+    if (read_ctx == write_ctx) {
+        aio_set_fd_handler(read_ctx, sioc->fd, io_read, io_write,
+                           NULL, NULL, opaque);
+    } else {
+        if (read_ctx) {
+            aio_set_fd_handler(read_ctx, sioc->fd, io_read, NULL,
+                               NULL, NULL, opaque);
+        }
+        if (write_ctx) {
+            aio_set_fd_handler(write_ctx, sioc->fd, NULL, io_write,
+                               NULL, NULL, opaque);
+        }
+    }
 }
 
 static GSource *qio_channel_socket_create_watch(QIOChannel *ioc,
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 847d5297c3..58fe1aceee 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -388,14 +388,16 @@ static int qio_channel_tls_close(QIOChannel *ioc,
 }
 
 static void qio_channel_tls_set_aio_fd_handler(QIOChannel *ioc,
-                                               AioContext *ctx,
+                                               AioContext *read_ctx,
                                                IOHandler *io_read,
+                                               AioContext *write_ctx,
                                                IOHandler *io_write,
                                                void *opaque)
 {
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(ioc);
 
-    qio_channel_set_aio_fd_handler(tioc->master, ctx, io_read, io_write, opaque);
+    qio_channel_set_aio_fd_handler(tioc->master, read_ctx, io_read,
+            write_ctx, io_write, opaque);
 }
 
 typedef struct QIOChannelTLSSource QIOChannelTLSSource;
diff --git a/io/channel.c b/io/channel.c
index c415f3fc88..b190d593d3 100644
--- a/io/channel.c
+++ b/io/channel.c
@@ -365,6 +365,12 @@ int qio_channel_set_blocking(QIOChannel *ioc,
 }
 
 
+void qio_channel_set_follow_coroutine_ctx(QIOChannel *ioc, bool enabled)
+{
+    ioc->follow_coroutine_ctx = enabled;
+}
+
+
 int qio_channel_close(QIOChannel *ioc,
                       Error **errp)
 {
@@ -388,14 +394,16 @@ GSource *qio_channel_create_watch(QIOChannel *ioc,
 
 
 void qio_channel_set_aio_fd_handler(QIOChannel *ioc,
-                                    AioContext *ctx,
+                                    AioContext *read_ctx,
                                     IOHandler *io_read,
+                                    AioContext *write_ctx,
                                     IOHandler *io_write,
                                     void *opaque)
 {
     QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
 
-    klass->io_set_aio_fd_handler(ioc, ctx, io_read, io_write, opaque);
+    klass->io_set_aio_fd_handler(ioc, read_ctx, io_read, write_ctx, io_write,
+            opaque);
 }
 
 guint qio_channel_add_watch_full(QIOChannel *ioc,
@@ -542,56 +550,101 @@ static void qio_channel_restart_write(void *opaque)
     aio_co_wake(co);
 }
 
-static void qio_channel_set_aio_fd_handlers(QIOChannel *ioc)
+static void coroutine_fn
+qio_channel_set_fd_handlers(QIOChannel *ioc, GIOCondition condition)
 {
-    IOHandler *rd_handler = NULL, *wr_handler = NULL;
+    AioContext *ctx = ioc->follow_coroutine_ctx ?
+        qemu_coroutine_get_aio_context(qemu_coroutine_self()) :
+        iohandler_get_aio_context();
+    AioContext *read_ctx = NULL;
+    IOHandler *io_read = NULL;
+    AioContext *write_ctx = NULL;
+    IOHandler *io_write = NULL;
+
+    if (condition == G_IO_IN) {
+        ioc->read_coroutine = qemu_coroutine_self();
+        ioc->read_ctx = ctx;
+        read_ctx = ctx;
+        io_read = qio_channel_restart_read;
+
+        /*
+         * Thread safety: if the other coroutine is set and its AioContext
+         * match ours, then there is mutual exclusion between read and write
+         * because they share a single thread and it's safe to set both read
+         * and write fd handlers here. If the AioContext does not match ours,
+         * then both threads may run in parallel but there is no shared state
+         * to worry about.
+         */
+        if (ioc->write_coroutine && ioc->write_ctx == ctx) {
+            write_ctx = ctx;
+            io_write = qio_channel_restart_write;
+        }
+    } else if (condition == G_IO_OUT) {
+        ioc->write_coroutine = qemu_coroutine_self();
+        ioc->write_ctx = ctx;
+        write_ctx = ctx;
+        io_write = qio_channel_restart_write;
+        if (ioc->read_coroutine && ioc->read_ctx == ctx) {
+            read_ctx = ctx;
+            io_read = qio_channel_restart_read;
+        }
+    } else {
+        abort();
+    }
+
+    qio_channel_set_aio_fd_handler(ioc, read_ctx, io_read,
+            write_ctx, io_write, ioc);
+}
+
+static void coroutine_fn
+qio_channel_clear_fd_handlers(QIOChannel *ioc, GIOCondition condition)
+{
+    AioContext *read_ctx = NULL;
+    IOHandler *io_read = NULL;
+    AioContext *write_ctx = NULL;
+    IOHandler *io_write = NULL;
     AioContext *ctx;
 
-    if (ioc->read_coroutine) {
-        rd_handler = qio_channel_restart_read;
+    if (condition == G_IO_IN) {
+        ctx = ioc->read_ctx;
+        read_ctx = ctx;
+        io_read = NULL;
+        if (ioc->write_coroutine && ioc->write_ctx == ctx) {
+            write_ctx = ctx;
+            io_write = qio_channel_restart_write;
+        }
+    } else if (condition == G_IO_OUT) {
+        ctx = ioc->write_ctx;
+        write_ctx = ctx;
+        io_write = NULL;
+        if (ioc->read_coroutine && ioc->read_ctx == ctx) {
+            read_ctx = ctx;
+            io_read = qio_channel_restart_read;
+        }
+    } else {
+        abort();
     }
-    if (ioc->write_coroutine) {
-        wr_handler = qio_channel_restart_write;
-    }
-
-    ctx = ioc->ctx ? ioc->ctx : iohandler_get_aio_context();
-    qio_channel_set_aio_fd_handler(ioc, ctx, rd_handler, wr_handler, ioc);
-}
-
-void qio_channel_attach_aio_context(QIOChannel *ioc,
-                                    AioContext *ctx)
-{
-    assert(!ioc->read_coroutine);
-    assert(!ioc->write_coroutine);
-    ioc->ctx = ctx;
-}
 
-void qio_channel_detach_aio_context(QIOChannel *ioc)
-{
-    ioc->read_coroutine = NULL;
-    ioc->write_coroutine = NULL;
-    qio_channel_set_aio_fd_handlers(ioc);
-    ioc->ctx = NULL;
+    qio_channel_set_aio_fd_handler(ioc, read_ctx, io_read,
+            write_ctx, io_write, ioc);
 }
 
 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
                                     GIOCondition condition)
 {
-    AioContext *ioc_ctx = ioc->ctx ?: qemu_get_aio_context();
+    AioContext *ioc_ctx;
 
     assert(qemu_in_coroutine());
-    assert(in_aio_context_home_thread(ioc_ctx));
+    ioc_ctx = qemu_coroutine_get_aio_context(qemu_coroutine_self());
 
     if (condition == G_IO_IN) {
         assert(!ioc->read_coroutine);
-        ioc->read_coroutine = qemu_coroutine_self();
     } else if (condition == G_IO_OUT) {
         assert(!ioc->write_coroutine);
-        ioc->write_coroutine = qemu_coroutine_self();
     } else {
         abort();
     }
-    qio_channel_set_aio_fd_handlers(ioc);
+    qio_channel_set_fd_handlers(ioc, condition);
     qemu_coroutine_yield();
     assert(in_aio_context_home_thread(ioc_ctx));
 
@@ -599,11 +652,10 @@ void coroutine_fn qio_channel_yield(QIOChannel *ioc,
      * through the aio_fd_handlers. */
     if (condition == G_IO_IN) {
         assert(ioc->read_coroutine == NULL);
-        qio_channel_set_aio_fd_handlers(ioc);
     } else if (condition == G_IO_OUT) {
         assert(ioc->write_coroutine == NULL);
-        qio_channel_set_aio_fd_handlers(ioc);
     }
+    qio_channel_clear_fd_handlers(ioc, condition);
 }
 
 void qio_channel_wake_read(QIOChannel *ioc)
diff --git a/migration/channel-block.c b/migration/channel-block.c
index b7374363c3..fff8d87094 100644
--- a/migration/channel-block.c
+++ b/migration/channel-block.c
@@ -158,8 +158,9 @@ qio_channel_block_close(QIOChannel *ioc,
 
 static void
 qio_channel_block_set_aio_fd_handler(QIOChannel *ioc,
-                                     AioContext *ctx,
+                                     AioContext *read_ctx,
                                      IOHandler *io_read,
+                                     AioContext *write_ctx,
                                      IOHandler *io_write,
                                      void *opaque)
 {
diff --git a/nbd/client.c b/nbd/client.c
index 479208d5d9..81877d088d 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -948,7 +948,7 @@ static int nbd_start_negotiate(AioContext *aio_context, QIOChannel *ioc,
                 ioc = *outioc;
                 if (aio_context) {
                     qio_channel_set_blocking(ioc, false, NULL);
-                    qio_channel_attach_aio_context(ioc, aio_context);
+                    qio_channel_set_follow_coroutine_ctx(ioc, true);
                 }
             } else {
                 error_setg(errp, "Server does not support STARTTLS");
diff --git a/nbd/server.c b/nbd/server.c
index 8486b64b15..b5f93a20c9 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1333,6 +1333,7 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
      */
 
     qio_channel_set_blocking(client->ioc, false, NULL);
+    qio_channel_set_follow_coroutine_ctx(client->ioc, true);
 
     trace_nbd_negotiate_begin();
     memcpy(buf, "NBDMAGIC", 8);
@@ -1352,11 +1353,6 @@ static coroutine_fn int nbd_negotiate(NBDClient *client, Error **errp)
         return ret;
     }
 
-    /* Attach the channel to the same AioContext as the export */
-    if (client->exp && client->exp->common.ctx) {
-        qio_channel_attach_aio_context(client->ioc, client->exp->common.ctx);
-    }
-
     assert(!client->optlen);
     trace_nbd_negotiate_success();
 
@@ -1465,7 +1461,6 @@ void nbd_client_put(NBDClient *client)
          */
         assert(client->closing);
 
-        qio_channel_detach_aio_context(client->ioc);
         object_unref(OBJECT(client->sioc));
         object_unref(OBJECT(client->ioc));
         if (client->tlscreds) {
@@ -1544,8 +1539,6 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
     exp->common.ctx = ctx;
 
     QTAILQ_FOREACH(client, &exp->clients, next) {
-        qio_channel_attach_aio_context(client->ioc, ctx);
-
         assert(client->nb_requests == 0);
         assert(client->recv_coroutine == NULL);
         assert(client->send_coroutine == NULL);
@@ -1555,14 +1548,9 @@ static void blk_aio_attached(AioContext *ctx, void *opaque)
 static void blk_aio_detach(void *opaque)
 {
     NBDExport *exp = opaque;
-    NBDClient *client;
 
     trace_nbd_blk_aio_detach(exp->name, exp->common.ctx);
 
-    QTAILQ_FOREACH(client, &exp->clients, next) {
-        qio_channel_detach_aio_context(client->ioc);
-    }
-
     exp->common.ctx = NULL;
 }
 
diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index ae44a816e1..c6c6347e9b 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -735,8 +735,7 @@ static void coroutine_fn prh_co_entry(void *opaque)
 
     qio_channel_set_blocking(QIO_CHANNEL(client->ioc),
                              false, NULL);
-    qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc),
-                                   qemu_get_aio_context());
+    qio_channel_set_follow_coroutine_ctx(QIO_CHANNEL(client->ioc), true);
 
     /* A very simple negotiation for future extensibility.  No features
      * are defined so write 0.
@@ -796,7 +795,6 @@ static void coroutine_fn prh_co_entry(void *opaque)
     }
 
 out:
-    qio_channel_detach_aio_context(QIO_CHANNEL(client->ioc));
     object_unref(OBJECT(client->ioc));
     g_free(client);
 }
diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
index cd17fb5326..b4b6bf30a2 100644
--- a/util/vhost-user-server.c
+++ b/util/vhost-user-server.c
@@ -127,7 +127,14 @@ vu_message_read(VuDev *vu_dev, int conn_fd, VhostUserMsg *vmsg)
         if (rc < 0) {
             if (rc == QIO_CHANNEL_ERR_BLOCK) {
                 assert(local_err == NULL);
-                qio_channel_yield(ioc, G_IO_IN);
+                if (server->ctx) {
+                    server->in_qio_channel_yield = true;
+                    qio_channel_yield(ioc, G_IO_IN);
+                    server->in_qio_channel_yield = false;
+                } else {
+                    /* Wait until attached to an AioContext again */
+                    qemu_coroutine_yield();
+                }
                 continue;
             } else {
                 error_report_err(local_err);
@@ -278,7 +285,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
         vu_fd_watch->fd = fd;
         vu_fd_watch->cb = cb;
         qemu_socket_set_nonblock(fd);
-        aio_set_fd_handler(server->ioc->ctx, fd, kick_handler,
+        aio_set_fd_handler(server->ctx, fd, kick_handler,
                            NULL, NULL, NULL, vu_fd_watch);
         vu_fd_watch->vu_dev = vu_dev;
         vu_fd_watch->pvt = pvt;
@@ -299,7 +306,7 @@ static void remove_watch(VuDev *vu_dev, int fd)
     if (!vu_fd_watch) {
         return;
     }
-    aio_set_fd_handler(server->ioc->ctx, fd, NULL, NULL, NULL, NULL, NULL);
+    aio_set_fd_handler(server->ctx, fd, NULL, NULL, NULL, NULL, NULL);
 
     QTAILQ_REMOVE(&server->vu_fd_watches, vu_fd_watch, next);
     g_free(vu_fd_watch);
@@ -344,6 +351,8 @@ static void vu_accept(QIONetListener *listener, QIOChannelSocket *sioc,
     /* TODO vu_message_write() spins if non-blocking! */
     qio_channel_set_blocking(server->ioc, false, NULL);
 
+    qio_channel_set_follow_coroutine_ctx(server->ioc, true);
+
     server->co_trip = qemu_coroutine_create(vu_client_trip, server);
 
     aio_context_acquire(server->ctx);
@@ -399,13 +408,12 @@ void vhost_user_server_attach_aio_context(VuServer *server, AioContext *ctx)
         return;
     }
 
-    qio_channel_attach_aio_context(server->ioc, ctx);
-
     QTAILQ_FOREACH(vu_fd_watch, &server->vu_fd_watches, next) {
         aio_set_fd_handler(ctx, vu_fd_watch->fd, kick_handler, NULL,
                            NULL, NULL, vu_fd_watch);
     }
 
+    assert(!server->in_qio_channel_yield);
     aio_co_schedule(ctx, server->co_trip);
 }
 
@@ -419,11 +427,16 @@ void vhost_user_server_detach_aio_context(VuServer *server)
             aio_set_fd_handler(server->ctx, vu_fd_watch->fd,
                                NULL, NULL, NULL, NULL, vu_fd_watch);
         }
-
-        qio_channel_detach_aio_context(server->ioc);
     }
 
     server->ctx = NULL;
+
+    if (server->ioc) {
+        if (server->in_qio_channel_yield) {
+            /* Stop receiving the next vhost-user message */
+            qio_channel_wake_read(server->ioc);
+        }
+    }
 }
 
 bool vhost_user_server_start(VuServer *server,
-- 
2.41.0


