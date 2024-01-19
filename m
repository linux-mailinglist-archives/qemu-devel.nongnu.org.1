Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D725832EBD
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:16:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNN-0001jf-Ap; Fri, 19 Jan 2024 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNL-0001iB-6L
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtNF-0007gO-3F
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sj3ULLvzpdZSSoBFU8DUbG4v/mhg3sH2J0N7KsejgkQ=;
 b=LG5k+D4WhjYyUi1bc413hPNJOWil9Eeu7n00YNAzlR7UIN8xTyzMceQvhnv2NaRA/Oi64U
 2+sOFbdW+7MbDbDANuku+oUrokwlEVTb3xCPIPn/jEyjv1VJGeDkypk8K5M53g1TIv4Zcc
 ybYAdrikYn5Q9kK539T7UxWaU7D6ly0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-hig_P3L5Ooiw46CJ8Su1bg-1; Fri, 19 Jan 2024 13:13:45 -0500
X-MC-Unique: hig_P3L5Ooiw46CJ8Su1bg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8A3410665A2;
 Fri, 19 Jan 2024 18:13:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9FC1B96;
 Fri, 19 Jan 2024 18:13:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/14] block/blklogwrites: Protect mutable driver state with a
 mutex.
Date: Fri, 19 Jan 2024 19:13:27 +0100
Message-ID: <20240119181327.236745-15-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Ari Sundholm <ari@tuxera.com>

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
Message-ID: <20240119162913.2620245-1-ari@tuxera.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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


