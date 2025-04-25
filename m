Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48622A9BC0A
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Apr 2025 02:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u87Le-0006ww-O6; Thu, 24 Apr 2025 20:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87Lb-0006ol-Nx
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u87LZ-0000mY-I5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 20:55:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745542516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcDH9p6H/EPFu5ldQahTqYObeHljv+DZrkONSWOsJw0=;
 b=L7WvsKV5apRWtyHZ96BUn7ND67GWRZmVKf1mdrcWeVdToIj+nRuIN9JVZO5qC1udkHt/C6
 pfwDeCI7TM/n3N5iyjp0Pb/zG8V23N232f01Jyatig9FeObLIvGi0+bJ/bIFnqawfFRjBF
 9CrMUzRNyQIdEfNRukhZrZsjwZD9m2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-805JznhsMg-ZAXJt96Cn_A-1; Thu,
 24 Apr 2025 20:55:14 -0400
X-MC-Unique: 805JznhsMg-ZAXJt96Cn_A-1
X-Mimecast-MFC-AGG-ID: 805JznhsMg-ZAXJt96Cn_A_1745542513
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5272180036E; Fri, 25 Apr 2025 00:55:13 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.59])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 113081800374; Fri, 25 Apr 2025 00:55:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru, stefanha@redhat.com,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 08/11] mirror: Skip writing zeroes when target is already
 zero
Date: Thu, 24 Apr 2025 19:52:08 -0500
Message-ID: <20250425005439.2252467-21-eblake@redhat.com>
In-Reply-To: <20250425005439.2252467-13-eblake@redhat.com>
References: <20250425005439.2252467-13-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.84,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When mirroring, the goal is to ensure that the destination reads the
same as the source; this goal is met whether the destination is sparse
or fully-allocated.  However, if the destination cannot efficiently
write zeroes, then any time the mirror operation wants to copy zeroes
from the source to the destination (either during the background over
sparse regions when doing a full mirror, or in the foreground when the
guest actively writes zeroes), we were causing the destination to
fully allocate that portion of the disk, even if it already read as
zeroes.

The effect is especially pronounced when the source is a raw file.
That's because when the source is a qcow2 file, the dirty bitmap only
visits the portions of the source that are allocated, which tend to be
non-zero.  But when the source is a raw file,
bdrv_co_is_allocated_above() reports the entire file as allocated so
mirror_dirty_init sets the entire dirty bitmap, and it is only later
during mirror_iteration that we change to consulting the more precise
bdrv_co_block_status_above() to learn where the source reads as zero.

Remember that since a mirror operation can write a cluster more than
once (every time the guest changes the source, the destination is also
changed to keep up), we can't take the shortcut of relying on
s->zero_target (which is static for the life of the job) in
mirror_co_zero() to see if the destination is already zero, because
that information may be stale.  Any solution we use must be dynamic in
the face of the guest writing or discarding a cluster while the mirror
has been ongoing.

We could just teach mirror_co_zero() to do a block_status() probe of
the destination, and skip the zeroes if the destination already reads
as zero, but we know from past experience that extra block_status()
calls are not always cheap (tmpfs, anyone?), especially when they are
random access rather than linear.  Use of block_status() of the source
by the background task in a linear fashion is not our bottleneck (it's
a background task, after all); but since mirroring can be done while
the source is actively being changed, we don't want a slow
block_status() of the destination to occur on the hot path of the
guest trying to do random-access writes to the source.

So this patch takes a slightly different approach: any time we have to
transfer the full image, we know that mirror_dirty_init() is _already_
doing a pre-zero pass over the entire destination.  Therefore, if we
track which clusters of the destination are zero at any given moment,
we don't have to do a block_status() call on the destination, but can
instead just refer to the zero bitmap associated with the job.

With this patch, if I create a raw sparse destination file, connect it
with QMP 'blockdev-add' while leaving it at the default "discard":
"ignore", then run QMP 'blockdev-mirror' with "sync": "full", the
destination remains sparse rather than fully allocated.  Meanwhile, a
destination image that is already fully allocated remains so unless it
was opened with "detect-zeroes": "unmap".  If writing zeroes is
skipped, the job counters are not incremented.

Signed-off-by: Eric Blake <eblake@redhat.com>

---

v3: also skip counters when skipping I/O [Sunny]
---
 block/mirror.c | 92 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 11 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 4059bf96854..69a02dfc2b7 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -73,6 +73,7 @@ typedef struct MirrorBlockJob {
     size_t buf_size;
     int64_t bdev_length;
     unsigned long *cow_bitmap;
+    unsigned long *zero_bitmap;
     BdrvDirtyBitmap *dirty_bitmap;
     BdrvDirtyBitmapIter *dbi;
     uint8_t *buf;
@@ -108,9 +109,12 @@ struct MirrorOp {
     int64_t offset;
     uint64_t bytes;

-    /* The pointee is set by mirror_co_read(), mirror_co_zero(), and
-     * mirror_co_discard() before yielding for the first time */
+    /*
+     * These pointers are set by mirror_co_read(), mirror_co_zero(), and
+     * mirror_co_discard() before yielding for the first time
+     */
     int64_t *bytes_handled;
+    bool *io_skipped;

     bool is_pseudo_op;
     bool is_active_write;
@@ -408,15 +412,34 @@ static void coroutine_fn mirror_co_read(void *opaque)
 static void coroutine_fn mirror_co_zero(void *opaque)
 {
     MirrorOp *op = opaque;
-    int ret;
+    bool write_needed = true;
+    int ret = 0;

     op->s->in_flight++;
     op->s->bytes_in_flight += op->bytes;
     *op->bytes_handled = op->bytes;
     op->is_in_flight = true;

-    ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
-                               op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
+    if (op->s->zero_bitmap) {
+        unsigned long end = DIV_ROUND_UP(op->offset + op->bytes,
+                                         op->s->granularity);
+        assert(QEMU_IS_ALIGNED(op->offset, op->s->granularity));
+        assert(QEMU_IS_ALIGNED(op->bytes, op->s->granularity) ||
+               op->offset + op->bytes == op->s->bdev_length);
+        if (find_next_zero_bit(op->s->zero_bitmap, end,
+                               op->offset / op->s->granularity) == end) {
+            write_needed = false;
+            *op->io_skipped = true;
+        }
+    }
+    if (write_needed) {
+        ret = blk_co_pwrite_zeroes(op->s->target, op->offset, op->bytes,
+                                   op->s->unmap ? BDRV_REQ_MAY_UNMAP : 0);
+    }
+    if (ret >= 0 && op->s->zero_bitmap) {
+        bitmap_set(op->s->zero_bitmap, op->offset / op->s->granularity,
+                   DIV_ROUND_UP(op->bytes, op->s->granularity));
+    }
     mirror_write_complete(op, ret);
 }

@@ -435,29 +458,43 @@ static void coroutine_fn mirror_co_discard(void *opaque)
 }

 static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
-                               unsigned bytes, MirrorMethod mirror_method)
+                               unsigned bytes, MirrorMethod mirror_method,
+                               bool *io_skipped)
 {
     MirrorOp *op;
     Coroutine *co;
     int64_t bytes_handled = -1;

+    assert(QEMU_IS_ALIGNED(offset, s->granularity));
+    assert(QEMU_IS_ALIGNED(bytes, s->granularity) ||
+           offset + bytes == s->bdev_length);
     op = g_new(MirrorOp, 1);
     *op = (MirrorOp){
         .s              = s,
         .offset         = offset,
         .bytes          = bytes,
         .bytes_handled  = &bytes_handled,
+        .io_skipped     = io_skipped,
     };
     qemu_co_queue_init(&op->waiting_requests);

     switch (mirror_method) {
     case MIRROR_METHOD_COPY:
+        if (s->zero_bitmap) {
+            bitmap_clear(s->zero_bitmap, offset / s->granularity,
+                         DIV_ROUND_UP(bytes, s->granularity));
+        }
         co = qemu_coroutine_create(mirror_co_read, op);
         break;
     case MIRROR_METHOD_ZERO:
+        /* s->zero_bitmap handled in mirror_co_zero */
         co = qemu_coroutine_create(mirror_co_zero, op);
         break;
     case MIRROR_METHOD_DISCARD:
+        if (s->zero_bitmap) {
+            bitmap_clear(s->zero_bitmap, offset / s->granularity,
+                         DIV_ROUND_UP(bytes, s->granularity));
+        }
         co = qemu_coroutine_create(mirror_co_discard, op);
         break;
     default:
@@ -568,6 +605,7 @@ static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
         int ret = -1;
         int64_t io_bytes;
         int64_t io_bytes_acct;
+        bool io_skipped = false;
         MirrorMethod mirror_method = MIRROR_METHOD_COPY;

         assert(!(offset % s->granularity));
@@ -611,8 +649,10 @@ static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
         }

         io_bytes = mirror_clip_bytes(s, offset, io_bytes);
-        io_bytes = mirror_perform(s, offset, io_bytes, mirror_method);
-        if (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok) {
+        io_bytes = mirror_perform(s, offset, io_bytes, mirror_method,
+                                  &io_skipped);
+        if (io_skipped ||
+            (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok)) {
             io_bytes_acct = 0;
         } else {
             io_bytes_acct = io_bytes;
@@ -849,6 +889,8 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     bdrv_graph_co_rdunlock();

     if (s->zero_target) {
+        int64_t bitmap_length = DIV_ROUND_UP(s->bdev_length, s->granularity);
+
         offset = 0;
         bdrv_graph_co_rdlock();
         ret = bdrv_co_is_all_zeroes(target_bs);
@@ -856,6 +898,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
         if (ret < 0) {
             return ret;
         }
+        s->zero_bitmap = bitmap_new(bitmap_length);
         /*
          * If the destination already reads as zero, and we are not
          * requested to punch holes into existing zeroes, then we can
@@ -864,6 +907,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
         if (ret > 0 &&
             (target_bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_UNMAP ||
              !bdrv_can_write_zeroes_with_unmap(target_bs))) {
+            bitmap_set(s->zero_bitmap, 0, bitmap_length);
             offset = s->bdev_length;
         }
         if (!bdrv_can_write_zeroes_with_unmap(target_bs)) {
@@ -875,6 +919,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
         while (offset < s->bdev_length) {
             int bytes = MIN(s->bdev_length - offset,
                             QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
+            bool ignored;

             mirror_throttle(s);

@@ -890,7 +935,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }

-            mirror_perform(s, offset, bytes, MIRROR_METHOD_ZERO);
+            mirror_perform(s, offset, bytes, MIRROR_METHOD_ZERO, &ignored);
             offset += bytes;
         }

@@ -1180,6 +1225,7 @@ immediate_exit:
     assert(s->in_flight == 0);
     qemu_vfree(s->buf);
     g_free(s->cow_bitmap);
+    g_free(s->zero_bitmap);
     g_free(s->in_flight_bitmap);
     bdrv_dirty_iter_free(s->dbi);

@@ -1359,6 +1405,7 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
     int ret;
     size_t qiov_offset = 0;
     int64_t dirty_bitmap_offset, dirty_bitmap_end;
+    int64_t zero_bitmap_offset, zero_bitmap_end;

     if (!QEMU_IS_ALIGNED(offset, job->granularity) &&
         bdrv_dirty_bitmap_get(job->dirty_bitmap, offset))
@@ -1402,8 +1449,9 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
     }

     /*
-     * Tails are either clean or shrunk, so for bitmap resetting
-     * we safely align the range down.
+     * Tails are either clean or shrunk, so for dirty bitmap resetting
+     * we safely align the range narrower.  But for zero bitmap, round
+     * range wider for checking or clearing, and narrower for setting.
      */
     dirty_bitmap_offset = QEMU_ALIGN_UP(offset, job->granularity);
     dirty_bitmap_end = QEMU_ALIGN_DOWN(offset + bytes, job->granularity);
@@ -1411,22 +1459,44 @@ do_sync_target_write(MirrorBlockJob *job, MirrorMethod method,
         bdrv_reset_dirty_bitmap(job->dirty_bitmap, dirty_bitmap_offset,
                                 dirty_bitmap_end - dirty_bitmap_offset);
     }
+    zero_bitmap_offset = offset / job->granularity;
+    zero_bitmap_end = DIV_ROUND_UP(offset + bytes, job->granularity);

     job_progress_increase_remaining(&job->common.job, bytes);
     job->active_write_bytes_in_flight += bytes;

     switch (method) {
     case MIRROR_METHOD_COPY:
+        if (job->zero_bitmap) {
+            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
+                         zero_bitmap_end - zero_bitmap_offset);
+        }
         ret = blk_co_pwritev_part(job->target, offset, bytes,
                                   qiov, qiov_offset, flags);
         break;

     case MIRROR_METHOD_ZERO:
+        if (job->zero_bitmap) {
+            if (find_next_zero_bit(job->zero_bitmap, zero_bitmap_end,
+                                   zero_bitmap_offset) == zero_bitmap_end) {
+                ret = 0;
+                break;
+            }
+        }
         assert(!qiov);
         ret = blk_co_pwrite_zeroes(job->target, offset, bytes, flags);
+        if (job->zero_bitmap && ret >= 0) {
+            bitmap_set(job->zero_bitmap, dirty_bitmap_offset / job->granularity,
+                       (dirty_bitmap_end - dirty_bitmap_offset) /
+                       job->granularity);
+        }
         break;

     case MIRROR_METHOD_DISCARD:
+        if (job->zero_bitmap) {
+            bitmap_clear(job->zero_bitmap, zero_bitmap_offset,
+                         zero_bitmap_end - zero_bitmap_offset);
+        }
         assert(!qiov);
         ret = blk_co_pdiscard(job->target, offset, bytes);
         break;
-- 
2.49.0


