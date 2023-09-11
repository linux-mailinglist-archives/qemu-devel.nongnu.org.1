Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D1979A6F2
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVV-0005wr-1C; Mon, 11 Sep 2023 05:47:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVS-0005vS-LY
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVP-0004ia-KI
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FidnShto0DEZ/wgeRzANcug2eDoiBPesbeGdI6IyoQw=;
 b=d4xRW9kfYM6TFaj7b11NXADB+UwLVf6ISErOke+a6R1gQAMH1PtgeIT5Sg1ibABCkAFHfg
 +swr3Z6OQrS6x4FcBbwPCQdLuDdObkpjfF3YjCghJipwDY6b5+iHRCL1c+vJ9EpjjFiBUl
 wIjTn0sZISnFNAqwNzJxP4G1v8yBaLY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-ZWyP02dEMBiH6V7XOCa32g-1; Mon, 11 Sep 2023 05:46:50 -0400
X-MC-Unique: ZWyP02dEMBiH6V7XOCa32g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 731D48A2E3D;
 Mon, 11 Sep 2023 09:46:50 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42FBC40C6EA8;
 Mon, 11 Sep 2023 09:46:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 13/21] block: Mark bdrv_parent_perms_conflict() and callers
 GRAPH_RDLOCK
Date: Mon, 11 Sep 2023 11:46:12 +0200
Message-ID: <20230911094620.45040-14-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

The function reads the parents list, so it needs to hold the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-common.h            |  6 ++---
 include/block/block_int-global-state.h      |  8 +++---
 include/sysemu/block-backend-global-state.h |  4 +--
 block.c                                     | 28 +++++++++++++--------
 block/block-backend.c                       | 26 ++++++++++++++-----
 block/crypto.c                              |  6 +++--
 block/mirror.c                              |  8 ++++++
 block/vmdk.c                                |  2 ++
 tests/unit/test-bdrv-graph-mod.c            |  4 +++
 9 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 85be256c09..fda9d8b5c8 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -311,7 +311,7 @@ struct BlockDriver {
      */
     void (*bdrv_cancel_in_flight)(BlockDriverState *bs);
 
-    int (*bdrv_inactivate)(BlockDriverState *bs);
+    int GRAPH_RDLOCK_PTR (*bdrv_inactivate)(BlockDriverState *bs);
 
     int (*bdrv_snapshot_create)(BlockDriverState *bs,
                                 QEMUSnapshotInfo *sn_info);
@@ -944,8 +944,8 @@ struct BdrvChildClass {
      * when migration is completing) and it can start/stop requesting
      * permissions and doing I/O on it.
      */
-    void (*activate)(BdrvChild *child, Error **errp);
-    int (*inactivate)(BdrvChild *child);
+    void GRAPH_RDLOCK_PTR (*activate)(BdrvChild *child, Error **errp);
+    int GRAPH_RDLOCK_PTR (*inactivate)(BdrvChild *child);
 
     void GRAPH_WRLOCK_PTR (*attach)(BdrvChild *child);
     void GRAPH_WRLOCK_PTR (*detach)(BdrvChild *child);
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index da5fb31089..bebcc08bce 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -212,8 +212,9 @@ void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
  * bdrv_child_refresh_perms() instead and make the parent's
  * .bdrv_child_perm() implementation return the correct values.
  */
-int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-                            Error **errp);
+int GRAPH_RDLOCK
+bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                        Error **errp);
 
 /**
  * Calls bs->drv->bdrv_child_perm() and updates the child's permission
@@ -223,7 +224,8 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
  * values than before, but which will not result in the block layer
  * automatically refreshing the permissions.
  */
-int bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
+int GRAPH_RDLOCK
+bdrv_child_refresh_perms(BlockDriverState *bs, BdrvChild *c, Error **errp);
 
 bool GRAPH_RDLOCK bdrv_recurse_can_replace(BlockDriverState *bs,
                                            BlockDriverState *to_replace);
diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index 184e667ebd..d5f675493a 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -61,8 +61,8 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp);
 int blk_replace_bs(BlockBackend *blk, BlockDriverState *new_bs, Error **errp);
 bool bdrv_has_blk(BlockDriverState *bs);
 bool bdrv_is_root_node(BlockDriverState *bs);
-int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
-                 Error **errp);
+int GRAPH_UNLOCKED blk_set_perm(BlockBackend *blk, uint64_t perm,
+                                uint64_t shared_perm, Error **errp);
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm);
 
 void blk_iostatus_enable(BlockBackend *blk);
diff --git a/block.c b/block.c
index 369023872a..6720bc4f8a 100644
--- a/block.c
+++ b/block.c
@@ -2202,7 +2202,8 @@ static bool bdrv_a_allow_b(BdrvChild *a, BdrvChild *b, Error **errp)
     return false;
 }
 
-static bool bdrv_parent_perms_conflict(BlockDriverState *bs, Error **errp)
+static bool GRAPH_RDLOCK
+bdrv_parent_perms_conflict(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *a, *b;
     GLOBAL_STATE_CODE();
@@ -2255,8 +2256,8 @@ static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
  * simplest way to satisfy this criteria: use only result of
  * bdrv_topological_dfs() or NULL as @list parameter.
  */
-static GSList *bdrv_topological_dfs(GSList *list, GHashTable *found,
-                                    BlockDriverState *bs)
+static GSList * GRAPH_RDLOCK
+bdrv_topological_dfs(GSList *list, GHashTable *found, BlockDriverState *bs)
 {
     BdrvChild *child;
     g_autoptr(GHashTable) local_found = NULL;
@@ -2532,8 +2533,9 @@ static int bdrv_node_refresh_perm(BlockDriverState *bs, BlockReopenQueue *q,
  * @list is a product of bdrv_topological_dfs() (may be called several times) -
  * a topologically sorted subgraph.
  */
-static int bdrv_do_refresh_perms(GSList *list, BlockReopenQueue *q,
-                                 Transaction *tran, Error **errp)
+static int GRAPH_RDLOCK
+bdrv_do_refresh_perms(GSList *list, BlockReopenQueue *q, Transaction *tran,
+                      Error **errp)
 {
     int ret;
     BlockDriverState *bs;
@@ -2560,8 +2562,9 @@ static int bdrv_do_refresh_perms(GSList *list, BlockReopenQueue *q,
  * topologically sorted. It's not a problem if some node occurs in the @list
  * several times.
  */
-static int bdrv_list_refresh_perms(GSList *list, BlockReopenQueue *q,
-                                   Transaction *tran, Error **errp)
+static int GRAPH_RDLOCK
+bdrv_list_refresh_perms(GSList *list, BlockReopenQueue *q, Transaction *tran,
+                        Error **errp)
 {
     g_autoptr(GHashTable) found = g_hash_table_new(NULL, NULL);
     g_autoptr(GSList) refresh_list = NULL;
@@ -2621,8 +2624,8 @@ char *bdrv_perm_names(uint64_t perm)
 
 
 /* @tran is allowed to be NULL. In this case no rollback is possible */
-static int bdrv_refresh_perms(BlockDriverState *bs, Transaction *tran,
-                              Error **errp)
+static int GRAPH_RDLOCK
+bdrv_refresh_perms(BlockDriverState *bs, Transaction *tran, Error **errp)
 {
     int ret;
     Transaction *local_tran = NULL;
@@ -3247,7 +3250,6 @@ void bdrv_root_unref_child(BdrvChild *child)
     GLOBAL_STATE_CODE();
     bdrv_graph_wrlock(NULL);
     bdrv_replace_child_noperm(child, NULL);
-    bdrv_graph_wrunlock();
     bdrv_child_free(child);
 
     if (child_bs) {
@@ -3266,6 +3268,7 @@ void bdrv_root_unref_child(BdrvChild *child)
                                     NULL);
     }
 
+    bdrv_graph_wrunlock();
     bdrv_unref(child_bs);
 }
 
@@ -4585,7 +4588,10 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
      * reconfiguring the fd and that's why it does it in raw_check_perm(), not
      * in raw_reopen_prepare() which is called with "old" permissions.
      */
+    bdrv_graph_rdlock_main_loop();
     ret = bdrv_list_refresh_perms(refresh_list, bs_queue, tran, errp);
+    bdrv_graph_rdunlock_main_loop();
+
     if (ret < 0) {
         goto abort;
     }
@@ -6833,6 +6839,7 @@ int bdrv_activate(BlockDriverState *bs, Error **errp)
     BdrvDirtyBitmap *bm;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bs->drv)  {
         return -ENOMEDIUM;
@@ -6963,6 +6970,7 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs)
     uint64_t cumulative_perms, cumulative_shared_perms;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bs->drv) {
         return -ENOMEDIUM;
diff --git a/block/block-backend.c b/block/block-backend.c
index 4009ed5fed..8d0282a5d9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -121,6 +121,10 @@ static QTAILQ_HEAD(, BlockBackend) block_backends =
 static QTAILQ_HEAD(, BlockBackend) monitor_block_backends =
     QTAILQ_HEAD_INITIALIZER(monitor_block_backends);
 
+static int coroutine_mixed_fn GRAPH_RDLOCK
+blk_set_perm_locked(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
+                    Error **errp);
+
 static void blk_root_inherit_options(BdrvChildRole role, bool parent_is_format,
                                      int *child_flags, QDict *child_options,
                                      int parent_flags, QDict *parent_options)
@@ -186,7 +190,7 @@ static void blk_vm_state_changed(void *opaque, bool running, RunState state)
  *
  * If an error is returned, the VM cannot be allowed to be resumed.
  */
-static void blk_root_activate(BdrvChild *child, Error **errp)
+static void GRAPH_RDLOCK blk_root_activate(BdrvChild *child, Error **errp)
 {
     BlockBackend *blk = child->opaque;
     Error *local_err = NULL;
@@ -207,7 +211,7 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
      */
     saved_shared_perm = blk->shared_perm;
 
-    blk_set_perm(blk, blk->perm, BLK_PERM_ALL, &local_err);
+    blk_set_perm_locked(blk, blk->perm, BLK_PERM_ALL, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         blk->disable_perm = true;
@@ -226,7 +230,7 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
         return;
     }
 
-    blk_set_perm(blk, blk->perm, blk->shared_perm, &local_err);
+    blk_set_perm_locked(blk, blk->perm, blk->shared_perm, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         blk->disable_perm = true;
@@ -259,7 +263,7 @@ static bool blk_can_inactivate(BlockBackend *blk)
     return blk->force_allow_inactivate;
 }
 
-static int blk_root_inactivate(BdrvChild *child)
+static int GRAPH_RDLOCK blk_root_inactivate(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
 
@@ -953,8 +957,9 @@ int blk_replace_bs(BlockBackend *blk, BlockDriverState *new_bs, Error **errp)
 /*
  * Sets the permission bitmasks that the user of the BlockBackend needs.
  */
-int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
-                 Error **errp)
+static int coroutine_mixed_fn GRAPH_RDLOCK
+blk_set_perm_locked(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
+                    Error **errp)
 {
     int ret;
     GLOBAL_STATE_CODE();
@@ -972,6 +977,15 @@ int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
     return 0;
 }
 
+int blk_set_perm(BlockBackend *blk, uint64_t perm, uint64_t shared_perm,
+                 Error **errp)
+{
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    return blk_set_perm_locked(blk, perm, shared_perm, errp);
+}
+
 void blk_get_perm(BlockBackend *blk, uint64_t *perm, uint64_t *shared_perm)
 {
     GLOBAL_STATE_CODE();
diff --git a/block/crypto.c b/block/crypto.c
index 6ee8d46d30..c9c9a39fa3 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -777,7 +777,7 @@ block_crypto_get_specific_info_luks(BlockDriverState *bs, Error **errp)
     return spec_info;
 }
 
-static int
+static int GRAPH_RDLOCK
 block_crypto_amend_prepare(BlockDriverState *bs, Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
@@ -793,7 +793,7 @@ block_crypto_amend_prepare(BlockDriverState *bs, Error **errp)
     return ret;
 }
 
-static void
+static void GRAPH_RDLOCK
 block_crypto_amend_cleanup(BlockDriverState *bs)
 {
     BlockCrypto *crypto = bs->opaque;
@@ -841,6 +841,8 @@ block_crypto_amend_options_luks(BlockDriverState *bs,
     QCryptoBlockAmendOptions *amend_options = NULL;
     int ret = -EINVAL;
 
+    assume_graph_lock(); /* FIXME */
+
     assert(crypto);
     assert(crypto->block);
 
diff --git a/block/mirror.c b/block/mirror.c
index aae4bebbb6..3cc0757a03 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -702,8 +702,12 @@ static int mirror_exit_common(Job *job)
      * mirror_top_bs from now on, so keep it drained. */
     bdrv_drained_begin(mirror_top_bs);
     bs_opaque->stop = true;
+
+    bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
+    bdrv_graph_rdunlock_main_loop();
+
     if (!abort && s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
         BlockDriverState *unfiltered_target = bdrv_skip_filters(target_bs);
@@ -1670,6 +1674,8 @@ static BlockJob *mirror_start_job(
     uint64_t target_perms, target_shared_perms;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     if (granularity == 0) {
         granularity = bdrv_get_default_bitmap_granularity(target);
     }
@@ -1906,8 +1912,10 @@ fail:
     }
 
     bs_opaque->stop = true;
+    bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(mirror_top_bs, mirror_top_bs->backing,
                              &error_abort);
+    bdrv_graph_rdunlock_main_loop();
     bdrv_replace_node(mirror_top_bs, mirror_top_bs->backing->bs, &error_abort);
 
     bdrv_unref(mirror_top_bs);
diff --git a/block/vmdk.c b/block/vmdk.c
index 58ce290e9c..84185b73a2 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1309,6 +1309,8 @@ static int vmdk_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVVmdkState *s = bs->opaque;
     uint32_t magic;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index 621e616655..8609f7f42b 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -372,6 +372,9 @@ static void test_parallel_perm_update(void)
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
+
+    bdrv_graph_rdlock_main_loop();
+
     bdrv_child_refresh_perms(top, top->children.lh_first, &error_abort);
 
     assert(c_fl1->perm & BLK_PERM_WRITE);
@@ -391,6 +394,7 @@ static void test_parallel_perm_update(void)
     assert(c_fl1->perm & BLK_PERM_WRITE);
     assert(!(c_fl2->perm & BLK_PERM_WRITE));
 
+    bdrv_graph_rdunlock_main_loop();
     bdrv_unref(top);
 }
 
-- 
2.41.0


