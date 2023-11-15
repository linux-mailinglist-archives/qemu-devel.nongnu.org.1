Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF207EC993
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JZ6-0007kZ-U8; Wed, 15 Nov 2023 12:20:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JZ4-0007ib-9s
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JZ1-0003FG-58
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700068830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLAPbp2G39k4CyJsIsXs9tC0wVk3DQHBqGZd9elwdWY=;
 b=d8Nzyl5vHtJAF1QeVs83rN0gxzVQbQUP7x/Cvh6JiTZcX5dkw0vrtWSnqC2bO84/AB7NDJ
 tSvHj7gukcJijjRROcPPQzaGFmzrfo7wws0Hfc2Ix4AImqUPfZQIQulDU6NZFiHsyRrxOe
 +m+SRLt+dlt7df250c2jwrGgk9+TYNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-68R1cCIAPLmJcOU1wiAqAA-1; Wed,
 15 Nov 2023 12:20:28 -0500
X-MC-Unique: 68R1cCIAPLmJcOU1wiAqAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25EB51DD35E3;
 Wed, 15 Nov 2023 17:20:21 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C66C3709;
 Wed, 15 Nov 2023 17:20:20 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH for-8.2 2/4] block: Fix deadlocks in bdrv_graph_wrunlock()
Date: Wed, 15 Nov 2023 18:20:10 +0100
Message-ID: <20231115172012.112727-3-kwolf@redhat.com>
In-Reply-To: <20231115172012.112727-1-kwolf@redhat.com>
References: <20231115172012.112727-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

bdrv_graph_wrunlock() calls aio_poll(), which may run callbacks that
have a nested event loop. Nested event loops can depend on other
iothreads making progress, so in order to allow them to make progress it
must not hold the AioContext lock of another thread while calling
aio_poll().

This introduces a @bs parameter to bdrv_graph_wrunlock() whose
AioContext is temporarily dropped (which matches bdrv_graph_wrlock()),
and a bdrv_graph_wrunlock_ctx() that can be used if the BlockDriverState
doesn't necessarily exist any more when unlocking.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/graph-lock.h         | 15 ++++++++++++++-
 block.c                            | 26 +++++++++++++-------------
 block/backup.c                     |  2 +-
 block/blklogwrites.c               |  4 ++--
 block/blkverify.c                  |  2 +-
 block/block-backend.c              |  6 ++++--
 block/commit.c                     | 10 +++++-----
 block/graph-lock.c                 | 23 ++++++++++++++++++++++-
 block/mirror.c                     | 14 +++++++-------
 block/qcow2.c                      |  2 +-
 block/quorum.c                     |  4 ++--
 block/replication.c                | 10 +++++-----
 block/snapshot.c                   |  2 +-
 block/stream.c                     |  8 ++++----
 block/vmdk.c                       | 10 +++++-----
 blockdev.c                         |  4 ++--
 blockjob.c                         |  8 ++++----
 tests/unit/test-bdrv-drain.c       | 20 ++++++++++----------
 tests/unit/test-bdrv-graph-mod.c   | 10 +++++-----
 scripts/block-coroutine-wrapper.py |  2 +-
 20 files changed, 109 insertions(+), 73 deletions(-)

diff --git a/include/block/graph-lock.h b/include/block/graph-lock.h
index 6f1cd12745..22b5db1ed9 100644
--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -123,8 +123,21 @@ bdrv_graph_wrlock(BlockDriverState *bs);
  * bdrv_graph_wrunlock:
  * Write finished, reset global has_writer to 0 and restart
  * all readers that are waiting.
+ *
+ * If @bs is non-NULL, its AioContext is temporarily released.
+ */
+void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
+bdrv_graph_wrunlock(BlockDriverState *bs);
+
+/*
+ * bdrv_graph_wrunlock_ctx:
+ * Write finished, reset global has_writer to 0 and restart
+ * all readers that are waiting.
+ *
+ * If @ctx is non-NULL, its lock is temporarily released.
  */
-void bdrv_graph_wrunlock(void) TSA_RELEASE(graph_lock) TSA_NO_TSA;
+void no_coroutine_fn TSA_RELEASE(graph_lock) TSA_NO_TSA
+bdrv_graph_wrunlock_ctx(AioContext *ctx);
 
 /*
  * bdrv_graph_co_rdlock:
diff --git a/block.c b/block.c
index eac105a504..efb91d4ffb 100644
--- a/block.c
+++ b/block.c
@@ -1713,7 +1713,7 @@ open_failed:
         bdrv_unref_child(bs, bs->file);
         assert(!bs->file);
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -3577,7 +3577,7 @@ int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
     bdrv_drained_begin(drain_bs);
     bdrv_graph_wrlock(backing_hd);
     ret = bdrv_set_backing_hd_drained(bs, backing_hd, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(backing_hd);
     bdrv_drained_end(drain_bs);
     bdrv_unref(drain_bs);
 
@@ -3796,7 +3796,7 @@ BdrvChild *bdrv_open_child(const char *filename,
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     aio_context_release(ctx);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     return child;
 }
@@ -4652,7 +4652,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 
     bdrv_graph_wrlock(NULL);
     tran_commit(tran);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         BlockDriverState *bs = bs_entry->state.bs;
@@ -4671,7 +4671,7 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
 abort:
     bdrv_graph_wrlock(NULL);
     tran_abort(tran);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     QTAILQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (bs_entry->prepared) {
@@ -4857,7 +4857,7 @@ bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     ret = bdrv_set_file_or_backing_noperm(bs, new_child_bs, is_backing,
                                           tran, errp);
 
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(new_child_bs);
 
     if (old_ctx != ctx) {
         aio_context_release(ctx);
@@ -5216,7 +5216,7 @@ static void bdrv_close(BlockDriverState *bs)
 
     assert(!bs->backing);
     assert(!bs->file);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
 
     g_free(bs->opaque);
     bs->opaque = NULL;
@@ -5511,7 +5511,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
     bdrv_drained_begin(child_bs);
     bdrv_graph_wrlock(bs);
     ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
     bdrv_drained_end(child_bs);
 
     return ret;
@@ -5593,7 +5593,7 @@ out:
     tran_finalize(tran, ret);
 
     bdrv_refresh_limits(bs_top, NULL, NULL);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs_top);
 
     bdrv_drained_end(bs_top);
     bdrv_drained_end(bs_new);
@@ -5631,7 +5631,7 @@ int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
 
     tran_finalize(tran, ret);
 
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(new_bs);
     bdrv_drained_end(old_bs);
     bdrv_drained_end(new_bs);
     bdrv_unref(old_bs);
@@ -5720,7 +5720,7 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
     bdrv_drained_begin(new_node_bs);
     bdrv_graph_wrlock(new_node_bs);
     ret = bdrv_replace_node(bs, new_node_bs, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(new_node_bs);
     bdrv_drained_end(new_node_bs);
     bdrv_drained_end(bs);
     bdrv_unref(bs);
@@ -6015,7 +6015,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
      * That's a FIXME.
      */
     bdrv_replace_node_common(top, base, false, false, &local_err);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(base);
 
     if (local_err) {
         error_report_err(local_err);
@@ -6052,7 +6052,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
     goto exit;
 
 exit_wrlock:
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(base);
 exit:
     bdrv_drained_end(base);
     bdrv_unref(top);
diff --git a/block/backup.c b/block/backup.c
index 5bad7d116f..8aae5836d7 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -499,7 +499,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     bdrv_graph_wrlock(target);
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(target);
 
     return &job->common;
 
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index a0d70729bb..3678f6cf42 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -253,7 +253,7 @@ fail_log:
     if (ret < 0) {
         bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->log_file);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(NULL);
         s->log_file = NULL;
     }
 fail:
@@ -268,7 +268,7 @@ static void blk_log_writes_close(BlockDriverState *bs)
     bdrv_graph_wrlock(NULL);
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/blkverify.c b/block/blkverify.c
index a96905db35..9b17c46644 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -154,7 +154,7 @@ static void blkverify_close(BlockDriverState *bs)
     bdrv_graph_wrlock(NULL);
     bdrv_unref_child(bs, s->test_file);
     s->test_file = NULL;
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/block-backend.c b/block/block-backend.c
index f6f05ead28..e100915838 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -889,6 +889,7 @@ void blk_remove_bs(BlockBackend *blk)
 {
     ThrottleGroupMember *tgm = &blk->public.throttle_group_member;
     BdrvChild *root;
+    AioContext *ctx;
 
     GLOBAL_STATE_CODE();
 
@@ -918,9 +919,10 @@ void blk_remove_bs(BlockBackend *blk)
     root = blk->root;
     blk->root = NULL;
 
+    ctx = bdrv_get_aio_context(root->bs);
     bdrv_graph_wrlock(root->bs);
     bdrv_root_unref_child(root);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock_ctx(ctx);
 }
 
 /*
@@ -938,7 +940,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        blk->perm, blk->shared_perm,
                                        blk, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/commit.c b/block/commit.c
index eb3dc01f45..69cc75be0c 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -102,7 +102,7 @@ static void commit_abort(Job *job)
     bdrv_drained_begin(commit_top_backing_bs);
     bdrv_graph_wrlock(commit_top_backing_bs);
     bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(commit_top_backing_bs);
     bdrv_drained_end(commit_top_backing_bs);
 
     bdrv_unref(s->commit_top_bs);
@@ -370,19 +370,19 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  iter_shared_perms, errp);
         if (ret < 0) {
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(top);
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(top);
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(top);
 
     if (ret < 0) {
         goto fail;
@@ -436,7 +436,7 @@ fail:
         bdrv_drained_begin(top);
         bdrv_graph_wrlock(top);
         bdrv_replace_node(commit_top_bs, top, &error_abort);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(top);
         bdrv_drained_end(top);
     }
 }
diff --git a/block/graph-lock.c b/block/graph-lock.c
index e5525ee2db..079e878d9b 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -161,11 +161,21 @@ void no_coroutine_fn bdrv_graph_wrlock(BlockDriverState *bs)
     }
 }
 
-void bdrv_graph_wrunlock(void)
+void no_coroutine_fn bdrv_graph_wrunlock_ctx(AioContext *ctx)
 {
     GLOBAL_STATE_CODE();
     assert(qatomic_read(&has_writer));
 
+    /*
+     * Release only non-mainloop AioContext. The mainloop often relies on the
+     * BQL and doesn't lock the main AioContext before doing things.
+     */
+    if (ctx && ctx != qemu_get_aio_context()) {
+        aio_context_release(ctx);
+    } else {
+        ctx = NULL;
+    }
+
     WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
         /*
          * No need for memory barriers, this works in pair with
@@ -187,6 +197,17 @@ void bdrv_graph_wrunlock(void)
      * progress.
      */
     aio_bh_poll(qemu_get_aio_context());
+
+    if (ctx) {
+        aio_context_acquire(ctx);
+    }
+}
+
+void no_coroutine_fn bdrv_graph_wrunlock(BlockDriverState *bs)
+{
+    AioContext *ctx = bs ? bdrv_get_aio_context(bs) : NULL;
+
+    bdrv_graph_wrunlock_ctx(ctx);
 }
 
 void coroutine_fn bdrv_graph_co_rdlock(void)
diff --git a/block/mirror.c b/block/mirror.c
index 2096fade90..cd9d3ad4a8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -773,7 +773,7 @@ static int mirror_exit_common(Job *job)
                        "would not lead to an abrupt change of visible data",
                        to_replace->node_name, target_bs->node_name);
         }
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(target_bs);
         bdrv_drained_end(to_replace);
         if (local_err) {
             error_report_err(local_err);
@@ -798,7 +798,7 @@ static int mirror_exit_common(Job *job)
     block_job_remove_all_bdrv(bjob);
     bdrv_graph_wrlock(mirror_top_bs);
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(mirror_top_bs);
 
     bdrv_drained_end(target_bs);
     bdrv_unref(target_bs);
@@ -1920,7 +1920,7 @@ static BlockJob *mirror_start_job(
                              BLK_PERM_CONSISTENT_READ,
                              errp);
     if (ret < 0) {
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(bs);
         goto fail;
     }
 
@@ -1965,17 +1965,17 @@ static BlockJob *mirror_start_job(
             ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                      iter_shared_perms, errp);
             if (ret < 0) {
-                bdrv_graph_wrunlock();
+                bdrv_graph_wrunlock(bs);
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(bs);
             goto fail;
         }
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
 
     QTAILQ_INIT(&s->ops_in_flight);
 
@@ -2006,7 +2006,7 @@ fail:
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
     bdrv_replace_node(mirror_top_bs, bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
     bdrv_drained_end(bs);
 
     bdrv_unref(mirror_top_bs);
diff --git a/block/qcow2.c b/block/qcow2.c
index cf2468858f..13e032bd5e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2809,7 +2809,7 @@ qcow2_do_close(BlockDriverState *bs, bool close_data_file)
         bdrv_graph_rdunlock_main_loop();
         bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->data_file);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(NULL);
         s->data_file = NULL;
         bdrv_graph_rdlock_main_loop();
     }
diff --git a/block/quorum.c b/block/quorum.c
index d3ffc2ee33..505b8b3e18 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1044,7 +1044,7 @@ close_exit:
         }
         bdrv_unref_child(bs, s->children[i]);
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
     g_free(s->children);
     g_free(opened);
 exit:
@@ -1061,7 +1061,7 @@ static void quorum_close(BlockDriverState *bs)
     for (i = 0; i < s->num_children; i++) {
         bdrv_unref_child(bs, s->children[i]);
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     g_free(s->children);
 }
diff --git a/block/replication.c b/block/replication.c
index 43e259444b..5ded5f1ca9 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -568,7 +568,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                            &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(bs);
             aio_context_release(aio_context);
             return;
         }
@@ -579,7 +579,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                               BDRV_CHILD_DATA, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(bs);
             aio_context_release(aio_context);
             return;
         }
@@ -592,7 +592,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (!top_bs || !bdrv_is_root_node(top_bs) ||
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(bs);
             reopen_backing_file(bs, false, NULL);
             aio_context_release(aio_context);
             return;
@@ -600,7 +600,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(bs);
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
@@ -696,7 +696,7 @@ static void replication_done(void *opaque, int ret)
         s->secondary_disk = NULL;
         bdrv_unref_child(bs, s->hidden_disk);
         s->hidden_disk = NULL;
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(NULL);
 
         s->error = 0;
     } else {
diff --git a/block/snapshot.c b/block/snapshot.c
index 55974273ae..ec8cf4810b 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -292,7 +292,7 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         /* .bdrv_open() will re-attach it */
         bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, fallback);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(NULL);
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
diff --git a/block/stream.c b/block/stream.c
index 0b92410c00..e3aa696289 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -101,7 +101,7 @@ static int stream_prepare(Job *job)
 
         bdrv_graph_wrlock(base);
         bdrv_set_backing_hd_drained(unfiltered_bs, base, &local_err);
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(base);
 
         /*
          * This call will do I/O, so the graph can change again from here on.
@@ -369,7 +369,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     bdrv_graph_wrlock(bs);
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(bs);
         goto fail;
     }
 
@@ -389,11 +389,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
                                  basic_flags, errp);
         if (ret < 0) {
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(bs);
             goto fail;
         }
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/block/vmdk.c b/block/vmdk.c
index dda783f06b..d87f6d9aaa 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -283,7 +283,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
             bdrv_unref_child(bs, e->file);
         }
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     g_free(s->extents);
 }
@@ -1237,7 +1237,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                 bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
+                bdrv_graph_wrunlock(NULL);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1256,7 +1256,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                 bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
+                bdrv_graph_wrunlock(NULL);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1267,7 +1267,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
                 bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
-                bdrv_graph_wrunlock();
+                bdrv_graph_wrunlock(NULL);
                 bdrv_graph_rdlock_main_loop();
                 goto out;
             }
@@ -1277,7 +1277,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
             bdrv_graph_rdunlock_main_loop();
             bdrv_graph_wrlock(NULL);
             bdrv_unref_child(bs, extent_file);
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(NULL);
             bdrv_graph_rdlock_main_loop();
             ret = -ENOTSUP;
             goto out;
diff --git a/blockdev.c b/blockdev.c
index 5bc921236c..4c1177e8db 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1613,7 +1613,7 @@ static void external_snapshot_abort(void *opaque)
             bdrv_drained_begin(state->new_bs);
             bdrv_graph_wrlock(state->old_bs);
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
-            bdrv_graph_wrunlock();
+            bdrv_graph_wrunlock(state->old_bs);
             bdrv_drained_end(state->new_bs);
 
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
@@ -3692,7 +3692,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     }
 
 out:
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
diff --git a/blockjob.c b/blockjob.c
index af44322cbe..b7a29052b9 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -212,7 +212,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
 
         g_slist_free_1(l);
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock_ctx(job->job.aio_context);
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
@@ -523,7 +523,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job = job_create(job_id, &driver->job_driver, txn, bdrv_get_aio_context(bs),
                      flags, cb, opaque, errp);
     if (job == NULL) {
-        bdrv_graph_wrunlock();
+        bdrv_graph_wrunlock(bs);
         return NULL;
     }
 
@@ -563,11 +563,11 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
         goto fail;
     }
 
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
     return job;
 
 fail:
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(bs);
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 8d05538bf6..704d1a3f36 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -809,7 +809,7 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
 
     bdrv_graph_wrlock(target);
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(target);
 
     switch (result) {
     case TEST_JOB_SUCCESS:
@@ -995,7 +995,7 @@ static void bdrv_test_top_close(BlockDriverState *bs)
     QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
         bdrv_unref_child(bs, c);
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1088,7 +1088,7 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
     bdrv_graph_wrlock(NULL);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1101,7 +1101,7 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
@@ -1110,7 +1110,7 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
     bdrv_graph_wrlock(NULL);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1200,7 +1200,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 }
 
 static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1308,7 +1308,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     bdrv_attach_child(parent_a, a, "PA-A",
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1735,7 +1735,7 @@ static void test_drop_intermediate_poll(void)
                               &chain_child_class, BDRV_CHILD_COW, &error_abort);
         }
     }
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1985,7 +1985,7 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     bdrv_graph_wrlock(NULL);
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
@@ -2018,7 +2018,7 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     bdrv_drained_begin(new_child_bs);
     bdrv_graph_wrlock(NULL);
     bdrv_replace_node(old_child_bs, new_child_bs, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
     bdrv_drained_end(new_child_bs);
     bdrv_drained_end(old_child_bs);
     g_assert(parent_bs->quiesce_counter == new_drain_count);
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 878544dbd5..074adcbb93 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -140,7 +140,7 @@ static void test_update_perm_tree(void)
     bdrv_graph_wrlock(NULL);
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     aio_context_acquire(qemu_get_aio_context());
     ret = bdrv_append(filter, bs, NULL);
@@ -210,7 +210,7 @@ static void test_should_update_child(void)
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
     aio_context_acquire(qemu_get_aio_context());
     bdrv_append(filter, bs, &error_abort);
     aio_context_release(qemu_get_aio_context());
@@ -260,7 +260,7 @@ static void test_parallel_exclusive_write(void)
                       &error_abort);
 
     bdrv_replace_node(fl1, fl2, &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     bdrv_drained_end(fl2);
     bdrv_drained_end(fl1);
@@ -380,7 +380,7 @@ static void test_parallel_perm_update(void)
     bdrv_attach_child(fl2, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -438,7 +438,7 @@ static void test_append_greedy_filter(void)
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
-    bdrv_graph_wrunlock();
+    bdrv_graph_wrunlock(NULL);
 
     aio_context_acquire(qemu_get_aio_context());
     bdrv_append(fl, base, &error_abort);
diff --git a/scripts/block-coroutine-wrapper.py b/scripts/block-coroutine-wrapper.py
index a601c3c672..a38e5833fb 100644
--- a/scripts/block-coroutine-wrapper.py
+++ b/scripts/block-coroutine-wrapper.py
@@ -262,7 +262,7 @@ def gen_no_co_wrapper(func: FuncDecl) -> str:
         graph_unlock='    bdrv_graph_rdunlock_main_loop();'
     elif func.graph_wrlock:
         graph_lock='    bdrv_graph_wrlock(NULL);'
-        graph_unlock='    bdrv_graph_wrunlock();'
+        graph_unlock='    bdrv_graph_wrunlock(NULL);'
 
     return f"""\
 /*
-- 
2.41.0


