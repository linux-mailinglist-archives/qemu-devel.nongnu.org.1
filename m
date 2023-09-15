Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D987A2149
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3I-0000Eg-Mv; Fri, 15 Sep 2023 10:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3A-0008Vm-Sa
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA38-0004yg-P4
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+Bu4WjkVn3UhEAborWC1KInxUO3ycIk4RChpbs5yds=;
 b=WEyEqPnZAJ6hK8CS2vyI/hukAuKa7Kgs8eV55As6o/iluAEG04XLbKqrgI11+vmABgu0US
 eNi6li9yTC9PaYdAx7ULhX3Q0AgYbt5pojbI+1WROwv5tMskRSH92slLfOjXEE+2NyGbFt
 5YlPy7pDEWiSpXxvVJj9PtEUOVGkeFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-IK05ZSHTOs-6jM9DasUaJg-1; Fri, 15 Sep 2023 10:44:00 -0400
X-MC-Unique: IK05ZSHTOs-6jM9DasUaJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 448AB101B048;
 Fri, 15 Sep 2023 14:44:00 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A68DB2026D4B;
 Fri, 15 Sep 2023 14:43:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 14/28] block: Mark bdrv_get_cumulative_perm() and callers
 GRAPH_RDLOCK
Date: Fri, 15 Sep 2023 16:43:30 +0200
Message-ID: <20230915144344.238596-15-kwolf@redhat.com>
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

The function reads the parents list, so it needs to hold the graph lock.

This happens to result in BlockDriver.bdrv_set_perm() to be called with
the graph lock held. For consistency, make it the same for all of the
BlockDriver callbacks for updating permissions and annotate the function
pointers with GRAPH_RDLOCK_PTR.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-15-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h       |  9 ++++---
 include/block/block_int-global-state.h |  4 +--
 block.c                                | 35 ++++++++++++++++++++------
 blockdev.c                             |  6 +++++
 4 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index fda9d8b5c8..f82c14fb9c 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -413,8 +413,8 @@ struct BlockDriver {
      * If both conditions are met, 0 is returned. Otherwise, -errno is returned
      * and errp is set to an error describing the conflict.
      */
-    int (*bdrv_check_perm)(BlockDriverState *bs, uint64_t perm,
-                           uint64_t shared, Error **errp);
+    int GRAPH_RDLOCK_PTR (*bdrv_check_perm)(BlockDriverState *bs, uint64_t perm,
+                                            uint64_t shared, Error **errp);
 
     /**
      * Called to inform the driver that the set of cumulative set of used
@@ -426,7 +426,8 @@ struct BlockDriver {
      * This function is only invoked after bdrv_check_perm(), so block drivers
      * may rely on preparations made in their .bdrv_check_perm implementation.
      */
-    void (*bdrv_set_perm)(BlockDriverState *bs, uint64_t perm, uint64_t shared);
+    void GRAPH_RDLOCK_PTR (*bdrv_set_perm)(
+        BlockDriverState *bs, uint64_t perm, uint64_t shared);
 
     /*
      * Called to inform the driver that after a previous bdrv_check_perm()
@@ -436,7 +437,7 @@ struct BlockDriver {
      * This function can be called even for nodes that never saw a
      * bdrv_check_perm() call. It is a no-op then.
      */
-    void (*bdrv_abort_perm_update)(BlockDriverState *bs);
+    void GRAPH_RDLOCK_PTR (*bdrv_abort_perm_update)(BlockDriverState *bs);
 
     /**
      * Returns in @nperm and @nshared the permissions that the driver for @bs
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index bebcc08bce..e2304db58b 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -204,8 +204,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
 
-void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
-                              uint64_t *shared_perm);
+void GRAPH_RDLOCK bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
+                                           uint64_t *shared_perm);
 
 /**
  * Sets a BdrvChild's permissions.  Avoid if the parent is a BDS; use
diff --git a/block.c b/block.c
index 6720bc4f8a..186efda70f 100644
--- a/block.c
+++ b/block.c
@@ -2320,7 +2320,7 @@ static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm,
     tran_add(tran, &bdrv_child_set_pem_drv, s);
 }
 
-static void bdrv_drv_set_perm_commit(void *opaque)
+static void GRAPH_RDLOCK bdrv_drv_set_perm_commit(void *opaque)
 {
     BlockDriverState *bs = opaque;
     uint64_t cumulative_perms, cumulative_shared_perms;
@@ -2333,7 +2333,7 @@ static void bdrv_drv_set_perm_commit(void *opaque)
     }
 }
 
-static void bdrv_drv_set_perm_abort(void *opaque)
+static void GRAPH_RDLOCK bdrv_drv_set_perm_abort(void *opaque)
 {
     BlockDriverState *bs = opaque;
     GLOBAL_STATE_CODE();
@@ -2348,9 +2348,13 @@ TransactionActionDrv bdrv_drv_set_perm_drv = {
     .commit = bdrv_drv_set_perm_commit,
 };
 
-static int bdrv_drv_set_perm(BlockDriverState *bs, uint64_t perm,
-                             uint64_t shared_perm, Transaction *tran,
-                             Error **errp)
+/*
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a reader lock for the graph.
+ */
+static int GRAPH_RDLOCK
+bdrv_drv_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared_perm,
+                  Transaction *tran, Error **errp)
 {
     GLOBAL_STATE_CODE();
     if (!bs->drv) {
@@ -2457,9 +2461,13 @@ bdrv_replace_child_tran(BdrvChild *child, BlockDriverState *new_bs,
 /*
  * Refresh permissions in @bs subtree. The function is intended to be called
  * after some graph modification that was done without permission update.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a reader lock for the graph.
  */
-static int bdrv_node_refresh_perm(BlockDriverState *bs, BlockReopenQueue *q,
-                                  Transaction *tran, Error **errp)
+static int GRAPH_RDLOCK
+bdrv_node_refresh_perm(BlockDriverState *bs, BlockReopenQueue *q,
+                       Transaction *tran, Error **errp)
 {
     BlockDriver *drv = bs->drv;
     BdrvChild *c;
@@ -2532,6 +2540,9 @@ static int bdrv_node_refresh_perm(BlockDriverState *bs, BlockReopenQueue *q,
 /*
  * @list is a product of bdrv_topological_dfs() (may be called several times) -
  * a topologically sorted subgraph.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a reader lock for the graph.
  */
 static int GRAPH_RDLOCK
 bdrv_do_refresh_perms(GSList *list, BlockReopenQueue *q, Transaction *tran,
@@ -2561,6 +2572,9 @@ bdrv_do_refresh_perms(GSList *list, BlockReopenQueue *q, Transaction *tran,
  * @list is any list of nodes. List is completed by all subtrees and
  * topologically sorted. It's not a problem if some node occurs in the @list
  * several times.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a reader lock for the graph.
  */
 static int GRAPH_RDLOCK
 bdrv_list_refresh_perms(GSList *list, BlockReopenQueue *q, Transaction *tran,
@@ -2623,7 +2637,12 @@ char *bdrv_perm_names(uint64_t perm)
 }
 
 
-/* @tran is allowed to be NULL. In this case no rollback is possible */
+/*
+ * @tran is allowed to be NULL. In this case no rollback is possible.
+ *
+ * After calling this function, the transaction @tran may only be completed
+ * while holding a reader lock for the graph.
+ */
 static int GRAPH_RDLOCK
 bdrv_refresh_perms(BlockDriverState *bs, Transaction *tran, Error **errp)
 {
diff --git a/blockdev.c b/blockdev.c
index e6eba61484..372eaf198c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1378,6 +1378,9 @@ static void external_snapshot_action(TransactionAction *action,
     AioContext *aio_context;
     uint64_t perm, shared;
 
+    /* TODO We'll eventually have to take a writer lock in this function */
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     tran_add(tran, &external_snapshot_drv, state);
 
     /* 'blockdev-snapshot' and 'blockdev-snapshot-sync' have similar
@@ -2521,6 +2524,9 @@ void qmp_block_commit(const char *job_id, const char *device,
     int job_flags = JOB_DEFAULT;
     uint64_t top_perm, top_shared;
 
+    /* TODO We'll eventually have to take a writer lock in this function */
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     if (!has_speed) {
         speed = 0;
     }
-- 
2.41.0


