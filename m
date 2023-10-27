Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 941AA7D9D8C
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwPAB-0003v5-T6; Fri, 27 Oct 2023 11:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9q-0003Wr-S0
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qwP9l-0002eg-Qg
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698422032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BR9QUUGdhAAxg3GK1bTg935xvmOqd5Yhf7t1CpbJhcs=;
 b=Lbo8NVZx39UzK/x/Uh6h/LdG4+QrpyLQY3X4mJpzkAfUCCuCwGP3zSV9gqCBKxyGX8cNWS
 eC/5JGZGs9p+CeMe+uGKZdjXaSemc7GMhgzUANpJMyRAXyP9pCVEqVy09c056lJK2/igiL
 9pD85P7mpcPxIJ/qdhLqt2XH/qc6PTo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ATozQVssPiCkidLXe3ISbg-1; Fri, 27 Oct 2023 11:53:50 -0400
X-MC-Unique: ATozQVssPiCkidLXe3ISbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06A1C101A54C;
 Fri, 27 Oct 2023 15:53:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CDB65502A;
 Fri, 27 Oct 2023 15:53:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 06/24] block: Mark bdrv_filter_or_cow_bs() and callers
 GRAPH_RDLOCK
Date: Fri, 27 Oct 2023 17:53:15 +0200
Message-ID: <20231027155333.420094-7-kwolf@redhat.com>
In-Reply-To: <20231027155333.420094-1-kwolf@redhat.com>
References: <20231027155333.420094-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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
bdrv_filter_or_cow_bs() need to hold a reader lock for the graph because
it calls bdrv_filter_or_cow_child(), which accesses bs->file/backing.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h |  3 ++-
 block.c                      | 31 ++++++++++++++++++-------------
 block/stream.c               |  4 ++++
 blockdev.c                   |  2 +-
 nbd/server.c                 |  6 ++++++
 5 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index 26bff94e4e..6800af7590 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -150,7 +150,8 @@ bdrv_filter_bs(BlockDriverState *bs)
     return child_bs(bdrv_filter_child(bs));
 }
 
-static inline BlockDriverState *bdrv_filter_or_cow_bs(BlockDriverState *bs)
+static inline BlockDriverState * GRAPH_RDLOCK
+bdrv_filter_or_cow_bs(BlockDriverState *bs)
 {
     IO_CODE();
     return child_bs(bdrv_filter_or_cow_child(bs));
diff --git a/block.c b/block.c
index 5f92eb4950..a6060eddbc 100644
--- a/block.c
+++ b/block.c
@@ -5435,17 +5435,6 @@ static int bdrv_replace_node_common(BlockDriverState *from,
 
     GLOBAL_STATE_CODE();
 
-    if (detach_subchain) {
-        assert(bdrv_chain_contains(from, to));
-        assert(from != to);
-        for (to_cow_parent = from;
-             bdrv_filter_or_cow_bs(to_cow_parent) != to;
-             to_cow_parent = bdrv_filter_or_cow_bs(to_cow_parent))
-        {
-            ;
-        }
-    }
-
     /* Make sure that @from doesn't go away until we have successfully attached
      * all of its parents to @to. */
     bdrv_ref(from);
@@ -5457,6 +5446,17 @@ static int bdrv_replace_node_common(BlockDriverState *from,
 
     bdrv_graph_wrlock(to);
 
+    if (detach_subchain) {
+        assert(bdrv_chain_contains(from, to));
+        assert(from != to);
+        for (to_cow_parent = from;
+             bdrv_filter_or_cow_bs(to_cow_parent) != to;
+             to_cow_parent = bdrv_filter_or_cow_bs(to_cow_parent))
+        {
+            ;
+        }
+    }
+
     /*
      * Do the replacement without permission update.
      * Replacement may influence the permissions, we should calculate new
@@ -5504,10 +5504,14 @@ int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
 
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
 {
+    BlockDriverState *child_bs;
+
     GLOBAL_STATE_CODE();
+    bdrv_graph_rdlock_main_loop();
+    child_bs = bdrv_filter_or_cow_bs(bs);
+    bdrv_graph_rdunlock_main_loop();
 
-    return bdrv_replace_node_common(bs, bdrv_filter_or_cow_bs(bs), true, true,
-                                    errp);
+    return bdrv_replace_node_common(bs, child_bs, true, true, errp);
 }
 
 /*
@@ -6509,6 +6513,7 @@ bool bdrv_chain_contains(BlockDriverState *top, BlockDriverState *base)
 {
 
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     while (top && top != base) {
         top = bdrv_filter_or_cow_bs(top);
diff --git a/block/stream.c b/block/stream.c
index 51333e460b..2781441191 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -60,6 +60,8 @@ static int stream_prepare(Job *job)
     Error *local_err = NULL;
     int ret = 0;
 
+    GLOBAL_STATE_CODE();
+
     /* We should drop filter at this point, as filter hold the backing chain */
     bdrv_cor_filter_drop(s->cor_filter_bs);
     s->cor_filter_bs = NULL;
@@ -78,8 +80,10 @@ static int stream_prepare(Job *job)
         bdrv_drained_begin(unfiltered_bs_cow);
     }
 
+    bdrv_graph_rdlock_main_loop();
     base = bdrv_filter_or_cow_bs(s->above_base);
     unfiltered_base = bdrv_skip_filters(base);
+    bdrv_graph_rdunlock_main_loop();
 
     if (bdrv_cow_child(unfiltered_bs)) {
         const char *base_id = NULL, *base_fmt = NULL;
diff --git a/blockdev.c b/blockdev.c
index 25c6c6e8d3..240834b6d4 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2492,8 +2492,8 @@ void qmp_block_stream(const char *job_id, const char *device,
     /*
      * Check for op blockers in the whole chain between bs and base (or bottom)
      */
-    iter_end = bottom ? bdrv_filter_or_cow_bs(bottom_bs) : base_bs;
     bdrv_graph_rdlock_main_loop();
+    iter_end = bottom ? bdrv_filter_or_cow_bs(bottom_bs) : base_bs;
     for (iter = bs; iter && iter != iter_end;
          iter = bdrv_filter_or_cow_bs(iter))
     {
diff --git a/nbd/server.c b/nbd/server.c
index 859c163d19..895cf0a752 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1689,6 +1689,7 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     size_t i;
     int ret;
 
+    GLOBAL_STATE_CODE();
     assert(exp_args->type == BLOCK_EXPORT_TYPE_NBD);
 
     if (!nbd_server_is_running()) {
@@ -1743,6 +1744,8 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
     }
     exp->size = QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
 
+    bdrv_graph_rdlock_main_loop();
+
     for (bitmaps = arg->bitmaps; bitmaps; bitmaps = bitmaps->next) {
         exp->nr_export_bitmaps++;
     }
@@ -1825,9 +1828,12 @@ static int nbd_export_create(BlockExport *blk_exp, BlockExportOptions *exp_args,
 
     QTAILQ_INSERT_TAIL(&exports, exp, next);
 
+    bdrv_graph_rdunlock_main_loop();
+
     return 0;
 
 fail:
+    bdrv_graph_rdunlock_main_loop();
     g_free(exp->export_bitmaps);
     g_free(exp->name);
     g_free(exp->description);
-- 
2.41.0


