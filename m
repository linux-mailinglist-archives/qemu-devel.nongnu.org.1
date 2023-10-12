Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B05D87C7272
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:25:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySs-0003bj-9E; Thu, 12 Oct 2023 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySe-0003W4-Mj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0000aD-HX
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gVrUchiC4TUnFs3pPpMo+0nuafyp+n5hlIcmmyOy3R8=;
 b=G9WUMSr49NYTZx2ygT3aB8dsDFT4RSd14aP40aihDaNa8F3KNZNIofbNEQ9EpM8SZIoy6Q
 A7hAUDWddXt3tdUagfBeKnIoo9hor9AJHX3sbgtLw7SwCfSYteREP04HM7sGSqNv0ksHGT
 gg/W6C8tlzr2oEL8nyR08di6LiAYAsM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-gUMBlnckPtS9O6AM4Bl4Vw-1; Thu, 12 Oct 2023 12:22:47 -0400
X-MC-Unique: gUMBlnckPtS9O6AM4Bl4Vw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 057EB381079E;
 Thu, 12 Oct 2023 16:22:47 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 66CD020296DB;
 Thu, 12 Oct 2023 16:22:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/26] block: Mark bdrv_refresh_filename() and callers
 GRAPH_RDLOCK
Date: Thu, 12 Oct 2023 18:22:12 +0200
Message-ID: <20231012162224.240535-15-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds GRAPH_RDLOCK annotations to declare that callers of
bdrv_refresh_filename() need to hold a reader lock for the graph
because it accesses the children list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-11-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vhdx.h                       |  5 +--
 include/block/block-global-state.h |  9 ++++--
 include/block/block_int-common.h   |  8 ++---
 include/block/qapi.h               | 16 ++++------
 block.c                            | 23 +++++++++++---
 block/nfs.c                        |  2 +-
 block/qapi.c                       | 11 ++++---
 block/raw-format.c                 |  2 ++
 block/vhdx.c                       |  4 +++
 block/vmdk.c                       | 51 +++++++++++++++++++-----------
 blockdev.c                         | 13 ++++++++
 qemu-img.c                         |  4 +++
 12 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/block/vhdx.h b/block/vhdx.h
index 455a627a46..85594a5380 100644
--- a/block/vhdx.h
+++ b/block/vhdx.h
@@ -410,8 +410,9 @@ uint32_t vhdx_checksum_calc(uint32_t crc, uint8_t *buf, size_t size,
 
 bool vhdx_checksum_is_valid(uint8_t *buf, size_t size, int crc_offset);
 
-int vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
-                   Error **errp);
+int GRAPH_RDLOCK
+vhdx_parse_log(BlockDriverState *bs, BDRVVHDXState *s, bool *flushed,
+               Error **errp);
 
 int coroutine_fn GRAPH_RDLOCK
 vhdx_log_write_and_flush(BlockDriverState *bs, BDRVVHDXState *s,
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 4d80b3d554..ec623ef3c9 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -132,7 +132,7 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
 BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
                                           const char *backing_file);
-void bdrv_refresh_filename(BlockDriverState *bs);
+void GRAPH_RDLOCK bdrv_refresh_filename(BlockDriverState *bs);
 
 void GRAPH_RDLOCK
 bdrv_refresh_limits(BlockDriverState *bs, Transaction *tran, Error **errp);
@@ -216,8 +216,11 @@ void bdrv_next_cleanup(BdrvNextIterator *it);
 BlockDriverState *bdrv_next_monitor_owned(BlockDriverState *bs);
 void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
                          void *opaque, bool read_only);
-char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
-char *bdrv_dirname(BlockDriverState *bs, Error **errp);
+
+char * GRAPH_RDLOCK
+bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
+
+char * GRAPH_RDLOCK bdrv_dirname(BlockDriverState *bs, Error **errp);
 
 void bdrv_img_create(const char *filename, const char *fmt,
                      const char *base_filename, const char *base_fmt,
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 0373cbed49..be80887898 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -272,7 +272,7 @@ struct BlockDriver {
      * Refreshes the bs->exact_filename field. If that is impossible,
      * bs->exact_filename has to be left empty.
      */
-    void (*bdrv_refresh_filename)(BlockDriverState *bs);
+    void GRAPH_RDLOCK_PTR (*bdrv_refresh_filename)(BlockDriverState *bs);
 
     /*
      * Gathers the open options for all children into @target.
@@ -295,15 +295,15 @@ struct BlockDriver {
      * block driver which implements it is probably doing something
      * shady regarding its runtime option structure.
      */
-    void (*bdrv_gather_child_options)(BlockDriverState *bs, QDict *target,
-                                      bool backing_overridden);
+    void GRAPH_RDLOCK_PTR (*bdrv_gather_child_options)(
+        BlockDriverState *bs, QDict *target, bool backing_overridden);
 
     /*
      * Returns an allocated string which is the directory name of this BDS: It
      * will be used to make relative filenames absolute by prepending this
      * function's return value to them.
      */
-    char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);
+    char * GRAPH_RDLOCK_PTR (*bdrv_dirname)(BlockDriverState *bs, Error **errp);
 
     /*
      * This informs the driver that we are no longer interested in the result
diff --git a/include/block/qapi.h b/include/block/qapi.h
index 8663971c58..887235653a 100644
--- a/include/block/qapi.h
+++ b/include/block/qapi.h
@@ -29,18 +29,16 @@
 #include "block/snapshot.h"
 #include "qapi/qapi-types-block-core.h"
 
-BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
-                                        BlockDriverState *bs,
-                                        bool flat,
-                                        Error **errp);
+BlockDeviceInfo * GRAPH_RDLOCK
+bdrv_block_device_info(BlockBackend *blk, BlockDriverState *bs,
+                       bool flat, Error **errp);
+
 int bdrv_query_snapshot_info_list(BlockDriverState *bs,
                                   SnapshotInfoList **p_list,
                                   Error **errp);
-void bdrv_query_image_info(BlockDriverState *bs,
-                           ImageInfo **p_info,
-                           bool flat,
-                           bool skip_implicit_filters,
-                           Error **errp);
+void GRAPH_RDLOCK
+bdrv_query_image_info(BlockDriverState *bs, ImageInfo **p_info, bool flat,
+                      bool skip_implicit_filters, Error **errp);
 void GRAPH_RDLOCK
 bdrv_query_block_graph_info(BlockDriverState *bs, BlockGraphInfo **p_info,
                             Error **errp);
diff --git a/block.c b/block.c
index 084ff14509..142e1d5e2b 100644
--- a/block.c
+++ b/block.c
@@ -371,8 +371,9 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
  * setting @errp.  In all other cases, NULL will only be returned with
  * @errp set.
  */
-static char *bdrv_make_absolute_filename(BlockDriverState *relative_to,
-                                         const char *filename, Error **errp)
+static char * GRAPH_RDLOCK
+bdrv_make_absolute_filename(BlockDriverState *relative_to,
+                            const char *filename, Error **errp)
 {
     char *dir, *full_name;
 
@@ -1250,7 +1251,7 @@ static void bdrv_temp_snapshot_options(int *child_flags, QDict *child_options,
     *child_flags &= ~BDRV_O_NATIVE_AIO;
 }
 
-static void bdrv_backing_attach(BdrvChild *c)
+static void GRAPH_WRLOCK bdrv_backing_attach(BdrvChild *c)
 {
     BlockDriverState *parent = c->opaque;
     BlockDriverState *backing_hd = c->bs;
@@ -1874,7 +1875,10 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     }
 
     if (file != NULL) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(blk_bs(file));
+        bdrv_graph_rdunlock_main_loop();
+
         filename = blk_bs(file)->filename;
     } else {
         /*
@@ -3644,7 +3648,10 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
             implicit_backing = !strcmp(bs->auto_backing_file, bs->backing_file);
         }
 
+        bdrv_graph_rdlock_main_loop();
         backing_filename = bdrv_get_full_backing_filename(bs, &local_err);
+        bdrv_graph_rdunlock_main_loop();
+
         if (local_err) {
             ret = -EINVAL;
             error_propagate(errp, local_err);
@@ -3675,7 +3682,9 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     }
 
     if (implicit_backing) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(backing_hd);
+        bdrv_graph_rdunlock_main_loop();
         pstrcpy(bs->auto_backing_file, sizeof(bs->auto_backing_file),
                 backing_hd->filename);
     }
@@ -4964,7 +4973,9 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
             if (local_err != NULL) {
                 error_propagate(errp, local_err);
             } else {
+                bdrv_graph_rdlock_main_loop();
                 bdrv_refresh_filename(reopen_state->bs);
+                bdrv_graph_rdunlock_main_loop();
                 error_setg(errp, "failed while preparing to reopen image '%s'",
                            reopen_state->bs->filename);
             }
@@ -5931,6 +5942,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 
     bdrv_ref(top);
     bdrv_drained_begin(base);
+    bdrv_graph_rdlock_main_loop();
 
     if (!top->drv || !base->drv) {
         goto exit;
@@ -5955,11 +5967,9 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         backing_file_str = base->filename;
     }
 
-    bdrv_graph_rdlock_main_loop();
     QLIST_FOREACH(c, &top->parents, next_parent) {
         updated_children = g_slist_prepend(updated_children, c);
     }
-    bdrv_graph_rdunlock_main_loop();
 
     /*
      * It seems correct to pass detach_subchain=true here, but it triggers
@@ -6005,6 +6015,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
 
     ret = 0;
 exit:
+    bdrv_graph_rdunlock_main_loop();
     bdrv_drained_end(base);
     bdrv_unref(top);
     return ret;
@@ -6295,6 +6306,7 @@ BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
     BlockDriverState *bs;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     list = NULL;
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
@@ -6763,6 +6775,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     BlockDriverState *bs_below;
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
diff --git a/block/nfs.c b/block/nfs.c
index c24df49747..f737e19cd3 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -843,7 +843,7 @@ static void nfs_refresh_filename(BlockDriverState *bs)
     }
 }
 
-static char *nfs_dirname(BlockDriverState *bs, Error **errp)
+static char * GRAPH_RDLOCK nfs_dirname(BlockDriverState *bs, Error **errp)
 {
     NFSClient *client = bs->opaque;
 
diff --git a/block/qapi.c b/block/qapi.c
index 1cbb0935ff..82a30b38fe 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -225,9 +225,8 @@ int bdrv_query_snapshot_info_list(BlockDriverState *bs,
  * Helper function for other query info functions.  Store information about @bs
  * in @info, setting @errp on error.
  */
-static void bdrv_do_query_node_info(BlockDriverState *bs,
-                                    BlockNodeInfo *info,
-                                    Error **errp)
+static void GRAPH_RDLOCK
+bdrv_do_query_node_info(BlockDriverState *bs, BlockNodeInfo *info, Error **errp)
 {
     int64_t size;
     const char *backing_filename;
@@ -423,8 +422,8 @@ fail:
 }
 
 /* @p_info will be set only on success. */
-static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
-                            Error **errp)
+static void GRAPH_RDLOCK
+bdrv_query_info(BlockBackend *blk, BlockInfo **p_info, Error **errp)
 {
     BlockInfo *info = g_malloc0(sizeof(*info));
     BlockDriverState *bs = blk_bs(blk);
@@ -672,6 +671,8 @@ BlockInfoList *qmp_query_block(Error **errp)
     BlockBackend *blk;
     Error *local_err = NULL;
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
         BlockInfoList *info;
 
diff --git a/block/raw-format.c b/block/raw-format.c
index a8bdee5279..8ff03adfa4 100644
--- a/block/raw-format.c
+++ b/block/raw-format.c
@@ -505,7 +505,9 @@ static int raw_open(BlockDriverState *bs, QDict *options, int flags,
                                    BDRV_REQ_ZERO_WRITE;
 
     if (bs->probed && !bdrv_is_read_only(bs)) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(bs->file->bs);
+        bdrv_graph_rdunlock_main_loop();
         fprintf(stderr,
                 "WARNING: Image format was not specified for '%s' and probing "
                 "guessed raw.\n"
diff --git a/block/vhdx.c b/block/vhdx.c
index a67edcc03e..73cb214fb4 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -1001,11 +1001,15 @@ static int vhdx_open(BlockDriverState *bs, QDict *options, int flags,
     uint64_t signature;
     Error *local_err = NULL;
 
+    GLOBAL_STATE_CODE();
+
     ret = bdrv_open_file_child(NULL, options, "file", bs, errp);
     if (ret < 0) {
         return ret;
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     s->bat = NULL;
     s->first_visible_write = true;
 
diff --git a/block/vmdk.c b/block/vmdk.c
index e90649c8bf..e50965bc37 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -578,8 +578,8 @@ static int vmdk_add_extent(BlockDriverState *bs,
     return 0;
 }
 
-static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
-                            Error **errp)
+static int GRAPH_RDLOCK
+vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent, Error **errp)
 {
     int ret;
     size_t l1_size;
@@ -641,9 +641,9 @@ static int vmdk_init_tables(BlockDriverState *bs, VmdkExtent *extent,
     return ret;
 }
 
-static int vmdk_open_vmfs_sparse(BlockDriverState *bs,
-                                 BdrvChild *file,
-                                 int flags, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_open_vmfs_sparse(BlockDriverState *bs, BdrvChild *file, int flags,
+                      Error **errp)
 {
     int ret;
     uint32_t magic;
@@ -797,9 +797,9 @@ static int check_se_sparse_volatile_header(VMDKSESparseVolatileHeader *header,
     return 0;
 }
 
-static int vmdk_open_se_sparse(BlockDriverState *bs,
-                               BdrvChild *file,
-                               int flags, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_open_se_sparse(BlockDriverState *bs, BdrvChild *file, int flags,
+                    Error **errp)
 {
     int ret;
     VMDKSESparseConstHeader const_header;
@@ -913,9 +913,9 @@ static char *vmdk_read_desc(BdrvChild *file, uint64_t desc_offset, Error **errp)
     return buf;
 }
 
-static int vmdk_open_vmdk4(BlockDriverState *bs,
-                           BdrvChild *file,
-                           int flags, QDict *options, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_open_vmdk4(BlockDriverState *bs, BdrvChild *file, int flags,
+                QDict *options, Error **errp)
 {
     int ret;
     uint32_t magic;
@@ -1095,8 +1095,9 @@ static int vmdk_parse_description(const char *desc, const char *opt_name,
 }
 
 /* Open an extent file and append to bs array */
-static int vmdk_open_sparse(BlockDriverState *bs, BdrvChild *file, int flags,
-                            char *buf, QDict *options, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_open_sparse(BlockDriverState *bs, BdrvChild *file, int flags,
+                 char *buf, QDict *options, Error **errp)
 {
     uint32_t magic;
 
@@ -1123,8 +1124,9 @@ static const char *next_line(const char *s)
     return s;
 }
 
-static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
-                              QDict *options, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_parse_extents(const char *desc, BlockDriverState *bs, QDict *options,
+                   Error **errp)
 {
     int ret;
     int matches;
@@ -1143,6 +1145,8 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
     char extent_opt_prefix[32];
     Error *local_err = NULL;
 
+    GLOBAL_STATE_CODE();
+
     for (p = desc; *p; p = next_line(p)) {
         /* parse extent line in one of below formats:
          *
@@ -1223,9 +1227,11 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
             ret = vmdk_add_extent(bs, extent_file, true, sectors,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
+                bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_graph_rdlock_main_loop();
                 goto out;
             }
             extent->flat_start_offset = flat_offset << 9;
@@ -1240,26 +1246,32 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
             }
             g_free(buf);
             if (ret) {
+                bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_graph_rdlock_main_loop();
                 goto out;
             }
             extent = &s->extents[s->num_extents - 1];
         } else if (!strcmp(type, "SESPARSE")) {
             ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
             if (ret) {
+                bdrv_graph_rdunlock_main_loop();
                 bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
                 bdrv_graph_wrunlock();
+                bdrv_graph_rdlock_main_loop();
                 goto out;
             }
             extent = &s->extents[s->num_extents - 1];
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
+            bdrv_graph_rdunlock_main_loop();
             bdrv_graph_wrlock(NULL);
             bdrv_unref_child(bs, extent_file);
             bdrv_graph_wrunlock();
+            bdrv_graph_rdlock_main_loop();
             ret = -ENOTSUP;
             goto out;
         }
@@ -1283,8 +1295,9 @@ out:
     return ret;
 }
 
-static int vmdk_open_desc_file(BlockDriverState *bs, int flags, char *buf,
-                               QDict *options, Error **errp)
+static int GRAPH_RDLOCK
+vmdk_open_desc_file(BlockDriverState *bs, int flags, char *buf, QDict *options,
+                    Error **errp)
 {
     int ret;
     char ct[128];
@@ -2900,7 +2913,7 @@ static int vmdk_has_zero_init(BlockDriverState *bs)
     return 1;
 }
 
-static VmdkExtentInfo *vmdk_get_extent_info(VmdkExtent *extent)
+static VmdkExtentInfo * GRAPH_RDLOCK vmdk_get_extent_info(VmdkExtent *extent)
 {
     VmdkExtentInfo *info = g_new0(VmdkExtentInfo, 1);
 
@@ -2985,6 +2998,8 @@ static ImageInfoSpecific *vmdk_get_specific_info(BlockDriverState *bs,
     ImageInfoSpecific *spec_info = g_new0(ImageInfoSpecific, 1);
     VmdkExtentInfoList **tail;
 
+    assume_graph_lock(); /* FIXME */
+
     *spec_info = (ImageInfoSpecific){
         .type = IMAGE_INFO_SPECIFIC_KIND_VMDK,
         .u = {
diff --git a/blockdev.c b/blockdev.c
index ff5ee9ff7b..51c58dd432 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1665,6 +1665,8 @@ static void drive_backup_action(DriveBackup *backup,
     bool set_backing_hd = false;
     int ret;
 
+    GLOBAL_STATE_CODE();
+
     tran_add(tran, &drive_backup_drv, state);
 
     if (!backup->has_mode) {
@@ -1735,7 +1737,10 @@ static void drive_backup_action(DriveBackup *backup,
             BlockDriverState *explicit_backing =
                 bdrv_skip_implicit_filters(source);
 
+            bdrv_graph_rdlock_main_loop();
             bdrv_refresh_filename(explicit_backing);
+            bdrv_graph_rdunlock_main_loop();
+
             bdrv_img_create(backup->target, format,
                             explicit_backing->filename,
                             explicit_backing->drv->format_name, NULL,
@@ -2398,6 +2403,8 @@ void qmp_block_stream(const char *job_id, const char *device,
     Error *local_err = NULL;
     int job_flags = JOB_DEFAULT;
 
+    GLOBAL_STATE_CODE();
+
     if (base && base_node) {
         error_setg(errp, "'base' and 'base-node' cannot be specified "
                    "at the same time");
@@ -2448,7 +2455,10 @@ void qmp_block_stream(const char *job_id, const char *device,
             goto out;
         }
         assert(bdrv_get_aio_context(base_bs) == aio_context);
+
+        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(base_bs);
+        bdrv_graph_rdunlock_main_loop();
     }
 
     if (bottom) {
@@ -3076,7 +3086,10 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
             break;
         case NEW_IMAGE_MODE_ABSOLUTE_PATHS:
             /* create new image with backing file */
+            bdrv_graph_rdlock_main_loop();
             bdrv_refresh_filename(explicit_backing);
+            bdrv_graph_rdunlock_main_loop();
+
             bdrv_img_create(arg->target, format,
                             explicit_backing->filename,
                             explicit_backing->drv->format_name,
diff --git a/qemu-img.c b/qemu-img.c
index 5a74e9b10e..3ecbc375b0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3165,7 +3165,9 @@ static int get_block_status(BlockDriverState *bs, int64_t offset,
     has_offset = !!(ret & BDRV_BLOCK_OFFSET_VALID);
 
     if (file && has_offset) {
+        bdrv_graph_rdlock_main_loop();
         bdrv_refresh_filename(file);
+        bdrv_graph_rdunlock_main_loop();
         filename = file->filename;
     }
 
@@ -3688,7 +3690,9 @@ static int img_rebase(int argc, char **argv)
                 qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
             }
 
+            bdrv_graph_rdlock_main_loop();
             bdrv_refresh_filename(bs);
+            bdrv_graph_rdunlock_main_loop();
             overlay_filename = bs->exact_filename[0] ? bs->exact_filename
                                                      : bs->filename;
             out_real_path =
-- 
2.41.0


