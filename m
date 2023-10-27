Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B57A97D9DAB
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:58:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAL-0004iz-8Y; Fri, 27 Oct 2023 11:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA8-0003hK-DT
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA4-0002tH-1R
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZrJsXcemkKbz0S+R479bJvgeggaVu/QXJhSVnztWoc=;
 b=GFXvTYIXGnm9a+dR0CV+Hb+Q59mJGChO9YrmqFO2BCcFcxDZ83Uuh0NuSQ2YUQn9yAOj73
 yETZqIRaYxyfwkQnCL8JTdYyhojX1oXibsGm4GVCttzXDz34C3pzYf+9++CZnpcRd8sKfQ
 T0a8pe7QW/ZZFVQmysZM5T6jLRAiwIg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-GIHLPrmHNrqRy47ym3XAVg-1; Fri, 27 Oct 2023 11:54:09 -0400
X-MC-Unique: GIHLPrmHNrqRy47ym3XAVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF4C5857BC0;
 Fri, 27 Oct 2023 15:54:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8359C5027;
 Fri, 27 Oct 2023 15:54:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 17/24] block: Protect bs->backing with graph_lock
Date: Fri, 27 Oct 2023 17:53:26 +0200
Message-ID: <20231027155333.420094-18-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Almost all functions that access bs->backing already take the graph
lock now. Add locking to the remaining users and finally annotate the
struct field itself as protected by the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h |  2 +-
 block.c                          | 27 +++++++++++++++++----------
 block/commit.c                   |  5 ++++-
 block/mirror.c                   | 17 ++++++++++++-----
 block/qed.c                      |  2 +-
 block/replication.c              |  7 ++++++-
 block/vmdk.c                     |  7 ++++---
 tests/unit/test-bdrv-drain.c     | 22 ++++++++++++++++++----
 tests/unit/test-bdrv-graph-mod.c |  5 ++++-
 9 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index c0db862de7..ed6066929a 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1178,7 +1178,7 @@ struct BlockDriverState {
      * are connected with BdrvChildRole.
      */
     QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) children;
-    BdrvChild *backing;
+    BdrvChild * GRAPH_RDLOCK_PTR backing;
     BdrvChild *file;
 
     QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) parents;
diff --git a/block.c b/block.c
index eb7eeb85e9..41164983a3 100644
--- a/block.c
+++ b/block.c
@@ -3560,10 +3560,14 @@ out:
 int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                         Error **errp)
 {
-    BlockDriverState *drain_bs = bs->backing ? bs->backing->bs : bs;
+    BlockDriverState *drain_bs;
     int ret;
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_rdlock_main_loop();
+    drain_bs = bs->backing ? bs->backing->bs : bs;
+    bdrv_graph_rdunlock_main_loop();
+
     bdrv_ref(drain_bs);
     bdrv_drained_begin(drain_bs);
     bdrv_graph_wrlock(backing_hd);
@@ -3602,6 +3606,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (bs->backing != NULL) {
         goto free_exit;
@@ -3643,10 +3648,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
             implicit_backing = !strcmp(bs->auto_backing_file, bs->backing_file);
         }
 
-        bdrv_graph_rdlock_main_loop();
         backing_filename = bdrv_get_full_backing_filename(bs, &local_err);
-        bdrv_graph_rdunlock_main_loop();
-
         if (local_err) {
             ret = -EINVAL;
             error_propagate(errp, local_err);
@@ -3677,9 +3679,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     if (implicit_backing) {
-        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(backing_hd);
-        bdrv_graph_rdunlock_main_loop();
         pstrcpy(bs->auto_backing_file, sizeof(bs->auto_backing_file),
                 backing_hd->filename);
     }
@@ -4750,8 +4750,8 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
 {
     BlockDriverState *bs = reopen_state->bs;
     BlockDriverState *new_child_bs;
-    BlockDriverState *old_child_bs = is_backing ? child_bs(bs->backing) :
-                                                  child_bs(bs->file);
+    BlockDriverState *old_child_bs;
+
     const char *child_name = is_backing ? "backing" : "file";
     QObject *value;
     const char *str;
@@ -4797,6 +4797,7 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         g_assert_not_reached();
     }
 
+    old_child_bs = is_backing ? child_bs(bs->backing) : child_bs(bs->file);
     if (old_child_bs == new_child_bs) {
         ret = 0;
         goto out_rdlock;
@@ -5008,13 +5009,16 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
      * file or if the image file has a backing file name as part of
      * its metadata. Otherwise the 'backing' option can be omitted.
      */
+    bdrv_graph_rdlock_main_loop();
     if (drv->supports_backing && reopen_state->backing_missing &&
         (reopen_state->bs->backing || reopen_state->bs->backing_file[0])) {
         error_setg(errp, "backing is missing for '%s'",
                    reopen_state->bs->node_name);
+        bdrv_graph_rdunlock_main_loop();
         ret = -EINVAL;
         goto error;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     /*
      * Allow changing the 'backing' option. The new value can be
@@ -5204,10 +5208,11 @@ static void bdrv_close(BlockDriverState *bs)
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
-    bdrv_graph_wrunlock();
 
     assert(!bs->backing);
     assert(!bs->file);
+    bdrv_graph_wrunlock();
+
     g_free(bs->opaque);
     bs->opaque = NULL;
     qatomic_set(&bs->copy_on_read, 0);
@@ -5531,7 +5536,9 @@ int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
 
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_rdlock_main_loop();
     assert(!bs_new->backing);
+    bdrv_graph_rdunlock_main_loop();
 
     old_context = bdrv_get_aio_context(bs_top);
     bdrv_drained_begin(bs_top);
@@ -8111,7 +8118,7 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
 /* Note: This function may return false positives; it may return true
  * even if opening the backing file specified by bs's image header
  * would result in exactly bs->backing. */
-static bool bdrv_backing_overridden(BlockDriverState *bs)
+static bool GRAPH_RDLOCK bdrv_backing_overridden(BlockDriverState *bs)
 {
     GLOBAL_STATE_CODE();
     if (bs->backing) {
diff --git a/block/commit.c b/block/commit.c
index 2fecdce86f..078cc227aa 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -95,7 +95,10 @@ static void commit_abort(Job *job)
      * XXX Can (or should) we somehow keep 'consistent read' blocked even
      * after the failed/cancelled commit job is gone? If we already wrote
      * something to base, the intermediate images aren't valid any more. */
+    bdrv_graph_rdlock_main_loop();
     commit_top_backing_bs = s->commit_top_bs->backing->bs;
+    bdrv_graph_rdunlock_main_loop();
+
     bdrv_drained_begin(commit_top_backing_bs);
     bdrv_graph_wrlock(commit_top_backing_bs);
     bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
@@ -219,7 +222,7 @@ bdrv_commit_top_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
 }
 
-static void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
+static GRAPH_RDLOCK void bdrv_commit_top_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->backing->bs->filename);
diff --git a/block/mirror.c b/block/mirror.c
index e2e325ec56..5034b04362 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -471,7 +471,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
     return bytes_handled;
 }
 
-static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
+static void coroutine_fn GRAPH_RDLOCK mirror_iteration(MirrorBlockJob *s)
 {
     BlockDriverState *source = s->mirror_top_bs->backing->bs;
     MirrorOp *pseudo_op;
@@ -831,14 +831,18 @@ static void coroutine_fn mirror_throttle(MirrorBlockJob *s)
     }
 }
 
-static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
+static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t offset;
-    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
+    BlockDriverState *bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret;
     int64_t count;
 
+    bdrv_graph_co_rdlock();
+    bs = s->mirror_top_bs->backing->bs;
+    bdrv_graph_co_rdunlock();
+
     if (s->zero_target) {
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
             bdrv_set_dirty_bitmap(s->dirty_bitmap, 0, s->bdev_length);
@@ -918,7 +922,7 @@ static int coroutine_fn mirror_flush(MirrorBlockJob *s)
 static int coroutine_fn mirror_run(Job *job, Error **errp)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common.job);
-    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
+    BlockDriverState *bs;
     MirrorBDSOpaque *mirror_top_opaque = s->mirror_top_bs->opaque;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
@@ -935,6 +939,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     }
 
     bdrv_graph_co_rdlock();
+    bs = bdrv_filter_bs(s->mirror_top_bs);
     s->bdev_length = bdrv_co_getlength(bs);
     bdrv_graph_co_rdunlock();
 
@@ -1062,7 +1067,9 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
                 mirror_wait_for_free_in_flight_slot(s);
                 continue;
             } else if (cnt != 0) {
+                bdrv_graph_co_rdlock();
                 mirror_iteration(s);
+                bdrv_graph_co_rdunlock();
             }
         }
 
@@ -1587,7 +1594,7 @@ bdrv_mirror_top_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
                                     NULL, 0);
 }
 
-static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
+static void GRAPH_RDLOCK bdrv_mirror_top_refresh_filename(BlockDriverState *bs)
 {
     if (bs->backing == NULL) {
         /* we can be here after failed bdrv_attach_child in
diff --git a/block/qed.c b/block/qed.c
index 45ae320290..686ad711f7 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1138,7 +1138,7 @@ out:
 /**
  * Check if the QED_F_NEED_CHECK bit should be set during allocating write
  */
-static bool qed_should_set_need_check(BDRVQEDState *s)
+static bool GRAPH_RDLOCK qed_should_set_need_check(BDRVQEDState *s)
 {
     /* The flush before L2 update path ensures consistency */
     if (s->bs->backing) {
diff --git a/block/replication.c b/block/replication.c
index d522c7396f..49ecc608b2 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -363,6 +363,9 @@ static void reopen_backing_file(BlockDriverState *bs, bool writable,
     BdrvChild *hidden_disk, *secondary_disk;
     BlockReopenQueue *reopen_queue = NULL;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /*
      * s->hidden_disk and s->secondary_disk may not be set yet, as they will
      * only be set after the children are writable.
@@ -496,9 +499,11 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
     case REPLICATION_MODE_PRIMARY:
         break;
     case REPLICATION_MODE_SECONDARY:
+        bdrv_graph_rdlock_main_loop();
         active_disk = bs->file;
         if (!active_disk || !active_disk->bs || !active_disk->bs->backing) {
             error_setg(errp, "Active disk doesn't have backing file");
+            bdrv_graph_rdunlock_main_loop();
             aio_context_release(aio_context);
             return;
         }
@@ -506,11 +511,11 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         hidden_disk = active_disk->bs->backing;
         if (!hidden_disk->bs || !hidden_disk->bs->backing) {
             error_setg(errp, "Hidden disk doesn't have backing file");
+            bdrv_graph_rdunlock_main_loop();
             aio_context_release(aio_context);
             return;
         }
 
-        bdrv_graph_rdlock_main_loop();
         secondary_disk = hidden_disk->bs->backing;
         if (!secondary_disk->bs || !bdrv_has_blk(secondary_disk->bs)) {
             error_setg(errp, "The secondary disk doesn't have block backend");
diff --git a/block/vmdk.c b/block/vmdk.c
index f34abb43e2..d705e53b5e 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -380,7 +380,7 @@ out:
     return ret;
 }
 
-static int coroutine_fn vmdk_is_cid_valid(BlockDriverState *bs)
+static int coroutine_fn GRAPH_RDLOCK vmdk_is_cid_valid(BlockDriverState *bs)
 {
     BDRVVmdkState *s = bs->opaque;
     uint32_t cur_pcid;
@@ -3046,8 +3046,9 @@ vmdk_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
-static void vmdk_gather_child_options(BlockDriverState *bs, QDict *target,
-                                      bool backing_overridden)
+static void GRAPH_RDLOCK
+vmdk_gather_child_options(BlockDriverState *bs, QDict *target,
+                          bool backing_overridden)
 {
     /* No children but file and backing can be explicitly specified (TODO) */
     qdict_put(target, "file",
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index b16f831c23..ba4e42b197 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -218,8 +218,14 @@ static void do_drain_end_unlocked(enum drain_type drain_type, BlockDriverState *
     }
 }
 
-static void test_drv_cb_common(BlockBackend *blk, enum drain_type drain_type,
-                               bool recursive)
+/*
+ * Locking the block graph would be a bit cumbersome here because this function
+ * is called both in coroutine and non-coroutine context. We know this is a test
+ * and nothing else is running, so don't bother with TSA.
+ */
+static void coroutine_mixed_fn TSA_NO_TSA
+test_drv_cb_common(BlockBackend *blk, enum drain_type drain_type,
+                   bool recursive)
 {
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *backing = bs->backing->bs;
@@ -307,8 +313,14 @@ static void test_drv_cb_co_drain(void)
     blk_unref(blk);
 }
 
-static void test_quiesce_common(BlockBackend *blk, enum drain_type drain_type,
-                                bool recursive)
+/*
+ * Locking the block graph would be a bit cumbersome here because this function
+ * is called both in coroutine and non-coroutine context. We know this is a test
+ * and nothing else is running, so don't bother with TSA.
+ */
+static void coroutine_mixed_fn TSA_NO_TSA
+test_quiesce_common(BlockBackend *blk, enum drain_type drain_type,
+                    bool recursive)
 {
     BlockDriverState *bs = blk_bs(blk);
     BlockDriverState *backing = bs->backing->bs;
@@ -1868,6 +1880,8 @@ static void bdrv_replace_test_drain_end(BlockDriverState *bs)
 {
     BDRVReplaceTestState *s = bs->opaque;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!s->setup_completed) {
         return;
     }
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 22d4cd83f6..878544dbd5 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -206,15 +206,18 @@ static void test_should_update_child(void)
 
     bdrv_set_backing_hd(target, bs, &error_abort);
 
-    g_assert(target->backing->bs == bs);
     bdrv_graph_wrlock(NULL);
+    g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
     aio_context_acquire(qemu_get_aio_context());
     bdrv_append(filter, bs, &error_abort);
     aio_context_release(qemu_get_aio_context());
+
+    bdrv_graph_rdlock_main_loop();
     g_assert(target->backing->bs == bs);
+    bdrv_graph_rdunlock_main_loop();
 
     bdrv_unref(filter);
     bdrv_unref(bs);
-- 
2.41.0


