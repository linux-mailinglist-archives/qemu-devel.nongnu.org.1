Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D2F82AECF
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:35:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNuHM-0005y0-Cq; Thu, 11 Jan 2024 07:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@iki.fi>)
 id 1rNuGx-0005Ry-2v; Thu, 11 Jan 2024 07:35:00 -0500
Received: from meesny.iki.fi ([195.140.195.201])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <megari@iki.fi>)
 id 1rNuGu-0006KS-DX; Thu, 11 Jan 2024 07:34:58 -0500
Received: from asuna.localdomain (dqtkhhyj8rfbp6-pnnpzy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:6c10:6300:fc71:2cd:7d8b:5b28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: megari)
 by meesny.iki.fi (Postfix) with ESMTPSA id 4T9kdD48XCzyWK;
 Thu, 11 Jan 2024 14:34:40 +0200 (EET)
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Ari Sundholm <ari@tuxera.com>
Subject: [PATCH] block/blklogwrites: Protect mutable driver state with a mutex.
Date: Thu, 11 Jan 2024 14:34:24 +0200
Message-ID: <20240111123424.1317763-1-ari@tuxera.com>
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
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
by the current thread when accessing them.

Additionally, add the const qualifier to a few BDRVBlkLogWritesState
pointer targets in contexts where the driver state is not written to.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index ba717dab4d..50f68df2a6 100644
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
@@ -55,9 +55,18 @@ typedef struct {
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
 } BDRVBlkLogWritesState;
 
 static QemuOptsList runtime_opts = {
@@ -149,6 +158,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t log_sector_size;
     bool log_append;
 
+    qemu_mutex_init(&s->mutex);
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         ret = -EINVAL;
@@ -255,6 +265,7 @@ fail_log:
         bdrv_unref_child(bs, s->log_file);
         bdrv_graph_wrunlock();
         s->log_file = NULL;
+        qemu_mutex_destroy(&s->mutex);
     }
 fail:
     qemu_opts_del(opts);
@@ -269,6 +280,7 @@ static void blk_log_writes_close(BlockDriverState *bs)
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
     bdrv_graph_wrunlock();
+    qemu_mutex_destroy(&s->mutex);
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
@@ -295,7 +307,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
 
 static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
 {
-    BDRVBlkLogWritesState *s = bs->opaque;
+    const BDRVBlkLogWritesState *s = bs->opaque;
     bs->bl.request_alignment = s->sectorsize;
 }
 
@@ -338,15 +350,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
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
@@ -366,14 +381,16 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
 
     /* Update super block on flush or every update interval */
     if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
-        || (s->nr_entries % s->update_interval == 0)))
+        || (entry_seq % s->update_interval == 0)))
     {
+        qemu_mutex_lock(&s->mutex);
         struct log_write_super super = {
             .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
             .version    = cpu_to_le64(WRITE_LOG_VERSION),
             .nr_entries = cpu_to_le64(s->nr_entries),
             .sectorsize = cpu_to_le32(s->sectorsize),
         };
+        qemu_mutex_unlock(&s->mutex);
         void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
         QEMUIOVector qiov;
 
@@ -405,7 +422,7 @@ blk_log_writes_co_log(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
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


