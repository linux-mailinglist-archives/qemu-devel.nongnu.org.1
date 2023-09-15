Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BD17A2159
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:47:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3T-0000OM-2Y; Fri, 15 Sep 2023 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3H-0000Ej-Iu
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3E-00052t-DY
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=asyMDcjsl5fuTWRXxyIYJ0GIv9RC7k1ZOOXD77o+VoM=;
 b=HhizSFLn7bUkBQBPMv+goNwxNamoaWakKoqQ7VcNaEo2c2FPlsKf0LsQBaUzg5L6c1kL5f
 uhsfDKlGQPd81DYQZyZEKLw1Fp/QKf208e0BhLdaxx153NBLju2ZTgHGCDRkPS64yvNwuS
 QuEReW6nxopf3AVbMDQb1bSQREpnklg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-NYpbYsPmPKKHp0iny9q-GQ-1; Fri, 15 Sep 2023 10:44:05 -0400
X-MC-Unique: NYpbYsPmPKKHp0iny9q-GQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BB7597D207;
 Fri, 15 Sep 2023 14:44:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3632026D4B;
 Fri, 15 Sep 2023 14:44:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 20/28] block: Mark bdrv_unref_child() GRAPH_WRLOCK
Date: Fri, 15 Sep 2023 16:43:36 +0200
Message-ID: <20230915144344.238596-21-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_unref_child(). These callers will typically
already hold the graph lock once the locking work is completed, which
means that they can't call functions that take it internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-21-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  7 ++++++-
 block.c                            | 11 +++++++----
 block/blklogwrites.c               |  4 ++++
 block/blkverify.c                  |  2 ++
 block/qcow2.c                      |  4 +++-
 block/quorum.c                     |  6 ++++++
 block/replication.c                |  3 +++
 block/snapshot.c                   |  2 ++
 block/vmdk.c                       | 11 +++++++++++
 tests/unit/test-bdrv-drain.c       |  8 ++++++--
 10 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index eb12a35439..0f6df8f1a2 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -225,7 +225,12 @@ void bdrv_ref(BlockDriverState *bs);
 void no_coroutine_fn bdrv_unref(BlockDriverState *bs);
 void coroutine_fn no_co_wrapper bdrv_co_unref(BlockDriverState *bs);
 void GRAPH_WRLOCK bdrv_schedule_unref(BlockDriverState *bs);
-void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
+
+void GRAPH_WRLOCK
+bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
+
+void coroutine_fn no_co_wrapper_bdrv_wrlock
+bdrv_co_unref_child(BlockDriverState *parent, BdrvChild *child);
 
 BdrvChild * GRAPH_WRLOCK
 bdrv_attach_child(BlockDriverState *parent_bs,
diff --git a/block.c b/block.c
index 9ea8333a28..e7f349b25c 100644
--- a/block.c
+++ b/block.c
@@ -1701,7 +1701,9 @@ bdrv_open_driver(BlockDriverState *bs, BlockDriver *drv, const char *node_name,
 open_failed:
     bs->drv = NULL;
     if (bs->file != NULL) {
+        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, bs->file);
+        bdrv_graph_wrunlock();
         assert(!bs->file);
     }
     g_free(bs->opaque);
@@ -3331,8 +3333,9 @@ static void bdrv_set_inherits_from(BlockDriverState *bs,
  * @root that point to @root, where necessary.
  * @tran is allowed to be NULL. In this case no rollback is possible
  */
-static void bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *child,
-                                     Transaction *tran)
+static void GRAPH_WRLOCK
+bdrv_unset_inherits_from(BlockDriverState *root, BdrvChild *child,
+                         Transaction *tran)
 {
     BdrvChild *c;
 
@@ -3364,10 +3367,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
         return;
     }
 
-    bdrv_graph_wrlock(NULL);
     bdrv_unset_inherits_from(parent, child, NULL);
     bdrv_root_unref_child(child);
-    bdrv_graph_wrunlock();
 }
 
 
@@ -5164,9 +5165,11 @@ static void bdrv_close(BlockDriverState *bs)
         bs->drv = NULL;
     }
 
+    bdrv_graph_wrlock(NULL);
     QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
         bdrv_unref_child(bs, child);
     }
+    bdrv_graph_wrunlock();
 
     assert(!bs->backing);
     assert(!bs->file);
diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 3ea7141cb5..a0d70729bb 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -251,7 +251,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     ret = 0;
 fail_log:
     if (ret < 0) {
+        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->log_file);
+        bdrv_graph_wrunlock();
         s->log_file = NULL;
     }
 fail:
@@ -263,8 +265,10 @@ static void blk_log_writes_close(BlockDriverState *bs)
 {
     BDRVBlkLogWritesState *s = bs->opaque;
 
+    bdrv_graph_wrlock(NULL);
     bdrv_unref_child(bs, s->log_file);
     s->log_file = NULL;
+    bdrv_graph_wrunlock();
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/blkverify.c b/block/blkverify.c
index 7326461f30..dae9716a26 100644
--- a/block/blkverify.c
+++ b/block/blkverify.c
@@ -151,8 +151,10 @@ static void blkverify_close(BlockDriverState *bs)
 {
     BDRVBlkverifyState *s = bs->opaque;
 
+    bdrv_graph_wrlock(NULL);
     bdrv_unref_child(bs, s->test_file);
     s->test_file = NULL;
+    bdrv_graph_wrunlock();
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/qcow2.c b/block/qcow2.c
index b48cd9ce63..071004b302 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1880,7 +1880,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     g_free(s->image_data_file);
     if (open_data_file && has_data_file(bs)) {
         bdrv_graph_co_rdunlock();
-        bdrv_unref_child(bs, s->data_file);
+        bdrv_co_unref_child(bs, s->data_file);
         bdrv_graph_co_rdlock();
         s->data_file = NULL;
     }
@@ -2790,7 +2790,9 @@ static void qcow2_do_close(BlockDriverState *bs, bool close_data_file)
     g_free(s->image_backing_format);
 
     if (close_data_file && has_data_file(bs)) {
+        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->data_file);
+        bdrv_graph_wrunlock();
         s->data_file = NULL;
     }
 
diff --git a/block/quorum.c b/block/quorum.c
index def0539fda..620a50ba2c 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1037,12 +1037,14 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
 
 close_exit:
     /* cleanup on error */
+    bdrv_graph_wrlock(NULL);
     for (i = 0; i < s->num_children; i++) {
         if (!opened[i]) {
             continue;
         }
         bdrv_unref_child(bs, s->children[i]);
     }
+    bdrv_graph_wrunlock();
     g_free(s->children);
     g_free(opened);
 exit:
@@ -1055,9 +1057,11 @@ static void quorum_close(BlockDriverState *bs)
     BDRVQuorumState *s = bs->opaque;
     int i;
 
+    bdrv_graph_wrlock(NULL);
     for (i = 0; i < s->num_children; i++) {
         bdrv_unref_child(bs, s->children[i]);
     }
+    bdrv_graph_wrunlock();
 
     g_free(s->children);
 }
@@ -1147,7 +1151,9 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
     memmove(&s->children[i], &s->children[i + 1],
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
+    bdrv_graph_wrlock(NULL);
     bdrv_unref_child(bs, child);
+    bdrv_graph_wrunlock();
 
     quorum_refresh_flags(bs);
     bdrv_drained_end(bs);
diff --git a/block/replication.c b/block/replication.c
index eec9819625..dd166d2d82 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -672,10 +672,13 @@ static void replication_done(void *opaque, int ret)
     if (ret == 0) {
         s->stage = BLOCK_REPLICATION_DONE;
 
+        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, s->secondary_disk);
         s->secondary_disk = NULL;
         bdrv_unref_child(bs, s->hidden_disk);
         s->hidden_disk = NULL;
+        bdrv_graph_wrunlock();
+
         s->error = 0;
     } else {
         s->stage = BLOCK_REPLICATION_FAILOVER_FAILED;
diff --git a/block/snapshot.c b/block/snapshot.c
index e22ac3eac6..b86b5b24ad 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -281,7 +281,9 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
         }
 
         /* .bdrv_open() will re-attach it */
+        bdrv_graph_wrlock(NULL);
         bdrv_unref_child(bs, fallback);
+        bdrv_graph_wrunlock();
 
         ret = bdrv_snapshot_goto(fallback_bs, snapshot_id, errp);
         open_ret = drv->bdrv_open(bs, options, bs->open_flags, &local_err);
diff --git a/block/vmdk.c b/block/vmdk.c
index 84185b73a2..78baa04c0c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -272,6 +272,7 @@ static void vmdk_free_extents(BlockDriverState *bs)
     BDRVVmdkState *s = bs->opaque;
     VmdkExtent *e;
 
+    bdrv_graph_wrlock(NULL);
     for (i = 0; i < s->num_extents; i++) {
         e = &s->extents[i];
         g_free(e->l1_table);
@@ -282,6 +283,8 @@ static void vmdk_free_extents(BlockDriverState *bs)
             bdrv_unref_child(bs, e->file);
         }
     }
+    bdrv_graph_wrunlock();
+
     g_free(s->extents);
 }
 
@@ -1220,7 +1223,9 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
             ret = vmdk_add_extent(bs, extent_file, true, sectors,
                             0, 0, 0, 0, 0, &extent, errp);
             if (ret < 0) {
+                bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
+                bdrv_graph_wrunlock();
                 goto out;
             }
             extent->flat_start_offset = flat_offset << 9;
@@ -1235,20 +1240,26 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
             }
             g_free(buf);
             if (ret) {
+                bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
+                bdrv_graph_wrunlock();
                 goto out;
             }
             extent = &s->extents[s->num_extents - 1];
         } else if (!strcmp(type, "SESPARSE")) {
             ret = vmdk_open_se_sparse(bs, extent_file, bs->open_flags, errp);
             if (ret) {
+                bdrv_graph_wrlock(NULL);
                 bdrv_unref_child(bs, extent_file);
+                bdrv_graph_wrunlock();
                 goto out;
             }
             extent = &s->extents[s->num_extents - 1];
         } else {
             error_setg(errp, "Unsupported extent type '%s'", type);
+            bdrv_graph_wrlock(NULL);
             bdrv_unref_child(bs, extent_file);
+            bdrv_graph_wrunlock();
             ret = -ENOTSUP;
             goto out;
         }
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 6d33249656..b040a73bb9 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -967,9 +967,12 @@ typedef struct BDRVTestTopState {
 static void bdrv_test_top_close(BlockDriverState *bs)
 {
     BdrvChild *c, *next_c;
+
+    bdrv_graph_wrlock(NULL);
     QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
         bdrv_unref_child(bs, c);
     }
+    bdrv_graph_wrunlock();
 }
 
 static int coroutine_fn GRAPH_RDLOCK
@@ -1024,7 +1027,7 @@ static void coroutine_fn test_co_delete_by_drain(void *opaque)
     } else {
         BdrvChild *c, *next_c;
         QLIST_FOREACH_SAFE(c, &bs->children, next, next_c) {
-            bdrv_unref_child(bs, c);
+            bdrv_co_unref_child(bs, c);
         }
     }
 
@@ -1162,10 +1165,11 @@ static void detach_indirect_bh(void *opaque)
     struct detach_by_parent_data *data = opaque;
 
     bdrv_dec_in_flight(data->child_b->bs);
+
+    bdrv_graph_wrlock(NULL);
     bdrv_unref_child(data->parent_b, data->child_b);
 
     bdrv_ref(data->c);
-    bdrv_graph_wrlock(NULL);
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
-- 
2.41.0


