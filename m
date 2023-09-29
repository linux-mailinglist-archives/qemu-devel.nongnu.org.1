Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E57B362F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmErX-00060e-Hz; Fri, 29 Sep 2023 10:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmErV-0005zk-QK
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEr4-0004nS-6V
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh7JMiR0wYJHqcxvzKIO19JQMbsgLc8dXRrla6pC/18=;
 b=Y4XLNeC/s2gByuDi5O3CPh4ki6xMnzkTsXYb6SfGHM3Hf9FDl4UXd+Q/WeBnIMUk1UfVTm
 FQxpDswh0n3H5ZQbTGusg/C3NlMInmoEIhdhEQgi6/VenMQUOpFP3rw7xwHlI/IwopXnQi
 hMrXTVAKsGoKwlrshTxSp/g/nIGVy+g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-QEEGq3RUMZa2FP5pu_vgQQ-1; Fri, 29 Sep 2023 10:52:19 -0400
X-MC-Unique: QEEGq3RUMZa2FP5pu_vgQQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A470280A9CD;
 Fri, 29 Sep 2023 14:52:19 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 282F62026D4B;
 Fri, 29 Sep 2023 14:52:18 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 11/22] block: Mark bdrv_primary_child() and callers
 GRAPH_RDLOCK
Date: Fri, 29 Sep 2023 16:51:46 +0200
Message-ID: <20230929145157.45443-12-kwolf@redhat.com>
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
bdrv_primary_child() need to hold a reader lock for the graph
because it accesses the children list of a node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int-io.h |  5 +++--
 block.c                      | 11 ++++++++++-
 block/snapshot.c             |  3 +++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/block/block_int-io.h b/include/block/block_int-io.h
index eb0da7232e..2b6004ab93 100644
--- a/include/block/block_int-io.h
+++ b/include/block/block_int-io.h
@@ -133,7 +133,7 @@ bdrv_refresh_total_sectors(BlockDriverState *bs, int64_t hint);
 BdrvChild *bdrv_cow_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_child(BlockDriverState *bs);
 BdrvChild *bdrv_filter_or_cow_child(BlockDriverState *bs);
-BdrvChild *bdrv_primary_child(BlockDriverState *bs);
+BdrvChild * GRAPH_RDLOCK bdrv_primary_child(BlockDriverState *bs);
 BlockDriverState *bdrv_skip_filters(BlockDriverState *bs);
 BlockDriverState *bdrv_backing_chain_next(BlockDriverState *bs);
 
@@ -155,7 +155,8 @@ static inline BlockDriverState *bdrv_filter_or_cow_bs(BlockDriverState *bs)
     return child_bs(bdrv_filter_or_cow_child(bs));
 }
 
-static inline BlockDriverState *bdrv_primary_bs(BlockDriverState *bs)
+static inline BlockDriverState * GRAPH_RDLOCK
+bdrv_primary_bs(BlockDriverState *bs)
 {
     IO_CODE();
     return child_bs(bdrv_primary_child(bs));
diff --git a/block.c b/block.c
index 7e6ba91885..133efa47e2 100644
--- a/block.c
+++ b/block.c
@@ -6691,7 +6691,8 @@ void coroutine_fn bdrv_co_debug_event(BlockDriverState *bs, BlkdebugEvent event)
     bs->drv->bdrv_co_debug_event(bs, event);
 }
 
-static BlockDriverState *bdrv_find_debug_node(BlockDriverState *bs)
+static BlockDriverState * GRAPH_RDLOCK
+bdrv_find_debug_node(BlockDriverState *bs)
 {
     GLOBAL_STATE_CODE();
     while (bs && bs->drv && !bs->drv->bdrv_debug_breakpoint) {
@@ -6710,6 +6711,8 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
                           const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_debug_node(bs);
     if (bs) {
         return bs->drv->bdrv_debug_breakpoint(bs, event, tag);
@@ -6721,6 +6724,8 @@ int bdrv_debug_breakpoint(BlockDriverState *bs, const char *event,
 int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     bs = bdrv_find_debug_node(bs);
     if (bs) {
         return bs->drv->bdrv_debug_remove_breakpoint(bs, tag);
@@ -6732,6 +6737,8 @@ int bdrv_debug_remove_breakpoint(BlockDriverState *bs, const char *tag)
 int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     while (bs && (!bs->drv || !bs->drv->bdrv_debug_resume)) {
         bs = bdrv_primary_bs(bs);
     }
@@ -6746,6 +6753,8 @@ int bdrv_debug_resume(BlockDriverState *bs, const char *tag)
 bool bdrv_debug_is_suspended(BlockDriverState *bs, const char *tag)
 {
     GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
     while (bs && bs->drv && !bs->drv->bdrv_debug_is_suspended) {
         bs = bdrv_primary_bs(bs);
     }
diff --git a/block/snapshot.c b/block/snapshot.c
index 554065578b..ad2bf6e068 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -311,7 +311,10 @@ int bdrv_snapshot_goto(BlockDriverState *bs,
          * respective option (with the qdict_put_str() call above).
          * Assert that .bdrv_open() has attached the right BDS as primary child.
          */
+        bdrv_graph_rdlock_main_loop();
         assert(bdrv_primary_bs(bs) == fallback_bs);
+        bdrv_graph_rdunlock_main_loop();
+
         bdrv_unref(fallback_bs);
         return ret;
     }
-- 
2.41.0


