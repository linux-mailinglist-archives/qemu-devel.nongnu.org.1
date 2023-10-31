Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3DA7DD66D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:00:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxs-0003xU-QA; Tue, 31 Oct 2023 14:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxq-0003vy-6B
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxX-00066c-Ny
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l3+fT6/ewxPAURhl9QdC6HK90R4WmSt7cUYOYEAyp+c=;
 b=DtXAaTCJX0RUlRt+ygsfRgZTC94+jk87/86WiVA5AbH+YV/I9SVpQWNBy59xOE5KjgzEKR
 fEr4+CwPUYf4s5viwUSlEmvhBxJ3pJRHFgsKAZPnqiRy0JPVDkICNN3bXutwgTaMKV6FOw
 5iF/QXTrrOKsdh/OKe+iTdrfeJ7AUjo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-Qb7YzzI_NpebB80sCSoMLA-1; Tue,
 31 Oct 2023 14:59:25 -0400
X-MC-Unique: Qb7YzzI_NpebB80sCSoMLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B22DF3C025CC;
 Tue, 31 Oct 2023 18:59:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2217B143;
 Tue, 31 Oct 2023 18:59:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/27] qemu-img: rebase: avoid unnecessary COW operations
Date: Tue, 31 Oct 2023 19:58:56 +0100
Message-ID: <20231031185918.346940-6-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
this size equals to the cluster size. so in any case we end up aligning
to the smallest unit of allocation.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Message-ID: <20230919165804.439110-6-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 74 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 20 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a64a664a37..01de77295e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3530,6 +3530,7 @@ static int img_rebase(int argc, char **argv)
     uint8_t *buf_new = NULL;
     BlockDriverState *bs = NULL, *prefix_chain_bs = NULL;
     BlockDriverState *unfiltered_bs;
+    BlockDriverInfo bdi = {0};
     char *filename;
     const char *fmt, *cache, *src_cache, *out_basefmt, *out_baseimg;
     int c, flags, src_flags, ret;
@@ -3540,6 +3541,7 @@ static int img_rebase(int argc, char **argv)
     bool quiet = false;
     Error *local_err = NULL;
     bool image_opts = false;
+    int64_t write_align;
 
     /* Parse commandline parameters */
     fmt = NULL;
@@ -3663,6 +3665,20 @@ static int img_rebase(int argc, char **argv)
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
@@ -3762,7 +3778,7 @@ static int img_rebase(int argc, char **argv)
         int64_t old_backing_size = 0;
         int64_t new_backing_size = 0;
         uint64_t offset;
-        int64_t n;
+        int64_t n, n_old = 0, n_new = 0;
         float local_progress = 0;
 
         if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk_old_backing)) >
@@ -3808,7 +3824,8 @@ static int img_rebase(int argc, char **argv)
         }
 
         for (offset = 0; offset < size; offset += n) {
-            bool buf_old_is_zero = false;
+            bool old_backing_eof = false;
+            int64_t n_alloc;
 
             /* How many bytes can we handle with the next read? */
             n = MIN(IO_BUF_SIZE, size - offset);
@@ -3853,33 +3870,46 @@ static int img_rebase(int argc, char **argv)
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
+             * Much like with the target image, we'll try to read as much
+             * of the old and new backings as we can.
+             */
+            n_old = MIN(n, MAX(0, old_backing_size - (int64_t) offset));
+            n_new = MIN(n, MAX(0, new_backing_size - (int64_t) offset));
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
+            if (n_new) {
+                ret = blk_pread(blk_new_backing, offset, n_new, buf_new, 0);
                 if (ret < 0) {
                     error_report("error while reading from new backing file");
                     goto out;
@@ -3893,11 +3923,12 @@ static int img_rebase(int argc, char **argv)
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
@@ -3909,6 +3940,9 @@ static int img_rebase(int argc, char **argv)
                 }
 
                 written += pnum;
+                if (offset + written >= old_backing_size) {
+                    old_backing_eof = true;
+                }
             }
             qemu_progress_print(local_progress, 100);
         }
-- 
2.41.0


