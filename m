Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 440277D9DA6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:57:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAL-0004iK-64; Fri, 27 Oct 2023 11:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPAB-0003xl-Fx
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwPA8-0002xU-86
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avtUzFh5SsHZ19izQjExlD4WZdHGt/QEZ72I2+/hQ6A=;
 b=MyC45ndwYdxMcGGknI9KZ4B9YhPawHzy2u619t2GKUQ+EjtfW5MbbvYRkHiYwKIZsLHoPl
 FoXuhOEniH1sAab/f0QCrMQr3vC3XNNkYjvOgpi3GVgCss5HyhZJ+t7sSr64/xlt/EcP/z
 EH4rkVGqM1SmYAsef+EZu+KDE+O7eHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Mc3XFiZWMlaoxIdBaLKgOw-1; Fri, 27 Oct 2023 11:54:10 -0400
X-MC-Unique: Mc3XFiZWMlaoxIdBaLKgOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF3B01019C83;
 Fri, 27 Oct 2023 15:54:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1271502A;
 Fri, 27 Oct 2023 15:54:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 20/24] block: Add missing GRAPH_RDLOCK annotations
Date: Fri, 27 Oct 2023 17:53:29 +0200
Message-ID: <20231027155333.420094-21-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

This adds GRAPH_RDLOCK to some driver callbacks that are already called
with the graph lock held, and which will need the annotation because
they access bs->file, but don't have it yet.

This also covers a few callbacks that were not marked GRAPH_RDLOCK
before, but where updating BlockDriver is trivially possible.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.h                    | 11 ++++++-----
 include/block/block_int-common.h | 17 +++++++++--------
 block/blkdebug.c                 | 13 +++++--------
 block/blkverify.c                |  2 +-
 block/copy-before-write.c        |  2 +-
 block/filter-compress.c          |  3 ++-
 block/io.c                       |  2 ++
 block/parallels.c                | 12 ++++--------
 block/preallocate.c              |  4 ++--
 block/qcow.c                     |  2 +-
 block/qcow2.c                    |  4 ++--
 block/qed.c                      | 10 ++++------
 block/raw-format.c               | 16 ++++++++--------
 block/snapshot-access.c          |  2 +-
 block/vdi.c                      |  9 ++++-----
 block/vhdx.c                     |  6 +++---
 16 files changed, 55 insertions(+), 60 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 29958c512b..948335979f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -972,11 +972,12 @@ int GRAPH_RDLOCK
 qcow2_snapshot_delete(BlockDriverState *bs, const char *snapshot_id,
                           const char *name, Error **errp);
 
-int qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab);
-int qcow2_snapshot_load_tmp(BlockDriverState *bs,
-                            const char *snapshot_id,
-                            const char *name,
-                            Error **errp);
+int GRAPH_RDLOCK
+qcow2_snapshot_list(BlockDriverState *bs, QEMUSnapshotInfo **psn_tab);
+
+int GRAPH_RDLOCK
+qcow2_snapshot_load_tmp(BlockDriverState *bs, const char *snapshot_id,
+                        const char *name, Error **errp);
 
 void qcow2_free_snapshots(BlockDriverState *bs);
 int coroutine_fn GRAPH_RDLOCK
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 59f6d7f195..63bc523d7c 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -310,7 +310,7 @@ struct BlockDriver {
      * One example usage is to avoid waiting for an nbd target node reconnect
      * timeout during job-cancel with force=true.
      */
-    void (*bdrv_cancel_in_flight)(BlockDriverState *bs);
+    void GRAPH_RDLOCK_PTR (*bdrv_cancel_in_flight)(BlockDriverState *bs);
 
     int GRAPH_RDLOCK_PTR (*bdrv_inactivate)(BlockDriverState *bs);
 
@@ -324,12 +324,12 @@ struct BlockDriver {
         BlockDriverState *bs, const char *snapshot_id, const char *name,
         Error **errp);
 
-    int (*bdrv_snapshot_list)(BlockDriverState *bs,
-                              QEMUSnapshotInfo **psn_info);
-    int (*bdrv_snapshot_load_tmp)(BlockDriverState *bs,
-                                  const char *snapshot_id,
-                                  const char *name,
-                                  Error **errp);
+    int GRAPH_RDLOCK_PTR (*bdrv_snapshot_list)(
+        BlockDriverState *bs, QEMUSnapshotInfo **psn_info);
+
+    int GRAPH_RDLOCK_PTR (*bdrv_snapshot_load_tmp)(
+        BlockDriverState *bs, const char *snapshot_id, const char *name,
+        Error **errp);
 
     int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_change_backing_file)(
         BlockDriverState *bs, const char *backing_file,
@@ -396,7 +396,8 @@ struct BlockDriver {
      * Only drivers that want to override guest geometry implement this
      * callback; see hd_geometry_guess().
      */
-    int (*bdrv_probe_geometry)(BlockDriverState *bs, HDGeometry *geo);
+    int GRAPH_RDLOCK_PTR (*bdrv_probe_geometry)(
+        BlockDriverState *bs, HDGeometry *geo);
 
     void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
         BlockDriverState *parent, BlockDriverState *child, Error **errp);
diff --git a/block/blkdebug.c b/block/blkdebug.c
index addad914b3..230efa9e8d 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -746,13 +746,10 @@ blkdebug_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
 
-static int coroutine_fn blkdebug_co_block_status(BlockDriverState *bs,
-                                                 bool want_zero,
-                                                 int64_t offset,
-                                                 int64_t bytes,
-                                                 int64_t *pnum,
-                                                 int64_t *map,
-                                                 BlockDriverState **file)
+static int coroutine_fn GRAPH_RDLOCK
+blkdebug_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
+                         int64_t bytes, int64_t *pnum, int64_t *map,
+                         BlockDriverState **file)
 {
     int err;
 
@@ -973,7 +970,7 @@ blkdebug_co_getlength(BlockDriverState *bs)
     return bdrv_co_getlength(bs->file->bs);
 }
 
-static void blkdebug_refresh_filename(BlockDriverState *bs)
+static void GRAPH_RDLOCK blkdebug_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkdebugState *s = bs->opaque;
     const QDictEntry *e;
diff --git a/block/blkverify.c b/block/blkverify.c
index 9ea2cb4cc5..a96905db35 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -288,7 +288,7 @@ blkverify_recurse_can_replace(BlockDriverState *bs,
            bdrv_recurse_can_replace(s->test_file->bs, to_replace);
 }
 
-static void blkverify_refresh_filename(BlockDriverState *bs)
+static void GRAPH_RDLOCK blkverify_refresh_filename(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 4ffabc5ca2..8193d3a4cd 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -335,7 +335,7 @@ cbw_co_pdiscard_snapshot(BlockDriverState *bs, int64_t offset, int64_t bytes)
     return bdrv_co_pdiscard(s->target, offset, bytes);
 }
 
-static void cbw_refresh_filename(BlockDriverState *bs)
+static void GRAPH_RDLOCK cbw_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->file->bs->filename);
diff --git a/block/filter-compress.c b/block/filter-compress.c
index 320d9576fa..e3fc82f322 100644
--- a/block/filter-compress.c
+++ b/block/filter-compress.c
@@ -97,7 +97,8 @@ compress_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 }
 
 
-static void compress_refresh_limits(BlockDriverState *bs, Error **errp)
+static void GRAPH_RDLOCK
+compress_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BlockDriverInfo bdi;
     int ret;
diff --git a/block/io.c b/block/io.c
index 527a1de04e..7e62fabbf5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -3685,6 +3685,8 @@ out:
 void bdrv_cancel_in_flight(BlockDriverState *bs)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!bs || !bs->drv) {
         return;
     }
diff --git a/block/parallels.c b/block/parallels.c
index 6b46623241..4917ccc1ae 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -415,14 +415,10 @@ parallels_co_flush_to_os(BlockDriverState *bs)
     return 0;
 }
 
-
-static int coroutine_fn parallels_co_block_status(BlockDriverState *bs,
-                                                  bool want_zero,
-                                                  int64_t offset,
-                                                  int64_t bytes,
-                                                  int64_t *pnum,
-                                                  int64_t *map,
-                                                  BlockDriverState **file)
+static int coroutine_fn GRAPH_RDLOCK
+parallels_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
+                          int64_t bytes, int64_t *pnum, int64_t *map,
+                          BlockDriverState **file)
 {
     BDRVParallelsState *s = bs->opaque;
     int count;
diff --git a/block/preallocate.c b/block/preallocate.c
index bfb638d8b1..4e0c891ab2 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -541,8 +541,8 @@ static void preallocate_drop_resize_bh(void *opaque)
     preallocate_drop_resize(opaque, NULL);
 }
 
-static void preallocate_set_perm(BlockDriverState *bs,
-                                 uint64_t perm, uint64_t shared)
+static void GRAPH_RDLOCK
+preallocate_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared)
 {
     BDRVPreallocateState *s = bs->opaque;
 
diff --git a/block/qcow.c b/block/qcow.c
index 38a16253b8..825634a012 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -1026,7 +1026,7 @@ fail:
     return ret;
 }
 
-static int qcow_make_empty(BlockDriverState *bs)
+static int GRAPH_RDLOCK qcow_make_empty(BlockDriverState *bs)
 {
     BDRVQcowState *s = bs->opaque;
     uint32_t l1_length = s->l1_size * sizeof(uint64_t);
diff --git a/block/qcow2.c b/block/qcow2.c
index 63c7cd882e..7f022d5d78 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -5226,8 +5226,8 @@ qcow2_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return 0;
 }
 
-static ImageInfoSpecific *qcow2_get_specific_info(BlockDriverState *bs,
-                                                  Error **errp)
+static ImageInfoSpecific * GRAPH_RDLOCK
+qcow2_get_specific_info(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     ImageInfoSpecific *spec_info;
diff --git a/block/qed.c b/block/qed.c
index 996aa384fe..f4c1628a81 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -1443,12 +1443,10 @@ bdrv_qed_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
                           QED_AIOCB_WRITE | QED_AIOCB_ZERO);
 }
 
-static int coroutine_fn bdrv_qed_co_truncate(BlockDriverState *bs,
-                                             int64_t offset,
-                                             bool exact,
-                                             PreallocMode prealloc,
-                                             BdrvRequestFlags flags,
-                                             Error **errp)
+static int coroutine_fn GRAPH_RDLOCK
+bdrv_qed_co_truncate(BlockDriverState *bs, int64_t offset, bool exact,
+                     PreallocMode prealloc, BdrvRequestFlags flags,
+                     Error **errp)
 {
     BDRVQEDState *s = bs->opaque;
     uint64_t old_image_size;
diff --git a/block/raw-format.c b/block/raw-format.c
index 8ca74c1cf3..2640d54801 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -279,11 +279,10 @@ fail:
     return ret;
 }
 
-static int coroutine_fn raw_co_block_status(BlockDriverState *bs,
-                                            bool want_zero, int64_t offset,
-                                            int64_t bytes, int64_t *pnum,
-                                            int64_t *map,
-                                            BlockDriverState **file)
+static int coroutine_fn GRAPH_RDLOCK
+raw_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
+                    int64_t bytes, int64_t *pnum, int64_t *map,
+                    BlockDriverState **file)
 {
     BDRVRawState *s = bs->opaque;
     *pnum = bytes;
@@ -397,7 +396,7 @@ raw_co_get_info(BlockDriverState *bs, BlockDriverInfo *bdi)
     return bdrv_co_get_info(bs->file->bs, bdi);
 }
 
-static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
+static void GRAPH_RDLOCK raw_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     bs->bl.has_variable_length = bs->file->bs->bl.has_variable_length;
 
@@ -561,7 +560,8 @@ raw_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz)
     return 0;
 }
 
-static int raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
+static int GRAPH_RDLOCK
+raw_probe_geometry(BlockDriverState *bs, HDGeometry *geo)
 {
     BDRVRawState *s = bs->opaque;
     if (s->offset || s->has_size) {
@@ -611,7 +611,7 @@ static const char *const raw_strong_runtime_opts[] = {
     NULL
 };
 
-static void raw_cancel_in_flight(BlockDriverState *bs)
+static void GRAPH_RDLOCK raw_cancel_in_flight(BlockDriverState *bs)
 {
     bdrv_cancel_in_flight(bs->file->bs);
 }
diff --git a/block/snapshot-access.c b/block/snapshot-access.c
index 8d4e8932b8..7c45739eb1 100644
--- a/block/snapshot-access.c
+++ b/block/snapshot-access.c
@@ -73,7 +73,7 @@ snapshot_access_co_pwritev_part(BlockDriverState *bs,
 }
 
 
-static void snapshot_access_refresh_filename(BlockDriverState *bs)
+static void GRAPH_RDLOCK snapshot_access_refresh_filename(BlockDriverState *bs)
 {
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
             bs->file->bs->filename);
diff --git a/block/vdi.c b/block/vdi.c
index f882eb458a..aede29b318 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -521,11 +521,10 @@ static int vdi_reopen_prepare(BDRVReopenState *state,
     return 0;
 }
 
-static int coroutine_fn vdi_co_block_status(BlockDriverState *bs,
-                                            bool want_zero,
-                                            int64_t offset, int64_t bytes,
-                                            int64_t *pnum, int64_t *map,
-                                            BlockDriverState **file)
+static int coroutine_fn GRAPH_RDLOCK
+vdi_co_block_status(BlockDriverState *bs, bool want_zero, int64_t offset,
+                    int64_t bytes, int64_t *pnum, int64_t *map,
+                    BlockDriverState **file)
 {
     BDRVVdiState *s = (BDRVVdiState *)bs->opaque;
     size_t bmap_index = offset / s->block_size;
diff --git a/block/vhdx.c b/block/vhdx.c
index 5b0252fa7f..50aefa5fb5 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -2165,9 +2165,9 @@ fail:
  * r/w and any log has already been replayed, so there is nothing (currently)
  * for us to do here
  */
-static int coroutine_fn vhdx_co_check(BlockDriverState *bs,
-                                      BdrvCheckResult *result,
-                                      BdrvCheckMode fix)
+static int coroutine_fn GRAPH_RDLOCK
+vhdx_co_check(BlockDriverState *bs, BdrvCheckResult *result,
+              BdrvCheckMode fix)
 {
     BDRVVHDXState *s = bs->opaque;
 
-- 
2.41.0


