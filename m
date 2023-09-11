Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8273779A6F9
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVa-00062y-BX; Mon, 11 Sep 2023 05:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVX-0005yy-Ao
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdVV-0004kF-4P
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWQXFZIL2VBGL4USdnntWKbElfvlxL3xoN7kTdXJkQA=;
 b=Otnw+C/XvOMUOEJtf+Qd/Q3MDJJL95SVDv15CfirZ3MIiFVqA7om7BJ5Qx/DtmAmQJNBs0
 L6aO5l4eS3i+IlA1qTZa2ukmKXzrmXmyWEphHj+GZz/aUJVUfypeAxZ6H/XK7vdSv9z+XF
 eL3jQ/VIvqyyjbE3N0agTqDOOef5nRY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-7UC00CBIO1mt__fdqsMLfA-1; Mon, 11 Sep 2023 05:46:59 -0400
X-MC-Unique: 7UC00CBIO1mt__fdqsMLfA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D89D2802A6E;
 Mon, 11 Sep 2023 09:46:58 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AAB3540C6EA8;
 Mon, 11 Sep 2023 09:46:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 19/21] block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
Date: Mon, 11 Sep 2023 11:46:18 +0200
Message-ID: <20230911094620.45040-20-kwolf@redhat.com>
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

Instead of taking the writer lock internally, require callers to already
hold it when calling bdrv_root_unref_child(). These callers will
typically already hold the graph lock once the locking work is
completed, which means that they can't call functions that take it
internally.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/block_int-global-state.h | 2 +-
 block.c                                | 6 +++---
 block/block-backend.c                  | 3 +++
 blockjob.c                             | 2 ++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index e2304db58b..074b677838 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -202,7 +202,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   BdrvChildRole child_role,
                                   uint64_t perm, uint64_t shared_perm,
                                   void *opaque, Error **errp);
-void bdrv_root_unref_child(BdrvChild *child);
+void GRAPH_WRLOCK bdrv_root_unref_child(BdrvChild *child);
 
 void GRAPH_RDLOCK bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
                                            uint64_t *shared_perm);
diff --git a/block.c b/block.c
index 8e589bb2e4..9ea8333a28 100644
--- a/block.c
+++ b/block.c
@@ -3268,7 +3268,6 @@ void bdrv_root_unref_child(BdrvChild *child)
     BlockDriverState *child_bs = child->bs;
 
     GLOBAL_STATE_CODE();
-    bdrv_graph_wrlock(NULL);
     bdrv_replace_child_noperm(child, NULL);
     bdrv_child_free(child);
 
@@ -3288,8 +3287,7 @@ void bdrv_root_unref_child(BdrvChild *child)
                                     NULL);
     }
 
-    bdrv_graph_wrunlock();
-    bdrv_unref(child_bs);
+    bdrv_schedule_unref(child_bs);
 }
 
 typedef struct BdrvSetInheritsFrom {
@@ -3366,8 +3364,10 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
         return;
     }
 
+    bdrv_graph_wrlock(NULL);
     bdrv_unset_inherits_from(parent, child, NULL);
     bdrv_root_unref_child(child);
+    bdrv_graph_wrunlock();
 }
 
 
diff --git a/block/block-backend.c b/block/block-backend.c
index 8d0282a5d9..c2636f4351 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -915,7 +915,10 @@ void blk_remove_bs(BlockBackend *blk)
     blk_drain(blk);
     root = blk->root;
     blk->root = NULL;
+
+    bdrv_graph_wrlock(NULL);
     bdrv_root_unref_child(root);
+    bdrv_graph_wrunlock();
 }
 
 /*
diff --git a/blockjob.c b/blockjob.c
index 25fe8e625d..58c5d64539 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -198,6 +198,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
      * one to make sure that such a concurrent access does not attempt
      * to process an already freed BdrvChild.
      */
+    bdrv_graph_wrlock(NULL);
     while (job->nodes) {
         GSList *l = job->nodes;
         BdrvChild *c = l->data;
@@ -209,6 +210,7 @@ void block_job_remove_all_bdrv(BlockJob *job)
 
         g_slist_free_1(l);
     }
+    bdrv_graph_wrunlock();
 }
 
 bool block_job_has_bdrv(BlockJob *job, BlockDriverState *bs)
-- 
2.41.0


