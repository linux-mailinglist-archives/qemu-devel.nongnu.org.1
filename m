Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A79722BCA
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:47:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CP6-0007lP-I1; Mon, 05 Jun 2023 11:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP3-0007jR-37
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q6CP0-0001I0-Oe
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685979949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9IdGHYywvBoHrKHd/prbEpTXxdeXSE8arL8UjZXsMM=;
 b=efFpAWUq93MckUKC0Z759MfDwIVc543xQrnEFJ9Rg8CoMqXi2OyEwI49ndnogDZTtWmcni
 If69hY/7eLr3RUM2NSTxOjDsQNIhTnSJ6HCQlzh8RiC7W3tCywGRa/YDsz128WOO0mSwyQ
 GqEWElsPM0r/TCTZeaBckw1rvBMubsI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-i3X0gkECMPe-5YC_EWk2ow-1; Mon, 05 Jun 2023 11:45:47 -0400
X-MC-Unique: i3X0gkECMPe-5YC_EWk2ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED2932A5956A;
 Mon,  5 Jun 2023 15:45:46 +0000 (UTC)
Received: from localhost (unknown [10.39.194.13])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91D9C140E958;
 Mon,  5 Jun 2023 15:45:46 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 02/17] block: Collapse padded I/O vecs exceeding IOV_MAX
Date: Mon,  5 Jun 2023 17:45:26 +0200
Message-Id: <20230605154541.1043261-3-hreitz@redhat.com>
In-Reply-To: <20230605154541.1043261-1-hreitz@redhat.com>
References: <20230605154541.1043261-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When processing vectored guest requests that are not aligned to the
storage request alignment, we pad them by adding head and/or tail
buffers for a read-modify-write cycle.

The guest can submit I/O vectors up to IOV_MAX (1024) in length, but
with this padding, the vector can exceed that limit.  As of
4c002cef0e9abe7135d7916c51abce47f7fc1ee2 ("util/iov: make
qemu_iovec_init_extended() honest"), we refuse to pad vectors beyond the
limit, instead returning an error to the guest.

To the guest, this appears as a random I/O error.  We should not return
an I/O error to the guest when it issued a perfectly valid request.

Before 4c002cef0e9abe7135d7916c51abce47f7fc1ee2, we just made the vector
longer than IOV_MAX, which generally seems to work (because the guest
assumes a smaller alignment than we really have, file-posix's
raw_co_prw() will generally see bdrv_qiov_is_aligned() return false, and
so emulate the request, so that the IOV_MAX does not matter).  However,
that does not seem exactly great.

I see two ways to fix this problem:
1. We split such long requests into two requests.
2. We join some elements of the vector into new buffers to make it
   shorter.

I am wary of (1), because it seems like it may have unintended side
effects.

(2) on the other hand seems relatively simple to implement, with
hopefully few side effects, so this patch does that.

To do this, the use of qemu_iovec_init_extended() in bdrv_pad_request()
is effectively replaced by the new function bdrv_create_padded_qiov(),
which not only wraps the request IOV with padding head/tail, but also
ensures that the resulting vector will not have more than IOV_MAX
elements.  Putting that functionality into qemu_iovec_init_extended() is
infeasible because it requires allocating a bounce buffer; doing so
would require many more parameters (buffer alignment, how to initialize
the buffer, and out parameters like the buffer, its length, and the
original elements), which is not reasonable.

Conversely, it is not difficult to move qemu_iovec_init_extended()'s
functionality into bdrv_create_padded_qiov() by using public
qemu_iovec_* functions, so that is what this patch does.

Because bdrv_pad_request() was the only "serious" user of
qemu_iovec_init_extended(), the next patch will remove the latter
function, so the functionality is not implemented twice.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2141964
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20230411173418.19549-3-hreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/io.c | 166 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 151 insertions(+), 15 deletions(-)

diff --git a/block/io.c b/block/io.c
index f2dfc7c405..30748f0b59 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1441,6 +1441,14 @@ out:
  * @merge_reads is true for small requests,
  * if @buf_len == @head + bytes + @tail. In this case it is possible that both
  * head and tail exist but @buf_len == align and @tail_buf == @buf.
+ *
+ * @write is true for write requests, false for read requests.
+ *
+ * If padding makes the vector too long (exceeding IOV_MAX), then we need to
+ * merge existing vector elements into a single one.  @collapse_bounce_buf acts
+ * as the bounce buffer in such cases.  @pre_collapse_qiov has the pre-collapse
+ * I/O vector elements so for read requests, the data can be copied back after
+ * the read is done.
  */
 typedef struct BdrvRequestPadding {
     uint8_t *buf;
@@ -1449,11 +1457,17 @@ typedef struct BdrvRequestPadding {
     size_t head;
     size_t tail;
     bool merge_reads;
+    bool write;
     QEMUIOVector local_qiov;
+
+    uint8_t *collapse_bounce_buf;
+    size_t collapse_len;
+    QEMUIOVector pre_collapse_qiov;
 } BdrvRequestPadding;
 
 static bool bdrv_init_padding(BlockDriverState *bs,
                               int64_t offset, int64_t bytes,
+                              bool write,
                               BdrvRequestPadding *pad)
 {
     int64_t align = bs->bl.request_alignment;
@@ -1485,6 +1499,8 @@ static bool bdrv_init_padding(BlockDriverState *bs,
         pad->tail_buf = pad->buf + pad->buf_len - align;
     }
 
+    pad->write = write;
+
     return true;
 }
 
@@ -1549,8 +1565,23 @@ zero_mem:
     return 0;
 }
 
-static void bdrv_padding_destroy(BdrvRequestPadding *pad)
+/**
+ * Free *pad's associated buffers, and perform any necessary finalization steps.
+ */
+static void bdrv_padding_finalize(BdrvRequestPadding *pad)
 {
+    if (pad->collapse_bounce_buf) {
+        if (!pad->write) {
+            /*
+             * If padding required elements in the vector to be collapsed into a
+             * bounce buffer, copy the bounce buffer content back
+             */
+            qemu_iovec_from_buf(&pad->pre_collapse_qiov, 0,
+                                pad->collapse_bounce_buf, pad->collapse_len);
+        }
+        qemu_vfree(pad->collapse_bounce_buf);
+        qemu_iovec_destroy(&pad->pre_collapse_qiov);
+    }
     if (pad->buf) {
         qemu_vfree(pad->buf);
         qemu_iovec_destroy(&pad->local_qiov);
@@ -1558,6 +1589,101 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
     memset(pad, 0, sizeof(*pad));
 }
 
+/*
+ * Create pad->local_qiov by wrapping @iov in the padding head and tail, while
+ * ensuring that the resulting vector will not exceed IOV_MAX elements.
+ *
+ * To ensure this, when necessary, the first two or three elements of @iov are
+ * merged into pad->collapse_bounce_buf and replaced by a reference to that
+ * bounce buffer in pad->local_qiov.
+ *
+ * After performing a read request, the data from the bounce buffer must be
+ * copied back into pad->pre_collapse_qiov (e.g. by bdrv_padding_finalize()).
+ */
+static int bdrv_create_padded_qiov(BlockDriverState *bs,
+                                   BdrvRequestPadding *pad,
+                                   struct iovec *iov, int niov,
+                                   size_t iov_offset, size_t bytes)
+{
+    int padded_niov, surplus_count, collapse_count;
+
+    /* Assert this invariant */
+    assert(niov <= IOV_MAX);
+
+    /*
+     * Cannot pad if resulting length would exceed SIZE_MAX.  Returning an error
+     * to the guest is not ideal, but there is little else we can do.  At least
+     * this will practically never happen on 64-bit systems.
+     */
+    if (SIZE_MAX - pad->head < bytes ||
+        SIZE_MAX - pad->head - bytes < pad->tail)
+    {
+        return -EINVAL;
+    }
+
+    /* Length of the resulting IOV if we just concatenated everything */
+    padded_niov = !!pad->head + niov + !!pad->tail;
+
+    qemu_iovec_init(&pad->local_qiov, MIN(padded_niov, IOV_MAX));
+
+    if (pad->head) {
+        qemu_iovec_add(&pad->local_qiov, pad->buf, pad->head);
+    }
+
+    /*
+     * If padded_niov > IOV_MAX, we cannot just concatenate everything.
+     * Instead, merge the first two or three elements of @iov to reduce the
+     * number of vector elements as necessary.
+     */
+    if (padded_niov > IOV_MAX) {
+        /*
+         * Only head and tail can have lead to the number of entries exceeding
+         * IOV_MAX, so we can exceed it by the head and tail at most.  We need
+         * to reduce the number of elements by `surplus_count`, so we merge that
+         * many elements plus one into one element.
+         */
+        surplus_count = padded_niov - IOV_MAX;
+        assert(surplus_count <= !!pad->head + !!pad->tail);
+        collapse_count = surplus_count + 1;
+
+        /*
+         * Move the elements to collapse into `pad->pre_collapse_qiov`, then
+         * advance `iov` (and associated variables) by those elements.
+         */
+        qemu_iovec_init(&pad->pre_collapse_qiov, collapse_count);
+        qemu_iovec_concat_iov(&pad->pre_collapse_qiov, iov,
+                              collapse_count, iov_offset, SIZE_MAX);
+        iov += collapse_count;
+        iov_offset = 0;
+        niov -= collapse_count;
+        bytes -= pad->pre_collapse_qiov.size;
+
+        /*
+         * Construct the bounce buffer to match the length of the to-collapse
+         * vector elements, and for write requests, initialize it with the data
+         * from those elements.  Then add it to `pad->local_qiov`.
+         */
+        pad->collapse_len = pad->pre_collapse_qiov.size;
+        pad->collapse_bounce_buf = qemu_blockalign(bs, pad->collapse_len);
+        if (pad->write) {
+            qemu_iovec_to_buf(&pad->pre_collapse_qiov, 0,
+                              pad->collapse_bounce_buf, pad->collapse_len);
+        }
+        qemu_iovec_add(&pad->local_qiov,
+                       pad->collapse_bounce_buf, pad->collapse_len);
+    }
+
+    qemu_iovec_concat_iov(&pad->local_qiov, iov, niov, iov_offset, bytes);
+
+    if (pad->tail) {
+        qemu_iovec_add(&pad->local_qiov,
+                       pad->buf + pad->buf_len - pad->tail, pad->tail);
+    }
+
+    assert(pad->local_qiov.niov == MIN(padded_niov, IOV_MAX));
+    return 0;
+}
+
 /*
  * bdrv_pad_request
  *
@@ -1565,6 +1691,8 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
  * read of padding, bdrv_padding_rmw_read() should be called separately if
  * needed.
  *
+ * @write is true for write requests, false for read requests.
+ *
  * Request parameters (@qiov, &qiov_offset, &offset, &bytes) are in-out:
  *  - on function start they represent original request
  *  - on failure or when padding is not needed they are unchanged
@@ -1573,26 +1701,34 @@ static void bdrv_padding_destroy(BdrvRequestPadding *pad)
 static int bdrv_pad_request(BlockDriverState *bs,
                             QEMUIOVector **qiov, size_t *qiov_offset,
                             int64_t *offset, int64_t *bytes,
+                            bool write,
                             BdrvRequestPadding *pad, bool *padded,
                             BdrvRequestFlags *flags)
 {
     int ret;
+    struct iovec *sliced_iov;
+    int sliced_niov;
+    size_t sliced_head, sliced_tail;
 
     bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error_abort);
 
-    if (!bdrv_init_padding(bs, *offset, *bytes, pad)) {
+    if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
         if (padded) {
             *padded = false;
         }
         return 0;
     }
 
-    ret = qemu_iovec_init_extended(&pad->local_qiov, pad->buf, pad->head,
-                                   *qiov, *qiov_offset, *bytes,
-                                   pad->buf + pad->buf_len - pad->tail,
-                                   pad->tail);
+    sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
+                                  &sliced_head, &sliced_tail,
+                                  &sliced_niov);
+
+    /* Guaranteed by bdrv_check_qiov_request() */
+    assert(*bytes <= SIZE_MAX);
+    ret = bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
+                                  sliced_head, *bytes);
     if (ret < 0) {
-        bdrv_padding_destroy(pad);
+        bdrv_padding_finalize(pad);
         return ret;
     }
     *bytes += pad->head + pad->tail;
@@ -1659,8 +1795,8 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
         flags |= BDRV_REQ_COPY_ON_READ;
     }
 
-    ret = bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad,
-                           NULL, &flags);
+    ret = bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, false,
+                           &pad, NULL, &flags);
     if (ret < 0) {
         goto fail;
     }
@@ -1670,7 +1806,7 @@ int coroutine_fn bdrv_co_preadv_part(BdrvChild *child,
                               bs->bl.request_alignment,
                               qiov, qiov_offset, flags);
     tracked_request_end(&req);
-    bdrv_padding_destroy(&pad);
+    bdrv_padding_finalize(&pad);
 
 fail:
     bdrv_dec_in_flight(bs);
@@ -2002,7 +2138,7 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
     /* This flag doesn't make sense for padding or zero writes */
     flags &= ~BDRV_REQ_REGISTERED_BUF;
 
-    padding = bdrv_init_padding(bs, offset, bytes, &pad);
+    padding = bdrv_init_padding(bs, offset, bytes, true, &pad);
     if (padding) {
         assert(!(flags & BDRV_REQ_NO_WAIT));
         bdrv_make_request_serialising(req, align);
@@ -2050,7 +2186,7 @@ bdrv_co_do_zero_pwritev(BdrvChild *child, int64_t offset, int64_t bytes,
     }
 
 out:
-    bdrv_padding_destroy(&pad);
+    bdrv_padding_finalize(&pad);
 
     return ret;
 }
@@ -2118,8 +2254,8 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
          * bdrv_co_do_zero_pwritev() does aligning by itself, so, we do
          * alignment only if there is no ZERO flag.
          */
-        ret = bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, &pad,
-                               &padded, &flags);
+        ret = bdrv_pad_request(bs, &qiov, &qiov_offset, &offset, &bytes, true,
+                               &pad, &padded, &flags);
         if (ret < 0) {
             return ret;
         }
@@ -2149,7 +2285,7 @@ int coroutine_fn bdrv_co_pwritev_part(BdrvChild *child,
     ret = bdrv_aligned_pwritev(child, &req, offset, bytes, align,
                                qiov, qiov_offset, flags);
 
-    bdrv_padding_destroy(&pad);
+    bdrv_padding_finalize(&pad);
 
 out:
     tracked_request_end(&req);
-- 
2.40.1


