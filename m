Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FB978CB24
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:23:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2Qk-0007jj-Oz; Tue, 29 Aug 2023 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb2PT-0006tq-U2
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb2PQ-0000r5-6t
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693329703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7BekLkQHdNl+nON36AsTjo2RLArJ5w0AroGSMvtVbtI=;
 b=iUhvrVB/cpGmW9KtnVLqJ+KvQIiOBp4haJFC0Kk6/a9pGZ9Jsf2ZwRYofonbTpIFX7fj9z
 JpvXZf/VXCoiTPyT0W5GOfhD/55CwZFabjW2fjJ4Ybaa3vg8ZOvOHE3HUp9xbSITc1wc63
 QlzMfW3wloxW8sa2o5PtuNLxDAhIVTs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-r9RFhvfQNrCUReQXDNPPoQ-1; Tue, 29 Aug 2023 13:21:41 -0400
X-MC-Unique: r9RFhvfQNrCUReQXDNPPoQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55283805BFB;
 Tue, 29 Aug 2023 17:21:41 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A91D6140E963;
 Tue, 29 Aug 2023 17:21:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Eric Blake <eblake@redhat.com>, "Denis V . Lunev" <den@openvz.org>
Subject: [PULL v2 7/8] block/io: align requests to subcluster_size
Date: Tue, 29 Aug 2023 13:21:21 -0400
Message-ID: <20230829172122.303592-8-stefanha@redhat.com>
In-Reply-To: <20230829172122.303592-1-stefanha@redhat.com>
References: <20230829172122.303592-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

When target image is using subclusters, and we align the request during
copy-on-read, it makes sense to align to subcluster_size rather than
cluster_size.  Otherwise we end up with unnecessary allocations.

This commit renames bdrv_round_to_clusters() to bdrv_round_to_subclusters()
and utilizes subcluster_size field of BlockDriverInfo to make necessary
alignments.  It affects copy-on-read as well as mirror job (which is
using bdrv_round_to_clusters()).

This change also fixes the following bug with failing assert (covered by
the test in the subsequent commit):

qemu-img create -f qcow2 base.qcow2 64K
qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
qemu-io -c "write -P 0xaa 0 2K" img.qcow2
qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2

qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230711172553.234055-3-andrey.drobyshev@virtuozzo.com>
---
 include/block/block-io.h |  8 +++----
 block/io.c               | 50 ++++++++++++++++++++--------------------
 block/mirror.c           |  8 +++----
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/include/block/block-io.h b/include/block/block-io.h
index 4415506e40..6db48f2d35 100644
--- a/include/block/block-io.h
+++ b/include/block/block-io.h
@@ -189,10 +189,10 @@ bdrv_get_info(BlockDriverState *bs, BlockDriverInfo *bdi);
 ImageInfoSpecific *bdrv_get_specific_info(BlockDriverState *bs,
                                           Error **errp);
 BlockStatsSpecific *bdrv_get_specific_stats(BlockDriverState *bs);
-void bdrv_round_to_clusters(BlockDriverState *bs,
-                            int64_t offset, int64_t bytes,
-                            int64_t *cluster_offset,
-                            int64_t *cluster_bytes);
+void bdrv_round_to_subclusters(BlockDriverState *bs,
+                               int64_t offset, int64_t bytes,
+                               int64_t *cluster_offset,
+                               int64_t *cluster_bytes);
 
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
diff --git a/block/io.c b/block/io.c
index 055fcf7438..76e7df18d8 100644
--- a/block/io.c
+++ b/block/io.c
@@ -728,21 +728,21 @@ BdrvTrackedRequest *coroutine_fn bdrv_co_get_self_request(BlockDriverState *bs)
 }
 
 /**
- * Round a region to cluster boundaries
+ * Round a region to subcluster (if supported) or cluster boundaries
  */
 void coroutine_fn GRAPH_RDLOCK
-bdrv_round_to_clusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
-                       int64_t *cluster_offset, int64_t *cluster_bytes)
+bdrv_round_to_subclusters(BlockDriverState *bs, int64_t offset, int64_t bytes,
+                          int64_t *align_offset, int64_t *align_bytes)
 {
     BlockDriverInfo bdi;
     IO_CODE();
-    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.cluster_size == 0) {
-        *cluster_offset = offset;
-        *cluster_bytes = bytes;
+    if (bdrv_co_get_info(bs, &bdi) < 0 || bdi.subcluster_size == 0) {
+        *align_offset = offset;
+        *align_bytes = bytes;
     } else {
-        int64_t c = bdi.cluster_size;
-        *cluster_offset = QEMU_ALIGN_DOWN(offset, c);
-        *cluster_bytes = QEMU_ALIGN_UP(offset - *cluster_offset + bytes, c);
+        int64_t c = bdi.subcluster_size;
+        *align_offset = QEMU_ALIGN_DOWN(offset, c);
+        *align_bytes = QEMU_ALIGN_UP(offset - *align_offset + bytes, c);
     }
 }
 
@@ -1168,8 +1168,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
     void *bounce_buffer = NULL;
 
     BlockDriver *drv = bs->drv;
-    int64_t cluster_offset;
-    int64_t cluster_bytes;
+    int64_t align_offset;
+    int64_t align_bytes;
     int64_t skip_bytes;
     int ret;
     int max_transfer = MIN_NON_ZERO(bs->bl.max_transfer,
@@ -1203,28 +1203,28 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
      * BDRV_REQUEST_MAX_BYTES (even when the original read did not), which
      * is one reason we loop rather than doing it all at once.
      */
-    bdrv_round_to_clusters(bs, offset, bytes, &cluster_offset, &cluster_bytes);
-    skip_bytes = offset - cluster_offset;
+    bdrv_round_to_subclusters(bs, offset, bytes, &align_offset, &align_bytes);
+    skip_bytes = offset - align_offset;
 
     trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
-                                   cluster_offset, cluster_bytes);
+                                   align_offset, align_bytes);
 
-    while (cluster_bytes) {
+    while (align_bytes) {
         int64_t pnum;
 
         if (skip_write) {
             ret = 1; /* "already allocated", so nothing will be copied */
-            pnum = MIN(cluster_bytes, max_transfer);
+            pnum = MIN(align_bytes, max_transfer);
         } else {
-            ret = bdrv_is_allocated(bs, cluster_offset,
-                                    MIN(cluster_bytes, max_transfer), &pnum);
+            ret = bdrv_is_allocated(bs, align_offset,
+                                    MIN(align_bytes, max_transfer), &pnum);
             if (ret < 0) {
                 /*
                  * Safe to treat errors in querying allocation as if
                  * unallocated; we'll probably fail again soon on the
                  * read, but at least that will set a decent errno.
                  */
-                pnum = MIN(cluster_bytes, max_transfer);
+                pnum = MIN(align_bytes, max_transfer);
             }
 
             /* Stop at EOF if the image ends in the middle of the cluster */
@@ -1242,7 +1242,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             /* Must copy-on-read; use the bounce buffer */
             pnum = MIN(pnum, MAX_BOUNCE_BUFFER);
             if (!bounce_buffer) {
-                int64_t max_we_need = MAX(pnum, cluster_bytes - pnum);
+                int64_t max_we_need = MAX(pnum, align_bytes - pnum);
                 int64_t max_allowed = MIN(max_transfer, MAX_BOUNCE_BUFFER);
                 int64_t bounce_buffer_len = MIN(max_we_need, max_allowed);
 
@@ -1254,7 +1254,7 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             }
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
-            ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
+            ret = bdrv_driver_preadv(bs, align_offset, pnum,
                                      &local_qiov, 0, 0);
             if (ret < 0) {
                 goto err;
@@ -1266,13 +1266,13 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
                 /* FIXME: Should we (perhaps conditionally) be setting
                  * BDRV_REQ_MAY_UNMAP, if it will allow for a sparser copy
                  * that still correctly reads as zero? */
-                ret = bdrv_co_do_pwrite_zeroes(bs, cluster_offset, pnum,
+                ret = bdrv_co_do_pwrite_zeroes(bs, align_offset, pnum,
                                                BDRV_REQ_WRITE_UNCHANGED);
             } else {
                 /* This does not change the data on the disk, it is not
                  * necessary to flush even in cache=writethrough mode.
                  */
-                ret = bdrv_driver_pwritev(bs, cluster_offset, pnum,
+                ret = bdrv_driver_pwritev(bs, align_offset, pnum,
                                           &local_qiov, 0,
                                           BDRV_REQ_WRITE_UNCHANGED);
             }
@@ -1301,8 +1301,8 @@ bdrv_co_do_copy_on_readv(BdrvChild *child, int64_t offset, int64_t bytes,
             }
         }
 
-        cluster_offset += pnum;
-        cluster_bytes -= pnum;
+        align_offset += pnum;
+        align_bytes -= pnum;
         progress += pnum - skip_bytes;
         skip_bytes = 0;
     }
diff --git a/block/mirror.c b/block/mirror.c
index d3cacd1708..e213a892db 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -283,8 +283,8 @@ static int coroutine_fn mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
     need_cow |= !test_bit((*offset + *bytes - 1) / s->granularity,
                           s->cow_bitmap);
     if (need_cow) {
-        bdrv_round_to_clusters(blk_bs(s->target), *offset, *bytes,
-                               &align_offset, &align_bytes);
+        bdrv_round_to_subclusters(blk_bs(s->target), *offset, *bytes,
+                                  &align_offset, &align_bytes);
     }
 
     if (align_bytes > max_bytes) {
@@ -576,8 +576,8 @@ static void coroutine_fn mirror_iteration(MirrorBlockJob *s)
             int64_t target_offset;
             int64_t target_bytes;
             WITH_GRAPH_RDLOCK_GUARD() {
-                bdrv_round_to_clusters(blk_bs(s->target), offset, io_bytes,
-                                       &target_offset, &target_bytes);
+                bdrv_round_to_subclusters(blk_bs(s->target), offset, io_bytes,
+                                          &target_offset, &target_bytes);
             }
             if (target_offset == offset &&
                 target_bytes == io_bytes) {
-- 
2.41.0


