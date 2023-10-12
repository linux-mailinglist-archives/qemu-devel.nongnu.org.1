Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6B67C72CE
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:31:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySt-0003d1-RU; Thu, 12 Oct 2023 12:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySm-0003ZG-QD
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySb-0000cW-2S
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ft8GAeSk8cUXJIECsiOjx95sWtq2WekCrZ15z2k+F38=;
 b=XCiiqJMbT+JIsi7qVPzHmLC1LnNhPP0VJW/1aOK6dXS/8eFkupEq9bj5aZZw6g0dHdfQmw
 an/tOvRsMAb/DRp8PQZIkAXVcp2ZlBIXiQHULSGk20ye8dLcz47Z5bXQIZUkzJBir9TMxo
 Duv0JkeFrapvseFY2r+kZ7NzbWYzGTE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-md5aYiZxO0OA2fLGGiArlQ-1; Thu, 12 Oct 2023 12:22:45 -0400
X-MC-Unique: md5aYiZxO0OA2fLGGiArlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FF2B3C17098;
 Thu, 12 Oct 2023 16:22:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C43D9202701E;
 Thu, 12 Oct 2023 16:22:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 12/26] block: Take graph rdlock in parts of reopen
Date: Thu, 12 Oct 2023 18:22:10 +0200
Message-ID: <20231012162224.240535-13-kwolf@redhat.com>
In-Reply-To: <20231012162224.240535-1-kwolf@redhat.com>
References: <20231012162224.240535-1-kwolf@redhat.com>
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

Reopen isn't easy with respect to locking because many of its functions
need to iterate the graph, some change it, and then you get some drains
in the middle where you can't hold any locks.

Therefore just documents most of the functions to be unlocked, and take
locks internally before accessing the graph.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20230929145157.45443-9-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-common.h | 13 +++++---
 block.c                          | 57 ++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 29c5b8a3c5..0373cbed49 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -235,11 +235,14 @@ struct BlockDriver {
                                 Error **errp);
 
     /* For handling image reopen for split or non-split files. */
-    int (*bdrv_reopen_prepare)(BDRVReopenState *reopen_state,
-                               BlockReopenQueue *queue, Error **errp);
-    void (*bdrv_reopen_commit)(BDRVReopenState *reopen_state);
-    void (*bdrv_reopen_commit_post)(BDRVReopenState *reopen_state);
-    void (*bdrv_reopen_abort)(BDRVReopenState *reopen_state);
+    int GRAPH_UNLOCKED_PTR (*bdrv_reopen_prepare)(
+        BDRVReopenState *reopen_state, BlockReopenQueue *queue, Error **errp);
+    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit)(
+        BDRVReopenState *reopen_state);
+    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_commit_post)(
+        BDRVReopenState *reopen_state);
+    void GRAPH_UNLOCKED_PTR (*bdrv_reopen_abort)(
+        BDRVReopenState *reopen_state);
     void (*bdrv_join_options)(QDict *options, QDict *old_options);
 
     int GRAPH_UNLOCKED_PTR (*bdrv_open)(
diff --git a/block.c b/block.c
index 6cc4115510..084ff14509 100644
--- a/block.c
+++ b/block.c
@@ -4314,8 +4314,8 @@ static int bdrv_reset_options_allowed(BlockDriverState *bs,
 /*
  * Returns true if @child can be reached recursively from @bs
  */
-static bool bdrv_recurse_has_child(BlockDriverState *bs,
-                                   BlockDriverState *child)
+static bool GRAPH_RDLOCK
+bdrv_recurse_has_child(BlockDriverState *bs, BlockDriverState *child)
 {
     BdrvChild *c;
 
@@ -4356,15 +4356,12 @@ static bool bdrv_recurse_has_child(BlockDriverState *bs,
  *
  * To be called with bs->aio_context locked.
  */
-static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
-                                                 BlockDriverState *bs,
-                                                 QDict *options,
-                                                 const BdrvChildClass *klass,
-                                                 BdrvChildRole role,
-                                                 bool parent_is_format,
-                                                 QDict *parent_options,
-                                                 int parent_flags,
-                                                 bool keep_old_opts)
+static BlockReopenQueue * GRAPH_RDLOCK
+bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
+                        QDict *options, const BdrvChildClass *klass,
+                        BdrvChildRole role, bool parent_is_format,
+                        QDict *parent_options, int parent_flags,
+                        bool keep_old_opts)
 {
     assert(bs != NULL);
 
@@ -4376,6 +4373,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
 
     GLOBAL_STATE_CODE();
 
+    /*
+     * Strictly speaking, draining is illegal under GRAPH_RDLOCK. We know that
+     * we've been called with bdrv_graph_rdlock_main_loop(), though, so it's ok
+     * in practice.
+     */
     bdrv_drained_begin(bs);
 
     if (bs_queue == NULL) {
@@ -4517,6 +4519,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     QDict *options, bool keep_old_opts)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, 0, false,
                                    NULL, 0, keep_old_opts);
@@ -4736,9 +4739,10 @@ int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
  * Callers must make sure that their AioContext locking is still correct after
  * this.
  */
-static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
-                                             bool is_backing, Transaction *tran,
-                                             Error **errp)
+static int GRAPH_UNLOCKED
+bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
+                                  bool is_backing, Transaction *tran,
+                                  Error **errp)
 {
     BlockDriverState *bs = reopen_state->bs;
     BlockDriverState *new_child_bs;
@@ -4748,6 +4752,7 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
     QObject *value;
     const char *str;
     AioContext *ctx, *old_ctx;
+    bool has_child;
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -4767,7 +4772,13 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
         new_child_bs = bdrv_lookup_bs(NULL, str, errp);
         if (new_child_bs == NULL) {
             return -EINVAL;
-        } else if (bdrv_recurse_has_child(new_child_bs, bs)) {
+        }
+
+        bdrv_graph_rdlock_main_loop();
+        has_child = bdrv_recurse_has_child(new_child_bs, bs);
+        bdrv_graph_rdunlock_main_loop();
+
+        if (has_child) {
             error_setg(errp, "Making '%s' a %s child of '%s' would create a "
                        "cycle", str, child_name, bs->node_name);
             return -EINVAL;
@@ -4866,9 +4877,9 @@ static int bdrv_reopen_parse_file_or_backing(BDRVReopenState *reopen_state,
  * After calling this function, the transaction @change_child_tran may only be
  * completed while holding a writer lock for the graph.
  */
-static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
-                               BlockReopenQueue *queue,
-                               Transaction *change_child_tran, Error **errp)
+static int GRAPH_UNLOCKED
+bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
+                    Transaction *change_child_tran, Error **errp)
 {
     int ret = -1;
     int old_flags;
@@ -5010,6 +5021,8 @@ static int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
     if (qdict_size(reopen_state->options)) {
         const QDictEntry *entry = qdict_first(reopen_state->options);
 
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
         do {
             QObject *new = entry->value;
             QObject *old = qdict_get(reopen_state->bs->options, entry->key);
@@ -5083,7 +5096,7 @@ error:
  * makes them final by swapping the staging BlockDriverState contents into
  * the active BlockDriverState contents.
  */
-static void bdrv_reopen_commit(BDRVReopenState *reopen_state)
+static void GRAPH_UNLOCKED bdrv_reopen_commit(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
     BlockDriverState *bs;
@@ -5100,6 +5113,8 @@ static void bdrv_reopen_commit(BDRVReopenState *reopen_state)
         drv->bdrv_reopen_commit(reopen_state);
     }
 
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     /* set BDS specific flags now */
     qobject_unref(bs->explicit_options);
     qobject_unref(bs->options);
@@ -5121,9 +5136,7 @@ static void bdrv_reopen_commit(BDRVReopenState *reopen_state)
     qdict_del(bs->explicit_options, "backing");
     qdict_del(bs->options, "backing");
 
-    bdrv_graph_rdlock_main_loop();
     bdrv_refresh_limits(bs, NULL, NULL);
-    bdrv_graph_rdunlock_main_loop();
     bdrv_refresh_total_sectors(bs, bs->total_sectors);
 }
 
@@ -5131,7 +5144,7 @@ static void bdrv_reopen_commit(BDRVReopenState *reopen_state)
  * Abort the reopen, and delete and free the staged changes in
  * reopen_state
  */
-static void bdrv_reopen_abort(BDRVReopenState *reopen_state)
+static void GRAPH_UNLOCKED bdrv_reopen_abort(BDRVReopenState *reopen_state)
 {
     BlockDriver *drv;
 
-- 
2.41.0


