Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B6B7C729C
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySu-0003eU-W1; Thu, 12 Oct 2023 12:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySq-0003ah-5p
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000Zm-M9
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KV3bkGuHxwopuYxU23flYy/qNdsNUsVMSP78jNlnv10=;
 b=MJ/d0P3IUIRQ9qF8IY9vnt+wpdanIC+RM+rFvmbH2OHTmFEPMrAqv6u0YOdYv07c3BQLtY
 4AAHvNnoLfXA75VgSAaQw3Yk4IZmscz+j1WfDESx37e6N8GVFi2xKusnjXyVjRzzYfBT9X
 di1ImFo89HDWtl62WiWC4CPqWpJPwe8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-MOijYXe6N3SzvrJNPODrsA-1; Thu, 12 Oct 2023 12:22:43 -0400
X-MC-Unique: MOijYXe6N3SzvrJNPODrsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EBB1A81D9E1;
 Thu, 12 Oct 2023 16:22:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BEE5202701E;
 Thu, 12 Oct 2023 16:22:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/26] block: Mark drain related functions GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:07 +0200
Message-ID: <20231012162224.240535-10-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

From: Emanuele Giuseppe Esposito <eesposit@redhat.com>

Draining recursively traverses the graph, therefore we need to make sure
that also such accesses to the graph are protected by the graph rdlock.

There are 3 different drain callers to consider:
1. drain in the main loop: no issue at all, rdlock is nop.
2. drain in an iothread: rdlock only works in main loop or coroutines,
   so disallow it.
3. drain in a coroutine (regardless of AioContext): the drain mechanism
   takes care of scheduling a BH in the bs->aio_context that will
   then take care of perform the actual draining. This is wrong,
   because as pointed in (2) if bs->aio_context is an iothread then
   rdlock won't work. Therefore change bdrv_co_yield_to_drain to
   schedule the BH in the main loop.

Caller (2) also implies that we need to modify test-bdrv-drain.c to
disallow draining in the iothreads.

For some places, we know that they will hold the lock, but we don't have
the GRAPH_RDLOCK annotations yet. In this case, add assume_graph_lock()
with a FIXME comment. These places will be removed once everything is
properly annotated.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-6-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-io.h         | 23 ++++++++++++++++++-----
 include/block/block_int-common.h |  6 +++---
 block.c                          |  6 +++---
 block/io.c                       | 32 ++++++++++++++++++++++++++++----
 tests/unit/test-bdrv-drain.c     |  4 ++--
 5 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 6485b194a4..9707eb3eff 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -370,7 +370,7 @@ bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos);
  *
  * Begin a quiesced section for the parent of @c.
  */
-void bdrv_parent_drained_begin_single(BdrvChild *c);
+void GRAPH_RDLOCK bdrv_parent_drained_begin_single(BdrvChild *c);
 
 /**
  * bdrv_parent_drained_poll_single:
@@ -378,14 +378,14 @@ void bdrv_parent_drained_begin_single(BdrvChild *c);
  * Returns true if there is any pending activity to cease before @c can be
  * called quiesced, false otherwise.
  */
-bool bdrv_parent_drained_poll_single(BdrvChild *c);
+bool GRAPH_RDLOCK bdrv_parent_drained_poll_single(BdrvChild *c);
 
 /**
  * bdrv_parent_drained_end_single:
  *
  * End a quiesced section for the parent of @c.
  */
-void bdrv_parent_drained_end_single(BdrvChild *c);
+void GRAPH_RDLOCK bdrv_parent_drained_end_single(BdrvChild *c);
 
 /**
  * bdrv_drain_poll:
@@ -398,8 +398,9 @@ void bdrv_parent_drained_end_single(BdrvChild *c);
  *
  * This is part of bdrv_drained_begin.
  */
-bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
-                     bool ignore_bds_parents);
+bool GRAPH_RDLOCK
+bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
+                bool ignore_bds_parents);
 
 /**
  * bdrv_drained_begin:
@@ -407,6 +408,12 @@ bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
  * Begin a quiesced section for exclusive access to the BDS, by disabling
  * external request sources including NBD server, block jobs, and device model.
  *
+ * This function can only be invoked by the main loop or a coroutine
+ * (regardless of the AioContext where it is running).
+ * If the coroutine is running in an Iothread AioContext, this function will
+ * just schedule a BH to run in the main loop.
+ * However, it cannot be directly called by an Iothread.
+ *
  * This function can be recursive.
  */
 void bdrv_drained_begin(BlockDriverState *bs);
@@ -423,6 +430,12 @@ void bdrv_do_drained_begin_quiesce(BlockDriverState *bs, BdrvChild *parent);
  * bdrv_drained_end:
  *
  * End a quiescent section started by bdrv_drained_begin().
+ *
+ * This function can only be invoked by the main loop or a coroutine
+ * (regardless of the AioContext where it is running).
+ * If the coroutine is running in an Iothread AioContext, this function will
+ * just schedule a BH to run in the main loop.
+ * However, it cannot be directly called by an Iothread.
  */
 void bdrv_drained_end(BlockDriverState *bs);
 
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 2ca3758cb8..8ef68176a5 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -963,15 +963,15 @@ struct BdrvChildClass {
      * Note that this can be nested. If drained_begin() was called twice, new
      * I/O is allowed only after drained_end() was called twice, too.
      */
-    void (*drained_begin)(BdrvChild *child);
-    void (*drained_end)(BdrvChild *child);
+    void GRAPH_RDLOCK_PTR (*drained_begin)(BdrvChild *child);
+    void GRAPH_RDLOCK_PTR (*drained_end)(BdrvChild *child);
 
     /*
      * Returns whether the parent has pending requests for the child. This
      * callback is polled after .drained_begin() has been called until all
      * activity on the child has stopped.
      */
-    bool (*drained_poll)(BdrvChild *child);
+    bool GRAPH_RDLOCK_PTR (*drained_poll)(BdrvChild *child);
 
     /*
      * Notifies the parent that the filename of its child has changed (e.g.
diff --git a/block.c b/block.c
index 701f77fe2f..6cc4115510 100644
--- a/block.c
+++ b/block.c
@@ -1192,19 +1192,19 @@ static char *bdrv_child_get_parent_desc(BdrvChild *c)
     return g_strdup_printf("node '%s'", bdrv_get_node_name(parent));
 }
 
-static void bdrv_child_cb_drained_begin(BdrvChild *child)
+static void GRAPH_RDLOCK bdrv_child_cb_drained_begin(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
     bdrv_do_drained_begin_quiesce(bs, NULL);
 }
 
-static bool bdrv_child_cb_drained_poll(BdrvChild *child)
+static bool GRAPH_RDLOCK bdrv_child_cb_drained_poll(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
     return bdrv_drain_poll(bs, NULL, false);
 }
 
-static void bdrv_child_cb_drained_end(BdrvChild *child)
+static void GRAPH_RDLOCK bdrv_child_cb_drained_end(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
     bdrv_drained_end(bs);
diff --git a/block/io.c b/block/io.c
index 5821a4d1f5..e2e846d37d 100644
--- a/block/io.c
+++ b/block/io.c
@@ -46,9 +46,12 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs);
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int64_t bytes, BdrvRequestFlags flags);
 
-static void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
+static void GRAPH_RDLOCK
+bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
 {
     BdrvChild *c, *next;
+    IO_OR_GS_CODE();
+    assert_bdrv_graph_readable();
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c == ignore) {
@@ -70,9 +73,12 @@ void bdrv_parent_drained_end_single(BdrvChild *c)
     }
 }
 
-static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
+static void GRAPH_RDLOCK
+bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
 {
     BdrvChild *c;
+    IO_OR_GS_CODE();
+    assert_bdrv_graph_readable();
 
     QLIST_FOREACH(c, &bs->parents, next_parent) {
         if (c == ignore) {
@@ -84,17 +90,22 @@ static void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
 
 bool bdrv_parent_drained_poll_single(BdrvChild *c)
 {
+    IO_OR_GS_CODE();
+
     if (c->klass->drained_poll) {
         return c->klass->drained_poll(c);
     }
     return false;
 }
 
-static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
-                                     bool ignore_bds_parents)
+static bool GRAPH_RDLOCK
+bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
+                         bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
     bool busy = false;
+    IO_OR_GS_CODE();
+    assert_bdrv_graph_readable();
 
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
         if (c == ignore || (ignore_bds_parents && c->klass->parent_is_bds)) {
@@ -114,6 +125,7 @@ void bdrv_parent_drained_begin_single(BdrvChild *c)
     c->quiesced_parent = true;
 
     if (c->klass->drained_begin) {
+        /* called with rdlock taken, but it doesn't really need it. */
         c->klass->drained_begin(c);
     }
 }
@@ -263,6 +275,9 @@ bool bdrv_drain_poll(BlockDriverState *bs, BdrvChild *ignore_parent,
 static bool bdrv_drain_poll_top_level(BlockDriverState *bs,
                                       BdrvChild *ignore_parent)
 {
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     return bdrv_drain_poll(bs, ignore_parent, false);
 }
 
@@ -362,6 +377,7 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, BdrvChild *parent,
 
     /* Stop things in parent-to-child order */
     if (qatomic_fetch_inc(&bs->quiesce_counter) == 0) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         bdrv_parent_drained_begin(bs, parent);
         if (bs->drv && bs->drv->bdrv_drain_begin) {
             bs->drv->bdrv_drain_begin(bs);
@@ -408,12 +424,16 @@ static void bdrv_do_drained_end(BlockDriverState *bs, BdrvChild *parent)
         bdrv_co_yield_to_drain(bs, false, parent, false);
         return;
     }
+
+    /* At this point, we should be always running in the main loop. */
+    GLOBAL_STATE_CODE();
     assert(bs->quiesce_counter > 0);
     GLOBAL_STATE_CODE();
 
     /* Re-enable things in child-to-parent order */
     old_quiesce_counter = qatomic_fetch_dec(&bs->quiesce_counter);
     if (old_quiesce_counter == 1) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         if (bs->drv && bs->drv->bdrv_drain_end) {
             bs->drv->bdrv_drain_end(bs);
         }
@@ -437,6 +457,8 @@ void bdrv_drain(BlockDriverState *bs)
 static void bdrv_drain_assert_idle(BlockDriverState *bs)
 {
     BdrvChild *child, *next;
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     assert(qatomic_read(&bs->in_flight) == 0);
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
@@ -450,7 +472,9 @@ static bool bdrv_drain_all_poll(void)
 {
     BlockDriverState *bs = NULL;
     bool result = false;
+
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     /* bdrv_drain_poll() can't make changes to the graph and we are holding the
      * main AioContext lock, so iterating bdrv_next_all_states() is safe. */
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index bdd3757615..d734829778 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1196,7 +1196,7 @@ static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
     }
 }
 
-static void detach_by_driver_cb_drained_begin(BdrvChild *child)
+static void GRAPH_RDLOCK detach_by_driver_cb_drained_begin(BdrvChild *child)
 {
     struct detach_by_parent_data *data = &detach_by_parent_data;
 
@@ -1233,7 +1233,7 @@ static BdrvChildClass detach_by_driver_cb_class;
  *     state is messed up, but if it is only polled in the single
  *     BDRV_POLL_WHILE() at the end of the drain, this should work fine.
  */
-static void test_detach_indirect(bool by_parent_cb)
+static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
 {
     BlockBackend *blk;
     BlockDriverState *parent_a, *parent_b, *a, *b, *c;
-- 
2.41.0


