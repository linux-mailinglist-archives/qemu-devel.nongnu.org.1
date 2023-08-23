Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0CB78501E
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgmz-0001HP-AY; Wed, 23 Aug 2023 01:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmr-0001G1-Qi
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgmj-0007Fm-8d
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:52:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B91661C38B
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 53F1921233;
 Wed, 23 Aug 2023 08:52:00 +0300 (MSK)
Received: (nullmailer pid 1917447 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 01/24] block: spelling fixes
Date: Wed, 23 Aug 2023 08:51:29 +0300
Message-Id: <20230823055155.1917375-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 block.c                              | 2 +-
 block/block-copy.c                   | 4 ++--
 block/export/vduse-blk.c             | 2 +-
 block/export/vhost-user-blk-server.c | 2 +-
 block/export/vhost-user-blk-server.h | 2 +-
 block/file-posix.c                   | 8 ++++----
 block/graph-lock.c                   | 2 +-
 block/io.c                           | 2 +-
 block/linux-aio.c                    | 2 +-
 block/mirror.c                       | 2 +-
 block/qcow2-refcount.c               | 2 +-
 block/vhdx.c                         | 2 +-
 block/vhdx.h                         | 4 ++--
 13 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/block.c b/block.c
index a307c151a8..90d2dde828 100644
--- a/block.c
+++ b/block.c
@@ -7583,5 +7583,5 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
      * Recursion phase: go through all nodes of the graph.
      * Take care of checking that all nodes support changing AioContext
-     * and drain them, builing a linear list of callbacks to run if everything
+     * and drain them, building a linear list of callbacks to run if everything
      * is successful (the transaction itself).
      */
diff --git a/block/block-copy.c b/block/block-copy.c
index e13d7bc6b6..1c60368d72 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -68,5 +68,5 @@ typedef struct BlockCopyCallState {
 
     /*
-     * Fields that report information about return values and erros.
+     * Fields that report information about return values and errors.
      * Protected by lock in BlockCopyState.
      */
@@ -463,5 +463,5 @@ static coroutine_fn int block_copy_task_run(AioTaskPool *pool,
  * s->len only to cover last cluster when s->len is not aligned to clusters.
  *
- * No sync here: nor bitmap neighter intersecting requests handling, only copy.
+ * No sync here: neither bitmap nor intersecting requests handling, only copy.
  *
  * @method is an in-out argument, so that copy_range can be either extended to
diff --git a/block/export/vduse-blk.c b/block/export/vduse-blk.c
index 83b05548e7..172f73cef4 100644
--- a/block/export/vduse-blk.c
+++ b/block/export/vduse-blk.c
@@ -139,5 +139,5 @@ static void vduse_blk_enable_queue(VduseDev *dev, VduseVirtq *vq)
     aio_set_fd_handler(vblk_exp->export.ctx, vduse_queue_get_fd(vq),
                        on_vduse_vq_kick, NULL, NULL, NULL, vq);
-    /* Make sure we don't miss any kick afer reconnecting */
+    /* Make sure we don't miss any kick after reconnecting */
     eventfd_write(vduse_queue_get_fd(vq), 1);
 }
diff --git a/block/export/vhost-user-blk-server.c b/block/export/vhost-user-blk-server.c
index f7b5073605..fe2cee3a78 100644
--- a/block/export/vhost-user-blk-server.c
+++ b/block/export/vhost-user-blk-server.c
@@ -1,4 +1,4 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
  * Parts of the code based on nbd/server.c.
diff --git a/block/export/vhost-user-blk-server.h b/block/export/vhost-user-blk-server.h
index fcf46fc8a5..77fb5c0131 100644
--- a/block/export/vhost-user-blk-server.h
+++ b/block/export/vhost-user-blk-server.h
@@ -1,4 +1,4 @@
 /*
- * Sharing QEMU block devices via vhost-user protocal
+ * Sharing QEMU block devices via vhost-user protocol
  *
  * Copyright (c) Coiby Xu <coiby.xu@gmail.com>.
diff --git a/block/file-posix.c b/block/file-posix.c
index b16e9c21a1..4757914ac0 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -1160,7 +1160,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
      * raw_reconfigure_getfd(). But it wants updated "perm", when in
      * bdrv_reopen_multiple() .bdrv_reopen_prepare() callback called prior to
-     * permission update. Happily, permission update is always a part (a seprate
-     * stage) of bdrv_reopen_multiple() so we can rely on this fact and
-     * reconfigure fd in raw_check_perm().
+     * permission update. Happily, permission update is always a part
+     * (a separate stage) of bdrv_reopen_multiple() so we can rely on this
+     * fact and reconfigure fd in raw_check_perm().
      */
 
@@ -3375,5 +3375,5 @@ static void raw_account_discard(BDRVRawState *s, uint64_t nbytes, int ret)
  * zones is an array of zone descriptors to hold zone information on reply;
  * offset can be any byte within the entire size of the device;
- * nr_zones is the maxium number of sectors the command should operate on.
+ * nr_zones is the maximum number of sectors the command should operate on.
  */
 #if defined(CONFIG_BLKZONED)
diff --git a/block/graph-lock.c b/block/graph-lock.c
index 5e66f01ae8..f357a2c0b1 100644
--- a/block/graph-lock.c
+++ b/block/graph-lock.c
@@ -96,5 +96,5 @@ static uint32_t reader_count(void)
     QEMU_LOCK_GUARD(&aio_context_list_lock);
 
-    /* rd can temporarly be negative, but the total will *always* be >= 0 */
+    /* rd can temporarily be negative, but the total will *always* be >= 0 */
     rd = orphaned_reader_count;
     QTAILQ_FOREACH(brdv_graph, &aio_context_list, next_aio) {
diff --git a/block/io.c b/block/io.c
index 055fcf7438..9ccb1ccb16 100644
--- a/block/io.c
+++ b/block/io.c
@@ -343,5 +343,5 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 
-    /* Reaquire the AioContext of bs if we dropped it */
+    /* Reacquire the AioContext of bs if we dropped it */
     if (ctx != co_ctx) {
         aio_context_acquire(ctx);
diff --git a/block/linux-aio.c b/block/linux-aio.c
index 561c71a9ae..1a51503271 100644
--- a/block/linux-aio.c
+++ b/block/linux-aio.c
@@ -228,5 +228,5 @@ static void qemu_laio_process_completions(LinuxAioState *s)
     /* If we are nested we have to notify the level above that we are done
      * by setting event_max to zero, upper level will then jump out of it's
-     * own `for` loop.  If we are the last all counters droped to zero. */
+     * own `for` loop.  If we are the last all counters dropped to zero. */
     s->event_max = 0;
     s->event_idx = 0;
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..02a092c61c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -503,5 +503,5 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
     job_pause_point(&s->common.job);
 
-    /* Find the number of consective dirty chunks following the first dirty
+    /* Find the number of consecutive dirty chunks following the first dirty
      * one, and wait for in flight requests in them. */
     bdrv_dirty_bitmap_lock(s->dirty_bitmap);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 5095e99a37..996d1217d0 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -2646,5 +2646,5 @@ rebuild_refcount_structure(BlockDriverState *bs, BdrvCheckResult *res,
      *
      * (This loop will terminate, because with every cluster the
-     * reftable grows, it can accomodate a multitude of more refcounts,
+     * reftable grows, it can accommodate a multitude of more refcounts,
      * so that at some point this must be able to cover the reftable
      * and all refblocks describing it.)
diff --git a/block/vhdx.c b/block/vhdx.c
index f2c3a80190..a67edcc03e 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1078,5 +1078,5 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
-    /* endian convert populated BAT field entires */
+    /* endian convert populated BAT field entries */
     for (i = 0; i < s->bat_entries; i++) {
         s->bat[i] = le64_to_cpu(s->bat[i]);
diff --git a/block/vhdx.h b/block/vhdx.h
index 7db746cd18..455a627a46 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -213,5 +213,5 @@ typedef struct QEMU_PACKED VHDXLogDataSector {
     uint8_t     data[4084];             /* raw data, bytes 8-4091 (inclusive).
                                            see the data descriptor field for the
-                                           other mising bytes */
+                                           other missing bytes */
     uint32_t    sequence_low;           /* 4 LSB of 8 byte sequence_number */
 } VHDXLogDataSector;
@@ -258,5 +258,5 @@ typedef struct QEMU_PACKED VHDXMetadataTableHeader {
 #define VHDX_META_FLAGS_IS_USER         0x01    /* max 1024 entries */
 #define VHDX_META_FLAGS_IS_VIRTUAL_DISK 0x02    /* virtual disk metadata if set,
-                                                   otherwise file metdata */
+                                                   otherwise file metadata */
 #define VHDX_META_FLAGS_IS_REQUIRED     0x04    /* parse must understand this
                                                    entry to open the file */
-- 
2.39.2


