Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE677E489A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:47:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R6B-0004N0-3v; Tue, 07 Nov 2023 13:46:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5r-00045d-RP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5o-0001XI-Rv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT14BSQd1gW1kW2hRnWi57CSh+BfdQ7NnNQ/i3wEQmc=;
 b=Myal/J+/uCjvVvtbZTUZpkKaa/TYhGz78MEO+6ojYNAKDi5fYNPvARiGm/4jhAOcqnLdQc
 OvET1ki/vqIw/uUb1LoDVUU9H1JyyP53a5epRLJq+eHUaqno2Sc2gcdT9qFdyy+YCUZ6zR
 1+F/Ii7No/5oUHj+gQMyCCYctpZFXZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-MNSIhuw4NReLM3sE3venVA-1; Tue, 07 Nov 2023 13:46:26 -0500
X-MC-Unique: MNSIhuw4NReLM3sE3venVA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9BE0185A789
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 342B6C12911;
 Tue,  7 Nov 2023 18:46:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 24/25] block: Protect bs->file with graph_lock
Date: Tue,  7 Nov 2023 19:46:04 +0100
Message-ID: <20231107184605.236540-25-kwolf@redhat.com>
In-Reply-To: <20231107184605.236540-1-kwolf@redhat.com>
References: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Almost all functions that access bs->file already take the graph
lock now. Add locking to the remaining users and finally annotate the
struct field itself as protected by the graph lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231027155333.420094-25-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/parallels.h                |  5 +++--
 block/qed.h                      |  2 +-
 include/block/block_int-common.h |  2 +-
 block.c                          | 11 ++++++++---
 block/blkreplay.c                |  8 +++++++-
 block/copy-before-write.c        |  2 +-
 block/crypto.c                   |  6 ++++++
 block/dmg.c                      | 16 ++++++++++------
 block/parallels-ext.c            | 21 ++++++++++-----------
 block/parallels.c                |  6 ++++--
 block/preallocate.c              | 19 ++++++++++++++-----
 block/qed.c                      | 12 ++++++++++--
 block/raw-format.c               |  9 ++++++---
 block/replication.c              |  5 ++++-
 block/vmdk.c                     | 14 ++++++++++++--
 15 files changed, 97 insertions(+), 41 deletions(-)

diff --git a/block/parallels.h b/block/parallels.h
index 6b199443cf..423b2ad727 100644
--- a/block/parallels.h
+++ b/block/parallels.h
@@ -90,7 +90,8 @@ typedef struct BDRVParallelsState {
     Error *migration_blocker;
 } BDRVParallelsState;
 
-int parallels_read_format_extension(BlockDriverState *bs,
-                                    int64_t ext_off, Error **errp);
+int GRAPH_RDLOCK
+parallels_read_format_extension(BlockDriverState *bs, int64_t ext_off,
+                                Error **errp);
 
 #endif
diff --git a/block/qed.h b/block/qed.h
index 988654cb86..26d4bf038c 100644
--- a/block/qed.h
+++ b/block/qed.h
@@ -185,7 +185,7 @@ enum {
 /**
  * Header functions
  */
-int qed_write_header_sync(BDRVQEDState *s);
+int GRAPH_RDLOCK qed_write_header_sync(BDRVQEDState *s);
 
 /**
  * L2 cache functions
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 63bc523d7c..4e31d161c5 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1181,7 +1181,7 @@ struct BlockDriverState {
      */
     QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) children;
     BdrvChild * GRAPH_RDLOCK_PTR backing;
-    BdrvChild *file;
+    BdrvChild * GRAPH_RDLOCK_PTR file;
 
     QLIST_HEAD(, BdrvChild GRAPH_RDLOCK_PTR) parents;
 
diff --git a/block.c b/block.c
index 4910b95d7d..eac105a504 100644
--- a/block.c
+++ b/block.c
@@ -1707,12 +1707,14 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
     return 0;
 open_failed:
     bs->drv = NULL;
+
+    bdrv_graph_wrlock(NULL);
     if (bs->file != NULL) {
-        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, bs->file);
-        bdrv_graph_wrunlock();
         assert(!bs->file);
     }
+    bdrv_graph_wrunlock();
+
     g_free(bs->opaque);
     bs->opaque = NULL;
     return ret;
@@ -1854,9 +1856,12 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     Error *local_err = NULL;
     bool ro;
 
+    GLOBAL_STATE_CODE();
+
+    bdrv_graph_rdlock_main_loop();
     assert(bs->file == NULL);
     assert(options != NULL && bs->options != options);
-    GLOBAL_STATE_CODE();
+    bdrv_graph_rdunlock_main_loop();
 
     opts = qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort);
     if (!qemu_opts_absorb_qdict(opts, options, errp)) {
diff --git a/block/blkreplay.c b/block/blkreplay.c
index 04f53eea41..792d980aa9 100644
--- a/block/blkreplay.c
+++ b/block/blkreplay.c
@@ -130,7 +130,13 @@ static int coroutine_fn GRAPH_RDLOCK blkreplay_co_flush(BlockDriverState *bs)
 static int blkreplay_snapshot_goto(BlockDriverState *bs,
                                    const char *snapshot_id)
 {
-    return bdrv_snapshot_goto(bs->file->bs, snapshot_id, NULL);
+    BlockDriverState *file_bs;
+
+    bdrv_graph_rdlock_main_loop();
+    file_bs = bs->file->bs;
+    bdrv_graph_rdunlock_main_loop();
+
+    return bdrv_snapshot_goto(file_bs, snapshot_id, NULL);
 }
 
 static BlockDriver bdrv_blkreplay = {
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index ad3b73cc4a..13972879b1 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -203,7 +203,7 @@ static int coroutine_fn GRAPH_RDLOCK cbw_co_flush(BlockDriverState *bs)
  * It's guaranteed that guest writes will not interact in the region until
  * cbw_snapshot_read_unlock() called.
  */
-static coroutine_fn BlockReq *
+static BlockReq * coroutine_fn GRAPH_RDLOCK
 cbw_snapshot_read_lock(BlockDriverState *bs, int64_t offset, int64_t bytes,
                        int64_t *pnum, BdrvChild **file)
 {
diff --git a/block/crypto.c b/block/crypto.c
index 6ee0cac4b6..921933a5e5 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -65,6 +65,9 @@ static int block_crypto_read_func(QCryptoBlock *block,
     BlockDriverState *bs = opaque;
     ssize_t ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     ret = bdrv_pread(bs->file, offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
@@ -83,6 +86,9 @@ static int block_crypto_write_func(QCryptoBlock *block,
     BlockDriverState *bs = opaque;
     ssize_t ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     ret = bdrv_pwrite(bs->file, offset, buflen, buf, 0);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write encryption header");
diff --git a/block/dmg.c b/block/dmg.c
index 853ad36a00..33dcb3a349 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -70,7 +70,8 @@ static int dmg_probe(const uint8_t *buf, int buf_size, const char *filename)
     return 0;
 }
 
-static int read_uint64(BlockDriverState *bs, int64_t offset, uint64_t *result)
+static int GRAPH_RDLOCK
+read_uint64(BlockDriverState *bs, int64_t offset, uint64_t *result)
 {
     uint64_t buffer;
     int ret;
@@ -84,7 +85,8 @@ static int read_uint64(BlockDriverState *bs, int64_t offset, uint64_t *result)
     return 0;
 }
 
-static int read_uint32(BlockDriverState *bs, int64_t offset, uint32_t *result)
+static int GRAPH_RDLOCK
+read_uint32(BlockDriverState *bs, int64_t offset, uint32_t *result)
 {
     uint32_t buffer;
     int ret;
@@ -321,8 +323,9 @@ fail:
     return ret;
 }
 
-static int dmg_read_resource_fork(BlockDriverState *bs, DmgHeaderState *ds,
-                                  uint64_t info_begin, uint64_t info_length)
+static int GRAPH_RDLOCK
+dmg_read_resource_fork(BlockDriverState *bs, DmgHeaderState *ds,
+                       uint64_t info_begin, uint64_t info_length)
 {
     BDRVDMGState *s = bs->opaque;
     int ret;
@@ -388,8 +391,9 @@ fail:
     return ret;
 }
 
-static int dmg_read_plist_xml(BlockDriverState *bs, DmgHeaderState *ds,
-                              uint64_t info_begin, uint64_t info_length)
+static int GRAPH_RDLOCK
+dmg_read_plist_xml(BlockDriverState *bs, DmgHeaderState *ds,
+                   uint64_t info_begin, uint64_t info_length)
 {
     BDRVDMGState *s = bs->opaque;
     int ret;
diff --git a/block/parallels-ext.c b/block/parallels-ext.c
index 4d8ecf5047..b4e14c88f2 100644
--- a/block/parallels-ext.c
+++ b/block/parallels-ext.c
@@ -59,11 +59,10 @@ typedef struct ParallelsDirtyBitmapFeature {
 } QEMU_PACKED ParallelsDirtyBitmapFeature;
 
 /* Given L1 table read bitmap data from the image and populate @bitmap */
-static int parallels_load_bitmap_data(BlockDriverState *bs,
-                                      const uint64_t *l1_table,
-                                      uint32_t l1_size,
-                                      BdrvDirtyBitmap *bitmap,
-                                      Error **errp)
+static int GRAPH_RDLOCK
+parallels_load_bitmap_data(BlockDriverState *bs, const uint64_t *l1_table,
+                           uint32_t l1_size, BdrvDirtyBitmap *bitmap,
+                           Error **errp)
 {
     BDRVParallelsState *s = bs->opaque;
     int ret = 0;
@@ -120,10 +119,9 @@ finish:
  * @data buffer (of @data_size size) is the Dirty bitmaps feature which
  * consists of ParallelsDirtyBitmapFeature followed by L1 table.
  */
-static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
-                                              uint8_t *data,
-                                              size_t data_size,
-                                              Error **errp)
+static BdrvDirtyBitmap * GRAPH_RDLOCK
+parallels_load_bitmap(BlockDriverState *bs, uint8_t *data, size_t data_size,
+                      Error **errp)
 {
     int ret;
     ParallelsDirtyBitmapFeature bf;
@@ -183,8 +181,9 @@ static BdrvDirtyBitmap *parallels_load_bitmap(BlockDriverState *bs,
     return bitmap;
 }
 
-static int parallels_parse_format_extension(BlockDriverState *bs,
-                                            uint8_t *ext_cluster, Error **errp)
+static int GRAPH_RDLOCK
+parallels_parse_format_extension(BlockDriverState *bs, uint8_t *ext_cluster,
+                                 Error **errp)
 {
     BDRVParallelsState *s = bs->opaque;
     int ret;
diff --git a/block/parallels.c b/block/parallels.c
index a04f836cc2..9205a0864f 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -200,7 +200,7 @@ static int mark_used(BlockDriverState *bs, unsigned long *bitmap,
  * bitmap anyway, as much as we can. This information will be used for
  * error resolution.
  */
-static int parallels_fill_used_bitmap(BlockDriverState *bs)
+static int GRAPH_RDLOCK parallels_fill_used_bitmap(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
     int64_t payload_bytes;
@@ -1185,7 +1185,7 @@ static int parallels_probe(const uint8_t *buf, int buf_size,
     return 0;
 }
 
-static int parallels_update_header(BlockDriverState *bs)
+static int GRAPH_RDLOCK parallels_update_header(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
     unsigned size = MAX(bdrv_opt_mem_align(bs->file->bs),
@@ -1428,6 +1428,8 @@ static void parallels_close(BlockDriverState *bs)
 {
     BDRVParallelsState *s = bs->opaque;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if ((bs->open_flags & BDRV_O_RDWR) && !(bs->open_flags & BDRV_O_INACTIVE)) {
         s->header->inuse = 0;
         parallels_update_header(bs);
diff --git a/block/preallocate.c b/block/preallocate.c
index f302d17d3f..d215bc5d6d 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -173,7 +173,8 @@ static int preallocate_open(BlockDriverState *bs, QDict *options, int flags,
     return 0;
 }
 
-static int preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
+static int GRAPH_RDLOCK
+preallocate_truncate_to_real_size(BlockDriverState *bs, Error **errp)
 {
     BDRVPreallocateState *s = bs->opaque;
     int ret;
@@ -204,6 +205,9 @@ static void preallocate_close(BlockDriverState *bs)
 {
     BDRVPreallocateState *s = bs->opaque;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     qemu_bh_cancel(s->drop_resize_bh);
     qemu_bh_delete(s->drop_resize_bh);
 
@@ -227,6 +231,9 @@ static int preallocate_reopen_prepare(BDRVReopenState *reopen_state,
     PreallocateOpts *opts = g_new0(PreallocateOpts, 1);
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!preallocate_absorb_opts(opts, reopen_state->options,
                                  reopen_state->bs->file->bs, errp)) {
         g_free(opts);
@@ -287,7 +294,7 @@ static bool can_write_resize(uint64_t perm)
     return (perm & BLK_PERM_WRITE) && (perm & BLK_PERM_RESIZE);
 }
 
-static bool has_prealloc_perms(BlockDriverState *bs)
+static bool GRAPH_RDLOCK has_prealloc_perms(BlockDriverState *bs)
 {
     BDRVPreallocateState *s = bs->opaque;
 
@@ -503,7 +510,8 @@ preallocate_co_getlength(BlockDriverState *bs)
     return ret;
 }
 
-static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
+static int GRAPH_RDLOCK
+preallocate_drop_resize(BlockDriverState *bs, Error **errp)
 {
     BDRVPreallocateState *s = bs->opaque;
     int ret;
@@ -529,15 +537,16 @@ static int preallocate_drop_resize(BlockDriverState *bs, Error **errp)
      */
     s->data_end = s->file_end = s->zero_start = -EINVAL;
 
-    bdrv_graph_rdlock_main_loop();
     bdrv_child_refresh_perms(bs, bs->file, NULL);
-    bdrv_graph_rdunlock_main_loop();
 
     return 0;
 }
 
 static void preallocate_drop_resize_bh(void *opaque)
 {
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /*
      * In case of errors, we'll simply keep the exclusive lock on the image
      * indefinitely.
diff --git a/block/qed.c b/block/qed.c
index f4c1628a81..bc2f0a61c0 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -612,7 +612,7 @@ static int bdrv_qed_reopen_prepare(BDRVReopenState *state,
     return 0;
 }
 
-static void bdrv_qed_close(BlockDriverState *bs)
+static void GRAPH_RDLOCK bdrv_qed_do_close(BlockDriverState *bs)
 {
     BDRVQEDState *s = bs->opaque;
 
@@ -631,6 +631,14 @@ static void bdrv_qed_close(BlockDriverState *bs)
     qemu_vfree(s->l1_table);
 }
 
+static void GRAPH_UNLOCKED bdrv_qed_close(BlockDriverState *bs)
+{
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    bdrv_qed_do_close(bs);
+}
+
 static int coroutine_fn GRAPH_UNLOCKED
 bdrv_qed_co_create(BlockdevCreateOptions *opts, Error **errp)
 {
@@ -1574,7 +1582,7 @@ bdrv_qed_co_invalidate_cache(BlockDriverState *bs, Error **errp)
     BDRVQEDState *s = bs->opaque;
     int ret;
 
-    bdrv_qed_close(bs);
+    bdrv_qed_do_close(bs);
 
     bdrv_qed_init_state(bs);
     qemu_co_mutex_lock(&s->table_lock);
diff --git a/block/raw-format.c b/block/raw-format.c
index 66741be954..1111dffd54 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -95,9 +95,9 @@ end:
     return ret;
 }
 
-static int raw_apply_options(BlockDriverState *bs, BDRVRawState *s,
-                             uint64_t offset, bool has_size, uint64_t size,
-                             Error **errp)
+static int GRAPH_RDLOCK
+raw_apply_options(BlockDriverState *bs, BDRVRawState *s, uint64_t offset,
+                  bool has_size, uint64_t size, Error **errp)
 {
     int64_t real_size = 0;
 
@@ -145,6 +145,9 @@ static int raw_reopen_prepare(BDRVReopenState *reopen_state,
     uint64_t offset, size;
     int ret;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     assert(reopen_state != NULL);
     assert(reopen_state->bs != NULL);
 
diff --git a/block/replication.c b/block/replication.c
index 49ecc608b2..43e259444b 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -311,7 +311,7 @@ static void GRAPH_UNLOCKED
 secondary_do_checkpoint(BlockDriverState *bs, Error **errp)
 {
     BDRVReplicationState *s = bs->opaque;
-    BdrvChild *active_disk = bs->file;
+    BdrvChild *active_disk;
     Error *local_err = NULL;
     int ret;
 
@@ -328,6 +328,7 @@ secondary_do_checkpoint(BlockDriverState *bs, Error **errp)
         return;
     }
 
+    active_disk = bs->file;
     if (!active_disk->bs->drv) {
         error_setg(errp, "Active disk %s is ejected",
                    active_disk->bs->node_name);
@@ -755,11 +756,13 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
             return;
         }
 
+        bdrv_graph_rdlock_main_loop();
         s->stage = BLOCK_REPLICATION_FAILOVER;
         s->commit_job = commit_active_start(
                             NULL, bs->file->bs, s->secondary_disk->bs,
                             JOB_INTERNAL, 0, BLOCKDEV_ON_ERROR_REPORT,
                             NULL, replication_done, bs, true, errp);
+        bdrv_graph_rdunlock_main_loop();
         break;
     default:
         aio_context_release(aio_context);
diff --git a/block/vmdk.c b/block/vmdk.c
index 5c789bb65b..dda783f06b 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -300,7 +300,8 @@ static void vmdk_free_last_extent(BlockDriverState *bs)
 }
 
 /* Return -ve errno, or 0 on success and write CID into *pcid. */
-static int vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
+static int GRAPH_RDLOCK
+vmdk_read_cid(BlockDriverState *bs, int parent, uint32_t *pcid)
 {
     char *desc;
     uint32_t cid;
@@ -415,6 +416,9 @@ static int vmdk_reopen_prepare(BDRVReopenState *state,
     BDRVVmdkReopenState *rs;
     int i;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     assert(state != NULL);
     assert(state->bs != NULL);
     assert(state->opaque == NULL);
@@ -451,6 +455,9 @@ static void vmdk_reopen_commit(BDRVReopenState *state)
     BDRVVmdkReopenState *rs = state->opaque;
     int i;
 
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     for (i = 0; i < s->num_extents; i++) {
         if (rs->extents_using_bs_file[i]) {
             s->extents[i].file = state->bs->file;
@@ -465,7 +472,7 @@ static void vmdk_reopen_abort(BDRVReopenState *state)
     vmdk_reopen_clean(state);
 }
 
-static int vmdk_parent_open(BlockDriverState *bs)
+static int GRAPH_RDLOCK vmdk_parent_open(BlockDriverState *bs)
 {
     char *p_name;
     char *desc;
@@ -2547,7 +2554,10 @@ vmdk_co_do_create(int64_t size,
             ret = -EINVAL;
             goto exit;
         }
+
+        bdrv_graph_co_rdlock();
         ret = vmdk_read_cid(blk_bs(backing), 0, &parent_cid);
+        bdrv_graph_co_rdunlock();
         blk_co_unref(backing);
         if (ret) {
             error_setg(errp, "Failed to read parent CID");
-- 
2.41.0


