Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 815E17169DF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42II-00005f-Tf; Tue, 30 May 2023 12:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42Hi-0006xM-KZ
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42He-0008UC-OV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+p6z9womlcWKNL8k7k9wu4aHeNKiXbRqBsGD/x8Ins=;
 b=anpVMzG0b92dwv9CBffBftu4MVFGSCuAZJ9uNCtfr/2/ONf274Nvbe5jTDb82L4bXC/1lQ
 0fdLerTZ76Q9soyKKa9O3W2ooCcfaUC4LghjuBPklCJb+dUkHpWz6ZD5dKustFxyQpdTby
 G6Jd77zjvV6dTR3ucLFQ9yxH97suCec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-oPEW5R68NK288G4m0atIOw-1; Tue, 30 May 2023 12:33:08 -0400
X-MC-Unique: oPEW5R68NK288G4m0atIOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 031231C01E94;
 Tue, 30 May 2023 16:33:08 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 48D8DC154D2;
 Tue, 30 May 2023 16:33:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 22/32] block: drain from main loop thread in
 bdrv_co_yield_to_drain()
Date: Tue, 30 May 2023 18:32:29 +0200
Message-Id: <20230530163239.576632-23-kwolf@redhat.com>
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

For simplicity, always run BlockDevOps .drained_begin/end/poll()
callbacks in the main loop thread. This makes it easier to implement the
callbacks and avoids extra locks.

Move the function pointer declarations from the I/O Code section to the
Global State section for BlockDevOps, BdrvChildClass, and BlockDriver.

Narrow IO_OR_GS_CODE() to GLOBAL_STATE_CODE() where appropriate.

The test-bdrv-drain test case calls bdrv_drain() from an IOThread. This
is now only allowed from coroutine context, so update the test case to
run in a coroutine.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230516190238.8401-11-stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h      | 72 +++++++++++++--------------
 include/sysemu/block-backend-common.h | 25 +++++-----
 block/io.c                            | 14 ++++--
 tests/unit/test-bdrv-drain.c          | 14 +++---
 4 files changed, 67 insertions(+), 58 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 6492a1e538..b1cbc1e00c 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -363,6 +363,21 @@ struct BlockDriver {
     void (*bdrv_attach_aio_context)(BlockDriverState *bs,
                                     AioContext *new_context);
 
+    /**
+     * bdrv_drain_begin is called if implemented in the beginning of a
+     * drain operation to drain and stop any internal sources of requests in
+     * the driver.
+     * bdrv_drain_end is called if implemented at the end of the drain.
+     *
+     * They should be used by the driver to e.g. manage scheduled I/O
+     * requests, or toggle an internal state. After the end of the drain new
+     * requests will continue normally.
+     *
+     * Implementations of both functions must not call aio_poll().
+     */
+    void (*bdrv_drain_begin)(BlockDriverState *bs);
+    void (*bdrv_drain_end)(BlockDriverState *bs);
+
     /**
      * Try to get @bs's logical and physical block size.
      * On success, store them in @bsz and return zero.
@@ -758,21 +773,6 @@ struct BlockDriver {
     void coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_io_unplug)(
         BlockDriverState *bs);
 
-    /**
-     * bdrv_drain_begin is called if implemented in the beginning of a
-     * drain operation to drain and stop any internal sources of requests in
-     * the driver.
-     * bdrv_drain_end is called if implemented at the end of the drain.
-     *
-     * They should be used by the driver to e.g. manage scheduled I/O
-     * requests, or toggle an internal state. After the end of the drain new
-     * requests will continue normally.
-     *
-     * Implementations of both functions must not call aio_poll().
-     */
-    void (*bdrv_drain_begin)(BlockDriverState *bs);
-    void (*bdrv_drain_end)(BlockDriverState *bs);
-
     bool (*bdrv_supports_persistent_dirty_bitmap)(BlockDriverState *bs);
 
     bool coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_can_store_new_dirty_bitmap)(
@@ -955,6 +955,27 @@ struct BdrvChildClass {
     void GRAPH_WRLOCK_PTR (*attach)(BdrvChild *child);
     void GRAPH_WRLOCK_PTR (*detach)(BdrvChild *child);
 
+    /*
+     * If this pair of functions is implemented, the parent doesn't issue new
+     * requests after returning from .drained_begin() until .drained_end() is
+     * called.
+     *
+     * These functions must not change the graph (and therefore also must not
+     * call aio_poll(), which could change the graph indirectly).
+     *
+     * Note that this can be nested. If drained_begin() was called twice, new
+     * I/O is allowed only after drained_end() was called twice, too.
+     */
+    void (*drained_begin)(BdrvChild *child);
+    void (*drained_end)(BdrvChild *child);
+
+    /*
+     * Returns whether the parent has pending requests for the child. This
+     * callback is polled after .drained_begin() has been called until all
+     * activity on the child has stopped.
+     */
+    bool (*drained_poll)(BdrvChild *child);
+
     /*
      * Notifies the parent that the filename of its child has changed (e.g.
      * because the direct child was removed from the backing chain), so that it
@@ -984,27 +1005,6 @@ struct BdrvChildClass {
     const char *(*get_name)(BdrvChild *child);
 
     AioContext *(*get_parent_aio_context)(BdrvChild *child);
-
-    /*
-     * If this pair of functions is implemented, the parent doesn't issue new
-     * requests after returning from .drained_begin() until .drained_end() is
-     * called.
-     *
-     * These functions must not change the graph (and therefore also must not
-     * call aio_poll(), which could change the graph indirectly).
-     *
-     * Note that this can be nested. If drained_begin() was called twice, new
-     * I/O is allowed only after drained_end() was called twice, too.
-     */
-    void (*drained_begin)(BdrvChild *child);
-    void (*drained_end)(BdrvChild *child);
-
-    /*
-     * Returns whether the parent has pending requests for the child. This
-     * callback is polled after .drained_begin() has been called until all
-     * activity on the child has stopped.
-     */
-    bool (*drained_poll)(BdrvChild *child);
 };
 
 extern const BdrvChildClass child_of_bds;
diff --git a/include/sysemu/block-backend-common.h b/include/sysemu/block-backend-common.h
index 2391679c56..780cea7305 100644
--- a/include/sysemu/block-backend-common.h
+++ b/include/sysemu/block-backend-common.h
@@ -59,6 +59,19 @@ typedef struct BlockDevOps {
      */
     bool (*is_medium_locked)(void *opaque);
 
+    /*
+     * Runs when the backend receives a drain request.
+     */
+    void (*drained_begin)(void *opaque);
+    /*
+     * Runs when the backend's last drain request ends.
+     */
+    void (*drained_end)(void *opaque);
+    /*
+     * Is the device still busy?
+     */
+    bool (*drained_poll)(void *opaque);
+
     /*
      * I/O API functions. These functions are thread-safe.
      *
@@ -76,18 +89,6 @@ typedef struct BlockDevOps {
      * Runs when the size changed (e.g. monitor command block_resize)
      */
     void (*resize_cb)(void *opaque);
-    /*
-     * Runs when the backend receives a drain request.
-     */
-    void (*drained_begin)(void *opaque);
-    /*
-     * Runs when the backend's last drain request ends.
-     */
-    void (*drained_end)(void *opaque);
-    /*
-     * Is the device still busy?
-     */
-    bool (*drained_poll)(void *opaque);
 } BlockDevOps;
 
 /*
diff --git a/block/io.c b/block/io.c
index 4d54fda593..fece938fd0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -60,7 +60,7 @@ static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
 
 void bdrv_parent_drained_end_single(BdrvChild *c)
 {
-    IO_OR_GS_CODE();
+    GLOBAL_STATE_CODE();
 
     assert(c->quiesced_parent);
     c->quiesced_parent = false;
@@ -108,7 +108,7 @@ static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
 
 void bdrv_parent_drained_begin_single(BdrvChild *c)
 {
-    IO_OR_GS_CODE();
+    GLOBAL_STATE_CODE();
 
     assert(!c->quiesced_parent);
     c->quiesced_parent = true;
@@ -247,7 +247,7 @@ typedef struct {
 bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
                      bool ignore_bds_parents)
 {
-    IO_OR_GS_CODE();
+    GLOBAL_STATE_CODE();
 
     if (bdrv_parent_drained_poll(bs, ignore_parent, ignore_bds_parents)) {
         return true;
@@ -334,7 +334,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     if (ctx != co_ctx) {
         aio_context_release(ctx);
     }
-    replay_bh_schedule_oneshot_event(ctx, bdrv_co_drain_bh_cb, &data);
+    replay_bh_schedule_oneshot_event(qemu_get_aio_context(),
+                                     bdrv_co_drain_bh_cb, &data);
 
     qemu_coroutine_yield();
     /* If we are resumed from some other event (such as an aio completion or a
@@ -357,6 +358,8 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
         return;
     }
 
+    GLOBAL_STATE_CODE();
+
     /* Stop things in parent-to-child order */
     if (qatomic_fetch_inc(&bs->quiesce_counter) == 0) {
         aio_disable_external(bdrv_get_aio_context(bs));
@@ -399,11 +402,14 @@ static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
 {
     int old_quiesce_counter;
 
+    IO_OR_GS_CODE();
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false, parent, false);
         return;
     }
     assert(bs->quiesce_counter > 0);
+    GLOBAL_STATE_CODE();
 
     /* Re-enable things in child-to-parent order */
     old_quiesce_counter = qatomic_fetch_dec(&bs->quiesce_counter);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 08bb0f9984..d53a633577 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -483,19 +483,19 @@ struct test_iothread_data {
     BlockDriverState *bs;
     enum drain_type drain_type;
     int *aio_ret;
+    bool co_done;
 };
 
-static void test_iothread_drain_entry(void *opaque)
+static void coroutine_fn test_iothread_drain_co_entry(void *opaque)
 {
     struct test_iothread_data *data = opaque;
 
-    aio_context_acquire(bdrv_get_aio_context(data->bs));
     do_drain_begin(data->drain_type, data->bs);
     g_assert_cmpint(*data->aio_ret, ==, 0);
     do_drain_end(data->drain_type, data->bs);
-    aio_context_release(bdrv_get_aio_context(data->bs));
 
-    qemu_event_set(&done_event);
+    data->co_done = true;
+    aio_wait_kick();
 }
 
 static void test_iothread_aio_cb(void *opaque, int ret)
@@ -531,6 +531,7 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
     BlockDriverState *bs;
     BDRVTestState *s;
     BlockAIOCB *acb;
+    Coroutine *co;
     int aio_ret;
     struct test_iothread_data data;
 
@@ -609,8 +610,9 @@ static void test_iothread_common(enum drain_type drain_type, int drain_thread)
         }
         break;
     case 1:
-        aio_bh_schedule_oneshot(ctx_a, test_iothread_drain_entry, &data);
-        qemu_event_wait(&done_event);
+        co = qemu_coroutine_create(test_iothread_drain_co_entry, &data);
+        aio_co_enter(ctx_a, co);
+        AIO_WAIT_WHILE_UNLOCKED(NULL, !data.co_done);
         break;
     default:
         g_assert_not_reached();
-- 
2.40.1


