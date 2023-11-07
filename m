Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F41D7E48A3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:48:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6F-0004Vf-Bm; Tue, 07 Nov 2023 13:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5h-0003vP-Mw
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5f-0001UN-AC
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2rmk37/1+MaLUl82vdTAMrHS8+OOW11NeH/kDFXrXvY=;
 b=g6Z+72aw9InzFCPYJE4Ru6q6GQmJNxP1nsJ/LY+BSQsC24juw8a8L+eptkQ2VJl5Ty5C1Q
 0geoFHOmdJYcrDjFsL+GuKSUifn0Gz0pxqSBwEGQlDLJkanEFNsnbUr0UJHusK1cH/EiLL
 rzfWEF6E1DaINygPdshbAg+/uShP6Kk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-cb2aN3iJOneWMHoUzXuteg-1; Tue, 07 Nov 2023 13:46:15 -0500
X-MC-Unique: cb2aN3iJOneWMHoUzXuteg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0018834FC2
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:14 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A9FBC1290F;
 Tue,  7 Nov 2023 18:46:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 09/25] block: Mark bdrv_(un)freeze_backing_chain() and callers
 GRAPH_RDLOCK
Date: Tue,  7 Nov 2023 19:45:49 +0100
Message-ID: <20231107184605.236540-10-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_(un)freeze_backing_chain() need to hold a reader lock for the
graph because it calls bdrv_filter_or_cow_child(), which accesses
bs->file/backing.

Use the opportunity to make bdrv_is_backing_chain_frozen() static, it
has no external callers.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-10-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/copy-on-read.h               |  3 ++-
 include/block/block-global-state.h | 11 ++++++-----
 block.c                            |  5 +++--
 block/commit.c                     |  6 ++++++
 block/copy-on-read.c               | 19 +++++++++++++++----
 block/mirror.c                     |  3 +++
 block/stream.c                     | 16 +++++++++++-----
 7 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/block/copy-on-read.h b/block/copy-on-read.h
index 1d8ad38c74..72f9b378ea 100644
--- a/block/copy-on-read.h
+++ b/block/copy-on-read.h
@@ -27,6 +27,7 @@
 
 #include "block/block_int.h"
 
-void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
+void no_coroutine_fn GRAPH_UNLOCKED
+bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs);
 
 #endif /* BLOCK_COPY_ON_READ_H */
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index b6860ae43b..545708c35a 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -149,11 +149,12 @@ BlockDriverState * GRAPH_RDLOCK
 bdrv_find_overlay(BlockDriverState *active, BlockDriverState *bs);
 
 BlockDriverState * GRAPH_RDLOCK bdrv_find_base(BlockDriverState *bs);
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
-                                  Error **errp);
-int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
-                              Error **errp);
-void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
+
+int GRAPH_RDLOCK
+bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState *base,
+                          Error **errp);
+void GRAPH_RDLOCK
+bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverState *base);
 
 /*
  * The units of offset and total_work_size may be chosen arbitrarily by the
diff --git a/block.c b/block.c
index 7e8b39711b..dc1980ee42 100644
--- a/block.c
+++ b/block.c
@@ -5843,8 +5843,9 @@ BlockDriverState *bdrv_find_base(BlockDriverState *bs)
  * between @bs and @base is frozen. @errp is set if that's the case.
  * @base must be reachable from @bs, or NULL.
  */
-bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
-                                  Error **errp)
+static bool GRAPH_RDLOCK
+bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverState *base,
+                             Error **errp)
 {
     BlockDriverState *i;
     BdrvChild *child;
diff --git a/block/commit.c b/block/commit.c
index 05eb57d9ea..d92af02ead 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -48,8 +48,10 @@ static int commit_prepare(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
 
+    bdrv_graph_rdlock_main_loop();
     bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
     s->chain_frozen = false;
+    bdrv_graph_rdunlock_main_loop();
 
     /* Remove base node parent that still uses BLK_PERM_WRITE/RESIZE before
      * the normal backing chain can be restored. */
@@ -68,7 +70,9 @@ static void commit_abort(Job *job)
     BlockDriverState *top_bs = blk_bs(s->top);
 
     if (s->chain_frozen) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_unfreeze_backing_chain(s->commit_top_bs, s->base_bs);
+        bdrv_graph_rdunlock_main_loop();
     }
 
     /* Make sure commit_top_bs and top stay around until bdrv_replace_node() */
@@ -404,7 +408,9 @@ void commit_start(const char *job_id, BlockDriverState *bs,
 
 fail:
     if (s->chain_frozen) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_unfreeze_backing_chain(commit_top_bs, base);
+        bdrv_graph_rdunlock_main_loop();
     }
     if (s->base) {
         blk_unref(s->base);
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index 5149fcf63a..6f245b629a 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -35,8 +35,8 @@ typedef struct BDRVStateCOR {
 } BDRVStateCOR;
 
 
-static int cor_open(BlockDriverState *bs, QDict *options, int flags,
-                    Error **errp)
+static int GRAPH_UNLOCKED
+cor_open(BlockDriverState *bs, QDict *options, int flags, Error **errp)
 {
     BlockDriverState *bottom_bs = NULL;
     BDRVStateCOR *state = bs->opaque;
@@ -44,6 +44,8 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
     const char *bottom_node = qdict_get_try_str(options, "bottom");
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
@@ -59,6 +61,8 @@ static int cor_open(BlockDriverState *bs, QDict *options, int flags,
             bs->file->bs->supported_zero_flags);
 
     if (bottom_node) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
         bottom_bs = bdrv_find_node(bottom_node);
         if (!bottom_bs) {
             error_setg(errp, "Bottom node '%s' not found", bottom_node);
@@ -227,13 +231,17 @@ cor_co_lock_medium(BlockDriverState *bs, bool locked)
 }
 
 
-static void cor_close(BlockDriverState *bs)
+static void GRAPH_UNLOCKED cor_close(BlockDriverState *bs)
 {
     BDRVStateCOR *s = bs->opaque;
 
+    GLOBAL_STATE_CODE();
+
     if (s->chain_frozen) {
+        bdrv_graph_rdlock_main_loop();
         s->chain_frozen = false;
         bdrv_unfreeze_backing_chain(bs, s->bottom_bs);
+        bdrv_graph_rdunlock_main_loop();
     }
 
     bdrv_unref(s->bottom_bs);
@@ -263,12 +271,15 @@ static BlockDriver bdrv_copy_on_read = {
 };
 
 
-void bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
+void no_coroutine_fn bdrv_cor_filter_drop(BlockDriverState *cor_filter_bs)
 {
     BDRVStateCOR *s = cor_filter_bs->opaque;
 
+    GLOBAL_STATE_CODE();
+
     /* unfreeze, as otherwise bdrv_replace_node() will fail */
     if (s->chain_frozen) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
         s->chain_frozen = false;
         bdrv_unfreeze_backing_chain(cor_filter_bs, s->bottom_bs);
     }
diff --git a/block/mirror.c b/block/mirror.c
index 75e826dac8..f8e439371c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -678,6 +678,7 @@ static int mirror_exit_common(Job *job)
     s->prepared = true;
 
     aio_context_acquire(qemu_get_aio_context());
+    bdrv_graph_rdlock_main_loop();
 
     mirror_top_bs = s->mirror_top_bs;
     bs_opaque = mirror_top_bs->opaque;
@@ -696,6 +697,8 @@ static int mirror_exit_common(Job *job)
     bdrv_ref(mirror_top_bs);
     bdrv_ref(target_bs);
 
+    bdrv_graph_rdunlock_main_loop();
+
     /*
      * Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
      * inserting target_bs at s->to_replace, where we might not be able to get
diff --git a/block/stream.c b/block/stream.c
index 5323a9976d..c32c98339a 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -266,6 +266,8 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     assert(!(base && bottom));
     assert(!(backing_file_str && bottom));
 
+    bdrv_graph_rdlock_main_loop();
+
     if (bottom) {
         /*
          * New simple interface. The code is written in terms of old interface
@@ -278,13 +280,11 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         assert(!bottom->drv->is_filter);
         base_overlay = above_base = bottom;
     } else {
-        GRAPH_RDLOCK_GUARD_MAINLOOP();
-
         base_overlay = bdrv_find_overlay(bs, base);
         if (!base_overlay) {
             error_setg(errp, "'%s' is not in the backing chain of '%s'",
                        base->node_name, bs->node_name);
-            return;
+            goto out_rdlock;
         }
 
         /*
@@ -306,7 +306,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     if (bs_read_only) {
         /* Hold the chain during reopen */
         if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
-            return;
+            goto out_rdlock;
         }
 
         ret = bdrv_reopen_set_read_only(bs, false, errp);
@@ -315,10 +315,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
         bdrv_unfreeze_backing_chain(bs, above_base);
 
         if (ret < 0) {
-            return;
+            goto out_rdlock;
         }
     }
 
+    bdrv_graph_rdunlock_main_loop();
+
     opts = qdict_new();
 
     qdict_put_str(opts, "driver", "copy-on-read");
@@ -413,4 +415,8 @@ fail:
     if (bs_read_only) {
         bdrv_reopen_set_read_only(bs, true, NULL);
     }
+    return;
+
+out_rdlock:
+    bdrv_graph_rdunlock_main_loop();
 }
-- 
2.41.0


