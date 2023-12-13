Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D1E812087
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 22:17:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDWaF-0005Q3-UG; Wed, 13 Dec 2023 16:15:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaE-0005PR-DU
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rDWaC-0004xN-Cj
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 16:15:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702502155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNQ4Z5Vu7lEIKts58kf7lQYbs7BMpPMSCU8sm2F0U4c=;
 b=iZ1Genp8OhOyCoq9ZR37ocahlB2xxhfxAc9Jr+y67OeHC1tjtjNFAdJ/wKIfzQykO+TbSh
 O0eu+pIKgbR1kZGO9GEaacHoayjS7mvujLpzihiEANRew/eGcAPqFfFrcbfgFVP3++vAA1
 UTLj6wtlk2jBoq/L65OI7osmUhFvMaA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-5gMFgXjbPkmKVFnqlqN4EQ-1; Wed, 13 Dec 2023 16:15:52 -0500
X-MC-Unique: 5gMFgXjbPkmKVFnqlqN4EQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CF1E85A58A;
 Wed, 13 Dec 2023 21:15:52 +0000 (UTC)
Received: from localhost (unknown [10.39.195.82])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C462B40C6EB9;
 Wed, 13 Dec 2023 21:15:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fiona Ebner <f.ebner@proxmox.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 2/3] aio: use counter instead of ctx->list_lock
Date: Wed, 13 Dec 2023 16:15:43 -0500
Message-ID: <20231213211544.1601971-3-stefanha@redhat.com>
In-Reply-To: <20231213211544.1601971-1-stefanha@redhat.com>
References: <20231213211544.1601971-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

TODO further simplifications may be possible, like using none _RCU() macros for the aio_handlers QLIST

Now that aio_set_fd_handler() uses a BH to schedule itself in remote
AioContexts it is no longer necessary to worry about multi-threading.
Replace the ctx->list_lock locked counter with a plain uint32_t counter
called ctx->walking_handlers.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/aio.h | 22 ++++++----------------
 util/aio-posix.c    | 44 ++++++++++++++++----------------------------
 util/async.c        |  2 --
 util/fdmon-epoll.c  |  6 +-----
 4 files changed, 23 insertions(+), 51 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index af05512a7d..569e704411 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -71,8 +71,6 @@ typedef struct {
      *            removed
      *
      * Add/remove/modify a monitored file descriptor.
-     *
-     * Called with ctx->list_lock acquired.
      */
     void (*update)(AioContext *ctx, AioHandler *old_node, AioHandler *new_node);
 
@@ -84,7 +82,7 @@ typedef struct {
      *
      * Wait for file descriptors to become ready and place them on ready_list.
      *
-     * Called with ctx->list_lock incremented but not locked.
+     * Called with ctx->walking_handlers incremented.
      *
      * Returns: number of ready file descriptors.
      */
@@ -136,10 +134,10 @@ struct AioContext {
      */
     BdrvGraphRWlock *bdrv_graph;
 
-    /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
+    /* The list of registered AIO handlers. */
     AioHandlerList aio_handlers;
 
-    /* The list of AIO handlers to be deleted.  Protected by ctx->list_lock. */
+    /* The list of AIO handlers to be deleted. */
     AioHandlerList deleted_aio_handlers;
 
     /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
@@ -171,11 +169,8 @@ struct AioContext {
      */
     uint32_t notify_me;
 
-    /* A lock to protect between QEMUBH and AioHandler adders and deleter,
-     * and to ensure that no callbacks are removed while we're walking and
-     * dispatching them.
-     */
-    QemuLockCnt list_lock;
+    /* Re-entrancy counter for iterating over aio_handlers */
+    uint32_t walking_handlers;
 
     /* Bottom Halves pending aio_bh_poll() processing */
     BHList bh_list;
@@ -236,12 +231,7 @@ struct AioContext {
     /* AIO engine parameters */
     int64_t aio_max_batch;  /* maximum number of requests in a batch */
 
-    /*
-     * List of handlers participating in userspace polling.  Protected by
-     * ctx->list_lock.  Iterated and modified mostly by the event loop thread
-     * from aio_poll() with ctx->list_lock incremented.  aio_set_fd_handler()
-     * only touches the list to delete nodes if ctx->list_lock's count is zero.
-     */
+    /* List of handlers participating in userspace polling. */
     AioHandlerList poll_aio_handlers;
 
     /* Are we in polling mode or monitoring file descriptors? */
diff --git a/util/aio-posix.c b/util/aio-posix.c
index c5e944f30b..86e232e9d3 100644
--- a/util/aio-posix.c
+++ b/util/aio-posix.c
@@ -84,7 +84,7 @@ static bool aio_remove_fd_handler(AioContext *ctx, AioHandler *node)
     }
 
     /* If a read is in progress, just mark the node as deleted */
-    if (qemu_lockcnt_count(&ctx->list_lock)) {
+    if (ctx->walking_handlers > 0) {
         QLIST_INSERT_HEAD_RCU(&ctx->deleted_aio_handlers, node, node_deleted);
         return false;
     }
@@ -116,14 +116,11 @@ static void aio_set_fd_handler_local(AioContext *ctx,
         io_poll = NULL; /* polling only makes sense if there is a handler */
     }
 
-    qemu_lockcnt_lock(&ctx->list_lock);
-
     node = find_aio_handler(ctx, fd);
 
     /* Are we deleting the fd handler? */
     if (!io_read && !io_write && !io_poll) {
         if (node == NULL) {
-            qemu_lockcnt_unlock(&ctx->list_lock);
             return;
         }
         /* Clean events in order to unregister fd from the ctx epoll. */
@@ -171,7 +168,6 @@ static void aio_set_fd_handler_local(AioContext *ctx,
     if (node) {
         deleted = aio_remove_fd_handler(ctx, node);
     }
-    qemu_lockcnt_unlock(&ctx->list_lock);
     aio_notify(ctx);
 
     if (deleted) {
@@ -317,7 +313,7 @@ static bool poll_set_started(AioContext *ctx, AioHandlerList *ready_list,
 
     ctx->poll_started = started;
 
-    qemu_lockcnt_inc(&ctx->list_lock);
+    ctx->walking_handlers++;
     QLIST_FOREACH(node, &ctx->poll_aio_handlers, node_poll) {
         IOHandler *fn;
 
@@ -341,7 +337,7 @@ static bool poll_set_started(AioContext *ctx, AioHandlerList *ready_list,
             progress = true;
         }
     }
-    qemu_lockcnt_dec(&ctx->list_lock);
+    ctx->walking_handlers--;
 
     return progress;
 }
@@ -363,12 +359,7 @@ bool aio_pending(AioContext *ctx)
     AioHandler *node;
     bool result = false;
 
-    /*
-     * We have to walk very carefully in case aio_set_fd_handler is
-     * called while we're walking.
-     */
-    qemu_lockcnt_inc(&ctx->list_lock);
-
+    ctx->walking_handlers++;
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         int revents;
 
@@ -383,19 +374,17 @@ bool aio_pending(AioContext *ctx)
             break;
         }
     }
-    qemu_lockcnt_dec(&ctx->list_lock);
+    ctx->walking_handlers--;
 
     return result;
 }
 
+/* Caller must not have ctx->walking_handlers incremented */
 static void aio_free_deleted_handlers(AioContext *ctx)
 {
     AioHandler *node;
 
-    if (QLIST_EMPTY_RCU(&ctx->deleted_aio_handlers)) {
-        return;
-    }
-    if (!qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
+    if (ctx->walking_handlers > 0) {
         return; /* we are nested, let the parent do the freeing */
     }
 
@@ -405,8 +394,6 @@ static void aio_free_deleted_handlers(AioContext *ctx)
         QLIST_SAFE_REMOVE(node, node_poll);
         g_free(node);
     }
-
-    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
 }
 
 static bool aio_dispatch_handler(AioContext *ctx, AioHandler *node)
@@ -511,11 +498,12 @@ static bool aio_dispatch_handlers(AioContext *ctx)
 
 void aio_dispatch(AioContext *ctx)
 {
-    qemu_lockcnt_inc(&ctx->list_lock);
+    ctx->walking_handlers++;
     aio_bh_poll(ctx);
     aio_dispatch_handlers(ctx);
+    ctx->walking_handlers--;
+
     aio_free_deleted_handlers(ctx);
-    qemu_lockcnt_dec(&ctx->list_lock);
 
     timerlistgroup_run_timers(&ctx->tlg);
 }
@@ -607,7 +595,7 @@ static bool remove_idle_poll_handlers(AioContext *ctx,
  *
  * Polls for a given time.
  *
- * Note that the caller must have incremented ctx->list_lock.
+ * Note that the caller must have incremented ctx->walking_handlers.
  *
  * Returns: true if progress was made, false otherwise
  */
@@ -617,7 +605,7 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
     bool progress;
     int64_t start_time, elapsed_time;
 
-    assert(qemu_lockcnt_count(&ctx->list_lock) > 0);
+    assert(&ctx->walking_handlers > 0);
 
     trace_run_poll_handlers_begin(ctx, max_ns, *timeout);
 
@@ -663,7 +651,7 @@ static bool run_poll_handlers(AioContext *ctx, AioHandlerList *ready_list,
  * @timeout: timeout for blocking wait, computed by the caller and updated if
  *    polling succeeds.
  *
- * Note that the caller must have incremented ctx->list_lock.
+ * Note that the caller must have incremented ctx->walking_handlers.
  *
  * Returns: true if progress was made, false otherwise
  */
@@ -711,7 +699,7 @@ bool aio_poll(AioContext *ctx, bool blocking)
     assert(in_aio_context_home_thread(ctx == iohandler_get_aio_context() ?
                                       qemu_get_aio_context() : ctx));
 
-    qemu_lockcnt_inc(&ctx->list_lock);
+    ctx->walking_handlers++;
 
     if (ctx->poll_max_ns) {
         start = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
@@ -814,9 +802,9 @@ bool aio_poll(AioContext *ctx, bool blocking)
     progress |= aio_bh_poll(ctx);
     progress |= aio_dispatch_ready_handlers(ctx, &ready_list);
 
-    aio_free_deleted_handlers(ctx);
+    ctx->walking_handlers--;
 
-    qemu_lockcnt_dec(&ctx->list_lock);
+    aio_free_deleted_handlers(ctx);
 
     progress |= timerlistgroup_run_timers(&ctx->tlg);
 
diff --git a/util/async.c b/util/async.c
index 460529057c..19dd9efce1 100644
--- a/util/async.c
+++ b/util/async.c
@@ -412,7 +412,6 @@ aio_ctx_finalize(GSource     *source)
     aio_set_event_notifier(ctx, &ctx->notifier, NULL, NULL, NULL);
     event_notifier_cleanup(&ctx->notifier);
     qemu_rec_mutex_destroy(&ctx->lock);
-    qemu_lockcnt_destroy(&ctx->list_lock);
     timerlistgroup_deinit(&ctx->tlg);
     unregister_aiocontext(ctx);
     aio_context_destroy(ctx);
@@ -585,7 +584,6 @@ AioContext *aio_context_new(Error **errp)
         goto fail;
     }
     g_source_set_can_recurse(&ctx->source, true);
-    qemu_lockcnt_init(&ctx->list_lock);
 
     ctx->co_schedule_bh = aio_bh_new(ctx, co_schedule_bh_cb, ctx);
     QSLIST_INIT(&ctx->scheduled_coroutines);
diff --git a/util/fdmon-epoll.c b/util/fdmon-epoll.c
index c6413cb18f..ec7c8effc9 100644
--- a/util/fdmon-epoll.c
+++ b/util/fdmon-epoll.c
@@ -132,15 +132,11 @@ bool fdmon_epoll_try_upgrade(AioContext *ctx, unsigned npfd)
         return false;
     }
 
-    /* The list must not change while we add fds to epoll */
-    if (!qemu_lockcnt_dec_if_lock(&ctx->list_lock)) {
+    if (ctx->walking_handlers > 1) {
         return false;
     }
 
     ok = fdmon_epoll_try_enable(ctx);
-
-    qemu_lockcnt_inc_and_unlock(&ctx->list_lock);
-
     if (!ok) {
         fdmon_epoll_disable(ctx);
     }
-- 
2.43.0


