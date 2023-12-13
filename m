Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B029812089
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWaH-0005R5-Kc; Wed, 13 Dec 2023 16:16:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaF-0005QS-QX
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaD-0004xo-Kq
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkKm+eXRl7l3OD2B5ezumByGMlEISCALx3XbpALonO0=;
 b=Ngs3/mlHkwfxnqcoQb1fYYGGyo6kFplWHzEWSBf0acWOVU2Bs3BlrAICUnYRUovm5wyzIP
 1K9ql4NcT/z94POWQCz9wPYzQmMsBjUT+YSJaODO/RemT/KIbTLItzOR+CS8rzD/QjYqbc
 Ggf9X6l6KUOJOe+cRcYYOP94At71+Zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-xVCZsMm5Nl6JdMcWsB0xEA-1; Wed, 13 Dec 2023 16:15:50 -0500
X-MC-Unique: xVCZsMm5Nl6JdMcWsB0xEA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DD88101A551;
 Wed, 13 Dec 2023 21:15:50 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 64B932026D66;
 Wed, 13 Dec 2023 21:15:49 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 1/3] aio-posix: run aio_set_fd_handler() in target AioContext
Date: Wed, 13 Dec 2023 16:15:42 -0500
Message-ID: <20231213211544.1601971-2-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

TODO
- What about Windows?

Most of the event loop code runs in the AioContext's home thread. The
exceptions are aio_notify(), aio_bh_scheduler(), aio_set_fd_handler(),
etc. Amongst them, aio_set_fd_handler() is the most complicated because
the aio_handlers list must be both thread-safe and handle nested
aio_poll() simultaneously.

This patch eliminates the multi-threading concerns by moving the actual
work into a BH in the AioContext's home thread.

This change is required to call the AioHandler's io_poll_end() callback
from the AioContext's home thread in a later patch.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 util/aio-posix.c | 106 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/util/aio-posix.c b/util/aio-posix.c
index 7f2c99729d..c5e944f30b 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -97,13 +97,14 @@ static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
     return true;
 }
 
-void aio_set_fd_handler(AioContext *ctx,
-                        int fd,
-                        IOHandler *io_read,
-                        IOHandler *io_write,
-                        AioPollFn *io_poll,
-                        IOHandler *io_poll_ready,
-                        void *opaque)
+/* Perform aio_set_fd_handler() in this thread's AioContext */
+static void aio_set_fd_handler_local(AioContext *ctx,
+                                     int fd,
+                                     IOHandler *io_read,
+                                     IOHandler *io_write,
+                                     AioPollFn *io_poll,
+                                     IOHandler *io_poll_ready,
+                                     void *opaque)
 {
     AioHandler *node;
     AioHandler *new_node = NULL;
@@ -178,6 +179,97 @@ void aio_set_fd_handler(AioContext *ctx,
     }
 }
 
+typedef struct {
+    AioContext *ctx;
+    int fd;
+    IOHandler *io_read;
+    IOHandler *io_write;
+    AioPollFn *io_poll;
+    IOHandler *io_poll_ready;
+    void *opaque;
+    QemuEvent done;
+} AioSetFdHandlerRemote;
+
+static void aio_set_fd_handler_remote_bh(void *opaque)
+{
+    AioSetFdHandlerRemote *data = opaque;
+
+    aio_set_fd_handler_local(data->ctx, data->fd, data->io_read,
+                             data->io_write, data->io_poll,
+                             data->io_poll_ready, data->opaque);
+    qemu_event_set(&data->done);
+}
+
+/* Perform aio_set_fd_handler() in another thread's AioContext */
+static void aio_set_fd_handler_remote(AioContext *ctx,
+                                      int fd,
+                                      IOHandler *io_read,
+                                      IOHandler *io_write,
+                                      AioPollFn *io_poll,
+                                      IOHandler *io_poll_ready,
+                                      void *opaque)
+{
+    AioSetFdHandlerRemote data = {
+        .ctx = ctx,
+        .fd = fd,
+        .io_read = io_read,
+        .io_write = io_write,
+        .io_poll = io_poll,
+        .io_poll_ready = io_poll_ready,
+        .opaque = opaque,
+    };
+
+    /*
+     * Arbitrary threads waiting for each other can deadlock, so only allow
+     * cross-thread aio_set_fd_handler() when the BQL is held.
+     */
+    assert(qemu_in_main_thread());
+
+    qemu_event_init(&data.done, false);
+
+    aio_bh_schedule_oneshot(ctx, aio_set_fd_handler_remote_bh, &data);
+
+    /*
+     * The BQL is not dropped when run from the main loop thread so the
+     * assumption is that this wait is fast.
+     */
+    qemu_event_wait(&data.done);
+
+    qemu_event_destroy(&data.done);
+}
+
+void aio_set_fd_handler(AioContext *ctx,
+                        int fd,
+                        IOHandler *io_read,
+                        IOHandler *io_write,
+                        AioPollFn *io_poll,
+                        IOHandler *io_poll_ready,
+                        void *opaque)
+{
+    /*
+     * Special case for ctx->notifier: it's not possible to rely on
+     * in_aio_context_home_thread() or iohandler_get_aio_context() below when
+     * aio_context_new() calls aio_set_fd_handler() on ctx->notifier.
+     * qemu_set_current_aio_context() and iohandler_ctx haven't been set up yet
+     * at this point. Treat ctx as local when dealing with ctx->notifier.
+     */
+    bool is_ctx_notifier = fd == event_notifier_get_fd(&ctx->notifier);
+
+    /*
+     * iohandler_ctx is special in that it runs in the main thread, but that
+     * thread's context is qemu_aio_context.
+     */
+    if (is_ctx_notifier ||
+        in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
+                                   qemu_get_aio_context() : ctx)) {
+        aio_set_fd_handler_local(ctx, fd, io_read, io_write, io_poll,
+                                 io_poll_ready, opaque);
+    } else {
+        aio_set_fd_handler_remote(ctx, fd, io_read, io_write, io_poll,
+                                  io_poll_ready, opaque);
+    }
+}
+
 static void aio_set_fd_poll(AioContext *ctx, int fd,
                             IOHandler *io_poll_begin,
                             IOHandler *io_poll_end)
-- 
2.43.0


