Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4227D9D8B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAF-000465-BZ; Fri, 27 Oct 2023 11:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9w-0003Z5-Bu
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9s-0002hp-Em
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5RWu0K6/PeayYlK5SthlXfUdUcBUAP4H0nfgCbozBo=;
 b=AE73PTbrqiHWxB3d2WgjaoZYm1uPBnpDvCzJ4WS99fwki/o3H3YGH6a2juQIDX5hd+zbSz
 BgRDk3TgxiM5HZq4Nrsh7wfebyZ6m8tT6WUXDW8+96cqPA6yt5LUSdIUMqZ7kogBAEYZDM
 mn7PB5JamaWELQGq5gO2SMbuqfWGPfo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-hm25mfBgMN6s27vGlXTTjw-1; Fri, 27 Oct 2023 11:53:53 -0400
X-MC-Unique: hm25mfBgMN6s27vGlXTTjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ECAF8811E8F;
 Fri, 27 Oct 2023 15:53:52 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3A9B5027;
 Fri, 27 Oct 2023 15:53:51 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 08/24] block: Mark bdrv_skip_filters() and callers GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:17 +0200
Message-ID: <20231027155333.420094-9-kwolf@redhat.com>
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_skip_filters() need to hold a reader lock for the graph because it
calls bdrv_filter_child(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  8 ++++---
 include/block/block_int-io.h       |  4 ++--
 block/block-backend.c              |  1 +
 block/block-copy.c                 |  9 +++++++-
 block/commit.c                     |  5 ++++-
 block/mirror.c                     | 34 +++++++++++++++++++++---------
 block/stream.c                     | 22 ++++++++++++-------
 blockdev.c                         |  7 +++---
 qemu-img.c                         | 18 +++++++++++++---
 9 files changed, 77 insertions(+), 31 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 3ae468ea15..b6860ae43b 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -144,9 +144,11 @@ int bdrv_change_backing_file(BlockDriverState *bs, const char *backing_file,
 void bdrv_register(BlockDriver *bdrv);
 int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
                            const char *backing_file_str);
-BlockDriverState *bdrv_find_overlay(BlockDriverState *active,
-                                    BlockDriverState *bs);
-BlockDriverState *bdrv_find_base(BlockDriverState *bs);
+
+BlockDriverState * GRAPH_RDLOCK
+bdrv_find_overlay(BlockDriverState *active, BlockDriverState *bs);
+
+BlockDriverState * GRAPH_RDLOCK bdrv_find_base(BlockDriverState *bs);
 bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
                                   Error **errp);
 int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 6800af7590..4e7bf57a5e 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -134,8 +134,8 @@ BdrvChild *bdrv_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
 BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
-BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
-BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
+BlockDriverState * GRAPH_RDLOCK bdrv_skip_filters(BlockDriverState *bs);
+BlockDriverState * GRAPH_RDLOCK bdrv_backing_chain_next(BlockDriverState *bs);
 
 static inline BlockDriverState *bdrv_cow_bs(BlockDriverState *bs)
 {
diff --git a/block/block-backend.c b/block/block-backend.c
index 075a0dfa95..4053134781 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2730,6 +2730,7 @@ int blk_commit_all(void)
 {
     BlockBackend *blk = NULL;
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     while ((blk = blk_all_next(blk)) != NULL) {
         AioContext *aio_context = blk_get_aio_context(blk);
diff --git a/block/block-copy.c b/block/block-copy.c
index 1c60368d72..6b2be3d204 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -313,7 +313,12 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
 {
     int ret;
     BlockDriverInfo bdi;
-    bool target_does_cow = bdrv_backing_chain_next(target);
+    bool target_does_cow;
+
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    target_does_cow = bdrv_backing_chain_next(target);
 
     /*
      * If there is no backing file on the target, we cannot rely on COW if our
@@ -355,6 +360,8 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
     BdrvDirtyBitmap *copy_bitmap;
     bool is_fleecing;
 
+    GLOBAL_STATE_CODE();
+
     cluster_size = block_copy_calculate_cluster_size(target->bs, errp);
     if (cluster_size < 0) {
         return NULL;
diff --git a/block/commit.c b/block/commit.c
index fc3ad79749..05eb57d9ea 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -255,10 +255,13 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     assert(top != bs);
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_skip_filters(top) == bdrv_skip_filters(base)) {
         error_setg(errp, "Invalid files for merge: top and base are the same");
+        bdrv_graph_rdunlock_main_loop();
         return;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     base_size = bdrv_getlength(base);
     if (base_size < 0) {
@@ -324,6 +327,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * this is the responsibility of the interface (i.e. whoever calls
      * commit_start()).
      */
+    bdrv_graph_wrlock(top);
     s->base_overlay = bdrv_find_overlay(top, base);
     assert(s->base_overlay);
 
@@ -342,7 +346,6 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      */
     iter_shared_perms = BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE;
 
-    bdrv_graph_wrlock(top);
     for (iter = top; iter != base; iter = bdrv_filter_or_cow_bs(iter)) {
         if (iter == filtered_base) {
             /*
diff --git a/block/mirror.c b/block/mirror.c
index b1d2a5268a..4d11a30508 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -706,7 +706,6 @@ static int mirror_exit_common(Job *job)
     bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
-    bdrv_graph_rdunlock_main_loop();
 
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
@@ -729,6 +728,7 @@ static int mirror_exit_common(Job *job)
             local_err = NULL;
         }
     }
+    bdrv_graph_rdunlock_main_loop();
 
     if (s->to_replace) {
         replace_aio_context = bdrv_get_aio_context(s->to_replace);
@@ -984,13 +984,13 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
     } else {
         s->target_cluster_size = BDRV_SECTOR_SIZE;
     }
-    bdrv_graph_co_rdunlock();
     if (backing_filename[0] && !bdrv_backing_chain_next(target_bs) &&
         s->granularity < s->target_cluster_size) {
         s->buf_size = MAX(s->buf_size, s->target_cluster_size);
         s->cow_bitmap = bitmap_new(length);
     }
     s->max_iov = MIN(bs->bl.max_iov, target_bs->bl.max_iov);
+    bdrv_graph_co_rdunlock();
 
     s->buf = qemu_try_blockalign(bs, s->buf_size);
     if (s->buf == NULL) {
@@ -1691,12 +1691,15 @@ static BlockJob *mirror_start_job(
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_skip_filters(bs) == bdrv_skip_filters(target)) {
         error_setg(errp, "Can't mirror node into itself");
+        bdrv_graph_rdunlock_main_loop();
         return NULL;
     }
 
     target_is_backing = bdrv_chain_contains(bs, target);
+    bdrv_graph_rdunlock_main_loop();
 
     /* In the case of active commit, add dummy driver to provide consistent
      * reads on the top, while disabling it in the intermediate nodes, and make
@@ -1779,14 +1782,19 @@ static BlockJob *mirror_start_job(
         }
 
         target_shared_perms |= BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE;
-    } else if (bdrv_chain_contains(bs, bdrv_skip_filters(target))) {
-        /*
-         * We may want to allow this in the future, but it would
-         * require taking some extra care.
-         */
-        error_setg(errp, "Cannot mirror to a filter on top of a node in the "
-                   "source's backing chain");
-        goto fail;
+    } else {
+        bdrv_graph_rdlock_main_loop();
+        if (bdrv_chain_contains(bs, bdrv_skip_filters(target))) {
+            /*
+             * We may want to allow this in the future, but it would
+             * require taking some extra care.
+             */
+            error_setg(errp, "Cannot mirror to a filter on top of a node in "
+                       "the source's backing chain");
+            bdrv_graph_rdunlock_main_loop();
+            goto fail;
+        }
+        bdrv_graph_rdunlock_main_loop();
     }
 
     s->target = blk_new(s->common.job.aio_context,
@@ -1807,6 +1815,7 @@ static BlockJob *mirror_start_job(
     blk_set_allow_aio_context_change(s->target, true);
     blk_set_disable_request_queuing(s->target, true);
 
+    bdrv_graph_rdlock_main_loop();
     s->replaces = g_strdup(replaces);
     s->on_source_error = on_source_error;
     s->on_target_error = on_target_error;
@@ -1822,6 +1831,7 @@ static BlockJob *mirror_start_job(
     if (auto_complete) {
         s->should_complete = true;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
     if (!s->dirty_bitmap) {
@@ -1950,8 +1960,12 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
                    MirrorSyncMode_str(mode));
         return;
     }
+
+    bdrv_graph_rdlock_main_loop();
     is_none_mode = mode == MIRROR_SYNC_MODE_NONE;
     base = mode == MIRROR_SYNC_MODE_TOP ? bdrv_backing_chain_next(bs) : NULL;
+    bdrv_graph_rdunlock_main_loop();
+
     mirror_start_job(job_id, bs, creation_flags, target, replaces,
                      speed, granularity, buf_size, backing_mode, zero_target,
                      on_source_error, on_target_error, unmap, NULL, NULL,
diff --git a/block/stream.c b/block/stream.c
index 2781441191..5323a9976d 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -53,8 +53,8 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
 static int stream_prepare(Job *job)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
-    BlockDriverState *unfiltered_bs_cow = bdrv_cow_bs(unfiltered_bs);
+    BlockDriverState *unfiltered_bs;
+    BlockDriverState *unfiltered_bs_cow;
     BlockDriverState *base;
     BlockDriverState *unfiltered_base;
     Error *local_err = NULL;
@@ -62,6 +62,11 @@ static int stream_prepare(Job *job)
 
     GLOBAL_STATE_CODE();
 
+    bdrv_graph_rdlock_main_loop();
+    unfiltered_bs = bdrv_skip_filters(s->target_bs);
+    unfiltered_bs_cow = bdrv_cow_bs(unfiltered_bs);
+    bdrv_graph_rdunlock_main_loop();
+
     /* We should drop filter at this point, as filter hold the backing chain */
     bdrv_cor_filter_drop(s->cor_filter_bs);
     s->cor_filter_bs = NULL;
@@ -142,18 +147,19 @@ static void stream_clean(Job *job)
 static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockDriverState *unfiltered_bs = bdrv_skip_filters(s->target_bs);
+    BlockDriverState *unfiltered_bs;
     int64_t len;
     int64_t offset = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
 
-    if (unfiltered_bs == s->base_overlay) {
-        /* Nothing to stream */
-        return 0;
-    }
-
     WITH_GRAPH_RDLOCK_GUARD() {
+        unfiltered_bs = bdrv_skip_filters(s->target_bs);
+        if (unfiltered_bs == s->base_overlay) {
+            /* Nothing to stream */
+            return 0;
+        }
+
         len = bdrv_co_getlength(s->target_bs);
         if (len < 0) {
             return len;
diff --git a/blockdev.c b/blockdev.c
index 52236f2639..0d9c821e66 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1701,7 +1701,6 @@ static void drive_backup_action(DriveBackup *backup,
         bdrv_graph_rdunlock_main_loop();
         goto out;
     }
-    bdrv_graph_rdunlock_main_loop();
 
     flags = bs->open_flags | BDRV_O_RDWR;
 
@@ -1726,6 +1725,7 @@ static void drive_backup_action(DriveBackup *backup,
         flags |= BDRV_O_NO_BACKING;
         set_backing_hd = true;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     size = bdrv_getlength(bs);
     if (size < 0) {
@@ -3045,7 +3045,6 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         bdrv_graph_rdunlock_main_loop();
         return;
     }
-    bdrv_graph_rdunlock_main_loop();
 
     aio_context = bdrv_get_aio_context(bs);
     aio_context_acquire(aio_context);
@@ -3067,6 +3066,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     if (arg->sync == MIRROR_SYNC_MODE_NONE) {
         target_backing_bs = bs;
     }
+    bdrv_graph_rdunlock_main_loop();
 
     size = bdrv_getlength(bs);
     if (size < 0) {
@@ -3427,15 +3427,16 @@ void qmp_change_backing_file(const char *device,
         goto out;
     }
 
+    bdrv_graph_rdlock_main_loop();
     if (bdrv_find_base(image_bs) == image_bs) {
         error_setg(errp, "not allowing backing file change on an image "
                          "without a backing file");
+        bdrv_graph_rdunlock_main_loop();
         goto out;
     }
 
     /* even though we are not necessarily operating on bs, we need it to
      * determine if block ops are currently prohibited on the chain */
-    bdrv_graph_rdlock_main_loop();
     if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_CHANGE, errp)) {
         bdrv_graph_rdunlock_main_loop();
         goto out;
diff --git a/qemu-img.c b/qemu-img.c
index c061fd0634..33f3ab5fba 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1050,12 +1050,14 @@ static int img_commit(int argc, char **argv)
     qemu_progress_init(progress, 1.f);
     qemu_progress_print(0.f, 100);
 
+    bdrv_graph_rdlock_main_loop();
     if (base) {
         base_bs = bdrv_find_backing_image(bs, base);
         if (!base_bs) {
             error_setg(&local_err,
                        "Did not find '%s' in the backing chain of '%s'",
                        base, filename);
+            bdrv_graph_rdunlock_main_loop();
             goto done;
         }
     } else {
@@ -1065,9 +1067,11 @@ static int img_commit(int argc, char **argv)
         base_bs = bdrv_backing_chain_next(bs);
         if (!base_bs) {
             error_setg(&local_err, "Image does not have a backing file");
+            bdrv_graph_rdunlock_main_loop();
             goto done;
         }
     }
+    bdrv_graph_rdunlock_main_loop();
 
     cbi = (CommonBlockJobCBInfo){
         .errp = &local_err,
@@ -1713,7 +1717,8 @@ static void convert_select_part(ImgConvertState *s, int64_t sector_num,
     }
 }
 
-static int convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
+static int coroutine_mixed_fn GRAPH_RDLOCK
+convert_iteration_sectors(ImgConvertState *s, int64_t sector_num)
 {
     int64_t src_cur_offset;
     int ret, n, src_cur;
@@ -2115,7 +2120,9 @@ static int convert_do_copy(ImgConvertState *s)
     }
 
     while (sector_num < s->total_sectors) {
+        bdrv_graph_rdlock_main_loop();
         n = convert_iteration_sectors(s, sector_num);
+        bdrv_graph_rdunlock_main_loop();
         if (n < 0) {
             return n;
         }
@@ -2757,8 +2764,10 @@ static int img_convert(int argc, char **argv)
          * s.target_backing_sectors has to be negative, which it will
          * be automatically).  The backing file length is used only
          * for optimizations, so such a case is not fatal. */
+        bdrv_graph_rdlock_main_loop();
         s.target_backing_sectors =
             bdrv_nb_sectors(bdrv_backing_chain_next(out_bs));
+        bdrv_graph_rdunlock_main_loop();
     } else {
         s.target_backing_sectors = -1;
     }
@@ -3145,6 +3154,9 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
     int64_t map;
     char *filename = NULL;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* As an optimization, we could cache the current range of unallocated
      * clusters in each file of the chain, and avoid querying the same
      * range repeatedly.
@@ -3173,9 +3185,7 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
     has_offset = !!(ret & BDRV_BLOCK_OFFSET_VALID);
 
     if (file && has_offset) {
-        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(file);
-        bdrv_graph_rdunlock_main_loop();
         filename = file->filename;
     }
 
@@ -3663,7 +3673,9 @@ static int img_rebase(int argc, char **argv)
     }
     bs = blk_bs(blk);
 
+    bdrv_graph_rdlock_main_loop();
     unfiltered_bs = bdrv_skip_filters(bs);
+    bdrv_graph_rdunlock_main_loop();
 
     if (compress && !block_driver_can_compress(unfiltered_bs->drv)) {
         error_report("Compression not supported for this file format");
-- 
2.41.0


