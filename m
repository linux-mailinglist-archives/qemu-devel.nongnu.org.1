Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BD97A06D3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:03:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmur-00080h-RR; Thu, 14 Sep 2023 10:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmuc-0007yZ-Bo
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmuV-00019T-LP
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700084;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MAOhD67sgYXgN63nbkZvtAVWc6L847RzatreqXJJcKg=;
 b=OtvgMg+a2oGF0N8ViVWKlunD/vS5Yj4A3eBBtQDIX4YDtFo68Bw+M2++0hyxjpUFYuZwla
 oxobt6Bjn8UzvV+WQUbLxwf1tRWC4nsURKbJJHGCNfd322jdPqCyTZkqsPsvCUoiOREN1E
 SBrtXVUIvhIWozRR38A7SPFIqd8uKhQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-369-GnC-y2r4MJKOnvasmPRETg-1; Thu, 14 Sep 2023 10:01:20 -0400
X-MC-Unique: GnC-y2r4MJKOnvasmPRETg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34EA8857A9A;
 Thu, 14 Sep 2023 14:01:05 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD54E1054FC2;
 Thu, 14 Sep 2023 14:01:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/4] block/file-posix: set up Linux AIO and io_uring in the
 current thread
Date: Thu, 14 Sep 2023 10:00:58 -0400
Message-ID: <20230914140101.1065008-2-stefanha@redhat.com>
In-Reply-To: <20230914140101.1065008-1-stefanha@redhat.com>
References: <20230914140101.1065008-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The file-posix block driver currently only sets up Linux AIO and
io_uring in the BDS's AioContext. In the multi-queue block layer we must
be able to submit I/O requests in AioContexts that do not have Linux AIO
and io_uring set up yet since any thread can call into the block driver.

Set up Linux AIO and io_uring for the current AioContext during request
submission. We lose the ability to return an error from
.bdrv_file_open() when Linux AIO and io_uring setup fails (e.g. due to
resource limits). Instead the user only gets warnings and we fall back
to aio=threads. This is still better than a fatal error after startup.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/file-posix.c | 99 ++++++++++++++++++++++------------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 4757914ac0..e9dbb87c57 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -713,17 +713,11 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
 
 #ifdef CONFIG_LINUX_AIO
      /* Currently Linux does AIO only for files opened with O_DIRECT */
-    if (s->use_linux_aio) {
-        if (!(s->open_flags & O_DIRECT)) {
-            error_setg(errp, "aio=native was specified, but it requires "
-                             "cache.direct=on, which was not specified.");
-            ret = -EINVAL;
-            goto fail;
-        }
-        if (!aio_setup_linux_aio(bdrv_get_aio_context(bs), errp)) {
-            error_prepend(errp, "Unable to use native AIO: ");
-            goto fail;
-        }
+    if (s->use_linux_aio && !(s->open_flags & O_DIRECT)) {
+        error_setg(errp, "aio=native was specified, but it requires "
+                         "cache.direct=on, which was not specified.");
+        ret = -EINVAL;
+        goto fail;
     }
 #else
     if (s->use_linux_aio) {
@@ -734,14 +728,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
     }
 #endif /* !defined(CONFIG_LINUX_AIO) */
 
-#ifdef CONFIG_LINUX_IO_URING
-    if (s->use_linux_io_uring) {
-        if (!aio_setup_linux_io_uring(bdrv_get_aio_context(bs), errp)) {
-            error_prepend(errp, "Unable to use io_uring: ");
-            goto fail;
-        }
-    }
-#else
+#ifndef CONFIG_LINUX_IO_URING
     if (s->use_linux_io_uring) {
         error_setg(errp, "aio=io_uring was specified, but is not supported "
                          "in this build.");
@@ -2442,6 +2429,44 @@ static bool bdrv_qiov_is_aligned(BlockDriverState *bs, QEMUIOVector *qiov)
     return true;
 }
 
+static inline bool raw_check_linux_io_uring(BDRVRawState *s)
+{
+    Error *local_err = NULL;
+    AioContext *ctx;
+
+    if (!s->use_linux_io_uring) {
+        return false;
+    }
+
+    ctx = qemu_get_current_aio_context();
+    if (unlikely(!aio_setup_linux_io_uring(ctx, &local_err))) {
+        error_reportf_err(local_err, "Unable to use linux io_uring, "
+                                     "falling back to thread pool: ");
+        s->use_linux_io_uring = false;
+        return false;
+    }
+    return true;
+}
+
+static inline bool raw_check_linux_aio(BDRVRawState *s)
+{
+    Error *local_err = NULL;
+    AioContext *ctx;
+
+    if (!s->use_linux_aio) {
+        return false;
+    }
+
+    ctx = qemu_get_current_aio_context();
+    if (unlikely(!aio_setup_linux_aio(ctx, &local_err))) {
+        error_reportf_err(local_err, "Unable to use Linux AIO, "
+                                     "falling back to thread pool: ");
+        s->use_linux_aio = false;
+        return false;
+    }
+    return true;
+}
+
 static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
                                    uint64_t bytes, QEMUIOVector *qiov, int type)
 {
@@ -2470,13 +2495,13 @@ static int coroutine_fn raw_co_prw(BlockDriverState *bs, uint64_t offset,
     if (s->needs_alignment && !bdrv_qiov_is_aligned(bs, qiov)) {
         type |= QEMU_AIO_MISALIGNED;
 #ifdef CONFIG_LINUX_IO_URING
-    } else if (s->use_linux_io_uring) {
+    } else if (raw_check_linux_io_uring(s)) {
         assert(qiov->size == bytes);
         ret = luring_co_submit(bs, s->fd, offset, qiov, type);
         goto out;
 #endif
 #ifdef CONFIG_LINUX_AIO
-    } else if (s->use_linux_aio) {
+    } else if (raw_check_linux_aio(s)) {
         assert(qiov->size == bytes);
         ret = laio_co_submit(s->fd, offset, qiov, type,
                               s->aio_max_batch);
@@ -2566,39 +2591,13 @@ static int coroutine_fn raw_co_flush_to_disk(BlockDriverState *bs)
     };
 
 #ifdef CONFIG_LINUX_IO_URING
-    if (s->use_linux_io_uring) {
+    if (raw_check_linux_io_uring(s)) {
         return luring_co_submit(bs, s->fd, 0, NULL, QEMU_AIO_FLUSH);
     }
 #endif
     return raw_thread_pool_submit(handle_aiocb_flush, &acb);
 }
 
-static void raw_aio_attach_aio_context(BlockDriverState *bs,
-                                       AioContext *new_context)
-{
-    BDRVRawState __attribute__((unused)) *s = bs->opaque;
-#ifdef CONFIG_LINUX_AIO
-    if (s->use_linux_aio) {
-        Error *local_err = NULL;
-        if (!aio_setup_linux_aio(new_context, &local_err)) {
-            error_reportf_err(local_err, "Unable to use native AIO, "
-                                         "falling back to thread pool: ");
-            s->use_linux_aio = false;
-        }
-    }
-#endif
-#ifdef CONFIG_LINUX_IO_URING
-    if (s->use_linux_io_uring) {
-        Error *local_err = NULL;
-        if (!aio_setup_linux_io_uring(new_context, &local_err)) {
-            error_reportf_err(local_err, "Unable to use linux io_uring, "
-                                         "falling back to thread pool: ");
-            s->use_linux_io_uring = false;
-        }
-    }
-#endif
-}
-
 static void raw_close(BlockDriverState *bs)
 {
     BDRVRawState *s = bs->opaque;
@@ -3897,7 +3896,6 @@ BlockDriver bdrv_file = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
-    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
@@ -4267,7 +4265,6 @@ static BlockDriver bdrv_host_device = {
     .bdrv_co_copy_range_from = raw_co_copy_range_from,
     .bdrv_co_copy_range_to  = raw_co_copy_range_to,
     .bdrv_refresh_limits = raw_refresh_limits,
-    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
@@ -4403,7 +4400,6 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits    = cdrom_refresh_limits,
-    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
@@ -4529,7 +4525,6 @@ static BlockDriver bdrv_host_cdrom = {
     .bdrv_co_pwritev        = raw_co_pwritev,
     .bdrv_co_flush_to_disk  = raw_co_flush_to_disk,
     .bdrv_refresh_limits    = cdrom_refresh_limits,
-    .bdrv_attach_aio_context = raw_aio_attach_aio_context,
 
     .bdrv_co_truncate                   = raw_co_truncate,
     .bdrv_co_getlength                  = raw_co_getlength,
-- 
2.41.0


