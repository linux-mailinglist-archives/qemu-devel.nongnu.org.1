Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE47D9DAE
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAH-0004MB-U9; Fri, 27 Oct 2023 11:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA6-0003h0-AN
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA0-0002qr-52
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZAN4gAdxb/LpVyf5ObGr9UHcFPnJ5JVsjcJuT77Ano=;
 b=JlKZNljtFsMf5FxmQTjn4Fj3K2ZB2h+kfmOBlM2dZxuRmk6AdLJqQ4XNCI5OaVXxCGkNec
 nTakxhP/bSWtFC5Uj0RlLrOZ/oiOQ5bAOz6uT7e7TstHUcZLelWN8uhfHLKIcQ55a2+2ph
 ZrFRNZ5b5PHyVijC0JwzRDw8CXGbOxU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-4WIHlzpANA-PXKDET4x0dQ-1; Fri,
 27 Oct 2023 11:54:04 -0400
X-MC-Unique: 4WIHlzpANA-PXKDET4x0dQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4CB463C23643;
 Fri, 27 Oct 2023 15:54:04 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CBBF5027;
 Fri, 27 Oct 2023 15:54:03 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 16/24] block: Mark bdrv_replace_node() GRAPH_WRLOCK
Date: Fri, 27 Oct 2023 17:53:25 +0200
Message-ID: <20231027155333.420094-17-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_replace_node(). Its callers may already want
to hold the graph lock and so wouldn't be able to call functions that
take it internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  6 ++++--
 block.c                            | 26 +++++++-------------------
 block/commit.c                     | 13 +++++++++++--
 block/mirror.c                     | 26 ++++++++++++++++----------
 blockdev.c                         |  5 +++++
 tests/unit/test-bdrv-drain.c       |  6 ++++++
 tests/unit/test-bdrv-graph-mod.c   | 13 +++++++++++--
 7 files changed, 60 insertions(+), 35 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index a1fd70ec97..9e0ccc1c32 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -71,8 +71,10 @@ bdrv_co_create_file(const char *filename, QemuOpts *opts, Error **errp);
 BlockDriverState *bdrv_new(void);
 int bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
                 Error **errp);
-int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
-                      Error **errp);
+
+int GRAPH_WRLOCK
+bdrv_replace_node(BlockDriverState *from, BlockDriverState *to, Error **errp);
+
 int bdrv_replace_child_bs(BdrvChild *child, BlockDriverState *new_bs,
                           Error **errp);
 BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *node_options,
diff --git a/block.c b/block.c
index c7409cf658..eb7eeb85e9 100644
--- a/block.c
+++ b/block.c
@@ -5484,25 +5484,7 @@ out:
 int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                       Error **errp)
 {
-    int ret;
-
-    GLOBAL_STATE_CODE();
-
-    /* Make sure that @from doesn't go away until we have successfully attached
-     * all of its parents to @to. */
-    bdrv_ref(from);
-    bdrv_drained_begin(from);
-    bdrv_drained_begin(to);
-    bdrv_graph_wrlock(to);
-
-    ret = bdrv_replace_node_common(from, to, true, false, errp);
-
-    bdrv_graph_wrunlock();
-    bdrv_drained_end(to);
-    bdrv_drained_end(from);
-    bdrv_unref(from);
-
-    return ret;
+    return bdrv_replace_node_common(from, to, true, false, errp);
 }
 
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
@@ -5717,9 +5699,15 @@ BlockDriverState *bdrv_insert_node(BlockDriverState *bs, QDict *options,
         goto fail;
     }
 
+    bdrv_ref(bs);
     bdrv_drained_begin(bs);
+    bdrv_drained_begin(new_node_bs);
+    bdrv_graph_wrlock(new_node_bs);
     ret = bdrv_replace_node(bs, new_node_bs, errp);
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(new_node_bs);
     bdrv_drained_end(bs);
+    bdrv_unref(bs);
 
     if (ret < 0) {
         error_prepend(errp, "Could not replace node: ");
diff --git a/block/commit.c b/block/commit.c
index d92af02ead..2fecdce86f 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -68,6 +68,7 @@ static void commit_abort(Job *job)
 {
     CommitBlockJob *s = container_of(job, CommitBlockJob, common.job);
     BlockDriverState *top_bs = blk_bs(s->top);
+    BlockDriverState *commit_top_backing_bs;
 
     if (s->chain_frozen) {
         bdrv_graph_rdlock_main_loop();
@@ -94,8 +95,12 @@ static void commit_abort(Job *job)
      * XXX Can (or should) we somehow keep 'consistent read' blocked even
      * after the failed/cancelled commit job is gone? If we already wrote
      * something to base, the intermediate images aren't valid any more. */
-    bdrv_replace_node(s->commit_top_bs, s->commit_top_bs->backing->bs,
-                      &error_abort);
+    commit_top_backing_bs = s->commit_top_bs->backing->bs;
+    bdrv_drained_begin(commit_top_backing_bs);
+    bdrv_graph_wrlock(commit_top_backing_bs);
+    bdrv_replace_node(s->commit_top_bs, commit_top_backing_bs, &error_abort);
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(commit_top_backing_bs);
 
     bdrv_unref(s->commit_top_bs);
     bdrv_unref(top_bs);
@@ -425,7 +430,11 @@ fail:
     /* commit_top_bs has to be replaced after deleting the block job,
      * otherwise this would fail because of lack of permissions. */
     if (commit_top_bs) {
+        bdrv_graph_wrlock(top);
+        bdrv_drained_begin(top);
         bdrv_replace_node(commit_top_bs, top, &error_abort);
+        bdrv_drained_end(top);
+        bdrv_graph_wrunlock();
     }
 }
 
diff --git a/block/mirror.c b/block/mirror.c
index 304bd3208a..e2e325ec56 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -704,6 +704,7 @@ static int mirror_exit_common(Job *job)
      * these permissions any more means that we can't allow any new requests on
      * mirror_top_bs from now on, so keep it drained. */
     bdrv_drained_begin(mirror_top_bs);
+    bdrv_drained_begin(target_bs);
     bs_opaque->stop = true;
 
     bdrv_graph_rdlock_main_loop();
@@ -749,15 +750,13 @@ static int mirror_exit_common(Job *job)
         /* The mirror job has no requests in flight any more, but we need to
          * drain potential other users of the BDS before changing the graph. */
         assert(s->in_drain);
-        bdrv_drained_begin(target_bs);
+        bdrv_drained_begin(to_replace);
         /*
          * Cannot use check_to_replace_node() here, because that would
          * check for an op blocker on @to_replace, and we have our own
          * there.
-         *
-         * TODO Pull out the writer lock from bdrv_replace_node() to here
          */
-        bdrv_graph_rdlock_main_loop();
+        bdrv_graph_wrlock(target_bs);
         if (bdrv_recurse_can_replace(src, to_replace)) {
             bdrv_replace_node(to_replace, target_bs, &local_err);
         } else {
@@ -766,8 +765,8 @@ static int mirror_exit_common(Job *job)
                        "would not lead to an abrupt change of visible data",
                        to_replace->node_name, target_bs->node_name);
         }
-        bdrv_graph_rdunlock_main_loop();
-        bdrv_drained_end(target_bs);
+        bdrv_graph_wrunlock();
+        bdrv_drained_end(to_replace);
         if (local_err) {
             error_report_err(local_err);
             ret = -EPERM;
@@ -782,7 +781,6 @@ static int mirror_exit_common(Job *job)
         aio_context_release(replace_aio_context);
     }
     g_free(s->replaces);
-    bdrv_unref(target_bs);
 
     /*
      * Remove the mirror filter driver from the graph. Before this, get rid of
@@ -790,7 +788,12 @@ static int mirror_exit_common(Job *job)
      * valid.
      */
     block_job_remove_all_bdrv(bjob);
+    bdrv_graph_wrlock(mirror_top_bs);
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
+    bdrv_graph_wrunlock();
+
+    bdrv_drained_end(target_bs);
+    bdrv_unref(target_bs);
 
     bs_opaque->job = NULL;
 
@@ -1930,11 +1933,14 @@ fail:
     }
 
     bs_opaque->stop = true;
-    bdrv_graph_rdlock_main_loop();
+    bdrv_drained_begin(bs);
+    bdrv_graph_wrlock(bs);
+    assert(mirror_top_bs->backing->bs == bs);
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
-    bdrv_graph_rdunlock_main_loop();
-    bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
+    bdrv_replace_node(mirror_top_bs, bs, &error_abort);
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(bs);
 
     bdrv_unref(mirror_top_bs);
 
diff --git a/blockdev.c b/blockdev.c
index 368cec3747..f36e169ea3 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1601,7 +1601,12 @@ static void external_snapshot_abort(void *opaque)
                 aio_context_acquire(aio_context);
             }
 
+            bdrv_drained_begin(state->new_bs);
+            bdrv_graph_wrlock(state->old_bs);
             bdrv_replace_node(state->new_bs, state->old_bs, &error_abort);
+            bdrv_graph_wrunlock();
+            bdrv_drained_end(state->new_bs);
+
             bdrv_unref(state->old_bs); /* bdrv_replace_node() ref'ed old_bs */
 
             aio_context_release(aio_context);
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 40d17b4c5a..b16f831c23 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -2000,7 +2000,13 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     parent_s->was_undrained = false;
 
     g_assert(parent_bs->quiesce_counter == old_drain_count);
+    bdrv_drained_begin(old_child_bs);
+    bdrv_drained_begin(new_child_bs);
+    bdrv_graph_wrlock(NULL);
     bdrv_replace_node(old_child_bs, new_child_bs, &error_abort);
+    bdrv_graph_wrunlock();
+    bdrv_drained_end(new_child_bs);
+    bdrv_drained_end(old_child_bs);
     g_assert(parent_bs->quiesce_counter == new_drain_count);
 
     if (!old_drain_count && !new_drain_count) {
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 8609f7f42b..22d4cd83f6 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -234,11 +234,16 @@ static void test_parallel_exclusive_write(void)
     BlockDriverState *fl1 = pass_through_node("fl1");
     BlockDriverState *fl2 = pass_through_node("fl2");
 
+    bdrv_drained_begin(fl1);
+    bdrv_drained_begin(fl2);
+
     /*
      * bdrv_attach_child() eats child bs reference, so we need two @base
-     * references for two filters:
+     * references for two filters. We also need an additional @fl1 reference so
+     * that it still exists when we want to undrain it.
      */
     bdrv_ref(base);
+    bdrv_ref(fl1);
 
     bdrv_graph_wrlock(NULL);
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
@@ -250,10 +255,14 @@ static void test_parallel_exclusive_write(void)
     bdrv_attach_child(fl2, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
-    bdrv_graph_wrunlock();
 
     bdrv_replace_node(fl1, fl2, &error_abort);
+    bdrv_graph_wrunlock();
+
+    bdrv_drained_end(fl2);
+    bdrv_drained_end(fl1);
 
+    bdrv_unref(fl1);
     bdrv_unref(fl2);
     bdrv_unref(top);
 }
-- 
2.41.0


