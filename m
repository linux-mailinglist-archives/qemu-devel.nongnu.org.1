Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1A4AC9264
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 17:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1PP-00040i-Hr; Fri, 30 May 2025 11:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1PD-0003QS-Gk; Fri, 30 May 2025 11:12:23 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uL1P8-0002Hy-Rh; Fri, 30 May 2025 11:12:23 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 3BBFD44ADD;
 Fri, 30 May 2025 17:11:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com,
 andrey.drobyshev@virtuozzo.com, hreitz@redhat.com, stefanha@redhat.com,
 eblake@redhat.com, jsnow@redhat.com, vsementsov@yandex-team.ru,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, berto@igalia.com,
 fam@euphon.net, ari@tuxera.com
Subject: [PATCH v4 12/48] block: move drain outside of bdrv_root_attach_child()
Date: Fri, 30 May 2025 17:10:49 +0200
Message-Id: <20250530151125.955508-13-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250530151125.955508-1-f.ebner@proxmox.com>
References: <20250530151125.955508-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The function bdrv_root_attach_child() runs under the graph lock, so it
is not allowed to drain. It is called by:
1. blk_insert_bs(), where a drained section is introduced.
2. block_job_add_bdrv(), which holds the graph lock itself.

block_job_add_bdrv() is called by:
1. mirror_start_job()
2. stream_start()
3. commit_start()
4. backup_job_create()
5. block_job_create()
6. In the test_blockjob_common_drain_node() unit test

In all callers, a drained section is introduced.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---

Changes in v4:
* Document requirement that all nodes need to be drained for
  bdrv_root_attach_child() and block_job_add_bdrv().

 block.c                      | 4 ++--
 block/backup.c               | 2 ++
 block/block-backend.c        | 2 ++
 block/commit.c               | 4 ++++
 block/mirror.c               | 5 +++++
 block/stream.c               | 4 ++++
 blockjob.c                   | 4 ++++
 include/block/blockjob.h     | 2 ++
 tests/unit/test-bdrv-drain.c | 2 ++
 9 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index e53a88e1b6..17c34dc240 100644
--- a/block.c
+++ b/block.c
@@ -3228,6 +3228,8 @@ bdrv_attach_child_noperm(BlockDriverState *parent_bs,
  *
  * On failure NULL is returned, errp is set and the reference to
  * child_bs is also dropped.
+ *
+ * All block nodes must be drained.
  */
 BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   const char *child_name,
@@ -3242,7 +3244,6 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
     child = bdrv_attach_child_common(child_bs, child_name, child_class,
                                    child_role, perm, shared_perm, opaque,
                                    tran, errp);
@@ -3255,7 +3256,6 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 
 out:
     tran_finalize(tran, ret);
-    bdrv_drain_all_end();
 
     bdrv_schedule_unref(child_bs);
 
diff --git a/block/backup.c b/block/backup.c
index 0151e84395..909027c17a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -498,10 +498,12 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_copy_set_speed(bcs, speed);
 
     /* Required permissions are taken by copy-before-write filter target */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     return &job->common;
 
diff --git a/block/block-backend.c b/block/block-backend.c
index 6a6949edeb..24cae3cb55 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -904,6 +904,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
 
     GLOBAL_STATE_CODE();
     bdrv_ref(bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     if ((bs->open_flags & BDRV_O_INACTIVE) && blk_can_inactivate(blk)) {
@@ -919,6 +920,7 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
                                        BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                                        perm, shared_perm, blk, errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     if (blk->root == NULL) {
         return -EPERM;
     }
diff --git a/block/commit.c b/block/commit.c
index 7cc8c0f0df..6c4b736ff8 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -392,6 +392,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
      * this is the responsibility of the interface (i.e. whoever calls
      * commit_start()).
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     s->base_overlay = bdrv_find_overlay(top, base);
     assert(s->base_overlay);
@@ -424,18 +425,21 @@ void commit_start(const char *job_id, BlockDriverState *bs,
                                  iter_shared_perms, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
 
     if (bdrv_freeze_backing_chain(commit_top_bs, base, errp) < 0) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
     s->chain_frozen = true;
 
     ret = block_job_add_bdrv(&s->common, "base", base, 0, BLK_PERM_ALL, errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     if (ret < 0) {
         goto fail;
diff --git a/block/mirror.c b/block/mirror.c
index c2c5099c95..6e8caf4b49 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -2014,6 +2014,7 @@ static BlockJob *mirror_start_job(
      */
     bdrv_disable_dirty_bitmap(s->dirty_bitmap);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     ret = block_job_add_bdrv(&s->common, "source", bs, 0,
                              BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
@@ -2021,6 +2022,7 @@ static BlockJob *mirror_start_job(
                              errp);
     if (ret < 0) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -2066,16 +2068,19 @@ static BlockJob *mirror_start_job(
                                      iter_shared_perms, errp);
             if (ret < 0) {
                 bdrv_graph_wrunlock();
+                bdrv_drain_all_end();
                 goto fail;
             }
         }
 
         if (bdrv_freeze_backing_chain(mirror_top_bs, target, errp) < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     QTAILQ_INIT(&s->ops_in_flight);
 
diff --git a/block/stream.c b/block/stream.c
index 6ba49cffd3..f5441f27f4 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -371,10 +371,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached.
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     if (block_job_add_bdrv(&s->common, "active node", bs, 0,
                            basic_flags | BLK_PERM_WRITE, errp)) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         goto fail;
     }
 
@@ -395,10 +397,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
                                  basic_flags, errp);
         if (ret < 0) {
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             goto fail;
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     s->base_overlay = base_overlay;
     s->above_base = above_base;
diff --git a/blockjob.c b/blockjob.c
index 34185d7715..44991e3ff7 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -496,6 +496,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     int ret;
     GLOBAL_STATE_CODE();
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
 
     if (job_id == NULL && !(flags & JOB_INTERNAL)) {
@@ -506,6 +507,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                      flags, cb, opaque, errp);
     if (job == NULL) {
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
         return NULL;
     }
 
@@ -544,10 +546,12 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     }
 
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     return job;
 
 fail:
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     job_early_fail(&job->job);
     return NULL;
 }
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 7061ab7201..990f3e179a 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -137,6 +137,8 @@ BlockJob *block_job_get_locked(const char *id);
  * Add @bs to the list of BlockDriverState that are involved in
  * @job. This means that all operations will be blocked on @bs while
  * @job exists.
+ *
+ * All block nodes must be drained.
  */
 int GRAPH_WRLOCK
 block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 3185f3f429..4f3057844b 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -772,9 +772,11 @@ static void test_blockjob_common_drain_node(enum drain_type drain_type,
     tjob->bs = src;
     job = &tjob->common;
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     switch (result) {
     case TEST_JOB_SUCCESS:
-- 
2.39.5



