Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FAE4832D27
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:31:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrkg-0006k2-UL; Fri, 19 Jan 2024 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@iki.fi>)
 id 1rQrkT-0006jV-Oh; Fri, 19 Jan 2024 11:29:43 -0500
Received: from meesny.iki.fi ([195.140.195.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@iki.fi>)
 id 1rQrkR-0003Bd-VC; Fri, 19 Jan 2024 11:29:41 -0500
Received: from asuna.localdomain (dqtkhhyc60wj3ycwv0sjt-3.rev.dnainternet.fi
 [IPv6:2001:14ba:6c10:6300:5af4:8f70:a51:f3cf])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: megari)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4TGlSR1LbbzyPB;
 Fri, 19 Jan 2024 18:29:26 +0200 (EET)
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Ari Sundholm <ari@tuxera.com>
Subject: [PATCH v3] block/blklogwrites: Protect mutable driver state with a
 mutex.
Date: Fri, 19 Jan 2024 18:29:13 +0200
Message-ID: <20240119162913.2620245-1-ari@tuxera.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.140.195.201; envelope-from=megari@iki.fi;
 helo=meesny.iki.fi
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ari Sundholm <ari@tuxera.com>
From:  Ari Sundholm via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

During the review of a fix for a concurrency issue in blklogwrites,
it was found that the driver needs an additional fix when enabling
multiqueue, which is a new feature introduced in QEMU 9.0, as the
driver state may be read and written by multiple threads at the same
time, which was not the case when the driver was originally written.

Fix the multi-threaded scenario by introducing a mutex to protect the
mutable fields in the driver state, and always having the mutex locked
by the current thread when accessing them. Also use the mutex and a
CoQueue to ensure that the super block is not being written to by
multiple threads concurrently and updates are properly serialized.

Additionally, add the const qualifier to a few BDRVBlkLogWritesState
pointer targets in contexts where the driver state is not written to.

Signed-off-by: Ari Sundholm <ari@tuxera.com>

v1->v2: Ensure that the super block is not written to concurrently.
v2->v3: Use a CoQueue instead of a condition variable, as the latter
does not make the currently executing coroutine yield on entering a
wait.
---
 block/blklogwrites.c | 85 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 77 insertions(+), 8 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ba717dab4d..399819a2a1 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
  * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
- * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
+ * Copyright (c) 2018-2024 Ari Sundholm <ari@tuxera.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -55,9 +55,34 @@ typedef struct {
     BdrvChild *log_file;
     uint32_t sectorsize;
     uint32_t sectorbits;
+    uint64_t update_interval;
+
+    /*
+     * The mutable state of the driver, consisting of the current log sector
+     * and the number of log entries.
+     *
+     * May be read and/or written from multiple threads, and the mutex must be
+     * held when accessing these fields.
+     */
     uint64_t cur_log_sector;
     uint64_t nr_entries;
-    uint64_t update_interval;
+    QemuMutex mutex;
+
+    /*
+     * The super block sequence number. Non-zero if a super block update is in
+     * progress.
+     *
+     * The mutex must be held when accessing this field.
+     */
+    uint64_t super_update_seq;
+
+    /*
+     * A coroutine-aware queue to serialize super block updates.
+     *
+     * Used with the mutex to ensure that only one thread be updating the super
+     * block at a time.
+     */
+    CoQueue super_update_queue;
 } BDRVBlkLogWritesState;
 
 static QemuOptsList runtime_opts = {
@@ -169,6 +194,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    qemu_mutex_init(&s->mutex);
+    qemu_co_queue_init(&s->super_update_queue);
+
     log_append = qemu_opt_get_bool(opts, "log-append", false);
 
     if (log_append) {
@@ -231,6 +259,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
         s->nr_entries = 0;
     }
 
+    s->super_update_seq = 0;
+
     if (!blk_log_writes_sector_size_valid(log_sector_size)) {
         ret = -EINVAL;
         error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
@@ -255,6 +285,7 @@ fail_log:
         bdrv_unref_child(bs, s->log_file);
         bdrv_graph_wrunlock();
         s->log_file = NULL;
+        qemu_mutex_destroy(&s->mutex);
     }
 fail:
     qemu_opts_del(opts);
@@ -269,6 +300,7 @@ static void blk_log_writes_close(BlockDriverState *bs)
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
     bdrv_graph_wrunlock();
+    qemu_mutex_destroy(&s->mutex);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
@@ -295,7 +327,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
 
 static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    BDRVBlkLogWritesState *s = bs->opaque;
+    const BDRVBlkLogWritesState *s = bs->opaque;
     bs->bl.request_alignment = s->sectorsize;
 }
 
@@ -338,15 +370,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
      * driver may be modified by other driver operations while waiting for the
      * I/O to complete.
      */
+    qemu_mutex_lock(&s->mutex);
     const uint64_t entry_start_sector = s->cur_log_sector;
     const uint64_t entry_offset = entry_start_sector << s->sectorbits;
     const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
     const uint64_t entry_aligned_size = qiov_aligned_size +
         ROUND_UP(lr->zero_size, s->sectorsize);
     const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
+    const uint64_t entry_seq = s->nr_entries + 1;
 
-    s->nr_entries++;
+    s->nr_entries = entry_seq;
     s->cur_log_sector += entry_nr_sectors;
+    qemu_mutex_unlock(&s->mutex);
 
     /*
      * Write the log entry. Note that if this is a "write zeroes" operation,
@@ -366,17 +401,44 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 
     /* Update super block on flush or every update interval */
     if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
-        || (s->nr_entries % s->update_interval == 0)))
+        || (entry_seq % s->update_interval == 0)))
     {
         struct log_write_super super = {
             .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
             .version    = cpu_to_le64(WRITE_LOG_VERSION),
-            .nr_entries = cpu_to_le64(s->nr_entries),
+            .nr_entries = const_le64(0),
             .sectorsize = cpu_to_le32(s->sectorsize),
         };
-        void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
+        void *zeroes;
         QEMUIOVector qiov;
 
+        /*
+         * Wait if a super block update is already in progress.
+         * Bail out if a newer update got its turn before us.
+         */
+        WITH_QEMU_LOCK_GUARD(&s->mutex) {
+            CoQueueWaitFlags wait_flags = 0;
+            while (s->super_update_seq) {
+                if (entry_seq < s->super_update_seq) {
+                    return;
+                }
+                qemu_co_queue_wait_flags(&s->super_update_queue,
+                    &s->mutex, wait_flags);
+
+                /*
+                 * In case the wait condition remains true after wakeup,
+                 * to avoid starvation, make sure that this request is
+                 * scheduled to rerun next by pushing it to the front of the
+                 * queue.
+                 */
+                wait_flags = CO_QUEUE_WAIT_FRONT;
+            }
+            s->super_update_seq = entry_seq;
+            super.nr_entries = cpu_to_le64(s->nr_entries);
+        }
+
+        zeroes = g_malloc0(s->sectorsize - sizeof(super));
+
         qemu_iovec_init(&qiov, 2);
         qemu_iovec_add(&qiov, &super, sizeof(super));
         qemu_iovec_add(&qiov, zeroes, s->sectorsize - sizeof(super));
@@ -386,6 +448,13 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
         if (lr->log_ret == 0) {
             lr->log_ret = bdrv_co_flush(s->log_file->bs);
         }
+
+        /* The super block has been updated. Let another request have a go. */
+        qemu_mutex_lock(&s->mutex);
+        s->super_update_seq = 0;
+        (void) qemu_co_queue_next(&s->super_update_queue);
+        qemu_mutex_unlock(&s->mutex);
+
         qemu_iovec_destroy(&qiov);
         g_free(zeroes);
     }
@@ -405,7 +474,7 @@ blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
 {
     QEMUIOVector log_qiov;
     size_t niov = qiov ? qiov->niov : 0;
-    BDRVBlkLogWritesState *s = bs->opaque;
+    const BDRVBlkLogWritesState *s = bs->opaque;
     BlkLogWritesFileReq fr = {
         .bs         = bs,
         .offset     = offset,
-- 
2.43.0


