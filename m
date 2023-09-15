Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B52C7A2379
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:22:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBYc-0005Ku-Pt; Fri, 15 Sep 2023 12:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYT-0005Em-HP; Fri, 15 Sep 2023 12:20:31 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhBYN-0000Rx-4F; Fri, 15 Sep 2023 12:20:28 -0400
Received: from [130.117.225.1] (helo=dev005.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1qhBUx-00Ezdu-1N;
 Fri, 15 Sep 2023 18:20:15 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH v2 5/8] qemu-img: rebase: avoid unnecessary COW operations
Date: Fri, 15 Sep 2023 19:20:13 +0300
Message-Id: <20230915162016.141771-6-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
From:  Andrey Drobyshev via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

When rebasing an image from one backing file to another, we need to
compare data from old and new backings.  If the diff between that data
happens to be unaligned to the target cluster size, we might end up
doing partial writes, which would lead to copy-on-write and additional IO.

Consider the following simple case (virtual_size == cluster_size == 64K):

base <-- inc1 <-- inc2

qemu-io -c "write -P 0xaa 0 32K" base.qcow2
qemu-io -c "write -P 0xcc 32K 32K" base.qcow2
qemu-io -c "write -P 0xbb 0 32K" inc1.qcow2
qemu-io -c "write -P 0xcc 32K 32K" inc1.qcow2
qemu-img rebase -f qcow2 -b base.qcow2 -F qcow2 inc2.qcow2

While doing rebase, we'll write a half of the cluster to inc2, and block
layer will have to read the 2nd half of the same cluster from the base image
inc1 while doing this write operation, although the whole cluster is already
read earlier to perform data comparison.

In order to avoid these unnecessary IO cycles, let's make sure every
write request is aligned to the overlay subcluster boundaries.  Using
subcluster size is universal as for the images which don't have them
this size equals to the cluster size, so in any case we end up aligning
to the smallest unit of allocation.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-img.c | 76 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index fcd31d7b5b..83950af42b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3523,6 +3523,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     BlockDriverState *unfiltered_bs;
+    BlockDriverInfo bdi = {0};
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3533,6 +3534,7 @@ static int img_rebase(int argc, char **argv)
     bool quiet = false;
     Error *local_err = NULL;
     bool image_opts = false;
+    int64_t write_align;
 
     /* Parse commandline parameters */
     fmt = NULL;
@@ -3656,6 +3658,20 @@ static int img_rebase(int argc, char **argv)
         }
     }
 
+    /*
+     * We need overlay subcluster size to make sure write requests are
+     * aligned.
+     */
+    ret = bdrv_get_info(unfiltered_bs, &bdi);
+    if (ret < 0) {
+        error_report("could not get block driver info");
+        goto out;
+    } else if (bdi.subcluster_size == 0) {
+        bdi.subcluster_size = 1;
+    }
+
+    write_align = bdi.subcluster_size;
+
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
@@ -3753,7 +3769,7 @@ static int img_rebase(int argc, char **argv)
         int64_t old_backing_size = 0;
         int64_t new_backing_size = 0;
         uint64_t offset;
-        int64_t n;
+        int64_t n, n_old = 0, n_new = 0;
         float local_progress = 0;
 
         if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
@@ -3799,7 +3815,8 @@ static int img_rebase(int argc, char **argv)
         }
 
         for (offset = 0; offset < size; offset += n) {
-            bool buf_old_is_zero = false;
+            bool old_backing_eof = false;
+            int64_t n_alloc;
 
             /* How many bytes can we handle with the next read? */
             n = MIN(IO_BUF_SIZE, size - offset);
@@ -3844,33 +3861,48 @@ static int img_rebase(int argc, char **argv)
                 }
             }
 
+            /*
+             * At this point we know that the region [offset; offset + n)
+             * is unallocated within the target image.  This region might be
+             * unaligned to the target image's (sub)cluster boundaries, as
+             * old backing may have smaller clusters (or have subclusters).
+             * We extend it to the aligned boundaries to avoid CoW on
+             * partial writes in blk_pwrite(),
+             */
+            n += offset - QEMU_ALIGN_DOWN(offset, write_align);
+            offset = QEMU_ALIGN_DOWN(offset, write_align);
+            n += QEMU_ALIGN_UP(offset + n, write_align) - (offset + n);
+            n = MIN(n, size - offset);
+            assert(!bdrv_is_allocated(unfiltered_bs, offset, n, &n_alloc) &&
+                   n_alloc == n);
+
+            /*
+             * Much like the with the target image, we'll try to read as much
+             * of the old and new backings as we can.
+             */
+            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
+            if (blk_new_backing) {
+                n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
+            }
+
             /*
              * Read old and new backing file and take into consideration that
              * backing files may be smaller than the COW image.
              */
-            if (offset >= old_backing_size) {
-                memset(buf_old, 0, n);
-                buf_old_is_zero = true;
+            memset(buf_old + n_old, 0, n - n_old);
+            if (!n_old) {
+                old_backing_eof = true;
             } else {
-                if (offset + n > old_backing_size) {
-                    n = old_backing_size - offset;
-                }
-
-                ret = blk_pread(blk_old_backing, offset, n, buf_old, 0);
+                ret = blk_pread(blk_old_backing, offset, n_old, buf_old, 0);
                 if (ret < 0) {
                     error_report("error while reading from old backing file");
                     goto out;
                 }
             }
 
-            if (offset >= new_backing_size || !blk_new_backing) {
-                memset(buf_new, 0, n);
-            } else {
-                if (offset + n > new_backing_size) {
-                    n = new_backing_size - offset;
-                }
-
-                ret = blk_pread(blk_new_backing, offset, n, buf_new, 0);
+            memset(buf_new + n_new, 0, n - n_new);
+            if (blk_new_backing && n_new) {
+                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
                 if (ret < 0) {
                     error_report("error while reading from new backing file");
                     goto out;
@@ -3884,11 +3916,12 @@ static int img_rebase(int argc, char **argv)
                 int64_t pnum;
 
                 if (compare_buffers(buf_old + written, buf_new + written,
-                                    n - written, 0, &pnum))
+                                    n - written, write_align, &pnum))
                 {
-                    if (buf_old_is_zero) {
+                    if (old_backing_eof) {
                         ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
                     } else {
+                        assert(written + pnum <= IO_BUF_SIZE);
                         ret = blk_pwrite(blk, offset + written, pnum,
                                          buf_old + written, 0);
                     }
@@ -3900,6 +3933,9 @@ static int img_rebase(int argc, char **argv)
                 }
 
                 written += pnum;
+                if (offset + written >= old_backing_size) {
+                    old_backing_eof = true;
+                }
             }
             qemu_progress_print(local_progress, 100);
         }
-- 
2.39.3


