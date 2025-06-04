Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC87ACE41C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 20:01:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsMz-0002q0-Tl; Wed, 04 Jun 2025 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsMD-0002KA-3c
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uMsM6-0000Tp-CT
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 13:56:56 -0400
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-agQsJ8A1M2qMQEZ09ollSg-1; Wed,
 04 Jun 2025 13:56:44 -0400
X-MC-Unique: agQsJ8A1M2qMQEZ09ollSg-1
X-Mimecast-MFC-AGG-ID: agQsJ8A1M2qMQEZ09ollSg_1749059803
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E4B91956096; Wed,  4 Jun 2025 17:56:43 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.34.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CD0B818003FD; Wed,  4 Jun 2025 17:56:41 +0000 (UTC)
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 13/24] block: move drain outside of bdrv_attach_child()
Date: Wed,  4 Jun 2025 19:56:02 +0200
Message-ID: <20250604175613.344113-14-kwolf@redhat.com>
In-Reply-To: <20250604175613.344113-1-kwolf@redhat.com>
References: <20250604175613.344113-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Kevin Wolf <kwolf@redhat.com>
From:  Kevin Wolf via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Fiona Ebner <f.ebner@proxmox.com>

This is part of resolving the deadlock mentioned in commit "block:
move draining out of bdrv_change_aio_context() and mark GRAPH_RDLOCK".

The function bdrv_attach_child() runs under the graph lock, so it is
not allowed to drain. It is called by:
1. replication_start()
2. quorum_add_child()
3. bdrv_open_child_common()
4. Throughout test-bdrv-graph-mod.c and test-bdrv-drain.c unit tests.

In all callers, a drained section is introduced.

The function quorum_add_child() runs under the graph lock, so it is
not actually allowed to drain. This will be addressed by the following
commit.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20250530151125.955508-14-f.ebner@proxmox.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                          |  6 ++++--
 block/quorum.c                   |  2 ++
 block/replication.c              |  5 +++++
 tests/unit/test-bdrv-drain.c     | 14 ++++++++++++++
 tests/unit/test-bdrv-graph-mod.c | 10 ++++++++++
 5 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 17c34dc240..6fc87aa318 100644
--- a/block.c
+++ b/block.c
@@ -3269,6 +3269,8 @@ out:
  *
  * On failure NULL is returned, errp is set and the reference to
  * child_bs is also dropped.
+ *
+ * All block nodes must be drained.
  */
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
@@ -3283,7 +3285,6 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     GLOBAL_STATE_CODE();
 
-    bdrv_drain_all_begin();
     child = bdrv_attach_child_noperm(parent_bs, child_bs, child_name,
                                      child_class, child_role, tran, errp);
     if (!child) {
@@ -3298,7 +3299,6 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
 out:
     tran_finalize(tran, ret);
-    bdrv_drain_all_end();
 
     bdrv_schedule_unref(child_bs);
 
@@ -3789,10 +3789,12 @@ static BdrvChild *bdrv_open_child_common(const char *filename,
         return NULL;
     }
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     child = bdrv_attach_child(parent, bs, bdref_key, child_class, child_role,
                               errp);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     return child;
 }
diff --git a/block/quorum.c b/block/quorum.c
index ed8ce801ee..ea17b0ec13 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1096,8 +1096,10 @@ quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs, Error **errp)
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
+    bdrv_drain_all_begin();
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
+    bdrv_drain_all_end();
     if (child == NULL) {
         s->next_child_index--;
         return;
diff --git a/block/replication.c b/block/replication.c
index 07f274de9e..54cbd03e00 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -540,6 +540,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             return;
         }
 
+        bdrv_drain_all_begin();
         bdrv_graph_wrlock();
 
         bdrv_ref(hidden_disk->bs);
@@ -549,6 +550,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             return;
         }
 
@@ -559,6 +561,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         if (local_err) {
             error_propagate(errp, local_err);
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             return;
         }
 
@@ -571,12 +574,14 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             !check_top_bs(top_bs, bs)) {
             error_setg(errp, "No top_bs or it is invalid");
             bdrv_graph_wrunlock();
+            bdrv_drain_all_end();
             reopen_backing_file(bs, false, NULL);
             return;
         }
         bdrv_op_block_all(top_bs, s->blocker);
 
         bdrv_graph_wrunlock();
+        bdrv_drain_all_end();
 
         s->backup_job = backup_job_create(
                                 NULL, s->secondary_disk->bs, s->hidden_disk->bs,
diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
index 4f3057844b..ac76525e5a 100644
--- a/tests/unit/test-bdrv-drain.c
+++ b/tests/unit/test-bdrv-drain.c
@@ -1049,10 +1049,12 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
 
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* This child will be the one to pass to requests through to, and
      * it will stall until a drain occurs */
@@ -1060,21 +1062,25 @@ static void do_test_delete_by_drain(bool detach_instead_of_delete,
                                     &error_abort);
     child_bs->total_sectors = 65536 >> BDRV_SECTOR_BITS;
     /* Takes our reference to child_bs */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     tts->wait_child = bdrv_attach_child(bs, child_bs, "wait-child",
                                         &child_of_bds,
                                         BDRV_CHILD_DATA | BDRV_CHILD_PRIMARY,
                                         &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* This child is just there to be deleted
      * (for detach_instead_of_delete == true) */
     null_bs = bdrv_open("null-co://", NULL, NULL, BDRV_O_RDWR | BDRV_O_PROTOCOL,
                         &error_abort);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(bs, null_bs, "null-child", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     blk = blk_new(qemu_get_aio_context(), BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk, bs, &error_abort);
@@ -1157,6 +1163,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
 
     bdrv_dec_in_flight(data->child_b->bs);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_unref_child(data->parent_b, data->child_b);
 
@@ -1165,6 +1172,7 @@ static void no_coroutine_fn detach_indirect_bh(void *opaque)
                                       &child_of_bds, BDRV_CHILD_DATA,
                                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 }
 
 static void coroutine_mixed_fn detach_by_parent_aio_cb(void *opaque, int ret)
@@ -1262,6 +1270,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
     /* Set child relationships */
     bdrv_ref(b);
     bdrv_ref(a);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     child_b = bdrv_attach_child(parent_b, b, "PB-B", &child_of_bds,
                                 BDRV_CHILD_DATA, &error_abort);
@@ -1273,6 +1282,7 @@ static void TSA_NO_TSA test_detach_indirect(bool by_parent_cb)
                       by_parent_cb ? &child_of_bds : &detach_by_driver_cb_class,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     g_assert_cmpint(parent_a->refcnt, ==, 1);
     g_assert_cmpint(parent_b->refcnt, ==, 1);
@@ -1685,6 +1695,7 @@ static void test_drop_intermediate_poll(void)
      * Establish the chain last, so the chain links are the first
      * elements in the BDS.parents lists
      */
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     for (i = 0; i < 3; i++) {
         if (i) {
@@ -1694,6 +1705,7 @@ static void test_drop_intermediate_poll(void)
         }
     }
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     job = block_job_create("job", &test_simple_job_driver, NULL, job_node,
                            0, BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
@@ -1940,10 +1952,12 @@ static void do_test_replace_child_mid_drain(int old_drain_count,
     new_child_bs->total_sectors = 1;
 
     bdrv_ref(old_child_bs);
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(parent_bs, old_child_bs, "child", &child_of_bds,
                       BDRV_CHILD_COW, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     parent_s->setup_completed = true;
 
     for (i = 0; i < old_drain_count; i++) {
diff --git a/tests/unit/test-bdrv-graph-mod.c b/tests/unit/test-bdrv-graph-mod.c
index d743abb4bb..7b03ebe4b0 100644
--- a/tests/unit/test-bdrv-graph-mod.c
+++ b/tests/unit/test-bdrv-graph-mod.c
@@ -137,10 +137,12 @@ static void test_update_perm_tree(void)
 
     blk_insert_bs(root, bs, &error_abort);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(filter, bs, "child", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     ret = bdrv_append(filter, bs, NULL);
     g_assert_cmpint(ret, <, 0);
@@ -204,11 +206,13 @@ static void test_should_update_child(void)
 
     bdrv_set_backing_hd(target, bs, &error_abort);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     g_assert(target->backing->bs == bs);
     bdrv_attach_child(filter, target, "target", &child_of_bds,
                       BDRV_CHILD_DATA, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
     bdrv_append(filter, bs, &error_abort);
 
     bdrv_graph_rdlock_main_loop();
@@ -244,6 +248,7 @@ static void test_parallel_exclusive_write(void)
     bdrv_ref(base);
     bdrv_ref(fl1);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, fl1, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
@@ -257,6 +262,7 @@ static void test_parallel_exclusive_write(void)
 
     bdrv_replace_node(fl1, fl2, &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     bdrv_drained_end(fl2);
     bdrv_drained_end(fl1);
@@ -363,6 +369,7 @@ static void test_parallel_perm_update(void)
      */
     bdrv_ref(base);
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, ws, "file", &child_of_bds, BDRV_CHILD_DATA,
                       &error_abort);
@@ -377,6 +384,7 @@ static void test_parallel_perm_update(void)
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     /* Select fl1 as first child to be active */
     s->selected = c_fl1;
@@ -430,11 +438,13 @@ static void test_append_greedy_filter(void)
     BlockDriverState *base = no_perm_node("base");
     BlockDriverState *fl = exclusive_writer_node("fl1");
 
+    bdrv_drain_all_begin();
     bdrv_graph_wrlock();
     bdrv_attach_child(top, base, "backing", &child_of_bds,
                       BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY,
                       &error_abort);
     bdrv_graph_wrunlock();
+    bdrv_drain_all_end();
 
     bdrv_append(fl, base, &error_abort);
     bdrv_unref(fl);
-- 
2.49.0


