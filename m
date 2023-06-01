Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E271F2EB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 21:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4nyk-0006nI-Dg; Thu, 01 Jun 2023 15:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyZ-0006ju-6c; Thu, 01 Jun 2023 15:28:48 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1q4nyV-0005mE-TJ; Thu, 01 Jun 2023 15:28:46 -0400
Received: from dev005.ch-qa.vzint.dev ([172.29.1.10])
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <andrey.drobyshev@virtuozzo.com>) id 1q4nyC-00DLDg-12;
 Thu, 01 Jun 2023 21:28:36 +0200
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 andrey.drobyshev@virtuozzo.com, den@virtuozzo.com
Subject: [PATCH 4/6] qemu-img: rebase: avoid unnecessary COW operations
Date: Thu,  1 Jun 2023 22:28:34 +0300
Message-Id: <20230601192836.598602-5-andrey.drobyshev@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=andrey.drobyshev@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
write request is aligned to the overlay cluster size.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 qemu-img.c | 72 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 20 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 60f4c06487..9a469cd609 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3513,6 +3513,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     BlockDriverState *unfiltered_bs;
+    BlockDriverInfo bdi = {0};
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3646,6 +3647,15 @@ static int img_rebase(int argc, char **argv)
         }
     }
 
+    /* We need overlay cluster size to make sure write requests are aligned */
+    ret = bdrv_get_info(unfiltered_bs, &bdi);
+    if (ret < 0) {
+        error_report("could not get block driver info");
+        goto out;
+    } else if (bdi.cluster_size == 0) {
+        bdi.cluster_size = 1;
+    }
+
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
         QDict *options = NULL;
@@ -3744,6 +3754,7 @@ static int img_rebase(int argc, char **argv)
         int64_t new_backing_size = 0;
         uint64_t offset;
         int64_t n;
+        int64_t n_old = 0, n_new = 0;
         float local_progress = 0;
 
         buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
@@ -3784,7 +3795,7 @@ static int img_rebase(int argc, char **argv)
         }
 
         for (offset = 0; offset < size; offset += n) {
-            bool buf_old_is_zero = false;
+            bool old_backing_eof = false;
 
             /* How many bytes can we handle with the next read? */
             n = MIN(IO_BUF_SIZE, size - offset);
@@ -3829,33 +3840,38 @@ static int img_rebase(int argc, char **argv)
                 }
             }
 
+            /* At this point n must be aligned to the target cluster size. */
+            if (offset + n < size) {
+                assert(n % bdi.cluster_size == 0);
+            }
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
@@ -3867,15 +3883,28 @@ static int img_rebase(int argc, char **argv)
 
             while (written < n) {
                 int64_t pnum;
+                int64_t start, end;
 
                 if (compare_buffers(buf_old + written, buf_new + written,
                                     n - written, &pnum))
                 {
-                    if (buf_old_is_zero) {
+                    if (old_backing_eof) {
                         ret = blk_pwrite_zeroes(blk, offset + written, pnum, 0);
                     } else {
-                        ret = blk_pwrite(blk, offset + written, pnum,
-                                         buf_old + written, 0);
+                        /*
+                         * If we've got to this point, it means the cluster
+                         * we're dealing with is unallocated, and any partial
+                         * write will cause COW.  To avoid that, we make sure
+                         * request is aligned to cluster size.
+                         */
+                        start = QEMU_ALIGN_DOWN(offset + written,
+                                                bdi.cluster_size);
+                        end = QEMU_ALIGN_UP(offset + written + pnum,
+                                            bdi.cluster_size);
+                        end = end > size ? size : end;
+                        ret = blk_pwrite(blk, start, end - start,
+                                         buf_old + (start - offset), 0);
+                        pnum = end - (offset + written);
                     }
                     if (ret < 0) {
                         error_report("Error while writing to COW image: %s",
@@ -3885,6 +3914,9 @@ static int img_rebase(int argc, char **argv)
                 }
 
                 written += pnum;
+                if (offset + written >= old_backing_size) {
+                    old_backing_eof = true;
+                }
             }
             qemu_progress_print(local_progress, 100);
         }
-- 
2.31.1


