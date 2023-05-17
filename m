Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E57706EC1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:53:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNI-00040O-PY; Wed, 17 May 2023 12:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNG-0003yc-EQ
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKND-0001QU-BT
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j89rRWHLEF5CD6pklWntVXwdDuYUd1+NGlsXOv3pBNA=;
 b=RHK2lES4mIFuw9/70JZ0TwHLdgJQWYzrP7R7jq3wFnloiz71kbJ0pzit4nKutwLjx+veX9
 /wyZZIkTHtLOk6bxOQC98U+2UIFe+ctgrdydzXxNkWZ1TdfgfOEW2BsdovM85RSg3MOGrr
 b+jeFV89t8wFhzN3u+KmruCSSBHBfZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-Vt8hDlv6NNar8RPvx3K6sA-1; Wed, 17 May 2023 12:51:31 -0400
X-MC-Unique: Vt8hDlv6NNar8RPvx3K6sA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4723B85A5B1;
 Wed, 17 May 2023 16:51:31 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8EDFE40C6EC4;
 Wed, 17 May 2023 16:51:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 08/18] block: Call .bdrv_co_create(_opts) unlocked
Date: Wed, 17 May 2023 18:51:06 +0200
Message-Id: <20230517165116.475123-9-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

These are functions that modify the graph, so they must be able to take
a writer lock. This is impossible if they already hold the reader lock.
If they need a reader lock for some of their operations, they should
take it internally.

Many of them go through blk_*(), which will always take the lock itself.
Direct calls of bdrv_*() need to take the reader lock. Note that while
locking for bdrv_co_*() calls is checked by TSA, this is not the case
for the mixed_coroutine_fns bdrv_*(). Holding the lock is still required
when they are called from coroutine context like here!

This effectively reverts 4ec8df0183, but adds some internal locking
instead.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510203601.418015-2-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  8 +++----
 include/block/block_int-common.h   |  4 ++--
 block.c                            |  1 -
 block/create.c                     |  1 -
 block/crypto.c                     | 25 ++++++++++----------
 block/parallels.c                  |  6 ++---
 block/qcow.c                       |  6 ++---
 block/qcow2.c                      | 37 +++++++++++++++++++-----------
 block/qed.c                        |  6 ++---
 block/raw-format.c                 |  2 +-
 block/vdi.c                        | 11 +++++----
 block/vhdx.c                       |  8 ++++---
 block/vmdk.c                       | 27 ++++++++++------------
 block/vpc.c                        |  6 ++---
 14 files changed, 78 insertions(+), 70 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 2d93423d35..f347199bff 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -58,14 +58,14 @@ BlockDriver *bdrv_find_protocol(const char *filename,
                                 Error **errp);
 BlockDriver *bdrv_find_format(const char *format_name);
 
-int coroutine_fn GRAPH_RDLOCK
+int coroutine_fn GRAPH_UNLOCKED
 bdrv_co_create(BlockDriver *drv, const char *filename, QemuOpts *opts,
                Error **errp);
 
-int co_wrapper_bdrv_rdlock bdrv_create(BlockDriver *drv, const char *filename,
-                                       QemuOpts *opts, Error **errp);
+int co_wrapper bdrv_create(BlockDriver *drv, const char *filename,
+                           QemuOpts *opts, Error **errp);
 
-int coroutine_fn GRAPH_RDLOCK
+int coroutine_fn GRAPH_UNLOCKED
 bdrv_co_create_file(const char *filename, QemuOpts *opts, Error **errp);
 
 BlockDriverState *bdrv_new(void);
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index dbec0e3bb4..6492a1e538 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -250,10 +250,10 @@ struct BlockDriver {
         BlockDriverState *bs, QDict *options, int flags, Error **errp);
     void (*bdrv_close)(BlockDriverState *bs);
 
-    int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_create)(
+    int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create)(
         BlockdevCreateOptions *opts, Error **errp);
 
-    int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_create_opts)(
+    int coroutine_fn GRAPH_UNLOCKED_PTR (*bdrv_co_create_opts)(
         BlockDriver *drv, const char *filename, QemuOpts *opts, Error **errp);
 
     int (*bdrv_amend_options)(BlockDriverState *bs,
diff --git a/block.c b/block.c
index f04a6ad4e8..a2f8d5a0c0 100644
--- a/block.c
+++ b/block.c
@@ -533,7 +533,6 @@ int coroutine_fn bdrv_co_create(BlockDriver *drv, const char *filename,
     int ret;
     GLOBAL_STATE_CODE();
     ERRP_GUARD();
-    assert_bdrv_graph_readable();
 
     if (!drv->bdrv_co_create_opts) {
         error_setg(errp, "Driver '%s' does not support image creation",
diff --git a/block/create.c b/block/create.c
index bf67b9947c..6b23a21675 100644
--- a/block/create.c
+++ b/block/create.c
@@ -43,7 +43,6 @@ static int coroutine_fn blockdev_create_run(Job *job, Error **errp)
     int ret;
 
     GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD();
 
     job_progress_set_remaining(&s->common, 1);
     ret = s->drv->bdrv_co_create(s->opts, errp);
diff --git a/block/crypto.c b/block/crypto.c
index 30093cff9b..6ee8d46d30 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -99,12 +99,10 @@ struct BlockCryptoCreateData {
 };
 
 
-static int block_crypto_create_write_func(QCryptoBlock *block,
-                                          size_t offset,
-                                          const uint8_t *buf,
-                                          size_t buflen,
-                                          void *opaque,
-                                          Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+block_crypto_create_write_func(QCryptoBlock *block, size_t offset,
+                               const uint8_t *buf, size_t buflen, void *opaque,
+                               Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
     ssize_t ret;
@@ -117,10 +115,9 @@ static int block_crypto_create_write_func(QCryptoBlock *block,
     return 0;
 }
 
-static int block_crypto_create_init_func(QCryptoBlock *block,
-                                         size_t headerlen,
-                                         void *opaque,
-                                         Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+block_crypto_create_init_func(QCryptoBlock *block, size_t headerlen,
+                              void *opaque, Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
     Error *local_error = NULL;
@@ -314,7 +311,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 }
 
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_generic(BlockDriverState *bs, int64_t size,
                                QCryptoBlockCreateOptions *opts,
                                PreallocMode prealloc, Error **errp)
@@ -627,7 +624,7 @@ static int block_crypto_open_luks(BlockDriverState *bs,
                                      bs, options, flags, errp);
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_luks(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsLUKS *luks_opts;
@@ -665,7 +662,7 @@ fail:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 block_crypto_co_create_opts_luks(BlockDriver *drv, const char *filename,
                                  QemuOpts *opts, Error **errp)
 {
@@ -727,7 +724,9 @@ fail:
      * beforehand, it has been truncated and corrupted in the process.
      */
     if (ret) {
+        bdrv_graph_co_rdlock();
         bdrv_co_delete_file_noerr(bs);
+        bdrv_graph_co_rdunlock();
     }
 
     bdrv_co_unref(bs);
diff --git a/block/parallels.c b/block/parallels.c
index b49c35929e..d8a3f13e24 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -522,8 +522,8 @@ out:
 }
 
 
-static int coroutine_fn parallels_co_create(BlockdevCreateOptions* opts,
-                                            Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+parallels_co_create(BlockdevCreateOptions* opts, Error **errp)
 {
     BlockdevCreateOptionsParallels *parallels_opts;
     BlockDriverState *bs;
@@ -622,7 +622,7 @@ exit:
     goto out;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 parallels_co_create_opts(BlockDriver *drv, const char *filename,
                          QemuOpts *opts, Error **errp)
 {
diff --git a/block/qcow.c b/block/qcow.c
index a0c701f578..3644bbf5cb 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -800,8 +800,8 @@ static void qcow_close(BlockDriverState *bs)
     error_free(s->migration_blocker);
 }
 
-static int coroutine_fn qcow_co_create(BlockdevCreateOptions *opts,
-                                       Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+qcow_co_create(BlockdevCreateOptions *opts, Error **errp)
 {
     BlockdevCreateOptionsQcow *qcow_opts;
     int header_size, backing_filename_len, l1_size, shift, i;
@@ -921,7 +921,7 @@ exit:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 qcow_co_create_opts(BlockDriver *drv, const char *filename,
                     QemuOpts *opts, Error **errp)
 {
diff --git a/block/qcow2.c b/block/qcow2.c
index 5bde3b8401..73f36447f9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -118,8 +118,9 @@ static int qcow2_crypto_hdr_read_func(QCryptoBlock *block, size_t offset,
 }
 
 
-static int qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
-                                      void *opaque, Error **errp)
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen, void *opaque,
+                           Error **errp)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
@@ -144,9 +145,7 @@ static int qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
      */
     clusterlen = size_to_clusters(s, headerlen) * s->cluster_size;
     assert(qcow2_pre_write_overlap_check(bs, 0, ret, clusterlen, false) == 0);
-    ret = bdrv_pwrite_zeroes(bs->file,
-                             ret,
-                             clusterlen, 0);
+    ret = bdrv_co_pwrite_zeroes(bs->file, ret, clusterlen, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not zero fill encryption header");
         return -1;
@@ -156,9 +155,11 @@ static int qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
 }
 
 
-static int qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
-                                       const uint8_t *buf, size_t buflen,
-                                       void *opaque, Error **errp)
+/* The graph lock must be held when called in coroutine context */
+static int coroutine_mixed_fn
+qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
+                            const uint8_t *buf, size_t buflen,
+                            void *opaque, Error **errp)
 {
     BlockDriverState *bs = opaque;
     BDRVQcow2State *s = bs->opaque;
@@ -3137,9 +3138,10 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
-static int qcow2_set_up_encryption(BlockDriverState *bs,
-                                   QCryptoBlockCreateOptions *cryptoopts,
-                                   Error **errp)
+static int coroutine_fn GRAPH_RDLOCK
+qcow2_set_up_encryption(BlockDriverState *bs,
+                        QCryptoBlockCreateOptions *cryptoopts,
+                        Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QCryptoBlock *crypto = NULL;
@@ -3426,7 +3428,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int coroutine_fn
+static int coroutine_fn GRAPH_UNLOCKED
 qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
@@ -3724,8 +3726,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
         goto out;
     }
 
+    bdrv_graph_co_rdlock();
     ret = qcow2_alloc_clusters(blk_bs(blk), 3 * cluster_size);
     if (ret < 0) {
+        bdrv_graph_co_rdunlock();
         error_setg_errno(errp, -ret, "Could not allocate clusters for qcow2 "
                          "header and refcount table");
         goto out;
@@ -3743,6 +3747,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
+    bdrv_graph_co_rdunlock();
+
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not update qcow2 header");
         goto out;
@@ -3776,7 +3782,10 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 
     /* Want encryption? There you go. */
     if (qcow2_opts->encrypt) {
+        bdrv_graph_co_rdlock();
         ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
+        bdrv_graph_co_rdunlock();
+
         if (ret < 0) {
             goto out;
         }
@@ -3813,7 +3822,7 @@ out:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
                      Error **errp)
 {
@@ -3933,8 +3942,10 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
     ret = qcow2_co_create(create_options, errp);
 finish:
     if (ret < 0) {
+        bdrv_graph_co_rdlock();
         bdrv_co_delete_file_noerr(bs);
         bdrv_co_delete_file_noerr(data_bs);
+        bdrv_graph_co_rdunlock();
     } else {
         ret = 0;
     }
diff --git a/block/qed.c b/block/qed.c
index be9ff0fb34..9a0350b534 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -630,8 +630,8 @@ static void bdrv_qed_close(BlockDriverState *bs)
     qemu_vfree(s->l1_table);
 }
 
-static int coroutine_fn bdrv_qed_co_create(BlockdevCreateOptions *opts,
-                                           Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+bdrv_qed_co_create(BlockdevCreateOptions *opts, Error **errp)
 {
     BlockdevCreateOptionsQed *qed_opts;
     BlockBackend *blk = NULL;
@@ -751,7 +751,7 @@ out:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 bdrv_qed_co_create_opts(BlockDriver *drv, const char *filename,
                         QemuOpts *opts, Error **errp)
 {
diff --git a/block/raw-format.c b/block/raw-format.c
index 3a3946213f..918fe4fb7e 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -457,7 +457,7 @@ static int raw_has_zero_init(BlockDriverState *bs)
     return bdrv_has_zero_init(bs->file->bs);
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 raw_co_create_opts(BlockDriver *drv, const char *filename,
                    QemuOpts *opts, Error **errp)
 {
diff --git a/block/vdi.c b/block/vdi.c
index 08331d2dd7..6c35309e04 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -734,8 +734,9 @@ nonallocating_write:
     return ret;
 }
 
-static int coroutine_fn vdi_co_do_create(BlockdevCreateOptions *create_options,
-                                         size_t block_size, Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+vdi_co_do_create(BlockdevCreateOptions *create_options, size_t block_size,
+                 Error **errp)
 {
     BlockdevCreateOptionsVdi *vdi_opts;
     int ret = 0;
@@ -892,13 +893,13 @@ exit:
     return ret;
 }
 
-static int coroutine_fn vdi_co_create(BlockdevCreateOptions *create_options,
-                                      Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+vdi_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
     return vdi_co_do_create(create_options, DEFAULT_CLUSTER_SIZE, errp);
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vdi_co_create_opts(BlockDriver *drv, const char *filename,
                    QemuOpts *opts, Error **errp)
 {
diff --git a/block/vhdx.c b/block/vhdx.c
index b20b1edf11..89913cba87 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1506,7 +1506,7 @@ exit:
  * There are 2 headers, and the highest sequence number will represent
  * the active header
  */
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vhdx_create_new_headers(BlockBackend *blk, uint64_t image_size,
                         uint32_t log_size)
 {
@@ -1515,6 +1515,8 @@ vhdx_create_new_headers(BlockBackend *blk, uint64_t image_size,
     int ret = 0;
     VHDXHeader *hdr = NULL;
 
+    GRAPH_RDLOCK_GUARD();
+
     hdr = g_new0(VHDXHeader, 1);
 
     hdr->signature       = VHDX_HEADER_SIGNATURE;
@@ -1898,7 +1900,7 @@ exit:
  *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ -----------.
  *   1MB
  */
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vhdx_co_create(BlockdevCreateOptions *opts, Error **errp)
 {
     BlockdevCreateOptionsVhdx *vhdx_opts;
@@ -2060,7 +2062,7 @@ delete_and_exit:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vhdx_co_create_opts(BlockDriver *drv, const char *filename,
                     QemuOpts *opts, Error **errp)
 {
diff --git a/block/vmdk.c b/block/vmdk.c
index fddbd1c86c..e3e86608ec 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2165,10 +2165,9 @@ vmdk_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
     return ret;
 }
 
-static int vmdk_init_extent(BlockBackend *blk,
-                            int64_t filesize, bool flat,
-                            bool compress, bool zeroed_grain,
-                            Error **errp)
+static int GRAPH_UNLOCKED
+vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
+                 bool zeroed_grain, Error **errp)
 {
     int ret, i;
     VMDK4Header header;
@@ -2277,7 +2276,7 @@ exit:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vmdk_create_extent(const char *filename, int64_t filesize, bool flat,
                    bool compress, bool zeroed_grain, BlockBackend **pbb,
                    QemuOpts *opts, Error **errp)
@@ -2358,7 +2357,7 @@ static int filename_decompose(const char *filename, char *path, char *prefix,
  *           non-split format.
  * idx >= 1: get the n-th extent if in a split subformat
  */
-typedef BlockBackend * coroutine_fn /* GRAPH_RDLOCK */
+typedef BlockBackend * coroutine_fn GRAPH_UNLOCKED_PTR
     (*vmdk_create_extent_fn)(int64_t size, int idx, bool flat, bool split,
                              bool compress, bool zeroed_grain, void *opaque,
                              Error **errp);
@@ -2374,7 +2373,7 @@ static void vmdk_desc_add_extent(GString *desc,
     g_free(basename);
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vmdk_co_do_create(int64_t size,
                   BlockdevVmdkSubformat subformat,
                   BlockdevVmdkAdapterType adapter_type,
@@ -2605,7 +2604,7 @@ typedef struct {
     QemuOpts *opts;
 } VMDKCreateOptsData;
 
-static BlockBackend * coroutine_fn GRAPH_RDLOCK
+static BlockBackend * coroutine_fn GRAPH_UNLOCKED
 vmdk_co_create_opts_cb(int64_t size, int idx, bool flat, bool split,
                        bool compress, bool zeroed_grain, void *opaque,
                        Error **errp)
@@ -2647,7 +2646,7 @@ exit:
     return blk;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vmdk_co_create_opts(BlockDriver *drv, const char *filename,
                     QemuOpts *opts, Error **errp)
 {
@@ -2756,11 +2755,9 @@ exit:
     return ret;
 }
 
-static BlockBackend * coroutine_fn vmdk_co_create_cb(int64_t size, int idx,
-                                                     bool flat, bool split,
-                                                     bool compress,
-                                                     bool zeroed_grain,
-                                                     void *opaque, Error **errp)
+static BlockBackend * coroutine_fn GRAPH_UNLOCKED
+vmdk_co_create_cb(int64_t size, int idx, bool flat, bool split, bool compress,
+                  bool zeroed_grain, void *opaque, Error **errp)
 {
     int ret;
     BlockDriverState *bs;
@@ -2809,7 +2806,7 @@ static BlockBackend * coroutine_fn vmdk_co_create_cb(int64_t size, int idx,
     return blk;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vmdk_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsVmdk *opts;
diff --git a/block/vpc.c b/block/vpc.c
index 07ddda5b99..7ee7c7b4e0 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -967,8 +967,8 @@ static int calculate_rounded_image_size(BlockdevCreateOptionsVpc *vpc_opts,
     return 0;
 }
 
-static int coroutine_fn vpc_co_create(BlockdevCreateOptions *opts,
-                                      Error **errp)
+static int coroutine_fn GRAPH_UNLOCKED
+vpc_co_create(BlockdevCreateOptions *opts, Error **errp)
 {
     BlockdevCreateOptionsVpc *vpc_opts;
     BlockBackend *blk = NULL;
@@ -1087,7 +1087,7 @@ out:
     return ret;
 }
 
-static int coroutine_fn GRAPH_RDLOCK
+static int coroutine_fn GRAPH_UNLOCKED
 vpc_co_create_opts(BlockDriver *drv, const char *filename,
                    QemuOpts *opts, Error **errp)
 {
-- 
2.40.1


