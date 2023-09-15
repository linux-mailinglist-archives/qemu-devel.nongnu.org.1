Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A99D7A214B
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3I-0000EX-Mj; Fri, 15 Sep 2023 10:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3A-0008Vl-SH
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA38-0004ym-Tz
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6EUkit0xMHtJ4so0G6TDNmWl9zDVLIzk+bi2i8HzCs=;
 b=A+RlO+yOstAy9phmyZDPine2qos8Xtp4jqyMqXPlF8BDggYdUt9C4DDOSCiOJMFVFlQgVp
 LlE8zmiyq6X5EZ4uGVSPnWysjV619c8+pJ2p+uGvMSdlILOlqle6TzJaTSl5IGdJapR13G
 zE3bBt3Avh41RG9B+0eR+1wLd7phzyA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-UmwyG1gMNV653i01LRz7-Q-1; Fri, 15 Sep 2023 10:43:58 -0400
X-MC-Unique: UmwyG1gMNV653i01LRz7-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9DFE918162CC;
 Fri, 15 Sep 2023 14:43:58 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B7102026D4B;
 Fri, 15 Sep 2023 14:43:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/28] block: Mark bdrv_attach_child() GRAPH_WRLOCK
Date: Fri, 15 Sep 2023 16:43:28 +0200
Message-ID: <20230915144344.238596-13-kwolf@redhat.com>
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
hold it when calling bdrv_attach_child_common(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-13-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h | 14 ++++++++------
 block.c                            |  7 +++----
 block/quorum.c                     |  2 ++
 block/replication.c                |  6 ++++++
 tests/unit/test-bdrv-drain.c       | 14 ++++++++++++++
 tests/unit/test-bdrv-graph-mod.c   | 10 ++++++++++
 6 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index e570799f85..eb12a35439 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -226,12 +226,14 @@ void no_coroutine_fn bdrv_unref(BlockDriverState *bs);
 void coroutine_fn no_co_wrapper bdrv_co_unref(BlockDriverState *bs);
 void GRAPH_WRLOCK bdrv_schedule_unref(BlockDriverState *bs);
 void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
-BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
-                             BlockDriverState *child_bs,
-                             const char *child_name,
-                             const BdrvChildClass *child_class,
-                             BdrvChildRole child_role,
-                             Error **errp);
+
+BdrvChild * GRAPH_WRLOCK
+bdrv_attach_child(BlockDriverState *parent_bs,
+                  BlockDriverState *child_bs,
+                  const char *child_name,
+                  const BdrvChildClass *child_class,
+                  BdrvChildRole child_role,
+                  Error **errp);
 
 bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
 void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason);
diff --git a/block.c b/block.c
index f06de58a3b..369023872a 100644
--- a/block.c
+++ b/block.c
@@ -3219,8 +3219,6 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     GLOBAL_STATE_CODE();
 
-    bdrv_graph_wrlock(child_bs);
-
     child = bdrv_attach_child_noperm(parent_bs, child_bs, child_name,
                                      child_class, child_role, tran, errp);
     if (!child) {
@@ -3235,9 +3233,8 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
 out:
     tran_finalize(tran, ret);
-    bdrv_graph_wrunlock();
 
-    bdrv_unref(child_bs);
+    bdrv_schedule_unref(child_bs);
 
     return ret < 0 ? NULL : child;
 }
@@ -3758,11 +3755,13 @@ BdrvChild *bdrv_open_child(const char *filename,
         return NULL;
     }
 
+    bdrv_graph_wrlock(NULL);
     ctx = bdrv_get_aio_context(bs);
     aio_context_acquire(ctx);
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     aio_context_release(ctx);
+    bdrv_graph_wrunlock();
 
     return child;
 }
diff --git a/block/quorum.c b/block/quorum.c
index f28758cf2b..def0539fda 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1094,8 +1094,10 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
+    bdrv_graph_wrlock(child_bs);
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
+    bdrv_graph_wrunlock();
     if (child == NULL) {
         s->next_child_index--;
         goto out;
diff --git a/block/replication.c b/block/replication.c
index ea4bf1aa80..eec9819625 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -542,12 +542,15 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
+        bdrv_graph_wrlock(bs);
+
         bdrv_ref(hidden_disk->bs);
         s->hidden_disk = bdrv_attach_child(bs, hidden_disk->bs, "hidden disk",
                                            &child_of_bds, BDRV_CHILD_DATA,
                                            &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
+            bdrv_graph_wrunlock();
             aio_context_release(aio_context);
             return;
         }
@@ -558,10 +561,13 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
                                               BDRV_CHILD_DATA, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
+            bdrv_graph_wrunlock();
             aio_context_release(aio_context);
             return;
         }
 
+        bdrv_graph_wrunlock();
+
         /* start backup job now */
         error_setg(&s->blocker,
                    "Block device is in use by internal backup job");
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 89c8fa6780..6d33249656 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1055,8 +1055,10 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
+    bdrv_graph_wrunlock();
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1064,17 +1066,21 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
+    bdrv_graph_wrlock(NULL);
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
+    bdrv_graph_wrunlock();
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
+    bdrv_graph_wrunlock();
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1159,9 +1165,11 @@ static void detach_indirect_bh(void *opaque)
     bdrv_unref_child(data->parent_b, data->child_b);
 
     bdrv_ref(data->c);
+    bdrv_graph_wrlock(NULL);
     data->child_c = bdrv_attach_child(data->parent_b, data->c, "PB-C",
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
+    bdrv_graph_wrunlock();
 }
 
 static void detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1258,6 +1266,7 @@ static void test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
+    bdrv_graph_wrlock(NULL);
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
                                 BDRV_CHILD_DATA, &error_abort);
     child_a = bdrv_attach_child(parent_b, a, "PB-A", &child_of_bds,
@@ -1267,6 +1276,7 @@ static void test_detach_indirect(bool by_parent_cb)
     bdrv_attach_child(parent_a, a, "PA-A",
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
+    bdrv_graph_wrunlock();
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1685,6 +1695,7 @@ static void test_drop_intermediate_poll(void)
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
+    bdrv_graph_wrlock(NULL);
     for (i = 0; i < 3; i++) {
         if (i) {
             /* Takes the reference to chain[i - 1] */
@@ -1692,6 +1703,7 @@ static void test_drop_intermediate_poll(void)
                               &chain_child_class, BDRV_CHILD_COW, &error_abort);
         }
     }
+    bdrv_graph_wrunlock();
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1936,8 +1948,10 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     new_child_bs->total_sectors = 1;
 
     bdrv_ref(old_child_bs);
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
+    bdrv_graph_wrunlock();
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index d8503165b3..621e616655 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -137,8 +137,10 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
+    bdrv_graph_wrunlock();
 
     aio_context_acquire(qemu_get_aio_context());
     ret = bdrv_append(filter, bs, NULL);
@@ -205,8 +207,10 @@ static void test_should_update_child(void)
     bdrv_set_backing_hd(target, bs, &error_abort);
 
     g_assert(target->backing->bs == bs);
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
+    bdrv_graph_wrunlock();
     aio_context_acquire(qemu_get_aio_context());
     bdrv_append(filter, bs, &error_abort);
     aio_context_release(qemu_get_aio_context());
@@ -236,6 +240,7 @@ static void test_parallel_exclusive_write(void)
      */
     bdrv_ref(base);
 
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
@@ -245,6 +250,7 @@ static void test_parallel_exclusive_write(void)
     bdrv_attach_child(fl2, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
+    bdrv_graph_wrunlock();
 
     bdrv_replace_node(fl1, fl2, &error_abort);
 
@@ -349,6 +355,7 @@ static void test_parallel_perm_update(void)
      */
     bdrv_ref(base);
 
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(top, ws, "file", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     c_fl1 = bdrv_attach_child(ws, fl1, "first", &child_of_bds,
@@ -361,6 +368,7 @@ static void test_parallel_perm_update(void)
     bdrv_attach_child(fl2, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
+    bdrv_graph_wrunlock();
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -410,9 +418,11 @@ static void test_append_greedy_filter(void)
     BlockDriverState *base = no_perm_node("base");
     BlockDriverState *fl = exclusive_writer_node("fl1");
 
+    bdrv_graph_wrlock(NULL);
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
+    bdrv_graph_wrunlock();
 
     aio_context_acquire(qemu_get_aio_context());
     bdrv_append(fl, base, &error_abort);
-- 
2.41.0


