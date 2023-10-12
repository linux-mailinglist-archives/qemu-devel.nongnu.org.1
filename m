Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D9B7C72DD
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:31:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySv-0003fG-HT; Thu, 12 Oct 2023 12:23:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySr-0003bm-SQ
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000co-Hb
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTansi5iYYM78de8wLXg/Xiisg6BcuxfV1H3RkCFWZs=;
 b=BD7yUgms1Y5lmnNRozmzwKiEpOmPRnksbzFqewAy4f50NHs62SsCB69NTmwgDmseTIt/pY
 nGlUT0tQHJ/9SS/Xbse/MOuV6aghqR//4H4Bohm0Ut/BQTgxU7n2dB6t6OsvfaEWS5TkJx
 8cEZfZvBFlKXPPmEBBLoUavjMKjPpuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-xJr6BldtNBuyEspGU_CygA-1; Thu, 12 Oct 2023 12:22:39 -0400
X-MC-Unique: xJr6BldtNBuyEspGU_CygA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE852858F1C;
 Thu, 12 Oct 2023 16:22:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D8902026831;
 Thu, 12 Oct 2023 16:22:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/26] block: convert more bdrv_is_allocated* and
 bdrv_block_status* calls to coroutine versions
Date: Thu, 12 Oct 2023 18:22:02 +0200
Message-ID: <20231012162224.240535-5-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

From: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20230904100306.156197-5-pbonzini@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/copy-before-write.c |  2 +-
 block/copy-on-read.c      |  8 ++++----
 block/io.c                |  6 +++---
 block/mirror.c            | 10 +++++-----
 block/qcow2.c             |  5 +++--
 block/replication.c       |  8 ++++----
 block/stream.c            |  8 ++++----
 block/vvfat.c             | 18 +++++++++---------
 8 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index aeaff3bb82..4ffabc5ca2 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -305,7 +305,7 @@ cbw_co_snapshot_block_status(BlockDriverState *bs,
         return -EACCES;
     }
 
-    ret = bdrv_block_status(child->bs, offset, cur_bytes, pnum, map, file);
+    ret = bdrv_co_block_status(child->bs, offset, cur_bytes, pnum, map, file);
     if (child == s->target) {
         /*
          * We refer to s->target only for areas that we've written to it.
diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index b4d6b7efc3..5149fcf63a 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -146,11 +146,11 @@ cor_co_preadv_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
         local_flags = flags;
 
         /* In case of failure, try to copy-on-read anyway */
-        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
+        ret = bdrv_co_is_allocated(bs->file->bs, offset, bytes, &n);
         if (ret <= 0) {
-            ret = bdrv_is_allocated_above(bdrv_backing_chain_next(bs->file->bs),
-                                          state->bottom_bs, true, offset,
-                                          n, &n);
+            ret = bdrv_co_is_allocated_above(bdrv_backing_chain_next(bs->file->bs),
+                                             state->bottom_bs, true, offset,
+                                             n, &n);
             if (ret > 0 || ret < 0) {
                 local_flags |= BDRV_REQ_COPY_ON_READ;
             }
diff --git a/block/io.c b/block/io.c
index b15a1ea880..9e170929a7 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1223,8 +1223,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             ret = 1; /* "already allocated", so nothing will be copied */
             pnum = MIN(align_bytes, max_transfer);
         } else {
-            ret = bdrv_is_allocated(bs, align_offset,
-                                    MIN(align_bytes, max_transfer), &pnum);
+            ret = bdrv_co_is_allocated(bs, align_offset,
+                                       MIN(align_bytes, max_transfer), &pnum);
             if (ret < 0) {
                 /*
                  * Safe to treat errors in querying allocation as if
@@ -1371,7 +1371,7 @@ bdrv_aligned_preadv(BdrvChild *child, BdrvTrackedRequest *req,
         /* The flag BDRV_REQ_COPY_ON_READ has reached its addressee */
         flags &= ~BDRV_REQ_COPY_ON_READ;
 
-        ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
+        ret = bdrv_co_is_allocated(bs, offset, bytes, &pnum);
         if (ret < 0) {
             goto out;
         }
diff --git a/block/mirror.c b/block/mirror.c
index 3cc0757a03..dcd88de2e3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -559,9 +559,9 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
 
         assert(!(offset % s->granularity));
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_block_status_above(source, NULL, offset,
-                                        nb_chunks * s->granularity,
-                                        &io_bytes, NULL, NULL);
+            ret = bdrv_co_block_status_above(source, NULL, offset,
+                                             nb_chunks * s->granularity,
+                                             &io_bytes, NULL, NULL);
         }
         if (ret < 0) {
             io_bytes = MIN(nb_chunks * s->granularity, max_io_bytes);
@@ -879,8 +879,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
         }
 
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_is_allocated_above(bs, s->base_overlay, true, offset,
-                                          bytes, &count);
+            ret = bdrv_co_is_allocated_above(bs, s->base_overlay, true, offset,
+                                             bytes, &count);
         }
         if (ret < 0) {
             return ret;
diff --git a/block/qcow2.c b/block/qcow2.c
index 5a3c537f14..6e9c731bac 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3991,7 +3991,8 @@ finish:
 }
 
 
-static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
+static bool coroutine_fn GRAPH_RDLOCK
+is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     int64_t nr;
     int res;
@@ -4012,7 +4013,7 @@ static bool is_zero(BlockDriverState *bs, int64_t offset, int64_t bytes)
      * backing file. So, we need a loop.
      */
     do {
-        res = bdrv_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
+        res = bdrv_co_block_status_above(bs, NULL, offset, bytes, &nr, NULL, NULL);
         offset += nr;
         bytes -= nr;
     } while (res >= 0 && (res & BDRV_BLOCK_ZERO) && nr && bytes);
diff --git a/block/replication.c b/block/replication.c
index dd166d2d82..4ad3dd5115 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -276,10 +276,10 @@ replication_co_writev(BlockDriverState *bs, int64_t sector_num,
     while (remaining_sectors > 0) {
         int64_t count;
 
-        ret = bdrv_is_allocated_above(top->bs, base->bs, false,
-                                      sector_num * BDRV_SECTOR_SIZE,
-                                      remaining_sectors * BDRV_SECTOR_SIZE,
-                                      &count);
+        ret = bdrv_co_is_allocated_above(top->bs, base->bs, false,
+                                         sector_num * BDRV_SECTOR_SIZE,
+                                         remaining_sectors * BDRV_SECTOR_SIZE,
+                                         &count);
         if (ret < 0) {
             goto out1;
         }
diff --git a/block/stream.c b/block/stream.c
index 133cb72fb4..ddaab7dbbd 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -172,7 +172,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         copy = false;
 
         WITH_GRAPH_RDLOCK_GUARD() {
-            ret = bdrv_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
+            ret = bdrv_co_is_allocated(unfiltered_bs, offset, STREAM_CHUNK, &n);
             if (ret == 1) {
                 /* Allocated in the top, no need to copy.  */
             } else if (ret >= 0) {
@@ -180,9 +180,9 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
                  * Copy if allocated in the intermediate images.  Limit to the
                  * known-unallocated area [offset, offset+n*BDRV_SECTOR_SIZE).
                  */
-                ret = bdrv_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
-                                            s->base_overlay, true,
-                                            offset, n, &n);
+                ret = bdrv_co_is_allocated_above(bdrv_cow_bs(unfiltered_bs),
+                                                 s->base_overlay, true,
+                                                 offset, n, &n);
                 /* Finish early if end of backing file has been reached */
                 if (ret == 0 && n == 0) {
                     n = len - offset;
diff --git a/block/vvfat.c b/block/vvfat.c
index 856b479c91..1a3a64c713 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -1480,8 +1480,8 @@ vvfat_read(BlockDriverState *bs, int64_t sector_num, uint8_t *buf, int nb_sector
         if (s->qcow) {
             int64_t n;
             int ret;
-            ret = bdrv_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
-                                    (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
+            ret = bdrv_co_is_allocated(s->qcow->bs, sector_num * BDRV_SECTOR_SIZE,
+                                       (nb_sectors - i) * BDRV_SECTOR_SIZE, &n);
             if (ret < 0) {
                 return ret;
             }
@@ -1806,10 +1806,10 @@ cluster_was_modified(BDRVVVFATState *s, uint32_t cluster_num)
     }
 
     for (i = 0; !was_modified && i < s->sectors_per_cluster; i++) {
-        was_modified = bdrv_is_allocated(s->qcow->bs,
-                                         (cluster2sector(s, cluster_num) +
-                                          i) * BDRV_SECTOR_SIZE,
-                                         BDRV_SECTOR_SIZE, NULL);
+        was_modified = bdrv_co_is_allocated(s->qcow->bs,
+                                            (cluster2sector(s, cluster_num) +
+                                             i) * BDRV_SECTOR_SIZE,
+                                            BDRV_SECTOR_SIZE, NULL);
     }
 
     /*
@@ -1967,9 +1967,9 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                 for (i = 0; i < s->sectors_per_cluster; i++) {
                     int res;
 
-                    res = bdrv_is_allocated(s->qcow->bs,
-                                            (offs + i) * BDRV_SECTOR_SIZE,
-                                            BDRV_SECTOR_SIZE, NULL);
+                    res = bdrv_co_is_allocated(s->qcow->bs,
+                                               (offs + i) * BDRV_SECTOR_SIZE,
+                                               BDRV_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
-- 
2.41.0


