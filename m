Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8887A2160
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:48:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3V-0000QM-A3; Fri, 15 Sep 2023 10:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3L-0000G3-0w
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA3F-00053i-7b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A8G6NAW9jZY/fgwHKnmLCg3OnjDvkm0AFU6wGYaKWGU=;
 b=AbqxPLRtAIuP/IooZPSoo7yVpq31TwtX4v1pv6BZHJ0JAJm0CKl7+T4sxk6s1DI0x4VefY
 NMfLtmCk4wgfFMX7KnYECmOufwxTqinom0flOF9Wb2F7Ozt0Rz7XdWF2+rkuMIBE+7EnRK
 dhnQ8Gid2quYB8YBDKhT9Oi7660PX34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-KVtHCkdRMkiGOjhhtI7dFw-1; Fri, 15 Sep 2023 10:44:07 -0400
X-MC-Unique: KVtHCkdRMkiGOjhhtI7dFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2AD118162C0;
 Fri, 15 Sep 2023 14:44:05 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 614B62026D4B;
 Fri, 15 Sep 2023 14:44:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 21/28] block: Mark bdrv_add/del_child() and caller GRAPH_WRLOCK
Date: Fri, 15 Sep 2023 16:43:37 +0200
Message-ID: <20230915144344.238596-22-kwolf@redhat.com>
In-Reply-To: <20230915144344.238596-1-kwolf@redhat.com>
References: <20230915144344.238596-1-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The functions read the parents list in the generic block layer, so we
need to hold the graph lock already there. The BlockDriver
implementations actually modify the graph, so it has to be a writer
lock.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230911094620.45040-22-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  8 +++++---
 include/block/block_int-common.h   |  9 +++++----
 block/quorum.c                     | 23 ++++++-----------------
 blockdev.c                         | 17 +++++++++++------
 4 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 0f6df8f1a2..f31660c7b1 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -276,9 +276,11 @@ int bdrv_try_change_aio_context(BlockDriverState *bs, AioContext *ctx,
 int bdrv_probe_blocksizes(BlockDriverState *bs, BlockSizes *bsz);
 int bdrv_probe_geometry(BlockDriverState *bs, HDGeometry *geo);
 
-void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
-                    Error **errp);
-void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
+void GRAPH_WRLOCK
+bdrv_add_child(BlockDriverState *parent, BlockDriverState *child, Error **errp);
+
+void GRAPH_WRLOCK
+bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
 
 /**
  *
diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 3feb67ec4a..2ca3758cb8 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -393,10 +393,11 @@ struct BlockDriver {
      */
     int (*bdrv_probe_geometry)(BlockDriverState *bs, HDGeometry *geo);
 
-    void (*bdrv_add_child)(BlockDriverState *parent, BlockDriverState *child,
-                           Error **errp);
-    void (*bdrv_del_child)(BlockDriverState *parent, BdrvChild *child,
-                           Error **errp);
+    void GRAPH_WRLOCK_PTR (*bdrv_add_child)(
+        BlockDriverState *parent, BlockDriverState *child, Error **errp);
+
+    void GRAPH_WRLOCK_PTR (*bdrv_del_child)(
+        BlockDriverState *parent, BdrvChild *child, Error **errp);
 
     /**
      * Informs the block driver that a permission change is intended. The
diff --git a/block/quorum.c b/block/quorum.c
index 620a50ba2c..05220cab7f 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1066,8 +1066,8 @@ static void quorum_close(BlockDriverState *bs)
     g_free(s->children);
 }
 
-static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
-                             Error **errp)
+static void GRAPH_WRLOCK
+quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs, Error **errp)
 {
     BDRVQuorumState *s = bs->opaque;
     BdrvChild *child;
@@ -1093,29 +1093,22 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
     }
     s->next_child_index++;
 
-    bdrv_drained_begin(bs);
-
     /* We can safely add the child now */
     bdrv_ref(child_bs);
 
-    bdrv_graph_wrlock(child_bs);
     child = bdrv_attach_child(bs, child_bs, indexstr, &child_of_bds,
                               BDRV_CHILD_DATA, errp);
-    bdrv_graph_wrunlock();
     if (child == NULL) {
         s->next_child_index--;
-        goto out;
+        return;
     }
     s->children = g_renew(BdrvChild *, s->children, s->num_children + 1);
     s->children[s->num_children++] = child;
     quorum_refresh_flags(bs);
-
-out:
-    bdrv_drained_end(bs);
 }
 
-static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
-                             Error **errp)
+static void GRAPH_WRLOCK
+quorum_del_child(BlockDriverState *bs, BdrvChild *child, Error **errp)
 {
     BDRVQuorumState *s = bs->opaque;
     char indexstr[INDEXSTR_LEN];
@@ -1145,18 +1138,14 @@ static void quorum_del_child(BlockDriverState *bs, BdrvChild *child,
         s->next_child_index--;
     }
 
-    bdrv_drained_begin(bs);
-
     /* We can safely remove this child now */
     memmove(&s->children[i], &s->children[i + 1],
             (s->num_children - i - 1) * sizeof(BdrvChild *));
     s->children = g_renew(BdrvChild *, s->children, --s->num_children);
-    bdrv_graph_wrlock(NULL);
+
     bdrv_unref_child(bs, child);
-    bdrv_graph_wrunlock();
 
     quorum_refresh_flags(bs);
-    bdrv_drained_end(bs);
 }
 
 static void quorum_gather_child_options(BlockDriverState *bs, QDict *target,
diff --git a/blockdev.c b/blockdev.c
index 372eaf198c..325b7a3bef 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3545,8 +3545,8 @@ out:
     aio_context_release(aio_context);
 }
 
-static BdrvChild *bdrv_find_child(BlockDriverState *parent_bs,
-                                  const char *child_name)
+static BdrvChild * GRAPH_RDLOCK
+bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
 {
     BdrvChild *child;
 
@@ -3565,9 +3565,11 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
     BlockDriverState *parent_bs, *new_bs = NULL;
     BdrvChild *p_child;
 
+    bdrv_graph_wrlock(NULL);
+
     parent_bs = bdrv_lookup_bs(parent, parent, errp);
     if (!parent_bs) {
-        return;
+        goto out;
     }
 
     if (!child == !node) {
@@ -3576,7 +3578,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
         } else {
             error_setg(errp, "Either child or node must be specified");
         }
-        return;
+        goto out;
     }
 
     if (child) {
@@ -3584,7 +3586,7 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
         if (!p_child) {
             error_setg(errp, "Node '%s' does not have child '%s'",
                        parent, child);
-            return;
+            goto out;
         }
         bdrv_del_child(parent_bs, p_child, errp);
     }
@@ -3593,10 +3595,13 @@ void qmp_x_blockdev_change(const char *parent, const char *child,
         new_bs = bdrv_find_node(node);
         if (!new_bs) {
             error_setg(errp, "Node '%s' not found", node);
-            return;
+            goto out;
         }
         bdrv_add_child(parent_bs, new_bs, errp);
     }
+
+out:
+    bdrv_graph_wrunlock();
 }
 
 BlockJobInfoList *qmp_query_block_jobs(Error **errp)
-- 
2.41.0


